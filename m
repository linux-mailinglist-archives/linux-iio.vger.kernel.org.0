Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97CC65A5460
	for <lists+linux-iio@lfdr.de>; Mon, 29 Aug 2022 21:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiH2TPt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 29 Aug 2022 15:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiH2TPs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 29 Aug 2022 15:15:48 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D01229C9B;
        Mon, 29 Aug 2022 12:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661800546; x=1693336546;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=sXsgyIvYKgoTog/eFw/57RxP3GihL0VylkQHwzGwnFQ=;
  b=H7NfKPkEphlLcFii68CNquCnrHX9TuAeZWB7s380ualNQUi64TE6p9+w
   Wy+Fliv+DtuVSpn8ooy1E4Ot0aoz4AQKf1W8PjYaH1WH9lkqxZbCIZMxk
   ZtzcmoFc5BtidnjfJ7u0PJcOcS5p4i9+ABVJOb0tkW41+8o8ACT9TqoUP
   7pyRuA1eMA1MLm9WLUOSezJcPOYqF1aKpmYeemfUXybmGXMT0l+fsyNoI
   6Tr3aOB9/7cBAkIyrCXNKb//1wnDuD+3tG7Gz7iIobilSkobck8GWrDzd
   ckI7tYuUcEaBdayt1tzOBeHCo3bmWAdCZ4I5Qrni05TLYBD4niN6xoK2q
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="281950289"
X-IronPort-AV: E=Sophos;i="5.93,273,1654585200"; 
   d="scan'208";a="281950289"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 12:15:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,273,1654585200"; 
   d="scan'208";a="679739003"
Received: from lkp-server02.sh.intel.com (HELO e45bc14ccf4d) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 29 Aug 2022 12:15:43 -0700
Received: from kbuild by e45bc14ccf4d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oSkEZ-0000B7-0V;
        Mon, 29 Aug 2022 19:15:43 +0000
Date:   Tue, 30 Aug 2022 03:15:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-mm@kvack.org, linux-iio@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: [linux-next:master] BUILD REGRESSION
 b27a3ca08ba7abcf1a8af4dc3dce3e5221d91212
Message-ID: <630d105e.ndcPUQJswrnHbuox%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: b27a3ca08ba7abcf1a8af4dc3dce3e5221d91212  Add linux-next specific files for 20220829

Error/Warning reports:

https://lore.kernel.org/linux-mm/202208190147.RwbMifl8-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

drivers/base/regmap/regmap-mmio.c:221:17: error: implicit declaration of function 'writesb'; did you mean 'writeb'? [-Werror=implicit-function-declaration]
drivers/base/regmap/regmap-mmio.c:224:17: error: implicit declaration of function 'writesw'; did you mean 'writew'? [-Werror=implicit-function-declaration]
drivers/base/regmap/regmap-mmio.c:227:17: error: implicit declaration of function 'writesl'; did you mean 'writel'? [-Werror=implicit-function-declaration]
drivers/base/regmap/regmap-mmio.c:231:17: error: implicit declaration of function 'writesq'; did you mean 'writeq'? [-Werror=implicit-function-declaration]
drivers/base/regmap/regmap-mmio.c:231:17: error: implicit declaration of function 'writesq'; did you mean 'writesl'? [-Werror=implicit-function-declaration]
drivers/base/regmap/regmap-mmio.c:358:17: error: implicit declaration of function 'readsb'; did you mean 'readb'? [-Werror=implicit-function-declaration]
drivers/base/regmap/regmap-mmio.c:361:17: error: implicit declaration of function 'readsw'; did you mean 'readw'? [-Werror=implicit-function-declaration]
drivers/base/regmap/regmap-mmio.c:364:17: error: implicit declaration of function 'readsl'; did you mean 'readl'? [-Werror=implicit-function-declaration]
drivers/base/regmap/regmap-mmio.c:368:17: error: implicit declaration of function 'readsq'; did you mean 'readq'? [-Werror=implicit-function-declaration]
drivers/base/regmap/regmap-mmio.c:368:17: error: implicit declaration of function 'readsq'; did you mean 'readsl'? [-Werror=implicit-function-declaration]
drivers/iio/cdc/ad7746.c:336:14: warning: use of uninitialized value '<unknown>' [CWE-457] [-Wanalyzer-use-of-uninitialized-value]
drivers/opp/core.c:2454:22: warning: use of uninitialized value '<unknown>' [CWE-457] [-Wanalyzer-use-of-uninitialized-value]
drivers/platform/mellanox/mlxreg-lc.c:866 mlxreg_lc_probe() warn: passing zero to 'PTR_ERR'

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allyesconfig
|   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-readsb
|   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-readsl
|   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-readsq
|   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-readsw
|   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-writesb
|   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-writesl
|   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-writesq
|   `-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-writesw
|-- alpha-buildonly-randconfig-r003-20220828
|   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-readsb
|   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-readsl
|   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-readsq
|   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-readsw
|   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-writesb
|   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-writesl
|   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-writesq
|   `-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-writesw
|-- alpha-randconfig-r012-20220829
|   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-readsb
|   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-readsl
|   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-readsq
|   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-readsw
|   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-writesb
|   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-writesl
|   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-writesq
|   `-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-writesw
|-- alpha-randconfig-r032-20220828
|   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-readsb
|   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-readsl
|   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-readsq
|   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-readsw
|   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-writesb
|   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-writesl
|   |-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-writesq
|   `-- drivers-base-regmap-regmap-mmio.c:error:implicit-declaration-of-function-writesw
|-- arm-randconfig-c002-20220829
|   |-- drivers-iio-cdc-ad7746.c:warning:use-of-uninitialized-value-unknown-CWE
|   `-- drivers-opp-core.c:warning:use-of-uninitialized-value-unknown-CWE
|-- csky-randconfig-s043-20220829
|   `-- mm-vmscan.c:sparse:sparse:incorrect-type-in-argument-(different-address-spaces)-expected-struct-lockdep_map-const-lock-got-struct-lockdep_map-noderef-__rcu
|-- i386-randconfig-s001-20220829
|   `-- include-trace-events-kmem.h:sparse:sparse:restricted-gfp_t-degrades-to-integer
|-- i386-randconfig-s002-20220829
|   `-- include-trace-events-kmem.h:sparse:sparse:restricted-gfp_t-degrades-to-integer
|-- i386-randconfig-s003-20220829
|   `-- include-trace-events-kmem.h:sparse:sparse:restricted-gfp_t-degrades-to-integer
|-- loongarch-randconfig-s032-20220829
|   `-- include-trace-events-kmem.h:sparse:sparse:restricted-gfp_t-degrades-to-integer
|-- openrisc-randconfig-s032-20220828

elapsed time: 725m

configs tested: 124
configs skipped: 4

gcc tested configs:
um                           x86_64_defconfig
loongarch                         allnoconfig
um                             i386_defconfig
csky                                defconfig
sparc                               defconfig
x86_64                              defconfig
x86_64                                  kexec
loongarch                           defconfig
arm                                 defconfig
i386                        debian-10.3-kunit
i386                         debian-10.3-func
arc                                 defconfig
i386                 randconfig-a001-20220829
riscv                             allnoconfig
i386                          debian-10.3-kvm
parisc                           allyesconfig
x86_64                               rhel-8.3
parisc64                            defconfig
i386                 randconfig-a002-20220829
arm                           stm32_defconfig
parisc                              defconfig
i386                 randconfig-a005-20220829
openrisc                 simple_smp_defconfig
s390                             allmodconfig
csky                              allnoconfig
riscv                    nommu_virt_defconfig
arc                               allnoconfig
alpha                               defconfig
nios2                               defconfig
i386                 randconfig-a006-20220829
x86_64                          rhel-8.3-func
riscv                randconfig-r042-20220828
alpha                             allnoconfig
mips                             allyesconfig
arc                          axs103_defconfig
mips                         cobalt_defconfig
nios2                            allyesconfig
riscv                          rv32_defconfig
s390                       zfcpdump_defconfig
s390                             allyesconfig
x86_64               randconfig-a003-20220829
x86_64                         rhel-8.3-kunit
s390                                defconfig
sparc                            allyesconfig
x86_64                           rhel-8.3-kvm
x86_64               randconfig-a004-20220829
x86_64                           allyesconfig
i386                   debian-10.3-kselftests
riscv             nommu_k210_sdcard_defconfig
sh                                  defconfig
arm                              allyesconfig
x86_64               randconfig-a005-20220829
i386                              debian-10.3
x86_64               randconfig-a002-20220829
arm                              allmodconfig
arc                  randconfig-r043-20220829
i386                                defconfig
riscv                    nommu_k210_defconfig
arc                  randconfig-r043-20220828
powerpc                           allnoconfig
powerpc                        cell_defconfig
i386                 randconfig-a003-20220829
x86_64               randconfig-a006-20220829
powerpc                      mgcoge_defconfig
xtensa                           allyesconfig
arm64                            allyesconfig
x86_64               randconfig-a001-20220829
um                                  defconfig
powerpc                          allmodconfig
x86_64                    rhel-8.3-kselftests
sh                               allmodconfig
i386                 randconfig-a004-20220829
arm64                               defconfig
x86_64                           rhel-8.3-syz
riscv                            allmodconfig
m68k                             allyesconfig
m68k                                defconfig
arc                              allyesconfig
powerpc                          allyesconfig
s390                 randconfig-r044-20220828
ia64                                defconfig
riscv                            allyesconfig
ia64                             allmodconfig
i386                          randconfig-c001
alpha                            allyesconfig
arm                          gemini_defconfig
xtensa                          iss_defconfig
powerpc                       holly_defconfig
arm                        multi_v7_defconfig
m68k                            mac_defconfig
um                               alldefconfig
powerpc                         ps3_defconfig
x86_64               randconfig-c001-20220829
m68k                             allmodconfig
i386                             allyesconfig
arm                  randconfig-c002-20220829

clang tested configs:
x86_64               randconfig-a011-20220829
x86_64               randconfig-a014-20220829
x86_64               randconfig-a016-20220829
arm                         bcm2835_defconfig
i386                 randconfig-a011-20220829
mips                        bcm63xx_defconfig
powerpc                     akebono_defconfig
mips                           ip28_defconfig
powerpc                     tqm8560_defconfig
powerpc                      walnut_defconfig
x86_64               randconfig-a015-20220829
arm                         mv78xx0_defconfig
x86_64               randconfig-a012-20220829
x86_64               randconfig-a013-20220829
i386                 randconfig-a014-20220829
hexagon              randconfig-r041-20220829
i386                 randconfig-a013-20220829
mips                       rbtx49xx_defconfig
i386                 randconfig-a012-20220829
i386                 randconfig-a016-20220829
riscv                randconfig-r042-20220829
i386                 randconfig-a015-20220829
hexagon              randconfig-r041-20220828
s390                 randconfig-r044-20220829
arm                          moxart_defconfig
mips                     cu1000-neo_defconfig
x86_64                          rhel-8.3-rust
x86_64               randconfig-k001-20220829

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
