Return-Path: <linux-iio+bounces-26816-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D3ACA9C7E
	for <lists+linux-iio@lfdr.de>; Sat, 06 Dec 2025 01:57:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F01793240070
	for <lists+linux-iio@lfdr.de>; Sat,  6 Dec 2025 00:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9687E30E820;
	Sat,  6 Dec 2025 00:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pBM3ZoKa"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453BF17BA2;
	Sat,  6 Dec 2025 00:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764982082; cv=none; b=XudphbTNFav09W69M91yFyT1f7Kd3DJuKmbZ0zttBbbhyRpmGbStQ6OQnOpmUJHer6JtK1yzWx0zFiIGQ/bmUOu+j9euZUO6E7kOiTDDmh7xFpo0SJKaLcCPbuEhVM+8aAIgCPcUPbccybPsG8QEfOL8oQxNLSfxIAsJexmPWvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764982082; c=relaxed/simple;
	bh=3r+/te3zSS54bBwDzvPEgNnCe8Q1KuObyX/Z1h+VAc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IGUrPyCEIktykaA29YbkMS1O8pau6kL/CTIp5/0A1QJLz6gAxXW6A10KvgOJaMV8DnyeJOg4Hdgurc63VPkW5EflUr0ImaxzvzBETujxgQrxw0VrvjuvjucbMs2RY9QY5nJBSeuykrYN+0DciFvYA/wcbhOWP+8jOLV7MNZA8cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pBM3ZoKa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9763EC4CEF1;
	Sat,  6 Dec 2025 00:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764982079;
	bh=3r+/te3zSS54bBwDzvPEgNnCe8Q1KuObyX/Z1h+VAc8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pBM3ZoKapRQzNDKhiluRNsGLO9XMjo6IJk7ZyjS4dGXSFjccyWLfqRKlvUnrAKHtC
	 Hw5CUQJaLnSH8fhzHoKV69Jk/xhi+WzTfXinlV9CYsPjcuDrugOivS1SOiJJYpEjhB
	 1Th+I7g8JRA9Blsj2dPec4xpySarXaN2mfP5m31sImtRnLUNT/6fPd8XUKgpJfMEfv
	 GJM432SADyG/M6vctTMhwFDYItqCKzHX5pWpArtaTRxRkc4Hhg+xb4fVR0Sagze1cv
	 hg8xozF4cf+Blnm+tuyL6SAJpEX8BZBSNr7KYGGliyTG+w7DftTOxdGWtT2f7cwL8m
	 gO4MsQVEQeINg==
Date: Fri, 5 Dec 2025 18:47:57 -0600
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
Message-ID: <20251206004757.GA980619-robh@kernel.org>
References: <20251201-spi-add-multi-bus-support-v3-0-34e05791de83@baylibre.com>
 <20251201-spi-add-multi-bus-support-v3-7-34e05791de83@baylibre.com>
 <20251204213348.GA2198382-robh@kernel.org>
 <aTNKyaWAEjVJixMI@debian-BULLSEYE-live-builder-AMD64>
 <0cf78f84-01e7-4507-abf9-2f82f98206b2@baylibre.com>
 <221d5ed6-51da-4dce-b8a7-58b4d2423101@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <221d5ed6-51da-4dce-b8a7-58b4d2423101@baylibre.com>

On Fri, Dec 05, 2025 at 05:43:31PM -0600, David Lechner wrote:
> On 12/5/25 3:33 PM, David Lechner wrote:
> > On 12/5/25 3:12 PM, Marcelo Schmitt wrote:
> >> On 12/04, Rob Herring wrote:
> >>> On Mon, Dec 01, 2025 at 08:20:45PM -0600, David Lechner wrote:
> >>>> Add data-lanes property to specify the number of data lanes used on the
> >>>> ad463x chips that support reading two samples at the same time using
> >>>> two data lanes with a capable SPI controller.
> >>>>
> >>>> Signed-off-by: David Lechner <dlechner@baylibre.com>
> >>>> ---
> >>>> v3 changes: new patch
> >>>>
> >>>> I added this one to give a real-world use case where spi-rx-bus-width
> >>>> was not sufficient to fully describe the hardware configuration.
> >>>>
> >>>> spi-rx-bus-width = <4>; alone could be be interpreted as either:
> >>>>
> >>>> +--------------+    +----------+
> >>>> | SPI          |    | AD4630   |
> >>>> | Controller   |    | ADC      |
> >>>> |              |    |          |
> >>>> |        SDIA0 |<---| SDOA0    |
> >>>> |        SDIA1 |<---| SDOA1    |
> >>>> |        SDIA2 |<---| SDOA2    |
> >>>> |        SDIA3 |<---| SDOA3    |
> >>>> |              |    |          |
> >>>> |        SDIB0 |x   | SDOB0    |
> >>>> |        SDIB1 |x   | SDOB1    |
> >>>> |        SDIB2 |x   | SDOB2    |
> >>>> |        SDIB3 |x   | SDOB3    |
> >>>> |              |    |          |
> >>>> +--------------+     +---------+
> >>>>
> >>>> or
> >>>>
> >>>> +--------------+    +----------+
> >>>> | SPI          |    | AD4630   |
> >>>> | Controller   |    | ADC      |
> >>>> |              |    |          |
> >>>> |        SDIA0 |<---| SDOA0    |
> >>>> |        SDIA1 |<---| SDOA1    |
> >>>> |        SDIA2 |x   | SDOA2    |
> >>>> |        SDIA3 |x   | SDOA3    |
> >>>> |              |    |          |
> >>>> |        SDIB0 |<---| SDOB0    |
> >>>> |        SDIB1 |<---| SDOB1    |
> >>>> |        SDIB2 |x   | SDOB2    |
> >>>> |        SDIB3 |x   | SDOB3    |
> >>>> |              |    |          |
> >>>> +--------------+     +---------+
> >>>>
> >>>> Now, with data-lanes having a default value of [0] (inherited from
> >>>> spi-peripheral-props.yaml), specifying:
> >>>>
> >>>>     spi-rx-bus-width = <4>;
> >>>>
> >>>> is unambiguously the first case and the example given in the binding
> >>>> documentation is the second case:
> >>>>
> >>>>     spi-rx-bus-width = <2>;
> >>>>     data-lanes = <0>, <1>;
> >>>
> >>> I just reviewed this and all, but what if you just did:
> >>>
> >>> spi-rx-bus-width = <2>, <2>;
> >>>
> >>> So *-bus-width becomes equal to the number of serializers/channels.
> >>
> >> Unless I'm missing something, I think that would also describe the currently
> >> possible use cases as well. To me, it actually seems even more accurate than
> >> data-lanes. The data-lanes property only describes the SPI controller input
> >> lines/lanes, no info is given about the output lanes.
> > 
> > It describes both directions.
> > 
> >> Well yeah, that would only> be a problem for a device with multiple input serializers and multiple output
> >> serializers. Still, the *-bus-width = <N>, <N>, ... <N>; notation looks clearer,
> >> IMHO.
> >>
> >>>
> >>> Rob
> >>>
> > 
> > It think it complicates Sean's use case though where such
> > a controller is being used as basically two separate SPI
> > buses.
> > 
> > For that case, we want to be able to do:
> > 
> > spi {
> > 	...
> > 
> > 	thing@0 {
> > 		compatible = ...;
> > 		reg = <0>;
> > 		/* (implicit) data-lanes = <0>; */
> > 	};
> > 
> > 	thing@1 {
> > 		compatible = ...;
> > 		reg = <1>;
> > 		data-lanes = <1>;
> > 	};
> > };
> > 
> > Meaning:
> > 
> > +--------------+    +----------+
> > | SPI          |    | Thing 1  |
> > | Controller   |    |          |
> > |              |    |          |
> > |          CS0 |--->| CS       |
> > |         SDI0 |<---| SDO      |
> > |         SDO0 |--->| SDI      |
> > |        SCLK0 |--->| SCLK     |
> > |              |    |          |
> > |              |    +----------+
> > |              |                
> > |              |    +----------+
> > |              |    | Thing 2  |
> > |              |    |          |
> > |          CS1 |--->| CS       |
> > |         SDI1 |<---| SDO      |
> > |         SDO1 |--->| SDI      |
> > |        SCLK1 |--->| SCLK     |
> > |              |    |          |
> > +--------------+    +----------+
> > 
> > (I don't remember if SCLKs are shared or separate, but I don't
> > think that is relevant anyway).
> > 
> > 
> > I guess we could write it like this?
> > 
> > spi {
> > 	...
> > 
> > 	thing@0 {
> > 		compatible = ...;
> > 		reg = <0>;
> > 	};
> > 
> > 	thing@1 {
> > 		compatible = ...;
> > 		reg = <1>;
> > 		spi-tx-bus-width = <0>, <1>;
> > 		spi-rx-bus-width = <0>, <1>;
> > 	};
> > };

I forget the details on that, but just looking at the above I think 
something like that should have 2 SPI bus nodes under the controller. 
Unless CS0 and CS1 can't be asserted at the same time and they aren't 
really independent.

But would be good to wait for Sean's comments here.

> 
> I started down this road. Before I do the working of changing the
> whole series, this is what it will probably look like. Is this really
> what we want?
> 
> There is one issue I see with this. If we allow <0> to mean that a lane
> isn't wired up on the controller, then we can't constrain the length of
> the array in peripheral bindings. For example, the ad403x chips can only
> have one lane and the ad463x chips can have one or two lanes. But I
> don't see a way to express that in the binding if <0> at any index
> doesn't count towards the number of lanes that are actually wired up.

That's fine I think. How many entries is primarily a controller 
property. We set the length in the controller binding. The device just 
sets the maximum width per channel.

> 
> This is e.g. why the binding in sitronix,st7789v.yaml is
> 
> 	items:
> 	  enum: [0, 1]
> 
> rather than
> 
> 	items:
> 	  - enum: [0, 1]
> 
> ---
> commit 049b9508b1b0190f87a4b35fe3ed8a9f3d0d3c50
> Author: David Lechner <dlechner@baylibre.com>
> Date:   Fri Dec 5 16:09:08 2025 -0600
> 
>     spi: dt-bindings: change spi-{rx,tx}-bus-width to arrays
>     
>     Change spi-rx-bus-width and spi-tx-bus-width properties from single
>     uint32 values to arrays of uint32 values. This allows describing SPI
>     peripherals connected to controllers that have multiple data lanes for
>     receiving or transmitting two or more words at the same time.
>     
>     Bindings that make use of this property are updated in the same commit
>     to avoid validation errors. Bindings that used minimum/maximum are
>     changed to use enum instead to be consistent with the base property
>     definition.
>     
>     The adi,ad4030 binding has an example added now that we can fully
>     describe the peripheral's capabilities.
>     
>     Converting from single uint32 to array of uint32 does not break .dts/
>     .dtb files since there is no difference between specifying a single
>     uint32 value and an array with a single uint32 value in devicetree.
>     
>     Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---   
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/sitronix,st7789v.yaml b/Documentation/devicetree/bindings/display/panel/sitronix,st7789v.yaml
> index 0ce2ea13583d..23b33dcd5ed4 100644
> --- a/Documentation/devicetree/bindings/display/panel/sitronix,st7789v.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/sitronix,st7789v.yaml
> @@ -34,8 +34,8 @@ properties:
>    spi-cpol: true
>  
>    spi-rx-bus-width:
> -    minimum: 0
> -    maximum: 1
> +    items:
> +      enum: [0, 1]
>  
>    dc-gpios:
>      maxItems: 1
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
> index 54e7349317b7..6052a44b04de 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
> @@ -37,7 +37,8 @@ properties:
>      maximum: 102040816
>  
>    spi-rx-bus-width:
> -    enum: [1, 2, 4]
> +    items:
> +      enum: [1, 2, 4]

We'd need to allow 0 here, right?

What we really want to say is there is exactly 1 entry of 1, 2, or 4. I 
can't think of a concise way to say that. The closest is something like 
this:

uniqueItems: true
items:
  enum: [0, 1, 2, 4]
contains:
  enum: [1, 2, 4]

That implicitly limits the length to 4, but does allow [0, 1, 2, 4] and 
other ordering. More generally, if the device supports fewer channels 
than the host, then we can't constrain that. Oh well, we can't check 
everything (we hardly check values within reg, interrupts, clocks, and 
on and on). But most controllers are going to limit the length to 1 
entry, so it should end up with the same constraints most of the time.

Are these updates all of them or just a sampling. If the latter and 
there's a lot more, then we may want to split spi-controller.yaml into 
2 (3 really with a common part). Make spi-controller.yaml define single 
channel SPI controllers which keeps the length of spi-[rt]x-bus-width at 
1 entry and then define a spi-multi-chan-controller.yaml which doesn't 
constrain it. 

Rob

