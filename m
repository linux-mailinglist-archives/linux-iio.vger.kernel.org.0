Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58B0358C791
	for <lists+linux-iio@lfdr.de>; Mon,  8 Aug 2022 13:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242005AbiHHLeA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Aug 2022 07:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbiHHLd7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Aug 2022 07:33:59 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69CDEE2D;
        Mon,  8 Aug 2022 04:33:58 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id o1so6156601qkg.9;
        Mon, 08 Aug 2022 04:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Pc8brGgZ8rnZc2uoHyQ1lCNFFhM+Ve3yuMln1N/6S+k=;
        b=RtYRQaCxMUQf86NwOmvg1lGxoipF0W0tme1dmCxFHIJEmBsQZI+3Mq4++f69h75TOv
         lYCwk3Omh9fHEkQoKPfB1lKsSgWunZlXaWD4UoZg4akjX6f04p2wg3p631v0Z0VwUlXP
         SAFtiO1uNUYxwOj+XU4ZD4/DipES1ItxYchRWtE/IqeUtSXYvU4xEW24B/QJMtTO5QSS
         kyeiA7uerCfxrM5TnEnSHbxa6UXr0O36m5xEmM9ABKb/TwSGAUf44K+nxLfLUuXn7n03
         D9phT03anHip7pmW4d0hrTM2vot2lxJs7MKkW4KnUf33f2FS9KCFCU3IJrX3IFUP6QaN
         L12w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Pc8brGgZ8rnZc2uoHyQ1lCNFFhM+Ve3yuMln1N/6S+k=;
        b=QzPupTWy0+JgHrNvluJ/VmRly/wVriQYaFNLXnmG5iB4XDbY9lNaNZxQgFTnhXSSgr
         VB+Qx7OQynwBsEMPQPZC5q+ldEeTxI7EzOqmEPfgK7jTMgYsUJz8WcEkgVtt6cJPYyVV
         coblxdOOYgWUJapPN41aLWmsgVCFdfxk54PF4ctP/bAQGoKU6bUElzyhFOSDODfnM2cQ
         RSb/dMxJ2orAOeDVS143ReJhxuHByKq21u76ErD5329diahmmsW2m74Uo4SLd9/t1h0H
         5lUzV156U/TXLmnYzMU2Bq+Bsv/VwkE16CjiaL2ePAc2SswS9fIeuQO5irZUyHudKWQY
         mQBQ==
X-Gm-Message-State: ACgBeo3z8rQleo55IrWasdHMjCKAKp8wSbu25jXDJUlfTfWhnUU92tKk
        /oTZBH68rk7hMVAEAo1vLoV2w8QsoFZbYecLCNM=
X-Google-Smtp-Source: AA6agR5LmSLB/EqfZst5jXQMRkxVgWKS2sDQUw5vTtb/fBUZAp6n5jX1JB1TA1sa0G6h2qMl66hmcOKzLzdeLPpHMec=
X-Received: by 2002:a05:620a:8018:b0:6b6:5df:977 with SMTP id
 ee24-20020a05620a801800b006b605df0977mr13284649qkb.320.1659958437878; Mon, 08
 Aug 2022 04:33:57 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1659909060.git.jahau@rocketmail.com> <aa1936a9e3687cb9d112232b87db8a9f9e1a7ffa.1659909060.git.jahau@rocketmail.com>
In-Reply-To: <aa1936a9e3687cb9d112232b87db8a9f9e1a7ffa.1659909060.git.jahau@rocketmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 8 Aug 2022 13:33:21 +0200
Message-ID: <CAHp75VcroSHcgMWwkVZh8sG8ex4K56X1wmM9SFH0qa+GCLzgng@mail.gmail.com>
Subject: Re: [PATCH v5 10/14] iio: magnetometer: yas530: Add volatile
 registers to "chip_info"
To:     Jakob Hauser <jahau@rocketmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Aug 8, 2022 at 1:07 AM Jakob Hauser <jahau@rocketmail.com> wrote:
>
> Add volatile registers to the "chip_info" structure to ease the handling of
> different YAS variants.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
> ---
>  drivers/iio/magnetometer/yamaha-yas530.c | 37 ++++++++++++++++++++++--
>  1 file changed, 34 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iio/magnetometer/yamaha-yas530.c b/drivers/iio/magnetometer/yamaha-yas530.c
> index ecc2b61a5c4f..914f7f0a243e 100644
> --- a/drivers/iio/magnetometer/yamaha-yas530.c
> +++ b/drivers/iio/magnetometer/yamaha-yas530.c
> @@ -114,6 +114,11 @@ static const char * const yas5xx_version_names[][2] = {
>         [yas533] = { "AB", "AC" },
>  };
>
> +static const int yas530_volatile_reg[] = {
> +       YAS530_ACTUATE_INIT_COIL,
> +       YAS530_MEASURE,
> +};
> +
>  struct yas5xx_calibration {
>         /* Linearization calibration x, y1, y2 */
>         s32 r[3];
> @@ -135,11 +140,15 @@ struct yas5xx;
>   * @devid: device ID number
>   * @product_name: product name of the YAS variant
>   * @version_name: version letter or naming
> + * @volatile_reg: device-specific volatile registers
> + * @volatile_reg_qty: quantity of device-specific volatile registers
>   */
>  struct yas5xx_chip_info {
>         unsigned int devid;
>         const char *product_name;
>         const char * const *version_name;
> +       const int *volatile_reg;
> +       int volatile_reg_qty;
>  };
>
>  /**
> @@ -626,9 +635,25 @@ static const struct iio_info yas5xx_info = {
>
>  static bool yas5xx_volatile_reg(struct device *dev, unsigned int reg)
>  {
> -       return reg == YAS530_ACTUATE_INIT_COIL ||
> -               reg == YAS530_MEASURE ||
> -               (reg >= YAS5XX_MEASURE_DATA && reg < YAS5XX_MEASURE_DATA + 8);
> +       struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +       struct yas5xx *yas5xx = iio_priv(indio_dev);
> +       int reg_qty;
> +       int i;
> +
> +       if (reg >= YAS5XX_MEASURE_DATA && reg < YAS5XX_MEASURE_DATA + 8)
> +               return true;
> +
> +       /*
> +        * YAS versions share different registers on the same address,
> +        * need to differentiate.
> +        */
> +       reg_qty = yas5xx->chip_info->volatile_reg_qty;
> +       for (i = 0; i < reg_qty; i++) {
> +               if (reg == yas5xx->chip_info->volatile_reg[i])
> +                       return true;
> +       }
> +
> +       return false;
>  }
>
>  /* TODO: enable regmap cache, using mark dirty and sync at runtime resume */
> @@ -932,16 +957,22 @@ static const struct yas5xx_chip_info yas5xx_chip_info_tbl[] = {
>                 .devid = YAS530_DEVICE_ID,
>                 .product_name = yas5xx_product_name[yas530],
>                 .version_name = yas5xx_version_names[yas530],
> +               .volatile_reg = yas530_volatile_reg,
> +               .volatile_reg_qty = ARRAY_SIZE(yas530_volatile_reg),
>         },
>         [yas532] = {
>                 .devid = YAS532_DEVICE_ID,
>                 .product_name = yas5xx_product_name[yas532],
>                 .version_name = yas5xx_version_names[yas532],
> +               .volatile_reg = yas530_volatile_reg,
> +               .volatile_reg_qty = ARRAY_SIZE(yas530_volatile_reg),
>         },
>         [yas533] = {
>                 .devid = YAS532_DEVICE_ID,
>                 .product_name = yas5xx_product_name[yas533],
>                 .version_name = yas5xx_version_names[yas533],
> +               .volatile_reg = yas530_volatile_reg,
> +               .volatile_reg_qty = ARRAY_SIZE(yas530_volatile_reg),
>         },
>  };
>
> --
> 2.35.1
>


-- 
With Best Regards,
Andy Shevchenko
