Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D21AA254F94
	for <lists+linux-iio@lfdr.de>; Thu, 27 Aug 2020 21:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbgH0T7v (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 27 Aug 2020 15:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbgH0T7v (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 27 Aug 2020 15:59:51 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1224DC061264;
        Thu, 27 Aug 2020 12:59:51 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id i13so3210424pjv.0;
        Thu, 27 Aug 2020 12:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BtW/ozpx4qaFKtR4WdRiyJH+a5pa+/rdp0E0zYCBtiw=;
        b=AjsVfQcbbs8m2CmFrHV0gwxOPDDFel6Dtuz0EVsMe9pOvePSe2KyCjg5R54J213aA0
         dYs7dOdAsqUXhUKoWNElRVtmUGHCALn0WOiQUKE3W6V6pIo5TVmtY5wvgoJScOJBWpF2
         ZwroeOfqHbSXgH9NOC4gFVc4jTWoND5bcI6V09T8yOcf2ohLyiHpQVEaPEZNqdAIqkPI
         UeZlWWC0M/SJWy9F5wyNplXtqhJHSmtWHVsSFfV7wIy865aw2DytyMKKrm30aAaK0iG0
         tmW4yhgyhYPR7janwCUFLJmWVHIfAqhea6q549D12zbhnsK/fJvsZeTjhzSky3l/gGR3
         9QZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BtW/ozpx4qaFKtR4WdRiyJH+a5pa+/rdp0E0zYCBtiw=;
        b=Kwd7yYFMwfiuNdfmp+yz5o1rncNWB9qPDyZtWExxlxb8jfMZz6V4ugrZG3gNDlc2Lu
         WOP+6v7QVSuSsS2jhlV5ts3tcjxnw9hPpiU8BDYAmdO5Fxbu/SEKxLAVHnoxF0IrjO/K
         fYqjVuI1F3I59QYY74je8A8sFKay/8fSYOgbYnWsiM8Y7qNzmXm+diQK4PlIjiMVvvkA
         z2H+Rl7pVmDotZo9pQVnvFehHvxceSbo2XCjvkxxrWCE19vb2Ev130tTFR1lvbvpXyUv
         OGx5aaQrrxZqel8ktyH2n2cmSUS30mOD9M0gX4Yd0fx5fDArqMupcXRW5ldyVkxDamRW
         U/JQ==
X-Gm-Message-State: AOAM531i0WXafupecX5sW+1tC695hmyZXBdKSlnhHGvDscXKaPjmbUaB
        n+f660MrNuQojTSJd59GiLmX1iqtbg5j75Rw0hE=
X-Google-Smtp-Source: ABdhPJztdvx7l/Bma3wdHdw/Knt4y7nn4/yOSwjk8CneJT6blQkPrpb2KiIZIrG26U/H2iMIqzfbq2Fkdjt5j2df1p0=
X-Received: by 2002:a17:90a:2c06:: with SMTP id m6mr433859pjd.129.1598558390619;
 Thu, 27 Aug 2020 12:59:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200827192642.1725-1-krzk@kernel.org> <20200827192642.1725-13-krzk@kernel.org>
In-Reply-To: <20200827192642.1725-13-krzk@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 27 Aug 2020 22:59:34 +0300
Message-ID: <CAHp75VfByooMDK0bMGG-EiYg=x5NtYaweAyeJ3CXH38j_xPw9A@mail.gmail.com>
Subject: Re: [PATCH v2 13/18] iio: imu: inv_mpu6050: Simplify with dev_err_probe()
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Peter Rosin <peda@axentia.se>, Kukjin Kim <kgene@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Aug 27, 2020 at 10:28 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> Common pattern of handling deferred probe can be simplified with
> dev_err_probe().  Less code and also it prints the error value.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 20 ++++++--------------
>  1 file changed, 6 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index 3fee3947f772..18a1898e3e34 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -1475,22 +1475,14 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
>         }
>
>         st->vdd_supply = devm_regulator_get(dev, "vdd");
> -       if (IS_ERR(st->vdd_supply)) {
> -               if (PTR_ERR(st->vdd_supply) != -EPROBE_DEFER)
> -                       dev_err(dev, "Failed to get vdd regulator %d\n",
> -                               (int)PTR_ERR(st->vdd_supply));
> -
> -               return PTR_ERR(st->vdd_supply);
> -       }
> +       if (IS_ERR(st->vdd_supply))
> +               return dev_err_probe(dev, PTR_ERR(st->vdd_supply),
> +                                    "Failed to get vdd regulator\n");
>
>         st->vddio_supply = devm_regulator_get(dev, "vddio");
> -       if (IS_ERR(st->vddio_supply)) {
> -               if (PTR_ERR(st->vddio_supply) != -EPROBE_DEFER)
> -                       dev_err(dev, "Failed to get vddio regulator %d\n",
> -                               (int)PTR_ERR(st->vddio_supply));
> -
> -               return PTR_ERR(st->vddio_supply);
> -       }
> +       if (IS_ERR(st->vddio_supply))
> +               return dev_err_probe(dev, PTR_ERR(st->vddio_supply),
> +                                    "Failed to get vddio regulator\n");
>
>         result = regulator_enable(st->vdd_supply);
>         if (result) {
> --
> 2.17.1
>


-- 
With Best Regards,
Andy Shevchenko
