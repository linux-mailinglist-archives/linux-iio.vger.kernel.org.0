Return-Path: <linux-iio+bounces-11608-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 640059B6411
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 14:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 959561C20A6E
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 13:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731DA1E47BC;
	Wed, 30 Oct 2024 13:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="biYP1z73"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B33D1DF754;
	Wed, 30 Oct 2024 13:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730294927; cv=none; b=J1WZaKgq4sprkRyv0UQulzB4JfKnAaqEnyMBsq+QiUMfqvsPtr6QiOMMlz/FDusQV5drko/BuWmIsTPXb0e87DZyFioJghtTDNpqFe0SQDkNYE2POcF7LcL1A5PujH0MZO5pqEvhKzeKn9rb+XeJffe8KOy0ML/ydrfFAIbQqyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730294927; c=relaxed/simple;
	bh=OpH0Ihzw4aLoatOPMl4+LfZ+kC1HwHVeg7SvENl2MHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ec+vqLJ2Z5agKsHdd7k35Zh+cPQOu2RzdKVWSDOVctTtoMbA73YbYvWqWgqLHfhJmZBLzbXu5H97wzqWcn1TTMVyN3Vmbi4laDwg7FSmPB07k9Nz5sD/VdPIO7B2TkXaM1r8CqugeaWj7G+sIMSPqtDeQ4ZIn0LYfIrwa5RILps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=biYP1z73; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53a097aa3daso5901929e87.1;
        Wed, 30 Oct 2024 06:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730294923; x=1730899723; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OGZab1xZG2/vym3zoXCYPi1+0F2M3o2xJQM0/wIDSEk=;
        b=biYP1z73wN6CXjvF/lx2TajWBX3X9131F3ovKoC5IM0t6ElQSEu4j8DxBh185O6Ofs
         dnhpWpEsy7g/DGckpzXFbSHWjkYH5HIjnrBEeffWOInHRMdtfwL4eeeYY2Yur7wjS4yg
         BldIEFULoW4oOghx2eSdRnGGlhVGx1/GYrrfAx0Y1i1mREVKHh8Vy0PLTl07vljxVFzi
         wpoEGQaApuhVSLaCEVhk4stQ5FGm68FVqOAGfolabGsqpXDv0sjJgRLGlkZDun/Nxs62
         zqHomnK6FHgJuj2jyTOGI73+dX5jUXlW51cQfe6yrLU3dr4wmitSAzDjHXJ7HjwfeKgY
         bQfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730294923; x=1730899723;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OGZab1xZG2/vym3zoXCYPi1+0F2M3o2xJQM0/wIDSEk=;
        b=l8cCmFUXMcsyY6JCKteYMNbrO12Mmha9a0ybPoZSvmedt5Md3yJhzd/zKDrxyiQgAv
         ryk3bGds/mWH84QmkKSpHPetcdQL/aFhnb76sbCumjkiF7vZfMjzC9XV0Lzyf7QANZJu
         k0x2JJDEMLUcvASFN4eIU3SA61zq7R4+2FeWOsXA09GWFiU7VyM9eBZjWsrwpVcpzeMN
         5vrhwM+NKs0a3l/yDCjhKKjmN6z1sKUpV51hzp5mZ8jh56GGg9DVylhYIHGXDWQp5ffX
         tcCBNxQDb0sQTBWDwS2x09R5jdlpPCf5UoSXONhCNs08NdMzDzOuQX7/4buyjJKGuAaz
         +ojA==
X-Forwarded-Encrypted: i=1; AJvYcCUFUnj79z5cjzlXNla4E+ccnCHTawCyMoHvFz5MYvzWDAMBrgqYoVxQC92/UZBLuILqzfMLVZYDj03Ks9Ar@vger.kernel.org, AJvYcCUSugC7ZKonN1usdYJhug9gkE4JfeN+ur1Mggofq/eiBnt9TedlQ01VpXyVpeqAdsQA2BRCKBeDC2E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys7+6xzbJt8qHC7Hj1Q1VnZGt8JwiltjqBtX+JR0VXfpmsh6+M
	hHiRvxMX2iY1XKArC3QB9eqWgCbStR5lSnTj4+HLUR996EwxL2WV
X-Google-Smtp-Source: AGHT+IHE4gzj70K3Pk1n/7+JRn6DJxVC2dVUX0uQDIzgM9s0SSwXoTwlqo3E2IdUBCPgo8+BgUTuDA==
X-Received: by 2002:a05:6512:39c7:b0:52e:9e70:d068 with SMTP id 2adb3069b0e04-53b348c0c88mr8721980e87.4.1730294922891;
        Wed, 30 Oct 2024 06:28:42 -0700 (PDT)
Received: from [172.16.183.207] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53bc0d6de47sm249349e87.261.2024.10.30.06.28.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 06:28:42 -0700 (PDT)
Message-ID: <216a4ffe-b97a-43e8-b1cc-59baedcb0ca8@gmail.com>
Date: Wed, 30 Oct 2024 15:28:41 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: kx022a: Fix raw read format
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Kalle Niemi <kaleposti@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Mehdi Djait <mehdi.djait.k@gmail.com>
References: <ZyIxm_zamZfIGrnB@mva-rohm>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <ZyIxm_zamZfIGrnB@mva-rohm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30/10/2024 15:16, Matti Vaittinen wrote:
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
>   drivers/iio/accel/kionix-kx022a.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-kx022a.c
> index 53d59a04ae15..b6a828a6df93 100644
> --- a/drivers/iio/accel/kionix-kx022a.c
> +++ b/drivers/iio/accel/kionix-kx022a.c
> @@ -594,7 +594,7 @@ static int kx022a_get_axis(struct kx022a_data *data,
>   	if (ret)
>   		return ret;
>   
> -	*val = le16_to_cpu(data->buffer[0]);
> +	*val = (s16)le16_to_cpu(data->buffer[0]);
>   
>   	return IIO_VAL_INT;
>   }
> 
> base-commit: 81983758430957d9a5cb3333fe324fd70cf63e7e


I should have CC's Mehdi who added the kx132-1211 support. Did so now - 
sorry for the noise.

Yours,
	-- Matti

