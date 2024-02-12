Return-Path: <linux-iio+bounces-2461-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB90585127F
	for <lists+linux-iio@lfdr.de>; Mon, 12 Feb 2024 12:42:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9777D281186
	for <lists+linux-iio@lfdr.de>; Mon, 12 Feb 2024 11:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B940939859;
	Mon, 12 Feb 2024 11:42:13 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834C33984A;
	Mon, 12 Feb 2024 11:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707738133; cv=none; b=ucuRMRaYfU4y6lj07kdL0LduLdGVcSrouJYGPIKXBnvrZnArtoIpxPN4sa5Ku9sZ4qHhAiLddMh83twrenFdY5fmJ1R8Rf2mA2lAPTp9J2KyRM+b8EL0VUzmlPMzApaV3v00L3pKj9E6hSVm/SImo3VKuOS++o443C4EAnSBWFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707738133; c=relaxed/simple;
	bh=px08+1SkCrrmTZqG/uxsxxzAgxGCz+kRRq4ti0TxZsQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nqQbdWua3gAR5k0HvCsuftwlk0Jrqlp39Z7SQEOdY48IodZHTf77uhuf0KtIb0zLY/TU5HoLYSTk+igQBruOtzQm+GMe9V17P/7A36ZxjgsfgxHI8+JpUkbhvgfzR2y+TGSgwmMRDBYDfiHCH4zBRKYSFmAliVcTIVFf7RJzgzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TYMsL3lBgz6J9fy;
	Mon, 12 Feb 2024 19:38:14 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 3AD6E140136;
	Mon, 12 Feb 2024 19:42:08 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 12 Feb
 2024 11:42:07 +0000
Date: Mon, 12 Feb 2024 11:42:06 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
CC: Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>, "Rafael
 J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	<linux-acpi@vger.kernel.org>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Daniel Scally <djrscally@gmail.com>, "Heikki
 Krogerus" <heikki.krogerus@linux.intel.com>, Julia Lawall
	<Julia.Lawall@inria.fr>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Cosmin Tanislav <cosmin.tanislav@analog.com>, Mihail Chindris
	<mihail.chindris@analog.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Tomislav Denis <tomislav.denis@avl.com>, Marek Vasut <marex@denx.de>, Olivier
 Moysan <olivier.moysan@foss.st.com>, Fabrice Gasnier
	<fabrice.gasnier@foss.st.com>, Lad Prabhakar
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>, Marijn Suijten
	<marijn.suijten@somainline.org>, Marius Cristea
	<marius.cristea@microchip.com>, Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 01/14] device property: Add cleanup.h based
 fwnode_handle_put() scope based cleanup.
Message-ID: <20240212114206.00005b9f@Huawei.com>
In-Reply-To: <Zcnbk6_9BU_trU9P@kekkonen.localdomain>
References: <20240211192540.340682-1-jic23@kernel.org>
	<20240211192540.340682-2-jic23@kernel.org>
	<Zcnbk6_9BU_trU9P@kekkonen.localdomain>
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
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 12 Feb 2024 08:49:23 +0000
Sakari Ailus <sakari.ailus@linux.intel.com> wrote:

> Hi Jonathan,
> 
> On Sun, Feb 11, 2024 at 07:25:27PM +0000, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Useful where the fwnode_handle was obtained from a call such as
> > fwnode_find_reference() as it will safely do nothing if IS_ERR() is true
> > and will automatically release the reference on the variable leaving
> > scope.
> > 
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  include/linux/property.h | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/include/linux/property.h b/include/linux/property.h
> > index e6516d0b7d52..bcda028f1a33 100644
> > --- a/include/linux/property.h
> > +++ b/include/linux/property.h
> > @@ -12,6 +12,7 @@
> >  
> >  #include <linux/args.h>
> >  #include <linux/bits.h>
> > +#include <linux/cleanup.h>
> >  #include <linux/fwnode.h>
> >  #include <linux/stddef.h>
> >  #include <linux/types.h>
> > @@ -188,6 +189,8 @@ struct fwnode_handle *device_get_named_child_node(const struct device *dev,
> >  
> >  struct fwnode_handle *fwnode_handle_get(struct fwnode_handle *fwnode);
> >  void fwnode_handle_put(struct fwnode_handle *fwnode);
> > +DEFINE_FREE(fwnode_handle, struct fwnode_handle *,
> > +	    if (!IS_ERR_OR_NULL(_T)) fwnode_handle_put(_T))  
> 
> fwnode_handle_put() can be safely called on NULL or error pointer fwnode so
> you can remove the check.

Was discussed in the RFC thread (where i didn't have this protection)

https://lore.kernel.org/linux-iio/20240108125117.000010fb@Huawei.com/
includes a reference to Linus Torvald's view on this.

All comes down to compiler visibility and optimization opportunities, which are improved
if the check is in the macro definition.

Jonathan
> 
> >  
> >  int fwnode_irq_get(const struct fwnode_handle *fwnode, unsigned int index);
> >  int fwnode_irq_get_byname(const struct fwnode_handle *fwnode, const char *name);  
> 


