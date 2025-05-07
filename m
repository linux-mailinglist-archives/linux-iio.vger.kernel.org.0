Return-Path: <linux-iio+bounces-19263-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E59AAEC92
	for <lists+linux-iio@lfdr.de>; Wed,  7 May 2025 21:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C28B79C1657
	for <lists+linux-iio@lfdr.de>; Wed,  7 May 2025 19:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6BBB28E5FD;
	Wed,  7 May 2025 19:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="akq5jul8"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7331F28E59F;
	Wed,  7 May 2025 19:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746647886; cv=none; b=nN+kHgzcTIUGD31syg/PyJbEZi68A8lBORHF3h8n6uRVuoDyYq0OVNzi1lYdiFG1KEMXfpY4PK99NI5KstSY3HVdz4GhyxR7u6HGHXcD39Z/54STqYdPtHqXgI0As8k5hn94uK3+BrggAuVIv0XRAXKt2QyeUCrJhTsE+HxztZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746647886; c=relaxed/simple;
	bh=Sl/O9tbxuYSTHBAOLUnGaBf3c6bYP4TWR8+4mnFAWSI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XJIH0jp4mL/UK1kBjVFwFNInwf7ADaL+U5rYCx+b505NyMHSnF8tAJn42XZMGDwLt7uJZ3PakN0yYRhsXN8+ZqossoqsN7ftLlR0grV9NhI/UPkfJWwVHdtDxx9Y89ilzZZF9PVn/KSJUGjzRUtjI44CHHsVFhY1E0vCValXwr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=akq5jul8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8976EC4CEE2;
	Wed,  7 May 2025 19:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746647886;
	bh=Sl/O9tbxuYSTHBAOLUnGaBf3c6bYP4TWR8+4mnFAWSI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=akq5jul8DPExk0S2renmYeNJpQyVm5B/wv2Ynutsl7z/8Ku0paDjnKFTlbTaHpeGi
	 wkz8IkmjfIIu8IiIPF4LYX1Hxm/1ZZu9W7FG1tnvsFRot3FO+LO7H2g0BHyNaeBaZR
	 ur/sBektWqBlouwGHLK8cEO6Ev+WskM9hlGNWmDJtJU5zLUb5eJ0eJEECpUiXyO/6G
	 u4RFRyNzOTQY/TTnoKIhUyqR6M1da/c15+uKdrEuFv+sJDxPcpTEZTPKEBdOhYkAt7
	 AWpRI8ibpVgs6ASXmhKG6G/Ur/2rPJ/i3Urmuarao0WUhRqD4OLS2Ug4ra/9SkG+Ts
	 PuTenpfOX0CFQ==
Date: Wed, 7 May 2025 20:57:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Esteban Blanc <eblanc@baylibre.com>,
 Andy Shevchenko <andy@kernel.org>, Oleksij Rempel
 <o.rempel@pengutronix.de>, kernel@pengutronix.de, Song Qiang
 <songqiang1304521@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/14] iio: remove bits_per_word = 8 assignments
Message-ID: <20250507205755.69428eb5@jic23-huawei>
In-Reply-To: <4678d4f0c5634f8709f84745054ae16484617b8d.camel@gmail.com>
References: <20250505-iio-remove-bits_per_word-8-v1-0-341f85fcfe11@baylibre.com>
	<4678d4f0c5634f8709f84745054ae16484617b8d.camel@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 07 May 2025 07:28:12 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Mon, 2025-05-05 at 14:20 -0500, David Lechner wrote:
> > While grepping the IIO subsystem for drivers that set bits_per_word to
> > unusual values to check for potential bugs, I found it to be a bit of a
> > nuisance that 2/3s of the matches were setting it to the default value
> > of 8. So here is a series removing the unnecessary assignments.
> >=20
> > --- =20
>=20
> LGTM,
>=20
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
Applied.  Still time to comment if we missed anything though as for
now just pushed out for 0-day to poke at.

Thanks,

Jonathan

>=20
> > David Lechner (14):
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: adc: ad4030: remove bits_per_word =
=3D 8
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: adc: ti-tsc2046: remove bits_per_wo=
rd =3D 8
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: chemical: bme680_spi: remove bits_p=
er_word =3D 8
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: dac: ad5761: remove bits_per_word =
=3D 8
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: dac: ad5766: remove bits_per_word =
=3D 8
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: dac: ad5791: remove bits_per_word =
=3D 8
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: dac: ltc2688: remove bits_per_word =
=3D 8
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: gyro: adxrs450: remove bits_per_wor=
d =3D 8
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: imu: adis: remove bits_per_word =3D=
 8
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: magnetometer: hmc5843_spi: remove b=
its_per_word =3D 8
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: magnetometer: rm3100-spi: remove bi=
ts_per_word =3D 8
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: pressure: bmp280-spi: remove bits_p=
er_word =3D 8
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: pressure: ms5611_spi: remove bits_p=
er_word =3D 8
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iio: pressure: zpa2326_spi: remove bits_=
per_word =3D 8
> >=20
> > =C2=A0drivers/iio/adc/ad4030.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 4 ----
> > =C2=A0drivers/iio/adc/ti-tsc2046.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 1 -
> > =C2=A0drivers/iio/chemical/bme680_spi.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
 8 --------
> > =C2=A0drivers/iio/dac/ad5761.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2 --
> > =C2=A0drivers/iio/dac/ad5766.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2 --
> > =C2=A0drivers/iio/dac/ad5791.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2 --
> > =C2=A0drivers/iio/dac/ltc2688.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2 --
> > =C2=A0drivers/iio/gyro/adxrs450.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 5 -----
> > =C2=A0drivers/iio/imu/adis.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 9 ---------
> > =C2=A0drivers/iio/imu/adis_buffer.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 3 ---
> > =C2=A0drivers/iio/magnetometer/hmc5843_spi.c | 1 -
> > =C2=A0drivers/iio/magnetometer/rm3100-spi.c=C2=A0 | 1 -
> > =C2=A0drivers/iio/pressure/bmp280-spi.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
 8 --------
> > =C2=A0drivers/iio/pressure/ms5611_spi.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
 1 -
> > =C2=A0drivers/iio/pressure/zpa2326_spi.c=C2=A0=C2=A0=C2=A0=C2=A0 | 1 -
> > =C2=A015 files changed, 50 deletions(-)
> > ---
> > base-commit: 7e9a82ab5b861d3c33c99a22c1245a5b262ee502
> > change-id: 20250505-iio-remove-bits_per_word-8-db80654b1c17
> >=20
> > Best regards, =20
>=20


