Return-Path: <linux-iio+bounces-20927-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D2CAE4E99
	for <lists+linux-iio@lfdr.de>; Mon, 23 Jun 2025 23:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74385189F5F5
	for <lists+linux-iio@lfdr.de>; Mon, 23 Jun 2025 21:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D923922069F;
	Mon, 23 Jun 2025 21:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="homv4ZlH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A52470838;
	Mon, 23 Jun 2025 21:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750712842; cv=none; b=Zv8YR6faIvljTZj2K0YUzPVzBwlpvsOkl7fMeApR+P0mItbTsL6R0xHoR+1i71VeVZ/ZoOsRVnvJxOq3lf9x6EN9t69S9NTsspk4TsNsh8mD2vp4ZEu75zGtQ9vLbmP49hSCSd5vJEaKsGFp5CLvMqfmT8Kzc1vdeWTS+ndCKDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750712842; c=relaxed/simple;
	bh=gj6Nh48Bqa/jpifwytP4nQvcgn7IakDE0lEsrujhtI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nHUgJNhGsdDkG4sh0sBtUp1cPAvJ2ift2W/04J2rnzjJDL0/EwLk//5eXRnajMsh9n72rR8K4qt8rkKGB8tdSxo96X+fzxRvS9zXrRPZ3yN53jdcMXuZLLyI8lHwLmO/WB8MaM2WENHJhT+qiGEYymPIRi/mf38xmLVcKv4InTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=homv4ZlH; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e7dc7245bcdso589808276.2;
        Mon, 23 Jun 2025 14:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750712840; x=1751317640; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WIktiIAK8TZ7Hzmpbbme4BqBHTRSvQoT3VFTLZchY+E=;
        b=homv4ZlHSDX5KbYKoYPNIw+G/TFV0XihyeA8rHKz3hWH/Wd9sGgwulteT1X5zWTRrm
         Ej3kx4VihFG5kF6arRxAwFfhYAAKPjKHcqWV0znr6vN9mVyP2OJwujzA3yC890u1+7kO
         6/djr4d/LloqpAP5Uc99D7egXfyxnie7FrAzECj/aFg1h4PWoHD04iagZ2uBtKN30NQz
         nOSPx1wcm4/NAiZsln4AUVTarBQIHy6wGsTsGk3DWYagZcE7z1w1Mygew5ztGpPxsoOa
         PovG1ouifiiRSjd7bWQPZhVnYxbifJc7sixVI15nC99hBH4VXvrXsHCh4CkqUIztqjAr
         6BTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750712840; x=1751317640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WIktiIAK8TZ7Hzmpbbme4BqBHTRSvQoT3VFTLZchY+E=;
        b=nlnZt1hTH7JdARjMsDlBwZ+SUo0c94KM8iszhHRJTefRDtBtzSfgugoUr1p7YKppWQ
         xj1z0aCMmlXCSW0L3PnTLQ22rzoKvWDwYe9vSsi1Mdp+oMBBdQk0MERxr8S7XYTEqbxm
         pVB84O93Y1EY+RlldCwhgvpFqP9UHONP0D7D+9MoTFHBNuCdDD7fKOHlFtIRr8yUSMEk
         C0y9d/en1vUPxWMsRVpX0PWXdQrDyoz2vwnthnZLDrgxpNt7WbRoj8mr4zf07TZhz+vu
         zTPuSCBdEWS6EOwW3GHncFZG3FeD8wriUqhGeWTgVjiWwqWRIvG34bLs3xq90i5TJ/fW
         PMOw==
X-Forwarded-Encrypted: i=1; AJvYcCVoamZ0EjKozIZRsX0MOT/GoOf1tn1Ln1smPD20BM88PbJyE8m/XbIgfaaFr/MQWTfvHvgMb9mctpZJ1Y7A@vger.kernel.org, AJvYcCWG7CO+zfKzOzUDeE8GCoFT81lov6RDiWMNyg4iXTUW48YcxfwZoBCPE7icpogs5WOsvpPwsMUThwo=@vger.kernel.org, AJvYcCWYfEeybcWYCdOaJEmKo7oJJu9wQ6+/2IEqNaOwtamqJJ39Vmf6ruKk/E6ym7hBPrruwkl2cjWCysn6@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4VkyIqA3Az8YaiuWehoQFb5U7Y2CIk9+CSEbliutkNg3JxNM7
	E8yFaksRL1CdttdFo8Hh6QICiP/R4DajAKkUDV0Wf+/SIj9JbU0VQX8QZLQxjpE/h35u6IBW+dD
	eT8ORE9xupRzCiutL13xn57coCg2aqgs=
X-Gm-Gg: ASbGnctnGE4jxcQIk/4+EvdgHVwhbzW0sRRaopOfun4Cl2CMe/wIH/xt1zq+N5gzggn
	qGnAK2McMjpharnQKFMjmbmG57LtcSxkb8no4uaqXkiB21i1XKJJ258tavH756P76+NKSdP52EZ
	v2TXsFKrnmCtbQU3/aAjoaxeFugcvTy33VUeHT68jVUFeMXd6ijJHovA==
X-Google-Smtp-Source: AGHT+IGX1SLbO7YPV9P3rLFzrIK7XlJWzCsQmcYNF+HsqVHhXA+vDhsos3/+LIZKMZjMKjrOmdNKgPxRcwCSZ3xbWQw=
X-Received: by 2002:a05:690c:931c:10b0:712:b566:bf7c with SMTP id
 00721157ae682-712c6390298mr65387497b3.1.1750712839863; Mon, 23 Jun 2025
 14:07:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250622155010.164451-1-l.rubusch@gmail.com> <20250622155010.164451-5-l.rubusch@gmail.com>
 <aFkh-E1dG__p_G4m@smile.fi.intel.com>
In-Reply-To: <aFkh-E1dG__p_G4m@smile.fi.intel.com>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Mon, 23 Jun 2025 23:06:44 +0200
X-Gm-Features: AX0GCFusMTwtOEffoDsb82ZqKxDo1D_yxOOF9_FbLOqdgHVtQCU0vg0DRwtC8to
Message-ID: <CAFXKEHan_7+BVshb12JZLH8CJtSPuwv=H_vC2kUWkS411wsqaA@mail.gmail.com>
Subject: Re: [PATCH v10 4/7] iio: accel: adxl345: add inactivity feature
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, corbet@lwn.net, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, eraretuya@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 11:44=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Sun, Jun 22, 2025 at 03:50:07PM +0000, Lothar Rubusch wrote:
> > Add support for the sensor=E2=80=99s inactivity feature in the driver. =
When both
> > activity and inactivity detection are enabled, the sensor sets a link b=
it
> > that ties the two functions together. This also enables auto-sleep mode=
,
> > allowing the sensor to automatically enter sleep state upon detecting
> > inactivity.
> >
> > Inactivity detection relies on a configurable threshold and a specified
> > time period. If sensor measurements remain below the threshold for the
> > defined duration, the sensor transitions to the inactivity state.
> >
> > When an Output Data Rate (ODR) is set, the inactivity time period is
> > automatically adjusted to a sensible default. Higher ODRs result in sho=
rter
> > inactivity timeouts, while lower ODRs allow longer durations-within
> > reasonable upper and lower bounds. This is important because features l=
ike
> > auto-sleep operate effectively only between 12.5 Hz and 400 Hz. These
> > defaults are applied when the sample rate is modified, but users can
> > override them by explicitly setting a custom inactivity timeout.
> >
> > Similarly, configuring the g-range provides default threshold values fo=
r
> > both activity and inactivity detection. These are implicit defaults mea=
nt
> > to simplify configuration, but they can also be manually overridden as
> > needed.
>
> ...
>
> > +static int adxl345_set_inact_time(struct adxl345_state *st, u32 val_s)
> > +{
> > +     int max_boundary =3D U8_MAX;
> > +     int min_boundary =3D 10;
> > +     unsigned int val =3D min(val_s, U8_MAX);
>
> Wondering if it's possible to refer here to max_boundary?
> In any case, split this assignment since it will be easier
> to maintain.
>
> > +     enum adxl345_odr odr;
> > +     unsigned int regval;
> > +     int ret;
>
>         val =3D min(val_s, max_boundary);
>

Well, yes, that's what I had initially. Then min() needed unsigned
int, where clamp() - down below - needed signed int. At the end of the
day, I set up min() here, but later this will disappear. I was
wondering, if it's actually needed anymore, when doing clamp() anyway.

The story is a bit longer, since original version (I think I never
submitted) I started with clamp(), ran into signed / unsigned and
difference from max, that I skipped clamp() until when you complained
about it: "use clamp()"

Long story short, I'll verify this in my tests, but probably I'll
rather drop a call to min() here.

> > +     if (val =3D=3D 0) {
> > +             ret =3D regmap_read(st->regmap, ADXL345_REG_BW_RATE, &reg=
val);
> > +             if (ret)
> > +                     return ret;
> > +
> > +             odr =3D FIELD_GET(ADXL345_BW_RATE_MSK, regval);
> > +             val =3D clamp(max_boundary - adxl345_odr_tbl[odr][0],
> > +                         min_boundary, max_boundary);
> > +     }
> > +
> > +     return regmap_write(st->regmap, ADXL345_REG_TIME_INACT, val);
> > +}
>
> ...
>
> > +     case ADXL345_INACTIVITY:
> > +             en =3D FIELD_GET(ADXL345_INACT_X_EN, axis_ctrl) |
> > +                     FIELD_GET(ADXL345_INACT_Y_EN, axis_ctrl) |
> > +                     FIELD_GET(ADXL345_INACT_Z_EN, axis_ctrl);
>
> As I pointed out earlier. the indentation is supposed to be on the same c=
olomn
> for 'F' letters.
>

Let me allow a stupid question, when you mean on the same column, the
above is wrong? Can you give me an example here how to fix it?

Best,
L

> > +             if (!en)
> > +                     return false;
> > +             break;
>
> ...
>
> > +                     ret =3D regmap_read(st->regmap,
> > +                                       ADXL345_REG_TIME_INACT,
> > +                                       &period);
>
> There is plenty of room on the previous lines. Depending on the next
> changes (which I believe unlikely touch this) it may be packed to two
> lines with a logical split, like
>
>                         ret =3D regmap_read(st->regmap,
>                                           ADXL345_REG_TIME_INACT, &period=
);
>
> It again seems the byproduct of the too strict settings of the wrap limit=
 in
> your editor.
>
> ...
>
> > +     case ADXL345_INACTIVITY:
> > +             axis_ctrl =3D ADXL345_INACT_X_EN | ADXL345_INACT_Y_EN |
> > +                             ADXL345_INACT_Z_EN;
>
> Consider
>                 axis_ctrl =3D
>                         ADXL345_INACT_X_EN | ADXL345_INACT_Y_EN | ADXL345=
_INACT_Z_EN;
>
> (yes, I see that it's longer than 80, but it might worth doing it for the=
 sake of
>  consistency with the previous suggestion).
>
>
> ...
>
> >  static int adxl345_set_range(struct adxl345_state *st, enum adxl345_ra=
nge range)
> >  {
> > -     return regmap_update_bits(st->regmap, ADXL345_REG_DATA_FORMAT,
>
> > +     int ret;
> > +
> > +     ret =3D regmap_update_bits(st->regmap, ADXL345_REG_DATA_FORMAT,
> >                                ADXL345_DATA_FORMAT_RANGE,
> >                                FIELD_PREP(ADXL345_DATA_FORMAT_RANGE, ra=
nge));
> > +     if (ret)
> > +             return ret;
>
> If it's a code from the previous patch, it might make sense to introduce =
ret
> there.
>
> >  }
>
> ...
>
> > +     case IIO_EV_INFO_PERIOD:
> > +             ret =3D regmap_read(st->regmap,
> > +                               ADXL345_REG_TIME_INACT,
> > +                               &period);
>
> Too short lines.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

