Return-Path: <linux-iio+bounces-24097-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1D0B56A4D
	for <lists+linux-iio@lfdr.de>; Sun, 14 Sep 2025 17:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C969189B36D
	for <lists+linux-iio@lfdr.de>; Sun, 14 Sep 2025 15:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC152DC341;
	Sun, 14 Sep 2025 15:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="gE/5JzCX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5362D12F1
	for <linux-iio@vger.kernel.org>; Sun, 14 Sep 2025 15:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757864642; cv=none; b=f0bBC+bFTCwXhQ6LlLp2w05cE37x0iwhy4k7TSrQohmhBXwmwR1/9h91AyekWpRjHHQv0C0aXLmsG9rJ9ppEZr+r0F9OuD1VWNQ1zIBT49oXpHtoV4eEz1xRizH9Q+0Xc6JKPXZvFKFaoF9kRCd6pG7de5kh3/fWn1bnSbBCHFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757864642; c=relaxed/simple;
	bh=cP0K/fO+03hivuzCPBr9UJRxnuVoSdNkA2qEl1wBq1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=T49zs/b7pG43R3HAllGAYUTwo6uPRXEEPUVuYw0AAiaP1zgoeTRT9RV6dBZnmwNp7V+GtAfYnfV1utNC5adMlwgOrX6omzipv3ZbPsGF6+VVChuZGmecq/rgv3Pv78PBjVFv6VSmFxo+i/dx7zWmJqX8P7vRENrwsvGG5pVhGwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=gE/5JzCX; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3ea115556b2so278462f8f.2
        for <linux-iio@vger.kernel.org>; Sun, 14 Sep 2025 08:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1757864639; x=1758469439; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=17ifI2mYE1NgbBTyTNuir4pDtVCiq8BMt8N76nRgoes=;
        b=gE/5JzCXB0cQCDXvC2d5bHqmJsCwY9zPhYQo57k5htoP4NMh9+LOujN586e3uQldMf
         0OVMQo336R+S0rokscRux8+rUTUw2CXHdoGzQEdJ7+xkg2aLFNEhbEYahIw9OfzZqAX6
         pdkDoE1G7hcIJQUSyR+pm9rMxe2Xih2VbaRsBFArSVl1W02BobUS1vToWSM0/HMbtH+z
         QUscixrb3yO0cMpeVjIFG10x9nLGGCV6VnmJOZySfVDcfCGKGXzCaNYDyq9SuYgwGBX7
         mkBIvzzxJ8Ufq1j4I7KCUH8SWdi0RcU6o9d/0B0ZaF8epkdcsUMOdpaOuU0qQEQB4l43
         Lhig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757864639; x=1758469439;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=17ifI2mYE1NgbBTyTNuir4pDtVCiq8BMt8N76nRgoes=;
        b=GxOcmWV/DZIanev8Tsu1J8sFWsyY4tZ46uv62TfrkVFAEzNEvbxcFvIRppQpVzgNJi
         4rTiXY7OgclDNYrOO997ADqMQq3NukdRp1SdZXONZTNemdRpUy47WEK6mOHPm4Y6VGfx
         r36hDsHv4M7fhJ/QYBro6mgSNJUv8po7EbdCDSgTwYSX/TuhHABxkviKX5HMJ74rmByA
         rm4tzbKcWDNLh1+4SEIZ4HIuCCsbBDONsUrhNVLBdzDA/Tgyr7+rJ5lxoQGEMU545h5j
         2x24aBciNAK2fUWZvdJvRYDrJraShF827F69jk05GSXJ7rdMxLvZefO2M7hNG+BdeUY+
         hapA==
X-Forwarded-Encrypted: i=1; AJvYcCUzIE0yJHzlrrU7GlrlIoTYmkaAkb/vbBRtkFZ0ju56tudbHGU56CBmj5fwxbN4RjUkSEmsURUKu2g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgFmajNBKjpj0QIdpebtaicvGkozAprkof1o8dfNwhvoj9fV6t
	gAExbwvt39EkRcbVlZEcWiiJGfvyUsD/ToYG55X2kMO/Y+LfBOcwfYJ4761xVqgFD2U=
X-Gm-Gg: ASbGncuwD1QbM/36lHIOs1r+C57TcYmZ/GCNHUBlQn+DlRvcKa6UefKUinJyY+3i70I
	N9a7YIz6rl4xdJOzhoHMRFcP0vX31gGOI+XtWZH8VADj1zvloWVZ6fI/AsWEbZ4bzYloQCbzzj7
	/P/YvCDsmS12Ft2bG70DyUrVxBuNEVEy7dAyvvrkhzWYDEnH6hLV/HyufJMSRWQKl3GpzNK6LRZ
	Lg2cbBOos41eJgL8kF60MhmuJMCSfJow6LYLf7abkV9B0R7OgZD3G4PR/8ayfZNlFVRtpfUmdwH
	g5vmoei8No6xZvQj3vk/XrxOhFoekmIW3rgcx2OINLpPfMxHqqsPVEk6xB6XpcisZaIy9FC9+/F
	chTOJ9Fz5ZQoq0+MI86i3KBvzUT3r/Yq7JhL/8cpG+A==
X-Google-Smtp-Source: AGHT+IHL6egG0n/SaYA5xvNQA+X+v1J8Dbx8go0tlT2XCBBZEzMIXumDBUCMKSubOS2pVf3FdBCGfA==
X-Received: by 2002:a05:6000:2510:b0:3e4:ea11:f7df with SMTP id ffacd0b85a97d-3e7659db441mr8532807f8f.40.1757864638550;
        Sun, 14 Sep 2025 08:43:58 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.153])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e0153fbd5sm74655275e9.5.2025.09.14.08.43.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Sep 2025 08:43:57 -0700 (PDT)
Message-ID: <038ea3e7-53d5-4e49-ad35-cc2a58e4d808@tuxon.dev>
Date: Sun, 14 Sep 2025 18:43:55 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/15] iio: adc: at91-sama5d2_adc: update calibration
 index, validation condition
To: Varshini Rajendran <varshini.rajendran@microchip.com>,
 eugen.hristev@linaro.org, jic23@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, srini@kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250804100219.63325-1-varshini.rajendran@microchip.com>
 <20250804100219.63325-5-varshini.rajendran@microchip.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <20250804100219.63325-5-varshini.rajendran@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Varshini,

On 8/4/25 13:02, Varshini Rajendran wrote:
> Add additional condition for validating the calibration data read from
> the OTP through nvmem device interface. Adjust the calibration indexes
> of sama7g5 according to the buffer received from the OTP memory.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> ---
>  drivers/iio/adc/at91-sama5d2_adc.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
> index c3450246730e..d952109a64a9 100644
> --- a/drivers/iio/adc/at91-sama5d2_adc.c
> +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> @@ -445,6 +445,14 @@ static const struct at91_adc_reg_layout sama7g5_layout = {
>  #define at91_adc_writel(st, reg, val)					\
>  	writel_relaxed(val, (st)->base + (st)->soc_info.platform->layout->reg)
>  
> +/*
> + * The calibration data has a TAG to recognize the packet
> + * The tag has a constant value "ACST" with the ASCII
> + * equivalent 0x41435354. This is used to validate the
> + * calibration data obtained from the OTP.
> + */
> +#define AT91_TEMP_CALIB_TAG	0x41435354
> +
>  /**
>   * struct at91_adc_platform - at91-sama5d2 platform information struct
>   * @layout:		pointer to the reg layout struct
> @@ -504,10 +512,10 @@ struct at91_adc_temp_sensor_clb {
>   * @AT91_ADC_TS_CLB_IDX_MAX: max index for temperature calibration packet in OTP
>   */
>  enum at91_adc_ts_clb_idx {
> -	AT91_ADC_TS_CLB_IDX_P1 = 2,
> -	AT91_ADC_TS_CLB_IDX_P4 = 5,
> -	AT91_ADC_TS_CLB_IDX_P6 = 7,
> -	AT91_ADC_TS_CLB_IDX_MAX = 19,
> +	AT91_ADC_TS_CLB_IDX_P1 = 1,
> +	AT91_ADC_TS_CLB_IDX_P4 = 4,
> +	AT91_ADC_TS_CLB_IDX_P6 = 6,
> +	AT91_ADC_TS_CLB_IDX_MAX = 18,
>  };
>  
>  /* Temperature sensor calibration - Vtemp voltage sensitivity to temperature. */
> @@ -2281,7 +2289,7 @@ static int at91_adc_temp_sensor_init(struct at91_adc_state *st,
>  		dev_err(dev, "Failed to read calibration data!\n");
>  		return PTR_ERR(buf);
>  	}
> -	if (len < AT91_ADC_TS_CLB_IDX_MAX * 4) {
> +	if (len < AT91_ADC_TS_CLB_IDX_MAX * 4  || buf[0] != AT91_TEMP_CALIB_TAG) {

Can buf[0] != AT91_TEMP_CALIB_TAG with the new code?


>  		dev_err(dev, "Invalid calibration data!\n");
>  		ret = -EINVAL;
>  		goto free_buf;


