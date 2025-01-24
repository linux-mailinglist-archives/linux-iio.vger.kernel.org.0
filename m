Return-Path: <linux-iio+bounces-14548-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DA7A1B171
	for <lists+linux-iio@lfdr.de>; Fri, 24 Jan 2025 09:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BAD81886B81
	for <lists+linux-iio@lfdr.de>; Fri, 24 Jan 2025 08:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC27205AB7;
	Fri, 24 Jan 2025 08:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aX9m4KUX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FF51D61A3;
	Fri, 24 Jan 2025 08:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737706368; cv=none; b=FpsR49ikdQ0kHaK07z459u4W+wN9s4lqlsuntZ4xoYadpDERcUJiQ0/EJj6f8MzMqobiYC3ZvvxMJHS4+1uFRnAZv7RmWGtLBk/h4JbDDy4FkuzA8mQO77VlZtQMTmurwHUsNdAzft4AP6doOV7GWMybbY2LZl34rD7fP8p17DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737706368; c=relaxed/simple;
	bh=k4+ITQqrIbo1loVHiuZlp6XOp4dHy6I+5KXgu2/YzOw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qAt6yp1Gtq6VJ7/D8gkfo3JDxpioubFpkk/+yKtWjv98wyvXtoyLXOpN5o33oocvFhV5A60HbLjaGaN0X6KDwQ5IJP/XLUWJtSZhixHHktAkcRFH/RDcvdBzd276I7q2WDM36q5zQHE3fiImpOtVX32UPYUPaJocndQY9+NFlxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aX9m4KUX; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5401c52000fso1513587e87.2;
        Fri, 24 Jan 2025 00:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737706365; x=1738311165; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/ksgYZyRCIheLXzeBXOWodFK4I/3cMnoXDRDkBciDoU=;
        b=aX9m4KUXTQMR/s+rzzqAfQNIND+SoVkDKHB9qmCuLP9FekvJ2G+svXJMDsZUYNUPRe
         FPRYSzVLBJfyna6rWQHpWCwQW5VKX/ISl2wnD+iVaYqf82+kSMLQtpvEIZSw8GCYiVDR
         4Cwwrcil9CVBsY0W5M7HxoMBVLAFE/D8ab9pcP26iMoNANCt0JTeQ09Q/LQXrNf42OjO
         Tj6aTpGupg1YZuA3yDdxAsP+M/MIZgh81J/OvK3o2EbZENtQJLCQetRw9jfvjxfxApUE
         mr57pfHvVhuIp5vLbKF0FfujWHriQM9k4EUJ1HU8x5zCHgFiqXZRYqpd2ALCbCxeSoTp
         Is+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737706365; x=1738311165;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/ksgYZyRCIheLXzeBXOWodFK4I/3cMnoXDRDkBciDoU=;
        b=PUI/fxct4Uqkvs5ObNFgxBjQmdIhCaFugeqm7xzNMN0BYmwFakkXjj23L2v682H6bC
         Z3ueZYsfX3/3fXy/shEUZWDEWZc6erpUEmW+E7L7lZ8IM9TZVt3+IPjXEcUuePJBxWGF
         w0FiuT9dZA02TBrsmtu2FQAID71f1NyX0RjUrcmN/wNgjN2s/cDFXFT8G0uHZe8Dlc6D
         Z7KnccCR/XHlHFWaOzr/yp4M66j5N548mCu9Cv8FvoZIacRHNoycROwCQoDkI3iGZHGw
         sm/hhL0jFd3pqhXxS+9xDOTNWCPSZVGbFYUfN6yb45BlsIsUJMYvtX4hZIcgaj8cmFT2
         TlPA==
X-Forwarded-Encrypted: i=1; AJvYcCUqJbHvOkCY91/gAb4wCSWTljqCVT1sCBjglrHvyb+gOBq/BAgOPR1gJoqO7NwwgHCHzvxUrxbB+5+Fv6A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5Wnz2hX4Vbdh6+C8iybC/uNryGggaVvqEk0kIWXTi7+MJ3grL
	bBTjhsHS5I8Y3qMpE6qO6GYQ31J5jXR9WPL6C/gudoN7B5vzZykj
X-Gm-Gg: ASbGncvj27OfQ1DemTks1y8eUL5zbMp7EAhZGL4twHARFx4WCX5NQ0G7r1l3FBtoN0F
	Bb+VxIYtqESfWe808zKasb49brxtEKTv1Htfr7kOyf3xEcTKqH5t/fcVlL2dGpSEWz7qg3Gc1x6
	Rn78arxGwURnKEK0OoW7xLdNWwK/0IjMnxSH/efAX3W49s7rvE8IhT2Ri73BwxcmS3+1CCsmACt
	AAYhX4ItJrpYI1JQ0+Nodzv1gOLnbZPRPQa7pfrFbl15ZoZ3+sizTztIJfZD/2FhHuvvU8HUyyl
	KHCoV6T18NgrK4ADFw==
X-Google-Smtp-Source: AGHT+IGJHG71bmWkjlWvyn+G1hsNW63HDGCjoRy70j0bOKwUTh3FZkruwOvrWu3GrDn+cpXPasiYJQ==
X-Received: by 2002:a19:f509:0:b0:540:3550:b0f1 with SMTP id 2adb3069b0e04-5439c22d865mr8029717e87.7.1737706364812;
        Fri, 24 Jan 2025 00:12:44 -0800 (PST)
Received: from [172.16.183.207] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-543c822935csm208980e87.3.2025.01.24.00.12.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jan 2025 00:12:43 -0800 (PST)
Message-ID: <9bdd3a1d-0eb3-4ef1-a6b8-f613de1eecb4@gmail.com>
Date: Fri, 24 Jan 2025 10:12:41 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] iio: gts-helper: export iio_gts_get_total_gain()
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Rishi Gupta <gupt21@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250119-veml6030-scale-v2-0-6bfc4062a371@gmail.com>
 <20250119-veml6030-scale-v2-3-6bfc4062a371@gmail.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250119-veml6030-scale-v2-3-6bfc4062a371@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/01/2025 19:32, Javier Carrasco wrote:
> Export this function in preparation for the fix in veml6030.c, where the
> total gain can be used to ease the calculation of the processed value of
> the IIO_LIGHT channel compared to acquiring the scale in NANO.
> 
> Suggested-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Hi Javier,

This is fine but could you please go the extra mile and add a doc to the 
function? I'd like to have kerneldoc for all exported functions.

> ---
>   drivers/iio/industrialio-gts-helper.c | 3 ++-
>   include/linux/iio/iio-gts-helper.h    | 1 +
>   2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/industrialio-gts-helper.c b/drivers/iio/industrialio-gts-helper.c
> index d70ebe3bf7742906960c6af22102682c5b8dcdfa..6ec434338411d09fffa1db52046a7df9b34c89bf 100644
> --- a/drivers/iio/industrialio-gts-helper.c
> +++ b/drivers/iio/industrialio-gts-helper.c
> @@ -950,7 +950,7 @@ int iio_gts_find_gain_time_sel_for_scale(struct iio_gts *gts, int scale_int,
>   }
>   EXPORT_SYMBOL_NS_GPL(iio_gts_find_gain_time_sel_for_scale, "IIO_GTS_HELPER");
>   
> -static int iio_gts_get_total_gain(struct iio_gts *gts, int gain, int time)
> +int iio_gts_get_total_gain(struct iio_gts *gts, int gain, int time)
>   {
>   	const struct iio_itime_sel_mul *itime;
>   
> @@ -966,6 +966,7 @@ static int iio_gts_get_total_gain(struct iio_gts *gts, int gain, int time)
>   
>   	return gain * itime->mul;
>   }
> +EXPORT_SYMBOL_NS_GPL(iio_gts_get_total_gain, "IIO_GTS_HELPER");
>   
>   static int iio_gts_get_scale_linear(struct iio_gts *gts, int gain, int time,
>   				    u64 *scale)
> diff --git a/include/linux/iio/iio-gts-helper.h b/include/linux/iio/iio-gts-helper.h
> index e5de7a124bad6eb65414df364f84e81301b0690b..66f830ab9b49b566d549c7b5b8291d42a0825b96 100644
> --- a/include/linux/iio/iio-gts-helper.h
> +++ b/include/linux/iio/iio-gts-helper.h
> @@ -208,5 +208,6 @@ int iio_gts_all_avail_scales(struct iio_gts *gts, const int **vals, int *type,
>   			     int *length);
>   int iio_gts_avail_scales_for_time(struct iio_gts *gts, int time,
>   				  const int **vals, int *type, int *length);
> +int iio_gts_get_total_gain(struct iio_gts *gts, int gain, int time);
>   
>   #endif
> 


