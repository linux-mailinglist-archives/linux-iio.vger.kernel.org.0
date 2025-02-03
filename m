Return-Path: <linux-iio+bounces-14906-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D70AEA257D8
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 12:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4937D3A9164
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 11:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01A9202F68;
	Mon,  3 Feb 2025 11:15:04 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BD4202C30;
	Mon,  3 Feb 2025 11:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738581304; cv=none; b=H1jls9p7ug6kZFTI8wKMF23eoQrmkQPRIv98dn6ozFSxgmKK0vW2goXW4Tuu0YqhlU73VodzuimAj3VuDdku+GpV+c2uTqXqtWOfmRX5iNP/WiVbL4Wb2PcpeY1Rl1DUZ0b0lTMMEKgl+kPxg+7k8EKheg+rwPhOngEZAINAgYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738581304; c=relaxed/simple;
	bh=Sh62TUgO9nu9uV2ysqDVSkHBdGr8aWWz1Gt2+gIoWWc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u6jTtP/M9ptAC8yS9ISMQN5xdeSHhahOYLeoe4DSv5wQ6vPtYoHaoDTSfU4UnK6BV53UsgldSdKvpprSlyICCRprUIZGKf0FVxKMfHZ1aUZv8afPWaG+BLl57MJE8F3kF3p6Kho94mHKEpqIH0c/Rg8dl0AcDl0o3zb4KHAys0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YmkNr2CjGz6L4tr;
	Mon,  3 Feb 2025 19:12:28 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 11D70140155;
	Mon,  3 Feb 2025 19:15:00 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 3 Feb
 2025 12:14:59 +0100
Date: Mon, 3 Feb 2025 11:14:58 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Raag Jadav <raag.jadav@intel.com>
CC: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	<gregkh@linuxfoundation.org>, <rafael@kernel.org>,
	<linus.walleij@linaro.org>, <mika.westerberg@linux.intel.com>,
	<dmitry.torokhov@gmail.com>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
	<sre@kernel.org>, <jic23@kernel.org>, <przemyslaw.kitszel@intel.com>,
	<linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-input@vger.kernel.org>, <linux-sound@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v3 14/20] iio: adc: xilinx-xadc-core: use
 devm_kmemdup_array()
Message-ID: <20250203111458.00002a5d@huawei.com>
In-Reply-To: <Z6CdnPryJkBHO9PK@black.fi.intel.com>
References: <20250203080902.1864382-1-raag.jadav@intel.com>
	<20250203080902.1864382-15-raag.jadav@intel.com>
	<Z6CSYn7ZDVNELIIv@smile.fi.intel.com>
	<Z6CdnPryJkBHO9PK@black.fi.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 3 Feb 2025 12:42:36 +0200
Raag Jadav <raag.jadav@intel.com> wrote:

> On Mon, Feb 03, 2025 at 11:54:42AM +0200, Andy Shevchenko wrote:
> > On Mon, Feb 03, 2025 at 01:38:56PM +0530, Raag Jadav wrote:  
> > > Convert to use devm_kmemdup_array() which is more robust.  
> > 
> > ...
> >   
> > > -	channels = devm_kmemdup(dev, channel_templates,
> > > -				sizeof(channels[0]) * max_channels, GFP_KERNEL);
> > > +	channels = devm_kmemdup_array(dev, channel_templates, max_channels,
> > > +				      sizeof(channels[0]), GFP_KERNEL);  
> > 
> > I would use more regular sizeof(*channels)  
> 
> This might get confusing since we're assigning it back to channels.
> 
It looks like standard pattern.  Assign X * the thing to the thing.

So I'd prefer sizeof(*channels) here as well.

> Raag
> 
> 


