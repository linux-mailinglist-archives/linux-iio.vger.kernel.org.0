Return-Path: <linux-iio+bounces-16166-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1215CA491F3
	for <lists+linux-iio@lfdr.de>; Fri, 28 Feb 2025 08:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60E943B73F8
	for <lists+linux-iio@lfdr.de>; Fri, 28 Feb 2025 07:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0FF1C5F29;
	Fri, 28 Feb 2025 07:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sJqk/I4Q"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F401BD9C5;
	Fri, 28 Feb 2025 07:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740726668; cv=none; b=AmZ4C0MyWlJgg0xyxIiCAT8zOjaYniegfWRwU+ye6UTiYU6F3n/fDXcRubDybHy/fqoZOr0bQvhjb80JMmzPk+8U+rg6SYXlylDszZm99GxmHQgxVXGlmCmFgtNgx9gn68fY/a5v2qkjykeqaG0shtEhFRa8euGYUX5SGXTfiV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740726668; c=relaxed/simple;
	bh=9Avyi3xa4JVAe9WdyAcqPktVRWRBaZG/CqhP8E2C2oM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mitY8rtWfmdMOIXpRMS4XWs7uab+PBx3Qf6b9Xpu0gWcw1oK47cXwEbD+ucRsJaMmInCUHik6tuLxUg7ViLZu2TLvo/xw/E36Vgiw1SUWl5zmpsJOncJ3d2712Zge4ihdhwFT0eGYwPKcvgZ9f1bXAnw5ghRBqwqwnoZz/ngOoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sJqk/I4Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38432C4CED6;
	Fri, 28 Feb 2025 07:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740726668;
	bh=9Avyi3xa4JVAe9WdyAcqPktVRWRBaZG/CqhP8E2C2oM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sJqk/I4QeNUiqYRTauretLZl9olttK72N5w7nY42+WHyBnwq7eQ2v10ZdErtHDIrh
	 fTa2/ou6a6Jy7gjeMNty5du84titWVb2h+mY42fBaxELnT+QLntApG8pPdYG5VZaCZ
	 pusIcddTOfYvVgoKgZ4oFBO+1JF2TB8FkaD4gkiHCubmuy6aBExSRqNd3c3GQ7i7K8
	 mhRozXHV9bsxy6iVTKAGQe/YLSwPAQyUh3NxC1SwBFDu1sIFDPnvIzevaD22dOviv3
	 XNustcaThdTr52ar2YGe1fwCbYHndJnXOH+4wqy/yVAECbchBPfvcK0tbr1z3zBRIQ
	 zugo9ab/7ktew==
Date: Fri, 28 Feb 2025 08:11:04 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: David Jander <david@protonic.nl>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-doc@vger.kernel.org, Nuno Sa <nuno.sa@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [RFC PATCH 6/7] dt-bindings: motion: Add adi,tmc5240 bindings
Message-ID: <20250228-groovy-lyrical-skunk-751ee3@krzk-bin>
References: <20250227162823.3585810-1-david@protonic.nl>
 <20250227162823.3585810-7-david@protonic.nl>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250227162823.3585810-7-david@protonic.nl>

On Thu, Feb 27, 2025 at 05:28:22PM +0100, David Jander wrote:
> +$id: http://devicetree.org/schemas/motion/adi,tmc5240.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices TMC5240 Stepper Motor controller
> +
> +maintainers:
> +  - David Jander <david@protonic>
> +
> +description: |

Do not need '|' unless you need to preserve formatting.

> +   Stepper motor controller with motion engine and SPI interface.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,tmc5240
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  enable-supply:
> +    description: Optional external enable supply to control SLEEPn pin. Can

That's odd. regular pins are not supplies. This must be named after
physical supplies. There is vdd18, vcc, vcp but nothing about enable
supply in datasheet.


> +      be shared between several controllers.

Second sentence is both redundant and really not relevant to this
binding. It's not this binding which decides about sharing.


> +
> +  clocks:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +  - $ref: /schemas/motion/common.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        motor@0 {
> +            compatible = "adi,tmc5240";
> +            reg = <0>;
> +            interrupts-extended = <&gpiok 7 0>;

Include header and use standard defines for flags.

> +            clocks = <&clock_tmc5240>;
> +            enable-supply = <&stpsleepn>;
> +            spi-max-frequency = <1000000>;

Where are any other properties from common schema?

Best regards,
Krzysztof


