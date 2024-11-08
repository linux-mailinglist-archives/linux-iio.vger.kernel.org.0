Return-Path: <linux-iio+bounces-12028-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA8F9C1C01
	for <lists+linux-iio@lfdr.de>; Fri,  8 Nov 2024 12:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B133F282559
	for <lists+linux-iio@lfdr.de>; Fri,  8 Nov 2024 11:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC1A1E47AD;
	Fri,  8 Nov 2024 11:15:05 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15CD1D0400;
	Fri,  8 Nov 2024 11:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731064505; cv=none; b=YnY9DPshdsw7Y8A+ayfjpaTeE6ii7JNcAW6dEYb/aUcjvAVRCF0LLxrzKhybHrKmnIn80agiyV+hFTb/ziLjhSrA9n+QNZ9NNBzsCJjRurDQQkjUkVh+lYPS0UVb8gTUpDtEkDg9Y725ejfyKLuDkdXQkZOXptLbAH7pLh1qwGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731064505; c=relaxed/simple;
	bh=DrS9z4j0wSvNsWrj0iM7gd2sljO/gTrUX1dW8YuZDrg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=raTmQp2w4djkz77IjyhxWQokeDvGoeulj7xz532hs0eTarw33dQjF39zMpaAEaf/80sQzn8lPTkVfuNhOT4D63qPhvkv+ELngqce1E7RbqSOUSN0R3qa8MHStosshawpE6mh5RoiNcWh4Uv3BnxC9iwXNrG0Jpt627py0xQMAmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XlGWp5TLzz6K9R2;
	Fri,  8 Nov 2024 19:13:10 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 9ABF81401F4;
	Fri,  8 Nov 2024 19:14:53 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 8 Nov
 2024 12:14:53 +0100
Date: Fri, 8 Nov 2024 11:14:51 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
	"Jonathan Corbet" <corbet@lwn.net>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH] iio: Move __private marking before struct element priv
 in struct iio_dev
Message-ID: <20241108111451.00005fd0@huawei.com>
In-Reply-To: <Zy3Ongpc0vdGxKsX@smile.fi.intel.com>
References: <20241107185746.138146-1-jic23@kernel.org>
	<Zy3Ongpc0vdGxKsX@smile.fi.intel.com>
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

On Fri, 8 Nov 2024 10:41:02 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Thu, Nov 07, 2024 at 06:57:46PM +0000, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > This is to avoid tripping up kernel-doc which filters it out before
> > but not after the name.
> > 
> > Fixes:
> > ./include/linux/iio/iio.h:628: warning: Function parameter or struct member '__private' not described in 'iio_dev'
> > ./include/linux/iio/iio.h:628: warning: Excess struct member 'priv' description in 'iio_dev'  
> 
> ...
> 
> > -	void				*priv __private;
> > +	void				__private *priv;
> >  };  
> 
> This is still inconsistent from the position perspective (while may still
> work). I specifically placed it there, otherwise what you need is to have
> 
> 	void * __private priv;
> 
> to be fully consistent.
> 
> That said, either you need to carefully reindent all the affected members,
> or fix the kernel-doc, or both.
Doh. Indeed. The marking was wrong and sparse tripped on it.

I'll switch to void * __private priv; hideous though that is and not worry about indenting.

We can then decide next cycle whether to tidy up better.

> 


