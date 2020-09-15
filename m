Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 065A326ACA3
	for <lists+linux-iio@lfdr.de>; Tue, 15 Sep 2020 20:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbgIOSzI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Sep 2020 14:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727431AbgIOSyb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Sep 2020 14:54:31 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F4AC06174A
        for <linux-iio@vger.kernel.org>; Tue, 15 Sep 2020 11:54:30 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id y9so4057716ilq.2
        for <linux-iio@vger.kernel.org>; Tue, 15 Sep 2020 11:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dM36Che5BQ/8OCHIPz3RRxPnvV8GhiglI9m7no8WJ10=;
        b=tWiTsm9vek2LSRfCg7+Ibt+TwS0YzJYp0nfeerXgtxNiB/CJbFvJV4KeQhVc6lbYlc
         VCkUe0cHkcqzoQGyfr/e0KZACU5c59KOEzHJ/gO3GL4h5C0JfsTG/QtcaQLD5DxsGDV8
         O6mDlrXa1Z/BcClHX8RmGC3tAINlNvjq6LRzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dM36Che5BQ/8OCHIPz3RRxPnvV8GhiglI9m7no8WJ10=;
        b=EYGdYD57hhiWn6dwAu4zab1WPUzjO6EGJVly/A7Q15AOEOi5adCQFADAHVEn5i4eUu
         h0exQvcl2xw8p629MqvZ/I4nzS1AMrcunvk0hJc5NTQnskxHu2G53Cb1i3xrnGNzkuSF
         IkR2wo0CKnvnKa8JfDTpuQfNV0UqK6DqlKNvTTdnhf7KyI3EiDZQN9PqgLf+wuCBpVno
         vrzPTQT/JqS6J+CMs4bMnU8v/nTYZUhVaqjGmoobmEI4qSZx9/dkjUkXGC98AWJM+/UM
         vIoXFBDVSfc82BDalcgt5U/HqqkDpcKEWPLsZVe567koLiQ0LIhDzw4764vul8bE7ZAf
         gNZA==
X-Gm-Message-State: AOAM5331+iXQzLlXQjs7es6UqkFId6RVKsfSFK2NiY5InHhjMkpKej+K
        O+7Z0LLpmGZ4w7qRCoU5OyncmBky/LFs6HUAg7gRRA==
X-Google-Smtp-Source: ABdhPJwQL4RqWa/iDvWG82dauyA3e/pbc+CyM5tOcjggDP/ODXgSf5ItDu1LbKwxq8b+0dRiiYkdKHccjZJNDjUE4UM=
X-Received: by 2002:a92:d18c:: with SMTP id z12mr6968717ilz.142.1600196070036;
 Tue, 15 Sep 2020 11:54:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200910173242.621168-1-jic23@kernel.org> <20200910173242.621168-39-jic23@kernel.org>
In-Reply-To: <20200910173242.621168-39-jic23@kernel.org>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Tue, 15 Sep 2020 11:54:19 -0700
Message-ID: <CAJCx=gme_HbQeCu7x1_9Oi=hos_nptoBy3BseVHEsX-DC+PLdg@mail.gmail.com>
Subject: Re: [PATCH 38/38] iio:health:max30102: Drop of_match_ptr and use
 generic fw accessors
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Sep 10, 2020 at 10:36 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> This enables use of the driver with ACPI PRP0001 and also removes
> an antipattern that I am trying to clear out of IIO to avoid
> it being coppied into new drivers.

Typo, should be copied.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Matt Ranostay <matt.ranostay@konsulko.com>

Acked-by: Matt Ranostay <matt.ranostay@konsulko.com>

> ---
>  drivers/iio/health/max30102.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/iio/health/max30102.c b/drivers/iio/health/max30102.c
> index bb504e993f19..543021d8df34 100644
> --- a/drivers/iio/health/max30102.c
> +++ b/drivers/iio/health/max30102.c
> @@ -19,7 +19,7 @@
>  #include <linux/irq.h>
>  #include <linux/i2c.h>
>  #include <linux/mutex.h>
> -#include <linux/of.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/regmap.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/buffer.h>
> @@ -323,11 +323,10 @@ static int max30102_get_current_idx(unsigned int val, int *reg)
>  static int max30102_led_init(struct max30102_data *data)
>  {
>         struct device *dev = &data->client->dev;
> -       struct device_node *np = dev->of_node;
>         unsigned int val;
>         int reg, ret;
>
> -       ret = of_property_read_u32(np, "maxim,red-led-current-microamp", &val);
> +       ret = device_property_read_u32(dev, "maxim,red-led-current-microamp", &val);
>         if (ret) {
>                 dev_info(dev, "no red-led-current-microamp set\n");
>
> @@ -346,7 +345,7 @@ static int max30102_led_init(struct max30102_data *data)
>                 return ret;
>
>         if (data->chip_id == max30105) {
> -               ret = of_property_read_u32(np,
> +               ret = device_property_read_u32(dev,
>                         "maxim,green-led-current-microamp", &val);
>                 if (ret) {
>                         dev_info(dev, "no green-led-current-microamp set\n");
> @@ -368,7 +367,7 @@ static int max30102_led_init(struct max30102_data *data)
>                         return ret;
>         }
>
> -       ret = of_property_read_u32(np, "maxim,ir-led-current-microamp", &val);
> +       ret = device_property_read_u32(dev, "maxim,ir-led-current-microamp", &val);
>         if (ret) {
>                 dev_info(dev, "no ir-led-current-microamp set\n");
>
> @@ -624,7 +623,7 @@ MODULE_DEVICE_TABLE(of, max30102_dt_ids);
>  static struct i2c_driver max30102_driver = {
>         .driver = {
>                 .name   = MAX30102_DRV_NAME,
> -               .of_match_table = of_match_ptr(max30102_dt_ids),
> +               .of_match_table = max30102_dt_ids,
>         },
>         .probe          = max30102_probe,
>         .remove         = max30102_remove,
> --
> 2.28.0
>
