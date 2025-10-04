Return-Path: <linux-iio+bounces-24723-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2417BB8F53
	for <lists+linux-iio@lfdr.de>; Sat, 04 Oct 2025 17:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72EA9189A3D0
	for <lists+linux-iio@lfdr.de>; Sat,  4 Oct 2025 15:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295591F582C;
	Sat,  4 Oct 2025 15:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t1UIwg7Z"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9B2145B3F
	for <linux-iio@vger.kernel.org>; Sat,  4 Oct 2025 15:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759591269; cv=none; b=qUp69IvI+aGTaEDkYGd5aBuV9PLGHiQVxKGD2RR7kx6u5vAdnVDAL29WjpsmARZS7oqIwjqF/Y+J9WnutrLq3anelKIS41esjKXF/Jeo63Ea51g/v4NZ/YNvqELuyPoyQtWYYKD2SlS0KpT1fi5g/o7HiKPpB4+E+W3mDb4NDG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759591269; c=relaxed/simple;
	bh=+EcZRGnrDdAgsRFOqnj8g521j7oZfWt2WllRBLcDVpo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NUKYdWMLXJw++O0Ov7ZEIDAn1SnlFCH/jFUTaTYzVa+tNKxrmkbHGErvI65mf5ZDfjoiNCh5RmyPv1bnF1xp+3jNaNW/bhxSV9PzTiSOlzV1fPGO2/ffZu/0wgjJs3PBaKeOsWr0rBv3WEKI37GRiracIrb6PhFzFnBn3UqkK3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t1UIwg7Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33AE6C4CEF1;
	Sat,  4 Oct 2025 15:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759591268;
	bh=+EcZRGnrDdAgsRFOqnj8g521j7oZfWt2WllRBLcDVpo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=t1UIwg7ZjpIKbXaWuf2pHoV0BCDXUwyWJDOXQWZxdee4Q5XlSW0nYkk4t2OiiLm2I
	 YbrznWowxk0YcqaZVEyg7hXYKF1z3Shc/YBZ+Dry4rAL0Yzo6fg1HLQ6Ah/Z2KBHQS
	 OSaJxQSCSCXR3Y1iPo1GF+W077XuoyHWoNjVZ0Xh3TsWfPvsxvTI+c/w2rz+gh6T0q
	 DHhjaazyzpwU3HV0IiqkIKu90kp5dB5DjidnFQCv37ZaoTVnGknNOH1jU75jjsGx2a
	 hdy52qHlrgCOZ4f8FH3cjBjjdHNYD43utIChPD77OZjjg1oHDD1yOfuRFfw0DtkeTp
	 uZB0Z96HIjbeg==
Date: Sat, 4 Oct 2025 16:21:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Achim Gratz <Achim.Gratz@Stromeko.DE>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Subject: Re: [RFC PATCH v3 1/9] iio: pressure: bmp280: correct meas_time_us
 calculation
Message-ID: <20251004162101.3de2397b@jic23-huawei>
In-Reply-To: <20250928172637.37138-2-Achim.Gratz@Stromeko.DE>
References: <20250928172637.37138-1-Achim.Gratz@Stromeko.DE>
	<20250928172637.37138-2-Achim.Gratz@Stromeko.DE>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 28 Sep 2025 19:26:28 +0200
Achim Gratz <Achim.Gratz@Stromeko.DE> wrote:

> Correction of meas_time_us initialization based on an observation and
> partial patch by David Lechner.
>=20
> The constant part of the measurement time (as described in the
> datasheet and implemented in the BM(P/E)2 Sensor API) was apparently
> forgotten (it was already correctly applied for the BMP380) and is now
> used.
>=20
> There was also another thinko in bmp280_wait_conv:
> data->oversampling_humid can actually have a value of 0 (for an
> oversampling_ratio of 1), so it can not be used to detect the presence
> of the humidity measurement capability.  Use
> data->chip_info->oversampling_humid_avail instead, which is NULL for
> chips that cannot measure humidity and therefore must skip that part
> of the calculation.
>=20
> Closes: https://lore.kernel.org/linux-iio/875xgfg0wz.fsf@Gerda.invalid/
> Fixes: 26ccfaa9ddaa ("iio: pressure: bmp280: Use sleep and forced mode fo=
r oneshot captures")
> Suggested-by: David Lechner <dlechner@baylibre.com>
> Tested-by: Achim Gratz <Achim.Gratz@Stromeko.DE>
> Signed-off-by: Achim Gratz <Achim.Gratz@Stromeko.DE>

Applied this to the fixes-togreg branch of iio.git.  I'll send a pull reque=
st
for that shortly after rc1.  The others will have to wait until that is ava=
ilable upstream.

>=20
> ---
>=20
> Notes
> =3D=3D=3D=3D=3D
>=20
> Since the BMx280 device support was added, oversampling=3D0 actually is
> a valid register setting (meaning that measurement channel is off),
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
> the overhead of course as each read triggers a new measurement on all
> enabled channels.  It is therefore also impossible to obtain all
> channel values from the same measurement cycle with MODE_FORCED, which
> is in a way a limitation of the sysfs interface and can only be
> obtained by using buffered reads.
> ---
>  drivers/iio/pressure/bmp280-core.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bm=
p280-core.c
> index 6cdc8ed53520..2078b810745b 100644
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


