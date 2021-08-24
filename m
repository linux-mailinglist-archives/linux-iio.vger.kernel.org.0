Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29E3D3F5E22
	for <lists+linux-iio@lfdr.de>; Tue, 24 Aug 2021 14:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237347AbhHXMlm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 24 Aug 2021 08:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237290AbhHXMlm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 24 Aug 2021 08:41:42 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8F4C061757
        for <linux-iio@vger.kernel.org>; Tue, 24 Aug 2021 05:40:58 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id c4so12145538plh.7
        for <linux-iio@vger.kernel.org>; Tue, 24 Aug 2021 05:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=opizYsAqNI8XMNMRD7ViV3ypH44/aP9bZ4J3Nwvz0uc=;
        b=VFCZRNf+Sd5m/NWgHu1lBcH/BHf+58S1vqCNg2zrZmYYhdTBfVWbAXaZJX5KzPhYdZ
         UntlMMUdkWPJaqBNtV6emg+ARV+CgmBnGAo63LVIN4GBW1EWbcv9S0ZVHUTKSZr+HAvc
         XCYRVwuJWi23/rRqo80OPpG4866CY/dtOIucm3uOB2H1lcdiSdq+u1Po66ShL07jxKSU
         MnuxpkrvYSzzjfSc2LS2ZU7tJoZwKR2RFZjnb5QDXvkTdfO9XmNn4VjhfOxAKczpe0I7
         puGXwTNoUpjvSYFc2Jf6bYrKhkTE3AMLj3Upg+sfR3WIjGkZtzWy0ky5ilglXft0Xh5e
         K5EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=opizYsAqNI8XMNMRD7ViV3ypH44/aP9bZ4J3Nwvz0uc=;
        b=GWIFIp50sKfFCnNUZDUwYT2zx8/IrlCWBMBmTiq6EMNi9tvmIu93m8n1eWOKDEjWgG
         WtjeIl0v+OlET+8xGKFmIFPZwAzz3D4lNX8yEpKbbaFGX6NX9X+7cw2tj2joBD+AurGT
         EPecv8xgdR1Xlu68FutGVN1ctuUkrabhybUHi1vXxMyfU/877edJRt5P3STXEVoOfkdy
         fP9+WbnoF0k/qs4xLTBu1x7LOZsx93+/Ipqkg9jihsiRb6bWe9icCD+dZCZjHYaMHJMN
         2msSrBl+XPBPts/ronjx5bME5xfJ1yD44TLMq7j3hJNRjCYLu+3M8c96zH0O5CsyqDV8
         E7bQ==
X-Gm-Message-State: AOAM531AQXxwRyFB8Lw+7JPRGIitrIk/v848c10oVIKfEGQsD4CW7LbY
        6uj5YKlaeUh0gRyR7zLm1TA5A/+QEYAaDD2Ijfw=
X-Google-Smtp-Source: ABdhPJzvWxoKxDKF+JagsL8+wQ2SvUx9zr8LG8CLTt8BdE9r/mJ4KMqIOF9HxyWeBjA8d4rQZEDlN/aeTsB/dYPlZ/Y=
X-Received: by 2002:a17:902:ced0:b029:12d:4ce1:ce3a with SMTP id
 d16-20020a170902ced0b029012d4ce1ce3amr32983916plg.0.1629808857704; Tue, 24
 Aug 2021 05:40:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210824113709.1834195-1-sean@geanix.com> <20210824113709.1834195-2-sean@geanix.com>
In-Reply-To: <20210824113709.1834195-2-sean@geanix.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 24 Aug 2021 15:40:18 +0300
Message-ID: <CAHp75VdzUuMogq7u5hd2ajw+rzEtaWuybrTkQ2ykossy1T2iUg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] iio: accel: fxls8962af: add wake on event
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Aug 24, 2021 at 2:39 PM Sean Nyekjaer <sean@geanix.com> wrote:
>
> This adds ways for the SoC to wake from accelerometer wake events.
>
> In the suspend function we skip disabling the sensor if wakeup-source
> and events are activated.
>
> If buffered reads are enabled they will be deactivated before suspend.
> As the onboard buffer is only holding up to 32 12-bit X/Y/Z data
> triplets.

Assuming it works, the code looks good to me
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

One niy-pick below, though.

> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---
> Changes since v1:
>  - Fixed comments fron Andy (Thanks)
>
>  drivers/iio/accel/fxls8962af-core.c | 47 +++++++++++++++++++++++++++--
>  1 file changed, 45 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
> index fd35f8685e62..ecd138f595d4 100644
> --- a/drivers/iio/accel/fxls8962af-core.c
> +++ b/drivers/iio/accel/fxls8962af-core.c
> @@ -160,6 +160,7 @@ struct fxls8962af_data {
>         } scan;
>         int64_t timestamp, old_timestamp;       /* Only used in hw fifo mode. */
>         struct iio_mount_matrix orientation;
> +       int irq;
>         u8 watermark;
>         u8 enable_event;
>         u16 lower_thres;
> @@ -1121,6 +1122,7 @@ int fxls8962af_core_probe(struct device *dev, struct regmap *regmap, int irq)
>         data = iio_priv(indio_dev);
>         dev_set_drvdata(dev, indio_dev);
>         data->regmap = regmap;
> +       data->irq = irq;
>
>         ret = iio_read_mount_matrix(dev, &data->orientation);
>         if (ret)
> @@ -1190,6 +1192,9 @@ int fxls8962af_core_probe(struct device *dev, struct regmap *regmap, int irq)
>         if (ret)
>                 return ret;
>
> +       if (device_property_read_bool(dev, "wakeup-source"))
> +               device_init_wakeup(dev, true);
> +
>         return devm_iio_device_register(dev, indio_dev);
>  }
>  EXPORT_SYMBOL_GPL(fxls8962af_core_probe);
> @@ -1215,9 +1220,47 @@ static int __maybe_unused fxls8962af_runtime_resume(struct device *dev)
>         return fxls8962af_active(data);
>  }
>
> +static int __maybe_unused fxls8962af_suspend(struct device *dev)
> +{
> +       struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +       struct fxls8962af_data *data = iio_priv(indio_dev);
> +
> +       if (device_may_wakeup(dev) && data->enable_event) {
> +               enable_irq_wake(data->irq);
> +
> +               /*
> +                * Disable buffer, as the buffer is so small the device will wake
> +                * almost immediately.
> +                */
> +               if (iio_buffer_enabled(indio_dev))
> +                       fxls8962af_buffer_predisable(indio_dev);
> +       } else {
> +               fxls8962af_runtime_suspend(dev);
> +       }
> +
> +       return 0;
> +}
> +
> +static int __maybe_unused fxls8962af_resume(struct device *dev)
> +{
> +       struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +       struct fxls8962af_data *data = iio_priv(indio_dev);
> +
> +       if (device_may_wakeup(dev) && data->enable_event) {
> +               disable_irq_wake(data->irq);
> +
> +               if (iio_buffer_enabled(indio_dev))
> +                       fxls8962af_buffer_postenable(indio_dev);
> +       } else {
> +               fxls8962af_runtime_resume(dev);
> +       }
> +
> +       return 0;
> +}
> +
>  const struct dev_pm_ops fxls8962af_pm_ops = {
> -       SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> -                               pm_runtime_force_resume)

> +       SET_SYSTEM_SLEEP_PM_OPS(fxls8962af_suspend,
> +                               fxls8962af_resume)

Now one line?

>         SET_RUNTIME_PM_OPS(fxls8962af_runtime_suspend,
>                            fxls8962af_runtime_resume, NULL)
>  };

-- 
With Best Regards,
Andy Shevchenko
