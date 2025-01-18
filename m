Return-Path: <linux-iio+bounces-14443-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 085A4A15C91
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jan 2025 12:59:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 538EB3A8B46
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jan 2025 11:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97B718B470;
	Sat, 18 Jan 2025 11:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mrjNpmWc"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB9B155757;
	Sat, 18 Jan 2025 11:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737201535; cv=none; b=rWB7t9tz1T/eBXxn+dB5dk/WG8llpHHMd+ErCXsKU2/XcSv7B3Nj+xinDpdeS2fWpmEyFITEIQXyw6+qVPEsMzTyeZpGodOpymx/+i9LAZC71An3JtO0fokHJjlW7+NfkMBhZT29l/4C0wDpMXAaakkCUprRlqmHkCA5RieFzoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737201535; c=relaxed/simple;
	bh=pmrKQ4YKlEjHO27uFH0ZemOSIQZepOHbHu2h4XvObDk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L2FXrDoDZ5zlpay6jtZSGxIiMouOoIUrkGwnYxAYoZ3Qm70cF66W6EvgVm0RunzqIBnY3gHMJgrwmt/cpsuxgTq4b2gOiJvQWRtiCLP2+rpoh8mTbdQhmxEmwxU7VqlSw+cfDumCYZlQ6HXpRaNW2Qdbw9iZGqAXW7hYk3hsttM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mrjNpmWc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CFCEC4CED1;
	Sat, 18 Jan 2025 11:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737201534;
	bh=pmrKQ4YKlEjHO27uFH0ZemOSIQZepOHbHu2h4XvObDk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mrjNpmWcVQgnW029Vm320cY3KWdLMabFERitE1zkmWh/AvL65kmDnemh1mXbrFgTz
	 Q7TsUSF2uoPMH107IwR2FcZONSTddF8hIBowe5gyJM6kb6lVSmy7fNhlURbLk+7jT4
	 WA/hfaOG5/xQGvrhdXRwZmOUUnKQAeYWnfbIAyGp9unWP6qi5lJZxIu4R92tMbIWPS
	 cTlGmePA5c9Uhq7zOs6oL4Jm0q/mNe4mrAUF0sqbuhxaXpylE3Ih5G9exm1OdkofAy
	 jFlYPDAqEHyx+sv5JaRJYtVO0iiuc0Qt8fxyzLNy6Ddnfh5a4NlGe7aYumRaCY+V8U
	 VhjsV2ulfL/mQ==
Date: Sat, 18 Jan 2025 11:58:44 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: 20250112120530.1950a265@jic23-huawei.smtp.subspace.kernel.org,
	dc7f6461-6fce-4dbd-9be4-f7814053e7dc@baylibre.com,
	Jonathan Santos <Jonathan.Santos@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, lars@metafoo.de,
	Michael.Hennerich@analog.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v1 01/15] dt-bindings: iio: adc: ad7768-1: add
 synchronization over SPI property
Message-ID: <20250118115844.733a4974@jic23-huawei>
In-Reply-To: <e5e8eba7-2455-488b-a36f-e246844e11fd@baylibre.com>
References: <cover.1736201898.git.Jonathan.Santos@analog.com>
	<bde43579b41199f0c17f07dfacefcb137028e66e.1736201898.git.Jonathan.Santos@analog.com>
	<dc7f6461-6fce-4dbd-9be4-f7814053e7dc@baylibre.com>
	<Z4Lx5myE2OPDie6n@JSANTO12-L01.ad.analog.com>
	<20250112121229.5bc7545c@jic23-huawei>
	<Z4WtbRG3gWQCwTmE@JSANTO12-L01.ad.analog.com>
	<e5e8eba7-2455-488b-a36f-e246844e11fd@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Jan 2025 10:05:02 -0600
David Lechner <dlechner@baylibre.com> wrote:

> On 1/13/25 6:18 PM, Jonathan Santos wrote:
> > On 01/12, Jonathan Cameron wrote:  
> >> On Sat, 11 Jan 2025 19:34:14 -0300
> >> Jonathan Santos <jonath4nns@gmail.com> wrote:
> >>  
> >>> On 01/07, David Lechner wrote:  
> >>>> On 1/7/25 9:24 AM, Jonathan Santos wrote:    
> >>>>> Add adi,sync-in-spi property to enable synchronization over SPI.
> >>>>> This should be used in the case when the GPIO cannot provide a
> >>>>> pulse synchronous with the base MCLK signal.
> >>>>>
> >>>>> User can choose between SPI, GPIO synchronization or neither of them,
> >>>>> but only if a external pulse can be provided, for example, by another
> >>>>> device in a multidevice setup.
> >>>>>     
> >>>>
> >>>> While we are fixing up these bindings, we could add some more trivial things,
> >>>> like power supplies.
> >>>>
> >>>> Also, the interrupt property could use a description since the chip has multiple
> >>>> output pins. I assume it means the /DRDY pin?
> >>>>     
> >>>
> >>> Right! Yes, the interrupt pin refers to the /DRDY.
> >>>  
> >>>>> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> >>>>> ---
> >>>>>  .../bindings/iio/adc/adi,ad7768-1.yaml        | 24 ++++++++++++++++++-
> >>>>>  1 file changed, 23 insertions(+), 1 deletion(-)
> >>>>>
> >>>>> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
> >>>>> index 3ce59d4d065f..55cec27bfe60 100644
> >>>>> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
> >>>>> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
> >>>>> @@ -47,6 +47,15 @@ properties:
> >>>>>        in any way, for example if the filter decimation rate changes.
> >>>>>        As the line is active low, it should be marked GPIO_ACTIVE_LOW.
> >>>>>  
> >>>>> +  adi,sync-in-spi:    
> >>>>
> >>>> If this is saying that SYNC_OUT is connected to SYNC_IN, then I think the name
> >>>> should be something like adi,sync-in-sync-out. SPI seems irrelevant here since
> >>>> we should just be describing how things are wired up, not how it is being used.
> >>>>
> >>>> But if we also need to consider the case where SYNC_OUT of one chip is connected
> >>>> to SYNC_IN of another chip, we might want to consider using trigger-source
> >>>> bindings instead (recently standardized in dtschema).
> >>>>     
> >>>
> >>> Do you mean the trigger-sources used for LEDs? I can try to see if it works, but would it
> >>> handle the non-GPIO case? While testing a multidevice setup, I found it simpler to 
> >>> have a single device to manage everything. It lets us toggle the GPIO or /SYNC_OUT
> >>> without referencing another device and makes simultaneous buffered reads easier.  
> >>
> >> Daisy-chain mode (figure 131)?  In that case we normally end up with a single presented device
> >> with a 'lot' of channels. (See the electric car style battery charging chips, those can
> >> be chained in very large numbers!)
> >>  
> > 
> > Actually, it is more like Figure 133 , but the premise is similar. We
> > have here a Quad setup.
> >   
> >> Probably similar for figure 133 (which is a dual SPI setup) as the SPI clock must
> >> be shared so we still see it over a single interface.
> >>  
> > 
> > We could view them as a single device with multiple channels, and since
> > the goal is to read them simultaneously with buffered reads, some parameters
> > such as sampling frequency should be equal to all devices.
> > 
> > However, there are some implications: If we do the above, we have
> > limitations in the customization of the "channels", they would have
> > the same filter, frequency modulator and scale (we plan to add support
> > for ADAQ776x-1 series, which include PGA and AAF gain).
> > 
> > To customize them separetely, we would need to assert only the
> > corresponding chip select, which is only possible with different
> > instances, as far as I know.  

Ah.  This is different from the daisy chain cases where even this
is done by writing through the single interface (usually you have
to update same register on all devices).

To support this they probably have to remain separate devices because
of how the SPI subystem will present them.  It's not impossible to
have multiple spi parents feed into a single child device but it is
complex. Or I guess we end up with something magic via a backend like
David describes below.

> 
> FYI, I've been discussing with the HDL folks at ADI about how we could make a
> multi-bus SPI controller, similar to controllers used for parallel SPI flash
> memories that are used as a single logical device. So that is the solution I
> am hoping for here. It would would allow a single IIO device instance for
> multiple chips. But the SPI controller would allow addressing individual chips
> for configuration and addressing all chips at the same time for reading sample
> data.

Maybe this could be presented as if it were a typical daisy chain.
So a long write sends the correct writes to each chip.  However, even
if we have HDL like this it isn't very general if someone wires this up
to a different HDL it will look quite different :(

I guess we don't have to keep to conventions of this looking like an SPI
a device given there is going to be a backend involved.

Nice to keep the bindings in line with conventional SPI though.

Jonathan
> 
> >   
> >> If those are the only two options then keeping this within the driver is fine.
> >> For daisy chain there are examples in tree and it normally means we have to
> >> have a DT parameter that says how long the chain is, though we maybe can
> >> do that with per channel nodes as well if those make sense here.
> >>
> >> Jonathan
> >>  
> > 
> > Those are the options in the datasheet and in hardware so far. I was 
> > considering other scenarios in case the user combine them differently.
> > I believe keping within the driver covers the main cases. 
> >   


