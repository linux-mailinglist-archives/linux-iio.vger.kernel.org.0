Return-Path: <linux-iio+bounces-2548-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 414F4854B20
	for <lists+linux-iio@lfdr.de>; Wed, 14 Feb 2024 15:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8F781F237E0
	for <lists+linux-iio@lfdr.de>; Wed, 14 Feb 2024 14:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFAD54FA5;
	Wed, 14 Feb 2024 14:09:44 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933D355E56;
	Wed, 14 Feb 2024 14:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707919784; cv=none; b=g/5/iUoM6s/QpwP50LuC82jfbvTM4XSi5aj67cyTfeG1/kbt3El3BQSXTnFAEAaX72+no55NwFliClHpXH7ibNoHgcEKRT3lCqMTgo13GkndX2cGMp8b275px0ybeMuGvKeTlLxfJ39oTX6IJuThfg0h5PodnAd1RL7L+qURD9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707919784; c=relaxed/simple;
	bh=poPOuBJ5Js8FiOJBGMjgY7kRrMGMCzBV31PBCsrONBA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gr1h/pW4uJZiST0gAzgaowQr42H1Ev4l0xTQizIX91S1IAn5sL8LqMJm+MLHaCCpMAVMCV2gdQfZjTSwTO1bEnf7Ttnp7iikbeCrTXH1MH0qfB7rX9KQ2TjpY/iWI2E0sys25ElF8jlaF7BFFqgKmPs5O24/H+o4UfIWt6VZ2S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TZg392bxmz6K8kJ;
	Wed, 14 Feb 2024 22:06:13 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 9F1F2140D1A;
	Wed, 14 Feb 2024 22:09:39 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 14 Feb
 2024 14:09:38 +0000
Date: Wed, 14 Feb 2024 14:09:38 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
CC: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jonathan Cameron
	<jic23@kernel.org>, <linux-iio@vger.kernel.org>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	<linux-acpi@vger.kernel.org>, Greg Kroah-Hartman
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
Message-ID: <20240214140938.00001637@Huawei.com>
In-Reply-To: <20240213102245.00005c35@Huawei.com>
References: <20240211192540.340682-1-jic23@kernel.org>
	<20240211192540.340682-2-jic23@kernel.org>
	<Zcnbk6_9BU_trU9P@kekkonen.localdomain>
	<20240212114206.00005b9f@Huawei.com>
	<ZcoQ3sOcVYbwoHO7@kekkonen.localdomain>
	<ZcoTOZzJ3ZhSD0oi@smile.fi.intel.com>
	<ZcoV2xfcCOYKZicY@kekkonen.localdomain>
	<20240213102245.00005c35@Huawei.com>
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
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 13 Feb 2024 10:22:45 +0000
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Mon, 12 Feb 2024 12:58:03 +0000
> Sakari Ailus <sakari.ailus@linux.intel.com> wrote:
> 
> > On Mon, Feb 12, 2024 at 02:46:49PM +0200, Andy Shevchenko wrote:  
> > > On Mon, Feb 12, 2024 at 12:36:46PM +0000, Sakari Ailus wrote:    
> > > > On Mon, Feb 12, 2024 at 11:42:06AM +0000, Jonathan Cameron wrote:    
> > > 
> > > ...
> > >     
> > > > Hmm. In that case I'd rather make fwnode_handle_put() and similar trivial
> > > > functions macros.    
> > > 
> > > This will kill the type-checking opportunity, so I'm against this move.    
> > 
> > Then it could be made static inline and moved to the header. I suppose for
> > modern compilers there should be no difference in between the two
> > optimisation-wise.
> >   
> 
> Sure - will be a bit fiddly as this is only worth doing if we drop
> the internal check that buried several macros deep.

Not enough coffee yesterday. We can just move the the existing
fwnode_handle_put() to property.h as that includes fwnode.h has
all the definitions in it which we need to be able to see.

I think that should be uncontroversial?

Jonathan

> 
> 1. rename existing fwnode_handle_put() to __fwnode_handle_put()
> 2. Make __fwnode_handle_put() call a new set of macros
> #define fwnode_has_op_nocheck(fwnode, op) \
> 	(fwnode)->ops && (fwnode)->ops->op
> 
> #define fwnode_call_void_op_nocheck(fwnode, op, .... \
> 	do {
> 		if (fwnode_had_op_nocheck(fwnode, op)) \
> 			(fwnode)->ops->op(fwnode, ## __VA_ARGS__);
> 	} while (false);
> 
> 3. Add new
> static inline fwnode_handle_put(struct fwnode_handle *fwnode)
> {
> 	if (!IS_ERR_OR_NULL(fwnode))
> 		__fwnode_handle_put(fwnode);
> }
> 
> Or something like that.
> 
> I'm fine with doing that if conclusion is the complexity of the change
> is worth it.
> 
> Jonathan
> 


