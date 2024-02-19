Return-Path: <linux-iio+bounces-2786-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3148385A7D5
	for <lists+linux-iio@lfdr.de>; Mon, 19 Feb 2024 16:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAF721F24C47
	for <lists+linux-iio@lfdr.de>; Mon, 19 Feb 2024 15:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417033C498;
	Mon, 19 Feb 2024 15:49:54 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E563D38C;
	Mon, 19 Feb 2024 15:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708357794; cv=none; b=hCo4yg1XhX6HBBHhv7Nkp33OQhQa1OjKZHizs+/si8fCJfnRQGcWmuYMQVPJVNX0YkSFHAvs+ZBqYambrB2/hLaPxM+tdkYX5mAUBNz+gEnZKM06yCb2lOtkISCbLNpihILeIVBp86siQqP7OyDYb4J2F9GycycPkBeg6786v4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708357794; c=relaxed/simple;
	bh=x5zOWXxQIf1d7fTrSg+f4glMORlONk1rC2rbp/gkCH0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M6VgDFQMdJOIfors6/gelzD2WcGBVeruqbxvYXt17rBv7fo5xO7T/XHk4kxNgfNpdhH1OIYtgGOmgE2P4WFg28ShmjGByCKrVc+cke+A3/F8yqFNRcLNVqIBEGQUa057kc1o+0hbJPWrcTAtyGd4mzhyjl9whTMt11dSw2AoCcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Tdn2H4SgJz6K9GC;
	Mon, 19 Feb 2024 23:46:15 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id EF516140CF4;
	Mon, 19 Feb 2024 23:49:48 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 19 Feb
 2024 15:49:48 +0000
Date: Mon, 19 Feb 2024 15:49:47 +0000
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
Subject: Re: [PATCH v4 00/15] device property / IIO: Use cleanup.h magic for
 fwnode_handle_put() handling.
Message-ID: <20240219154947.0000681b@Huawei.com>
In-Reply-To: <ZdNAQi6IlMN-quO_@smile.fi.intel.com>
References: <20240217164249.921878-1-jic23@kernel.org>
	<ZdNAQi6IlMN-quO_@smile.fi.intel.com>
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

On Mon, 19 Feb 2024 13:49:22 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Sat, Feb 17, 2024 at 04:42:34PM +0000, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Sorry for the rapid resend, Andy noticed I'd messed up creating the v3 patch
> > set with some updates committed in the wrong patch.
> > 
> > Since v3: The updates to alignment of device_for_each_child_node_scopd() were
> >     in the wrong patch. Move them to patch 4 where they should always
> >     have been. (thanks Andy!)
> > 
> > Since v2: Thanks to Sakari and Andy for reviews.
> > - New first patch moving fwnode_handle_put() into property.h
> > - Tweak alignment in the loop macro
> > - Pick up tags.
> > - scopd -> scoped typo fix in some patch descriptions.
> > 
> > As can be seen by the examples from IIO that follow this can save
> > a reasonable amount of complexity and boiler plate code, often enabling
> > additional cleanups in related code such as use of
> > return dev_err_probe().
> > 
> > Given we are now fairly late in the cycle, I'd expect to take this
> > through the IIO tree and we can make use of it elsewhere next cycle.
> > 
> > Note I don't have the hardware so this is compile tested only.
> > Hence I'd appreciate some Tested-by tags if anyone can poke one of the
> > effected drivers.
> > 
> > Julia Lawal has posted some nice coccinelle magic for the DT equivalents.
> > Referenced from that cover letter.  Similar may help us convert more
> > drivers to use this new approach, but often hand tweaking can take
> > additional advantage of other cleanup.h based magic, or things like
> > return dev_err_probe().
> > https://lore.kernel.org/all/20240211174237.182947-1-jic23@kernel.org/  
> 
> It seems you are got all necessary tags to go.

Light on the driver changes to use it, but seems that we have
reached convergence on the infrastructure.

I'll let it sit until the end of the week though as I want to
get a pull request out anyway before taking this into my tree.


> I commented with some side notes that may be addressed later on.
> Up to you.
Thanks. I'll catch up with those shortly. 

Jonathan

> 


