Return-Path: <linux-iio+bounces-27292-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 049E0CD4477
	for <lists+linux-iio@lfdr.de>; Sun, 21 Dec 2025 20:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AAF9A3000932
	for <lists+linux-iio@lfdr.de>; Sun, 21 Dec 2025 19:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F710233D88;
	Sun, 21 Dec 2025 19:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KA9ecCRN"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E278C1E32CF
	for <linux-iio@vger.kernel.org>; Sun, 21 Dec 2025 19:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766344014; cv=none; b=Fdb2Qt9WKpKhzIEXefceCPTFTKP1zPFt+LpFObKk941TyH1uwdWkrVmmKpMD5YoGtK3y1c+SvPzEfqq67pEeGl/VOy/8PBefHHetFkzn4GrDzduNPF8F4Pc93YkL6bnAM5TNEZlBbuGNBrEIzPnrNlEy9XmVnaeDVvtBxXDOjjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766344014; c=relaxed/simple;
	bh=mYwUWc9vMRWfPmYq7p9fl4BhYW13g9F+MtyNe45Xnp8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N3TvoyJDXQoXoihys71r0Yze+f8tF43jF7TyAG5itCZ0woblq/zmReMf7vs+A7Af6bxu10WGCdURi+wvDWgyySEbtVCxb/MP+wLuvPQREUKQN/k5dFS6dw9fnbLgQBVg/KgaI0URq/1rBqw9bIoLDyCwB80DP4qASZ19vv0fWRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KA9ecCRN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AA47C4CEFB;
	Sun, 21 Dec 2025 19:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766344013;
	bh=mYwUWc9vMRWfPmYq7p9fl4BhYW13g9F+MtyNe45Xnp8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KA9ecCRNA0UCLxbhCglSxv6nayvCz6w3oxjnRUropQiufObVJsM08g3mjCUu6IlxU
	 dQVUFqs1Ecd6GmRauhCjHWFsvdRGpbmgQRiEQkszcn/+iSxZR78yGPFOSTraB3dlyP
	 IpfPwNd5I4Voe8nBlPmJ3mIHMcNxubPOokGrWPqxoXcuuEv/XH8/0yKU2rD8Umo2z/
	 qaiMRIrzrcnmXNuzmMKi+PBDDxb7JeVTkLu7QP7X6gqHDW/aK3TcJ9xaWalCNF6qqc
	 vn9JJaOUoKFoABw46jadkVFAH+d77s3dNNpf7oBHY07oQCBrhf++nX7ZqBMj9JAnEQ
	 oMMyZi0jTInow==
Date: Sun, 21 Dec 2025 19:06:45 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Peter Rosin <peda@axentia.se>
Cc: Rasmus Villemoes <ravi@prevas.dk>, linux-iio@vger.kernel.org, Guenter
 Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] iio: core: add separate lockdep class for
 info_exist_lock
Message-ID: <20251221190645.5d5d1b32@jic23-huawei>
In-Reply-To: <78de7c11-5724-c3ba-4a32-0dd0f8b4d74f@axentia.se>
References: <20251215131723.4130826-1-ravi@prevas.dk>
	<78de7c11-5724-c3ba-4a32-0dd0f8b4d74f@axentia.se>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Dec 2025 14:33:38 +0100
Peter Rosin <peda@axentia.se> wrote:

> Hi!
> 
> 2025-12-15 at 14:17, Rasmus Villemoes wrote:
> > When one iio device is a consumer of another, it is possible that
> > the ->info_exist_lock of both ends up being taken when reading the
> > value of the consumer device.
> > 
> > Since they currently belong to the same lockdep class (being
> > initialized in a single location with mutex_init()), that results in a
> > lockdep warning  
> 
> ...
> 
> > Just as the mlock_key already has its own lockdep class, add a
> > lock_class_key for the info_exist mutex.
> > 
> > Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>  
> 
> Looks sane from here.
> 
> Reviewed-by: Peter Rosin <peda@axentia.se>
Hi Rasmus,

Thanks for doing this!
> 
We should probably merge this as a fix and get it backported.
Whilst fairly rare anyone hits this it is also safe enough wrt
to very low chance of causing any problems.

Would be good to have an appropriate Fixes tag though.
Ideally please reply to this thread with an appropriate one.
If not I'll try and figure one out, but not today!

Jonathan

> Cheers,
> Peter


