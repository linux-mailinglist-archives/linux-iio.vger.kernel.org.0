Return-Path: <linux-iio+bounces-10474-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6464299AC4E
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2024 21:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75AD51C26312
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2024 19:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63BE11D015A;
	Fri, 11 Oct 2024 18:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=ijzerbout.nl header.i=@ijzerbout.nl header.b="Z1XETybb"
X-Original-To: linux-iio@vger.kernel.org
Received: from bout3.ijzerbout.nl (bout3.ijzerbout.nl [136.144.140.114])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B721CEE86;
	Fri, 11 Oct 2024 18:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.144.140.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728673182; cv=none; b=RzpBLBR21hmLoI3dqgY0/qLmjhUVuqnqW1NF+pONryDhEsqrumXst7mn8SHh8ICjQa2o/WyQhZj+/wnDt1EOQxG0baMtAqhtwfS9K7WoY5pFRH403rXcu2yZ7AsI9vJ3p8mgL+XsDjjZkBaZE4wrRFCkH4dpUuWodBOxb2/VHCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728673182; c=relaxed/simple;
	bh=tfzphyBXmgX+W5YnHQG1jp4AfKvqpmREL0HJpK4fxLw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kLiPZZqBJX4K6ORg3KV5lZ2jBKF981M9A7mK9MtYHxLeozOBKqO9/xX2dbliLHtcFdaOYxpomjrcqJkj8i+XpeoN7ev/a77ft1mNsrv8rsNAVcPl+LxsQRbvl4aFYYzBxCNsQAIA4TxIYgtrzA8EMFTLthElfhf/ZJiuSpWCBwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ijzerbout.nl; spf=pass smtp.mailfrom=ijzerbout.nl; dkim=pass (4096-bit key) header.d=ijzerbout.nl header.i=@ijzerbout.nl header.b=Z1XETybb; arc=none smtp.client-ip=136.144.140.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ijzerbout.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ijzerbout.nl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ijzerbout.nl; s=key;
	t=1728673170; bh=tfzphyBXmgX+W5YnHQG1jp4AfKvqpmREL0HJpK4fxLw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Z1XETybbQ2OvycLOZqw+47j4m3Da+WPOn3A7l0n9sya+RtdbfMSDZihjKNGPSk8xY
	 4zWieUZEiyK/HgeiijamKaXP4XbbTTNCnjqB69l9sudIeCWdRAPQXG46kDMRu6mqKp
	 5k/ebGbhvehd5VXVpzMKsPJ8Xx9LlJ9ol92BZVbphhkFEzXLL2PyPH/Mfuzh2IjQYF
	 UsCPZO2BriDJ//Q2Jk2awNCOrJii3drWQJWxBwzDuLI6+bWFFVnjtpFPwud8sId0Eh
	 wTc5ksz6+3BI+KA7cbcnL4nTsK66gTIMguJX09OuN7N3cOogAYSf93MvkWETIXTChJ
	 fxpwhWFUuu6I23pw+qtcwz5C+oFU/OqBv5nRb4TpEukPX9QviQC4RKmlCjPjDvHJ2Q
	 GP1+PwmhcFqhkr5nnlxDV7vMK3tRnBtrz4ntaSYa1mynKaAeWujKtMftBCMuIj/e7H
	 /NbKD7LEOuZeAKOfj35Oc1W2cY8jbq1LTR7VBsv8urxtIqdvkLN58VkiT/BGYxYbkL
	 p9durlkH1SXzpEOlsolL8yFtrXsYWHhkndEL3pxKZi9OkiDeBHGqmtSjiMpC04y347
	 wQPGM46NmsqTrkC2BqVxP4O1ibvS0s40jWhpAx83bcCSxDURefs9bDw7dYCVe/cvcI
	 kwojDC67wxRQbJHTsQpkKaKE=
Received: from [IPV6:2a10:3781:99:1:1ac0:4dff:fea7:ec3a] (racer.ijzerbout.nl [IPv6:2a10:3781:99:1:1ac0:4dff:fea7:ec3a])
	by bout3.ijzerbout.nl (Postfix) with ESMTPSA id CB07D1670AA;
	Fri, 11 Oct 2024 20:59:30 +0200 (CEST)
Message-ID: <7e9d8b56-2033-4ca6-905a-e761f43cecef@ijzerbout.nl>
Date: Fri, 11 Oct 2024 20:59:28 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] iio: pressure: bmp280: Use char instead of s32 for
 data buffer
To: Vasileios Amoiridis <vassilisamir@gmail.com>, jic23@kernel.org
Cc: dan.carpenter@linaro.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240930202353.38203-1-vassilisamir@gmail.com>
 <20240930202353.38203-3-vassilisamir@gmail.com>
Content-Language: en-US
From: Kees Bakker <kees@ijzerbout.nl>
In-Reply-To: <20240930202353.38203-3-vassilisamir@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Op 30-09-2024 om 22:23 schreef Vasileios Amoiridis:
> As it was reported and discussed here [1], storing the sensor data in an
> endian aware s32 buffer is not optimal. Advertising the timestamp as an
> addition of 2 s32 variables which is also implied is again not the best
> practice. For that reason, change the s32 sensor_data buffer to a u8
> buffer and align it properly.
>
> [1]: https://lore.kernel.org/linux-iio/73d13cc0-afb9-4306-b498-5d821728c3ba@stanley.mountain/
>
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> ---
>   drivers/iio/pressure/bmp280-core.c | 72 ++++++++++++++++++------------
>   drivers/iio/pressure/bmp280.h      |  4 +-
>   2 files changed, 46 insertions(+), 30 deletions(-)
> [...]
> @@ -2199,7 +2210,7 @@ static irqreturn_t bmp580_trigger_handler(int irq, void *p)
>   	struct iio_poll_func *pf = p;
>   	struct iio_dev *indio_dev = pf->indio_dev;
>   	struct bmp280_data *data = iio_priv(indio_dev);
> -	int ret;
> +	int ret, offset;
>   
>   	guard(mutex)(&data->lock);
>   
> @@ -2211,13 +2222,15 @@ static irqreturn_t bmp580_trigger_handler(int irq, void *p)
>   		goto out;
>   	}
>   
> -	/* Temperature calculations */
> -	memcpy(&data->sensor_data[1], &data->buf[0], 3);
> -
>   	/* Pressure calculations */
> -	memcpy(&data->sensor_data[0], &data->buf[3], 3);
> +	memcpy(&data->sensor_data[offset], &data->buf[3], 3);
Variable offset is not initialized.
> +
> +	offset += sizeof(s32);
> +
> +	/* Temperature calculations */
> +	memcpy(&data->sensor_data[offset], &data->buf[0], 3);
>   
> -	iio_push_to_buffers_with_timestamp(indio_dev, &data->sensor_data,
> +	iio_push_to_buffers_with_timestamp(indio_dev, data->sensor_data,
>   					   iio_get_time_ns(indio_dev));
>   
>   out:
>

