Return-Path: <linux-iio+bounces-14134-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 101B1A0A3F2
	for <lists+linux-iio@lfdr.de>; Sat, 11 Jan 2025 14:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F707188BF50
	for <lists+linux-iio@lfdr.de>; Sat, 11 Jan 2025 13:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4961718CBFE;
	Sat, 11 Jan 2025 13:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V2XNBhNz"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072FB1A8F82
	for <linux-iio@vger.kernel.org>; Sat, 11 Jan 2025 13:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736602658; cv=none; b=nk5MMiGhFki/ZG91Bf3y5Gov1/DupyPeKARkPJHjL/46qKViOuDE7tBIk5jbKRqjmeUG74DmprEd3idk4gGwOoCzHNijiJYITdtSh2ps420F7Y4OJbIfDELBD9K01k22G8Vwwn5o4ERjS93FMkAYupeCp9LlDAjpPzOuL0Z9y9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736602658; c=relaxed/simple;
	bh=WPt7awXR6dYH4pmZIcwZGyIHnElAJj4mJk6ADNe8s+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jtqa5UBc3icmlkqdLOHsydBAX1BhhuBFqSKvzNWXCAIkY1e4CQ/2Fd3vuEX2ApaR8yDuSqHcAiR+HHVMm+0ZZwN3gyf+eS7KUXBkbQR38fXwM2Z/d++kwWlfDYBztNPIrJY0i/HW9+fPmLOxbrdypJnLn39FqyhjcEzKO8m8l4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V2XNBhNz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1761C4CEDF;
	Sat, 11 Jan 2025 13:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736602657;
	bh=WPt7awXR6dYH4pmZIcwZGyIHnElAJj4mJk6ADNe8s+Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V2XNBhNzyJnCrt8vVVcVuXYAQfmmbfxR/dZ5QwCRGsQnFbV5Lzk3ehKhttw7FmQwm
	 ukcoDoPko7P6orxkrO77lObAkxE1W1ER4XHh49k03A3yOsmtwhorFPd49e4vMvhOjP
	 6g+Rge7Fb6ah0Qv0AZtkjYv8gjeDea6i0ww8g+UiwLh5mAW8FAAZvaKkMaHumxOHqa
	 qntEnyecocWwyTmVa8BVuty3kbanoKDf1m+dJYQgjpoWMP7xZHtaHjecC7YA4NkusC
	 nPvpngPf0I71s4I7Fu4VyI5KNjU6dUQF1oXa6f9E0T+a+htliAsrb7NY9s0wahUEjD
	 NrExI7Yjp7GuQ==
Date: Sat, 11 Jan 2025 13:37:31 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
 <linux-iio@vger.kernel.org>, =?UTF-8?B?4oCcTHVj?= Van =?UTF-8?B?T29zdGVu?=
 =?UTF-8?B?cnlja+KAnQ==?= <luc.vanoostenryck@gmail.com>, David Lechner
 <dlechner@baylibre.com>
Subject: Re: [RFC PATCH 09/27] iio: adc: ad4000: Stop using
 iio_device_claim_direct_scoped()
Message-ID: <20250111133731.18f6a6e4@jic23-huawei>
In-Reply-To: <20250107142854.0000656a@huawei.com>
References: <20250105172613.1204781-1-jic23@kernel.org>
	<20250105172613.1204781-10-jic23@kernel.org>
	<Z30QIFr12sw7Wajd@debian-BULLSEYE-live-builder-AMD64>
	<20250107142854.0000656a@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 7 Jan 2025 14:28:54 +0000
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> On Tue, 7 Jan 2025 08:29:36 -0300
> Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:
> 
> > On 01/05, Jonathan Cameron wrote:  
> > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > 
> > > This complex cleanup.h use case of conditional guards has proved
> > > to be more trouble that it is worth in terms of false positive compiler
> > > warnings and hard to read code.
> > > 
> > > Move directly to the new claim/release_direct() that allow sparse
> > > to check for unbalanced context.
> > > 
> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > ---
> > >  drivers/iio/adc/ad4000.c | 61 +++++++++++++++++++++++++---------------
> > >  1 file changed, 38 insertions(+), 23 deletions(-)
> > >     
> > Hi Jonathan, aside from the spurious blank line noted by David, the changes for
> > ad4000 look good to me.
> > 
> > Acked-by: <marcelo.schmitt1@gmail.com>
> > 
> > I also tried running Sparse on IIO subsystem but didn't see any warns for the
> > drivers being changed (nor prior nor after applying the patches).
> > 
> > make CHECK="path_to_local_sparse_v0.6.4-66-g0196afe1" C=2 drivers/iio/
> > 
> > Did see warns after adding incorrect type in assignments in the driver.
> > 
> > Mind sharing how you are running Sparse?  
> 
> I just used C=1 but that doesn't really matter for this.
> With this series there should be no false positive warnings (or before
> it where we didn't have any markings so sparse didn't know to do anything).
> 
> Testing wise, I sprinkled in some early returns, breaks etc to add
> some broken paths and those triggered context imbalance warnings.
> 
> This isn't fixing warnings, it is just about moving to code where we
> will get them if we do something silly in the future.

Seems David is also not seeing warnings when he deliberately breaks
the code.  See discussion on patch 1. Hopefully we'll soon get to the
bottom of why!

Jonathan

> 
> Jonathan
> 
> > 
> > Thanks,
> > Marcelo  
> 


