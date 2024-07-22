Return-Path: <linux-iio+bounces-7799-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B344939493
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jul 2024 22:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAD2D28249F
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jul 2024 20:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14EC1CA94;
	Mon, 22 Jul 2024 20:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E2p7+NxQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966E51BC20;
	Mon, 22 Jul 2024 20:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721678716; cv=none; b=AbyJUS7P3gFWIJdFWfejyaT4a+wMLo6k0OHAJ+uGCF7So/1j4dF4d1m0RGgcnvO4U2EB3RJJVNTvXlhBGFg3olLjT6Nrs3v2MF3XVHI7n0h1lpx0haslmmqHqsHG/s6gh73aGDQeQONxGf1R3GH84hwAuQVlK/hCqwA5ZEpU29w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721678716; c=relaxed/simple;
	bh=3WQt62yUojKqc8sl3CY5tmZshlNVs9j+qKup+n524hE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RdRUhVlL/63wgRYqn1p0AHgsZNdf3u2pIovxo/AdOkngPvW1s1rVcQDSwwmlCq3JZabELR+YMZhNOGy3SFdU8Bpob3FyNlDOFxMWiWwOOAayaPR2QBW+X2NKnDOB6uhhX1c8XFYrOy2lg1hd0F43tDpTp8gU0+sYq1qafq21PPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E2p7+NxQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1179BC116B1;
	Mon, 22 Jul 2024 20:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721678716;
	bh=3WQt62yUojKqc8sl3CY5tmZshlNVs9j+qKup+n524hE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=E2p7+NxQLQgO/16E5oCu2ZLq6Qjv9GfVUUFRylB5/d3WweYtTWHsIyoLFPQcwiT2n
	 +Hjh5LrhaH53+d4Tp8Opm4U7UJQiicww2GyfUoJx0fX3sVk0pgbPk1ObzwZ0V22drU
	 pIBvIVDvr5aCg0imwLrNY0ttFrD4s8k5VVqrADRiZEouwIdsOsDzOmCGbtGCkI1Q15
	 2v1Fw/5EC/Vw869Gaw0DRNS8hSqtepGAk6AK6yCCMZ+DHtLVH4u+rwryW5nY7Sqz3S
	 HQdxMjQ4dTjrzkq9/XFKzA8l2gpmXvYHVHJj+UxHMpGrq0QmVcvu4isT/Y9mSSdfmY
	 //WbxPGppQZkA==
Date: Mon, 22 Jul 2024 21:05:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matteo Martelli <matteomartelli3@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Marius Cristea <marius.cristea@microchip.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: iio: adc: add binding for pac1921
Message-ID: <20240722210507.76d82f54@jic23-huawei>
In-Reply-To: <20240722-iio-pac1921-v3-1-05dc9916cb33@gmail.com>
References: <20240722-iio-pac1921-v3-0-05dc9916cb33@gmail.com>
	<20240722-iio-pac1921-v3-1-05dc9916cb33@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Jul 2024 12:03:18 +0200
Matteo Martelli <matteomartelli3@gmail.com> wrote:

> Add binging for Microchip PAC1921 Power/Current monitor
> 
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Matteo Martelli <matteomartelli3@gmail.com>
> ---
>  .../bindings/iio/adc/microchip,pac1921.yaml        | 71 ++++++++++++++++++++++
>  1 file changed, 71 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/microchip,pac1921.yaml b/Documentation/devicetree/bindings/iio/adc/microchip,pac1921.yaml
> new file mode 100644
> index 000000000000..b6f01b79b91d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/microchip,pac1921.yaml
> @@ -0,0 +1,71 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/microchip,pac1921.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip PAC1921 High-Side Power/Current Monitor with Anaog Output
> +
> +maintainers:
> +  - Matteo Martelli <matteomartelli3@gmail.com>
> +
> +description: |
> +  The PAC1921 is a power/current monitoring device with an analog output
> +  and I2C/SMBus interface.
> +
> +  Datasheet can be found here:
> +  https://ww1.microchip.com/downloads/en/DeviceDoc/PAC1921-Data-Sheet-DS20005293E.pdf
> +
> +properties:
> +  compatible:
> +    const: microchip,pac1921
> +
> +  reg:
> +    maxItems: 1
> +
> +  vdd-supply: true
> +
> +  "#io-channel-cells":
> +    const: 1
> +
> +  shunt-resistor-micro-ohms:
> +    description:
> +      Value in micro Ohms of the shunt resistor connected between
> +      the SENSE+ and SENSE- inputs, across which the current is measured.
> +      Value is needed to compute the scaling of the measured current.
> +
> +  label:
> +    description: Unique name to identify which device this is.
> +
> +  microchip,read-int-gpios:
Given I agree with Conor about not needing a vendor prefix for gpios
so you'll be respinning anyway:
Would you mind renaming this to longer form: read-integrate-gpios?

I was briefly assuming it was a INTerrupt pin.

> +    description:
> +      READ/INT input pin to control the current state of the device, either in
> +      the INTEGRATE state when driven high, or in the READ state when driven low.
> +      When not connected the pin is floating and it can be overridden by the
> +      INT_EN register bit after asserting the READ/INT_OVR register bit.
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - vdd-supply
> +  - shunt-resistor-micro-ohms
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        adc@4c {
> +            compatible = "microchip,pac1921";
> +            reg = <0x4c>;
> +            vdd-supply = <&vdd>;
> +            #io-channel-cells = <1>;
> +            label = "vbat";
> +            shunt-resistor-micro-ohms = <10000>;
> +        };
> +    };
> +...
> 


