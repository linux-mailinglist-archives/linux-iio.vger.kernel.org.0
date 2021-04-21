Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47C25367328
	for <lists+linux-iio@lfdr.de>; Wed, 21 Apr 2021 21:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235861AbhDUTGj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 21 Apr 2021 15:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234222AbhDUTGi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 21 Apr 2021 15:06:38 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520F4C06138A;
        Wed, 21 Apr 2021 12:06:04 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id 20so18244269pll.7;
        Wed, 21 Apr 2021 12:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1Y23JnKjBwQdkJUIgYx6qPgc4bpAYldIpTO3iXzJLC8=;
        b=JrYibZGQdBbnfEVpUaV9G0AG6Hr2ikoH4WWszoEkyadJi3tn5QxoiAysIEaMR/B+x+
         a1qCFnyicaxd1Lx9w7tUFyKunaxeySRMJ2+xXy5EXZJJLsA4aFNFkc+AF5RfXZQW1m4T
         aJM00f9JE1VyovGk/FALPO4GMSbscBYkTil1kUELcwzsWaAPYmOASmqj91YBv0kf3HBL
         uJeEng1z/Rf9UEB63/suGcSGTnkVXtQrobqaokbVS0r0MtYcUDDRy9+mgUOBkQI2EUPm
         IszEgl2XWyYRpSq3Tqs/PBSNzRfrxIg2LjwHdGMBJjJAhlK5C0xkFcHR5w6FuMWAqDIr
         guOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1Y23JnKjBwQdkJUIgYx6qPgc4bpAYldIpTO3iXzJLC8=;
        b=BRMrlfnSZscPUKYloEIdbnEGJv9MAm1RXVZA/l8bxJ4WU8xxaZxBVyN8hTRPQpfT5T
         uLqwzmE3Idi1Y4zGxZ798g6l6RqWCpacJxbqf3jUCG8N586wi/J4SKWpfLdiZHPRAquR
         1XQH7N9Sxz5VLAE2bSUN3upnnnym5T+veZiwuvaRJIXXk2iiVld+tAZhX2ycM2+n0N2e
         hJyLPmGHrz/1Y0Z1ym1D973uYs1nu/EhOknTI+pKHJQT2K+Gms+Q8tzgRnV4YAQxU5gd
         T3xon2ktq+Y8fn7s/ctfen2wkiOykw/JhJi2KofV/VXnvtKZqj/WIt9iDz2cSLtkgZLt
         ZRvg==
X-Gm-Message-State: AOAM530iGVpmRjc0nXIwoSE4qTwWRFG6OwD6LU2F8oyqLGGw2gnAFALl
        x5EaEutqEPXs9oshgP/ZG9Va1XKEAUYPtmotX1M=
X-Google-Smtp-Source: ABdhPJziy649pqt6T9VdBy4SyUSxBJ3opznbqD9be7lJ55zKeQJVw9XKmov+U5WpBYJTbB+LXVHs7DdWglYJ2OJzRSw=
X-Received: by 2002:a17:902:a406:b029:e6:78c4:71c8 with SMTP id
 p6-20020a170902a406b02900e678c471c8mr34933891plq.17.1619031963840; Wed, 21
 Apr 2021 12:06:03 -0700 (PDT)
MIME-Version: 1.0
References: <483ac17b-705a-38c3-54ee-7f0089262c03@gmail.com>
 <CACRpkdbEue3OLpU0L_SDAsxpLTY7aqRP5sOZ90pF=o-Yb0ot4Q@mail.gmail.com>
 <f2b7938f-12ea-529b-da5e-83c9c8074e1a@gmail.com> <CACRpkdbtnCoDdwJA9oi88NKStf5uhi72DgP_a=3Dpp_aT=kYNg@mail.gmail.com>
In-Reply-To: <CACRpkdbtnCoDdwJA9oi88NKStf5uhi72DgP_a=3Dpp_aT=kYNg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 21 Apr 2021 22:05:47 +0300
Message-ID: <CAHp75VcEsrM+uYSLo2iEta7C8LQtg26iwQVFX1GUk1Gp5TPT7g@mail.gmail.com>
Subject: Re: BUG: iio: mpu3050: Wrong temperature scale
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Nathan Royer <nroyer@invensense.com>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Apr 21, 2021 at 1:14 PM Linus Walleij <linus.walleij@linaro.org> wr=
ote:
>
> On Tue, Apr 20, 2021 at 11:26 PM Dmitry Osipenko <digetx@gmail.com> wrote=
:
>
> > I found a non-kernel example
> > which uses a similar equation [1], but in a different form. The main
> > difference is that the Arduino code interprets a raw temperature value
> > as a signed integer, while upstream assumes it's unsigned.
> >
> > [1]
> > https://github.com/blaisejarrett/Arduino-Lib.MPU3050/blob/master/MPU305=
0lib.cpp#L111
>
> Oh that's nice. Room temperature as mentioned is 20 deg C
> I think?
>
> The divide by 280 part seems coherent in all examples.
>
> > Still, even if assume that the raw temperature is a signed s16 value, i=
t
> > gives us ~35C in a result, which should be off by ~10C.

Actually here [1] it says in chapter 3.1 that room temperature is 35=C2=B0C=
.

Range: -30=C2=B0C .. +85=C2=B0C
Sensitivity: 280 LSB/=C2=B0C
Room temperature offset: 35=C2=B0C =3D -13200 LSB

[1]: https://www.cdiweb.com/datasheets/invensense/mpu-3000a.pdf

> > Certainly a manual calibration is an option, but we will try to wait fo=
r
> > the answer from Nathans and Jean-Baptiste before going that route.
>
> The method I have seen used is:
> - Collect many bags of silica gel, those little packages of "dryer" that
> come in shoe boxes.
> - Put the device with all these in two layers of plastic bags and pull ou=
t
> cables, glue or strap many layers around the bags to make it really tight
> where the cables come out.
> - Submerge this into a mixture of ice and water which is known to be
> a calibration point for 0 degrees C, wait for some hour or so to
> stabilize, add some ice if it all melts.
>
> Now measures should be 0 deg C so any deviance will be the constant
> offset that need be added for the sensor.



--=20
With Best Regards,
Andy Shevchenko
