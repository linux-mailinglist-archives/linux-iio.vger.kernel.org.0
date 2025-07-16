Return-Path: <linux-iio+bounces-21713-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB8EB06FCF
	for <lists+linux-iio@lfdr.de>; Wed, 16 Jul 2025 10:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1D433BD407
	for <lists+linux-iio@lfdr.de>; Wed, 16 Jul 2025 07:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93F128A402;
	Wed, 16 Jul 2025 08:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D49RgNBN"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712272248B5;
	Wed, 16 Jul 2025 08:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752652818; cv=none; b=QPkgG1DlF2EaVe03zfEqmTTpq4SAxP5FdtW3u385shVXJOk7Ianrx03bQtqpzww9W2nOXQ0IiL0ZS+PiwNGu3Vozfeva0Gl4xixVn851vNSALqd6SvER2DrZkyNlJQUoD6FkqITwD38FAJThUZqDrtal0437KFjWPbPBw0v5AdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752652818; c=relaxed/simple;
	bh=0koS8Yh1ZLnXHxawKMVn2VSN1pxeO71n+2+XgnmHYqs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nHafDHbyiH9AO5fYESN4O5NYBKLaQ2Tm39GREqiH1po2Mk4nmCilbbFgrSj+GTo8QNFkl0C8KaAA/5Wd66Tn5sodL44jBetSKiarevUa/fKUYpuJFfm1DFHYdjfP/Swg/ocODcpF09CVF9Wb5Yuy6TVaF9sbqSBK7MVyOgZ/ytM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D49RgNBN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F00A4C4CEF0;
	Wed, 16 Jul 2025 08:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752652818;
	bh=0koS8Yh1ZLnXHxawKMVn2VSN1pxeO71n+2+XgnmHYqs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D49RgNBN721ba7eK2SxqPg1VLqIOXzxpfCnTsjF2cpq5Qre774aDYQqj457NX0mfu
	 SfXx+FruxPMrL4TchSNemAPt9e1W3YlzEbfrtNAGxo9bMJrVdbvZLNrd3HA0lyvk7M
	 hJ/JRyZ7IvhCU15aL3r2QA74WCqjPb2XkQTr8EMPgUpsmxkGU03LKmb3/5ZG2Y27X3
	 ASMrd6yZT+blM3I3Qsid7d2s7mXLBpGPTgc3R+yrdvv0AYT9/H9oO+IjIPTIyvw2WI
	 tVRlQr4y925EzRfOnf4otJWhPtwY8lmAM0H/XcLDP1BYFubLVeXWag/Ak8AvxkTYWy
	 vt0PwBcgukWnA==
Date: Wed, 16 Jul 2025 09:00:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sean Nyekjaer <sean@geanix.com>
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] iio: imu: inv_icm42600: Simplify pm_runtime setup
Message-ID: <20250716090010.23ea03b6@jic23-huawei>
In-Reply-To: <76fnxeuufv56fmfvq6odi5xz2yjtjxymz24t436zk7rtuyst4s@oihlvsoxhllp>
References: <20250709-icm42pmreg-v1-0-3d0e793c99b2@geanix.com>
	<20250709-icm42pmreg-v1-4-3d0e793c99b2@geanix.com>
	<20250713152810.4483c786@jic23-huawei>
	<ie3zr2mvuss2f7prksw6nuc3wonig5ju6y6hqq46upvkhovwpa@vtfc3tqwz3d5>
	<76fnxeuufv56fmfvq6odi5xz2yjtjxymz24t436zk7rtuyst4s@oihlvsoxhllp>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Jul 2025 07:42:43 +0000
Sean Nyekjaer <sean@geanix.com> wrote:

> On Mon, Jul 14, 2025 at 07:24:57AM +0100, Sean Nyekjaer wrote:
> > On Sun, Jul 13, 2025 at 03:28:10PM +0100, Jonathan Cameron wrote:  
> > > On Wed, 09 Jul 2025 14:35:12 +0200
> > > Sean Nyekjaer <sean@geanix.com> wrote:
> > >   
> > > > Remove unnecessary pm_runtime_get_noresume() and pm_runtime_put()
> > > > calls during probe. These are not required when the device is marked
> > > > active via pm_runtime_set_active() before enabling pm_runtime with
> > > > pm_runtime_enable().
> > > >
> > > > Also remove the redundant pm_runtime_put_sync() call from the cleanup
> > > > path, since the core is not incrementing the usage count beforehand.
> > > >
> > > > This simplifies the PM setup and avoids manipulating the usage counter
> > > > unnecessarily.  
> > > 
> > > Could we switch directly to using devm_pm_runtime_enable() for this driver?
> > > 
> > > At first glance looks like this code is missing the disable of autosuspend
> > > that should be there (which devm_pm_runtime_enable() will also handle).
> > >   
> > 
> > I have tried to use devm_pm_runtime_enable() but on rmmod it warns
> > "unbalanced disables for regulator"
> > 
> > If I remove this:
> > -	ret = devm_add_action_or_reset(dev, inv_icm42600_disable_vddio_reg, st);
> > -	if (ret)
> > -		return ret;
> > 
> > Everything seems okay again. I have checked with printk's that
> > inv_icm42600_disable_vddio_reg() is called twice with
> > devm_pm_runtime_enable() used.
> > Does it make sense?
> > 
> > /Sean  
> 
> with pm_runtime_enable():
> root@v4:/data/root# insmod /tmp/inv-icm42600.ko; insmod /tmp/inv-icm42600-i2c.ko
> [ 3793.713077] inv-icm42600-i2c 1-0068: no INT1 interrupt defined, fallback to first interrupt
> [ 3793.727728] inv-icm42600-i2c 1-0068: mounting matrix not found: using identity...
> [ 3793.737660] inv-icm42600-i2c 1-0068: supply vdd not found, using dummy regulator
> [ 3793.856891] inv-icm42600-i2c 1-0068: supply vddio not found, using dummy regulator
> [ 3793.866872] inv_icm42600_enable_regulator_vddio() enable vddio
> [ 3793.920739] inv_icm42600_runtime_suspend() disable vddio
> root@v4:/data/root# rmmod inv_icm42600_i2c inv_icm42600
> [ 3796.954850] inv_icm42600_runtime_resume() -> inv_icm42600_enable_regulator_vddio()
> [ 3796.954910] inv_icm42600_enable_regulator_vddio() enable vddio
> [ 3796.985140] inv_icm42600_disable_vddio_reg() disable vddio
> 
> with devm_pm_runtime_enable():
> root@v4:/data/root# insmod /tmp/inv-icm42600.ko; insmod /tmp/inv-icm42600-i2c.ko
> [ 3852.873887] inv-icm42600-i2c 1-0068: no INT1 interrupt defined, fallback to first interrupt
> [ 3852.888715] inv-icm42600-i2c 1-0068: mounting matrix not found: using identity...
> [ 3852.898514] inv-icm42600-i2c 1-0068: supply vdd not found, using dummy regulator
> [ 3853.016890] inv-icm42600-i2c 1-0068: supply vddio not found, using dummy regulator
> [ 3853.026860] inv_icm42600_enable_regulator_vddio() enable vddio
> [ 3853.080835] inv_icm42600_runtime_suspend() disable vddio
> root@v4:/data/root# rmmod inv_icm42600_i2c inv_icm42600
> [ 3854.448461] inv_icm42600_runtime_resume() -> inv_icm42600_enable_regulator_vddio()
> [ 3854.448540] inv_icm42600_enable_regulator_vddio() enable vddio
> [ 3854.467061] inv_icm42600_runtime_suspend() disable vddio

As below What is the call path for this final suspend?
Is it coming from update_autosuspend()?

> [ 3854.477170] inv_icm42600_disable_vddio_reg() disable vddio
> [ 3854.483835] ------------[ cut here ]------------
> [ 3854.483912] WARNING: CPU: 0 PID: 582 at drivers/regulator/core.c:3016 _regulator_disable+0x140/0x1a0
> [ 3854.497853] unbalanced disables for regulator
> 
> Is the way from here to remove the devm_add_action_or_reset(dev,
> inv_icm42600_disable_vddio_reg... ?

That will make a mess if runtime PM is not built into
the kernel which is why an PM state in remove should return to the state
before it was enabled in the first place (i.e. on!).
That final runtime suspend surprises me.

> 
> /Sean
> 


