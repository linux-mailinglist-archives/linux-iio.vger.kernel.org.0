Return-Path: <linux-iio+bounces-18486-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3584AA95E7B
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 08:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95F9F3AE98C
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 06:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1B322B8D2;
	Tue, 22 Apr 2025 06:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mIZB4NhY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C159122ACEE
	for <linux-iio@vger.kernel.org>; Tue, 22 Apr 2025 06:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745304091; cv=none; b=UIEbxW4Hf4QjAtTihwx2rrbHCjYfgQ8/M+sgT7OHqXxwHjHstky/3T1zeuVQ4W+VYFjUuwVysTa5gTH9BsFp6cUn/+8HHZHFZ31eWQpQYEDn1iR4r2VHoPkTwY5VjGQ5ewgwKSxXjLmMmIZrL0VB1uDkrJTXqfHQ4StzT9CQEr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745304091; c=relaxed/simple;
	bh=b+b5f49WuUM/GVoPNhs0qQ519kURG3dfG9PkIjCLyIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CsNPFI/vAKFumiFNfR1d9Drc4AJe2L3Av6lkwJgaW4CsRdhHfX8XIQrBFAQlAK+QZ3iQbcx+nDMOJqacu40FTwSX1WA2eT2SSUkJs/6vD4wpgr5qgfZSvZe0B/mIEC7sN4xabubVWkJxCeWhYK6MR/Gtw0ffZM4jZcKqhgAYreI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mIZB4NhY; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-39c1ef4acf2so2845307f8f.0
        for <linux-iio@vger.kernel.org>; Mon, 21 Apr 2025 23:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745304087; x=1745908887; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/pURcEhBEHdxpYhnWEBaI44DGcypxp9nMdkY7Iw/QyY=;
        b=mIZB4NhY2Em5fUD+AIIZaDIGXx3gP4tfN6A2+ln32O7AP39GEajZhAZrgE8y4l5Jst
         hOfXTbXTyb++vmLLReUyPXoyXbEPbbQUlt3EIEzswb9r30MhOr2ctBOA1e9TeGFNhluJ
         2is9+ydhd5p24+helWXoHQ8sOGeslEsckXz9svyHfSDEgUxh9cfNwk+2M+jMIpxj44U9
         7yKeHsSPOwDeCRp2nUv2GcvSoLIr3GjPOtcBfgsHXDKlSFKOfJXicfCRN/Yck1w14mbp
         ceE4rulaZiJhIMa41Fph4vY0HqWvsrAZHxPxqI69KRqJLVXaLoK6GcRTnm+vmbXaPAuq
         wymQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745304087; x=1745908887;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/pURcEhBEHdxpYhnWEBaI44DGcypxp9nMdkY7Iw/QyY=;
        b=q3yI9NqgYJI0IxkK9zDPmLbq+oqdQ8y+8O1xNHJ29sJGmK4fk6imy5CBtr9lpr0soE
         NL3g8Pv0O5WUy04k92ypr6MU0WK4qbJVj1OjXx51wd/lGgDqYKNoCLXEk29qKIWJdoIi
         scjIiZF0QfAj94PFUZzbhIhpZtVKO2QAgw3cFI+RWIwLmcxvppZJLYBt/2BMZ5r3a3bc
         mYjB9eUDZ4j1VDgpI3offNdeD54JYdbDZFCcKofit9UF+D1zl12T2iISoxzpRk91GIoB
         RgBVNbZM63TwygSs3XxngP5h40P9tp8HfXI2rsDbAVEf3NVlWnNlSqx98FaqJIMOrklw
         1VZw==
X-Forwarded-Encrypted: i=1; AJvYcCULw9fXCIxO5XAVEQcC4ayS5/KhPePJrEivBYKPaD95ZHcwEO09pGZF/ADmEpo+1qCpN60W2DGfGwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YysA6witYRmIJbArLAhtd56dlUCThs0GJxbRQzgbakUTTJsNgvg
	OWS6egN3qj6MX9LQW5S9ZYJXpWgiWn/H9nKbz6GNGPyUX+fGgrTsS3K7sKe7GS65eQqP+Ksh9Qa
	J
X-Gm-Gg: ASbGnctV1CdgoyZZZUL5yeCQq+BrzAQTo+aYY5ey7eKOjMSJPAJBW2emA/pMLlARrg9
	tfVo9LNMI5wgO1aXsHqtbbBDG8S0SuFKUOkxt+bVS6sT55y+2w1c5eEygH5Q0EAtmTN3P4A7qbW
	GMWXBPA2gfRvXHsZF49PDPGZ2ycrf3pK3rCbhGTJNYYbxto2gQKR6sbKH4CucH4KuHheNaWzAKk
	/oH20efRvPHWkVLWwDB8RWfzfvekIMDDCZmf2qFTococd+2ZR/CZnQ5kDT+mYQSi0zZgI8SZ7If
	y6k/my6aIN6Xop3c+/0M297zkfJMS8fO5avNSsgmResHUA==
X-Google-Smtp-Source: AGHT+IGY+z1SYzbAwHQ1bDwluBsR27wnP/M2SunDoCiRoLo03vSfRP0XeHzwdWtlYLn2l6uyLgUtbw==
X-Received: by 2002:a5d:584e:0:b0:39c:2264:43ea with SMTP id ffacd0b85a97d-39efba2a69bmr11843060f8f.3.1745304086981;
        Mon, 21 Apr 2025 23:41:26 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4406d5bbc13sm159163195e9.17.2025.04.21.23.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 23:41:26 -0700 (PDT)
Date: Tue, 22 Apr 2025 09:41:23 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Gabriel Shahrouzi <gshahrouzi@gmail.com>
Cc: gregkh@linuxfoundation.org, jic23@kernel.org, lars@metafoo.de,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev, Michael.Hennerich@analog.com,
	sonic.zhang@analog.com, vapier@gentoo.org,
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH 4/5] staging: iio: adc: ad7816: Use chip_info for device
 capabilities
Message-ID: <0145edf4-aef9-45c2-9a74-8c15abb1286c@stanley.mountain>
References: <20250419135638.810070-1-gshahrouzi@gmail.com>
 <20250419135638.810070-5-gshahrouzi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250419135638.810070-5-gshahrouzi@gmail.com>

On Sat, Apr 19, 2025 at 09:56:37AM -0400, Gabriel Shahrouzi wrote:
> Move device-specific capability information, like the presence of a
> BUSY pin, into the ad7816_chip_info structure.
> 
> Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
> ---
>  drivers/staging/iio/adc/ad7816.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
> index 39310ade770d0..ab7520a8a3da9 100644
> --- a/drivers/staging/iio/adc/ad7816.c
> +++ b/drivers/staging/iio/adc/ad7816.c
> @@ -44,21 +44,25 @@
>  struct ad7816_chip_info {
>  	const char *name;
>  	u8 max_channels;
> +	bool has_busy_pin;
>  };
>  
>  static const struct ad7816_chip_info ad7816_info_ad7816 = {
>  	.name = "ad7816",
>  	.max_channels = 0,
> +	.has_busy_pin = true,
>  };
>  
>  static const struct ad7816_chip_info ad7817_info_ad7817 = {
>  	.name = "ad7817",
>  	.max_channels = 3,
> +	.has_busy_pin = true,
>  };
>  
>  static const struct ad7816_chip_info ad7818_info_ad7818 = {
>  	.name = "ad7818",
>  	.max_channels = 1,
> +	.has_busy_pin = false,
>  };
>  
>  struct ad7816_state {
> @@ -98,7 +102,7 @@ static int ad7816_spi_read(struct ad7816_state *chip, u16 *data)
>  		gpiod_set_value(chip->convert_pin, 1);
>  	}
>  
> -	if (chip->chip_info == &ad7816_info_ad7816 || chip->chip_info == &ad7817_info_ad7817) {
> +	if (chip->chip_info->has_busy_pin) {
>  		while (gpiod_get_value(chip->busy_pin))
>  			cpu_relax();
>  	}

Here we could just check if (chip->busy_pin)...  The place you really need
to change is ad7816_probe().

regards,
dan carpenter


