Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1D8B3326C1
	for <lists+linux-iio@lfdr.de>; Tue,  9 Mar 2021 14:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbhCINV7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Mar 2021 08:21:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbhCINVd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Mar 2021 08:21:33 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4168C06174A;
        Tue,  9 Mar 2021 05:21:32 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id e2so1288180pld.9;
        Tue, 09 Mar 2021 05:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=943qSIAAGbzfZ1Mli8l1IMkssOCUKnzaCo1jCEsYE1Q=;
        b=Ep2pKTBjeC4vo44sneiCLLWX9Z4z0Op9qhMq4HidRZnQnOlwLCbj4NRBCTnNfUqMr0
         MGbXIrrMgTys/HwIBn/i8szntUuDbmxcA12LlBgubBt8jOkHkKSGLozVcXKBQrfQSL+9
         HO1T4wT49O/5EVJleJCDi2NObZEYN2XoUTaBMt/Iux9eKTGlzPKieezfRmuUYVVbxt4E
         q0IhAaz4RPvS6UIOCJZL1QVS6mocmGXDUIIbAbfA7SQco42UAv4eh68x1XphVM9KJOGQ
         729TaBWuj9gdoD5gYz4/CrVyF4nMnax6b/By4gvDiPT0HKM92pch5lhkosi7GKgVI5Nr
         KUlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=943qSIAAGbzfZ1Mli8l1IMkssOCUKnzaCo1jCEsYE1Q=;
        b=rpAKODoW0HMJgJYOR+vbT5bXIam5808tdj6ZBsinDOdFtG7v11fLckDRpP2on9mFgP
         WpMEyF4UK2HMe6JFCE50ZwEdD+QQTEGMFLBdWMCwNsUkd1ItGL3/HvLsXXt+0Z9A7xIq
         t6jpJgxKLJlbQldZzeRlHWviuQGlADtRq4GRCLq9FbwXkSb1NBYlukrLA6VBQSbaeyuC
         hDfeHoFb0SJyN1TT2uVQLUTDWWK5ZZt0nHtcdiiqbF7WriQZZEW3KQ1ZJXMNUp0OYc6s
         a0TSx4BlwPUadU+6IV3IjlLBpcq2vHkLCb5c9vPhzAfPc/mgmAJGkmtYNmy+nNFS2jdq
         PSeQ==
X-Gm-Message-State: AOAM532StBcqRgldJy98eLydWA0Mv3+vEVwyKIZ9WIuK3op/BgxddLUz
        HPKnJcpdi4EcyFYtUB0BMCxo0t4t+J1B3DMFyVA=
X-Google-Smtp-Source: ABdhPJxXNJoXrfaJKa/Io08GgjAWjAFK3EP4VnL0bJf0fm5BvCuPuusd0kfYfzAnWr0P1yEE+0S1qW2bebnrh/TwEeg=
X-Received: by 2002:a17:90a:e454:: with SMTP id jp20mr1348560pjb.129.1615296092301;
 Tue, 09 Mar 2021 05:21:32 -0800 (PST)
MIME-Version: 1.0
References: <20210305133813.27967-1-o.rempel@pengutronix.de> <20210305133813.27967-3-o.rempel@pengutronix.de>
In-Reply-To: <20210305133813.27967-3-o.rempel@pengutronix.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 9 Mar 2021 15:21:15 +0200
Message-ID: <CAHp75VepMJKuePOgqhgfJzpvLXAizoKsPyJ99wtzHod_xxYLYA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] iio: adc: add ADC driver for the TI TSC2046 controller
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

On Fri, Mar 5, 2021 at 3:40 PM Oleksij Rempel <o.rempel@pengutronix.de> wrote:

I have heard it will be a new version, so below a lot of nit-picks.

> Basically the TI TSC2046 touchscreen controller is 8 channel ADC optimized for
> the touchscreen use case. By implementing it as IIO ADC device, we can

an IIO

> make use of resistive-adc-touch and iio-hwmon drivers.
>
> So far, this driver was tested with custom version of resistive-adc-touch driver,
> since it need to be extended to make use of Z1 and Z2 channels. The X/Y

needs

> are working without additional changes.

...

> +#include <asm/unaligned.h>

Usually asm/* goes after linux/*

> +#include <linux/bitfield.h>
> +#include <linux/delay.h>

> +#include <linux/iio/buffer.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/trigger.h>

Can we move this group separately after all other includes?

> +#include <linux/module.h>
> +#include <linux/spi/spi.h>

...

> +/* this driver doesn't aim at the peak continuous sample rate */

This

> +/*
> + * Default settling time. This time depends on the:
> + * - PCB design
> + * - touch plates size, temperature, etc
> + * - initial power state of the ADC
> + *
> + * Since most values higher than 100us seems to be good, it make sense to

seem
makes

> + * have some default value. These values were measuring get by testing on a

were measured on a

> + * PLYM2M board at 2MHz SPI CLK rate.
> + *
> + * Sometimes there are extra signal filter capacitors on the touchscreen
> + * signals, which make it 10 or 100 times worse.
> + */

...

> +#define TI_TSC2046_TIMESTAMP_SIZE              (sizeof(int64_t) / sizeof(int16_t))

Hmm... shouldn't we use a struct approach below?

...

> +/* represents a HW sample */

Represents

Kernel doc with explanation on the fields?

...

> +/* layout of atomic buffers within big buffer */

Ditto.

...

> +       u16 scan_buf[TI_TSC2046_MAX_CHAN + 2 + TI_TSC2046_TIMESTAMP_SIZE];

Shouldn't we use a struct approach here?

...

> +       /*
> +        * Lock to protect the layout and the spi transfer buffer.

SPI

> +        * tsc2046_adc_group_layout can be changed within update_scan_mode(),
> +        * in this case the l[] and tx/rx buffer will be out of sync to each
> +        * other.
> +        */

...

> +       dev_dbg(&priv->spi->dev, "%s effective speed %u, time per bit: %u, count bits: %u, count samples: %u\n",
> +               __func__, priv->effective_speed_hz, priv->time_per_bit_ns,
> +               bit_count, sample_count);

Drop all these __func__ from everywhere. For debug they may be enabled
via Dynamic Debug interface.

...

> +       switch (ch_idx) {
> +       case TI_TSC2046_ADDR_X:
> +       case TI_TSC2046_ADDR_Y:
> +       case TI_TSC2046_ADDR_Z1:
> +       case TI_TSC2046_ADDR_Z2:
> +               settle_time = TI_TSC2046_SETTLING_TIME_XYZ_DEF_US;
> +               break;
> +       default:
> +               settle_time = 0;

break;

> +       }

...

> +static u8 tsc2046_adc_get_cmd(struct tsc2046_adc_priv *priv, int ch_idx,
> +                             bool keep_power)
> +{
> +       u32 pd = 0; /* power down (pd) bits */
> +
> +       /*
> +        * if PD bits are 0, controller will automatically disable ADC, VREF and
> +        * enable IRQ.
> +        */

> +       if (keep_power)
> +               pd = TI_TSC2046_PD0_ADC_ON;

else
  pd = 0;

?

Otherwise comments are kinda not fully clear.

> +       return TI_TSC2046_START | FIELD_PREP(TI_TSC2046_ADDR, ch_idx) | pd;
> +}

...

> +       /* last 3 bits on the wire are empty */

Last

> +       return get_unaligned_be16(&buf->data) >> 3;

Doesn't mean we will lose precision when the driver will be used as AD/C?

...

> +static size_t tsc2046_adc_group_set_layout(struct tsc2046_adc_priv *priv,
> +                                          unsigned int group,
> +                                          unsigned int ch_idx)
> +{
> +       struct tsc2046_adc_group_layout *l = &priv->l[group];

Hmm...

> +       unsigned int max_count, count_skip;
> +       unsigned int offset = 0;
> +
> +       count_skip = tsc2046_adc_get_settle_count(priv, ch_idx);

> +       if (group != 0) {
> +               l = &priv->l[group - 1];
> +               offset = l->offset + l->count;
> +       }
> +
> +       l = &priv->l[group];

Why do you need to reassign this?

Wouldn't be simpler to rewrite it as

if (group)
  offset = ...;

?

> +       max_count = count_skip + TI_TSC2046_SAMPLES_XYZ_DEF;
> +
> +       l->offset = offset;
> +       l->count = max_count;
> +       l->skip = count_skip;
> +
> +       return sizeof(*priv->tx) * max_count;
> +}

...

> +               switch (ch_idx) {
> +               case TI_TSC2046_ADDR_Y:
> +                       if (val == 0xfff)
> +                               return -EAGAIN;
> +                       break;
> +               case TI_TSC2046_ADDR_X:
> +                       if (!val)
> +                               return -EAGAIN;
> +                       break;

default?

> +               }

...

> +               if (valid) {
> +                       /*
> +                        * Validate data to stop sampling and reduce power
> +                        * consumption.
> +                        */
> +                       ret = tsc2046_adc_get_valide_val(priv, group);
> +                       if (ret < 0) {
> +                               /* go back and invalidate all channels */
> +                               group = 0;
> +                               valid = false;
> +                       }
> +               } else {

> +                       ret = 0xffff;

GENMASK() if it's a bitfield or U16_MAX if it's plain number?

> +               }
> +
> +               priv->scan_buf[group] = ret;
> +       }

...

> +       unsigned int retry = 3;

Why this number? Comment?

...

> +               /*
> +                * We can sample it as fast as we can, but usually we do not
> +                * need so many samples. Reduce the sample rate for default
> +                * (touchscreen) use case.
> +                * Currently we do not need highly precise sample rate. It

a highly

> +                * is enough to have calculated numbers.
> +                */

...

> +       priv->time_per_scan_us = size * 8 *
> +               priv->time_per_bit_ns / NSEC_PER_USEC;

One line?

...

> +       /*
> +        * calculate and allocate maximal size buffer if all channels are
> +        * enabled

Calculate
enabled.

> +        */

...

> +       name = devm_kasprintf(dev, GFP_KERNEL, "%s-%s",
> +                             TI_TSC2046_NAME, dev_name(dev));

NULL check?

...

> +       trig = devm_iio_trigger_alloc(dev, "%s-dev%d",
> +                                     indio_dev->name, indio_dev->id);

One line?

> +       if (!trig)
> +               return -ENOMEM;

...

> +static const struct of_device_id ads7950_of_table[] = {
> +       { .compatible = "ti,tsc2046e-adc", .data = &tsc2046_adc_dcfg_tsc2046e },

> +       { },

No comma needed for a terminator line.

> +};

-- 
With Best Regards,
Andy Shevchenko
