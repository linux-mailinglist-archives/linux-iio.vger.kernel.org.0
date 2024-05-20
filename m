Return-Path: <linux-iio+bounces-5140-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 69AA28C9D08
	for <lists+linux-iio@lfdr.de>; Mon, 20 May 2024 14:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02264B21F4D
	for <lists+linux-iio@lfdr.de>; Mon, 20 May 2024 12:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F72A50A6A;
	Mon, 20 May 2024 12:17:45 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0128E17BB7;
	Mon, 20 May 2024 12:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716207465; cv=none; b=kj7UzjRp8tQH0Dexyf5bHh2uAmx5l4psQTu4FNAy2kjEjrnB9BgrLiA6hjt0AekzWghxKdntHoeS+jyxSxQQE7NO+5uan3i+dBXmtCvtt4NXOuSnoYWXxPo4etkvdHUgzSk7/EagTaNzuD+xBRwCblCA6mLP73mz21ZTr3b4Tz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716207465; c=relaxed/simple;
	bh=k/OdqFfsmY5X8BDUEd/nsT28LLVg6dXeO0TNUgyA1ts=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EbVVoEilokqfhGTI0VuSpMquFnGOdvtLkxkfnFkZvKw1cbUXxeuVNmhVZrVnN2femWme4Tv//3lU7Q7dDtRL8hfITGljLti3Y8oPooqyeN58FSBUtxM2uFpwzobCceHq3tnJ8JSwr9gSsJgOyEpxPapcUTl4LiYh+3WLv9sgctA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Vjc1F6yd2z6J6bg;
	Mon, 20 May 2024 20:13:53 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 12D02140C72;
	Mon, 20 May 2024 20:17:39 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 20 May
 2024 13:17:38 +0100
Date: Mon, 20 May 2024 13:17:37 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Andrew Hepp <andrew.hepp@ahepp.dev>, Marcelo Schmitt
	<marcelo.schmitt1@gmail.com>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Nuno =?ISO-8859-1?Q?S=E1?=
	<nuno.sa@analog.com>
Subject: Re: [PATCH v2 1/2] iio: temperature: mcp9600: Provide index for
 both channels
Message-ID: <20240520131737.00007f80@Huawei.com>
In-Reply-To: <20240519203250.GA10322@debian>
References: <20240517081050.168698-1-dima.fedrau@gmail.com>
	<20240517081050.168698-2-dima.fedrau@gmail.com>
	<20240519171438.08810789@jic23-huawei>
	<20240519203250.GA10322@debian>
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

On Sun, 19 May 2024 22:32:50 +0200
Dimitri Fedrau <dima.fedrau@gmail.com> wrote:

> Am Sun, May 19, 2024 at 05:14:38PM +0100 schrieb Jonathan Cameron:
> > On Fri, 17 May 2024 10:10:49 +0200
> > Dimitri Fedrau <dima.fedrau@gmail.com> wrote:
> >   
> > > The mapping from cold junction to ambient temperature is inaccurate. We
> > > provide an index for hot and cold junction temperatures.
> > > 
> > > Suggested-by: Jonathan Cameron <jic23@kernel.org>
> > > Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>  
> > Hi Dmitri,
> >  
> Hi Jonathan,
> 
> > I'm not sure you replied to the question in previous review of what
> > sysfs files exist for this device.  Whilst I am at least a little
> > open to changing the ABI, I'd like to fully understand what
> > is currently presented and why iio_info is having trouble with it.
> >   
> I did, see: https://lore.kernel.org/linux-iio/20240509193125.GA3614@debian/T/#u

Ah thanks!  Oddly seem to have missed that on my other email account, but
have it here.  Thanks for the link.

> 
> But maybe not to the point. Sysfs is working correct and iio_info
> probably not. There is only one channel found, the temp_ambient. I would
> have expected two channels. Instead there are four attributes, I would
> have expected two. It seems to me that they are just duplicated. I also
> added the output when setting channel2 member of channel 0 to
> IIO_MOD_TEMP_OBJECT. This time iio_info works fine.

I'd be tempted to look at whether iio_info can be easily 'fixed' as a starting point.
This corner case may well occur for other devices in future.
It is 'stretching' the ABI definition but I don't think the current documentation
rules this case out.

> 
> > I also want an ack from Andrew on this one given might break it existing
> > usage.
> > 
> > The current interface is perhaps less than ideal, but I don't think it
> > is wrong as such. Whilst I wasn't particularly keen on the cold junction
> > == ambient I'm not sure moving to just indexed is an improvement.
> > Hence looking for input from Andrew. +CC Nuno as someone who is both
> > active in IIO and has written thermocouple front end drivers in
> > the past.
> >   
> I just thought the setting of channel2 member to IIO_MOD_TEMP_OBJECT was
> missing. But it turned out that it is not set for a reason. I'm fine
> with the existing mapping, but would be still interesting to know how
> others think about the mapping.

Agreed - I'm not sure on the right thing to do here.
I suspect leaving the modifier and add the index may be the best we can do
but let us wait to see what others think.

Jonathan

> 
> Dimitri
> 
> >   
> > > ---
> > >  drivers/iio/temperature/mcp9600.c | 9 +++++++--
> > >  1 file changed, 7 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/iio/temperature/mcp9600.c b/drivers/iio/temperature/mcp9600.c
> > > index 46845804292b..22451d1d9e1f 100644
> > > --- a/drivers/iio/temperature/mcp9600.c
> > > +++ b/drivers/iio/temperature/mcp9600.c
> > > @@ -14,6 +14,9 @@
> > >  
> > >  #include <linux/iio/iio.h>
> > >  
> > > +#define MCP9600_CHAN_HOT_JUNCTION	0
> > > +#define MCP9600_CHAN_COLD_JUNCTION	1
> > > +
> > >  /* MCP9600 registers */
> > >  #define MCP9600_HOT_JUNCTION 0x0
> > >  #define MCP9600_COLD_JUNCTION 0x2
> > > @@ -25,17 +28,19 @@
> > >  static const struct iio_chan_spec mcp9600_channels[] = {
> > >  	{
> > >  		.type = IIO_TEMP,
> > > +		.channel = MCP9600_CHAN_HOT_JUNCTION,
> > >  		.address = MCP9600_HOT_JUNCTION,
> > >  		.info_mask_separate =
> > >  			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> > > +		.indexed = 1,
> > >  	},
> > >  	{
> > >  		.type = IIO_TEMP,
> > > +		.channel = MCP9600_CHAN_COLD_JUNCTION,
> > >  		.address = MCP9600_COLD_JUNCTION,
> > > -		.channel2 = IIO_MOD_TEMP_AMBIENT,
> > > -		.modified = 1,
> > >  		.info_mask_separate =
> > >  			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> > > +		.indexed = 1,
> > >  	},
> > >  };
> > >    
> >   
> 


