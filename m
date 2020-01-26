Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78BB9149B58
	for <lists+linux-iio@lfdr.de>; Sun, 26 Jan 2020 16:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbgAZPRN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 Jan 2020 10:17:13 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39103 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbgAZPRN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 26 Jan 2020 10:17:13 -0500
Received: by mail-lj1-f195.google.com with SMTP id o11so7964856ljc.6
        for <linux-iio@vger.kernel.org>; Sun, 26 Jan 2020 07:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jzO4kvhvu2342eqevha+Ur5tSgDydF3IhWq+9VEqU/E=;
        b=c790BvrFpMrVYqNU/drWNWkENB9rcoDOBIj5dFKfXY3DDvxkd9OjQeN57/6ZrYzvJV
         nRgoaNwtjHLTQZFbUQLC0bkIxexthOT1Qh8gv+4Pprq563lvYITwsOwsRcQVQPXoHAKi
         OcnwdmxkvW52lRzrQzt7P//Xtd87KpYs8u0US6DUd0KYrAKOrb+HCl0oQy1dqhppsWFr
         47SZAx1jmL7EGRYVwGhhi+4UymXqqLVcWnjdvULpkxWUMEvhp7hzeQQcpnlAfTmS3Gnu
         SHFC4i767DdZ/yLTeaUvpxYuICwtnxi2q1qXVzy0OmgVRA1Fgu3n66/5V4XM3zsRAznu
         1Fzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jzO4kvhvu2342eqevha+Ur5tSgDydF3IhWq+9VEqU/E=;
        b=feSvytB2ohrbZZ/6qSANn1lFZAz0+qTo3tg4kqvns4xL0T9fyvX5QVOfdOnhzCmZJi
         PgA3YRyT9xGqc4ungMK0vP0U9WbFHaZc5v74gSpDHVnbtkNJspZmZePbgHzXnwFz2Dmt
         JWUgz13SRfYl50ba2LqB++BXpj5Jw10XUtTgYAPOgmLX9CND9HC4sJZLtwKsqdTVI2Qh
         UEX+splPDlkjTwe2QbfcTujw+QQ4WuPWcDPuQckztKTZy5MX10QP0dDbPN5psAM1mPbz
         IFLCYe487BpsVQYiIwQ1vvwCh8cQL+f3ot8TeD5IU0olPPTLIfoKvfgRUBiKwN1ZC85L
         MijA==
X-Gm-Message-State: APjAAAUZ1GOBRBhOi/jfM4idOl7zQM8neED99wQo8UHPTg9o4fqaFmT1
        GQ1eTJQ3uHo6ICPjsCBeYnhgkmOTdM9pSMyZzTSF3g==
X-Google-Smtp-Source: APXvYqwdDjhUnzzgEF0ZRpLUcU4CUNf9kV7vXQfX6KghRxguooIH8gP9o1ruScZjHbdfqP0+9Kz1yULKRn9YA1ZTDRI=
X-Received: by 2002:a2e:2a84:: with SMTP id q126mr7440023ljq.258.1580051830986;
 Sun, 26 Jan 2020 07:17:10 -0800 (PST)
MIME-Version: 1.0
References: <20200121210419.13372-1-linus.walleij@linaro.org>
 <20200121210419.13372-2-linus.walleij@linaro.org> <BYAPR10MB3479CEEA65545B8422C77091A30E0@BYAPR10MB3479.namprd10.prod.outlook.com>
In-Reply-To: <BYAPR10MB3479CEEA65545B8422C77091A30E0@BYAPR10MB3479.namprd10.prod.outlook.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 26 Jan 2020 16:16:59 +0100
Message-ID: <CACRpkdYMxXL6oY0eA+5EYOUTZ_opAtiT-6THfc9dwy_9Ufq8MQ@mail.gmail.com>
Subject: Re: [PATCH 2/2 v5] iio: light: Add a driver for Sharp GP2AP002x00F
To:     Jonathan Bakker <xc-racer2@live.ca>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Minkyu Kang <mk7.kang@samsung.com>,
        =?UTF-8?Q?Pawe=C5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        Oskar Andero <oskar.andero@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Jan 24, 2020 at 1:47 AM Jonathan Bakker <xc-racer2@live.ca> wrote:

> Thanks for the driver, I've tested it on a first-gen Galaxy S
> device with a GP2AP002A00F.  I have a few comments that I've put inline
> based on my experiences.

Thanks a lot!

> Both shortly after probe (when runtime pm timeout occurs?) and after
> manually disabling the proximity event, this
> irq handler is called.  Since the chip is in low power state, it obviously
> fails to read the proximity value and write to the OCON register below, eg
>
> [    7.215875] gp2ap002 11-0044: error reading proximity
> [    8.105878] gp2ap002 11-0044: error setting up VOUT control 1
>
> Can we do something like disable_irq() in the runtime pm function to prevent
> this?

I added that in v6, I hope this solves your problem.

> The gp2ap002s00f_regmap_i2c_read function works on the gp2ap002a00f as well,
> so this can be simplified/dropped.

Fixed this too in v6.

> > +             if (ch_type != IIO_CURRENT) {
> > +                     dev_err(dev,
> > +                             "wrong type of IIO channel specified for ALSOUT\n");
> > +                     return -EINVAL;
> > +             }
>
> This enforces a current ADC, while several devices besides mine (eg Galaxy Nexus)
> use a resistor and a voltage ADC.  For this case, could we add a device property such as
> sharp,adc-adjustment-ratio to convert from the raw ADC values to a "current" that
> could be used in the lookup table?  So the "current" would be the raw ADC divided
> by that special value.
>
> Instructions for converting the ADC back to the current can be found eg at
> https://android.googlesource.com/device/samsung/crespo/+/2e0ab7265e3039fee787c2216e0c98d92ea0b49e%5E%21/#F0

I'd like to keep that as a future enhancement unless someone is very eager
to get it and has a device they can test it on. Otherwise it will be
just dry-coding
on my part.

I think the property we would add in the device tree in that case should
be the resistance value. This is based on the following assumption
which is indeed a bit of speculation since there is no proper datasheet
for the light sensor part of the component:

- The light sensor part is simply a photodiode
- This emits a nonlinear current in relation to how many
  photons hit the photodiode in a time interval, the relationship
  is described in the curren->lux table we have
- Some vendors do not have any current ADC, so they connect
  this to a resistor, and measure the voltage over the
  resistor because the have a voltage ADC

Since current is linear to the voltage over the resistor, we should
include the resistance in the device tree, then using that the
corresponding current can be calculated and we use the same
look-up table to find the lux. Probably each system may need
to also subtract some bias voltage or so.

But we definately need something to test on to do this right.

Yours,
Linus Walleij
