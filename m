Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7797B24A781
	for <lists+linux-iio@lfdr.de>; Wed, 19 Aug 2020 22:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgHSUIx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 19 Aug 2020 16:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbgHSUIw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 19 Aug 2020 16:08:52 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7956C061383
        for <linux-iio@vger.kernel.org>; Wed, 19 Aug 2020 13:08:51 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id d6so27797597ejr.5
        for <linux-iio@vger.kernel.org>; Wed, 19 Aug 2020 13:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cornell.edu; s=g.20171207;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+aM5oKD4pM5eL2T/vl2kxAT5NLvu6NBnLTbGfDotkZQ=;
        b=CtBOo5cObQNV3sqVEBTmkxnWmIDUNKDpInK7XNSpdrQkDSwpH+DYjvZk4TXRuB9WPu
         oKl71Zfr3HjSLTmMu7CaIqq9Bkkwn8gAoL+3HZeVcfEtAD1G2UCxd5HVevywq1W4zvNa
         kul4XU4nFxm7fP0ApmkUEqX1kojyP4/xl6bbau9HB0oEIDT1GmHTnQQo5QMHAieSIR2M
         fRsWtRmBz5B/h5WMPTaVHhLzvhDoBRF8Z77IX0NRdW64EUuiKguT3pK101kXD2bNohaL
         dU2kZRwrTQz6GXlHQRhdo2FDVlzK+pPkpUcMz/CVdFHWz6xYw9pnufjLll19c/vd01YF
         NqeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+aM5oKD4pM5eL2T/vl2kxAT5NLvu6NBnLTbGfDotkZQ=;
        b=lEatig2wXf9h2xoYKJ5dWNlJyye/cUOnR6Cy+Ct6fQW8C4sBh/nRoFNdzahGQUc/MZ
         2BR69X/wecG0S/uBHcjehKsTh2huCcEdCPlw5MAl5L9GUhYbthZCDtVECdlxKwZsW2uq
         yszG5X1HSvXrC3/CRi4lAQxT6lKmdzptqP/lW9uC5gYvDvYqIA9DJBDxDZCStfvUWNQU
         XEMK4ts2/rY16Y9kxZrnPHI6yIvZXXst5L7axqB5ujzTibw+V6L8ZzE0aeIhYtpfpgDi
         /49PNLvurnIqO6Y1MZCCEBtuPUcSYc12QYzbIOwqlpFI183fFjGy1LRdjmVyC1dvI/6p
         L9aw==
X-Gm-Message-State: AOAM532Znlw3bgmVPdJLP8ylAVrc5qOJZUcGyeSjPvYYgmfepfBIMqxr
        UycweaBEhk6yecGlUNgY5FN81I/JRMOlXlzPd9OPTA==
X-Google-Smtp-Source: ABdhPJwW7tgV1Ue4IzWcoDZFYtqNYZRQhU0B2EXYQVulylayxsAorz860s+HP5brJb7bluLvc96s/G1ey/VLHYpfAsY=
X-Received: by 2002:a17:906:d050:: with SMTP id bo16mr28610589ejb.367.1597867730448;
 Wed, 19 Aug 2020 13:08:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200818153614.6438-1-dts86@cornell.edu> <202008190450.G3jEV7AR%lkp@intel.com>
In-Reply-To: <202008190450.G3jEV7AR%lkp@intel.com>
From:   Darren Schachter <dts86@cornell.edu>
Date:   Wed, 19 Aug 2020 16:08:37 -0400
Message-ID: <CAMEcr28KUH3pxGUENr7p6_9eRmw0AJ3g8n5ONN2GXgP=Emp9BA@mail.gmail.com>
Subject: Re: [PATCH] iio: pulse: Support PWM capture with TI AM3358 eCAP module
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net,
        Matthew Porter <mporter@konsulko.com>,
        robertcnelson@beagleboard.org, drew@beagleboard.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Aug 18, 2020 at 4:49 PM kernel test robot <lkp@intel.com> wrote:
>
> Hi Darren,
>
> Thank you for the patch! Perhaps something to improve:
>
> [auto build test WARNING on iio/togreg]
> [also build test WARNING on linux/master linus/master v5.9-rc1 next-20200818]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
>
> url:    https://github.com/0day-ci/linux/commits/Darren-Schachter/iio-pulse-Support-PWM-capture-with-TI-AM3358-eCAP-module/20200818-233934
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
> config: nios2-allyesconfig (attached as .config)
> compiler: nios2-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=nios2
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
>    drivers/iio/pulse/pulse_tiecap.c: In function 'ecap_attr_prescalar_store':
> >> drivers/iio/pulse/pulse_tiecap.c:193:6: warning: variable 'ret' set but not used [-Wunused-but-set-variable]
>      193 |  int ret;
>          |      ^~~
>
> # https://github.com/0day-ci/linux/commit/b454a1487cd33fe1b8962f9e6b5b0ca35b373ece
> git remote add linux-review https://github.com/0day-ci/linux
> git fetch --no-tags linux-review Darren-Schachter/iio-pulse-Support-PWM-capture-with-TI-AM3358-eCAP-module/20200818-233934
> git checkout b454a1487cd33fe1b8962f9e6b5b0ca35b373ece
> vim +/ret +193 drivers/iio/pulse/pulse_tiecap.c
>
>    187
>    188  static ssize_t ecap_attr_prescalar_store(struct device *dev,
>    189                                          struct device_attribute *attr,
>    190                                          const char *buf,
>    191                                          size_t len)
>    192  {
>  > 193          int ret;
>    194          long val;
>    195          struct ecap_state *state = dev_to_ecap_state(dev);
>    196
>    197          if (test_bit(ECAP_ENABLED, &state->flags))
>    198                  return -EINVAL;
>    199
>    200          ret = kstrtol(buf, 16, &val);
>    201          if (val > 0x05 && val != 0x1E && val != 0x1F)
>    202                  return -EINVAL;
>    203
>    204          mutex_lock(&state->lock);
>    205          state->flags &= ~(0x1F << ECAP_PRESCALAR_OFFSET); // clear bits
>    206          state->flags |= (val << ECAP_PRESCALAR_OFFSET);
>    207          mutex_unlock(&state->lock);
>    208
>    209          return len;
>    210  }
>    211
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

I've made modifications to remedy this issue for version 2 of the
patch. I will wait for additional feedback before submitting version
2. I do not believe this minor change warrants a new version on its
own, but please let me know if you feel differently.
