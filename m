Return-Path: <linux-iio+bounces-13253-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB529E8759
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 19:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F26D164681
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 18:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E1C18D63A;
	Sun,  8 Dec 2024 18:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YBFFYbCW"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D131145324;
	Sun,  8 Dec 2024 18:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733683428; cv=none; b=GDiSWwVZBlib7gbDd/t+L2GysMA8GR0l18peW1uj+l99fEC/T8bdX1dbI76cjcHEumOjHoNmAZNKx6jGiUKFEtdvP0oSP4OksVawX3APfSNG2zgFkSM1pzzodTuHl2DjXuKXRP2tXibl/ZPfVX62RXBn0z51OBlYyL6CaitI2uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733683428; c=relaxed/simple;
	bh=gd+3HtTuHkjOJVJYI1WZORpFcMA1c8JA1eQmUcHuVr8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VpJ4XBaWfUX/R8ahDzPiIHXPWUh5ILhiq+1+qCs36JXtoVRrltt55Qtuhc1EokAysNJjPwZhp6FqvQReLWxf1jl23s7A8e3xxKjK6poZtAa4BGZJTFJL4L2yKmurjrCkfNEM9stbygn+uqZPFx/ECbhM4EFsNqyEI/gWJJ1y3Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YBFFYbCW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B448C4CED2;
	Sun,  8 Dec 2024 18:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733683427;
	bh=gd+3HtTuHkjOJVJYI1WZORpFcMA1c8JA1eQmUcHuVr8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YBFFYbCWFPY+qL1pV6P3NNoyUvVfP2XZmSO2J0vkL923EA25ezT4w9hcFzK6Pw/cR
	 Vuxof3JAB6EBNpbztWA/+chtooOI4PqJB8IXFOGpicr3ufcGDw2kEsvgp4xJ7RCiK2
	 gP8jAX7WP0GnTUvb7ke0te5PrZwZkli1Wg6BH75YiC7enJ8Wkz1KeUNj/XoAEpFZGJ
	 HCbqyaSmWn68n6iOUaiOLyecMs8yBd/cQ/xTbZSemoSgIdM3OjS06bn407f3usKwPo
	 TSVS015qviN4ZDa2ue5DguoD+acUr6uJlq+RaWcVjO6raWgjQI1tyGp/GySzfF3s7w
	 6ktDhi4j1L6cQ==
Date: Sun, 8 Dec 2024 18:43:37 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Alisa-Dariana Roman <alisadariana@gmail.com>, Alisa-Dariana Roman
 <alisa.roman@analog.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Michael Hennerich <michael.hennerich@analog.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v1 3/3] iio: adc: ad7192: Add sync gpio
Message-ID: <20241208184337.79c701db@jic23-huawei>
In-Reply-To: <6435f696-40fe-4ff9-ae76-1f121fe7604f@baylibre.com>
References: <20241128125811.11913-1-alisa.roman@analog.com>
	<20241128125811.11913-4-alisa.roman@analog.com>
	<20241130183839.1fd5884f@jic23-huawei>
	<6435f696-40fe-4ff9-ae76-1f121fe7604f@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 2 Dec 2024 16:21:43 -0600
David Lechner <dlechner@baylibre.com> wrote:

> On 11/30/24 12:38 PM, Jonathan Cameron wrote:
> > On Thu, 28 Nov 2024 14:55:03 +0200
> > Alisa-Dariana Roman <alisadariana@gmail.com> wrote:
> >   
> >> Add support for the SYNC pin of AD719x devices. This pin is controlled
> >> through a GPIO. The pin allows synchronization of digital filters and
> >> analog modulators when using multiple devices.
> >>
> >> Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>  
> > Hi.
> > 
> > Like all userspace ABI, this needs documentation.
> > 
> > It's an unusual feature, so some usecases would help.
> > 
> > It is also cross multiple devices which makes this odd as only one device
> > can presumably acquire the gpio?
> > 
> > An alternative would be to look at how to do this with a 'wrapper' sort of device
> > so that we have one instance to which this applies.
> > 
> > I'm not sure that helps that much though as we'd still need some for of
> > 'I'm setup for all channels, now you can go' ABI.
> > 
> > Jonathan
> >   
> 
> Giving userspace direct control over the /SYNC pin without coordinating
> with the rest of the driver does seem like it could be asking for trouble.
> 
> It seems like the only time you would want to actually toggle the /SYNC
> pin is when starting a buffered read.
> 
> 1. Deassert /SYNC so that no conversions can be triggered.
> 2. Enable buffered reads for all chips connected to the same GPIO.
> 3. Assert /SYNC to start all conversions at the same time.
> 
> So it could make sense to integrate this into the buffer pre/post enable
> callbacks somehow instead of adding a new sysfs attribute.
> 
> For the "wrapper" device, maybe we could do something with configfs to
> enable dynamically connecting multiple device instances? We might not
> need to actually create a separate device in sysfs, but just do something
> so that enabling a buffered read on the first chip will enable buffered
> reads on all of the chips in the group.
> 
> It seems like we have some other chips that are currently being worked on
> that also have the possibility of some sort of multi-chip synchronization
> like this so it would be nice to come up with a general solution.

Most of the multichip cases we've had before have been chained, rather
than separate data interfaces, hence I don't recall us needing something
like this before.

> 
> Another use case for a general synchronized buffered read/write between
> multiple chips would be the AD3552R DAC. Recently, while adding support
> for an IIO backend for this chip, we saw that the AXI DAC backend has a
> synchronization feature like this where you set an "arm" bit on all AXI
> DAC instances. Then when you enable streaming to the first chip, it also
> triggers all of the other AXI DAC blocks to start streaming at the same
> time. We ended up not implementing that feature since the IIO subsystem
> doesn't really support this yet, but could be a good one to look at as a
> similar feature with a different implementation to help us find a general
> solution.
> 
This feels like a case where we need a prototype to poke holes in.
It's not totally dissimilar from the hardware trigger stuff that
exists in a few devices. Some of the stm parts for instance where the
triggering is entirely within the chip.  Maybe we could make something
like that work.  So the driver instance that has the sync pin registers
a trigger that the other devices use.   It's a bit ugly though and we'd
still need a dt-binding to let us know 'which' devices are connected
to that sync pin.

Jonathan



