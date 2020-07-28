Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C540E231187
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jul 2020 20:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728979AbgG1SVX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Jul 2020 14:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728886AbgG1SVW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jul 2020 14:21:22 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE71BC061794;
        Tue, 28 Jul 2020 11:21:22 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id l2so5080076pff.0;
        Tue, 28 Jul 2020 11:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xBNFTWpWvbuyYttTx5FJzXMGIoQ5ioCfp2lUjYaRrnY=;
        b=r8M0BeTAbK7MU3O/JzGv8BetoHJjwe74GKR5eBzjwBtUixkGTnzPJulv8DoiD3z0M+
         4cbsGiwrbXTjReT++CKT9dpb5yZnxX0AkMu1zaE1p3vGgvEn343GDrS/fihDAwDJ4QXT
         as/vsiHkN5wpWaT6Q0vUOyRJfRJDdcXK17MaP/ZMiCz5hsSaQoym6+VDNdzX4Z8zjYVn
         pC1ccgdRQmFQUQURw/RXsWVKj+ZT2UGziMEGMvWDR4z60RX6TOzL7+VkkyHSjDHnmE1p
         fpNScszPS06stwU7LOSXR3yjYeLYCBNtWwQcsPQnqBixwGj/ftP4l8W50Z9syEEluI6B
         40Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xBNFTWpWvbuyYttTx5FJzXMGIoQ5ioCfp2lUjYaRrnY=;
        b=WrWKpAJfUGAyUM+QTmBRKbf3jQX16tAp7IO8z60ez70Gf0CpXznFAO9aZUnXtnnTsV
         MlerEa+wEZSTEujcHhN8MgwnAaSWRnTII6HQyMzT2XDj8x43uhXDiA2ktT4ouJ5Xd3Hv
         76R969R5gSQYbCrEkzeHn1C4O4bDBdLTpoKqflTj6KM8llU+iZI+xUWvF+9yFKxYpQVt
         cL3kZtOfpwbonBqmS/SgiKg/XrTMDLFTL+86YsF7A0FzIRvvxX6rHJxAbgf1f5VY6Ofv
         6n+ggjp/wpMEbHJXhj4572D3Hv+boR/g28ol3WHVbwCwjI+sL64lB4QSwaPMdELGaeo/
         wSgQ==
X-Gm-Message-State: AOAM530sx9lNTzKliha+8C9zmOXj5Yop5HyrKmzjHchtTOJrwuQP6n4t
        OU1L/25TPlOaolKI4nJIvmM8SVzroSJXPOBhjoY=
X-Google-Smtp-Source: ABdhPJyzjIBZqt/Egn+xHr1LfK5t+AM9WogDpOm8Biuj3PSoqJG9tJ651RR9hyabsZIN4dcRn9ruYcpxyCiNQ5F2ewc=
X-Received: by 2002:a63:a05f:: with SMTP id u31mr25056868pgn.4.1595960482322;
 Tue, 28 Jul 2020 11:21:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200724183954.1.I2e29ae25368ba8a72a9e44121cfbc36ead8ecc6b@changeid>
 <20200728151258.1222876-1-campello@chromium.org> <20200728091057.15.Iaf4d717d1908ef22c88922b556e1eb803ae019c6@changeid>
In-Reply-To: <20200728091057.15.Iaf4d717d1908ef22c88922b556e1eb803ae019c6@changeid>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 28 Jul 2020 21:21:05 +0300
Message-ID: <CAHp75Veo8UWSe_FtpF-gVgTd85vL0E2+61HHc1vKvyeVekd0ng@mail.gmail.com>
Subject: Re: [PATCH 15/15] iio: sx9310: Enable vdd and svdd regulators at probe
To:     Daniel Campello <campello@chromium.org>
Cc:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Enrico Granata <egranata@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jul 28, 2020 at 6:14 PM Daniel Campello <campello@chromium.org> wrote:
>
> From: Stephen Boyd <swboyd@chromium.org>
>
> Enable the main power supply (vdd) and digital IO power supply (svdd)
> during probe so that the i2c communication and device works properly on
> boards that aggressively power gate these supplies.
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Daniel Campello <campello@chromium.org>

Again wrong order.
After fixing,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> ---
>
>  drivers/iio/proximity/sx9310.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
> index 202018b726e32f..24a2360b6314ef 100644
> --- a/drivers/iio/proximity/sx9310.c
> +++ b/drivers/iio/proximity/sx9310.c
> @@ -18,6 +18,7 @@
>  #include <linux/module.h>
>  #include <linux/pm.h>
>  #include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
>  #include <linux/slab.h>
>
>  #include <linux/iio/buffer.h>
> @@ -118,6 +119,7 @@ struct sx9310_data {
>         struct i2c_client *client;
>         struct iio_trigger *trig;
>         struct regmap *regmap;
> +       struct regulator_bulk_data supplies[2];
>         /*
>          * Last reading of the proximity status for each channel.
>          * We only send an event to user space when this changes.
> @@ -873,6 +875,13 @@ static int sx9310_set_indio_dev_name(struct device *dev,
>         return 0;
>  }
>
> +static void sx9310_regulator_disable(void *_data)
> +{
> +       struct sx9310_data *data = _data;
> +
> +       regulator_bulk_disable(ARRAY_SIZE(data->supplies), data->supplies);
> +}
> +
>  static int sx9310_probe(struct i2c_client *client)
>  {
>         int ret;
> @@ -886,6 +895,8 @@ static int sx9310_probe(struct i2c_client *client)
>
>         data = iio_priv(indio_dev);
>         data->client = client;
> +       data->supplies[0].supply = "vdd";
> +       data->supplies[1].supply = "svdd";
>         mutex_init(&data->mutex);
>         init_completion(&data->completion);
>
> @@ -893,6 +904,21 @@ static int sx9310_probe(struct i2c_client *client)
>         if (IS_ERR(data->regmap))
>                 return PTR_ERR(data->regmap);
>
> +       ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(data->supplies),
> +                                     data->supplies);
> +       if (ret)
> +               return ret;
> +
> +       ret = regulator_bulk_enable(ARRAY_SIZE(data->supplies), data->supplies);
> +       if (ret)
> +               return ret;
> +       /* Must wait for Tpor time after initial power up */
> +       usleep_range(1000, 1100);
> +
> +       ret = devm_add_action_or_reset(dev, sx9310_regulator_disable, data);
> +       if (ret)
> +               return ret;
> +
>         ret = regmap_read(data->regmap, SX9310_REG_WHOAMI, &data->whoami);
>         if (ret) {
>                 dev_err(dev, "error in reading WHOAMI register: %d\n", ret);
> --
> 2.28.0.rc0.142.g3c755180ce-goog
>


-- 
With Best Regards,
Andy Shevchenko
