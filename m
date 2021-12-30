Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49589481DCE
	for <lists+linux-iio@lfdr.de>; Thu, 30 Dec 2021 16:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238070AbhL3PrN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 Dec 2021 10:47:13 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:37520 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbhL3PrN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Dec 2021 10:47:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 802B86163C
        for <linux-iio@vger.kernel.org>; Thu, 30 Dec 2021 15:47:12 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id 7E903C36AEB;
        Thu, 30 Dec 2021 15:47:09 +0000 (UTC)
Date:   Thu, 30 Dec 2021 15:52:55 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v8 3/5] iio: proximity: Add SX9324 support
Message-ID: <20211230155255.7c9630b3@jic23-huawei>
In-Reply-To: <CAPUE2uvzPk7dRVHLNr-br+oKJW0Fmhbs-Y8QPfoQUuKztoQwkg@mail.gmail.com>
References: <20211218001755.3096807-1-gwendal@chromium.org>
        <20211218001755.3096807-4-gwendal@chromium.org>
        <CAHp75Vds5z2cBfWA3ZMaeQQQx_8YJuXWUvyU-SMdBiMWe4phrQ@mail.gmail.com>
        <CAPUE2uvzPk7dRVHLNr-br+oKJW0Fmhbs-Y8QPfoQUuKztoQwkg@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 29 Dec 2021 20:42:58 -0800
Gwendal Grignou <gwendal@chromium.org> wrote:

> On Sat, Dec 18, 2021 at 8:08 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> >
> > On Sat, Dec 18, 2021 at 11:58 AM Gwendal Grignou <gwendal@chromium.org> wrote:  
> > >
> > > Semtech SAR sensor SX9324 is an evolution of the SX9310:
> > > It has 4 phases that can be configure to capture and process data
> > > from any of 3 CS pins and provide independent detection:
> > > proximity, table proximity or body proximity.
> > >
> > > Gather antenna data:  
> >  
> > > echo sx9324-dev3 > trigger/current_trigger
> > > echo 1 > scan_elements/in_proximity0_en
> > > echo 1 > buffer/enable
> > > od -v -An --endian=big -t d2 -w2 /dev/iio\:device3  
> >
> > Can you shift this right by two spaces?  
> Done
> >  
> > > (at 10Hz, the default).
> > >
> > > Trigger events:
> > > Setting:  
> >  
> > > thresh_falling_period: 2 (events)
> > > thresh_rising_period: 2 (events)
> > > in_proximity0_thresh_either_value: 300
> > > in_proximity0_thresh_either_hysteresis: 72  
> >
> > Ditto.
> >  
> > > using iio_event_monitor /dev/iio\:deviceX, approaching my hand to the
> > > antenna pad, I see:
> > > ...
> > > Event: time: 1634763907532035297, type: proximity, channel: 0, evtype:
> > > thresh, direction: falling
> > > Event: time: 1634763910138104640, type: proximity, channel: 0, evtype:
> > > thresh, direction: rising  
> >
> > ...
> >  
> > > + * Based on SX9324 driver and copy of datasheet at:
> > > + * https://edit.wpgdadawant.com/uploads/news_file/program/2019/30184/tech_files/program_30184_suggest_other_file.pdf  
> >
> > Can you provide the link to the datasheet as Datasheet: tag?  
> Done.
> >
> > ...
> >  
> > > +       for (i = 0; i < SX9324_NUM_PINS; i++) {
> > > +               pin_idx = (val & SX9324_REG_AFE_PH0_PIN_MASK(i)) >> (2 * i);  
> >
> >  
> > > +               len += scnprintf(buf + len, PAGE_SIZE - len, "%s,",  
> >
> > Shouldn't this be sysfs_emit_at()?  
> Done (and for other snprintf in sx9360 as well).
> >  
> > > +                                sx9324_cs_pin_usage[pin_idx]);
> > > +       }  
> >
> > ...
> >  
> > > +       *val = 1 << FIELD_GET(SX9324_REG_PROX_CTRL0_GAIN_MASK, regval);  
> >
> > Hmm... perhaps BIT()?  
> I prefer to use '1 <<' explicitly, as val is a physical number, not a
> bit in a bitfield.
> >
> > ...
> >  
> > > +       switch (mask) {
> > > +       case IIO_CHAN_INFO_HARDWAREGAIN:
> > > +               *type = IIO_VAL_INT;
> > > +               *length = ARRAY_SIZE(sx9324_gain_vals);
> > > +               *vals = sx9324_gain_vals;
> > > +               return IIO_AVAIL_LIST;
> > > +       case IIO_CHAN_INFO_SAMP_FREQ:
> > > +               *type = IIO_VAL_INT_PLUS_MICRO;
> > > +               *length = ARRAY_SIZE(sx9324_samp_freq_table) * 2;
> > > +               *vals = (int *)sx9324_samp_freq_table;
> > > +               return IIO_AVAIL_LIST;
> > > +       }
> > > +
> > > +       return -EINVAL;  
> >
> > Make it the default case?  
> Done. Fixed sx9360 as well.
> >
> > ...
> >  
> > > +       regval = FIELD_GET(SX9324_REG_PROX_CTRL5_FAR_DEBOUNCE_MASK, regval);
> > > +       if (regval)
> > > +               *val = 1 << regval;  
> >
> > BIT() ?  
> I prefer to use '1 <<' explicitly, as val is a physical number, not a
> bit in a bitfield.
> >  
> > > +       else
> > > +               *val = 0;  
> >
> > ...
> >  
> > > +       regval = FIELD_GET(SX9324_REG_PROX_CTRL5_CLOSE_DEBOUNCE_MASK, regval);
> > > +       if (regval)
> > > +               *val = 1 << regval;  
> >
> > Ditto?
> >  
> > > +       else
> > > +               *val = 0;  
> >
> > ...
> >  
> > > +       switch (mask) {
> > > +       case IIO_CHAN_INFO_SAMP_FREQ:
> > > +               return sx9324_set_samp_freq(data, val, val2);
> > > +       case IIO_CHAN_INFO_HARDWAREGAIN:
> > > +               return sx9324_write_gain(data, chan, val);
> > > +       }
> > > +
> > > +       return -EINVAL;  
> >
> > In some cases you have default in some not, can it be consistent?  
> Done.
> >
> > ...
> >  
> > > +               dev_err(&data->client->dev,
> > > +                       "initial compensation timed out: 0x%02x\n",
> > > +                       val);  
> >
> > Isn't it what user space will get anyway?  
> Remove similar dev_err call in other drivers as well.
> >
> > ...
> >  
> > > +static const struct acpi_device_id sx9324_acpi_match[] = {
> > > +       { "STH9324", SX9324_WHOAMI_VALUE},  
> >
> > Missed whitespace?  
> Done. Note `checkpatch.pl --strict` does not complain, and not having
> whitespace in tables is widespread:
> grep -re "[0-9A-Za-z]}" drivers/iio/ | wc -l
> 1239

Hohum. We should clean those up at somepoint to avoid cut and paste
into more drivers.  Definitely worth cleaning up the inconsistent ones
like this. Bit more doubtful on the ones that don't put a space after
the { as well.

Maybe I'll get really bored sometime soon and tidy these up.  Patches
of course welcome in the meantime!

Jonathan

