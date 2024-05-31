Return-Path: <linux-iio+bounces-5550-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB348D67EE
	for <lists+linux-iio@lfdr.de>; Fri, 31 May 2024 19:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D65291C2289C
	for <lists+linux-iio@lfdr.de>; Fri, 31 May 2024 17:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0664B176ABA;
	Fri, 31 May 2024 17:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xsi4w0Rx"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9CB17622F;
	Fri, 31 May 2024 17:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717175672; cv=none; b=doAvGIscFLCPZEeVdearw7p/tDjbOyRHvqNddfywj7TQgLytZnqGV8GuvbhXxk1ofQoy9yJFi7ktzsDT1AN24hixWObYDmpqShiqmQfNP67YSR+GY8OhcuPH4QkavQvxx7RleNw1lSPyLGjaqyhxFUAq8j8XCyjxer75fQKSwew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717175672; c=relaxed/simple;
	bh=9P1Ir8WKg26GeXuuS3odKkZE/Pc+6MTvdlKOntSYO8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UyKgHX4b/3NaTNA2hg87eXYzpGbPVsIK2I9+nJ4ejiY403XmMD9zCGrwuRHvAFNGAQHmfzP5xZqJzN3Ro+F8yQ1xhfLcNEHvfmcELWMlD/yJvkLXglbo7/2CCzZf0WjiM2I/ESSmGcovWIN5BOwhfhldmOL2ttnNio+cBqqOaPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xsi4w0Rx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D873C116B1;
	Fri, 31 May 2024 17:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717175671;
	bh=9P1Ir8WKg26GeXuuS3odKkZE/Pc+6MTvdlKOntSYO8Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xsi4w0RxX7lrXL3U7qqbWnh+5LB55a7IfV+I3Gvuu4PB/+KEspQ+OX0nwWmekuzRs
	 aX2DYTMu1Iyqww/1bspWawfbEYnu42cYAoPOscFjmcts+CcpYEndq4COQlDVvH5I3d
	 BFkjjRv0FF2W8icBNcGgPIGoaNol1cfmTLk9ji/lbCtAaU9nINEk/8u5BucDTyPOTN
	 /MQzE5iLWTyd2IYND5uRqgNinQ1jGWJPtv9lN3ohKzJhmuVNXRM+YBnMgZrUmNoXce
	 TSFus5h3yNcWvyJVrfxgBwKq6oHnwHg2HRDvqIsfU/TK8mhP7pW+511i+q52DhpyYC
	 M6dwbSnnfdCWQ==
Date: Fri, 31 May 2024 18:14:25 +0100
From: Lee Jones <lee@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, johan@kernel.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-leds@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Pavel Machek <pavel@ucw.cz>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
	Johan Hovold <jhovold@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 0/4] lm3533: Remove the outdated drivers
Message-ID: <20240531171425.GE1204315@google.com>
References: <20240531170844.1595468-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240531170844.1595468-1-andriy.shevchenko@linux.intel.com>

Making sure Johan is aware of this with his new address.

On Fri, 31 May 2024, Andy Shevchenko wrote:

> Driver is quite outdated from the Linux kernel internal APIs
> perspective. In particular GPIO code is using legacy calls,
> that started being replaced by a new API ca. 2014, i.e. ten
> years ago.
> 
> Suggested-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Andy Shevchenko (4):
>   backlight: lm3533_bl: Remove the driver
>   iio: light: lm3533-als: Remove the driver
>   leds: lm3533: Remove the driver
>   mfd: lm3533: Remove the driver
> 
>  drivers/iio/light/Kconfig           |  17 -
>  drivers/iio/light/Makefile          |   1 -
>  drivers/iio/light/lm3533-als.c      | 922 ----------------------------
>  drivers/leds/Kconfig                |  13 -
>  drivers/leds/Makefile               |   1 -
>  drivers/leds/leds-lm3533.c          | 755 -----------------------
>  drivers/mfd/lm3533-core.c           | 645 -------------------
>  drivers/video/backlight/Kconfig     |  11 -
>  drivers/video/backlight/Makefile    |   1 -
>  drivers/video/backlight/lm3533_bl.c | 399 ------------
>  include/linux/mfd/lm3533.h          | 100 ---
>  11 files changed, 2865 deletions(-)
>  delete mode 100644 drivers/iio/light/lm3533-als.c
>  delete mode 100644 drivers/leds/leds-lm3533.c
>  delete mode 100644 drivers/mfd/lm3533-core.c
>  delete mode 100644 drivers/video/backlight/lm3533_bl.c
>  delete mode 100644 include/linux/mfd/lm3533.h
> 
> -- 
> 2.43.0.rc1.1336.g36b5255a03ac
> 

-- 
Lee Jones [李琼斯]

