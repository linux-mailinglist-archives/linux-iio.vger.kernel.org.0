Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35DBC3775C4
	for <lists+linux-iio@lfdr.de>; Sun,  9 May 2021 09:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbhEIHV0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 May 2021 03:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbhEIHVZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 9 May 2021 03:21:25 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E606C061573
        for <linux-iio@vger.kernel.org>; Sun,  9 May 2021 00:20:22 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id t21so7652709plo.2
        for <linux-iio@vger.kernel.org>; Sun, 09 May 2021 00:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XnXrLc1kcjkMCfV6t4hsxU88T/vM1ZtX+oYFbSQNHpU=;
        b=BRn655dXIbNmDZ3gmFpMBPrinp+MfmoD0Fi7bBb+DwnS3UlShaWGqJHu/cQq6brKqA
         KebUDp2gBGw3ZtpFCpgpTNq1kbbfL/hBa18B0HjA49tdq4Z2LE/7WZKW2zdoSyJh0OtZ
         s04Sg2FIPxb6TfkK+kxaNN63yyKTR6ero6thC8qjPBHr0aGzEjymDh5b09Yf1qTDKjBV
         DQrmwl9jiCI+khFgySgWs/TD3bvNlT1c9iY9Vgz5Ma2OIzdZ5RmthxyN+j/AZvHd9+IT
         joNo3BIcO5r3hlgRue0EPSH91RejG0PW9bdltkBZaALiwBLTFQ8gomZrzOSZOiI/PBDu
         RpmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XnXrLc1kcjkMCfV6t4hsxU88T/vM1ZtX+oYFbSQNHpU=;
        b=F/fDcvc38ClBUQRJGZJYUuBHlDBArsW5cO73kSyOh1XiVPCGS2aA+KiqwgFMcpjRHl
         cZyBlQ/IOhsB090Mt+ofHERKx7M+csYPULlbB29yUwfIoTZFRyO0fD7sN0ZVaE02Kbxp
         MESin3TMDgavlcfLBVY9bUdngzxV4Wb8HppLef7looInyerVmR7DXsHdHrsJztzHgjvt
         aOIBfzJBAp7cKbIhd9+mdFH2v1JftGnW9L+7mpDFnLwD+w8QZJKb7b7fruFaByx6ytEc
         TNd/feNkkhRAYdXG44mWETOmkMQZOdQfG+Bk8AFGLMAcgvmImWi7hUNI1P5wwdYCC5PJ
         NrMw==
X-Gm-Message-State: AOAM530hll+hiFbv0CX3NNTsYNK/L/jgFLbO92ZfKU5FcCVAcNVneCU/
        eGz36oByU7KuXByKBCm5l+qcFZ3gFoQiq9cineo=
X-Google-Smtp-Source: ABdhPJwfMI6Y9uRQgutnGga+KT9XRhkswWJEyMGgwkG1Xf2wcLKadMZ9FeSwsVjq4vBTIKnhg+dmDC26Y9MrHRIYDRk=
X-Received: by 2002:a17:90a:1b0b:: with SMTP id q11mr21090507pjq.181.1620544821722;
 Sun, 09 May 2021 00:20:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210508182319.488551-1-jic23@kernel.org> <20210508182319.488551-2-jic23@kernel.org>
In-Reply-To: <20210508182319.488551-2-jic23@kernel.org>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Sun, 9 May 2021 10:20:10 +0300
Message-ID: <CA+U=DsqW=NszVukaDK1-MXhZbr3F_RwD1YghnfFqWesYnQh7tA@mail.gmail.com>
Subject: Re: [PATCH 1/3] iio: adc: ad7124: Fix missbalanced regulator enable /
 disable on error.
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        alexandru.tachici@analog.com,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, May 8, 2021 at 9:24 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> If the devm_regulator_get() call succeeded but not the regulator_enable()
> then regulator_disable() would be called on a regulator that was not
> enabled.
>
> Fix this by moving regulator enabling / disabling over to
> devm_ management via devm_add_action_or_reset.
>

Definitely looks unbalanced.
This was probably written in the days when I wasn't familiar with devm_ much.
I probably would have complained about this.

Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>

> Fixes: b3af341bbd96 ("iio: adc: Add ad7124 support")
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Alexandru Ardelean <ardeleanalex@gmail.com>
> ---
>  drivers/iio/adc/ad7124.c | 29 +++++++++++++----------------
>  1 file changed, 13 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
> index 766c73333604..c0d0870a29ff 100644
> --- a/drivers/iio/adc/ad7124.c
> +++ b/drivers/iio/adc/ad7124.c
> @@ -707,6 +707,11 @@ static int ad7124_setup(struct ad7124_state *st)
>         return ret;
>  }
>
> +static void ad7124_reg_disable(void *r)
> +{
> +       regulator_disable(r);
> +}
> +
>  static int ad7124_probe(struct spi_device *spi)
>  {
>         const struct ad7124_chip_info *info;
> @@ -752,17 +757,20 @@ static int ad7124_probe(struct spi_device *spi)
>                 ret = regulator_enable(st->vref[i]);
>                 if (ret)
>                         return ret;
> +
> +               ret = devm_add_action_or_reset(&spi->dev, ad7124_reg_disable,
> +                                              st->vref[i]);
> +               if (ret)
> +                       return ret;
>         }
>
>         st->mclk = devm_clk_get(&spi->dev, "mclk");
> -       if (IS_ERR(st->mclk)) {
> -               ret = PTR_ERR(st->mclk);
> -               goto error_regulator_disable;
> -       }
> +       if (IS_ERR(st->mclk))
> +               return PTR_ERR(st->mclk);
>
>         ret = clk_prepare_enable(st->mclk);
>         if (ret < 0)
> -               goto error_regulator_disable;
> +               return ret;
>
>         ret = ad7124_soft_reset(st);
>         if (ret < 0)
> @@ -792,11 +800,6 @@ static int ad7124_probe(struct spi_device *spi)
>         ad_sd_cleanup_buffer_and_trigger(indio_dev);
>  error_clk_disable_unprepare:
>         clk_disable_unprepare(st->mclk);
> -error_regulator_disable:
> -       for (i = ARRAY_SIZE(st->vref) - 1; i >= 0; i--) {
> -               if (!IS_ERR_OR_NULL(st->vref[i]))
> -                       regulator_disable(st->vref[i]);
> -       }
>
>         return ret;
>  }
> @@ -805,17 +808,11 @@ static int ad7124_remove(struct spi_device *spi)
>  {
>         struct iio_dev *indio_dev = spi_get_drvdata(spi);
>         struct ad7124_state *st = iio_priv(indio_dev);
> -       int i;
>
>         iio_device_unregister(indio_dev);
>         ad_sd_cleanup_buffer_and_trigger(indio_dev);
>         clk_disable_unprepare(st->mclk);
>
> -       for (i = ARRAY_SIZE(st->vref) - 1; i >= 0; i--) {
> -               if (!IS_ERR_OR_NULL(st->vref[i]))
> -                       regulator_disable(st->vref[i]);
> -       }
> -
>         return 0;
>  }
>
> --
> 2.31.1
>
