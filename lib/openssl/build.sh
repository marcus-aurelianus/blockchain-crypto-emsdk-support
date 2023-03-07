emconfigure ./Configure \
  linux-generic64 \
  no-asm \
  no-threads \
  no-engine \
  no-hw \
  no-weak-ssl-ciphers \
  no-dtls \
  no-shared \
  no-dso \
  --prefix=$EMSCRIPTEN/system

sed -i 's|^CROSS_COMPILE.*$|CROSS_COMPILE=|g' Makefile
sed -i '/^CFLAGS/ s/$/ -D__STDC_NO_ATOMICS__=1/' Makefile
sed -i '/^CXXFLAGS/ s/$/ -D__STDC_NO_ATOMICS__=1/' Makefile

emmake make -j 1 build_generated libssl.a libcrypto.a

ar -x libssl.a
/home/ec2-user/emsdk/upstream/emscripten/em++ -shared *.a -i libssl.so