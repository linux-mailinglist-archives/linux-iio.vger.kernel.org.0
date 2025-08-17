Return-Path: <linux-iio+bounces-22864-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADDC8B293C6
	for <lists+linux-iio@lfdr.de>; Sun, 17 Aug 2025 17:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9AA61B235E1
	for <lists+linux-iio@lfdr.de>; Sun, 17 Aug 2025 15:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964D017C21E;
	Sun, 17 Aug 2025 15:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ei5nRE67"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560D17494
	for <linux-iio@vger.kernel.org>; Sun, 17 Aug 2025 15:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755443799; cv=none; b=ESx7WjF04HNxxMdzd3RYrRYC0dWlz/e1xR6Zv8oFUlnnr8yRSbQo4FrWaAKKUMnwj65+8rksNA7i4SLgkWzgHWt/ezcJfE7cDcuRDPU0kjRbcL7cGBmfID45i5HD2OzHOC0FNum0chwyhMpnDt4oaXAFcL3qKFsdh51cPD7LVbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755443799; c=relaxed/simple;
	bh=4CDEzPj3equpVrm9QTjzp5YwXuN2zX+SA3fjToaTVew=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bW3q5w4LyK2gx+eN/t/tGVBMe7A+lxyuxy7asWqYdJNz200IYKklY+nWw9oSreASc4ptTgrnC6VisjhV1b6aOq9mkpU6XBSIMGR5PkqViglQ1naIaqmLvnvSwd07shDt2ykLwoV/xnC7DFLEyFoWaZk9zEqz3vUQF2DVMBS08Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ei5nRE67; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A9DEC4CEEB;
	Sun, 17 Aug 2025 15:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755443797;
	bh=4CDEzPj3equpVrm9QTjzp5YwXuN2zX+SA3fjToaTVew=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ei5nRE67wCEeRgJ1rYGfpe6biToYxn64SA+FUw/FPOtfPz6xpblSyUv0ACR1IO/15
	 que0u2cqBjxR7xe/DDdX+uPBTq8BJoCj0E9FjVp4cRa9jCOBTywKPp2DAnNBRRIqmB
	 MSpuUkUZtKgTz3XOCaMS3Ye0e/9v0Oj6yBxymkiLpRcY1Mbi7o+52Kh9eaKKv9HQWT
	 BdlRWEgQSqzfPBDqGd4Ypar0gqlprV3iMeT5SeWVWdfE4g0HCmNKwA27ydR0FtkcQ9
	 NPK97IfaDx02BW/MFxLTUTKrrTpuLy5lsBe7MCJqUkI5+VswJlc5KkENyfztpoynEN
	 playDA7dYn/yQ==
Date: Sun, 17 Aug 2025 16:16:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Achim Gratz <Achim.Gratz@Stromeko.DE>, linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>, Andy Shevchenko
 <andy@kernel.org>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Subject: Re: [RFC PATCH v2 1/9] iio: pressure: bmp280: correct meas_time_us
 calculation
Message-ID: <20250817161630.7eeb5591@jic23-huawei>
In-Reply-To: <20250810185846.114355-2-Achim.Gratz@Stromeko.DE>
References: <20241017233022.238250-1-vassilisamir@gmail.com>
	<20250810185846.114355-1-Achim.Gratz@Stromeko.DE>
	<20250810185846.114355-2-Achim.Gratz@Stromeko.DE>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 10 Aug 2025 20:58:38 +0200
Achim Gratz <Achim.Gratz@Stromeko.DE> wrote:

> Correction of meas_time_us initialization based on an observation and
> partial patch by David Lechner.
>=20
> There was also a thinko in bmp280_wait_conv: data->oversampling_humid
> can actually be 0 (for an oversampling_ratio of 1), so it can not be
> used to detect the presence of the humidity measurement capability.
> Use data->chip_info->oversampling_humid_avail instead, which is NULL
> for chips that cannot measure humidity and therefore need to skip that
> part of the calculation.
Hi Achim,


This addresses part of the change (and that bit is fine) but doesn't
mention the other part. See below.

>=20
> Closes: https://lore.kernel.org/linux-iio/875xgfg0wz.fsf@Gerda.invalid/
> Fixes: 26ccfaa9ddaa ("iio: pressure: bmp280: Use sleep and forced mode fo=
r oneshot captures")
> Suggested-by: David Lechner <dlechner@baylibre.com>
> Tested-by: Achim Gratz <Achim.Gratz@Stromeko.DE>
> Signed-off-by: Achim Gratz <Achim.Gratz@Stromeko.DE>
>=20
> ---
>=20
> Notes
> =3D=3D=3D=3D=3D
>=20
> Since the BMx280 device support was added, oversampling=3D0
> actually is a valid setting (meaning that measurement channel is off),
> but actually allowing that setting to be used by changing the data
> structure to hold the actual value instead of its ilog2 would require
> more extensive changes elsewhere in the code.
>=20
> Further changes would be necesary to avoid the awkward use of -1 as
> the value that would currently be necessary to achieve a setting of 0
> in the register.
>=20
> Datasheet values and median actual measurement times through sysfs for
> a single reading with my BME280 connected to a 400kHz I=C2=B2C bus provid=
ed
> by the i915 IGP VGA port:
>=20
> |--------------+---------+---------+----------+----------|
> | Oversampling | Typical | Maximum | Measured | Overhead |
> |        Ratio |    [ms] |    [ms] |     [ms] |     [ms] |
> |--------------+---------+---------+----------+----------|
> |           16 |    98.0 |   112.8 |    122.1 |      9.3 |
> |            8 |    50.0 |    57.6 |     63.6 |      6.0 |
> |            4 |    26.0 |    30.0 |     34.6 |      4.6 |
> |            2 |    14.0 |    16.2 |     21.7 |      5.5 |
> |            1 |     8.0 |     9.3 |     14.8 |      5.5 |
> |--------------+---------+---------+----------+----------|
>=20
> Reading all three channels via sysfs triples those times, including
> the overhead of course.
>=20
> It is also impossible to obtain all three values from
> the same measurement with MODE_FORCED, which is in a way a limitation
> of the sysfs interface AFAIU.

Sort of.  As per other discussion, there are a few drivers that
do work around this but in general the intent is that if you want a
'scan' of multiple channels taken together then the buffered interface
is the only way to guarantee that.

> ---
>  drivers/iio/pressure/bmp280-core.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bm=
p280-core.c
> index f37f20776c89..5bec63c1bc11 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c
> @@ -1042,13 +1042,16 @@ static int bmp280_wait_conv(struct bmp280_data *d=
ata)
>  	unsigned int reg, meas_time_us;
>  	int ret;
> =20
> -	/* Check if we are using a BME280 device */
> -	if (data->oversampling_humid)
> -		meas_time_us =3D BMP280_PRESS_HUMID_MEAS_OFFSET +
> -				BIT(data->oversampling_humid) * BMP280_MEAS_DUR;
> +	/* Constant part of the measurement time */
> +	meas_time_us =3D BMP280_MEAS_OFFSET;

I'm fine with this being necessary but it's not mentioned in the patch desc=
ription
that all measurement times need to be increased by this time.

Add something to the description to cover this change.

> =20
> -	else
> -		meas_time_us =3D 0;
> +	/*
> +	 * Check if we are using a BME280 device,
> +	 * Humidity measurement time
> +	 */
> +	if (data->chip_info->oversampling_humid_avail)
> +		meas_time_us +=3D BMP280_PRESS_HUMID_MEAS_OFFSET +
> +				BIT(data->oversampling_humid) * BMP280_MEAS_DUR;
> =20
>  	/* Pressure measurement time */
>  	meas_time_us +=3D BMP280_PRESS_HUMID_MEAS_OFFSET +


