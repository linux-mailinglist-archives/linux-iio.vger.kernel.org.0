Return-Path: <linux-iio+bounces-7879-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7462793C1E9
	for <lists+linux-iio@lfdr.de>; Thu, 25 Jul 2024 14:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 305C9289FC7
	for <lists+linux-iio@lfdr.de>; Thu, 25 Jul 2024 12:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C941199E8A;
	Thu, 25 Jul 2024 12:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qX2sZWHc"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437AA199241;
	Thu, 25 Jul 2024 12:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721910222; cv=none; b=Ede5Ub+4tQ8iP3sw10cagd0LK8EgePUuoV9sCNzmKseeKowjbztABfZtcrY+Z3gnQ7FxdpoUWQsd8fQi4ha2Uuhyn7nlBJCKRirQdldywQ3hGdEp0r5aqYpfhubwTo7FRj0hKv05V2vWkD0/9hW3LZZYffXxpm0qPPaeeB5/rDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721910222; c=relaxed/simple;
	bh=FxpBSkox+kGUdr5ySqjw7luWtMsnywJWHOmsE0BGYZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YmonBleW2yTqzGInLT/OcDQbSVE7bSOLktygNkbTFquLhC4zsEvwKcGVfZUzba+ZwHFf1GbUnRxwygspUpO/jVak/Yc5R2aM8yltXEoTYwRzwQ8C5mx6d/aSGi0eLN0114T6sY1ia7Tbg4Mtq7RezmyVJj1cLBWwkDE1pDfLwLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qX2sZWHc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F9C4C32782;
	Thu, 25 Jul 2024 12:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721910221;
	bh=FxpBSkox+kGUdr5ySqjw7luWtMsnywJWHOmsE0BGYZ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qX2sZWHc94S27MpTxVZc+U5E2xVhnkLF6TjChRWXH9/tHggOMZTVqaHqw94yTUWg+
	 f63ezr45jUwxp349qcODGFFU4sTAZG0FS44par0jn7zxECLO5pv9aUjkHDza7iNhUh
	 /KA9iJirdvlw7ME4A3m28V8mnZK59dgDv+o5HQ4WnAZMC812oq/9GckbzvH1kSqHQG
	 iFF6N9o/2RIpJdgEygI8e15Nh2eZpjoWcVUWdAtPrW6IJYW5CdCe4s5LkrlXtrLMtj
	 7DmZptFZWMWZv4iMsbNZXVV/04FirzQxqEw9pNxllmAcDvtUEC629dFOHzxRh75Qv+
	 Xz1L0P/Kjp75g==
Date: Thu, 25 Jul 2024 07:23:40 -0500
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
Subject: Re: [PATCH v5 4/9] dt-bindings: iio: dfsdm: move to backend framework
Message-ID: <20240725122340.GA1360128-robh@kernel.org>
References: <20240724153639.803263-1-olivier.moysan@foss.st.com>
 <20240724153639.803263-5-olivier.moysan@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724153639.803263-5-olivier.moysan@foss.st.com>

On Wed, Jul 24, 2024 at 05:36:32PM +0200, Olivier Moysan wrote:
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
>  .../bindings/iio/adc/st,stm32-dfsdm-adc.yaml  | 124 +++++++++++++++---
>  1 file changed, 108 insertions(+), 16 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.yaml b/Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.yaml
> index 2722edab1d9a..ceadd73504a4 100644
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

Don't need ().

> +        type: object
> +        $ref: adc.yaml
> +        unevaluatedProperties: false
> +        description: Represents the external channels which are connected to the DFSDM.
> +
> +        properties:
> +          reg:
> +            maximum: 7
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
> +            "^channel@([0-7])$":

And here.

With that and the newline fixed,

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

