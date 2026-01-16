Return-Path: <linux-iio+bounces-27886-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D21CD386FD
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jan 2026 21:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE433314B63A
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jan 2026 20:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 664113A35AA;
	Fri, 16 Jan 2026 20:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G1OJAVgh"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F83B3A1D1F;
	Fri, 16 Jan 2026 20:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768594170; cv=none; b=XKO0/AMWqE/jJHl0uElJDhZFpQFIkd8p42vr1A4KRbrx+p7D8+Iru/rSiIaK+OulePWMIiPECilh/fVKR/x7aP6Bibdi62f98mYhZIdIuqEt2owECrHGJnjNoWqU5gElMFlusKdGl2iKwlCmIey4twMtgUWfq34F1+swsuDguSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768594170; c=relaxed/simple;
	bh=5L+Mf+YozV6v4LYtZFkuYU6PG8fdFWiof/GcG2gB9q8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LzfRzsNnFFhW6dlFWX0aSD9hd4fYctOw3ccZKkAvmXjTPnS5iD2swoStU7sygsCbpkDLFnfl8i1qYgSBBU1Mpmr4KWgPzTZY0VkWlPnmnHsBnIS8KS3ch4031sRpKGvF4tkd9CRbL46GfJHGhTKW3piVC9rziPxQahpZxKg+GXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G1OJAVgh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 943D7C19422;
	Fri, 16 Jan 2026 20:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768594169;
	bh=5L+Mf+YozV6v4LYtZFkuYU6PG8fdFWiof/GcG2gB9q8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=G1OJAVghEtu5rRvzjWad9dfN4jewE+4Zkhfu2c6rXY1mZU3ik/d+QyE2fErUKePSo
	 JjctzailQIeYtGnxi/1D4i+Gd+es8qg9n+pQPXm/Kse6cBg+0X3kYHh2Aeco5WaRBX
	 wwW7UTWmWVv8YX61mnCYisHTuurVYHcYfSqRiC6p84hnobU2SWJLLM3gTU9rJhOPTv
	 eTSmTG/O3Nf0vtPsOebUc39twzofUvPK9yOQf0qcFG2eypduRq0rjtNYhIfsUnSLl0
	 jE/BpNaivlcC6m12VH1Im70Fu3P77nirbs8qsDcBTMJ6Lkd6Q3pcPz0ezSgpCS/A38
	 YNDNMNt1xeYwA==
Date: Fri, 16 Jan 2026 20:09:21 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: raskar.shree97@gmail.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 skhan@linuxfoundation.org, david.hunter.linux@gmail.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/5] iio: proximity: rfd77402: Use kernel helper for
 result polling
Message-ID: <20260116200921.7494025b@jic23-huawei>
In-Reply-To: <aWinTdOD0FHaeqYp@smile.fi.intel.com>
References: <20260115-rfd77402_v5-v5-0-594eb57683e4@gmail.com>
	<20260115-rfd77402_v5-v5-2-594eb57683e4@gmail.com>
	<aWinTdOD0FHaeqYp@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Jan 2026 10:37:33 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Thu, Jan 15, 2026 at 01:57:38PM +0530, Shrikant Raskar via B4 Relay wrote:
> 
> > Replace the manually written polling loop with read_poll_timeout(),
> > the kernel's standard helper for waiting on hardware status.
> > This makes the code easier to read and avoids repeating the same
> > polling code in the driver.  
> 
> Also need to add that you made it as a separate helper as it will be reused in
> the future (or next changes).
> 
> No need to resend just for this, I hope Jonathan can tweak this whilst applying.
> 
I'm trying to cut down on what is left for new revisions as we get near to
the end of the cycle. As such I've applied patches 1 and 2 from this series
to the testing branch of iio.git.  Just send the remaining patches for v6.

Thanks,

Jonathan



