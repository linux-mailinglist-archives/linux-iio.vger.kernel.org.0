Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E31C8254F45
	for <lists+linux-iio@lfdr.de>; Thu, 27 Aug 2020 21:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgH0TtN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 27 Aug 2020 15:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbgH0TtN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 27 Aug 2020 15:49:13 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E04A0C061264;
        Thu, 27 Aug 2020 12:49:12 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id 31so4090381pgy.13;
        Thu, 27 Aug 2020 12:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WpaQTjLfV7KuSsjB4F9wP9EPb6gXE6IBxqNf6Q1HCtA=;
        b=vMMPvCokJT5yJ29bs2poZN7/8ToLpy92ObHhrh0C8jSwKA6UlkjHuqmgZcPeY7DxzO
         I527Vpj4YlMmK+NwDxWuWuL2jzRXPBfa1GXkjw5WtJTqO3EOEUYOhy/0ieitpsqXWGxQ
         /OYxu49IXfLq1+YzrROvYpT3LyQzO3XZzftFohTTVRQGc6KisIh1PUDSBLIKKWtvbOxf
         MaNH6qP0GQGJEj0Fmt5z/vqAPulC6fszq4aXwBZ3hhpUOFytvHzuwkz0so+SpYkCl5RG
         t2h2mlFXF8+cdNBkM6DJn1VX2mejLI86PVuKsijPZt8fimCyC25oU78Xmoy+qQlrJbAE
         Ec2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WpaQTjLfV7KuSsjB4F9wP9EPb6gXE6IBxqNf6Q1HCtA=;
        b=qPKWmfiaBdTwVXy4OM4ap0ZSBXeMyLT4Qvcx5L3hKvFnyqo3P+vPK9Lz7Qo/2JGfdD
         Dl3USRWN9AOFtABFAPxMk1a8emQ6QTbmdg8n7PQOsKTJ+PRGt2rXgGGRtEow6UACNmpe
         PQwViJnouk9vJLQ8PIPMEuPiBIcr8efLq/w2q8qoOTs2MQSfHQaBfhdsWVSsBWHNpntm
         ZJWz4AbCTWoWnN814FjfOJ0LNVZtC+KlwsPCj5QPkcGutekyBHS/PQUUQOxrUsva3hPg
         iJwA1zuDtrvXQYhwusmjhKAqQrOcRplmqaAm5xvr3UPAASbCDCjp7xa0lxMiOLtt0fDM
         dDwQ==
X-Gm-Message-State: AOAM533OtP+btKDHlyokG5ubLI9fkvvrX3Ah6HKHJw9tfbTJDQPTF8D3
        Er+AehOzhrpobuPydWcaz2Xxt8UORGSJyUpmSXE=
X-Google-Smtp-Source: ABdhPJz1ZTuLx8D3lXV7Ue7cNy2v+gh/dlv/Okbh2nb8veYRd//0muFAck8Ma4Jv7DzINNSNTJ3Y0FOdg3nrFU2hNjs=
X-Received: by 2002:a62:2587:: with SMTP id l129mr18131209pfl.47.1598557752461;
 Thu, 27 Aug 2020 12:49:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200827192642.1725-1-krzk@kernel.org> <20200827192642.1725-6-krzk@kernel.org>
In-Reply-To: <20200827192642.1725-6-krzk@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 27 Aug 2020 22:48:56 +0300
Message-ID: <CAHp75Vd8ttMmOx28V3wXv5pY1fbru8aUV=fTBoJyZJ=CQRo7hw@mail.gmail.com>
Subject: Re: [PATCH v2 06/18] iio: adc: meson_saradc: Simplify with dev_err_probe()
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

On Thu, Aug 27, 2020 at 10:28 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> Common pattern of handling deferred probe can be simplified with
> dev_err_probe().  Less code and also it prints the error value.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/iio/adc/meson_saradc.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
> index 93c2252c0b89..a9d06e8a576a 100644
> --- a/drivers/iio/adc/meson_saradc.c
> +++ b/drivers/iio/adc/meson_saradc.c
> @@ -719,11 +719,8 @@ static int meson_sar_adc_temp_sensor_init(struct iio_dev *indio_dev)
>                 if (ret == -ENODEV)
>                         return 0;
>
> -               if (ret != -EPROBE_DEFER)
> -                       dev_err(indio_dev->dev.parent,
> -                               "failed to get temperature_calib cell\n");
> -
> -               return ret;
> +               return dev_err_probe(indio_dev->dev.parent, ret,
> +                                    "failed to get temperature_calib cell\n");
>         }
>
>         priv->tsc_regmap =
> --
> 2.17.1
>


-- 
With Best Regards,
Andy Shevchenko
