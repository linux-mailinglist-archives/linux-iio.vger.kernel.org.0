Return-Path: <linux-iio+bounces-20066-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0CF3AC9B74
	for <lists+linux-iio@lfdr.de>; Sat, 31 May 2025 17:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B770518986A2
	for <lists+linux-iio@lfdr.de>; Sat, 31 May 2025 15:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C05C23D282;
	Sat, 31 May 2025 15:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QNWGX2Tk"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5751623A9AE;
	Sat, 31 May 2025 15:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748704236; cv=none; b=bwPFAaZIennr5eTJyuNmlixmgwcTgFHhMQePcUzAdJQDO28cnlkCAjx2ECNOvaENs8td8/txsw3s6jm4cutMxLCTIUQrkIYUwm9F4lb0qXo4L1Csf2PUEOOY30MEvo2LDS3INBFSVeKjsFpi63Ww5ulqCWoEKlxKlf1yMNyw3rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748704236; c=relaxed/simple;
	bh=ZMHrF29e4Q0OwlSJeMtEVlrgKuLi7VCVY7xQQc19E3o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jI6yXtxPf9sGERITRRXzf8eBciCC77so9Mxj6lvN9vLUvQ11meIadfEydw/bMNgXfyOjDZAUjRIeUUnbzxj7aT81vOmu+diObGb23TYRfwaU05aZR+i7+8zd+cR8wB/mj0txN6HwfzM1cS/lTMriApuBSrfAfnNVmkl6DupIVgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QNWGX2Tk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEC8DC4CEE3;
	Sat, 31 May 2025 15:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748704235;
	bh=ZMHrF29e4Q0OwlSJeMtEVlrgKuLi7VCVY7xQQc19E3o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QNWGX2TkEuQg0+tuSvottoUNgI4LinPejvb+o22rbtBIAKxj2kLhM9ywJzv+ynB4R
	 Hxn6a/nbz804MIbdCwQgReiLhwcsYORmarTB6MTQ3yMQ/X/poMg4cierNCxSX6IU5A
	 DIO2D1eBq5fcjUwvC28zz0yg3VND7wqwRGOlxBd7eFu3dgc/PLMMcqd/mDsHq8i1sA
	 rH4q8dQQYzOAQGpePt3k9y1weDiOFIRmHYq9ZocoRJYv/NuocesRLdqX8o1JSxOud+
	 ll7MwGSHMj3DM5MzlvV7EhaMdg2LY0n5kq8Q0bCo4wdVthhgQG+rDKwLsVusPM3JmE
	 6NiYGYVe1cDdQ==
Date: Sat, 31 May 2025 16:10:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Waqar Hameed <waqar.hameed@axis.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, <kernel@axis.com>,
 <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 3/3] iio: Add driver for Nicera D3-323-AA PIR sensor
Message-ID: <20250531161029.4010a3d6@jic23-huawei>
In-Reply-To: <pndecwa85z5.fsf@axis.com>
References: <cover.1746802541.git.waqar.hameed@axis.com>
	<c5184074d85b68ca35ccb29ab94d774203b93535.1746802541.git.waqar.hameed@axis.com>
	<20250511131432.1c6e381c@jic23-huawei>
	<pndldqwiihi.fsf@axis.com>
	<20250518183852.7e9afdac@jic23-huawei>
	<pndo6vnfrnp.fsf@axis.com>
	<20250525103019.3773be94@jic23-huawei>
	<pndecwa85z5.fsf@axis.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 May 2025 16:48:30 +0200
Waqar Hameed <waqar.hameed@axis.com> wrote:

> On Sun, May 25, 2025 at 10:30 +0100 Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > On Tue, 20 May 2025 13:27:54 +0200
> > Waqar Hameed <waqar.hameed@axis.com> wrote:
> >  
> >> On Sun, May 18, 2025 at 18:38 +0100 Jonathan Cameron <jic23@kernel.org> wrote:
> >>   
> >> >> >> +#define D3323AA_DRV_NAME "d3323aa"      
> >> >> >
> >> >> > Put that inline where used.  A define like this both implies that various values
> >> >> > must be the same when they need not be and means that we have to go find the
> >> >> > define to fine out what they are set to.  Just setting the strings directly
> >> >> > tends to end up more readable.      
> >> >> 
> >> >> Sure, we can do that. (There are a bunch of IIO-drivers doing this, so I
> >> >> just thought that was the "convention".)    
> >> >
> >> > I'm sometimes in less fussy mood.  One day I might just clean those up
> >> > so there is nothing to copy into new drivers!    
> >> 
> >> A quick search tells that there are (at least) 105 of those:
> >> 
> >>   rgrep -A 30 "\.driver" drivers/iio/ | grep "\.name" | grep -v '"'
> >>   
> >> I was just about to write a small Python script to fix those, but just
> >> wanted to confirm with you before spending more time on this. So if you
> >> don't want to do this yourself, I can help your here :)  
> >
> > It's probably not worth the churn on the ones that have the string repeated
> > multiple times.  However, perhaps any that are only using it for .name would
> > be good to tidy up?  Those are less a case of it being 'taste' vs it being silly
> > to have a define!  
> 
> I think if you use it in multiple places, it should definitively be a
> macro definition. I just sent some patches for those that only used it
> once (I didn't include those with `KBUILD_MODNAME`. We can discuss if we
> should also address those in that thread).

I would disagree slightly.  If it is used in multiple places because there
is some inherent reason they should have same string then I absolutely agree.
If it's just because it's a convenient string that is used twice in places
that could have had different string then not so much.

> 
> However, there are a bunch of drivers that _only_ use a macro definition
> in `.name` and `indio_dev->name`, including this one. That _is_ more
> than one place, so we should actually leave it? Or do you still think we
> should have the same string literal in both places, as you originally
> commented above?

I'd prefer that for new code, but it is a less clear cut case than the ones
you have tidied up, so not worth the churn of tidying up unless people
are otherwise working on the relevant drivers.

Jonathan

> 


