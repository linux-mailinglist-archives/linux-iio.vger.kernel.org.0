Return-Path: <linux-iio+bounces-20939-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C693AE5EEE
	for <lists+linux-iio@lfdr.de>; Tue, 24 Jun 2025 10:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F308B4A2A6C
	for <lists+linux-iio@lfdr.de>; Tue, 24 Jun 2025 08:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1E0257424;
	Tue, 24 Jun 2025 08:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XDs9HEBs"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C5230E84D;
	Tue, 24 Jun 2025 08:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750753154; cv=none; b=jmoEIRglcZG9MX1W+ozl8G14YZsJB0aw3ge8lG893fdFfJnBCtC8R7Eix9cuQ3cMHfjmUhS8xYSP1cFCGH72JmL1cZbpuDPVvpfvx5X9O3IaQArb6wKDzWDGOEtZSa7D7+2dmvDpA0dSqu+SHH1d+8f3tkQnF6BJgl2YkXkMg4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750753154; c=relaxed/simple;
	bh=5a9phdz7D6n6ePqfkDs1A4rTHLxpcrtrt0JxKFR2lYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AJ083PGw0hnvRZqKlOaouXVovfX1QkXAaoyFdle4rT5Wn5VZvrk72dOhMXoghOCYZuYfEPhthY3Rx33mD9QO6EfjhY9dGbwZmG4fqlZNQ4Uou2cKauVkHmv0oR0I7PsCnliH4XpZfa8DkZ8fjkwb1FwWJ1qkxn5kdPu6hQE+s2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XDs9HEBs; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-706e7babc4eso2061507b3.2;
        Tue, 24 Jun 2025 01:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750753151; x=1751357951; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VHgEsigv797toVCzAe7I/zuMfsGR9eA4wJiGN0BxYF0=;
        b=XDs9HEBsARdDPgmEx6c0O6kp7IqywRFfgRgO2mjimrzbQGz4h9mOi5ofuCQUaLmyWF
         mBH9Xc3UqM3ZBSWFSEa0OgK80l6jb+JCuHY2tN2HB0mMvRwigDSQv9gOLufKO3WNQAVi
         HFKnLZg4/drRtARPvO4Z+i1ISecCtbX619e5jnolKi0tGE29glx8uFStbfK1vPrhFIdH
         RhVwNPNEsxaaaxW+gBTFf198OqVeRIQFZ1ggN9c2x/Efe7ZRrvYACaMPM2HOpcOHHfQw
         PHdz2fo84zsOyKKmqzuwRlUoatxIE+rSbyE/pO30dYxLXXfg7Qwkc77L3yAD72ZNY4u8
         zUrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750753151; x=1751357951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VHgEsigv797toVCzAe7I/zuMfsGR9eA4wJiGN0BxYF0=;
        b=VZgYEHTvCqKg0/hviVe0M23mnSmaGqWAL+/vM9Ra1e1txj+7EYrd3cASNq26YVaXXM
         wmRAudNbKkBEq/rT20mmV81NzI7m+MauDknnMTpSUXI0RwIqc6iwEZf83c3Pl40YvmCy
         lgS/6TlvZYJhNKKML0yeWYAqGbGTsRKYqLJ11myuGvn1kzWMOYmgqiIAmpRCbmAtk93q
         5Al9vc2S8OeqneQjq5nC7Y4RMj81lA31Cfh+o2rxiEDnSwDEOfYlfhoLpNED4eu8xdq3
         WpdbGu5tSc8lvP7mNCtlwWfmoqDsFHN9f204Nj96xOAdrIb6Dcag7nl6r7autGDowzwB
         HKpw==
X-Forwarded-Encrypted: i=1; AJvYcCUsQB27rwFCLPGWihNP9MhGctIunuNcrI+XaT//byq9B+NRAzTCiGRk4KuxZQCufsFFMqoVFOes/IdQ@vger.kernel.org, AJvYcCUwgIf2sC/khVBqnRw/ZWnpvWihHnNvv+iF7NuQEqREiTbO+FOHU3dCxE9+NlvEE6ymSNy/uSTyCPU=@vger.kernel.org, AJvYcCVkanBSb7nMMDBq+QIu+LFWsdRTb6MVsv06CzNyxxixrD6Hjs5lLJJAsYutl5kJPxkVP+wfDi4sVO3ytfup@vger.kernel.org
X-Gm-Message-State: AOJu0YxtEuO6EIDLAJgh0NWAR3C8E/oCAbDZcKBAaroAI+sEVQiDrQt4
	M8yegOWpxKi/ZRGx1+M+juyXIzxqsmPRJPwMFckUU2N83XyB4/E+ygAWU3LrnrOd7uY7sYxJjPx
	MOKWbJQkvPvfWS2hZ82EYWns8nz5lpXc=
X-Gm-Gg: ASbGncudaN6Zr8EkP62TTZiAUQxO0py6Jze3X1Y6778WGhStGBeE+jOzcC/KssDce35
	CKPVN+YcJodDCtIqEr8vg/ntInq77IURKEG9nHiX8zP+tJx73JTwvmMK/FKKmS0xXZhqRa/dUez
	nxa+tWYflj4rvqC1SMF3qAyp1ZHmjvTsdWXX7Nue80ac1dW+hYbgNVpw==
X-Google-Smtp-Source: AGHT+IEobZ95YPFh7gSnrVYpj1c1HgaveoCeuvwSoyJpoS0Z6TFC3YdT/2xXv5PXGSxYfKmeryT51rEuyJZlHWDM/K8=
X-Received: by 2002:a05:690c:c14:b0:70e:7613:e31b with SMTP id
 00721157ae682-712c639043emr99303287b3.2.1750753151474; Tue, 24 Jun 2025
 01:19:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250622155010.164451-1-l.rubusch@gmail.com> <20250622155010.164451-7-l.rubusch@gmail.com>
 <aFkpv0CUkateel8q@smile.fi.intel.com> <CAFXKEHb9Fbd_UOF90EumEtns82VPhYBrLZ=JtmhVJ4pJsT=q-g@mail.gmail.com>
 <aFpV1f1qapCQunVO@smile.fi.intel.com>
In-Reply-To: <aFpV1f1qapCQunVO@smile.fi.intel.com>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Tue, 24 Jun 2025 10:18:35 +0200
X-Gm-Features: AX0GCFu3oFpqSYvU-4eggzmfabKFBuG-nKLi0LF1UG8mCx-7osic9bYVrJ7mkcw
Message-ID: <CAFXKEHYhXekE29Ljfv=c7oRuzo0irWtJNM7fjW516xQ-ydsm=Q@mail.gmail.com>
Subject: Re: [PATCH v10 6/7] iio: accel: adxl345: extend inactivity time for
 less than 1s
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, corbet@lwn.net, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, eraretuya@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 9:38=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Mon, Jun 23, 2025 at 11:21:01PM +0200, Lothar Rubusch wrote:
> > On Mon, Jun 23, 2025 at 12:17=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@intel.com> wrote:
> > > On Sun, Jun 22, 2025 at 03:50:09PM +0000, Lothar Rubusch wrote:
>
> ...
>
> > > > -static int adxl345_set_inact_time(struct adxl345_state *st, u32 va=
l_s)
> > > > +static int adxl345_set_inact_time(struct adxl345_state *st, u32 va=
l_int,
> > > > +                               u32 val_fract)
> > > >  {
> > > >       int max_boundary =3D U8_MAX;
> > > >       int min_boundary =3D 10;
> > > > -     unsigned int val =3D min(val_s, U8_MAX);
> > > > +     unsigned int val;
> > >
> > > You see, I even suggested splitting this assignment to begin with.
> > > The change will be clearer with that done.
> > >
> > > >       enum adxl345_odr odr;
> > > >       unsigned int regval;
> > > >       int ret;
> > > >
> > > > -     if (val =3D=3D 0) {
> > > > +     if (val_int =3D=3D 0 && val_fract =3D=3D 0) {
> >
> > The case for 0sec, 0.0 or setting "0" and fract will consequently be
> > "0". 0 is an invalid input for this period and sensor, so it will
> > default to an optimized period based on given ODR.
> >
> > > > +             /* Generated inactivity time based on ODR */
> > > >               ret =3D regmap_read(st->regmap, ADXL345_REG_BW_RATE, =
&regval);
> > > >               if (ret)
> > > >                       return ret;
> > >
> > > >               odr =3D FIELD_GET(ADXL345_BW_RATE_MSK, regval);
> > > >               val =3D clamp(max_boundary - adxl345_odr_tbl[odr][0],
> > > >                           min_boundary, max_boundary);
> > > > +             st->inact_time_ms =3D MILLI * val;
> > > > +
> > > > +             /* Inactivity time in s */
> > > > +             return regmap_write(st->regmap, ADXL345_REG_TIME_INAC=
T, val);
> > > > +     } else if (val_int =3D=3D 0 && val_fract > 0) {
> > >
> > > val_fract check is not needed here.
> >
> > Case for e.g. 0.123, numbers under 1s. This goes into the free-fall reg=
ister.
>
> 0.0 is already checked above, and since the val_fract is unsigned this is=
 check
> is redundant.
>
> > > > +             /* time < 1s, free-fall */
> > > > +
> > > > +             /*
> > > > +              * Datasheet max. value is 255 * 5000 us =3D 1.275000=
 seconds.
> > > > +              *
> > > > +              * Recommended values between 100ms and 350ms (0x14 t=
o 0x46)
> > > > +              */
> > > > +             st->inact_time_ms =3D DIV_ROUND_UP(val_fract, MILLI);
> > > > +
> > > > +             return regmap_write(st->regmap, ADXL345_REG_TIME_FF,
> > > > +                                 DIV_ROUND_CLOSEST(val_fract, 5));
> > > > +     } else if (val_int > 0) {
> > >
> > > if now is redundant here, right?
> >
> > So, this will be 1s through 255s. Periods above 1sec. This goes into
> > the inactivity register.
>
> See above,
>

I agree, that checking for val_fract is actually done as a sub case of
val_int, and only if val_int was 0. So, would the following make it
clearer?

if (val_int  =3D=3D 0) {
    if (val_fract =3D=3D 0) {
        // 0 provided, default values
    } else {
        // >0s, e.g. 0.123s, use free-fall register
} else {
    // 1s - 255s, use inactivity register
}

Actually - I did not touch that - I saw some places where I'm already
using nested if/else in the third level. I guess, by the style advice
according to switch/case, this also applies to if/else, right?

If yes, when the according parts go into another round, I might give
it a try to separate as well using helper functions.

Best,
L

> > > > +             /* Time >=3D 1s, inactivity */
> > > > +             st->inact_time_ms =3D MILLI * val_int;
> > > > +
> > > > +             return regmap_write(st->regmap, ADXL345_REG_TIME_INAC=
T, val_int);
> > > >       }
> > > >
> > > > -     return regmap_write(st->regmap, ADXL345_REG_TIME_INACT, val);
> > > > +     /* Do not support negative or wrong input. */
> > > > +     return -EINVAL;
> > > >  }
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

