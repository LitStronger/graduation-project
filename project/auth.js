let T =
  "  0.0461 -0.0496  0.0339 -0.0300  0.0115 -0.0201  0.0038  0.0118 -0.0057 -0.0031  0.0050  0.0084  0.0059  0.0195 -0.0068 -0.0212  0.0237  0.0054  0.0094 -0.0133  0.0072  0.0011 -0.0000  0.1333  0.1211  0.1771  0.2051  0.1994  0.1794  0.1790  0.1608  0.1899  0.1789  0.1947  0.1616  0.1321  0.1807  0.2271  0.0781  0.1030  0.1013  0.1337  0.0995  0.1147  0.0920  0.0000";
let TDiTong =
  "  0.0459 -0.0496  0.0336 -0.0298  0.0116 -0.0204  0.0039  0.0121 -0.0052 -0.0030  0.0055  0.0085  0.0055  0.0193 -0.0067 -0.0216  0.0237  0.0057  0.0090 -0.0132  0.0073  0.0006 -0.0000  0.1338  0.1218  0.1789  0.2049  0.1994  0.1858  0.2121  0.1684  0.2078  0.2861  0.2177  0.1622  0.1322  0.1807  0.2270  0.0783  0.1034  0.1022  0.1339  0.0999  0.1158  0.0946  0.0000";
let TCut =
  "  0.0459 -0.0496  0.0336 -0.0298  0.0116 -0.0204  0.0187  0.0116  0.0020  0.0072  0.0100 -0.0049 -0.0055  0.0135 -0.0281  0.0239  0.0100  0.0031 -0.0010 -0.0113  0.0125  0.0000  0.1338  0.1218  0.1789  0.2049  0.1994  0.1858  0.1917  0.2189  0.2910  0.2109  0.1637  0.1176  0.2068  0.2037  0.0763  0.1047  0.1016  0.1347  0.1013  0.1246  0.0783  0.0000";
let TRevert =
  "  0.0459 -0.0496  0.0336 -0.0298  0.0116 -0.0143  0.0034  0.0068 -0.0052 -0.0030  0.0055  0.0086  0.0056  0.0193 -0.0067 -0.0216  0.0237  0.0057  0.0090 -0.0132  0.0073  0.0006 -0.0000  0.1338  0.1218  0.1789  0.2049  0.1994  0.1720  0.1844  0.2082  0.2079  0.2866  0.2176  0.1621  0.1322  0.1807  0.2270  0.0783  0.1034  0.1022  0.1339  0.0999  0.1158  0.0946  0.0000";
let TArr = TSplit(T);
let TDiTongArr = TSplit(TDiTong);
// let TCutArr = TSplit(TCut);
let TRevertArr = TSplit(TRevert);
console.log(verify(TArr, TDiTongArr));
// console.log(verify(TArr, TCutArr));
// console.log(verify(TArr, TRevertArr));

function verify(TArr, T1Arr) {
  let errCount = 0;
  if (TArr.length !== T1Arr.length) {
    return -1;
  }
  let i = 0;
  while (i < TArr.length) {
    // console.log(TArr[i] - T1Arr[i]);
    if (Math.abs(TArr[i] - T1Arr[i]) > 0.005) {
      console.log(TArr[i], T1Arr[i], i);
      errCount++;
    }
    i++;
  }
  return errCount;
}

function TSplit(T) {
  let TArr = [];
  let i = 0;
  while (i < T.length / 8) {
    TArr.push(parseFloat(T.slice(i * 8, (i + 1) * 8)));
    i++;
  }
  console.log(TArr);
  return TArr;
}
