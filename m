Return-Path: <linux-iio+bounces-1483-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1647826F00
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jan 2024 13:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6CBBB219CD
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jan 2024 12:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16284174D;
	Mon,  8 Jan 2024 12:51:24 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EACB4121C
	for <linux-iio@vger.kernel.org>; Mon,  8 Jan 2024 12:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4T7v4s6n1yz6K9TP;
	Mon,  8 Jan 2024 20:48:45 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id DE4AF140A86;
	Mon,  8 Jan 2024 20:51:18 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 8 Jan
 2024 12:51:18 +0000
Date: Mon, 8 Jan 2024 12:51:17 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
CC: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Jonathan Cameron <jic23@kernel.org>,
	<linux-iio@vger.kernel.org>
Subject: Re: [RFC PATCH 01/13] device property: Add cleanup.h based
 fwnode_handle_put() scope based cleanup.
Message-ID: <20240108125117.000010fb@Huawei.com>
In-Reply-To: <4b6f283d-48b9-4702-81dc-003a2dcfc3f1@rasmusvillemoes.dk>
References: <20240101172611.694830-1-jic23@kernel.org>
	<20240101172611.694830-2-jic23@kernel.org>
	<ZZlu5fTW27Tx3drB@smile.fi.intel.com>
	<305F62D9-8410-4F2F-9411-5A7395192789@jic23.retrosnub.co.uk>
	<4b6f283d-48b9-4702-81dc-003a2dcfc3f1@rasmusvillemoes.dk>
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
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Sun, 7 Jan 2024 22:05:35 +0100
Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:

> On 06/01/2024 18.53, Jonathan Cameron wrote:
> > 
> > ething similar and PeterZ explained there why if (_T) is  
> >> important, hence this should be  
> > 
> > I can't find the reference unfortunately. 
> >   
> >>
> >> DEFINE_FREE(fwnode_handle, struct fwnode_handle *, if (_T) fwnode_handle_put(_T))
> >>
> >> or even
> >>
> >> DEFINE_FREE(fwnode_handle, struct fwnode_handle *, if (!IS_ERR_OR_NULL(_T)) fwnode_handle_put(_T))
> >>
> >> as we accept in many calls an error pointer as unset / undefined firmware node
> >> handle.  
> > 
> > The function called has a protection for null
> >  and error inputs so I'm not sure why extra protection
> > is needed?  
> 
> IIRC, it's for code generation, avoiding emitting the call to the
> cleanup function on the code paths where the compiler knows the argument
> is NULL. And on the other return paths, the compiler most likely knows
> the value is non-NULL, so the conditional is elided (but of course not
> the put call). Read ERR_OR_NULL as appropriate.
> 
> Rasmus
> 
> 

Thanks. Makes sense.  A reference in another thread where this was being discussed
lead me to a reference to Linus arguing for just this:
https://lore.kernel.org/all/20230814161731.GN776869@hirez.programming.kicks-ass.net/

