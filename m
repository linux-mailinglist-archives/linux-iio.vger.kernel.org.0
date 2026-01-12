Return-Path: <linux-iio+bounces-27644-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 705A3D1468C
	for <lists+linux-iio@lfdr.de>; Mon, 12 Jan 2026 18:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8B456300A6D0
	for <lists+linux-iio@lfdr.de>; Mon, 12 Jan 2026 17:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5ABD37A4BA;
	Mon, 12 Jan 2026 17:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="1KVccHfE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9150374171
	for <linux-iio@vger.kernel.org>; Mon, 12 Jan 2026 17:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768239485; cv=none; b=Kv1FwakdQRoVRfIJfKvtecw8rTu2BE8qMCT0we4VmNc/yQuAssbFeDRazb4cSeMn7V3IpFEO4RE7VgNLWLCIRVyLsfWjrXoaih/LbZDeXu1n8ZWN0PrjjNbdbFTaR/bFYcZA+dGjry+ilGG/xTWBarvvYf0yNu0cz36nVrmj9Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768239485; c=relaxed/simple;
	bh=ziwUKic9o6MWNjnofk4xysfhC+K18bxBbKVES9HcNfw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cgT5BU1Hh4SW6/33GG6pE+TIPDefuhyQNGAFVRtckLH+Vf9xhDWgXFIpZsdJYHhQNf0yhzZVv0YLhB372x7EdOxDZiBUt9qrLcXO1ajr+j8gG8z1FCLWIJdUuWgHydsDaC7ehMB52aiUMAbIFFUW4r3CjebjQf0zI6H1MA2w1j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=1KVccHfE; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b87281dbdbcso131316966b.0
        for <linux-iio@vger.kernel.org>; Mon, 12 Jan 2026 09:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768239480; x=1768844280; darn=vger.kernel.org;
        h=mime-version:user-agent:organization:references:in-reply-to:date:cc
         :to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ziwUKic9o6MWNjnofk4xysfhC+K18bxBbKVES9HcNfw=;
        b=1KVccHfECXuBX2zzT/4oxeXhhcW/Jd6fJYr6WlpZ+FrmImx/dAOqNkeFwW96uCXdda
         oAmwSxNF25mKHliJBI0MbkVWaJk9u/GZiP1Fj0Z7MZRKnuW2c4mYVkh8bA2au8DdNs0Y
         cD6ojb6xWo2JpCK9i84UtBA72SklqmbPumtlE+xfX2mbddUvwGtlQlE4/bjyrfFAaOzm
         tqhfoMZADNv02USr9HmPmDpm531NFqmEnpSVbiKIg5cjy9nM7tWpNNTXnG2V6UYzuGUy
         XRUYMX+NVthPvsetB6XJw2GNduvqy56MboK4z/z4n+X3JFFybFPVjvupccoK2FgWhSz6
         4BPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768239480; x=1768844280;
        h=mime-version:user-agent:organization:references:in-reply-to:date:cc
         :to:from:subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ziwUKic9o6MWNjnofk4xysfhC+K18bxBbKVES9HcNfw=;
        b=dTCDzONInTmXodcizrfx6goKOEc4Fvwp3eC9akB3DfOXzZFOAm2+z6VzPtcknVT+0L
         gBD5hFfmBB+M8/UPKEiJ5SJH8XBczDtwAj4d6H6ZKGmABtz1IStmEGTPFhKlSjBBEc19
         wBJZfNqxZXoRa4FxC83/Y/WMbbVOt7tQ9b7D2vM8LS1XGheqV9wtD3crFrg2mS2TdL4o
         S9c/Xy/06T92Uo2dkB8W3i4IG67UkTvqB8AYq1BvSZndV7bUkNDMwm9yqiTabrZeAWXg
         TWoGlkdV3BUSdttJ3AO08PKcY9RokoPvo8/0fZGpKMYVoIH4TQwom5T/Kmhw/SezgmrW
         SFWg==
X-Forwarded-Encrypted: i=1; AJvYcCWwYRcaml6DCc7Jv7nTt6FNRwPts20jqgaoOEefGHZu+jQUUba5vgY44tQVcSU2dHEcAwruiABxtI0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBztiNmmW3gUSCJp9A/1X5zvfwk93b+6CN2hSPcm9mMvZKhmg/
	FuICJwHaOSTd0XO0f0eRH7xtWItp9i/G/++LWLdR+50eaOFwqFmBamiYxLZ9RZqqZYU=
X-Gm-Gg: AY/fxX58RtA/7ToutUdIGQvPqLfkKIl9Sfw3vTrUog7JZWH0echklxVHoLm85W6n+oO
	37kd4JEzRJUIgfLj5HM5C89RgyjekeXvXcTA4j9tQeFdPhNwtfI1HiYVyEEX2NsxaUTAeBjF/Mx
	D5edMCwYPxTlngs1rjOgbXQgywjWlvYNMbuVImQSS+wTa4A5NaQ45WlQNstIuCQ70aym1kfBJ34
	tCQE1O4LrsaRONRzB0rn3nhYwnvRD+b3CD6A4f/am502jvUNUMbjfutq1ipI4RF0R0Lerl74a07
	X2u5IVg8hVLYbbofu/C1XNuafZt6Wm3KrPKRzm5cVdDvu05jjAYWdVy99V/M4SzKLucUwGbobi8
	OksOUqPZnEQOA/AUHYTT0zbPlS91Uc2kC5XRIiHpO2JQR1R79LHldqU4ce5SCkUtw+1gZvXYQUm
	n2t4uJDZSeRgNQig==
X-Google-Smtp-Source: AGHT+IE0HgxbMf4ckCuy9Qhg3yryMNAkVYPPHnv8Onh0bErd06MFqLxQbeDP8pxbU6MZC0xw5Lbq4g==
X-Received: by 2002:a17:906:ef02:b0:b80:751:ee62 with SMTP id a640c23a62f3a-b8444c8e95bmr1833232366b.14.1768239480082;
        Mon, 12 Jan 2026 09:38:00 -0800 (PST)
Received: from [10.203.83.61] ([151.35.240.230])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a56c547sm1978198566b.69.2026.01.12.09.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 09:37:59 -0800 (PST)
Message-ID: <338c098efe0d22aa27d0713fba449e75c4355fc4.camel@baylibre.com>
Subject: Re: [PATCH 2/3] iio: imu: st_lsm6dsx: set FIFO ODR for
 accelerometer and magnetometer only
From: Francesco Lavra <flavra@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, David Lechner
 <dlechner@baylibre.com>,  Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>,  linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Mon, 12 Jan 2026 18:37:54 +0100
In-Reply-To: <20260111162609.14e6fbae@jic23-huawei>
References: <20260109181528.154127-1-flavra@baylibre.com>
	 <20260109181528.154127-3-flavra@baylibre.com>
	 <20260111162351.1407115a@jic23-huawei>
	 <20260111162609.14e6fbae@jic23-huawei>
Organization: BayLibre
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-EMgQ3ORzcx3KcMaqQ+U1"
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-EMgQ3ORzcx3KcMaqQ+U1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2026-01-11 at 16:26 +0000, Jonathan Cameron wrote:
> On Sun, 11 Jan 2026 16:23:51 +0000
> Jonathan Cameron <jic23@kernel.org> wrote:
>=20
> > On Fri,=C2=A0 9 Jan 2026 19:15:27 +0100
> > Francesco Lavra <flavra@baylibre.com> wrote:
> >=20
> > > The st_lsm6dsx_set_fifo_odr() function, which is called when enabling
> > > and
> > > disabling the hardware FIFO, checks the contents of the hw->settings-
> > > >batch
> > > array at index sensor->id, and then sets the current ODR value in
> > > sensor
> > > registers that depend on whether the register address is set in the
> > > above
> > > array element. This logic is valid for internal sensors only, i.e.
> > > the
> > > accelerometer and magnetometer; however, since commit c91c1c844ebd

Oops: s/magnetometer/gyroscope/ (will fix this in the next iteration)

> > > ("iio:
> > > imu: st_lsm6dsx: add i2c embedded controller support"), this function
> > > is
> > > called also when configuring the hardware FIFO for external sensors
> > > (i.e.
> > > sensors accessed through the sensor hub functionality), which can
> > > result in
> > > unrelated device registers being written.
> > >=20
> > > Add a check to the beginning of st_lsm6dsx_set_fifo_odr() so that it
> > > does
> > > not touch any registers unless it is called for internal sensors.
> > >=20
> > > Fixes: c91c1c844ebd ("iio: imu: st_lsm6dsx: add i2c embedded
> > > controller support")
> > > Signed-off-by: Francesco Lavra <flavra@baylibre.com>
> > This seems fine to me. Ideally it would have been first patch in the
> > series
> > as this is one we want to backport.=C2=A0 I'll leave it on list little =
while
> > though to see if Lorenzo or anyone else has time to take a look.
> >=20
> One thing...
>=20
> > Thanks,
> >=20
> > Jonathan
> >=20
> >=20
> > > ---
> > > =C2=A0drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 3 +++
> > > =C2=A01 file changed, 3 insertions(+)
> > >=20
> > > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > > b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > > index 5ac45e6230b5..9db48e835d4f 100644
> > > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > > @@ -225,6 +225,9 @@ static int st_lsm6dsx_set_fifo_odr(struct
> > > st_lsm6dsx_sensor *sensor,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0const struct st_lsm6d=
sx_reg *batch_reg;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u8 data;
> > > =C2=A0
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Only accel and gyro hav=
e batch registers. */
>=20
> It's true we can't use the batch register, but not clear from this
> comment
> that the else path below is inappropriate.=C2=A0 Is it the absence of pat=
ch
> register
> or just that the set_fifo_odr is meaningless for other sensors that
> matters?
> I think this comment needs to provide more detail.

The set_fifo_odr is meaningless for external sensors, so the else path
below is also inappropriate for external sensors; I will amend the comment
to clarify that only internal sensors have a FIFO ODR configuration
register.

> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (sensor->id >=3D ARRAY_=
SIZE(hw->settings->batch))
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0batch_reg =3D &hw->se=
ttings->batch[sensor->id];
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (batch_reg->addr) =
{
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0int val;


--=-EMgQ3ORzcx3KcMaqQ+U1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEhleFT5U73KMewxTm7fE7c86UNl8FAmllMXIACgkQ7fE7c86U
Nl+Higv9GsXqiRCGG6koZnXq8VTOKrINtI9BB/v6GzXujtECRI40NDHBz+qgWUkA
DDKj2s6vqVnG5wjIIvuB0M8xJOl7EwYwaBffPFdrP+2V+gIv9mVBSEze3xUiVQGd
P5CCHIikOSZFbCMMAh/cmjOe4S02xz/cmaCQHE15obrXSyYi/arnZCFSBnVSVllT
xQI8vXDd0gU8Astq817PaoWH+rTuEK+KdAtcWVmhRInMxWFhbPc+vWqd90xTq3gN
3NaIsLb3KQXm90b/5hlVndzo9dKy7Fv1CxdlSh1n5qkECsjXu21m3BfILjSRBWuw
tiJxVYotxf9xpmNjIwNjiGBUVtka3oKlU1RuPoto2Z8qB49u0Aef9yKteT7f9ZiM
CZr7KsKdYoN7uB7ThCxV0pmVXzbHBLvYk8ezWIC7vZQLQfJwLBLR1VIsSJnCqvH5
txka4xsaHWN81eB+0XIKLWqWC161BCNefjheRUVQ4NGXIsYBSu+trW6OE4ta2w9P
wrsS8Fno
=MfSg
-----END PGP SIGNATURE-----

--=-EMgQ3ORzcx3KcMaqQ+U1--

