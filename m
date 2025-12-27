Return-Path: <linux-iio+bounces-27362-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B41EFCDFE2B
	for <lists+linux-iio@lfdr.de>; Sat, 27 Dec 2025 16:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 60E03300E3CE
	for <lists+linux-iio@lfdr.de>; Sat, 27 Dec 2025 15:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07A82459D9;
	Sat, 27 Dec 2025 15:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ahOxKyyr"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602AA23E35B
	for <linux-iio@vger.kernel.org>; Sat, 27 Dec 2025 15:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766848052; cv=none; b=ZPgR4zRQsEckSsX8sFnElazb+LIAuuoVagpTKzuUkyFDrSB6FpWdFja+K2p4N5jPq8N73owZ/NMR9vgZi8pJK0OQkkh6oRUHV/2GbCEGaDHuS5bWv0Y4ge+ieqKEdQ1a4RKzCzdSKzIpxAbcVCiRlzxWa1kARf12dRw0dN2HvxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766848052; c=relaxed/simple;
	bh=kc9IfybTpcfy/TQ+Y6ALzGRSWGPLYro2M6GKy3PqXY8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r1M5SmLMZoYrKlsH7TFVnrxjSZjzPBXQpfHDj0hxOkYZRX+VxYwo21Ed6aCwYuk+Q6MVb3B12qpNQqDcU/oeb0KAeSGrA4VoH1Rufe9LIiCqMe7CtZu8AjdyQTVgQ9yJ0mSMSMZM7MPbsBwob3S+TewSZKRrcWYMbzUvZjY5ypQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ahOxKyyr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEFACC4CEF1;
	Sat, 27 Dec 2025 15:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766848051;
	bh=kc9IfybTpcfy/TQ+Y6ALzGRSWGPLYro2M6GKy3PqXY8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ahOxKyyr1p/jBfS5Dkbj0KCC/P2kMS5V0dlMRFp65EzmhY+JYPFHPo4Pneagcr8dd
	 2oJxZhRuVEQtYk7MIGcHbaFItzpoTNdd9HTv7DQImwYj+Dx7AL+Pj9vKQHpllkrifz
	 U2HnPvIxkdCC/pgWwYHzgvdMiN2O2D8VU17Dt6HRkioYXKcufvrTRC5RY76iceCYu8
	 P8GvhunzbKVpIeQPuRzHo45V2fuPp72Zhfp6LGQsZoMwdmTP82ZJ3Qg+33QffHD/eV
	 dLHuHUSWFR99hv2iFi0AnK11ciP2yw5N/rk4uokyhfAQPSphBML/9O4VA/D7Wolv7k
	 dhVngKLL0H9eQ==
Date: Sat, 27 Dec 2025 15:07:24 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: Peter Rosin <peda@axentia.se>, linux-iio@vger.kernel.org, Guenter Roeck
 <linux@roeck-us.net>
Subject: Re: [PATCH] iio: core: add separate lockdep class for
 info_exist_lock
Message-ID: <20251227150724.08e17cc3@jic23-huawei>
In-Reply-To: <875x9yucdh.fsf@prevas.dk>
References: <20251215131723.4130826-1-ravi@prevas.dk>
	<78de7c11-5724-c3ba-4a32-0dd0f8b4d74f@axentia.se>
	<20251221190645.5d5d1b32@jic23-huawei>
	<875x9yucdh.fsf@prevas.dk>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Dec 2025 09:52:42 +0100
Rasmus Villemoes <ravi@prevas.dk> wrote:

> On Sun, Dec 21 2025, Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > On Mon, 15 Dec 2025 14:33:38 +0100
> > Peter Rosin <peda@axentia.se> wrote:
> >  
> >> Hi!
> >> 
> >> 2025-12-15 at 14:17, Rasmus Villemoes wrote:  
> >> > When one iio device is a consumer of another, it is possible that
> >> > the ->info_exist_lock of both ends up being taken when reading the
> >> > value of the consumer device.
> >> > 
> >> > Since they currently belong to the same lockdep class (being
> >> > initialized in a single location with mutex_init()), that results in a
> >> > lockdep warning    
> >> 
> >> ...
> >>   
> >> > Just as the mlock_key already has its own lockdep class, add a
> >> > lock_class_key for the info_exist mutex.
> >> > 
> >> > Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>    
> >> 
> >> Looks sane from here.
> >> 
> >> Reviewed-by: Peter Rosin <peda@axentia.se>  
> > Hi Rasmus,
> >
> > Thanks for doing this!  
> >>   
> > We should probably merge this as a fix and get it backported.
> > Whilst fairly rare anyone hits this it is also safe enough wrt
> > to very low chance of causing any problems.
> >
> > Would be good to have an appropriate Fixes tag though.
> > Ideally please reply to this thread with an appropriate one.
> > If not I'll try and figure one out, but not today!  
> 
> I tried to find one, but the problem goes way back, probably all the way
> to either the introduction of info_exist_lock or the ability for one iio
> channel to have a dependency on another, whichever came latest. And I'm
> not really very familiar with the iio subsystem, so I couldn't find one
> single commit to name.
> 
> Commit 2bc9cd66eb25d ("iio: Use per-device lockdep class for mlock")
> which introduced the mlock_key referred to 67e17300dc1d76 ("iio:
> potentiostat: add LMP91000 support"), but that feels more like a "this
> driver is what first exposed the problem" and not really "this is where
> the problem was introduced in the iio framework".
> 
> Wrt. backporting, it's probably worth mentioning c76ba4b264442 ("iio:
> core: Replace lockdep_set_class() + mutex_init() by combined call") as a
> prerequisite, as that is needed to make it cherry-pick cleanly.

Thanks for doing the archeology.  I had a dig as well and fairly sure it's.
That references the rules for consumers in the commit message so definitely
seems that all the relevant infrastructure was in there at that point.
Given it's from 2012 we can backport this to all kernels anyone still cares
about.

 ac917a81117c ("staging:iio:core set the iio_dev.info pointer to null on unregister under lock.")

So applied with that fixes tag to the fixes-togreg branch of iio.git.

thanks,

Jonathan


> Rasmus


