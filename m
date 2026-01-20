Return-Path: <linux-iio+bounces-28045-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B742D3C40F
	for <lists+linux-iio@lfdr.de>; Tue, 20 Jan 2026 10:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 153C4541657
	for <lists+linux-iio@lfdr.de>; Tue, 20 Jan 2026 09:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31FF03D7D66;
	Tue, 20 Jan 2026 09:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="T0NBBxvk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBEA3D6491
	for <linux-iio@vger.kernel.org>; Tue, 20 Jan 2026 09:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768901307; cv=none; b=b4ujHvleOwVaaUzaBOYRIRV8spzyKaONpezVj/f2oTobLLIbNl/noBkfDDjv3lW3kVXT2C6ecrDfkoASKb207/Qz3pAJsKfgyt3V+/FQLZsYAWQFePceTjM0QELikGFynGxNV4/KL4PkhrJssM6z6dILtKPj0H9vI4eKSov94Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768901307; c=relaxed/simple;
	bh=pW+uY/M58KWJfHfNTHdAztOxy+HkKDH+fsrIIqQbo6s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XWPr+Wba/pvgxTkBzLck4q4I5l7/WNHXXtSMZgtRTKk7hmltvrPTZKXDLR9fDxJWssN0MsIMcGLacp7Oj/n5LYTqTDmx9oldrGukfwcZ5WsqlHf9CfgNA7PrmwTKuwsN2MIGd2w+byU1Dt2pDRPsmlz47Xn3yFMtEk0yslLuz8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=T0NBBxvk; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-658034ce0e3so503580a12.3
        for <linux-iio@vger.kernel.org>; Tue, 20 Jan 2026 01:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768901303; x=1769506103; darn=vger.kernel.org;
        h=mime-version:user-agent:organization:references:in-reply-to:date:cc
         :to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K8I2Yrd+qDz2gFHYKnXEwDO0xyZ88vPtEDQjcpamV10=;
        b=T0NBBxvkcuIaHvAg6GzpMExzQl/y3MvTaDTed9B+n/McIzTncqu9fa7D3GMekKRKyA
         xMU+P7CJj1WoLBgRM7nAk8ZpWInrPy1Q+XVVE81BmV+reqDuaEjXPM9FS4lz3DG1NN2E
         A5+R3+Q7kdb3KxcXqzwJTRgpBvyiebNxRa/lLMyOUIWgsGY/npD0EmeMfIELN3fXKlCG
         R4gglmXTP6EK0cuABiBqxhYiHIm4cBc/t6jYccjr+jQmJtwFSWPSHNZzUEhps6TnySRp
         q76x6oC8IhtwavJbDXd9XiI/jImhVYEXX4O3UjeYsa6mw+VBjVq1f1FGXGC5SjsbH1so
         Bd6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768901303; x=1769506103;
        h=mime-version:user-agent:organization:references:in-reply-to:date:cc
         :to:from:subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K8I2Yrd+qDz2gFHYKnXEwDO0xyZ88vPtEDQjcpamV10=;
        b=WfqZXtcjFKMipkm9bvSVx+yRcZdjWBOQmqqXxlczPK/qw2bBTr+Hr/nP1MPCGlSKNR
         ZxG2PItIZY94oDNxca4WdaWlrgWTfQNs6NMcpU89VjR1Fzk/HvTo1WLTu2XLm4BCbO34
         IGNo+B2XNrBRuPUBxYr65Gqhx2VeOw0pKYRPIHoq+Vuq2CrnHSnr2a+oBU/aDiZmtj4o
         Sg1ifLl1cVXC7hjkvLTCr7OKuM2z8Skf+5hlgCGfaDXW/3mE5nDE6FXIQYbuoPaoU5ON
         T4VAALH0FLoVwYwisuWOV78da2V1lmRuZIIoirg2Q+jat6EDczneicvFWMT2M60zbXy8
         jLZg==
X-Forwarded-Encrypted: i=1; AJvYcCVXCnXm1iTu9hDNl6REO9sC/aRYZOIMAaTWmHdTUQ5xRFBxMFG6WlMUtY7tAdrqD+xY28zAiKmPXRg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUF1RU3ft9j/Myzn0uu1VC2ZfjuOal0V0DXoVK4HZZfV9OGrmY
	RTKnmvbo7iYWi4freRkBaUnFgoy6hjVTXJt69WoI6IuqyUSxhLCm35yY/AATqhOc68E06eukWBo
	Gl9Ra720=
X-Gm-Gg: AZuq6aJREyUrwjyboGsOvqBrhQtQnr7LrfbGHPuVwF8Gi9RjVphI0SzvUOrzT7bIcJe
	nAcVExHmTxaiHlRlwfhu7jHVMhuTN/SA9aYg3SGWJUX9k5p7hjp/GDZafyS6ka8qJw79/ajIJNK
	rvDkPbMW9ORGngt7fqElS9O/WVjVNHvWy2W5JIhtYTy2jveZ4rRqdgLNAlYEHsMWwCiD8QbVhT0
	C1SsgCZYtIQpNts/SLMcurBgXINEYXoSHFgnFIeG/smp7of28rqxwZ3Xelgk6jPnaopFi/+MHaX
	R5BP+qRag955GzehhTOzlkkju3ph4xL0a5pdT4jFwXfUqY/Sukf5hkDXAb2uRMjs3xcD7+B/1sI
	lriZFvAMsL1N3I8WF6KZfhHHIN+DLUWKJKqWYwpwbzyfDQu6KC9qPvLC5yD+rYo/Y0Vk26g==
X-Received: by 2002:a05:6402:5208:b0:647:54ba:6c42 with SMTP id 4fb4d7f45d1cf-657ff29979cmr929977a12.4.1768901303296;
        Tue, 20 Jan 2026 01:28:23 -0800 (PST)
Received: from [10.203.83.229] ([151.47.45.157])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6580781b7f9sm430634a12.17.2026.01.20.01.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 01:28:21 -0800 (PST)
Message-ID: <851180c6f41f8c9cc79d6412eb97f381f0312f00.camel@baylibre.com>
Subject: Re: [PATCH v3 3/3] iio: imu: st_lsm6dsx: add support for rotation
 sensor
From: Francesco Lavra <flavra@baylibre.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, Jonathan Cameron
 <jic23@kernel.org>,  David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 20 Jan 2026 10:28:15 +0100
In-Reply-To: <aW4Ic5bUId3MG4em@smile.fi.intel.com>
References: <20260119100449.1559624-1-flavra@baylibre.com>
	 <20260119100449.1559624-4-flavra@baylibre.com>
	 <aW4Ic5bUId3MG4em@smile.fi.intel.com>
Organization: BayLibre
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-4awvdZ/o3DKgtqHWkTYR"
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-4awvdZ/o3DKgtqHWkTYR
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-01-19 at 12:33 +0200, Andy Shevchenko wrote:
> On Mon, Jan 19, 2026 at 11:04:49AM +0100, Francesco Lavra wrote:
> > Some IMU chips in the LSM6DSX family have sensor fusion features that
> > combine data from the accelerometer and gyroscope. One of these
> > features
> > generates rotation vector data and makes it available in the hardware
> > FIFO as a quaternion (more specifically, the X, Y and Z components of
> > the
> > quaternion vector, expressed as 16-bit half-precision floating-point
> > numbers).
> >=20
> > Add support for a new sensor instance that allows receiving sensor
> > fusion
> > data, by defining a new struct st_lsm6dsx_sf_settings (which contains
> > chip-specific details for the sensor fusion functionality), and adding
> > this
> > struct as a new field in struct st_lsm6dsx_settings. In
> > st_lsm6dsx_core.c,
> > populate this new struct for the LSM6DSV and LSM6DSV16X chips, and add
> > the
> > logic to initialize an additional IIO device if this struct is
> > populated
> > for the hardware type being probed.
> > Note: a new IIO device is being defined (as opposed to adding channels
> > to
> > an existing device) because the rate at which sensor fusion data is
> > generated may not match the data rate from any of the existing devices.
> >=20
> > Tested on LSMDSV16X.
>=20
> ...
>=20
> > st_lsm6dsx_push_tagged_data(struct st_lsm6dsx_hw *hw, u8 tag,
>=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0case ST_LSM6DSX_EXT2_TA=
G:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0iio_dev =3D hw->iio_devs[ST_LSM6DSX_ID_EXT2];
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0break;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0case ST_LSM6DSX_ROT_TAG:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0/*
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 * The sensor reports only the {X, Y, Z} elements of
> > the
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 * quaternion vector; set the W value to 0 (it can be
> > derived
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 * from the {X, Y, Z} values due to the property that
> > the vector
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 * is normalized).
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0*(u16 *)(data + ST_LSM6DSX_SAMPLE_SIZE) =3D 0;
>=20
> This looks confusing taking into account
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0s16 val =3D le16_to_cpu(*=
(__le16 *)data);
>=20
> (which actually should use le16_to_cpup() instead of the direct
> conversion).

The above val variable is used to do a (val >=3D ST_LSM6DSX_INVALID_SAMPLE)
check, which actually should be done only if (tag =3D=3D ST_LSM6DSX_ACC_TAG=
 ||
tag =3D=3D ST_LSM6DSX_GYRO_TAG).
I will add a patch to fix this (it will fix commit 960506ed2c69 "iio: imu:
st_lsm6dsx: enable drdy-mask if available")

> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0iio_dev =3D hw->iio_devs[ST_LSM6DSX_ID_SF];
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0break;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0default:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0return -EINVAL;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>=20
> ...
>=20
> > +int st_lsm6dsx_sf_set_enable(struct st_lsm6dsx_sensor *sensor, bool
> > enable)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct st_lsm6dsx_hw *hw =3D=
 sensor->hw;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0const struct st_lsm6dsx_reg =
*en_reg;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int err;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0guard(mutex)(&hw->page_lock)=
;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0en_reg =3D &hw->settings->sf=
_settings.enable;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0err =3D st_lsm6dsx_sf_set_pa=
ge(hw, true);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (err < 0)
>=20
> Do you need ' < 0' here? Why isn't it required at the end of the
> function?

Will drop ' < 0'

> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return err;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0err =3D regmap_assign_bits(h=
w->regmap, en_reg->addr, en_reg-
> > >mask, enable);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (err < 0) {
>=20
>  is not needed.
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0st_lsm6dsx_sf_set_page(hw, false);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return err;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return st_lsm6dsx_sf_set_pag=
e(hw, false);
> > +}
>=20
> And IIRC I replied that these _sf_set_page() seems to be used only with
> the explicit boolean value, which means a good hint that it needs to be
> split just to two functions doing for true and false. It will increase
> the readability of the code in both places (in the caller and callee).

OK

> ...
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0snprintf(sensor->name, sizeo=
f(sensor->name), "%s_sf", name);
>=20
> Does GCC complain on this (`make W=3D1` build)?
> Since this can cut the string and we don't check the return value, the Q
> is:
> is this okay to have a reduced string?

gcc does not complain with W=3D1. sensor->name is appropriately sized to
accommodate the longest possible name; if it wasn't, the string would be
cut in the accel and gyro IIO devices too (which use a longer suffix than
"_sf").


--=-4awvdZ/o3DKgtqHWkTYR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEhleFT5U73KMewxTm7fE7c86UNl8FAmlvSq8ACgkQ7fE7c86U
Nl88aAwAmJq8KaE8iH4Sb01rxt/xCKH9Oocke9kfeC/fBRciuOb2Ihk5fnlTdxLq
vkHn/JO8zD1HOy8Djdf3fYNvAxwLuHvlUU0g2CftvgKiEzQTYzX6ki49gMDhZT8z
6xK0JWOp3DOizihvMbxh340DJu6GcfYTf09+2mwNVZgJF0j38hLxnY7QfPFNZ4zp
5DIwyWz79wn6yS6UQ3BA217EoE/gAIwZUj/CfYWmXiFxtAvJeVbIsccnHo0Z6ZW3
Q6DD2QhvCVHUZWmmZV/zJPYL+whTwKeVZHeI3AUL7TQCbmCm6KpHCaWw926onuGM
qtCmmD7pV4Y8G2SsulwJvopXyGs35ElC6Wr6K2PBIs11Vejy3903imLluVDknl+W
6bKUkB5FL3PleDXhAmKlTmG8PrikWrHMQsP3kwnNtRx2RFYJUc7Daaqb44jxchTD
MTLFlqdwpNPtsZHFwdqHOreHaH9TwsTgANaTXAUkl6Y2Tx4tbApuQKyRAa2iPN2y
cEEBCsNA
=+Evq
-----END PGP SIGNATURE-----

--=-4awvdZ/o3DKgtqHWkTYR--

