Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29258254FA5
	for <lists+linux-iio@lfdr.de>; Thu, 27 Aug 2020 22:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbgH0UB7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 27 Aug 2020 16:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbgH0UB6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 27 Aug 2020 16:01:58 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73BEBC061264;
        Thu, 27 Aug 2020 13:01:58 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id p37so4136449pgl.3;
        Thu, 27 Aug 2020 13:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l6QdgtQwuCtCJCOXFFSMuQPOtSKidk6SZriT8+KhQKU=;
        b=B784LqlhlWCORMwjfseGM9afIz00NTvMypFlKUBZTooVep4/T0/aixsxongGyx3wDz
         Vg2+U4LCeAI7Yib+KiJZ24l/0/FfhRaidOdFvUUWRes3nDyPcm5VV2ogvlsIYbadSuA+
         7hVKFLzj3mIih5YVGxJste5+4zT0jWH6QCHJ7a599HH1cEynJHhvbDzUrJNcVg+2LdYU
         vJz7JB1MzlPVeFxH+Ywz5BuZVnrsLEQqYGbsgA9TxfLbz9vHqcNbp9L8M3BveliFy6F6
         slZQAUspB+XSx2BvCSYHwxT68ofD/WjT3JZJ47bsp376mZrFgkcUnV3hrR2G7TeJh8k8
         Kv3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l6QdgtQwuCtCJCOXFFSMuQPOtSKidk6SZriT8+KhQKU=;
        b=l8szXOi/DYJwIhABmRWGWl79sDUNNKQK9scLYO9LNm1C/osSC3Jb2Ip1lCtUIMeCDu
         4FEB1QNTQLRg+cC/+6+cN10Oi9IW6rzSoDjV85sZuapfJgfTBC5TzC5U9uaM6CJCJH2t
         OyyRx/+giCENSzJ8UALgT8OPplNgy3JiheuRjUyoLJjby6idem6aiKZDyMMn3AIluRwi
         Hm3BZR+Gf9LF2+XQOPouJE4xlPyy3CJ/L/7LzQJzbihgCfi25sB5AGAxeKzk7GnSfdWH
         UU9m98hS7AA5iXnVxhseWbXJhLUWTwVPiEOGa7aBtVyIl7fdCoenC4QtKJ5n7qE9Bnp9
         WtAw==
X-Gm-Message-State: AOAM533idCed/yGLPsxowVGgzoEgaePqGwbZjuQsc6/LgyT2HJY0yFdi
        C7hVGa6qnIrRL0l15cbFXGuQim+r+QheCSFxP5U=
X-Google-Smtp-Source: ABdhPJzCSEzURvMIShpRrKsXdEjhN4LSdnjS+SJS9io1bcAC4MW3DZYDijZQo+ehN/ojjLNrNphCrhRo/58GmQug+Io=
X-Received: by 2002:a17:902:8208:: with SMTP id x8mr6322386pln.65.1598558517933;
 Thu, 27 Aug 2020 13:01:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200827192642.1725-1-krzk@kernel.org> <20200827192642.1725-17-krzk@kernel.org>
In-Reply-To: <20200827192642.1725-17-krzk@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 27 Aug 2020 23:01:41 +0300
Message-ID: <CAHp75VfoaSvnECbtQ_HRNBrnQK6avvnmymrgcge5wLPH89_Vnw@mail.gmail.com>
Subject: Re: [PATCH v2 17/18] iio: magnetometer: mag3110: Simplify with dev_err_probe()
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

On Thu, Aug 27, 2020 at 10:29 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> Common pattern of handling deferred probe can be simplified with
> dev_err_probe().  Less code and also it prints the error value.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/iio/magnetometer/mag3110.c | 20 ++++++--------------
>  1 file changed, 6 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/iio/magnetometer/mag3110.c b/drivers/iio/magnetometer/mag3110.c
> index 4d305a21c379..838b13c8bb3d 100644
> --- a/drivers/iio/magnetometer/mag3110.c
> +++ b/drivers/iio/magnetometer/mag3110.c
> @@ -476,22 +476,14 @@ static int mag3110_probe(struct i2c_client *client,
>         data = iio_priv(indio_dev);
>
>         data->vdd_reg = devm_regulator_get(&client->dev, "vdd");
> -       if (IS_ERR(data->vdd_reg)) {
> -               if (PTR_ERR(data->vdd_reg) == -EPROBE_DEFER)
> -                       return -EPROBE_DEFER;
> -
> -               dev_err(&client->dev, "failed to get VDD regulator!\n");
> -               return PTR_ERR(data->vdd_reg);
> -       }
> +       if (IS_ERR(data->vdd_reg))
> +               return dev_err_probe(&client->dev, PTR_ERR(data->vdd_reg),
> +                                    "failed to get VDD regulator!\n");
>
>         data->vddio_reg = devm_regulator_get(&client->dev, "vddio");
> -       if (IS_ERR(data->vddio_reg)) {
> -               if (PTR_ERR(data->vddio_reg) == -EPROBE_DEFER)
> -                       return -EPROBE_DEFER;
> -
> -               dev_err(&client->dev, "failed to get VDDIO regulator!\n");
> -               return PTR_ERR(data->vddio_reg);
> -       }
> +       if (IS_ERR(data->vddio_reg))
> +               return dev_err_probe(&client->dev, PTR_ERR(data->vddio_reg),
> +                                    "failed to get VDDIO regulator!\n");
>
>         ret = regulator_enable(data->vdd_reg);
>         if (ret) {
> --
> 2.17.1
>


-- 
With Best Regards,
Andy Shevchenko
