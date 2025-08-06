Return-Path: <linux-iio+bounces-22346-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B0EB1C93C
	for <lists+linux-iio@lfdr.de>; Wed,  6 Aug 2025 17:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E963172531
	for <lists+linux-iio@lfdr.de>; Wed,  6 Aug 2025 15:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA9E292B26;
	Wed,  6 Aug 2025 15:46:32 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C77292936
	for <linux-iio@vger.kernel.org>; Wed,  6 Aug 2025 15:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754495192; cv=none; b=uMWtqOU2i7x9JOgiGkXsVL75ru+Ps5cW+nWQkZ48VLPN+5gYb7hiYoVabk0tkN8Y/9Ics+EeO73wY+5RTG5kV1bmAj8UcMEmg9tAkeEr9WxNErfceTH6XZcOBeT+dC65pi5ikB5BgVFAQHVbIByqXe1UmwADfvdgzOhU/zry0eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754495192; c=relaxed/simple;
	bh=JBRuR9USX87oh6CMuoYN1I6uZGSyseMwVICOtz64dHA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IwJnD0/RR8B7xuymJBl9m0PnyIRungX+8rFyOcxTz1UvscVIJmQiPv8Gbz1avB8/gStbe+Jam899JcgbQZDhlWP+Z+mpX753omH3q6TATfq5P0EUkK4lf4d8uORIrKMyOPFnc4nmxi4oDrtQMFojXIy61BKR/OtgRDpRqv3R4eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bxvk064Fhz6M4Vh;
	Wed,  6 Aug 2025 23:44:40 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 20C9C1402F4;
	Wed,  6 Aug 2025 23:46:28 +0800 (CST)
Received: from localhost (10.81.207.60) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 6 Aug
 2025 17:46:27 +0200
Date: Wed, 6 Aug 2025 16:46:25 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Achim Gratz <Achim.Gratz@Stromeko.DE>
CC: <linux-iio@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>, "David
 Lechner" <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Subject: Re: [bmp280 v1 1/6] iio: pressure: bmp280: correct meas_time_us
 calculation
Message-ID: <20250806164625.0000217e@huawei.com>
In-Reply-To: <20250803140802.36888-2-Achim.Gratz@Stromeko.DE>
References: <20241017233022.238250-1-vassilisamir@gmail.com>
	<20250803140802.36888-1-Achim.Gratz@Stromeko.DE>
	<20250803140802.36888-2-Achim.Gratz@Stromeko.DE>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Sun,  3 Aug 2025 16:07:57 +0200
Achim Gratz <Achim.Gratz@Stromeko.DE> wrote:

> Based on an observation and partial patch by David Lechner.
> 
> There was also a thinko in bmp280_wait_conv: data->oversampling_humid
> can actually be 0 (for an oversampling_ratio of 1), so it can not be
> used to detect the presence of the humidity measurement capability.
> Use data->chip_info->oversampling_humid_avail instead, which is NULL
> for chips that cannot measure humidity and therefore need to skip that
> part of the calculation.
> 
> Note: Since the BMx280 device support was added, oversampling=0
> actually is a valid setting (that channels measurement is off), but
> allowing that setting by changing the data structure to hold the
> actual value instead of its ilog2 would require more extensive changes
> elsewhere in the code.
> 
> Suggested-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Achim Gratz <Achim.Gratz@Stromeko.DE>
Needs a fixes tag if it is correcting something.

> ---
>  drivers/iio/pressure/bmp280-core.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> index 74505c9ec1a0..3213dcadba28 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c
> @@ -1042,14 +1042,13 @@ static int bmp280_wait_conv(struct bmp280_data *data)
>  	unsigned int reg, meas_time_us;
>  	int ret;
>  
> +	meas_time_us = BMP280_MEAS_OFFSET;
> +

I'm not following this. Why are we now effectively adding MP280_MEAS_OFFSET
that we weren't before whether or not oversampling is enabled?

>  	/* Check if we are using a BME280 device */
> -	if (data->oversampling_humid)
> -		meas_time_us = BMP280_PRESS_HUMID_MEAS_OFFSET +
> +	if (data->chip_info->oversampling_humid_avail)
> +		meas_time_us += BMP280_PRESS_HUMID_MEAS_OFFSET +
>  				BIT(data->oversampling_humid) * BMP280_MEAS_DUR;
>  
> -	else
> -		meas_time_us = 0;
> -
>  	/* Pressure measurement time */
>  	meas_time_us += BMP280_PRESS_HUMID_MEAS_OFFSET +
>  			BIT(data->oversampling_press) * BMP280_MEAS_DUR;


