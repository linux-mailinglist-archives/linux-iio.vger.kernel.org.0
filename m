Return-Path: <linux-iio+bounces-20431-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E9B3AD57BE
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 15:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F78418841B1
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 13:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD382BDC38;
	Wed, 11 Jun 2025 13:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="jisvjjVS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57B52BD5B7
	for <linux-iio@vger.kernel.org>; Wed, 11 Jun 2025 13:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749650257; cv=none; b=nrPSqp/1MHzPplniZpGmSGCXoSlx6S62sylBUk0Di2r4J0ld6GJwY/8er5LHpZ4tJVzsq+yZ2evhZtB0uaP/r2JXOhBBUFcVY7++mn4EXUTrxJ/xobupDKhzXmfbJ8rzHU29KBoV8h6pc7DT0Rh4laMQnUFbv4DJnUcZZDS5iIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749650257; c=relaxed/simple;
	bh=nd64DLm4mhs4qa7Cw4rmwJkqLp8AQYl+cgtOwldnmD4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WGvRCXKM97uaGbs1KE+kE4r0VWjgKGEyprG9HCT/NBHzEBri7Q2GdBU4ERyPQiXSc8oCqvFYoRgMI2nPEKuvR84bHkBIDAONCVm6j0iMneWscW+h+nKvKK9YlDfzPq4h75e7Pk/NuXwE5vlALz1HSZ/t93R5so/0ztr2Lw2S4gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=jisvjjVS; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-4067106dd56so4382506b6e.3
        for <linux-iio@vger.kernel.org>; Wed, 11 Jun 2025 06:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749650254; x=1750255054; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Onw+F7Njzqx9qJlT9wI5+vJ8uzypmHxvVhvYZXMTUQc=;
        b=jisvjjVSMo6qU0hKqooo4xFc31Oxn/qrMatYVDoyD1Hlz/Mx81tChCJMdJtqh6+eu7
         WFDPicZtUYGKuRJ+HLRIiMLLoCu8+mxhOyHj2EEif5tZMWHXo3NFf8uuTIWl366+nP5j
         4Dg2IrNX+bFVtrTogNgEByk059T4xNAV8smCcD1idD5NF7PN2OIkNG2iQvgBChGia+hA
         cmXNoqrx7InvM8/WD1Qk+btPc4wBRIuJ/zheCgXbEkf2PE7IumT9X1LUVitKVnBnvdYr
         EI06lDApvbkvt1ZPcAJtDrHQ6/lykU6eSgbnBB3r2PewVAQnUQv5gpcTdJdQzbaUk+Xo
         vS/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749650254; x=1750255054;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Onw+F7Njzqx9qJlT9wI5+vJ8uzypmHxvVhvYZXMTUQc=;
        b=NV+cy9p+GV9y6FiTGHlMMW2KeFb3eRldqxBbrZolKI6mNjh5DihQliu/juyIgQfvty
         ZixNO42nLPYTO2NczWJsE90TsfoDNNZ2Pkh1L1rniIp9HHBbTV0XyWYzVQ9M09b11UgA
         vebiZTsdJGyucU3rOaLh3g5jDFywAs7PgeDeeL+G6bPmstTMV56gQvDDFtfLo4xI21wv
         FPeX6T0c1/4Pb8jBRgBJ1Bm9JrpvzlTphYR2RE9Yz411ymqRzyZYq5l8m8OdulawaGjD
         6YoVYj5koQgj2VXbKBozLPODXIV+BIgMLbyTwlX6ioorBA6g5jOc6hBnY+ONgDS5Hya2
         8Uyg==
X-Forwarded-Encrypted: i=1; AJvYcCVYYJOofnH7oCce76zrgIL/0NVNesi4VTu3xdpONpcfB6ochZ8KiYCrEdNZuufdMtpZRkg/q48nh00=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNVhcTkzou84QUkw3DXZqPrEu6DaWZqOIwPvpDoSs1quOpHVQT
	+3kWMIM4i31dJjMOSaMlEVsP4Ba6lVYP9g/VVzwfp/m51EKtoEAg0aEWEVEd897FoZE=
X-Gm-Gg: ASbGncsxqcCiEWXgFGfzRqIUQFEAQ4c780nM3Qftpw4wRV3IeUnwJ7xjimL/hvIKoVB
	s2DDA1LDRxRIGwXUbuFLNkAyFoCw3annKFcIoaX+WajutmpYzLC5nYhhruzyGTz6emmoKDLFqkw
	299BA+JC6QqT80bhgfnxvfMYgXk3ENYIcWm1r0mhao2QRa/5Rd9dbJ1rpqzkTD39alsNxxBzfWr
	KY1G/ecyIbUN0nnXcGdm45uuo81N//R4Z6mDOEjclTEFDwP8MdOup+xXFkEOqCtSs1dc2Lhhrby
	ovBVEGVb389LU5rnGcdputYFH/krC3cKKTIukkrAV2Cpyxa6lC+522NRhoKHyz43CRQrMXKqzai
	9mk09VwAE0k4JtzsWkCTm0OLaZuKJmo7QRIYq
X-Google-Smtp-Source: AGHT+IHHOJ7UPUjqfa7Ax2DODQaNiUV5DY9O1oiua1yOw8frXqBPksX3fFK+2Qk20HoobYMoNjVxXw==
X-Received: by 2002:a05:6808:21a4:b0:3f8:3eeb:11a3 with SMTP id 5614622812f47-40a5e0a6824mr1694522b6e.11.1749650253782;
        Wed, 11 Jun 2025 06:57:33 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:eb6c:30d1:632b:494? ([2600:8803:e7e4:1d00:eb6c:30d1:632b:494])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40a5d941cbesm333645b6e.24.2025.06.11.06.57.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jun 2025 06:57:32 -0700 (PDT)
Message-ID: <0ec0fd5e-8fbe-43c4-8aad-f36d2872f280@baylibre.com>
Date: Wed, 11 Jun 2025 08:57:30 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: Use dev_fwnode()
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, Jonathan Cameron <jic23@kernel.org>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, linux-iio@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
References: <20250611104348.192092-1-jirislaby@kernel.org>
 <20250611104348.192092-9-jirislaby@kernel.org>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250611104348.192092-9-jirislaby@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Subject should be "iio: adc: stm32-adc: Use dev_fwnode()"

On 6/11/25 5:43 AM, Jiri Slaby (SUSE) wrote:
> irq_domain_create_simple() takes fwnode as the first argument. It can be
> extracted from the struct device using dev_fwnode() helper instead of
> using of_node with of_fwnode_handle().
> 
> So use the dev_fwnode() helper.
> 

...

> @@ -421,10 +420,8 @@ static int stm32_adc_irq_probe(struct platform_device *pdev,
>  			return priv->irq[i];
>  	}
>  
> -	priv->domain = irq_domain_create_simple(of_fwnode_handle(np),
> -						STM32_ADC_MAX_ADCS, 0,
> -						&stm32_adc_domain_ops,
> -						priv);
> +	priv->domain = irq_domain_create_simple(dev_fwnode(&pdev->dev), STM32_ADC_MAX_ADCS, 0,
> +						&stm32_adc_domain_ops, priv);

In the IIO subsystem, we still usually wrap at 80 characters so
wouldn't want to unwrap the lines here.

>  	if (!priv->domain) {
>  		dev_err(&pdev->dev, "Failed to add irq domain\n");
>  		return -ENOMEM;


