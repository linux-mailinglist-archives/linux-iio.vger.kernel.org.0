Return-Path: <linux-iio+bounces-14177-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55913A0A8E9
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 13:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E9BA1886ED1
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 12:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267461ACEB3;
	Sun, 12 Jan 2025 12:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qn4f9Ylg"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB8A139B;
	Sun, 12 Jan 2025 12:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736683541; cv=none; b=F0VL5bqhxZwtY80veT/sFDoQ7XD8gYk/6gJ8JSdoRvHDoacI1qVa8/cgb26P0PLN4BJsmyVCGJdS0WoH/6oMcC8Qv6NorcB4lqu0NaFL6kRAGuGQqw02Ixo5XCrIYY2bVgo6z9d5F5MirYARe7ihvrbFeUHL1KvN0ikO83Cu8qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736683541; c=relaxed/simple;
	bh=ktLANMa+jnGipKDn/U875LSbC2dHl2mcA7foa9+gLW8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pUlxwIjddzZDTNi0VAT8qJwnBkghBJe6EnuIYQ+I5ac8qtpz/WoZLAfJU4Cq+Q49rksdii5apHSWUPeJSCRY3hUBDsbm4LTDyCM3WBNBUCyKuQwXqv/Sw13LVaQ4PKyeGmhf93I0ENzL08LGrCPDGrNOrrLTW8SIyzsB5kqQf8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qn4f9Ylg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 779EDC4CEDF;
	Sun, 12 Jan 2025 12:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736683540;
	bh=ktLANMa+jnGipKDn/U875LSbC2dHl2mcA7foa9+gLW8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qn4f9Ylgmrh+a0G1KAVNZpIXUVhg8KW5EA2dDZ1LBL/aFF+jy6toZI53zNELdJfZm
	 44OTUkyqz3Y5YfXIqbPzxw6jzUrUdt2EyvhLcZ7yKxu99VN70UYwLZ+g2DAwWGIDNA
	 rER6lTixlBmlJaSntEnuRh6J0jIREBEGvNhEe5FW4s9o/S9wkUWTXfPC6KMw8h+VdL
	 y1WSJyx2aaZ0uowSTGi4YB5le/ePbQe0qYcGk441hcT6DKw8FAakr6gOSyAOO0ajGJ
	 T/W5KI9fz/JLsMj2s2GRuMDaD9MZ2/OEjoC+DxsQY/SHcxCMJBXNpwR2jdxNdx7kZE
	 ZR15P9BtL3jSw==
Date: Sun, 12 Jan 2025 12:05:30 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, lars@metafoo.de,
 Michael.Hennerich@analog.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org
Subject: Re: [PATCH v1 01/15] dt-bindings: iio: adc: ad7768-1: add
 synchronization over SPI property
Message-ID: <20250112120530.1950a265@jic23-huawei>
In-Reply-To: <Z4GWSgruwnkDfYSg@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1736201898.git.Jonathan.Santos@analog.com>
	<bde43579b41199f0c17f07dfacefcb137028e66e.1736201898.git.Jonathan.Santos@analog.com>
	<Z4GWSgruwnkDfYSg@debian-BULLSEYE-live-builder-AMD64>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 Jan 2025 18:51:06 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> On 01/07, Jonathan Santos wrote:
> > Add adi,sync-in-spi property to enable synchronization over SPI.
> > This should be used in the case when the GPIO cannot provide a
> > pulse synchronous with the base MCLK signal.
> > 
> > User can choose between SPI, GPIO synchronization or neither of them,
> > but only if a external pulse can be provided, for example, by another
> > device in a multidevice setup.
> > 
> > Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> > ---
> >  .../bindings/iio/adc/adi,ad7768-1.yaml        | 24 ++++++++++++++++++-
> >  1 file changed, 23 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
> > index 3ce59d4d065f..55cec27bfe60 100644
> > --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
> > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
> > @@ -47,6 +47,15 @@ properties:
> >        in any way, for example if the filter decimation rate changes.
> >        As the line is active low, it should be marked GPIO_ACTIVE_LOW.
> >  
> > +  adi,sync-in-spi:
> > +    description:
> > +      Enables synchronization of multiple devices over SPI. This property is
> > +      used when a signal synchronous to the base MCLK signal cannot be provided
> > +      via GPIO. It requires the SYNC_OUT pin to be connected to the SYNC_IN pin
> > +      on the ADC. In the case of multiple devices, the SYNC_OUT pin of one device
> > +      should be routed to the SYNC_IN pins of the other devices.  
> So, if I'm getting it right,

Datasheet on this is indeed complex!

>/SYNC_IN may be driven by a GPIO (ADAQ7768-1 datasheet Figure 131),

For that we expose a gpio binding already. If that's present we know what is going on.

>/SYNC_IN may be driven by own device /SYNC_OUT (ADAQ7768-1 datasheet Figure 133),

This is the default - no information provided so it isn't wired externally.
We don't normally bother to describe required chip to chip connections.
I couldn't entirely figure out if this is 'required' if we aren't driving explicitly
from GPIO or another chip but i think it is(?).

>/SYNC_IN may be driven by other AD7768-1 > /SYNC_OUT pin (also Figure 133).
This is only case we are about for sync in I think.

As long as there isn't a valid 'not connected' It think we are fine with a boolean.

> That is too much to describe with a boolean.
> 
> If David's suggestion of using a trigger-source doesn't fit, this property
> should at least become an enum or string.
> 
> > +    type: boolean
> > +
> >    reset-gpios:
> >      maxItems: 1
> >  
> > @@ -65,7 +74,6 @@ required:
> >    - vref-supply
> >    - spi-cpol
> >    - spi-cpha
> > -  - adi,sync-in-gpios
> >  
> >  patternProperties:
> >    "^channel@([0-9]|1[0-5])$":
> > @@ -89,6 +97,20 @@ patternProperties:
> >  allOf:
> >    - $ref: /schemas/spi/spi-peripheral-props.yaml#
> >  
> > +  # adi,sync-in-gpios and adi,sync-in-spi are mutually exclusive (neither is also valid)
> > +  - if:
> > +      required:
> > +        - adi,sync-in-gpios
> > +    then:
> > +      properties:
> > +        adi,sync-in-spi: false
> > +  - if:
> > +      required:
> > +        - adi,sync-in-spi
> > +    then:
> > +      properties:
> > +        adi,sync-in-gpios: false
> > +
> >  unevaluatedProperties: false
> >  
> >  examples:
> > -- 
> > 2.34.1
> >   


