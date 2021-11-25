% ���ɹ�Կ��˽Կ
%[Modulus, PublicExponent, PrivateExponent] = GenerateKeyPair();

hashCode = '1d01c56e3c35564436632c1b9e83eaab';
message = int32(hashCode);
verifyTarget = int32('1d01c56e3c35564436632c1b9e83eaab');

% ����ǩ��/��֤ 
Signature       = Sign(Modulus, PrivateExponent, message);
IsVerified      = Verify(Modulus, PublicExponent, verifyTarget, Signature);

fprintf('\n-Signing-\n')
%fprintf('Signature:[%s]\n',char(Signature))
fprintf('Signature:%s\n',num2str(Signature))
fprintf('Is Verified:    %d\n', IsVerified)