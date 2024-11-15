Return-Path: <linux-iio+bounces-12312-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3A69CF314
	for <lists+linux-iio@lfdr.de>; Fri, 15 Nov 2024 18:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8E5B1F29937
	for <lists+linux-iio@lfdr.de>; Fri, 15 Nov 2024 17:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56041D63C3;
	Fri, 15 Nov 2024 17:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nDEZ+eFy"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA78166307;
	Fri, 15 Nov 2024 17:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731692219; cv=none; b=UlilDwCtXZMbJ8WUCzoPjLamzyD+jBMObhgs+8ll58kXTO+nweGfqOmPHlLWbXtqBeFHEYu3NhYRM67BuelHVjAN2GigY+jwhzcGRiSM8DP2a7tIRXV/BDxrJQOlC7eZwJoakRWl6catOfO1tDr0u7lzdaPeAsOBTEc9UscpNDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731692219; c=relaxed/simple;
	bh=IcilZRqcLlz7smR2XW5euoYnS0/VzBgcCuJBGtNwkGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E49VbdFQCuM37eTXfMC9MOy3rCch3NU08lUc1nJHokducYZp0FFxTS26WRs/4Jy8BPrRcl6hVLpGY0dX0fb2sp0d7xeElMgfkmvixmiDGXj4aaxrJQHfc9Gold7uatBblZyU2I1QKXJUbqBBeuBjH4AIBfHRjgxp1zkb/HcsvBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nDEZ+eFy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FD5AC4CECF;
	Fri, 15 Nov 2024 17:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731692219;
	bh=IcilZRqcLlz7smR2XW5euoYnS0/VzBgcCuJBGtNwkGA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nDEZ+eFyEgyFipvy9yImn1Cr33i4Euku8fTWKKAz5VHYTWXsB+dNKx+4NO2IUpeuu
	 XmuN9j6dfUqRgWbnRikiVFeBIbaH6tq1DcJ0JAPqmdff5IzHGntlfcr79Jn6NtaOF3
	 ssCF7gj1llWGF7gLL+lN9jkssGvZF+HqIwTxcvqLlH+EyfZBf31N2CIYAMafzBrdVE
	 7NsNEEbyAYPNANyPRhhMoayLY52gKKb0Lw/af4VtrF9gifYvB2ygJrVVoXi1w8GrdL
	 o+MdrDWatMe2/jn55+ZRkzbO3ZTYuIHxkQabx0hW+l9tYtvAF1Ue6j4UpZ3kYukQCx
	 dM6IDUiBeMLog==
Date: Fri, 15 Nov 2024 11:36:57 -0600
From: Rob Herring <robh@kernel.org>
To: "Sperling, Tobias" <Tobias.Sperling@softing.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jic23@kernel.org" <jic23@kernel.org>,
	"lars@metafoo.de" <lars@metafoo.de>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: Introduce ADS7138
Message-ID: <20241115173657.GA3440948-robh@kernel.org>
References: <BE1P281MB24207662EAC941780807F88BEF5A2@BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BE1P281MB24207662EAC941780807F88BEF5A2@BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM>

On Wed, Nov 13, 2024 at 02:41:08PM +0000, Sperling, Tobias wrote:
> >From 6a06973e1023ca6a128c8d426b4c87887117c084 Mon Sep 17 00:00:00 2001
> From: Tobias Sperling <tobias.sperling@softing.com>
> Date: Wed, 13 Nov 2024 14:52:49 +0100
> Subject: [PATCH 1/2] dt-bindings: iio: adc: Introduce ADS7138

Your patch is corrupted.

> 
> Add documentation for the driver of ADS7128 and ADS7138 12-bit, 8-channel
> analog-to-digital converters. These ADCs have a wide operating range and
> a wide feature set. Communication is based on the I2C interface.
> 
> Signed-off-by: Tobias Sperling <tobias.sperling@softing.com>
> ---
>  .../bindings/iio/adc/ti,ads7138.yaml          | 60 +++++++++++++++++++
>  1 file changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads7138.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads7138.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads7138.yaml
> new file mode 100644
> index 000000000000..c70ad5747828
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads7138.yaml
> @@ -0,0 +1,60 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/ti,ads7138.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments ADS7128/ADS7138 Analog to Digital Converter (ADC)
> +
> +maintainers:
> +  - Tobias Sperling <tobias.sperling@softing.com>
> +
> +description: |
> +  The ADS7128 is 12-Bit, 8-Channel Sampling Analog to Digital Converter (ADC)
> +  with an I2C interface.
> +
> +  Datasheets:
> +    https://www.ti.com/product/ADS7128
> +    https://www.ti.com/product/ADS7138
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,ads7128
> +      - ti,ads7138

What's the difference between the 2?

> +
> +  reg:
> +    maxItems: 1
> +
> +  avdd-supply:
> +    description:
> +      The regulator used as analog supply voltage as well as reference voltage.
> +
> +  interrupts:
> +    description:
> +      Interrupt on ALERT pin, triggers on low level.
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - avdd-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        adc@10 {
> +            compatible = "ti,ads7138";
> +            reg = <0x10>;
> +            avdd-supply = <&reg_stb_3v3>;
> +            interrupt-parent = <&gpio2>;
> +            interrupts = <12 IRQ_TYPE_LEVEL_LOW>;
> +        };
> +    };
> +...
> -- 
> 2.34.1
> 

