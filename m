Return-Path: <linux-iio+bounces-20928-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 77CF1AE5040
	for <lists+linux-iio@lfdr.de>; Mon, 23 Jun 2025 23:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D80A7AE612
	for <lists+linux-iio@lfdr.de>; Mon, 23 Jun 2025 21:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A132C9D;
	Mon, 23 Jun 2025 21:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CUe42R9S"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114707482;
	Mon, 23 Jun 2025 21:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750713700; cv=none; b=CfKBmO0J4V5BJ+zf1/KXfE8/E3O57CojcOAexyAKtPdgiI+37azPGB6AiP/CkbW5bMIWJTJ+/lMljHrTmftAIR18uw51+JKOR7RjI27qdUtHFSn6WwvMTFstOduYaNWZhSd5Xt7DFLVPUIsk6R1eqq0dP1cc17UmL43l7vX2H5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750713700; c=relaxed/simple;
	bh=GUmRyiBipwQB1znn4EM8MMcdJpwBom/ghiZxQ5pF6gA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PHenOoJDTO6lbgNsTDSblgMBwyGJFFXBx6IwPGzWSPCVu3cv/xPCpCADA6pFUMQ5XusAOo079Egv25Mc4P1Br6ifE/ZH9/o2OyJAScCwbARyI0J42xt7hzHUT8CQwbyul70mgZ+Dk9PC9cFzSQ8cdRaiiogPdU98ZIiiAkpxWyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CUe42R9S; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7111f616c6bso4792957b3.1;
        Mon, 23 Jun 2025 14:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750713698; x=1751318498; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5EhPVXv5KsxcXF90XtgQeQgh5a4/WNYm2viabusGVu4=;
        b=CUe42R9SAQZSuHx3MmfMu+gQqYt4mLYoT8AUzp3x6Yq/6vm6LuTjwR88anoNpHjKU+
         IMlGH8IqcqzVGzGD7E/rVmodGYNnBAB0oPEO7Gfkkj4gJzMFHHHhWYKW+BzzBB8J+qU4
         KTtVJHTa9CrJWpM5xdCCUEFYGdKK7voz8s+uO+hLYW5T6MjxHlTi26XyQtUrVcUeGuCF
         T2iI5bVm+WGRJXE2upC82a4twXonmKVnhKLT/p7FK2tq6WhAOaAEWW6b3b+UAaymxE3t
         RQt11NqN3ursHFLJhvAQCC/I4H5q0a6DoPT+S9HsO7g0jBSdNl7uGTcrVoI4v81HDeWt
         h5uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750713698; x=1751318498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5EhPVXv5KsxcXF90XtgQeQgh5a4/WNYm2viabusGVu4=;
        b=PdpBzN3j1QZBUOJqtMLRHoAPBZVN6f9/JhwOsprZEP+T+uv9kt3whQ05nDJYgBkEvw
         ZEou6/XZAlBN8sOHDWJM+GM7ALna1QBHd68AJdCQ+ylRm6nP7eTlpnIdWS4JXEFTUkMU
         11zjNhYXVN7vhhsjvaV3t9AWpMjW+QjICvxg6NPhvyl9/URjHbf78ysYC4Zww552b7wQ
         BpzAE5cth/3y5iB6MOcrvOOp7H5FCxkAbAFaYJGkPOSrHFkG7dfTBD9emDVIuzoaKs5l
         xvcwIKtD4bHyWgS3K1c5cNdPhLtYqcr/rs9dNxzQ7MzCcNMkmMHiis5+8O3tcjkbbvN9
         FV/g==
X-Forwarded-Encrypted: i=1; AJvYcCU9E5ZLcghRKZCfxVBdJktyW88YkECKXtgEkuRyJBaEQ11YJJSGZQBqrQDfnRcPdR32isXkkMJF0mU=@vger.kernel.org, AJvYcCVOGCyHhDIhWOl9afqszDdgB/xW+2RLGCjLPOF2L78V+WAb5wwG4HRLmJfnPb6rFvft0OSMiJg3mWpxqHvq@vger.kernel.org, AJvYcCWW5mUQB37tc/id4kl8HdNhmJunOdFxqztgTiadLEAfdpXyNzCu29/Rf6Jy+UcLRI1Q1sEa5UUVT388@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2LpZD6oKUqwrdCJwg2UJVk5CHuv4dXh9Ky0x29nmjBqxd2Pli
	0MOUeckw31u0bM/zRCA1Ohv4HmxdXWwexxMU0u1wxuzXKX1kkfCMmwA0DOqdPZ/2Ng1AVAKQUUq
	ZnoTQVcLaNi2dDMxu2fSfLHY9WeCYntsCJg==
X-Gm-Gg: ASbGncuQi6L6/Y+UDTgOT3+uJCA7oxDDQ+qF/ElYQxrD6rFV3DPpGicXuSCTXIBrE8b
	TV4gaZyrpn+wsS/l0TYgBA4eNARVgtg7MYXkCRgVcjx5l+W06QuIpgEagsNL1lLHpG6e8M1ktI6
	qwHTLtVeTA12X/V/eO5d9tnV4mD5SpVvIGMDWeaS/QwXU=
X-Google-Smtp-Source: AGHT+IES96Vhz9Z48D89qHM4JfJPRfuAbs2HBlR+RnR9BBxF8H5SHTIoOyQWADOKLTGV37ZEhEgZLOqoDW+0bkyaSY0=
X-Received: by 2002:a05:690c:3588:b0:70e:2d3d:acdd with SMTP id
 00721157ae682-712c6762396mr91474187b3.9.1750713697442; Mon, 23 Jun 2025
 14:21:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250622155010.164451-1-l.rubusch@gmail.com> <20250622155010.164451-7-l.rubusch@gmail.com>
 <aFkpv0CUkateel8q@smile.fi.intel.com>
In-Reply-To: <aFkpv0CUkateel8q@smile.fi.intel.com>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Mon, 23 Jun 2025 23:21:01 +0200
X-Gm-Features: AX0GCFuEKxrfHsfLqaoz47e3jOBKcPhE3y9Y_EC3s5zhy9Z1SpYK8UTDeG4oh6U
Message-ID: <CAFXKEHb9Fbd_UOF90EumEtns82VPhYBrLZ=JtmhVJ4pJsT=q-g@mail.gmail.com>
Subject: Re: [PATCH v10 6/7] iio: accel: adxl345: extend inactivity time for
 less than 1s
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, corbet@lwn.net, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, eraretuya@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy,

This is a tricky one, I'll give some examples why (I think) the code
is needed as is.


On Mon, Jun 23, 2025 at 12:17=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Sun, Jun 22, 2025 at 03:50:09PM +0000, Lothar Rubusch wrote:
> > Inactivity and free-fall events are essentially the same type of sensor
> > events. Therefore, inactivity detection (normally set for periods betwe=
en 1
> > and 255 seconds) can be extended for shorter durations to support free-=
fall
> > detection.
> >
> > For periods shorter than 1 second, the driver automatically configures =
the
> > threshold and duration using the free-fall register. For periods longer
> > than 1 second, it uses the inactivity threshold and duration using the
> > inactivity registers.
> >
> > When using the free-fall register, the link bit is not set, which means
> > auto-sleep cannot be enabled if activity detection is also active.
>
> ...
>
> > -static int adxl345_set_inact_time(struct adxl345_state *st, u32 val_s)
> > +static int adxl345_set_inact_time(struct adxl345_state *st, u32 val_in=
t,
> > +                               u32 val_fract)
> >  {
> >       int max_boundary =3D U8_MAX;
> >       int min_boundary =3D 10;
> > -     unsigned int val =3D min(val_s, U8_MAX);
> > +     unsigned int val;
>
> You see, I even suggested splitting this assignment to begin with.
> The change will be clearer with that done.
>
> >       enum adxl345_odr odr;
> >       unsigned int regval;
> >       int ret;
> >
> > -     if (val =3D=3D 0) {
> > +     if (val_int =3D=3D 0 && val_fract =3D=3D 0) {

The case for 0sec, 0.0 or setting "0" and fract will consequently be
"0". 0 is an invalid input for this period and sensor, so it will
default to an optimized period based on given ODR.

> > +             /* Generated inactivity time based on ODR */
> >               ret =3D regmap_read(st->regmap, ADXL345_REG_BW_RATE, &reg=
val);
> >               if (ret)
> >                       return ret;
>
> >               odr =3D FIELD_GET(ADXL345_BW_RATE_MSK, regval);
> >               val =3D clamp(max_boundary - adxl345_odr_tbl[odr][0],
> >                           min_boundary, max_boundary);
> > +             st->inact_time_ms =3D MILLI * val;
> > +
> > +             /* Inactivity time in s */
> > +             return regmap_write(st->regmap, ADXL345_REG_TIME_INACT, v=
al);
> > +     } else if (val_int =3D=3D 0 && val_fract > 0) {
>
> val_fract check is not needed here.
>

Case for e.g. 0.123, numbers under 1s. This goes into the free-fall registe=
r.

> > +             /* time < 1s, free-fall */
> > +
> > +             /*
> > +              * Datasheet max. value is 255 * 5000 us =3D 1.275000 sec=
onds.
> > +              *
> > +              * Recommended values between 100ms and 350ms (0x14 to 0x=
46)
> > +              */
> > +             st->inact_time_ms =3D DIV_ROUND_UP(val_fract, MILLI);
> > +
> > +             return regmap_write(st->regmap, ADXL345_REG_TIME_FF,
> > +                                 DIV_ROUND_CLOSEST(val_fract, 5));
> > +     } else if (val_int > 0) {
>
> if now is redundant here, right?
>

So, this will be 1s through 255s. Periods above 1sec. This goes into
the inactivity register.

> > +             /* Time >=3D 1s, inactivity */
> > +             st->inact_time_ms =3D MILLI * val_int;
> > +
> > +             return regmap_write(st->regmap, ADXL345_REG_TIME_INACT, v=
al_int);
> >       }
> >
> > -     return regmap_write(st->regmap, ADXL345_REG_TIME_INACT, val);
> > +     /* Do not support negative or wrong input. */
> > +     return -EINVAL;
> >  }
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

