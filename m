Return-Path: <linux-iio+bounces-20684-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A048AADA44B
	for <lists+linux-iio@lfdr.de>; Mon, 16 Jun 2025 00:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A466D3ADA6F
	for <lists+linux-iio@lfdr.de>; Sun, 15 Jun 2025 22:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224CF194A67;
	Sun, 15 Jun 2025 22:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yyi7ssTE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575772F22;
	Sun, 15 Jun 2025 22:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750026088; cv=none; b=YEbj9NrZnGyNqwszyW+ef1wQblYMUWtu/eivQcPC9/fupvhbnvWQkMhQ5dp8+EBAqHRFVlKy7/6/Byx2RArEZ74OXUWAs13YFrRnbP4rrvT6zq6YsBUyrs16t7XPFTpR3jPwCRvvTXmMa/xo1by2zqCear37JDyBbmQJE3V1NdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750026088; c=relaxed/simple;
	bh=TBqaFVbJ4gxIpchnp4HCSwGG6aDfC0Sq75i4WRR+YqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SSikpL/JAJUpdV3l+C5nS5du3KA2nlQuYZepg1QAWZcqVzDn5nrva2Vm+6DvvkIQt1zooTSlzPD/a2IIkE3aV4WvSQb0depvZ2H9R3emq5a/aGxUDbXq7k1dH5aF10alRld09I7rwn9ja3WPD8fbo6Y9ChQw2sYa1WD4O6hxh1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yyi7ssTE; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-70b684670e7so4918407b3.2;
        Sun, 15 Jun 2025 15:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750026086; x=1750630886; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TdqgMFNTr3ehEqovd465EYFKV7hHgzdxmOF3mrDho8M=;
        b=Yyi7ssTE8IYzDe+yKshRwOIW6RfWWs+LxWgz64GXv2b5fL5lQGbLovMR4skPeVl8/m
         RfIHFf9zMcbrWj5wsR17OmUKTBoSolO2yobnk4wY0gnuWYRzXxzAvwAXRV6GnmZXaEYr
         TrTHHQS8IsqEwHvY8OmiU0yrxlOw6oRgOKcMVqcqdIhDASreIyo3mZV+L0i/y1P8qWZr
         oeEvwtqkfKy23C75DiD+VIdzRHptGKnPuk5iVSSYGsEPDE2ZZpD/jG19pXWb279QlQmL
         N6SdDkSP7VRZjjAHf2o7gldN31b/2K2coqi5Ivdex94Iq1lXL4WDbwRxbU0lS3E7OG65
         oe4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750026086; x=1750630886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TdqgMFNTr3ehEqovd465EYFKV7hHgzdxmOF3mrDho8M=;
        b=SWDEDC4onSgGCO89BQbZMJKwtZs6aDVE0We0ywW9eZeE5d3y8NG7sIVvaOkbGPEEwc
         4thhFsKbQrYOAxFnMW4Z/CcQhxUxHkC0lNcKHXaVRBGS8OPL613tSw+aE79ryZzLGhpY
         zTeF8PAiLUYwk296BkMsB2cisqEPT1VIteTQ/v5iPgyDi69umrT6Ngd0ZbbFQh6B8v5N
         SVGJuKmsptHP5PPf2tRUc/FMZ1VianUpcUvpLNQfaZ6cbj6Vw/GP9Btin2dgM9HKqeMj
         qGvpZ5XiX88w8vA7SmIA4G/SQFnr40tpkfrEq7YHqemzghHsot07EAd3JnKyANw7XCeg
         pD+w==
X-Forwarded-Encrypted: i=1; AJvYcCVtY6bLZCA1j184c3UDVeeWXaJmBTYHUZrIKP1+/2rlY6/VdxxR4HWW5uTTuteXksssrrDis6d2axTS2nH0@vger.kernel.org, AJvYcCWBN0OfgV7/4Ih2726ErabbUo5inpa3Ib26R5HD7FsApV22n+MURXT82k/A3o/el+EGRgXGVi8+xE0=@vger.kernel.org, AJvYcCX0Go9hDszTUsSfwGFCoQac1ZBJnYA0ETN4gRYMZB1H5f7O6j+Cs71FG3yTv62MISysjkwqgRFC1ZAH@vger.kernel.org
X-Gm-Message-State: AOJu0YxiPSK/seL+AXwnrNk9H3iBxcXqe80GpYy5R3yUKygWbndQqg8R
	DHkTjPCwVrZRVJMStBHFJuy/0QoVVLNbjtiS/7ol1Be+dHw45O845kyUFz4/h7/6sPECWnKVzQk
	9/PjvPj2xLDGmjPR70XbSpriDGk/xuYk=
X-Gm-Gg: ASbGncsspKFHzYGhCSg7x8Rt6jIhgMDCzbAd3ktkD7dGhtxSCBJa07AiyU/g8D6PSSK
	tn4XkWZ1H+w5W8jAHAYVj98XDNwX3P0aNgxyAgE8pfl9N65/Zvc5X8XA7/WPQ9a3LiKRXHYySPt
	a2+4lyuGwYg6dazyKl0V7OWIYJqAwS+r2hj8hIFOfVHFQ=
X-Google-Smtp-Source: AGHT+IFseAFhURE1AhK8P9MNEmc1FkT9QkCiyzuwFk9fE907usx+wuUvJMqYfGutd0Jir6yOpAhPg7+TbgzoWdfPp1w=
X-Received: by 2002:a05:690c:690a:b0:70e:7613:e310 with SMTP id
 00721157ae682-7117536d4f7mr44824687b3.2.1750026086257; Sun, 15 Jun 2025
 15:21:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610215933.84795-1-l.rubusch@gmail.com> <20250610215933.84795-2-l.rubusch@gmail.com>
 <20250614144208.363c29cf@jic23-huawei>
In-Reply-To: <20250614144208.363c29cf@jic23-huawei>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Mon, 16 Jun 2025 00:20:49 +0200
X-Gm-Features: AX0GCFtP0hsj9GfW70c_szvGJIgZ5v5RTMdbCnWZGA24OG6gMvHNZSvbkUsIXx0
Message-ID: <CAFXKEHbh=_A9WvEvkBaz9nNEGX5bxWu2sFvbMtqLM-Ag0cdY0A@mail.gmail.com>
Subject: Re: [PATCH v9 01/11] iio: accel: adxl345: apply scale factor to tap threshold
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, corbet@lwn.net, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, eraretuya@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 14, 2025 at 3:42=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Tue, 10 Jun 2025 21:59:23 +0000
> Lothar Rubusch <l.rubusch@gmail.com> wrote:
>
> > The threshold for tap detection was still not scaled. The datasheet set=
s
> > a scale factor of 62.5mg/LSB. Remove commit about not scaled threshold
> > for tap detection, and apply scaling to it.
> >
>
> Given tap detection algorithms are not generally well defined and not a s=
imple
> threshold (generally) what scaling should we be aiming for here?
> Even if it were a simple threshold, when a channel provides _raw the
> expectation is that event config is vs _raw, not the base units.
>
> So if this doesn't care about the current fullscale range (which the
> comment implied was the case) it would need to rescale when the
> IIO_INFO_SCALE changes.
>
> That comment is I think indicating we decided to gloss over the
> detail because it's going into a (potentially) non trivial algorithm anyw=
ay.
>
> Jonathan
>

Well, the tap threshold so far was around in "raw" LSB bits. At that
time I only left the comment that the value is not scaled. The current
patch is just putting now the scale factor and the sysfs handle then
will take values of 'g' and not just raw bits. This is like for the
other scaled values such as periods.

I think at the time I left the thresholds a bit out, because for me
it's clear what a time is. But I'm not sure, if actually the
thresholds are going so much by the unit values. So, in particular
what is missing here? Is it just about the commit message, or does it
need technical further adjustments?

Best,
L
>
> > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> > ---
> >  drivers/iio/accel/adxl345_core.c | 11 +++++------
> >  1 file changed, 5 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl3=
45_core.c
> > index 7c093c0241de..d80efb68d113 100644
> > --- a/drivers/iio/accel/adxl345_core.c
> > +++ b/drivers/iio/accel/adxl345_core.c
> > @@ -697,17 +697,15 @@ static int adxl345_read_event_value(struct iio_de=
v *indio_dev,
> >               switch (info) {
> >               case IIO_EV_INFO_VALUE:
> >                       /*
> > -                      * The scale factor would be 62.5mg/LSB (i.e. 0xF=
F =3D 16g) but
> > -                      * not applied here. In context of this general p=
urpose sensor,
> > -                      * what imports is rather signal intensity than t=
he absolute
> > -                      * measured g value.
> > +                      * Scale factor is 62.5mg/LSB i.e. 0xff =3D 16g
> >                        */
> >                       ret =3D regmap_read(st->regmap, ADXL345_REG_THRES=
H_TAP,
> >                                         &tap_threshold);
> >                       if (ret)
> >                               return ret;
> > -                     *val =3D sign_extend32(tap_threshold, 7);
> > -                     return IIO_VAL_INT;
> > +                     *val =3D 62500 * sign_extend32(tap_threshold, 7);
> > +                     *val2 =3D MICRO;
> > +                     return IIO_VAL_FRACTIONAL;
> >               case IIO_EV_INFO_TIMEOUT:
> >                       *val =3D st->tap_duration_us;
> >                       *val2 =3D 1000000;
> > @@ -746,6 +744,7 @@ static int adxl345_write_event_value(struct iio_dev=
 *indio_dev,
> >       case IIO_EV_TYPE_GESTURE:
> >               switch (info) {
> >               case IIO_EV_INFO_VALUE:
> > +                     val =3D DIV_ROUND_CLOSEST(val * MICRO + val2, 625=
00);
> >                       ret =3D regmap_write(st->regmap, ADXL345_REG_THRE=
SH_TAP,
> >                                          min(val, 0xFF));
> >                       if (ret)
>

