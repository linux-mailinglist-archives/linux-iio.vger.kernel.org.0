Return-Path: <linux-iio+bounces-28048-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C0649D3C48F
	for <lists+linux-iio@lfdr.de>; Tue, 20 Jan 2026 11:06:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C2438547B73
	for <lists+linux-iio@lfdr.de>; Tue, 20 Jan 2026 09:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38843A89A7;
	Tue, 20 Jan 2026 09:50:50 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B582AD35
	for <linux-iio@vger.kernel.org>; Tue, 20 Jan 2026 09:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768902650; cv=none; b=cUkZlc6U1OS3uFeVUwu5BVHzyn9GSMw1jYLYylNuh2vesegeE2BYR2wtYaX+ddyu2SxBaUdqgPgGYV2V/5Mk/UlBa3KIjr2QUI+PCd4WCajCQ3i7pYhnEdUYHKQV6zJ6Gx0xH/X7EaWAKpC0rRJtSE/eGtfk74vjCRQCfQbxEs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768902650; c=relaxed/simple;
	bh=ZA0s/tuoPW1D6wPLszUGgUM7+dx8qfSGeQ7YYwW5zJU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FwS5MGM1A+1uZ0FHkp3mOfURuJkyBnOniMtGBsHeNNSzrFxYVdtaAYiY0LHiF6NT7rMcR0CDHASw+MSA0WTOB9G0/vvNdQ4Qw3PwFr1yGkdEPnxB8eQ/LnKxGXAOyABSxV3ozRyVvU6VEGHv5NL+qCH4CfwIMybSJ8s/9Rzht2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dwMxx4GHPzHnGd6;
	Tue, 20 Jan 2026 17:50:13 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 1F19540569;
	Tue, 20 Jan 2026 17:50:45 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 20 Jan
 2026 09:50:44 +0000
Date: Tue, 20 Jan 2026 09:50:41 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>, "Andy
 Shevchenko" <andy@kernel.org>, Sasha Levin <sashal@kernel.org>, "David
 Lechner" <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=
	<nuno.sa@analog.com>, <jorge.marques@analog.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH] iio: adc: ad4062: Switch from struct i3c_priv_xfer to
 struct i3c_xfer
Message-ID: <20260120095041.0000705f@huawei.com>
In-Reply-To: <aW8sk9mD-dOHeJZg@smile.fi.intel.com>
References: <20260119213617.745603-1-jic23@kernel.org>
	<aW8sk9mD-dOHeJZg@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Tue, 20 Jan 2026 09:19:47 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, Jan 19, 2026 at 09:36:17PM +0000, Jonathan Cameron wrote:
> 
> > commit 9904232ae30bc ("i3c: drop i3c_priv_xfer and i3c_device_do_priv_xfers()")  
> 
> Commit ?
> The commit ?
> 
> > currently in the i3c/for-next tree removes the deprecated
> > struct i3c_priv_xfer and i3c_device_do_priv_xfers().
> > 
> > Switch to struct i3c_xfer and i3c_device_do_xfers(..., I3C_SDR)
> > now rather causing a build issue when both trees are merged.  
> 
> Not sure if we need a Fixes tag.

I was lazy. Both this and the original patch will go in together
so low risk, but indeed it should have a fixes tag.

> 
> > Suggested-by: Sasha Levin <sashal@kernel.org>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>  
> 
> > Cc: jorge.marques@analog.com  
> 
> Can we move this to be after the '---' cutter line?

When I really want someone to review / test I tend to put them above the ---
so that I remember to poke them if they don't and I want them to be
included in any follow on threads. 

More FYI type +CC below the line. Mostly I just add them to the send
list however rather than having a Cc at all.

> 
> > ---
> > I'm already carrying this on my tree to resolve the issue in next
> > but feedback still welcome!  
> 
> The rest is fine to me.
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Thanks for the quick response!

J
> 


