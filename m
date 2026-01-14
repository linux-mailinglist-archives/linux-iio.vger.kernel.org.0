Return-Path: <linux-iio+bounces-27769-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBE5D1EAD0
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 13:15:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9D24E3033B86
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 12:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE1E396D2B;
	Wed, 14 Jan 2026 12:15:01 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6384396B9A;
	Wed, 14 Jan 2026 12:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768392901; cv=none; b=RAwwRZptK6bo+wzmzXL+v0eCP12QmHrdo/uuHWsMEz4Z30SIKUQ+f+b5WDff1nCNHtdB/XprI3eA2ASj56TgiE3j7WIk3jf+B5ifgX0ydyNEthfvvOd3Y0b4izcA5mB1Bz6QoFXNN4WofGalKziVBhIdHnTXhZVlnp9Hg++pDHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768392901; c=relaxed/simple;
	bh=xvgc/ef0mubFnx9C0rk9O+pFF27njKKnf2ONMGNp/QU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mslPe9exCOQBPvN8Tq4JaudzOLNwzeTI9LjmwoFjWHXA0pnsaGKlCT63M3B0uQ051oqgKRomBYq/zg+6C2w+vbcCelXrnA209QzfRAfuo346/QKm3mRJ5SK69PayNn10s3F6NSHC46t3ttkUb6PrDYOE/Q3qSrckm5IOKBAnP1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4drlRH3KhhzJ46ZK;
	Wed, 14 Jan 2026 20:14:35 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 1860540570;
	Wed, 14 Jan 2026 20:14:50 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 14 Jan
 2026 12:14:49 +0000
Date: Wed, 14 Jan 2026 12:14:48 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: Petre Rodan <petre.rodan@subdimension.ro>, Jonathan Cameron
	<jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Andy Shevchenko
	<andy@kernel.org>, Andreas Klinger <ak@it-klinger.de>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 03/13] iio: pressure: mprls0025pa: fix interrupt flag
Message-ID: <20260114121448.00000249@huawei.com>
In-Reply-To: <aWdsTf5l5hyw1qr0@smile.fi.intel.com>
References: <20260114-mprls_cleanup-v2-0-5868b0045316@subdimension.ro>
	<20260114-mprls_cleanup-v2-3-5868b0045316@subdimension.ro>
	<aWdsTf5l5hyw1qr0@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Wed, 14 Jan 2026 12:13:33 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Wed, Jan 14, 2026 at 12:05:37PM +0200, Petre Rodan wrote:
> > Interrupt falling/rising flags should only be defined in the device tree.  
> 
> ...
> 
> >  	if (data->irq > 0) {
> >  		ret = devm_request_irq(dev, data->irq, mpr_eoc_handler,
> > -				       IRQF_TRIGGER_RISING,
> > -				       dev_name(dev),
> > -				       data);
> > +				       IRQF_TRIGGER_NONE, dev_name(dev), data);  
> 
> No, this is still incorrect, should be plain 0 here.

Yeah. My mistake in agreeing with your reply in v1.  

I'll randomly blame lack of coffee ;)
See the help text above IRQF_TRIGGER_NONE in interrupt.h which talks about not
specifying up at all (i.e. 0) meaning go with whatever is already there.

Jonathan
> 
> >  		if (ret)
> >  			return dev_err_probe(dev, ret,
> >  					  "request irq %d failed\n", data->irq);  
> 


