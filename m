Return-Path: <linux-iio+bounces-240-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 995697F36D5
	for <lists+linux-iio@lfdr.de>; Tue, 21 Nov 2023 20:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 527C72823A7
	for <lists+linux-iio@lfdr.de>; Tue, 21 Nov 2023 19:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9825B20D;
	Tue, 21 Nov 2023 19:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="FXyvXTAY"
X-Original-To: linux-iio@vger.kernel.org
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFFF6191;
	Tue, 21 Nov 2023 11:35:49 -0800 (PST)
Received: from [100.117.177.39] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: shreeya)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 4B2AA6602F3D;
	Tue, 21 Nov 2023 19:35:47 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1700595348;
	bh=/VVJWABCA7OL+A9POx+GinmD39+Xcj9nJKZjqipf/BM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FXyvXTAY5u5vyGIr9fOEpnrHF2cv5bq9yC3SaO0eKxQZosbVe5MW9BQ/mxuRsaBQj
	 9K/WM8nrvt9Z8lHOz+9JKYBtQVGjsA9ZTVLJD7a8a6vw+Jdohsp1BVtuZIJ4m1X3kH
	 Qug3PUYCRChei4tWj8eW8otT5kwtNhHh9Q3X7qXXLYQoqIfof0Gy6FvKT8w8mKtDpd
	 +Bd23TWMx7WrWnx5QHrddDoySQCRTMag753bpIVXYbx8/Q6n1RG95jviuPyFsRyokC
	 upnWkL3JNdEHyUmP2xtgAvty5imYK7H52y82pLRaq8beacvoeVoY7LkP5IPSamKwq0
	 f86E78pJjLEUA==
Message-ID: <06d3c2f7-50b4-b44d-fa75-8ca6a1a26d89@collabora.com>
Date: Wed, 22 Nov 2023 01:05:41 +0530
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] iio: light: ltrf216a: Return floating point values
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, lars@metafoo.de
References: <20231107192005.285534-1-shreeya.patel@collabora.com>
Content-Language: en-US
From: Shreeya Patel <shreeya.patel@collabora.com>
In-Reply-To: <20231107192005.285534-1-shreeya.patel@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 08/11/23 00:50, Shreeya Patel wrote:
> For better precision of input light intesity, return floating point
> values through sysfs instead of an integer value

Hi Jonathan,

Gentle ping for this patch. I am not sure if you got time to look at the 
patches
after LPC but just making sure it doesn't get lost between bunch of 
others :)


Thanks,
Shreeya Patel

>
> Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
> ---
>   drivers/iio/light/ltrf216a.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/iio/light/ltrf216a.c b/drivers/iio/light/ltrf216a.c
> index 8de4dd849936..68dc48420a88 100644
> --- a/drivers/iio/light/ltrf216a.c
> +++ b/drivers/iio/light/ltrf216a.c
> @@ -234,7 +234,7 @@ static int ltrf216a_read_data(struct ltrf216a_data *data, u8 addr)
>   static int ltrf216a_get_lux(struct ltrf216a_data *data)
>   {
>   	int ret, greendata;
> -	u64 lux, div;
> +	u64 lux;
>   
>   	ret = ltrf216a_set_power_state(data, true);
>   	if (ret)
> @@ -246,10 +246,9 @@ static int ltrf216a_get_lux(struct ltrf216a_data *data)
>   
>   	ltrf216a_set_power_state(data, false);
>   
> -	lux = greendata * 45 * LTRF216A_WIN_FAC * 100;
> -	div = data->als_gain_fac * data->int_time_fac * 100;
> +	lux = greendata * 45 * LTRF216A_WIN_FAC;
>   
> -	return div_u64(lux, div);
> +	return lux;
>   }
>   
>   static int ltrf216a_read_raw(struct iio_dev *indio_dev,
> @@ -279,7 +278,8 @@ static int ltrf216a_read_raw(struct iio_dev *indio_dev,
>   		if (ret < 0)
>   			return ret;
>   		*val = ret;
> -		return IIO_VAL_INT;
> +		*val2 = data->als_gain_fac * data->int_time_fac;
> +		return IIO_VAL_FRACTIONAL;
>   	case IIO_CHAN_INFO_INT_TIME:
>   		mutex_lock(&data->lock);
>   		ret = ltrf216a_get_int_time(data, val, val2);


