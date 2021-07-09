./venv/bin/py.test tests/core/full_node/test_conditions.py tests/core/full_node/test_initial_freeze.py tests/core/full_node/test_mempool.py -s -v --durations 0 
    FAILED tests/core/full_node/test_conditions.py::TestConditions::test_valid_block_age - assert <Err.BAD_REMOVAL_ROOT: 25> is None
    FAILED tests/core/full_node/test_conditions.py::TestConditions::test_valid_block_height - assert <Err.BAD_REMOVAL_ROOT: 25> is None
    FAILED tests/core/full_node/test_conditions.py::TestConditions::test_invalid_my_id - assert <Err.BAD_REMOVAL_ROOT: 25> == <Err.ASSERT_M...ID_FAILED: 11>
    FAILED tests/core/full_node/test_conditions.py::TestConditions::test_valid_my_id - assert <Err.BAD_REMOVAL_ROOT: 25> is None
    FAILED tests/core/full_node/test_conditions.py::TestConditions::test_invalid_seconds_absolute - assert <Err.BAD_REMOVAL_ROOT: 25> == <Err.ASSERT_S...TE_FAILED: 15>
    FAILED tests/core/full_node/test_conditions.py::TestConditions::test_invalid_coin_announcement - assert <Err.BAD_REMOVAL_ROOT: 25> == <Err.ASSERT_A...ED_FAILED: 12>
    FAILED tests/core/full_node/test_conditions.py::TestConditions::test_valid_coin_announcement - assert <Err.BAD_REMOVAL_ROOT: 25> is None
    FAILED tests/core/full_node/test_conditions.py::TestConditions::test_invalid_puzzle_announcement - assert <Err.BAD_REMOVAL_ROOT: 25> == <Err.ASSERT_A...ED_FAILED: 12>
    FAILED tests/core/full_node/test_conditions.py::TestConditions::test_valid_puzzle_announcement - assert <Err.BAD_REMOVAL_ROOT: 25> is None
    FAILED tests/core/full_node/test_initial_freeze.py::TestTransactions::test_invalid_block - assert None is not None
    FAILED tests/core/full_node/test_mempool.py::TestMempoolManager::test_invalid_block_index - IndexError: list index out of range
    FAILED tests/core/full_node/test_mempool.py::TestMempoolManager::test_invalid_block_age - IndexError: list index out of range

./venv/bin/py.test tests/pools/test_pool_puzzles_lifecycle.py tests/pools/test_pool_rpc.py tests/pools/test_pool_wallet.py tests/pools/test_wallet_pool_store.py -s -v --durations 0 
    FAILED tests/pools/test_pool_puzzles_lifecycle.py::TestPoolPuzzles::test_pool_lifecycle - tests.clvm.coin_store.BadSpendBundleError: coin not found for id 0x2807c8d136f9f555d96a8a278ab63e3c909cc3a1933b62bab...
    FAILED tests/pools/test_pool_rpc.py::TestPoolWalletRpc::test_create_new_pool_wallet_self_farm - AssertionError: assert '0xf1326e6f396556ec3a29212ac7946d40a6542d8ec4ce7ef87587f28d891dcab8' in {'0x09edf686c31...
    FAILED tests/pools/test_pool_rpc.py::TestPoolWalletRpc::test_create_new_pool_wallet_farm_to_pool - AssertionError: assert '0xf1326e6f396556ec3a29212ac7946d40a6542d8ec4ce7ef87587f28d891dcab8' in {'0x09edf686...