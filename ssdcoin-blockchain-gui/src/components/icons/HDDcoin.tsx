import React from 'react';
import { SvgIcon, SvgIconProps } from '@material-ui/core';
import { ReactComponent as SSDCoinIcon } from './images/ssdcoin.svg';

export default function Keys(props: SvgIconProps) {
  return <SvgIcon component={SSDCoinIcon} viewBox="0 0 150 58" {...props} />;
} 