Return-Path: <linux-iio+bounces-17377-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A746A75B91
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 19:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 454DA18883F3
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 17:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341641D7998;
	Sun, 30 Mar 2025 17:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L5K9idNH"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E593714B08A;
	Sun, 30 Mar 2025 17:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743357241; cv=none; b=DB669ZJkNOoY/H6WoXQ7ISOBz/Ih9osP9gidOuME7NedifvIzEv51xfykT4Ql3/fKY2/uWkAVrXBKO62oOhKWbvVqYHZW2trKvEf+QaaX72Ng5xAHqBGufb+Vi1cEwxgIkjNHaFHQOcW3dZYBHPmKiKlg3pEm6ZxvlaT4vc3n4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743357241; c=relaxed/simple;
	bh=yNK0Hniafm4FKl9WeXtWXEHJ8B4ypu+qK7dq4X403Xo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IvbL0yBGPCGZyXTf0HKI74Kxyz2Pt/2j0c2fHRSFWvcGePQ1KaXdqVj8io90919d2UwA0bpyZagH7a8PhOKSMI0EYw3IbMgClSfNPTEmwH8eVxmrc2RzVh+xzK2PDgRoI4dgDlyq4MKIJ+KM7vA5HCPEae9ds4gXgASOeCva7oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L5K9idNH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A53B6C4CEDD;
	Sun, 30 Mar 2025 17:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743357240;
	bh=yNK0Hniafm4FKl9WeXtWXEHJ8B4ypu+qK7dq4X403Xo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=L5K9idNHryzXSsCULR8P7Sv8F/FZRCCp3evwVhK/azdze9uTi2cyNIKEXKS55FCHd
	 sViUljB1IHe4jwgpckoKEJxT+ygCYmNHYISQoyY6D5XEMHPvAaJ5U1mwfK8qgRXY7A
	 V0x2/cwO060tfOx13yMFWDC88HSWQlaYakQVOGX5DJ9O/gJIRel4IhS5BdXMMTyi/i
	 CMYyOzUY7i39auZ81UUq2tRB5Btoj4MIhv/VK1mcRX/cOOJka+xcc6DRmoYyE7kYAy
	 zb0VmVi6o/P6rwflDZyvH6IgWcFkSk64I0YvhaZOk2phqghbvG/VZJLApph7EfBQ55
	 EmwqPjsURiTLw==
Date: Sun, 30 Mar 2025 18:53:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Jorge Marques <jorge.marques@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Documentation: ABI: add oversampling frequency in
 sysfs-bus-iio
Message-ID: <20250330185353.150fc33a@jic23-huawei>
In-Reply-To: <3ad6f137-5f67-4448-b0c9-2e760bd935a7@baylibre.com>
References: <20250321-abi-oversampling-events-frequency-v1-0-794c1ab2f079@analog.com>
	<20250321-abi-oversampling-events-frequency-v1-2-794c1ab2f079@analog.com>
	<20250330181320.0ec4351c@jic23-huawei>
	<3ad6f137-5f67-4448-b0c9-2e760bd935a7@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 30 Mar 2025 12:34:39 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 3/30/25 12:13 PM, Jonathan Cameron wrote:
> > On Fri, 21 Mar 2025 15:50:02 +0100
> > Jorge Marques <jorge.marques@analog.com> wrote:
> >   
> >> Some devices have an internal clock used to space out the conversion
> >> trigger for the oversampling filter,
> >> Consider an ADC with conversion and data ready pins topology:
> >>
> >>   Sampling trigger |       |       |       |       |
> >>   ADC conversion   ++++    ++++    ++++    ++++    ++++
> >>   ADC data ready      *       *       *       *       *
> >>
> >> With the oversampling frequency, conversions can be evenly space between
> >> the sampling edge:  
> > 
> > I'm not sure what this second example is providing.  Are you suggesting
> > that if we don't provide oversampling frequency we should assume this
> > pattern?  i.e. it is the default?
> >   
> >>
> >>   Sampling trigger |       |       |       |       |
> >>   ADC conversion   + + + + + + + + + + + + + + + + + + + +
> >>   ADC data ready         *       *       *       *       *
> >>  
> > In general this patch needs to go in with the first driver using it.
> > I don't think we have any such driver yet?
> >   
> >> Signed-off-by: Jorge Marques <jorge.marques@analog.com>
> >> ---
> >>  Documentation/ABI/testing/sysfs-bus-iio | 17 +++++++++++++++++
> >>  1 file changed, 17 insertions(+)
> >>
> >> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> >> index 33c09c4ac60a4feec82308461643134f5ba84b66..2317bacf6a2884691a08725d6f01d18555a96227 100644
> >> --- a/Documentation/ABI/testing/sysfs-bus-iio
> >> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> >> @@ -139,6 +139,23 @@ Contact:	linux-iio@vger.kernel.org
> >>  Description:
> >>  		Hardware dependent values supported by the oversampling filter.
> >>  
> >> +What:		/sys/bus/iio/devices/iio:deviceX/oversampling_frequency
> >> +KernelVersion:	6.15
> >> +Contact:	linux-iio@vger.kernel.org
> >> +Description:
> >> +		Some devices have internal clocks for the ADC oversampling.  
> > I wonder if we can hint at your diagram above?
> > Maybe
> > 		Some devices have internal clocks for the ADC oversampling allowing
> > 		the over samples to be bunched up, rather than evenly spread over the
> > 		period set by the sampling frequency.
> >   
> >> +		Sets the resulting sampling frequency to trigger a conversion
> >> +		used by the oversampling filter.
> >> +		Can be used to evenly space conversion between the sampling edge
> >> +		on some devices.  
> > I'd skip this last line, or maybe say something like:
> > 
> > 		If not provided, the default assumption is that the oversamples
> > 		are evenly spread over the period of the sample.  
> 
> Does that mean we should go through existing drivers and add this new
> attribute if appropriate? For example, ad7380 comes to mind. It has a
> fixed-rate internal clock for oversampling, so would have a read-only
> oversampling_frequency attribute.

Good point.

It is possibly a useful thing to do if that fixed rate clock is not
jut the appropriate fraction of the sampling_frequency clock.

Requiring drivers conform provide a new ABI is a non starter though.

I guess rewrite the above suggestion to be more vague.

		If not provided, either over samples are evenly spread over the
		period of the sample, or no information is available.

Or just don't have anything for that last sentence on basis if no
rules set there are no rules.

Jonathan

> 
> >   
> >> +
> >> +What:		/sys/bus/iio/devices/iio:deviceX/oversampling_frequency_available
> >> +KernelVersion:	6.15
> >> +Contact:	linux-iio@vger.kernel.org
> >> +Description:
> >> +		Hardware dependent values supported by the oversampling
> >> +		frequency.
> >> +
> >>  What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_raw
> >>  What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_supply_raw
> >>  What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_i_raw
> >>  
> >   
> 


