Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9732E3159
	for <lists+linux-iio@lfdr.de>; Sun, 27 Dec 2020 14:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgL0Nq5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 27 Dec 2020 08:46:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgL0Nq5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 27 Dec 2020 08:46:57 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A936DC061795
        for <linux-iio@vger.kernel.org>; Sun, 27 Dec 2020 05:46:16 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id o13so18578838lfr.3
        for <linux-iio@vger.kernel.org>; Sun, 27 Dec 2020 05:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7FsbNRFwzGpY67mFSosv+OJcTmyCz7rrYpaPFl9GehQ=;
        b=SYJjK35lh7tQ0946i2hOUVM8NC2clv8K6g5fs02m9vdyfTEiBO1QjtIi52ftC8iJit
         ZTXz6APmPkAWJ3bnYENdOVRw0fkBTR8nVscXhXlrkyUqo2+p/1DnAwtIesaqGzAEevbY
         of9XUrIDELxJiq3CwAQwTlYTLClO42X+ccgjy5OC+J9zDRrDVadE+9LITKQy+9/32tko
         vQOJc9jWso7zkV1wUzPgF6niwjwZDOAIkLSQYn4OLCrE6RO26YGAlvyEy1kPX6rcHOqN
         Y5q/9rmAUw9hK4Bp9+6p1NUkWmY2vp0IfrikSum610/sGwwaLt6QC8wPNq4gfTetJpEg
         Az0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7FsbNRFwzGpY67mFSosv+OJcTmyCz7rrYpaPFl9GehQ=;
        b=WR/8H7Texjrb3fwW3JRx+JkB8upLmF/5wJRdhhyrjo/4gyj52GH1AfWowczJOn/zS/
         w5r3rw87ZrhpHClbOik7hBibEiYyPRT6I3+mfFMMqo4T3yj3churLd42esupBktn4xE6
         MFKKTVAIq+ByNdKYKPU3T1DGbFK2iXCeSCIQeo91ZpIRXR1I8mzktkeCtnPdqLH8glFB
         zZGmZUc/w41MSjCkYZnJVQqx+V9hQ32yTNAKIsLkg63w2h8KFYg7eRA7ntgBYCA7v4b6
         Ql5KEQAIUxqy/oSiAfizCYQM6v5H4ShEstgqO7xr5q2s8i1npGAhMyJqQA8gRfhtTNaG
         ODSg==
X-Gm-Message-State: AOAM531BaJLegZqebzEJjvWCcpX3jtisPH+OpQrducUYHNqpTG0m5otV
        DhQGgw/9W2is4PZINjwNxLmx0wBCQq1rnRy6VZzRgg==
X-Google-Smtp-Source: ABdhPJz4zD/yP64QV/o9bAeIHxd0JDYDmTOv/4oCo1v0GtqeX2V1HHgJNtrPDSrbK6kLB22OkLpFZyI9fWQq0//rjsY=
X-Received: by 2002:a05:651c:1312:: with SMTP id u18mr19897547lja.200.1609076775113;
 Sun, 27 Dec 2020 05:46:15 -0800 (PST)
MIME-Version: 1.0
References: <20201224011607.1059534-1-linus.walleij@linaro.org>
 <SN6PR08MB556580B228FEC722C4A75B669ADD0@SN6PR08MB5565.namprd08.prod.outlook.com>
 <CACRpkdZJT386M5y5cyCLYaWDhS+AnpXgB__VEshvYKbxN_=wPg@mail.gmail.com> <SN6PR08MB556511839F0A54D34E898EB79ADB0@SN6PR08MB5565.namprd08.prod.outlook.com>
In-Reply-To: <SN6PR08MB556511839F0A54D34E898EB79ADB0@SN6PR08MB5565.namprd08.prod.outlook.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 27 Dec 2020 14:46:04 +0100
Message-ID: <CACRpkdbxzuYrFeU2H2LGaWb3kKqfZ4-SpWu5FiXdFVyz82-zWw@mail.gmail.com>
Subject: Re: [PATCH v2] hwmon: (ntc_thermistor): try reading processed
To:     Chris Lesiak <chris.lesiak@licor.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        Peter Rosin <peda@axentia.se>,
        Jonathan Cameron <jic23@cam.ac.uk>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Dec 26, 2020 at 2:45 AM Chris Lesiak <chris.lesiak@licor.com> wrote:

> I haven't been able to find detailed documentation on the ab8500-gpadc,
> so I have a couple of questions / comments:

The documentation is available here:
https://web.archive.org/web/20130614115108/http://www.stericsson.com/developers/CD00291561_UM1031_AB8500_user_manual-rev5_CTDS_public.pdf

As it is in the wayback machine I put a copy here:
https://dflund.se/~triad/krad/CD00291561_UM1031_AB8500_user_manual-rev5_CTDS_public.pdf

As with many mixsig products the ADC isn't very well documented.
The code is the documentation...

> 1. The driver appears to support temperature output directly.  Why do
> you need ntc_thermistor?

Actually these channels (if you mean AB8500_GPADC_CHAN_BAT_TEMP,
AB8505_GPADC_CHAN_DIE_TEMP, AB8500_GPADC_CHAN_XTAL_TEMP)
are just voltages and they need to be processed because they are
some kind of thermistors and not temperatures at all, these are
voltages. It's just that the channels are named like this.

However in this case (the current patch), the two channels used for the
thermistors are
AB8500_GPADC_CHAN_ADC_AUX_1
AB8500_GPADC_CHAN_ADC_AUX_2
which are just common arbitrary voltage ADCs, not related to
the above, so it doesn't really apply anyways.

> 2. I don't understand how the ab8500_gpadc_read_raw output of processed
> data could possibly be correct.
>
>         if (mask == IIO_CHAN_INFO_PROCESSED) {
>                 processed = ab8500_gpadc_ad_to_voltage(gpadc, ch->id, raw_val);
>                 if (processed < 0)
>                         return processed;
>
>                 /* Return millivolt or milliamps or millicentigrades */
>                 *val = processed * 1000;
>                 return IIO_VAL_INT;
>         }
>
> Note that both processed and *val are both of type int.
>
> If *val really does end up with milliVolt units, then processed must
> have had Volt units.  And you only have single Volt resolution.

Sorry there is a bug there and I sent a patch the other day:
https://lore.kernel.org/linux-iio/20201224011700.1059659-1-linus.walleij@linaro.org/T/#u

"processed" contains millivolts, the * 1000 is a bug. This is why
reading the processed channel without multiplying with 1000
was working for me before, then I discovered that the contract
of the API is to pass millivolts and then I fixed this bug.

Sorry about the confusion :/

> Either you are working with a lot higher voltages than I usually see,
> or something must be wrong.

Yeah something was wrong. Fixed with the patch.

But do you agree with the general stance that we should
give precedence to using iio_read_channel_processed()
and multiply the result with 1000? It should work with
any driver I think.

Yours,
Linus Walleij
