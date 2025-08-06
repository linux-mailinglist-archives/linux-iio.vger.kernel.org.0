Return-Path: <linux-iio+bounces-22347-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D081B1C972
	for <lists+linux-iio@lfdr.de>; Wed,  6 Aug 2025 17:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E6A984E364F
	for <lists+linux-iio@lfdr.de>; Wed,  6 Aug 2025 15:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1066829551B;
	Wed,  6 Aug 2025 15:59:08 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D93293C6C
	for <linux-iio@vger.kernel.org>; Wed,  6 Aug 2025 15:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754495947; cv=none; b=CpBLnEWzxyGN9ad0w/M0cHVwfa0LqCpB4SAI5qUlXG71/8PcDU0NQvmLOI8NS9bt8TuNn6PisOHRfIOwStfBTs8/REBtHDbNHEHNSb0rHWuUN50CupXgexsyk/gp0QxDkf/53+FVV2PZlvtaIUlTtjhb/SG7jV0DH/4j+PEg1XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754495947; c=relaxed/simple;
	bh=ZWEkTWqeenViW4hVjx7OdOfD8hXIh8X939z58xNSqY0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HVNBAQXi0HajtQVNyqUuWoWE/91v647HGcTOyaS+RSiqJpMz5HbfvyFwPkmEziF8Wfi6NcNZSEc0sKWkLU5kBoPn5mZUgKa7Z7wP//CMtM1cgtfmj7qnml9SVX7YHZthF828sQzuri2DWlnqREYZgJB64vUpcA5VYkxUgdTxyZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bxw0W0bLQz6M4VW;
	Wed,  6 Aug 2025 23:57:15 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 5C0AB14027A;
	Wed,  6 Aug 2025 23:59:02 +0800 (CST)
Received: from localhost (10.81.207.60) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 6 Aug
 2025 17:59:01 +0200
Date: Wed, 6 Aug 2025 16:58:59 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Achim Gratz <Achim.Gratz@Stromeko.DE>
CC: <linux-iio@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>, "David
 Lechner" <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Subject: Re: [bmp280 v1 2/6] iio: pressure: bmp280: reduce overhead on read
 with MODE_FORCED
Message-ID: <20250806165859.000039d4@huawei.com>
In-Reply-To: <20250803140802.36888-3-Achim.Gratz@Stromeko.DE>
References: <20241017233022.238250-1-vassilisamir@gmail.com>
	<20250803140802.36888-1-Achim.Gratz@Stromeko.DE>
	<20250803140802.36888-3-Achim.Gratz@Stromeko.DE>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Sun,  3 Aug 2025 16:07:58 +0200
Achim Gratz <Achim.Gratz@Stromeko.DE> wrote:

> When measuring with MODE_FORCED, each read through sysfs triggers a
> new measurement cycle through aLL channels with the current channel
> configuration, even though we can only access a single channel.
> Reduce the incurred overhead (especially for higher oversampling_ratio
> settings) by temporarily switching off the unused channels.  This
> savea about a third of the acquisition time when reading all three
> channels in succession:
>=20
> | oversampling | max/full | max/skip | time/full | time/skip |
> |              |     [ms] |     [ms] |      [ms] |      [ms] |
> |--------------+----------+----------+-----------+-----------|
> |           16 |      339 |      120 |       315 |       127 |
> |            8 |      174 |       65 |       166 |        76 |
> |            4 |       90 |       38 |        94 |        53 |
> |            2 |       49 |       24 |        59 |        41 |
> |            1 |       28 |       17 |        36 |        33 |
>=20
> The results are from an I=B2C connected sensor at 400kHz, so there is
> considerable overhead from the changing the channel configuration,
> most noticeably with low oversampling_ratio values.  Faster
> communication will reduce this overhead further; and since there is
> still a net reduction in acquisition time even for
> oversampling_ratio=3D1 switching off the channels is always done.
>=20
> Note: The IIR filters will process a slightly noisier input signal.
>=20
> Signed-off-by: Achim Gratz <Achim.Gratz@Stromeko.DE>
Hi Achim.

I'm not really sure what the algorithm implemented here is and what the
various local variables actually mean as state.  Please add some
more comments to the code.

> ---
>  drivers/iio/pressure/bmp280-core.c | 138 ++++++++++++++++++++++++++---
>  drivers/iio/pressure/bmp280.h      |   7 +-
>  2 files changed, 129 insertions(+), 16 deletions(-)
>=20
> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bm=
p280-core.c
> index 3213dcadba28..858974a64306 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c
> @@ -619,18 +619,66 @@ static int bmp280_read_raw_impl(struct iio_dev *ind=
io_dev,
>  	struct bmp280_data *data =3D iio_priv(indio_dev);
>  	int chan_value;
>  	int ret;
> +	int prev_oversampling_humid, prev_oversampling_press, prev_oversampling=
_temp;
> +	int temp_oversampling_humid, temp_oversampling_press, temp_oversampling=
_temp;
> +	int switch_off, switch_threshold =3D -1;
> =20
>  	guard(mutex)(&data->lock);
> =20
> +	prev_oversampling_humid =3D temp_oversampling_humid =3D data->oversampl=
ing_humid;
> +	prev_oversampling_press =3D temp_oversampling_press =3D data->oversampl=
ing_press;
> +	prev_oversampling_temp  =3D temp_oversampling_temp  =3D data->oversampl=
ing_temp;
> +
>  	switch (mask) {
>  	case IIO_CHAN_INFO_PROCESSED:
> +		/* switch off unused channels */
> +		switch_off =3D 0;

So this is saying if 'anything can be switched off'?=20
switch_off_something or some naming like that.

> +		switch (chan->type) {
> +		case IIO_HUMIDITYRELATIVE:
> +			temp_oversampling_press =3D 0-1;

0 - 1
etc. So always spaces around operators.
I'm not at all sure on the logic behind this maths though.
Seems it ultimately gets store into a u8.  Add some comments on what the al=
gorithm
is doing.


> +			switch_off |=3D (prev_oversampling_press > switch_threshold);
> +			/* can't be switched off as it is needed for compensation */
What can't be switched off?  The temperature I guess.
> +			temp_oversampling_temp  =3D 1-1;
1 - 1
> +			break;
> +		case IIO_PRESSURE:
> +			temp_oversampling_humid =3D 0-1;
> +			switch_off |=3D (prev_oversampling_humid > switch_threshold);
> +			/* can't be switched off as it is needed for compensation */
> +			temp_oversampling_temp  =3D 1-1;
> +			break;
> +		case IIO_TEMP:
> +			temp_oversampling_humid =3D 0-1;
> +			temp_oversampling_press =3D 0-1;
> +			switch_off =3D (prev_oversampling_humid > switch_threshold) |
> +				     (prev_oversampling_press > switch_threshold);
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		if (switch_off) {
> +			data->oversampling_humid =3D temp_oversampling_humid;
> +			data->oversampling_press =3D temp_oversampling_press;
> +			data->oversampling_temp  =3D temp_oversampling_temp;
> +			ret =3D data->chip_info->chip_config(data);
> +			if (ret)
> +				goto restore;
> +		}
> +
>  		ret =3D data->chip_info->set_mode(data, BMP280_FORCED);
>  		if (ret)
> -			return ret;
> -
> +			goto restore;
>  		ret =3D data->chip_info->wait_conv(data);
>  		if (ret)
> -			return ret;
> +			goto restore;
> +
> +		if (switch_off) {
> +			data->oversampling_humid =3D prev_oversampling_humid;
> +			data->oversampling_press =3D prev_oversampling_press;
> +			data->oversampling_temp  =3D prev_oversampling_temp;
> +			ret =3D data->chip_info->chip_config(data);
> +			if (ret)
> +				return ret;
> +		}
> =20
>  		switch (chan->type) {
>  		case IIO_HUMIDITYRELATIVE:
> @@ -661,13 +709,55 @@ static int bmp280_read_raw_impl(struct iio_dev *ind=
io_dev,
>  			return -EINVAL;
>  		}
>  	case IIO_CHAN_INFO_RAW:
> +		/* switch off unused channels */
> +		switch_off =3D 0;
> +		switch (chan->type) {
> +		case IIO_HUMIDITYRELATIVE:
> +			temp_oversampling_press =3D 0-1;
> +			switch_off |=3D (prev_oversampling_press > switch_threshold);
> +			/* can't be switched off as it is needed for compensation */
> +			temp_oversampling_temp  =3D 1-1;
> +			break;
> +		case IIO_PRESSURE:
> +			temp_oversampling_humid =3D 0-1;
> +			switch_off |=3D (prev_oversampling_humid > switch_threshold);
> +			/* can't be switched off as it is needed for compensation */
> +			temp_oversampling_temp  =3D 1-1;
> +			break;
> +		case IIO_TEMP:
> +			temp_oversampling_humid =3D 0-1;
> +			temp_oversampling_press =3D 0-1;
> +			switch_off =3D (prev_oversampling_humid > switch_threshold) |
> +				     (prev_oversampling_press > switch_threshold);
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		if (switch_off) {
> +			data->oversampling_humid =3D temp_oversampling_humid;
> +			data->oversampling_press =3D temp_oversampling_press;
> +			data->oversampling_temp  =3D temp_oversampling_temp;
> +			ret =3D data->chip_info->chip_config(data);
> +			if (ret)
> +				goto restore;
> +		}
> +
>  		ret =3D data->chip_info->set_mode(data, BMP280_FORCED);
>  		if (ret)
> -			return ret;
> -
> +			goto restore;
>  		ret =3D data->chip_info->wait_conv(data);
>  		if (ret)
> -			return ret;
> +			goto restore;
> +
> +		if (switch_off) {
> +			data->oversampling_humid =3D prev_oversampling_humid;
> +			data->oversampling_press =3D prev_oversampling_press;
> +			data->oversampling_temp  =3D prev_oversampling_temp;
> +			data->chip_info->chip_config(data);
> +			if (ret) {
> +				return ret;
> +			}
> +		}
> =20
>  		switch (chan->type) {
>  		case IIO_HUMIDITYRELATIVE:
> @@ -741,6 +831,15 @@ static int bmp280_read_raw_impl(struct iio_dev *indi=
o_dev,
>  	default:
>  		return -EINVAL;
>  	}
> +restore:
Maybe worth factoring out he contents of the switch case that has goto rest=
ore
into a separate function so that the scope of the restore is same as the co=
de
that is calling it.  (i.e. avoid a goto jumping out of a switch.

> +	if (switch_off) {
> +	/* restore channel configuration */
> +		data->oversampling_humid =3D prev_oversampling_humid;
> +		data->oversampling_press =3D prev_oversampling_press;
> +		data->oversampling_temp  =3D prev_oversampling_temp;
> +		data->chip_info->chip_config(data);
> +	}
> +	return ret;
>  }

