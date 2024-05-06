Return-Path: <linux-iio+bounces-4838-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F5F8BCE89
	for <lists+linux-iio@lfdr.de>; Mon,  6 May 2024 14:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 650F8B2804F
	for <lists+linux-iio@lfdr.de>; Mon,  6 May 2024 12:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD3C6D1AE;
	Mon,  6 May 2024 12:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W1YJjOyR"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2373C1DFED;
	Mon,  6 May 2024 12:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715000048; cv=none; b=E99Z5NfnCXFd6J6FTRg6W8S0zpzQVXKuroXxIc05/VJ+RrLUo80Y0Rn46wXEtCDXHqtE3uOlrMT5oUTOT2DaILt5PDZ6RMB99/jylXLwCWrYNTJSx1sZ+FH3TgDqksAlhrN46IoL8G8M2g9B6Wpi+v1PGziVxvM4TqTuy00owF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715000048; c=relaxed/simple;
	bh=KUwwyNyJwPPdMeGqoeTUqqEDzql3cEq+MUynSJgDF6s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f+Ky/R8Ev2gxFE5AIY/qabYKphvJsLmSh6FmYkvCZtvu/ZpQKC9OwN6mBSafYUGeZCjY46PU+6vQbi5HIfT5i/evMYE9/u6cq8B6q/v2lZP4mYKFaqHPLLYeXBUr/OEpHtikusqJB1yYBEvXmICyJIYP+MNpy2VFjrFUo24XU60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W1YJjOyR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C523C116B1;
	Mon,  6 May 2024 12:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715000047;
	bh=KUwwyNyJwPPdMeGqoeTUqqEDzql3cEq+MUynSJgDF6s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=W1YJjOyRny1ZzwTH0HfI8uXikOQ9ax3ni+hVAM+atWu2yCpmAVVH/coidEJZo9qFu
	 dYZrvsg39skRnjVYB9gyKb5W+w7odcw8WVAoL4IAQhzn11D055spDMDXjZxZbORyvQ
	 Hr15TjvOvoU/CBHa/WUtUApJXDkSdo+/iDBIkgSswVNc3ftn4rGOfwxsn65i13+tp3
	 PsT4faH3IUHGxKVbGLKx8UhzABzvi+oc7JKSis4c0x2vyXPng/5KEWpfRLCAGjaSqv
	 +PggfKnIM3PT8vFRKGfLm/z7W+vmwSbuzjrtFjh4E1pCD/LrEJWmVHc/JcZeMRaG8S
	 mbK/dy14+s9zg==
Date: Mon, 6 May 2024 13:53:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen
 <lars@metafoo.de>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Chenyuan Yang <chenyuan0y@gmail.com>
Subject: Re: [PATCH v2 0/2] Fix the iio-gts-helpers available times table
 sorting
Message-ID: <20240506135356.7babe20f@jic23-huawei>
In-Reply-To: <11a16488-7f5f-4d53-a091-9cedcab76dc8@gmail.com>
References: <cover.1714480171.git.mazziesaccount@gmail.com>
	<20240505185027.18809bfd@jic23-huawei>
	<11a16488-7f5f-4d53-a091-9cedcab76dc8@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 6 May 2024 08:09:27 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> On 5/5/24 20:50, Jonathan Cameron wrote:
> > On Tue, 30 Apr 2024 15:44:26 +0300
> > Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> >   
> >> Fix the available times table sorting in iio-gts-helpers
> >>
> >> This series contains a fix and test for the sorting of the available times in
> >> IIO-gts helpers. Fix was originally developed and posted by Chenyuan Yang.
> >>
> >> Revision history:
> >> 	v1 => v2:
> >> 	  - Fix the sender for patch 1/2 (Sic!)
> >> 	  - Fix Co-Developed-by tag (drop this from Chenyuan who
> >> 	    is the original author)
> >> 	  - Fix the From: tag as instructed in:
> >> 	    https://www.kernel.org/doc/html/latest/process/submitting-patches.html  
> > 
> > Am I right in thinking this doesn't matter for existing drivers?  
> 
> I think this is right. Only couple of in-tree drivers are using these 
> helpers for now, and all of them sorted the tables already in driver.
> 
> > As such not high priority for back porting?  
> 
> The bug is pretty nasty as it causes invalid memory accesses. Hence I'd 
> like to see this landing in the longterm kernels. It seems to me the GTS 
> helpers got merged in 6.4, so getting the fix backported to 6.6 might 
> make sense.
> 
> > I'll assume that and queue it up for 6.11. If someone shouts I can pull the fix
> > forwards, but then we have the mess of chasing the testing in later.  
> 
> I am sorry Jonathan but I'm not quite sure what you mean by "pulling fix 
> forward", or what is the "mess of chasing the testing in later" :)

Hmm. That was an odd choice of words :)  I just meant that I could send
the fix in the first set of fixes after 6.10-rc1 rather than waiting for 6.11.

For now I'll leave it queued for 6.11 on the basis there are a lot of ways
a driver writer can cause similar out of bounds accesses and they should
notice it not working during testing.  So it 'should' not be a problem to
not rush this in.

J
> 
> > Applied to the togreg branch of iio.git and pushed out as testing for 0-day
> > to poke at it.  
> 
> Thanks! Appreciate your work as always!
> 
> Yours,
> 	-- Matti
> 


