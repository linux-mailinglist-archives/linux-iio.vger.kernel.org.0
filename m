Return-Path: <linux-iio+bounces-20041-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5844AC929C
	for <lists+linux-iio@lfdr.de>; Fri, 30 May 2025 17:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 882F21C08301
	for <lists+linux-iio@lfdr.de>; Fri, 30 May 2025 15:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE157233D8E;
	Fri, 30 May 2025 15:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="kaI9XafS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2E31E515
	for <linux-iio@vger.kernel.org>; Fri, 30 May 2025 15:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748619582; cv=none; b=EF5gveX7/BSkVpCoTqlJMLA6vkPQghzyI5dikl74n1d64VYquP442QayU7JZxRZ7yTpHfhus7OnzoX5gQ5aazvzXRAt4NH9u7CoOfFYHxi5UPaApDeCbd92eGlhCKvvp9K7gJaSV7k8weCpRcw726EuNMW/fVBGhMZ4M3IV+/nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748619582; c=relaxed/simple;
	bh=b7btFpwI/5wm+1ld40EI1n6LRFzHnxTFCCMCb981U+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E2GiwYiGhY1jn9bcoqQRie9BT3xnMC4b6oN2lFn7WHQip08isYJbi/R0FghP1yGV1TAMAUczWX/gBJ1C4h699chosz4zYpVCHvl2nWSY++PSqv2WqX7e6Ghh4UQV9OimKLPX7A9WJYGnxYtN4Sip5lIilya1InHLrgs5+ylFj0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=kaI9XafS; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-73044329768so1709928a34.3
        for <linux-iio@vger.kernel.org>; Fri, 30 May 2025 08:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1748619579; x=1749224379; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/u7rwzZrSAyNyyRlGLwaH/GU4L7iGPNEX79+p0QShAA=;
        b=kaI9XafSoEdalIm4caDGuC9wGxr12KZGxH4cx3VOl1aSFu5zAcJmOmGwMdEIG7P0gI
         8bgKPkT9JdEwe02Oxtwj0X01OEg1n8ER9+XvyLT7zOB6z1kpWAsoduIMjiGfJiGjr2KI
         ar3qAOCPqKlqlfLGAi30t7Plco952E2z1N0cGl6qZw8Eq2soVDdZTzJlgUWzcYBwUB84
         iqou0D3V5irn+MBLRZlNuCKdPH67i7m181GLYzVtj/ehu3GniBU4yDIPIRDBuy5rHmHi
         /aSxT0mdmHGgChNfL2y8sJVSb7B2p8FZYOTe5OraVlLkv8sBGjVE1IXtiuRLrIALmzeE
         9ZSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748619579; x=1749224379;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/u7rwzZrSAyNyyRlGLwaH/GU4L7iGPNEX79+p0QShAA=;
        b=Ara1CQ5a8nNI1NV75riunRT/xyXTsBQnyYO3hXyCjLk1bI63Ynr0mF7u3O7GjPBtsi
         jOpu5AkJSEnlKei1IGFjle5E/lvkA+WCdl+G6ELPcphNUKEXXRn4gGVWQhV1n/M4adF4
         J3+3mlK7W/12nY0ITxt4Go0Z+v37wK6IeyvJrq3YpJSGQAZTAQVLwzWUR5qrPVpqMtoE
         jwo1TWX6XIcNsAr3fuFwAQasBi+DVXapZzFZP6IG8WFp17GGBJc8gvTi+uNbncWk/Xax
         MoZLENeZwgEna1QXlXEQyqtygBokMkw1voeN++3RBIgIGquEHmCVYbEV8ZpjcME2diat
         bpsQ==
X-Gm-Message-State: AOJu0Yy8EZVi2CDdYBxmy/TSAvAkxFgF9yj3hE7uf2Jg6GmgApbumqyt
	tMptPA/kygw975HRPBFe8hMIIplbC0H+TRUrkwntTFrnCFUwxozGqnSTtaMv+49G6Rbs3LnHPDJ
	evMdZ
X-Gm-Gg: ASbGncukibcyINqy/kvk7cjSPXtYox7gW4AGIvBegHQygLsj1PBk+4mWYTL0ZzY9FmA
	5GasYMSBl1ZKPDzCHXFNjVMjKAd44Cg+koCF/vD3yNHVH52qTBRUF7KslICl27i9RRgJFcrHdmR
	Hft+GTfy3DLUqSNYlcgNXzoveNbE8hKlam1cHXe4wqRNBk7ZvtXyQjAUlUCwyexXjf9mYjUiU58
	89cAqOPzGEcTkxbqMRXvJnMdJ3gXmdj3M79PH3ChoeO7n68mhzwAXokv1bcPFbjHsaspglyLvMy
	2sRwqaNvzDJz9NjE9aS7F8puGUiY4RqscTTg241pQxH1j9FOPYjRzLKv6NEI2WQ2xWN79aR0nQw
	QYjbpEzrIXv6M1ko40q7lrXAk5PMLzbN4zudo73I=
X-Google-Smtp-Source: AGHT+IGG6DMBSGgPWCHIO7NgNhnGv4pO+yLYXB7qonCi9he/56OL0CJOqlpr62QtRv63Lv82VFI8iw==
X-Received: by 2002:a05:6830:2110:b0:72b:84ab:b1bc with SMTP id 46e09a7af769-736688ded63mr2273128a34.2.1748619568685;
        Fri, 30 May 2025 08:39:28 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:29cb:b1cd:c8f4:2777? ([2600:8803:e7e4:1d00:29cb:b1cd:c8f4:2777])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-735af9ef0d7sm621689a34.56.2025.05.30.08.39.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 May 2025 08:39:28 -0700 (PDT)
Message-ID: <73be8e49-3130-4dcd-9286-689ef55badd9@baylibre.com>
Date: Fri, 30 May 2025 10:39:27 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] iio: adc: ad7606: add enabling of optional Vrefin
 voltage
To: Angelo Dureghello <adureghello@baylibre.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250530-wip-bl-ad7606-reference-voltages-v2-0-d5e1ad7e6f14@baylibre.com>
 <20250530-wip-bl-ad7606-reference-voltages-v2-2-d5e1ad7e6f14@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250530-wip-bl-ad7606-reference-voltages-v2-2-d5e1ad7e6f14@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/30/25 9:27 AM, Angelo Dureghello wrote:
> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Add optional refin voltage enabling. The property "refin-supply" is
> already available and optional in the current fdt dt_schema.
> 
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---
>  drivers/iio/adc/ad7606.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
> index 3bbe9c05b5edbc11e8016c995c6ab64104836e7b..4fd9638eb6e56f800c7c97425e45e04f269e3df7 100644
> --- a/drivers/iio/adc/ad7606.c
> +++ b/drivers/iio/adc/ad7606.c
> @@ -1335,6 +1335,11 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
>  		return dev_err_probe(dev, ret,
>  				     "Failed to enable Vdrive supply\n");
>  
> +	ret = devm_regulator_get_enable_optional(dev, "refin");
> +	if (ret && ret != -ENODEV)
> +		return dev_err_probe(dev, ret,
> +				     "failed to enable REFIN voltage\n");

s/failed/Failed/
s/voltage/supply/

to be consistent with AVcc and Vdrive messages

> +
>  	st->chip_info = chip_info;
>  
>  	if (st->chip_info->oversampling_num) {
> 


