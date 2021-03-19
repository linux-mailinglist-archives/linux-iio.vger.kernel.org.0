Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D98F34238F
	for <lists+linux-iio@lfdr.de>; Fri, 19 Mar 2021 18:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbhCSRnA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 19 Mar 2021 13:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbhCSRm6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 19 Mar 2021 13:42:58 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F4CC06174A;
        Fri, 19 Mar 2021 10:42:58 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id l1so3298177plg.12;
        Fri, 19 Mar 2021 10:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aCBxKGyN1RW9McR86Ob8DISjqGfg+CaKCVIqc4Cd+b4=;
        b=nlkD62njG7eZA+nK9kojt3lTe8jXKPwyFlwaHD10T+uTYR+qjk11Epgurd4S7Ws6Bh
         P/iMS7+vU1KiOKTKSoeoQKenAhFwJbsrW6SnSI2O9XZzrQcnfpsqiQpxVIw33EXQbeZi
         xnx3DaDPm/kHhRcLtsPUIrjrrKA9sMKWq7DLRMn/+WQVPa5B7uETH1RHLY0moZ78K1Dh
         6Ar3KeDnvFHen5vKyBoPgGBGPF0Q+gdPNL7sJWxX7E0i0cAcWQuFuOPa3rPj7v+uam0A
         levOpW3GNzL5dfN5zG0jAFbBG+/TvjqmS6AnKDfzJpWvBjgz4EjfGxZ9nljQtoyPMETp
         wCFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aCBxKGyN1RW9McR86Ob8DISjqGfg+CaKCVIqc4Cd+b4=;
        b=S34Ti16GzEBkj23jS1PlJyp5tHTPi42MCRS6B5Yf2iFTiN+Az9phQ9ZrNYig3n3ckW
         Nls14W9jxk5zvJE+39ImAk5sr01pZUiL48ulEGIZdsJo5QXmRKhbUd8NoA7WUoJ8Xq9j
         gCFCncZZB7AUmsv19LMqLTj2Pe5z69WFAXjjRH0X2odU6NHmc6wG2V+sRCFcA3WYMM8x
         CokuDEuoa9LvopjC+MpIAbz6fE3ripQ1DtsIcD7mOineSpgRKBPmwAUGtu4dwes80i2R
         OzTCruNCEDUPKhYDUvN5emU2T7uOmt06zhhuSv33qt5VYt9qzLEjRWVVYc9TABB0U0Mn
         EgOw==
X-Gm-Message-State: AOAM530R2MoOx2GdhvECJbbKQp1p5yyXg5v6pdtotomrTGVW494xkAXx
        rqdfBm36uINURpM7og3fmBYktrVg48ZZdZPZCSI=
X-Google-Smtp-Source: ABdhPJxoo4vsSIeNDkBBr2mzZSj7vcXIsQn3r+AXxkiCjnO3Z0ouzSL6VmvOsWbYb+aTQulZXjfRzeLOqrwZg4+4I80=
X-Received: by 2002:a17:902:a406:b029:e6:78c4:71c8 with SMTP id
 p6-20020a170902a406b02900e678c471c8mr15307631plq.17.1616175777639; Fri, 19
 Mar 2021 10:42:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210319144509.7627-1-o.rempel@pengutronix.de> <20210319144509.7627-4-o.rempel@pengutronix.de>
In-Reply-To: <20210319144509.7627-4-o.rempel@pengutronix.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 19 Mar 2021 19:42:41 +0200
Message-ID: <CAHp75Vcn=g-3NRXAEd5jEu4uxD_fHbybiDg=t9QiY80TNZuTgQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] iio: adc: add ADC driver for the TI TSC2046 controller
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Robin van der Gracht <robin@protonic.nl>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Mar 19, 2021 at 4:45 PM Oleksij Rempel <o.rempel@pengutronix.de> wrote:
>
> Basically the TI TSC2046 touchscreen controller is 8 channel ADC optimized for
> the touchscreen use case. By implementing it as an IIO ADC device, we can
> make use of resistive-adc-touch and iio-hwmon drivers.
>
> So far, this driver was tested with a custom version of resistive-adc-touch driver,
> since it needs to be extended to make use of Z1 and Z2 channels. The X/Y
> are working without additional changes.

Since kbuild bot found some issues and it will be v4, some additional
comments from me below.

...

> +#define        TI_TSC2046_SAMPLE_BITS \
> +       (sizeof(struct tsc2046_adc_atom) * BITS_PER_BYTE)

Isn't it something like BITS_PER_TYPE(struct ...) ?

...

> +struct tsc2046_adc_atom {
> +       /*
> +        * Command transmitted to the controller. This filed is empty on the RX
> +        * buffer.
> +        */
> +       u8 cmd;
> +       /*
> +        * Data received from the controller. This filed is empty for the TX
> +        * buffer
> +        */
> +       __be16 data;
> +} __packed;

filed -> field in both cases above.

...

> +       /*
> +        * Lock to protect the layout and the spi transfer buffer.

SPI

> +        * tsc2046_adc_group_layout can be changed within update_scan_mode(),
> +        * in this case the l[] and tx/rx buffer will be out of sync to each
> +        * other.
> +        */

...

> +static unsigned int tsc2046_adc_time_to_count(struct tsc2046_adc_priv *priv,
> +                                             unsigned long time)
> +{
> +       unsigned int bit_count, sample_count;
> +
> +       bit_count = DIV_ROUND_UP(time * NSEC_PER_USEC, priv->time_per_bit_ns);

Does it survive 32-bit builds?

> +       sample_count = DIV_ROUND_UP(bit_count, TI_TSC2046_SAMPLE_BITS);
> +
> +       dev_dbg(&priv->spi->dev, "Effective speed %u, time per bit: %u, count bits: %u, count samples: %u\n",
> +               priv->effective_speed_hz, priv->time_per_bit_ns,
> +               bit_count, sample_count);
> +
> +       return sample_count;
> +}

...

> +       /*
> +        * if PD bits are 0, controller will automatically disable ADC, VREF and
> +        * enable IRQ.
> +        */
> +       if (keep_power)
> +               pd = TI_TSC2046_PD0_ADC_ON;
> +       else
> +               pd = 0;

Can be ternary on one line, but it's up to you.

...

> +static u16 tsc2046_adc_get_value(struct tsc2046_adc_atom *buf)
> +{
> +       /* Last 3 bits on the wire are empty */

Last?! You meant Least significant?
Also, don't we lose precision if a new compatible chip appears that
does fill those bits?

Perhaps define the constant and put a comment why it's like this.

> +       return get_unaligned_be16(&buf->data) >> 3;
> +}

...

> +static size_t tsc2046_adc_group_set_layout(struct tsc2046_adc_priv *priv,
> +                                          unsigned int group,
> +                                          unsigned int ch_idx)
> +{
> +       struct tsc2046_adc_ch_cfg *ch = &priv->ch_cfg[ch_idx];
> +       struct tsc2046_adc_group_layout *prev, *cur;
> +       unsigned int max_count, count_skip;
> +       unsigned int offset = 0;
> +
> +       if (group) {
> +               prev = &priv->l[group - 1];
> +               offset = prev->offset + prev->count;
> +       }

I guess you may easily refactor this by supplying a pointer to the
current layout + current size.

> +       cur = &priv->l[group];

Also, can you move it down closer to the (single?) caller.

> +}

...

> +static int tsc2046_adc_scan(struct iio_dev *indio_dev)
> +{
> +       struct tsc2046_adc_priv *priv = iio_priv(indio_dev);
> +       struct device *dev = &priv->spi->dev;
> +       int group;
> +       int ret;
> +
> +       ret = spi_sync(priv->spi, &priv->msg);
> +       if (ret < 0) {

> +               dev_err_ratelimited(dev, "SPI transfer filed: %pe\n",
> +                                   ERR_PTR(ret));

One line?

> +               return ret;
> +       }

> +       ret = iio_push_to_buffers_with_timestamp(indio_dev, &priv->scan_buf,
> +                                                iio_get_time_ns(indio_dev));
> +       /* If consumer is kfifo, we may get a EBUSY here - ignore it. */

the consumer

> +       if (ret < 0 && ret != -EBUSY) {
> +               dev_err_ratelimited(dev, "Failed to push scan buffer %pe\n",
> +                                   ERR_PTR(ret));
> +
> +               return ret;
> +       }
> +
> +       return 0;
> +}


...

> +static enum hrtimer_restart tsc2046_adc_trig_more(struct hrtimer *hrtimer)
> +{
> +       struct tsc2046_adc_priv *priv = container_of(hrtimer,
> +                                                    struct tsc2046_adc_priv,
> +                                                    trig_timer);
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&priv->trig_lock, flags);
> +
> +       disable_irq_nosync(priv->spi->irq);

> +       atomic_inc(&priv->trig_more_count);

You already have a spin lock, do you need to use the atomic API?

> +       iio_trigger_poll(priv->trig);
> +
> +       spin_unlock_irqrestore(&priv->trig_lock, flags);
> +
> +       return HRTIMER_NORESTART;
> +}

...

> +       size_t size = 0;

Move the assignment closer to the actual use of the variable.

...

> +       /*
> +        * In case SPI controller do not report effective_speed_hz, use
> +        * configure value and hope it will match

Missed period.

> +        */
> +       if (!priv->effective_speed_hz)
> +               priv->effective_speed_hz = priv->spi->max_speed_hz;

Also can be ternary on one line, but it's up to you.

...

> +       name = devm_kasprintf(dev, GFP_KERNEL, "%s-%s",
> +                             TI_TSC2046_NAME, dev_name(dev));

No NULL check?
Should be added or justified.

...

> +       trig->dev.parent = indio_dev->dev.parent;

Don't we have this done by core (some recent patches in upstream)?

...

> +       ret = devm_iio_device_register(dev, indio_dev);
> +       if (ret) {
> +               dev_err(dev, "Failed to register iio device\n");

> +               return ret;
> +       }
> +
> +       return 0;

  return ret;
or even
  return devm_iio_device_register(dev, indio_dev);

-- 
With Best Regards,
Andy Shevchenko
