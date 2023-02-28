Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2BA6A5523
	for <lists+linux-iio@lfdr.de>; Tue, 28 Feb 2023 10:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjB1JGx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Feb 2023 04:06:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjB1JGx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Feb 2023 04:06:53 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725DD168B2
        for <linux-iio@vger.kernel.org>; Tue, 28 Feb 2023 01:06:51 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1pWvwV-0003ZI-C3; Tue, 28 Feb 2023 10:06:39 +0100
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1pWvwT-00073Y-Ib; Tue, 28 Feb 2023 10:06:37 +0100
Date:   Tue, 28 Feb 2023 10:06:37 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     kernel test robot <lkp@intel.com>
Cc:     puranjay12@gmail.com, jic23@kernel.org, lars@metafoo.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        oe-kbuild-all@lists.linux.dev, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v5 4/5] iio: temperature: tmp117: add TI TMP116 support
Message-ID: <20230228090637.es46f2tjvmikmdlw@pengutronix.de>
References: <20230227211230.165073-5-m.felsch@pengutronix.de>
 <202302280821.OXqGp2Tq-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202302280821.OXqGp2Tq-lkp@intel.com>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 23-02-28, kernel test robot wrote:
> Hi Marco,
> 
> Thank you for the patch! Yet something to improve:

Argh.. I didn't noticed that since I repaired it within the last
commit... I have send a v6 which fixes this.

Regards,
  Marco


> 
> [auto build test ERROR on v6.2]
> [cannot apply to jic23-iio/togreg linus/master]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Marco-Felsch/dt-bindings-iio-ti-tmp117-fix-documentation-link/20230228-051305
> patch link:    https://lore.kernel.org/r/20230227211230.165073-5-m.felsch%40pengutronix.de
> patch subject: [PATCH v5 4/5] iio: temperature: tmp117: add TI TMP116 support
> config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20230228/202302280821.OXqGp2Tq-lkp@intel.com/config)
> compiler: powerpc-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/424113d7fdc257200d20da2991242a4050c04cb3
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Marco-Felsch/dt-bindings-iio-ti-tmp117-fix-documentation-link/20230228-051305
>         git checkout 424113d7fdc257200d20da2991242a4050c04cb3
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc olddefconfig
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/iio/
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Link: https://lore.kernel.org/oe-kbuild-all/202302280821.OXqGp2Tq-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
> >> drivers/iio/temperature/tmp117.c:111:2: error: expected '}' before ';' token
>      111 | };
>          |  ^
>    drivers/iio/temperature/tmp117.c:106:55: note: to match this '{'
>      106 | static const struct iio_chan_spec tmp117_channels[] = {
>          |                                                       ^
>    drivers/iio/temperature/tmp117.c:106:35: warning: 'tmp117_channels' defined but not used [-Wunused-const-variable=]
>      106 | static const struct iio_chan_spec tmp117_channels[] = {
>          |                                   ^~~~~~~~~~~~~~~
>    drivers/iio/temperature/tmp117.c:85:12: warning: 'tmp117_write_raw' defined but not used [-Wunused-function]
>       85 | static int tmp117_write_raw(struct iio_dev *indio_dev,
>          |            ^~~~~~~~~~~~~~~~
>    drivers/iio/temperature/tmp117.c:45:12: warning: 'tmp117_read_raw' defined but not used [-Wunused-function]
>       45 | static int tmp117_read_raw(struct iio_dev *indio_dev,
>          |            ^~~~~~~~~~~~~~~
> 
> 
> vim +111 drivers/iio/temperature/tmp117.c
> 
>    105	
>    106	static const struct iio_chan_spec tmp117_channels[] = {
>    107		{
>    108			.type = IIO_TEMP,
>    109			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>    110				BIT(IIO_CHAN_INFO_CALIBBIAS) | BIT(IIO_CHAN_INFO_SCALE),
>  > 111	};
>    112	
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests
> 
