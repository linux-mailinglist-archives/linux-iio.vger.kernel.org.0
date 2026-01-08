Return-Path: <linux-iio+bounces-27554-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9CDD046D5
	for <lists+linux-iio@lfdr.de>; Thu, 08 Jan 2026 17:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 91EFD323EA73
	for <lists+linux-iio@lfdr.de>; Thu,  8 Jan 2026 15:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8349E4A8F7E;
	Thu,  8 Jan 2026 13:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nrZnx2ec"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49324CA789
	for <linux-iio@vger.kernel.org>; Thu,  8 Jan 2026 13:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767879928; cv=none; b=ehUbpXIcmHTMnZhxYxlIYk4M7eDecqpYjCTeN3nW6nx7SPZ1FHd3ATX6YfdoWmdugEu5eZDfB/u13Q17whhvfb/SCSSWM/GlVT+ot/aIpYiH7gZ1Z0mcUsVSfd0pVg8tmgBsOcykhkOASt9qp8YiiwsAyquGWKrLUV6wGM4WsVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767879928; c=relaxed/simple;
	bh=CA+OcVYwlAR0KUjhM+FdFOnuU8HCz2zYR3BYb70ICG8=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sEIfMhPMUsmhG1asrl8YAlqtZQniIkH4Kx/LPQk7Hj/DaUunk4P0RSL+w+hTjdiFWip61FszzoHQCnZ47uw2daT7AU9XVBJXzvHcPGd8J6c+St64QFAEns6NTVdBzxCpw1KXxkGXfETZiQnA4EaS8vxdeoYYeIVNGeRLfBcrFGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nrZnx2ec; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47d3ba3a4deso18948965e9.2
        for <linux-iio@vger.kernel.org>; Thu, 08 Jan 2026 05:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767879917; x=1768484717; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CA+OcVYwlAR0KUjhM+FdFOnuU8HCz2zYR3BYb70ICG8=;
        b=nrZnx2ecKbeDjKimNBBEFbVp3Teuh885OU7YYKljuFaL+FPf5ra04EGHTffGCyxyJo
         cLnz5EuLHVUQIIEe4zUj9rMIkTJozzzNIfb50rtAFoE2tLqgl+jjaA+3H2tU6rH42DOf
         aeI6GNh56+TB2NceBI68w4AJgqjmYuyPj0OC3betLmpIXbk1aZHClEvSWY4htmrRXEID
         0DUsXvrhmLRvEP7H0mQautb05Xgqt15A3p6BqS/ZqfPPuuM1Qz8dbMhUeEw3LFdvkBIr
         3yCWi0XvDEe2h42Fg6KjKqqw6vOAwon6m5iuAijSFtxlxxXp1UOh8dlSVSrVfW5YSlMD
         ZSvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767879917; x=1768484717;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CA+OcVYwlAR0KUjhM+FdFOnuU8HCz2zYR3BYb70ICG8=;
        b=B9i+BBsDgajHjdCJhFyJ3hGmiqxM+qFwZV7955FI+4owsFxOXrogQnbExsvfFrBlBm
         G2gaplQIwot2cgYpTQQPNfSQrkmvEOyPenU7KMMQjDioHicmV9vmNv3FhGNkHnKyCMig
         N3xWFuAkX0URCQ1KS4bdpYJfMR4LfiYpIP5UKxjAWnpPLXaZuPdRYZ5v40SiEi8aHZfJ
         Hby4p+DzDYVKsLxiZr8FgtXcckDwskwdwQSNXowS5jBu/LSXMmjEh86dQ5vq8m/Zasyl
         //yfl/gVuMrPmDsq2RPo0h+0xHaY6+DXHJADoc45RkbCxGFvi9Q3bL84mPO9ONfLzxz5
         agyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVL/lkO/7V+pERd6PhgQ0qUvhNnjbJa0nlUslOk2XRoid22NPN4058Vd0Rv90qPMnMDFukUv+q3nu0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3hzzu3WnyFjN5boM3QrQ9nSRjISnQ2gyxKqE3sCs7FeeixhwN
	RaUwFH5tJ3Y81dvWtmtkZO4zC1x89cyvW/df6iRYyOelKQFBwhZyymI3
X-Gm-Gg: AY/fxX4HtfaAAoT0pe7+TXCudSmdv71vK5/degf+Pm3EhSgzc9KeXudeHvZRraJSb34
	KTLlIWgJUDo2UOXwKv1H6oP8q8Y+V7HRblkC8JMqSqOIbyHMCLZ2g9Fq9ZrqnocPaDr6kGZZLnj
	cARBfmAeCwcd5oj1SoFH3AwyF8vOq5Uv18oECNuIqBQRUwjrbXP0x25NdU0S5zWu/Y2gLQqcVo3
	l6AG/VyS8pkHqOcUeao99uNLZ7009rrOIakQZa7Fsf0LPx1XXigUeegZ/OIgxaOavm6E93KWozN
	ztI/d2eSKXsh+gWjHzDb2DEXP+P9/FkaKCUZaMm5xacmPn8isqtQ5brzSbGlGvlZ2v6a85KPoj6
	IJE4qcLdgYSgT8H1WjnGPBelukLQ0bvuwr0Jn7NJyPGEIP0/MS8JlyeWCOuGGlTTHSGOPpXxIRA
	W+4qRu58x4hI0AO3yVIqlIHZs8y1XTdQ==
X-Google-Smtp-Source: AGHT+IGqC+YpFC8AtrYSr5K2U+LOC6qSa9F/xVWtbGW+5nd3fTLz34UJcjifFLY4mVHx9luSsoW3bw==
X-Received: by 2002:a05:600c:470c:b0:475:da13:2568 with SMTP id 5b1f17b1804b1-47d84b39626mr67416585e9.25.1767879917115;
        Thu, 08 Jan 2026 05:45:17 -0800 (PST)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d8662c09bsm41168155e9.2.2026.01.08.05.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 05:45:16 -0800 (PST)
Message-ID: <5cd68e397bb45f606f59038290e4f3ac09d241da.camel@gmail.com>
Subject: Re: [PATCH 2/2] iio: accel: adxl380: Add support for 1 kHz sampling
 frequency
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Francesco Lavra <flavra@baylibre.com>, Ramona Gradinariu	
 <ramona.gradinariu@analog.com>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>,  Lars-Peter Clausen	 <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,  Jonathan Cameron	
 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?=	 <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, 	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 08 Jan 2026 13:45:59 +0000
In-Reply-To: <9a5db937dc7072d95d6757cdf2eb8d6fde4abbd0.camel@baylibre.com>
References: <20260107123518.4017292-1-flavra@baylibre.com>
		 <20260107123518.4017292-3-flavra@baylibre.com>
		 <52e5cea72b99fc23c922cf74d7dce3403f43c9cd.camel@gmail.com>
	 <9a5db937dc7072d95d6757cdf2eb8d6fde4abbd0.camel@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-01-07 at 16:39 +0100, Francesco Lavra wrote:
> On Wed, 2026-01-07 at 13:56 +0000, Nuno S=C3=A1 wrote:
> > Hi Francesco,
> >=20
> > On Wed, 2026-01-07 at 13:35 +0100, Francesco Lavra wrote:
> > > In sensor variants (such as ADXL380 and ADXL382) that support low-pow=
er
> > > mode, the SAR signal path allows sampling acceleration data at lower
> > > rates;
> > > more specifically, when the sensor operates in VLP mode, the sampling
> > > frequency is 1 kHz.
> > > To add support for the 1kHz sampling frequency value, modify the
> > > operating
> > > mode selection logic to take into account the sampling frequency, and
> > > configure the decimation filters only when applicable (i.e. when usin=
g
> > > a
> > > sampling frequency that relies on the DSM signal path).
> > >=20
> > > Signed-off-by: Francesco Lavra <flavra@baylibre.com>
> > > ---
> > > =C2=A0drivers/iio/accel/adxl380.c | 49 +++++++++++++++++++++++-------=
-------
> > > =C2=A0drivers/iio/accel/adxl380.h | 10 +++++++-
> > > =C2=A02 files changed, 40 insertions(+), 19 deletions(-)
> > >=20
> > > diff --git a/drivers/iio/accel/adxl380.c b/drivers/iio/accel/adxl380.=
c
> > > index bbf1f88ca781..a6919dfce2e9 100644
> > > --- a/drivers/iio/accel/adxl380.c
> > > +++ b/drivers/iio/accel/adxl380.c
> > > @@ -245,12 +245,14 @@ static int adxl380_set_measure_en(struct
> > > adxl380_state *st, bool en)
> > > =C2=A0
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Activity/Inactivity detection available only =
in
> > > VLP/ULP
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 * mode and for devices that support low power mode=
s.
> > > Otherwise
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 * go straight to measure mode (same bits as
> > > ADXL380_OP_MODE_HP).
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 * mode and for devices that support low power mode=
s.
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0if (st->chip_info->has_low_power &&
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (FIELD_GET(ADXL380_ACT_EN_MSK=
, act_inact_ctl) ||
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FIELD_GET(ADXL380_INACT=
_EN_MSK, act_inact_ctl)))
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0st-=
>odr =3D ADXL380_ODR_VLP;
> > > +
> >=20
> > So before this change we would go to low power mode but still report
> > whatever sampling frequency
> > userspace had configured (which I guess would not correspond to reality=
)?
>=20
> Correct.
>=20
> > With the above we'll
> > update the reported odr right?
>=20
> Right.
>=20
> > Some things/doubts that come to mind:
> >=20
> > 1. If I'm right not sure if this shouldn't be treated as a fix.
>=20
> Yes, this technically fixes an existing issue, but I didn't advertise it =
as
> a fix because solving the issue requires adding support for the 1kHz
> frequency, which seems to go beyond the strict definition of a fix and
> sounds more like a new feature.
> =C2=A0
> > 2. Should we cache the current odr so that we restore it when
> > appropriate?
>=20
> Do you mean caching it when activity detection is enabled and restoring i=
t
> when detection is disabled? It could be done.
>=20

Just and idea. I think it makes sense since enabling activity detection wil=
l change things
under the hood and some users might not realize it. But it is not super imp=
ortant I guess.

> > 3. Other thing that comes to mind is if it makes sense to allow
> > controlling odr if
> > Activity/Inactivity detection is enabled?
>=20
> Disallowing odr control when activity detection is enabled could be an
> option, but what error code should be returned if the user tries to set t=
he
> sampling frequency value when not allowed? -EBUSY?

I think it makes sense given the constrains on activity events. EBUSY would=
 be my choice as well.
Out of curiosity, do you know how the chip behaves if we change the odr wit=
h activity enabled? Is it
just ignored?

- Nuno S=C3=A1


