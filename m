Return-Path: <linux-iio+bounces-21377-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BEBBAFA426
	for <lists+linux-iio@lfdr.de>; Sun,  6 Jul 2025 11:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C16193A9CF4
	for <lists+linux-iio@lfdr.de>; Sun,  6 Jul 2025 09:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C2B1EDA0E;
	Sun,  6 Jul 2025 09:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lT3pqUN6"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142BE145355;
	Sun,  6 Jul 2025 09:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751795388; cv=none; b=l+enVdLomYjeZfKyltT1TujRzZdyhSfDdq1K/1s/VnODD7UzYXUtpMkSnrMuyhQ2cHMmbCV12/XrwTZKwpF3ww9lBpWtOyFsopIBLswj4Ft+yZi7OgGrDrAkH3Fm7GXwwIYbyYMVOPivCcJ7jjiejQMPTEUjCCFTpq5j+iv4YaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751795388; c=relaxed/simple;
	bh=AtYdeYWCa/3PPF5iWhKTWSc3MvzAmuaSbskhm83USTs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BrJuxpItmT8afxiBeE5XTrBo7uvQfmi9R3mUnIS6u1bgseaS8pQ/ho8G230ThO3OA+b/+Q41mb5TUpmbuv/G9jaByjkQK/Eg8GJzeAYDL8IC3ETP2ZEfK60XubaYR3SDH6Po1HwHLDQx8VEN6a38g+l4DyK1+O770dkuF8onhFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lT3pqUN6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30DB9C4CEED;
	Sun,  6 Jul 2025 09:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751795387;
	bh=AtYdeYWCa/3PPF5iWhKTWSc3MvzAmuaSbskhm83USTs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lT3pqUN6ZIvTbq9Ktrse4z8u4Wzfw18B4TtiimNCOjbOyrgw97e+bWX1RU0Ea2YlG
	 Toe/i6oY/Xk6D61qZZwHZq94dEPSWDBOKl88eJodhO46S0Gj2k9NMeWFaIz5QPs/c0
	 qcDpjw4NeYC40yVeIW8LPmMPz++8+Y17nGWUVRFXucDkbOqOHhGTfm831PumO4eZL6
	 Ik/YDRXfAVAND4/OTUq99WVbeHmD/Iox3bB4t18ixX9d8MUmx/UXCxtvyCXDIu9cFG
	 c1Jw0Rl18CUDN5qubn8Jc04+PPW+3sbZkr+DGeo7DQC1jdQMtUygOVZ13LSs81ssiP
	 qhGSHoxK+LiZA==
Date: Sun, 6 Jul 2025 10:49:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: imu: adis16400: drop use of chip info array
Message-ID: <20250706104941.13983ca1@jic23-huawei>
In-Reply-To: <20250628-iio-const-data-17-v1-1-a215ebb653ec@baylibre.com>
References: <20250628-iio-const-data-17-v1-1-a215ebb653ec@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 28 Jun 2025 12:27:46 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Change the adis16400 driver to use individual chip info structures
> instead of an array. This reduces the verbosity of the code. Also, the
> data is now const as it should have been in the first place.

Applied with title changed to be Use separate structures rather than an array for chip info

> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  drivers/iio/imu/adis16400.c | 314 +++++++++++++++++++++-----------------------
>  1 file changed, 153 insertions(+), 161 deletions(-)
> 
> diff --git a/drivers/iio/imu/adis16400.c b/drivers/iio/imu/adis16400.c
> index 90ed3f9bb39c502996161d9df3addcb093ccd11a..36323ad149e04de69f58403cb39d41df64564201 100644
> --- a/drivers/iio/imu/adis16400.c
> +++ b/drivers/iio/imu/adis16400.c
> @@ -170,7 +170,7 @@ struct adis16400_chip_info {
>   *			that must be enabled together
>   **/
>  struct adis16400_state {
> -	struct adis16400_chip_info	*variant;
> +	const struct adis16400_chip_info *variant;
>  	int				filt_int;
>  
>  	struct adis adis;
> @@ -289,19 +289,6 @@ static void adis16400_debugfs_init(struct iio_dev *indio_dev)
>  			d, st, &adis16400_flash_count_fops);
>  }
>  
> -enum adis16400_chip_variant {
> -	ADIS16300,
> -	ADIS16334,
> -	ADIS16350,
> -	ADIS16360,
> -	ADIS16362,
> -	ADIS16364,
> -	ADIS16367,
> -	ADIS16400,
> -	ADIS16445,
> -	ADIS16448,
> -};
> -
>  static int adis16334_get_freq(struct adis16400_state *st)
>  {
>  	int ret;
> @@ -984,137 +971,142 @@ static const struct adis_timeout adis16448_timeouts = {
>  	.self_test_ms = 45,
>  };
>  
> -static struct adis16400_chip_info adis16400_chips[] = {
> -	[ADIS16300] = {
> -		.channels = adis16300_channels,
> -		.num_channels = ARRAY_SIZE(adis16300_channels),
> -		.flags = ADIS16400_HAS_PROD_ID | ADIS16400_HAS_SLOW_MODE |
> -				ADIS16400_HAS_SERIAL_NUMBER,
> -		.gyro_scale_micro = IIO_DEGREE_TO_RAD(50000), /* 0.05 deg/s */
> -		.accel_scale_micro = 5884,
> -		.temp_scale_nano = 140000000, /* 0.14 C */
> -		.temp_offset = 25000000 / 140000, /* 25 C = 0x00 */
> -		.set_freq = adis16400_set_freq,
> -		.get_freq = adis16400_get_freq,
> -		.adis_data = ADIS16400_DATA(&adis16300_timeouts, 18),
> -	},
> -	[ADIS16334] = {
> -		.channels = adis16334_channels,
> -		.num_channels = ARRAY_SIZE(adis16334_channels),
> -		.flags = ADIS16400_HAS_PROD_ID | ADIS16400_NO_BURST |
> -				ADIS16400_HAS_SERIAL_NUMBER,
> -		.gyro_scale_micro = IIO_DEGREE_TO_RAD(50000), /* 0.05 deg/s */
> -		.accel_scale_micro = IIO_G_TO_M_S_2(1000), /* 1 mg */
> -		.temp_scale_nano = 67850000, /* 0.06785 C */
> -		.temp_offset = 25000000 / 67850, /* 25 C = 0x00 */
> -		.set_freq = adis16334_set_freq,
> -		.get_freq = adis16334_get_freq,
> -		.adis_data = ADIS16400_DATA(&adis16334_timeouts, 0),
> -	},
> -	[ADIS16350] = {
> -		.channels = adis16350_channels,
> -		.num_channels = ARRAY_SIZE(adis16350_channels),
> -		.gyro_scale_micro = IIO_DEGREE_TO_RAD(73260), /* 0.07326 deg/s */
> -		.accel_scale_micro = IIO_G_TO_M_S_2(2522), /* 0.002522 g */
> -		.temp_scale_nano = 145300000, /* 0.1453 C */
> -		.temp_offset = 25000000 / 145300, /* 25 C = 0x00 */
> -		.flags = ADIS16400_NO_BURST | ADIS16400_HAS_SLOW_MODE,
> -		.set_freq = adis16400_set_freq,
> -		.get_freq = adis16400_get_freq,
> -		.adis_data = ADIS16400_DATA(&adis16300_timeouts, 0),
> -	},
> -	[ADIS16360] = {
> -		.channels = adis16350_channels,
> -		.num_channels = ARRAY_SIZE(adis16350_channels),
> -		.flags = ADIS16400_HAS_PROD_ID | ADIS16400_HAS_SLOW_MODE |
> -				ADIS16400_HAS_SERIAL_NUMBER,
> -		.gyro_scale_micro = IIO_DEGREE_TO_RAD(50000), /* 0.05 deg/s */
> -		.accel_scale_micro = IIO_G_TO_M_S_2(3333), /* 3.333 mg */
> -		.temp_scale_nano = 136000000, /* 0.136 C */
> -		.temp_offset = 25000000 / 136000, /* 25 C = 0x00 */
> -		.set_freq = adis16400_set_freq,
> -		.get_freq = adis16400_get_freq,
> -		.adis_data = ADIS16400_DATA(&adis16300_timeouts, 28),
> -	},
> -	[ADIS16362] = {
> -		.channels = adis16350_channels,
> -		.num_channels = ARRAY_SIZE(adis16350_channels),
> -		.flags = ADIS16400_HAS_PROD_ID | ADIS16400_HAS_SLOW_MODE |
> -				ADIS16400_HAS_SERIAL_NUMBER,
> -		.gyro_scale_micro = IIO_DEGREE_TO_RAD(50000), /* 0.05 deg/s */
> -		.accel_scale_micro = IIO_G_TO_M_S_2(333), /* 0.333 mg */
> -		.temp_scale_nano = 136000000, /* 0.136 C */
> -		.temp_offset = 25000000 / 136000, /* 25 C = 0x00 */
> -		.set_freq = adis16400_set_freq,
> -		.get_freq = adis16400_get_freq,
> -		.adis_data = ADIS16400_DATA(&adis16362_timeouts, 28),
> -	},
> -	[ADIS16364] = {
> -		.channels = adis16350_channels,
> -		.num_channels = ARRAY_SIZE(adis16350_channels),
> -		.flags = ADIS16400_HAS_PROD_ID | ADIS16400_HAS_SLOW_MODE |
> -				ADIS16400_HAS_SERIAL_NUMBER,
> -		.gyro_scale_micro = IIO_DEGREE_TO_RAD(50000), /* 0.05 deg/s */
> -		.accel_scale_micro = IIO_G_TO_M_S_2(1000), /* 1 mg */
> -		.temp_scale_nano = 136000000, /* 0.136 C */
> -		.temp_offset = 25000000 / 136000, /* 25 C = 0x00 */
> -		.set_freq = adis16400_set_freq,
> -		.get_freq = adis16400_get_freq,
> -		.adis_data = ADIS16400_DATA(&adis16362_timeouts, 28),
> -	},
> -	[ADIS16367] = {
> -		.channels = adis16350_channels,
> -		.num_channels = ARRAY_SIZE(adis16350_channels),
> -		.flags = ADIS16400_HAS_PROD_ID | ADIS16400_HAS_SLOW_MODE |
> -				ADIS16400_HAS_SERIAL_NUMBER,
> -		.gyro_scale_micro = IIO_DEGREE_TO_RAD(2000), /* 0.2 deg/s */
> -		.accel_scale_micro = IIO_G_TO_M_S_2(3333), /* 3.333 mg */
> -		.temp_scale_nano = 136000000, /* 0.136 C */
> -		.temp_offset = 25000000 / 136000, /* 25 C = 0x00 */
> -		.set_freq = adis16400_set_freq,
> -		.get_freq = adis16400_get_freq,
> -		.adis_data = ADIS16400_DATA(&adis16300_timeouts, 28),
> -	},
> -	[ADIS16400] = {
> -		.channels = adis16400_channels,
> -		.num_channels = ARRAY_SIZE(adis16400_channels),
> -		.flags = ADIS16400_HAS_PROD_ID | ADIS16400_HAS_SLOW_MODE,
> -		.gyro_scale_micro = IIO_DEGREE_TO_RAD(50000), /* 0.05 deg/s */
> -		.accel_scale_micro = IIO_G_TO_M_S_2(3333), /* 3.333 mg */
> -		.temp_scale_nano = 140000000, /* 0.14 C */
> -		.temp_offset = 25000000 / 140000, /* 25 C = 0x00 */
> -		.set_freq = adis16400_set_freq,
> -		.get_freq = adis16400_get_freq,
> -		.adis_data = ADIS16400_DATA(&adis16400_timeouts, 24),
> -	},
> -	[ADIS16445] = {
> -		.channels = adis16445_channels,
> -		.num_channels = ARRAY_SIZE(adis16445_channels),
> -		.flags = ADIS16400_HAS_PROD_ID |
> -				ADIS16400_HAS_SERIAL_NUMBER |
> -				ADIS16400_BURST_DIAG_STAT,
> -		.gyro_scale_micro = IIO_DEGREE_TO_RAD(10000), /* 0.01 deg/s */
> -		.accel_scale_micro = IIO_G_TO_M_S_2(250), /* 1/4000 g */
> -		.temp_scale_nano = 73860000, /* 0.07386 C */
> -		.temp_offset = 31000000 / 73860, /* 31 C = 0x00 */
> -		.set_freq = adis16334_set_freq,
> -		.get_freq = adis16334_get_freq,
> -		.adis_data = ADIS16400_DATA(&adis16445_timeouts, 16),
> -	},
> -	[ADIS16448] = {
> -		.channels = adis16448_channels,
> -		.num_channels = ARRAY_SIZE(adis16448_channels),
> -		.flags = ADIS16400_HAS_PROD_ID |
> -				ADIS16400_HAS_SERIAL_NUMBER |
> -				ADIS16400_BURST_DIAG_STAT,
> -		.gyro_scale_micro = IIO_DEGREE_TO_RAD(40000), /* 0.04 deg/s */
> -		.accel_scale_micro = IIO_G_TO_M_S_2(833), /* 1/1200 g */
> -		.temp_scale_nano = 73860000, /* 0.07386 C */
> -		.temp_offset = 31000000 / 73860, /* 31 C = 0x00 */
> -		.set_freq = adis16334_set_freq,
> -		.get_freq = adis16334_get_freq,
> -		.adis_data = ADIS16400_DATA(&adis16448_timeouts, 24),
> -	}
> +static const struct adis16400_chip_info adis16300_chip_info = {
> +	.channels = adis16300_channels,
> +	.num_channels = ARRAY_SIZE(adis16300_channels),
> +	.flags = ADIS16400_HAS_PROD_ID | ADIS16400_HAS_SLOW_MODE |
> +		 ADIS16400_HAS_SERIAL_NUMBER,
> +	.gyro_scale_micro = IIO_DEGREE_TO_RAD(50000), /* 0.05 deg/s */
> +	.accel_scale_micro = 5884,
> +	.temp_scale_nano = 140000000, /* 0.14 C */
> +	.temp_offset = 25000000 / 140000, /* 25 C = 0x00 */
> +	.set_freq = adis16400_set_freq,
> +	.get_freq = adis16400_get_freq,
> +	.adis_data = ADIS16400_DATA(&adis16300_timeouts, 18),
> +};
> +
> +static const struct adis16400_chip_info adis16334_chip_info = {
> +	.channels = adis16334_channels,
> +	.num_channels = ARRAY_SIZE(adis16334_channels),
> +	.flags = ADIS16400_HAS_PROD_ID | ADIS16400_NO_BURST |
> +		 ADIS16400_HAS_SERIAL_NUMBER,
> +	.gyro_scale_micro = IIO_DEGREE_TO_RAD(50000), /* 0.05 deg/s */
> +	.accel_scale_micro = IIO_G_TO_M_S_2(1000), /* 1 mg */
> +	.temp_scale_nano = 67850000, /* 0.06785 C */
> +	.temp_offset = 25000000 / 67850, /* 25 C = 0x00 */
> +	.set_freq = adis16334_set_freq,
> +	.get_freq = adis16334_get_freq,
> +	.adis_data = ADIS16400_DATA(&adis16334_timeouts, 0),
> +};
> +
> +static const struct adis16400_chip_info adis16350_chip_info = {
> +	.channels = adis16350_channels,
> +	.num_channels = ARRAY_SIZE(adis16350_channels),
> +	.gyro_scale_micro = IIO_DEGREE_TO_RAD(73260), /* 0.07326 deg/s */
> +	.accel_scale_micro = IIO_G_TO_M_S_2(2522), /* 0.002522 g */
> +	.temp_scale_nano = 145300000, /* 0.1453 C */
> +	.temp_offset = 25000000 / 145300, /* 25 C = 0x00 */
> +	.flags = ADIS16400_NO_BURST | ADIS16400_HAS_SLOW_MODE,
> +	.set_freq = adis16400_set_freq,
> +	.get_freq = adis16400_get_freq,
> +	.adis_data = ADIS16400_DATA(&adis16300_timeouts, 0),
> +};
> +
> +static const struct adis16400_chip_info adis16360_chip_info = {
> +	.channels = adis16350_channels,
> +	.num_channels = ARRAY_SIZE(adis16350_channels),
> +	.flags = ADIS16400_HAS_PROD_ID | ADIS16400_HAS_SLOW_MODE |
> +		 ADIS16400_HAS_SERIAL_NUMBER,
> +	.gyro_scale_micro = IIO_DEGREE_TO_RAD(50000), /* 0.05 deg/s */
> +	.accel_scale_micro = IIO_G_TO_M_S_2(3333), /* 3.333 mg */
> +	.temp_scale_nano = 136000000, /* 0.136 C */
> +	.temp_offset = 25000000 / 136000, /* 25 C = 0x00 */
> +	.set_freq = adis16400_set_freq,
> +	.get_freq = adis16400_get_freq,
> +	.adis_data = ADIS16400_DATA(&adis16300_timeouts, 28),
> +};
> +
> +static const struct adis16400_chip_info adis16362_chip_info = {
> +	.channels = adis16350_channels,
> +	.num_channels = ARRAY_SIZE(adis16350_channels),
> +	.flags = ADIS16400_HAS_PROD_ID | ADIS16400_HAS_SLOW_MODE |
> +		 ADIS16400_HAS_SERIAL_NUMBER,
> +	.gyro_scale_micro = IIO_DEGREE_TO_RAD(50000), /* 0.05 deg/s */
> +	.accel_scale_micro = IIO_G_TO_M_S_2(333), /* 0.333 mg */
> +	.temp_scale_nano = 136000000, /* 0.136 C */
> +	.temp_offset = 25000000 / 136000, /* 25 C = 0x00 */
> +	.set_freq = adis16400_set_freq,
> +	.get_freq = adis16400_get_freq,
> +	.adis_data = ADIS16400_DATA(&adis16362_timeouts, 28),
> +};
> +
> +static const struct adis16400_chip_info adis16364_chip_info = {
> +	.channels = adis16350_channels,
> +	.num_channels = ARRAY_SIZE(adis16350_channels),
> +	.flags = ADIS16400_HAS_PROD_ID | ADIS16400_HAS_SLOW_MODE |
> +		 ADIS16400_HAS_SERIAL_NUMBER,
> +	.gyro_scale_micro = IIO_DEGREE_TO_RAD(50000), /* 0.05 deg/s */
> +	.accel_scale_micro = IIO_G_TO_M_S_2(1000), /* 1 mg */
> +	.temp_scale_nano = 136000000, /* 0.136 C */
> +	.temp_offset = 25000000 / 136000, /* 25 C = 0x00 */
> +	.set_freq = adis16400_set_freq,
> +	.get_freq = adis16400_get_freq,
> +	.adis_data = ADIS16400_DATA(&adis16362_timeouts, 28),
> +};
> +
> +static const struct adis16400_chip_info adis16367_chip_info = {
> +	.channels = adis16350_channels,
> +	.num_channels = ARRAY_SIZE(adis16350_channels),
> +	.flags = ADIS16400_HAS_PROD_ID | ADIS16400_HAS_SLOW_MODE |
> +		 ADIS16400_HAS_SERIAL_NUMBER,
> +	.gyro_scale_micro = IIO_DEGREE_TO_RAD(2000), /* 0.2 deg/s */
> +	.accel_scale_micro = IIO_G_TO_M_S_2(3333), /* 3.333 mg */
> +	.temp_scale_nano = 136000000, /* 0.136 C */
> +	.temp_offset = 25000000 / 136000, /* 25 C = 0x00 */
> +	.set_freq = adis16400_set_freq,
> +	.get_freq = adis16400_get_freq,
> +	.adis_data = ADIS16400_DATA(&adis16300_timeouts, 28),
> +};
> +
> +static const struct adis16400_chip_info adis16400_chip_info = {
> +	.channels = adis16400_channels,
> +	.num_channels = ARRAY_SIZE(adis16400_channels),
> +	.flags = ADIS16400_HAS_PROD_ID | ADIS16400_HAS_SLOW_MODE,
> +	.gyro_scale_micro = IIO_DEGREE_TO_RAD(50000), /* 0.05 deg/s */
> +	.accel_scale_micro = IIO_G_TO_M_S_2(3333), /* 3.333 mg */
> +	.temp_scale_nano = 140000000, /* 0.14 C */
> +	.temp_offset = 25000000 / 140000, /* 25 C = 0x00 */
> +	.set_freq = adis16400_set_freq,
> +	.get_freq = adis16400_get_freq,
> +	.adis_data = ADIS16400_DATA(&adis16400_timeouts, 24),
> +};
> +
> +static const struct adis16400_chip_info adis16445_chip_info = {
> +	.channels = adis16445_channels,
> +	.num_channels = ARRAY_SIZE(adis16445_channels),
> +	.flags = ADIS16400_HAS_PROD_ID | ADIS16400_HAS_SERIAL_NUMBER |
> +		 ADIS16400_BURST_DIAG_STAT,
> +	.gyro_scale_micro = IIO_DEGREE_TO_RAD(10000), /* 0.01 deg/s */
> +	.accel_scale_micro = IIO_G_TO_M_S_2(250), /* 1/4000 g */
> +	.temp_scale_nano = 73860000, /* 0.07386 C */
> +	.temp_offset = 31000000 / 73860, /* 31 C = 0x00 */
> +	.set_freq = adis16334_set_freq,
> +	.get_freq = adis16334_get_freq,
> +	.adis_data = ADIS16400_DATA(&adis16445_timeouts, 16),
> +};
> +
> +static const struct adis16400_chip_info adis16448_chip_info = {
> +	.channels = adis16448_channels,
> +	.num_channels = ARRAY_SIZE(adis16448_channels),
> +	.flags = ADIS16400_HAS_PROD_ID | ADIS16400_HAS_SERIAL_NUMBER |
> +		 ADIS16400_BURST_DIAG_STAT,
> +	.gyro_scale_micro = IIO_DEGREE_TO_RAD(40000), /* 0.04 deg/s */
> +	.accel_scale_micro = IIO_G_TO_M_S_2(833), /* 1/1200 g */
> +	.temp_scale_nano = 73860000, /* 0.07386 C */
> +	.temp_offset = 31000000 / 73860, /* 31 C = 0x00 */
> +	.set_freq = adis16334_set_freq,
> +	.get_freq = adis16334_get_freq,
> +	.adis_data = ADIS16400_DATA(&adis16448_timeouts, 24),
>  };
>  
>  static const struct iio_info adis16400_info = {
> @@ -1157,7 +1149,7 @@ static int adis16400_probe(struct spi_device *spi)
>  	st = iio_priv(indio_dev);
>  
>  	/* setup the industrialio driver allocated elements */
> -	st->variant = &adis16400_chips[spi_get_device_id(spi)->driver_data];
> +	st->variant = spi_get_device_match_data(spi);
>  	indio_dev->name = spi_get_device_id(spi)->name;
>  	indio_dev->channels = st->variant->channels;
>  	indio_dev->num_channels = st->variant->num_channels;
> @@ -1197,21 +1189,21 @@ static int adis16400_probe(struct spi_device *spi)
>  }
>  
>  static const struct spi_device_id adis16400_id[] = {
> -	{"adis16300", ADIS16300},
> -	{"adis16305", ADIS16300},
> -	{"adis16334", ADIS16334},
> -	{"adis16350", ADIS16350},
> -	{"adis16354", ADIS16350},
> -	{"adis16355", ADIS16350},
> -	{"adis16360", ADIS16360},
> -	{"adis16362", ADIS16362},
> -	{"adis16364", ADIS16364},
> -	{"adis16365", ADIS16360},
> -	{"adis16367", ADIS16367},
> -	{"adis16400", ADIS16400},
> -	{"adis16405", ADIS16400},
> -	{"adis16445", ADIS16445},
> -	{"adis16448", ADIS16448},
> +	{ "adis16300", (kernel_ulong_t)&adis16300_chip_info },
> +	{ "adis16305", (kernel_ulong_t)&adis16300_chip_info },
> +	{ "adis16334", (kernel_ulong_t)&adis16334_chip_info },
> +	{ "adis16350", (kernel_ulong_t)&adis16350_chip_info },
> +	{ "adis16354", (kernel_ulong_t)&adis16350_chip_info },
> +	{ "adis16355", (kernel_ulong_t)&adis16350_chip_info },
> +	{ "adis16360", (kernel_ulong_t)&adis16360_chip_info },
> +	{ "adis16362", (kernel_ulong_t)&adis16362_chip_info },
> +	{ "adis16364", (kernel_ulong_t)&adis16364_chip_info },
> +	{ "adis16365", (kernel_ulong_t)&adis16360_chip_info },
> +	{ "adis16367", (kernel_ulong_t)&adis16367_chip_info },
> +	{ "adis16400", (kernel_ulong_t)&adis16400_chip_info },
> +	{ "adis16405", (kernel_ulong_t)&adis16400_chip_info },
> +	{ "adis16445", (kernel_ulong_t)&adis16445_chip_info },
> +	{ "adis16448", (kernel_ulong_t)&adis16448_chip_info },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(spi, adis16400_id);
> 
> ---
> base-commit: 14071b9cf2d751ff9bc8b5e43fa94fbf08aceea1
> change-id: 20250628-iio-const-data-17-e2a380903879
> 
> Best regards,


