Return-Path: <linux-iio+bounces-20647-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AEBFAD9CD1
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jun 2025 15:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 025A0179267
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jun 2025 13:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0431282EE;
	Sat, 14 Jun 2025 13:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qdDWRuX6"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567191FC8;
	Sat, 14 Jun 2025 13:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749906219; cv=none; b=PPoqn7YVPEAVv80g8jucjgM7brzXL2QZ0nZV7CHHRijjjAUpBg29BkVJkqoQtzubeiphTSZjYRl3xrRWFTlunyabKfQKs5bLUfXeY+96U8Gk11/WrQ783xIS4K8eqn1rC1X//eyBsjSn68CP61AfpU0eFRL/GpnhqkOSB1JeeME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749906219; c=relaxed/simple;
	bh=nUsMqcgjWlbjfSpgElJGq3ExeK0Rxi+P3UYremNkUTU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D2Ur61F/7XBMzKCwmGkxpJRNO51YRyewGp69y5OoOd+LLmichdd1UIURZro54Iaj8sHablhy90xfJBsHRKNkVsTQbUyTZEELBIHWBpiiLDuUp5evY+7T0VPqau4XSoyULVvNseBKTEmN9J5sAT5etTJRNBTosMsS0N14H/+mxic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qdDWRuX6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56A3BC4CEEB;
	Sat, 14 Jun 2025 13:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749906218;
	bh=nUsMqcgjWlbjfSpgElJGq3ExeK0Rxi+P3UYremNkUTU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qdDWRuX6AgRrVdAK5D23uWkbcxvaJu8jh5m6CJdnWgx16rPQa+O/LfFyUzEPzLKFB
	 HtgYRsJLbYfx7QStE9SgE1l0bmuYBol+eQFRd620xzcYferYrlt1bJKRjXkaxY9tLb
	 fCcn3OFD7g+awcIf4ScT5kMo/kRl+pSd8Ir1C8sT5Munmj8Df9kTIxD1Ay1Io+8gku
	 MnCzkorgP60AH3ASRDaeT8hvhOg2cWfhH8PV6V04CN4YHyPLAEFc9w0BaclH7ILnOl
	 G24nFa3+aAsfShfJeYBVPe/GcHMUzeWHxkpgIkZdpJ/M16KzeafESu+2eMI5ldSA+f
	 3ekuyA/JZXFDg==
Date: Sat, 14 Jun 2025 14:03:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Marek Vasut
 <marek.vasut+bmc150@mailbox.org>, Hans de Goede <hansg@kernel.org>,
 linux-iio@vger.kernel.org, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, David Lechner <dlechner@baylibre.com>, Julien
 Stephan <jstephan@baylibre.com>, Peter Zijlstra <peterz@infradead.org>,
 Salvatore Bonaccorso <carnil@debian.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: accel: bmc150: Do not configure IRQ registers if
 no IRQ connected
Message-ID: <20250614140330.31183fd5@jic23-huawei>
In-Reply-To: <8605141c-b615-4e84-9574-81e24590df48@mailbox.org>
References: <20250613124648.14141-1-marek.vasut+bmc150@mailbox.org>
	<aEw_DcqpCpcsBGd0@smile.fi.intel.com>
	<8605141c-b615-4e84-9574-81e24590df48@mailbox.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Jun 2025 19:02:28 +0200
Marek Vasut <marek.vasut@mailbox.org> wrote:

> On 6/13/25 5:09 PM, Andy Shevchenko wrote:
> > Strange I don't see Hans in the Cc list, so added.
> > Thanks for the report and patch, my comments below.
> > 
> > On Fri, Jun 13, 2025 at 02:45:22PM +0200, Marek Vasut wrote:  
> >> The BMC150 on Onemix 2S does not have IRQ line described in ACPI tables,
> >> which leads to bmc150_accel_core_probe() being called with irq=0, which
> >> leads to bmc150_accel_interrupts_setup() never being called, which leads
> >> to struct bmc150_accel_data *data ->interrupts[i].info being left unset
> >> to NULL. Later, userspace can indirectly trigger bmc150_accel_set_interrupt()
> >> which depends on struct bmc150_accel_data *data ->interrupts[i].info being
> >> non-NULL, and which triggers NULL pointer dereference. This is triggered
> >> e.g. from iio-sensor-proxy.
> >>
> >> Fix this by skipping the IRQ register configuration in case there is no
> >> IRQ connected in hardware, in a manner similar to what the driver did in
> >> the very first commit which added the driver.
> >>
> >> ACPI table dump:  
> >   
> >>          Device (BMA2)
> >>          {
> >>              Name (_ADR, Zero)  // _ADR: Address
> >>              Name (_HID, "BOSC0200")  // _HID: Hardware ID
> >>              Name (_CID, "BOSC0200")  // _CID: Compatible ID
> >>              Name (_DDN, "Accelerometer")  // _DDN: DOS Device Name
> >>              Name (_UID, One)  // _UID: Unique ID
> >>              Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
> >>              {
> >>                  Name (RBUF, ResourceTemplate ()
> >>                  {
> >>                      I2cSerialBusV2 (0x0019, ControllerInitiated, 0x00061A80,
> >>                          AddressingMode7Bit, "\\_SB.PCI0.I2C0",
> >>                          0x00, ResourceConsumer, , Exclusive,
> >>                          )
> >>                  })
> >>                  Return (RBUF) /* \_SB_.PCI0.I2C0.BMA2._CRS.RBUF */
> >>              }  
> > 
> > These lines...
> >   
> >>              Method (ROTM, 0, NotSerialized)
> >>              {
> >>                  Name (SBUF, Package (0x03)
> >>                  {
> >>                      "0 1 0",
> >>                      "1 0 0 ",
> >>                      "0 0 1"
> >>                  })
> >>                  Return (SBUF) /* \_SB_.PCI0.I2C0.BMA2.ROTM.SBUF */
> >>              }
> >>
> >>              Method (_STA, 0, NotSerialized)  // _STA: Status
> >>              {
> >>                  Return (0x0F)
> >>              }  
> > 
> > ...are irrelevant.
> >   
> >>          }
> >> "
> >>
> >> Splat, collected from debian unstable, probably not very useful:  
> > 
> > Oh my gosh, please leave only ~3-5 *important* lines out of this, or move it
> > completely to the comment block (after '---' cutter line).
> > 
> > This is requirement written in Submitting Patches.
> > 
> > ...
> > 
> > As for the solution, are you sure the line is not wired at all?  
> 
> No . It is some cheap mini-laptop , I have no schematics or any other 
> info really .
> 
> Note that I am not really familiar with x86 and ACPI, so there is that.
> 
> > IIRC Hans had a broken tales where it was simply forgotten, meaning
> > the Android / Windows driver simply hardcoded needed info.
> > 
> > If it's the case, it should be solved differently around PDx86 special quirk
> > driver for the cases like this.  
> There are likely two issues.
> 
> First, this driver needs to handle i2c_client->irq == 0 correctly if it 
> should work without IRQ line, which the driver seems to indicate that it 
> does. The current crashing the kernel is not the correct way of handling 
> that. That's this patch, in some form.

Hi Marek,

For this, the driver shouldn't be giving the impression it can do either
events or fifo based capture if it doesn't have an irq.
(the fifo case could be made to work but that's a complex job).
Right now the driver only correctly doesn't initialize a trigger
for data ready use when the interrupt isn't there - it does all the
rest unconditionally :(

Usual way to do that is to have two iio_info structures and chan spec
arrays and pick between them.  That should remove any chance of getting
to the code that messes with the interrupts.  It seems to be using
the watermark setting to mess with the fifo interrupt so hiding that
as well in the info structure should block that one and anything that
indicates there might be a fifo.

What you have here stops it crashing and is sensible defence in depth
but cutting off the pointless paths at the top is also needed
to avoid giving userspace the wrong impression.

Jonathan


> 
> Second, if this laptop has some IRQ line for this chip hidden somewhere, 
> then it might need a quirk of sorts, sure. Is there some way to find 
> out, without taking the thing apart and poking around with a scope ?


