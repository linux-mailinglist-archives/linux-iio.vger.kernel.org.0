Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1887D3F7023
	for <lists+linux-iio@lfdr.de>; Wed, 25 Aug 2021 09:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239110AbhHYHMI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 25 Aug 2021 03:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239005AbhHYHMF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 25 Aug 2021 03:12:05 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63068C061757;
        Wed, 25 Aug 2021 00:11:19 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id e1so6834435plt.11;
        Wed, 25 Aug 2021 00:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dDWWfjycZLV3IxSuze6wt1njkX6GdjVfdq4FRPlZ9kU=;
        b=UF0fgSVJcFRrpEC2yzwwVn86yVEuDNvc+S0VNrbPIwvJBlMm6xyYRSa7EqUpmxTtfD
         z/ZXGEnsqLMuZa0dhM7RGCeWtdbp6qcayawBFFOx9oMtM/LV3vclAin4jTIhJ/arXq39
         tE2e+LPnynj/z1jx5LW852QBqcrzD6ox2+KO5c2eS2IxH4bHIcNKhePSfhRyZlNdfpl8
         Dv/Rf5uEQWYeZ9auZvSKl506WNgLZ6+nso+GKg3TN1YF7ROYByJjjbFFV+x84n0NGPxA
         2gk0C81rYnUiO1/ErRNAwrTwRstDXPnERn5+xt8YpIT4uhMhEWZrLVN29jFfskZ38ebd
         MMww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dDWWfjycZLV3IxSuze6wt1njkX6GdjVfdq4FRPlZ9kU=;
        b=XGKKoTuc425glgP8fcJF80D9xSNA6oGCvI/Xjh8Dz5R+Y9QIaBwqksl85TIKdQqELD
         Zwypj6QLvBMwDVgThCWxNSXiXJq3r4ZNSSsR0N4AeN8w6QKVpp8zBRTrXKGovLW+tcU/
         DTiFOVuxRLIVJWN/e4cDUwoT7/tNa/e2bH0AaPA9iVwkThyPDavdBayU4H3WTx+AjMJL
         JgJsZCrJIBw6mokUCFuOs8KBG9jaFiAGij4mfkXdjrSZ7hL+AsU4f1ytygMXCxtWfT3w
         5m356K6tzZ6Sw5jU5yGWW5piq9B1qnm7I84IeLW1Cw7LjzJoGGh4YKr83f+Kh1TM3R8t
         4s8w==
X-Gm-Message-State: AOAM531T1DzW8aVHkWfTus5pEdNaovwL130aFOydiqUWE+72J8lkchIW
        uy91XxmJVJJwn4N7XgrW4WdVyH1+YnYfMlfwvj4=
X-Google-Smtp-Source: ABdhPJz01n4op3Br7li5DPpI73/Q+T9EvWeuuQ3m0IZmBkgdBIkFe8usQ8m/VBFPo1S6ras3Usq69pNM2M7wi98zxKg=
X-Received: by 2002:a17:90a:a382:: with SMTP id x2mr9163863pjp.86.1629875478922;
 Wed, 25 Aug 2021 00:11:18 -0700 (PDT)
MIME-Version: 1.0
References: <f20a0eb45957c6931a8f35d035514484a2ac0f3d.1629838169.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <f20a0eb45957c6931a8f35d035514484a2ac0f3d.1629838169.git.christophe.jaillet@wanadoo.fr>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Wed, 25 Aug 2021 10:11:07 +0300
Message-ID: <CA+U=DspfvNU6gwRGZjWMtjrDQV2=N8H5ARnq4Sz4HWZ=FBmn_g@mail.gmail.com>
Subject: Re: [PATCH] iio: adc128s052: Simplify 'adc128_probe()'
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Aug 24, 2021 at 11:52 PM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> Turn 'adc128_probe()' into a full resource managed function to simplify the
> code.
>
> This way, the .remove function can be removed.
> Doing so, the only 'spi_get_drvdata()' call is removed and the
> corresponding 'spi_set_drvdata()' can be removed as well.
>

Minor note inline. Nothing major.

Other than that:

Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>

> Suggested-by: Alexandru Ardelean <ardeleanalex@gmail.com>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Compile tested only.
>
> When reviewing, pay special attention to the 'spi_set_drvdata()' call
> removal. I recently introduced a regression with a too aggressive cleanup
> like that.
>
> This patch should be applied after
> https://lore.kernel.org/linux-iio/f33069f0-601b-4bbb-3766-026f7a161912@wanadoo.fr/T/#meb792dcd6540f87d9ae041660ca4738a776e924a
> ---
>  drivers/iio/adc/ti-adc128s052.c | 34 +++++++++++----------------------
>  1 file changed, 11 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
> index 83c1ae07b3e9..e1afdb775100 100644
> --- a/drivers/iio/adc/ti-adc128s052.c
> +++ b/drivers/iio/adc/ti-adc128s052.c
> @@ -132,6 +132,13 @@ static const struct iio_info adc128_info = {
>         .read_raw = adc128_read_raw,
>  };
>
> +static void adc128_disable_regulator(void *data)
> +{
> +       struct regulator *reg = data;
> +
> +       regulator_disable(reg);
> +}

You can also do this as:

static void adc128_disable_regulator(void *reg)
{
      regulator_disable(reg);
}

> +
>  static int adc128_probe(struct spi_device *spi)
>  {
>         struct iio_dev *indio_dev;
> @@ -151,8 +158,6 @@ static int adc128_probe(struct spi_device *spi)
>         adc = iio_priv(indio_dev);
>         adc->spi = spi;
>
> -       spi_set_drvdata(spi, indio_dev);
> -
>         indio_dev->name = spi_get_device_id(spi)->name;
>         indio_dev->modes = INDIO_DIRECT_MODE;
>         indio_dev->info = &adc128_info;
> @@ -167,29 +172,13 @@ static int adc128_probe(struct spi_device *spi)
>         ret = regulator_enable(adc->reg);
>         if (ret < 0)
>                 return ret;
> -
> -       mutex_init(&adc->lock);
> -
> -       ret = iio_device_register(indio_dev);
> +       ret = devm_add_action_or_reset(&spi->dev, adc128_disable_regulator, adc->reg);
>         if (ret)
> -               goto err_disable_regulator;
> -
> -       return 0;
> -
> -err_disable_regulator:
> -       regulator_disable(adc->reg);
> -       return ret;
> -}
> -
> -static int adc128_remove(struct spi_device *spi)
> -{
> -       struct iio_dev *indio_dev = spi_get_drvdata(spi);
> -       struct adc128 *adc = iio_priv(indio_dev);
> +               return ret;
>
> -       iio_device_unregister(indio_dev);
> -       regulator_disable(adc->reg);
> +       mutex_init(&adc->lock);
>
> -       return 0;
> +       return devm_iio_device_register(&spi->dev, indio_dev);
>  }
>
>  static const struct of_device_id adc128_of_match[] = {
> @@ -231,7 +220,6 @@ static struct spi_driver adc128_driver = {
>                 .acpi_match_table = ACPI_PTR(adc128_acpi_match),
>         },
>         .probe = adc128_probe,
> -       .remove = adc128_remove,
>         .id_table = adc128_id,
>  };
>  module_spi_driver(adc128_driver);
> --
> 2.30.2
>
