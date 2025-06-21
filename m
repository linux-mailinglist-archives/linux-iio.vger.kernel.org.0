Return-Path: <linux-iio+bounces-20830-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 383F9AE2B21
	for <lists+linux-iio@lfdr.de>; Sat, 21 Jun 2025 20:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 859E91898550
	for <lists+linux-iio@lfdr.de>; Sat, 21 Jun 2025 18:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3554626FD90;
	Sat, 21 Jun 2025 18:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OKW7wi8Z"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93AB21C9E8;
	Sat, 21 Jun 2025 18:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750529690; cv=none; b=pgGRfNZfnbWYbxDiSbGBU0tE73Ovqm0ywXHf4SC9vVgjvSvAfQtwapwl5Y3gWXd7I9Z/8AB+fvlv26/J7YUreD3EnuaUs2Ql+bynRy4kfekzCmGFZAh8uSB/9LsCueguFMwyR2ggrRG1BWaCp97G3Dve3Ls46t96dnfxoyg4R20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750529690; c=relaxed/simple;
	bh=1cs0cXbMkZOrpNtAR1gyFyo5vtKD+GK9iev2+1bElYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NIYkp4/7xTnLHP8kt+UdFL6M+RaEk03fWnkq76ILsKyTuUv37fx6xkXHkovcQlLhTiOTgB6x1fPYWNM/4XcwoPIgcr3O3QiPFCefFfJHbzvJ9noaVYTEmDXgGzVOnTLTwbIRVQ0crigl1cEMKHwaka65+2ayNiXOXHWBJ9u8eqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OKW7wi8Z; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e81881bdd55so454198276.0;
        Sat, 21 Jun 2025 11:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750529687; x=1751134487; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w2Q+TpFevmaKqs+ZnGNjN0BGT/qoqb8hQl4f0eoBZew=;
        b=OKW7wi8ZKzplO2RefjIoZ2JiIMizVjHShtTbEt7YMTy9fuZ7OiyHyjS68ySw97sY06
         J43sGkMEWASvLyxV4hXDtipJBqYcdNlQAxLB1H1n7sfpBn/tC946eYRxg2GDssS0EjSv
         HJEHWQ++6xO3lapxixsZtGeqUAqJrM9l+GXck97QT9a/ywwVN0ZGalEb0qri/DJ/UQki
         y5o5WkVIO2vQOG+GdzysZLpmaRQmXcWnQ/VCY82lizWpLL2DYLlI9fOZD7ICoRZmNnKN
         vQH8b/EByP9216mwqoDlCEL+Um3GVyK0YO2sYMF0a3hdBTtjlSg34BDEWXuGIUMLlbAF
         FwoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750529687; x=1751134487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w2Q+TpFevmaKqs+ZnGNjN0BGT/qoqb8hQl4f0eoBZew=;
        b=DT/I/LQtafMlc5sy60YaZ+zvX4lySoUw23pwX9uImjq+imGGzvSV9ea33LtbmsvVbq
         86iQJZXaeqizNZxmgFO8Ib8uhQJCIOTpmS73PtjqU5aOcQL7r/3PSz+jmW9x/naqDihr
         zhfa25Qi1ouy25+LtvOiHcN+cIClbsLHs1Dq8ZX140F8sFH6NqQv24VEF40ZkKdV65wi
         QWOSRcqxRhp202uhwMcJWCiZcXvdNkeDH0vKj6aqCXf6vHeP2gcTk0Em7u5hZJ/EQ4bB
         76yoI6FvbKl6IMalWzfnCxOk80STz2gEeAooAcJDtwXjigk2Xe3jsLIoYZi83yRVyN+z
         roog==
X-Forwarded-Encrypted: i=1; AJvYcCVS/lovcMZKFT+us/yXBjDl00y9J5TuNB/yvJouUT+48DFyXBHGeWYvGQdbSaibckNCzBttjSLxcbq4bMuX@vger.kernel.org, AJvYcCXFWCLpvR5l7KKRdlAhbcUKCjaJjLvQ836V4x8khyFswh1rNC4BRSttyn6XEAzx5kbHTZFt/bdNIrk=@vger.kernel.org, AJvYcCXYNSI8xn9qqVzeUJRFSiG5nkRhh+RZzrafh+eN67SPSymrzvziS8bsuCGGJ1Us7s+EDFGr/EN9/C8k@vger.kernel.org
X-Gm-Message-State: AOJu0YwrRXCNgzjsU8tHWhCyRrHr0+6gK7b2MuO+Gf3OxJwd1BN0W8Ix
	wpxI8dyx7xqNsymf2exPJhre4t5WsfUwaXdByZ0/GjdFf5KolRss9GGYLXcUEDXSFmVcAd9GRFX
	F8Pf+ycvfOYCjNcAwfoK7JBBZHc7gAUo=
X-Gm-Gg: ASbGncvabSV8bNoJc3msr6YlS6L5dHa0D8q2gm2Co+Do7pnWUVGw2POsTdX4TJaptyP
	2U+VAy+kwSrhWdRODfDSKRh7OqdLiNGOEpAXPzRnkYbdXAXryFxX4FYbzr7x1Tgdf90nDh383cI
	vsD7J0AWQAUOJmVDKPRuXSrIxPsSPVUyIcieRFANgSZrbnUBDXUE9lWw==
X-Google-Smtp-Source: AGHT+IGA9AGyGrH8+MZOMf2hY13oCcyT6tXGS7nvIUzHT6jvDU8fAF1eZgZWaJWEa2kRbPBhZmU+hgzHnxfEDsIXCuQ=
X-Received: by 2002:a05:690c:4b10:b0:712:a286:2ca2 with SMTP id
 00721157ae682-712c654cc21mr48843047b3.7.1750529686775; Sat, 21 Jun 2025
 11:14:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610215933.84795-1-l.rubusch@gmail.com> <20250610215933.84795-2-l.rubusch@gmail.com>
 <20250614144208.363c29cf@jic23-huawei> <CAFXKEHbh=_A9WvEvkBaz9nNEGX5bxWu2sFvbMtqLM-Ag0cdY0A@mail.gmail.com>
 <20250621175540.4520a6b5@jic23-huawei>
In-Reply-To: <20250621175540.4520a6b5@jic23-huawei>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Sat, 21 Jun 2025 20:14:10 +0200
X-Gm-Features: AX0GCFsNDDjLn6YMSBTV1uxtMOIo0Uzp9OlHogY4u2dUzB0-PPE_mCNSP_fcweY
Message-ID: <CAFXKEHZ_2SJKYzh6i0YauaEdqF8nYdDR-6CY+G3sFtdspsNveA@mail.gmail.com>
Subject: Re: [PATCH v9 01/11] iio: accel: adxl345: apply scale factor to tap threshold
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, corbet@lwn.net, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, eraretuya@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

On Sat, Jun 21, 2025 at 6:55=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Mon, 16 Jun 2025 00:20:49 +0200
> Lothar Rubusch <l.rubusch@gmail.com> wrote:
>
> > On Sat, Jun 14, 2025 at 3:42=E2=80=AFPM Jonathan Cameron <jic23@kernel.=
org> wrote:
> > >
> > > On Tue, 10 Jun 2025 21:59:23 +0000
> > > Lothar Rubusch <l.rubusch@gmail.com> wrote:
> > >
> > > > The threshold for tap detection was still not scaled. The datasheet=
 sets
> > > > a scale factor of 62.5mg/LSB. Remove commit about not scaled thresh=
old
> > > > for tap detection, and apply scaling to it.
> > > >
> > >
> > > Given tap detection algorithms are not generally well defined and not=
 a simple
> > > threshold (generally) what scaling should we be aiming for here?
> > > Even if it were a simple threshold, when a channel provides _raw the
> > > expectation is that event config is vs _raw, not the base units.
> > >
> > > So if this doesn't care about the current fullscale range (which the
> > > comment implied was the case) it would need to rescale when the
> > > IIO_INFO_SCALE changes.
> > >
> > > That comment is I think indicating we decided to gloss over the
> > > detail because it's going into a (potentially) non trivial algorithm =
anyway.
> > >
> > > Jonathan
> > >
> >
> > Well, the tap threshold so far was around in "raw" LSB bits. At that
> > time I only left the comment that the value is not scaled. The current
> > patch is just putting now the scale factor and the sysfs handle then
> > will take values of 'g' and not just raw bits. This is like for the
> > other scaled values such as periods.
>
> Tricky corner because tap isn't a simple threshold - it it were I'd have
> a cleaner argument.
>
> If we were doing this it would need to be scalling to m/s^2 not g but
> that's not important for this discussion.
>
> Huh. For thresholds I thought we had this clear in the ABI docs, but we d=
on't.
> The ABI doc refers to having _raw_ in the name which I'm not sure has bee=
n true
> in a very long time.  The convention is intended to be if the channel
> has _raw the thresholds are in that unit (i.e. ADC counts) and if not
> they are in the processed value units.
>
> It has to be this way because of non linear sensors.  We have cases
> where there isn't a transform we can sensibly convert in the kernel
> to set a 'raw' threshold.   (involves cube roots for instance).
> As a side note, those sensors are one of the few cases where we have
> both _RAW and _PROCESSED because the thresholds have to relate to _RAW
> but we need _PROCESSED to give standard units.
>
> Now for this case where it's kind of tangentially connected by the
> particular algorithm to the raw reading things are non obvious.
> The tap detector could just as easily be a threshold on jerk -
> rate of change of acceleration or some 'score' calculated from
> a bunch of inputs in which case we couldn't apply a scaling.
>
> >
> > I think at the time I left the thresholds a bit out, because for me
> > it's clear what a time is. But I'm not sure, if actually the
> > thresholds are going so much by the unit values. So, in particular
> > what is missing here? Is it just about the commit message, or does it
> > need technical further adjustments?
>
> I don't think the patch is needed. For this particular parameter there
> isn't a clear concept of scale (putting aside that for this particular
> sensor there is one).  Thus it's a twiddle control. No need to connect
> it to real world units at all.  Also change this is an ABI change
> so we should do it only if we are considering the change to be fixing
> a bug.
>

Great to hear! To be honest, I was a bit worried that finally I missed
scaling the threshold to units of g. Then I made it right just by
chance, using the raw values. Patch will be dropped in v10.

Best,
L

> Jonathan
>
> >
> > Best,
> > L
> > >
> > > > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> > > > ---
> > > >  drivers/iio/accel/adxl345_core.c | 11 +++++------
> > > >  1 file changed, 5 insertions(+), 6 deletions(-)
> > > >
> > > > diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/a=
dxl345_core.c
> > > > index 7c093c0241de..d80efb68d113 100644
> > > > --- a/drivers/iio/accel/adxl345_core.c
> > > > +++ b/drivers/iio/accel/adxl345_core.c
> > > > @@ -697,17 +697,15 @@ static int adxl345_read_event_value(struct ii=
o_dev *indio_dev,
> > > >               switch (info) {
> > > >               case IIO_EV_INFO_VALUE:
> > > >                       /*
> > > > -                      * The scale factor would be 62.5mg/LSB (i.e.=
 0xFF =3D 16g) but
> > > > -                      * not applied here. In context of this gener=
al purpose sensor,
> > > > -                      * what imports is rather signal intensity th=
an the absolute
> > > > -                      * measured g value.
> > > > +                      * Scale factor is 62.5mg/LSB i.e. 0xff =3D 1=
6g
> > > >                        */
> > > >                       ret =3D regmap_read(st->regmap, ADXL345_REG_T=
HRESH_TAP,
> > > >                                         &tap_threshold);
> > > >                       if (ret)
> > > >                               return ret;
> > > > -                     *val =3D sign_extend32(tap_threshold, 7);
> > > > -                     return IIO_VAL_INT;
> > > > +                     *val =3D 62500 * sign_extend32(tap_threshold,=
 7);
> > > > +                     *val2 =3D MICRO;
> > > > +                     return IIO_VAL_FRACTIONAL;
> > > >               case IIO_EV_INFO_TIMEOUT:
> > > >                       *val =3D st->tap_duration_us;
> > > >                       *val2 =3D 1000000;
> > > > @@ -746,6 +744,7 @@ static int adxl345_write_event_value(struct iio=
_dev *indio_dev,
> > > >       case IIO_EV_TYPE_GESTURE:
> > > >               switch (info) {
> > > >               case IIO_EV_INFO_VALUE:
> > > > +                     val =3D DIV_ROUND_CLOSEST(val * MICRO + val2,=
 62500);
> > > >                       ret =3D regmap_write(st->regmap, ADXL345_REG_=
THRESH_TAP,
> > > >                                          min(val, 0xFF));
> > > >                       if (ret)
> > >
>

