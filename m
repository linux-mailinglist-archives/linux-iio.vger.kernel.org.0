Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 965C91A5E1F
	for <lists+linux-iio@lfdr.de>; Sun, 12 Apr 2020 12:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgDLK45 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 12 Apr 2020 06:56:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:51116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726043AbgDLK44 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 12 Apr 2020 06:56:56 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FD41206DA;
        Sun, 12 Apr 2020 10:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586689015;
        bh=X3fEng+5biN0i5V0U5O+A5zlawcrsCFcufGJy9DUGmU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YMjHcv14QqrIEqk/Zr0tZsBfoApNMYDONx1fBb+edqxGs1cn+vmL1hi5/DY39m2gX
         qUSD7Xp6fnsZnBmMM5QtNZ7Vpg9Q1A7vQ7HDWH+6lCHOmIIK4e+liq4kvdrZE974OW
         j91MrbloJW3JSGAYsxd1o8AWZl457+lg2ZCxV+hg=
Date:   Sun, 12 Apr 2020 11:56:50 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Daniel Campello <campello@chromium.org>,
        LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Enrico Granata <egranata@chromium.org>,
        Andreas Klinger <ak@it-klinger.de>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 2/2 v8] iio: Add SEMTECH SX9310/9311 sensor driver
Message-ID: <20200412115650.5312f05e@archlinux>
In-Reply-To: <CAHp75VcuPoVK_+KV+88Di1dUFZ9S8-1nNqo2s8a_n3vgSMoecg@mail.gmail.com>
References: <20200408175058.2.I1f56fe698017f22d6e825c913c256d5afc2ad69f@changeid>
        <CAHp75VcuPoVK_+KV+88Di1dUFZ9S8-1nNqo2s8a_n3vgSMoecg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 10 Apr 2020 13:52:16 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> One side note. Whenever you prepare patches do the following:
> - use -v<n> to git-format-patch to versioning it by using standard
> template (<n> is a version number)
> - use --thread to make messages in one bunch
> - resend entire series
> - do not send patches more often than once per 24 hours

If no one replied to earlier thread and you are fixing up something
you noticed yourself, please also reply to that thread so that
no one accidentally reviews it when catching up on emails!

Jonathan

> 
> On Thu, Apr 9, 2020 at 2:54 AM Daniel Campello <campello@chromium.org> wrote:
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
> >
> > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> > Signed-off-by: Enrico Granata <egranata@chromium.org>  
> 
> This is not understandable. Are they who helped you develop the code
> (we have a special tag, i.e. Co-developed-by in addition to SoB), or
> just people in the middle? Then the question is, how come author is
> you and not Gwendal?
> 
> ...
> 
> > +What:          /sys/bus/iio/devices/iio:deviceX/in_proximity3_comb_raw  
> 
> > +Description:
> > +               Proximity measurement indicating that some object is
> > +               near the combined sensor. The combined sensor presents
> > +               proximity measurements constructed by hardware by
> > +               combining measurements taken from a given set of
> > +               physical sensors.  
> 
> I'm wondering if we rather have some standard tag across sensors for
> combined values.
> It's particular to proximity sensors only? Would it stay like this
> forever? Won't we come to the very heavy and noisy ABI if more sensors
> are gaining something like this?

It's the first instance I've ever seen of this particular oddity.
We have combined magic for cases like accelerometers where there is
maths involved (x^2 + y^2 + z^2) but this is a bit 'special'.
To be honest, I'm not sure what the point in actually doing it in a
design is.

So yes we are paying a price in ABI by doing this but until we have some
visibility of more sensors doing it, I'm not sure we can come up with a
general solution.

> 
> ...
> 
> > + * Copyright 2018 Google LLC.  
> 
> I remember you did changes in this year...
> Is your changes copyrighted by G company?
> 
> > + * Reworked April 2019 by Evan Green <evgreen@chromium.org>  
> 
> in April
> 
> > + * and January 2020 by Daniel Campello <campello@chromium.org>  
> 
> in January
> 
> And since it looks like a sentence, put period at the end of it.
> 
> ...
> 
> > +#include <linux/acpi.h>
> > +#include <linux/delay.h>
> > +#include <linux/i2c.h>
> > +#include <linux/irq.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/pm.h>
> > +#include <linux/regmap.h>
> > +#include <linux/slab.h>  
> 
> ...
> 
> > +#define SX9310_REG_IRQ_MSK                             0x03  
> 
> Is MSK abbreviation in datasheet? Please spell it how it's in datasheet.
> 
> > +#define   SX9310_CONVDONE_IRQ                          BIT(3)
> > +#define   SX9310_FAR_IRQ                               BIT(5)
> > +#define   SX9310_CLOSE_IRQ                             BIT(6)  
> 
> > +#define   SX9310_EVENT_IRQ             (SX9310_FAR_IRQ | SX9310_CLOSE_IRQ)  
> 
> Is it listed in hardware, or simple an addition to have it easier to
> handle in the code?
> 
> ...
> 
> > +#define   SX9310_REG_PROX_CTRL0_EN_MASK                        0x0F  
> 
> GENMASK()
> 
> ...
> 
> > +#define   SX9310_REG_PROX_CTRL2_COMBMODE_ALL           0x80  
> 
> BIT() ?
> 
> > +#define   SX9310_REG_PROX_CTRL2_SHIELDEN_DYNAMIC       0x04  
> 
> BIT() ?
> 
> If it is not a one bit value, better to use (value << shift) and
> perhaps mention other possibilities.
> But for current case looks like anyway BIT() macro can be suitable.
> 
> You can revisit all the rest definitions, but it's up to you, just try
> to be close to the datasheet.
> 
> ...
> 
> > +struct sx9310_data {  
> 
> > +       struct i2c_client *client;  
> 
> > +};  
> 
> ...
> 
> > +static ssize_t sx9310_show_samp_freq_avail(struct device *dev,
> > +                                          struct device_attribute *attr,
> > +                                          char *buf)
> > +{
> > +       size_t len = 0;
> > +       int i;
> > +
> > +       for (i = 0; i < ARRAY_SIZE(sx9310_samp_freq_table); i++)
> > +               len += scnprintf(buf + len, PAGE_SIZE - len, "%d.%d ",
> > +                                sx9310_samp_freq_table[i].val,
> > +                                sx9310_samp_freq_table[i].val2);
> > +       buf[len - 1] = '\n';
> > +       return len;
> > +}
> > +static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(sx9310_show_samp_freq_avail);  
> 
> Jonathan, what is the best practice now with this kind of output? I
> think that IIO core provides a unified format to out this.

Yeah.  I've been a bit lazy on pushing the read_avail callback other than
in cases where we need to provide in kernel access.  However, in this
particular case the code is replicating what the core does so would be
nice to switch to the avail callbacks if possible.

At somepoint I'll actually add good documentation on how to use those
then start being a lot fussier about moving over to them for new
code.  To do that I'd also want to convert a few drivers to give more
examples of the various options.  It's been on the todo list for a while
(that list is far too long!)

If anyone wants to take this task on they would be most welcome - however
this probably isn't one for a beginner!

Jonathan

> 
> ...
> 
> > +static int sx9310_read_prox_data(struct sx9310_data *data,
> > +                                const struct iio_chan_spec *chan, __be16 *val)
> > +{
> > +       int ret;
> > +
> > +       ret = regmap_write(data->regmap, SX9310_REG_SENSOR_SEL, chan->channel);  
> 
> > +       if (ret < 0)  
> 
> Do you need all these ' < 0' checks? Revisit code and drop where it's
> not needed, like here.
> 
> > +               return ret;
> > +
> > +       return regmap_bulk_read(data->regmap, chan->address, val,  
> 
> > +                               sizeof(__be16));  
> 
> sizeof(*val)
> 
> > +}  
> 
> ...
> 
> > +static int sx9310_read_proximity(struct sx9310_data *data,
> > +                                const struct iio_chan_spec *chan, int *val)
> > +{  
> 
> > +       int ret = 0;  
> 
> Unneede assignment.
> 
> > +       if (ret < 0)
> > +               goto out_disable_irq;  
> 
> And if the path was non-IRQ one do we need to call ..._disable_irq()?
> 
> > +       if (ret < 0)
> > +               goto out_disable_irq;  
> 
> Ditto.
> 
> > +       ret = sx9310_disable_irq(data, SX9310_CONVDONE_IRQ);
> > +       if (ret < 0)
> > +               goto out_put_channel;  
> 
> Ditto.
> 
> > +       return IIO_VAL_INT;
> > +
> > +out_disable_irq:
> > +       sx9310_disable_irq(data, SX9310_CONVDONE_IRQ);
> > +out_put_channel:
> > +       sx9310_put_read_channel(data, chan->channel);
> > +out:
> > +       mutex_unlock(&data->mutex);
> > +
> > +       return ret;
> > +}  
> 
> ...
> 
> > +static int sx9310_read_samp_freq(struct sx9310_data *data, int *val, int *val2)
> > +{
> > +       unsigned int regval;  
> 
> > +       int ret = regmap_read(data->regmap, SX9310_REG_PROX_CTRL0, &regval);  
> 
> Slightly better to assign exactly before use, i.e. below before if (ret).
> For now it's okay, but rationale is that if you need to inject some
> code in between in the future, this will become an additional burden.
> 
> > +       if (ret < 0)
> > +               return ret;  
> 
> > +}  
> 
> ...
> 
> > +       for_each_set_bit(chan, &data->chan_event, SX9310_NUM_CHANNELS) {
> > +               int dir;
> > +               u64 ev;  
> 
> > +               bool new_prox = val & BIT(chan);  
> 
> Similar: slightly better to assign before use.
> 
> > +
> > +               if (new_prox == data->prox_stat[chan])
> > +                       /* No change on this channel. */
> > +                       continue;  
> 
> > +       }  
> 
> ...
> 
> > +#define SX_INIT(_reg, _def)                    \
> > +       {                                       \
> > +               .reg = SX9310_REG_##_reg,       \
> > +               .def = _def,                    \
> > +       }  
> 
> I think this macro makes it harder to read, and better simple to put
> these initializers directly into below structure, but it's up to you.
> 
> ...
> 
> > +       ret = regmap_read_poll_timeout(data->regmap, SX9310_REG_STAT1, val,
> > +                                      !(val & SX9310_COMPSTAT_MASK), 20000,
> > +                                      2000000);
> > +       if (ret == -ETIMEDOUT)
> > +               dev_err(&data->client->dev,
> > +                       "initial compensation timed out: 0x%02x", val);
> > +  
> 
> > +       regmap_write(data->regmap, SX9310_REG_PROX_CTRL0, ctrl0);  
> 
> Even in timeout case?
> 
> > +       return ret;  
> 
> ...
> 
> > +       if ((long)device_get_match_data(dev) != whoami)  
> 
>   unsigned int long ddata;
> 
>   ddata = (uintptr_t)device_get_match_data(dev);
>   if (ddata != whoami)
>   ...
> 
> > +               dev_err(dev, "WHOAMI does not match device data: %d", whoami);  
> 
> If it's error, why not bail out here?
> Or i.o.w. what is the usefulness of the driver data?
> 
> > +       switch (whoami) {
> > +       case SX9310_WHOAMI_VALUE:
> > +               indio_dev->name = "sx9310";
> > +               break;
> > +       case SX9311_WHOAMI_VALUE:
> > +               indio_dev->name = "sx9311";
> > +               break;
> > +       default:
> > +               dev_err(dev, "unexpected WHOAMI response: %u", whoami);
> > +               return -ENODEV;
> > +       }  
> 
> ...
> 
> > +               data->trig = devm_iio_trigger_alloc(
> > +                       dev, "%s-dev%d", indio_dev->name, indio_dev->id);  
> 
> Indentation issues.
> 
> ...
> 
> > +       mutex_lock(&data->mutex);
> > +       ret = regmap_read(data->regmap, SX9310_REG_PROX_CTRL0,
> > +                         &data->suspend_ctrl0);  
> 
> > +  
> 
> Blank line in a wrong position?
> 
> > +       if (ret)
> > +               goto out;
> > +  
> 
> ...
> 
> > +       mutex_lock(&data->mutex);
> > +       ret = regmap_write(data->regmap, SX9310_REG_PAUSE, 1);
> > +       if (ret)
> > +               goto out;
> > +
> > +       ret = regmap_write(data->regmap, SX9310_REG_PROX_CTRL0,
> > +                          data->suspend_ctrl0);
> > +
> > +out:
> > +       mutex_unlock(&data->mutex);
> > +  
> 
> > +       enable_irq(data->client->irq);  
> 
> So, you enable IRQ despite the error. Why?
> 
> ...
> 
> > +static const struct dev_pm_ops sx9310_pm_ops = {
> > +       SET_SYSTEM_SLEEP_PM_OPS(sx9310_suspend, sx9310_resume)
> > +};  
> 
> ...
> 
> > +               .acpi_match_table = ACPI_PTR(sx9310_acpi_match),
> > +               .of_match_table = of_match_ptr(sx9310_of_match),  
> 
> Drop these macros. They more harmful than useful, i.e. you will get
> compiler warning.
> If you would like to use them, you have to guard ID tables with ugly ifdeffery.
> 
> 
> --
> With Best Regards,
> Andy Shevchenko

