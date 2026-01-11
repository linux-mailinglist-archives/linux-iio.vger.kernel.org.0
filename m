Return-Path: <linux-iio+bounces-27623-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DDAED0F6F9
	for <lists+linux-iio@lfdr.de>; Sun, 11 Jan 2026 17:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E891030486A6
	for <lists+linux-iio@lfdr.de>; Sun, 11 Jan 2026 16:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F2E34B438;
	Sun, 11 Jan 2026 16:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="obDd491e"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8772E34B68F;
	Sun, 11 Jan 2026 16:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768148777; cv=none; b=Y0eexWq75CNOjJFQagCDulHytxzOo4EAOywfoMlnj1f/PT6kng1LK9aQ2Kjy2BcmNjjG6WvZmzYA/hH44u428uRbVBq8mT4ggTKRtjHMbcLR5oLyper2bZ0gTqS3HiFQ8XIzt+9L0EsYB0Nhuglv8je/giZVx1PgQ1j05vRQ0/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768148777; c=relaxed/simple;
	bh=qmMKQkxVkeJFVzLAX8h7+AX6sCs29ojpxeFxWa6tfu0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R5kQ2W03kta4ma7JJjbCS54Rd19JpWiciUH5FHzXN2QXwbLj4sUXG4xNOC3oL1GJwDh1dv+K4iOYw9+ADgMBS3+NfP2doNBdogE18NgA022H5yqmpu/PwNiLLOZHLPiMu8LsUi1KtL0+Aa0Y+RbpU/6gLXqUUh6vfODCbhaaHUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=obDd491e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AEF0C4CEF7;
	Sun, 11 Jan 2026 16:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768148777;
	bh=qmMKQkxVkeJFVzLAX8h7+AX6sCs29ojpxeFxWa6tfu0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=obDd491eBX3gwBCj9Tb7YxnGOxisSMpW5EWVC3VN2hQEy4hUAXq0uptdQamBYPV4q
	 oI0eZxuEnn5cwPtI6B2tQ0Qu3ysXYQyvpery/9xjCHP/7pDp8gUk0k7YRHi6YctyOn
	 IptgmgtSGhkKPQpnGEj60kagPmG8pUe4KxTqUcfDLD3ZSdv65SVm6Or1rwqLkKjdKR
	 ARL6h4oRXU0Dlr8VLNVFPZRkx7CPfWzP0AAjj6Cexz6u9g2slhqh46iUWodsvpZTEU
	 hO7hwSRNwLtpzM9vFKBHeFrIIfBhmUpINYLVNjdNQf4TIcGMjl95N435bZaLM/GFXK
	 ZJi19EF9zsebw==
Date: Sun, 11 Jan 2026 16:26:09 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Francesco Lavra <flavra@baylibre.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: imu: st_lsm6dsx: set FIFO ODR for
 accelerometer and magnetometer only
Message-ID: <20260111162609.14e6fbae@jic23-huawei>
In-Reply-To: <20260111162351.1407115a@jic23-huawei>
References: <20260109181528.154127-1-flavra@baylibre.com>
	<20260109181528.154127-3-flavra@baylibre.com>
	<20260111162351.1407115a@jic23-huawei>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 11 Jan 2026 16:23:51 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Fri,  9 Jan 2026 19:15:27 +0100
> Francesco Lavra <flavra@baylibre.com> wrote:
> 
> > The st_lsm6dsx_set_fifo_odr() function, which is called when enabling and
> > disabling the hardware FIFO, checks the contents of the hw->settings->batch
> > array at index sensor->id, and then sets the current ODR value in sensor
> > registers that depend on whether the register address is set in the above
> > array element. This logic is valid for internal sensors only, i.e. the
> > accelerometer and magnetometer; however, since commit c91c1c844ebd ("iio:
> > imu: st_lsm6dsx: add i2c embedded controller support"), this function is
> > called also when configuring the hardware FIFO for external sensors (i.e.
> > sensors accessed through the sensor hub functionality), which can result in
> > unrelated device registers being written.
> > 
> > Add a check to the beginning of st_lsm6dsx_set_fifo_odr() so that it does
> > not touch any registers unless it is called for internal sensors.
> > 
> > Fixes: c91c1c844ebd ("iio: imu: st_lsm6dsx: add i2c embedded controller support")
> > Signed-off-by: Francesco Lavra <flavra@baylibre.com>
> This seems fine to me. Ideally it would have been first patch in the series
> as this is one we want to backport.  I'll leave it on list little while
> though to see if Lorenzo or anyone else has time to take a look.
> 
One thing...

> Thanks,
> 
> Jonathan
> 
> 
> > ---
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > index 5ac45e6230b5..9db48e835d4f 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> > @@ -225,6 +225,9 @@ static int st_lsm6dsx_set_fifo_odr(struct st_lsm6dsx_sensor *sensor,
> >  	const struct st_lsm6dsx_reg *batch_reg;
> >  	u8 data;
> >  
> > +	/* Only accel and gyro have batch registers. */

It's true we can't use the batch register, but not clear from this comment
that the else path below is inappropriate.  Is it the absence of patch register
or just that the set_fifo_odr is meaningless for other sensors that matters?
I think this comment needs to provide more detail.

> > +	if (sensor->id >= ARRAY_SIZE(hw->settings->batch))
> > +		return 0;
> >  	batch_reg = &hw->settings->batch[sensor->id];
> >  	if (batch_reg->addr) {
> >  		int val;
> 


