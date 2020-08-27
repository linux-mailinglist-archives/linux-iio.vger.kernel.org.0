Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13239254F03
	for <lists+linux-iio@lfdr.de>; Thu, 27 Aug 2020 21:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbgH0TpY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 27 Aug 2020 15:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbgH0TpX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 27 Aug 2020 15:45:23 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868F5C061264;
        Thu, 27 Aug 2020 12:45:23 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id g29so3084187pgl.2;
        Thu, 27 Aug 2020 12:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DsY79qVdnz/yUX82ew80473wZLT4P/n0zA6vYZgLAJM=;
        b=DDtkvONhdCDz2E15P3lgm4SUPfbidvJwyzD/KGMvJl5Uaj+BvEDrkhmpYeNcRP3WfK
         oeCzjEsz923anj2td9TkmoUrH3RirNTL6NWuMWq0c46s2akRNJn8ZAPOEqpgoqjBJkPm
         y6hj7W4fibWg/xEPwbt3AhH35mjnu/xsZjuu1f6kDcSjEjXYiDfNO18/BweXqDuXxcKJ
         2Hb6RvXZRgyxit2KC8hOo/3C7HM0GmVNmCuoWM8SaWTggcxr0ZBg0vKXKKitWR3u7NwR
         BJnPeBZ3LIlM/+ygoHaKIGQVEDH/Qzy8Bj5vp/TzfG5iuAwRLoq7r93AR679Eirr4Svh
         fzVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DsY79qVdnz/yUX82ew80473wZLT4P/n0zA6vYZgLAJM=;
        b=kYCb1EC0oUWhsD5qX30ZrA4H/+tV/eKg4Es0B+MCmlyHwfqMTQMHWZdRbbsjEA4RkF
         2aBNBTIwfD32VKchPIaEttuTBfToXUMj3Ytv9khl6KNSbBq+pnJ/zgpgmSZ7mPHu4Pjn
         k/DjFW7X7oIkwzMqday98PBRboZxFA7qOelHFHYUFy9zDjShXEfez8hvgrglf4A/ep5r
         NgGU1Qc5K316g3ABsUKNL2d3aC10rykAp+wEoUpnFrzT6HPE1RDOS1IhFSJ2i06Q2b0o
         Pf9VyvSjsDzlizb/aJdzqXRU932d6fEatyT0H5nmKG8U0c/+3NR2V7tfd8oZIbVAFKTx
         Ul4g==
X-Gm-Message-State: AOAM5313hCEHwGG5TRv9Z8svWJWD0sVf/0L4hogFbnr4lAgJ2amYvvrw
        MHwpemDW/xdTW0A+a+LcMCpnv5EX/ramLL/q2cM=
X-Google-Smtp-Source: ABdhPJxTPsEZ0NvbCTeS5S2AtrwEnzIQfqw3CXuZCY6zFOfEvr+qWnk8Liv0uWUJ1MAF/BZU0DBK6bdXUJnm0FufMsk=
X-Received: by 2002:a62:9215:: with SMTP id o21mr6773830pfd.268.1598557522910;
 Thu, 27 Aug 2020 12:45:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200827192642.1725-1-krzk@kernel.org> <20200827192642.1725-2-krzk@kernel.org>
In-Reply-To: <20200827192642.1725-2-krzk@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 27 Aug 2020 22:45:06 +0300
Message-ID: <CAHp75Vc5iPhe+kRRiqcLfkos0x3VnWH8E-43VsAzbYpNsDg0mw@mail.gmail.com>
Subject: Re: [PATCH v2 02/18] iio: accel: mma8452: Simplify with dev_err_probe()
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
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
        Beniamin Bia <beniamin.bia@analog.com>,
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

On Thu, Aug 27, 2020 at 10:27 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> Common pattern of handling deferred probe can be simplified with
> dev_err_probe().  Less code and also it prints the error value.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/iio/accel/mma8452.c | 20 ++++++--------------
>  1 file changed, 6 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index 4e6e70250048..104b87b98455 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -1538,22 +1538,14 @@ static int mma8452_probe(struct i2c_client *client,
>         data->chip_info = match->data;
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
