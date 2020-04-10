Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51DE21A4567
	for <lists+linux-iio@lfdr.de>; Fri, 10 Apr 2020 12:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725991AbgDJKwa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 10 Apr 2020 06:52:30 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45595 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgDJKwa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 10 Apr 2020 06:52:30 -0400
Received: by mail-pl1-f195.google.com with SMTP id t4so546082plq.12;
        Fri, 10 Apr 2020 03:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qgB8b/mQgCWAPCsQSjZOrDGeMQp8rE+ANYcAlQn0Km4=;
        b=cE5Zf4dYWktCKoncveIFQKYUV5ZklZeqX6vlNdIcM84e5QJ941CYsHcnh2Kmbr2LrV
         PRHEAVlNdZ1l9ejCFPmMNpjl/GV5AJrjBlTS+ymbiv4w1M6BqXBwb5betBJVuCDiw1el
         9Dkifdwp/v1iGV04mgwOe1yNUrEc195Ho+iI5CPSJPgVoeYzF1xVs3swXWLdIzr1ztB0
         aLklQNba/5whfvSFe0vlwY5JzVDXn8y2BMjrs8bIin+1p9EB4vs6p3s1ZlwPkbjlJGCt
         aI3vkKSPRq6BB13Y3dk6X6oUeL/dAbR/o95ei5YOzepDBr+TANvXm8CnwWMWNcb33q5d
         038A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qgB8b/mQgCWAPCsQSjZOrDGeMQp8rE+ANYcAlQn0Km4=;
        b=Fp/+NUvyYZZjzebqHCPWjeMzk3c8c8e3g75qxY9XE4ux0IkL8NMi1meKOzG/+0xpl8
         KQuf8VmH54s6Il/EyVagu/Rr6XRwMHei098wwnE6ZQv7xdiIltwhHVb+9Ut+RpCqqzPC
         RvKp6kw17sX0OZG6aNmP7fa80lLHrWoz4LGNPypoqiADbaVGSSJagjdS/eM5dUXbxQpT
         6DW6BAeNscGf7YCs8sBB0X7O9QI1unjuzGO+cGLRaBcWecvFbBcH+bEfYNn/sr1adHbq
         pvvOHhDMJi3yXSFJdNp4aAtYuUExZk6v725VimFLPJLsJxzCzTUKwIQyEZlbn7HpA2F5
         zxtA==
X-Gm-Message-State: AGi0PuaWF5F2j4eBc9TXfM3j3HIeCRt6J85top+ty2DAUSGeWbjWb8d/
        pe/0GsA/VcM4q3AZAeY1asy5V4F4DIv9ZWzgySQ=
X-Google-Smtp-Source: APiQypLiM7NBbn2p10bI6vTHm8Hq0SwDXuYD3iRJwS1lXxkyP00+SEem44Kjx7oE+stjxAR5arOMTiH4Q8XIvh2+JRU=
X-Received: by 2002:a17:90a:e982:: with SMTP id v2mr4850272pjy.1.1586515948609;
 Fri, 10 Apr 2020 03:52:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200408175058.2.I1f56fe698017f22d6e825c913c256d5afc2ad69f@changeid>
In-Reply-To: <20200408175058.2.I1f56fe698017f22d6e825c913c256d5afc2ad69f@changeid>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 10 Apr 2020 13:52:16 +0300
Message-ID: <CAHp75VcuPoVK_+KV+88Di1dUFZ9S8-1nNqo2s8a_n3vgSMoecg@mail.gmail.com>
Subject: Re: [PATCH 2/2 v8] iio: Add SEMTECH SX9310/9311 sensor driver
To:     Daniel Campello <campello@chromium.org>
Cc:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Enrico Granata <egranata@chromium.org>,
        Andreas Klinger <ak@it-klinger.de>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

One side note. Whenever you prepare patches do the following:
- use -v<n> to git-format-patch to versioning it by using standard
template (<n> is a version number)
- use --thread to make messages in one bunch
- resend entire series
- do not send patches more often than once per 24 hours

On Thu, Apr 9, 2020 at 2:54 AM Daniel Campello <campello@chromium.org> wrote:
>
> Add SEMTECH SX9310/9311 driver.
>
> The device has the following entry points:
>
> Usual frequency:
> - sampling_frequency
> - sampling_frequency_available
>
> Instant reading of current values for different sensors:
> - in_proximity0_raw
> - in_proximity1_raw
> - in_proximity2_raw
> - in_proximity3_comb_raw
> and associated events in events/
>
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> Signed-off-by: Enrico Granata <egranata@chromium.org>

This is not understandable. Are they who helped you develop the code
(we have a special tag, i.e. Co-developed-by in addition to SoB), or
just people in the middle? Then the question is, how come author is
you and not Gwendal?

...

> +What:          /sys/bus/iio/devices/iio:deviceX/in_proximity3_comb_raw

> +Description:
> +               Proximity measurement indicating that some object is
> +               near the combined sensor. The combined sensor presents
> +               proximity measurements constructed by hardware by
> +               combining measurements taken from a given set of
> +               physical sensors.

I'm wondering if we rather have some standard tag across sensors for
combined values.
It's particular to proximity sensors only? Would it stay like this
forever? Won't we come to the very heavy and noisy ABI if more sensors
are gaining something like this?

...

> + * Copyright 2018 Google LLC.

I remember you did changes in this year...
Is your changes copyrighted by G company?

> + * Reworked April 2019 by Evan Green <evgreen@chromium.org>

in April

> + * and January 2020 by Daniel Campello <campello@chromium.org>

in January

And since it looks like a sentence, put period at the end of it.

...

> +#include <linux/acpi.h>
> +#include <linux/delay.h>
> +#include <linux/i2c.h>
> +#include <linux/irq.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/pm.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>

...

> +#define SX9310_REG_IRQ_MSK                             0x03

Is MSK abbreviation in datasheet? Please spell it how it's in datasheet.

> +#define   SX9310_CONVDONE_IRQ                          BIT(3)
> +#define   SX9310_FAR_IRQ                               BIT(5)
> +#define   SX9310_CLOSE_IRQ                             BIT(6)

> +#define   SX9310_EVENT_IRQ             (SX9310_FAR_IRQ | SX9310_CLOSE_IRQ)

Is it listed in hardware, or simple an addition to have it easier to
handle in the code?

...

> +#define   SX9310_REG_PROX_CTRL0_EN_MASK                        0x0F

GENMASK()

...

> +#define   SX9310_REG_PROX_CTRL2_COMBMODE_ALL           0x80

BIT() ?

> +#define   SX9310_REG_PROX_CTRL2_SHIELDEN_DYNAMIC       0x04

BIT() ?

If it is not a one bit value, better to use (value << shift) and
perhaps mention other possibilities.
But for current case looks like anyway BIT() macro can be suitable.

You can revisit all the rest definitions, but it's up to you, just try
to be close to the datasheet.

...

> +struct sx9310_data {

> +       struct i2c_client *client;

> +};

...

> +static ssize_t sx9310_show_samp_freq_avail(struct device *dev,
> +                                          struct device_attribute *attr,
> +                                          char *buf)
> +{
> +       size_t len = 0;
> +       int i;
> +
> +       for (i = 0; i < ARRAY_SIZE(sx9310_samp_freq_table); i++)
> +               len += scnprintf(buf + len, PAGE_SIZE - len, "%d.%d ",
> +                                sx9310_samp_freq_table[i].val,
> +                                sx9310_samp_freq_table[i].val2);
> +       buf[len - 1] = '\n';
> +       return len;
> +}
> +static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(sx9310_show_samp_freq_avail);

Jonathan, what is the best practice now with this kind of output? I
think that IIO core provides a unified format to out this.

...

> +static int sx9310_read_prox_data(struct sx9310_data *data,
> +                                const struct iio_chan_spec *chan, __be16 *val)
> +{
> +       int ret;
> +
> +       ret = regmap_write(data->regmap, SX9310_REG_SENSOR_SEL, chan->channel);

> +       if (ret < 0)

Do you need all these ' < 0' checks? Revisit code and drop where it's
not needed, like here.

> +               return ret;
> +
> +       return regmap_bulk_read(data->regmap, chan->address, val,

> +                               sizeof(__be16));

sizeof(*val)

> +}

...

> +static int sx9310_read_proximity(struct sx9310_data *data,
> +                                const struct iio_chan_spec *chan, int *val)
> +{

> +       int ret = 0;

Unneede assignment.

> +       if (ret < 0)
> +               goto out_disable_irq;

And if the path was non-IRQ one do we need to call ..._disable_irq()?

> +       if (ret < 0)
> +               goto out_disable_irq;

Ditto.

> +       ret = sx9310_disable_irq(data, SX9310_CONVDONE_IRQ);
> +       if (ret < 0)
> +               goto out_put_channel;

Ditto.

> +       return IIO_VAL_INT;
> +
> +out_disable_irq:
> +       sx9310_disable_irq(data, SX9310_CONVDONE_IRQ);
> +out_put_channel:
> +       sx9310_put_read_channel(data, chan->channel);
> +out:
> +       mutex_unlock(&data->mutex);
> +
> +       return ret;
> +}

...

> +static int sx9310_read_samp_freq(struct sx9310_data *data, int *val, int *val2)
> +{
> +       unsigned int regval;

> +       int ret = regmap_read(data->regmap, SX9310_REG_PROX_CTRL0, &regval);

Slightly better to assign exactly before use, i.e. below before if (ret).
For now it's okay, but rationale is that if you need to inject some
code in between in the future, this will become an additional burden.

> +       if (ret < 0)
> +               return ret;

> +}

...

> +       for_each_set_bit(chan, &data->chan_event, SX9310_NUM_CHANNELS) {
> +               int dir;
> +               u64 ev;

> +               bool new_prox = val & BIT(chan);

Similar: slightly better to assign before use.

> +
> +               if (new_prox == data->prox_stat[chan])
> +                       /* No change on this channel. */
> +                       continue;

> +       }

...

> +#define SX_INIT(_reg, _def)                    \
> +       {                                       \
> +               .reg = SX9310_REG_##_reg,       \
> +               .def = _def,                    \
> +       }

I think this macro makes it harder to read, and better simple to put
these initializers directly into below structure, but it's up to you.

...

> +       ret = regmap_read_poll_timeout(data->regmap, SX9310_REG_STAT1, val,
> +                                      !(val & SX9310_COMPSTAT_MASK), 20000,
> +                                      2000000);
> +       if (ret == -ETIMEDOUT)
> +               dev_err(&data->client->dev,
> +                       "initial compensation timed out: 0x%02x", val);
> +

> +       regmap_write(data->regmap, SX9310_REG_PROX_CTRL0, ctrl0);

Even in timeout case?

> +       return ret;

...

> +       if ((long)device_get_match_data(dev) != whoami)

  unsigned int long ddata;

  ddata = (uintptr_t)device_get_match_data(dev);
  if (ddata != whoami)
  ...

> +               dev_err(dev, "WHOAMI does not match device data: %d", whoami);

If it's error, why not bail out here?
Or i.o.w. what is the usefulness of the driver data?

> +       switch (whoami) {
> +       case SX9310_WHOAMI_VALUE:
> +               indio_dev->name = "sx9310";
> +               break;
> +       case SX9311_WHOAMI_VALUE:
> +               indio_dev->name = "sx9311";
> +               break;
> +       default:
> +               dev_err(dev, "unexpected WHOAMI response: %u", whoami);
> +               return -ENODEV;
> +       }

...

> +               data->trig = devm_iio_trigger_alloc(
> +                       dev, "%s-dev%d", indio_dev->name, indio_dev->id);

Indentation issues.

...

> +       mutex_lock(&data->mutex);
> +       ret = regmap_read(data->regmap, SX9310_REG_PROX_CTRL0,
> +                         &data->suspend_ctrl0);

> +

Blank line in a wrong position?

> +       if (ret)
> +               goto out;
> +

...

> +       mutex_lock(&data->mutex);
> +       ret = regmap_write(data->regmap, SX9310_REG_PAUSE, 1);
> +       if (ret)
> +               goto out;
> +
> +       ret = regmap_write(data->regmap, SX9310_REG_PROX_CTRL0,
> +                          data->suspend_ctrl0);
> +
> +out:
> +       mutex_unlock(&data->mutex);
> +

> +       enable_irq(data->client->irq);

So, you enable IRQ despite the error. Why?

...

> +static const struct dev_pm_ops sx9310_pm_ops = {
> +       SET_SYSTEM_SLEEP_PM_OPS(sx9310_suspend, sx9310_resume)
> +};

...

> +               .acpi_match_table = ACPI_PTR(sx9310_acpi_match),
> +               .of_match_table = of_match_ptr(sx9310_of_match),

Drop these macros. They more harmful than useful, i.e. you will get
compiler warning.
If you would like to use them, you have to guard ID tables with ugly ifdeffery.


--
With Best Regards,
Andy Shevchenko
