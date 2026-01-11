Return-Path: <linux-iio+bounces-27629-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E73D0FAB0
	for <lists+linux-iio@lfdr.de>; Sun, 11 Jan 2026 20:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 611D63063F75
	for <lists+linux-iio@lfdr.de>; Sun, 11 Jan 2026 19:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF3E352C51;
	Sun, 11 Jan 2026 19:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UVOtdJbt"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB802D193F;
	Sun, 11 Jan 2026 19:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768160359; cv=none; b=BbvfKzlYPz5gv5yaY6MIZ2vCzO+pRdelwSFDCaRxs16YdmMtF2xkcqg3Kn5yCdsFhiJVhjZTnWIMzPhPlhO8sJ4lnyI0Hw2+iji0yXEBoA5oT3UPgc66MNhDQT7uBuGP1mbKhewA6Ob8De5Dql2SE7ofKwfK87+qfYcceqB2TYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768160359; c=relaxed/simple;
	bh=u2UHmpomSDwkDRiVG2IhuRUJsYu9wG1KoGO4PusAsZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uCCJcjFbE4qLXWloUkSnJPio50axI4wMOeUfhA8c1HyDbes+RCWs7NN48ZxIF9NFnokPfMi7dmnR2jVkTL80i7jLlfVMgwip1kWE/3h0LV3ah0bscOFr0wmdIhfhIr3uP7MxwRjB0zDACCIkSVPRcd3W4eYeeiy1yeZZImY5fkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UVOtdJbt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0DEDC116C6;
	Sun, 11 Jan 2026 19:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768160359;
	bh=u2UHmpomSDwkDRiVG2IhuRUJsYu9wG1KoGO4PusAsZ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UVOtdJbt9VaIgBGK21ye4a81FnMTRIxaIqWMCHfdlFRYTCyI+97ZFuHEiNEgEUXGi
	 KZ8lSXQL59NdfzQqRxSgODD48mlVyGKCSRTE5S9Xv1980Mph6mTJrSn/x9nyfxPDAF
	 2kVCaksHHj0OtGExpyosMr1lXrZM1vKuYQJlC0HTRgRbYD8aPAuSmgv/j8a9/KJeWG
	 7gmaRPVVtqKjKcY17Xtt4xEmRNJuNU405XCuHA9TLb2vBmueXh6ZToOBfXn/CSZ3cy
	 nEh8uNYe//myZYDRs31cUfFIWdi0WvMwAazhs77xO4HVeJC6l5RfJdv61X+yPfwEBf
	 UB+1Q/owb35nw==
Date: Sun, 11 Jan 2026 19:39:09 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Francesco Lavra <flavra@baylibre.com>, Lorenzo Bianconi
 <lorenzo@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: imu: st_lsm6dsx: add support for rotation
 sensor
Message-ID: <20260111193909.1166309b@jic23-huawei>
In-Reply-To: <aWFVYefhhVn27vku@smile.fi.intel.com>
References: <20260109181528.154127-1-flavra@baylibre.com>
	<20260109181528.154127-4-flavra@baylibre.com>
	<aWFVYefhhVn27vku@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 9 Jan 2026 21:22:09 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Fri, Jan 09, 2026 at 07:15:28PM +0100, Francesco Lavra wrote:
> > Some IMU chips in the LSM6DSX family have sensor fusion features that
> > combine data from the accelerometer and gyroscope. One of these features
> > generates rotation vector data and makes it available in the hardware
> > FIFO as a quaternion (more specifically, the X, Y and Z components of the
> > quaternion vector, expressed as 16-bit half-precision floating-point
> > numbers).
> > 
> > Add support for a new sensor instance that allows receiving sensor fusion
> > data, by defining a new struct st_lsm6dsx_sf_settings (which contains
> > chip-specific details for the sensor fusion functionality), and adding this
> > struct as a new field in struct st_lsm6dsx_settings. In st_lsm6dsx_core.c,
> > populate this new struct for the LSM6DSV and LSM6DSV16X chips, and add the
> > logic to initialize an additional IIO device if this struct is populated
> > for the hardware type being probed.
> > Note: a new IIO device is being defined (as opposed to adding channels to
> > an existing device) because each of the existing devices handles data
> > coming from a single sensor, while sensor fusion data comes from multiple
> > sensors.
> > 
> > Tested on LSMDSV16X.  
> 
> ...
> 
> > enum st_lsm6dsx_sensor_id {  
> 
> >  	ST_LSM6DSX_ID_EXT0,
> >  	ST_LSM6DSX_ID_EXT1,
> >  	ST_LSM6DSX_ID_EXT2,
> > +	ST_LSM6DSX_ID_SF,
> >  	ST_LSM6DSX_ID_MAX,  
> 
> At some point please either get rid of _ID_MAX, or drop the trailing comma
> (maybe some other places also need the same treatment).
It's already gone, this needs a rebase on the upstream
tree.

Thanks,

Jonathan


