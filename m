Return-Path: <linux-iio+bounces-6779-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A82913CCB
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 18:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE73CB21BA2
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2024 16:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33AC2183070;
	Sun, 23 Jun 2024 16:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FAyy/KiI"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D1527453;
	Sun, 23 Jun 2024 16:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719160759; cv=none; b=HNnYgE5dvt0VORbDYZ3CXbsojFQOeu49OjlT60y1fhK5/AtJHZvgLIDVoWGpJEJZbbkMhH+KakO4BX7MJgxxVfyIodEpkQS3G2FIpHqIOFGpQ5eJ/sEB8wIt1dZSx3o6KmCYfYdDQUlzUK4hW6Ce26u5oDUZQrfj2SzRN41IfJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719160759; c=relaxed/simple;
	bh=iyXtYUzy5O3X9DAJs0asKfGjTbzvj1GK9MGlEZocrOM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C4JRMzsSUBO+yCkr0DB6Soo1XvizCJIC2u6KR2jDJNFwj9zpfLlXUkNJ9nOjCGDG0OJPzw/mBukoo22DF2M66EH4ARUAQBNxN9wA/nVzsXeQYL/2veKWikNs1Lfzu2s43tdficPs72pT+S8ZB5sDNM5MmfbP0+2bYHbid0V0HSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FAyy/KiI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E95A0C2BD10;
	Sun, 23 Jun 2024 16:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719160758;
	bh=iyXtYUzy5O3X9DAJs0asKfGjTbzvj1GK9MGlEZocrOM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FAyy/KiI6VFRjdkCXlYt2DuzZWHdj4UDTxSJ9KLZW5fqntZne7nR/pUMXbyaIhAhs
	 O/J5JV3/CQFAZOQLLQGiL7nmF5bTYk6sFbf5Lgni3L+ZOEEMWfzXKippdylTc+eC1x
	 GwzcWSsTvrJ3Io0RLhzCUeaGdNCsLTl5fk7yQ9yq2Prn3sXl7jz7aKx/Ev9BLqD/U1
	 XqGj4nWZEPp2yd8E3XmEPWG+xM+IT6GPTaIfFzr10kx9gOYWmyY+bH2fXRuUS75vlH
	 NWNWschOP+YOcrZUC29uuPLTAIjzkcRB3sf/ATCqlXJusbF7xFw5r7FDyrWJX5odB+
	 bEJoolbh8q9bg==
Date: Sun, 23 Jun 2024 17:39:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Michael Hennerich
 <michael.hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 2/4] dt-bindings: iio: adc: add AD4695 and similar
 ADCs
Message-ID: <20240623173911.7ea5d518@jic23-huawei>
In-Reply-To: <187da75c-9af3-42a9-b31e-be731aaf63d2@baylibre.com>
References: <20240617-iio-adc-ad4695-v2-0-63ef6583f25d@baylibre.com>
	<20240617-iio-adc-ad4695-v2-2-63ef6583f25d@baylibre.com>
	<187da75c-9af3-42a9-b31e-be731aaf63d2@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Jun 2024 14:29:10 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 6/17/24 2:53 PM, David Lechner wrote:
> > Add device tree bindings for AD4695 and similar ADCs.
> > 
> > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > ---
> >   
> ...
> 
> > +
> > +  interrupts:
> > +    minItems: 1
> > +    items:
> > +      - description:
> > +          Signal coming from the BSY_ALT_GP0 or GP3 pin that indicates a busy
> > +          condition.
> > +      - description:
> > +          Signal coming from the BSY_ALT_GP0 or GP2 pin that indicates an alert
> > +          condition.
> > +
> > +  interrupt-names:
> > +    minItems: 1
> > +    items:
> > +      - const: busy
> > +      - const: alert
> > +  
> 
> Since the interrupt can come from two different pins, it seems like we would
> need an extra property to specify this. Is there a standard way to do this?
> 
> Otherwise I will add something like:
> 
> adi,busy-on-gp3:
>   $ref: /schemas/types.yaml#/definitions/flag
>   description:
>     When present, the busy interrupt is coming from the GP3 pin, otherwise
>     the interrupt is coming from the BSY_ALT_GP0 pin.
>    
> adi,alert-on-gp2:
>   $ref: /schemas/types.yaml#/definitions/flag
>   description:
>     When present, the alert interrupt is coming from the GP2 pin, otherwise
>     the interrupt is coming from the BSY_ALT_GP0 pin.
Cut and paste?  Or it ends up on the same pin as the bsy? In which case that's
a single interrupt and it's up to software to decide how to use. I'll guess
it comes on GP1?
> 

More interrupt names.  We shouldn't restrict someone wiring all 4 if they want
to - we'll just use 2 that we choose in the driver.

interrupt-names
  minItems: 1
  items:
    - const: busy-gp0
    - const: busy-gp1
    - const: alert-gp2
    - cosnt: alert-gp1

T   
> 
> > +
> > +patternProperties:
> > +  "^channel@[0-9a-f]$":
> > +    type: object
> > +    $ref: adc.yaml
> > +    unevaluatedProperties: false
> > +    description:
> > +      Describes each individual channel. In addition the properties defined
> > +      below, bipolar from adc.yaml is also supported.
> > +
> > +    properties:
> > +      reg:
> > +        maximum: 15
> > +
> > +      diff-channels:
> > +        description:
> > +          Describes inputs used for differential channels. The first value must
> > +          be an even numbered input and the second value must be the next
> > +          consecutive odd numbered input.
> > +        items:
> > +          - minimum: 0
> > +            maximum: 14
> > +            multipleOf: 2
> > +          - minimum: 1
> > +            maximum: 15
> > +            not:
> > +              multipleOf: 2  
> 
> After some more testing, it turns out that I misunderstood the datasheet and
> this isn't actually fully differential, but rather pseudo-differential.
> 
> So when pairing with the next pin, it is similar to pairing with the COM pin
> where the negative input pin is connected to a constant voltage source.

Ok. I'm curious, how does it actually differ from a differential channel?
What was that test?  It doesn't cope with an actual differential pair and needs
a stable value on the negative?

> 
> > +
> > +      single-channel:
> > +        minimum: 0
> > +        maximum: 15
> > +
> > +      common-mode-channel:
> > +        description:
> > +          Describes the common mode channel for single channels. 0 is REFGND
> > +          and 1 is COM. Macros are available for these values in
> > +          dt-bindings/iio/adi,ad4695.h.
> > +        minimum: 0
> > +        maximum: 1
> > +        default: 0  
> 
> So I'm thinking the right thing to do here go back to using reg and the INx
> number and only have common-mode-channel (no diff-channels or single-channel).
> 
> common-mode-channel will need to be changed to allow INx numbers in addition
> to COM and REFGND.
> 
> This means that [PATCH v2 1/4] "dt-bindings: iio: adc: add common-mode-channel
> dependency" would be wrong since we would be using common-mode-channel without
> single-channel.
> 
> It also means we will need an optional in1-supply: true for all odd numbered
> inputs.
Ok. I'm not totally sure I see how this comes together but will wait for v3 rather
than trying to figure it out now.

Jonathan



