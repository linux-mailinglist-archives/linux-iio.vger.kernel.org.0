Return-Path: <linux-iio+bounces-11643-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5719B6BA7
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 19:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 511511C21ABD
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 18:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF3F1C3F00;
	Wed, 30 Oct 2024 18:07:05 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378E419E99F;
	Wed, 30 Oct 2024 18:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730311625; cv=none; b=nQD4BFzfIxeXhlbgudBYxgIm3g3NUpsAfAQxxmdhrRkpQh0cgm8SFUM95Zgc7ic8H1dWnga8u9PNzKw0uPkbW0JvQ9EN1v6/kVm1dn0N1MHb1To/I4gAGTZCzz1xsn7uQAB/9xCvlAVU6rpoL5Z9ocxK/j3rzlt5H1qYTWhZKNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730311625; c=relaxed/simple;
	bh=Ob3QZ/kFjZWCEJv+qE06Gp1MrNr26sKK36Jmxpv0iRM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H5C+bveRu6/Cdw1lu+Svhg3JduCAGNQMuvXRTgTAOh78VDt2GyD4oS34MiN/qjoZyaO5GKyHz3VchtJ4R+fSdLeUaPhlM/TfQTtls+uxGFZxfWzxUlfYq/ZpxnDzuSA75yPlJE0rrk/V2xfTR01XPfnxtj6+NyMCnQnb+y+9ozY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Xdw4f3kppz6K5vS;
	Thu, 31 Oct 2024 02:04:34 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 44024140B39;
	Thu, 31 Oct 2024 02:07:00 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 30 Oct
 2024 19:06:59 +0100
Date: Wed, 30 Oct 2024 18:06:58 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
CC: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Kalle Niemi
	<kaleposti@gmail.com>, Jonathan Cameron <jic23@kernel.org>, "Lars-Peter
 Clausen" <lars@metafoo.de>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: kx022a: Fix raw read format
Message-ID: <20241030180658.00000ac2@Huawei.com>
In-Reply-To: <ZyIxm_zamZfIGrnB@mva-rohm>
References: <ZyIxm_zamZfIGrnB@mva-rohm>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 30 Oct 2024 15:16:11 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> The KX022A provides the accelerometer data in two subsequent registers.
> The registers are laid out so that the value obtained via bulk-read of
> these registers can be interpreted as signed 16-bit little endian value.
> The read value is converted to cpu_endianes and stored into 32bit integer.
> The le16_to_cpu() casts value to unsigned 16-bit value, and when this is
> assigned to 32-bit integer the resulting value will always be positive.
> 
> This has not been a problem to users (at least not all users) of the sysfs
> interface, who know the data format based on the scan info and who have
> converted the read value back to 16-bit signed value.
They shouldn't be doing that. Scaninfo is for buffered values only
This should indeed be signed.

> 
> This, however, will be a problem for those who use the in-kernel
> interfaces, especially the iio_read_channel_processed_scale().
> 
> The iio_read_channel_processed_scale() performs multiplications to the
> returned (always positive) raw value, which will cause strange results
> when the data from the sensor has been negative.
> 
> Fix the read_raw format by casting the result of the le_to_cpu() to
> signed 16-bit value before assigning it to the integer. This will make
> the negative readings to be correctly reported as negative.
> 
> This fix will be visible to users by changing values returned via sysfs
> to appear in correct (negative) format.
> 
> Reported-by: Kalle Niemi <kaleposti@gmail.com>
> Fixes: 7c1d1677b322 ("iio: accel: Support Kionix/ROHM KX022A accelerometer")
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Tested-by: Kalle Niemi <kaleposti@gmail.com>
> ---
>  drivers/iio/accel/kionix-kx022a.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-kx022a.c
> index 53d59a04ae15..b6a828a6df93 100644
> --- a/drivers/iio/accel/kionix-kx022a.c
> +++ b/drivers/iio/accel/kionix-kx022a.c
> @@ -594,7 +594,7 @@ static int kx022a_get_axis(struct kx022a_data *data,
>  	if (ret)
>  		return ret;
>  
> -	*val = le16_to_cpu(data->buffer[0]);
> +	*val = (s16)le16_to_cpu(data->buffer[0]);
LGTM.
>  
>  	return IIO_VAL_INT;
>  }
> 
> base-commit: 81983758430957d9a5cb3333fe324fd70cf63e7e


