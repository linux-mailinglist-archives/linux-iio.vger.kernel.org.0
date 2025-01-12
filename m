Return-Path: <linux-iio+bounces-14184-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4B5A0A8FE
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 13:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DDC716602F
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 12:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C441B0414;
	Sun, 12 Jan 2025 12:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qC8IuYhu"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C229139B;
	Sun, 12 Jan 2025 12:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736683959; cv=none; b=HZuBGLf7AIug8d/R1wwPdEMb2NBAsLQP/g7cQzuFx+lGQyRqmiTWcHIRL+navILky8aqtIWuOk+pMqkz4qTJ4PWUkAHD+X+tqzi3JOX/jxflwk7I/JhumqoVf+XgBtJmoOnpFI1lwnjYJUqErQIg99UZUQ4tGcJO+M1+PmIV6rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736683959; c=relaxed/simple;
	bh=xYj1b4y4XeuSD718qeu8JW7X5RvVi6g4820wPHLRsME=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iCzk3tNE6/xhwPnbCghoCtRiyD4a7u5Y41R0fICC6FfidQakwg68DF8J82aSDcEzpZYYNtQqqhpJMaB5hbpHT1o51TfvrKZxO8hTh8gztcCvzJRxx31IJexvq1WDSWuFN41sOvZVzdqSs1qj1SJLaQdsAyvoBdNbZ51Zo2X3dbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qC8IuYhu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F28F0C4CEDF;
	Sun, 12 Jan 2025 12:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736683958;
	bh=xYj1b4y4XeuSD718qeu8JW7X5RvVi6g4820wPHLRsME=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qC8IuYhum55nN4iRvquBvGQFj3yIPm1/itzZtWL1t1WwMzwgdjDMOW23FTRrYE0Pv
	 xXQRj7PaTfzvKT7UTq1XqAb/VPsOCLHYewmNoBzoFpXFnCVpmKDJGfDGdVyGPsGLTZ
	 9eDdXOBF4DjuHvGSvMyb7URDAoIvATm6b416STgtgPltbZEf90nTok5o02ZStII4j8
	 Z6znd0KV2T/GVCEThyP68O5y04FPv+kqzfDd3U8RJLwR3mJTcznXU58iwPTOVvkvyT
	 8ZWxRjCXHjYFY5Jf6z9T9A3U9FrZddozRyntN4EEJrMYUou0XPukkuaTnfwBmFO24s
	 W8NPGkfkTD8AQ==
Date: Sun, 12 Jan 2025 12:12:29 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan Santos <jonath4nns@gmail.com>
Cc: dc7f6461-6fce-4dbd-9be4-f7814053e7dc@baylibre.com, David Lechner
 <dlechner@baylibre.com>, Jonathan Santos <Jonathan.Santos@analog.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, lars@metafoo.de,
 Michael.Hennerich@analog.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v1 01/15] dt-bindings: iio: adc: ad7768-1: add
 synchronization over SPI property
Message-ID: <20250112121229.5bc7545c@jic23-huawei>
In-Reply-To: <Z4Lx5myE2OPDie6n@JSANTO12-L01.ad.analog.com>
References: <cover.1736201898.git.Jonathan.Santos@analog.com>
	<bde43579b41199f0c17f07dfacefcb137028e66e.1736201898.git.Jonathan.Santos@analog.com>
	<dc7f6461-6fce-4dbd-9be4-f7814053e7dc@baylibre.com>
	<Z4Lx5myE2OPDie6n@JSANTO12-L01.ad.analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 11 Jan 2025 19:34:14 -0300
Jonathan Santos <jonath4nns@gmail.com> wrote:

> On 01/07, David Lechner wrote:
> > On 1/7/25 9:24 AM, Jonathan Santos wrote:  
> > > Add adi,sync-in-spi property to enable synchronization over SPI.
> > > This should be used in the case when the GPIO cannot provide a
> > > pulse synchronous with the base MCLK signal.
> > > 
> > > User can choose between SPI, GPIO synchronization or neither of them,
> > > but only if a external pulse can be provided, for example, by another
> > > device in a multidevice setup.
> > >   
> > 
> > While we are fixing up these bindings, we could add some more trivial things,
> > like power supplies.
> > 
> > Also, the interrupt property could use a description since the chip has multiple
> > output pins. I assume it means the /DRDY pin?
> >   
> 
> Right! Yes, the interrupt pin refers to the /DRDY.
> 
> > > Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> > > ---
> > >  .../bindings/iio/adc/adi,ad7768-1.yaml        | 24 ++++++++++++++++++-
> > >  1 file changed, 23 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
> > > index 3ce59d4d065f..55cec27bfe60 100644
> > > --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
> > > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
> > > @@ -47,6 +47,15 @@ properties:
> > >        in any way, for example if the filter decimation rate changes.
> > >        As the line is active low, it should be marked GPIO_ACTIVE_LOW.
> > >  
> > > +  adi,sync-in-spi:  
> > 
> > If this is saying that SYNC_OUT is connected to SYNC_IN, then I think the name
> > should be something like adi,sync-in-sync-out. SPI seems irrelevant here since
> > we should just be describing how things are wired up, not how it is being used.
> > 
> > But if we also need to consider the case where SYNC_OUT of one chip is connected
> > to SYNC_IN of another chip, we might want to consider using trigger-source
> > bindings instead (recently standardized in dtschema).
> >   
> 
> Do you mean the trigger-sources used for LEDs? I can try to see if it works, but would it
> handle the non-GPIO case? While testing a multidevice setup, I found it simpler to 
> have a single device to manage everything. It lets us toggle the GPIO or /SYNC_OUT
> without referencing another device and makes simultaneous buffered reads easier.

Daisy-chain mode (figure 131)?  In that case we normally end up with a single presented device
with a 'lot' of channels. (See the electric car style battery charging chips, those can
be chained in very large numbers!)

Probably similar for figure 133 (which is a dual SPI setup) as the SPI clock must
be shared so we still see it over a single interface.

If those are the only two options then keeping this within the driver is fine.
For daisy chain there are examples in tree and it normally means we have to
have a DT parameter that says how long the chain is, though we maybe can
do that with per channel nodes as well if those make sense here.

Jonathan


> 
> Maybe we could stick to synchronization within the chip for now.
> 
> > > +    description:
> > > +      Enables synchronization of multiple devices over SPI. This property is
> > > +      used when a signal synchronous to the base MCLK signal cannot be provided
> > > +      via GPIO. It requires the SYNC_OUT pin to be connected to the SYNC_IN pin
> > > +      on the ADC. In the case of multiple devices, the SYNC_OUT pin of one device
> > > +      should be routed to the SYNC_IN pins of the other devices.
> > > +    type: boolean
> > > +
> > >    reset-gpios:
> > >      maxItems: 1
> > >  
> > > @@ -65,7 +74,6 @@ required:
> > >    - vref-supply
> > >    - spi-cpol
> > >    - spi-cpha
> > > -  - adi,sync-in-gpios
> > >  
> > >  patternProperties:
> > >    "^channel@([0-9]|1[0-5])$":
> > > @@ -89,6 +97,20 @@ patternProperties:
> > >  allOf:
> > >    - $ref: /schemas/spi/spi-peripheral-props.yaml#
> > >  
> > > +  # adi,sync-in-gpios and adi,sync-in-spi are mutually exclusive (neither is also valid)
> > > +  - if:
> > > +      required:
> > > +        - adi,sync-in-gpios
> > > +    then:
> > > +      properties:
> > > +        adi,sync-in-spi: false
> > > +  - if:
> > > +      required:
> > > +        - adi,sync-in-spi
> > > +    then:
> > > +      properties:
> > > +        adi,sync-in-gpios: false  
> > 
> > I think this can be simplified to using oneOf: to provide XOR validation
> >   
> 
> Right!
> 
> > > +
> > >  unevaluatedProperties: false
> > >  
> > >  examples:  
> >   


