Return-Path: <linux-iio+bounces-7099-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9913091DFB4
	for <lists+linux-iio@lfdr.de>; Mon,  1 Jul 2024 14:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 513C8283F96
	for <lists+linux-iio@lfdr.de>; Mon,  1 Jul 2024 12:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5912158D77;
	Mon,  1 Jul 2024 12:45:01 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C02B15667C;
	Mon,  1 Jul 2024 12:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719837901; cv=none; b=KFdS4BCzTK/zWDoOzpAhtgXGpg+0gkU6zN4homlk1Qi4RCqO/+lVNQB9QQke42ii0wWVmeLm7lVZ2eBQsVs3xkVnfq6+xzin3vo11qgN6BlJmHEf6OM1Gyi+T6hIKcfUOv4Q9D5zAKnlDSbQAfcMoa5N7MfnpQREtphGEzAbarI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719837901; c=relaxed/simple;
	bh=cQylj+EjYj/7INTgdTr0BduS9Kod/JnlXfO3nV7qH2s=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sYEDLhmP9KXN5UomieItUO1DnesNO4IiWqr7R7v9UgUxh6W2o3rNvS+bvTJPyX0eY/UArGfwZdW3sjKwn13iwO0ItP/nvPLIOM6NDa0Xa/icDHb89PSGSCVI0s6b7VBQLMElP/qwsZlLu15dObeUv9UaRV3+ootjdaNsCFEXyIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WCQhX4zHkz6K6tY;
	Mon,  1 Jul 2024 20:43:56 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 081061404FC;
	Mon,  1 Jul 2024 20:44:54 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 1 Jul
 2024 13:44:53 +0100
Date: Mon, 1 Jul 2024 13:44:52 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
CC: <jic23@kernel.org>, <dpfrey@gmail.com>, <himanshujha199640@gmail.com>,
	<lars@metafoo.de>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <mike.looijmans@topic.nl>
Subject: Re: [PATCH v3 00/15] iio: chemical: bme680: Driver cleanup
Message-ID: <20240701134452.00003f1d@Huawei.com>
In-Reply-To: <20240630202640.GA185141@vamoiridPC>
References: <20240609233826.330516-1-vassilisamir@gmail.com>
	<20240630202640.GA185141@vamoiridPC>
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
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Sun, 30 Jun 2024 22:26:40 +0200
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> On Mon, Jun 10, 2024 at 01:38:11AM +0200, Vasileios Amoiridis wrote:
> > Based on fixes-togreg as the 4 first commits are already applied
> > 
> > Patch 1/15: Added comment for explanation of what mutex is used for
> > 
> > Patch 2/15: Removed fixes tag
> > 
> > Patch 3-15/15: Reworded the commit messages to come close to convention
> > 	       of 75 chars per line.
> > 
> > v2: https://lore.kernel.org/linux-iio/20240606212313.207550-1-vassilisamir@gmail.com/
> > 
> > Patch 4/19:
> > 	- Combined the bme680_conversion_time_us() and bme680_wait_for_eoc()
> > 	  into one function.
> > 	- Added better comment for the calculation.
> > 	- Added checks in the bme680_wait_for_eoc() function.
> > 
> > Patch 5/19:
> > 	- Fixed typo in commit message.
> > 
> > Patch 6/19:
> > 	- Added a fixes tag since without the mutexes, read operations can be
> > 	  broken.
> > 
> > Patch 10/19:
> > 	- Converted shifting operation to FIELD_GET()
> > 
> > Patch 11/19:
> > 	- Changed convention from &data->bufer[0] to data->buffer.
> > 	- Removed IIO_DMA_MINALIGN as it is not needed anymore.
> > 
> > Patch 13/19:
> > 	- Removed IIO_DMA_MINALIGN
> > 
> > Patch 14/19:
> > 	- Splitted from Patch v1 14/19
> > 
> > Patch 15/19:
> > 	- Splitted from Patch v1 14/19
> > 
> > Patch 16/19: **NEW**
> > 	- Use dev_err_probe() where applicable.
> > 
> > v1: https://lore.kernel.org/linux-iio/20240527183805.311501-1-vassilisamir@gmail.com/
> > 
> > This started as a series to add support for buffers and the new
> > BME688 but it ended up being just a cleaning series. These might
> > be quite some patches for such a thing but I feel that they are
> > are well split, in order to allow for better review.
> > 
> > The patches are mostly small changes but essential for the correct use
> > of the driver. The first patches looked like fixes that should be
> > marked for the stable. Patches [11,17/17] might be a bit bigger but 11/17
> > is quite straightforward and 17/17 is basically a duplication of a
> > very similar commit coming from the BMP280 driver [1].
> > 
> > In general, the datasheet [2] of the driver is not very descriptive,
> > and it redirects the user to the BME68x Sensor API [3]. All the things
> > that were identified from the BME68x Sensor API have been marked with
> > links to the original locations of the GitHub code. If this is too much
> > and we don't want this type of information on the commit message, please
> > let me know and I will fix it.
> > 
> > [1]: https://lore.kernel.org/linux-iio/20240512230524.53990-1-vassilisamir@gmail.com/T/#mc6f814e9a4f8c2b39015909d174c7013b3648b9b
> > [2]: https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bme680-ds001.pdf
> > [3]: https://github.com/boschsensortec/BME68x_SensorAPI/tree/master
> > 
> > 
> > Vasileios Amoiridis (15):
> >   iio: chemical: bme680: Fix read/write ops to device by adding mutexes
> >   iio: chemical: bme680: Fix typo in define
> >   iio: chemical: bme680: Drop unnecessary casts and correct adc data
> >     types
> >   iio: chemical: bme680: Remove remaining ACPI-only stuff
> >   iio: chemical: bme680: Sort headers alphabetically
> >   iio: chemical: bme680: Remove duplicate register read
> >   iio: chemical: bme680: Use bulk reads for calibration data
> >   iio: chemical: bme680: Allocate IIO device before chip initialization
> >   iio: chemical: bme680: Add read buffers in read/write buffer union
> >   iio: chemical: bme680: Make error checks consistent
> >   iio: chemical: bme680: Modify startup procedure
> >   iio: chemical: bme680: Move probe errors to dev_err_probe()
> >   iio: chemical: bme680: Remove redundant gas configuration
> >   iio: chemical: bme680: Move forced mode setup in ->read_raw()
> >   iio: chemical: bme680: Refactorize reading functions
> > 
> >  drivers/iio/chemical/bme680.h      |  41 +-
> >  drivers/iio/chemical/bme680_core.c | 631 +++++++++++++----------------
> >  2 files changed, 291 insertions(+), 381 deletions(-)
> > 
> > 
> > base-commit: 4241665e6ea063a9c1d734de790121a71db763fc
> > -- 
> > 2.25.1
> >   
> 
> Hi Jonathan,
> 
> It's been three weeks so I am just checking-in here, to be sure that this
> series was not lost in the countless e-mails that you receive. Totally
> understand the summer time on top, so no hurry at all, just checking in
> that it is not lost! :) Thanks for the amazing job with the reviews
> though anyways! :)

Hi,

It's stalled because of a tree management issue - that is the first
few patches were going through fixes-togreg and I'd like to keep
the merge fun simple which means they have to end up upstream and
back in char-misc/char-misc-next which I then rebase on after
an IIO pull request.

They are in char-misc-next as of about 45 mins ago.

It'll be a bit tight for this cycle but my plan is 2 more pull requests
with the last one at risk because of timing.  This stuff can only be
in that final pull request.

Once it's all in place I will take a final look for but not anticipating
needing any changes.

Jonathan



> 
> Cheers,
> Vasilis
> 


