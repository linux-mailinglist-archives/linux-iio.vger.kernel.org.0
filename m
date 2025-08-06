Return-Path: <linux-iio+bounces-22335-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CDDFB1C82B
	for <lists+linux-iio@lfdr.de>; Wed,  6 Aug 2025 17:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE9813A385F
	for <lists+linux-iio@lfdr.de>; Wed,  6 Aug 2025 15:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517E428F531;
	Wed,  6 Aug 2025 15:04:22 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8444C19A;
	Wed,  6 Aug 2025 15:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754492662; cv=none; b=CDhz/PpKeL9uY9oM4nMSLzxBSlh3xQp07E/WekOlx1lVtSg2Z5mtlnkhwb/hB6dhzRKWfApJlExFP4maRwGnbMzdTMlwDtaH6Dt6uFZ8w3jhIWkIip0oxZtmNiL/zpDoUIC6PGT4+Jy0jAcYIAGFqDzsE6guO3RYuoVH9b7WiWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754492662; c=relaxed/simple;
	bh=aWaX+/h6Iw/2wULa0z+ppkkZt8pkVDSpW2CCqqjLcEE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pDQ+pxjyR1BAwjC5EpDRcli7wyMBycZ5W25MYqkC10lZH5t49YpKaatbq/QG/Ml6VT8l786tSLYYfE7wOmkgQ4cBi4wJ+IiY88gBxrkME7UvoyqtN03PPiYdMPJJYujGbXZTK9d8jUbz6SgX9JHUXGJzDyO7aQIv68PV/qTCbHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bxtnL2xwqz6M4RQ;
	Wed,  6 Aug 2025 23:02:30 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 9F25C1402EC;
	Wed,  6 Aug 2025 23:04:17 +0800 (CST)
Received: from localhost (10.81.207.60) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 6 Aug
 2025 17:04:16 +0200
Date: Wed, 6 Aug 2025 16:04:13 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
CC: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen
	<lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan
 Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Andy Shevchenko
	<andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/8] iio: adc: ad7476: Use correct channel for bit info
Message-ID: <20250806160413.00005a75@huawei.com>
In-Reply-To: <7c353ad496e0056e9fb3869bf07e7fd66d816018.1754463393.git.mazziesaccount@gmail.com>
References: <cover.1754463393.git.mazziesaccount@gmail.com>
	<7c353ad496e0056e9fb3869bf07e7fd66d816018.1754463393.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 6 Aug 2025 10:03:43 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> The ad7476 supports ADCs which use separate GPIO for starting the
> conversion. For such devices, the driver uses different channel
> information if the GPIO is found. The bit information is still always
> used from the original (non 'convstart') channels.
> 
> This has not been causing problems because the bit information for the
> 'convstart' -channel and the 'normal' -channel is identical. It,
> however, will cause issues if an IC has different characteristics for an
> 'convstart' -channel and regular channel. Furthermore, this will cause
> problems if a device always requires the convstart GPIO and thus only
> defines the convstart channel.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> ---
> It appears that the _only_ difference between the 'convstart' -channel
> and the 'normal' channel is a lack of the 'raw-read' support. I might
> prefer seeing the _same_ channel information being used for 'convstart'
> and 'normal' channels, just setting the IIO_CHAN_INFO_RAW -bit when the
> CONVSTART GPIO is found. This would allow getting rid of the 'convstart'
> -channel spec altogeher. Having only one channel info spec would also
> help the code-reader to understand that the driver really provides only
> one data channel to the users. Currently a quick reader may assume the
> driver for some reason provides both the 'convstart' and the 'normal'
> channels.
> 
> Adding the IIO_CHAN_INFO_RAW when CONVSTART GPIO is obtained would
> however require the channel information structs to be mutable - which may
> be seen as a "no, no" by some. Hence this minimally intrusive patch.
If you duplicate them before updating that is probably fine, just keep the
ones in the chip info static const. 
> ---
>  drivers/iio/adc/ad7476.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
> index 7b6d36999afc..fc701267358e 100644
> --- a/drivers/iio/adc/ad7476.c
> +++ b/drivers/iio/adc/ad7476.c
> @@ -121,8 +121,8 @@ static int ad7476_read_raw(struct iio_dev *indio_dev,
>  
>  		if (ret < 0)
>  			return ret;
> -		*val = (ret >> st->chip_info->channel[0].scan_type.shift) &
> -			GENMASK(st->chip_info->channel[0].scan_type.realbits - 1, 0);
> +		*val = (ret >> chan->scan_type.shift) &
> +			GENMASK(chan->scan_type.realbits - 1, 0);
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SCALE:
>  		*val = st->scale_mv;
> @@ -345,7 +345,7 @@ static int ad7476_probe(struct spi_device *spi)
>  	/* Setup default message */
>  
>  	st->xfer.rx_buf = &st->data;
> -	st->xfer.len = st->chip_info->channel[0].scan_type.storagebits / 8;
> +	st->xfer.len = indio_dev->channels[0].scan_type.storagebits / 8;
>  
>  	spi_message_init(&st->msg);
>  	spi_message_add_tail(&st->xfer, &st->msg);


