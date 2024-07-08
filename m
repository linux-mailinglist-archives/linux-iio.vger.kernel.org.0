Return-Path: <linux-iio+bounces-7450-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD15992A7DB
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jul 2024 19:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E09311C21045
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jul 2024 17:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF33814900B;
	Mon,  8 Jul 2024 17:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KJ3EEjpJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B0A148FEE;
	Mon,  8 Jul 2024 17:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720458508; cv=none; b=kPmOW+t1eHUvTprr2mPDj3RcR2gAMDSJAr3YrWlHWPjFUsYRdMlewXh3kn3rNrjkDw/k1KHmVSfvldfM9LJ8DPMwb95BHSNFMQpY48ULIpKOTEcBJFlsPBvW97paddvVrd414mmvb3UfOR5VXPQcdqgprtsULduLDpvdPmbsRys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720458508; c=relaxed/simple;
	bh=Y3aHN1NmCiICEtufO9VLeJIX/a8wyoqvGJdPF9we2rQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FusKsrserFArVkMr6TV0UFgJ1ofma4KtlIxADxaw3g8d9FAnc6nEQKLIY5170IBw9wXnTN8JAfK2/DyDMvGbwqf3PI9bRKens6SZxkAyyEsbcIYA08GqbA83VGB5g75T+PYqC7ssm+C79X8JMQ0DROT5CSxdmMipDPnf0Jx6k9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KJ3EEjpJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC899C32786;
	Mon,  8 Jul 2024 17:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720458508;
	bh=Y3aHN1NmCiICEtufO9VLeJIX/a8wyoqvGJdPF9we2rQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KJ3EEjpJQ7KhLsBB1ZzRBnG2cF+rHHd/CNFLUWehzYoGgnDC/ydRyoxwpMMWB1c1U
	 d64dEgd9+rJ4fqSar4OYyvZ32TIKvoD5U/fbKVq3cMwGBBDvsoniJFYljs1jg+0nO3
	 XgDypjRFCNXY8AhYMNn4ve/nAwpdAntsO7XBecmWAis7kJk+RsS3o8+/FTdxZvf+Ih
	 ITY4Mw0Fy0ljYlYqQW9N/6BZqHJrTAHlK3kcuCCPucieJtpTCMYafNhb4bD//+NU7K
	 heUPMFFOcvGY2pub23LOyPaH810AZW66VSp3NXkOvDr5STkoOvtri9old3uQlbY79X
	 6yQ+qdHhjo9eg==
Date: Mon, 8 Jul 2024 11:08:26 -0600
From: Rob Herring <robh@kernel.org>
To: Olivier Moysan <olivier.moysan@foss.st.com>
Cc: fabrice.gasnier@foss.st.com,
	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	alsa-devel@alsa-project.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/8] dt-bindings: iio: dfsdm: move to backend framework
Message-ID: <20240708170826.GA3381590-robh@kernel.org>
References: <20240704155338.2387858-1-olivier.moysan@foss.st.com>
 <20240704155338.2387858-5-olivier.moysan@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704155338.2387858-5-olivier.moysan@foss.st.com>

On Thu, Jul 04, 2024 at 05:53:32PM +0200, Olivier Moysan wrote:
> Change the DFSDM binding to use the new IIO backend framework,
> along with the adoption of IIO generic channels.
> This binding change allows to add scaling support to the DFSDM.
> 
> Keep the legacy binding as deprecated for backward compatibility.
> 
> The io-backends property is supported only in generic IIO channel
> binding.
> 
> - Channel description with the generic binding (Audio and Analog):
> 
>   Properties superseded by generic properties:
>     st,adc-channels: becomes "reg" property in channel node
>     st,adc-channel-names: becomes "label" property in channel node
>   Properties moved to channel child node:
>     st,adc-channel-types: becomes st,adc-channel-type
>     st,adc-channel-clk-src, st,adc-alt-channel
> 
> - Analog binding:
> 
>   DFSDM filter channel is configured as an IIO backend consumer.
>   Add io-backends property in channel child nodes.
> 
>   DFSDM is no more configured as a channel consumer from SD modulator.
>   Use of io-channels in DFSDM node is deprecated.
> 
> - Audio binding:
> 
>   DFSDM audio DAI is configured as a channel consumer from DFSDM filter.
>   No change compare to legacy.
> 
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> ---
>  .../bindings/iio/adc/st,stm32-dfsdm-adc.yaml  | 153 +++++++++++++++++-
>  1 file changed, 147 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.yaml b/Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.yaml
> index 2722edab1d9a..5a5bc8b96402 100644
> --- a/Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.yaml
> @@ -102,9 +102,11 @@ patternProperties:
>          items:
>            minimum: 0
>            maximum: 7
> +        deprecated: true
>  
>        st,adc-channel-names:
>          description: List of single-ended channel names.
> +        deprecated: true
>  
>        st,filter-order:
>          description: |
> @@ -118,6 +120,12 @@ patternProperties:
>        "#io-channel-cells":
>          const: 1
>  
> +      '#address-cells':
> +        const: 1
> +
> +      '#size-cells':
> +        const: 0
> +
>        st,adc-channel-types:
>          description: |
>            Single-ended channel input type.
> @@ -128,6 +136,7 @@ patternProperties:
>          items:
>            enum: [ SPI_R, SPI_F, MANCH_R, MANCH_F ]
>          $ref: /schemas/types.yaml#/definitions/non-unique-string-array
> +        deprecated: true
>  
>        st,adc-channel-clk-src:
>          description: |
> @@ -139,6 +148,7 @@ patternProperties:
>          items:
>            enum: [ CLKIN, CLKOUT, CLKOUT_F, CLKOUT_R ]
>          $ref: /schemas/types.yaml#/definitions/non-unique-string-array
> +        deprecated: true
>  
>        st,adc-alt-channel:
>          description:
> @@ -147,6 +157,7 @@ patternProperties:
>            If not set, channel n is connected to SPI input n.
>            If set, channel n is connected to SPI input n + 1.
>          type: boolean
> +        deprecated: true
>  
>        st,filter0-sync:
>          description:
> @@ -165,11 +176,60 @@ patternProperties:
>        - compatible
>        - reg
>        - interrupts
> -      - st,adc-channels
> -      - st,adc-channel-names
>        - st,filter-order
>        - "#io-channel-cells"
>  
> +    patternProperties:
> +      "^channel@([0-7])$":
> +        type: object
> +        $ref: adc.yaml
> +        unevaluatedProperties: false
> +        description: Represents the external channels which are connected to the DFSDM.
> +
> +        properties:
> +          reg:
> +            maxItems: 1

Instead:

maximum: 7

> +
> +          label:
> +            description:
> +              Unique name to identify which channel this is.
> +
> +          st,adc-channel-type:
> +            description: |
> +              Single-ended channel input type.
> +              - "SPI_R": SPI with data on rising edge (default)
> +              - "SPI_F": SPI with data on falling edge
> +              - "MANCH_R": manchester codec, rising edge = logic 0, falling edge = logic 1
> +              - "MANCH_F": manchester codec, rising edge = logic 1, falling edge = logic 0
> +            $ref: /schemas/types.yaml#/definitions/string
> +            enum: [ SPI_R, SPI_F, MANCH_R, MANCH_F ]
> +
> +          st,adc-channel-clk-src:
> +            description: |
> +              Conversion clock source.
> +              - "CLKIN": external SPI clock (CLKIN x)
> +              - "CLKOUT": internal SPI clock (CLKOUT) (default)
> +              - "CLKOUT_F": internal SPI clock divided by 2 (falling edge).
> +              - "CLKOUT_R": internal SPI clock divided by 2 (rising edge).
> +            $ref: /schemas/types.yaml#/definitions/string
> +            enum: [ CLKIN, CLKOUT, CLKOUT_F, CLKOUT_R ]
> +
> +          st,adc-alt-channel:
> +            description:
> +              Must be defined if two sigma delta modulators are
> +              connected on same SPI input.
> +              If not set, channel n is connected to SPI input n.
> +              If set, channel n is connected to SPI input n + 1.
> +            type: boolean
> +
> +          io-backends:
> +            description:
> +              Used to pipe external sigma delta modulator or internal ADC backend to DFSDM channel.
> +            maxItems: 1
> +
> +        required:
> +          - reg
> +
>      allOf:
>        - if:
>            properties:
> @@ -199,9 +259,19 @@ patternProperties:
>                description:
>                  From common IIO binding. Used to pipe external sigma delta
>                  modulator or internal ADC output to DFSDM channel.
> +              deprecated: true
>  
> -          required:
> -            - io-channels
> +          if:
> +            required:
> +              - st,adc-channels
> +          then:
> +            required:
> +              - io-channels
> +
> +          patternProperties:
> +            "^channel@([0-9])$":

Is it 8 or 10 channels?

> +              required:
> +                - io-backends
>  
>        - if:
>            properties:
> @@ -298,7 +368,77 @@ examples:
>        #address-cells = <1>;
>        #size-cells = <0>;
>  
> +      // Example 1: Audio use case with generic binding
>        dfsdm0: filter@0 {
> +        compatible = "st,stm32-dfsdm-dmic";
> +        reg = <0>;
> +        interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
> +        dmas = <&dmamux1 101 0x400 0x01>;
> +        dma-names = "rx";
> +        #io-channel-cells = <1>;
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        st,filter-order = <5>;
> +
> +        channel@1 {
> +          reg = <1>;
> +          label = "dmic0";
> +          st,adc-channel-type = "SPI_R";
> +          st,adc-channel-clk-src = "CLKOUT";
> +          st,adc-alt-channel;
> +        };
> +
> +        asoc_pdm0: dfsdm-dai {
> +          compatible = "st,stm32h7-dfsdm-dai";
> +          #sound-dai-cells = <0>;
> +          io-channels = <&dfsdm0 0>;
> +        };
> +      };
> +
> +      // Example 1: Analog use case with generic binding

2nd example 1?

> +      dfsdm1: filter@1 {
> +        compatible = "st,stm32-dfsdm-adc";
> +        reg = <1>;
> +        interrupts = <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>;
> +        dmas = <&dmamux1 102 0x400 0x01>;
> +        dma-names = "rx";
> +        st,filter-order = <1>;
> +        #io-channel-cells = <1>;
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        channel@2 {
> +          reg = <2>;
> +          label = "in2";
> +          st,adc-channel-type = "SPI_F";
> +          st,adc-channel-clk-src = "CLKOUT";
> +          st,adc-alt-channel;
> +          io-backends = <&sd_adc2>;
> +        };
> +
> +        channel@3 {
> +          reg = <3>;
> +          label = "in3";
> +          st,adc-channel-type = "SPI_R";
> +          st,adc-channel-clk-src = "CLKOUT";
> +          io-backends = <&sd_adc3>;
> +        };
> +      };
> +    };
> +
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/stm32mp1-clks.h>
> +    dfsdm_2: dfsdm@4400d000 {
> +      compatible = "st,stm32mp1-dfsdm";
> +      reg = <0x4400d000 0x800>;
> +      clocks = <&rcc DFSDM_K>, <&rcc ADFSDM_K>;
> +      clock-names = "dfsdm", "audio";
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      // Example 3: Audio use case with legacy binding

I don't think it is worthwhile to show how to use the deprecated 
binding.

> +      dfsdm0_2: filter@0 {
>          compatible = "st,stm32-dfsdm-dmic";
>          reg = <0>;
>          interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
> @@ -311,14 +451,15 @@ examples:
>          st,adc-channel-clk-src = "CLKOUT";
>          st,filter-order = <5>;
>  
> -        asoc_pdm0: dfsdm-dai {
> +        asoc_pdm0_2: dfsdm-dai {
>            compatible = "st,stm32h7-dfsdm-dai";
>            #sound-dai-cells = <0>;
>            io-channels = <&dfsdm0 0>;
>          };
>        };
>  
> -      dfsdm_pdm1: filter@1 {
> +      // Example 3: Analog use case with legacy binding
> +      dfsdm1_2: filter@1 {
>          compatible = "st,stm32-dfsdm-adc";
>          reg = <1>;
>          interrupts = <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>;
> -- 
> 2.25.1
> 

