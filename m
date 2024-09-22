Return-Path: <linux-iio+bounces-9705-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1F197E38C
	for <lists+linux-iio@lfdr.de>; Sun, 22 Sep 2024 22:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7110E280E6F
	for <lists+linux-iio@lfdr.de>; Sun, 22 Sep 2024 20:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB29274409;
	Sun, 22 Sep 2024 20:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IbVLFAZ1"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7346241C6D;
	Sun, 22 Sep 2024 20:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727038755; cv=none; b=ZmXdQzDeGubiS8nQX41MkgZB7h6FE6FDxtTtQAEBzm5u16/jzDVOAUNvM+J+/4Ydzk419RlHRl5usYN66TmmqWsiO1KY0CnKSDoDWnIN56horXTqmpOXwUc1658LQEEu3xYkVSyQ4cO9mo7NGvInkN+KG+aYYRraCrrm+PxEp4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727038755; c=relaxed/simple;
	bh=/dJHHul0bwca9Q2srbhOFgndHDS9pqLrIK+v17cwh74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oDHGyYtzwE8+wPv7UGkUpQxHAs6DzozoaTu4l/+jzSoOwcm+iy8tPkxNsRbYey4qJaYGBqI4JeNT/K9ycrM+wU9DpBX4Z3Uliq4qqvhXB8g8nZ5w+gs06WihbSzLjL0FBBWZI7bckZCAX1iKHUqa04Z6DwhuKlzMmsuB4VvWfvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IbVLFAZ1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CF03C4CEC3;
	Sun, 22 Sep 2024 20:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727038755;
	bh=/dJHHul0bwca9Q2srbhOFgndHDS9pqLrIK+v17cwh74=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IbVLFAZ1aojwgpTvu4yVxc9RuwBveSF4W5SH3Jk4iOxn3RDXef7KD3TW5APwyMqwN
	 xALMs7lxTRq2w0Q5lcDO5k2g7eQhLE5VONdicj9zJlPOxTJCQ8Y0jscUa8IG64y+5B
	 AQgzxmsd+/FNoNsdwToIvHgcH6vUNETbaDY/vU+He8Lcd/vdUmH+5Va38nsHwwHhjp
	 yahMyO+7W9/aKwNESIELqhn3VCll4osu+XqOsi//dDebT1E6BhhwTR7rg907dr83FW
	 mYj9rEX1tR1VNaTzrKpodrXyPHHXZy/sy254ulfqO99Sz0smT1QwWNr5TnMUrBKgQR
	 R8VlrKMczYtUg==
Date: Sun, 22 Sep 2024 22:59:11 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Olivier Moysan <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, dlechner@baylibre.com
Subject: Re: [PATCH v3 02/10] dt-bindings: iio: dac: axi-dac: add ad3552r axi
 variant
Message-ID: <odkqq4oikux4766unjrixnw35qx7sa24byk5ob4bm7njq5bl3l@4zx4iyfwnsum>
References: <20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-0-a17b9b3d05d9@baylibre.com>
 <20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-2-a17b9b3d05d9@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-2-a17b9b3d05d9@baylibre.com>

On Thu, Sep 19, 2024 at 11:19:58AM +0200, Angelo Dureghello wrote:
> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Add a new compatible and related bindigns for the fpga-based
> "ad3552r" AXI IP core, a variant of the generic AXI DAC IP.
> 
> The AXI "ad3552r" IP is a very similar HDL (fpga) variant of the
> generic AXI "DAC" IP, intended to control ad3552r and similar chips,
> mainly to reach high speed transfer rates using an additional QSPI
> DDR interface.
> 
> The ad3552r device is defined as a child of the AXI DAC, that in
> this case is acting as an SPI controller.


So who acts as an SPI controller? adi,axi-ad3552r? Why this is not
reflected in the binding?

> 
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---
>  .../devicetree/bindings/iio/dac/adi,axi-dac.yaml   | 40 ++++++++++++++++++++--
>  1 file changed, 37 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml b/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
> index a55e9bfc66d7..6cf0c2cb84e7 100644
> --- a/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
> +++ b/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
> @@ -19,11 +19,13 @@ description: |
>    memory via DMA into the DAC.
>  
>    https://wiki.analog.com/resources/fpga/docs/axi_dac_ip
> +  https://analogdevicesinc.github.io/hdl/library/axi_ad3552r/index.html
>  
>  properties:
>    compatible:
>      enum:
>        - adi,axi-dac-9.1.b
> +      - adi,axi-ad3552r
>  
>    reg:
>      maxItems: 1
> @@ -41,22 +43,54 @@ properties:
>    '#io-backend-cells':
>      const: 0
>  
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
>  required:
>    - compatible
>    - dmas
>    - reg
>    - clocks
>  
> +patternProperties:
> +  "^.*@([0-9])$":

No need for ()

but this is pattern is quite permissive, so looks like you want to
achieve something else. Maybe spi controller? Not sure, I am just
guessing because empty example does not help me.

> +    type: object
> +    additionalProperties: true

No, this cannot be true.

> +    properties:
> +      io-backends:
> +        description: |
> +          AXI backend reference
> +    required:
> +      - io-backends

I don't get the point. Nodes with only one property are not really
useful.

> +
>  additionalProperties: false
>  
>  examples:
>    - |
>      dac@44a00000 {
> -        compatible = "adi,axi-dac-9.1.b";
> -        reg = <0x44a00000 0x10000>;
> -        dmas = <&tx_dma 0>;
> +      compatible = "adi,axi-dac-9.1.b";
> +      reg = <0x44a00000 0x10000>;

Why are you changing this? It's even messier now - other example uses
different indentayion...

> +      dmas = <&tx_dma 0>;
> +      dma-names = "tx";
> +      #io-backend-cells = <0>;
> +      clocks = <&axi_clk>;
> +    };
> +
> +  - |
> +    axi_dac: spi@44a70000 {
> +        compatible = "adi,axi-ad3552r";
> +        reg = <0x44a70000 0x1000>;
> +        dmas = <&dac_tx_dma 0>;
>          dma-names = "tx";
>          #io-backend-cells = <0>;
>          clocks = <&axi_clk>;
> +
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        /* DAC devices */

Your schema must be complete, example as well (minus repetitive pieces).

Best regards,
Krzysztof


