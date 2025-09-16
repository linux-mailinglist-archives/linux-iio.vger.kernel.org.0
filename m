Return-Path: <linux-iio+bounces-24177-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BE1B5A15E
	for <lists+linux-iio@lfdr.de>; Tue, 16 Sep 2025 21:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98CD61C03E0C
	for <lists+linux-iio@lfdr.de>; Tue, 16 Sep 2025 19:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00162E0B5F;
	Tue, 16 Sep 2025 19:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="U2FvcY23"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953402E0B79
	for <linux-iio@vger.kernel.org>; Tue, 16 Sep 2025 19:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758050589; cv=none; b=aoo8hXie/34MByNfTIC2i0IkvPWAZ7DTwFTxxi4J1MkBNNxfemwOQOLJtzU8AItMYfIh0FfcjnpUtxF1nRIiqCzJSgw/spSorS9uGkbOrHfAdxiosubUS9P99BPNLpF2Llx5sPAO8TeyVIjDoaVuonNSBLddT9w5teJvnYQwVOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758050589; c=relaxed/simple;
	bh=YC8yC8EkT75hFHr/FbdShk4F5U3DDZ2cuWERcjLqWNo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TL1Xva9yAXW5CaxEgx7w6n5jP8zv5oXbcTKY75dlaBOSbQwoEHIneTFr4ebpfbZovLrLIuviddTHY/1WymYNMTCwdSabJCqQAQxQaScojIko1zkFc2dpDf9bz9vueuXrZ1FQ+UfwKCjb7ftAlDVuhsO+48bmK3c+1xLDUyEURqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=U2FvcY23; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7459de59821so5028617a34.1
        for <linux-iio@vger.kernel.org>; Tue, 16 Sep 2025 12:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758050587; x=1758655387; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ndEfo094lSvy62IAprmxo1mwUZWSJf0/xtVgiQTCUv4=;
        b=U2FvcY23hcSV9j6GQDXjqoL1u2et5ynDTh7rXq+nTbcXWLcUH35+Wp4ItMbtsSqIAs
         hBpkOBazl6pSqq8HMBB6ygknEHmVpoVcKvlOg9lQ3rkM8PYjs09SM9YR9tirXi8CPsxR
         8Yu5N2s7xU8WZYYhOBJtGfwinqOQ9ZdUfgUdh7GOdVvuBNkIqnWelLX7O19G0DNDD8Rl
         q5bv+A5q+IRJ4wGMfVnmnj1AgALl9BlOswwlZ7mCNl1c/pgQfFa6Z2s3+Yhkl3KLsJ9S
         0Kx3mvanhalNaXUCGl4R4v6vDJMvRMxXAkgiyJTRcKMEYpzOUl1SzysAx2pruAZ6sm5P
         PPWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758050587; x=1758655387;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ndEfo094lSvy62IAprmxo1mwUZWSJf0/xtVgiQTCUv4=;
        b=f7YpuBNp3NdDbnjxUExRMa4fpzYC+fLWIZkLMEs5DwAsm0MaUzFv4713M5raY6bxZj
         Hbvt6nuFy2SJp/Swaqu5WoKwvYZE5oPEO9g+Y8BNaQffyuslTP9t2AzNpbfzc/e85u27
         /l0DRDyVmEeRQORxt4BiCdn+upzVM88/X523NWsCI8o7wi+aoDd1BVU/RE+hB7novS/Z
         RaZ6f+C+aMjZ/qNfBhj0L/JfqZOhxlJU+ZBBWc9J9wpYg+ZdRW/5T63Ql9tiELJCmqaZ
         NLGm+mMOGkW0Kh55gVSqlegR+OogqYUKu/N96WrKOOzuw6nXP0BhaQZWz+XvneVjZCdL
         E7rA==
X-Forwarded-Encrypted: i=1; AJvYcCXk10+5YQwKeS07u57V0ZT9pxVZ65LLjK1l/h61zqPpPRSMT+hSyzto0bUY/MZ7dELd0h1I9Glj5zU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNdX5l8V/B2JWB4O+37q09qMFuT8jIEsUfJbtTkT1+s2kU6D5m
	AUB6FmjiB6vzMVPu6qvgmHBUO2nQL4VdgUyF+8V1EnBND5pwu8dgUVxg+Zm73RvL1ew=
X-Gm-Gg: ASbGnctGS5DWjfbEZSBSGUh1cjOGSJrn/arZOUROuORKILVqzLWFjRQbO5xpH2QR2rV
	GJkK6lCQ8qI5EAf0tCx+j6HPD6FMVVQAI6DgO2ScMTiTJnzx+RyU9VU+nu249DlCwaG+7GhJy9W
	VD3UGY+raFTlF3SfBqHVjCiHwz2sCmlisPuCDSvLr9HIC+4lJYO08dvgy9Qq1wPyr2h+C3dyHyr
	P41jfCDMw2/aLKJ4s4yHxpMrBDafbeiMO60QAc+b6RNO0d0gkxCTsNoFisVMILiZ+CecilNXZHO
	dHauszD7Mzp3HRBJb2DSLzVpGDxY1sPsnQ5GOGM0m8aYiVl8tktnaJ7AJHIBwczS7yKWRQq/86k
	GrtBNoVJ2KQrx+ucGx+BMFr8db0XdC7FuANA/X80M0x+pjOlmeVKp1eZVxbzHmC3Lzc2NFs2YNE
	Q=
X-Google-Smtp-Source: AGHT+IFahDXfOCqPDL5DJRiTlTC8K5W8kCgTUbKQTe8XK7pkQ4Dti/tyYJ5r5j0lRk6m3tCLtofLzA==
X-Received: by 2002:a05:6830:6987:b0:74a:52f8:6f40 with SMTP id 46e09a7af769-75352d93fb0mr9717520a34.8.1758050586672;
        Tue, 16 Sep 2025 12:23:06 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:70a1:e065:6248:ef8b? ([2600:8803:e7e4:1d00:70a1:e065:6248:ef8b])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7524986ca64sm4301216a34.14.2025.09.16.12.23.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 12:23:05 -0700 (PDT)
Message-ID: <decdb75c-b61e-4e0f-bddd-cfc8986f3b6f@baylibre.com>
Date: Tue, 16 Sep 2025 14:23:04 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] iio: add processed write API
To: Romain Gantois <romain.gantois@bootlin.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org
References: <20250916-ltm8054-driver-v1-0-fd4e781d33b9@bootlin.com>
 <20250916-ltm8054-driver-v1-2-fd4e781d33b9@bootlin.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250916-ltm8054-driver-v1-2-fd4e781d33b9@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/16/25 5:24 AM, Romain Gantois wrote:
> Add a function to allow IIO consumers to write a processed value to a
> channel.
> 
> Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
> ---
>  drivers/iio/inkern.c         | 99 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/iio/consumer.h | 17 ++++++++
>  2 files changed, 116 insertions(+)
> 
> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> index c174ebb7d5e6d183674b7ffb15c4ce0f65fa3aed..6486fdb7c66a4c84312541f0f42cc24469972a9c 100644
> --- a/drivers/iio/inkern.c
> +++ b/drivers/iio/inkern.c
> @@ -598,6 +598,85 @@ int iio_read_channel_average_raw(struct iio_channel *chan, int *val)
>  }
>  EXPORT_SYMBOL_GPL(iio_read_channel_average_raw);
>  
> +static int iio_convert_processed_to_raw_unlocked(struct iio_channel *chan,
> +						 int processed, int *raw,
> +						 unsigned int scale)
> +{
> +	int scale_type, scale_val, scale_val2;
> +	int offset_type, offset_val, offset_val2;
> +	s64 tmp_num, tmp_den;
> +
> +	scale_type = iio_channel_read(chan, &scale_val, &scale_val2,
> +				      IIO_CHAN_INFO_SCALE);
> +	if (scale_type >= 0) {
> +		switch (scale_type) {
> +		case IIO_VAL_INT:
> +			tmp_num = processed;
> +			tmp_den = scale_val;
> +			break;
> +		case IIO_VAL_INT_PLUS_MICRO:
> +			tmp_num = (s64)processed * 1000000LL;
> +
> +			if (scale_val2 < 0) {
> +				tmp_den = (s64)scale_val * 1000000LL - (s64)scale_val2;
> +				tmp_den *= -1;
> +			} else {
> +				tmp_den = (s64)scale_val * 1000000LL + (s64)scale_val2;
> +			}
> +
> +			break;
> +		case IIO_VAL_INT_PLUS_NANO:
> +			tmp_num = (s64)processed * 1000000000LL;
> +
> +			if (scale_val2 < 0) {
> +				tmp_den = (s64)scale_val * 1000000000LL - (s64)scale_val2;
> +				tmp_den *= -1;
> +			} else {
> +				tmp_den = (s64)scale_val * 1000000000LL + (s64)scale_val2;
> +			}
> +
> +			break;
> +		case IIO_VAL_FRACTIONAL:
> +			tmp_num = (s64)processed * (s64)scale_val2;
> +			tmp_den = scale_val;
> +			break;
> +		case IIO_VAL_FRACTIONAL_LOG2:
> +			tmp_num = (s64)processed << scale_val2;
> +			tmp_den = scale_val;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +
> +		tmp_den *= scale;
> +
> +		*raw = div64_s64(tmp_num, tmp_den);
> +	}

It can be quite tricky to get all of these combinations right. I would
prefer if added some unit tests like we did in [1].

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?h=testing&id=c732e60ee10ed0611a59513cbf9c8d35fbe7cf65

> +
> +	offset_type = iio_channel_read(chan, &offset_val, &offset_val2,
> +				       IIO_CHAN_INFO_OFFSET);
> +	if (offset_type >= 0) {
> +		switch (offset_type) {
> +		case IIO_VAL_INT:
> +		case IIO_VAL_INT_PLUS_MICRO:
> +		case IIO_VAL_INT_PLUS_NANO:
> +			break;
> +		case IIO_VAL_FRACTIONAL:
> +			offset_val /= offset_val2;
> +			break;
> +		case IIO_VAL_FRACTIONAL_LOG2:
> +			offset_val >>= offset_val2;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +
> +		*raw -= offset_val;
> +	}
> +
> +	return 0;
> +}

