Return-Path: <linux-iio+bounces-27942-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1F0D3A26C
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 10:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8F32302EF4C
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 09:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4263635295B;
	Mon, 19 Jan 2026 09:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="P5v3naCu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5BA29BD95
	for <linux-iio@vger.kernel.org>; Mon, 19 Jan 2026 09:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768813613; cv=none; b=ervYzyvgAlLOAqu4z/RSahHOZ46tHNZgzslRAwjLIEfi+sFghGiPRhYktn1QD+mdluOcqRDCDgaMaoiIm/g4msxbsFd1r695ae1AIig9vnpmR7tMxL9lAElA4j4MzimC2Fd+OVjM9TB2MByMvpxg602tgAytd1YdZDzOPCzcmMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768813613; c=relaxed/simple;
	bh=iGCWYqelSdkFUZtn1DuyDlbz8zWMkDvhus6PKioeOAY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=liLykFrtco5CWk2LE6MbbCM25S3FbNzciOX7X7y+wBBngH1gpA1vU7cpyAu2cQ5LJ+lcph/cgc8o4bzObYZffLFniGuHiIl3NQXc4EPFURdRyH0A3K8ZuOzHHRjOzwb7vFrv0Wd7++Q+G93IMsEDxoHFvMMc7ODu0uS9up5U21Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=P5v3naCu; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-64b921d9e67so6786595a12.3
        for <linux-iio@vger.kernel.org>; Mon, 19 Jan 2026 01:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768813609; x=1769418409; darn=vger.kernel.org;
        h=mime-version:user-agent:organization:references:in-reply-to:date:cc
         :to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iGCWYqelSdkFUZtn1DuyDlbz8zWMkDvhus6PKioeOAY=;
        b=P5v3naCuGzbZuTp9dWocciorv3Ov/HNaw5ncPMrneUfdhFJw8dNMFs9U0gLNQy3WBw
         O4xbbE6RUZ9jnl2MPBe8xSrp0hE32fLRj+xNbvc5Gw6SwvFxgyeX3yfXFebXYrvW+Uz+
         KqAj4GfVkKtwj3m/kGu0yzUt+5xzSvEj2HawUI9iKq0xA5sbXztTzubcLrR/mpLa5whW
         m+QT+p+Ux9SF9We7Sqtc+Lt8n1CR2Aglcawq2q0IAF5KzcdRlmSALj9dKc34h5S//h4V
         BSjCW5tau2QqRfRwKRQsVooUG3+oZiNq/hYGVqpqCu467BuaS0V7ZQ1fgb8AGxbLUOPe
         zwdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768813609; x=1769418409;
        h=mime-version:user-agent:organization:references:in-reply-to:date:cc
         :to:from:subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iGCWYqelSdkFUZtn1DuyDlbz8zWMkDvhus6PKioeOAY=;
        b=nyqYQP3NslVbygUc7pcSQJkjrFCaHLt5Z7yKs9YLwQWd+RQXvOPqiiObc/Z3gXsPXF
         nELvmnPpd8qx/f/gl0RxTO0I0druqy8+JVovdD2BWnjQYE/dN0yuJfCcWlIKKiKWIalM
         v2C4mQ7YxGVaOfCevvjxDCp8ocFukqYHL9rxpWgHfaTi/Go4/uH2RrEwXtzZkIftkqGU
         EIFI5Mi26+fIpccPK5PMnu8k6lvuESXKI2K1Beoh5BOiViw4178ZVm/O0HxkuS3CbsTU
         wXRpAemgI+YZ1vmMhjvenfbcKyY+dXKcWsRDux+j9d/+az5urxUBUDQcSYyvVs4p0jXe
         CAMg==
X-Forwarded-Encrypted: i=1; AJvYcCWTRsdjLjqfZIebEp5mbQIF8nPyJ3hW+jrnJdTBza0VtpD7E5VLmvwDd36W9HJ9x9LeEXkFkdoDepw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxugRi3bpvIY4RwozSeQv6CLAiuY4Rzc076CcqTSTK2EvEzuh0F
	oLY1GdKDWFHp17cgK4ZOSwCadhwMHS1SDqmYCM0mRJDQCqmyOQ/Iv+JPQpU/Mj9sS10=
X-Gm-Gg: AY/fxX5nNeoFIykhpuZvcGEaWq8EwLtwgVnxHqEe7lTZ5Bj+ImNzHYWEwSboqyUNxpF
	E61YslYs/I5ypxXyswpimhYncQowgIExb7pFUS+lJY3YUHF7WdDr7lg3D2GHZf1lWgRqt0GzYis
	zARN9AL75P1Ge7W7iHyD4ECWveVhdJbZe7OXgm/eRo7moJayXZfDfSZvKRJ24Bbj7KNa+xMCC93
	P1WIR/We0Umkiqwc+6SEVK/0ma6nCLxKg/TSVQ6wVcl8oMdVoghVgJFk+euxFswbHGBqxTruTXM
	T7DWn6O/1B/86IQjvpiHVl1NxeYsVNfALio+8bTCoWDmn4DO4EsX404Fig+Sg5kShPtePYAye54
	Ae4+tAhYHSlbypDIxB+C52Q5vVWOlvmg0cGxRE0KzT0zCB4lt4DPbIJszP7PFicpcFVzwOIAB9n
	tnYjIEmU2csuM=
X-Received: by 2002:a05:6402:1ecb:b0:641:2cf3:ec3e with SMTP id 4fb4d7f45d1cf-654b955d7dfmr8007220a12.11.1768813608780;
        Mon, 19 Jan 2026 01:06:48 -0800 (PST)
Received: from [10.203.83.30] ([151.37.196.5])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65452cda145sm9666325a12.9.2026.01.19.01.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 01:06:48 -0800 (PST)
Message-ID: <48d5a091cdccb60b5f95d142cbf6df0b16ca4987.camel@baylibre.com>
Subject: Re: [PATCH v2 1/3] iio: imu: st_lsm6dsx: Set FIFO ODR for
 accelerometer and gyroscope only
From: Francesco Lavra <flavra@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, Lorenzo Bianconi
 <lorenzo@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 19 Jan 2026 10:06:36 +0100
In-Reply-To: <20260116194738.48b6e3ff@jic23-huawei>
References: <20260115122431.1014630-1-flavra@baylibre.com>
	 <20260115122431.1014630-2-flavra@baylibre.com> <aWjn3cCNhm9t_DCe@lore-desk>
	 <20260116194738.48b6e3ff@jic23-huawei>
Organization: BayLibre
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-SaN/OiCsypi+41p2bsZZ"
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-SaN/OiCsypi+41p2bsZZ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-01-16 at 19:47 +0000, Jonathan Cameron wrote:
> On Thu, 15 Jan 2026 14:13:01 +0100
> Lorenzo Bianconi <lorenzo@kernel.org> wrote:
>=20
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
> > > accelerometer and gyroscope; however, since commit c91c1c844ebd
> > > ("iio: imu:
> > > st_lsm6dsx: add i2c embedded controller support"), this function is
> > > called
> > > also when configuring the hardware FIFO for external sensors (i.e.
> > > sensors
> > > accessed through the sensor hub functionality), which can result in
> > > unrelated device registers being written.
> > >=20
> > > Add a check to the beginning of st_lsm6dsx_set_fifo_odr() so that it
> > > does
> > > not touch any registers unless it is called for internal sensors.
> > >=20
> > > Fixes: c91c1c844ebd ("iio: imu: st_lsm6dsx: add i2c embedded
> > > controller support")
> > > Signed-off-by: Francesco Lavra <flavra@baylibre.com>
> > > ---
> > > =C2=A0drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 4 ++++
> > > =C2=A01 file changed, 4 insertions(+)
> > >=20
> > > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > > b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > > index 55d877745575..1ee2fc5f5f1f 100644
> > > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > > @@ -225,6 +225,10 @@ static int st_lsm6dsx_set_fifo_odr(struct
> > > st_lsm6dsx_sensor *sensor,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0const struct st_lsm6d=
sx_reg *batch_reg;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u8 data;
> > > =C2=A0
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Only internal sensors h=
ave a FIFO ODR configuration
> > > register. */
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (sensor->id >=3D ARRAY_=
SIZE(hw->settings->batch))
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return 0;=C2=A0=20
> >=20
> > I guess it is more clear to check if the sensor is acc or gyro here.
> > What do you think? Something like:
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (sensor->id !=3D ST_=
LSM6DSX_ID_GYRO &&
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sens=
or->id !=3D ST_LSM6DSX_ID_ACC)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retu=
rn 0;
>=20
> Disadvantage is that to check for overflow we have to know those are 0
> and 1.
> I'm not sure which is better of the two here. One is more logically
> correct
> the other is easier to review :)

I'm keeping this as is, since there are pros and cons to changing it

--=-SaN/OiCsypi+41p2bsZZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEhleFT5U73KMewxTm7fE7c86UNl8FAmlt9BwACgkQ7fE7c86U
Nl8YVQv8C+PmBmDNrdtBfxdxVJFAh7DAtfNpc52SmBRZLjMPLwtpSyUlY9/i3XdA
mg4dv9F/HfzDE/Rcy//VYApAMZFAyVaEqEljPNJkbmsJ1HSz1rViz9nRp646SKoM
Df3VptEQdUxRyDs/Na0Sf85s9IkQUb36H+al6xkqBEnDtB7EmIdO8zzt64O+wqHx
AzWs2eP6h4wVAAo4H29J7B84CIuVt1Zogkf54PUpknXvxOgT/kgTFlH/+yVAhvGG
IYP+vc7vgOaLY7LFx7R9PwVk/weMb8KRgQMfFal7bs/et8sICQrAPJtiHe6bB01g
6EsSZrKIIM/+u7VncOuRTclG7+vi1tqmWm+xuy3GiVtGEHDTRzLmPn2fvA21tCsq
yt9+b7i0JZ+Oa/erMZM6lKAKUVgwHsyNEin0Jx/Ae5QB+m0RyGdfHS4hSA0iM9XW
D1SUNhFPBefULXld/F649EWswG/9rCBImpjcd3r3UXDUgsidiOwly7acThgDIf5c
tOH1ppmj
=sK4z
-----END PGP SIGNATURE-----

--=-SaN/OiCsypi+41p2bsZZ--

