Return-Path: <linux-iio+bounces-26123-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 659F4C45486
	for <lists+linux-iio@lfdr.de>; Mon, 10 Nov 2025 08:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0B5264E85CE
	for <lists+linux-iio@lfdr.de>; Mon, 10 Nov 2025 07:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B30E2F12D4;
	Mon, 10 Nov 2025 07:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nF7nczR4"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA8A2F3605;
	Mon, 10 Nov 2025 07:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762761579; cv=none; b=li/SM8yV9FA7YOT/AcoWUEuw7ASErb2HGHuSMAtkKS4oaHf5k0/DyZwBQFXp+cMG2fRT5Xnc84UEDik56v5CM1fGFMBNEwXxsKFXi/yv/TREU7EIK6pIX5e78Ynj8yRSbH4OV7fUPlfs6y+D+0WlDJbB1gy/dWBOuSEM3qAQ26A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762761579; c=relaxed/simple;
	bh=Ky4ZUbF427UA1ak5hD3hxfs9YMIHo7w0v8HQSA52ZSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H+vaTy+Xe+n/ttzNO3T5QBN0ombtrz5JYQVtPZJLHfa80xNuInVabbNJwPtsCwYocFA50YWnryvkU/NyYjEJda6GGvPYlH8wpj5WDw9uPrtkGD4RR+jm1OshKSvyOWzd5cyvhk0ijz2ew+8HUjyAePsSZD6w2qCqNQvmMIdkf48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nF7nczR4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D6F1C4AF0B;
	Mon, 10 Nov 2025 07:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762761578;
	bh=Ky4ZUbF427UA1ak5hD3hxfs9YMIHo7w0v8HQSA52ZSo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nF7nczR4VaS5idOtiTinYLTvd5C1dCOOK9Ot68JAgL+Le+7WryMEjUTLPVwzzZP5x
	 Q/XTjtI2E99bTUFOW60XU4BMh8wGgbeVsZkro5xlokTDnRt6iS021RT9aLk1J28kyJ
	 ATua9Lpc3wRUBayBCVtjM2EN/5eJrz7RcseWwEgdLnL/QK4TN5h7W+PMFUlBFXs4Q6
	 Zic+84U3r4LHLypMc/41px3sPHf5FVmgahgfaB4nfFvR4gXIcEZAMkcajsQ1REqUBR
	 l5gX+IY0wmCBZhE9gS4CrpNDoAOpRLKJwi3UPv3aoNvF7KvhQZvq6s202d6fo/vF6u
	 +noU7jxGRS+bw==
Date: Mon, 10 Nov 2025 08:59:36 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ajith Anandhan <ajithanandhan0406@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: Add TI ADS1120 binding
Message-ID: <20251110-curly-ultra-coucal-d7cc32@kuoka>
References: <20251109141119.561756-1-ajithanandhan0406@gmail.com>
 <20251109141119.561756-2-ajithanandhan0406@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251109141119.561756-2-ajithanandhan0406@gmail.com>

On Sun, Nov 09, 2025 at 07:41:18PM +0530, Ajith Anandhan wrote:
> Add device tree binding documentation for the Texas Instruments
> ADS1120.

A nit, subject: drop second/last, redundant "binding". The
"dt-bindings" prefix is already stating that these are bindings.
See also:
https://elixir.bootlin.com/linux/v6.17-rc3/source/Documentation/devicetree/bindings/submitting-patches.rst#L18

> 
> The binding defines required properties like compatible, reg, and
> SPI configuration parameters.

Drop sentence, completely redundant. We can read the diff.

> 
> Signed-off-by: Ajith Anandhan <ajithanandhan0406@gmail.com>
> ---
>  .../bindings/iio/adc/ti,ads1120.yaml          | 109 ++++++++++++++++++
>  1 file changed, 109 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads1120.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1120.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads1120.yaml
> new file mode 100644
> index 000000000..2449094af
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1120.yaml
> @@ -0,0 +1,109 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/ti,ads1120.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments ADS1120 4-channel, 16-bit, 2kSPS ADC
> +
> +maintainers:
> +  - Ajith Anandhan <ajithanandhan0406@gmail.com>
> +
> +description: |
> +  The ADS1120 is a precision, 16-bit, analog-to-digital converter (ADC)
> +  that features two differential or four single-ended inputs through a
> +  flexible input multiplexer.
> +
> +  Datasheet: https://www.ti.com/lit/gpn/ads1120
> +
> +properties:
> +  compatible:
> +    const: ti,ads1120
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    minItems: 1
> +    maxItems: 2
> +    description: |

Do not need '|' unless you need to preserve formatting.

> +      Interrupts for the DRDY (data ready) pin(s). The device can output
> +      DRDY on a dedicated pin or multiplex it with DOUT. If both pins are
> +      wired, both interrupts can be specified.
> +
> +  interrupt-names:
> +    minItems: 1
> +    maxItems: 2
> +    items:
> +      enum:
> +        - drdy
> +        - dout

No, this cannot be flexible so much. Look at existing examples how this
is supposed to be written.

minItems: 1
items:
 - enum
 - const

> +
> +  avdd-supply:
> +    description: |


Do not need '|' unless you need to preserve formatting.


> +      Analog power supply, typically 2.3V to 5.5V.
> +
> +  vref-supply:
> +    description: |

Do not need '|' unless you need to preserve formatting.

> +      Optional external voltage reference. Can be connected to either
> +      REFP0/REFN0 or REFP1/REFN1 pins. If not supplied, the internal
> +      2.048V reference is used.
> +
> +  ti,avdd-is-ref:
> +    type: boolean
> +    description: |

Do not need '|' unless you need to preserve formatting.

> +      If present, indicates that the AVDD supply voltage is of sufficient
> +      quality and stability to be used as the voltage reference instead of
> +      the internal reference. This allows the driver to select AVDD as the
> +      reference source for potentially better performance.

Driver? Aren't you just describing the case when AVDD is connected to
REF pins?

> +
> +  clocks:
> +    maxItems: 1
> +    description: |

Do not need '|' unless you need to preserve formatting.

> +      Optional external clock input. If not specified, the internal

Drop first sentence, completely redundant. Schema defines what is
optional, not your description. Can it be something else than external
clock input? No, it cannot. Please write informative descriptions, not
just inflate the text.

> +      oscillator is used.
> +
> +  spi-max-frequency:
> +    maximum: 4000000
> +
> +  spi-cpha: true
> +
> +  "#io-channel-cells":
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg

avdd-suply

> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +unevaluatedProperties: false

Best regards,
Krzysztof


