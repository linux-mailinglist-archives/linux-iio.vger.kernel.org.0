Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 218C4231167
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jul 2020 20:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732248AbgG1SPZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Jul 2020 14:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728050AbgG1SPY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jul 2020 14:15:24 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC80C061794;
        Tue, 28 Jul 2020 11:15:24 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id il6so306937pjb.0;
        Tue, 28 Jul 2020 11:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ycxnhWPUAr/2jFh8UDFILpEkppRmN7Ol2hxP6bBiICY=;
        b=rMBXFMHDUJId25FoorkJnUiPRZFI2vgruNzaPkdbHWVwgKodtuXLak0hMqP4O7E6LD
         6fcz9R1AcwXTGup3Vzod+k+cX2uEokZCH0qPw0khDTXu08wu5S+CFsjOFq6ucKEoEPNW
         Ssm6z0sk97C2Oxj7+L/5U6s8d2DkvmjlEab9dc2FtU2KKJPhTSoDpfHzDCuQGBN6JxAG
         28u9o59aV6hu1ZTlPFvCZYHu+o4shXAnUi3QX6gzlXLdyZ+GROlGUptkXfMo+4dl2sgs
         +9HufzAJ5UAEkcaZmov134KSX1j6ddF3eFLpbVb+QVEH4iD1yQFGWRRIfRyfqZ7S2EsD
         s0ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ycxnhWPUAr/2jFh8UDFILpEkppRmN7Ol2hxP6bBiICY=;
        b=iYgLZJaZtj2mkiulRbtE/r4wj6Y7rZlrxe78QFiDIIth6aEhw36Y3KZfCfxEwCmQ83
         kVraUuemjichrDdGtzLppU5Z934ZjO09TRqKr4hTd/lwZgjnFbjIQ9IcayqMhHrWPY/4
         1O0Dgg3ZgPa+aSruq+WFOz8ABYr9XlOLY9TjuHNguS0ydMLbz8/nRBN0vwnNURWCddhP
         AgDZUs4b9cKTtfXTdkus5jWCTUst8BQOYTu2BUT9pwoALLVBRnYYBPEBrASNSDNxXj1M
         4Y/3tA3vCF+KF/HSVOag7qIsinQdPzgHieNsVFiK+XW0OjRGZO9FDb7IExXrJqMlOMfb
         /dtQ==
X-Gm-Message-State: AOAM532rWgb/lHhiQbYVyZV+pIaR5EWa7a+8i/agAApwMDkwrnUhDol2
        2Q8hg14OWDqxMyHcQLj5vny46jnEVuCIfgsJKkg=
X-Google-Smtp-Source: ABdhPJxIZ/FDGYnm9uB0LMmXOk6t6XwzOeD171oTnwpgkYRwHRfx1MpvJys29imN35DQsIppX6YCUnjWge9hIjMDKsA=
X-Received: by 2002:a17:902:9a4b:: with SMTP id x11mr24311328plv.255.1595960124236;
 Tue, 28 Jul 2020 11:15:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200724183954.1.I2e29ae25368ba8a72a9e44121cfbc36ead8ecc6b@changeid>
 <20200728151258.1222876-1-campello@chromium.org> <20200728091057.10.Ibe84fae61cd914c116e6d59ffeb644f1cbecd601@changeid>
In-Reply-To: <20200728091057.10.Ibe84fae61cd914c116e6d59ffeb644f1cbecd601@changeid>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 28 Jul 2020 21:15:07 +0300
Message-ID: <CAHp75VeWpMPFxsP67FVsm_+jJOxkChj-e7UJ4mbBXzFGqLNd7w@mail.gmail.com>
Subject: Re: [PATCH 10/15] iio: sx9310: Simplify error return handling
To:     Daniel Campello <campello@chromium.org>
Cc:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Enrico Granata <egranata@chromium.org>,
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
> Checks for non-zero return values to signal error conditions.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Daniel Campello <campello@chromium.org>
> ---
>
>  drivers/iio/proximity/sx9310.c | 52 +++++++++++++++++-----------------
>  1 file changed, 26 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
> index 31234691a31abf..051c6515e62c18 100644
> --- a/drivers/iio/proximity/sx9310.c
> +++ b/drivers/iio/proximity/sx9310.c
> @@ -338,7 +338,7 @@ static int sx9310_read_prox_data(struct sx9310_data *data,
>         int ret;
>
>         ret = regmap_write(data->regmap, SX9310_REG_SENSOR_SEL, chan->channel);
> -       if (ret < 0)
> +       if (ret)
>                 return ret;
>
>         return regmap_bulk_read(data->regmap, chan->address, val, sizeof(*val));
> @@ -354,7 +354,7 @@ static int sx9310_wait_for_sample(struct sx9310_data *data)
>         unsigned int val;
>
>         ret = regmap_read(data->regmap, SX9310_REG_PROX_CTRL0, &val);
> -       if (ret < 0)
> +       if (ret)
>                 return ret;
>
>         val = (val & SX9310_REG_PROX_CTRL0_SCANPERIOD_MASK) >>
> @@ -368,13 +368,13 @@ static int sx9310_wait_for_sample(struct sx9310_data *data)
>  static int sx9310_read_proximity(struct sx9310_data *data,
>                                  const struct iio_chan_spec *chan, int *val)
>  {
> -       int ret = 0;
> +       int ret;
>         __be16 rawval;
>
>         mutex_lock(&data->mutex);
>
>         ret = sx9310_get_read_channel(data, chan->channel);
> -       if (ret < 0)
> +       if (ret)
>                 goto out;
>
>         if (data->client->irq) {
> @@ -394,11 +394,11 @@ static int sx9310_read_proximity(struct sx9310_data *data,
>
>         mutex_lock(&data->mutex);
>
> -       if (ret < 0)
> +       if (ret)
>                 goto out_disable_irq;
>
>         ret = sx9310_read_prox_data(data, chan, &rawval);
> -       if (ret < 0)
> +       if (ret)
>                 goto out_disable_irq;
>
>         *val = sign_extend32(be16_to_cpu(rawval),
> @@ -411,7 +411,7 @@ static int sx9310_read_proximity(struct sx9310_data *data,
>         }
>
>         ret = sx9310_put_read_channel(data, chan->channel);
> -       if (ret < 0)
> +       if (ret)
>                 goto out;
>
>         mutex_unlock(&data->mutex);
> @@ -434,7 +434,7 @@ static int sx9310_read_samp_freq(struct sx9310_data *data, int *val, int *val2)
>         unsigned int regval;
>         int ret = regmap_read(data->regmap, SX9310_REG_PROX_CTRL0, &regval);
>
> -       if (ret < 0)
> +       if (ret)
>                 return ret;
>
>         regval = (regval & SX9310_REG_PROX_CTRL0_SCANPERIOD_MASK) >>
> @@ -535,7 +535,7 @@ static void sx9310_push_events(struct iio_dev *indio_dev)
>
>         /* Read proximity state on all channels */
>         ret = regmap_read(data->regmap, SX9310_REG_STAT0, &val);
> -       if (ret < 0) {
> +       if (ret) {
>                 dev_err(&data->client->dev, "i2c transfer error in irq\n");
>                 return;
>         }
> @@ -570,7 +570,7 @@ static irqreturn_t sx9310_irq_thread_handler(int irq, void *private)
>         mutex_lock(&data->mutex);
>
>         ret = regmap_read(data->regmap, SX9310_REG_IRQ_SRC, &val);
> -       if (ret < 0) {
> +       if (ret) {
>                 dev_err(&data->client->dev, "i2c transfer error in irq\n");
>                 goto out;
>         }
> @@ -613,20 +613,20 @@ static int sx9310_write_event_config(struct iio_dev *indio_dev,
>         mutex_lock(&data->mutex);
>         if (state) {
>                 ret = sx9310_get_event_channel(data, chan->channel);
> -               if (ret < 0)
> +               if (ret)
>                         goto out_unlock;
>                 if (!(data->chan_event & ~BIT(chan->channel))) {
>                         ret = sx9310_enable_irq(data, eventirq);
> -                       if (ret < 0)
> +                       if (ret)
>                                 sx9310_put_event_channel(data, chan->channel);
>                 }
>         } else {
>                 ret = sx9310_put_event_channel(data, chan->channel);
> -               if (ret < 0)
> +               if (ret)
>                         goto out_unlock;
>                 if (!data->chan_event) {
>                         ret = sx9310_disable_irq(data, eventirq);
> -                       if (ret < 0)
> +                       if (ret)
>                                 sx9310_get_event_channel(data, chan->channel);
>                 }
>         }
> @@ -665,7 +665,7 @@ static int sx9310_set_trigger_state(struct iio_trigger *trig, bool state)
>                 ret = sx9310_enable_irq(data, SX9310_CONVDONE_IRQ);
>         else if (!data->chan_read)
>                 ret = sx9310_disable_irq(data, SX9310_CONVDONE_IRQ);
> -       if (ret < 0)
> +       if (ret)
>                 goto out;
>
>         data->trigger_enabled = state;
> @@ -694,7 +694,7 @@ static irqreturn_t sx9310_trigger_handler(int irq, void *private)
>                          indio_dev->masklength) {
>                 ret = sx9310_read_prox_data(data, &indio_dev->channels[bit],
>                                             &val);
> -               if (ret < 0)
> +               if (ret)
>                         goto out;
>
>                 data->buffer[i++] = val;
> @@ -801,13 +801,13 @@ static int sx9310_init_compensation(struct iio_dev *indio_dev)
>         unsigned int ctrl0;
>
>         ret = regmap_read(data->regmap, SX9310_REG_PROX_CTRL0, &ctrl0);
> -       if (ret < 0)
> +       if (ret)
>                 return ret;
>
>         /* run the compensation phase on all channels */
>         ret = regmap_write(data->regmap, SX9310_REG_PROX_CTRL0,
>                            ctrl0 | SX9310_REG_PROX_CTRL0_SENSOREN_MASK);
> -       if (ret < 0)
> +       if (ret)
>                 return ret;
>
>         ret = regmap_read_poll_timeout(data->regmap, SX9310_REG_STAT1, val,
> @@ -833,21 +833,21 @@ static int sx9310_init_device(struct iio_dev *indio_dev)
>         unsigned int i, val;
>
>         ret = regmap_write(data->regmap, SX9310_REG_RESET, SX9310_SOFT_RESET);
> -       if (ret < 0)
> +       if (ret)
>                 return ret;
>
>         usleep_range(1000, 2000); /* power-up time is ~1ms. */
>
>         /* Clear reset interrupt state by reading SX9310_REG_IRQ_SRC. */
>         ret = regmap_read(data->regmap, SX9310_REG_IRQ_SRC, &val);
> -       if (ret < 0)
> +       if (ret)
>                 return ret;
>
>         /* Program some sane defaults. */
>         for (i = 0; i < ARRAY_SIZE(sx9310_default_regs); i++) {
>                 initval = &sx9310_default_regs[i];
>                 ret = regmap_write(data->regmap, initval->reg, initval->def);
> -               if (ret < 0)
> +               if (ret)
>                         return ret;
>         }
>
> @@ -901,14 +901,14 @@ static int sx9310_probe(struct i2c_client *client)
>                 return PTR_ERR(data->regmap);
>
>         ret = regmap_read(data->regmap, SX9310_REG_WHOAMI, &data->whoami);
> -       if (ret < 0) {
> +       if (ret) {
>                 dev_err(&client->dev, "error in reading WHOAMI register: %d",
>                         ret);
>                 return ret;
>         }
>
>         ret = sx9310_set_indio_dev_name(&client->dev, indio_dev, data->whoami);
> -       if (ret < 0)
> +       if (ret)
>                 return ret;
>
>         ACPI_COMPANION_SET(&indio_dev->dev, ACPI_COMPANION(&client->dev));
> @@ -920,7 +920,7 @@ static int sx9310_probe(struct i2c_client *client)
>         i2c_set_clientdata(client, indio_dev);
>
>         ret = sx9310_init_device(indio_dev);
> -       if (ret < 0)
> +       if (ret)
>                 return ret;
>
>         if (client->irq) {
> @@ -929,7 +929,7 @@ static int sx9310_probe(struct i2c_client *client)
>                                                 sx9310_irq_thread_handler,
>                                                 IRQF_TRIGGER_LOW | IRQF_ONESHOT,
>                                                 "sx9310_event", indio_dev);
> -               if (ret < 0)
> +               if (ret)
>                         return ret;
>
>                 data->trig =
> @@ -951,7 +951,7 @@ static int sx9310_probe(struct i2c_client *client)
>                                               iio_pollfunc_store_time,
>                                               sx9310_trigger_handler,
>                                               &sx9310_buffer_setup_ops);
> -       if (ret < 0)
> +       if (ret)
>                 return ret;
>
>         return devm_iio_device_register(&client->dev, indio_dev);
> --
> 2.28.0.rc0.142.g3c755180ce-goog
>


-- 
With Best Regards,
Andy Shevchenko
