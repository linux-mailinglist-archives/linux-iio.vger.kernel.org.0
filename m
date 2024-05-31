Return-Path: <linux-iio+bounces-5552-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F9E8D67FA
	for <lists+linux-iio@lfdr.de>; Fri, 31 May 2024 19:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34EFD2813FB
	for <lists+linux-iio@lfdr.de>; Fri, 31 May 2024 17:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B86F176AA4;
	Fri, 31 May 2024 17:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DIdD0yEC"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1175E2E3F2;
	Fri, 31 May 2024 17:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717175753; cv=none; b=sRHyfJvdAB68tjfzCYxUS7KeyUOK+W2lIu6nrpNiMRrFs8sTuZ2ekPPXb4eSrZhl0VF59wqU/OjJoZtsQZ2Xl8BB66pn12LvUzEwRmBwxLlqV7sQ/v4QIH2CXdEDaA7TOg1eYX0ftX7A/81nKcAXzN7O7l71eRXTFCDCjO+qUI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717175753; c=relaxed/simple;
	bh=3mjCUPT3tD5OU5Z66Ty6rCRSMA4D4CBrZRr9Imwi0Nc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g3/mDbpfrvHiThktYkKoKWJ6F9DHhAv407kGpMgOjkl5Ow6PaLjukDkDKRrR/wYRzT6zVLGujbEM7ZAC50ZFtzoko4uyIFUmYThV+k3d95nX9ZdHOoNddNh4lG6kXutvmRNNvBQwQhpSoCy5SjuDayQ2IyR8kle94ULQbN9QLqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DIdD0yEC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 615FEC116B1;
	Fri, 31 May 2024 17:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717175752;
	bh=3mjCUPT3tD5OU5Z66Ty6rCRSMA4D4CBrZRr9Imwi0Nc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DIdD0yEC7VlFOlUUEGHg/j9u5deAMCXLkLKeJRO4eEnoNu2nt7j1sEdFc1jaYb6+5
	 9x90QIiwOOEHbRHVHtn/qPJmeZ0BQAjJppBoxK5NuW9YzJoDH4M7kLbv9H7+4oEFuw
	 IF9E86HOQ/RXocSbOYn9luyDSgHNpqHqaLpPN8apXXwPWS4lfNVldsYl0R+ndfXofq
	 deDtWqGaWphUgUW44+T9iN5tcGx/DvbNRPwpS8MOTwaSaZ7NDaD57JDVuuyiQ6Dr7Q
	 P1aj5awGzUvMvhLYNABuyew65dFZ/IqZcaRDOox+/DJINgC6GTs1xF5xHm3JAXpSbO
	 F2UKgq1IF6ytw==
Date: Fri, 31 May 2024 18:15:46 +0100
From: Lee Jones <lee@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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
Message-ID: <20240531171546.GF1204315@google.com>
References: <20240531170844.1595468-1-andriy.shevchenko@linux.intel.com>
 <ZloFgnKC6S2B_oz0@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZloFgnKC6S2B_oz0@smile.fi.intel.com>

On Fri, 31 May 2024, Andy Shevchenko wrote:

> On Fri, May 31, 2024 at 07:56:12PM +0300, Andy Shevchenko wrote:
> > Driver is quite outdated from the Linux kernel internal APIs
> > perspective. In particular GPIO code is using legacy calls,
> > that started being replaced by a new API ca. 2014, i.e. ten
> > years ago.
> > 
> > Suggested-by: Linus Walleij <linus.walleij@linaro.org>
> 
> >  drivers/mfd/lm3533-core.c           | 645 -------------------
> 
> Oops, still leftovers: one file and Kconfig/Makefile updates...
> If needed I'll send a v2, but now I leave it to Lee and Johan to decide
> the destiny of the drivers.

Let's not rush into it.  Take your time.

-- 
Lee Jones [李琼斯]

