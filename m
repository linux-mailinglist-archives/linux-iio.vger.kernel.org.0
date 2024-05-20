Return-Path: <linux-iio+bounces-5141-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5E68C9D0A
	for <lists+linux-iio@lfdr.de>; Mon, 20 May 2024 14:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16391282551
	for <lists+linux-iio@lfdr.de>; Mon, 20 May 2024 12:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84B552F74;
	Mon, 20 May 2024 12:18:56 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444F817BB7;
	Mon, 20 May 2024 12:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716207536; cv=none; b=GC0zPqCRdHj5M9qFur4SeQ1qvk+bSEyIy1i6kgyOwdUzcb9L4YEZq+cB9JmTUhI6bVGZjUqwoOloWzz77zzmurT73k+1zRxPNQ6TlZAl3dBF+xiQDmBMIwUyPP3aiqMIq4iMgxY4n3a9j3o6SrHoJUbnqEbUn/uEFitMd04r2qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716207536; c=relaxed/simple;
	bh=AhAkIxdxo8nGovCaSlq1pkGb4X16g2knzkRwPVd2RZA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u4i2tW3lD7f/VFn0ISex9J9vWTqfcWLkgysKFRaG4fDCce0ncdmHMvqZJa+AsS/OPIYEGJ2A32T3eyhiERbtXDWuHZs6pb7QqLy28JXx4l1htItuPyHqM0BHBxAqZmWYgIdJtrQcfvRtmys4thavxMIQLI3+kZygCDx/E0ius30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Vjc2t445zz6JBT5;
	Mon, 20 May 2024 20:15:18 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 193B11400D4;
	Mon, 20 May 2024 20:18:52 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 20 May
 2024 13:18:51 +0100
Date: Mon, 20 May 2024 13:18:50 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Andrew Hepp <andrew.hepp@ahepp.dev>, Marcelo Schmitt
	<marcelo.schmitt1@gmail.com>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] iio: temperature: mcp9600: add threshold events
 support
Message-ID: <20240520131850.00003430@Huawei.com>
In-Reply-To: <20240519210036.GB10322@debian>
References: <20240517081050.168698-1-dima.fedrau@gmail.com>
	<20240517081050.168698-3-dima.fedrau@gmail.com>
	<20240519174248.69f00448@jic23-huawei>
	<20240519210036.GB10322@debian>
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

On Sun, 19 May 2024 23:00:36 +0200
Dimitri Fedrau <dima.fedrau@gmail.com> wrote:

> Am Sun, May 19, 2024 at 05:42:48PM +0100 schrieb Jonathan Cameron:
> > On Fri, 17 May 2024 10:10:50 +0200
> > Dimitri Fedrau <dima.fedrau@gmail.com> wrote:
> >   
> > > The device has four programmable temperature alert outputs which can be
> > > used to monitor hot or cold-junction temperatures and detect falling and
> > > rising temperatures. It supports up to 255 degree celsius programmable
> > > hysteresis. Each alert can be individually configured by setting following
> > > options in the associated alert configuration register:
> > > - monitor hot or cold junction temperature
> > > - monitor rising or falling temperature
> > > - set comparator or interrupt mode
> > > - set output polarity
> > > - enable alert
> > > 
> > > This patch binds alert outputs to iio events:
> > > - alert1: hot junction, rising temperature
> > > - alert2: hot junction, falling temperature
> > > - alert3: cold junction, rising temperature
> > > - alert4: cold junction, falling temperature
> > > 
> > > All outputs are set in comparator mode and polarity depends on interrupt
> > > configuration.
> > > 
> > > Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>  
> > Hi Dmitri  
> 
> Hi Jonathan,
> 
> > Please make sure to address all questions in earlier reviews, either by
> > changing the code, or directly answering the question.
> >  
> I did, see: https://lore.kernel.org/linux-iio/20240509204559.GB3614@debian/T/#u
> or did I miss anything ? I'm a little bit confused.

I think some emails went astray :( Sorry I didn't check the archive.

Anyhow, thanks for providing the links.

Jonathan


