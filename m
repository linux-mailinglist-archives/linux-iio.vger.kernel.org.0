Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D36A4343D48
	for <lists+linux-iio@lfdr.de>; Mon, 22 Mar 2021 10:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbhCVJya (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 22 Mar 2021 05:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbhCVJyM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 22 Mar 2021 05:54:12 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8204CC061574
        for <linux-iio@vger.kernel.org>; Mon, 22 Mar 2021 02:54:11 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id z136so13216663iof.10
        for <linux-iio@vger.kernel.org>; Mon, 22 Mar 2021 02:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l1adJFBoPVG8fqBuKNB0IlihiIsx7yMHi9VZJd5Jrik=;
        b=X7PnkWoc0t0E/Gb3zSJ9vLUhFvj9gFWxaPB4htu3XzDWc5dPaJhV+fFv9RqvOgl1tM
         NzpN25D4MfrJNxXHhI3J7N4Pda3s8RfLUX59V1BnPhfq8YzRz2B9T8nRfTevXhhvaT1Y
         PxlaILCtuThOxw8xoG7NGJ/wXSdad3GMP3m0P8YXJ5srb3guJXJtw+Q1Q+5hblu8OgeW
         84zmKzDBYSQuSgVjTnI3M2Ykkzqd6+rd9S1Z5EKBeiN5OnELRigBlEFkHGfyUQS3vz4o
         Mmy3a2hCvvupwRfnmcEXXBVNAO2IlYxCZ0FzflqpvSG+dNbNUvO/kOudj1gX0fA1alyi
         zvTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l1adJFBoPVG8fqBuKNB0IlihiIsx7yMHi9VZJd5Jrik=;
        b=HpHf9TcLiJuRpAGidXq9JCd67piawxKiZiB0wtzN43XOPE1g9GomuK6m2H1QpJSNm/
         MsGosehx4K8R//NA6C9+Y2R8ZhIU455iylstjkyQkqqqLgm2V1TsLa9hSG9byL3gPzYE
         eoYFBO+c3Hz3yyFlMBgmE0ZA+9GdyfFojah3evaZhhamr4wGruNwuWYv3eBzXoguDRGP
         ROvrObBFL+FCfkqOJSZpGZ/f186gRkq6fZcOfwLjvSYV8assRiw2TaHY5OsKmiNBnoN7
         /K6hm6+kq8PgE8Tzq0R/kCbq3wDoNttqOmMWhA9DSAfbVli20noxSGRFZaMYpNSs5Cal
         T5Dw==
X-Gm-Message-State: AOAM531Majr8wOtd7uPnYuI4lVbic6ifKsq9c7gGPZD0p9zZi2BW07O9
        z03BSKTL8mI92JfrS4Z4MQkxnJf8js8cdYsRl60=
X-Google-Smtp-Source: ABdhPJy4UbcnUle+uR1z62N/SvX+tZ/h55paoDG5h7m6pRYIVuU7hZeqTKmjpZUlqIlgppZ2ceUrOr39NbMxRDJCBYM=
X-Received: by 2002:a6b:103:: with SMTP id 3mr10414579iob.98.1616406850935;
 Mon, 22 Mar 2021 02:54:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210322073220.1637117-1-gwendal@chromium.org> <20210322073220.1637117-3-gwendal@chromium.org>
In-Reply-To: <20210322073220.1637117-3-gwendal@chromium.org>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Mon, 22 Mar 2021 11:53:59 +0200
Message-ID: <CA+U=DsqvwOMxXt_05WnmBDccJ4S=rMoNajM8Dr3u58uek4jE4w@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] iio: sx9310: Support ACPI properties
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, swboyd@chromium.org,
        campello@chromium.org, Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Mar 22, 2021 at 9:33 AM Gwendal Grignou <gwendal@chromium.org> wrote:
>
> Use device_property_read_uXX to support both device tree and ACPI
> bindings when reading the properties we need to configure the SAR
> sensor.
>
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
>  Changes in v6:
>  Use proper function to gather the number of elements in an array.
>
>  Changes in v5:
>  Split in 2 patches, one for fixing access to propery array, the other
>  to support ACPI.
>
>  drivers/iio/proximity/sx9310.c | 26 +++++++++++---------------
>  1 file changed, 11 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
> index 289c76bb3b024..3817a5714aab3 100644
> --- a/drivers/iio/proximity/sx9310.c
> +++ b/drivers/iio/proximity/sx9310.c
> @@ -20,6 +20,7 @@
>  #include <linux/mod_devicetable.h>
>  #include <linux/module.h>
>  #include <linux/pm.h>
> +#include <linux/property.h>
>  #include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/slab.h>
> @@ -1213,10 +1214,9 @@ static int sx9310_init_compensation(struct iio_dev *indio_dev)
>  }
>
>  static const struct sx9310_reg_default *
> -sx9310_get_default_reg(struct sx9310_data *data, int idx,
> +sx9310_get_default_reg(struct device *dev, int idx,
>                        struct sx9310_reg_default *reg_def)
>  {
> -       const struct device_node *np = data->client->dev.of_node;

There may be an issue with this.
'np' was coming from the parent device (which is an i2c device)

So, 'data->client->dev' should be the same pointer as 'indio_dev->dev.parent'

Now, it's a reference to 'indio_dev->dev', so it's probably going to
miss a lot of DT properties.
Maybe an alternative would be to do:

const struct device *dev = &data->client->dev;   [1]

Or instead of pass '&data->client->dev' or 'indio_dev->dev.parent'
when calling sx9310_get_default_reg()

Though [1] looks good to me as well.

>         u32 combined[SX9310_NUM_CHANNELS];
>         u32 start = 0, raw = 0, pos = 0;
>         unsigned long comb_mask = 0;
> @@ -1224,21 +1224,17 @@ sx9310_get_default_reg(struct sx9310_data *data, int idx,
>         const char *res;
>
>         memcpy(reg_def, &sx9310_default_regs[idx], sizeof(*reg_def));
> -       if (!np)
> -               return reg_def;
> -
>         switch (reg_def->reg) {
>         case SX9310_REG_PROX_CTRL2:
> -               if (of_property_read_bool(np, "semtech,cs0-ground")) {
> +               if (device_property_read_bool(dev, "semtech,cs0-ground")) {
>                         reg_def->def &= ~SX9310_REG_PROX_CTRL2_SHIELDEN_MASK;
>                         reg_def->def |= SX9310_REG_PROX_CTRL2_SHIELDEN_GROUND;
>                 }
>
> -               count = of_property_count_elems_of_size(np, "semtech,combined-sensors",
> -                                                       sizeof(u32));
> +               count = device_property_count_u32(dev, "semtech,combined-sensors");
>                 if (count > 0 && count <= ARRAY_SIZE(combined)) {
> -                       ret = of_property_read_u32_array(np, "semtech,combined-sensors",
> -                                                        combined, count);
> +                       ret = device_property_read_u32_array(dev, "semtech,combined-sensors",
> +                                                            combined, count);
>                         if (ret)
>                                 break;
>                 } else {
> @@ -1270,7 +1266,7 @@ sx9310_get_default_reg(struct sx9310_data *data, int idx,
>
>                 break;
>         case SX9310_REG_PROX_CTRL4:
> -               ret = of_property_read_string(np, "semtech,resolution", &res);
> +               ret = device_property_read_string(dev, "semtech,resolution", &res);
>                 if (ret)
>                         break;
>
> @@ -1294,7 +1290,7 @@ sx9310_get_default_reg(struct sx9310_data *data, int idx,
>
>                 break;
>         case SX9310_REG_PROX_CTRL5:
> -               ret = of_property_read_u32(np, "semtech,startup-sensor", &start);
> +               ret = device_property_read_u32(dev, "semtech,startup-sensor", &start);
>                 if (ret) {
>                         start = FIELD_GET(SX9310_REG_PROX_CTRL5_STARTUPSENS_MASK,
>                                           reg_def->def);
> @@ -1304,7 +1300,7 @@ sx9310_get_default_reg(struct sx9310_data *data, int idx,
>                 reg_def->def |= FIELD_PREP(SX9310_REG_PROX_CTRL5_STARTUPSENS_MASK,
>                                            start);
>
> -               ret = of_property_read_u32(np, "semtech,proxraw-strength", &raw);
> +               ret = device_property_read_u32(dev, "semtech,proxraw-strength", &raw);
>                 if (ret) {
>                         raw = FIELD_GET(SX9310_REG_PROX_CTRL5_RAWFILT_MASK,
>                                         reg_def->def);
> @@ -1317,7 +1313,7 @@ sx9310_get_default_reg(struct sx9310_data *data, int idx,
>                                            raw);
>                 break;
>         case SX9310_REG_PROX_CTRL7:
> -               ret = of_property_read_u32(np, "semtech,avg-pos-strength", &pos);
> +               ret = device_property_read_u32(dev, "semtech,avg-pos-strength", &pos);
>                 if (ret)
>                         break;
>
> @@ -1353,7 +1349,7 @@ static int sx9310_init_device(struct iio_dev *indio_dev)
>
>         /* Program some sane defaults. */
>         for (i = 0; i < ARRAY_SIZE(sx9310_default_regs); i++) {
> -               initval = sx9310_get_default_reg(data, i, &tmp);
> +               initval = sx9310_get_default_reg(&indio_dev->dev, i, &tmp);
>                 ret = regmap_write(data->regmap, initval->reg, initval->def);
>                 if (ret)
>                         return ret;
> --
> 2.31.0.291.g576ba9dcdaf-goog
>
