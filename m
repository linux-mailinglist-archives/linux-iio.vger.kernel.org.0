Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 834503ECB9D
	for <lists+linux-iio@lfdr.de>; Mon, 16 Aug 2021 00:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbhHOWPF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Aug 2021 18:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbhHOWPF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 15 Aug 2021 18:15:05 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F086EC061764;
        Sun, 15 Aug 2021 15:14:34 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id l24so12918551qtj.4;
        Sun, 15 Aug 2021 15:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:content-transfer-encoding:date:message-id:to:cc
         :subject:from:references:in-reply-to;
        bh=UhqKtGQIi5V3cQyOb7CAhpL/IkmmRLLPBGpSwieBIOo=;
        b=dOoxizpZ8c1lltj2PyHaYqNG7uJ245e0PazEiWcr/RZx7ZtCH2ZGg0SJ/iz6O3H1Bh
         PqUXE86P90YfAmNve0YpP5JPBh+lCs9AacIXpfh6YYeZqksgbfmQx93yxyjCRt76V2ZU
         01V8Y5sIIfDGWTr7LVrSrb73xeXvSjhsE4DKYL2MScsEk/CK7BmUjMHw0hL7+gydfjOg
         VbTXL+GtBCGqbaOI2JTtzDHqET5K5GVyZkquIBF7zkcXVoYk/dQX5N22b/1d/EaZHvW/
         x+b2umqy9OWrIPLL4dyz3Abxim3J9US2k3ohneDCmykP+EFG9AvWb4wCiAnAzDXDh2eW
         Jyaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date
         :message-id:to:cc:subject:from:references:in-reply-to;
        bh=UhqKtGQIi5V3cQyOb7CAhpL/IkmmRLLPBGpSwieBIOo=;
        b=AF5NzYg2wrm4sbZIla65ix0GjYBfSXzzLzmFN9PLVJYXu55hZ5jL4t9cdsuzxTJACL
         ZCYrw2LAt1XKLyZLlIV8oqP4U69zAinKFgje8fA5CDyp+zHE/Mw4CwuZxTybvuNi07FI
         IWKCnRFfUATS9U1+LfVze5vamfwtNNKDaBj5k3osDiwPpNczNz/gad7Z1l21cNvgafjs
         x5KYKIMLogp6EaW222DzfhabBCEX4oxLl8tYrMJusxtPi5bLfFmoMpCUxzhaSd0S+3/T
         ZeGGCoIhg+g/tSXfpZGd1j/NyGYVz5iBg1pKy4B07NyUv7rj1qDEgk2DT1tg5wyDlY2A
         ak/A==
X-Gm-Message-State: AOAM532XFVHRMc64dPtbyOMc86zmd0oZMpIO1ge5R0B8R33YQZ+ACGFq
        EKVEqBC1ywHUMY93sjKxdgI=
X-Google-Smtp-Source: ABdhPJwOyIehI2jizBdOw62AIy1vWn5nLx/sze9ncx/ODNOxlfTQf+lK5YX5nvg8CT/CQEbz408cOg==
X-Received: by 2002:a05:622a:3c6:: with SMTP id k6mr11362074qtx.29.1629065673962;
        Sun, 15 Aug 2021 15:14:33 -0700 (PDT)
Received: from localhost (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id m19sm3905608qtx.84.2021.08.15.15.14.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Aug 2021 15:14:33 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 15 Aug 2021 18:14:32 -0400
Message-Id: <CDKFL2EUNDL5.3RT3OOLRJFRGC@shaak>
To:     "Peter Rosin" <peda@axentia.se>, <jic23@kernel.org>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>
Cc:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>
Subject: Re: [PATCH v7 08/13] iio: afe: rescale: fix precision on fractional
 log scale
From:   "Liam Beguin" <liambeguin@gmail.com>
References: <20210801194000.3646303-1-liambeguin@gmail.com>
 <20210801194000.3646303-9-liambeguin@gmail.com>
 <3be0f8d4-eea3-9959-b12d-e28ddae9e23f@axentia.se>
In-Reply-To: <3be0f8d4-eea3-9959-b12d-e28ddae9e23f@axentia.se>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon Aug 2, 2021 at 5:17 AM EDT, Peter Rosin wrote:
> On 2021-08-01 21:39, Liam Beguin wrote:
> > From: Liam Beguin <lvb@xiphos.com>
> >=20
> > The IIO_VAL_FRACTIONAL_LOG2 scale type doesn't return the expected
> > scale. Update the case so that the rescaler returns a fractional type
> > and a more precise scale.
> >=20
> > Signed-off-by: Liam Beguin <lvb@xiphos.com>
> > ---
> >  drivers/iio/afe/iio-rescale.c | 15 ++++++++++-----
> >  1 file changed, 10 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescal=
e.c
> > index abd7ad73d1ce..e37a9766080c 100644
> > --- a/drivers/iio/afe/iio-rescale.c
> > +++ b/drivers/iio/afe/iio-rescale.c
> > @@ -47,12 +47,17 @@ int rescale_process_scale(struct rescale *rescale, =
int scale_type,
> >  		*val2 =3D rescale->denominator;
> >  		return IIO_VAL_FRACTIONAL;
> >  	case IIO_VAL_FRACTIONAL_LOG2:
> > -		tmp =3D *val * 1000000000LL;
> > -		do_div(tmp, rescale->denominator);
> > -		tmp *=3D rescale->numerator;
> > -		do_div(tmp, 1000000000LL);
> > +		if (check_mul_overflow(*val, rescale->numerator, (s32 *)&tmp) ||
> > +		    check_mul_overflow(rescale->denominator, (1 << *val2), (s32 *)&t=
mp2)) {
> > +			tmp =3D (s64)*val * rescale->numerator;
> > +			tmp2 =3D (s64)rescale->denominator * (1 << *val2);
> > +			factor =3D gcd(abs(tmp), abs(tmp2));
> > +			tmp =3D div_s64(tmp, factor);
> > +			tmp2 =3D div_s64(tmp2, factor);

Hi Peter,

Apologies for the delay, I got caught up on some other work.

>
> The case I really worry about is when trying to get an exact result by
> using
> gcd() really doesn't improve the situation, and the only way to avoid
> overflow
> is to reduce the precision. A perhaps contrived example:
>
> scale numerator 1,220,703,125 i.e. 5 ^ 13
> scale denominator 1,162,261,467 i.e. 3 ^ 19
> *val 1,129,900,996 i.e. 7 ^ 10 * 2 ^ 2
> *val2 2 i.e. value =3D 7 ^ 10
>
> Then you get overflow for both the calls to check_mul_overflow(). But
> when gcd()
> returns 1 (or something too small) the overflow is "returned" as-is.

I was aware of the issue when gcd() returns 1 and thought it would be
unlikely enough to not be an issue, but as you pointed out there's also
cases where it returns something that's not good enough to take care of
the overflow. This is unfortunately more likely to happen, and makes it
impossible to ignore.

>
> With the old code you get something that is at least not completely
> wrong, just
> not as accurate as is perhaps possible:
> *val 1,186,715,480
> *val2 2
> Or 1,186,715,480 / 2^2 =3D 296,678,870.
>
> With this patch the above makes you attempt to return the fraction:
> *val 1,379,273,676,757,812,500
> *val2 4,649,045,868
> Or 296,678,870.443403528 (or something like that, not 100% sure about
> all the
> fractional digits, but they are not really important for my argument)
>
> While the latter is more correct, truncation to 32-bit clobbers the
> result so
> in reality this is returned:
> *val -281,918,188
> *val2 354,078,572
> Or -0.796202341
>
> So, while it might seem unlucky that gcd() will not find a big enough
> factor,
> it is certainly possible. And I also worry that when this happens it
> will only
> happen once in a while, and that the resulting bad values might be
> extremely
> unexpected and difficult to track down. Things that happen once in a
> blue moon
> are simply not fun to debug.
>
> I.e. I worry that small islands of input will cause failures. With the
> old code
> there are no such islands. The scale factor alone determines the
> precision, and
> if you get poor precision you get poor precision throughout the range.
> And any
> problem will therefore be "stable" and much easier to debug for
> "innocent" 3rd
> party users that may not even be aware that the rescaler is involved at
> all.

I agree with you, that such islands are a bad thing that might cause a
lot of pain, and it's probably not worth it just to gain a few digits of
precision (that can sometimes be irrelevant).

I'll drop this change and will update the test cases to take into
account an error margin.

>
> This is also an issue I have with patch 7/13, but there the only thing
> that is
> sacrificed is CPU cycles. But nonetheless, I'm dubious if patch 7/13 is
> wise
> precisely because it might cause issues that are intermittent and
> therefore
> difficult to debug.

Again, I agree with you, patch 7/13 has the same limitations,
unfortunately, I did run into an overflow while testing this on a real
setup.

>
> Also, changing the calculation so that you get more precision whenever
> that is
> possible feels dangerous. I fear linearity breaks and that bigger input
> cause
> smaller output due to rounding if the bigger value has to be rounded
> down, but
> that this isn't done carefully enough. I.e. attempting to return an
> exact
> fraction and only falling back to the old code when that is not possible
> is
> still not safe since the old code isn't careful enough about rounding. I
> think
> it is really important that bigger input cause bigger (or equal) output.
> Otherwise you might trigger instability in feedback loops should a
> rescaler be
> involved in a some regulator function.

I see what you mean here, and it's a good point I hadn't considered.

To address some of these concerns, I was thinking of using consecutive
right shifts instead of gcd(), but that seems like the wrong way to go
given that we're working with signed integers.

For 7/13, I'll look into approximating like you did here originally.

Thanks,
Liam

>
> Cheers,
> Peter
>
> > +		}
> >  		*val =3D tmp;
> > -		return scale_type;
> > +		*val2 =3D tmp2;
> > +		return IIO_VAL_FRACTIONAL;
> >  	case IIO_VAL_INT_PLUS_NANO:
> >  	case IIO_VAL_INT_PLUS_MICRO:
> >  		if (scale_type =3D=3D IIO_VAL_INT_PLUS_NANO)
> >=20

