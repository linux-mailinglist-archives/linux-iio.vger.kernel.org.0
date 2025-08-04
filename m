Return-Path: <linux-iio+bounces-22257-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E218B19BE4
	for <lists+linux-iio@lfdr.de>; Mon,  4 Aug 2025 09:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2E6B1779DF
	for <lists+linux-iio@lfdr.de>; Mon,  4 Aug 2025 07:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898582309B3;
	Mon,  4 Aug 2025 07:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f4HvCiuA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62D33D3B3
	for <linux-iio@vger.kernel.org>; Mon,  4 Aug 2025 07:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754291197; cv=none; b=GHgNjgJ9g/TprOzhgDfHw+S7qjII3eOVd5cg93l/EYx2hAfNt+Pl1iRHTXZhW1y+4pBfas4i7TjkTQQapSHsdwrr3a9Pi6vQUJRpEGGz4CDIEQPbrKQyeRcVt+4b5WOJImYu4AGR/Ekzn6XP6zqUEMsPRRf6wVplZOgXdqs24fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754291197; c=relaxed/simple;
	bh=PDLYlQXLH1Lgj8UMMdqM0utJPIBau59i8mRqC+YXNJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dpDLx7DJ9qb5dL2Bszzv5ploWKch526k5Yz6+nEZFcBK/ICiGnNml2V8jLEUSUzGWTdee8ED/5PnXgM5gixl/r7csLv605pn/bPAy1Iozkw3V6ULkkiPQLGKAPJCJMzwST1Cpp3ymuGbShg+C1+lxXz2XRRrZdLRdhY9It+iajA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f4HvCiuA; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-55b9a3e69d3so2046626e87.0
        for <linux-iio@vger.kernel.org>; Mon, 04 Aug 2025 00:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754291194; x=1754895994; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mo38LrOuC4hOC5Cm4IaRJ4r2sbMwbvs0YL26VZZbWvA=;
        b=f4HvCiuA66SdZNe/nMd7dP8AdkD4HXWQecMWjKB5XY14tG8blllo1bZgLtXbo3sT9v
         wd6hRxfdxY0fHRcneZVsc+m+4Tnyz56MpascBscbIK9I0HNij6ZZwQ/fo/9LyAd0JuqQ
         MS+Pa9PWNxbdXmXD8oopyicY56M7dFC8n5UH+M+PeecjePcyYeSm3dNiocNbPrsPJ2S4
         C4kIvrnbTUK+70W1zb/qhfOCU0XwQ+HohNYWh76GHAPzPh9bT7/rFa1YDz58dL7I0NYL
         xlnzKFpWzrmqcDlLukSJyYmR2CMzmICb/moqWMVFWGEZASVC6VrM6WCInPUlAvi6e6El
         VuxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754291194; x=1754895994;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mo38LrOuC4hOC5Cm4IaRJ4r2sbMwbvs0YL26VZZbWvA=;
        b=J5yCE2xK94qKlKXafsxIotojyazr59vWX9pwTXbL3HsW7sF5HqmfuCAvz5WQlE/mgX
         FD/aFM+6r1VmzgAZhg2Yp5aDKKt7Ri+J/lK7S3QTU1RQuN+WdiEGyuoUeuDiQcKBw6DC
         oI4dckU3RDVN/Ukta6jMjJDJhGs4CF3c88fFJmdKuzoDnIfbxKVLTq0iZR+NRH03QkIf
         uQWwQNAiSBVJIR2AZYix1FRqa+DW17CJ+V/hK/hdNZ+YZPURd5gg389DvLqceMerFLfd
         bYefy+zMEErjwkXRfkNwxDHxYFpFxY98bJ5mwiD5bZywRxS8hroEMVCB0B9pp2PCauey
         rtKA==
X-Forwarded-Encrypted: i=1; AJvYcCUavLGlykeJCdWMXuJYAmAzccKWC3fOWqtaDt4u124p4sVHTFCh86A58yg+r4cg2Ne6PJfsEcoSVCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfniECpGTiRxU/3a5RKf9ipTNHeH3K6X5Di3kn7abpdlAjK2j6
	yH6hp8uvk5KexCH4lRNpxBNSgoFvMrp+oNDAycJ1NuPgxVJhc0QBf6Pt
X-Gm-Gg: ASbGncuTB41XxyBvfpzdWZWfsYpLj+5za7DwqXcNXEYB/1yEQdXEreK9cBjhDO8ZUuM
	3mqP0sBUBtD7Aao2HEbI4zYlhdZnpOawrDH0A6sfUzC9NoeGeaWNg2nl7e1R/zGWPvliusk8MTf
	hAYVn2AuHWVVW+VFcqWSmbmX76+HSCxwLX1+1IqMEHJMVvg8jxGY+Y5NK6g9j5CPct6Wm0NBS/Q
	KVhf4XMWlJXP/6OuJ7tHmflXirwdmtvOiREAo1GZJ3QhPyLKJLdxmCcVTBC9GKk9bmYESQd+jNv
	Xn+JRBh5cruvxHhJIiCskAG0I8qvfe+yJBfbyVtmFsurFbsuYnaGhDHLk36yLozk+M1DGZyReIm
	0ZQKULTHAMPFWziN27IhZSXdqRa3NJ3CSs9mgOnITviIHXyKLGfmb/BEVHry27SALdKEg5mkmbr
	QFwJ0=
X-Google-Smtp-Source: AGHT+IEmPgMUh8+bwWNWlHEwcqZMPHqfiuNNELRV+wOuE/ltV+v2Ls3dX6Jl+hqtiB5176IwdFnowQ==
X-Received: by 2002:a05:6512:1289:b0:553:35f5:7a90 with SMTP id 2adb3069b0e04-55b97b5088bmr2240961e87.28.1754291193518;
        Mon, 04 Aug 2025 00:06:33 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b8898be9bsm1532475e87.12.2025.08.04.00.06.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 00:06:31 -0700 (PDT)
Message-ID: <5dc80967-6bfb-4caa-8e6c-dc8b7c533df9@gmail.com>
Date: Mon, 4 Aug 2025 10:06:30 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/16] iio: light: isl29125: Use
 iio_push_to_buffers_with_ts() to allow source size runtime check
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Cc: Mudit Sharma <muditsharma.info@gmail.com>, Jiri Kosina
 <jikos@kernel.org>, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Abhash Jha <abhashkumarjha123@gmail.com>, Astrid Rost
 <astrid.rost@axis.com>, =?UTF-8?Q?M=C3=A5rten_Lindahl?=
 <marten.lindahl@axis.com>, Gwendal Grignou <gwendal@chromium.org>,
 Christian Eggers <ChristianEggersceggers@arri.de>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250802164436.515988-1-jic23@kernel.org>
 <20250802164436.515988-10-jic23@kernel.org>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250802164436.515988-10-jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/08/2025 19:44, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Also move the structure used as the source to the stack as it is only 16
> bytes and not the target of an DMA or similar.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>   drivers/iio/light/isl29125.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/light/isl29125.c b/drivers/iio/light/isl29125.c
> index 6bc23b164cc5..3acb8a4f1d12 100644
> --- a/drivers/iio/light/isl29125.c
> +++ b/drivers/iio/light/isl29125.c
> @@ -51,11 +51,6 @@
>   struct isl29125_data {
>   	struct i2c_client *client;
>   	u8 conf1;
> -	/* Ensure timestamp is naturally aligned */
> -	struct {
> -		u16 chans[3];
> -		aligned_s64 timestamp;
> -	} scan;
>   };
>   
>   #define ISL29125_CHANNEL(_color, _si) { \
> @@ -179,6 +174,11 @@ static irqreturn_t isl29125_trigger_handler(int irq, void *p)
>   	struct iio_dev *indio_dev = pf->indio_dev;
>   	struct isl29125_data *data = iio_priv(indio_dev);
>   	int i, j = 0;
> +	/* Ensure timestamp is naturally aligned */
> +	struct {
> +		u16 chans[3];
> +		aligned_s64 timestamp;
> +	} scan = { };
>   
>   	iio_for_each_active_channel(indio_dev, i) {
>   		int ret = i2c_smbus_read_word_data(data->client,
> @@ -186,10 +186,10 @@ static irqreturn_t isl29125_trigger_handler(int irq, void *p)
>   		if (ret < 0)
>   			goto done;
>   
> -		data->scan.chans[j++] = ret;
> +		scan.chans[j++] = ret;
>   	}
>   
> -	iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
> +	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan),
>   		iio_get_time_ns(indio_dev));
>   
>   done:

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com

