Return-Path: <linux-iio+bounces-19854-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF892AC3356
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 11:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB4C23B867A
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 09:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815141DDC1B;
	Sun, 25 May 2025 09:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z0e70Sgl"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356192770B;
	Sun, 25 May 2025 09:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748164805; cv=none; b=j9tn7YOrUpITigZssMjXiVqxHnBrjZEstY94QoOTuutHmXTLoL+iywmTPqSULnyceR2jleM9D1ZsmAqlq8kflyDkTWi90YEucIckssPoQhdFNb9/CxMG+6u7WgQsA6hUVFvHUtH7X8PJ/iHZICzZUkXJVii5MfCJnilaEEDcIyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748164805; c=relaxed/simple;
	bh=M6wNUdl+f/LJKZELy9CIlDDMGL8GGdionU7cG+oIVJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pds/fjAHHN21uwIBm5Dtoe0DOoOnhgRC3Uy/nt2h9V5WvlEOXH1KQNuTgTuIm/iqT+YeUpQft/jvx+RamAE24t1SHbTXAkDdYgp0JD/b6SkciBw0fs7LV3W2RjfMCItUpP9wpAoJf7yvbE7+UIbnblEhz01OaSlYsXeyoEngHpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z0e70Sgl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEB1AC4CEEA;
	Sun, 25 May 2025 09:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748164804;
	bh=M6wNUdl+f/LJKZELy9CIlDDMGL8GGdionU7cG+oIVJQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Z0e70SglbUOUYIUwGE9EvW/JcY14JljkXPcrXvRwOWMfKnOoZdPxFBk8x8EpFANPI
	 vG1u78itnbNpPvqJV9za7eDRQY7XiGc2O7R63dkSTog6u6Uhs9V0ueAnnn3xAPPb5N
	 NwgpL7Hr54FI18ZatUXKTjIXNlibhMXTDRag936yRj1pELwLfCoJnG4HDYHId6DCex
	 74tRpY6EUPIkdT8JgYWiDgVG4pfAUzLo+J6CpUlIxjEgTttC2+uVcp+CRt0A56C/PS
	 4Dw7oQHewMIHBpcl9NpvXPNpOrRqIeUMG/Kt/haznyrvxckVqMqHM4XmaH8IuvBeSY
	 SF/KBNh4I7ppw==
Date: Sun, 25 May 2025 10:19:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Markus Burri <markus.burri@mt.com>
Cc: linux-kernel@vger.kernel.org, Mahesh J Salgaonkar
 <mahesh@linux.ibm.com>, "Oliver O'Halloran" <oohall@gmail.com>, Madhavan
 Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, Jacek
 Lawrynowicz <jacek.lawrynowicz@linux.intel.com>, Maciej Falkowski
 <maciej.falkowski@linux.intel.com>, Oded Gabbay <ogabbay@kernel.org>, Linus
 Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
 Nuno Sa <nuno.sa@analog.com>, Olivier Moysan <olivier.moysan@foss.st.com>,
 Lars-Peter Clausen <lars@metafoo.de>, linuxppc-dev@lists.ozlabs.org,
 dri-devel@lists.freedesktop.org, linux-gpio@vger.kernel.org,
 linux-iio@vger.kernel.org, Markus Burri <markus.burri@bbv.ch>
Subject: Re: [PATCH v4 1/6] iio: backend: fix out-of-bound write
Message-ID: <20250525101953.7930a410@jic23-huawei>
In-Reply-To: <20250511152707.294bc7b9@jic23-huawei>
References: <20250508130612.82270-1-markus.burri@mt.com>
	<20250508130612.82270-2-markus.burri@mt.com>
	<20250511152707.294bc7b9@jic23-huawei>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 11 May 2025 15:27:07 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Thu,  8 May 2025 15:06:07 +0200
> Markus Burri <markus.burri@mt.com> wrote:
> 
> > The buffer is set to 80 character. If a caller write more characters,
> > count is truncated to the max available space in "simple_write_to_buffer".
> > But afterwards a string terminator is written to the buffer at offset count
> > without boundary check. The zero termination is written OUT-OF-BOUND.
> > 
> > Add a check that the given buffer is smaller then the buffer to prevent.
> > 
> > Fixes: 035b4989211d ("iio: backend: make sure to NULL terminate stack buffer")
> > Signed-off-by: Markus Burri <markus.burri@mt.com>  
> I'm looking for a tag from Nuno on this one before applying.

Please make sure to pick up tags on earlier versions. Nuno had sent a RB for
this one which I've now added.

People don't tend to look again at patches that they've already tagged so Nuno
probably didn't see my ask for a tag above.

Anyhow, now applied but will have to wait for a rebase of my fixes-togreg tree
on rc1 once available.

Thanks,

Jonathan

> 
> J
> > ---
> >  drivers/iio/industrialio-backend.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
> > index a43c8d1bb3d0..31fe793e345e 100644
> > --- a/drivers/iio/industrialio-backend.c
> > +++ b/drivers/iio/industrialio-backend.c
> > @@ -155,11 +155,14 @@ static ssize_t iio_backend_debugfs_write_reg(struct file *file,
> >  	ssize_t rc;
> >  	int ret;
> >  
> > +	if (count >= sizeof(buf))
> > +		return -ENOSPC;
> > +
> >  	rc = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, userbuf, count);
> >  	if (rc < 0)
> >  		return rc;
> >  
> > -	buf[count] = '\0';
> > +	buf[rc] = '\0';
> >  
> >  	ret = sscanf(buf, "%i %i", &back->cached_reg_addr, &val);
> >    
> 
> 


