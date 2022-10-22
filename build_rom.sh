# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/Fork-Krypton/manifest.git -b A12 -g default,-mips,-darwin,-notdefault
git clone https://github.com/zaidannn7/local_manifest --depth 1 -b main .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8

# build rom
source build/envsetup.sh
export ALLOW_MISSING_DEPENDENCIES=true
export BUILD_BROKEN_USES_BUILD_COPY_HEADERS=true
export BUILD_BROKEN_DUP_RULES=true
export
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES=true
export BUILD_BROKEN_VENDOR_PROPERTY_NAMESPACE=true
export BUILD_BROKEN_VERIFY_USES_LIBRARIES =true
export RELAX_USES_LIBRARY_CHECK=true
export SELINUX_IGNORE_NEVERALLOWS=true
export BUILD_USERNAME=zaidan
export BUILD_HOSTNAME=ytta-labs
export TZ=Asia/Jakarta
launch juice userdebug

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P

