Return-Path: <linux-iio+bounces-9707-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6790C97E393
	for <lists+linux-iio@lfdr.de>; Sun, 22 Sep 2024 23:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DDED2810CF
	for <lists+linux-iio@lfdr.de>; Sun, 22 Sep 2024 21:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ECA76F077;
	Sun, 22 Sep 2024 21:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WGmO/xlv"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1514C8C07;
	Sun, 22 Sep 2024 21:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727038976; cv=none; b=pgetDUR3PeyALQma3HZkpF+CA1krM+b/fg95cQO8hrpcYhv0uqN8NtsTjmN/ObhbvsuiwVlp0PTvPoGAPWyoMmdX+9br/pDStkpJ0Y+VPaH0emzam9rpgSybAIB7CQ2jNcs8hiKD/c0z1kyDM/Rj03s1WoC8uzX4csw7kgsXkMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727038976; c=relaxed/simple;
	bh=EVs1mVoH7mEn/7YWyaOXPY99H23/RONT5NvB6xqvvvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IDB4FBqWpvSf/NfhEfk+oJaubHNfIE3UuMQdU5U677Zu2soMaDlKbZH+fZoQFG92pmTHjljcUgAcqUoTGYQ18ND7ccm5SVeuI5glSV9EybTgt4/tmqnyj17CiNirK2bKZ/dAdxza2CBXzP8fMwAcuuli+Tt/c3tX89neDyCmTXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WGmO/xlv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE0F3C4CEC3;
	Sun, 22 Sep 2024 21:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727038975;
	bh=EVs1mVoH7mEn/7YWyaOXPY99H23/RONT5NvB6xqvvvk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WGmO/xlv+A91nGvcc7HI+m2jF6Knvd5CtZGQJOwOt5KfhJYeotI7g9JUPjbMFHO0V
	 ZH4q+bXlbiv4zixnIxHuSYuKVhcgjr45nXEWCr+TnsJyFDByPqw12TKKtYjArF5QnJ
	 ObpA+yqGhn5M6nlROn7f6YAmoQPj5nMVVoS+iVahsp/mZS5/uLJLal1Yy0LCpxBIRU
	 8niHeK0pHuj0PKssFJoNwvGS4Nep78uQhbXX69JBSqi6Ls3yx7i8HS9T1RXJIVcYQ9
	 Y1Aq4mr3Ry+64JzY9NRErivCbaJMgOsadKIi41TiCjeCXvviqGxCH+b+ypKOJM5wLw
	 cCjhKPn4O135Q==
Date: Sun, 22 Sep 2024 23:02:51 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Olivier Moysan <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, dlechner@baylibre.com
Subject: Re: [PATCH v3 04/10] dt-bindings: iio: dac: ad3552r: add io-backend
 support
Message-ID: <gojq6ardhvt6vcs2kawdhdn2cj6qbpzp4p5mjjgwsypuatm5eo@3u6k4q7le46s>
References: <20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-0-a17b9b3d05d9@baylibre.com>
 <20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-4-a17b9b3d05d9@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-4-a17b9b3d05d9@baylibre.com>

On Thu, Sep 19, 2024 at 11:20:00AM +0200, Angelo Dureghello wrote:
> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> There is a version AXI DAC IP block (for FPGAs) that provides
> a physical bus for AD3552R and similar chips, and acts as
> an SPI controller.
> 
> For this case, the binding is modified to include some
> additional properties.
> 
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---
>  .../devicetree/bindings/iio/dac/adi,ad3552r.yaml   | 42 ++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
> index 41fe00034742..aca4a41c2633 100644
> --- a/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
> +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
> @@ -60,6 +60,18 @@ properties:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      enum: [0, 1, 2, 3]
>  
> +  io-backends:
> +    description: The iio backend reference.
> +      An example backend can be found at
> +        https://analogdevicesinc.github.io/hdl/library/axi_ad3552r/index.html
> +    maxItems: 1
> +
> +  adi,synchronous-mode:
> +    description: Enable waiting for external synchronization signal.
> +      Some AXI IP configuration can implement a dual-IP layout, with internal
> +      wirings for streaming synchronization.
> +    type: boolean
> +
>    '#address-cells':
>      const: 1
>  
> @@ -128,6 +140,7 @@ patternProperties:
>            - custom-output-range-config
>  
>  allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
>    - if:
>        properties:
>          compatible:
> @@ -238,4 +251,33 @@ examples:
>              };
>          };
>      };
> +
> +  - |
> +    axi_dac: spi@44a70000 {
> +        compatible = "adi,axi-ad3552r";

That is either redundant or entire example should go to the parent node,
if this device is fixed child of complex device (IOW, adi,ad3552r cannot
be used outside of adi,axi-ad3552r).


> +        reg = <0x44a70000 0x1000>;
> +        dmas = <&dac_tx_dma 0>;
> +        dma-names = "tx";
> +        #io-backend-cells = <0>;
> +        clocks = <&ref_clk>;
> +
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        dac@0 {
> +            compatible = "adi,ad3552r";
> +            reg = <0>;
> +            reset-gpios = <&gpio0 92 0>;

Use standard defines for GPIO flags.

> +            io-backends = <&axi_dac>;

Why do you need to point to the parent? How much coupled are these
devices? Child pointing to parent is not usually expected, because
that's obvious.

Best regards,
Krzysztof


