Return-Path: <linux-iio+bounces-12922-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 324CB9DF5D4
	for <lists+linux-iio@lfdr.de>; Sun,  1 Dec 2024 14:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B9B5B213E6
	for <lists+linux-iio@lfdr.de>; Sun,  1 Dec 2024 13:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB38D1D07BE;
	Sun,  1 Dec 2024 13:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GDQ7Az8O"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950761D043F;
	Sun,  1 Dec 2024 13:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733060343; cv=none; b=Q3o2KSIzhXkDDUOdQC4sDRoYNq+30kPQ+HYWzTw9iDGFm8D1lCesZoA3RBwj1qYdi0Huqe0hAjuGqsNJ0XchMPcAL9z/HurX1HR02EgmGaKfvzxLcwFqan9iUXQaAcThkAY7rgVfqlqEMcQcrkBhMASfx2RWXKe20dMhmhEMps0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733060343; c=relaxed/simple;
	bh=QoutfndgNOo2iW6hFIXJ48WE+GMQKoPrnTPRsPW92S4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fJnrIVV/AgzaSpoHG1OVROzVvoL9ngq4ZMRX3WzDjuFRnRy3TjjYWNM4M8cgMFLvuqNtWSkXD9XmMuQnYaRs28yFi7b4vylr3z06hMdVS36QvM+YF8OaxeiR1PXkpSKaMiBpgUgRzerS/PlHbEOWOHC06w+8CUiOSG1anZf8k4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GDQ7Az8O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9D2EC4CEDB;
	Sun,  1 Dec 2024 13:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733060343;
	bh=QoutfndgNOo2iW6hFIXJ48WE+GMQKoPrnTPRsPW92S4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GDQ7Az8OdYnDvTJLqEwXyycACpZj3lsVaQKiKwGoDAGvmRonGNVaNsYjKOADUWKHk
	 gTh9SHEFcwE+GOQ4VEn1CdhdRG2VmDxYsGZeSzN1ju4Wglc2eZpJu4p+D7fTuoiuNZ
	 K8hnOzLfqe419PZD/VefPikyoCa+hQTZjWkB/OIHuSPW7DVqisjcGdsuSP2Ixa5KHK
	 flxcI5Q5RSL4TjZWAUoefGlqJzvrkNSr8iWV0dbItIAkcUJioukL+Cdhw5PnpSQAHE
	 nK5AkxyLZHS8ArKdhKMFmlPuKgAwa4iGu/8hSBL2sWGwoEwx3beEFoGyXkk5aA8CYr
	 6qtpWETIWqnNQ==
Date: Sun, 1 Dec 2024 13:38:54 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Laight <David.Laight@ACULAB.COM>, 'Jakob Hauser'
 <jahau@rocketmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Linus Walleij
 <linus.walleij@linaro.org>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] iio: magnetometer: yas530: Use signed integer type
 for clamp limits
Message-ID: <20241201133854.2e87400c@jic23-huawei>
In-Reply-To: <20241130183222.ecf271abffcff61b93bbae22@linux-foundation.org>
References: <11609b2243c295d65ab4d47e78c239d61ad6be75.1732914810.git.jahau@rocketmail.com>
	<11609b2243c295d65ab4d47e78c239d61ad6be75.1732914810.git.jahau@rocketmail.com>
	<9f5793f03c2440d2aa18630469df06df@AcuMS.aculab.com>
	<20241130143506.53973e40@jic23-huawei>
	<6f2c9946a9fe4b40ac7dd5a66003c8c4@AcuMS.aculab.com>
	<20241130183222.ecf271abffcff61b93bbae22@linux-foundation.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 30 Nov 2024 18:32:22 -0800
Andrew Morton <akpm@linux-foundation.org> wrote:

> On Sat, 30 Nov 2024 20:59:22 +0000 David Laight <David.Laight@ACULAB.COM> wrote:
> 
> > From: Jonathan Cameron  
> > > Sent: 30 November 2024 14:35
> > > 
> > > On Sat, 30 Nov 2024 11:40:45 +0000
> > > David Laight <David.Laight@ACULAB.COM> wrote:
> > >   
> > > > From: Jakob Hauser
> > > >
> > > > Copying Andrew M - he might want to take this through his mm tree.  
> > > 
> > > I'm confused. Why?
> > > 
> > > Looks like a local bug in an IIO driver.  What am I missing?  
> > 
> > The build test bot picked it up because a change to minmax.h that Andrew
> > committed to the mm tree showed up the bug.
> > To avoid W=1 builds failing Andrew had applied a temporary 'fix'.
> > So he needs to be in the loop at least.
> > I don't know the actual procedure :-)  
> 
> Jakob's minmax changes
> (https://lkml.kernel.org/r/c50365d214e04f9ba256d417c8bebbc0@AcuMS.aculab.com)
> are queued in mm.git for 6.14-rc1.  They require a yas530 fix to build.
> 
> So as I need to carry this yas530 fix in mm.git I'd like to merge it as
> a hotfix for 6.13-rcX, sometime in the next week or two.  So please
> send acks!

Thanks for the info - I'm fine with this going through mm.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

