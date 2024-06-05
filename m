Return-Path: <linux-iio+bounces-5833-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 733D58FCEE7
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jun 2024 15:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 116871F26C11
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jun 2024 13:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8734919EEC9;
	Wed,  5 Jun 2024 12:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ILOFt2xD"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3925D194AC3;
	Wed,  5 Jun 2024 12:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717591362; cv=none; b=I8NGvmQ872ezt4+3ZqCqT/4AOk/sdF49yAgeHNmrzqIfVUQL6+frpWA0ZBqJ+QO67M85RmuexjR7L0Tn87DVbJTGF+ojTGYB5dqTzX2FMQ7TyeQasgS+OuApt83L55BObZJG2hXO8mY9MprtS5vrxJdQUsvHd+hHQ5hxA444OTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717591362; c=relaxed/simple;
	bh=JbMspYh1b0RcaRaZ4nSseQoB5VDk9OVF1ggAJwKyX0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DktvWBmas+p+erlFlRKPBAPhJqOzHQb+U3Fh9A4NKf1JT4U29zuTIth9+IvsSlrgdp/uocc9uUvj39h9vy4tSaZdiBEZ4a3oFEKAgbE0IzgTcqmkIZUeWmw2F/vr6c5NLphIUu7k03I8OfM0YBPe66DdJ1EW20A2x3dVIFOJTjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ILOFt2xD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B84BDC3277B;
	Wed,  5 Jun 2024 12:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717591361;
	bh=JbMspYh1b0RcaRaZ4nSseQoB5VDk9OVF1ggAJwKyX0c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ILOFt2xD7wv3XSFL/Cri4khqdWptym7ANOG/4VoOSIU6GYv/imhzyE0nDIi5OcTH7
	 2WKMz29L/Imc4RyomBpYlSaP4T8juOkF1UG1fLQqvZh+51YhLmt8wvwR23q5zRkDvm
	 ifvyHnPzxQOm83q02E4pqABsSGGGRyfSaXytxQBwsjxnjXneCFyCLB+pVL7O1Mq9oW
	 i69CU7n25Dj0vdzbgXbpRvA2V43sh+YXctBOPetZ35qdBvos/5xtRAY+NlYgxfuNDt
	 jvjkEbsmK08r1Cy9zAKQw/BRCcy9a/OQzeba0xiWhyI6mXX8KOMG04Sy6JUs6b5skX
	 DuUN7PQd+W6fA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1sEpyV-000000007jb-1M1P;
	Wed, 05 Jun 2024 14:42:43 +0200
Date: Wed, 5 Jun 2024 14:42:43 +0200
From: Johan Hovold <johan@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-leds@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Pavel Machek <pavel@ucw.cz>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 0/4] lm3533: Remove the outdated drivers
Message-ID: <ZmBdQygUaVzxieH9@hovoldconsulting.com>
References: <20240531170844.1595468-1-andriy.shevchenko@linux.intel.com>
 <ZloFgnKC6S2B_oz0@smile.fi.intel.com>
 <ZloGLmlfHIfWfWV9@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZloGLmlfHIfWfWV9@smile.fi.intel.com>

On Fri, May 31, 2024 at 08:17:34PM +0300, Andy Shevchenko wrote:
> +Cc: Johan (via kernel.org)
> 
> On Fri, May 31, 2024 at 08:14:43PM +0300, Andy Shevchenko wrote:
> > On Fri, May 31, 2024 at 07:56:12PM +0300, Andy Shevchenko wrote:
> > > Driver is quite outdated from the Linux kernel internal APIs
> > > perspective. In particular GPIO code is using legacy calls,
> > > that started being replaced by a new API ca. 2014, i.e. ten
> > > years ago.
> > > 
> > > Suggested-by: Linus Walleij <linus.walleij@linaro.org>
> > 
> > >  drivers/mfd/lm3533-core.c           | 645 -------------------
> > 
> > Oops, still leftovers: one file and Kconfig/Makefile updates...
> > If needed I'll send a v2, but now I leave it to Lee and Johan to decide
> > the destiny of the drivers.

I prefer to keep them as I just mentioned here:

	https://lore.kernel.org/lkml/ZmBcvtLCzllQDWVX@hovoldconsulting.com/

Johan

