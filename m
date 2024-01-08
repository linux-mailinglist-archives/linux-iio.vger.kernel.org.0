Return-Path: <linux-iio+bounces-1484-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7D7826F07
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jan 2024 13:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57C3C1C22741
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jan 2024 12:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43CC24121E;
	Mon,  8 Jan 2024 12:53:55 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E6640C1F;
	Mon,  8 Jan 2024 12:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4T7v8l4SYlz6FGXK;
	Mon,  8 Jan 2024 20:52:07 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id BEB981404F5;
	Mon,  8 Jan 2024 20:53:50 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 8 Jan
 2024 12:53:50 +0000
Date: Mon, 8 Jan 2024 12:53:49 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Rob Herring <robh@kernel.org>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Frank Rowand <frowand.list@gmail.com>
Subject: Re: [RFC PATCH 1/4] of: Add cleanup.h based autorelease via
 __free(device_node) markings.
Message-ID: <20240108125349.000020d9@Huawei.com>
In-Reply-To: <20231221105434.5842ff3a@jic23-huawei>
References: <20231217184648.185236-1-jic23@kernel.org>
	<20231217184648.185236-2-jic23@kernel.org>
	<20231220221144.GA1188444-robh@kernel.org>
	<20231221105434.5842ff3a@jic23-huawei>
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
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)


> >   
> > > 
> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > ---
> > >  include/linux/of.h | 2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/include/linux/of.h b/include/linux/of.h
> > > index 6a9ddf20e79a..50e882ee91da 100644
> > > --- a/include/linux/of.h
> > > +++ b/include/linux/of.h
> > > @@ -13,6 +13,7 @@
> > >   */
> > >  #include <linux/types.h>
> > >  #include <linux/bitops.h>
> > > +#include <linux/cleanup.h>
> > >  #include <linux/errno.h>
> > >  #include <linux/kobject.h>
> > >  #include <linux/mod_devicetable.h>
> > > @@ -134,6 +135,7 @@ static inline struct device_node *of_node_get(struct device_node *node)
> > >  }
> > >  static inline void of_node_put(struct device_node *node) { }
> > >  #endif /* !CONFIG_OF_DYNAMIC */
> > > +DEFINE_FREE(device_node, struct device_node *, if (_T) of_node_put(_T))    
> > 
> > of_node_put() can be called with NULL, so do we need the "if (_T)"?  
> 
> Nope - should be fine to call it without. I was being lazy and didn't check :)

Seems there has been a lot of discussion of this for similar cases and
consensus is to keep the if (_T)
e.g. 

https://lore.kernel.org/all/6596edda327c8_8dc68294b2@dwillia2-xfh.jf.intel.com.notmuch/

> 
> > 
> > Rob  
> 
> 


