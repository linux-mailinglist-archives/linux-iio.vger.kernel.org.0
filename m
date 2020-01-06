Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47E01130F34
	for <lists+linux-iio@lfdr.de>; Mon,  6 Jan 2020 10:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbgAFJJJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 Jan 2020 04:09:09 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40131 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbgAFJJJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 6 Jan 2020 04:09:09 -0500
Received: by mail-lj1-f194.google.com with SMTP id u1so50168133ljk.7
        for <linux-iio@vger.kernel.org>; Mon, 06 Jan 2020 01:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8DARrvaq+PcRquTcIaqd1gCUQRO9MABf9bEpQXNB0WQ=;
        b=U/wK22yxF40YKv9qtBYMsz0hBZAw8ftksSCLmOX7v9m1l53IF3FYygEF8t4rgXKq2V
         D9nLMyXPnZUZs/SKALpZlMCvcdkVL2F8myu31I4yHROQFhADFa6LwKkmbGRxV9DijPuN
         IU7zROdEL0LJngZl1tC7YY8jYrPKImax6lNnqVDDU8vs1gWramgTz2UPNQ2dmSPG6gDJ
         t/a800X/DWZvVEjtRyrM1lLTiIRkaCev64i/P8zcvYFYEKVuq4P04isclqgeEOUskZBs
         QVhKResmNwQHYMfLG0u3hNx/7ZwA0wHdHGZ8jb037e9JI9NVZ1gmaNpg4wLB+MhwQXfE
         51YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8DARrvaq+PcRquTcIaqd1gCUQRO9MABf9bEpQXNB0WQ=;
        b=A1TvpSEBZCvCAcUhPFMBU+TKlV4eTOR7OUStvNssy331vWHp1DJJezEFe2MLivHZLN
         aQgofXDxfJ0tKqyY9CpL5Yny/wAIWgb8G1isVYEC6vtfCdoeDuUx85gyxXTWv8gRqrcx
         Py2wBbkHpBsSESrdejGlwoIxaKwIH2DGqXZE+0DEmh7YqPzghvJ9Siq5aL5TXFFn7j4+
         1LftAs7eY5yiTNmDDpe4PATXNQvK1z8WL7+eFsTmKsOP8MQKfGhsEB+HJCNOwwZR7cjP
         Q+f1BiADnIuaQz62a7CJ6haRHXhI05UlmHbhbtbY4GfHf7QL5isj9q0qgYYkJF2Xq9RQ
         eq4g==
X-Gm-Message-State: APjAAAW2HWas6C4r9yu556pCKQ+c4fHt4jvcUzlrnP5XVYhvk7q4r+S4
        6vo4bGJ6JVExkos2gMp2QyjLa42sS3BOLe6azsGeUA==
X-Google-Smtp-Source: APXvYqw5DNOYHqq0/bb+XxEER9k0ajbxWEguyNVy9ZnfEBWGWy6IUtk9Qz1740T+o15PeJhnbDujBdR5B45EkTvtv5k=
X-Received: by 2002:a05:651c:1049:: with SMTP id x9mr58486521ljm.233.1578301747096;
 Mon, 06 Jan 2020 01:09:07 -0800 (PST)
MIME-Version: 1.0
References: <20191228201109.13635-1-linus.walleij@linaro.org>
 <20191228201109.13635-2-linus.walleij@linaro.org> <20191230173919.373f4e8a@archlinux>
In-Reply-To: <20191230173919.373f4e8a@archlinux>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 6 Jan 2020 10:08:55 +0100
Message-ID: <CACRpkdbpqge9beL8QEdqnA3pN+41PUfJg4Zr9hDnnYYkatSYTg@mail.gmail.com>
Subject: Re: [PATCH 2/2 v1] iio: light: Add a driver for Sharp GP2AP002x00F
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linux Input <linux-input@vger.kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Donggeun Kim <dg77.kim@samsung.com>,
        Minkyu Kang <mk7.kang@samsung.com>,
        =?UTF-8?Q?Pawe=C5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        Jonathan Bakker <xc-racer2@live.ca>,
        Oskar Andero <oskar.andero@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

fixed most of the things and resending as v2 soon-ish,
some inline responses, comments:

On Mon, Dec 30, 2019 at 6:39 PM Jonathan Cameron <jic23@kernel.org> wrote:
> On Sat, 28 Dec 2019 21:11:09 +0100 Linus Walleij <linus.walleij@linaro.org> wrote:

> If at all possible I'd like to discourage use of of specific
> calls in favour of the generic ones.  It's pretty unlikely we'll
> ever see this driver using anything else, but I'd like to build
> up a good set of examples to point people at now that functionality
> is in place.

I guess you mean to use fwnode where possible. I comment on this
below.

> > +     iio_push_event(indio_dev, ev, iio_get_time_ns(indio_dev));
> > +     usleep_range(20000, 30000);
>
> What is the basis for these timings?

Detection cycle, I explained this with an inline comment.

> > +     gp2ap002->is_gp2ap002s00f =
> > +             of_device_is_compatible(np, "sharp,gp2ap002s00f");
>
> Hmm. This rather breaks my comment below about trying to avoid making
> this of specific if we don't need to...
>
> I 'think' we could use device_property_read_string
> There is a bit of precedence for doing so, but it is not common.

This is the real trick. Using
device_property_read_string(dev, "compatible", str);
isn't going to work as ACPI probes from a unique 4-char
ID not a compatible string this will never work on ACPI
anyways.

I can try to go some extra mile to support a hypothetical
ACPI client by adding a struct with one bool member as
match data and pass that around if you insist, but I think it's
more something appropriate for the first ACPI user to do.

It's no problem if you want it, but it will add a bunch of
boilerplate just for this.

> > +     /* Check the device tree for the IR LED hysteresis */
> > +     ret = of_property_read_u32(np, "sharp,proximity-far-hysteresis", &val);
>
> Do these belong in DT at all, or are they more of a policy decision?
> Without a datasheet I'm kind of guessing what they actually are.

There is a datasheet:
https://global.sharp/products/device-china/lineup/data/pdf/datasheet/gp2ap002s00f_appl_e.pdf

> We have the option for hysterisis controls on events from sysfs if that
> make sense.

I don't know, these are two hysteresis settings: one that detects an
object close to the sensor and one detecting an object far from
the sensor.

The two settings are describes as fixed to mode A, B1 and B2 in the
datasheet. However there is a vendor driver in one of the phone
trees that use "mode B 1.5" not documented in the datasheet
(bummer). So given how fluid this all is I opted for just an u8
in the device tree for "close" and "far" hysteresis setting.

> Could use the fwnode_get_property_u32 etc to drop reliance on OF.

Will do if we must support hypotetical non-DT probe.

> > +     /* The GP2AP002A00F has a light sensor too */
> > +     if (!gp2ap002->is_gp2ap002s00f) {
>
> This section is rather 'unusual' and definitely needs some explanatory
> comments - particularly as I can't find any reference docs for the part.

The only reference for the light sensor part in GP2AP002A00F
is the submission from Samsung mentioned in the header of the
driver submitted by Donggeun Kim & Minkyu Kang in 2011:
https://lore.kernel.org/lkml/1315556546-7445-1-git-send-email-dg77.kim@samsung.com/

It also appears in the GPL code from GT-S7710 which seems to
derive from a code drop from Sharp.

Yep the code is the documentation...

> I'm guessing that the light sensor is simply an analog output?  As such
> you need to wire it up to a separate ADC to actually read the light level...

Yep that's the same method as used for
drivers/iio/light/cm3605.c
Most early Androids do something like that, and all SoCs seem to
provide some ADC to do the conversion.

Yours,
Linus Walleij
