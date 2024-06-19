Return-Path: <linux-iio+bounces-6591-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6254690EF86
	for <lists+linux-iio@lfdr.de>; Wed, 19 Jun 2024 15:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66A8A1C21C23
	for <lists+linux-iio@lfdr.de>; Wed, 19 Jun 2024 13:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EDBE150984;
	Wed, 19 Jun 2024 13:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NOxU9WS7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7360514F9C4
	for <linux-iio@vger.kernel.org>; Wed, 19 Jun 2024 13:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718805419; cv=none; b=aXTYWpx7aBHuJV+qcrgq0D22KxTt/SOIIRsSr/eLPxvV3EjP+Ey0zYzTNAF7GsYs6OGlCniNhx4NsLj1UGVmHmyDMeNbLP/im51UOvxhE/yZ5WnvQMApCpKJlm52lWDElDR6EbCRrLfDpOyBHsR9jMtyQzfWNzHDwzVPpqVvzuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718805419; c=relaxed/simple;
	bh=4YpmGHY2TB039BP2VfN05LGC3OdymGgIoGdy6v3hIW8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MgY29+oBkeB9pz615NZyFOu357mTLrO8bEMNwtIM2KTHk8gOitU7h1IHoRE3TZex9Zh9zayKG92awvy/sy0MDENZq8wUaWWyH13fJ/lnSVVEHQLzOD2vc2u3WLm6d8m1bsUeUzp4vjxmNhhH0ptcqJhqRoui4QqmhoGX4QC0hv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=NOxU9WS7; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-250ca14422aso3607521fac.0
        for <linux-iio@vger.kernel.org>; Wed, 19 Jun 2024 06:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718805415; x=1719410215; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kSPgTLrYAIER1520IHBWtifoNKXPibq2elTdXzAWxws=;
        b=NOxU9WS7I1ixeQ7jNAPSnvkNNAq7vq1V7Hh2mvjvOMLxUIrk461Xx5bIKBQNUFTGLy
         cfkndtJCSRUbYolCZG9rJqjnMQllZjJAU25YAWyBCuDH439nma3IOp8AX550/Lv7Msml
         Si9itxDSRpabOUkdfmzxBopjNb/1YgfCnKBDUCMXTyhljhmu6v4XOg1hjQMDbVusi1m4
         P+1Q6f7SrvvF7QII1cgUQzqNiP7OfHgHg6Besn+PHikhADSdgVld2I8Y76sajfPiWKCA
         qK9c6C1MRn37l8NTlI95tnTYUa7scS6XJ5oG5DSIALcqW400Z0ULAeRKdrCNW3n8tvlm
         rjWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718805415; x=1719410215;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kSPgTLrYAIER1520IHBWtifoNKXPibq2elTdXzAWxws=;
        b=G5LFInzJ96DXOZer4/+UWGNtOsvL/biEMtn/pYYlF1CqyfIuVAveCuuML24HfYMhkr
         0kRtkDBUCZORtO+Yij7VxA10KIDWc6lGS3EwjYaHVhXcaQ7/S9voSoTjD73pucP0e9Ke
         wvsDTOTvjw8Thzw37L6mSUkhnh1tgo7ZC3rPdUnTETGUGnueIx5YFwBvtLA3g8b1t5Gz
         V4i0RLCs2jiSPD+vTxZ4DR2/qMPNRfZometBoAml939KiGX/n+1S8DRKwbYxgR6j+qY9
         hOd2bnfVmM4Wi4187tjELwJb+ftC+KuAFz8gumlDbpDYW/oNJ9DOx5CftKM6tv65iy6X
         s9cA==
X-Gm-Message-State: AOJu0Yx7bgeRzFfv0+uBEyGjhsWLcfhIBu4aKXIDL3OtDc35HNrsfzKn
	FW1k1bw7f+U7j/AWEP6X/F8nBuauH1ougOnh4UhWuumiTRyvMi1NitWhH729BlI=
X-Google-Smtp-Source: AGHT+IHQhtwtn3q99qx1DtHTwYTM65SjEm6yem4vTsRk9lAiFBEHwPqq1Ktxa7Qbe5eZABSkRNp2ag==
X-Received: by 2002:a05:6870:63ab:b0:24c:a547:7b5a with SMTP id 586e51a60fabf-25c94991652mr3393011fac.14.1718805415510;
        Wed, 19 Jun 2024 06:56:55 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2569930f7f5sm3695527fac.44.2024.06.19.06.56.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 06:56:55 -0700 (PDT)
Message-ID: <6f945701-cac0-4a56-9ca7-1daceccc5efd@baylibre.com>
Date: Wed, 19 Jun 2024 08:56:54 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/6] spi: spi-axi-spi-engine: Add support for MOSI idle
 configuration
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, broonie@kernel.org,
 lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 nuno.sa@analog.com, marcelo.schmitt1@gmail.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1718749981.git.marcelo.schmitt@analog.com>
 <ead669c15db7cfad4034df1d743fd4088f1c2253.1718749981.git.marcelo.schmitt@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <ead669c15db7cfad4034df1d743fd4088f1c2253.1718749981.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/18/24 6:11 PM, Marcelo Schmitt wrote:
> Implement MOSI idle low and MOSI idle high to better support peripherals
> that request specific MOSI behavior.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
>  drivers/spi/spi-axi-spi-engine.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
> index 0aa31d745734..787e22ae80c0 100644
> --- a/drivers/spi/spi-axi-spi-engine.c
> +++ b/drivers/spi/spi-axi-spi-engine.c
> @@ -41,6 +41,7 @@
>  #define SPI_ENGINE_CONFIG_CPHA			BIT(0)
>  #define SPI_ENGINE_CONFIG_CPOL			BIT(1)
>  #define SPI_ENGINE_CONFIG_3WIRE			BIT(2)
> +#define SPI_ENGINE_CONFIG_SDO_IDLE		BIT(3)

Calling this SPI_ENGINE_CONFIG_SDO_IDLE_HIGH would make it more
clear what happens when the bit is enabled.

>  
>  #define SPI_ENGINE_INST_TRANSFER		0x0
>  #define SPI_ENGINE_INST_ASSERT			0x1
> @@ -132,6 +133,10 @@ static unsigned int spi_engine_get_config(struct spi_device *spi)
>  		config |= SPI_ENGINE_CONFIG_CPHA;
>  	if (spi->mode & SPI_3WIRE)
>  		config |= SPI_ENGINE_CONFIG_3WIRE;
> +	if (spi->mode & SPI_MOSI_IDLE_HIGH)
> +		config |= SPI_ENGINE_CONFIG_SDO_IDLE;
> +	if (spi->mode & SPI_MOSI_IDLE_LOW)
> +		config &= ~SPI_ENGINE_CONFIG_SDO_IDLE;
>  
>  	return config;
>  }
> @@ -646,6 +651,9 @@ static int spi_engine_probe(struct platform_device *pdev)
>  
>  	host->dev.of_node = pdev->dev.of_node;
>  	host->mode_bits = SPI_CPOL | SPI_CPHA | SPI_3WIRE;
> +	if (ADI_AXI_PCORE_VER_MAJOR(version) >= 1 &&

Currently, the major version is required to be 1, so this check is not
strictly needed.

> +	    ADI_AXI_PCORE_VER_MINOR(version) >= 3)
> +		host->mode_bits |=  SPI_MOSI_IDLE_LOW | SPI_MOSI_IDLE_HIGH;



>  	host->bits_per_word_mask = SPI_BPW_RANGE_MASK(1, 32);
>  	host->max_speed_hz = clk_get_rate(spi_engine->ref_clk) / 2;
>  	host->transfer_one_message = spi_engine_transfer_one_message;


