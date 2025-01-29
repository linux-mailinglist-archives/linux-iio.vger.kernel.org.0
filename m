Return-Path: <linux-iio+bounces-14714-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4122FA2205D
	for <lists+linux-iio@lfdr.de>; Wed, 29 Jan 2025 16:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EF071885494
	for <lists+linux-iio@lfdr.de>; Wed, 29 Jan 2025 15:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3EF1DDC3B;
	Wed, 29 Jan 2025 15:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OuIf5Sk2"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D9214830F;
	Wed, 29 Jan 2025 15:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738164629; cv=none; b=lOQUsCjoQ05k35wEfUp8JKSZCDZgfFGhYmoqM+4zM57alOJdR6k0EtjQ+JozBtS6Np6KbForixU4W3e2QCjAga/KYF9R/zP73ba5xUuasQNxPxrV6Iuj38+Eujwht3BKn+LjGPuEU2BKzsAKiY355h61IBjJWC4Zy+f61wtPKCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738164629; c=relaxed/simple;
	bh=su917WJUDlLVVvJbeCquP6XrtRrkcWv8Akxqql7MZwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qf6GgJ/tiNsYHiiTN8n/F9mAysOxeZ31e0Jb3cWUpUtYmi9MiPid1LmchUV38zGSW+Vt1Zfv1gXC4l4UdQHi5cQtX3Y4HSartxLWJebPNWAmWcVqSBcBUmLzJTk7r1fmiu4qumfHgj0S9ptoannIxhZBP54WpvSp8OniqaxBq+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OuIf5Sk2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B6B5C4CED1;
	Wed, 29 Jan 2025 15:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738164628;
	bh=su917WJUDlLVVvJbeCquP6XrtRrkcWv8Akxqql7MZwE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OuIf5Sk2wPLPHidQ70Wc7i2FuIaFfDQnsj1KOYyYmjz6MRrRmKbvnVt4kNBHS18c/
	 t2qEornCCuaheq68E+6PfZfLzyA+brIDkqE4sqk9kThUOuz2ZMADqmH/iLjov+GT1J
	 Us4unzTVcX0I6Z1Zv32CBSr/rGbUVMY1xMbra10Ww8SolUgnEp3ewL6qUv4OxHGL+X
	 VgWGHXZrZ6kyMg+mGlRlaOcO1hng43ahZ5G2wCqS8Trmpxe6OBgEtFqJ27d7iQpBXs
	 Xo6HzAAHQzqG3KCFk/3PDQg5X0bkelr3VqsVFj0XWOe/eq+hyF/EN/B+gk3vH+rIo8
	 gk4XMy8rnkQ4w==
Date: Wed, 29 Jan 2025 09:30:27 -0600
From: Rob Herring <robh@kernel.org>
To: Robert Budai <robert.budai@analog.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, nuno.sa@analog.com,
	ramona.gradinariu@analog.com, antoniu.miclaus@analog.com,
	jic23@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	corbet@lwn.net, lanzano.alex@gmail.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v5 4/6] dt-bindings: iio: Add adis16550 bindings
Message-ID: <20250129153027.GA2121051-robh@kernel.org>
References: <20250129082053.19077-1-robert.budai@analog.com>
 <20250129082053.19077-5-robert.budai@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250129082053.19077-5-robert.budai@analog.com>

On Wed, Jan 29, 2025 at 10:20:44AM +0200, Robert Budai wrote:
> Document the ADIS16550 device devicetree bindings.
> 
> Co-developed-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
> Signed-off-by: Robert Budai <robert.budai@analog.com>
> ---
> 
> v5:
> - removed sync-mode binding
> - added binding for external clock frequency
> - removed adis16550w
> 
>  .../bindings/iio/imu/adi,adis16550.yaml       | 80 +++++++++++++++++++
>  MAINTAINERS                                   |  9 +++
>  2 files changed, 89 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml b/Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml
> new file mode 100644
> index 000000000000..4e9406168782
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml
> @@ -0,0 +1,80 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/imu/adi,adis16550.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#

blank line

> +title: Analog Devices ADIS16550 and similar IMUs

blank line

> +maintainers:
> +  - Nuno Sa <nuno.sa@analog.com>
> +  - Ramona Gradinariu <ramona.gradinariu@analog.com>
> +  - Antoniu Miclaus <antoniu.miclaus@analog.com>

blank line

> +properties:
> +  compatible:
> +    enum:
> +      - adi,adis16550
> +      - adi,adis16550w

blank line

> +  reg:
> +    maxItems: 1

blank line

> +  spi-cpha: true
> +  spi-cpol: true

blank line

> +  spi-max-frequency:
> +    maximum: 15000000

blank line

> +  vdd-supply: true

blank line

> +  interrupts:
> +    maxItems: 1

blank line

And so on. IOW, follow the style you see in *every* other schema doc.


> +  reset-gpios:
> +    description:
> +      Must be the device tree identifier of the RESET pin. If specified,
> +      it will be asserted during driver probe. As the line is active low,
> +      it should be marked GPIO_ACTIVE_LOW.
> +    maxItems: 1
> +  clocks:
> +    description: If not provided, then the internal clock is used.
> +    maxItems: 1
> +  clock-frequency:
> +    description: Clock frequency in Hz when an external clock is used.
> +    oneOf:
> +      - type: integer

Drop 'type'

> +        minimum: 1
> +        maximum: 128
> +      - type: integer

Drop 'type'

> +        minimum: 3000
> +        maximum: 4500
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - spi-cpha
> +  - spi-cpol
> +  - spi-max-frequency
> +  - vdd-supply
> +
> +allOf:
> +  - if:
> +      properties:
> +        clocks:
> +          maxItems: 1

clocks doesn't have to be present for this to be true. Hence the 
failure. But this can all be expressed as:

dependentRequired:
  clock: [clock-frequency]

> +    then:
> +      required:
> +        - clock-frequency
> +
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +additionalProperties: false
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        imu@0 {
> +            compatible = "adi,adis16550";
> +            reg = <0>;
> +            spi-max-frequency = <15000000>;
> +            spi-cpol;
> +            spi-cpha;
> +            vdd-supply = <&vdd>;
> +            interrupts = <4 IRQ_TYPE_EDGE_FALLING>;
> +            interrupt-parent = <&gpio>;
> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index aeb5f3cc58a1..5c59a183cd3f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1479,6 +1479,15 @@ W:	https://ez.analog.com/linux-software-drivers
>  F:	Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml
>  F:	drivers/iio/imu/adis16475.c
>  
> +ANALOG DEVICES INC ADIS16550 DRIVER
> +M:	Nuno Sa <nuno.sa@analog.com>
> +M:	Ramona Gradinariu <ramona.gradinariu@analog.com>
> +M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Supported
> +W:	https://ez.analog.com/linux-software-drivers
> +F:	Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml
> +
>  ANALOG DEVICES INC ADM1177 DRIVER
>  M:	Michael Hennerich <Michael.Hennerich@analog.com>
>  L:	linux-hwmon@vger.kernel.org
> -- 
> 2.43.0
> 

