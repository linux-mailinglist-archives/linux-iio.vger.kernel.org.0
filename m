Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 371042C7497
	for <lists+linux-iio@lfdr.de>; Sat, 28 Nov 2020 23:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388242AbgK1Vtc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Nov 2020 16:49:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387762AbgK1VFu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 28 Nov 2020 16:05:50 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6EBC0613D2
        for <linux-iio@vger.kernel.org>; Sat, 28 Nov 2020 13:05:09 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id s9so10333395ljo.11
        for <linux-iio@vger.kernel.org>; Sat, 28 Nov 2020 13:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NXUgVDY/D8K1+7OpYT2Vp98ohpEzXQV3FJGu7OisKHw=;
        b=B0RYQ/X8uMlxaHTlxLlkMxhZWIXS6S5D4Dc5hIrd7dNsbUYDzvwpk9TAV1/qlDrHMj
         +qukWe72ObWsO9pQLV7/X+xTQdlRxwdTq7DVmjrwonNTanp25gLcSMZdAMuVhOcBSW69
         QBwXgZntGwASuk0ZwBaeJgZ2EXu2DA71lFmCE+tcazt37PlGBZ3as6vFjufW1eMEAT4R
         Frf/MZAEshhqNI1w8hFUvCFwESi8/mbGQGuaL11REKTMgF/pLo4/6sLhsKivrh6y/oRf
         nY3R2fX4kVbwgnZ/AQurjpD6mIcv8Q2zdaYGtq51xvhUV2BsTlVHD0EI1h+yRA6uPSKn
         GZQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NXUgVDY/D8K1+7OpYT2Vp98ohpEzXQV3FJGu7OisKHw=;
        b=gIQZBnk+cnpabyEZePp7mZ0a/NtQU52sXb3njIbuF2dBHdoOSLnVHuNqzWdOFdkgCg
         IrwfnsCzAYu7E6ylDLA9isMvS9L2+BG5UFKDYtT5yCm8epHiw+V/5JbsFEvmCQ1FdufD
         nICgnU9AE4VaqpEb8/vhLuhsHZ+ng1Ch51yO9E6vgbUnk9iP2953mubF083K2yHaWwqE
         dlhkOVpF+rZIQI5/RMK907y5TQo3i/M6M2yhieIhkqzXjFlvfidxcoV8BMMB8sXA70LE
         l/QLm/12ul53U5BdUcPJ8/pmorTzJMudhSXpaZF6iwJknzQuOhBVt2rvj5DsxXGTkj0w
         gczw==
X-Gm-Message-State: AOAM53153sC5p/gTg3DVJim246LlZnBswIZE70emNiDEmPdWkgYRgK2N
        Dzo/ylruRBJYQmkxWBqsZDjGbdckcgeTFgs3ZrVJaBj9SsAU9zLU
X-Google-Smtp-Source: ABdhPJzk9XSRJelIhy3xHhNQlcQJUiu6s5RaAPCZgj/9kuTxLN6mx6IMZCcKMLlGNOsauoMEoiV1TrTlNl9Pbws4OIk=
X-Received: by 2002:a05:651c:39d:: with SMTP id e29mr4810713ljp.144.1606597508162;
 Sat, 28 Nov 2020 13:05:08 -0800 (PST)
MIME-Version: 1.0
References: <20201128004038.883289-1-linus.walleij@linaro.org>
 <20201128004038.883289-2-linus.walleij@linaro.org> <20201128122153.44c1052c@archlinux>
In-Reply-To: <20201128122153.44c1052c@archlinux>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 28 Nov 2020 22:04:56 +0100
Message-ID: <CACRpkdYvkV0Xrw9fseQneHwhJ-EkcX+RQKVcCF8hhidE479AmQ@mail.gmail.com>
Subject: Re: [PATCH 2/2 v2] iio: magnetometer: Add driver for Yamaha YAS5xx
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        phone-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan!

I fixed most things, some elaboration inline:

On Sat, Nov 28, 2020 at 1:21 PM Jonathan Cameron <jic23@kernel.org> wrote:

> The 'interesting' nature of the packing in those calibration registers
> is unfortunate.  I'm not really sure how we make that code more readable
> but using overlapping unaligned big endian reads definitely doesn't make
> it easier for me to follow!

Yeah I am experimenting to find a good way. Maybe I will try to extract
u64 and chop out the bits from there to make it clearer.

I think a lot of clock drivers have this problem already.

> > +       This driver can also be compiled as a module.
> > +       To compile this driver as a module, choose M here: the module
> > +       will be called yamaha-yas.
> > +

> One line only

Please clarify what you want the end result to look like, I don't
quite get it... Looking a the latest committed drivers in linux-next
didn't give a clue either.

> > + * YAS530 MS-3E (2011 Samsung Galaxy S Advance)
> > + * YAS532 MS-3R (2011 Samsung Galaxy S4)
> > + * YAS533 MS-3F (Vivo 1633, 1707, V3, Y21L)
> > + * (YAS534 is a magnetic switch, not handled)
>
> And there is your reason not to use wild cards in the dt file name etc!

It's pretty safe as we definately account for all magnetometers
of the naming scheme YAS53x. The YAS534 would be in another
subsystem (proximity, I guess) so the path to the file gives the
right info: this covers all magnetometers named yas53x, goes
for both the bindings and the driver I think?

> > +static void yas53x_extract_calibration(u8 *data, struct yas5xx_calibration *c)
> > +{
>
> As below.  I'm not sure how you make this clearer, but right now it's
> really hard to follow.  Perhaps detailed comment on what the data packing
> in here is?

OK I try to detail a bit.

> > +     c->a2 = yas5xx_extract_bits(&data[3], 10, 15) - 32;
> > +     c->a3 = yas5xx_extract_bits(&data[3], 6, 9) - 8;
> > +     c->a4 = yas5xx_extract_bits(&data[4], 8, 13) - 32;
> > +     c->a5 = yas5xx_extract_bits(&data[5], 10, 15) + 38;
> > +     c->a6 = yas5xx_extract_bits(&data[5], 4, 9) - 32;
> > +     c->a7 = yas5xx_extract_bits(&data[6], 5, 11) - 64;
> > +     c->a8 = yas5xx_extract_bits(&data[7], 7, 12) - 32;
> > +     c->a9 = yas5xx_extract_bits(&data[8], 7, 14);
> > +     c->k = yas5xx_extract_bits(&data[9], 10, 14) + 10;

Since this segment easily fits in a u64 I thought about
extracing a u64 and then use FIELD_GET on that.

> As below, I wonder if you'd be better just constructing these directly from
> the 8 bit register pairs. The overlapping unaligned 16 bit reads are
> rather confusing.

I already tried that but it looks even worse :/

I will try to put them into a bigger word instead.

> > +     /* Extract linearization */
>
> Could you add a comment on the data layout here. It seems rather
> non obvious given the overlapping 16 bit reads you are doing.
> Whilst the maths might correspond to extracting bits from be16 registers
> that looks more like coincidence than design and only makes any
> useful difference to the bit 7,8 pair.  The bit 9-14 could just have
> been gotten from the next 8 bit register directly.

It sadly doesn't look any better if I operate on u8 chars. :/
I'll try to think of something.

> > +             snprintf(yas5xx->name, sizeof(yas5xx->name),
> > +                      "YAS530 MS-3E %s",
>
> Name tends to be lowercase. Also, not sure we've had one with spaces
> in it before.  I guess our userspace code is fine with it though
> as presumably you've tested that.

Yeah oddly it turns it into just "YAS530":

skomer:/home/linus# lsiio
Device 003: bma222
Device 001: current-sense-amplifier
Device 004: gp2ap002
Device 002: mpu3050
Device 000: ab8500-gpadc
Device 005: YAS530
Trigger 000: mpu3050-dev2

But it doesn't look nice, I will rename it lowercase.

Yours,
Linus Walleij
