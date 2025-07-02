Return-Path: <linux-iio+bounces-21252-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4716DAF5D6D
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jul 2025 17:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AD5818828C7
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jul 2025 15:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7AAC309A43;
	Wed,  2 Jul 2025 15:33:49 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C79303DE4;
	Wed,  2 Jul 2025 15:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751470429; cv=none; b=kVoDno/K0HiCa3++63xEGm51UswAHV7Xwz7I7hBZbKJdnKtAEmUmgiLX8MfqKHULzyVwMmw1WhpPgut/xzDGojUCPygrju0MixrEA/Sp0yW8H8RQAw8CD4+IhbA35U7zaVtCVxk2KZqd2QcIP79MAUtEnXD5LkiQRAu3NZe0DGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751470429; c=relaxed/simple;
	bh=XvErPKwXmrSaWnLPQRt75z9XMYPtu63Ke0m16RaoJ+k=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B6T/VlI3QrDKGC72BNhHvDukPn+Zt2ROmdQl+cet1TqaQe/nLlf5xCZmNUDsy3dM9MpeKZPJAU0kwZwFm+6fZZHA+uSqD5KXxwSdxULHDagLEjrSmmFYYqg1iAupuRMzECWwItbf0ofBVhGnDdSnh3vnzpaOyMeyAGE+GSydBV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bXP6S3Hm3z6M4tH;
	Wed,  2 Jul 2025 23:32:48 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 3C5D914011A;
	Wed,  2 Jul 2025 23:33:44 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 2 Jul
 2025 17:33:43 +0200
Date: Wed, 2 Jul 2025 16:33:42 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: David Lechner <dlechner@baylibre.com>
CC: Andy Shevchenko <andriy.shevchenko@intel.com>, Akshay Bansod
	<akbansd@gmail.com>, Lorenzo Bianconi <lorenzo@kernel.org>, "Jonathan
 Cameron" <jic23@kernel.org>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	<linux-kernel-mentees@lists.linuxfoundation.org>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: st_lsm6dsx: Replace scnprintf with sysfs_emit
Message-ID: <20250702163342.00003c66@huawei.com>
In-Reply-To: <e474db53-1b52-48b0-9253-2f62a3861bb4@baylibre.com>
References: <20250702135855.59955-1-akbansd@gmail.com>
	<f96b68a5-d750-45f0-8cdd-9761b5daca1d@baylibre.com>
	<aGVIcBLgXZj_YR7B@smile.fi.intel.com>
	<e474db53-1b52-48b0-9253-2f62a3861bb4@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 2 Jul 2025 10:04:23 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 7/2/25 9:55 AM, Andy Shevchenko wrote:
> > On Wed, Jul 02, 2025 at 09:16:51AM -0500, David Lechner wrote:  
> >> On 7/2/25 8:58 AM, Akshay Bansod wrote:  
> >>> Update the sysfs interface for sampling frequency and scale attributes.
> >>> Replace `scnprintf()` with `sysfs_emit_at()` which is PAGE_SIZE-aware
> >>> and recommended for use in sysfs.  
> > 
> > ...
> >   
> >>> +		len += sysfs_emit_at(buf, len, "%d.%03d ",
> >>>  				 odr_table->odr_avl[i].milli_hz / 1000,
> >>>  				 odr_table->odr_avl[i].milli_hz % 1000);  
> >>
> >> Let's keep checkpatch happy and change the indent of the wrapped lines to
> >> line up with ( since the ( moved.  
> > 
> > While I see the point, wouldn't be better to have 1000 replaced with MILLI
> > at the same time?
> >   
> 
> For anything with 3 zeros, I don't consider MILLI better (or worse).
> Science shows that the average human can easily see 3 or 4 things
> without having to count them [1]. So it is only when we start getting
> more 0s than that is when I think we should be picky about using macros
> instead.
> 
> And in this particular case, we are converting milli to micro so `1000`
> should be replaced by `(MICRO / MILLI)` if we are going to do that.
No we aren't.

This one is converting from milli_hz to hz + sticking to milli for the decimal
part.

Lots of other IIO cases where you would have been right, but I think not here.
> 
> [1]: https://www.scientificamerican.com/article/your-brain-finds-it-easy-to-size-up-four-objects-but-not-five-heres-why/
> 
> 


