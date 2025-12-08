Return-Path: <linux-iio+bounces-26947-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12225CADCFB
	for <lists+linux-iio@lfdr.de>; Mon, 08 Dec 2025 18:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 49E713050355
	for <lists+linux-iio@lfdr.de>; Mon,  8 Dec 2025 17:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E8A28CF50;
	Mon,  8 Dec 2025 17:09:08 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F722B9B7;
	Mon,  8 Dec 2025 17:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765213748; cv=none; b=mSjmJXePKDuefwXefzT3Shm0D1Hf3sS2fOcQkOUKPJ/m9nXCv4PEszgvv2vU3kH4i2L+gW4hu5eIDTfKJbZcrCsQh0OTMrENzUQRHMMAhY+bIMCjnWs906c259aEBvl5nU5YW2kLBKV2Ad+GlYLuz3LBBFqrPpzilLGjLh+x46w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765213748; c=relaxed/simple;
	bh=c+Bei5521HPFX4IkVBFAUg3EfYuweTlLkvT3Z9BwFTA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m/ukqplVwwYPlbV02E8VbEXfBl7G9m+zPdFiJFyQgYkSsB9y2vJImVxB+KkeTMp2mnQe0qpllD97tpeubR/MZrq59Tc3AWJ7kTfis2lcBacG5wJAfKfiLrHdhYYcfCTNNCQPE8bza9wJPIbdDLt+WVapRVqNmg/IOEzWba0gGSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dQ7jq29xDzJ46DZ;
	Tue,  9 Dec 2025 01:08:47 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 4C36340086;
	Tue,  9 Dec 2025 01:09:02 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Mon, 8 Dec
 2025 17:09:01 +0000
Date: Mon, 8 Dec 2025 17:08:59 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: Jonathan Cameron <jic23@kernel.org>, Oleksij Rempel
	<o.rempel@pengutronix.de>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "David
 Jander" <david@protonic.nl>, <kernel@pengutronix.de>,
	<linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Andy Shevchenko <andy@kernel.org>, "David
 Lechner" <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=
	<nuno.sa@analog.com>
Subject: Re: [PATCH v4 2/2] iio: adc: Add TI ADS131M0x ADC driver
Message-ID: <20251208170859.00006f2f@huawei.com>
In-Reply-To: <aTYGvaZk_PzouTRf@smile.fi.intel.com>
References: <20251118141821.907364-1-o.rempel@pengutronix.de>
	<20251118141821.907364-3-o.rempel@pengutronix.de>
	<20251207193313.794ea339@jic23-huawei>
	<aTYGvaZk_PzouTRf@smile.fi.intel.com>
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
 dubpeml100005.china.huawei.com (7.214.146.113)

On Mon, 8 Dec 2025 00:59:09 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Sun, Dec 07, 2025 at 07:33:13PM +0000, Jonathan Cameron wrote:
> > On Tue, 18 Nov 2025 15:18:21 +0100
> > Oleksij Rempel <o.rempel@pengutronix.de> wrote:  
> 
> ...
> 
> > > +	clk = devm_clk_get_enabled(dev, NULL);  
> > 
> > This surprised me, so I went digging.  Anyone know why
> > the stub returns NULL?  Given that the normal function doesn't have
> > that as an allowed return value that seems really odd.
> > 
> > Still, it does, so this code is fine if odd.  
> 
> I believe it has to do something with an optional clocks or so, but OTOH
> I think it's so odd that may be considered as a bug in CCF APIs.

I'd think an optional clock is optional whether or not the generic clock
stuff is built. Hence should use devm_clk_get_optional_enabled()
That one I agree should be stubbed to return NULL (which it is)

Ah well, I don't really care about the answer, just diverted me for
a few mins so I thought I'd comment.

Jonathan

> 
> > > +	if (IS_ERR_OR_NULL(clk)) {
> > > +		if (IS_ERR(clk))
> > > +			ret = PTR_ERR(clk);
> > > +		else
> > > +			ret = -ENODEV;
> > > +
> > > +		return dev_err_probe(dev, ret, "clk get enabled failed\n");
> > > +	}  
> 


