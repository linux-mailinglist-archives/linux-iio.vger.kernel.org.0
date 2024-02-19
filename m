Return-Path: <linux-iio+bounces-2784-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4BDC85A7CA
	for <lists+linux-iio@lfdr.de>; Mon, 19 Feb 2024 16:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E2FD1F24B7A
	for <lists+linux-iio@lfdr.de>; Mon, 19 Feb 2024 15:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06CAD3A1DE;
	Mon, 19 Feb 2024 15:48:54 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E6438F98;
	Mon, 19 Feb 2024 15:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708357733; cv=none; b=P6pEv9wzNTliGvvC4DqAobfHwmAgo/LQFyf5faYAlr+CEFKq8+O03FSw2eCRpGmcnQw3v2r8SwGEEuA06CM6PsnbnNy5yXHUHLxnjw5ZfbFa3rwFhqe4uYKiNmTyjKa7k/nyTCy/4hFskwF7nQDf8hp1wh7nXxn4yOL0togt0rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708357733; c=relaxed/simple;
	bh=XYt0KCPQSIFD2il940K9Gg+UtvhcLhhiYufRfiYQ3Vs=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DRDBQrLFGYZqHhbfBrCxiMARtmnMMOSjAD+bBgbjbw5vBYE7w79E3oAztknvONpFWy/bAJmpUHgd1viPqUkGmZLwUHGcpwFpN5byUUW7pwypmhpOrgCDLkZuJz2VmlKQCDm3UXxkzlDSFZzRMNxrra9G8TVXLK/nf8JfZyIOy5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Tdn0g0Dh2z689vq;
	Mon, 19 Feb 2024 23:44:51 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id CEE94140B38;
	Mon, 19 Feb 2024 23:48:47 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 19 Feb
 2024 15:48:47 +0000
Date: Mon, 19 Feb 2024 15:48:46 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>, "Rafael
 J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	<linux-acpi@vger.kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Daniel Scally <djrscally@gmail.com>, "Heikki
 Krogerus" <heikki.krogerus@linux.intel.com>, Sakari Ailus
	<sakari.ailus@linux.intel.com>, Julia Lawall <Julia.Lawall@inria.fr>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Cosmin Tanislav
	<cosmin.tanislav@analog.com>, Mihail Chindris <mihail.chindris@analog.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Tomislav Denis
	<tomislav.denis@avl.com>, Marek Vasut <marex@denx.de>, Olivier Moysan
	<olivier.moysan@foss.st.com>, Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>, Marijn Suijten
	<marijn.suijten@somainline.org>, Marius Cristea
	<marius.cristea@microchip.com>, Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4 15/15] iio: dac: ltc2688: Use
 device_for_each_child_node_scoped()
Message-ID: <20240219154846.000049e9@Huawei.com>
In-Reply-To: <ZdNACyMUH6Lk749H@smile.fi.intel.com>
References: <20240217164249.921878-1-jic23@kernel.org>
	<20240217164249.921878-16-jic23@kernel.org>
	<ZdNACyMUH6Lk749H@smile.fi.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 19 Feb 2024 13:48:27 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Sat, Feb 17, 2024 at 04:42:49PM +0000, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Switching to the _scoped() version removes the need for manual
> > calling of fwnode_handle_put() in the paths where the code
> > exits the loop early. In this case that's all in error paths.  
> 
> ...
> 
> >  			span = ltc2688_span_lookup(st, (int)tmp[0] / 1000,
> >  						   tmp[1] / 1000);
> > -			if (span < 0) {
> > -				fwnode_handle_put(child);
> > +			if (span < 0)
> >  				return dev_err_probe(dev, -EINVAL,
> >  						     "output range not valid:[%d %d]\n",
> >  						     tmp[0], tmp[1]);  
> 
> Last minute observation, should not we return span instead of -EINVAL?
> (Haven't checked the semantics of the former though.)
It returns 0 or -EINVAL, so yes we should use span here.

> 
> ...
> 
> > +		if (ret)
> >  			return dev_err_probe(dev, -EINVAL,
> >  					     "failed to set chan settings\n");  
> 
> Ditto.

Definitely on that one. 

I'll aim to fold those two in whilst picking this up with a note in the patch description.
(or I'll incorporate them if I do a v5 for other reasons!)

Thanks,

Jonathan

> 
> 


