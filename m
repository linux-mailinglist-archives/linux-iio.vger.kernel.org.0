Return-Path: <linux-iio+bounces-18228-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8175BA92443
	for <lists+linux-iio@lfdr.de>; Thu, 17 Apr 2025 19:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B52E1B60731
	for <lists+linux-iio@lfdr.de>; Thu, 17 Apr 2025 17:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB87A2561DD;
	Thu, 17 Apr 2025 17:44:36 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2215D1B4F09;
	Thu, 17 Apr 2025 17:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744911876; cv=none; b=UaHvcHNGPjw5XBs2PxzYHyUbCXinL/ekuktoVlMOTaXsOAq2+uRUqivu7Ph3K8bOdrlKgNR3y4rxXCUpg/eKtTCdcC6+g082vxaVBx4I92FDtqoQusWV0DI90CUy6bVSZ2/6sE2P4Hmfsr7fbcrgx1/K3yE0zK7Yi31FKOwwJ5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744911876; c=relaxed/simple;
	bh=cVBnumUroswgP2BUPsVHASBE14+00NJBPctGj1TGTe4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MNS8BrjWCWcAMojvOVUFTGR3/Vrtd3Hwh310dYYlrcE/Bu1icRd7A+DsNQYmYzZqhMH4xvd6ak0igKwkMlFoZ/2BUrymUOwKl0vVxCXjWGjB+w8uPhAGR+m4yZZYyLdrEVGt1Esz3Svbt60bMxmKIJiQ4TXyakWNh+CoWFjbtNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZdlXZ0x45z67KPG;
	Fri, 18 Apr 2025 01:40:14 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id BADD6140520;
	Fri, 18 Apr 2025 01:44:31 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 17 Apr
 2025 19:44:31 +0200
Date: Thu, 17 Apr 2025 18:44:29 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: David Lechner <dlechner@baylibre.com>
CC: Andy Shevchenko <andy@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Lars-Peter Clausen
	<lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, "Cosmin
 Tanislav" <cosmin.tanislav@analog.com>, Tomasz Duszynski
	<tduszyns@gmail.com>, Jean-Baptiste Maneyrol
	<jean-baptiste.maneyrol@tdk.com>, Andreas Klinger <ak@it-klinger.de>, "Petre
 Rodan" <petre.rodan@subdimension.ro>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH 6/8] iio: imu: adis16550: align buffers for timestamp
Message-ID: <20250417184429.00002403@huawei.com>
In-Reply-To: <f4db1a95-106f-4fa4-9318-3ee172e29cdb@baylibre.com>
References: <20250417-iio-more-timestamp-alignment-v1-0-eafac1e22318@baylibre.com>
	<20250417-iio-more-timestamp-alignment-v1-6-eafac1e22318@baylibre.com>
	<aAEzeY_p6a8Pr-zn@smile.fi.intel.com>
	<f4db1a95-106f-4fa4-9318-3ee172e29cdb@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 17 Apr 2025 12:07:37 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 4/17/25 11:59 AM, Andy Shevchenko wrote:
> > On Thu, Apr 17, 2025 at 11:52:38AM -0500, David Lechner wrote:  
> >> Align the buffers used with iio_push_to_buffers_with_timestamp() to
> >> ensure the s64 timestamp is aligned to 8 bytes.
> >>
> >>  drivers/iio/accel/bmc150-accel.h | 2 +-
> >>  drivers/iio/imu/adis16550.c      | 2 +-  
> > 
> > Looks like a stray squash of the two independent commits.  
> 
> Oops, sure enough.
> 
> > 
> > ...
> >   
> >>  	struct bmc150_accel_trigger triggers[BMC150_ACCEL_TRIGGERS];
> >>  	struct mutex mutex;
> >>  	u8 fifo_mode, watermark;
> >> -	s16 buffer[8];
> >> +	s16 buffer[8] __aligned(8);  
> > 
> > As for the code, would it be possible to convert to actually use a sturcture
> > rather than an array?  
> 
> I do personally prefer the struct pattern, but there are very many other drivers
> using this buffer pattern that I was not tempted to try to start converting them.

For drivers like this one where there is no room for the timestamp
to sit earlier for minimal channels I think it is worth that conversion
if we are touching them anyway. 

Jonathan


> 
> > 
> > ...
> >   
> >>  	struct iio_poll_func *pf = p;
> >> -	__be32 data[ADIS16550_MAX_SCAN_DATA];
> >> +	__be32 data[ADIS16550_MAX_SCAN_DATA] __aligned(8);
This one is more complex as you need to take the
available scan masks into account to figure out that it
always has enough channels enabled to ensure the timestamp
ends up in the 3rd 64 byte position.

We get 7 channels for each of the available scan masks.
So fine, but hard to see that, so this one I'd be less tempted
to change.


> >>  	struct iio_dev *indio_dev = pf->indio_dev;
> >>  	struct adis16550 *st = iio_priv(indio_dev);  
> > 
> > Ditto.
> >   
> 
> 


