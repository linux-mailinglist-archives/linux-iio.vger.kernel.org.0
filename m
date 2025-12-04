Return-Path: <linux-iio+bounces-26735-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 878E8CA4093
	for <lists+linux-iio@lfdr.de>; Thu, 04 Dec 2025 15:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8C8431103AD
	for <lists+linux-iio@lfdr.de>; Thu,  4 Dec 2025 14:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B55342C99;
	Thu,  4 Dec 2025 14:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a9GptvhQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC8F3054F2;
	Thu,  4 Dec 2025 14:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764858529; cv=none; b=DYxPZ8v3oO6R3rga+bNDBqF7P5XRngXgl2Ljtr/0Dsx0j97lT9ouY1g/mfhQk/EI16Kuw/xiKp8Gv20L82vEPYGecyOtgBJaA+fPM24U0pb13Ar3aXcJ2ZNZX+f0A2yg0LpxLBOqDJC/Bxcbbjl6X8UAvVwFCYLBtWTyERgXeLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764858529; c=relaxed/simple;
	bh=A7S0aqhNRp49+kPkpgOvDyswMTwDTAIZeVEntaKMiNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bMZZF4nunW2mJSt10bEZaypS5GrBNLKK1zrx1ZNvoX+BrCNa56dJrRiZq125APyIofC9JDF+E+oUYynRmlkKLFsFLn/rHOJn4FKWJ8n8GogZL4Uy5zHferaKbt24CTdobTdu4YGBfH8BKdK8aCbRWLPTanNjk7aGEiGfAdbnJGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a9GptvhQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79BA4C4CEFB;
	Thu,  4 Dec 2025 14:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764858528;
	bh=A7S0aqhNRp49+kPkpgOvDyswMTwDTAIZeVEntaKMiNQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a9GptvhQzmrjIUAqXiGQVaXFPMJNpIA4Qs32xCzl131Ra7qCHiyRdEQsozNMtl1Ld
	 NUQCKuQH+qKMmEk2IfpmR2tNKt5MdF77GT8GUOaJO5EPx2ZpOnJBAt8o21q9C9p1yi
	 nP6zSys2/qtwTh/vrJ+6ncCJw2FEux1vriv+ePMLn68vWQTF3Q1IZpkRSLo9Sr55UY
	 Ufs5Cc1zW8i6EVQa520w3g+9VIDoSQsSLQdmGsS//oju94/ju9Xz9DxNBDHPu+TX/1
	 T5833m7y33jm87qabnz8O7cALxpnmAk++SUOJM8lg6i7EVU0xABXsYyCt9ki8LbOUF
	 /yEgbRVcPHnTQ==
Date: Thu, 4 Dec 2025 08:28:45 -0600
From: Rob Herring <robh@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>,
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
Subject: Re: [PATCH v2 5/6] dt-bindings: iio: adc: adi,ad7380: add spi-buses
 property
Message-ID: <20251204142845.GA1303976-robh@kernel.org>
References: <20251107-spi-add-multi-bus-support-v2-0-8a92693314d9@baylibre.com>
 <20251107-spi-add-multi-bus-support-v2-5-8a92693314d9@baylibre.com>
 <20251118155905.GB3236324-robh@kernel.org>
 <97c6b55d-9505-4091-8f0b-317dcbd70838@baylibre.com>
 <CAL_Jsq+ZZE0g424jE75xeCt2KY1ThPLqmbmOs0o_ddaJ8fOf3w@mail.gmail.com>
 <f2ac13fc-8f47-465e-8cef-e2e34bf41818@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f2ac13fc-8f47-465e-8cef-e2e34bf41818@baylibre.com>

On Wed, Nov 19, 2025 at 08:45:42AM -0600, David Lechner wrote:
> On 11/19/25 7:18 AM, Rob Herring wrote:
> > On Tue, Nov 18, 2025 at 11:46 AM David Lechner <dlechner@baylibre.com> wrote:
> >>
> >> On 11/18/25 9:59 AM, Rob Herring wrote:
> >>> On Fri, Nov 07, 2025 at 02:52:51PM -0600, David Lechner wrote:
> >>>> Add spi-buses property to describe how many SDO lines are wired up on
> >>>> the ADC. These chips are simultaneous sampling ADCs and have one SDO
> >>>> line per channel, either 2 or 4 total depending on the part number.
> >>>>
> >>>> Signed-off-by: David Lechner <dlechner@baylibre.com>
> >>>> ---
> >>>>  .../devicetree/bindings/iio/adc/adi,ad7380.yaml    | 22 ++++++++++++++++++++++
> >>>>  1 file changed, 22 insertions(+)
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
> >>>> index b91bfb16ed6bc6c605880f81050250d1ed9c307a..9ef46cdb047d45d088e0fbc345f58c5b09083385 100644
> >>>> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
> >>>> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
> >>>> @@ -62,6 +62,10 @@ properties:
> >>>>    spi-cpol: true
> >>>>    spi-cpha: true
> >>>>
> >>>> +  spi-data-buses:
> >>>> +    minItems: 1
> >>>> +    maxItems: 4
> >>>> +
> >>>
> >>> As the property is not required, what's the default?
> >>
> >> spi-perepheral-props.yaml defines:
> >>
> >>         default: [0]
> >>
> >> Do I need to repeat that here?
> > 
> > No. So that means you only use one channel and the others are not connected?
> 
> Correct.
> 
> > 
> >>
> >>>
> >>>>    vcc-supply:
> >>>>      description: A 3V to 3.6V supply that powers the chip.
> >>>>
> >>>> @@ -245,6 +249,22 @@ allOf:
> >>>>        patternProperties:
> >>>>          "^channel@[0-3]$": false
> >>>>
> >>>> +  # 2-channel chip can only have up to 2 buses
> >>>> +  - if:
> >>>> +      properties:
> >>>> +        compatible:
> >>>> +          enum:
> >>>> +            - adi,ad7380
> >>>> +            - adi,ad7381
> >>>> +            - adi,ad7386
> >>>> +            - adi,ad7387
> >>>> +            - adi,ad7388
> >>>> +            - adi,ad7389
> >>>> +    then:
> >>>> +      properties:
> >>>> +        spi-data-buses:
> >>>> +          maxItems: 2
> >>>> +
> >>>>  examples:
> >>>>    - |
> >>>>      #include <dt-bindings/interrupt-controller/irq.h>
> >>>> @@ -260,6 +280,7 @@ examples:
> >>>>              spi-cpol;
> >>>>              spi-cpha;
> >>>>              spi-max-frequency = <80000000>;
> >>>> +            spi-data-buses = <0>, <1>;
> >>>>
> >>>>              interrupts = <27 IRQ_TYPE_EDGE_FALLING>;
> >>>>              interrupt-parent = <&gpio0>;
> >>>> @@ -284,6 +305,7 @@ examples:
> >>>>              spi-cpol;
> >>>>              spi-cpha;
> >>>>              spi-max-frequency = <80000000>;
> >>>> +            spi-data-buses = <0>, <1>, <2>, <3>;
> >>>
> >>> An example that doesn't look like a 1 to 1 mapping would be better.
> >>> Otherwise, it still looks to me like you could just define the bus
> >>> width.
> >>
> >> I'm not sure we could do that on this chip since it doesn't have
> >> the possibility of more than one line per channel.
> > 
> > That's a property of the SPI controller though, right?
> > 
> > If the above controller had 4 lines per channel/serializer, then you could have:
> > 
> > spi-data-buses = <0>, <4>, <8>, <12>;
> 
> Ah, I get what you mean now. The intention here though was that the
> index numbers correspond to the data lane (channel/serializer), not
> to individual lines. So the example you gave would mean that the chip
> has at least 13 data lanes (rather than what I think your intention was
> of saying it has at least 16 data wires). I did it that way because all
> of the hardware I looked at didn't allow assigning arbitrary data lines
> to arbitrary lanes/channels so it keeps things simpler and easier to match
> to the actual hardware docs.

But what happens if there is such h/w? Better to design things for 
something we can visualize and not have to revisit this. Of course there 
will be things we don't anticipate. (Who thought we'd have parallel 
SPI...)

I suppose if that's rare enough we can just have another property to map 
pins to channels.

Rob

