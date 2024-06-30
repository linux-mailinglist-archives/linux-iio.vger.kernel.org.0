Return-Path: <linux-iio+bounces-7076-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 623B691D10D
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jun 2024 12:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF3D2281B72
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jun 2024 10:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D5712F37F;
	Sun, 30 Jun 2024 10:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JbwvxeNI"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132BA28366;
	Sun, 30 Jun 2024 10:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719742666; cv=none; b=aZO6vBuvSW3L1cL2t0SkJFfPCMz4pB7YOYoAhA0IfKzLglbdov0YWC3KAV6qfvBUca8jOVFToVDzi1pcfVzNnyIpbUKlDiSIOEfuOYrT69gOuuJjaLSm1dma8ZpTk74dSJVDXeAjRunofKXb1rRTE9qpP07jyACEXEBwOB9GlH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719742666; c=relaxed/simple;
	bh=IWPNBQyIalTctizb0/fr4sK41qNaTJQ9mhfRy3wg/l8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HzBdCpYTdlbZWTn/gZgffRt9gG63zg2gTqi8vJmPjMBkW/B+S4akyduMz1sBT+ZbxSmIs99Rk8iYqiOX7NnQuZSMXsvVmYNszvRMOCEMmHpjN5LnozQ0hqMt7YXa5kIC27MP/zFI/aOpRAFOYpAEMCyjzujwpNtTqrhNSc4zum4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JbwvxeNI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDAAAC2BD10;
	Sun, 30 Jun 2024 10:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719742665;
	bh=IWPNBQyIalTctizb0/fr4sK41qNaTJQ9mhfRy3wg/l8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JbwvxeNIAJuppst26HTjvrH0b6Tz+Ef/OEyxD6E83uOMmB42WK+g5HHgelSMABDKu
	 T460eyVH7tjTGK3VWbjwF07NfYPv0ORxcDDDZvSf+vnQKy46vp5VOK40OZVdmofeOp
	 I1lbpuJHn/LhNyNFo6yJvGrDtnPbuzQbgu5bhuYNqzo8w1MNTVFF8iFM0PE6IiPKQ/
	 22qgTvDPMVlQUqu8GVkn+zx2nLc6XqjURoHlF9+nKZkKwS7uqEr0FQN/jzLSP2aZw6
	 StWSJNMWHPhk6dAhRVNMBIC5WBBUpa629QmVplC9pMoZMqXnfyclvyQ0W+LOV6HThA
	 fb/RrugYh8BQQ==
Date: Sun, 30 Jun 2024 11:17:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Neil Armstrong
 <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>,
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-iio@vger.kernel.org, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH 2/2] iio: frequency: add amlogic clock measure support
Message-ID: <20240630111737.276c949a@jic23-huawei>
In-Reply-To: <1jwmm6hp5s.fsf@starbuckisacylon.baylibre.com>
References: <20240624173105.909554-1-jbrunet@baylibre.com>
	<20240624173105.909554-3-jbrunet@baylibre.com>
	<20240629204025.683b1b69@jic23-huawei>
	<1jwmm6hp5s.fsf@starbuckisacylon.baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 30 Jun 2024 09:21:03 +0200
Jerome Brunet <jbrunet@baylibre.com> wrote:

> On Sat 29 Jun 2024 at 20:40, Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > On Mon, 24 Jun 2024 19:31:03 +0200
> > Jerome Brunet <jbrunet@baylibre.com> wrote:
> >  
> >> Add support for the HW found in most Amlogic SoC dedicated to measure
> >> system clocks.
> >> 
> >> This drivers aims to replace the one found in
> >> drivers/soc/amlogic/meson-clk-measure.c with following improvements:
> >> 
> >> * Access to the measurements through the IIO API:
> >>   Easier re-use of the results in userspace and other drivers
> >> * Controllable scale with raw measurements
> >> * Higher precision with processed measurements
> >> 
> >> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>  
> > Interesting device and the driver is pretty clean.
> >
> > Needs a new channel type though as altvoltage is in volts not hz.
> >
> > Various minor comments inline.
> >
> > Thanks,  
> 
> Thanks for the feedback Jonathan.
> 
> Just a couple of things,
> 
> David expressed concerns with having both IIO_CHAN_INFO_RAW and
> IIO_CHAN_INFO_PROCESSED for a channel and we did not reach a conclusion
> on this.
> 
> My idea here is to:
>  * Give full control over the scale to the consumer with
>    IIO_CHAN_INFO_RAW
>  * Give an easy/convenient way to get an Hz result with
>    IIO_CHAN_INFO_PROCESSED. There is a bit more than just 'raw * scale'
>    in the implementation of this info to figure out the most appropriate
>    scale for the measurement. They idea is also to avoid code
>    duplication in consumers.

So we have had a few cases of software driving autorange finding for sensors
in the past (typically light sensors). An example is the gp2ap020a00f driver but
those have been been driven by interrupts to detect range issue and are much
more complex than what you have here.  Note that driver only provides _RAW,
I think because we have no documentation of how to convert to an illuminance
reading.  It's old though and probably not a good example to follow.

> 
> David is definitely more familiar than me with IIO but we did not really
> know how to move forward on this.
> 
> Is it OK to have both IIO_CHAN_INFO_RAW and IIO_CHAN_INFO_PROCESSED, or
> should I ditch IIO_CHAN_INFO_RAW ?

I'll ask the obvious question - do you have a usecase for _RAW + _SCALE
if not we can take the conservative approach of not providing it 'yet'
and revisit once that use case surfaces.

Otherwise, I tend to resist mixing processed and raw + scale just because
it makes it hard for userspace to understand the difference. This combination
has only happened in the past due to driver evolution (we got it wrong
initially for a given driver). 

So I'm not strongly against providing both (and amending my standard
'don't do this reply' to include this as a special case) but I want to
know someone actually cares.


> 
> >
> > Jonathan  
> 
> [...]
> 
> >> +	indio_dev->name = "amlogic-clk-msr";
> >> +	indio_dev->info = &cmsr_info;
> >> +	indio_dev->modes = INDIO_DIRECT_MODE;
> >> +	indio_dev->num_channels = CLK_MSR_MAX;  
> >
> > Superficially looks like the number of channels depends on the compatible.
> > Ideally we shouldn't provide channels to userspace that aren't useful.  
> 
> Not exactly. All SoCs have 128 inputs, Some may not be connected indeed
> but some are, and the name is just not documented (yet).

> >
> > You could search the name arrays to see how far they go, but that is bit ugly.
> > Probably wrap those in a structure with a num_channels parameter as well.
> >  
> 
> I've been doodling with this idea while writing this
> driver. Technically, there is no problem.
> 
> The legacy driver this one will be replacing used to expose all 128
> inputs. I thought it was more important to have continuity with the
> legacy driver than filtering out possibly useless channels.

ok.
> 
> Another benefit of keeping all 128 is that the channel index (both in
> sysfs and more crucially in DT) matches the one in the SoC documentation.
> That makes things easier.
> 
> Would it be acceptable to keep all 128 channels then or do you still
> prefer that I filter out the undocumented ones ?

Your explanation for why we should keep them is fine.
Add some suitable comments so we don't forget it.

> 
> >> +	indio_dev->channels = cmsr_populate_channels(dev, conf);
> >> +	if (IS_ERR(indio_dev->channels))
> >> +		return PTR_ERR(indio_dev->channels);
> >> +
> >> +	return devm_iio_device_register(dev, indio_dev);
> >> +}  
> 
> Thanks for you help.
> 
You are welcome
J

