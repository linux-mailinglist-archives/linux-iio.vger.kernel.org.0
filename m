Return-Path: <linux-iio+bounces-14654-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B00B0A20302
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jan 2025 02:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBA87188663B
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jan 2025 01:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5FE42AB4;
	Tue, 28 Jan 2025 01:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ZOONgcZf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7B4EAF6
	for <linux-iio@vger.kernel.org>; Tue, 28 Jan 2025 01:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738027739; cv=none; b=Kbu+WA+vtvCbb4hVjFZD30FgPoBS8JMrWTY7qEP9F/6jEJWzEe7y8jKozR7CHJy7fFwb4LnQVTyQXnbgebWeHPlH4pVgJUzZmWSL8HxcXVGkEp7DZwy+xY+YKUT00lEzs329NkLU7SJ0yX/NWn2CJtP8LuQe/4v0FIGUC+app3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738027739; c=relaxed/simple;
	bh=VMJ//ZhdKIakDGRD4fQVsxWko+dmrXyV7Md0xi2/MdU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FjraA/dazlUFLb371BMJxg8ed/joPrAsypVqVfOXGBuDLsuq50dCvhgxfz4YzIhP9F/GVSA5s7cwQKOf00N0op2Gm6yIp/aEZSUsN4GKqMpyBhmmAIIWvPjiLI+4sSfD5l7Ju4fgmsBB7LFsh2IDddHuHUJxcnt6pb5Wj1SQ2cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ZOONgcZf; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3ebb4aae80dso2299845b6e.2
        for <linux-iio@vger.kernel.org>; Mon, 27 Jan 2025 17:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738027737; x=1738632537; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=08SMuDcYjRA/fEa36MDvgrTUtG8yD3JTS9Dq0JR83M0=;
        b=ZOONgcZfy/AY2aZ1a/qEKIWLwhi/okJKwAug9wFn7QiP7wCu39Uq7RWSzqQbfbKr4P
         9YN5TWW0Lkk756b47C3hbKI3lhesJ30izHrtURsJd2alQJGO+By7IBdejsifansgCPjd
         wcx14y4L7qGDrqNuqeNw3KWHdfvhyEZEPVZlriJ4E4FUWm71S0Zw9zSnr0kMXeUSLJgT
         lA8dswNJlmEWVaLSKri4w7UnO8CIiPUboxdPZkun2dpBBV7mKECpdrgB86+9bL+vi9+X
         UL3IzYZIrbVxkihF+N/LfbJsi/TUGDJLC72W1nYiAQ45eaLH/cQdETVUONX3vzg1su3y
         TmIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738027737; x=1738632537;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=08SMuDcYjRA/fEa36MDvgrTUtG8yD3JTS9Dq0JR83M0=;
        b=RM0ZIEKrwuNMRZRETC3REpAA/+VOGR1suxy/Fx4ktlhMY2ls8DO23dj63H1eKnvi7P
         5kCm9mz7DcbpEBV9jvihAtAJZTxm8c68Pfg0Wu1YBDYNOzxWJ/KXbzX/MaZqCNej4kF0
         b32P2m2FNTHJGBnSVcQeK1iHUUVx0UBtC14KNbD+9hrLqXNICxIT9fdPw+Y20Ks9fEIb
         beeCgrX6wKjOmYkrf+IyYRdlnadwpd5cjI7l/ZaCDgl+ybRi12oFZQL3ez4bNMD5e87L
         E/fqkUUbHu54+jL6LEvfhn9zhgNat8jcdX+5CSj5aXkfDRyaManNdh+xix+l1QwRqyBx
         ty/A==
X-Forwarded-Encrypted: i=1; AJvYcCUiQxShtmhwRctZP6+uM/fpCkiujHDSgjW6LZQweRz1iLAyAWi/foDd8B5HrtzJoMhwTbf4dwwKHak=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4zAto2I+K9gIySgld3IU06NNOfVJnch2DKp1PITlKJrbtgBkc
	e+9kvC36RZr7q733PuVzEUqQSpRJLEcpl1lE+dqhLjWxOxupMqZ9xtqGQaWBh6dkMwDkrOdkpto
	H
X-Gm-Gg: ASbGncvKaLo0uXY2Y2vz2emXOxjouwiqxgtJUKBSnu2c4rbFOea3Tnncf9agEgBl5GC
	EwfrklKhC6/fgLo17SpkrHGg1JVyrtwNP31XQGSJ5KAuqX3wMk6AH69SXNB3JFX6a5fSRhRpbBu
	/LBK3n52Ha6qw5U0DvpT2fQTUj+6SYa9Xm7umIcr1S/1izFmtKz7Aof/4NnwcYjzQjXuFk3DAYW
	sj79FfsEdkuq7ox/xRfM4+OJnHqGhGTTN2fw7gSGbxx4KbmPAu2KelAl5oIft139VDnskHCEAgL
	JlOOa9vUYNThCbH3QBvgPsbYzahlOsnBc6JNWLCP/A==
X-Google-Smtp-Source: AGHT+IG3JUrxTb1AoGq609NrxgfziYTKUspi+XNC7GFLYp3ofHKCUStTpoa0hxkLnYjImNXy0+o71Q==
X-Received: by 2002:a05:6808:228a:b0:3e6:3878:3b9c with SMTP id 5614622812f47-3f19fc4d943mr27361274b6e.8.1738027736676;
        Mon, 27 Jan 2025 17:28:56 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-724ecf98615sm2680304a34.56.2025.01.27.17.28.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jan 2025 17:28:55 -0800 (PST)
Message-ID: <0044dd4b-01ce-4ca0-9855-8c239b9bfb6f@baylibre.com>
Date: Mon, 27 Jan 2025 19:28:53 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/16] dt-bindings: iio: adc: ad7768-1: add
 trigger-sources property
To: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 marcelo.schmitt@analog.com, jic23@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, jonath4nns@gmail.com,
 marcelo.schmitt1@gmail.com
References: <cover.1737985435.git.Jonathan.Santos@analog.com>
 <f3972e6aa4ff3869ded1f0dbeb58c43b824b3932.1737985435.git.Jonathan.Santos@analog.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <f3972e6aa4ff3869ded1f0dbeb58c43b824b3932.1737985435.git.Jonathan.Santos@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/27/25 9:11 AM, Jonathan Santos wrote:
> Add a new trigger-sources property to enable synchronization across
> multiple devices. This property references the main device (or
> trigger provider) responsible for generating the pulse to drive the
> SYNC_IN of all devices in the setup.
> 
> In addition to GPIO synchronization, The AD7768-1 also supports
> synchronization over SPI, which use is recommended when the GPIO
> cannot provide a pulse synchronous with the base MCLK signal. It
> consists of looping back the SYNC_OUT to the SYNC_IN pin and send
> a command via SPI to trigger the synchronization.
> 
> SPI-based synchronization is enabled in the absence of adi,sync-in-gpios
> property. Since adi,sync-in-gpios is not long the only method, remove it
> from required properties.
> 
> While at it, add description to the interrupt property.
> 
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> ---
> v2 Changes:
> * Patch added as replacement for adi,sync-in-spi patch.
> * addressed the request for a description to interrupts property.
> ---
>  .../bindings/iio/adc/adi,ad7768-1.yaml        | 22 +++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
> index 3ce59d4d065f..3e119cf1754b 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
> @@ -26,7 +26,17 @@ properties:
>    clock-names:
>      const: mclk
>  
> +  trigger-sources:
> +    description:
> +      References the main device responsible for synchronization. In a single
> +      device setup, reference the own node.
> +    maxItems: 1

We probably actually need 2 here. One for /SYNC_IN and one for a GPIO3 pin
acting as the /START signal.

> +
>    interrupts:
> +    description:
> +      Specifies the interrupt line associated with the ADC. This refers
> +      to the DRDY (Data Ready) pin, which signals when conversion results are
> +      available.
>      maxItems: 1
>  
>    '#address-cells':
> @@ -46,6 +56,8 @@ properties:
>        sampling. A pulse is always required if the configuration is changed
>        in any way, for example if the filter decimation rate changes.
>        As the line is active low, it should be marked GPIO_ACTIVE_LOW.
> +      In the absence of this property, Synchronization over SPI will be
> +      enabled.

Isn't /SYNC_OUT connected to /SYNC_IN required for synchronization over SPI?

If yes, instead of adding this text, I would make the binding have:

oneOf:
  - required:
      - trigger-sources
  - required:
       - adi,sync-in-gpios

>  
>    reset-gpios:
>      maxItems: 1
> @@ -57,6 +69,9 @@ properties:
>    "#io-channel-cells":
>      const: 1
>  
> +  "#trigger-source-cells":
> +    const: 0
> +
>  required:
>    - compatible
>    - reg
> @@ -65,7 +80,8 @@ required:
>    - vref-supply
>    - spi-cpol
>    - spi-cpha
> -  - adi,sync-in-gpios
> +  - trigger-sources
> +  - #trigger-source-cells
>  
>  patternProperties:
>    "^channel@([0-9]|1[0-5])$":
> @@ -99,7 +115,7 @@ examples:
>          #address-cells = <1>;
>          #size-cells = <0>;
>  
> -        adc@0 {
> +        adc0: adc@0 {
>              compatible = "adi,ad7768-1";
>              reg = <0>;
>              spi-max-frequency = <2000000>;
> @@ -109,6 +125,8 @@ examples:
>              interrupts = <25 IRQ_TYPE_EDGE_RISING>;
>              interrupt-parent = <&gpio>;
>              adi,sync-in-gpios = <&gpio 22 GPIO_ACTIVE_LOW>;

Don't we need to drop adi,sync-in-gpios here? I don't think we would have two
things connected to /SYNC_IN at the same time.

> +            trigger-sources = <&adc0>;
> +            #trigger-source-cells = <0>;
>              reset-gpios = <&gpio 27 GPIO_ACTIVE_LOW>;
>              clocks = <&ad7768_mclk>;
>              clock-names = "mclk";


