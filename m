Return-Path: <linux-iio+bounces-6309-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 099BB909979
	for <lists+linux-iio@lfdr.de>; Sat, 15 Jun 2024 19:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2FA91F22176
	for <lists+linux-iio@lfdr.de>; Sat, 15 Jun 2024 17:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8761C52F6D;
	Sat, 15 Jun 2024 17:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GqxzWzhh"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DD04AECE;
	Sat, 15 Jun 2024 17:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718474124; cv=none; b=qWEwgd+JwTe4TIzA/K95KW0F5p5FYF7KsX6IZeWC1I2nH05cMi1mA4j7T6Fz/rHRrmcWq/JyYBNcfbJGhXyTgmmbJaLVmd9cgTRIvr1bzZZPEgUnzEvPdJSpf5OKHDshjUZbJL3ys0D207pkDcDk8xfNhe7lLttIxfO2DWjbaiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718474124; c=relaxed/simple;
	bh=YZDyQV5KHWh5QtJ2JUl+NV+uqA9/jKP/Y9UoVxDbkxU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fPmNr4iofCf5r9r4xmDaOxChOPJljptMMBxmJKIFk5XEma75JVnfeSsTFLoBr0OE4k+NGY6jtsh9DYtrLHUvn2cK/ebvdHTuC95I8iYg9QL+50eOZmj/vX7yYyBJwa7dj3UDeIl548+K+zsdaP05SoMdJkH652sRhcYnn8A8MLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GqxzWzhh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0242C116B1;
	Sat, 15 Jun 2024 17:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718474124;
	bh=YZDyQV5KHWh5QtJ2JUl+NV+uqA9/jKP/Y9UoVxDbkxU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GqxzWzhhunrVgA1lBhPJKkDRUXevtpMtbS0Hu9iBpJPR+NL0bsrVkKUJxNkBaJsMU
	 AgcZ3zk4kqwd6IuqjYdpLg0w8hw+hqWeFwLDJAoVSrZM/SMfsyC6zIqRJjRavgsT8u
	 +3pVzJFFO2CmsSfYEiCIFKVD4ossdvkeP95WiS/XO7R6khWqHoOLO1IVJTxaeWv0IM
	 QAHsn18E6Rizi0eUqC/3xHysrovX8KPTDk1nqeTO0Kw9rJ8VSXd/Fx9vxEIDqBX+S+
	 aPHDhNPR/YYt2WEacAmRhxnKpCVdhL3aR+swtAATEBiCP8wboAsZnCtGN+41yO9vQl
	 p5LV2fpXTAxAg==
Date: Sat, 15 Jun 2024 18:55:16 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Michael Hennerich
 <michael.hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: iio: adc: add AD4695 and similar ADCs
Message-ID: <20240615185516.61346425@jic23-huawei>
In-Reply-To: <2d9a1405-4b8d-401b-99c4-434ac4b57f6e@baylibre.com>
References: <20240612-iio-adc-ad4695-v1-0-6a4ed251fc86@baylibre.com>
	<20240612-iio-adc-ad4695-v1-1-6a4ed251fc86@baylibre.com>
	<20240615134106.40e55e16@jic23-huawei>
	<2d9a1405-4b8d-401b-99c4-434ac4b57f6e@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> >> +
> >> +      adi,pin-pairing:
> >> +        description: |
> >> +          The input pin pairing for the negative input. This can be:
> >> +          - REFGND, normally 0V (single-ended)
> >> +          - COM, normally V_REF/2, see com-supply (pseudo-differential)
> >> +          - For even numbered pins, the next odd numbered pin (differential)
> >> +        $ref: /schemas/types.yaml#/definitions/string
> >> +        enum: [refgnd, com, next]  
> > 
> > Next is full on differential, just provide both channels via
> > diff-channels. You can constrain the particular combinations in the binding.
> > 
> > Refcnd is normal single ended.  Probably want to use the new single-channel
> > property for that as we are mixing differential and single ended channels
> > so reg is pretty much just an index.
> > 
> > Hmm. For comm we haven't had done a recent binding for a chip with the option
> > of pseudo differential that is per channel, they've been whole device only.
> > That feels like it will be common enough we need to support it cleanly
> > with a 'general' scheme.  
> 
> I think we have. :-)
> 
> https://lore.kernel.org/linux-iio/adc6cba9-2e79-475f-9c24-039fe9d3345d@baylibre.com/T/#mcbc1ce3a2541db502bf7870b7ea8574626a46312
> 

My goldfish like memory strikes again. Had completely forgotten that :)

> > 
> > Problem is I know someone will have a chip with 2 vincom pins and selecting
> > between them, so we can't just have pseudo-differential as a boolean and adc.yaml
> > 
> > There are horrible solutions like a magic channel number that changes the
> > meaning of diff-channels but that's ugly.
> > Maybe pseudo-differential for now and we have to later we add
> > pseudo-differential-comm  = <0> etc?
> >   
> 
> I was trying to keep things simple with 1 property instead of 3, but we
> can drop adi,pin-pairing and use the standard diff-channels, single-channel
> and common-mode-channel properties.
Sounds good.

> 
> >> +examples:
> >> +  - |
> >> +    #include <dt-bindings/gpio/gpio.h>
> >> +
> >> +    spi {
> >> +        #address-cells = <1>;
> >> +        #size-cells = <0>;
> >> +
> >> +        adc@0 {
> >> +            compatible = "adi,ad4695";
> >> +            reg = <0>;
> >> +            spi-cpol;
> >> +            spi-cpha;
> >> +            spi-max-frequency = <80000000>;
> >> +            avdd-supply = <&supply_2_5V>;
> >> +            vdd-supply = <&supply_1_8V>;
> >> +            vio-supply = <&supply_1_2V>;
> >> +            ref-supply = <&supply_5V>;
> >> +            reset-gpios = <&gpio 1 GPIO_ACTIVE_LOW>;
> >> +
> >> +            #address-cells = <1>;
> >> +            #size-cells = <0>;
> >> +  
> 
> Using the standard adc.yaml properties, these would now be:
> 
> >> +            /* Differential channel between IN0 and IN1. */
> >> +            channel@0 {
> >> +                reg = <0>;  
> 
>                     diff-channels = <0>, <1>;
> 
> >> +                bipolar;
> >> +            };
> >> +
> >> +            /* Single-ended channel between IN2 and REFGND. */
> >> +            channel@2 {
> >> +                reg = <2>;  
> 
>                     single-channel = <2>;
> 		    common-mode-channel = <0>;

I wonder if we count ground ad default and so don't necessarily
specify this? 

I don't really mind either way though.  Maybe just default to 0 works.


> 
> >> +            };
> >> +
> >> +            /* Pseudo-differential channel between IN3 and COM. */
> >> +            channel@f {
> >> +                reg = <3>;  
> 
>                     single-channel = <3>;
>                     common-mode-channel = <1>;
> 
> >> +                bipolar;
> >> +            };
> >> +        };
> >> +    };  
> >   
> 
> And I will add a header file with macros for the common mode
> channel values.

Great

Jonathan

> 


