Return-Path: <linux-iio+bounces-27663-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EBAD17C8F
	for <lists+linux-iio@lfdr.de>; Tue, 13 Jan 2026 10:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CAFE7306629C
	for <lists+linux-iio@lfdr.de>; Tue, 13 Jan 2026 09:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B76389DEE;
	Tue, 13 Jan 2026 09:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="cWd2vjpq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F6930F949
	for <linux-iio@vger.kernel.org>; Tue, 13 Jan 2026 09:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768297731; cv=none; b=jEKol7C0xUtuXozpFOHU4wK2mtCTzPJlxQsDGwMDq4SzWodDkgjHpkbWiKEvIPVfbrQfFPlxdGYr4FDIPViyh1Bu8onWyRzw0yzdJy7s0ICkZJXUNgfFSga+Yx7fhGCorp1aAWAGmawj1wEMrMkBpKiq+W9/zs9JUuScFX682No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768297731; c=relaxed/simple;
	bh=i348gqMdswd1G1wgpJWWCs8x1y4Nm4/Loi6M1SwO2aI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tcewwu5dPMNv2ZSlp+EQkydtuGLNFGotJ1obnkJ7U+UoKX9moV223hGLTrFH8XUIEtkvt7wrrNHJG6GnGVOYeOncbiXNlWpkgyXz45giNUvk6OJzO6qgRLij/xIwzyAY1BDQyILu4Ynj19+BXRoN6BZUlpoUTzLXI6xZ739xsEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=cWd2vjpq; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-652fdd043f9so1199570a12.1
        for <linux-iio@vger.kernel.org>; Tue, 13 Jan 2026 01:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768297726; x=1768902526; darn=vger.kernel.org;
        h=mime-version:user-agent:organization:references:in-reply-to:date:cc
         :to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i348gqMdswd1G1wgpJWWCs8x1y4Nm4/Loi6M1SwO2aI=;
        b=cWd2vjpqVsBJ+jJVeZG0pAUZ4UhkqJaBFSsItDeQsTpBDD/SeIXx3eh79E8rYUCKP3
         kMKVXrzsxI27f0p/S/dmccD9TT+PJgvDTs1RTuJstn5tlgwcUqOB09gHxbiqgiClPM3T
         C61jBSmGTR2/DX7NtnKPafAv+J9SJKgFgU6S+Ev+sWb7Jh3g6OaNl8cW5tzLMNoSFGU2
         3/1P56zfBoWakMkcvab0axVTW+Jm5bzexmVfv/2HPBOKlJDbv01Xaoonl0V9vLyYn43I
         NtU3oabximwm1nTb1KpBnQiS8fXInVXCexbeBoIuS4IN/CTrez8yYUfJrC7n+If9E6YG
         Tdqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768297726; x=1768902526;
        h=mime-version:user-agent:organization:references:in-reply-to:date:cc
         :to:from:subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i348gqMdswd1G1wgpJWWCs8x1y4Nm4/Loi6M1SwO2aI=;
        b=b5HFco18knBfSuG54wCc4ldmVAgurJxngGRT62HjFyy0noD7TOKkWwAbaQWauZTkz/
         JqUzAATtr7BUgC62zFF+EXJPThwmiRIvi1u/vARMMTaqg6FHaWDOEc0NF2iQPJ1jtnBB
         oQPYs60oWkjBZtokNHi9yr9JCRBw4pR0sAOWmFn49EEWu3Wq/iWGznyb94Lt4D+yh0Me
         XrXsUhcm6L3L2zFH1gtYQXCYMu9kO3plOUs46p2VGD7UfsBPKD1LFHjXsYXaA/HrF4wt
         CHsA0RquQ06IofvkNg+7eM5PnGTG9l6YtgzmmPI2z/aFZ/GKa7gu/Gj9TEUNsu2oYAKm
         puNw==
X-Forwarded-Encrypted: i=1; AJvYcCWk5hd7RCAN5/pFXuK7CNLgPRAuMoW/r5vx3ayTW+JhGdDem1pj0DdkABK9m1hEJJF0lg4p4OuqC2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyCtIcurtveXIinWMwf7N5eqFoFzKxWm5QCTId0k9fQnW/yfC5
	67QCA4vezeYMJ4pd6q/jw0qy9bzj0xwucHUXbdf9x5xBuIQiVRZiHFKVTFgLX3Hdi63vENSvm2J
	rC66KsXM=
X-Gm-Gg: AY/fxX4oFi33W06zB1BfKBZds+OUHcvGT8TJ/2tk4r4Qre2nptCx1LDRh8AlFrCGtcV
	Pfcr5kC9uQcy+kRugEC2EOI60RhNRDy2WzzG4DEwZyJiP1qscxLynxoA6vNIlixj/mdJ6vAWVi+
	KvZWG4iP3x6Lcj5lFsUZ9lwmwXIUjd9ihnB+iYi2PtWTf+OkgFhj/m2+4ZsV80H3+AalRtnVI72
	Qk9sQUVlTxDoA4sgBQYp0thWGmVzj1legM+4E1KaW1OvMxJhj/XQc+6w1PlOYvswP/WZZa4G/aE
	JATYT7fO5oGTAvdUm6ZEL+NC0Wm8LlPlbV5LaHOaKyNWbYwudkfsvTLvBQGMlawRVsp3OHm8+HJ
	tFdsA3NrcK+2OdCWiDZA6KwpJ7uWn5pF/RuHk08E/72+aT0duDGVSuGu5yTbdc3XfKEYnrw==
X-Google-Smtp-Source: AGHT+IFV6NOSTSKIg+1C1Cg8TNa5rJ59MLQcSJfG/CZ/PwaxEk+negTg+QnYTVO9pm4c1+3wy9Z+3w==
X-Received: by 2002:a17:907:7b8c:b0:b87:14b3:7d6a with SMTP id a640c23a62f3a-b8714b37f5fmr612921366b.11.1768297726206;
        Tue, 13 Jan 2026 01:48:46 -0800 (PST)
Received: from [10.203.83.95] ([151.19.126.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b86fee09163sm873987666b.26.2026.01.13.01.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 01:48:45 -0800 (PST)
Message-ID: <d09ca6f843f75be5c5726eeab95063ea0e7c99cc.camel@baylibre.com>
Subject: Re: [PATCH 3/3] iio: imu: st_lsm6dsx: add support for rotation
 sensor
From: Francesco Lavra <flavra@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, David Lechner
 <dlechner@baylibre.com>,  Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>,  linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Tue, 13 Jan 2026 10:48:39 +0100
In-Reply-To: <20260111164651.56a0cf14@jic23-huawei>
References: <20260109181528.154127-1-flavra@baylibre.com>
	 <20260109181528.154127-4-flavra@baylibre.com>
	 <20260111164651.56a0cf14@jic23-huawei>
Organization: BayLibre
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-I3U8fW5tAGE63wIAUdgu"
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-I3U8fW5tAGE63wIAUdgu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2026-01-11 at 16:46 +0000, Jonathan Cameron wrote:
> On Fri,=C2=A0 9 Jan 2026 19:15:28 +0100
> Francesco Lavra <flavra@baylibre.com> wrote:
>=20
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
> > an existing device) because each of the existing devices handles data
> > coming from a single sensor, while sensor fusion data comes from
> > multiple
> > sensors.
> That doesn't really justify the extra IIO device.=C2=A0 We used to do thi=
s
> because the IIO buffers aren't tagged with channel info
> (unlike say driver/input) and so if the data for different channels
> /sub parts of the sensor can come out at different rates, we have to
> split them up.=C2=A0 So real question here is what data rate is this gene=
rated
> at?=C2=A0 If it matches an existing sensor we should add the channel ther=
e,
> if not fine to have yet another IIO device. All this changes is
> the explanation in this patch description. Code is fine.

The data rate from the rotation sensor may not match the rate from any of
the existing sensors. I changed the explanation in the patch description.

> Note as an FYI, we now support multiple buffers per IIO device. I think
> there are probably still some corners that need ironing out, but in
> theory
> that was to handle this sort of sensor in a single IIO device.
>=20
> >=20
> > Tested on LSMDSV16X.
> >=20
> > Signed-off-by: Francesco Lavra <flavra@baylibre.com>
>=20
>=20
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c
> > b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c
> > new file mode 100644
> > index 000000000000..7c78f14cbb91
> > --- /dev/null
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c
> > @@ -0,0 +1,224 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * STMicroelectronics st_lsm6dsx IMU sensor fusion
> > + */
> > +
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/sysfs.h>
> > +#include <linux/mutex.h>
> > +#include <linux/regmap.h>
> > +#include <linux/sprintf.h>
> > +#include <linux/types.h>
> > +#include <linux/units.h>
> > +
> > +#include "st_lsm6dsx.h"
>=20
> > +/**
> > + * st_lsm6dsx_sf_set_page - Enable or disable access to sensor fusion
> > + * configuration registers.
> > + * @hw: Sensor hardware instance.
> > + * @enable: True to enable access, false to disable access.
> > + *
> > + * The register page lock is acquired when enabling access, and
> > released when
> > + * disabling access. Therefore, a function call with @enable set to
> > true must be
> > + * followed by a call with @enable set to false (unless the first call
> > returns
> > + * an error value).
> > + *
> > + * Return: 0 on success, negative value on error.
> > + */
> > +static int st_lsm6dsx_sf_set_page(struct st_lsm6dsx_hw *hw, bool
> > enable)
> > +{
>=20
> I'm curious what sparse thinks of this.=C2=A0 Try a make C=3D1 build.
> I'd expect it to be fussy that it can't figure out the acquires and
> releases.
> Maybe it can see enough to figure it out.=C2=A0 If not you might need to =
break
> it into two functions so you can add the markings __acquires() etc
>=20
> Personally I think I'd just take the page lock out of here and use
> guard() in the
> callers.

Building with make C=3D1 doesn't generate any sparse warnings (sparse is no=
t
invoked for this source file). On the other hand, if I break this function
into two functions with the __acquires() and __releases() annotations,
sparse generates a "context imbalance - wrong count at exit" warning for
both functions (and their callers).
I ended up just taking the page lock out of here and using guard() in the
callers.

> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0const struct st_lsm6dsx_reg =
*mux;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int err;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mux =3D &hw->settings->sf_se=
ttings.page_mux;
>=20
> Just to check, can you use regmaps support for paging instead of doing
> this by hand?
> That would avoid future problems with enabling caching or similar

No, the chip has multiple register sets with overlapping addresses, and
struct regmap_range_cfg is not usable here.

>=20
> > +
> > +static
> > IIO_DEV_ATTR_SAMP_FREQ_AVAIL(st_lsm6dsx_sf_sampling_freq_avail);
> > +static struct attribute *st_lsm6dsx_sf_attributes[] =3D {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0&iio_dev_attr_sampling_frequ=
ency_available.dev_attr.attr,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0NULL,
>=20
> No comma as nothing should come after this.=C2=A0 Ideally would be replac=
ed
> with
> code using the read_avail callback and appropriate bit set in the
> info mask avail bitmaps.

The read_avail callback would require available values to be in an int
array, with one of the available IIO_VAL_* formats, but the driver uses a
table (similarly to other parts of the existing code) where frequency
values are expressed in mHz (which does not match any IIO_VAL_* format) and
are interleaved with corresponding hardware register values. So we can't
use the existing available frequency values in a read_avail callback.


--=-I3U8fW5tAGE63wIAUdgu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEhleFT5U73KMewxTm7fE7c86UNl8FAmlmFPgACgkQ7fE7c86U
Nl8ZDQv/XSKDcbpWkpsFgALqFBpk6XG7Rsl3KkGmj1p4ASG3nr6wrzwJy+CFB2uL
dgGqE2Gs8z9UnCc0zdFlDtdsZwGFoRM0Jq42mCMBQ8cpg4frdyUg6PIr2V9tjIxD
uQRKi3ln4Fkhhs6mc/CttYt2qLuQUvgZZOmiRHRbjgznaYpC4uAKo8d1oQ4NUaM8
/mNch4CLTeU2j/MClrN1JlSQ3pa96wSWwGSJyf1ghAcz9K/z/vETfziHKLjSGHPM
EKSg0E2EvGTkSSIcgkjDQ7gIbIuJiPPTsea8hy3nvpawD31VhdwTMMRSV8YFCm9a
6NMx7zze1HwHRPDZjNRBi8YdljQdeKFanaPx2/CCzhu0nXwUz6vtMU7eVxeoAJUZ
aE64rAPxRzF5UjT4U5dBpV8nthaiSgVkQj8EyO6zMKbXy1ZHLifQbY/c+PugLtN5
0acIyClATrixxRoOwp9Ukj6QhVjfo/DUZObIALOfLsSl4sJi1lyDJfGzAAicqyib
SB/zCaZn
=vhKu
-----END PGP SIGNATURE-----

--=-I3U8fW5tAGE63wIAUdgu--

