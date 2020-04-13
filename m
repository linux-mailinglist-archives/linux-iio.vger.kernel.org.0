Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBB841A6F82
	for <lists+linux-iio@lfdr.de>; Tue, 14 Apr 2020 00:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389790AbgDMW4E (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Apr 2020 18:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389783AbgDMW4E (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Apr 2020 18:56:04 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BEB7C0A3BDC
        for <linux-iio@vger.kernel.org>; Mon, 13 Apr 2020 15:56:04 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id a201so11481411wme.1
        for <linux-iio@vger.kernel.org>; Mon, 13 Apr 2020 15:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZYb2xyyK34AHj1wuqeYQRNe2+9C0Lwfb/jwvKLoKivU=;
        b=NcEgAJZza0lV54OpXzN20vk6d4aZiQyolxsl97TbKiim+DfGNIRwR3L2qpxhASTUmZ
         bcYyEpwoieRgeLwO+NOp/Ba6TtbKrzehz/9+KGwimK88oO32slq9XZTdQTzcF+ZStdBS
         BT7qAP1NnY1c2WnhB+9sl1pgJATksCuweUNHi74++ZnZDCIngskWmeetWyz/nlfZJ7ye
         FH8+KVkCW1byeiWXPMHJiv6O7XBotafdEl8S970Z7pY7wo0xjiCzXGe9NCqHiZncCxdL
         4E5OfFHklSnDWbS67K8x3Vt//AxZnxyNhe6bZDAgc6U276m/i8eGg/uU32hbYNT1nIPz
         lYyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZYb2xyyK34AHj1wuqeYQRNe2+9C0Lwfb/jwvKLoKivU=;
        b=Wy5uTjKpB0Zrc70Ny2Z14kZ4xcOV7MUvG9ubwKm2/JTLCcJ+8rP8u77NXoS8hJSmr1
         qnctgPZRwQfXGSvMYDkvNoWAuPoFIr+cr2dtrkMO2gAWZG3auVz+xqsjVGgzYgPlPhm/
         qbn4POC16TNzNFKKQwZ+K2ld7creXEebpCMM2ueuKyof1NjIKYkgBHwN1Po+KFEM6ZeZ
         y4E2dWI1/hwQeiOd9sDvzBVtd1kZ86gU23pRg/yA2o59ExwAmvBcSUGEq+wVzL0yIH0/
         VmoPJ4nhgKUhmrI1YQ1+mUZiscbSjJ6J9HOirP0HS1C6blj/GesVLxTQNHjCemmD18rI
         UuLg==
X-Gm-Message-State: AGi0PuYWtP8i5B5NFt2CuRpFim9ol2nPOU2k2XeNR77M/R8cyT58l3jP
        osskCXDBo82GRXGnFO/iHXTcBi81M5S6wDc22qbANg==
X-Google-Smtp-Source: APiQypLR5SaotXptORibWN/5tEVa9d5IGmq4nKQh/D6ETDAwrPKkUkhD/CVqVr4hcW7v0mYfI/Owgo0CmF7bX+OvOtY=
X-Received: by 2002:a1c:4603:: with SMTP id t3mr20433969wma.103.1586818562710;
 Mon, 13 Apr 2020 15:56:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200408175058.2.I1f56fe698017f22d6e825c913c256d5afc2ad69f@changeid>
 <CAHp75VcuPoVK_+KV+88Di1dUFZ9S8-1nNqo2s8a_n3vgSMoecg@mail.gmail.com>
In-Reply-To: <CAHp75VcuPoVK_+KV+88Di1dUFZ9S8-1nNqo2s8a_n3vgSMoecg@mail.gmail.com>
From:   Daniel Campello <campello@google.com>
Date:   Mon, 13 Apr 2020 16:55:26 -0600
Message-ID: <CAHcu+VZMiFVt9L9kNCTtsmxUP-7tO+pBpCOtMHQPotuye_2w1A@mail.gmail.com>
Subject: Re: [PATCH 2/2 v8] iio: Add SEMTECH SX9310/9311 sensor driver
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
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

On Fri, Apr 10, 2020 at 4:52 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> One side note. Whenever you prepare patches do the following:
> - use -v<n> to git-format-patch to versioning it by using standard
> template (<n> is a version number)
> - use --thread to make messages in one bunch
> - resend entire series
> - do not send patches more often than once per 24 hours
>
Thanks for the feedback
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
This patch was initially developed by Gwendal and Enrico (here:
crrev.com/c/1089826).
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
Yes, they indead use MSK.
>
> > +#define   SX9310_CONVDONE_IRQ                          BIT(3)
> > +#define   SX9310_FAR_IRQ                               BIT(5)
> > +#define   SX9310_CLOSE_IRQ                             BIT(6)
>
> > +#define   SX9310_EVENT_IRQ             (SX9310_FAR_IRQ | SX9310_CLOSE_IRQ)
>
> Is it listed in hardware, or simple an addition to have it easier to
> handle in the code?
It was an addition, removed in v9
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

Thank you for the review,
Daniel Campello
