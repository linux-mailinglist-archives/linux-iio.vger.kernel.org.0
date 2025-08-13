Return-Path: <linux-iio+bounces-22669-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 99626B24C70
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 16:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 42D734E133E
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 14:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805BA2EBDC6;
	Wed, 13 Aug 2025 14:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="c6ErBi8T"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AC4DF71
	for <linux-iio@vger.kernel.org>; Wed, 13 Aug 2025 14:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755096658; cv=none; b=NNM6OnDUuhdBnMV7i4rAEqfrwuN9T1wtIczVMPP4rKuosF7Hu3K7GzYbME4YKDo18ofVHCwm1yFuq8xsGvJqDTbbFYQKBr7iJOaVwOztPUZ0Bz7/eWyu7KqnDChmaqoS5l8X6VTsh+fZXsHR/MoyxRmCSgRMgJPoZ5u6xSNvYu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755096658; c=relaxed/simple;
	bh=JLR0HDB+sugXsigzkPLR4y5+9MWTZ/84rhQ5b38TEVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b2a3VLila8DfRdb/YE+LOA+ThIFgtrKUJ7QdyWnCimezLP2kYKivR0dTmJATxZZGGujWZZHTwp6NKL+Mke3255IH5MuwWinBPhhVsj5s9hgUqjgpGaxerM6ql7jdwjbw1eaHd28M6+3Elx6ataH+GCEpyNzHd1OSXGUYzS3X3PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=c6ErBi8T; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-433f984820dso4384195b6e.3
        for <linux-iio@vger.kernel.org>; Wed, 13 Aug 2025 07:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755096655; x=1755701455; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C+UquFq/+wFnP6FXzNP7+1OTyftKdtGDXwqAPY/zJW0=;
        b=c6ErBi8TNxS6xQnsQ99ktYkxpB166huH+MC4fiSMIgoE4lO7g3PYk3Nc7CC6ep36wS
         IQs5WAS1d8GZOUGHc4A64sY491hKzyURGZWNoYT6ZZa5f6sEPJu5/8Zde1sQnx/aEAyG
         xd6omGi5i3yFa9V6f6t89GVgMC+Knl5WQKGuiCdHNKzGIS74mnR7VkncEpDCWnJPY6GX
         /ewcM0s3dVE3/YeLFf6oMC7ejXAD1S5iWdCAeapmf4fFKKB5xzES0D/wL3Q0h29NX2V2
         5D297TJkUsNtRcGsbf7wignyid5PH5a3+Q5yTtP5Jy/vGWw/iw/YOURYjhyfPCYOSAsq
         bDgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755096655; x=1755701455;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C+UquFq/+wFnP6FXzNP7+1OTyftKdtGDXwqAPY/zJW0=;
        b=he3HV2yn3ZiFEhwkZNdSUYflNohCyw22Ty+wh2bKM+g6ZkYnFWr4T7z+haLEn5T+OH
         C0rQKcsHAe4MCw164UGdlwEsg/xMpVAmtvHuwzxR/rr2V2rAMwAEHyFkHqDttNpwI4GB
         +w8qxrqt+zuD+VvndIf7pnkPXC7eHH+DrJ7mb+ipW8HEKYsmKYHnV1xGa2ST0ie7uxhH
         AoO0WqzrKhFguqTrUD2Uu0ksBCvb6dhB+/2WLosMfbA7f129p9gro0icMfmbiHo6xOEI
         GIyOMlLI2Iud3IWY4l8jbRaZjGrXKE8LhN2EtvryxInPIVnkNvgXEF2H8KLgCN22gnMd
         PqSg==
X-Forwarded-Encrypted: i=1; AJvYcCXTvUZUT0JWhYIdPwb2UnVx6ygucotacQ8x8Ml2v/mNblpN81rRer6cKARnmPLrYAUaCnvnm6tAgCY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPJn+lGRebBwQVVPzu3HlwHW9KLdEVZ5UicdD/0I4iWsOz/GhK
	F68cLa3PpCUHclU4Tl9dSb/BnGxah8/37AbGl6Wqn3EC4gl5sNahH+WgEyA/wPK3XSU=
X-Gm-Gg: ASbGncsmCTUrwh/MSI4VIOE866ojHQ5PFlGwH9DzxAtHAhkw5wBm1BgJohTJRmbkZks
	cWIswCi2an9YvpHKjfq/D0HvCA1FpCeM6hkUrCVuUD9vxoqJ1/X4m7OAtNGbcSaPeLE+4bGPUTg
	4/oChjmJVSclsG9pu0KtROzYHNYICMwZRQtucrVGMNRkyo66hizU3EzAUTEMLEEeZSELlChEiTM
	JjQSBs9LQXA0ebVd2zPJ2100OAsQQgYL2Td+vxyRq1xYJLhleQUpeonD/XaOMW5aKXMmzZ8Jtrc
	OboytTdksGZwgbsXgj9OWoaSkS1fSNQzj0rnUj2yShHFLW/96qAElfuqRmzl+HFetX0rOXI3K+D
	glma2FInSoEmiatgO+RAYblb3rxQzoEy59EN0nn2oglp4uzGVJq0JM/JMMhBUolshlNBHX+rl
X-Google-Smtp-Source: AGHT+IHiF8MN1FZQrTnzJnSv9CNFxA7tA6Te9YnB/LJkhWovfk6NtiQn4dodjNFAsr5GNuaK5WqtRw==
X-Received: by 2002:a05:6808:178a:b0:435:9705:86dc with SMTP id 5614622812f47-435d4276988mr2027407b6e.35.1755096654950;
        Wed, 13 Aug 2025 07:50:54 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:ae46:dfe2:81c8:dde? ([2600:8803:e7e4:1d00:ae46:dfe2:81c8:dde])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-435ce74ebb0sm668253b6e.15.2025.08.13.07.50.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 07:50:53 -0700 (PDT)
Message-ID: <dc817ac9-105f-40c5-806d-93db95955628@baylibre.com>
Date: Wed, 13 Aug 2025 09:50:52 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] iio: adc: ad7768-1: use
 devm_regulator_get_enable_read_voltage
To: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Michael.Hennerich@analog.com, jic23@kernel.org, nuno.sa@analog.com,
 andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 jonath4nns@gmail.com
References: <cover.1754617360.git.Jonathan.Santos@analog.com>
 <3b9f5a9f188af8b1df947806e1049269f3a0dfa3.1754617360.git.Jonathan.Santos@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <3b9f5a9f188af8b1df947806e1049269f3a0dfa3.1754617360.git.Jonathan.Santos@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/12/25 9:49 PM, Jonathan Santos wrote:
> Use devm_regulator_get_enable_read_voltage function as a standard and
> concise way of reading the voltage from the regulator and keep the
> regulator enabled. Replace the regulator descriptor with the direct
> voltage value in the device struct.
> 
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> ---
>  drivers/iio/adc/ad7768-1.c | 29 +++++++----------------------
>  1 file changed, 7 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
> index 36ba208fc119..d0b9764a8f92 100644
> --- a/drivers/iio/adc/ad7768-1.c
> +++ b/drivers/iio/adc/ad7768-1.c
> @@ -225,7 +225,7 @@ struct ad7768_state {
>  	struct spi_device *spi;
>  	struct regmap *regmap;
>  	struct regmap *regmap24;
> -	struct regulator *vref;
> +	int vref_uv;
>  	struct regulator_dev *vcm_rdev;
>  	unsigned int vcm_output_sel;
>  	struct clk *mclk;
> @@ -809,7 +809,7 @@ static int ad7768_read_raw(struct iio_dev *indio_dev,
>  		return IIO_VAL_INT;
>  
>  	case IIO_CHAN_INFO_SCALE:
> -		scale_uv = regulator_get_voltage(st->vref);
> +		scale_uv = st->vref_uv;
>  		if (scale_uv < 0)
>  			return scale_uv;

Can also drop the error check since we've already done that in probe.



