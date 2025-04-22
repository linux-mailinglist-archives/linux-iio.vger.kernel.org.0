Return-Path: <linux-iio+bounces-18484-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C85A95E57
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 08:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF22E1894860
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 06:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5509122D4C0;
	Tue, 22 Apr 2025 06:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jQin1pY+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295E52367AD
	for <linux-iio@vger.kernel.org>; Tue, 22 Apr 2025 06:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745303794; cv=none; b=A/r02wwWHuAyXIWH9GZD2KURpWG1DqsWkoBB2WZR9DihzEoxQYOSGJLuBer+sJ4qxYcCHw2+HYc6BKIlPgwCIdfOZDiuhtANwUYspxOiHUlall0i6AL7YJ8VKzEUT2RgIgtrA3PbucGwlgQ+WX5KeE62lfFuHg6LY7zc4v+pQ0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745303794; c=relaxed/simple;
	bh=GiP/jlLbMozxOxUvrEms2VWQOoLHWMI7XjFly4V6b/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y6qXDjJ2YuVlQNoiAz7lKJg97GxhW9kJcEOXMAlCHFi9/8NeaCdcWx6X7fMK1YSDpAllYB4ixcKrn2JZn5TJfrucPUZGhHkz50SCn8Mqnb5Q808FnwEyff2EI94k9BA/VBHA0IrPnGJtf9oW/9kAjL2ksKOoJa89PcBxB9i223w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jQin1pY+; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43cfe63c592so54517685e9.2
        for <linux-iio@vger.kernel.org>; Mon, 21 Apr 2025 23:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745303789; x=1745908589; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MuuIFzXKAKOtJ/juljvbLrxvScq2q/lihuCqoG9qgYs=;
        b=jQin1pY+RUBpSOckThD/4Cxz17cwvJAHyvhaJy9LpLFMygyd1RjiIxiEno4Uzt7vEg
         lCVW07f/Gyyy6bF5jaZb/rUOaOjXyicvKOET8Fh4ijj2XAn7gOwuYG8Q3u8uDcPGEkJI
         IC6g67UrvSEEeSFYMq/8caHqaZMNYd3BVhBGYQrLXRByZ9WqJRob03fmdc2dhPG0KbrB
         Kw34xmN0Od09X7XIYDGQ1FqmerXoe6+my4otXymdPHxRtAAOMjnN5XFFevzq4kevMAB+
         DKkGUrUPJA501VFyTrui8MqO3Ir4eQpo7l1TUeKrHCNP8QCLJMmVZJ1Dj/Y4cgB61BCO
         BWyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745303789; x=1745908589;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MuuIFzXKAKOtJ/juljvbLrxvScq2q/lihuCqoG9qgYs=;
        b=Urh1jb1uSqB4coSnlftU6VzOBKdj96KORwcTyP7stieJQA81fp753wOKPQRzqNnCop
         LuWWRS9zcAFq/v/Q4C3sOTtBiRjAA9Gs1Vbyt7rM+U+VP+IVeVVDQkBsICww9tjq4e7J
         cQFza/DZgVuIIFNlkLr2o8uK/LAUCK2u9i4teE+By99c6hkFw+AkMKJ/YUEIH1XVwaXY
         DAAeDfP7+vjnJOdHtlllL5SVJdI22qm2ELbm/aI7kpab2O2EHcPSKt4VJ9IFmfCWDMEl
         Obzc6FcytsPCRmyudv2DMtR86mq+69w1XB5LqXNZfTBxVjEN/BzD7b7EeHmBrACxNYkn
         s9wA==
X-Forwarded-Encrypted: i=1; AJvYcCX5HBs035MhQhJXqnXimbIrj7K/N2kOI7bBCNDD2bMs9CMVSu6xWBqNKhy160AvX7fQ1MnDutSyD0E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXwP1VUtbh7GVVpgKxWcF0jGUzylX1R6tlF2oLwuFJqLOCWRDz
	UjE8euLPzuG0wz4s3zjhs3UM9vnftBV7/YRaTihzc/x0HYO227PzE/dF5umuv/U=
X-Gm-Gg: ASbGncvM4wkXdiyWpUUJ7eUqO9WBoOjR1JIl7TaJDf8v5lDlxd4JpwbbMut2RlxDHCJ
	UaW+S4qh0Xp953nXD+HIDSzsmIIMgBSjmJvrx2/ZO3ciMGmiyM32o51bNI2VJyFdQYoY4jqL4v9
	JiRQ4cIWZq36KCYlyl8CCLh5VDG0LBdWBB1ymIkm1yL89Qy/ka0QmYkG8cdm5HOYGhjYEc0biAz
	YbHBsP2Hup6AfkrNwGMTHRmaoCBPUngTdOpF7UFdp6lNWFybbIFmuv9C5KtBUh0zAoTVWKLJJXT
	6ff8MofalMHP008yHXptxzwa2Dhlfe1zjgkkBQ+B4FVYVw==
X-Google-Smtp-Source: AGHT+IG58ERkjB/D7cQnQR9ULR7mf0eJW0CrGoysFAmK0fVh9EIq2V04mHgq1He3cbNy5XZ0uVNl7A==
X-Received: by 2002:a05:600c:1c12:b0:43e:ee80:c233 with SMTP id 5b1f17b1804b1-4406ac20146mr111342455e9.32.1745303789459;
        Mon, 21 Apr 2025 23:36:29 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-39efa433133sm13898825f8f.28.2025.04.21.23.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 23:36:29 -0700 (PDT)
Date: Tue, 22 Apr 2025 09:36:25 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Gabriel Shahrouzi <gshahrouzi@gmail.com>
Cc: gregkh@linuxfoundation.org, jic23@kernel.org, lars@metafoo.de,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev, Michael.Hennerich@analog.com,
	sonic.zhang@analog.com, vapier@gentoo.org,
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH 3/5] staging: iio: adc: ad7816: Introduce chip_info and
 use pointer matching
Message-ID: <b17dc4de-9fd2-410e-8c5e-f27e550d3eca@stanley.mountain>
References: <20250419135638.810070-1-gshahrouzi@gmail.com>
 <20250419135638.810070-4-gshahrouzi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250419135638.810070-4-gshahrouzi@gmail.com>

On Sat, Apr 19, 2025 at 09:56:36AM -0400, Gabriel Shahrouzi wrote:
> @@ -84,7 +98,7 @@ static int ad7816_spi_read(struct ad7816_state *chip, u16 *data)
>  		gpiod_set_value(chip->convert_pin, 1);
>  	}
>  
> -	if (chip->id == ID_AD7816 || chip->id == ID_AD7817) {
> +	if (chip->chip_info == &ad7816_info_ad7816 || chip->chip_info == &ad7817_info_ad7817) {
>  		while (gpiod_get_value(chip->busy_pin))
>  			cpu_relax();
>  	}
> @@ -353,6 +367,7 @@ static int ad7816_probe(struct spi_device *spi_dev)
>  {
>  	struct ad7816_state *chip;
>  	struct iio_dev *indio_dev;
> +	const struct ad7816_chip_info *info;
>  	int i, ret;
>  
>  	indio_dev = devm_iio_device_alloc(&spi_dev->dev, sizeof(*chip));
> @@ -362,11 +377,15 @@ static int ad7816_probe(struct spi_device *spi_dev)
>  	/* this is only used for device removal purposes */
>  	dev_set_drvdata(&spi_dev->dev, indio_dev);
>  
> +	info = device_get_match_data(&spi_dev->dev);
> +	if (!info)
> +		return -ENODEV;
> +	chip->chip_info = info;
> +
>  	chip->spi_dev = spi_dev;
>  	for (i = 0; i <= AD7816_CS_MAX; i++)
>  		chip->oti_data[i] = 203;
>  
> -	chip->id = spi_get_device_id(spi_dev)->driver_data;

Delete the struct ad7816_state ->id member since you are no longer setting
or using it.

Btw, this patch didn't apply for me on linux-next.

regards,
dan carpenter


