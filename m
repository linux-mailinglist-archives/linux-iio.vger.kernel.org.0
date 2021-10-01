Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC8541F4CF
	for <lists+linux-iio@lfdr.de>; Fri,  1 Oct 2021 20:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355727AbhJASRm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 1 Oct 2021 14:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355682AbhJASRh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 1 Oct 2021 14:17:37 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12C4C0613E6
        for <linux-iio@vger.kernel.org>; Fri,  1 Oct 2021 11:15:44 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id a18so4706640wru.4
        for <linux-iio@vger.kernel.org>; Fri, 01 Oct 2021 11:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ACQZtp1I6ehmhXOr+taNCKAcsnyXPtbzuyGGTR/Sk4o=;
        b=URP+RNHMY4mcptX+LKb8Bxb6vfONQ1248fO/YjHxHVSFXtUrR5/scGmWv4rLAbohai
         DzR22249PNVFk+c6JmT4UlUcXXQQLN2dISbFGzDwRtrjFwfrZWXwkaPNnof/zeuwZkkI
         8uMd5cNCKdnuhWAnJlyA2pahAIu63bFdEA1afcmNRzwrAtlo3CSQX51VM0cOSIYodCKN
         87zhNakO8oreHV2TLry7+2LhGKwt9JvoqkkM5t0OGo9dzXlmDYSW9CpFEJtnwHHg+pQI
         sazFgj4qat9r6ysvpZirdVOWSziIJcBzUZWjOg6TfXUckeYmJ6B3HuddmIpueBjGAX5f
         jD3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ACQZtp1I6ehmhXOr+taNCKAcsnyXPtbzuyGGTR/Sk4o=;
        b=CCPFvjpsTe4Njyu1/g0ndV04ksRsQqrWeDLg0WLkBefD8IgXIp9Ok6EBkVTiFy4RrH
         E5pSN4vPCTyOax62iLDjGKnWzpifNOSJybCX2dLtdGaI8F2NExbBVDe86mvP1AhOzItZ
         Hh3RSk81T3D8+Q9Xr2wFcudIc3bzDbBsE451gsK2rQP44HtuOty+tcWSCBIR7PWFT5rW
         oWSTZcgUz6SXNoPlw0qHkfBD3LpWe/piOUPdMpLmMYn3iTcXwp3kFtEWBD6VZJkqAG66
         LOgfLXaiZuRpJOmsBtruXNVSLWOVnEG7Kq5v0cEr9m7JdtXUOr9X4BfdDz82JIoEcKDG
         brVQ==
X-Gm-Message-State: AOAM531z/govwDUNbL8iKph29BSiJlarvza9oQqoTeHPiBVGKDHbXEzz
        srMGc5DwrX6KI9AOynMEckIGTVjKvM+AoQ==
X-Google-Smtp-Source: ABdhPJxOZOm7Wcb37Kx3aO/UuDSejX2tY3JEq6nFN5jofAVflQn4LtvjXF6tfXYensAFj95xA7gMww==
X-Received: by 2002:a05:6000:c3:: with SMTP id q3mr14192785wrx.361.1633112143285;
        Fri, 01 Oct 2021 11:15:43 -0700 (PDT)
Received: from google.com ([95.148.6.233])
        by smtp.gmail.com with ESMTPSA id k26sm8679499wms.39.2021.10.01.11.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 11:15:42 -0700 (PDT)
Date:   Fri, 1 Oct 2021 19:15:41 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        bcousson@baylibre.com, Tony Lindgren <tony@atomide.com>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 36/48] mfd: ti_am335x_tscadc: Add ADC1/magnetic reader
 support
Message-ID: <YVdQTSQiNMw6fobl@google.com>
References: <20210928133143.157329-37-miquel.raynal@bootlin.com>
 <202109290654.q78br8Dx-lkp@intel.com>
 <20211001092648.37350b6a@xps13>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211001092648.37350b6a@xps13>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 01 Oct 2021, Miquel Raynal wrote:

> Hello Lee,
> 
> - reduced a bit the Cc: list
> 
> lkp@intel.com wrote on Wed, 29 Sep 2021 06:32:16 +0800:
> 
> > Hi Miquel,
> > 
> > I love your patch! Perhaps something to improve:
> > 
> > [auto build test WARNING on lee-mfd/for-mfd-next]
> > [also build test WARNING on jic23-iio/togreg robh/for-next v5.15-rc3 next-20210922]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch]
> > 
> > url:    https://github.com/0day-ci/linux/commits/Miquel-Raynal/TI-AM437X-ADC1/20210928-213524
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git for-mfd-next
> > config: microblaze-randconfig-r033-20210928 (attached as .config)
> > compiler: microblaze-linux-gcc (GCC) 11.2.0
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://github.com/0day-ci/linux/commit/43a01cf6413f2be038b0d466c7c3f6f16b40e2c3
> >         git remote add linux-review https://github.com/0day-ci/linux
> >         git fetch --no-tags linux-review Miquel-Raynal/TI-AM437X-ADC1/20210928-213524
> >         git checkout 43a01cf6413f2be038b0d466c7c3f6f16b40e2c3
> >         # save the attached .config to linux build tree
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=microblaze 
> > 
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > All warnings (new ones prefixed by >>):
> > 
> >    drivers/mfd/ti_am335x_tscadc.c: In function 'ti_tscadc_probe':
> > >> drivers/mfd/ti_am335x_tscadc.c:124:31: warning: variable 'use_mag' set but not used [-Wunused-but-set-variable]  
> >      124 |         bool use_tsc = false, use_mag = false;
> >          |                               ^~~~~~~
> 
> It's strange, on my side I didn't get any warnings (using an older GCC,
> perhaps not with all the flags enabled either). Anyway, let's remove
> the noise, I have a fixup patch which can be applied without disturbing
> any of the other patches.
> 
> Lee, do you prefer that I send a fixup patch or a v5 for patch "mfd:
> ti_am335x_tscadc: Add ADC1/magnetic reader support"? (provided of
> course that the other patches are fine to you).

Fix this patch up please.

It would be odd to apply a known broken patch.

> >    In file included from drivers/mfd/ti_am335x_tscadc.c:20:
> >    drivers/mfd/ti_am335x_tscadc.c: At top level:
> >    include/linux/mfd/ti_am335x_tscadc.h:126:38: error: 'HZ_PER_MHZ' undeclared here (not in a function)
> >      126 | #define TSC_ADC_CLK             (3 * HZ_PER_MHZ)
> >          |                                      ^~~~~~~~~~
> >    drivers/mfd/ti_am335x_tscadc.c:354:28: note: in expansion of macro 'TSC_ADC_CLK'
> >      354 |         .target_clk_rate = TSC_ADC_CLK,
> >          |                            ^~~~~~~~~~~
> 
> For this one I don't believe this is a real warning, units.h is
> introduced in a precedent patch, HZ_PER_MHZ is a new macro but it is
> upstream now so I think it can safely be discarded.
> 
> Thanks,
> Miquèl

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
