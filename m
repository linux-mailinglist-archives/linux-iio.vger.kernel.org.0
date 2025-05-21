Return-Path: <linux-iio+bounces-19773-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF054ABF43D
	for <lists+linux-iio@lfdr.de>; Wed, 21 May 2025 14:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F8A81BC3EAC
	for <lists+linux-iio@lfdr.de>; Wed, 21 May 2025 12:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962F525D8FC;
	Wed, 21 May 2025 12:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MgxAnuhb"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C181EB39
	for <linux-iio@vger.kernel.org>; Wed, 21 May 2025 12:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747830098; cv=none; b=lolQPVKBqE57+NpLWnvxn/jaF2DVmOzDGMYoJFu495qPKnYDiTnob9ftfxrhA8/ndwK9i8df9Slv4bN/K+M0PxwGc1twJsmwNEB/F5X4fdaflj4limzUDpRXTUEX6Vgy1AZ/E4myIvGwXa0+4G+m7R6K5MK3ryJkWF8GpZvll80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747830098; c=relaxed/simple;
	bh=Qlb6G4BSO9M7/L6xzVCQI73ICN3+Mtk5mUtjsu4JsNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EWXVabSHhBRaqBrQ1KEVt6Mk7yeRz2wSQI/OmsJlix8XS2pZSVpHzFwaIhPFgViwElMhWBOA+FuXfMS0Qow+TvImoFsRiVqgEbrGk4eUOZTMAfcjOd80bO7Rc4YAB6+ECTeKggSTZHjJjD7kV7uZUvTfYy7IoDeUQ+k3lbv/cDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MgxAnuhb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68FB5C4CEE7;
	Wed, 21 May 2025 12:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747830097;
	bh=Qlb6G4BSO9M7/L6xzVCQI73ICN3+Mtk5mUtjsu4JsNw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MgxAnuhbjDkfqYSjZGLlo5ymlk88wXO4KiJyHMb/WUK65J2Aczy5aU3oofre5kM0M
	 nIdUe/GLA2yJlTiu4zN64GTxVnkTDjgZ9oVrGrg2qbam9bTglmDVCQ1CPmteSZaCvE
	 pRHLatgi6xePBvgJkTYEsBPWO5xEOXE9ueM9iJdU=
Date: Wed, 21 May 2025 14:21:35 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO: New device support, features and cleanup for 6.16
Message-ID: <2025052113-reproach-zebra-005b@gregkh>
References: <20250517202341.095163d6@jic23-huawei>
 <20250518190933.4dab9eea@jic23-huawei>
 <2025052102-vanilla-acorn-606f@gregkh>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025052102-vanilla-acorn-606f@gregkh>

On Wed, May 21, 2025 at 02:20:34PM +0200, Greg KH wrote:
> On Sun, May 18, 2025 at 07:09:33PM +0100, Jonathan Cameron wrote:
> > On Sat, 17 May 2025 20:23:41 +0100
> > Jonathan Cameron <jic23@kernel.org> wrote:
> > 
> > > The following changes since commit 0af2f6be1b4281385b618cb86ad946eded089ac8:
> > > 
> > >   Linux 6.15-rc1 (2025-04-06 13:11:33 -0700)
> > > 
> > > are available in the Git repository at:
> > > 
> > >   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-6.16a
> > > 
> > > for you to fetch changes up to 1b8833364795fb4562b867623f62b401b72238e2:
> > > 
> > >   dt-bindings: iio: adc: Add ROHM BD79100G (2025-05-17 20:18:30 +0100)
> > > 
> > Hi Greg,
> > 
> > I didn't call it out in here because I'd forgotten about it when writing this
> > pull request up whilst travelling.  There is a trivial conflict with the
> > fixes pull request I just sent that modifies an adjacent line in the 
> > ad7606 driver.
> > 
> > https://lore.kernel.org/all/20250502-iio-adc-ad7606-fix-raw-read-for-18-bit-chips-v1-1-06caa92d8f11@baylibre.com/
> > called that out under the ---
> > 
> > I haven't resolved it locally because I meant to send that fix
> > a while back and as mentioned I forgot about it.  Hope you don't mind
> > doing the resolution during the merge.
> > 
> > Stephen's resolution was:
> > https://lore.kernel.org/linux-next/20250506155728.65605bae@canb.auug.org.au/
> 
> I've used his resolution here as well, thanks!

Ick, I get the following errors when trying to merge this:

Commit: 59e1bb0b7f4e ("iio: adc: ad4000: Avoid potential double data word read")
	Fixes tag: Fixes: d0dba3df842f ("iio: adc: ad4000: Add support for SPI offload")
	Has these problem(s):
		- Target SHA1 does not exist
Commit: 6f9b765075be ("iio: dac: ad5592r: Delete stray unlock in ad5592r_write_raw()")
	Fixes tag: Fixes: f8fedb167ba4 ("iio: dac: ad5592r: use lock guards")
	Has these problem(s):
		- Target SHA1 does not exist
Commit: 959fd4301e1a ("docs: iio: ad3552r: fix malformed table")
	Fixes tag: Fixes: 9a259b51e3ea ("docs: iio: add documentation for ad3552r driver")
	Has these problem(s):
		- Target SHA1 does not exist

So I can't take it, sorry :(

greg k-h

