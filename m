Return-Path: <linux-iio+bounces-16719-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F67A5AC3F
	for <lists+linux-iio@lfdr.de>; Tue, 11 Mar 2025 00:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CED803A4DB9
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 23:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD9F1F872A;
	Mon, 10 Mar 2025 23:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="1emMtjie"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9741DE3A6
	for <linux-iio@vger.kernel.org>; Mon, 10 Mar 2025 23:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741648744; cv=none; b=iJuhl5Pan22np7uDTmrl4F48NQQ0ZUDPUrXmNuwARL0pbSxGObfscA2Vc1EMk/1/R4vMEd4d10pmlBjORLR39XlNjI0Ooc4m+Juihp/6u4fSvsj0pbCVAVYJqKaPyL2xL6dOKPWOrcoISiduESDTcX1zDepFZcdDDQRQrl9ClWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741648744; c=relaxed/simple;
	bh=KylpWFP2VRXYO9JrY/cUJWicPczkz3Ki1zh8opLnewQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EH2mx5XxN7zzTe4f+V+cH6DxUkJ6wxzPtwcz7CMz+xTye2OniDiJ5Xz8h0x16YXuNEflbeQElteP5pIC0kFm2YX4CpNksgMPdy3GnpAPrJ2WdqoCBXMiUh95Bc0m0urrE+pVJhtj2O65mjiuCEIjd47klEzw+Lc7xrC0tHE9IUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=1emMtjie; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-72a1c42c70dso1838385a34.1
        for <linux-iio@vger.kernel.org>; Mon, 10 Mar 2025 16:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741648741; x=1742253541; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6Wc/ggvqEKOPmdXPvq6UZci8yHY2OAsNen+0p8oXVNI=;
        b=1emMtjiec66uTZ4exHsrprXJ92qXO3mDYaw8HXBZV3qIciPGJifxFz47tz0LV2AIn+
         nNET24c69OeF+aOMrPrVXX0PJM3Zq4OJ8Uge+0QtyFRnHxCnn8tC6NHjsEd0D7n/Dj51
         9GhMzM7fKamDSHml5/zxGQns03CV4A6N5DvI5clGB9LYOF4UvGkNXmaRaJd7ImqAggF7
         ERyRknzkWR1f2hJ9cv3co872Orrhgo5VRVxaphh5iTNFz7VpjLATPQLJI4t+6JVyHpAS
         eDM/AfhpFBr82Ws+PLJVW3afXSGfL/LJmX9aBh92n0qFhk3Zaw0GKeF/nNWeBysD+Von
         ye4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741648741; x=1742253541;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6Wc/ggvqEKOPmdXPvq6UZci8yHY2OAsNen+0p8oXVNI=;
        b=gBiYb0AC/Hr1KBRC9ObK7lk0v/+PzLaKDY2idBwvccuAo5YictRy3xTE27/dRNIHpO
         Pkrd6huHHd+vBoZ4ZEIiRUkzxrzEm5GHhPjKX7feBZ2yaYZUkqxih4ga8E15+bW1/z3r
         hvPG88RCEKrGjGwplgGBa+B3WCAqng+yyTBRojrsawHK4OBPuIs/+Z6MYb5id7iRp60a
         ZbRUCPXMcXT9+sBx2TuY77CH1NYIRbHz8OELvFis67aX5AAivL5C14KoiuT7+bpoxYtA
         Ey6Mqe9cLrwu+/w1zMRMcxgG7ctYj/a5zzECw5OCh6Nb64MdkUYwD1rdTtQZYHFiyQ7t
         MXzA==
X-Forwarded-Encrypted: i=1; AJvYcCXZs/bq2EyRBbQev9bhSn6psBZrsfg6jLca2G0iQP69uhn//izlLklDjbjmj71AyNTKQgqa1JpVeP4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxdp1zgdycZ8utjL8Cv3tQHHRpM3nhN4Yx0BQ5O+I/Gi/EbikPE
	gZz3GMeZxzPM5h5vBYW80X3lyNWimtlfGdgN3yVb68dbDAGcqUDPid1KNdmDq34=
X-Gm-Gg: ASbGncunonKQgitXeHL1qwH+sFsDK2ZpwEg1AcqvFKar+S57ZkwgztTNlbcOTn0Xe6T
	U8usWmLr6v3egGt2kuKjf4HdHORXuxE0P6Ogw2oS5uIrnr1O+62Q91HemfaEGJ51D4U3Jbnaj/4
	9IHe9+NLuXbNe+7nBhL4biWhE3l8SdIv5H0UCU97rrZfbltKBkc+ACjg21dCSxs3SCMRMw5CzpH
	Aigl+RbJW3K/yW8hGH+6Bcjg2RA6oJb/lc5Ny6lPuIjzQfvE9eXPcn8kLBKJ9Syfty8NrWsIoLR
	dYa0zbThxSXBeZQVRPHYX6bnOFGdko1XhQuPz8oWfzRfekJbzX+PkvLYO6ScHEtnA/aRsPT2s2y
	dDRg82Q==
X-Google-Smtp-Source: AGHT+IEEB61ToJ4MHc5KCkjL2xlGM5A1Q7UGeZui7hmub/GLLV6lZuk1GojzDTRHeoFXijzH8iWsxw==
X-Received: by 2002:a9d:3e0e:0:b0:727:2731:d5e5 with SMTP id 46e09a7af769-72b9b75cfc3mr925868a34.12.1741648740708;
        Mon, 10 Mar 2025 16:19:00 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2c248831c04sm2363675fac.8.2025.03.10.16.18.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 16:18:59 -0700 (PDT)
Message-ID: <9cd23b18-f1a9-4222-aa6a-e1453f4bad88@baylibre.com>
Date: Mon, 10 Mar 2025 18:18:57 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] iio: adc: ti-ads1015: Use guard(mutex) and factor
 out code for INFO_RAW
To: Jonathan Cameron <jic23@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Marek Vasut <marek.vasut+renesas@gmail.com>, linux-iio@vger.kernel.org,
 =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>
Cc: Marek Vasut <marex@denx.de>, Mike Looijmans <mike.looijmans@topic.nl>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250309165819.1346684-1-jic23@kernel.org>
 <20250309165819.1346684-6-jic23@kernel.org>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250309165819.1346684-6-jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/9/25 11:58 AM, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> By use of automatic lock release and introducing a new utility
> function to handle the core activity of reading the ADC channel,
> many more complex code flows can be replaced by direct returns.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Marek Vasut <marex@denx.de>
> ---

...

>  static int ads1015_read_event_config(struct iio_dev *indio_dev,
> @@ -710,25 +686,19 @@ static int ads1015_read_event_config(struct iio_dev *indio_dev,
>  	enum iio_event_direction dir)
>  {
>  	struct ads1015_data *data = iio_priv(indio_dev);
> -	int ret = 0;
>  
> -	mutex_lock(&data->lock);
> -	if (data->event_channel == chan->address) {
> -		switch (dir) {
> -		case IIO_EV_DIR_RISING:
> -			ret = 1;
> -			break;
> -		case IIO_EV_DIR_EITHER:
> -			ret = (data->comp_mode == ADS1015_CFG_COMP_MODE_WINDOW);
> -			break;
> -		default:
> -			ret = -EINVAL;
> -			break;
> -		}
> -	}
> -	mutex_unlock(&data->lock);
> +	guard(mutex)(&data->lock);
> +	if (data->event_channel != chan->address)
> +		return -EBUSY;

The old code returned 0 in this case instead of -EBUSY, so this seems like an
unrelated or unintentional change.

>  
> -	return ret;
> +	switch (dir) {
> +	case IIO_EV_DIR_RISING:
> +		return 1;
> +	case IIO_EV_DIR_EITHER:
> +		return (data->comp_mode == ADS1015_CFG_COMP_MODE_WINDOW);
> +	default:
> +		return -EINVAL;
> +	}
>  }
>  

