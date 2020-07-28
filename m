Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1CEC231171
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jul 2020 20:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728770AbgG1SQ7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Jul 2020 14:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728755AbgG1SQ6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jul 2020 14:16:58 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABAEAC061794;
        Tue, 28 Jul 2020 11:16:58 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id t6so12438015pgq.1;
        Tue, 28 Jul 2020 11:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iYy8NKIbcohPDe8y1Ke/ESzEVQn7LmRl2eZ3hgakvlo=;
        b=HoYTB89YW+pghwhBGVSMICLOciQL1Q4cnlWI8r+mzXhOJfSgL0vqCnFB4NAxcSqPAl
         yWcQ+OAjUDgiBNCqtC+q2Ht0ymsqUib/AKheduomZplWJUK14OxTeUZ/Vv1iRdLv8mXr
         JZocbCNKGVaVPP9mlk4dF1KuM0gQkjr2iysrLtzpbhPPO9ixT5x5hpldBOqh58IylI4V
         Hqxs4KjX98LN58qVHWyXrC879ablRCAgdugZfLoTsReGRrtX3CbcVjuNVtunfTDuWZH/
         laAM0Hw2doT5N9wB1TJk+1BRRrYDYYvFqsl9/w7MsP27H5MUuIswa0BS5I4GwUMDZBf7
         NoiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iYy8NKIbcohPDe8y1Ke/ESzEVQn7LmRl2eZ3hgakvlo=;
        b=PoUtBufM+hVKVt+JWsVQF6X7O24bluFAZfs49rQjFGuzmi72EMp6wxaoNYJmOi7Uc2
         d684HgDvXNfkUXWBU+Zhmjaw7D87xsiIsQnrZwf1p4a9yVqEQxcDvmRRV4EmciT3vqKf
         3YAun1qBypKZ1M0V5EQfdC30/NPtvg3x/72M/+iRKqT4DB/Inuz/iGl1Kmf6W5lqdjs3
         JzDUxogkybCUAsd8RxZTkxm9iKi3OhUKtUt78MFGSLQC/hXlFzxDRUYOv9NfS+TqHPKs
         l+7Uj0OD5PuVB1M76NU7CfdR0gd2t/WjyN60Opx7hpTKO7A5SNqrB/0i1L2HdLyj69LK
         Y2UA==
X-Gm-Message-State: AOAM531QOB2riiAHDBA2IiD64OvEYvw3VbtwJo6adeJNWK9iuP1kZV5i
        dKFGa73qtt2jsJ5mY3nPc7/TbIQKJhlbKjdneLA=
X-Google-Smtp-Source: ABdhPJzvA8SlQkTLxDg16GJOxvfodo3xc9kv2MHSFXhfaayfBkXZkXOjzg5gO7kJ/vmeNKbY4jVq6uQ7DCr2rkWjkpM=
X-Received: by 2002:a63:a05f:: with SMTP id u31mr25037766pgn.4.1595960217249;
 Tue, 28 Jul 2020 11:16:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200724183954.1.I2e29ae25368ba8a72a9e44121cfbc36ead8ecc6b@changeid>
 <20200728151258.1222876-1-campello@chromium.org> <20200728091057.12.Iacab204f4164af12fa47206b98505bfbf8770cf3@changeid>
In-Reply-To: <20200728091057.12.Iacab204f4164af12fa47206b98505bfbf8770cf3@changeid>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 28 Jul 2020 21:16:40 +0300
Message-ID: <CAHp75VcoFTBMBP0Zh-ntHKqKr8gvgDb3=Q4F0g6hoTxf4qSPiQ@mail.gmail.com>
Subject: Re: [PATCH 12/15] iio: sx9310: Miscellaneous format fixes
To:     Daniel Campello <campello@chromium.org>
Cc:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jul 28, 2020 at 6:14 PM Daniel Campello <campello@chromium.org> wrote:
>
> Miscellaneous format fixes throughout the whole file.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Daniel Campello <campello@chromium.org>
> ---
>
>  drivers/iio/proximity/sx9310.c | 28 ++++++++++------------------
>  1 file changed, 10 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
> index ba383710ef0dcf..3f981d28ee4056 100644
> --- a/drivers/iio/proximity/sx9310.c
> +++ b/drivers/iio/proximity/sx9310.c
> @@ -90,28 +90,21 @@
>  #define   SX9310_REG_SAR_CTRL2_SAROFFSET_DEFAULT       0x3c
>
>  #define SX9310_REG_SENSOR_SEL                          0x30
> -
>  #define SX9310_REG_USE_MSB                             0x31
>  #define SX9310_REG_USE_LSB                             0x32
> -
>  #define SX9310_REG_AVG_MSB                             0x33
>  #define SX9310_REG_AVG_LSB                             0x34
> -
>  #define SX9310_REG_DIFF_MSB                            0x35
>  #define SX9310_REG_DIFF_LSB                            0x36
> -
>  #define SX9310_REG_OFFSET_MSB                          0x37
>  #define SX9310_REG_OFFSET_LSB                          0x38
> -
>  #define SX9310_REG_SAR_MSB                             0x39
>  #define SX9310_REG_SAR_LSB                             0x3a
> -
>  #define SX9310_REG_I2C_ADDR                            0x40
>  #define SX9310_REG_PAUSE                               0x41
>  #define SX9310_REG_WHOAMI                              0x42
>  #define   SX9310_WHOAMI_VALUE                          0x01
>  #define   SX9311_WHOAMI_VALUE                          0x02
> -
>  #define SX9310_REG_RESET                               0x7f
>  #define   SX9310_SOFT_RESET                            0xde
>
> @@ -402,7 +395,7 @@ static int sx9310_read_proximity(struct sx9310_data *data,
>                 goto out_disable_irq;
>
>         *val = sign_extend32(be16_to_cpu(rawval),
> -                            (chan->address == SX9310_REG_DIFF_MSB ? 11 : 15));
> +                            chan->address == SX9310_REG_DIFF_MSB ? 11 : 15);
>
>         if (data->client->irq) {
>                 ret = sx9310_disable_irq(data, SX9310_CONVDONE_IRQ);
> @@ -432,8 +425,9 @@ static int sx9310_read_proximity(struct sx9310_data *data,
>  static int sx9310_read_samp_freq(struct sx9310_data *data, int *val, int *val2)
>  {
>         unsigned int regval;
> -       int ret = regmap_read(data->regmap, SX9310_REG_PROX_CTRL0, &regval);
> +       int ret;
>
> +       ret = regmap_read(data->regmap, SX9310_REG_PROX_CTRL0, &regval);
>         if (ret)
>                 return ret;
>
> @@ -518,10 +512,9 @@ static irqreturn_t sx9310_irq_handler(int irq, void *private)
>                 iio_trigger_poll(data->trig);
>
>         /*
> -        * Even if no event is enabled, we need to wake the thread to
> -        * clear the interrupt state by reading SX9310_REG_IRQ_SRC.  It
> -        * is not possible to do that here because regmap_read takes a
> -        * mutex.
> +        * Even if no event is enabled, we need to wake the thread to clear the
> +        * interrupt state by reading SX9310_REG_IRQ_SRC.
> +        * It is not possible to do that here because regmap_read takes a mutex.
>          */
>         return IRQ_WAKE_THREAD;
>  }
> @@ -638,7 +631,7 @@ static int sx9310_write_event_config(struct iio_dev *indio_dev,
>
>  static struct attribute *sx9310_attributes[] = {
>         &iio_dev_attr_sampling_frequency_available.dev_attr.attr,
> -       NULL,
> +       NULL
>  };
>
>  static const struct attribute_group sx9310_attribute_group = {
> @@ -969,7 +962,6 @@ static int __maybe_unused sx9310_suspend(struct device *dev)
>         mutex_lock(&data->mutex);
>         ret = regmap_read(data->regmap, SX9310_REG_PROX_CTRL0,
>                           &data->suspend_ctrl0);
> -
>         if (ret)
>                 goto out;
>
> @@ -1015,21 +1007,21 @@ static const struct dev_pm_ops sx9310_pm_ops = {
>  static const struct acpi_device_id sx9310_acpi_match[] = {
>         { "STH9310", SX9310_WHOAMI_VALUE },
>         { "STH9311", SX9311_WHOAMI_VALUE },
> -       {},
> +       {}
>  };
>  MODULE_DEVICE_TABLE(acpi, sx9310_acpi_match);
>
>  static const struct of_device_id sx9310_of_match[] = {
>         { .compatible = "semtech,sx9310", (void *)SX9310_WHOAMI_VALUE },
>         { .compatible = "semtech,sx9311", (void *)SX9311_WHOAMI_VALUE },
> -       {},
> +       {}
>  };
>  MODULE_DEVICE_TABLE(of, sx9310_of_match);
>
>  static const struct i2c_device_id sx9310_id[] = {
>         { "sx9310", SX9310_WHOAMI_VALUE },
>         { "sx9311", SX9311_WHOAMI_VALUE },
> -       {},
> +       {}
>  };
>  MODULE_DEVICE_TABLE(i2c, sx9310_id);
>
> --
> 2.28.0.rc0.142.g3c755180ce-goog
>


-- 
With Best Regards,
Andy Shevchenko
