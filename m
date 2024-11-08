Return-Path: <linux-iio+bounces-12030-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A699C1C0A
	for <lists+linux-iio@lfdr.de>; Fri,  8 Nov 2024 12:18:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38DAA1C21D14
	for <lists+linux-iio@lfdr.de>; Fri,  8 Nov 2024 11:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243531E32B1;
	Fri,  8 Nov 2024 11:18:29 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7791E0E0F;
	Fri,  8 Nov 2024 11:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731064709; cv=none; b=NTGK1U6mQAQpOJ8S90eMlhTt6NcA0yJX4azFYUI9ReiN/Gc+dze2NVKLCfcQC+fBPkZ8r8nQ9gt5wR3RGyNSQnBfthCL6mrwCQJ1CL6oeiY9u88za/QtG2atUmQghhOnxHiqBYO3/DwZzaIXn5vn/imUHlg/9ZU/bIblmIJCsFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731064709; c=relaxed/simple;
	bh=guJsLc5dAARKcdQDnA/WRwLWyWXntz3Gs11FY/3kw3E=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D3oF1MtFgw4/uRUKlm1BODUx11S2V7PgVzvRkrs/xR3iObdQB7Oe+l6OHMy5MctLIvJvXIkZ2pNiTABRDF7TzckZbKH7V3MtQ9c2ZdmFcJFrD4IJOC/Sj6Bh3fL2VmI68j6aIrxOiXvXRrImIXqEVfYgRKGFcfctlBqQhd8NbwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XlGbs2nJYz6K5pN;
	Fri,  8 Nov 2024 19:16:41 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 2CCDE140B73;
	Fri,  8 Nov 2024 19:18:24 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 8 Nov
 2024 12:18:23 +0100
Date: Fri, 8 Nov 2024 11:18:22 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>, Jonathan
 Corbet <corbet@lwn.net>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH] iio: Move __private marking before struct element priv
 in struct iio_dev
Message-ID: <20241108111822.0000389c@huawei.com>
In-Reply-To: <20241108111451.00005fd0@huawei.com>
References: <20241107185746.138146-1-jic23@kernel.org>
	<Zy3Ongpc0vdGxKsX@smile.fi.intel.com>
	<20241108111451.00005fd0@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 8 Nov 2024 11:14:51 +0000
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> On Fri, 8 Nov 2024 10:41:02 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > On Thu, Nov 07, 2024 at 06:57:46PM +0000, Jonathan Cameron wrote:
> > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > 
> > > This is to avoid tripping up kernel-doc which filters it out before
> > > but not after the name.
> > > 
> > > Fixes:
> > > ./include/linux/iio/iio.h:628: warning: Function parameter or struct member '__private' not described in 'iio_dev'
> > > ./include/linux/iio/iio.h:628: warning: Excess struct member 'priv' description in 'iio_dev'  
> > 
> > ...
> > 
> > > -	void				*priv __private;
> > > +	void				__private *priv;
> > >  };  
> > 
> > This is still inconsistent from the position perspective (while may still
> > work). I specifically placed it there, otherwise what you need is to have
> > 
> > 	void * __private priv;
> > 
> > to be fully consistent.
> > 
> > That said, either you need to carefully reindent all the affected members,
> > or fix the kernel-doc, or both.
> Doh. Indeed. The marking was wrong and sparse tripped on it.
> 
> I'll switch to void * __private priv; hideous though that is and not worry about indenting.
> 
> We can then decide next cycle whether to tidy up better.
Style wise I decided this was least hideous

void				*__private priv;

> 
> > 
> 


