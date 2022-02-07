Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D413F4AB831
	for <lists+linux-iio@lfdr.de>; Mon,  7 Feb 2022 11:01:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245453AbiBGJyI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Feb 2022 04:54:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354230AbiBGJwZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 7 Feb 2022 04:52:25 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EDA5C043188
        for <linux-iio@vger.kernel.org>; Mon,  7 Feb 2022 01:52:24 -0800 (PST)
Received: from fraeml745-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Jsglf2HQbz67P7x;
        Mon,  7 Feb 2022 17:27:26 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml745-chm.china.huawei.com (10.206.15.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 7 Feb 2022 10:32:22 +0100
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Mon, 7 Feb
 2022 09:32:21 +0000
Date:   Mon, 7 Feb 2022 09:32:20 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     kernel test robot <lkp@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        <linux-iio@vger.kernel.org>
Subject: Re: [jic23-iio:fixes-togreg] BUILD SUCCESS
 21472ddd425831f6cf39b3034e825df2825ec850
Message-ID: <20220207093220.0000138a@Huawei.com>
In-Reply-To: <62009f70.k3Jjl7f7YJXTiTPB%lkp@intel.com>
References: <62009f70.k3Jjl7f7YJXTiTPB%lkp@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml733-chm.china.huawei.com (10.201.108.84) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 07 Feb 2022 12:26:24 +0800
kernel test robot <lkp@intel.com> wrote:

> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git fixes-togreg
> branch HEAD: 21472ddd425831f6cf39b3034e825df2825ec850  iio: imu: st_lsm6dsx: wait for settling time in st_lsm6dsx_read_oneshot
> 
> possible Warning in current branch (please contact us if interested):
> 
> drivers/iio/accel/mma8452.c:1595 mma8452_probe() error: we previously assumed 'id' could be null (see line 1536)

We have name set from id->name after this patch which assumes id can be NULL.
iio: mma8452: Fix probe failing when an i2c_device_id is used
https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/tree/drivers/iio/accel/mma8452.c?h=fixes-togreg&id=4787cdbfbcb9590e6d9fb4809e0b667a3f491747#n1595

Hans, could you send me an updated fix dealing with that as well and I'll replace
this one.  If not I'll get to it when I'm next on the right computer.

Thanks,

Jonathan

> 
> Warning ids grouped by kconfigs:
> 
> gcc_recent_errors
> |-- microblaze-randconfig-m031-20220207
> |   `-- drivers-iio-accel-mma8452.c-mma8452_probe()-error:we-previously-assumed-id-could-be-null-(see-line-)
> |-- x86_64-randconfig-m001
> |   `-- drivers-iio-accel-mma8452.c-mma8452_probe()-error:we-previously-assumed-id-could-be-null-(see-line-)
> `-- x86_64-randconfig-m001-20220207
>     `-- drivers-iio-accel-mma8452.c-mma8452_probe()-error:we-previously-assumed-id-could-be-null-(see-line-)
> 
> elapsed time: 723m
> 
> configs tested: 183
> configs skipped: 3
> 
> The following configs have been built successfully.
> More configs may be tested in the coming days.
> 
> gcc tested configs:
> arm                                 defconfig
> arm64                            allyesconfig
> arm64                               defconfig
> arm                              allyesconfig
> arm                              allmodconfig
> i386                          randconfig-c001
> i386                 randconfig-c001-20220207
> arm                     eseries_pxa_defconfig
> arm                        mvebu_v7_defconfig
> powerpc                   motionpro_defconfig
> powerpc                     ep8248e_defconfig
> microblaze                      mmu_defconfig
> mips                         rt305x_defconfig
> arc                     haps_hs_smp_defconfig
> arm                        trizeps4_defconfig
> sh                     magicpanelr2_defconfig
> xtensa                           allyesconfig
> sh                          landisk_defconfig
> sh                          sdk7780_defconfig
> arc                        vdk_hs38_defconfig
> mips                           xway_defconfig
> sparc                       sparc32_defconfig
> m68k                          hp300_defconfig
> sh                          rsk7269_defconfig
> arm                        shmobile_defconfig
> arc                            hsdk_defconfig
> arc                              alldefconfig
> powerpc                      pcm030_defconfig
> mips                       capcella_defconfig
> mips                           ip32_defconfig
> powerpc                 canyonlands_defconfig
> sh                          rsk7201_defconfig
> sh                           se7780_defconfig
> arc                         haps_hs_defconfig
> sh                   secureedge5410_defconfig
> ia64                         bigsur_defconfig
> sh                   rts7751r2dplus_defconfig
> sh                           se7722_defconfig
> sh                        edosk7760_defconfig
> powerpc                   currituck_defconfig
> powerpc                 mpc834x_mds_defconfig
> xtensa                  cadence_csp_defconfig
> m68k                       m5208evb_defconfig
> arm                         lubbock_defconfig
> powerpc                     sequoia_defconfig
> m68k                          amiga_defconfig
> powerpc                      cm5200_defconfig
> nds32                             allnoconfig
> sh                               j2_defconfig
> sh                          r7785rp_defconfig
> x86_64                              defconfig
> arm                      jornada720_defconfig
> powerpc64                           defconfig
> openrisc                  or1klitex_defconfig
> m68k                        m5407c3_defconfig
> arm                        multi_v7_defconfig
> h8300                       h8s-sim_defconfig
> riscv                    nommu_k210_defconfig
> mips                     loongson1b_defconfig
> arm                             ezx_defconfig
> sh                           se7721_defconfig
> mips                     decstation_defconfig
> powerpc                         wii_defconfig
> sh                     sh7710voipgw_defconfig
> m68k                             alldefconfig
> m68k                        mvme16x_defconfig
> sh                             shx3_defconfig
> sh                          lboxre2_defconfig
> m68k                         apollo_defconfig
> sh                             espt_defconfig
> arc                           tb10x_defconfig
> mips                      loongson3_defconfig
> arm                  randconfig-c002-20220206
> arm                  randconfig-c002-20220207
> ia64                             allmodconfig
> ia64                                defconfig
> ia64                             allyesconfig
> m68k                             allmodconfig
> m68k                                defconfig
> m68k                             allyesconfig
> nios2                               defconfig
> arc                              allyesconfig
> csky                                defconfig
> alpha                               defconfig
> nds32                               defconfig
> alpha                            allyesconfig
> nios2                            allyesconfig
> h8300                            allyesconfig
> arc                                 defconfig
> sh                               allmodconfig
> parisc                              defconfig
> s390                             allyesconfig
> s390                             allmodconfig
> parisc                           allyesconfig
> s390                                defconfig
> i386                             allyesconfig
> sparc                            allyesconfig
> sparc                               defconfig
> i386                                defconfig
> i386                   debian-10.3-kselftests
> i386                              debian-10.3
> mips                             allyesconfig
> mips                             allmodconfig
> powerpc                          allyesconfig
> powerpc                          allmodconfig
> powerpc                           allnoconfig
> x86_64                        randconfig-a006
> x86_64                        randconfig-a004
> x86_64                        randconfig-a002
> x86_64               randconfig-a013-20220207
> x86_64               randconfig-a016-20220207
> x86_64               randconfig-a015-20220207
> x86_64               randconfig-a012-20220207
> x86_64               randconfig-a014-20220207
> x86_64               randconfig-a011-20220207
> i386                          randconfig-a012
> i386                          randconfig-a014
> i386                          randconfig-a016
> i386                 randconfig-a012-20220207
> i386                 randconfig-a013-20220207
> i386                 randconfig-a015-20220207
> i386                 randconfig-a014-20220207
> i386                 randconfig-a011-20220207
> i386                 randconfig-a016-20220207
> riscv                            allyesconfig
> riscv                    nommu_virt_defconfig
> riscv                             allnoconfig
> riscv                               defconfig
> riscv                          rv32_defconfig
> riscv                            allmodconfig
> um                           x86_64_defconfig
> um                             i386_defconfig
> x86_64                           allyesconfig
> x86_64                    rhel-8.3-kselftests
> x86_64                               rhel-8.3
> x86_64                          rhel-8.3-func
> x86_64                                  kexec
> 
> clang tested configs:
> riscv                randconfig-c006-20220207
> i386                 randconfig-c001-20220207
> powerpc              randconfig-c003-20220207
> x86_64               randconfig-c007-20220207
> mips                 randconfig-c004-20220207
> arm                  randconfig-c002-20220207
> x86_64                        randconfig-c007
> powerpc              randconfig-c003-20220206
> mips                 randconfig-c004-20220206
> i386                          randconfig-c001
> arm                  randconfig-c002-20220206
> s390                 randconfig-c005-20220206
> riscv                randconfig-c006-20220206
> arm                          pcm027_defconfig
> mips                      maltaaprp_defconfig
> powerpc                  mpc866_ads_defconfig
> arm                          ep93xx_defconfig
> arm                         shannon_defconfig
> arm                        magician_defconfig
> arm                         socfpga_defconfig
> powerpc                     skiroot_defconfig
> powerpc                     mpc5200_defconfig
> arm                            mmp2_defconfig
> arm                              alldefconfig
> powerpc                          allyesconfig
> powerpc                    mvme5100_defconfig
> powerpc                      ppc64e_defconfig
> arm                  colibri_pxa270_defconfig
> arm                   milbeaut_m10v_defconfig
> arm                    vt8500_v6_v7_defconfig
> powerpc                   bluestone_defconfig
> x86_64               randconfig-a006-20220207
> x86_64               randconfig-a004-20220207
> x86_64               randconfig-a005-20220207
> x86_64               randconfig-a003-20220207
> x86_64               randconfig-a002-20220207
> x86_64               randconfig-a001-20220207
> i386                          randconfig-a002
> i386                          randconfig-a006
> i386                          randconfig-a004
> i386                 randconfig-a004-20220207
> i386                 randconfig-a003-20220207
> i386                 randconfig-a001-20220207
> i386                 randconfig-a002-20220207
> i386                 randconfig-a005-20220207
> i386                 randconfig-a006-20220207
> hexagon              randconfig-r045-20220206
> riscv                randconfig-r042-20220206
> hexagon              randconfig-r041-20220206
> hexagon              randconfig-r045-20220207
> hexagon              randconfig-r041-20220207
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

