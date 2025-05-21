Return-Path: <linux-iio+bounces-19776-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82BF5ABF61B
	for <lists+linux-iio@lfdr.de>; Wed, 21 May 2025 15:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A6FB1887E61
	for <lists+linux-iio@lfdr.de>; Wed, 21 May 2025 13:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD18B2798F1;
	Wed, 21 May 2025 13:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vDP6PInp"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBAE2777E4
	for <linux-iio@vger.kernel.org>; Wed, 21 May 2025 13:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747834256; cv=none; b=CpYaAa0g7jbzYBo5YiSFUyjB+F4YP7KL1xpUn9B/o9ciMHicICZnTXDjiiJR/xDDT/LMOO14fGM24yAdUIpT7frPbxUgw7GHMl+rLrHvB8AJqLW54IU3SAJuAOCQfyEI4ejXhxYW6y/q7ItwR9hA82pkjQfAQBceKV66kPXXOiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747834256; c=relaxed/simple;
	bh=ShKcC77TyAQ3Cw5Hr+BP0MRVOy4JYN/x2Hi97q7XsJk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NzFZXgltp18riCIUyXhr7eRHdMGdqFYRObl4rSsL5yWTxKVsjdsF7FocXj2fpEfdCceBgKWkBBsvKedPCMAO+t4Ml3nZagKkNfUKwxfOKB0ChZDBwwllcG7Ix/EAMJaM0fro/Ue5jyE9teyr3nYF14p1J1uM3hfWfMtZNjYiOXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vDP6PInp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 379A2C4CEE7;
	Wed, 21 May 2025 13:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747834255;
	bh=ShKcC77TyAQ3Cw5Hr+BP0MRVOy4JYN/x2Hi97q7XsJk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vDP6PInpLEhj+9kNqkRarPGNcTRfkIB63fSbVdtlT9OAUunh8+KVwZIx8YxFWaYue
	 aRKI61gXGimUJZt8KcoDMtU1BJ4+X5hCAcEd2FdZyK9P72L4WdGAq8LDKNJLAAWbJa
	 abDcaVz25TjsBKprxoWeIonbzAyuW2h/DWSYLlntdWnzNrIC90qITuY9JO9vylP7vB
	 lnXSHj+GpjFaBHrQbIqKrYRPSg5I8RCpKXVUT7WJt5B/R2ypCPLACi9FSM5pkGCjd4
	 KxSOdxNS4QHv51MQuiADrKwgLvSZDF0JV9cZbmmYtLEwHlC1ItLCcwMPDxq53L7krx
	 Hczkizhdo/j9g==
Date: Wed, 21 May 2025 14:30:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PULL] IIO: New device support, features and cleanup for 6.16
Message-ID: <20250521143048.5c43a427@jic23-huawei>
In-Reply-To: <20250521133137.00005572@huawei.com>
References: <20250517202341.095163d6@jic23-huawei>
	<20250518190933.4dab9eea@jic23-huawei>
	<2025052102-vanilla-acorn-606f@gregkh>
	<2025052113-reproach-zebra-005b@gregkh>
	<20250521133137.00005572@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 May 2025 13:31:37 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> On Wed, 21 May 2025 14:21:35 +0200
> Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> > On Wed, May 21, 2025 at 02:20:34PM +0200, Greg KH wrote:  
> > > On Sun, May 18, 2025 at 07:09:33PM +0100, Jonathan Cameron wrote:    
> > > > On Sat, 17 May 2025 20:23:41 +0100
> > > > Jonathan Cameron <jic23@kernel.org> wrote:
> > > >     
> > > > > The following changes since commit 0af2f6be1b4281385b618cb86ad946eded089ac8:
> > > > > 
> > > > >   Linux 6.15-rc1 (2025-04-06 13:11:33 -0700)
> > > > > 
> > > > > are available in the Git repository at:
> > > > > 
> > > > >   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-6.16a
> > > > > 
> > > > > for you to fetch changes up to 1b8833364795fb4562b867623f62b401b72238e2:
> > > > > 
> > > > >   dt-bindings: iio: adc: Add ROHM BD79100G (2025-05-17 20:18:30 +0100)
> > > > >     
> > > > Hi Greg,
> > > > 
> > > > I didn't call it out in here because I'd forgotten about it when writing this
> > > > pull request up whilst travelling.  There is a trivial conflict with the
> > > > fixes pull request I just sent that modifies an adjacent line in the 
> > > > ad7606 driver.
> > > > 
> > > > https://lore.kernel.org/all/20250502-iio-adc-ad7606-fix-raw-read-for-18-bit-chips-v1-1-06caa92d8f11@baylibre.com/
> > > > called that out under the ---
> > > > 
> > > > I haven't resolved it locally because I meant to send that fix
> > > > a while back and as mentioned I forgot about it.  Hope you don't mind
> > > > doing the resolution during the merge.
> > > > 
> > > > Stephen's resolution was:
> > > > https://lore.kernel.org/linux-next/20250506155728.65605bae@canb.auug.org.au/    
> > > 
> > > I've used his resolution here as well, thanks!    
> > 
> > Ick, I get the following errors when trying to merge this:
> > 
> > Commit: 59e1bb0b7f4e ("iio: adc: ad4000: Avoid potential double data word read")
> > 	Fixes tag: Fixes: d0dba3df842f ("iio: adc: ad4000: Add support for SPI offload")
> > 	Has these problem(s):
> > 		- Target SHA1 does not exist
> > Commit: 6f9b765075be ("iio: dac: ad5592r: Delete stray unlock in ad5592r_write_raw()")
> > 	Fixes tag: Fixes: f8fedb167ba4 ("iio: dac: ad5592r: use lock guards")
> > 	Has these problem(s):
> > 		- Target SHA1 does not exist
> > Commit: 959fd4301e1a ("docs: iio: ad3552r: fix malformed table")
> > 	Fixes tag: Fixes: 9a259b51e3ea ("docs: iio: add documentation for ad3552r driver")
> > 	Has these problem(s):
> > 		- Target SHA1 does not exist
> > 
> > So I can't take it, sorry :(  
> Huh didn't see those locally for some reason.  I'll fix up and send a new version. 
> I probably missed a script run after rebasing to take a out that spurious
> non IIO patch.
> 
> Will be an hour or so.
> 
I considered rebasing the whole thing on char-misc-next, but the mess up is only in the last
few (46ish) patches and it would take for a lot more tag updating to rebase
and resolve the minor confict.

I could merge in at the end but there seems little benefit as we'll just end
up with a stack of merges.  So I hope you don't mind resolving as before.

Sorry for the mess up.

Jonathan




> J
> > 
> > greg k-h
> >   
> 
> 


