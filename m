Return-Path: <linux-iio+bounces-22704-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7FCCB25771
	for <lists+linux-iio@lfdr.de>; Thu, 14 Aug 2025 01:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B9F71C82C47
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 23:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C05E2FC899;
	Wed, 13 Aug 2025 23:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bAgBCGVL"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C522FC866;
	Wed, 13 Aug 2025 23:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755127443; cv=none; b=SI7AXFPKveArLAkILVOqS7libv39TqICprIPz25712ufta44/ilViRidxbwNkwyzJr9DM3c4ZhpG/BoNsnxpf1BMVARYf1r1HlEIwImytKSAPrFm5uZQ+v8KO14yh1b+mShbbrmWK/ZcxQrymrmgb9NTZ4oStzF3+PMDQgVps6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755127443; c=relaxed/simple;
	bh=14HP2KXJaaX6lYjuA7ln3CVRevS3gHQcCQ4Z1sbdRR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J3YgNDnWfD0e3NKdGjghfGJTNp2Va+rbH78UG1Oc/+dUDUYpNHkvANjXqv6I9UQtJjLmLUXQL5th32cZM/z7t92IlC1P2nCVrVphorx1Dmkr6xgN/HrRr/ajJxc2jodzA6FpDV05hEhEiTWGta9nacGMsHLc+/cOdKNEYP3yRGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bAgBCGVL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F195C4CEEB;
	Wed, 13 Aug 2025 23:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755127442;
	bh=14HP2KXJaaX6lYjuA7ln3CVRevS3gHQcCQ4Z1sbdRR4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bAgBCGVLihLVi/iuC48YBVbB3aDd9McJp7YMRvPDzJaLy7CTS2+gCfKFZX8IgNHRc
	 JTYA/iI9FIzIYH6SiPbTqtRyBWa+J0lQ7+asXst9++8pqxWRQ/8EtKVQB67i5Iuz57
	 wTUmI+/eLh+mkpMON1ypLoNLpFp4QYbMNtHIxS7RDWlYr8lt0sB8nweW6lXyQjIXwz
	 /4NdMBtPdNJE6Ax6Bgb1MUiqHpqO7dGsiog3vFk95P8q6v+/V6/jOMAVr06p6Kgddn
	 xQkKNUn8R1pOWBS9ckn9RiXNAIcnzwddWgku5/dpYXV2W1GQ2fX7Vj77paLpHHIdUV
	 OFNKquwSWH8cQ==
Date: Wed, 13 Aug 2025 18:24:01 -0500
From: Rob Herring <robh@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: jic23@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/4] dt-bindings: iio: adc: add ade9000
Message-ID: <20250813232401.GA1035450-robh@kernel.org>
References: <20250808141020.4384-1-antoniu.miclaus@analog.com>
 <20250808141020.4384-3-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250808141020.4384-3-antoniu.miclaus@analog.com>

On Fri, Aug 08, 2025 at 02:10:14PM +0000, Antoniu Miclaus wrote:
> Add devicetree bindings support for ade9000.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> changes in v3:
>  - fix $id schema URL format
>  - remove address/size-cells and channel subnodes
>  - add dready interrupt support
>  - add clock input/output support
>  - simplify device tree structure
>  .../bindings/iio/adc/adi,ade9000.yaml         | 110 ++++++++++++++++++
>  1 file changed, 110 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml
> new file mode 100644
> index 000000000000..07bc49acc920
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ade9000.yaml
> @@ -0,0 +1,110 @@
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
> +    description: |

Don't need '|'.

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
> +    description: ADE9000 can provide clock output via CLKOUT pin with external buffer

Wrap at 80 char. Or start on the next line.

> +    const: 0
> +
> +  clock-output-names:
> +    items:
> +      - const: clkout
> +
> +required:
> +  - compatible
> +  - reg
> +  - reset-gpios
> +  - interrupts
> +  - interrupt-names
> +  - vdd-supply
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
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

