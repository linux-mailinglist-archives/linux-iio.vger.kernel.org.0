Return-Path: <linux-iio+bounces-23323-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61938B37505
	for <lists+linux-iio@lfdr.de>; Wed, 27 Aug 2025 00:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C2E61BA082E
	for <lists+linux-iio@lfdr.de>; Tue, 26 Aug 2025 22:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9322853E9;
	Tue, 26 Aug 2025 22:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UMlZdcfu"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1376944F;
	Tue, 26 Aug 2025 22:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756248414; cv=none; b=L1xhyXURSPbAkNMn0KGreRZbyIsU0e3UI9J0s9HtVxMI29oChYCCirCD/gZNnGAg7D9xYfGK7rMiy6C2k14ZH2l7FvPdULmpD1Qe7iCLA58t9PMJtLOslSh0SRo6ZWELTzRMg8BKv8B+WYIhzNrNexUzWTU2f5GzNRm6WxeIFtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756248414; c=relaxed/simple;
	bh=9pHeQJt1/MYlKymbX7M+EP5gyBqp0LWoaCGIR386URQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dNwe0q4wtUL18ABuboiEn0Ch1ex8FOBoN79FfM4cuMzdyaZPdEoF9UoZFIAuxxW7J5TTA+4hR+rnMeBwmzHH6LYbPqDttz6QRczyKZcCK7B3lWfA33sAH47qeBMogAL0dVeComjMPC5YMHbxzfxI1l4YGM8XTqMbndCf2YP1Z3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UMlZdcfu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 730D3C4CEF1;
	Tue, 26 Aug 2025 22:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756248413;
	bh=9pHeQJt1/MYlKymbX7M+EP5gyBqp0LWoaCGIR386URQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UMlZdcfuUX8YSN3Z59efdqyklSS9T58txV+MD8nsRHmwrbKWdWNBkzc/2uEI+7OS0
	 SlOz/p1L8jkvkR2xhglWzAgctHcBVUUZ+a2IZ6N2thQ5fLEBBQzNq9BqAvpaiQX3FV
	 FxI5ZnsK2fDh+ODA0jUvbNmaNP1DW+TMOq26B52bYnOavRDM7BuwacIV3zRE/Yl2uX
	 x/FiEZbHJJ7J9qnxOsEptJVic20YR8YbWRUWjekMc1W/C1t4/ja40Tac1lgQUvr0tb
	 B9BwL3/nyBOBua05WVd0BZ+Chb76jbeZ4BLz81Xsq21jHrcQQ7tE4hLTS+zBjjVN/L
	 igPTOx+BhMJKw==
Date: Tue, 26 Aug 2025 17:46:51 -0500
From: Rob Herring <robh@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: jic23@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 3/6] dt-bindings: iio: adc: add ade9000
Message-ID: <20250826224651.GA608287-robh@kernel.org>
References: <20250822160157.5092-1-antoniu.miclaus@analog.com>
 <20250822160157.5092-4-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250822160157.5092-4-antoniu.miclaus@analog.com>

On Fri, Aug 22, 2025 at 04:01:52PM +0000, Antoniu Miclaus wrote:
> Add devicetree bindings support for ade9000.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> changes in v5:
>  - remove clock-output-names property (simplified clock output)
>  - make interrupts, reset-gpios, and interrupt-names optional (removed from required list)  
>  - improve interrupt-names description to allow any subset of irq0, irq1, dready
>  - fix typo in description ("ADE9000 s a" -> "ADE9000 is a")
>  - fix spacing in description ("analog-to- digital" -> "analog-to-digital")
>  - uncomment clock example in device tree example
>  .../bindings/iio/adc/adi,ade9000.yaml         | 97 +++++++++++++++++++
>  1 file changed, 97 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml
> new file mode 100644
> index 000000000000..a1513ad41651
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml
> @@ -0,0 +1,97 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2025 Analog Devices Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/adi,ade9000.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices ADE9000 High Performance, Polyphase Energy Metering driver

Binding is for some h/w device, not a driver.

> +
> +maintainers:
> +  - Antoniu Miclaus <antoniu.miclaus@analog.com>
> +
> +description: |
> +  The ADE9000 is a highly accurate, fully integrated, multiphase energy and power
> +  quality monitoring device. Superior analog performance and a digital signal
> +  processing (DSP) core enable accurate energy monitoring over a wide dynamic
> +  range. An integrated high end reference ensures low drift over temperature
> +  with a combined drift of less than ±25 ppm/°C maximum for the entire channel
> +  including a programmable gain amplifier (PGA) and an analog-to-digital
> +  converter (ADC).
> +
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ADE9000.pdf
> +
> +$ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ade9000
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    maximum: 20000000
> +
> +  interrupts:
> +    maxItems: 3
> +
> +  interrupt-names:
> +    description: Optional interrupt names. Any subset of irq0, irq1, dready.
> +    maxItems: 3

This doesn't work for a subset.

> +
> +  reset-gpios:
> +    description:
> +      Must be the device tree identifier of the RESET pin. As the line is
> +      active low, it should be marked GPIO_ACTIVE_LOW.
> +    maxItems: 1
> +
> +  vdd-supply: true
> +
> +  vref-supply: true
> +
> +  clocks:
> +    description: External clock source when not using crystal
> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: clkin
> +
> +  "#clock-cells":
> +    description:
> +      ADE9000 can provide clock output via CLKOUT pin with external buffer.
> +    const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +  - vdd-supply
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    spi {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      adc@0 {
> +          compatible = "adi,ade9000";
> +          reg = <0>;
> +          spi-max-frequency = <7000000>;
> +
> +          #clock-cells = <0>;
> +          reset-gpios = <&gpio 4 GPIO_ACTIVE_LOW>;
> +          interrupts = <2 IRQ_TYPE_EDGE_FALLING>, <3 IRQ_TYPE_EDGE_FALLING>, <4 IRQ_TYPE_EDGE_FALLING>;
> +          interrupt-names = "irq0", "irq1", "dready";
> +          interrupt-parent = <&gpio>;
> +          clocks = <&ext_clock_24576khz>;
> +          clock-names = "clkin";
> +          vdd-supply = <&vdd_reg>;
> +      };
> +    };
> -- 
> 2.43.0
> 

