Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75355382549
	for <lists+linux-iio@lfdr.de>; Mon, 17 May 2021 09:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbhEQH1x (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 17 May 2021 03:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbhEQH1w (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 May 2021 03:27:52 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB49C061573
        for <linux-iio@vger.kernel.org>; Mon, 17 May 2021 00:26:34 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id 66so2610750vsk.9
        for <linux-iio@vger.kernel.org>; Mon, 17 May 2021 00:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/PTI2FZtDYEzJXLhu3TanBqKUmJsL8910C5RrJh+7xY=;
        b=lfhVPys1Fj/Tk948B3sBWRmhqoO+iB4rCb01U5KHtlO61MVKXlcru+elqPOOSnRB9p
         Bjah7mabC7gvu4+0IySDhx2j1wKKPn/qjl4rSQbz8KQVdZ6CVQqGjVsiL+Mx60FHSREo
         pmmf3MGjrhwfGXP1aSd2JfXTTD2t7a45CXjy09D3pYU9RRpl3UoAlPssVhu6j72s75VT
         aNUYpvRtYHS2OFRnVjJNFk5bBkri+7JYS1VcG1jy8+ydoWIpYV0YRYaKE0rECXe8clBD
         t8UW0ZFvcc+L8iYtKIbItHX/grC1U/wlPa4UKSI+9hg2zo7HxwhL9uRwcrkaPdYFuT1C
         DThg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/PTI2FZtDYEzJXLhu3TanBqKUmJsL8910C5RrJh+7xY=;
        b=KLtlfHCZ9UPcjltUjv3vvOXvEOi1KDwiQS22BQ9yMjI7fLRl1dD67TLXp3eufaW1Nh
         Gw48GnM1Og/RLKRCEf7wSESuGCzY9UiFDrbfHnWB7TvASj1wgi+B4ir0xVYno4fFX3MS
         gfMH9vp35X32Vl8IcFupO0yYyt1Vp632e8liFb9SBw6v42MhpOjXzT8HxWNPd4AtMq+s
         wR2TYhhqNQwncKTk4Aa9D+NvOiK4Wmrb9YSb6Np/d/YnQsbWdtH+EurrmjFhPL8Gs2II
         5HvNWLRyQxptq5LHCcDLp7SoEVuCz963qmX6n5vHseBh9UfOB01nK/RCo9a4OdqbVfCY
         UJdA==
X-Gm-Message-State: AOAM533d0sytIdaVmC2mlnLwZVsUv7aDi8DDTY0krUAg2fejYWcszVGo
        vaQ6t0nYyXyrK9Wz/B2kjzWKiWUEeU/J/VmZXoGkig==
X-Google-Smtp-Source: ABdhPJw5LqeO5oFRP3jv5PC7tpBykORW+g0TskSdQi5mcgD4i0M5/X0H8ZJwZ/YjJAMN+YSHVRgQ+DeA1ALYDSZewg0=
X-Received: by 2002:a05:6102:30ad:: with SMTP id y13mr49913624vsd.19.1621236393593;
 Mon, 17 May 2021 00:26:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210516172520.1398835-1-jic23@kernel.org> <20210516172520.1398835-6-jic23@kernel.org>
In-Reply-To: <20210516172520.1398835-6-jic23@kernel.org>
From:   Alexandru Ardelean <aardelean@deviqon.com>
Date:   Mon, 17 May 2021 10:26:22 +0300
Message-ID: <CAASAkoY7w1rvELfjUS710=tM=XWFNnE3dQfWrbE+JBAWTNrXLg@mail.gmail.com>
Subject: Re: [PATCH 5/8] iio: adc: ti-adc081c: Use devm managed functions for
 all of probe()
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 16 May 2021 at 20:26, Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Simplifies error handling and allows us to drop remove() entirely.
>

Reviewed-by: Alexandru Ardelean <aardelean@deviqon.com>

> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/iio/adc/ti-adc081c.c | 43 ++++++++++++------------------------
>  1 file changed, 14 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/iio/adc/ti-adc081c.c b/drivers/iio/adc/ti-adc081c.c
> index b64718daa201..16fc608db36a 100644
> --- a/drivers/iio/adc/ti-adc081c.c
> +++ b/drivers/iio/adc/ti-adc081c.c
> @@ -146,6 +146,11 @@ static irqreturn_t adc081c_trigger_handler(int irq, void *p)
>         return IRQ_HANDLED;
>  }
>
> +static void adc081c_reg_disable(void *reg)
> +{
> +       regulator_disable(reg);
> +}
> +
>  static int adc081c_probe(struct i2c_client *client,
>                          const struct i2c_device_id *id)
>  {
> @@ -175,6 +180,11 @@ static int adc081c_probe(struct i2c_client *client,
>         if (err < 0)
>                 return err;
>
> +       err = devm_add_action_or_reset(&client->dev, adc081c_reg_disable,
> +                                      adc->ref);
> +       if (err)
> +               return err;
> +
>         iio->name = dev_name(&client->dev);
>         iio->modes = INDIO_DIRECT_MODE;
>         iio->info = &adc081c_info;
> @@ -182,38 +192,14 @@ static int adc081c_probe(struct i2c_client *client,
>         iio->channels = model->channels;
>         iio->num_channels = ADC081C_NUM_CHANNELS;
>
> -       err = iio_triggered_buffer_setup(iio, NULL, adc081c_trigger_handler, NULL);
> +       err = devm_iio_triggered_buffer_setup(&client->dev, iio, NULL,
> +                                             adc081c_trigger_handler, NULL);
>         if (err < 0) {
>                 dev_err(&client->dev, "iio triggered buffer setup failed\n");
> -               goto err_regulator_disable;
> +               return err;
>         }
>
> -       err = iio_device_register(iio);
> -       if (err < 0)
> -               goto err_buffer_cleanup;
> -
> -       i2c_set_clientdata(client, iio);
> -
> -       return 0;
> -
> -err_buffer_cleanup:
> -       iio_triggered_buffer_cleanup(iio);
> -err_regulator_disable:
> -       regulator_disable(adc->ref);
> -
> -       return err;
> -}
> -
> -static int adc081c_remove(struct i2c_client *client)
> -{
> -       struct iio_dev *iio = i2c_get_clientdata(client);
> -       struct adc081c *adc = iio_priv(iio);
> -
> -       iio_device_unregister(iio);
> -       iio_triggered_buffer_cleanup(iio);
> -       regulator_disable(adc->ref);
> -
> -       return 0;
> +       return devm_iio_device_register(&client->dev, iio);
>  }
>
>  static const struct i2c_device_id adc081c_id[] = {
> @@ -238,7 +224,6 @@ static struct i2c_driver adc081c_driver = {
>                 .of_match_table = adc081c_of_match,
>         },
>         .probe = adc081c_probe,
> -       .remove = adc081c_remove,
>         .id_table = adc081c_id,
>  };
>  module_i2c_driver(adc081c_driver);
> --
> 2.31.1
>
