Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87E96481963
	for <lists+linux-iio@lfdr.de>; Thu, 30 Dec 2021 05:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235868AbhL3EnL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 29 Dec 2021 23:43:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233962AbhL3EnL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 29 Dec 2021 23:43:11 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01E4C061574
        for <linux-iio@vger.kernel.org>; Wed, 29 Dec 2021 20:43:10 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id y70so28367108iof.2
        for <linux-iio@vger.kernel.org>; Wed, 29 Dec 2021 20:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8iNdDlPfkkJ/EPw6u08dpc2kDgy1rzKhGD/NotF+fHw=;
        b=mgQKF6ih4k3dInXBXJDAhWmH8ZiO1UG680k77leV5JYH5DuCFXCAL1iEo1hM1eMoj7
         yEZV11xVcRmrTL3SliMjat+6qL5lN0B3ZeQDwHkLDDFVkrdrxdPI6gaApFhJ3lCdyMMu
         U8ATXzVitQat7W02OjSw6KXDhWI2f4iUPMLBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8iNdDlPfkkJ/EPw6u08dpc2kDgy1rzKhGD/NotF+fHw=;
        b=pP1DX2WoRUfnasAyLYy+H0EO1WbU7FyPD0fJ9SdS7gzbMw+2lpzsUv7AZLOT/iR7aO
         MH4QBYxKQJvss4DdFCUSFB8C2mFqEgGuyG+OpCD4z8+wdZBGhqMBSgqsw2HSj3+APzoV
         K/bjNLtFHqAmLNJeGYSgl4Tn+wsinlpmqx1SbgU9KTXSA1513D+hA1Ira+DXozFvdpS3
         a9kqFRuwAHD1cKfVX/b9XtjLYTPLqFZZL550jJqLSG57AAj5R7IAk76nYkHezCyug8a9
         9sRK1MeX/KuOC9ceOhlX341BfBe+s9xnuK/RX5fU/xom7HOuagyfQ2uvKI25ECsxo/Cj
         tsCQ==
X-Gm-Message-State: AOAM531hKBHEf21ckGjGwN4YoB6Dk/+HI6xGczVBinf5vLz0CvYqhPmq
        762/UY/RolaFjt4EeSefk0H1oeYdSky38wrQgsBfWej+0As=
X-Google-Smtp-Source: ABdhPJxF6PVIFKusva3oA0r/lzl/RmC7I0bJIDSfQKrJxdrAHIpoCC4M8EI+8O10mXV82L/Q8VSfCJYIvcXQ2ukBhME=
X-Received: by 2002:a02:2aca:: with SMTP id w193mr13873073jaw.240.1640839390286;
 Wed, 29 Dec 2021 20:43:10 -0800 (PST)
MIME-Version: 1.0
References: <20211218001755.3096807-1-gwendal@chromium.org>
 <20211218001755.3096807-4-gwendal@chromium.org> <CAHp75Vds5z2cBfWA3ZMaeQQQx_8YJuXWUvyU-SMdBiMWe4phrQ@mail.gmail.com>
In-Reply-To: <CAHp75Vds5z2cBfWA3ZMaeQQQx_8YJuXWUvyU-SMdBiMWe4phrQ@mail.gmail.com>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Wed, 29 Dec 2021 20:42:58 -0800
Message-ID: <CAPUE2uvzPk7dRVHLNr-br+oKJW0Fmhbs-Y8QPfoQUuKztoQwkg@mail.gmail.com>
Subject: Re: [PATCH v8 3/5] iio: proximity: Add SX9324 support
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Dec 18, 2021 at 8:08 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Sat, Dec 18, 2021 at 11:58 AM Gwendal Grignou <gwendal@chromium.org> wrote:
> >
> > Semtech SAR sensor SX9324 is an evolution of the SX9310:
> > It has 4 phases that can be configure to capture and process data
> > from any of 3 CS pins and provide independent detection:
> > proximity, table proximity or body proximity.
> >
> > Gather antenna data:
>
> > echo sx9324-dev3 > trigger/current_trigger
> > echo 1 > scan_elements/in_proximity0_en
> > echo 1 > buffer/enable
> > od -v -An --endian=big -t d2 -w2 /dev/iio\:device3
>
> Can you shift this right by two spaces?
Done
>
> > (at 10Hz, the default).
> >
> > Trigger events:
> > Setting:
>
> > thresh_falling_period: 2 (events)
> > thresh_rising_period: 2 (events)
> > in_proximity0_thresh_either_value: 300
> > in_proximity0_thresh_either_hysteresis: 72
>
> Ditto.
>
> > using iio_event_monitor /dev/iio\:deviceX, approaching my hand to the
> > antenna pad, I see:
> > ...
> > Event: time: 1634763907532035297, type: proximity, channel: 0, evtype:
> > thresh, direction: falling
> > Event: time: 1634763910138104640, type: proximity, channel: 0, evtype:
> > thresh, direction: rising
>
> ...
>
> > + * Based on SX9324 driver and copy of datasheet at:
> > + * https://edit.wpgdadawant.com/uploads/news_file/program/2019/30184/tech_files/program_30184_suggest_other_file.pdf
>
> Can you provide the link to the datasheet as Datasheet: tag?
Done.
>
> ...
>
> > +       for (i = 0; i < SX9324_NUM_PINS; i++) {
> > +               pin_idx = (val & SX9324_REG_AFE_PH0_PIN_MASK(i)) >> (2 * i);
>
>
> > +               len += scnprintf(buf + len, PAGE_SIZE - len, "%s,",
>
> Shouldn't this be sysfs_emit_at()?
Done (and for other snprintf in sx9360 as well).
>
> > +                                sx9324_cs_pin_usage[pin_idx]);
> > +       }
>
> ...
>
> > +       *val = 1 << FIELD_GET(SX9324_REG_PROX_CTRL0_GAIN_MASK, regval);
>
> Hmm... perhaps BIT()?
I prefer to use '1 <<' explicitly, as val is a physical number, not a
bit in a bitfield.
>
> ...
>
> > +       switch (mask) {
> > +       case IIO_CHAN_INFO_HARDWAREGAIN:
> > +               *type = IIO_VAL_INT;
> > +               *length = ARRAY_SIZE(sx9324_gain_vals);
> > +               *vals = sx9324_gain_vals;
> > +               return IIO_AVAIL_LIST;
> > +       case IIO_CHAN_INFO_SAMP_FREQ:
> > +               *type = IIO_VAL_INT_PLUS_MICRO;
> > +               *length = ARRAY_SIZE(sx9324_samp_freq_table) * 2;
> > +               *vals = (int *)sx9324_samp_freq_table;
> > +               return IIO_AVAIL_LIST;
> > +       }
> > +
> > +       return -EINVAL;
>
> Make it the default case?
Done. Fixed sx9360 as well.
>
> ...
>
> > +       regval = FIELD_GET(SX9324_REG_PROX_CTRL5_FAR_DEBOUNCE_MASK, regval);
> > +       if (regval)
> > +               *val = 1 << regval;
>
> BIT() ?
I prefer to use '1 <<' explicitly, as val is a physical number, not a
bit in a bitfield.
>
> > +       else
> > +               *val = 0;
>
> ...
>
> > +       regval = FIELD_GET(SX9324_REG_PROX_CTRL5_CLOSE_DEBOUNCE_MASK, regval);
> > +       if (regval)
> > +               *val = 1 << regval;
>
> Ditto?
>
> > +       else
> > +               *val = 0;
>
> ...
>
> > +       switch (mask) {
> > +       case IIO_CHAN_INFO_SAMP_FREQ:
> > +               return sx9324_set_samp_freq(data, val, val2);
> > +       case IIO_CHAN_INFO_HARDWAREGAIN:
> > +               return sx9324_write_gain(data, chan, val);
> > +       }
> > +
> > +       return -EINVAL;
>
> In some cases you have default in some not, can it be consistent?
Done.
>
> ...
>
> > +               dev_err(&data->client->dev,
> > +                       "initial compensation timed out: 0x%02x\n",
> > +                       val);
>
> Isn't it what user space will get anyway?
Remove similar dev_err call in other drivers as well.
>
> ...
>
> > +static const struct acpi_device_id sx9324_acpi_match[] = {
> > +       { "STH9324", SX9324_WHOAMI_VALUE},
>
> Missed whitespace?
Done. Note `checkpatch.pl --strict` does not complain, and not having
whitespace in tables is widespread:
grep -re "[0-9A-Za-z]}" drivers/iio/ | wc -l
1239

>
> > +       { }
> > +};
>
> ...
>
> > +static const struct of_device_id sx9324_of_match[] = {
> > +       { .compatible = "semtech,sx9324", (void *)SX9324_WHOAMI_VALUE},
>
> Ditto.
>
> > +       { }
> > +};
>
> --
> With Best Regards,
> Andy Shevchenko
