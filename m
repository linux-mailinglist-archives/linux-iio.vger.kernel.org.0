Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFE3C15640C
	for <lists+linux-iio@lfdr.de>; Sat,  8 Feb 2020 12:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgBHLrO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 8 Feb 2020 06:47:14 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41921 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727076AbgBHLrO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 8 Feb 2020 06:47:14 -0500
Received: by mail-lj1-f193.google.com with SMTP id h23so2048875ljc.8
        for <linux-iio@vger.kernel.org>; Sat, 08 Feb 2020 03:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lfib1cvE8Qx1QhEsPsHSP8YT5t21BPrQoDhCsuJr4lo=;
        b=YMeyOxlCyyXRtks5fVGnlCGzuukSntb+AfCe/WorgOlcILbYjgZV8hcF+Z+pA6ASDW
         t8OcxXpblkJNwNL20kvYNm38nYBiLrzofa10Ka5XS4efRYgvWiIKVozHjcaYOhLLAl1g
         pLEJ6jsfhF/xNmINTA6m/8HKG1ZPrrPKLl1Ki2RblTue9xnbWzk2OMmh8HVyc1rex7K8
         aerZl4bJuwwT4YnDvYUHF39ho4X6zYuX8KjBAnGU+0dlphN+rP+XZiag98eg7MQEKoXV
         OMi8TTt5yM8gc1pm+SNNrLnk1CxRu7j2UKoymh8Y16vMovGQoD/2rBTsv435t0GVXxSO
         /q7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lfib1cvE8Qx1QhEsPsHSP8YT5t21BPrQoDhCsuJr4lo=;
        b=Ml1MlGEQS2GrppRKEmgd+r+xGiVFjrRnHRpe+mWfSgHzWEp4PAY5FbRi4ys8Z+fafu
         +YMQqKNqJreT7COluLYoefkp3a8raCZOVBseehx+IyHtykRkVOV3e3LqOAe7feLL/oaB
         81TvyqSZqWw56nTFbOA3bkyAum8uVzRCiTPaXtz1m2Q+xj1QEStvYKfIHOwPUGvxWtCh
         L5IYBqDmg+EDUYBD8se1QulGvcxUi/Ej4Rw6fYsOvDAx5oGoSo89zFmoDzAjBJcBOZ/y
         tokALEQZx/K/n3qzaE2qOkMGyPe2QD88UsIibdOHdzEfd0tS+/bbsgQFgViEoCjUIt3q
         YHqQ==
X-Gm-Message-State: APjAAAXbNuwbn+I6C10NxZAXCDwgrDb/h7P4SaLp1AGzj1OTDg4B1I0R
        6LeRLzcBhtmQq8KUxNz2UyrCDwt+grP3vysj/zUm0A==
X-Google-Smtp-Source: APXvYqzWoCinsXqyTZEQbGqMPAzCyi65WXPcoeIK8WVUDDy3QqbcirGTn7SNBUPWpsvNR7GjNMiVrDIOPbinNzmU+Ls=
X-Received: by 2002:a2e:81c3:: with SMTP id s3mr2513016ljg.168.1581162432256;
 Sat, 08 Feb 2020 03:47:12 -0800 (PST)
MIME-Version: 1.0
References: <20200126150548.9168-1-linus.walleij@linaro.org>
 <20200126150548.9168-2-linus.walleij@linaro.org> <20200202152742.073a4df6@archlinux>
In-Reply-To: <20200202152742.073a4df6@archlinux>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 8 Feb 2020 12:47:01 +0100
Message-ID: <CACRpkdZ3WWEmAaF6mSVTRTWXsPPQ=BVWNshBTS9wPn4Hc0CEDA@mail.gmail.com>
Subject: Re: [PATCH 2/2 v6] iio: light: Add a driver for Sharp GP2AP002x00F
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linux Input <linux-input@vger.kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Minkyu Kang <mk7.kang@samsung.com>,
        =?UTF-8?Q?Pawe=C5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        Jonathan Bakker <xc-racer2@live.ca>,
        Oskar Andero <oskar.andero@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Feb 2, 2020 at 4:27 PM Jonathan Cameron <jic23@kernel.org> wrote:
> On Sun, 26 Jan 2020 16:05:48 +0100 Linus Walleij <linus.walleij@linaro.or=
g> wrote:

> Hmm. There are a few minor things inline, but in the interests of
> saving everyone time I'll just fix them up.

Sweet! Thanks Jonathan.

> For the missing docs one I'll make something up based on what I think
> they are.  Please check!

OK

> Also it doesn't actually build..
>
> drivers/iio/light/gp2ap002.c:760:26: error: =E2=80=98gp2ap002_id=E2=80=99=
 undeclared here (not in a function); did you mean =E2=80=98gp2ap002_info=
=E2=80=99?
>   760 | MODULE_DEVICE_TABLE(i2c, gp2ap002_id);
>       |                          ^~~~~~~~~~~
> ./include/linux/module.h:230:15: note: in definition of macro =E2=80=98MO=
DULE_DEVICE_TABLE=E2=80=99
>   230 | extern typeof(name) __mod_##type##__##name##_device_table  \
>       |               ^~~~
> ./include/linux/module.h:230:21: error: =E2=80=98__mod_i2c__gp2ap002_id_d=
evice_table=E2=80=99 aliased to undefined symbol =E2=80=98gp2ap002_id=E2=80=
=99
>   230 | extern typeof(name) __mod_##type##__##name##_device_table  \
>       |                     ^~~~~~
> drivers/iio/light/gp2ap002.c:760:1: note: in expansion of macro =E2=80=98=
MODULE_DEVICE_TABLE=E2=80=99
>   760 | MODULE_DEVICE_TABLE(i2c, gp2ap002_id);
>       | ^~~~~~~~~~~~~~~~~~~
>
> I'll fix that as well..

That's what I get for not testing allmodconfig.

I have some new testing infrastructure in place, that will hopefully
let me test this better. I use build servers because my poor desktops
and laptops literally take hours to churn through allyes allno and
allmod configs.

> > +/**
> > + * struct gp2ap002 - GP2AP002 state
> > + * @map: regmap pointer for the i2c regmap
> > + * @dev: pointer to parent device
> > + * @vdd: regulator controlling VDD
> > + * @vio: regulator controlling VIO
> > + * @alsout: IIO ADC channel to convert the ALSOUT signal
>
> Grumble.. Incomplete docs. Please send a follow up patch fixing that.

OK

> > +struct gp2ap002 {
> > +     struct regmap *map;
> > +     struct device *dev;
> > +     struct regulator *vdd;
> > +     struct regulator *vio;
> > +     struct iio_channel *alsout;
> > +     enum iio_event_direction dir;
> This one doesn't actually seem to be used so I dropped it rather than
> make up the docs ;)

OK

> > +     /* VIO should be between 1.65V and VDD */
> > +     ret =3D regulator_get_voltage(gp2ap002->vdd);
> > +     if (ret < 0) {
> > +             dev_err(dev, "failed to get VIO voltage\n");
>
> VDD. I'll fix that up if I don't find anything else.

Thanks!

I checked the result on your testing branch and it looks good to me.

Yours,
Linus Walleij
