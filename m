Return-Path: <linux-iio+bounces-21987-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D445B10E83
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 17:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A8D85A7CC2
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 15:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC642E9EA7;
	Thu, 24 Jul 2025 15:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k8DTsl4I"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891692797B1;
	Thu, 24 Jul 2025 15:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753370554; cv=none; b=uGmUole4L0MqJlKCr1eK8qJxIuPiMpXnPnsbHQERXHXMo0JmzcVeMvxrhbi4MAk0GTJIMasHu6InjimcDRn6DJ2y18Z24G1ZL8ITv2klj2H1pLq5BC/JiSJ5TYmvKyZXYb7HBrRD4zCBzjbz3y9hWWaTsTBQo444WzRTEy4C5x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753370554; c=relaxed/simple;
	bh=kCc9+bv8prY7vXYH1dhbb3wufC7xyXoXKhvFlF8VvVw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KllgbuKJTzhMHkniU5Ux4hrSH7yzrO3pm5aCK3SzjlubIMg7hG3hK0mHnXGe+qlpT+PW3QILd0r2DAPHLrw56JvNef7GdglOxbFu/fRKaMSytP7OMdANbOxDO/Z69ZvGw1HLTlmPD8UbGXx1xgppRV9ooPm5Ragx84fRA4tJZcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k8DTsl4I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49462C4CEED;
	Thu, 24 Jul 2025 15:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753370554;
	bh=kCc9+bv8prY7vXYH1dhbb3wufC7xyXoXKhvFlF8VvVw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=k8DTsl4I23MMfQo4NKAPI7MSebhFYaBPGUp9Fp6hiCUBwsm5rVp+uqQQ5I3iDgKLI
	 Wptoq50sRQQ+l2iM0Wb4CFi9oiq8oBCsmLOezRDj/W8mmz70LyK2Bf6smqKEiyMLBD
	 mbif1CdT0MFEZygdIJcU9mtqRutHaT8xEpOqGW5sKPkiqS/7ICk5/DiccmJqXoen/1
	 zU2sVZeCIJIT/C7QOLtCMnwbMAQjbbAqKSntFAnndsOqqa6MLQoOTe8YKHs4w/fmTr
	 Ou49Rw7TPRdXeKEIeklvscOVLhkKQZWiMQNz/7OvK8OXqENkNIViOO+4Y47QV3/PBD
	 UhwA+4QayPoKg==
Date: Thu, 24 Jul 2025 16:22:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Gustavo Silva <gustavograzs@gmail.com>, Alex Lanzano
 <lanzano.alex@gmail.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Lothar Rubusch
 <l.rubusch@gmail.com>
Subject: Re: [PATCH v4 3/3] iio: imu: bmi270: add support for motion events
Message-ID: <20250724162227.065d20a0@jic23-huawei>
In-Reply-To: <aHd2s987EMCdgdrJ@smile.fi.intel.com>
References: <20250711-bmi270-events-v4-0-53ec7da35046@gmail.com>
	<20250711-bmi270-events-v4-3-53ec7da35046@gmail.com>
	<aHYFMf8QGDNt-5Nf@smile.fi.intel.com>
	<aHYIBReTFqJMtiXW@smile.fi.intel.com>
	<vlpqd3jeszhgpcob7qyzp5vljdowwu26my7xuwuvfftf54zg35@czxhsjejgdkm>
	<aHd2s987EMCdgdrJ@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Jul 2025 12:53:55 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, Jul 15, 2025 at 08:55:35PM -0300, Gustavo Silva wrote:
> > On Tue, Jul 15, 2025 at 10:49:25AM +0300, Andy Shevchenko wrote:  
> > > On Tue, Jul 15, 2025 at 10:37:22AM +0300, Andy Shevchenko wrote:  
> > > > On Fri, Jul 11, 2025 at 08:36:03PM -0300, Gustavo Silva wrote:  
> 
> ...
> 
> > > > > +/* 9.81 * 1000000 m/s^2 */
> > > > > +#define BMI270_G_MEGA_M_S_2				9810000  
> > > > 
> > > > I thought this is MICRO...  
> > > 
> > > Btw, what if we use the device on poles and on equator (or even on orbital
> > > station)? I'm wondering if this constant should be defined in units.h or
> > > even in uAPI that user space may add a correction if needed.
> > >   
> > I certainly hadn't thought about these scenarios.
> > FWIW, the accelerometer scale values also assume g = 9.81 m/s^2.
> > For example, 0.000598 = 2 * 9.81 / 32768  
> 
> Right, but this should be supplied to user space somehow. OTOH the measure error
> may be high enough (what is the precision of the measurements by the way?) that
> it will neglect the differences in the 'g' constant.
> 
> All the details are given in [1].
> 
> [1]: https://en.wikipedia.org/wiki/Gravity_of_Earth#:~:text=The%20precise%20strength%20of%20Earth's,/s2)%20by%20definition.
> 

These sensors don't measure relative to g.
That's annoying marketing which is why I held firm for m/s^2 for IIO :)
So what they measure for a given acceleration does not change depending
on where we are on earth. You should use a 'fixed' standard value for
conversion from marketing values in g to m/s^2..

Or maybe I'm missing something!

Jonathan
  

