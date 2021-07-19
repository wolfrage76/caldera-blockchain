import React, { useMemo } from 'react';
import { Trans } from '@lingui/macro';
import { useSelector } from 'react-redux';
import type { RootState } from '../../../modules/rootReducer';
import FarmCard from './FarmCard';
import { mojo_to_ssdcoin } from '../../../util/ssdcoin';
import useCurrencyCode from '../../../hooks/useCurrencyCode';

export default function FarmCardTotalSSDCoinFarmed() {
  const currencyCode = useCurrencyCode();

  const loading = useSelector(
    (state: RootState) => !state.wallet_state.farmed_amount,
  );

  const farmedAmount = useSelector(
    (state: RootState) => state.wallet_state.farmed_amount?.farmed_amount,
  );

  const totalSSDCoinFarmed = useMemo(() => {
    if (farmedAmount !== undefined) {
      const val = BigInt(farmedAmount.toString());
      return mojo_to_ssdcoin(val);
    }
  }, [farmedAmount]);

  return (
    <FarmCard
      title={<Trans>{currencyCode} Total SSDCoin Farmed</Trans>}
      value={totalSSDCoinFarmed}
      loading={loading}
    />
  );
} 
