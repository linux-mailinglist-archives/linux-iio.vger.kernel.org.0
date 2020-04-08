Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C90A91A2AF2
	for <lists+linux-iio@lfdr.de>; Wed,  8 Apr 2020 23:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728221AbgDHVUI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 8 Apr 2020 17:20:08 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34191 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729540AbgDHVUI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 8 Apr 2020 17:20:08 -0400
Received: by mail-wm1-f66.google.com with SMTP id c195so1020318wme.1
        for <linux-iio@vger.kernel.org>; Wed, 08 Apr 2020 14:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mlooLY7Sz99r4w5SxW3vhlXWplWMMsvRGvuuen3K1G4=;
        b=dN4B/PDUnB4ESD02bEyepRx8xOEgSxpQkBnOn1PcFRiLJHlhzDqu+5FzsTHHtqwmyu
         p0t1WW1FOGeUBGOvvWYNRZOM7PPegLuwU3C02BYEmf39qCifISHTYbOE//7hXGTkvULF
         69CBbB0SZnHe15+XLIEJwmIbv7QeXPZ+VIhdQ9yYEoUNLe/scixvX+TEHrnNVitj3oD2
         aPU2mOKUTycAypK/EIINnP3sRPGb5j67LPA3abnn6YqD3bZT1fEtoMpur7YkoaBr8ucR
         ZsgSHpx+NkPj+kkMao8gKvAfQNiTq6eGyaarUtfHNr85qgPoOUmiDq/KTtEugZoamFbW
         dFOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mlooLY7Sz99r4w5SxW3vhlXWplWMMsvRGvuuen3K1G4=;
        b=DHvgwVfEatfJBcGc9YhZLNKn181C3skl/QUY3m6etxQjgIG4mskGJ/R0Mf0db0sT60
         jku/KBEfYqjERO72uP6Et6YVZOyZMkLGC6MM9dqFLy52RifEPuhImkR+jiuPSORAYArC
         hIjdqa968/RFjuvEw2zkBIGdt7veuGHYgbXsGJhK1JLvpxRi6cR7DuGnGG+2Gf46uWfG
         1kqMlkvN8Gr8iQ/tgdXI46LBtg9WMxJPpVmoVg9Wi5JnX+MKu5bmcFprz43KCSyHb8bJ
         vfEMjH+Bt/RqKzJnBO4PubvMPHB5exwcbm4+sHsG9/u7dKXv3qJoK8KeVKS6+XDQmTKE
         34lQ==
X-Gm-Message-State: AGi0PubmagzabtvX8cOIxHhrfypw7m57gxlYBsr1E/vS3Zm4ulVHyur3
        z0YSbhVfXiQ+/YhIyABhUdbzGJddAVlkZyGdmzJPCw==
X-Google-Smtp-Source: APiQypKhHUwAsJjYzyYB5VHXHzMmc8iH+YM/uo2cJCDxrNfExZKJ40xBSX/01K7muRDVNEhwkWslWZLPCv77qbEK1j4=
X-Received: by 2002:adf:e282:: with SMTP id v2mr10444096wri.329.1586380803307;
 Wed, 08 Apr 2020 14:20:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200323124310.1.I6ed779cd21abf3e70f21c1562bbda81f590976ab@changeid>
 <20200323124310.2.I1f56fe698017f22d6e825c913c256d5afc2ad69f@changeid> <CAHp75VfHiKqjaEKPGa=ymmsu44AMB5FCNKFEKhDeazW5vWZkBg@mail.gmail.com>
In-Reply-To: <CAHp75VfHiKqjaEKPGa=ymmsu44AMB5FCNKFEKhDeazW5vWZkBg@mail.gmail.com>
From:   Daniel Campello <campello@google.com>
Date:   Wed, 8 Apr 2020 15:19:26 -0600
Message-ID: <CAHcu+VZW_giesTmJRoy35b7-6V04BW8Npgz+GAN6NSYH81ZYZQ@mail.gmail.com>
Subject: Re: [PATCH 2/2 v5] iio: Add SEMTECH SX9310/9311 sensor driver
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
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

On Tue, Mar 24, 2020 at 10:18 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Mon, Mar 23, 2020 at 8:46 PM Daniel Campello <campello@chromium.org> wrote:
> >
> > Add SEMTECH SX9310/9311 driver.
> >
> > The device has the following entry points:
> >
> > Usual frequency:
> > - sampling_frequency
> > - sampling_frequency_available
> >
> > Instant reading of current values for different sensors:
> > - in_proximity0_raw
> > - in_proximity1_raw
> > - in_proximity2_raw
> > - in_proximity3_comb_raw
> > and associated events in events/
>
> ...
>
> > +#include <linux/acpi.h>
>
> > +#include <linux/of.h>
>
> No users for these (see ID table handling below), but property.h would
> be needed.
>
>

I removed of.h but kept acpi.h in v6 since it was needed for other
ACPI macros on the probe function
>
> ...
>
> > +#define   SX9310_EVENT_IRQ                             (SX9310_FAR_IRQ | \
> > +                                                        SX9310_CLOSE_IRQ)
>
> Better formatting is
> #define FOO \
>   (BAR | ZOO)
>
> ...
>
> > +struct sx9310_data {
>
> > +       struct i2c_client *client;
>
> Do you really need client? Perhaps struct device will be enough?


There are references to client->irq in some places

>
>
> > +       struct iio_trigger *trig;
> > +       struct regmap *regmap;
> > +       /*
> > +        * Last reading of the proximity status for each channel.
> > +        * We only send an event to user space when this changes.
> > +        */
> > +       bool prox_stat[SX9310_NUM_CHANNELS];
> > +       bool trigger_enabled;
>
> > +       __be16 buffer[SX9310_NUM_CHANNELS +
> > +                     4]; /* 64-bit data + 64-bit timestamp */
>
> Please, fix formatting.
>
> > +};
>
> ...
>
> > +static int sx9310_update_chan_en(struct sx9310_data *data,
> > +                                unsigned int chan_read,
> > +                                unsigned int chan_event)
> > +{
> > +       int ret;
> > +
>
> > +       if ((data->chan_read | data->chan_event) != (chan_read | chan_event)) {
> > +               ret = regmap_update_bits(data->regmap, SX9310_REG_PROX_CTRL0,
> > +                                        SX9310_CHAN_ENABLED_MASK,
> > +                                        chan_read | chan_event);
>
> unsigned int readevent = chan_read | chan_event;
> ...
> if (... != readevent) {
>   ..., readevent);
> }
>
> > +               if (ret)
> > +                       return ret;
> > +       }
> > +       data->chan_read = chan_read;
> > +       data->chan_event = chan_event;
> > +       return 0;
> > +}
>
> ...
>
> > +static int sx9310_read_prox_data(struct sx9310_data *data,
> > +                                const struct iio_chan_spec *chan, __be16 *val)
> > +{
> > +       int ret;
> > +
> > +       ret = regmap_write(data->regmap, SX9310_REG_SENSOR_SEL, chan->channel);
> > +       if (ret < 0)
> > +               return ret;
> > +
>
> > +       return regmap_bulk_read(data->regmap, chan->address, val, 2);
>
> sizeof()?
>
> > +}
>
> ...
>
> > +       if (data->client->irq > 0) {
> > +               ret = wait_for_completion_interruptible(&data->completion);
> > +               reinit_completion(&data->completion);
>
> Logically reinit better to be called before you start measurement.
>
I think this is effectively before measurement, minus error/locking handling.

> > +       } else {
> > +               ret = sx9310_wait_for_sample(data);
> > +       }
>
> ...
>
> > +       *val = sign_extend32(be16_to_cpu(rawval),
> > +                            (chan->address == SX9310_REG_DIFF_MSB ? 11 : 15));
>
> Too many parentheses.
>
> ...
>
> > +       mutex_lock(&data->mutex);
> > +
> > +       ret = regmap_update_bits(data->regmap, SX9310_REG_PROX_CTRL0,
> > +                                SX9310_SCAN_PERIOD_MASK,
> > +                                i << SX9310_SCAN_PERIOD_SHIFT);
> > +
> > +       mutex_unlock(&data->mutex);
>
> Btw, can you use locking provided by regmap?


The lock is protecting critical sections that include multiple regmap
and other operations together in other parts of the code.
>
>
> ...
>
> > +       /*
> > +        * Even if no event is enabled, we need to wake the thread to
>
> > +        * clear the interrupt state by reading SX9310_REG_IRQ_SRC.  It
>
> Move it to the next line.
>
> > +        * is not possible to do that here because regmap_read takes a
> > +        * mutex.
> > +        */
>
> ...
>
> > +       for (chan = 0; chan < SX9310_NUM_CHANNELS; chan++) {
> > +               int dir;
> > +               u64 ev;
> > +               bool new_prox = val & BIT(chan);
> > +
>
> > +               if (!(data->chan_event & BIT(chan)))
> > +                       continue;
>
> for_each_set_bit()


Thanks, more clear now!
>
>
> > +               if (new_prox == data->prox_stat[chan])
> > +                       /* No change on this channel. */
> > +                       continue;
>
> > +       }
>
> ...
>
> > +static struct attribute *sx9310_attributes[] = {
> > +       &iio_dev_attr_sampling_frequency_available.dev_attr.attr,
>
> > +       NULL,
>
> Comma is not needed for terminator.
>
> > +};
>
> ...
>
> > +static int sx9310_buffer_preenable(struct iio_dev *indio_dev)
> > +{
> > +       struct sx9310_data *data = iio_priv(indio_dev);
> > +       unsigned int channels = 0;
> > +       int bit, ret;
> > +
> > +       mutex_lock(&data->mutex);
> > +       for_each_set_bit(bit, indio_dev->active_scan_mask,
> > +                        indio_dev->masklength)
>
> > +               channels |= BIT(indio_dev->channels[bit].channel);
>
> unsigned long channels;
> ...
> __set_bit(...);
>
> > +       ret = sx9310_update_chan_en(data, channels, data->chan_event);
> > +       mutex_unlock(&data->mutex);
> > +       return ret;
> > +}
>
> ...
>
> > +#define SX_INIT(_reg, _def)                    \
> > +       {                                       \
> > +               .reg = SX9310_REG_##_reg,       \
> > +               .def = _def,                    \
> > +       }
>
> Usually it's a good tone to #undef custom macro when they are not
> needed anymore.
>
> ...
>
> > +       for (i = 100; i >= 0; i--) {
> > +               msleep(20);
> > +               ret = regmap_read(data->regmap, SX9310_REG_STAT1, &val);
> > +               if (ret < 0)
> > +                       goto out;
> > +               if (!(val & SX9310_COMPSTAT_MASK))
> > +                       break;
> > +       }
>
> NIH of regmap_real_poll_timeout();


Sorry, somehow I overlooked this on v6, I'll send v7 with it

>
>
> > +
> > +       if (i < 0) {
> > +               dev_err(&data->client->dev,
> > +                       "initial compensation timed out: 0x%02x", val);
> > +               ret = -ETIMEDOUT;
> > +       }
>
> ...
>
> > +               ret = regmap_write(data->regmap, initval->reg, initval->def);
> > +               if (ret < 0)
>
> Do you need all these ' < 0'?


Not sure what do you mean? This one in particular is trying to fail
fast the probe
>
>
> > +                       return ret;
>
> ...
>
> > +       const struct acpi_device_id *acpi_id;
>
> > +       /* id will be NULL when enumerated via ACPI */
> > +       if (id) {
> > +               if (id->driver_data != whoami)
> > +                       dev_err(dev, "WHOAMI does not match i2c_device_id: %s",
> > +                               id->name);
> > +       } else if (ACPI_HANDLE(dev)) {
> > +               acpi_id = acpi_match_device(dev->driver->acpi_match_table, dev);
> > +               if (!acpi_id)
> > +                       return -ENODEV;
> > +               if (acpi_id->driver_data != whoami)
> > +                       dev_err(dev, "WHOAMI does not match acpi_device_id: %s",
> > +                               acpi_id->id);
> > +       } else
> > +               return -ENODEV;
>
> device_get_match_data().
>
THANKS! I was happy to learn about this after you pointed it out!
>
> ...
>
> > +static int sx9310_probe(struct i2c_client *client,
> > +                       const struct i2c_device_id *id)
>
> Can you switch to ->probe_new()?
>
> ...
>
> > +       indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
>
> > +       if (indio_dev == NULL)
>
> if (!indio_dev)
>
> > +               return -ENOMEM;
>
> ...
>
> > +               dev_err(&client->dev, "error in reading WHOAMI register: %d",
> > +                       ret);
>
> If you introduce temporary variable the code will be better to read
>
>   struct device *dev = &client->dev;
>
> > +       ret = sx9310_set_indio_dev_name(&client->dev, indio_dev, id,
> > +                                       data->whoami);
> > +       if (ret < 0)
> > +               return ret;
>
> ...
>
> > +static const struct acpi_device_id sx9310_acpi_match[] = {
> > +       { "STH9310", SX9310_WHOAMI_VALUE },
> > +       { "STH9311", SX9311_WHOAMI_VALUE },
>
> Hmm... May I ask some official proof that these IDs are real and
> issued by vendor?


Not sure how to prove this but they are live in device firmware right
now. One example:
https://chromium.googlesource.com/chromiumos/third_party/coreboot/+/b905beb46935c114ebc416583bb2e5407183af35/src/mainboard/google/zoombini/variants/meowth/devicetree.cb
>
>
> > +       {},
>
> No comma.
>
> > +};
> > +MODULE_DEVICE_TABLE(acpi, sx9310_acpi_match);
>
> > +static const struct of_device_id sx9310_of_match[] = {
> > +       { .compatible = "semtech,sx9310" },
> > +       { .compatible = "semtech,sx9311" },
>
> > +       {},
>
> No comma.
>
> > +};
> > +MODULE_DEVICE_TABLE(of, sx9310_of_match);
> > +
> > +static const struct i2c_device_id sx9310_id[] = {
> > +       { "sx9310", SX9310_WHOAMI_VALUE },
> > +       { "sx9311", SX9311_WHOAMI_VALUE },
>
> > +       {},
>
> No comma.
>
> > +};
> > +MODULE_DEVICE_TABLE(i2c, sx9310_id);
>
> ...
>
> > +               .acpi_match_table = ACPI_PTR(sx9310_acpi_match),
> > +               .of_match_table = of_match_ptr(sx9310_of_match),
>
> Drop these macros. You probably didn't test with !ACPI and/or !OF --
> should be compiler warning.


Why do we want to drop these? I tried compiling with either and both
disabled and did not see a warning on my system.
>
>
> > +               .pm = &sx9310_pm_ops,
> > +       },
>
> --
> With Best Regards,
> Andy Shevchenko

Thanks for the review. Sorry for the delay on this email after sending v6.

Regards,
Daniel
