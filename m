Return-Path: <linux-iio+bounces-19857-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31EDBAC336B
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 11:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E52F91764D2
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 09:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC521BC099;
	Sun, 25 May 2025 09:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h+9bVgIU"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB080101FF;
	Sun, 25 May 2025 09:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748165428; cv=none; b=UOFgCMbirzu89F1ZSdQwaSwHiWSrVJp2g3mIQYmVW6h5Sb85w67r0F9o4Y5gHa7d71dWo5zM5AvTcn18svdEV2zpsFs5utjYuOZnwvyg0SnpetkGgFk7rFYakAHFZad4SLl9CDf0snv7/GpqN6Zj8WdTnvRNPH4H2NKEmrS4Zew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748165428; c=relaxed/simple;
	bh=FK7fJoaY67rJ0ofhpZsxa0KwOuodLzDAxfhAisdsqFE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IWiU8ig5vWyet7MCM9tuvyc0dU5ozIIUDPQrFRHsnzGgqqEphZ2dyz6O1YlS5/yet/XrqxVlS7s9As/fTOHWaD4HmFZqDFb0DcIgrz4IAeYjIFWrC2njJhL9EB7qp3VUfPO1TCF6RASESIPcfDoU/9fYIKxKLKAfKtyRuXFFLY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h+9bVgIU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3009C4CEEA;
	Sun, 25 May 2025 09:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748165427;
	bh=FK7fJoaY67rJ0ofhpZsxa0KwOuodLzDAxfhAisdsqFE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h+9bVgIUFSekKnduhJUBHdhTmOCMBaz16+rASCPCDDFlObJ9SdTnXta+g93Z8x2Hh
	 Ho/m8FHkDXBb+KOIRxsohIUrk9sVWINWhNoISXIH/VteEPjrTz4eAUk4mZjG3hOOfU
	 z4NFnyjakXE9ZTh7QhT36VU8vWDx3Xk4ZfiEZUAzPk9fSo298zqwXKKicOHRZrMwCm
	 l6G+cI7P1VISKE0ce6Pf5zeTqzQueEGvRTOjk8Bk7iZUR8I+pIo74IWtYR6eO3AQG1
	 ur2+ad//8uEP8eLqMGVGQmrM3A/7QVgACO9yfX2CMnqqbbsoqwUqecucnAzNb53u6k
	 CJLR57mtxtkCw==
Date: Sun, 25 May 2025 10:30:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Waqar Hameed <waqar.hameed@axis.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, <kernel@axis.com>,
 <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 3/3] iio: Add driver for Nicera D3-323-AA PIR sensor
Message-ID: <20250525103019.3773be94@jic23-huawei>
In-Reply-To: <pndo6vnfrnp.fsf@axis.com>
References: <cover.1746802541.git.waqar.hameed@axis.com>
	<c5184074d85b68ca35ccb29ab94d774203b93535.1746802541.git.waqar.hameed@axis.com>
	<20250511131432.1c6e381c@jic23-huawei>
	<pndldqwiihi.fsf@axis.com>
	<20250518183852.7e9afdac@jic23-huawei>
	<pndo6vnfrnp.fsf@axis.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 May 2025 13:27:54 +0200
Waqar Hameed <waqar.hameed@axis.com> wrote:

> On Sun, May 18, 2025 at 18:38 +0100 Jonathan Cameron <jic23@kernel.org> wrote:
> 
> >> >> +#define D3323AA_DRV_NAME "d3323aa"    
> >> >
> >> > Put that inline where used.  A define like this both implies that various values
> >> > must be the same when they need not be and means that we have to go find the
> >> > define to fine out what they are set to.  Just setting the strings directly
> >> > tends to end up more readable.    
> >> 
> >> Sure, we can do that. (There are a bunch of IIO-drivers doing this, so I
> >> just thought that was the "convention".)  
> >
> > I'm sometimes in less fussy mood.  One day I might just clean those up
> > so there is nothing to copy into new drivers!  
> 
> A quick search tells that there are (at least) 105 of those:
> 
>   rgrep -A 30 "\.driver" drivers/iio/ | grep "\.name" | grep -v '"'
>   
> I was just about to write a small Python script to fix those, but just
> wanted to confirm with you before spending more time on this. So if you
> don't want to do this yourself, I can help your here :)

It's probably not worth the churn on the ones that have the string repeated
multiple times.  However, perhaps any that are only using it for .name would
be good to tidy up?  Those are less a case of it being 'taste' vs it being silly
to have a define!

> 
> >>  
> >> >> +	/* Input clock or output detection signal (Vout). */    
> >> >
> >> > I'd rename. Vout kind of suggests a variable voltage. This seems to just
> >> > be a level signal.    
> >>   
> >> >> +	struct gpio_desc *gpiod_clk_vout;    
> >> 
> >> Yeah, it's a weird pin with multiple use-cases... I just named it
> >> according to what the datasheet calls it. What about
> >> `gpiod_clk_detection`?  
> >
> > That sounds like it's detecting a clock.  Hmm.  
> > gpiod_clkin_detectout maybe?  
> 
> No objections.
> 
> [...]
> 


