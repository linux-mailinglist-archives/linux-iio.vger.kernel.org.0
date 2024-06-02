Return-Path: <linux-iio+bounces-5598-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCF58D749E
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 11:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F45D1C20EFC
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 09:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A129E2E416;
	Sun,  2 Jun 2024 09:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kYB5/ESR"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB3F134A8;
	Sun,  2 Jun 2024 09:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717321059; cv=none; b=npYn3Gces/gt08EEgpDYP7a1pYr7M0oQBt9V95GQGCi46kLhfmqvMF+waPQvOMxbF9djfGFltPCWiJ7TBTQ/z3MzJLh4rrfvwZW0s+evLRQT/4qG7Zenx+PTDJ86vOTmg4hY+d8/QDfMd8ABk8OBsLEMxfy0UO1Nb6ZG+jYOtS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717321059; c=relaxed/simple;
	bh=/xKLEHAs1Wv0Z9ZQAQzXdBZp83/KzYOQwn3DIECc6NM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nhF4a4IPQTEXLyvsjzeY7UfvXP6DYML2hNnQRokcKI2OAq92Hyr4HhDnj5ZkzCaPLp4/7y0N/75uGN2ewIHrPgsUlB3HVXuWNfEpWVy5jVTkXk4q+znNpG9K0hAefBSi2suGG68OaBHPxAQ4H4FtawpW0yDT5oixqQ4jsv6G8xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kYB5/ESR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CA86C2BBFC;
	Sun,  2 Jun 2024 09:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717321058;
	bh=/xKLEHAs1Wv0Z9ZQAQzXdBZp83/KzYOQwn3DIECc6NM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kYB5/ESRhYugjxyAa9WpS5ZiPq7QgrAFIJJbHFJpzHx87UT2EgLzUz8+ol6q2Anji
	 0JIYpMB9HOeIHTNdFHaYrNsl4ePbFO/02tvlnI7F3aWu453Piv2Y68diCr4CBRqZ47
	 OTu689IAucA2QV2NkAvwG2iJmbnLKAJckoNi2U8iC0zfKDZ08HEbFDFveTVXQLKkfS
	 ni59iCjyBP6JhJ8d2FB1004oGxvnbbFtWr7aMC3i2eTfjSnUFcgZH91rFY0jYi23ed
	 nN+osBBEH5fA01cwv6MPME9qy8DyIzL4BWKJghUf3R43nF+wBeus86PLt4VRpA9AWb
	 kPZxhdkB4zdjA==
Date: Sun, 2 Jun 2024 10:37:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Julien Stephan <jstephan@baylibre.com>, Esteban Blanc
 <eblanc@baylibre.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/5] iio: add support for multiple scan types
Message-ID: <20240602103727.007e34d6@jic23-huawei>
In-Reply-To: <20240602102726.35120347@jic23-huawei>
References: <20240530-iio-add-support-for-multiple-scan-types-v3-0-cbc4acea2cfa@baylibre.com>
	<20240602102517.438b51b8@jic23-huawei>
	<20240602102726.35120347@jic23-huawei>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 2 Jun 2024 10:27:26 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Sun, 2 Jun 2024 10:25:17 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > On Thu, 30 May 2024 10:14:07 -0500
> > David Lechner <dlechner@baylibre.com> wrote:
> >   
> > > Up to now, the IIO subsystem has only supported a single scan type per
> > > channel. This scan type determines the binary format of the data in the
> > > buffer when doing buffered reads.
> > > 
> > > For simple devices, there is only one scan type and all is well. But
> > > for more complex devices, there may be multiple scan types. For example,
> > > ADCs with a resolution boost feature that adds more bits to the raw
> > > sample data. Traditionally, for slow devices, we've just always used the
> > > highest resolution mode, but for high performance ADCs, this may not be
> > > always practical. Manipulating data after every read can hurt performance
> > > and in the case of hardware buffers, it may not be possible to change the
> > > format of the data in the buffer at all. There are also ADCs where
> > > enabling the higher resolution can only be done if oversampling is also
> > > enabled which may not be desireable.
> > > 
> > > To allow for more flexibility, we would like to add support for multiple
> > > scan types per channel.
> > > 
> > > To avoid having to touch every driver, we implemented this in a way that
> > > preserves the existing scan_type field. See the "iio: add support for
> > > multiple scan types per channel" the details. The first couple of patches
> > > are just preparation for this.
> > > 
> > > [1]: https://lore.kernel.org/linux-iio/CAMknhBHOXaff__QyU-wFSNNENvs23vDX5n_ddH-Dw3s6-sQ9sg@mail.gmail.com/    
> > 
> > Nice series. Applied to the togreg branch of iio.git and pushed out as
> > testing for 0-day to poke at it.
> > 
> > Obviously this v3 hasn't been on list that long, but there is still time
> > as I doubt I'll push out a non rebasing tree for a week or so.
> > This week is looking too busy!  
> 
> oops. Goes to show I'm not keeping track of things very well today.
> I haven't applied the driver this updates yet.
> 
> I'll look at that now and hopefully I can pick them both up.
> 
That was fine, so both now applied.
> Jonathan
> 
> > 
> > Thanks,
> > 
> > Jonathan
> > 
> > 
> >   
> 
> 


