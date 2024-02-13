Return-Path: <linux-iio+bounces-2511-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04543852DD1
	for <lists+linux-iio@lfdr.de>; Tue, 13 Feb 2024 11:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD08B1F212B4
	for <lists+linux-iio@lfdr.de>; Tue, 13 Feb 2024 10:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735052261F;
	Tue, 13 Feb 2024 10:25:36 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EFD225DA;
	Tue, 13 Feb 2024 10:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707819936; cv=none; b=hFKrSj/QUzAdZo5nTZr2v6Bmd4JSz9/71CAnYdwB6BqSHVQbDwwZyccVoE8ag4AQVKmrxgGoPFfKxH/FqdaUygE9z08lJgU+Y8+83Ynz51y9ff0HomiAmrIXze7WP3I76rJRv449Kg4Fpxk1TGMhJ9x7poA3BadH3yRxPmPzQDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707819936; c=relaxed/simple;
	bh=+XtzId9m0katE1bX/fV/aC/LwyQ0Y6TQgq6b1bfmyKo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nGWGmDkGW8efTUNOvPgVv/mbHXw3eWW/yWs5nGnGHwiDB6OO2WNQeuCZGg3YGv1aZ6psTSWQs+qzZGEZuTfWvLoOZiw0BbctMeTjFPEwzMO+3P9ZVAi9pIJKEFo55Uoogr/Z5bkRJkAAwxKBAEFDgYTnlFaT14y+6rdDVjNlefA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TYy726SGSz6D92Z;
	Tue, 13 Feb 2024 18:22:06 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 7D98C140519;
	Tue, 13 Feb 2024 18:25:31 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 13 Feb
 2024 10:25:30 +0000
Date: Tue, 13 Feb 2024 10:25:29 +0000
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
Subject: Re: [PATCH v2 03/14] device property: Introduce
 device_for_each_child_node_scoped()
Message-ID: <20240213102529.00003bf2@Huawei.com>
In-Reply-To: <ZcoK0Q8NgxolNeD8@smile.fi.intel.com>
References: <20240211192540.340682-1-jic23@kernel.org>
	<20240211192540.340682-4-jic23@kernel.org>
	<ZcoK0Q8NgxolNeD8@smile.fi.intel.com>
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
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 12 Feb 2024 14:10:57 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Sun, Feb 11, 2024 at 07:25:29PM +0000, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Similar to recently propose for_each_child_of_node_scoped() this
> > new version of the loop macro instantiates a new local
> > struct fwnode_handle * that uses the __free(fwnode_handle) auto
> > cleanup handling so that if a reference to a node is held on early
> > exit from the loop the reference will be released. If the loop
> > runs to completion, the child pointer will be NULL and no action will
> > be taken.
> > 
> > The reason this is useful is that it removes the need for
> > fwnode_handle_put() on early loop exits.  If there is a need
> > to retain the reference, then return_ptr(child) or no_free_ptr(child)
> > may be used to safely disable the auto cleanup.  
> 
> ...
> 
> > +#define device_for_each_child_node_scoped(dev, child)\  
> 
> Missing space before backslash, but I would rather to make them to be TABed to
> the same column.

Oops. I spotted I messed this up bug clearly failed to fix it before sending out.

> 
> > +	for (struct fwnode_handle *child __free(fwnode_handle) = \
> > +	     device_get_next_child_node(dev, NULL); child; \  
> 
> Please, move child to a separate line, so we will easily see the all three
> parameters of the for-loop. That said, indent the assignment to the right as
> well.
Indent makes sense - but (to save another respin) how far?
Next tab stop will be a bit random looking but I guess nothing else
makes more sense.

> 
> > +	     child = device_get_next_child_node(dev, child))  
> 
> With the above addressed,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks,
> 


