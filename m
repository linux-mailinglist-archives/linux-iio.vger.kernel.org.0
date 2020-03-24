Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7938219160C
	for <lists+linux-iio@lfdr.de>; Tue, 24 Mar 2020 17:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbgCXQTA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 24 Mar 2020 12:19:00 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41281 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727164AbgCXQTA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 24 Mar 2020 12:19:00 -0400
Received: by mail-pf1-f196.google.com with SMTP id z65so9511587pfz.8;
        Tue, 24 Mar 2020 09:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xHHHZO3RcIy83lINgOXUuaIUXlORCN+5eJIKniNCw1k=;
        b=vGhUzRHEeI8wxzGRCex9YLWwvpMk5FaAozZZ7q/gHcbJWPNE/EqbwytEh7RvZMyJE4
         zhG5+5aq/dLRkPEgQn4HCXWiqB7EnirkIQYc/Aan3TJ0mU6i5Im31+wZ5b76zQx9jk9H
         Vo6pxFEDyDNTKZOuLuHhY6WvCyLr1ePgffnBfLE2CscccotmEuYXcbFYc/YzVFn+kqip
         NqKfmu7sb1iU9oSwrdcjmcehWWd9FjyFn4Dz2cUTYqmAG3SVBeomDDXyaSIXrIBs/laf
         KSa3GfoT29K8SiG9DTaoZbTNkxLhmKJ5SUn752mvjQ+WuDkFOHUjrl+Y7i91U47jf2iF
         +WWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xHHHZO3RcIy83lINgOXUuaIUXlORCN+5eJIKniNCw1k=;
        b=KB4hTcM2UAqFfTJqgPwXNrgw9Nvq9WfmJ33IxTvpFSDDo8E6MusbU5sZWm4SHXfeyz
         6zJF/wIT9K9FlTLgOG0csqVfZ10IK/n1wqPpjLmhYMRTj3W9F2hcu3g29EN6JoAcreey
         Me/im13DLvvzRvDLlRueJDFAv92dGQqww0uVJMskxZoYIRX6z0KAO8jDLBzVg6mbkWta
         REM5mcB+ChJ7hpOHdVpa3HIfCrk3G/HQWgujT4NbmsCXlg/iPzE1Qfb0e55MpFUWDILT
         AI/lhkKLqQikjB+HpizIaRLtHVW09K5aOcgJo0LG2jZW+UQvXPGY7mbwFhGwyWMJw/7+
         e2XQ==
X-Gm-Message-State: ANhLgQ041naYnM3DfTzMYTgOGVzhaAfLLtPxu7GxU025/8/ReHoDvPcY
        /ioVJRh/SyazqzrtWX4wEQpfTEx/7qXUBOyLpfs=
X-Google-Smtp-Source: ADFU+vtJaivKr61psxMKMtawW8A25tsAXLtPBpEvY8GKRr2SOHcqk87vYeSYdfnCh+taB7GSWDiwcq6RNx7rmA5OMLw=
X-Received: by 2002:aa7:958f:: with SMTP id z15mr29368817pfj.130.1585066737681;
 Tue, 24 Mar 2020 09:18:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200323124310.1.I6ed779cd21abf3e70f21c1562bbda81f590976ab@changeid>
 <20200323124310.2.I1f56fe698017f22d6e825c913c256d5afc2ad69f@changeid>
In-Reply-To: <20200323124310.2.I1f56fe698017f22d6e825c913c256d5afc2ad69f@changeid>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 24 Mar 2020 18:18:50 +0200
Message-ID: <CAHp75VfHiKqjaEKPGa=ymmsu44AMB5FCNKFEKhDeazW5vWZkBg@mail.gmail.com>
Subject: Re: [PATCH 2/2 v5] iio: Add SEMTECH SX9310/9311 sensor driver
To:     Daniel Campello <campello@chromium.org>
Cc:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Enrico Granata <egranata@chromium.org>,
        Andreas Klinger <ak@it-klinger.de>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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

On Mon, Mar 23, 2020 at 8:46 PM Daniel Campello <campello@chromium.org> wrote:
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

...

> +#include <linux/acpi.h>

> +#include <linux/of.h>

No users for these (see ID table handling below), but property.h would
be needed.

...

> +#define   SX9310_EVENT_IRQ                             (SX9310_FAR_IRQ | \
> +                                                        SX9310_CLOSE_IRQ)

Better formatting is
#define FOO \
  (BAR | ZOO)

...

> +struct sx9310_data {

> +       struct i2c_client *client;

Do you really need client? Perhaps struct device will be enough?

> +       struct iio_trigger *trig;
> +       struct regmap *regmap;
> +       /*
> +        * Last reading of the proximity status for each channel.
> +        * We only send an event to user space when this changes.
> +        */
> +       bool prox_stat[SX9310_NUM_CHANNELS];
> +       bool trigger_enabled;

> +       __be16 buffer[SX9310_NUM_CHANNELS +
> +                     4]; /* 64-bit data + 64-bit timestamp */

Please, fix formatting.

> +};

...

> +static int sx9310_update_chan_en(struct sx9310_data *data,
> +                                unsigned int chan_read,
> +                                unsigned int chan_event)
> +{
> +       int ret;
> +

> +       if ((data->chan_read | data->chan_event) != (chan_read | chan_event)) {
> +               ret = regmap_update_bits(data->regmap, SX9310_REG_PROX_CTRL0,
> +                                        SX9310_CHAN_ENABLED_MASK,
> +                                        chan_read | chan_event);

unsigned int readevent = chan_read | chan_event;
...
if (... != readevent) {
  ..., readevent);
}

> +               if (ret)
> +                       return ret;
> +       }
> +       data->chan_read = chan_read;
> +       data->chan_event = chan_event;
> +       return 0;
> +}

...

> +static int sx9310_read_prox_data(struct sx9310_data *data,
> +                                const struct iio_chan_spec *chan, __be16 *val)
> +{
> +       int ret;
> +
> +       ret = regmap_write(data->regmap, SX9310_REG_SENSOR_SEL, chan->channel);
> +       if (ret < 0)
> +               return ret;
> +

> +       return regmap_bulk_read(data->regmap, chan->address, val, 2);

sizeof()?

> +}

...

> +       if (data->client->irq > 0) {
> +               ret = wait_for_completion_interruptible(&data->completion);
> +               reinit_completion(&data->completion);

Logically reinit better to be called before you start measurement.

> +       } else {
> +               ret = sx9310_wait_for_sample(data);
> +       }

...

> +       *val = sign_extend32(be16_to_cpu(rawval),
> +                            (chan->address == SX9310_REG_DIFF_MSB ? 11 : 15));

Too many parentheses.

...

> +       mutex_lock(&data->mutex);
> +
> +       ret = regmap_update_bits(data->regmap, SX9310_REG_PROX_CTRL0,
> +                                SX9310_SCAN_PERIOD_MASK,
> +                                i << SX9310_SCAN_PERIOD_SHIFT);
> +
> +       mutex_unlock(&data->mutex);

Btw, can you use locking provided by regmap?

...

> +       /*
> +        * Even if no event is enabled, we need to wake the thread to

> +        * clear the interrupt state by reading SX9310_REG_IRQ_SRC.  It

Move it to the next line.

> +        * is not possible to do that here because regmap_read takes a
> +        * mutex.
> +        */

...

> +       for (chan = 0; chan < SX9310_NUM_CHANNELS; chan++) {
> +               int dir;
> +               u64 ev;
> +               bool new_prox = val & BIT(chan);
> +

> +               if (!(data->chan_event & BIT(chan)))
> +                       continue;

for_each_set_bit()

> +               if (new_prox == data->prox_stat[chan])
> +                       /* No change on this channel. */
> +                       continue;

> +       }

...

> +static struct attribute *sx9310_attributes[] = {
> +       &iio_dev_attr_sampling_frequency_available.dev_attr.attr,

> +       NULL,

Comma is not needed for terminator.

> +};

...

> +static int sx9310_buffer_preenable(struct iio_dev *indio_dev)
> +{
> +       struct sx9310_data *data = iio_priv(indio_dev);
> +       unsigned int channels = 0;
> +       int bit, ret;
> +
> +       mutex_lock(&data->mutex);
> +       for_each_set_bit(bit, indio_dev->active_scan_mask,
> +                        indio_dev->masklength)

> +               channels |= BIT(indio_dev->channels[bit].channel);

unsigned long channels;
...
__set_bit(...);

> +       ret = sx9310_update_chan_en(data, channels, data->chan_event);
> +       mutex_unlock(&data->mutex);
> +       return ret;
> +}

...

> +#define SX_INIT(_reg, _def)                    \
> +       {                                       \
> +               .reg = SX9310_REG_##_reg,       \
> +               .def = _def,                    \
> +       }

Usually it's a good tone to #undef custom macro when they are not
needed anymore.

...

> +       for (i = 100; i >= 0; i--) {
> +               msleep(20);
> +               ret = regmap_read(data->regmap, SX9310_REG_STAT1, &val);
> +               if (ret < 0)
> +                       goto out;
> +               if (!(val & SX9310_COMPSTAT_MASK))
> +                       break;
> +       }

NIH of regmap_real_poll_timeout();

> +
> +       if (i < 0) {
> +               dev_err(&data->client->dev,
> +                       "initial compensation timed out: 0x%02x", val);
> +               ret = -ETIMEDOUT;
> +       }

...

> +               ret = regmap_write(data->regmap, initval->reg, initval->def);
> +               if (ret < 0)

Do you need all these ' < 0'?

> +                       return ret;

...

> +       const struct acpi_device_id *acpi_id;

> +       /* id will be NULL when enumerated via ACPI */
> +       if (id) {
> +               if (id->driver_data != whoami)
> +                       dev_err(dev, "WHOAMI does not match i2c_device_id: %s",
> +                               id->name);
> +       } else if (ACPI_HANDLE(dev)) {
> +               acpi_id = acpi_match_device(dev->driver->acpi_match_table, dev);
> +               if (!acpi_id)
> +                       return -ENODEV;
> +               if (acpi_id->driver_data != whoami)
> +                       dev_err(dev, "WHOAMI does not match acpi_device_id: %s",
> +                               acpi_id->id);
> +       } else
> +               return -ENODEV;

device_get_match_data().

...

> +static int sx9310_probe(struct i2c_client *client,
> +                       const struct i2c_device_id *id)

Can you switch to ->probe_new()?

...

> +       indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));

> +       if (indio_dev == NULL)

if (!indio_dev)

> +               return -ENOMEM;

...

> +               dev_err(&client->dev, "error in reading WHOAMI register: %d",
> +                       ret);

If you introduce temporary variable the code will be better to read

  struct device *dev = &client->dev;

> +       ret = sx9310_set_indio_dev_name(&client->dev, indio_dev, id,
> +                                       data->whoami);
> +       if (ret < 0)
> +               return ret;

...

> +static const struct acpi_device_id sx9310_acpi_match[] = {
> +       { "STH9310", SX9310_WHOAMI_VALUE },
> +       { "STH9311", SX9311_WHOAMI_VALUE },

Hmm... May I ask some official proof that these IDs are real and
issued by vendor?

> +       {},

No comma.

> +};
> +MODULE_DEVICE_TABLE(acpi, sx9310_acpi_match);

> +static const struct of_device_id sx9310_of_match[] = {
> +       { .compatible = "semtech,sx9310" },
> +       { .compatible = "semtech,sx9311" },

> +       {},

No comma.

> +};
> +MODULE_DEVICE_TABLE(of, sx9310_of_match);
> +
> +static const struct i2c_device_id sx9310_id[] = {
> +       { "sx9310", SX9310_WHOAMI_VALUE },
> +       { "sx9311", SX9311_WHOAMI_VALUE },

> +       {},

No comma.

> +};
> +MODULE_DEVICE_TABLE(i2c, sx9310_id);

...

> +               .acpi_match_table = ACPI_PTR(sx9310_acpi_match),
> +               .of_match_table = of_match_ptr(sx9310_of_match),

Drop these macros. You probably didn't test with !ACPI and/or !OF --
should be compiler warning.

> +               .pm = &sx9310_pm_ops,
> +       },

--
With Best Regards,
Andy Shevchenko
