Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE3C41E852
	for <lists+linux-iio@lfdr.de>; Fri,  1 Oct 2021 09:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352484AbhJAH2f convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Fri, 1 Oct 2021 03:28:35 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:42845 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231466AbhJAH2f (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 1 Oct 2021 03:28:35 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id BB62F1C0002;
        Fri,  1 Oct 2021 07:26:49 +0000 (UTC)
Date:   Fri, 1 Oct 2021 09:26:48 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        bcousson@baylibre.com, Tony Lindgren <tony@atomide.com>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 36/48] mfd: ti_am335x_tscadc: Add ADC1/magnetic
 reader support
Message-ID: <20211001092648.37350b6a@xps13>
In-Reply-To: <202109290654.q78br8Dx-lkp@intel.com>
References: <20210928133143.157329-37-miquel.raynal@bootlin.com>
        <202109290654.q78br8Dx-lkp@intel.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello Lee,

- reduced a bit the Cc: list

lkp@intel.com wrote on Wed, 29 Sep 2021 06:32:16 +0800:

> Hi Miquel,
> 
> I love your patch! Perhaps something to improve:
> 
> [auto build test WARNING on lee-mfd/for-mfd-next]
> [also build test WARNING on jic23-iio/togreg robh/for-next v5.15-rc3 next-20210922]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Miquel-Raynal/TI-AM437X-ADC1/20210928-213524
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git for-mfd-next
> config: microblaze-randconfig-r033-20210928 (attached as .config)
> compiler: microblaze-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/0day-ci/linux/commit/43a01cf6413f2be038b0d466c7c3f6f16b40e2c3
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Miquel-Raynal/TI-AM437X-ADC1/20210928-213524
>         git checkout 43a01cf6413f2be038b0d466c7c3f6f16b40e2c3
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=microblaze 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>    drivers/mfd/ti_am335x_tscadc.c: In function 'ti_tscadc_probe':
> >> drivers/mfd/ti_am335x_tscadc.c:124:31: warning: variable 'use_mag' set but not used [-Wunused-but-set-variable]  
>      124 |         bool use_tsc = false, use_mag = false;
>          |                               ^~~~~~~

It's strange, on my side I didn't get any warnings (using an older GCC,
perhaps not with all the flags enabled either). Anyway, let's remove
the noise, I have a fixup patch which can be applied without disturbing
any of the other patches.

Lee, do you prefer that I send a fixup patch or a v5 for patch "mfd:
ti_am335x_tscadc: Add ADC1/magnetic reader support"? (provided of
course that the other patches are fine to you).

>    In file included from drivers/mfd/ti_am335x_tscadc.c:20:
>    drivers/mfd/ti_am335x_tscadc.c: At top level:
>    include/linux/mfd/ti_am335x_tscadc.h:126:38: error: 'HZ_PER_MHZ' undeclared here (not in a function)
>      126 | #define TSC_ADC_CLK             (3 * HZ_PER_MHZ)
>          |                                      ^~~~~~~~~~
>    drivers/mfd/ti_am335x_tscadc.c:354:28: note: in expansion of macro 'TSC_ADC_CLK'
>      354 |         .target_clk_rate = TSC_ADC_CLK,
>          |                            ^~~~~~~~~~~

For this one I don't believe this is a real warning, units.h is
introduced in a precedent patch, HZ_PER_MHZ is a new macro but it is
upstream now so I think it can safely be discarded.

Thanks,
Miquèl
