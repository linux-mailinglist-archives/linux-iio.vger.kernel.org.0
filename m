Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33659479BAB
	for <lists+linux-iio@lfdr.de>; Sat, 18 Dec 2021 17:08:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233570AbhLRQIr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Dec 2021 11:08:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233569AbhLRQIr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 Dec 2021 11:08:47 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C35C061574
        for <linux-iio@vger.kernel.org>; Sat, 18 Dec 2021 08:08:46 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id e3so19950338edu.4
        for <linux-iio@vger.kernel.org>; Sat, 18 Dec 2021 08:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IbJuccsywbmvcoEhqdGVydYQrCrJJK5NReRHUTbBWws=;
        b=NXZmMobZ56NgioP0PbXOLUrFz3TC7kFW2cOWdBkOLp4q/KFQg3jTcWKdlS2atAhG8D
         768rrZUrhMp1+J/zchMMO+vjGNUjBclDqhD4515Lgsw7GKQkdk9/aW+fqpONxWXGUHLe
         IOrYtpRvNNrcR2CZ3/CI+lzoyrYTvSY9iwWnCfoMl65kUrNHwS5z35MBYaTdbI1/s7hH
         tukJJgI+IbbFNLbCaZ/+jWp+x3gCBkyMq/8kzy49dsSZhlKopHZlHquABMtVSz4QuA2v
         bTwA+5vmRa7rOwZD61jT1snN2yTr72/VVzzw+SJgJ43oOiXhCATKQalGK5uT8tNC6sim
         gaKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IbJuccsywbmvcoEhqdGVydYQrCrJJK5NReRHUTbBWws=;
        b=V8SVls99SmJ/TQiwNpTe6vqxB50V1WJZDYxuOvEE44HygfeqEWAU6QuJ3N8M4CmK61
         cGGUeV96LxlrK3RZyuwzRsDlBneS3kTaqqaEB4qyOvJoZ52hcNgHkP+PufhsCCvKgCGG
         4NzFXuuq1hzEDS0QXIfln7B1J9eWKw7Z1/8uOeUzLi3JT8omT5kIAHxep6tmFaYspKAb
         wEWMEEBdqTVJei5xAPBkvc9kzqP9oMCTTD/QI+Mn3WDkzcK56LIdyqlhGDWoR1ANv82R
         QFBq0twUf5OEXUUdozRo6Hwm6+wCz3kZ+AWs7iq82o7XoNAJoyDUH+HKQD/fq2GGnjOr
         89GA==
X-Gm-Message-State: AOAM532LaR1E4XZAR0GABMMR7GZ5hHyV7DE6kfEBNQeF6eqbbCWFDcg9
        cn4YG+kGNP+2ZVvIb16ECnLORZLNMSBzhxgSQDE=
X-Google-Smtp-Source: ABdhPJwts+AFlgPJPR1OE9J6v/x1DIIUuSRc7QJP8vwUmv7VFIPMiJRB2DB5je4i9Ub4SK/f4gFNorY4f/1hfoR3dwg=
X-Received: by 2002:a05:6402:270c:: with SMTP id y12mr7850493edd.258.1639843725161;
 Sat, 18 Dec 2021 08:08:45 -0800 (PST)
MIME-Version: 1.0
References: <20211218001755.3096807-1-gwendal@chromium.org> <20211218001755.3096807-4-gwendal@chromium.org>
In-Reply-To: <20211218001755.3096807-4-gwendal@chromium.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 18 Dec 2021 18:08:08 +0200
Message-ID: <CAHp75Vds5z2cBfWA3ZMaeQQQx_8YJuXWUvyU-SMdBiMWe4phrQ@mail.gmail.com>
Subject: Re: [PATCH v8 3/5] iio: proximity: Add SX9324 support
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Dec 18, 2021 at 11:58 AM Gwendal Grignou <gwendal@chromium.org> wrote:
>
> Semtech SAR sensor SX9324 is an evolution of the SX9310:
> It has 4 phases that can be configure to capture and process data
> from any of 3 CS pins and provide independent detection:
> proximity, table proximity or body proximity.
>
> Gather antenna data:

> echo sx9324-dev3 > trigger/current_trigger
> echo 1 > scan_elements/in_proximity0_en
> echo 1 > buffer/enable
> od -v -An --endian=big -t d2 -w2 /dev/iio\:device3

Can you shift this right by two spaces?

> (at 10Hz, the default).
>
> Trigger events:
> Setting:

> thresh_falling_period: 2 (events)
> thresh_rising_period: 2 (events)
> in_proximity0_thresh_either_value: 300
> in_proximity0_thresh_either_hysteresis: 72

Ditto.

> using iio_event_monitor /dev/iio\:deviceX, approaching my hand to the
> antenna pad, I see:
> ...
> Event: time: 1634763907532035297, type: proximity, channel: 0, evtype:
> thresh, direction: falling
> Event: time: 1634763910138104640, type: proximity, channel: 0, evtype:
> thresh, direction: rising

...

> + * Based on SX9324 driver and copy of datasheet at:
> + * https://edit.wpgdadawant.com/uploads/news_file/program/2019/30184/tech_files/program_30184_suggest_other_file.pdf

Can you provide the link to the datasheet as Datasheet: tag?

...

> +       for (i = 0; i < SX9324_NUM_PINS; i++) {
> +               pin_idx = (val & SX9324_REG_AFE_PH0_PIN_MASK(i)) >> (2 * i);


> +               len += scnprintf(buf + len, PAGE_SIZE - len, "%s,",

Shouldn't this be sysfs_emit_at()?

> +                                sx9324_cs_pin_usage[pin_idx]);
> +       }

...

> +       *val = 1 << FIELD_GET(SX9324_REG_PROX_CTRL0_GAIN_MASK, regval);

Hmm... perhaps BIT()?

...

> +       switch (mask) {
> +       case IIO_CHAN_INFO_HARDWAREGAIN:
> +               *type = IIO_VAL_INT;
> +               *length = ARRAY_SIZE(sx9324_gain_vals);
> +               *vals = sx9324_gain_vals;
> +               return IIO_AVAIL_LIST;
> +       case IIO_CHAN_INFO_SAMP_FREQ:
> +               *type = IIO_VAL_INT_PLUS_MICRO;
> +               *length = ARRAY_SIZE(sx9324_samp_freq_table) * 2;
> +               *vals = (int *)sx9324_samp_freq_table;
> +               return IIO_AVAIL_LIST;
> +       }
> +
> +       return -EINVAL;

Make it the default case?

...

> +       regval = FIELD_GET(SX9324_REG_PROX_CTRL5_FAR_DEBOUNCE_MASK, regval);
> +       if (regval)
> +               *val = 1 << regval;

BIT() ?

> +       else
> +               *val = 0;

...

> +       regval = FIELD_GET(SX9324_REG_PROX_CTRL5_CLOSE_DEBOUNCE_MASK, regval);
> +       if (regval)
> +               *val = 1 << regval;

Ditto?

> +       else
> +               *val = 0;

...

> +       switch (mask) {
> +       case IIO_CHAN_INFO_SAMP_FREQ:
> +               return sx9324_set_samp_freq(data, val, val2);
> +       case IIO_CHAN_INFO_HARDWAREGAIN:
> +               return sx9324_write_gain(data, chan, val);
> +       }
> +
> +       return -EINVAL;

In some cases you have default in some not, can it be consistent?

...

> +               dev_err(&data->client->dev,
> +                       "initial compensation timed out: 0x%02x\n",
> +                       val);

Isn't it what user space will get anyway?

...

> +static const struct acpi_device_id sx9324_acpi_match[] = {
> +       { "STH9324", SX9324_WHOAMI_VALUE},

Missed whitespace?

> +       { }
> +};

...

> +static const struct of_device_id sx9324_of_match[] = {
> +       { .compatible = "semtech,sx9324", (void *)SX9324_WHOAMI_VALUE},

Ditto.

> +       { }
> +};

-- 
With Best Regards,
Andy Shevchenko
