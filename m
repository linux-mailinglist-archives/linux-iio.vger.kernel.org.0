Return-Path: <linux-iio+bounces-27530-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F108CFFC91
	for <lists+linux-iio@lfdr.de>; Wed, 07 Jan 2026 20:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C5A213064AA5
	for <lists+linux-iio@lfdr.de>; Wed,  7 Jan 2026 19:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DFBE3A784E;
	Wed,  7 Jan 2026 15:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MVGIvWUZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441C03A782C
	for <linux-iio@vger.kernel.org>; Wed,  7 Jan 2026 15:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767800406; cv=none; b=cdCmbSsmqzYJkJ6Vd+Q6QmCSuIZCCYUHcRiG9g37BevLUt893NFN2G9FZ8qSWHhRK10QxcUOe5Ycfj1tPpbcU1V9p0/fkPzVQtVHzSzs/noXXKlA7hOBWEXN/+CS4LQbFkeTDPK5EP82dBPT146Kb++oa34Xfkz8meT/ju1YtVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767800406; c=relaxed/simple;
	bh=PwLA3Zx5Zn2HiWNWCkNzXiWy47mDo7eka3UjyZ+0sto=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M3PxnzDqMB5bVcU5+fn8gaG/LXFwadnwkH4fRdggPnkqM/C9y/2fNqFfDCJbzh26WHGDNR5JIm3+O6lKXqjocYlTTQronThiSza0QV7GN+2YK+epiGfnakyjURGA0S7pvt31Fjvhh9SC2YmyEwl6Ss5bAc83BFwe+hMS3AcjWrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=MVGIvWUZ; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b73a9592fb8so175962266b.1
        for <linux-iio@vger.kernel.org>; Wed, 07 Jan 2026 07:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1767800402; x=1768405202; darn=vger.kernel.org;
        h=mime-version:user-agent:organization:references:in-reply-to:date:to
         :from:subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PwLA3Zx5Zn2HiWNWCkNzXiWy47mDo7eka3UjyZ+0sto=;
        b=MVGIvWUZWHmwKKydT3X0OkI3mAp/sfyb+jBIiRMTG/SmNWUEgks5y0WewWjoL1o2nJ
         qZBa48dEXBRoRs8ikKlWdnGFM/Ahq6Qu4jyAi/OX7JsXzTDi+1eDOiYP6nBXO5pNPZ3x
         JrDmTrYwMGB3gRQosrrhVVyCDLXk7Nl+eOUs1kVjxQ6kmApRIuwJ8QioHkY6cZvVcFqD
         43rr3SAD6lcPrp18KqQdEtpWfFnKCcWAgpdjOGvD/BeIQp54wxIJIFWNFHMxUPFRv/wd
         3VIoYhtBIsMvygcUIXYw7aOVizzC9Bi5zFHYwiMMyBcZpPf+PeKiz/ipUV3J4DbUdBBR
         zqyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767800402; x=1768405202;
        h=mime-version:user-agent:organization:references:in-reply-to:date:to
         :from:subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PwLA3Zx5Zn2HiWNWCkNzXiWy47mDo7eka3UjyZ+0sto=;
        b=pkBWUGAsu1mgoWBD+5JiN0RNGV9PIb9bQ2uLyr7OjdfYH6xI/Ykh3oSgy2Yu9JCdqQ
         5GowogvZax3oUfSTvGmmFxV8C2U/IvKsrlUjfhvYWQ1beL6QRLXAnxwqW0Dp7zMCfewr
         HNUWakLCXMSq9dRtza8AaUeUK5KG+d3GPbfl7DTTa+hsaEsSUclVOwIrWT8oB52XJPU0
         7dgJYKZtM3OtWZg+fjjP5M7jM/v5+XY4OnYuk1/8Rr4PuLTR9q/f8JD8yHp4y+rcQX2X
         tP6B3Gznc6dYv03zxUR2YdrNqhFmS4egu6FR0M7ywkN2QLDK2z7adjOJnWSt4BZZt5xM
         vUCg==
X-Forwarded-Encrypted: i=1; AJvYcCV4HneTv4PImEudFYAyCcyjiyZRnaoDNsNbxikD0+aC6YG6Y/ivhCkhyOj382fFA2ukrg3avaXCd2A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXVGfOdeT7yUoEP9SkQOFdIZfLFVfgtIh+yJoEidGfF1n7Fy9T
	9BOieGRjag2mEiabCQTYSWRRiBQ5V9kqNVJ7301RkR7Y1c+/VlC6Y4sywe5Y6GKV3g4=
X-Gm-Gg: AY/fxX4SkRo+ufXVK1PWy8dJL6tL5H6fmVmEwEB7kuyx0UBpMNwBDkQx2VYEJZ9fTI6
	d4+mHkingujKDRplZOuEdUpWWzRweyj00e7EhNTkAhhNksPHz90PyHWI2Kyz7DPoBz1aJuorb2d
	LAujUgMijfGO87RamCaH0rfgghnUaQXcgMzaXoketE5hkRZ5oDVXqqskeN1Dd7DO/t+kKD3AI1R
	j70mzGwqwSQNdTsJjU2MzIiGDU1QkHrh2+lm2iaozPRPa7IF/lOegJegSX2nH+HeSkJqk0Z/6MA
	Tl0Z3Pqr5zyIcU6luqPlSqSggijHLL62+SN1hqtUiT8MnNA0665Ymr1XgYnXqj1zrxIJf1EMMeY
	LYfaNeruKpvG/Y6tB6PBIUFdLM7ugLBF81PXefUhaO8pos67jaWNftRd/WDB65k6FZylplNhbJp
	q8EINaF/r7s3yGk+1CIvxCj4+Qj4Z7O6y6je3JZattZLDWupauJBj1rQ==
X-Google-Smtp-Source: AGHT+IG8iyRFDvJpGLm/z5yMJCGsJNB5YwiiVJILvpfcOkS/LMnMxJa0FAPg22wtE0HI/0++7uGN6w==
X-Received: by 2002:a17:907:a08:b0:b07:87f1:fc42 with SMTP id a640c23a62f3a-b8444f488f0mr347306866b.16.1767800401548;
        Wed, 07 Jan 2026 07:40:01 -0800 (PST)
Received: from [10.203.83.20] (mob-176-245-178-111.net.vodafone.it. [176.245.178.111])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a5126d6sm537439666b.50.2026.01.07.07.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 07:40:00 -0800 (PST)
Message-ID: <9a5db937dc7072d95d6757cdf2eb8d6fde4abbd0.camel@baylibre.com>
Subject: Re: [PATCH 2/2] iio: accel: adxl380: Add support for 1 kHz sampling
 frequency
From: Francesco Lavra <flavra@baylibre.com>
To: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>, Ramona Gradinariu
 <ramona.gradinariu@analog.com>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>,  Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,  Jonathan Cameron
 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>,  linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 07 Jan 2026 16:39:54 +0100
In-Reply-To: <52e5cea72b99fc23c922cf74d7dce3403f43c9cd.camel@gmail.com>
References: <20260107123518.4017292-1-flavra@baylibre.com>
	 <20260107123518.4017292-3-flavra@baylibre.com>
	 <52e5cea72b99fc23c922cf74d7dce3403f43c9cd.camel@gmail.com>
Organization: BayLibre
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-8+xrSS0UILKS/MgU7OkV"
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-8+xrSS0UILKS/MgU7OkV
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-01-07 at 13:56 +0000, Nuno S=C3=A1 wrote:
> Hi Francesco,
>=20
> On Wed, 2026-01-07 at 13:35 +0100, Francesco Lavra wrote:
> > In sensor variants (such as ADXL380 and ADXL382) that support low-power
> > mode, the SAR signal path allows sampling acceleration data at lower
> > rates;
> > more specifically, when the sensor operates in VLP mode, the sampling
> > frequency is 1 kHz.
> > To add support for the 1kHz sampling frequency value, modify the
> > operating
> > mode selection logic to take into account the sampling frequency, and
> > configure the decimation filters only when applicable (i.e. when using
> > a
> > sampling frequency that relies on the DSM signal path).
> >=20
> > Signed-off-by: Francesco Lavra <flavra@baylibre.com>
> > ---
> > =C2=A0drivers/iio/accel/adxl380.c | 49 +++++++++++++++++++++++---------=
-----
> > =C2=A0drivers/iio/accel/adxl380.h | 10 +++++++-
> > =C2=A02 files changed, 40 insertions(+), 19 deletions(-)
> >=20
> > diff --git a/drivers/iio/accel/adxl380.c b/drivers/iio/accel/adxl380.c
> > index bbf1f88ca781..a6919dfce2e9 100644
> > --- a/drivers/iio/accel/adxl380.c
> > +++ b/drivers/iio/accel/adxl380.c
> > @@ -245,12 +245,14 @@ static int adxl380_set_measure_en(struct
> > adxl380_state *st, bool en)
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Activity/Inactivity detection available only =
in
> > VLP/ULP
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 * mode and for devices that support low power modes.
> > Otherwise
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 * go straight to measure mode (same bits as
> > ADXL380_OP_MODE_HP).
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 * mode and for devices that support low power modes.
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0if (st->chip_info->has_low_power &&
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (FIELD_GET(ADXL380_ACT_EN_MSK=
, act_inact_ctl) ||
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FIELD_GET(ADXL380_INACT=
_EN_MSK, act_inact_ctl)))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0st->od=
r =3D ADXL380_ODR_VLP;
> > +
>=20
> So before this change we would go to low power mode but still report
> whatever sampling frequency
> userspace had configured (which I guess would not correspond to reality)?

Correct.

> With the above we'll
> update the reported odr right?

Right.

> Some things/doubts that come to mind:
>=20
> 1. If I'm right not sure if this shouldn't be treated as a fix.

Yes, this technically fixes an existing issue, but I didn't advertise it as
a fix because solving the issue requires adding support for the 1kHz
frequency, which seems to go beyond the strict definition of a fix and
sounds more like a new feature.
=20
> 2. Should we cache the current odr so that we restore it when
> appropriate?

Do you mean caching it when activity detection is enabled and restoring it
when detection is disabled? It could be done.

> 3. Other thing that comes to mind is if it makes sense to allow
> controlling odr if
> Activity/Inactivity detection is enabled?

Disallowing odr control when activity detection is enabled could be an
option, but what error code should be returned if the user tries to set the
sampling frequency value when not allowed? -EBUSY?

>=20
> Thx!
> - Nuno S=C3=A1
>=20


--=-8+xrSS0UILKS/MgU7OkV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEhleFT5U73KMewxTm7fE7c86UNl8FAmlefkoACgkQ7fE7c86U
Nl+YygwAn1ZW3kg/CNvPcdo4qKSi9o/5I/FuTM2rQvY4f2BHGt8W7Y994KenUwW8
gepz01h4sBhCcbyYqUJmzIE57PIhGT6tg2lQPmEinq5qHJW/yvjENLAKBk0+gG5o
rPZKg0C/SDw2EIJed1M9OaWU4kHRzicMCq6HM+9ZWgIWPkEkyk33QDbOEAOZLTOX
i5YT+bpFKhv6hucKdCFyMGf5j4xChIedNJfOKhqqRO2VahHsmETAWer18Vctaiy/
g5NaRRxOlZCZZsenKrptH1cMpJvsgPXKfexw3Q8tM5YUPFkf7xE+8b4LBsFv5Avo
3YvmY4M5FSPSm+7FObADZSgnwG1BKcGC1U4h3rXPHEPmtT41GvEbUpqwKx5KhXU9
3uUvxhCTVWQ53GO6/vGItrnoht7EEx8XAUB72SsthZse4tWFoxDrOGIQUiydbjar
fGAlx9y49QjXsnJq5/jahyO9IadENkbeOH86T0GiLZTkTVOSW+8HliOcCAi2c8TR
1/SCyTVh
=lgfG
-----END PGP SIGNATURE-----

--=-8+xrSS0UILKS/MgU7OkV--

