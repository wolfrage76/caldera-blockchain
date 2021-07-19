const ssdcoin = require('../../util/ssdcoin');

describe('ssdcoin', () => {
  it('converts number mojo to ssdcoin', () => {
    const result = ssdcoin.mojo_to_ssdcoin(1000000);

    expect(result).toBe(0.000001);
  });
  it('converts string mojo to ssdcoin', () => {
    const result = ssdcoin.mojo_to_ssdcoin('1000000');

    expect(result).toBe(0.000001);
  });
  it('converts number mojo to ssdcoin string', () => {
    const result = ssdcoin.mojo_to_ssdcoin_string(1000000);

    expect(result).toBe('0.000001');
  });
  it('converts string mojo to ssdcoin string', () => {
    const result = ssdcoin.mojo_to_ssdcoin_string('1000000');

    expect(result).toBe('0.000001');
  });
  it('converts number ssdcoin to mojo', () => {
    const result = ssdcoin.ssdcoin_to_mojo(0.000001);

    expect(result).toBe(1000000);
  });
  it('converts string ssdcoin to mojo', () => {
    const result = ssdcoin.ssdcoin_to_mojo('0.000001');

    expect(result).toBe(1000000);
  });
  it('converts number mojo to colouredcoin', () => {
    const result = ssdcoin.mojo_to_colouredcoin(1000000);

    expect(result).toBe(1000);
  });
  it('converts string mojo to colouredcoin', () => {
    const result = ssdcoin.mojo_to_colouredcoin('1000000');

    expect(result).toBe(1000);
  });
  it('converts number mojo to colouredcoin string', () => {
    const result = ssdcoin.mojo_to_colouredcoin_string(1000000);

    expect(result).toBe('1,000');
  });
  it('converts string mojo to colouredcoin string', () => {
    const result = ssdcoin.mojo_to_colouredcoin_string('1000000');

    expect(result).toBe('1,000');
  });
  it('converts number colouredcoin to mojo', () => {
    const result = ssdcoin.colouredcoin_to_mojo(1000);

    expect(result).toBe(1000000);
  });
  it('converts string colouredcoin to mojo', () => {
    const result = ssdcoin.colouredcoin_to_mojo('1000');

    expect(result).toBe(1000000);
  });
});
