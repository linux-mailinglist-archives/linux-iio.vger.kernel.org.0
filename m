Return-Path: <linux-iio+bounces-11642-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D9D9B6B99
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 19:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15F101F22369
	for <lists+linux-iio@lfdr.de>; Wed, 30 Oct 2024 18:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A0119E99F;
	Wed, 30 Oct 2024 18:04:37 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D391B12CDA5
	for <linux-iio@vger.kernel.org>; Wed, 30 Oct 2024 18:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730311477; cv=none; b=m03HDNk8ekmzugZcTO1hV8gx4Kdfv59to8sn78E5GzAsPMW9kdqBA13bNqKcKpd6s8csuIZIXOy926lwv2kWtXbR81+FyC+Arjatk8gnYtUBT/Z2nj0wViWvxaNtlk97/Spx1th8CBckUJhJazbyfWttX+D5MgNWeU8ToizkzqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730311477; c=relaxed/simple;
	bh=+28lHSYso5/3+EKXYkHNwxjBSAKKLfqs2KaB5Qixn6o=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KUDGq/jCQaXbIKL09gSP5HgdTtCYBTxExSTZJYejukR4Uo8PENxBbmx9Z9zNKWbWlubYG8ixx+z4OMOL8d89Tbkju0t9hWLo+oYc/ftFp5lGb/0R4Hxa8mlwa6FJ+CfoIma67A7oP2Nh2wEzcMqcaaDmqEyDOve1xcdZBAXEFZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Xdw1p0xhDz6K6Kf;
	Thu, 31 Oct 2024 02:02:06 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id D7519140429;
	Thu, 31 Oct 2024 02:04:31 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 30 Oct
 2024 19:04:31 +0100
Date: Wed, 30 Oct 2024 18:04:30 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: Vasileios Amoiridis <vassilisamir@gmail.com>, <linux-iio@vger.kernel.org>
Subject: Re: [bug report] iio: chemical: bme680: generalize read_*()
 functions
Message-ID: <20241030180430.0000137b@Huawei.com>
In-Reply-To: <5f57df67-8e5d-49ac-ba1c-c9a39b70a1a2@stanley.mountain>
References: <13f764f7-4cc4-4563-81f6-0393732729a6@stanley.mountain>
	<ZyIDKdX7NKopqT4W@vamoirid-laptop>
	<7c694cba-9444-415c-ac6e-458cdd600ae7@stanley.mountain>
	<ZyJgj_E3qXw-Vj2C@vamoirid-laptop>
	<5f57df67-8e5d-49ac-ba1c-c9a39b70a1a2@stanley.mountain>
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
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 30 Oct 2024 19:40:02 +0300
Dan Carpenter <dan.carpenter@linaro.org> wrote:

> On Wed, Oct 30, 2024 at 05:36:31PM +0100, Vasileios Amoiridis wrote:
> > On Wed, Oct 30, 2024 at 01:47:20PM +0300, Dan Carpenter wrote:  
> > > On Wed, Oct 30, 2024 at 10:58:01AM +0100, Vasileios Amoiridis wrote:  
> > > > On Wed, Oct 30, 2024 at 12:26:13PM +0300, Dan Carpenter wrote:  
> > > > > Hello Vasileios Amoiridis,
> > > > > 
> > > > > Commit 9b4071ab8cbe ("iio: chemical: bme680: generalize read_*()
> > > > > functions") from Oct 21, 2024 (linux-next), leads to the following
> > > > > Smatch static checker warning:
> > > > > 
> > > > > 	drivers/iio/chemical/bme680_core.c:760 bme680_read_raw()
> > > > > 	warn: passing casted pointer '&chan_val' to 'bme680_read_temp()' 32 vs 16.
> > > > > 
> > > > > drivers/iio/chemical/bme680_core.c
> > > > >     738 static int bme680_read_raw(struct iio_dev *indio_dev,
> > > > >     739                            struct iio_chan_spec const *chan,
> > > > >     740                            int *val, int *val2, long mask)
> > > > >     741 {
> > > > >     742         struct bme680_data *data = iio_priv(indio_dev);
> > > > >     743         int chan_val, ret;
> > > > >     744 
> > > > >     745         guard(mutex)(&data->lock);
> > > > >     746 
> > > > >     747         /* set forced mode to trigger measurement */
> > > > >     748         ret = bme680_set_mode(data, true);
> > > > >     749         if (ret < 0)
> > > > >     750                 return ret;
> > > > >     751 
> > > > >     752         ret = bme680_wait_for_eoc(data);
> > > > >     753         if (ret)
> > > > >     754                 return ret;
> > > > >     755 
> > > > >     756         switch (mask) {
> > > > >     757         case IIO_CHAN_INFO_PROCESSED:
> > > > >     758                 switch (chan->type) {
> > > > >     759                 case IIO_TEMP:  
> > > > > --> 760                         ret = bme680_read_temp(data, (s16 *)&chan_val);  
> > > > > 
> > > > > The bme680_read_temp() function takes an s16 pointer but we're passing a s32.
> > > > > This will not work on big endian systems and even on little endian systems, we
> > > > > haven't initialized the last 16 bits of chan_val so it's an uninitialized
> > > > > variable bug.
> > > > >   
> > > > 
> > > > Hi Dan,
> > > > 
> > > > Thanks for letting me know! What I could do is instead of reusing the
> > > > int chan_val, I could use a local s16 temp_chan_val so there is no need
> > > > for typecasting here.  
> > > 
> > > That works.  Not a fan of the name though.  "temp" means "temperature" and "tmp"
> > > means "temporary".  chan_val16 perhaps?
> > > 
> > > regards,
> > > dan carpenter
> > >  
> > 
> > That's the reason I used temp in the name, because we are reading a
> > temperature channel in this line.  
> 
> Ha.  Okay.  Good then.
> 
> regards,
> dan carpenter
Yes, Vasilieos please spin a patch. I might fix it up directly first but a bit
short on time this week.

Jonathan

> 
> 


