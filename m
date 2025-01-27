Return-Path: <linux-iio+bounces-14635-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A54A1DADA
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jan 2025 17:55:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 949461663B5
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jan 2025 16:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E3115A842;
	Mon, 27 Jan 2025 16:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Js+Op39k"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB3F433CB;
	Mon, 27 Jan 2025 16:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737996932; cv=none; b=bo/B68I4Cyhpsen7WD9VL8ju3gNCkR4fYZRq3d8v1I0Fg0SwrJ3xk/11b50FjhzKi9J+NT29D4b8J+jvu0u1zdwu0k5tY/mVwAIn49RbPToM27VHyOrezsDTZ48Zr7dj4LfGhBpUYFC7pTkE/QubBTt5ylBlddbCy0CGI2VUZns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737996932; c=relaxed/simple;
	bh=dCHZ7RThHyLwPqcj8c7NPuZ8uYZjp2Zvuxey5DCSzgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JcNMmKRxTMbEiZz0GeKasaMp34eOEeIolKfToJMx4ZXh3TaOn1gSP0Ociju7Q4uayPjfhaqg0dQnioWxQ9I+3cI5R34rlEjVA31/+Ec6qqBz6BMyf8tlKfJ20IBIOb7V2bOVHT3ocZ6qTIYM7xhQDuUKG4GN7moipW401lHytBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Js+Op39k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 771E6C4CED2;
	Mon, 27 Jan 2025 16:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737996930;
	bh=dCHZ7RThHyLwPqcj8c7NPuZ8uYZjp2Zvuxey5DCSzgo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Js+Op39kBr/aQANumk7C6dKH6hXZ9ZgZjrY5oE9Xj1EkJooR4sezpfa+dZZG2xSbr
	 Gk6Fg7PKLflA8D7AuOrL7un5sM8NolM49ynMf8SErMsgD6t/EoQ5KRAw0s0KNTKXvQ
	 gTs8pCICIDaGIUSq/OqxirnoORT1oW/dPKBW8s+x34kA1AynWiRphKMAJ3QKMi/gUG
	 /iOI3GsgRgwIcSqsVVs6jkPpCIOa+R6u+uZIAgn2APwJX6YVzBgQywGmpTvcXo0GJM
	 ga0TvqaGqMXoTEYny2QIJGAXYgFaG+sXUvIXNfv96bqhbS6ROshkcKjXOo739iYnwu
	 WFA6Kgud/F5cw==
Date: Mon, 27 Jan 2025 10:55:29 -0600
From: Rob Herring <robh@kernel.org>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, lars@metafoo.de,
	Michael.Hennerich@analog.com, marcelo.schmitt@analog.com,
	jic23@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	jonath4nns@gmail.com, marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v2 02/16] dt-bindings: iio: adc: ad7768-1: add
 trigger-sources property
Message-ID: <20250127165529.GA435197-robh@kernel.org>
References: <cover.1737985435.git.Jonathan.Santos@analog.com>
 <f3972e6aa4ff3869ded1f0dbeb58c43b824b3932.1737985435.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3972e6aa4ff3869ded1f0dbeb58c43b824b3932.1737985435.git.Jonathan.Santos@analog.com>

On Mon, Jan 27, 2025 at 12:11:30PM -0300, Jonathan Santos wrote:
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

interrupts

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

You need quotes here.

This device worked before without these properties, so why are they 
required? That's an ABI change.

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
> +            trigger-sources = <&adc0>;
> +            #trigger-source-cells = <0>;
>              reset-gpios = <&gpio 27 GPIO_ACTIVE_LOW>;
>              clocks = <&ad7768_mclk>;
>              clock-names = "mclk";
> -- 
> 2.34.1
> 

