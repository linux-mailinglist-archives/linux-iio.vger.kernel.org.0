Return-Path: <linux-iio+bounces-26948-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D1111CAE042
	for <lists+linux-iio@lfdr.de>; Mon, 08 Dec 2025 19:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 564EC30B1145
	for <lists+linux-iio@lfdr.de>; Mon,  8 Dec 2025 18:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0032DF14C;
	Mon,  8 Dec 2025 18:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZhu+cMZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499052DCBE3;
	Mon,  8 Dec 2025 18:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765218781; cv=none; b=GgROL6T0PrKo46JU+LaIy9zRyVAdfSwHaHWZwD7CTbPLeAsn/D/XCRtZPyyDMqfCMrF60+gVeUPxcxy1NBRp4Zjx1JUsInnAXoqN2o9JsqyCIza5KqRco528y8ncMrND8qQZJkQ7wVDI4rPn0cUYtxyFBmaWCZmg0ceOdZGdFwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765218781; c=relaxed/simple;
	bh=ZA+mTSJWTBLywz5DiXmr9MLP7m9fwm/qg/hcu+2sp4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EtnPSqZvAfiQ8xHo6s7otVVGtx1w5KYUp3lfZWN3lUhKxrWWjXrh0iLmirHTsanKJrMiDTdc8EqF5aYLg9kJ/0jpVGYVtRTxHeqiqYPvMRQo5RtuXtQX1P+ffTfGl3tt7Ex4/npWFRp8TA+xYgRd4uOGbfyjzy8KxPnAqWQFZvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bZhu+cMZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9925C4CEF1;
	Mon,  8 Dec 2025 18:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765218781;
	bh=ZA+mTSJWTBLywz5DiXmr9MLP7m9fwm/qg/hcu+2sp4k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bZhu+cMZFMb5URqqXhOXo27VMmGdGodXz5lTl4usNvqiHN7m+MKwO4oCshWMQGHX/
	 rbRv19ZCvvGvffN4wNmxmrylxL1jSFue8YlXmPIlZeg00b3vHxpq5phaIWANryuXxS
	 Q7HNzgYn90tE6nzxAGmfelzxJ7CrFZ8Hhktx5nPz8/LffH1iuVH+GO4AEI7zb9fOgk
	 XJIGs+n9oRRfUIUr71PQXnz76QsLdTfZr6c2rujfQvIw3Fpdv2ICZ3fzKejzrimrYE
	 wy+gRFxjbmvX8K8So9Vy/iUn1eMCu82EcvCnSEXsrJPsJ5GftLKqKn9wjc7+ojUjxn
	 1QZmFPpmtI64g==
Date: Mon, 8 Dec 2025 12:32:58 -0600
From: Rob Herring <robh@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Sean Anderson <sean.anderson@linux.dev>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 7/7] dt-bindings: iio: adc: adi,ad4030: add data-lanes
 property
Message-ID: <20251208183258.GA2439268-robh@kernel.org>
References: <20251201-spi-add-multi-bus-support-v3-0-34e05791de83@baylibre.com>
 <20251201-spi-add-multi-bus-support-v3-7-34e05791de83@baylibre.com>
 <20251204213348.GA2198382-robh@kernel.org>
 <aTNKyaWAEjVJixMI@debian-BULLSEYE-live-builder-AMD64>
 <0cf78f84-01e7-4507-abf9-2f82f98206b2@baylibre.com>
 <221d5ed6-51da-4dce-b8a7-58b4d2423101@baylibre.com>
 <20251206004757.GA980619-robh@kernel.org>
 <b31f9e88-a078-47f4-8d6c-359a0394ef7e@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b31f9e88-a078-47f4-8d6c-359a0394ef7e@baylibre.com>

On Mon, Dec 08, 2025 at 10:14:36AM -0600, David Lechner wrote:
> On 12/5/25 6:47 PM, Rob Herring wrote:
> > On Fri, Dec 05, 2025 at 05:43:31PM -0600, David Lechner wrote:
> >> On 12/5/25 3:33 PM, David Lechner wrote:
> >>> On 12/5/25 3:12 PM, Marcelo Schmitt wrote:
> >>>> On 12/04, Rob Herring wrote:
> >>>>> On Mon, Dec 01, 2025 at 08:20:45PM -0600, David Lechner wrote:
> >>>>>> Add data-lanes property to specify the number of data lanes used on the
> >>>>>> ad463x chips that support reading two samples at the same time using
> >>>>>> two data lanes with a capable SPI controller.
> >>>>>>
> >>>>>> Signed-off-by: David Lechner <dlechner@baylibre.com>
> >>>>>> ---
> >>>>>> v3 changes: new patch
> >>>>>>
> >>>>>> I added this one to give a real-world use case where spi-rx-bus-width
> >>>>>> was not sufficient to fully describe the hardware configuration.
> >>>>>>
> >>>>>> spi-rx-bus-width = <4>; alone could be be interpreted as either:
> >>>>>>
> >>>>>> +--------------+    +----------+
> >>>>>> | SPI          |    | AD4630   |
> >>>>>> | Controller   |    | ADC      |
> >>>>>> |              |    |          |
> >>>>>> |        SDIA0 |<---| SDOA0    |
> >>>>>> |        SDIA1 |<---| SDOA1    |
> >>>>>> |        SDIA2 |<---| SDOA2    |
> >>>>>> |        SDIA3 |<---| SDOA3    |
> >>>>>> |              |    |          |
> >>>>>> |        SDIB0 |x   | SDOB0    |
> >>>>>> |        SDIB1 |x   | SDOB1    |
> >>>>>> |        SDIB2 |x   | SDOB2    |
> >>>>>> |        SDIB3 |x   | SDOB3    |
> >>>>>> |              |    |          |
> >>>>>> +--------------+     +---------+
> >>>>>>
> >>>>>> or
> >>>>>>
> >>>>>> +--------------+    +----------+
> >>>>>> | SPI          |    | AD4630   |
> >>>>>> | Controller   |    | ADC      |
> >>>>>> |              |    |          |
> >>>>>> |        SDIA0 |<---| SDOA0    |
> >>>>>> |        SDIA1 |<---| SDOA1    |
> >>>>>> |        SDIA2 |x   | SDOA2    |
> >>>>>> |        SDIA3 |x   | SDOA3    |
> >>>>>> |              |    |          |
> >>>>>> |        SDIB0 |<---| SDOB0    |
> >>>>>> |        SDIB1 |<---| SDOB1    |
> >>>>>> |        SDIB2 |x   | SDOB2    |
> >>>>>> |        SDIB3 |x   | SDOB3    |
> >>>>>> |              |    |          |
> >>>>>> +--------------+     +---------+
> >>>>>>
> >>>>>> Now, with data-lanes having a default value of [0] (inherited from
> >>>>>> spi-peripheral-props.yaml), specifying:
> >>>>>>
> >>>>>>     spi-rx-bus-width = <4>;
> >>>>>>
> >>>>>> is unambiguously the first case and the example given in the binding
> >>>>>> documentation is the second case:
> >>>>>>
> >>>>>>     spi-rx-bus-width = <2>;
> >>>>>>     data-lanes = <0>, <1>;
> >>>>>
> >>>>> I just reviewed this and all, but what if you just did:
> >>>>>
> >>>>> spi-rx-bus-width = <2>, <2>;
> >>>>>
> >>>>> So *-bus-width becomes equal to the number of serializers/channels.
> >>>>
> >>>> Unless I'm missing something, I think that would also describe the currently
> >>>> possible use cases as well. To me, it actually seems even more accurate than
> >>>> data-lanes. The data-lanes property only describes the SPI controller input
> >>>> lines/lanes, no info is given about the output lanes.
> >>>
> >>> It describes both directions.
> >>>
> >>>> Well yeah, that would only> be a problem for a device with multiple input serializers and multiple output
> >>>> serializers. Still, the *-bus-width = <N>, <N>, ... <N>; notation looks clearer,
> >>>> IMHO.
> >>>>
> >>>>>
> >>>>> Rob
> >>>>>
> >>>
> >>> It think it complicates Sean's use case though where such
> >>> a controller is being used as basically two separate SPI
> >>> buses.
> >>>
> >>> For that case, we want to be able to do:
> >>>
> >>> spi {
> >>> 	...
> >>>
> >>> 	thing@0 {
> >>> 		compatible = ...;
> >>> 		reg = <0>;
> >>> 		/* (implicit) data-lanes = <0>; */
> >>> 	};
> >>>
> >>> 	thing@1 {
> >>> 		compatible = ...;
> >>> 		reg = <1>;
> >>> 		data-lanes = <1>;
> >>> 	};
> >>> };
> >>>
> >>> Meaning:
> >>>
> >>> +--------------+    +----------+
> >>> | SPI          |    | Thing 1  |
> >>> | Controller   |    |          |
> >>> |              |    |          |
> >>> |          CS0 |--->| CS       |
> >>> |         SDI0 |<---| SDO      |
> >>> |         SDO0 |--->| SDI      |
> >>> |        SCLK0 |--->| SCLK     |
> >>> |              |    |          |
> >>> |              |    +----------+
> >>> |              |                
> >>> |              |    +----------+
> >>> |              |    | Thing 2  |
> >>> |              |    |          |
> >>> |          CS1 |--->| CS       |
> >>> |         SDI1 |<---| SDO      |
> >>> |         SDO1 |--->| SDI      |
> >>> |        SCLK1 |--->| SCLK     |
> >>> |              |    |          |
> >>> +--------------+    +----------+
> >>>
> >>> (I don't remember if SCLKs are shared or separate, but I don't
> >>> think that is relevant anyway).
> >>>
> >>>
> >>> I guess we could write it like this?
> >>>
> >>> spi {
> >>> 	...
> >>>
> >>> 	thing@0 {
> >>> 		compatible = ...;
> >>> 		reg = <0>;
> >>> 	};
> >>>
> >>> 	thing@1 {
> >>> 		compatible = ...;
> >>> 		reg = <1>;
> >>> 		spi-tx-bus-width = <0>, <1>;
> >>> 		spi-rx-bus-width = <0>, <1>;
> >>> 	};
> >>> };
> > 
> > I forget the details on that, but just looking at the above I think 
> > something like that should have 2 SPI bus nodes under the controller. 
> > Unless CS0 and CS1 can't be asserted at the same time and they aren't 
> > really independent.
> 
> It is the case that they aren't really independent. Only one "bus"
> can operate at a time.
> 
> > 
> > But would be good to wait for Sean's comments here.
> > 
> >>
> >> I started down this road. Before I do the working of changing the
> >> whole series, this is what it will probably look like. Is this really
> >> what we want?
> >>
> >> There is one issue I see with this. If we allow <0> to mean that a lane
> >> isn't wired up on the controller, then we can't constrain the length of
> >> the array in peripheral bindings. For example, the ad403x chips can only
> >> have one lane and the ad463x chips can have one or two lanes. But I
> >> don't see a way to express that in the binding if <0> at any index
> >> doesn't count towards the number of lanes that are actually wired up.
> > 
> > That's fine I think. How many entries is primarily a controller 
> > property. We set the length in the controller binding. The device just 
> > sets the maximum width per channel.
> > 
> >>
> >> This is e.g. why the binding in sitronix,st7789v.yaml is
> >>
> >> 	items:
> >> 	  enum: [0, 1]
> >>
> >> rather than
> >>
> >> 	items:
> >> 	  - enum: [0, 1]
> >>
> >> ---
> >> commit 049b9508b1b0190f87a4b35fe3ed8a9f3d0d3c50
> >> Author: David Lechner <dlechner@baylibre.com>
> >> Date:   Fri Dec 5 16:09:08 2025 -0600
> >>
> >>     spi: dt-bindings: change spi-{rx,tx}-bus-width to arrays
> >>     
> >>     Change spi-rx-bus-width and spi-tx-bus-width properties from single
> >>     uint32 values to arrays of uint32 values. This allows describing SPI
> >>     peripherals connected to controllers that have multiple data lanes for
> >>     receiving or transmitting two or more words at the same time.
> >>     
> >>     Bindings that make use of this property are updated in the same commit
> >>     to avoid validation errors. Bindings that used minimum/maximum are
> >>     changed to use enum instead to be consistent with the base property
> >>     definition.
> >>     
> >>     The adi,ad4030 binding has an example added now that we can fully
> >>     describe the peripheral's capabilities.
> >>     
> >>     Converting from single uint32 to array of uint32 does not break .dts/
> >>     .dtb files since there is no difference between specifying a single
> >>     uint32 value and an array with a single uint32 value in devicetree.
> >>     
> >>     Signed-off-by: David Lechner <dlechner@baylibre.com>
> >> ---   
> >>
> >> diff --git a/Documentation/devicetree/bindings/display/panel/sitronix,st7789v.yaml b/Documentation/devicetree/bindings/display/panel/sitronix,st7789v.yaml
> >> index 0ce2ea13583d..23b33dcd5ed4 100644
> >> --- a/Documentation/devicetree/bindings/display/panel/sitronix,st7789v.yaml
> >> +++ b/Documentation/devicetree/bindings/display/panel/sitronix,st7789v.yaml
> >> @@ -34,8 +34,8 @@ properties:
> >>    spi-cpol: true
> >>  
> >>    spi-rx-bus-width:
> >> -    minimum: 0
> >> -    maximum: 1
> >> +    items:
> >> +      enum: [0, 1]
> >>  
> >>    dc-gpios:
> >>      maxItems: 1
> >> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
> >> index 54e7349317b7..6052a44b04de 100644
> >> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
> >> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
> >> @@ -37,7 +37,8 @@ properties:
> >>      maximum: 102040816
> >>  
> >>    spi-rx-bus-width:
> >> -    enum: [1, 2, 4]
> >> +    items:
> >> +      enum: [1, 2, 4]
> > 
> > We'd need to allow 0 here, right?
> 
> To avoid binding check failures, yes, I suppose so. All of the
> `const: 1` would need to be changed to `enum: [0, 1]` as well.
> 
> Although since the controller also could have limitations maybe
> we should have the controller use `enum` and have the peripheral
> use `maximum`?

Yeah, that's probably better.

> Then, if we have a controller with:
> 
> patternProperties:
>   "@[0-9a-f]+$":
>       # controller has 2 lanes with 2 lines per lane
>       spi-rx-bus-width:
> 	maxItems: 2
>         items:
>           enum: [0, 1, 2]
> 
> And a peripheral with:
> 
> properties:
>   spi-rx-bus-width:
>     items:
>       maximum: 4
> 
> The controller limit would be in effect and cause a binding check error
> if attempting to use bus width of 4.
> 
> But if the controller was enum: [0, 1, 2, 4, 8], then the peripheral
> maximum would be the limiting factor if attempting to use bus width of 8.
> 
> > 
> > What we really want to say is there is exactly 1 entry of 1, 2, or 4. I
> 
> Not sure this is what we want. For the ADC cases, we want 2 or 4 items
> in the array to be the same value.

I meant for devices with only 1 possible channel attached to a 
controller with multiple channels.

On an ADC with multiple channels, you'd want 'minItems: 2' (or more) 
unless it can work with a single channel.

>  
> > can't think of a concise way to say that. The closest is something like 
> > this:
> > 
> > uniqueItems: true
> > items:
> >   enum: [0, 1, 2, 4]
> > contains:
> >   enum: [1, 2, 4]

Actually, uniqueItems doesn't work here. It would prevent multiple 
unused channels (e.g. [0, 4, 0, 0] ).

So there's not really any sane way to constrain this case. That's fine I 
guess.

Rob

