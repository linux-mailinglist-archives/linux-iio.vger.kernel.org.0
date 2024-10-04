Return-Path: <linux-iio+bounces-10104-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A8098FB93
	for <lists+linux-iio@lfdr.de>; Fri,  4 Oct 2024 02:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98D7E1F2202E
	for <lists+linux-iio@lfdr.de>; Fri,  4 Oct 2024 00:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11FBA1862;
	Fri,  4 Oct 2024 00:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c3Co+UWk"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB727483;
	Fri,  4 Oct 2024 00:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728002100; cv=none; b=dcNXW19FYOUO4e9D+q/zLliWgV+QOkia2/QBtonWaNyPjnUTdmRblLeswnR/jXu0ubdahqpPVEae2e6Ksdq3OO3QQbHX6NK0+cM9BAy2q0GRfVrfT88RFP7BzQVdA64Eq4s9e0Q/IIWy83nAgVeOZ2hHPgdG4w7eGIfFJsli2Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728002100; c=relaxed/simple;
	bh=Z2WFWxnFeiRoHDvmNnVcEUmOFZCB8QXG0d2pD+vr6tI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KnMWgnHrzxwXgg4nIKIL8kfFx7fXMjquZQ4Z75N382hf2R/P30HoGBgpzLzZ5UZnCES4PfnXza8GdE+zdLP+7pXK3owUhDqnhh2wWGNKeBSZ+wfLjI1gIPi9EbLJRNQo9lyQnTpPApjNypRJbOky8xzagyjZSKVQvhGMHfyapIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c3Co+UWk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E091C4CEC5;
	Fri,  4 Oct 2024 00:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728002100;
	bh=Z2WFWxnFeiRoHDvmNnVcEUmOFZCB8QXG0d2pD+vr6tI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c3Co+UWkNe3r0TwZrz6P12Rb66QZT3QfL3oVpNY1svu4QUw1trKU4HJVfiP5nUGJ/
	 6JfUih2cf90kMNTSmaC/goakZMFWt4kNSRq7i+lYZyEhGLx68vQmoeQkmUCbXw7Aqg
	 ieH4J75cZIUtLUpI3/EPzuKgLsYNAYqEViM6MAfeVOWjXHMW25r3yde4CUTrwyDMBf
	 uypw6PWWx4X0ZjhE4C50BaVL90/QPmXNEUv1hJUCpCYNElx4kI+ZObMJRaqnXeHEDl
	 gkHrjd9/rOLienvezMZK4UiWHNIWFEB5sqL/FPXWfuHPvlqmlD0i0kKOyw1RoWyCSi
	 paGgLrlf3vSLQ==
Date: Thu, 3 Oct 2024 19:34:54 -0500
From: Rob Herring <robh@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mihail Chindris <mihail.chindris@analog.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	devicetree@vger.kernel.org, dlechner@baylibre.com,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 03/11] dt-bindings: iio: dac: adi-axi-dac: add ad3552r
 axi variant
Message-ID: <20241004003454.GA1926225-robh@kernel.org>
References: <20241003-wip-bl-ad3552r-axi-v0-iio-testing-v4-0-ceb157487329@baylibre.com>
 <20241003-wip-bl-ad3552r-axi-v0-iio-testing-v4-3-ceb157487329@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003-wip-bl-ad3552r-axi-v0-iio-testing-v4-3-ceb157487329@baylibre.com>

On Thu, Oct 03, 2024 at 07:29:00PM +0200, Angelo Dureghello wrote:
> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Add a new compatible and related bindigns for the fpga-based
> "ad3552r" AXI IP core, a variant of the generic AXI DAC IP.
> 
> The AXI "ad3552r" IP is a very similar HDL (fpga) variant of the
> generic AXI "DAC" IP, intended to control ad3552r and similar chips,
> mainly to reach high speed transfer rates using a QSPI DDR
> (dobule-data-rate) interface.
> 
> The ad3552r device is defined as a child of the AXI DAC, that in
> this case is acting as an SPI controller.
> 
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---
>  .../devicetree/bindings/iio/dac/adi,axi-dac.yaml   | 49 +++++++++++++++++++++-
>  1 file changed, 48 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml b/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
> index a55e9bfc66d7..e15d02ef6be9 100644
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
> @@ -41,13 +43,28 @@ properties:
>    '#io-backend-cells':
>      const: 0
>  
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +

Defined in spi-controller.yaml, so you don't need them here.

>  required:
>    - compatible
>    - dmas
>    - reg
>    - clocks
>  
> -additionalProperties: false
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: adi,axi-ad3552r
> +    then:
> +      $ref: /schemas/spi/spi-controller.yaml#
> +
> +unevaluatedProperties: false
>  
>  examples:
>    - |
> @@ -59,4 +76,34 @@ examples:
>          #io-backend-cells = <0>;
>          clocks = <&axi_clk>;
>      };
> +
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    axi_dac: spi@44a70000 {
> +        compatible = "adi,axi-ad3552r";
> +        reg = <0x44a70000 0x1000>;
> +        dmas = <&dac_tx_dma 0>;
> +        dma-names = "tx";
> +        #io-backend-cells = <0>;
> +        clocks = <&axi_clk>;
> +
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        dac@0 {
> +            compatible = "adi,ad3552r";
> +            reg = <0>;
> +            reset-gpios = <&gpio0 92 GPIO_ACTIVE_HIGH>;
> +            io-backends = <&axi_dac>;
> +            spi-max-frequency = <66000000>;
> +
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            channel@0 {
> +                reg = <0>;
> +                adi,output-range-microvolt = <(-10000000) (10000000)>;
> +            };
> +        };
> +    };
>  ...
> 
> -- 
> 2.45.0.rc1
> 

