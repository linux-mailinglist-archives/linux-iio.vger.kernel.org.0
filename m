Return-Path: <linux-iio+bounces-25793-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B93C28DA5
	for <lists+linux-iio@lfdr.de>; Sun, 02 Nov 2025 11:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1D6FB347B13
	for <lists+linux-iio@lfdr.de>; Sun,  2 Nov 2025 10:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73CDF26B742;
	Sun,  2 Nov 2025 10:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NyHvOvgA"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B80D1F03D7;
	Sun,  2 Nov 2025 10:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762081064; cv=none; b=dEGBtAaLfDMsvAySeZqbXIxz6M82u0QJjNIPAeSHsJlktfEGu3mJWf7FVGzY64vmw3EDoLhoy1oYlr+Gar9Moe8jNHsv9pkrkoRAQYZvT+q5x0qtpa6ViNVpo1K1JcQ28XNeXtOJEXsYsX7zCAzwzNmOaoh8IRy9YfSRNetc6sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762081064; c=relaxed/simple;
	bh=uLQa0+JNOtcBBJFSW4uRxnOcmxwG+4MK7ICI1UcB7FM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LaTwO1tyTJGThdvM+AToUrMKF9eUbAoKyEL4WhG+dIpjocfz82pojMuisNIJi1yfVepGbRf5RGj0dxB0ZE4n+5aNZh4JyvsC6ggJ2cpIGhBBA6d7/+fQ2rDFI+ucrSo+LnFADLt7uABX+XjdMxRt1F4Izu24JbAiDvpvYXTM2K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NyHvOvgA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B448C4CEF7;
	Sun,  2 Nov 2025 10:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762081063;
	bh=uLQa0+JNOtcBBJFSW4uRxnOcmxwG+4MK7ICI1UcB7FM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NyHvOvgAhU7NRbPMmOZHtGqriqvGcdznEjucjpaALtEnC1Of/Q2lAbkiXXDVdjc0L
	 5EgVBRiCK6FzwbaJrvdbWyOmrqQltEUYfbEmArtylxBHKMpHhTSyfN27objDzdvgi7
	 Vortwa6I/2via68fJ/Y2LkhsvGIFHq+52g4wy5Wq1is487vYXrMhmfCzH+g6a9LIdO
	 0J9p5pVerl58yfSJVhVG0NUg8k1fxdP48gVdfxhIlpKoUJKnfitMNKXXgnpbxV3d0Y
	 nRVg91+nYVFq3r+ciYuSB0Pv4Vd2CCsb7F9Ax8+9CuaS+qYeXHnILyGa3Sq7PwYVFO
	 Vx23Rf008d+Jw==
Date: Sun, 2 Nov 2025 10:57:11 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: <robh@kernel.org>, <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: iio: amplifiers: add adl8113
Message-ID: <20251102105653.09941b27@jic23-huawei>
In-Reply-To: <20251031160405.13286-2-antoniu.miclaus@analog.com>
References: <20251031160405.13286-1-antoniu.miclaus@analog.com>
	<20251031160405.13286-2-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 31 Oct 2025 16:04:03 +0000
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add devicetree bindings for adl8113.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
>  .../bindings/iio/amplifiers/adi,adl8113.yaml  | 76 +++++++++++++++++++
>  1 file changed, 76 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/amplifiers/adi,adl8113.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/amplifiers/adi,adl8113.yaml b/Documentation/devicetree/bindings/iio/amplifiers/adi,adl8113.yaml
> new file mode 100644
> index 000000000000..4cc21c93233c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/amplifiers/adi,adl8113.yaml
> @@ -0,0 +1,76 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/amplifiers/adi,adl8113.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices ADL8113 Low Noise Amplifier with integrated bypass switches
> +
> +maintainers:
> +  - Antoniu Miclaus <antoniu.miclaus@analog.com>
> +
> +description: |
> +  The ADL8113 is a 10MHz to 12GHz Low Noise Amplifier with integrated bypass
> +  switches controlled by two GPIO pins (VA and VB). The device supports four
> +  operation modes:
> +    - Internal Amplifier: VA=0, VB=0 - Signal passes through the internal LNA
> +    - Internal Bypass: VA=1, VB=1 - Signal bypasses through internal path
> +    - External Bypass A: VA=0, VB=1 - Signal routes through external bypass path A
> +    - External Bypass B: VA=1, VB=0 - Signal routes through external bypass path B

These two external paths are a problem for description because there could be
literally anything between those OUT_A and IN_A etc.  To be useful it might be necessary
to describe that circuitry. 

> +
> +    https://www.analog.com/en/products/adl8113.html
> +
> +properties:
> +  compatible:
> +    const: adi,adl8113
> +
> +  vdd1-supply: true
> +
> +  vdd2-supply: true
> +
> +  vss2-supply: true
> +
> +  va-gpios:
> +    description:
> +      GPIO connected to the VA control pin. Must be specified as GPIO_ACTIVE_HIGH.
> +    maxItems: 1
> +
> +  vb-gpios:
> +    description:
> +      GPIO connected to the VB control pin. Must be specified as GPIO_ACTIVE_HIGH.
> +    maxItems: 1
> +
> +  adi,initial-mode:
> +    description: |
> +      Initial operation mode after device initialization
> +        0 - Internal Amplifier (default)
> +        1 - Internal Bypass
> +        2 - External Bypass A
> +        3 - External Bypass B
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1, 2, 3]
> +    default: 0

Given this only takes affect when the driver loads anyway, why have
an initial mode in DT?

> +
> +required:
> +  - compatible
> +  - va-gpios
> +  - vb-gpios
> +  - vdd1-supply
> +  - vdd2-supply
> +  - vss2-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    amplifier {
> +        compatible = "adi,adl8113";
> +        va-gpios = <&gpio 22 GPIO_ACTIVE_HIGH>;
> +        vb-gpios = <&gpio 23 GPIO_ACTIVE_HIGH>;
> +        vdd1-supply = <&vdd1_5v>;
> +        vdd2-supply = <&vdd2_3v3>;
> +        vss2-supply = <&vss2_neg>;
> +        adi,initial-mode = <0>;
> +    };
> +...


