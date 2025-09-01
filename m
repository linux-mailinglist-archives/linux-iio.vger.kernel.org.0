Return-Path: <linux-iio+bounces-23558-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 983BBB3D811
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 06:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C6CE1899411
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 04:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073382147E6;
	Mon,  1 Sep 2025 04:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HAmLAsQz"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39B8323E;
	Mon,  1 Sep 2025 04:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756699433; cv=none; b=ljinHAK5B9oHzTdecg8LpKjBcIRyIi8vNo78JgapEDsE0YAUAfEm8KZXI76k83CRasYmIJPu4EZoUzoTpHKklzopwKEYEoHVHQA8ALRcvOQS1JloVfgCDX7UCYpr2VAljF0gjIAjlF2uUvq0C7yUqs/pKECWFLfu/nznnecJj6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756699433; c=relaxed/simple;
	bh=ZFJ28hb7fkv8UsFli8+4lZwb6ixu2tkQjefwMMKbKUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j3ngbLp8liYFTERNxgndaYEjna+sQ6KrXBlW0Y//2IVR0EZE+3BW5DFZLwxKcTqrLPFwwcOuTnktM0+alCW+/yw+q+0L+9YEMYNg+yCV+H4gba7ObpEeedyeHtkrBibGpZaevwIsfINFYSdpEw+LAwfyMxrEqNExgGPwCvuPvGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HAmLAsQz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F17BC4CEF0;
	Mon,  1 Sep 2025 04:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756699433;
	bh=ZFJ28hb7fkv8UsFli8+4lZwb6ixu2tkQjefwMMKbKUA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HAmLAsQzPzjiDybPoouKC1hctWp6RD4iFJvGvO1XTTfIBBreNgH1mi+89OMrJbRlA
	 2uKLswogmZSrmQCZvqFS9r47NY2uWDEOg2WxrEPHkD9Exairk8ZBIaXtbZ84RfwQkI
	 mg8XChErwJlk2+9c7CigMU/c51MZOJVojOqjH3Wld3jKp8L8Ity2FPQQexCvp8NORi
	 qrxN5cm5TkqAq/fGYQNDJd7K+tO0NWjmXhTytXlGPT4HkCtFiORp5WN/JhOaAAurdz
	 5xGGjg1mpnVcWA8XMrMgBYByTnybT8ttl535sPLwrAnK05YME/mxcKAf1/3UMGjTWC
	 vW4iqJO29RSXQ==
Date: Mon, 1 Sep 2025 06:03:50 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: victor.duicu@microchip.com
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	marius.cristea@microchip.com, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: iio: temperature: add support for
 MCP998X
Message-ID: <20250901-piquant-rousing-skunk-14da73@kuoka>
References: <20250829143447.18893-1-victor.duicu@microchip.com>
 <20250829143447.18893-2-victor.duicu@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250829143447.18893-2-victor.duicu@microchip.com>

On Fri, Aug 29, 2025 at 05:34:46PM +0300, victor.duicu@microchip.com wrote:
> From: Victor Duicu <victor.duicu@microchip.com>
> 
> This is the devicetree schema for Microchip MCP998X/33 and MCP998XD/33D
> Multichannel Automotive Temperature Monitor Family.
> 
> Signed-off-by: Victor Duicu <victor.duicu@microchip.com>
> ---
>  .../iio/temperature/microchip,mcp9982.yaml    | 203 ++++++++++++++++++
>  1 file changed, 203 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/temperature/microchip,mcp9982.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9982.yaml b/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9982.yaml
> new file mode 100644
> index 000000000000..2f092e376fe8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9982.yaml
> @@ -0,0 +1,203 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/temperature/microchip,mcp9982.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip MCP998X/33 and MCP998XD/33D Multichannel Automotive
> +       Temperature Monitor Family

Looks like wrong indent.

> +
> +maintainers:
> +  - Victor Duicu <victor.duicu@microchip.com>
> +
> +description: |
> +  The MCP998X/33 and MCP998XD/33D family is a high-accuracy 2-wire multichannel
> +  automotive temperature monitor.
> +  The datasheet can be found here:
> +    https://ww1.microchip.com/downloads/aemDocuments/documents/MSLD/ProductDocuments/DataSheets/MCP998X-Family-Data-Sheet-DS20006827.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - microchip,mcp9933
> +      - microchip,mcp9933d
> +      - microchip,mcp9982
> +      - microchip,mcp9982d
> +      - microchip,mcp9983
> +      - microchip,mcp9983d
> +      - microchip,mcp9984
> +      - microchip,mcp9984d
> +      - microchip,mcp9985
> +      - microchip,mcp9985d
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    minItems: 2
> +    maxItems: 2
> +
> +  interrupt-names:
> +    description:
> +      -alert-therm is used to handle a HIGH or LOW limit.
> +      -therm-addr is used to handle a THERM limit on chips
> +      without "D" in the name.
> +      -sys-shutdown is used to handle a THERM limit on chips
> +      with "D" in the name.

Descriptions go to interrupts.

> +    items:
> +      - const: alert-therm
> +      - const: therm-addr
> +      - const: sys-shutdown

I don't think you ever tested this. This does not match interrupts.

> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +  microchip,enable-anti-parallel:
> +    description:
> +      Enable anti-parallel diode mode operation.
> +      MCP9984/84D/85/85D and MCP9933/33D support reading two external diodes
> +      in anti-parallel connection on the same set of pins.
> +    type: boolean
> +
> +  microchip,parasitic-res-on-channel1-2:
> +    description:
> +      Indicates that the chip and the diodes/transistors are sufficiently far
> +      apart that a parasitic resistance is added to the wires, which can affect
> +      the measurements. Due to the anti-parallel diode connections, channels
> +      1 and 2 are affected together.
> +    type: boolean
> +
> +  microchip,parasitic-res-on-channel3-4:
> +    description:
> +      Indicates that the chip and the diodes/transistors are sufficiently far
> +      apart that a parasitic resistance is added to the wires, which can affect
> +      the measurements. Due to the anti-parallel diode connections, channels
> +      3 and 4 are affected together.
> +    type: boolean
> +
> +  vdd-supply: true
> +
> +patternProperties:
> +  "^channel@[1-4]$":
> +    description:
> +      Represents the external temperature channels to which
> +      a remote diode is connected.
> +    type: object
> +
> +    properties:
> +      reg:

Missing min/maxItems.

> +        items:
> +          minimum: 1
> +          maximum: 4
> +
> +      microchip,ideality-factor:
> +        description:
> +          Each channel has an ideality factor.
> +          Beta compensation and resistance error correction automatically
> +          correct for most ideality errors. So ideality factor does not need
> +          to be adjusted in general.
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        default: 18
> +
> +      label:
> +        description: Unique name to identify which channel this is.
> +
> +    required:
> +      - reg
> +
> +    additionalProperties: false

Best regards,
Krzysztof


