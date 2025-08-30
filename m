Return-Path: <linux-iio+bounces-23482-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69081B3CE37
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 19:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BC53563629
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 17:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358702D46B1;
	Sat, 30 Aug 2025 17:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="1cbToZpi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4446E23ED5E
	for <linux-iio@vger.kernel.org>; Sat, 30 Aug 2025 17:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756575190; cv=none; b=l0z7WhUHF0sMBFBXb/MRxOb3TOKsBqgz0Jj9cuY6LS0lLmxLnjnXhadfzbXsk46iO12ENW9+g/zI0XEa+zJvRqGhn0pY4a47R1XVn/qAZInbqRWjNN3GA7ohE4mGlrm2/Hjias6lp6UDnvqVB13dhzT1HUGpK5iziS2hNCk2JBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756575190; c=relaxed/simple;
	bh=Vya6+lJmTJWfY/M8wUra0srurpA1liqHsz60MVER1eg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VABxF8EO3GbVyj0/nznR/cmO+L2PVRFKdZTvLl10XndFj8DZYYOqNnlIVDmFNClWJ3yiaWU3WAC9s0uj7ukUY7VaDWfQwbkAg3jFkW60wIYb1X+qRaI7C0RcjNVUA6gC9B7V7FSRvIkdD8Jwj1FQfh5cBGKjrbFLzRtTzdRvaHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=1cbToZpi; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-314f332e064so1096169fac.2
        for <linux-iio@vger.kernel.org>; Sat, 30 Aug 2025 10:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1756575186; x=1757179986; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UwGfxy65ZWGgnex0UcGnWFkAe5/xQalwPutBYQHrYU0=;
        b=1cbToZpi2/q9zCSHq8cYBfTH1RjbdXdQRgzYH+U8VF4TRyJwx/Pjfuwt3XWvXfEZ3O
         hyda4xkvT3rp9kNq5NESq9/eUbiWrs2jxXoKZiyrr9rQ6qWewVXbTyyTX9WG7/QBS7mA
         i9TCg3scXUoZqEK7Tt1dkPacrBXfAWxqh7Zn0EUMCkwmnlpISmQ51T6vyp8/Pstdk7pB
         YLwjfM78DSZV0MyETDNhRN0RCzKeyDpl69INMjyhA7aL7Q8y7J/pWiBAe5iijdez7zM6
         CnS/k195tOfluSr8ItPZRt0c9XgsmhG79cQIbVzrHnVXoD0upuPisT5JM6FXW/+SRQde
         BJAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756575186; x=1757179986;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UwGfxy65ZWGgnex0UcGnWFkAe5/xQalwPutBYQHrYU0=;
        b=ieSLFy8cEGsibCTB+S+3cC1xbf+v/tpNTPhcCQxMDOPl8sefjd9w3WrdywR0jijRRF
         Fe95dI+6fH2hkEqIsdKUbodJkoNOOvG9UNnRvDBqMv0t3kbtLLr2R91rHtTrIL7Wuq20
         vL69HWx4xD5Vv9CVxB0xIxYp26xSEXhy6fAD/wh8O8JBv5VyVqYenCgiazaV6GZ9dYbj
         WLAwhFjU5G1gDE26zydLVUs5PJT6lxsWukXCR2IWRx88Rkqj7gSicYf/btjTdQdFeCAe
         DtJamWm6SoiWgnSNIDxI5NaLCCq30z/vmfkaORB2nv65Ewrr3dpjhdH6k7FFRfrumQ1m
         4T5g==
X-Forwarded-Encrypted: i=1; AJvYcCX/Kifu+XJToAmOP3aHTY0w58VF5EAHiD7beD5iNURKJAojhy6XfRv5OBAXXZOO+0A33Uonu6S5aeU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzniQowdgCxUYkIwGEavbFoctwyKee8B5tAaNXPZuXmtfcaevFX
	jGyIlUKjnFMdoU/rvb5uO4Vg4HSfqIra2x0/WoQDnCjJdGP7xEHHcVhM8X4EnI7O/KQ=
X-Gm-Gg: ASbGncvlN0FnhMRgG0CEV15omXC4C6LeLMFC5QUOnLyGFGDEHwrt3Ke7CFcHidzyowI
	ZSFgfyJB7OSp0yM9kPPDApz2ES16woLabr+98cn4FkplxUE4Fifrl8ILNO34loZ0KfNDcxT+aKt
	pRtpL9EcvrWt4BW5AGGACTz6tPrmXH4RkDxlh0PtJDqIocDV6ltoBLJ4+ARtCCggvOV40nTS1t0
	/PgEV8rCBSI9mifwXkwgdWVwG6iYueRL+sjiLKfpD/CQW6R5KRdRASGR/MjqanMf6iMwHSurP/X
	p9tCzdo+WA7QDPHqM5civzI8jFS/HQlrrQUJLdAGLa/pTF1IEovBZRP2z0hbWKVO+uRDj0tghtJ
	BCgD4HIyHzubAf/k8jjF/S48lPaA0AZ//tyQMzUkdqfK7PpmrRKVOSO+p1n9Xj4axIWGOfJyows
	9nK6qKXEFdqA==
X-Google-Smtp-Source: AGHT+IFcICIgTAwdd2cegX4yfW7wbywNdgh/DYrUWm0XZ+08pLIWWYSQjsp1DI9hm/xDxEm0jp5Vpg==
X-Received: by 2002:a05:6871:b0d:b0:315:351d:bcf2 with SMTP id 586e51a60fabf-3196307edcfmr1120526fac.2.1756575186272;
        Sat, 30 Aug 2025 10:33:06 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:f7b4:dfbd:5110:c59d? ([2600:8803:e7e4:1d00:f7b4:dfbd:5110:c59d])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3196d4c1132sm369525fac.28.2025.08.30.10.33.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Aug 2025 10:33:04 -0700 (PDT)
Message-ID: <bb8f120b-db75-4dbf-8473-3ef6f340c38a@baylibre.com>
Date: Sat, 30 Aug 2025 12:33:04 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/15] iio: adc: ad4030: Enable dual data rate
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-spi@vger.kernel.org
Cc: jic23@kernel.org, Michael.Hennerich@analog.com, nuno.sa@analog.com,
 eblanc@baylibre.com, andy@kernel.org, corbet@lwn.net, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, broonie@kernel.org,
 Jonathan.Cameron@huawei.com, andriy.shevchenko@linux.intel.com,
 ahaslam@baylibre.com, sergiu.cuciurean@analog.com, marcelo.schmitt1@gmail.com
References: <cover.1756511030.git.marcelo.schmitt@analog.com>
 <47b2cf01555c31126bc2133526317c7829cb59ab.1756511030.git.marcelo.schmitt@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <47b2cf01555c31126bc2133526317c7829cb59ab.1756511030.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/29/25 7:45 PM, Marcelo Schmitt wrote:
> Set AD4030 series device to do two data bit transitions per clock cycle per
> active lane when specified by firmware. The dual data rate (DDR) feature is
> available only for host clock mode and echo clock mode.
> 
> Co-developed-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
>  drivers/iio/adc/ad4030.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
> index a5931056936a..37ba00097efe 100644
> --- a/drivers/iio/adc/ad4030.c
> +++ b/drivers/iio/adc/ad4030.c
> @@ -74,6 +74,7 @@
>  	(AD4030_REG_GAIN_X0_MSB + (AD4030_REG_GAIN_BYTES_NB * (ch)))
>  #define AD4030_REG_MODES			0x20
>  #define     AD4030_REG_MODES_MASK_OUT_DATA_MODE	GENMASK(2, 0)
> +#define     AD4030_REG_MODES_MASK_DDR_MODE	BIT(3)
>  #define     AD4030_REG_MODES_MASK_CLOCK_MODE	GENMASK(5, 4)
>  #define     AD4030_REG_MODES_MASK_LANE_MODE	GENMASK(7, 6)
>  #define AD4030_REG_OSCILATOR			0x21
> @@ -175,6 +176,7 @@ struct ad4030_state {
>  	enum ad4030_out_mode mode;
>  	enum ad4030_lane_mode lane_mode;
>  	enum ad4030_clock_mode clock_mode;
> +	bool ddr;
>  	/* offload sampling spi message */
>  	struct spi_transfer offload_xfer;
>  	struct spi_message offload_msg;
> @@ -1218,6 +1220,9 @@ static void ad4030_prepare_offload_msg(struct ad4030_state *st)
>  	else
>  		offload_bpw  = data_width / (1 << st->lane_mode);
>  
> +	if (st->ddr)
> +		offload_bpw  /= 2;
> +

There is already an existing dtr_mode flag in struct spi_transfer. We should
be using that instead of providing an inaccurate bits per word value.

>  	st->offload_xfer.speed_hz = AD4030_SPI_MAX_REG_XFER_SPEED;
>  	st->offload_xfer.bits_per_word = offload_bpw;
>  	st->offload_xfer.len = roundup_pow_of_two(BITS_TO_BYTES(offload_bpw));
> @@ -1271,6 +1276,12 @@ static int ad4030_config(struct ad4030_state *st)
>  	reg_modes |= FIELD_PREP(AD4030_REG_MODES_MASK_CLOCK_MODE,
>  				ret >= 0 ? ret : AD4030_SPI_CLOCK_MODE);
>  
> +	/* DDR is only valid for echo clock and host clock modes */
> +	if (ret == AD4030_ECHO_CLOCK_MODE || ret == AD4030_CLOCK_HOST_MODE) {
> +		st->ddr = device_property_read_bool(dev, "adi,dual-data-rate");

As mentioned in the dt-bindings patch review, we can already get this info
from the spi controller via dtr_caps. 

> +		reg_modes |= FIELD_PREP(AD4030_REG_MODES_MASK_DDR_MODE, st->ddr);
> +	}
> +
>  	ret = regmap_write(st->regmap, AD4030_REG_MODES, reg_modes);
>  	if (ret)
>  		return ret;

We will need a separate patch to add support for dtr_caps and dtr_mode to the
axi-spi-engine driver. And likely some HDL work for that as well. So I would
suggest splitting this out into a separate series.

