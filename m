Return-Path: <linux-iio+bounces-26905-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CFECAB74D
	for <lists+linux-iio@lfdr.de>; Sun, 07 Dec 2025 17:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5CA9430062F5
	for <lists+linux-iio@lfdr.de>; Sun,  7 Dec 2025 16:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7126F277017;
	Sun,  7 Dec 2025 16:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lgullIa9"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE821A9FA8;
	Sun,  7 Dec 2025 16:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765123494; cv=none; b=A+4v6aSQm3N4JmvjQTN9t87YM0i2RP80wHA0H5YCBQNdVrP+dS86ztkmbrC5IhSzT/GS7OIYt84AQoDh1NDJK8MIoO3bBl3xZKwGP/K+YidAB34N6w+mvidygMc+1omcCDZyLOc6n/Qy9ZSs0WqpEgWFxghRyk2YS6Uv5fY92wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765123494; c=relaxed/simple;
	bh=Ae07Glt9swweZACLss+9QiVLzy+UQboGW0oo6/ZEsng=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uGAYCt8sSASw0ULIRdFKpRMFxyW1JVHOp1Kh2F1RXxooCTptrPaNUzN0M/Vo80vq6PSbcyC9vTuVxTMAsHZpiwLEmdd6eKWfHPDd87oYY8zDR4YS3sK2OHvXt5/4QZGJqlZWJHO3TAYd86+fGKvnY+HRgyLpeDep+gx6M2ZTTuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lgullIa9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79A0BC4CEFB;
	Sun,  7 Dec 2025 16:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765123494;
	bh=Ae07Glt9swweZACLss+9QiVLzy+UQboGW0oo6/ZEsng=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lgullIa9vfXNEMy4aED0XO0HO3vzuh8FCUcQh1RAmw8BSCmme5fIBkE8nQ8bxZCvA
	 fgJ5jiumm7vTBhSk2cwuScLZ5l9E0EUh1MEVrY8UG2HXMRToMJUEHr37bnS2pqMAzX
	 Cs/JvbQyYaS1wRp/1uyBOKxM82YKttkg+NF3hCKDpQJAzu+AXQElYFWKmfF70rpFMq
	 8RdY//McOfaBPvk8MLt3vnaXVU6e7wNZnKyerK9t9Bn3C289nVwOId7kCrsShP1u0w
	 y0uWtq8GW8zGg0zHEQ5TCd/ldJ+CA6RcbGK81Au6Jxk+BP8Chd0jfAHLTkI8MW41+h
	 GMLtACZnqemXQ==
Date: Sun, 7 Dec 2025 16:04:48 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Tomas Borquez <tomasborquez13@gmail.com>, andy@kernel.org,
 dlechner@baylibre.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, nuno.sa@analog.com
Subject: Re: [PATCH v3] iio: isl29018.c: replace sprintf with safer
 alternatives
Message-ID: <20251207160448.66c91da7@jic23-huawei>
In-Reply-To: <aSd3DT7XfcG5frc5@smile.fi.intel.com>
References: <20251126172432.5532-1-tomasborquez13@gmail.com>
	<20251126203240.13466-1-tomasborquez13@gmail.com>
	<aSdsc6jhQLHLVfkR@smile.fi.intel.com>
	<aSd0Q7qCueXDSZtN@Lewboski.localdomain>
	<aSd3DT7XfcG5frc5@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Nov 2025 23:54:21 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Wed, Nov 26, 2025 at 06:46:18PM -0300, Tomas Borquez wrote:
> > On Wed, Nov 26, 2025 at 11:09:07PM +0200, Andy Shevchenko wrote:  
> > > This is a bit too long. Usually in the commit message the ~75 is a good
> > > threshold.  
> 
> ...
I tweaked the title as well to be:
iio: light: isl29018: replace sprintf() with safer alternatives

Applied to my currently local only togreg branch. I'll rebase on rc1 once it
is out and then it will turn up in linux-next etc.

> 
> > > P.S. Do NOT resend if not asked so. Jonathan may amend this whilst applying.
> > > Also note, this most likely misses the v6.19-rc1, so we have plenty of time,
> > > no rush with it.  
> 
> > Ah I see, my bad, its my first patch so I'm still adjusting to the workflow.
> > Thanks for the feedback, will keep everything in mind!  
> 
> NP and welcome aboard!
> 
Seconded!

