Return-Path: <linux-iio+bounces-23074-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AA01DB2E711
	for <lists+linux-iio@lfdr.de>; Wed, 20 Aug 2025 22:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6E5ED4E17C6
	for <lists+linux-iio@lfdr.de>; Wed, 20 Aug 2025 20:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6E42DA77B;
	Wed, 20 Aug 2025 20:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZzoXi1uk"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124E5258CDC;
	Wed, 20 Aug 2025 20:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755723521; cv=none; b=ljUdY/raL2v7HR3v0p2unmvvzyHvh50K51SrDc467Ip1gU5nMmIvhX+skjYKCHgT5FRzkChmS/chaJer986idLTPmsDGB+EEp9dP7aKvW52PYxj3mK8/2kMjUxWLL5SucC74jV+qnCbvGjp7J2Exd2G65T7uozHU5tsB5soZcB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755723521; c=relaxed/simple;
	bh=poaWP6dzopbmjIrDsPn4oWiiKrVjTMwMGwjEelXVxvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wk8EoZAeb2rVIl27UptLcK5HntmIwRzVRl5uq+ulgORQJ6+vnDkyx7SpLr9xvsgm3lZNybx3eG6IY1Ek8Cj8QZsUVRl9+9Pk4dJmvQuq7un8tGTjOQOb2cgooqpbOlKq4lKdBoxoVykl8Lc14lEni0sizbCbrNrYPKWjLItnWy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZzoXi1uk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 781C5C4CEED;
	Wed, 20 Aug 2025 20:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755723519;
	bh=poaWP6dzopbmjIrDsPn4oWiiKrVjTMwMGwjEelXVxvs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZzoXi1ukjWxn/kPSMPSabKqTD/h3ORlnKugYDnw8W+X0mC3ENIdPlYM0h9uAD4I1B
	 o1kpUOQNGfNvqkSJJw1GPgSmPFkpuOjprBrlgNqRaY/6/UqUnZRZUKnlqMtsmzlqR4
	 yaDXk++QJ70HPkimtjS9bvncrrCWzFPCfaBW0WFHk6k73Qj32SmVnoulEFWSpg07Ng
	 Z2OEbempQlar7Qx4cy99Bt6ZPRtlbof5xW30wWrl6Vsjn2qOwfKKoeYvAW0LGg8lXQ
	 XNqcZ/HTDIi1IJDrdMXdVfjvHKDzdnpWiB03g+lnnIuxlcRcQyoq+dHVb24wtfzBff
	 IGCZjspLHrLtg==
Date: Wed, 20 Aug 2025 15:58:38 -0500
From: Rob Herring <robh@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: jic23@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 3/5] dt-bindings: iio: adc: add ade9000
Message-ID: <20250820205838.GA986565-robh@kernel.org>
References: <20250815095713.9830-1-antoniu.miclaus@analog.com>
 <20250815095713.9830-4-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250815095713.9830-4-antoniu.miclaus@analog.com>

On Fri, Aug 15, 2025 at 09:56:36AM +0000, Antoniu Miclaus wrote:
> Add devicetree bindings support for ade9000.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> changes in v4:
>  - improve description formatting (remove unnecessary pipe symbols)
>  - move $ref to end and remove allOf section for cleaner structure
>  .../bindings/iio/adc/adi,ade9000.yaml         | 108 ++++++++++++++++++
>  1 file changed, 108 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml
> new file mode 100644
> index 000000000000..bd374c0d57d4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml
> @@ -0,0 +1,108 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2025 Analog Devices Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/adi,ade9000.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices ADE9000 High Performance, Polyphase Energy Metering driver
> +
> +maintainers:
> +  - Antoniu Miclaus <antoniu.miclaus@analog.com>
> +
> +description: |
> +  The ADE9000 s a highly accurate, fully integrated, multiphase energy and power
> +  quality monitoring device. Superior analog performance and a digital signal
> +  processing (DSP) core enable accurate energy monitoring over a wide dynamic
> +  range. An integrated high end reference ensures low drift over temperature
> +  with a combined drift of less than ±25 ppm/°C maximum for the entire channel
> +  including a programmable gain amplifier (PGA) and an analog-to- digital
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
> +    items:
> +      - const: irq0
> +      - const: irq1
> +      - const: dready
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
> +  clock-output-names:
> +    items:
> +      - const: clkout

No point in having this if there is only 1 possible value. Unless you 
have some need, just drop this.

> +
> +required:
> +  - compatible
> +  - reg
> +  - reset-gpios
> +  - interrupts
> +  - interrupt-names
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
> +          /* Optional: external clock instead of crystal */
> +          /* clocks = <&ext_clock_24576khz>; */
> +          /* clock-names = "clkin"; */
> +          clock-output-names = "clkout";
> +          vdd-supply = <&vdd_reg>;
> +      };
> +    };
> -- 
> 2.43.0
> 

