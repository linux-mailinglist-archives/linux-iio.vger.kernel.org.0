Return-Path: <linux-iio+bounces-7416-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C8D9298E3
	for <lists+linux-iio@lfdr.de>; Sun,  7 Jul 2024 18:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75A99282F0E
	for <lists+linux-iio@lfdr.de>; Sun,  7 Jul 2024 16:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807023B29D;
	Sun,  7 Jul 2024 16:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hvX6ngFk"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3788F1DDCE;
	Sun,  7 Jul 2024 16:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720370516; cv=none; b=Es3RfDV5kC5i4jjyYQb7ndZ4vftTTz8Orfw1yQSvxKPfyAKq7zKfXc7E3DRUG7P0h91ahsub2IApzQcynI7Ae2Y/1ds9Hpl0NbWx+yTc7Q3ebXt/lVMJZb3B25LjPBNorZ68whcdhwRlBR2CePm8QKEC/2nSaZ9n1NF+sEbrxi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720370516; c=relaxed/simple;
	bh=ypqCC1y+XCHXp9lKSFWoqLGkfNuFOLXD5Vy4SuI5cDM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EsbA/01jb1W7REzVDnS/+NlD6Cf147BZ8WIoyVhaAd2/0yayvFu/5vRvz9h89zHtNmJRnz6RXgj1PTk3K4mKvBpCgyIObrL/G3u1VhhclWHkCa5WTCTU2nIYN6hs98B9XU1TXrWL5rC/iLnA10R3NcVdrArTHVttx/tWYYlUHo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hvX6ngFk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9AB6C3277B;
	Sun,  7 Jul 2024 16:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720370515;
	bh=ypqCC1y+XCHXp9lKSFWoqLGkfNuFOLXD5Vy4SuI5cDM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hvX6ngFkHFFz/Y46EDXjuLYR4n8RmLUTipQ7Oa1k1L5ZJOJ1dd5wIDF9nvHcJebIe
	 2yue86LLh0524Gqg6EU/7mHJ89A97H1xEypZSnPpoRLgU/ZZnfr03plVuEMUPaPNTp
	 awYsTQZdjiWXs3BhQtotiLbx4h691CpzS6vfzVCuRGXg3ZK72bCDe8mmZ45gGCuTli
	 v381saJdUir1UoZNQuU3soZsW26odfv6h0Jq0hhTNnnwAKKH/IJDjiIMjOU1HXhuhY
	 Bozn1ZytBOiDIxrLTYPl32yMLPYG4EVRcwgqxT5JeJm3FXAxpyAZOtnf6tKwj2FVbr
	 4mslkqXRJeeOg==
Date: Sun, 7 Jul 2024 17:41:47 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>, dpfrey@gmail.com,
 himanshujha199640@gmail.com, lars@metafoo.de, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, mike.looijmans@topic.nl
Subject: Re: [PATCH v3 00/15] iio: chemical: bme680: Driver cleanup
Message-ID: <20240707174147.5faba5b2@jic23-huawei>
In-Reply-To: <20240701170049.GA248279@vamoiridPC>
References: <20240609233826.330516-1-vassilisamir@gmail.com>
	<20240630202640.GA185141@vamoiridPC>
	<20240701134452.00003f1d@Huawei.com>
	<20240701170049.GA248279@vamoiridPC>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 1 Jul 2024 19:00:49 +0200
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> On Mon, Jul 01, 2024 at 01:44:52PM +0100, Jonathan Cameron wrote:
> > On Sun, 30 Jun 2024 22:26:40 +0200
> > Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> >   
> > > On Mon, Jun 10, 2024 at 01:38:11AM +0200, Vasileios Amoiridis wrote:  
> > > > Based on fixes-togreg as the 4 first commits are already applied
> > > > 
> > > > Patch 1/15: Added comment for explanation of what mutex is used for
> > > > 
> > > > Patch 2/15: Removed fixes tag
> > > > 
> > > > Patch 3-15/15: Reworded the commit messages to come close to convention
> > > > 	       of 75 chars per line.
> > > > 
> > > > v2: https://lore.kernel.org/linux-iio/20240606212313.207550-1-vassilisamir@gmail.com/
> > > > 
> > > > Patch 4/19:
> > > > 	- Combined the bme680_conversion_time_us() and bme680_wait_for_eoc()
> > > > 	  into one function.
> > > > 	- Added better comment for the calculation.
> > > > 	- Added checks in the bme680_wait_for_eoc() function.
> > > > 
> > > > Patch 5/19:
> > > > 	- Fixed typo in commit message.
> > > > 
> > > > Patch 6/19:
> > > > 	- Added a fixes tag since without the mutexes, read operations can be
> > > > 	  broken.
> > > > 
> > > > Patch 10/19:
> > > > 	- Converted shifting operation to FIELD_GET()
> > > > 
> > > > Patch 11/19:
> > > > 	- Changed convention from &data->bufer[0] to data->buffer.
> > > > 	- Removed IIO_DMA_MINALIGN as it is not needed anymore.
> > > > 
> > > > Patch 13/19:
> > > > 	- Removed IIO_DMA_MINALIGN
> > > > 
> > > > Patch 14/19:
> > > > 	- Splitted from Patch v1 14/19
> > > > 
> > > > Patch 15/19:
> > > > 	- Splitted from Patch v1 14/19
> > > > 
> > > > Patch 16/19: **NEW**
> > > > 	- Use dev_err_probe() where applicable.
> > > > 
> > > > v1: https://lore.kernel.org/linux-iio/20240527183805.311501-1-vassilisamir@gmail.com/
> > > > 
> > > > This started as a series to add support for buffers and the new
> > > > BME688 but it ended up being just a cleaning series. These might
> > > > be quite some patches for such a thing but I feel that they are
> > > > are well split, in order to allow for better review.
> > > > 
> > > > The patches are mostly small changes but essential for the correct use
> > > > of the driver. The first patches looked like fixes that should be
> > > > marked for the stable. Patches [11,17/17] might be a bit bigger but 11/17
> > > > is quite straightforward and 17/17 is basically a duplication of a
> > > > very similar commit coming from the BMP280 driver [1].
> > > > 
> > > > In general, the datasheet [2] of the driver is not very descriptive,
> > > > and it redirects the user to the BME68x Sensor API [3]. All the things
> > > > that were identified from the BME68x Sensor API have been marked with
> > > > links to the original locations of the GitHub code. If this is too much
> > > > and we don't want this type of information on the commit message, please
> > > > let me know and I will fix it.
> > > > 
> > > > [1]: https://lore.kernel.org/linux-iio/20240512230524.53990-1-vassilisamir@gmail.com/T/#mc6f814e9a4f8c2b39015909d174c7013b3648b9b
> > > > [2]: https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bme680-ds001.pdf
> > > > [3]: https://github.com/boschsensortec/BME68x_SensorAPI/tree/master
> > > > 
> > > > 
> > > > Vasileios Amoiridis (15):
> > > >   iio: chemical: bme680: Fix read/write ops to device by adding mutexes
> > > >   iio: chemical: bme680: Fix typo in define
> > > >   iio: chemical: bme680: Drop unnecessary casts and correct adc data
> > > >     types
> > > >   iio: chemical: bme680: Remove remaining ACPI-only stuff
> > > >   iio: chemical: bme680: Sort headers alphabetically
> > > >   iio: chemical: bme680: Remove duplicate register read
> > > >   iio: chemical: bme680: Use bulk reads for calibration data
> > > >   iio: chemical: bme680: Allocate IIO device before chip initialization
> > > >   iio: chemical: bme680: Add read buffers in read/write buffer union
> > > >   iio: chemical: bme680: Make error checks consistent
> > > >   iio: chemical: bme680: Modify startup procedure
> > > >   iio: chemical: bme680: Move probe errors to dev_err_probe()
> > > >   iio: chemical: bme680: Remove redundant gas configuration
> > > >   iio: chemical: bme680: Move forced mode setup in ->read_raw()
> > > >   iio: chemical: bme680: Refactorize reading functions
> > > > 
> > > >  drivers/iio/chemical/bme680.h      |  41 +-
> > > >  drivers/iio/chemical/bme680_core.c | 631 +++++++++++++----------------
> > > >  2 files changed, 291 insertions(+), 381 deletions(-)
> > > > 
> > > > 
> > > > base-commit: 4241665e6ea063a9c1d734de790121a71db763fc
> > > > -- 
> > > > 2.25.1
> > > >     
> > > 
> > > Hi Jonathan,
> > > 
> > > It's been three weeks so I am just checking-in here, to be sure that this
> > > series was not lost in the countless e-mails that you receive. Totally
> > > understand the summer time on top, so no hurry at all, just checking in
> > > that it is not lost! :) Thanks for the amazing job with the reviews
> > > though anyways! :)  
> > 
> > Hi,
> > 
> > It's stalled because of a tree management issue - that is the first
> > few patches were going through fixes-togreg and I'd like to keep
> > the merge fun simple which means they have to end up upstream and
> > back in char-misc/char-misc-next which I then rebase on after
> > an IIO pull request.
> > 
> > They are in char-misc-next as of about 45 mins ago.
> > 
> > It'll be a bit tight for this cycle but my plan is 2 more pull requests
> > with the last one at risk because of timing.  This stuff can only be
> > in that final pull request.
> > 
> > Once it's all in place I will take a final look for but not anticipating
> > needing any changes.
> > 
> > Jonathan
> >   
> 
> Hi Jonathan,
> 
> Ok, since it is not lost perfect! No need to hurry or anything. Thanks!

Applied to the testing branch of iio.git.
Unfortunately the tree juggling meant this hit what is probably a few days
too late to get another pull request out for 6.11.  Hence I'm now treating
this as 6.12 material.  The tree will be rebased  on 6.11-rc1 once available
and pushed out then as togreg with linux-next picking that up.

Thanks,

Jonathan

> 
> Cheers,
> Vasilis
> 
> > 
> >   
> > > 
> > > Cheers,
> > > Vasilis
> > >   
> >   


