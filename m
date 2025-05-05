Return-Path: <linux-iio+bounces-19101-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E18AA9483
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 15:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 037EB167390
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 13:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E50C2586EE;
	Mon,  5 May 2025 13:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JDtvla5h"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B4B1E5218;
	Mon,  5 May 2025 13:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746451737; cv=none; b=HQrKhfZTS2KJYGbv2+7CxGDGc4DL+ReDza5EQfu2TTfNeBhOoGApADcZalynQJOVgacRxkV3Tuw7eYKu07XPe20N/qzn8/8x09kjlljpvZEGx0j/krVSQhWfxwncV5vyZavyfVWWghQ53nghlPJNLldZSGvtJug6fE9uBBi6ycM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746451737; c=relaxed/simple;
	bh=xH7735ca1FwHO7Q1/W7N4dAS2/ej5MPuwbbwF2LGDRg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aidxfS5HDwM88NGApdOsNWO0pjkrAZErDKJzAcDbu8YdU4fzZlNvpMWEWX1e38bCcpQ5CWyMrQVGyGJXaC04jfnDPZWVqWSFE7NZ0H3PS+Oi2FnceIeGMl2RB/vJ3nFh/9bmPWzFLCvr3QfcMw0xXJwHbNio/PJH3ESYEd/viME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JDtvla5h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EB62C4CEE4;
	Mon,  5 May 2025 13:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746451736;
	bh=xH7735ca1FwHO7Q1/W7N4dAS2/ej5MPuwbbwF2LGDRg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JDtvla5hoHPfR/l8HpHtFMPc9hwc5lwxDfhV5UGs+oG6RF74d1+QScND31+NO8I5J
	 pnLT22DuZ8jpdyxUa94eoZ5Tf2i9slv06h57zL7e0I+CeDB/9XKFCaPkm18idFrtX2
	 BLpsI/4MihbGtjrRTEPMn/yCKuc41sgMB73QnVzRCpYikAJy6sbo3xYUD95IRf0Q2T
	 pDl/KlGTQ38TNJXiZN68aAuZc+vV1sJlfbYMe6hrTP13FvWxN+FDS07hCQgLK9vdlg
	 EUjW/tz0WiFhBz1aSFsqHHDt1U9wKebiON4w3n9rZs+k0A70g6xfu85eWWbMKqv+zJ
	 0MBq86pyZKIqg==
Date: Mon, 5 May 2025 14:28:45 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Angelo Dureghello <adureghello@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/5] Documentation: ABI: IIO: add calibconv_delay
 documentation
Message-ID: <20250505142845.5b58a74c@jic23-huawei>
In-Reply-To: <357c418f-7f00-416c-937e-f6fea1c0af96@baylibre.com>
References: <20250502-wip-bl-ad7606-calibration-v2-0-174bd0af081b@baylibre.com>
	<20250502-wip-bl-ad7606-calibration-v2-1-174bd0af081b@baylibre.com>
	<20250504161603.7d1027af@jic23-huawei>
	<357c418f-7f00-416c-937e-f6fea1c0af96@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 4 May 2025 14:48:32 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 5/4/25 10:16 AM, Jonathan Cameron wrote:
> > On Fri, 02 May 2025 15:26:58 +0200
> > Angelo Dureghello <adureghello@baylibre.com> wrote:
> >   
> >> From: Angelo Dureghello <adureghello@baylibre.com>
> >>
> >> Add new IIO calibconv_delay documentation.
> >>
> >> The ad7606 implements a phase calibation feature, in nanoseconds.
> >> Being this a time delay, using the conv_delay suffix.  
> > I made a late reply to v1...
> > 
> > Key point being that, in the general sense this is only a calibration
> > thing if it is both writeable and we are using it for filter phase correction.
> > In more general terms it's just a conversion sampling time offset (and as you have
> > it here in seconds).  I'm keen we define this to incorporate more general
> > cases including extra read only info on sequencer timing - that can be useful
> > if we have something like 
> >                  _____________
> > Input 0 --------|             |
> > Input 1 --------| 4 in, 2 out |-----  ADC0
> > Input 2 --------|  MUX        |
> > Input 3 --------|_____________|-----  ADC1
> > 
> > That is the ability to schedule more channels across a small number of
> > simultaneous sampling ADCs.  In these cases we've never had a way to
> > express what was done together.  Mostly there have been obvious
> > combinations (i.e. voltage and current at same time on a given wire for
> > power measurement), but it would still be nice to use your new interface
> > to allow us to describe what is running here (though probably not control
> > it as that would be hard to do!)
> >   
> I'm totally on board with making this more general than just calibration, but
> having worked on a couple of multiplexed simultaneous sampling ADCs like this,
> I'm scratching my head a bit trying to figure out how we would be able to know
> what the delay was between the conversions, at least in cases where we don't
> have a hardware conversion trigger based on a clock/pwm. Generally, it is as
> fast as the SPI bus can bang it out, but that isn't a fixed or predictable
> amount of time.

Yeah, this only applies to self clocking devices with a FIFO (possibly a very
short one with 1 register per channel in a scan).
The SPI hammering cases don't work for exactly the reason you mention.

For those we might be able to come up with a multi-baseline solution to
indicate that inputs 0 + 1 are together and 2 + 3 also together but it would
be fiddly.  So lets wait until we know we need that :)

Jonathan



