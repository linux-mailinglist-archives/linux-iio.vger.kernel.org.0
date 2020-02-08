Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 103B1156439
	for <lists+linux-iio@lfdr.de>; Sat,  8 Feb 2020 13:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbgBHMfc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 8 Feb 2020 07:35:32 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42125 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbgBHMfb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 8 Feb 2020 07:35:31 -0500
Received: by mail-lj1-f195.google.com with SMTP id d10so2127552ljl.9
        for <linux-iio@vger.kernel.org>; Sat, 08 Feb 2020 04:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=56Xg9dBOxHL3FuEaB+XIek0DXA9+3UUEMRtYiQ3oaf4=;
        b=KLWo1eWGeoIB35myolj3uiaFcvdkPbGjxMZ1Z397jy6UBUniK0QzkNnZTdc9itNkMk
         g4+YA+dDpXYxx19xe5000cYtoGkfGAp1PDuCV14BECD0Ut20Vffn4MFDWHIZkYNrxzu8
         stWl9f9xq8UJe9oc93ts+QKvtSvPjl8v1oeKzaNSlpjHcXWO0WFW0NhLNH5TIw1xfFyG
         FPX8aeyNEWihP61oAh3Q1CyGx/qG6unioHoQ2IZYJ4R7Vyf8fPwaY6jZdWT1TOrHaL6p
         UP4OLlj+LPtA0p+LejnasClWqdjtvyaQVze+hgFEvoZ54G6Tt2LJ9J4FGhuYrLVgFeH1
         6+Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=56Xg9dBOxHL3FuEaB+XIek0DXA9+3UUEMRtYiQ3oaf4=;
        b=XNai7TkHxN+VNBJ37cCMf29byBoGSbH8GHeGu4x6dDpw5KEwAQURE/CVp59IPp5rmp
         9hPhqcnRwPvfsAazdvquHktmmR3fs1rOXFUxJZwDIvsCyjyoaHAQAM1pWMbsLhZnpibU
         aY5DSShN1gzX4yT7U/GWHhVL0zmQepatsX9+y8VfRWajAQo/Zs9xEdkZ72/MIBCeeWyc
         yYntFi/fYWHkh9jZJqZ8CInkuf+oUDtBWsMR+fTH+jLFwx/abf0lCVqyH4cVtUFMhgTO
         X5bZzDHhvE7Gwow5Q6u+Lo8rcIKKhpudbJ8+CeEyNUekO5hp4m3CaQdh8DLSpmCP0sLR
         RIOg==
X-Gm-Message-State: APjAAAV3z9pdxy38nFmGG4Q3OVL9iz/RwRx1gB5zkwvItalnx+x6cUCE
        2OumB4gPBWp/RA8Ec9M9NDHPFdsFqJJWPtQYAsqqPg==
X-Google-Smtp-Source: APXvYqx1VBAxlSPhjBZl5nZlcAeT+O6OLG8cXkidNJwx1rwl9++0OoAEWVqhoEHdEvGw8WmwwYKwKC4WAVp3n4N5YBc=
X-Received: by 2002:a2e:81c3:: with SMTP id s3mr2612356ljg.168.1581165329864;
 Sat, 08 Feb 2020 04:35:29 -0800 (PST)
MIME-Version: 1.0
References: <20200121210419.13372-1-linus.walleij@linaro.org>
 <20200121210419.13372-2-linus.walleij@linaro.org> <BYAPR10MB3479CEEA65545B8422C77091A30E0@BYAPR10MB3479.namprd10.prod.outlook.com>
 <CACRpkdYMxXL6oY0eA+5EYOUTZ_opAtiT-6THfc9dwy_9Ufq8MQ@mail.gmail.com>
 <BYAPR10MB3479E348502A3E94F293559DA3080@BYAPR10MB3479.namprd10.prod.outlook.com>
 <20200202150843.762c6897@archlinux>
In-Reply-To: <20200202150843.762c6897@archlinux>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 8 Feb 2020 13:35:18 +0100
Message-ID: <CACRpkdaWZ46j6M=TFsOEQvS1WOJyVkpXRdML585aKp+oCJVB_A@mail.gmail.com>
Subject: Re: [PATCH 2/2 v5] iio: light: Add a driver for Sharp GP2AP002x00F
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Jonathan Bakker <xc-racer2@live.ca>,
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

On Sun, Feb 2, 2020 at 4:08 PM Jonathan Cameron <jic23@kernel.org> wrote:
> On Sun, 26 Jan 2020 20:27:22 +0000 Jonathan Bakker <xc-racer2@live.ca> wrote:

> > -             if (ch_type != IIO_CURRENT) {
> > +             if (ch_type == IIO_VOLTAGE) {
> > +                     ret = device_property_read_u8(dev,
> > +                             "sharp,adc-adjustment-ratio", &val);
> > +                     if (ret) {
> > +                             dev_err(dev,
> > +                                     "failed to obtain adc conversion\n");
> > +                             return -EINVAL;
> > +                     }
> > +                     gp2ap002->adc_adj = val;
> > +             } else if (ch_type != IIO_CURRENT) {
> >                       dev_err(dev,
> >                               "wrong type of IIO channel specified for ALSOUT\n");
> >                       return -EINVAL;
> >
> > Alternatively, you could collect the resistor value, the ADC precision (this doesn't
> > appear to be queryable via the IIO layer), and the reference voltage level - but I'm
> > not sure how you'd do the inverse calculation in the kernel.
>
> An alternative to doing this is to represent the resistor circuit explicitly.
>
> You end up with a really small ADC driver that is a consumer of a voltage
> and provides a current channel.  That has all the properties of the
> circuit via DT.

That is indeed a lot better, more modular and more reusable.
It also becomes its own node in the device tree with very
generic bindings for resistance and ADC bias/offset.

> In general I would prefer we handle this sort of conversion generically
> rather than bolting it into a light sensor driver like you are doing here,
> even if it comes at the cost of a bit more complexity.

Agreed.

There are however two improvements that can be done as separate
patches to the code in this driver, but preferably by someone with access
to the right hardware so they can verify the result.

The Google Android code pointed to by Mr. Bakker:
https://android.googlesource.com/device/samsung/crespo/+/2e0ab7265e3039fee787c2216e0c98d92ea0b49e%5E%21/#F0

+                // Convert adc value to lux assuming:
+                // I = 10 * log(Ev) uA
+                // R = 47kOhm
+                // Max adc value 4095 = 3.3V
+                // 1/4 of light reaches sensor
+                mPendingEvent.light = powf(10, event->value * (330.0f
/ 4095.0f / 47.0f)) * 4;

contains:

- A logarithmic formula based on the datasheet which we
  don't have but presumably correct. A patch converting the
  crude interpolated look-up table to proper floating point maths
  expressing the curve would be much appreciated and cuts
  down the size of the driver. This should be one simple
  patch with nothing else needing to be changed. According
  to the formula it should be lux = 10^(mA/10) which corresponds
  to the values in the table. I verified the values with a spreadsheet,
  then I sent a patch like this, please test!

- A device tree property to compensate for the attenuation by
  the glass in front of the sensor. In the example the
  attenuation is 75%, only 1/4 of the light actually hits the
  sensor. I am uncertain about the physics of this, should
  that really be expressed as fraction or percentage?
  Should it rather be in dB? This should be another patch
  adding the DT property and maths for the attenuation.

Yours,
Linus Walleij
