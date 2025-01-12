Return-Path: <linux-iio+bounces-14166-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6732CA0A87A
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 12:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52F02166590
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 11:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595561AA1C4;
	Sun, 12 Jan 2025 11:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UtIbQgTl"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BE3187553;
	Sun, 12 Jan 2025 11:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736680271; cv=none; b=bqvFpkNn2uRphLURX/dHc8UU09c9B5y11ehyZjqoqeOP5m3+AMyLBI0XaH/jZudMlHZk6z9y4pFZqqjFwlRZz2g4N9ZUZ8L72q9oPZ+Tq6rUduDa4Sx4KGTY7+XfcdKv0WNLe0UacPflr51swsxd/Iw5BTF2F+pXP8ZYkVJFvOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736680271; c=relaxed/simple;
	bh=jfdItxbg0JYmuum+A0lOphvYN8PWl4MNSSYUdQkROaU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lLpU/gH9Oc2cA12b2mBoXWDvrggzk5DmCDMuYOB+y7FJuwx3/ENR6Dz25Lct9CKjNJGuTB8o1tmqoMDBOjE+tUq6o7NShXUNa9lEJY1Yf9KRd2r80s9/La/B9co1rjowIhGcWvFjlJv9VEFOC4fIyyGYV2FUlIdTZYhH/44DZqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UtIbQgTl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02B0BC4CEDF;
	Sun, 12 Jan 2025 11:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736680270;
	bh=jfdItxbg0JYmuum+A0lOphvYN8PWl4MNSSYUdQkROaU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UtIbQgTl0TAzmYl9uenllQcucCDJTq97fEKlQTg056nFgig96yjcwSyUIwK15QPO9
	 EusYS3xDWN/F/7MPC3AJZzaM4PvaarX0uwa3vuW2+cXsQ8oMy92jOd79osLqeFnoHr
	 UhdLyeHUnoPhJNvi9J3mwc31D5nI6dY0gApH6HAR2d4Rw6vjN5caa7L9Vj84HZQM7V
	 sr18Ivjd87wuzTqztmbvMdkBDcxNRmUCO/17XCwP2WTLa55iZVnNeVg04sfbsCCEPN
	 p880TNEeQoCpSDI9GXybBtQYBbBVjzDRPEKWd7fxxS6Jow+OcxrUZ42xM8JceOujpc
	 MMHBotLVnqvnw==
Date: Sun, 12 Jan 2025 11:10:59 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Mikael Gonella-Bolduc via B4 Relay
 <devnull+mgonellabolduc.dimonoff.com@kernel.org>
Cc: mgonellabolduc@dimonoff.com, Lars-Peter Clausen <lars@metafoo.de>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nick
 Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>, Mikael Gonella-Bolduc
 <m.gonella.bolduc@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, Hugo Villeneuve <hvilleneuve@dimonoff.com>, Matti
 Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: iio: light: Add APDS9160 binding
Message-ID: <20250112111059.677f8708@jic23-huawei>
In-Reply-To: <20250106-apds9160-driver-v4-1-f88d9fc45d84@dimonoff.com>
References: <20250106-apds9160-driver-v4-0-f88d9fc45d84@dimonoff.com>
	<20250106-apds9160-driver-v4-1-f88d9fc45d84@dimonoff.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 06 Jan 2025 17:23:01 -0500
Mikael Gonella-Bolduc via B4 Relay <devnull+mgonellabolduc.dimonoff.com@kernel.org> wrote:

> From: Mikael Gonella-Bolduc <mgonellabolduc@dimonoff.com>
> 
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
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Proximity sensor cancellation pulse duration in half clock cycles.
> +      This parameter determines a cancellation pulse duration.
> +      The cancellation is applied in the integration phase to cancel out
> +      unwanted reflected light from very near objects such as tempered glass
> +      in front of the sensor.
> +    minimum: 0
> +    maximum: 63
> +    default: 0
> +
> +  ps-cancellation-current-coarse:

I've lost track on what we've discussed previously but I'm curious as to whether
we can end up with a cleaner binding for this.  We may well see other identical
controls in future, so nice to have something more 'generic'.  I'm not suggesting
we don't keep it vendor specific though as not sure it will generalize beyond
different broadcomm parts.

It is a multiple of nA, so can we just express the combination of
this and ps-cancellation-current-fine as a single parameter, probably in pA

The tricky bit being there seem to be holes, so the allowed list would be complex.

Even if we can't do that can we express it as two nA values rather than indexes?

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


