Return-Path: <linux-iio+bounces-6833-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B413B9155D8
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 19:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65C3F281D5E
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 17:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE3719FA6F;
	Mon, 24 Jun 2024 17:52:28 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A4519E822;
	Mon, 24 Jun 2024 17:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719251548; cv=none; b=XbRzmQeboRgm43oNABfC0qMkr5JuQnhLR/8IAhEogvBKhtKhjsopdJtDgJZA1qzgHse/NOwEBcrw7A31z+4hG2UDhskl1xrkm+/v6v/TuoBH9TH8Zp9qliDr9XmhGZKzgKYr49yPOs4n61IxN2m0GP1Ma/ur7RN9XjnHDCL5pSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719251548; c=relaxed/simple;
	bh=Uiy9GqA3kD/mn5PsuWRqXxUJk/OTGXa94Bg//LfXQYI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dLE1qYW5dWekVxzsqI9vJd6d5Yr5XWZaaYycmTQYYL1UjUMOC//K37xWdqXwxZD7eAu1fYKDukmC6XDzg7889/ukqVFDjppQmW3U2ZBcriC+r+FQ1Hb0dc9/oU2ml7NcsqD1enWQuLrRpTOduVTkJyJ/IMARVXILSIz4YsQYDqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4W7Fqk60Zlz6K9fG;
	Tue, 25 Jun 2024 01:50:42 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 29DA71400DB;
	Tue, 25 Jun 2024 01:52:22 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 24 Jun
 2024 18:52:21 +0100
Date: Mon, 24 Jun 2024 18:52:20 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: David Lechner <dlechner@baylibre.com>
CC: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>, Nuno =?ISO-8859-1?Q?S=E1?=
	<nuno.sa@analog.com>, Jonathan Corbet <corbet@lwn.net>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] dt-bindings: iio: adc: add AD4695 and similar
 ADCs
Message-ID: <20240624185220.000044d8@Huawei.com>
In-Reply-To: <204e6729-d5b0-4d44-85d5-e8de7541b689@baylibre.com>
References: <20240617-iio-adc-ad4695-v2-0-63ef6583f25d@baylibre.com>
	<20240617-iio-adc-ad4695-v2-2-63ef6583f25d@baylibre.com>
	<187da75c-9af3-42a9-b31e-be731aaf63d2@baylibre.com>
	<20240623173911.7ea5d518@jic23-huawei>
	<204e6729-d5b0-4d44-85d5-e8de7541b689@baylibre.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 24 Jun 2024 09:36:43 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 6/23/24 11:39 AM, Jonathan Cameron wrote:
> > On Tue, 18 Jun 2024 14:29:10 -0500
> > David Lechner <dlechner@baylibre.com> wrote:
> >   
> >> On 6/17/24 2:53 PM, David Lechner wrote:  
> >>> Add device tree bindings for AD4695 and similar ADCs.
> >>>
> >>> Signed-off-by: David Lechner <dlechner@baylibre.com>
> >>> ---
> >>>     
> >> ...
> >>  
> >>> +
> >>> +  interrupts:
> >>> +    minItems: 1
> >>> +    items:
> >>> +      - description:
> >>> +          Signal coming from the BSY_ALT_GP0 or GP3 pin that indicates a busy
> >>> +          condition.
> >>> +      - description:
> >>> +          Signal coming from the BSY_ALT_GP0 or GP2 pin that indicates an alert
> >>> +          condition.
> >>> +
> >>> +  interrupt-names:
> >>> +    minItems: 1
> >>> +    items:
> >>> +      - const: busy
> >>> +      - const: alert
> >>> +    
> >>
> >> Since the interrupt can come from two different pins, it seems like we would
> >> need an extra property to specify this. Is there a standard way to do this?
> >>
> >> Otherwise I will add something like:
> >>
> >> adi,busy-on-gp3:
> >>   $ref: /schemas/types.yaml#/definitions/flag
> >>   description:
> >>     When present, the busy interrupt is coming from the GP3 pin, otherwise
> >>     the interrupt is coming from the BSY_ALT_GP0 pin.
> >>    
> >> adi,alert-on-gp2:
> >>   $ref: /schemas/types.yaml#/definitions/flag
> >>   description:
> >>     When present, the alert interrupt is coming from the GP2 pin, otherwise
> >>     the interrupt is coming from the BSY_ALT_GP0 pin.  
> > Cut and paste?  Or it ends up on the same pin as the bsy? In which case that's
> > a single interrupt and it's up to software to decide how to use. I'll guess
> > it comes on GP1?  
> 
> This is not a typo. The BSY_ALT_GP0 is a multi-purpose pin. The actual function
> of the pin isn't selected explicitly, but rather there is an order of priority
> (Table 25 in the datasheet).
> 
> Also, there are two packages the chip can come in, LFCSP and WLCSP. The former
> only has GP0 and not GP1/2/3.
> 
> My thinking was that if both interrupts are provided in the DT and neither
> adi,busy-on-gp3 or adi,alert-on-gp2 is given, then the driver would use
> a shared interrupt and only allow enabling one function alert or busy
> at a time.

Avoid the custom parameters They are not needed as software gets to decide
how these pins are used (if I read you description correctly)

Do it as 3 interrupts of which an combination could be supplied and the
driver gets to figure out what to use them for.

We are describing the wiring here for the interrupts, not what the driver
is doing with them.   So if only GP0 is provided then shared interrupt
it is with either alert or busy.


> 
> >>  
> > 
> > More interrupt names.  We shouldn't restrict someone wiring all 4 if they want
> > to - we'll just use 2 that we choose in the driver.
> > 
> > interrupt-names
> >   minItems: 1
> >   items:
> >     - const: busy-gp0
> >     - const: busy-gp1
> >     - const: alert-gp2
> >     - cosnt: alert-gp1  
> 
> This would actually need to be:
> 
> interrupt-names
>   minItems: 1
>   items:
>     - const: busy-gp0
>     - const: busy-gp3
>     - const: alert-gp0
>     - cosnt: alert-gp2
> 
> Or would it need to be this since there are two possible signals on the
> same pin rather than trying to mess with a shared interrupt?
> (Note: if both alert and busy are enabled at the same time on GP0, we
> will only get the alert signal and busy signal is masked).
> 
> interrupt-names
>   minItems: 1
>   items:
>     - const: alert-busy-gp0
>     - const: busy-gp3
>     - cosnt: alert-gp2

Don't describe the mode, just the pin in this case.
There are other cases of this but normally they are called int1, int2
or something like that rather than gpX.  They can have weird and complex
constraints on what is possible to signal but that's a driver problem
not a dt one.

interrupt-names:
  minItems: 1
  items:
    - const: gp0
    - const: gp3
    - const: gp2

I'm not sure I understand if there are other constraints, but if there
are I think they are on what can be used at the same time, not what can be wired.

> 
> > 
> > T     
> >>  
> >>> +
> >>> +patternProperties:
> >>> +  "^channel@[0-9a-f]$":
> >>> +    type: object
> >>> +    $ref: adc.yaml
> >>> +    unevaluatedProperties: false
> >>> +    description:
> >>> +      Describes each individual channel. In addition the properties defined
> >>> +      below, bipolar from adc.yaml is also supported.
> >>> +
> >>> +    properties:
> >>> +      reg:
> >>> +        maximum: 15
> >>> +
> >>> +      diff-channels:
> >>> +        description:
> >>> +          Describes inputs used for differential channels. The first value must
> >>> +          be an even numbered input and the second value must be the next
> >>> +          consecutive odd numbered input.
> >>> +        items:
> >>> +          - minimum: 0
> >>> +            maximum: 14
> >>> +            multipleOf: 2
> >>> +          - minimum: 1
> >>> +            maximum: 15
> >>> +            not:
> >>> +              multipleOf: 2    
> >>
> >> After some more testing, it turns out that I misunderstood the datasheet and
> >> this isn't actually fully differential, but rather pseudo-differential.
> >>
> >> So when pairing with the next pin, it is similar to pairing with the COM pin
> >> where the negative input pin is connected to a constant voltage source.  
> > 
> > Ok. I'm curious, how does it actually differ from a differential channel?
> > What was that test?  It doesn't cope with an actual differential pair and needs
> > a stable value on the negative?  
> 
> In my initial testing, since I was only doing a direct read, I was using
> constant voltages. But when I started working on buffered reads, then I
> saw noisy data when using a fully differential (antiphase) signal.
> 
> This chip uses a multiplexer for channel so when an odd number pin is used
> as the positive input (paired with REFGND or COM), it goes through one
> multiplexer, but when an odd number pin is used as the negative input
> it goes through the other multiplexer - the same one as REFGND and COM.
> 
> And burred in the middle of a paragraph on page 34 of 110 of the datasheet
> is the only place in the entire datasheet where it actually says this is
> a pseudo differential chip.

Fair enough.  Sounds like the right test to me.  I guess
that second mux has a slow tracking buffer or similar.
Good work tracking this down.

> 
> >   
> >>  
> >>> +
> >>> +      single-channel:
> >>> +        minimum: 0
> >>> +        maximum: 15
> >>> +
> >>> +      common-mode-channel:
> >>> +        description:
> >>> +          Describes the common mode channel for single channels. 0 is REFGND
> >>> +          and 1 is COM. Macros are available for these values in
> >>> +          dt-bindings/iio/adi,ad4695.h.
> >>> +        minimum: 0
> >>> +        maximum: 1
> >>> +        default: 0    
> >>
> >> So I'm thinking the right thing to do here go back to using reg and the INx
> >> number and only have common-mode-channel (no diff-channels or single-channel).
> >>
> >> common-mode-channel will need to be changed to allow INx numbers in addition
> >> to COM and REFGND.
> >>
> >> This means that [PATCH v2 1/4] "dt-bindings: iio: adc: add common-mode-channel
> >> dependency" would be wrong since we would be using common-mode-channel without
> >> single-channel.
> >>
> >> It also means we will need an optional in1-supply: true for all odd numbered
> >> inputs.  
> > Ok. I'm not totally sure I see how this comes together but will wait for v3 rather
> > than trying to figure it out now.
> > 
> > Jonathan
> > 
> >   
> 
> It should end up like other pseudo differential chips we have done recently.
> I've got it worked out, so you'll be seeing it soon enough anyway.
> 
Cool

Jonathan



