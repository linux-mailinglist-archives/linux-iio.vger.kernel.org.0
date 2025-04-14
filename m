Return-Path: <linux-iio+bounces-18078-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 203F5A881B3
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 15:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33D643B931E
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 13:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F4123D2B7;
	Mon, 14 Apr 2025 13:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fFfvTj02"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A052904;
	Mon, 14 Apr 2025 13:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744636831; cv=none; b=O4eunnPFJhThMztOkyHJTAHFa7rKcq0ZE0EHJwDLyOZvRjb3SOavq9NKr3am7jxEyxLKDL2dj6SrAMb7z/9PRnFTFIlTFM1u/XzgOzD4kZ7mVHn4qDUwcAFV6lBeJD5vWW0aXerOPOHJagMEGDaGbvh0hfOQSDxfKaXQgkYVHgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744636831; c=relaxed/simple;
	bh=qLr88WKimglQqeHOQLqpTJLNV8oFxlm/UJuYGO5HLw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q4e1O+9keRPeq/Ub137eKRPQjxzvY5IbqkmU/Ou0nJWCuHD/U5VzhT9kptTR/7oqUJVnscTSgkggZCcl+Hr+8tNZPiwGBNfYgIwZE66iO1gAouRy3jdG6hG34AEyb2YZoY6lTA6bynii0vD6Jw7QPjolAY0DWAcpzj4VkKPKLJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fFfvTj02; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e6b78b80393so529738276.1;
        Mon, 14 Apr 2025 06:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744636828; x=1745241628; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LENjcn0F6sVkTrTGTYqlO5GapuitcYgZ9GkCzUrs3jw=;
        b=fFfvTj02eMiUJ2RK+saW0F5L23aB9VEwLUcBb9DHy4Cnn61VFiwHzbA2RaDFhXW3TS
         rVBFaRu2eFWIHOmwHPZrQqgi/fqhb6CArfRZ1S2myMLxVL2NLuMSMzwk0wST8y36j0zj
         MJqnP4mUYPVXGxPBp+8yqxBgKuLa1PSDsj4B+uF9267o8QRjhz9loV5s9eWaFqNtb8xr
         dbwJPIsH1Lln0oDhxkVqer9EzKJpX7K64PlpGiZtA613e82ZQQ7WD71XnwCgfs08p6Od
         Z4oRDIzVDJ9JgnxZlOykB1QNIwyvHba5eZkzdGpt5SJZ2pRmvMYOtFo8c52TQeKrNJQ9
         hUFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744636828; x=1745241628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LENjcn0F6sVkTrTGTYqlO5GapuitcYgZ9GkCzUrs3jw=;
        b=JH9HhrtyTnYB3TeqIaStihJI/p2J9Iqv0nEIQ/duj+vJeEM3IS7agDrnnMeryTtlsN
         XMf1fkM7lJt5NY/mpa46/xOGVRPjHQ3pWgaE2RXGRCzuN4P77kiKULaRq4oyN+LAIRz2
         Mla+KKnYHGnKMsyIvoEZ2kJOC8gabQzUOd+V9tGI7uDSzp8GJfF0PCFuOPupp16Hn3k7
         RrMF9h2LxtDdZrbNthlmp5uzbCfcXTQERyvkBgD7RVR5FZZ5wk885n4bLhwNBuz3/lGM
         9Me6qRMHBsXgC4ecKqKzbQcInAydbupJDYgF4YaWI+Io5ycDdg3vwqhOd1ZRCkDEkNnl
         Q5wA==
X-Forwarded-Encrypted: i=1; AJvYcCUmF9eFb1awaidDbE60MkfsUngQ4eQkJG1pvxkmImjQgzxDcEnQPLa4yGOV/06QAhY65Z5r8/J/7qo=@vger.kernel.org, AJvYcCVxRDBZtib3ZSqqB41rO5ZNZgQNVHSyAR/r3yM1oc2l5tHQWCo/4WCDtV25vnt7/605h7XsjpdWn9IeBXcN@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1aOfupJjraqMcblerZTGUhwUQ5xZGAwK5UR3Y2kXF9Qa7l3jI
	YHyd/Wl9y8uU0jZ0L+Ue7ez5EA/i2GJAs3c1rWLS8lATyDJ5cWNvPUvSxCTKJh9paxVEeh4GzAp
	c45kmMiwaviMdgQrLGKin/EpCEPg=
X-Gm-Gg: ASbGnctvMxfnUl2Gt49dJwjBpzat7CnLb19DEoaaS0bKfq9rOp7BIErsU79vHcHqYyp
	EevVa6lFwaqzIMTCwUnu86jpMa6nXBdf+Ud4WEvdJe6MWKRwfFZwzPRiGeO1skIqA/1yWndb6SP
	Q1mpna/TZGJ0vgreuPY2k9Gw==
X-Google-Smtp-Source: AGHT+IG2amwl5JKM5eKY909aHAmkd1x9CqgxNixASnHhRi3izkvF6iqhpJrxOPH6EgyiMOQdrtstSyaBk1Ahg1+Q45c=
X-Received: by 2002:a05:6902:f83:b0:e60:9fb1:1f9f with SMTP id
 3f1490d57ef6-e7070ccbca0mr8397968276.1.1744636828461; Mon, 14 Apr 2025
 06:20:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250318230843.76068-1-l.rubusch@gmail.com> <20250318230843.76068-10-l.rubusch@gmail.com>
 <20250331114724.2c2c2e9b@jic23-huawei>
In-Reply-To: <20250331114724.2c2c2e9b@jic23-huawei>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Mon, 14 Apr 2025 15:19:52 +0200
X-Gm-Features: ATxdqUHSoigYjNJ2OuCxPbSfz6S3orfIqN5K-YaZtimTd6RfqqB4OLGiGnX2DEA
Message-ID: <CAFXKEHYXnN9ddSM3wzgRTCZDu3JiaBJ6n8htQEBCiS52G+QzQQ@mail.gmail.com>
Subject: Re: [PATCH v5 09/11] iio: accel: adxl345: add inactivity feature
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, eraretuya@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 31, 2025 at 12:47=E2=80=AFPM Jonathan Cameron <jic23@kernel.org=
> wrote:
>
> On Tue, 18 Mar 2025 23:08:41 +0000
> Lothar Rubusch <l.rubusch@gmail.com> wrote:
>
> > Add the inactivity feature of the sensor. When activity and inactivity
> > are enabled, a link bit will be set linking activity and inactivity
> > handling. Additionally, the auto-sleep mode will be enabled. Due to the
> > link bit the sensor is going to auto-sleep when inactivity was
> > detected.
> >
> > Inactivity detection needs a threshold to be configured, and a time
> > after which it will go into inactivity state if measurements under
> > threshold.
> >
> > When a ODR is configured this time for inactivity is adjusted with a
> > corresponding reasonable default value, in order to have higher
> > frequencies and lower inactivity times, and lower sample frequency but
> > give more time until inactivity. Both with reasonable upper and lower
> > boundaries, since many of the sensor's features (e.g. auto-sleep) will
> > need to operate beween 12.5 Hz and 400 Hz. This is a default setting
> > when actively changing sample frequency, explicitly setting the time
> > until inactivity will overwrite the default.
> >
> > Similarly, setting the g-range will provide a default value for the
> > activity and inactivity thresholds. Both are implicit defaults, but
> > equally can be overwritten to be explicitly configured.
> >
> > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
>
> A few comments inline.  The magic handling of the value 0 is
> a bit of unexpected ABI.
>
> Jonathan
>
> > @@ -327,6 +358,7 @@ static int adxl345_set_act_inact_en(struct adxl345_=
state *st,
> >                                   bool cmd_en)
> >  {
> >       bool axis_en, en;
> > +     unsigned int inact_time_s;
> >       unsigned int threshold;
> >       u32 axis_ctrl =3D 0;
> >       int ret;
> > @@ -345,6 +377,20 @@ static int adxl345_set_act_inact_en(struct adxl345=
_state *st,
> >               default:
> >                       return -EINVAL;
> >               }
> > +     } else {
> > +             switch (axis) {
> > +             case IIO_MOD_X:
> > +                     axis_ctrl =3D ADXL345_INACT_X_EN;
> > +                     break;
> > +             case IIO_MOD_Y:
> > +                     axis_ctrl =3D ADXL345_INACT_Y_EN;
> > +                     break;
> > +             case IIO_MOD_Z:
> > +                     axis_ctrl =3D ADXL345_INACT_Z_EN;
> > +                     break;
> > +             default:
> > +                     return -EINVAL;
> > +             }
> >       }
> >
> >       if (cmd_en)
> > @@ -365,11 +411,67 @@ static int adxl345_set_act_inact_en(struct adxl34=
5_state *st,
> >       if (type =3D=3D ADXL345_ACTIVITY) {
> >               axis_en =3D FIELD_GET(ADXL345_REG_ACT_AXIS_MSK, axis_ctrl=
) > 0;
> >               en =3D axis_en && threshold > 0;
> > +     } else {
>
> So previous suggestion on setting en doesn't work but you can still combi=
ne
> the bits other than the type match to simplify code and get rid of axis_e=
n
> in both paths.
>
> > +             ret =3D regmap_read(st->regmap, ADXL345_REG_TIME_INACT, &=
inact_time_s);
> > +             if (ret)
> > +                     return ret;
> > +
> > +             axis_en =3D FIELD_GET(ADXL345_REG_INACT_AXIS_MSK, axis_ct=
rl) > 0;
> > +             en =3D axis_en && threshold > 0 && inact_time_s > 0;
> >       }
>
> > +/**
> > + * adxl345_set_inact_time_s - Configure inactivity time explicitly or =
by ODR.
> > + * @st: The sensor state instance.
> > + * @val_s: A desired time value, between 0 and 255.
> > + *
> > + * If val_s is 0, a default inactivity time will be computed. It shoul=
d take
> > + * power consumption into consideration. Thus it shall be shorter for =
higher
> > + * frequencies and longer for lower frequencies. Hence, frequencies ab=
ove 255 Hz
> > + * shall default to 10 s and frequencies below 10 Hz shall result in 2=
55 s to
> > + * detect inactivity.
>
> I'd missed this previously.  I've no problem with a default time being se=
t
> on driver load, but a later write of 0 should not result in something ver=
y different
> as that's not standard use of the ABI.  If a user wants to go back to a s=
ensible
> default then they should have stored out what was set initially.
>
> I don't mind if you update the default until the point where they first o=
verride
> it, but from there on we should obey what they request or error out if th=
e
> value requested is not possible.
>

Hm, I'm unsure if I got this wrong. It is not supposed to be an
automatic feature to kick in and change user configured values,
actually. Let me try to explain it differently:
Setting a threshold for an inactivity time in [s] is always applied as
a user wishes. Setting 0s for inactivity time IMHO does not make much
sense, where one could also simply disable the sensor event. So, what
I did now is I implemented when 0s was set by a user for inactivity
time, it will result in an automatic adjustment of inactivity time,
depending on range and odr.

In v6 I will try to refrase the text, and double-check it's contained
in documentation, too. Pls, let me know what you think.

> > + *
> > + * The approach simply subtracts the pre-decimal figure of the configu=
red
> > + * sample frequency from 255 s to compute inactivity time [s]. Sub-Hz =
are thus
> > + * ignored in this estimation. The recommended ODRs for various featur=
es
> > + * (activity/inactivity, sleep modes, free fall, etc.) lie between 12.=
5 Hz and
> > + * 400 Hz, thus higher or lower frequencies will result in the boundar=
y
> > + * defaults or need to be explicitly specified via val_s.
> > + *
> > + * Return: 0 or error value.
> > + */
> > +static int adxl345_set_inact_time_s(struct adxl345_state *st, u32 val_=
s)
> > +{
> > +     unsigned int max_boundary =3D 255;
> > +     unsigned int min_boundary =3D 10;
> > +     unsigned int val =3D min(val_s, max_boundary);
> > +     enum adxl345_odr odr;
> > +     unsigned int regval;
> > +     int ret;
> > +
> > +     if (val =3D=3D 0) {
> > +             ret =3D regmap_read(st->regmap, ADXL345_REG_BW_RATE, &reg=
val);
> > +             if (ret)
> > +                     return ret;
> > +             odr =3D FIELD_GET(ADXL345_BW_RATE_MSK, regval);
> > +
> > +             val =3D (adxl345_odr_tbl[odr][0] > max_boundary)
> > +                     ? min_boundary : max_boundary - adxl345_odr_tbl[o=
dr][0];
> > +     }
> > +
> > +     return regmap_write(st->regmap, ADXL345_REG_TIME_INACT, val);
> >  }
> >
>
> > @@ -1546,10 +1697,18 @@ int adxl345_core_probe(struct device *dev, stru=
ct regmap *regmap,
> >               if (ret)
> >                       return ret;
> >
> > +             ret =3D regmap_write(st->regmap, ADXL345_REG_TIME_INACT, =
3);
> > +             if (ret)
> > +                     return ret;
> > +
> >               ret =3D regmap_write(st->regmap, ADXL345_REG_THRESH_ACT, =
6);
> >               if (ret)
> >                       return ret;
> >
> > +             ret =3D regmap_write(st->regmap, ADXL345_REG_THRESH_INACT=
, 4);
>
> Comments on defaults are good.
>
> > +             if (ret)
> > +                     return ret;
> > +
> >               ret =3D regmap_write(st->regmap, ADXL345_REG_THRESH_TAP, =
tap_threshold);
> >               if (ret)
> >                       return ret;
>

