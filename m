Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF270351F67
	for <lists+linux-iio@lfdr.de>; Thu,  1 Apr 2021 21:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234352AbhDATQH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 1 Apr 2021 15:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234850AbhDATOn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 1 Apr 2021 15:14:43 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BEEDC0613B3;
        Thu,  1 Apr 2021 11:06:15 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id a22-20020a17090aa516b02900c1215e9b33so3483151pjq.5;
        Thu, 01 Apr 2021 11:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LtbHgeOb5Q/GLe2iHTvlk5L+iXICHogfcJ7TfbimPCs=;
        b=VrZzKx+uJE1Tg2egJrBWLu9gt7VPFt1vdgxVuXWVwFli0ZByDP+TLwtmNsK3rBfDjr
         X7hhAzyzRTpOvhmB/LeTdNIxX4XX/UGzFC/GMPKd2Eryww1KZ40M7qxQSEaOYEPSzprh
         nw/hLrU383xEpIKwm1BCBTTUunmbXPf8Tc8j/IeWclI9wMWW/Gdk3CRe9QDZmDs8rUjP
         +YebusOFF126ld9ZER5jzx5j/WDpY2fs9fZQTq4mZoc/gd+fS6ExHGSO40lmtnWjlEoj
         M7gUflHLs8oMkXRwy55JMpOT0s4+Hu2QgkbC/5nsdS/qCKwMoFWsMty9iSBGa0LPtJGy
         aLSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LtbHgeOb5Q/GLe2iHTvlk5L+iXICHogfcJ7TfbimPCs=;
        b=laWGGfliET5gp7ZVcjfbb+7U5dzjYk36fEmZWeFu18+JlMWNTn2I8mFHAE7LXGodYw
         r11n3BecWCOvzg35M9dQleHy3y0tKNbeodhqXFJ9LHHPYh+QR5Wvux/mGdl5NjyLMoCa
         5PjWSfVs4Z1cJytAE7NSsg6cd2bQFHCreG1IzyMaPTe9bJco3Xxz7o/LgzEYQQsSSsKD
         0Hl24JcftsfE75COnv1taMhLOjI/A/W52iMZxleLNV68WbcIlKa7/7inU8rHcAx2TC3B
         EE6YepKJB/gq4lyY1up0iv8Y6doeny91dFxgHaZhtgYdBU8IKIlXI7vWl5KKbHNIoH6I
         5OAg==
X-Gm-Message-State: AOAM533AriOvDoNi5HX+kEfer9Ig12dG5gQxXvqrwKrwktNcw05Hm1bz
        beAhSZ3Wnnnz6lltVI9nnhlpVCMpRjetSZNPEns=
X-Google-Smtp-Source: ABdhPJzsvLX9harUfAuK07k4egskm6yqn6pQylArKiWFguIMrjNLOlW5MORgdYPmir2kwL2JGK0erL1PRRJAwTzvGaw=
X-Received: by 2002:a17:90a:db49:: with SMTP id u9mr10351275pjx.181.1617300374919;
 Thu, 01 Apr 2021 11:06:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210401154343.41527-1-dmugil2000@gmail.com>
In-Reply-To: <20210401154343.41527-1-dmugil2000@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 1 Apr 2021 21:05:58 +0300
Message-ID: <CAHp75VfkCQpfUrVcWHUnD4DLMp9iZJBL8mYfsYOCsESm_y068A@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: stm32-dfsdm: drop __func__ while using Dynamic debug
To:     Mugilraj Dhavachelvan <dmugil2000@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Apr 1, 2021 at 8:48 PM Mugilraj Dhavachelvan
<dmugil2000@gmail.com> wrote:
>
> dropped __func__ while using dev_dbg() and pr_debug()

The commit message may be amended, from code perspective LGTM!
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Mugilraj Dhavachelvan <dmugil2000@gmail.com>
> ---
>  drivers/iio/adc/stm32-dfsdm-adc.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
> index 76a60d93fe23..95ec5f3c3126 100644
> --- a/drivers/iio/adc/stm32-dfsdm-adc.c
> +++ b/drivers/iio/adc/stm32-dfsdm-adc.c
> @@ -198,7 +198,7 @@ static int stm32_dfsdm_compute_osrs(struct stm32_dfsdm_filter *fl,
>         unsigned int p = fl->ford;      /* filter order (ford) */
>         struct stm32_dfsdm_filter_osr *flo = &fl->flo[fast];
>
> -       pr_debug("%s: Requested oversampling: %d\n",  __func__, oversamp);
> +       pr_debug("Requested oversampling: %d\n", oversamp);
>         /*
>          * This function tries to compute filter oversampling and integrator
>          * oversampling, base on oversampling ratio requested by user.
> @@ -294,8 +294,8 @@ static int stm32_dfsdm_compute_osrs(struct stm32_dfsdm_filter *fl,
>                                 }
>                                 flo->max = (s32)max;
>
> -                               pr_debug("%s: fast %d, fosr %d, iosr %d, res 0x%llx/%d bits, rshift %d, lshift %d\n",
> -                                        __func__, fast, flo->fosr, flo->iosr,
> +                               pr_debug("fast %d, fosr %d, iosr %d, res 0x%llx/%d bits, rshift %d, lshift %d\n",
> +                                        fast, flo->fosr, flo->iosr,
>                                          flo->res, bits, flo->rshift,
>                                          flo->lshift);
>                         }
> @@ -858,7 +858,7 @@ static void stm32_dfsdm_dma_buffer_done(void *data)
>          * support in IIO.
>          */
>
> -       dev_dbg(&indio_dev->dev, "%s: pos = %d, available = %d\n", __func__,
> +       dev_dbg(&indio_dev->dev, "pos = %d, available = %d\n",
>                 adc->bufi, available);
>         old_pos = adc->bufi;
>
> @@ -912,7 +912,7 @@ static int stm32_dfsdm_adc_dma_start(struct iio_dev *indio_dev)
>         if (!adc->dma_chan)
>                 return -EINVAL;
>
> -       dev_dbg(&indio_dev->dev, "%s size=%d watermark=%d\n", __func__,
> +       dev_dbg(&indio_dev->dev, "size=%d watermark=%d\n",
>                 adc->buf_sz, adc->buf_sz / 2);
>
>         if (adc->nconv == 1 && !indio_dev->trig)
> --
> 2.25.1
>


-- 
With Best Regards,
Andy Shevchenko
