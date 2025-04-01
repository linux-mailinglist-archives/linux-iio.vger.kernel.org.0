Return-Path: <linux-iio+bounces-17511-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF95A7804D
	for <lists+linux-iio@lfdr.de>; Tue,  1 Apr 2025 18:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0532218946F4
	for <lists+linux-iio@lfdr.de>; Tue,  1 Apr 2025 16:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E022046B2;
	Tue,  1 Apr 2025 16:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Ox2cgNtr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EFD207A28
	for <linux-iio@vger.kernel.org>; Tue,  1 Apr 2025 16:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743524128; cv=none; b=fUCkylGYf5Ve5yb3Q/MPMg4CB14c04tVO/vjatArLjvN/A8OFxwzgkMgL4awYe//pjpmdorQsaIA+fhyObLw6A8Oxr8RAFlsg3IQNZ1x5osuOk32Ztn6Fd04jgu4mXFOR9f92GDwrfybyFA8u5vfEcnrem0W+WgRLLPWdmSJkQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743524128; c=relaxed/simple;
	bh=MCDRrc6gITw7ILHOzJNTmL2BGOeoJlccEAeGN1hnyDY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uj1QcjIeeWxur+Ur7hkfVemeYG7/MyRl+VXtgXqyL1j3yPSMcWHLtuezteHon1579U0rNiaXIZab2Mu6cpVx8BT5rexF0wX9L8G6WWQVYfjqOLoPoJ+v1Mx3lsPv2g2UW08ko54JkNsuhMPknqmgL6s49xDcI8W1x5p2IoakRSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Ox2cgNtr; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7272f9b4132so4171663a34.0
        for <linux-iio@vger.kernel.org>; Tue, 01 Apr 2025 09:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1743524124; x=1744128924; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KV6A6SkFyjP45lT34VumuzTtupTmw14mZAo1pKWFBns=;
        b=Ox2cgNtrnIxNz8aG0aUMSR2rosHJfCY+GQRSrNdUVCK6mGUQ3XxVu878TmVFCE5+jR
         EUe9x2BdE+QnpP+rMy1/D0VSOy32zu7KOHDXRnw3hvogEiiaBLIxici2yC1eV12j+LtR
         saUsDBFjalGxEbzSzgdvjv9JQKWMYSxe6/j83Jld7scNrZJpHjLMcG2MK1v//VQ33F4o
         1mtSlwX6s/4fGOhhQ99QiR5HaVF+umven+BKDy0nIzOEr7oJhv5hW64vYYDHftUqFJ1b
         WnZX7m1kxcuZl9o0WB6Ri0OyF78rC1VJsb/MnA3Y/gPtufXeykZSqLNtOTLGZa8D7MXB
         Jfbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743524124; x=1744128924;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KV6A6SkFyjP45lT34VumuzTtupTmw14mZAo1pKWFBns=;
        b=emBUe/yHEtWVBZajGp9Nx/VTUiAH/1hl4NjLcOy5XGjhMiR6V51MyKiNuA9S4thbGd
         5Yt88cIQthZSLpk5dxEt/InQfDuYreJ8hDn5LN5LFMQXYXJUamFvf00y7mETnxahUHMG
         2GFasdLLPrHmzE0+kH92DirDnTE3cniqxzj239s2UF1zIA2RBRInBEgh7wz5EvC7Av3e
         tGv/oGQoqqnHe/q0PQXDU3yPg71snBCVYBXq7RF1IgR9her4yIt6/AG5k6sFIEju0E3J
         ZT3Fv4xw8EfSkEYFuSJXWPEoN5ymVXnEXJNsc84JPtXdUTG51bfIBPtDmUCBQ4vmYoma
         4grw==
X-Forwarded-Encrypted: i=1; AJvYcCUwFmHT4yz7qL+NZE+3EOb+Q+coomUsBKfO6dtyGWJFRiutYWUnz2ERg6G87wSS/8X1ZRgEYljMBt0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbFqVmsrvx60sgroR/ppq5dFC+Eb99fUz/RV0EnZBWQaRww9La
	iLUZPMxDv+0mFeI1yazGk5e5Xhvx5chc7lOgbagX24MiHZYhHoRFeiKD6uY1JNY=
X-Gm-Gg: ASbGncsLdvsP7FG9gSYmlmm+ujS12C3lAEkcQWuPQ6eKVWlFeYZQ4QqAvLwLBbolqT2
	USMcynTyHNPwf+8t6Fg5XxsedxVav9LwfZUrb+wgs9liydE9tIu4DLzJJMH0Fq4k4mEOmRXJSS1
	lvK5aQILkNGNQA54hpuuTBnZgjAggDiqNVr+l1JPTnVqgXQimSvsAPdxxs4j8CZHhJKnvs5b5zH
	I0RNTVIjI2Nv5pJD6Kg2qM87jY/41PXmu8DBm0fiCGIbzEMuq55L8m/5Lfz3gi6WWegQDrsRRlD
	naoBHfWLtYKzRj29Pc8WJiK7wqTvo7M6Ggu/J8acUBK/c6hjjGmflIZCxqK0rDdWqwJ0f6Ar1DI
	IPzh8cA==
X-Google-Smtp-Source: AGHT+IHkFB1qErKdOP/R3+n0pyHcdkpWGJYkUI8OIJLr5yCsfzswBCRj23kPPNNelf6fm+HG+W8KGA==
X-Received: by 2002:a05:6830:3152:b0:729:ff76:5166 with SMTP id 46e09a7af769-72c637c450dmr8141400a34.14.1743524123806;
        Tue, 01 Apr 2025 09:15:23 -0700 (PDT)
Received: from [192.168.0.113] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72c58092589sm1914991a34.2.2025.04.01.09.15.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Apr 2025 09:15:22 -0700 (PDT)
Message-ID: <e609fff8-9fc8-425a-8362-9205c17ffc4d@baylibre.com>
Date: Tue, 1 Apr 2025 11:15:21 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/17] dt-bindings: iio: adc: ad7768-1: add
 trigger-sources property
To: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 marcelo.schmitt@analog.com, jic23@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, linus.walleij@linaro.org,
 brgl@bgdev.pl, lgirdwood@gmail.com, broonie@kernel.org,
 marcelo.schmitt1@gmail.com, jonath4nns@gmail.com
References: <cover.1741268122.git.Jonathan.Santos@analog.com>
 <4136b5259df75221fc314bcd4a57ecaeeab41a45.1741268122.git.Jonathan.Santos@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <4136b5259df75221fc314bcd4a57ecaeeab41a45.1741268122.git.Jonathan.Santos@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/6/25 3:00 PM, Jonathan Santos wrote:
> In addition to GPIO synchronization, The AD7768-1 also supports
> synchronization over SPI, which use is recommended when the GPIO
> cannot provide a pulse synchronous with the base MCLK signal. It
> consists of looping back the SYNC_OUT to the SYNC_IN pin and send
> a command via SPI to trigger the synchronization.
> 
> Add a new trigger-sources property to enable synchronization over SPI
> and future multiple devices support. This property references the
> main device (or trigger provider) responsible for generating the
> SYNC_OUT pulse to drive the SYNC_IN of device.
> 
> While at it, add description to the interrupts property.
> 
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> ---
> v4 Changes:
> * none
> 
> v3 Changes:
> * Fixed dt-bindings errors.
> * Trigger-source is set as an alternative to sync-in-gpios, so we
>   don't break the previous ABI.
> * increased maxItems from trigger-sources to 2.
> 
> v2 Changes:
> * Patch added as replacement for adi,sync-in-spi patch.
> * addressed the request for a description to interrupts property.
> ---
>  .../bindings/iio/adc/adi,ad7768-1.yaml        | 28 +++++++++++++++++--
>  1 file changed, 25 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
> index 3ce59d4d065f..4bcc9e20fab9 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
> @@ -26,7 +26,19 @@ properties:
>    clock-names:
>      const: mclk
>  
> +  trigger-sources:
> +    description:
> +      Specifies the device responsible for driving the synchronization pin,
> +      as an alternative to adi,sync-in-gpios. If the own device node is
> +      referenced, The synchronization over SPI is enabled and the SYNC_OUT
> +      output will drive the SYNC_IN pin.
> +    maxItems: 2

This says maxItems: 2 but the description only describes one, namely /SYNC_IN.
IIRC, the 2nd one is for the optional /START input.

> +
>    interrupts:
> +    description:
> +      Specifies the interrupt line associated with the ADC. This refers
> +      to the DRDY (Data Ready) pin, which signals when conversion results are
> +      available.
>      maxItems: 1
>  
>    '#address-cells':
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
> @@ -65,7 +80,6 @@ required:
>    - vref-supply
>    - spi-cpol
>    - spi-cpha
> -  - adi,sync-in-gpios
>  
>  patternProperties:
>    "^channel@([0-9]|1[0-5])$":
> @@ -89,6 +103,13 @@ patternProperties:
>  allOf:
>    - $ref: /schemas/spi/spi-peripheral-props.yaml#
>  
> +  - oneOf:
> +      - required:
> +          - trigger-sources
> +          - "#trigger-source-cells"
> +      - required:
> +          - adi,sync-in-gpios
> +
>  unevaluatedProperties: false
>  
>  examples:
> @@ -99,7 +120,7 @@ examples:
>          #address-cells = <1>;
>          #size-cells = <0>;
>  
> -        adc@0 {
> +        adc0: adc@0 {
>              compatible = "adi,ad7768-1";
>              reg = <0>;
>              spi-max-frequency = <2000000>;
> @@ -108,7 +129,8 @@ examples:
>              vref-supply = <&adc_vref>;
>              interrupts = <25 IRQ_TYPE_EDGE_RISING>;
>              interrupt-parent = <&gpio>;
> -            adi,sync-in-gpios = <&gpio 22 GPIO_ACTIVE_LOW>;
> +            trigger-sources = <&adc0 0>;

# cells is 0 but this has one cell specified. So one or the other is incorrect.
Since there are other outputs that could be used as triggers, e.g. /DRDY could
be used as a SPI offload trigger, having 1 cell seems prudent.

> +            #trigger-source-cells = <0>;
>              reset-gpios = <&gpio 27 GPIO_ACTIVE_LOW>;
>              clocks = <&ad7768_mclk>;
>              clock-names = "mclk";


