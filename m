Return-Path: <linux-iio+bounces-22251-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7774DB19BAA
	for <lists+linux-iio@lfdr.de>; Mon,  4 Aug 2025 08:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 337F63AADA2
	for <lists+linux-iio@lfdr.de>; Mon,  4 Aug 2025 06:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8C722422D;
	Mon,  4 Aug 2025 06:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lzqwd7Ov"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A812EC2
	for <linux-iio@vger.kernel.org>; Mon,  4 Aug 2025 06:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754289535; cv=none; b=OvEgKNar0eu7Xjf7eBKzJut1a6N/1/PLY2BbvFhX66lkuPRznekVwxeBOa59Ga1Tglq/hFaD5IcvSDuFB6+aSQKGJm/DNJxsnkbgB6pMfEZ07OIHyZmhaHHZjiDOuu9o87f70clq9Cp8WTzGBEuAKRtHxR1zYHwlIaxA/Qu4vbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754289535; c=relaxed/simple;
	bh=S4T08e0GpMv/9zuYdlakoGCD/4wIgIKkZvagj7+I6GQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PcaURchzyCgBS2rRXRzvlYp/Bu3hRKFlBaCgjQJS7xpMNiLORc+pkrANEhn9GtfcU14KsyIVsmwmyTu+txy9lyWrotW0Uc9LdYI3RwIGKMaOpozGGQqke8SRBejEK6hiwn03+NkkczM8apOX+y8eo1WmArl6bjxxSVfgNAdNRqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lzqwd7Ov; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-55b82db8fd4so3988681e87.2
        for <linux-iio@vger.kernel.org>; Sun, 03 Aug 2025 23:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754289531; x=1754894331; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LV7XBz3a6r47Fg9nnfSIUyGlzyU6a9mbqDQKZLv20og=;
        b=Lzqwd7OvRpSs3wc3de7Y0/fNgG4hQJVEy++6Fxc7WEDpKCTVTBJuJWpEVdobfia83h
         ri4D7FomGjB5QDmf/wAqNdVbD6+15pe9WeckT5hAlV9RXwAZWIJgxVgOnru84DdCVGSP
         B/MDTxqpiRPHotTqZnoaPA4qJ0CF+1WaRu4RWn4aoQGCIJL4aicgOpQw+L0KXlD+gLMz
         dBH90f/J0SHSFbqb6BQIzizZmOtu7ji/h9mDWG5xM5Jx4vHcLVmE1H0Qsf+JOW+aflak
         Dd2SnrhC4F93JAY1l6aU9evTPQacsobfHlHFCYsZHpK4s4pAdswe382usMJmMV6NJC8U
         iLhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754289531; x=1754894331;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LV7XBz3a6r47Fg9nnfSIUyGlzyU6a9mbqDQKZLv20og=;
        b=IKe63ocblvSrb1ecm0VwIlOKEy1ebn6BmMyrUKSOr5JZK0uy1cR36dcMPxCir2kXg6
         ZQqr5rSYaf/0CGQOy90cC+1iDAvclK5pHj41rWzhG4K/ni8jkq8EKGKRNiqiFA3YHfYz
         95fRor33sFY/JhPfm5bm4qzQiE/ATGsz1QjhcKczSj5Bv77TDeXmSZf8AslwqGLVKoSS
         dlyBj51pZODzq1ppMdjW1SgoPs2RN26/+vcZ9dyU7PudyuKnM0RCiiEX7zAyHshlyAWD
         /R2m9rJe9qoKebfcukKYPqXLHO4LocQpZ9XDfTm6H/mXGwxiZDLmgtADHpOtIcl6ecvT
         W5og==
X-Forwarded-Encrypted: i=1; AJvYcCVwTzJ2r4NZKRWKX2Fa2iwfTc3Vs9SAmmfNE2Z8db+DIlP76Bn/9PykLhkVGcsd8bhkZylX1O7iiSs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtQWXgsubEbVPTuVsKTYXDPT1IvsxsYUODK4au0NN3hYGVh5+5
	JgKZ+wuo7JQjozc5eEJ1kgETiHa9QPFp//4iKhYnl1f3pGM08pZk6B8K
X-Gm-Gg: ASbGncuCUl9q0Z5wpWay1NmTVxVVA1Ss2kzgdcyV4+wfB7cNJk5D/6z0hUs5JE/49MU
	QLfHDKyytVoYMY/uHzwWJTEmaIXMRNw2ZvtxZgDAHjr/Dyr2kPCt51qhZeCVCCV/7LzKnwDO73A
	5VqgDc9FrTaJoANn5j1isXY6ftzYgeRRkHrgeD5I4qH+bSJ5du86Dolgt5O2iWGPJ2fA+BeC4rX
	llzJWkxv9WTZwjWVagFukowDjTHmXwMg8snF2htN9CjObcAI8ka8+r3tbPb+a3DnbQYSeJhO8Hw
	IE1+zfcHfP0B4f9JocL0kcSTstscMmjFSXiLKMTagMa4hi8RKbj69UmF5vkstHskrWLVM4A7+Ch
	/aaeR8Re6VFoeisU7N6re1xxZ8gzRwpotQiWa4PaL6c8tNtyRqTHR00hgT+Tq+fIm177ZqCVsyP
	LOrvU=
X-Google-Smtp-Source: AGHT+IGnRwiuKInxJFTHIvr7vHYZkM+LmiJy8WPbVrQA4aCQMC5T6oCyW6BvWuF+vluYjZpnC2gLxA==
X-Received: by 2002:a05:6512:3e0f:b0:549:5866:6489 with SMTP id 2adb3069b0e04-55b97b7aaabmr2076553e87.47.1754289531352;
        Sun, 03 Aug 2025 23:38:51 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88cb902asm1551146e87.185.2025.08.03.23.38.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Aug 2025 23:38:49 -0700 (PDT)
Message-ID: <7c1c27a0-8256-48c3-950b-adba888f405c@gmail.com>
Date: Mon, 4 Aug 2025 09:38:48 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/16] iio: light: vcnl4035: Fix endianness vs data
 placement in buffer issue.
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
 <20250802164436.515988-3-jic23@kernel.org>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250802164436.515988-3-jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/08/2025 19:44, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> The assumption is that the channel ends up in the first 16 bits
> of the buffer.  On a big endian system, the regmap_read() will
> read a 16 bit value into the 4 byte location, leaving the value in bytes
> 2 and 3.  Fix this by using a a local variable and copying into the
> current location.
> 
> Fixes: 55707294c4eb ("iio: light: Add support for vishay vcnl4035")
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>   drivers/iio/light/vcnl4035.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/vcnl4035.c b/drivers/iio/light/vcnl4035.c
> index 01bc99564f98..79ec41b60530 100644
> --- a/drivers/iio/light/vcnl4035.c
> +++ b/drivers/iio/light/vcnl4035.c
> @@ -104,14 +104,16 @@ static irqreturn_t vcnl4035_trigger_consumer_handler(int irq, void *p)
>   	struct vcnl4035_data *data = iio_priv(indio_dev);
>   	/* Ensure naturally aligned timestamp */
>   	u8 buffer[ALIGN(sizeof(u16), sizeof(s64)) + sizeof(s64)]  __aligned(8) = { };
> +	int val;
>   	int ret;
>   
> -	ret = regmap_read(data->regmap, VCNL4035_ALS_DATA, (int *)buffer);
> +	ret = regmap_read(data->regmap, VCNL4035_ALS_DATA, &val);
>   	if (ret < 0) {
>   		dev_err(&data->client->dev,
>   			"Trigger consumer can't read from sensor.\n");
>   		goto fail_read;
>   	}
> +	*((u16 *)buffer) = val;
>   	iio_push_to_buffers_with_timestamp(indio_dev, buffer,
>   					iio_get_time_ns(indio_dev));
>   

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

(Although, I'm not sure if the local buffer could be a packed struct?)


