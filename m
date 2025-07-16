Return-Path: <linux-iio+bounces-21714-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC6FB06FE0
	for <lists+linux-iio@lfdr.de>; Wed, 16 Jul 2025 10:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABBD73A34BD
	for <lists+linux-iio@lfdr.de>; Wed, 16 Jul 2025 08:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B277C28A1C8;
	Wed, 16 Jul 2025 08:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TwwNaPi/"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBCC2C190;
	Wed, 16 Jul 2025 08:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752653223; cv=none; b=cNi49o14NPVJkZK3YTt5m0u0BSIhDGKtsF1SUKCBQQben+tix6s+c8DaKydymtly3ovCS8Klaxfqw8IFb+gx2OosJMeIpGKJJhtmnGkzWNU/8G7g2kDMqypcJeCSwZfETpFnt+Skge2ydawgDe3/JYVj7SgpGsmJPaRr5TVYePY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752653223; c=relaxed/simple;
	bh=DJw9JK/TOdk/9qj+pemHP4UIRhxxYiSVVqha+NcZJLo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e5lnwa5TKQ0ae7sz/ME/ML78yQJ6921LAS+usc5oaeCMQq00dUhtR4/0CI4CpYpAQEf2D9hj9leTan8pu2fa9OxYuJBDV8Cj6qZYWsBJf98m3yzAy/Z78ghQdrqgEiyWzHIhcrVz9YxuOOgKxUpIrDRSTl9RaG1tjDS1Lah0LO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TwwNaPi/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47C01C4CEF0;
	Wed, 16 Jul 2025 08:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752653223;
	bh=DJw9JK/TOdk/9qj+pemHP4UIRhxxYiSVVqha+NcZJLo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TwwNaPi/SjGq451dHcV9931uOE1VtkxArZm85J22lc2lwZ9XgKNdRe6AvWM6wplNV
	 HmffZC7FrrK9oYLzNZJ8DGQC7KabO/MbnYM4sk0hyvubB+CJNcE8frdmO/KyC0UP2w
	 diNLy+S/aPEmPPgwZCVsJMc+LbwdZTyZNSdO2fAkM7t5tnVJt81J7T/QJKjL8iHOwX
	 g/eXthXKtCekxbD9xeUhgtff44ivHuAdztfEknA46+ETXK4syaSrUXsacCl7wgnLhd
	 2Wc10WgcDV8HJHOZQ+WrxX82bX7DIhuUbuE/nUQ4nfOpuJHEeu8r0GIbhevHqQrOU/
	 BeeCArno+WZ0w==
Date: Wed, 16 Jul 2025 09:06:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sean Nyekjaer <sean@geanix.com>
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] iio: imu: inv_icm42600: Avoid configuring if
 already pm_runtime suspended
Message-ID: <20250716090655.0ba30a2a@jic23-huawei>
In-Reply-To: <kcrov3lqigiqzea2eds73ibhix46ovqrqkhodfatqwfmjanxya@l2cla3fkl6ow>
References: <20250709-icm42pmreg-v1-0-3d0e793c99b2@geanix.com>
	<20250709-icm42pmreg-v1-6-3d0e793c99b2@geanix.com>
	<20250713153227.08af0a54@jic23-huawei>
	<kcrov3lqigiqzea2eds73ibhix46ovqrqkhodfatqwfmjanxya@l2cla3fkl6ow>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Jul 2025 10:15:59 +0000
Sean Nyekjaer <sean@geanix.com> wrote:

> On Sun, Jul 13, 2025 at 03:32:27PM +0100, Jonathan Cameron wrote:
> > On Wed, 09 Jul 2025 14:35:14 +0200
> > Sean Nyekjaer <sean@geanix.com> wrote:
> >   
> > > Do as in suspend, skip resume configuration steps if the device is already
> > > pm_runtime suspended. This avoids reconfiguring a device that is already
> > > in the correct low-power state and ensures that pm_runtimeM handles the
> > > power state transitions properly.
> > >
> > > Fixes: 31c24c1e93c3 ("iio: imu: inv_icm42600: add core of new inv_icm42600 driver")
> > > Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> > > ---  
> > 
> > Not really related to what you have here, but this code would really
> > benefit from using guard(mutex)()
> > 
> > Jonathan  
> 
> I have converted most of this driver to use guard(mutex).
> 
> Does it make sense to use guard(mutex) in functions that still relies on
> goto error out? Like...

No - general rule is never combine cleanup.h magic like guard with gotos.

If you do want to use it in cases like this, factor out the stuff
> 
> static int inv_icm42600_temp_read(struct inv_icm42600_state *st, s16 *temp)
> {
> 	struct device *dev = regmap_get_device(st->map);
> 	__be16 *raw;
> 	int ret;
> 
> 	pm_runtime_get_sync(dev);
> 	mutex_lock(&st->lock);
> 

from here

> 	ret = inv_icm42600_set_temp_conf(st, true, NULL);
> 	if (ret)
> 		goto exit;
> 
> 	raw = (__be16 *)&st->buffer[0];
> 	ret = regmap_bulk_read(st->map, INV_ICM42600_REG_TEMP_DATA, raw, sizeof(*raw));
> 	if (ret)
> 		goto exit;
> 
> 	*temp = (s16)be16_to_cpup(raw);
> 	if (*temp == INV_ICM42600_DATA_INVALID)
> 		ret = -EINVAL;
> 

to here as a utility function.  Then can use direct returns in that 
function and there are no gotos to worry about.

> exit:
> 	mutex_unlock(&st->lock);
> 	pm_runtime_mark_last_busy(dev);
> 	pm_runtime_put_autosuspend(dev);
> 
> 	return ret;
> }
> 
> 
> If I use guard_scoped(..) it creates a lot of diff lines...
The only way to use that here and avoid the issue would be with breaks
which is ugly.   If we are going to pay the cost of churn, then
factoring out the guts of the function is much cleaner.

May not be worth bothering though!

Jonathan

> 
> /Sean
> 


