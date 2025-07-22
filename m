Return-Path: <linux-iio+bounces-21859-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E3CB0D543
	for <lists+linux-iio@lfdr.de>; Tue, 22 Jul 2025 11:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A6EC54154E
	for <lists+linux-iio@lfdr.de>; Tue, 22 Jul 2025 09:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646552DAFBD;
	Tue, 22 Jul 2025 09:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TUdIezxJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB4D2D9EE2;
	Tue, 22 Jul 2025 09:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753175203; cv=none; b=BoA8LvrzZHeVpSPcJDHfEbqjwyH3161iEVvlsOybTLX2SKEtT2sQKa4tUHWsI4xnpgZ5EcrN9/VaWpjOWRkYwUJr65qKxQfMmJLgUcEUqHwNz/tCyE7zxKe8gDJq3fuAOdmqW57nx2TBJP+SK9/cB2BhftXVwV7m6vRCoRDWijU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753175203; c=relaxed/simple;
	bh=nbkKH1Pbvai9HJCbbynLZ1Yp+mKjDYkrFsNRIbVc9IU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cyQtAM9IqW7LiFqHisoQDurFqHrGvBdW+WGEBolvvkvEWecxNhpzAIECVOFtoB0dpwjSyPbjPqPRhLOCoaPuoDhxPL4Do6fN/rQrdb4EyLTv9qyAr2qN9Nlubq6Htc0enbuhmnL8N+dFqmmBg+YbjTGZup36gaUI/2PcipqOA0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TUdIezxJ; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a548a73ff2so4880783f8f.0;
        Tue, 22 Jul 2025 02:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753175200; x=1753780000; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GFpwy5H33Tzvu61L7YI6i7+VtAtWAjgn/MPjQgevbpE=;
        b=TUdIezxJCFK1/zjiThf+qEprVUs8jZmGGj0+S84KQyAmO0hoQLOL3SVbcY9Ja8xIRY
         XoJmPGK9NCT1CwaKd1lAb2gjr8FbNb+UPly8OKy+f6JHCOLrIBS8dKJfoLvNmBcWe2OH
         wWCsyW2rIYF5UO/ZOGDqydriUCERMiV+SndC41PuFGZNh2OCQd04j2TRjDawiV/lCpOf
         BmM0PEOERV4WTa6kaY7ebPIDQJ99crbjGb4Tj4qbOdp2Dn4BMSs7pR2FW2iNufuRukgi
         cDKNpbQb0NUXVz36u8hDOW64CNdtKasPe0Qh99CcxmyGZbYpejpXHHW6L+XVf9cqqIxg
         ZzxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753175200; x=1753780000;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GFpwy5H33Tzvu61L7YI6i7+VtAtWAjgn/MPjQgevbpE=;
        b=kVBp+ZWR+iTz72FZKMul4eE4pGhusfW1KeCnqVFm4mOVeRxGNwmqNZUA0n1qSzxVgS
         gopo9SXSqFqvHf7W+qH6Cx253nN2RrxpDehijVEks315mEjpnAkheDoVYpEhK/6mGsfE
         jaiWcMwKG2XR6P+HdHPqHGp0DYYTyb19A4F9XpJbJ2ZxPZ/5W79TVyeT9f1X6t3M/JUa
         jb8SFwAP9BYRwLEcSXc82uRI6PScck+O4fsngtYXSRSvyb0Xn+L9gVt7aharXge/BOEu
         gimfEEgEaeT7qIGgQ5PbKt8aL4rfNhoSe1CBtkGKMrVSnSr8LUpWPKMrq6umMg07peNx
         p8Kg==
X-Forwarded-Encrypted: i=1; AJvYcCXUtDFUBPwKTprcwxx44tMQRn9EIXWAuPLDZHiM9zC0ZCGA21VO4rdGuXc0/JaEsO3ouLcPXv/3Lwv1QTpG@vger.kernel.org, AJvYcCXsetEqLL+O54JZ6DsFkfx3zmMLEOA4feAG4W3dGdFVLNwWFlOHZluVd/0GSC+VbcX0IlB44dFBbVs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2esIxa1nP1ALbkRIRM8nOpHKHoz6qugVq8L27/Dd7sWI5NwaD
	uav6LS4ZHsuXAOFcM1gCO44yHXIu9TiVIbS7M0F131vp90b5sZllYtNK
X-Gm-Gg: ASbGncv6iEYRTODRSaGuGvBC6jvTSVhC4oBKAJL6MIJ8GTgCPEHeQVuJPa6sUG+s8oa
	8/oQ1PgWjlwpP3Q5exajlRRKaXxKQlOTrcjUNIaKrYf4kX+cZHEgHAA7OOi47ZROSEhMIgHVgNY
	A49mb7WbUnOCPP1UrmM0iBSy4GioMTNosB9xb8tmsR7cVe38MkRqi5QTgK3UJOTNrp0oJQcInnV
	3Sr4yftiwpt88DWR9k+Bu6m401IDELfrlSBXqp2rQ+f0wnGqztFE+R1uXZ2WOqNILJ3nkFAV7Jl
	xcftmYiCivhIyZ82+oJkhlafWoOxfZDAaxmCYhpeGiUMFbp5AIIZY6/dVg3BUFm3AJmS3n+qWa8
	jDb0QVfz3Gg==
X-Google-Smtp-Source: AGHT+IEzelAkvqDER0Ioj8uKwn4FZxi+cg8R9FAVJ+HPhYzwrJP4COi9PSMrTcmT9XGTwGuBd2G6dQ==
X-Received: by 2002:a05:6000:1449:b0:3a5:2fae:1348 with SMTP id ffacd0b85a97d-3b60dd886cdmr23610079f8f.51.1753175199553;
        Tue, 22 Jul 2025 02:06:39 -0700 (PDT)
Received: from nsa ([89.40.212.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca31394sm12908644f8f.37.2025.07.22.02.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 02:06:38 -0700 (PDT)
Date: Tue, 22 Jul 2025 10:06:51 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: ti-adc081c: use individual model structures
 instead of array
Message-ID: <asemsswsa6e5tgpryfkfyuwkzewzzulcinaxx6kqhrhbvrih46@ykicfbep6n6v>
References: <20250721-iio-const-data-11-v2-1-c3fec12511ee@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250721-iio-const-data-11-v2-1-c3fec12511ee@baylibre.com>

On Mon, Jul 21, 2025 at 05:12:47PM -0500, David Lechner wrote:
> Change the ti-adc081c driver to use individual model structures instead
> of an array. This reduces the verbosity of the code. Also, the data is
> now const as it should have been in the first place. The ADCxx1C_MODEL()
> macro is dropped to be consistent with similar model definitions in
> other drivers.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> Changes in v2:
> - Drop use of ADCxx1C_MODEL() macro.
> - Link to v1: https://lore.kernel.org/r/20250628-iio-const-data-11-v1-1-268189459192@baylibre.com
> ---

Reviewed-by: Nuno Sá <nuno.sa@analog.com>

>  drivers/iio/adc/ti-adc081c.c | 40 ++++++++++++++++++----------------------
>  1 file changed, 18 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-adc081c.c b/drivers/iio/adc/ti-adc081c.c
> index 4f514db5c26ea803660087ae02b2cf8ec71911e4..8ef51c57912de62b1d6a6913372b2cc8c6d463ae 100644
> --- a/drivers/iio/adc/ti-adc081c.c
> +++ b/drivers/iio/adc/ti-adc081c.c
> @@ -102,27 +102,23 @@ struct adcxx1c_model {
>  	int bits;
>  };
>  
> -#define ADCxx1C_MODEL(_name, _bits)					\
> -	{								\
> -		.channels = _name ## _channels,				\
> -		.bits = (_bits),					\
> -	}
> -
>  DEFINE_ADCxx1C_CHANNELS(adc081c,  8);
>  DEFINE_ADCxx1C_CHANNELS(adc101c, 10);
>  DEFINE_ADCxx1C_CHANNELS(adc121c, 12);
>  
> -/* Model ids are indexes in _models array */
> -enum adcxx1c_model_id {
> -	ADC081C = 0,
> -	ADC101C = 1,
> -	ADC121C = 2,
> +static const struct adcxx1c_model adc081c_model = {
> +	.channels = adc081c_channels,
> +	.bits = 8,
> +};
> +
> +static const struct adcxx1c_model adc101c_model = {
> +	.channels = adc101c_channels,
> +	.bits = 10,
>  };
>  
> -static struct adcxx1c_model adcxx1c_models[] = {
> -	ADCxx1C_MODEL(adc081c,  8),
> -	ADCxx1C_MODEL(adc101c, 10),
> -	ADCxx1C_MODEL(adc121c, 12),
> +static const struct adcxx1c_model adc121c_model = {
> +	.channels = adc121c_channels,
> +	.bits = 12,
>  };
>  
>  static const struct iio_info adc081c_info = {
> @@ -203,24 +199,24 @@ static int adc081c_probe(struct i2c_client *client)
>  }
>  
>  static const struct i2c_device_id adc081c_id[] = {
> -	{ "adc081c", (kernel_ulong_t)&adcxx1c_models[ADC081C] },
> -	{ "adc101c", (kernel_ulong_t)&adcxx1c_models[ADC101C] },
> -	{ "adc121c", (kernel_ulong_t)&adcxx1c_models[ADC121C] },
> +	{ "adc081c", (kernel_ulong_t)&adc081c_model },
> +	{ "adc101c", (kernel_ulong_t)&adc101c_model },
> +	{ "adc121c", (kernel_ulong_t)&adc121c_model },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, adc081c_id);
>  
>  static const struct acpi_device_id adc081c_acpi_match[] = {
>  	/* Used on some AAEON boards */
> -	{ "ADC081C", (kernel_ulong_t)&adcxx1c_models[ADC081C] },
> +	{ "ADC081C", (kernel_ulong_t)&adc081c_model },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(acpi, adc081c_acpi_match);
>  
>  static const struct of_device_id adc081c_of_match[] = {
> -	{ .compatible = "ti,adc081c", .data = &adcxx1c_models[ADC081C] },
> -	{ .compatible = "ti,adc101c", .data = &adcxx1c_models[ADC101C] },
> -	{ .compatible = "ti,adc121c", .data = &adcxx1c_models[ADC121C] },
> +	{ .compatible = "ti,adc081c", .data = &adc081c_model },
> +	{ .compatible = "ti,adc101c", .data = &adc101c_model },
> +	{ .compatible = "ti,adc121c", .data = &adc121c_model },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, adc081c_of_match);
> 
> ---
> base-commit: cd2731444ee4e35db76f4fb587f12d327eec5446
> change-id: 20250628-iio-const-data-11-1c6b9e28aded
> 
> Best regards,
> -- 
> David Lechner <dlechner@baylibre.com>
> 

