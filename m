Return-Path: <linux-iio+bounces-13999-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E69A04D85
	for <lists+linux-iio@lfdr.de>; Wed,  8 Jan 2025 00:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 333A318864C7
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2025 23:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142341EBA07;
	Tue,  7 Jan 2025 23:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P320ZcpE"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA581E32DB;
	Tue,  7 Jan 2025 23:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736292561; cv=none; b=j5BHYFlmx4CzUB36ut14gJofgxy0C0cuWMGitbbTa+TJToDIS1ib4DPx5/0fdO3WHjRfGqT5mxBOf7j6+uHvTcTmfbzrvH8lUEy9a8ehzuuWuipXEFqW08uym2MVWanTkfh6LC4pLTNdFcpEo9u64GElyVDX71lZHmIwcSeUOOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736292561; c=relaxed/simple;
	bh=sRZplOxRM+HP2quKb3NThBj6ijHhm4bYSbuwor2VduI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kNhKHLF3Ip41rDRaG/vYlBvF1AyP5lE4lU/cFjSFb6ajoMgah4ea/x5jhNdy/BOY1zpOCT6vEq7NGyhCOUomqvLl7m/OGKXwgYFMD8KKCY3qwbyH9oqvGeLOrVx63GVNhftI8B2E8GJFWa8S5XZ0QUDcMx5pExVjaJzHS1rCbxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P320ZcpE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AB0FC4CED6;
	Tue,  7 Jan 2025 23:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736292560;
	bh=sRZplOxRM+HP2quKb3NThBj6ijHhm4bYSbuwor2VduI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P320ZcpEJk4DgqHxfU/hRRxPckwGagcM3WTKM3QwXnWNGGe4DSICahWNiZDdAXhfE
	 UjQA1RbWpRmZx8QizdG1bAQV8CItRurBzFPK2Kbk85TJ26wmr8bfq9y0RaKKjDw8j6
	 b8LND6HdUlD9pV5yOQ2NHzWfroDjV0Z49Zah1/Kk9h9q63FfXDTgthNcZdMWOla03b
	 xuGuic87y+L/dAujrbbMzlkfXOjHZUIfwz6OpServ2zdNQdbbmcGcrEbmJOGRx1+Vv
	 wVO414D3qe+iHAIPmb1pkHDNk/iNB5IHY4kBhGVSGDrf9l3Y1uSZvvoAr70vUCWF99
	 OL/6rDD4n66Dg==
Date: Tue, 7 Jan 2025 17:29:19 -0600
From: Rob Herring <robh@kernel.org>
To: Mikael Gonella-Bolduc <mgonellabolduc@dimonoff.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Mikael Gonella-Bolduc <m.gonella.bolduc@gmail.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: iio: light: Add APDS9160 binding
Message-ID: <20250107232919.GA2044181-robh@kernel.org>
References: <20250106-apds9160-driver-v4-0-f88d9fc45d84@dimonoff.com>
 <20250106-apds9160-driver-v4-1-f88d9fc45d84@dimonoff.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250106-apds9160-driver-v4-1-f88d9fc45d84@dimonoff.com>

On Mon, Jan 06, 2025 at 05:23:01PM -0500, Mikael Gonella-Bolduc wrote:
> Add device tree bindings for APDS9160
> Note: Using alternate email for maintainer
> 
> Signed-off-by: Mikael Gonella-Bolduc <mgonellabolduc@dimonoff.com>
> ---
>  .../bindings/iio/light/brcm,apds9160.yaml          | 86 ++++++++++++++++++++++
>  1 file changed, 86 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/brcm,apds9160.yaml b/Documentation/devicetree/bindings/iio/light/brcm,apds9160.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..756d46c2edb171da840ee49a7339cb781fe84ad2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/light/brcm,apds9160.yaml
> @@ -0,0 +1,86 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/light/brcm,apds9160.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Broadcom Combined Proximity & Ambient light sensor
> +
> +maintainers:
> +  - Mikael Gonella-Bolduc <m.gonella.bolduc@gmail.com>
> +
> +description: |
> +  Datasheet: https://docs.broadcom.com/docs/APDS-9160-003-DS
> +
> +properties:
> +  compatible:
> +    enum:
> +      - brcm,apds9160
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  vdd-supply: true
> +
> +  ps-cancellation-duration:

These all need a vendor prefix.

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |

Don't need '|' if no formatting to preserve.

> +      Proximity sensor cancellation pulse duration in half clock cycles.
> +      This parameter determines a cancellation pulse duration.

But maybe this is a paragraph break. If so, blank line between 
paragraphs. And '>' is more appropriate than '|' in that case.

> +      The cancellation is applied in the integration phase to cancel out
> +      unwanted reflected light from very near objects such as tempered glass
> +      in front of the sensor.
> +    minimum: 0

That's already the min being unsigned.

> +    maximum: 63
> +    default: 0
> +
> +  ps-cancellation-current-coarse:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Proximity sensor crosstalk cancellation current coarse value.
> +      This parameter adjust the current in steps of 60 nA up to 240 nA.
> +      This parameter is used in conjunction with the cancellation duration.
> +    minimum: 0
> +    maximum: 4
> +    default: 0
> +
> +  ps-cancellation-current-fine:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Proximity sensor crosstalk cancellation current fine value.
> +      This parameter adjust the current in steps of 2.4 nA up to 36 nA.
> +      This parameter is used in conjunction with the cancellation duration.
> +    minimum: 0
> +    maximum: 15
> +    default: 0
> +
> +required:
> +  - compatible
> +  - reg
> +  - vdd-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        light-sensor@53 {
> +            compatible = "brcm,apds9160";
> +            reg = <0x53>;
> +            vdd-supply = <&vdd_reg>;
> +            interrupts = <29 IRQ_TYPE_EDGE_FALLING>;
> +            interrupt-parent = <&pinctrl>;
> +            ps-cancellation-duration = <10>;
> +            ps-cancellation-current-coarse = <2>;
> +            ps-cancellation-current-fine = <10>;
> +        };
> +    };
> +...
> 
> -- 
> 2.34.1
> 

