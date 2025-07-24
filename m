Return-Path: <linux-iio+bounces-21971-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D9B6B10AF5
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 15:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20A5D1CE1EC4
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 13:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08ACA2D640F;
	Thu, 24 Jul 2025 13:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u6Eehoxq"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25472BE64D;
	Thu, 24 Jul 2025 13:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753362586; cv=none; b=qM8vRQEXmdO61lEM9QgYPHv73qsaL1geWnmzUtktyLTB95p0GNX0dfhqtnewacd9n/6RBRxJ6md75dva4ERi5+a4cj88ZGb3ZImWNFum1Nn94LHiyWY8torXTyrYPlboH20mUKnQECap1F5Nbo2xCbC+4aPDWT1wT4U//7Vzb/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753362586; c=relaxed/simple;
	bh=jHNW7RDukm860OgDTe9udnSJui/uXJQFBX78Vj/nqtM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i8nFtzLx2fa+k+uhyqt6/LzWsQRmTf1+gP7nacBJiA6afwRbqCz4OhJbUwQYdhRHnaGNGOk5xwd7ysDu45Rey0sH4v2Rfmd/xieG97HMDsF96oJUh+u5xWh9ugMU6Ar5BVdCsctYsqlDVclIxslABUNUekAOnl5EWLotMXMmK1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u6Eehoxq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2C17C4CEF5;
	Thu, 24 Jul 2025 13:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753362586;
	bh=jHNW7RDukm860OgDTe9udnSJui/uXJQFBX78Vj/nqtM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=u6EehoxqAOzTsGOmobZ78OLKNI/pYR13QnMLZE2oXZb9s/9kcapv7nsBWg8y1EeEg
	 RPJHg8wK8Q/7+WZLsuySc4zp6DcgceeQoL4tE/ZjQ2dVfsn7IVA0EGcjkFe0rs8NnA
	 LVFXpPdJe/py/6R7XkFY53lojAWcIVXaGsa8YD2Zf4+GlG8QXNBZ2qBzD8Q6a7wGK5
	 r9a06kjLHfddRFMDzi03wTod9BIuS9fvca39EnGtxNfiohoKJFlshmWz1zvGOrpY6p
	 zutuid5i4/IKebzZODjGrSrcyHcm/MnjJJ6y91bcA2nhFIh9pq/J44ZD0daFuP/fwP
	 g+x7EjEbz+63w==
Date: Thu, 24 Jul 2025 14:09:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>, robh@kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: add power and energy measurement modifiers
Message-ID: <20250724140940.2d9b4a1f@jic23-huawei>
In-Reply-To: <1ead013c-56ef-4f11-afb9-2b11e0de7eb2@baylibre.com>
References: <20250711130241.159143-1-antoniu.miclaus@analog.com>
	<20250711130241.159143-2-antoniu.miclaus@analog.com>
	<1ead013c-56ef-4f11-afb9-2b11e0de7eb2@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Jul 2025 14:23:14 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 7/11/25 8:02 AM, Antoniu Miclaus wrote:
> > Add new IIO modifiers to support power and energy measurement devices:
> >

Sorry I'm late to the game.  Busy few weeks :(
 
> > Power modifiers:
> > - IIO_MOD_ACTIVE: Real power consumed by the load
> > - IIO_MOD_REACTIVE: Power that oscillates between source and load
> > - IIO_MOD_APPARENT: Magnitude of complex power  
> 
> These make sense a modifiers since they are components of a single
> measured value.

Agreed. Oddly I thought we already had these.  Maybe there was a proposal
at some point that never got adopted. Maybe I just had a nightmare



> 
> > - IIO_MOD_FUND_REACTIVE: Reactive power at fundamental frequency  
> 
> This one seems like there should just be a separate channel
> with IIO_POWER + IIO_MOD_REACTIVE since it is measuring a different
> value.

Hmm. This one is new to me. A separate channels sounds fine to me
with a label to provide the info on what it is.

> 
> > - IIO_MOD_FACTOR: Power factor (ratio of active to apparent power)  
> 
> Power factor seems like it should be a IIO_CHAN_INFO_ rather than
> IIO_MOD_. It is also unitless, so doesn't make sense to be part
> of power_raw which would imply that it shuold be converted to Watts.

Agreed.

> 
> > 
> > Energy modifiers:
> > - IIO_MOD_ACTIVE_ACCUM: Accumulated active energy
> > - IIO_MOD_APPARENT_ACCUM: Accumulated apparent energy
> > - IIO_MOD_REACTIVE_ACCUM: Accumulated reactive energy  
> 
> As below, this one seems like there should be a separate
> energy channel for accumulated energy.

What sort of energy measurement isn't accumulated?  If it's
divided by time then it's power anyway.


> 
> > 
> > Signal quality modifiers:
> > - IIO_MOD_RMS: Root Mean Square value  
> 
> Suprised we don't have something like this already. altvoltageY isn't
> clear about if the value is peak-to-peak or RMS.

Hohum.. My vague recollection is peak to peak, but oops we should
have documented that better.  Someone want to audit existing drivers?

> 
> > - IIO_MOD_SWELL: Voltage swell detection
> > - IIO_MOD_DIP: Voltage dip (sag) detection  
> 
> These sound like events, not modifiers.
Agreed.  Those look fun.


> >  What:		/sys/bus/iio/devices/iio:deviceX/in_capacitanceY_raw
> >  KernelVersion:	3.2
> >  Contact:	linux-iio@vger.kernel.org
> > @@ -1593,6 +1603,12 @@ Description:
> >  
> >  What:		/sys/.../iio:deviceX/in_energy_input
> >  What:		/sys/.../iio:deviceX/in_energy_raw
> > +What:		/sys/.../iio:deviceX/in_energyY_active_raw
> > +What:		/sys/.../iio:deviceX/in_energyY_reactive_raw
> > +What:		/sys/.../iio:deviceX/in_energyY_apparent_raw
> > +What:		/sys/.../iio:deviceX/in_energyY_active_accum_raw
> > +What:		/sys/.../iio:deviceX/in_energyY_reactive_accum_raw
> > +What:		/sys/.../iio:deviceX/in_energyY_apparent_accum_raw  
> 
> I think the accumulated would just be a separate channel, not a modifier.

I'm confused what energy is vs accumulated energy. 


