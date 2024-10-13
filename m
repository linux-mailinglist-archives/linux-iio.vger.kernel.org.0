Return-Path: <linux-iio+bounces-10538-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6711499BA1E
	for <lists+linux-iio@lfdr.de>; Sun, 13 Oct 2024 17:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C2AD2819DB
	for <lists+linux-iio@lfdr.de>; Sun, 13 Oct 2024 15:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18CF146A6C;
	Sun, 13 Oct 2024 15:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GzlxZ8et"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1A713C9A6;
	Sun, 13 Oct 2024 15:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728834007; cv=none; b=QLHv+bifGqTOmHZX0/ExfGD9ZLpMvy/jX2ej2bOyk/MHVJ5Hl/GLbjwbrlxErKqZf9c5en3gRkxeD5aS5PmziDqb0K27NGUJdpgpizOlnNkpUjfnmw3qW7Y46USnwEjxNsBFJ9lpOJdVXEsLl1apMyNOhfGEjtaF8J2VGroBJK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728834007; c=relaxed/simple;
	bh=Rn31IjsiYcrrEXbqeFmwqVweK4SdvTGrY5WWcOYt7OI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eRFrmp4sovK4LybMugA+cjTC3KPfGjFuts/WmsDyc6C7Ea5bRBA5qvkagS2u3M4wDdRwao/xWrL2464nKAGUtBC7hoOAozXIaZbMAwQ9gWMXsJTqflGSnT9joeAoTNqaQIDCrSWNBcDOvPFL8Y7SC1dU5HU5JW6e/ZA11qGY3+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GzlxZ8et; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A771C4CEC5;
	Sun, 13 Oct 2024 15:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728834007;
	bh=Rn31IjsiYcrrEXbqeFmwqVweK4SdvTGrY5WWcOYt7OI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GzlxZ8etSHfS+rEK7+0v0jKY6skXWH6b+t3A9uxk9VA2UIqJklRm19QTIKn6xTneB
	 gVCc7H3k9GOMxDmcoV4nekMmcYrS/K8/PnszcfbDQTqWmRvo9051pjQS64pvrlKOFU
	 WvdTUkTd+5Em29X8jwT53vOpoxO87JvTi1uog9VhkRMw276faD+6ToQ7BIvlo1d3fD
	 CX9HF2SZ0uuH+d8XPQ8SX4BUMuhKFhWUWctTVN3uiw3mSuIjD7HOaBNwhPscA+OPX0
	 VhtU1MmLL5OXJIczb8afsUfrRYURI+VhO79RDJ5UZEDwQfKS9gMX6a4HvIDWm1dhlV
	 tW8RmmdjzBPRA==
Date: Sun, 13 Oct 2024 16:40:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Justin Weiss <justin@justinweiss.com>
Cc: Alex Lanzano <lanzano.alex@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Derek J . Clark" <derekjohn.clark@gmail.com>, Philip =?UTF-8?B?TcO8bGxl?=
 =?UTF-8?B?cg==?= <philm@manjaro.org>
Subject: Re: [PATCH 3/3] iio: imu: Add scale and sampling frequency to
 BMI270 IMU
Message-ID: <20241013164000.19087833@jic23-huawei>
In-Reply-To: <87jzecpvpd.fsf@justinweiss.com>
References: <20241011153751.65152-1-justin@justinweiss.com>
	<20241011153751.65152-4-justin@justinweiss.com>
	<20241012123535.1abe63bd@jic23-huawei>
	<87jzecpvpd.fsf@justinweiss.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 12 Oct 2024 19:45:18 -0700
Justin Weiss <justin@justinweiss.com> wrote:

> Jonathan Cameron <jic23@kernel.org> writes:
> 
> > On Fri, 11 Oct 2024 08:37:49 -0700
> > Justin Weiss <justin@justinweiss.com> wrote:
> >  
> >> Add read and write functions and create _available entries. Use
> >> IIO_CHAN_INFO_SAMP_FREQ instead of IIO_CHAN_INFO_FREQUENCY to match
> >> the BMI160 / BMI323 drivers.  
> >
> > Ah.  Please break dropping _FREQUENCY change out as a separate fix
> > with fixes tag etc and drag it to start of the patch. It was never
> > wired to anything anyway
> >
> > That's a straight forward ABI bug so we want that to land ahead
> > of the rest of the series.  
> 
> Thanks, I'll pull that into its own change and make it the first patch.
> 
> > Does this device have a data ready interrupt and if so what affect
> > do the different ODRs for each type of sensor have on that?
> > If there are separate data ready signals, you probably want to 
> > go with a dual buffer setup from the start as it is hard to unwind
> > that later.  
> 
> It has data ready interrupts for both accelerometer and gyroscope and a
> FIFO interrupt. I had held off on interrupts to keep this change
> simpler, but if it's a better idea to get it in earlier, I can add it
> alongside the triggered buffer change.

Ok. So the challenge is that IIO buffers are only described by external
metadata.  We don't carry tags within them.  Hence if you are using
either effectively separate datastreams (the two data ready interrupts)
or a fifo that is tagged data (how this difference of speed is normally handled
if it's one buffer) then when we push them into IIO buffers, they have
to go into separate buffers.

In older drivers this was done via the heavy weight option of registering
two separate IIO devices. Today we have the ability to support multiple buffers
in one driver. I'm not sure we've yet used it for this case, so I think
there may still be some gaps around triggering that will matter for the
separate dataready interrupt case (fifo is fine as no trigger involved).
Looking again at that code, it looks like there may need to be quite
a bit more work to cover this case proeprly.

We may be able to have a migration path from the simple case you have
(where timing is an external trigger) to multiple buffers.
It would involve:
1) Initial solution where the frequencies must match if the fifo is in use.
   Non fifo trigger from data ready might work but we'd need to figure out
   if they run in close enough timing.
2) Solution where we add a second buffer and if the channels are enabled
   in that we can allow separate timing for the two sensor types.

This is one of those hardware features that seems like a good idea
from the hardware design point of view but assumes a very specific
sort of software model :(

Jonathan


