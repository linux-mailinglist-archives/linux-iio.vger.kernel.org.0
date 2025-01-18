Return-Path: <linux-iio+bounces-14444-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B994A15C94
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jan 2025 13:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA18A3A8B9D
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jan 2025 12:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D3318871D;
	Sat, 18 Jan 2025 12:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gppmD4Sq"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6442913;
	Sat, 18 Jan 2025 12:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737201645; cv=none; b=YMhRjF1HmUJGDiSS72SfWGuVeQoxeopaBmU1uHw4CrkEBkS2NgeZl4RmDbi8zxSKmwRZJuByPdqEMFoewK+PKMelpyE6RpVwn8+Un0Ip9DjkDyi/XhRkyH3gX8w7bldfuo0cSZtJ/51zX1CWYt9umaHvzVJoJYhMPpQu9+TVFH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737201645; c=relaxed/simple;
	bh=r9a4GTiiCuqgBSqcHAGkqubTgHgaz0t2Pf1AK1Gh2/E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q6kjZBa5/teOGQca1AxIa505vvKybhWhtbDLCWTNiyhojQKomliGM5XUSMmCOQClNLmLRwCwCG6EDomSVqd/C3tz1jjXQKrN8DIKiCVVIEixJOBW6TI++LWx3ICPbhKsRgNd6TCdOeg7Bn4ag+1S9l3MTHlsvj7L+GcYUZaugcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gppmD4Sq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61EE4C4CED1;
	Sat, 18 Jan 2025 12:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737201645;
	bh=r9a4GTiiCuqgBSqcHAGkqubTgHgaz0t2Pf1AK1Gh2/E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gppmD4SqUqnT0vEeBqH5BNHwqmWbtOkDyAT2U4gwdms+Q1jJhdDwfbOmd1U/B4eN7
	 ltanld/+iKlUN/zgjqzRRzOr48HMie3y0eyrKAq5B1Re4TnN7qraxtuqbBRFQ4gWkK
	 YTfXsugcrguEcYfx4rcfRane7vS/KuQ5RMpmV0cq4TB9pYW1sIJnBBN041uHvYl4vM
	 n8nfz+r5aUWToRIeGr8c0zg3MUSpgQVRbUvKUlgZunVM5mgws9PussxvFTsRvW1aT1
	 rMP8IcPjsRdL5C7QCwWavoPOyAzus8XVgbvDUGRyiHbAg6LylJBRbC09EJyT7VwRs/
	 j2QqgDZfF/8zg==
Date: Sat, 18 Jan 2025 12:00:35 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan Santos <jonath4nns@gmail.com>
Cc: 20250112120530.1950a265@jic23-huawei.smtp.subspace.kernel.org,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	Jonathan Santos <Jonathan.Santos@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, lars@metafoo.de,
	Michael.Hennerich@analog.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org
Subject: Re: [PATCH v1 01/15] dt-bindings: iio: adc: ad7768-1: add
 synchronization over SPI property
Message-ID: <20250118120035.023c6dbb@jic23-huawei>
In-Reply-To: <Z4WyoPoSmOosyioE@JSANTO12-L01.ad.analog.com>
References: <cover.1736201898.git.Jonathan.Santos@analog.com>
	<bde43579b41199f0c17f07dfacefcb137028e66e.1736201898.git.Jonathan.Santos@analog.com>
	<Z4GWSgruwnkDfYSg@debian-BULLSEYE-live-builder-AMD64>
	<20250112120530.1950a265@jic23-huawei>
	<Z4WyoPoSmOosyioE@JSANTO12-L01.ad.analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 Jan 2025 21:41:04 -0300
Jonathan Santos <jonath4nns@gmail.com> wrote:

> On 01/12, Jonathan Cameron wrote:
> > On Fri, 10 Jan 2025 18:51:06 -0300
> > Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:
> >   
> > > On 01/07, Jonathan Santos wrote:  
> > > > Add adi,sync-in-spi property to enable synchronization over SPI.
> > > > This should be used in the case when the GPIO cannot provide a
> > > > pulse synchronous with the base MCLK signal.
> > > > 
> > > > User can choose between SPI, GPIO synchronization or neither of them,
> > > > but only if a external pulse can be provided, for example, by another
> > > > device in a multidevice setup.
> > > > 
> > > > Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> > > > ---
> > > >  .../bindings/iio/adc/adi,ad7768-1.yaml        | 24 ++++++++++++++++++-
> > > >  1 file changed, 23 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
> > > > index 3ce59d4d065f..55cec27bfe60 100644
> > > > --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
> > > > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
> > > > @@ -47,6 +47,15 @@ properties:
> > > >        in any way, for example if the filter decimation rate changes.
> > > >        As the line is active low, it should be marked GPIO_ACTIVE_LOW.
> > > >  
> > > > +  adi,sync-in-spi:
> > > > +    description:
> > > > +      Enables synchronization of multiple devices over SPI. This property is
> > > > +      used when a signal synchronous to the base MCLK signal cannot be provided
> > > > +      via GPIO. It requires the SYNC_OUT pin to be connected to the SYNC_IN pin
> > > > +      on the ADC. In the case of multiple devices, the SYNC_OUT pin of one device
> > > > +      should be routed to the SYNC_IN pins of the other devices.    
> > > So, if I'm getting it right,  
> > 
> > Datasheet on this is indeed complex!
> >   
> > >/SYNC_IN may be driven by a GPIO (ADAQ7768-1 datasheet Figure 131),  
> > 
> > For that we expose a gpio binding already. If that's present we know what is going on.
> >   
> > >/SYNC_IN may be driven by own device /SYNC_OUT (ADAQ7768-1 datasheet Figure 133),  
> > 
> > This is the default - no information provided so it isn't wired externally.
> > We don't normally bother to describe required chip to chip connections.
> > I couldn't entirely figure out if this is 'required' if we aren't driving explicitly
> > from GPIO or another chip but i think it is(?).
> >  
> 
> It is. If the device is not being driven by a GPIO or an external
> device, the user should connect the /SYNC_OUT to /SYNC_IN. We could
> assume that this is the case if the GPIO is not present in the
> devicetree, maybe put that into the description. The sync-out-sync-in
> property as a boolean can be quite redundant, since we also need to
> remove the GPIO.
> 
> > >/SYNC_IN may be driven by other AD7768-1 > /SYNC_OUT pin (also Figure 133).  
> > This is only case we are about for sync in I think.
> > 
> > As long as there isn't a valid 'not connected' It think we are fine with a boolean.
> >   
> 
> If opt for a single node instace, thats ok; otherwise, David's
> trigger-sources suggestion seems to be the best approach. 
That probably works on assumption that if no gpio, or trigger source etc
bindings are present then we assume the pins are wired together and it's
simple SPI triggering (so what we'd have if none of this complexity exists!)

Jonathan

> 
> > > That is too much to describe with a boolean.
> > > 
> > > If David's suggestion of using a trigger-source doesn't fit, this property
> > > should at least become an enum or string.
> > >   
> > > > +    type: boolean
> > > > +
> > > >    reset-gpios:
> > > >      maxItems: 1
> > > >  
> > > > @@ -65,7 +74,6 @@ required:
> > > >    - vref-supply
> > > >    - spi-cpol
> > > >    - spi-cpha
> > > > -  - adi,sync-in-gpios
> > > >  
> > > >  patternProperties:
> > > >    "^channel@([0-9]|1[0-5])$":
> > > > @@ -89,6 +97,20 @@ patternProperties:
> > > >  allOf:
> > > >    - $ref: /schemas/spi/spi-peripheral-props.yaml#
> > > >  
> > > > +  # adi,sync-in-gpios and adi,sync-in-spi are mutually exclusive (neither is also valid)
> > > > +  - if:
> > > > +      required:
> > > > +        - adi,sync-in-gpios
> > > > +    then:
> > > > +      properties:
> > > > +        adi,sync-in-spi: false
> > > > +  - if:
> > > > +      required:
> > > > +        - adi,sync-in-spi
> > > > +    then:
> > > > +      properties:
> > > > +        adi,sync-in-gpios: false
> > > > +
> > > >  unevaluatedProperties: false
> > > >  
> > > >  examples:
> > > > -- 
> > > > 2.34.1
> > > >     
> >   


