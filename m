Return-Path: <linux-iio+bounces-5227-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0639E8CD886
	for <lists+linux-iio@lfdr.de>; Thu, 23 May 2024 18:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C6331F21DC2
	for <lists+linux-iio@lfdr.de>; Thu, 23 May 2024 16:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2078B1B7FD;
	Thu, 23 May 2024 16:37:36 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19999D304;
	Thu, 23 May 2024 16:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716482256; cv=none; b=aGzO9Ywm5owY/bMiVYb0+CYrXXnGVU0/vgfGJ/gZSU8KBco3tgod0atU/TkM5FIK/zSiFocJ8va7FgruWxfYdbYSR1Rl4bo8urtNaZ3pK3rpSQ+dggFpT48QuI2p3W9KbjWPuOUqI6RTGbCm/7Iv7SEsw0flmrTqXDU6upmHs6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716482256; c=relaxed/simple;
	bh=qgkGDIjpEJfoA4a2AkMyyAveyC2iOGefHU0U1EkSN+k=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UUIfvDcBstNOeEs6fwkZZxKTvYI58kQDnt58R3M7sOi1If1jQg+0EVK6BtjXfSHQepmKQHo34hvqvk97PZk8PDjdf4p823+DNwlGXfyj2FAoXyA1RaKiXNAQypIPCxJwvb9JqdLBpY9dLsXPQGU9GPLsWuyxgtdp5puoSn9bdm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VlYj14d1vz6K9XP;
	Fri, 24 May 2024 00:36:37 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 443F5140B3C;
	Fri, 24 May 2024 00:37:29 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 23 May
 2024 17:37:28 +0100
Date: Thu, 23 May 2024 17:37:27 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Gradinariu, Ramona" <Ramona.Gradinariu@analog.com>
CC: Jonathan Cameron <jic23@kernel.org>, Nuno =?ISO-8859-1?Q?S=E1?=
	<noname.nuno@gmail.com>, Ramona Gradinariu <ramona.bolboaca13@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "corbet@lwn.net"
	<corbet@lwn.net>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"robh@kernel.org" <robh@kernel.org>, "Sa, Nuno" <Nuno.Sa@analog.com>
Subject: Re: [PATCH 4/5] iio: adis16480: add support for adis16545/7
 families
Message-ID: <20240523173727.000040ea@Huawei.com>
In-Reply-To: <BL1PR03MB5992653C0A426BAC69D7033197EB2@BL1PR03MB5992.namprd03.prod.outlook.com>
References: <20240423084210.191987-1-ramona.gradinariu@analog.com>
	<20240423084210.191987-5-ramona.gradinariu@analog.com>
	<20240428162555.3ddf31ea@jic23-huawei>
	<e62f8df4b06abc371b1e9fe3232cb593e468d54c.camel@gmail.com>
	<BL1PR03MB5992DEBF82C0DB7BDC5EA0FF971B2@BL1PR03MB5992.namprd03.prod.outlook.com>
	<20240429204027.3e47074a@jic23-huawei>
	<BL1PR03MB5992653C0A426BAC69D7033197EB2@BL1PR03MB5992.namprd03.prod.outlook.com>
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

On Wed, 22 May 2024 12:01:21 +0000
"Gradinariu, Ramona" <Ramona.Gradinariu@analog.com> wrote:

> > 
> > If you are using bursts, the data is getting read anyway - which is the main
> > cost here. The real question becomes what are you actually saving by supporting all
> > the combinations of the the two subsets of channels in the pollfunc?
> > Currently you have to pick the channels out and repack them, if pushing them all
> > looks to me like a mempcy and a single value being set (unconditionally).  
> 
> I did not get a chance to look at this again until now. Unfortunately, a
> memcpy will not work.
> The current implementation is as follows:
> /* The lower register data is sequenced first */
> st->data[i++] = buffer[2 * bit + offset + 3];
> st->data[i++] = buffer[2 * bit + offset + 2];

Ah. That's horrible... :(
Thanks for pointing that out!

> 
> The device first sends the 16LSB, then the next 16MSB in big endian
> format.
> 
> So then I wonder, can we keep the same implementation logic? The code
> is implemented in the same manner for adis16475 driver which uses the
> same channels data packing approach.

Not much choice and given the need to handle a mixed endian stream
you might as well do the packing here as well.  So sure, keep the
code as you have it.

> 
> > 
> > Then it's a question of what the overhead of the channel demux in the core is.
> > What you pass out of the driver via iio_push_to_buffers*()
> > is not what ends up in the buffer if you allow the IIO core to do data demuxing
> > for you - that is enabled by providing available_scan_masks.  At buffer
> > start up the demux code computes a fairly optimal set of copies to repack
> > the incoming data to match with what channels the consumer (here probably
> > the kfifo on the way to userspace) is expecting.
> > 
> > That demux adds a small overhead but it should be small as long
> > as the channels wanted aren't pathological (i.e. every other one).
> > 
> > Advantage is the driver ends up simpler and in the common case of turn
> > on all the channels (why else did you buy a device with those measurements
> > if you didn't want them!) the demux is zerocopy so effectively free which
> > is not going to be the case for the bitmap walk and element copy in the
> > driver.
> > 
> > Jonathan
> >   
> 


