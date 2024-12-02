Return-Path: <linux-iio+bounces-12930-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E669DFC2A
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 09:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCC0DB21798
	for <lists+linux-iio@lfdr.de>; Mon,  2 Dec 2024 08:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723CB1F9F52;
	Mon,  2 Dec 2024 08:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VFyZMjAj"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B8C2940F;
	Mon,  2 Dec 2024 08:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733128883; cv=none; b=mpNt5nHFC4RGWfdVEeBAp6BDcnxgV8vHiQgtPkwEM8/mRYI3xtI0KxAJ62YMOEizPXLlnfcpFbUNb1AqAa3Rx4roK9CJzQwBMjP0XLkajtDex6j5w8ir3nUcbz9VuMTsotnahyPBafCp/o3hrq1Jfg5sf5TraqQTmwFhha2ltpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733128883; c=relaxed/simple;
	bh=vVttW9NMJqQACrZODazCpXnpnmTn+J+x5pTHE6w9FD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j9rKl6XcBSXfuLWclt0Mm/R2H9xmJ50X1b0UEypEgfFDln1EycpFuRiZY1J9J7BzDBeLQdlPeMEtlzNsd97PCG63SeoXz9tdpM880hkXWbkSfq4K/imJC5+s7+KPOg9pHHjqNO2T38msvVkMqjMU4SPj6JGkNdP68hiE8bYUB84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VFyZMjAj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14A26C4CED2;
	Mon,  2 Dec 2024 08:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733128882;
	bh=vVttW9NMJqQACrZODazCpXnpnmTn+J+x5pTHE6w9FD4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VFyZMjAjSmD0ltAwlfHFzvd2FD9OtQY5+DdGGp5UfOlg6otPn7p/FKoj2qTf+e5DH
	 tDnAaK9vC8/RgqmrlB2bT5rriFredNM+6wxGf2h0tPonR38Wme5cey47pVfkeJjtNa
	 UO1NGKdj7+S+W649vU3And7Ale7R4tbI5jqqlD3zpXEmKMI73a3ZkmASXglkNBMHxI
	 9B/oZ+168eYrn6ZQeJEHIoaUaiggRHcIn7hxJqV+PvRiD7nFNBRW/Yv/+tq44AXTJd
	 ZezGJcHEUqd5s92zKdd3RXcJqpQlgJT5FJkIARcUFkOOL3A3Kn10rjv3o3KwTDkQJc
	 r+CqVjA9E6gzQ==
Date: Mon, 2 Dec 2024 09:41:20 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Paul Kocialkowski <paulk@sys-base.io>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: iio: Add TI OPT4048 color sensor
 bindings
Message-ID: <v67xcjoyl56o5bw6rri6k3vwst7y7bhq7inncak6nvxtgcdaic@t6gxqawqh5ah>
References: <20241130174212.3298371-1-paulk@sys-base.io>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241130174212.3298371-1-paulk@sys-base.io>

On Sat, Nov 30, 2024 at 06:42:11PM +0100, Paul Kocialkowski wrote:
> The Texas Instruments OPT4048 is a XYZ tristimulus color sensor.
> 
> It requires a VDD power supply and can optionally support an interrupt.

A nit, subject: drop second/last, redundant "bindings". The
"dt-bindings" prefix is already stating that these are bindings.
See also:
https://elixir.bootlin.com/linux/v6.7-rc8/source/Documentation/devicetree/bindings/submitting-patches.rst#L18

> 
> Signed-off-by: Paul Kocialkowski <paulk@sys-base.io>
> ---
>  .../bindings/iio/light/ti,opt4048.yaml        | 54 +++++++++++++++++++
>  1 file changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/ti,opt4048.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/ti,opt4048.yaml b/Documentation/devicetree/bindings/iio/light/ti,opt4048.yaml
> new file mode 100644
> index 000000000000..e2b7472ab588
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/light/ti,opt4048.yaml
> @@ -0,0 +1,54 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/light/ti,opt4048.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments OPT4048 XYZ tristimulus color sensor
> +
> +maintainers:
> +  - Paul Kocialkowski <paulk@sys-base.io>
> +
> +description: |

Do not need '|' unless you need to preserve formatting.

> +  The device supports both interrupt-driven and interrupt-less operation,
> +  depending on whether an interrupt property is present in the device-tree.
> +
> +properties:
> +  compatible:
> +    const: ti,opt4048
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +    description: |

Do not need '|' unless you need to preserve formatting.

> +      The interrupt is detected on a falling edge, with a low level asserted
> +      for 1 us. It might be missed because of hardware interrupt debouncing
> +      mechanisms due to this short time.
> +
> +  vdd-supply: true
> +
> +additionalProperties: false

This goes after required: block.

> +
> +required:
> +  - compatible
> +  - reg
> +  - vdd-supply
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        light-sensor@44 {
> +          compatible = "ti,opt4048";

Messed indentation, keep 4 spaces here.

With all above changes:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


