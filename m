Return-Path: <linux-iio+bounces-26829-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE414CAAA2C
	for <lists+linux-iio@lfdr.de>; Sat, 06 Dec 2025 17:27:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3F42302E073
	for <lists+linux-iio@lfdr.de>; Sat,  6 Dec 2025 16:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC662E764B;
	Sat,  6 Dec 2025 16:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k2+Goi7g"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EA425CC40;
	Sat,  6 Dec 2025 16:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765038413; cv=none; b=hieXIUWHFMYCbxFi+wRDy7R1MbX7WFppmv4q3mler/fykKv3fvsJnn9eZkAWW8l9LkhDu5zV13JuwmWnBnWf8fPo5fqSOu5yiXLEnX+PVwdKWWRdryCMTqijRtWUPDC6KkxFYf95lwu3dKEtG0SdLATxWe1BjcDLCZs4+PgZeqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765038413; c=relaxed/simple;
	bh=zlh6R34eLvBCutMwxLhNz1D7zkl+YobUWg9d9oj9hjs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NKM5qjYMw2EOOQQx79cJZNTYw+fPMdeb4Jku8vew5NMixXJk86bGjdJ9tXSKLuVf7VyGBGcigA9nVMH7X1I6MZYKKL99Ce/2SFBQAKiGaZkW4y+kUYs0e69AoKmke1GSEpCesK60J57CUqpfp2vavaaw4+n+1Pu9neVknMUCDKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k2+Goi7g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2CD7C4CEF5;
	Sat,  6 Dec 2025 16:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765038413;
	bh=zlh6R34eLvBCutMwxLhNz1D7zkl+YobUWg9d9oj9hjs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=k2+Goi7gn14RM99gy+jqv0HDG+ILpo2xdjCfDDixJQBfHg//cv5K2c5owg0ledR3z
	 3iVMTNt3dsjwl7atEmUmUSjzPkUupcqFS+bhdK89qKxxztywn50FUdiR8cDiRpYBwp
	 S34NYniVTpYwU8plQLZoO9NC2VDBNGeSI3zf5qzofvHzNpjveiD5HylBUsFy/BhIrZ
	 tlZzJWkoz+v54APkswRYFoGeKXZdKGZza8kUqLpM0SqpziOhQjN9PLdMS2p9mvU3JX
	 biSVa5oDVurkKc4uZnKJFI7tJgl2Dhinu2yVoFXmT2iNkgl88NFt3v0pTaPGi93H5g
	 nm6IXplEywZTA==
Date: Sat, 6 Dec 2025 16:26:42 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Tomas Borquez <tomasborquez13@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-staging@lists.linux.dev
Subject: Re: [RFC PATCH 3/3] dt-bindings: iio: add analog devices
 ad9832/ad9835
Message-ID: <20251206162642.5b4a3e9b@jic23-huawei>
In-Reply-To: <20251205202743.10530-4-tomasborquez13@gmail.com>
References: <20251205202743.10530-1-tomasborquez13@gmail.com>
	<20251205202743.10530-4-tomasborquez13@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  5 Dec 2025 17:27:43 -0300
Tomas Borquez <tomasborquez13@gmail.com> wrote:

> Add devicetree binding documentation for the AD9832 and AD9835
> Digital Synthesizer chips.
> 
> Signed-off-by: Tomas Borquez <tomasborquez13@gmail.com>

Normally we only add a binding as part of the staging graduation
which typically involves a full review of the whole driver (make sure
to disable move detection in git if you send the code moving patch).

Anyhow, we can still give early feedback on this!

Whilst checking the pin mappings I finally noticed this a current source DAC
not a voltage one so all the channel types should be out_altcurrent0_...

Michael, I don't suppose you happen to remember why it is pretending to
be a voltage DAC?  

Jonathan

> ---
>  .../bindings/iio/frequency/adi,ad9832.yaml    | 65 +++++++++++++++++++
>  1 file changed, 65 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/frequency/adi,ad9832.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/frequency/adi,ad9832.yaml b/Documentation/devicetree/bindings/iio/frequency/adi,ad9832.yaml
> new file mode 100644
> index 0000000000..f14e054ab2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/frequency/adi,ad9832.yaml
> @@ -0,0 +1,65 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/frequency/adi,ad9832.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD9832/AD9835 Direct Digital Synthesizer
> +
> +maintainers:
> +  - Michael Hennerich <michael.hennerich@analog.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad9832
> +      - adi,ad9835
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    maximum: 20000000
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    const: mclk
> +
> +  avdd-supply:
> +    description: Analog power supply.
> +
> +  dvdd-supply:
> +    description: Digital power supply.
There looks to be a REFIN pin (and FS Adjust which is a bit of an oddity)
We probably need to desribe any resistor connected to fs adjust a bit like
a shunt resistor.


See cover letter discussion for the ways the various
inputs could be wired.  Some of the recent discussion on tied
GPIOs is also relevant here. I'm not up to date with where that
ended up yet though!

> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - avdd-supply
> +  - dvdd-supply
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        dds@0 {
> +            compatible = "adi,ad9832";
> +            reg = <0>;
> +            spi-max-frequency = <20000000>;
> +            clocks = <&dds_clk>;
> +            clock-names = "mclk";
> +            avdd-supply = <&avdd_reg>;
> +            dvdd-supply = <&dvdd_reg>;
> +        };
> +    };
> +...


