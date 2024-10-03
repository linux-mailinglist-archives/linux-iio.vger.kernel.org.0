Return-Path: <linux-iio+bounces-10083-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7DD98F6FF
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 21:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 083E11C22174
	for <lists+linux-iio@lfdr.de>; Thu,  3 Oct 2024 19:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77E21A4F23;
	Thu,  3 Oct 2024 19:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nB0kQGT7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37BE768FC;
	Thu,  3 Oct 2024 19:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727983833; cv=none; b=qLbpSGHkEvGmm6cuSwF/f2YPfsNnQEtAIbopm0iXEt1dxADGw7MQck4ej4y5n9tr8KXVYbyTZdjITgJfJ9USqvN6dTOSU55PaJLEJ7HJqLEi7A0Lg87Co1r8i0nCfrG5zsOaerOjQ1vXPnrF65cdF9z4HTgBoszA6a3fccTQLfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727983833; c=relaxed/simple;
	bh=PmJ6zGhkvFaTz5q5lMmydyxb6LzW4tdal8FbkNDVbA0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=njBcn7u21Tb+9JmkWD11DPY7VmgcyGmT4P5xFe5YP9xSgI0LBjxZvpW/rcSNRm71utw4CluhL5nmdNy+MGdZO4ebtDW1m9nuoeJFsFURBOi0oaHMR7EKTtcJsxiY5jwkt6REcXuKah4wMvJQ1aqhybztKVrr7IcWpQ0rrIRLrxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nB0kQGT7; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-37cc4e718ecso1015358f8f.0;
        Thu, 03 Oct 2024 12:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727983829; x=1728588629; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cCU07AaMjlnjlQCPIhEhCPkLG6scsj2sB2fiNSzLiu0=;
        b=nB0kQGT7D9ITTngqF9fE6l5Afu3A4PqDorqaGhWUHZ7n+OH7lJvZGAk7EjaEM0xZLO
         rNtgxNZPinx7qf76BL9DgHLKYV7wTF3V/RIkn9iMNd6a+kiq8j8ewnc+40fgN5sUVDPn
         Y6txoRyXsrnvxJFY9h+d6rdmLEylZAMRNfzlCwve7YLAKBNPYjXnPU89BJEH2caTwA84
         iCzWTNRh9oXrwh6hY3OKD59rm73/J9v/uWJIk6R8euh8xwM14Ywq5lMOEVDvXR508J4m
         v4GpJ6vhotUl9yR738zGmFX0zfnxu/i6rFNUFt5AXl/Xa40v7WAvnFJ5jmi8Z9wWm0vh
         1Kbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727983829; x=1728588629;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cCU07AaMjlnjlQCPIhEhCPkLG6scsj2sB2fiNSzLiu0=;
        b=phRFuN8zD8abX0FRAKQeB0GPoDLFSu+F3HSEI/mZfDm2Wl5JKDkel2QHo2DwuOgFZu
         0hmrzYGUMGwqYvmWPeA3mJubiwrMz4FKTZYfLSR0YZbsSlaWgOCg/+t65urm8uEK/ml2
         driiLk9k7dPJ8EaOjLK0yckFeiJUlNau2KGyN5yXtCeKHJ9l3XVtb028tj4TxIAdorUB
         GB4rhkons3WaWh9z8mkZ73VocxPFmG6lGTiW1DjgMQwPmQSSev/Qhcb+vHscyZ2zHAoj
         /VFD2qRQiNDDzlSj2rgihA/0G+O6CU2jKp9ex8XI02TPhWcjLvqaHvEWmM9eHCXn54bL
         M+/g==
X-Forwarded-Encrypted: i=1; AJvYcCVvAMiUab5PcwBEauJvju5YJPdupQZJtsNx3lUcu4+90EcJCxfbp8Gbf1SiNtJfIok6zZlCzCST0yILkaAY@vger.kernel.org, AJvYcCWnulZ49tliTqf8F8VrrWJ2jAm3O1YmeN1m7VUB2PdgmSpU+Gy+bqbCn6+qTIh8lWtYEE5gohrgRQg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq6neAi/I2GkvhrAt4XdhIFkO2xKUVXA0KfRdNCaHWj0AhSMT8
	jpZG+qzChpJuwDCWyzIZ8dvr3nlI+MwAe0mXmMiFPzC0WN0DYKGF
X-Google-Smtp-Source: AGHT+IGvHiaqXhsr+pW+6q8UHgvRaKN1zmiSJbJ4Od2ZiDN/3SJoReU6RkmtoJ02z8eIDgfD/+WTSg==
X-Received: by 2002:a5d:5306:0:b0:378:fe6e:50ef with SMTP id ffacd0b85a97d-37d0e6f6469mr304949f8f.5.1727983829104;
        Thu, 03 Oct 2024 12:30:29 -0700 (PDT)
Received: from ?IPV6:2a02:8389:41cf:e200:3ec5:11f2:e453:20e3? (2a02-8389-41cf-e200-3ec5-11f2-e453-20e3.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:3ec5:11f2:e453:20e3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d082a6a2esm1848568f8f.66.2024.10.03.12.30.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 12:30:28 -0700 (PDT)
Message-ID: <b54239aa-9573-41e1-86f1-b38611443c46@gmail.com>
Date: Thu, 3 Oct 2024 21:30:26 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] iio: frequency: admv4420: add missing select
 REMAP_SPI in Kconfig
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, David Lechner <dlechner@baylibre.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Cristian Pop <cristian.pop@analog.com>,
 Mircea Caprioru <mircea.caprioru@analog.com>,
 Alexandru Tachici <alexandru.tachici@analog.com>,
 Marcus Folkesson <marcus.folkesson@gmail.com>,
 Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241003-ad2s1210-select-v1-0-4019453f8c33@gmail.com>
 <20241003-ad2s1210-select-v1-4-4019453f8c33@gmail.com>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <20241003-ad2s1210-select-v1-4-4019453f8c33@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/10/2024 18:49, Javier Carrasco wrote:
> This driver makes use of regmap_spi, but does not select the required
> module.
> Add the missing 'select REGMAP_SPI'.
> 
> Fixes: b59c04155901 ("iio: frequency: admv4420.c: Add support for ADMV4420")
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>  drivers/iio/frequency/Kconfig | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/frequency/Kconfig b/drivers/iio/frequency/Kconfig
> index 89ae09db5ca5..b90e1ac4b342 100644
> --- a/drivers/iio/frequency/Kconfig
> +++ b/drivers/iio/frequency/Kconfig
> @@ -92,14 +92,15 @@ config ADMV1014
>  	  module will be called admv1014.
>  
>  config ADMV4420
> -       tristate "Analog Devices ADMV4420 K Band Downconverter"
> -       depends on SPI
> -       help
> -         Say yes here to build support for Analog Devices K Band
> -         Downconverter with integrated Fractional-N PLL and VCO.
> -
> -         To compile this driver as a module, choose M here: the
> -         module will be called admv4420.
> +	tristate "Analog Devices ADMV4420 K Band Downconverter"
> +	depends on SPI
> +	select REGMAP_SPI
> +	help
> +	  Say yes here to build support for Analog Devices K Band
> +	  Downconverter with integrated Fractional-N PLL and VCO.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called admv4420.
>  
>  config ADRF6780
>          tristate "Analog Devices ADRF6780 Microwave Upconverter"
> 

Note that I formatted the entry to use tabs instead of spaces, although
I forgot to add it to the commit message.

Best regards,
Javier Carrasco

