Return-Path: <linux-iio+bounces-7100-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A9191E61E
	for <lists+linux-iio@lfdr.de>; Mon,  1 Jul 2024 19:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2487281C91
	for <lists+linux-iio@lfdr.de>; Mon,  1 Jul 2024 17:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A2B16CD21;
	Mon,  1 Jul 2024 17:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NTO85I9r"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F5A14AD25;
	Mon,  1 Jul 2024 17:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719853256; cv=none; b=BYET85qna82kGSxASxTLs2GVSaiKQSndTLUzE3Jhl67hpbnDN1EThSyqRkW+g3rlqRI+LZLNuWqEtH0jUH66ARyhhqXABe96PjNDG313SecOZHHmFHlPAIZbNf7SjZtbggr5HP6T9XAdQ9gcsXFKXtMOKhciSetymHmm5llxqvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719853256; c=relaxed/simple;
	bh=ekw0DMQar3iKgmubgFqmNT5HhTaIZCTupMRTitjU+U8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iIvfHQoKtkluTd/GAVLEDuqFC3egtg4gBNxvO7ikLFw6A5MQCwGV8nJDykcDGGYjT5C2yOsvajm8JHUMPV/AkR7hpTcMusoX8Xi9C/Mc3L+mZ6Lsmd59mJhwKufCneAJxe4R6Bxu/TXZyvXnB2yyf9HIDfjOfGMoYUxPDADklT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NTO85I9r; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a72988749f0so493673666b.0;
        Mon, 01 Jul 2024 10:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719853253; x=1720458053; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wS6rVccUbUUVIz0RCQ2zkO6umllJPh+yj9iUDxE7Wsw=;
        b=NTO85I9rnY7n9xUHgPlxIH/He4Mt2svz78Bd11jE1CRIH3ZX2mf7A1BqIUI7VF8ReK
         Fvuz7TtOvzSR03xweWbEn6G+2KEyzvA+fkXZoRioIzkFgPbhZYQFqT72LWrk34dVEO71
         FIo1I5CtViCiz677peQSe3D+i921a5IcMkmPN4x9VFCEvCHrJMEvTbWrzZPwISD7DPej
         tuKXbxGPdnaKbApf77MeDZj2AegOyY92MuveL0NbltNOxwVqyHwxf7kC6V52sCbI15kz
         DRa+PXB07bs3WXwo/9ZP/fwlMtUPWxzF4E/ZrUFYh9oRMxkxYyc5V3F/iHH+eol3Wxqw
         A2GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719853253; x=1720458053;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wS6rVccUbUUVIz0RCQ2zkO6umllJPh+yj9iUDxE7Wsw=;
        b=pqBHV6YVVnxYJPURi8smTuelAxeKCE0oqwPWHhHnm9woK+bBrspWEHJlW+knps7WAv
         AAuThXGU0uYSKh7mpCjnGh3ulTKzC+G4Fcr9OWvk1KBhn1KlBgYSErCkBi2IH5tC+Xf1
         TBuQzn7vCtO+psHzErW9gG86gZX/XgJ+/LoDKcpavQoJeKzWUFX+quo6rssPtcQWfS21
         OhsAhTZqSICz08/xHTgyjuomM+3MeaKgGltJad+EAX9E3bExsCN04C1wG0FiQ+vv31g/
         AT/ObEgTyuE9L2/9HJwRgg69XEtMDnZiY5Lj/rBHXSBacyVkWkyIKkumn4J37GXOqIOb
         5taw==
X-Forwarded-Encrypted: i=1; AJvYcCUTVUH/8Nr3EkpQXEddIU4Ic9uPryjr+qXvG1vc79jFBxxhZlWv6jn97ij3+BsSjWaiVxexw9j6Im/1Zx60I3oPtbIK02CGm6gPZHjUoksF6r6nJ/CRAFYH1WRGtmVLFUMl+FuJ2iu4
X-Gm-Message-State: AOJu0Yxfc4L8nB9+8/5o5EkYYutVocoktgDSvYFy5e5UC0yJhe6r4UUj
	XORmPITQGlzulLSu5kUnvBh6ZqRkxapefyPPNOtTrPU+JjZyLUGhC0NmkOKE2qM=
X-Google-Smtp-Source: AGHT+IEe9A5zBfv4Gu/ycdUeuERrUo9VIg62Eo8WIeVJ+4dDYHuhZ1w8sXUPNjCDzb7QDDxyW3cpuw==
X-Received: by 2002:a17:907:971d:b0:a72:a05a:6600 with SMTP id a640c23a62f3a-a75144630d2mr456397066b.7.1719853252593;
        Mon, 01 Jul 2024 10:00:52 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:427:8e07:6fdd:d397])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72aaf1b569sm346207366b.1.2024.07.01.10.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 10:00:51 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Mon, 1 Jul 2024 19:00:49 +0200
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, jic23@kernel.org,
	dpfrey@gmail.com, himanshujha199640@gmail.com, lars@metafoo.de,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	mike.looijmans@topic.nl
Subject: Re: [PATCH v3 00/15] iio: chemical: bme680: Driver cleanup
Message-ID: <20240701170049.GA248279@vamoiridPC>
References: <20240609233826.330516-1-vassilisamir@gmail.com>
 <20240630202640.GA185141@vamoiridPC>
 <20240701134452.00003f1d@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701134452.00003f1d@Huawei.com>

On Mon, Jul 01, 2024 at 01:44:52PM +0100, Jonathan Cameron wrote:
> On Sun, 30 Jun 2024 22:26:40 +0200
> Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> 
> > On Mon, Jun 10, 2024 at 01:38:11AM +0200, Vasileios Amoiridis wrote:
> > > Based on fixes-togreg as the 4 first commits are already applied
> > > 
> > > Patch 1/15: Added comment for explanation of what mutex is used for
> > > 
> > > Patch 2/15: Removed fixes tag
> > > 
> > > Patch 3-15/15: Reworded the commit messages to come close to convention
> > > 	       of 75 chars per line.
> > > 
> > > v2: https://lore.kernel.org/linux-iio/20240606212313.207550-1-vassilisamir@gmail.com/
> > > 
> > > Patch 4/19:
> > > 	- Combined the bme680_conversion_time_us() and bme680_wait_for_eoc()
> > > 	  into one function.
> > > 	- Added better comment for the calculation.
> > > 	- Added checks in the bme680_wait_for_eoc() function.
> > > 
> > > Patch 5/19:
> > > 	- Fixed typo in commit message.
> > > 
> > > Patch 6/19:
> > > 	- Added a fixes tag since without the mutexes, read operations can be
> > > 	  broken.
> > > 
> > > Patch 10/19:
> > > 	- Converted shifting operation to FIELD_GET()
> > > 
> > > Patch 11/19:
> > > 	- Changed convention from &data->bufer[0] to data->buffer.
> > > 	- Removed IIO_DMA_MINALIGN as it is not needed anymore.
> > > 
> > > Patch 13/19:
> > > 	- Removed IIO_DMA_MINALIGN
> > > 
> > > Patch 14/19:
> > > 	- Splitted from Patch v1 14/19
> > > 
> > > Patch 15/19:
> > > 	- Splitted from Patch v1 14/19
> > > 
> > > Patch 16/19: **NEW**
> > > 	- Use dev_err_probe() where applicable.
> > > 
> > > v1: https://lore.kernel.org/linux-iio/20240527183805.311501-1-vassilisamir@gmail.com/
> > > 
> > > This started as a series to add support for buffers and the new
> > > BME688 but it ended up being just a cleaning series. These might
> > > be quite some patches for such a thing but I feel that they are
> > > are well split, in order to allow for better review.
> > > 
> > > The patches are mostly small changes but essential for the correct use
> > > of the driver. The first patches looked like fixes that should be
> > > marked for the stable. Patches [11,17/17] might be a bit bigger but 11/17
> > > is quite straightforward and 17/17 is basically a duplication of a
> > > very similar commit coming from the BMP280 driver [1].
> > > 
> > > In general, the datasheet [2] of the driver is not very descriptive,
> > > and it redirects the user to the BME68x Sensor API [3]. All the things
> > > that were identified from the BME68x Sensor API have been marked with
> > > links to the original locations of the GitHub code. If this is too much
> > > and we don't want this type of information on the commit message, please
> > > let me know and I will fix it.
> > > 
> > > [1]: https://lore.kernel.org/linux-iio/20240512230524.53990-1-vassilisamir@gmail.com/T/#mc6f814e9a4f8c2b39015909d174c7013b3648b9b
> > > [2]: https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bme680-ds001.pdf
> > > [3]: https://github.com/boschsensortec/BME68x_SensorAPI/tree/master
> > > 
> > > 
> > > Vasileios Amoiridis (15):
> > >   iio: chemical: bme680: Fix read/write ops to device by adding mutexes
> > >   iio: chemical: bme680: Fix typo in define
> > >   iio: chemical: bme680: Drop unnecessary casts and correct adc data
> > >     types
> > >   iio: chemical: bme680: Remove remaining ACPI-only stuff
> > >   iio: chemical: bme680: Sort headers alphabetically
> > >   iio: chemical: bme680: Remove duplicate register read
> > >   iio: chemical: bme680: Use bulk reads for calibration data
> > >   iio: chemical: bme680: Allocate IIO device before chip initialization
> > >   iio: chemical: bme680: Add read buffers in read/write buffer union
> > >   iio: chemical: bme680: Make error checks consistent
> > >   iio: chemical: bme680: Modify startup procedure
> > >   iio: chemical: bme680: Move probe errors to dev_err_probe()
> > >   iio: chemical: bme680: Remove redundant gas configuration
> > >   iio: chemical: bme680: Move forced mode setup in ->read_raw()
> > >   iio: chemical: bme680: Refactorize reading functions
> > > 
> > >  drivers/iio/chemical/bme680.h      |  41 +-
> > >  drivers/iio/chemical/bme680_core.c | 631 +++++++++++++----------------
> > >  2 files changed, 291 insertions(+), 381 deletions(-)
> > > 
> > > 
> > > base-commit: 4241665e6ea063a9c1d734de790121a71db763fc
> > > -- 
> > > 2.25.1
> > >   
> > 
> > Hi Jonathan,
> > 
> > It's been three weeks so I am just checking-in here, to be sure that this
> > series was not lost in the countless e-mails that you receive. Totally
> > understand the summer time on top, so no hurry at all, just checking in
> > that it is not lost! :) Thanks for the amazing job with the reviews
> > though anyways! :)
> 
> Hi,
> 
> It's stalled because of a tree management issue - that is the first
> few patches were going through fixes-togreg and I'd like to keep
> the merge fun simple which means they have to end up upstream and
> back in char-misc/char-misc-next which I then rebase on after
> an IIO pull request.
> 
> They are in char-misc-next as of about 45 mins ago.
> 
> It'll be a bit tight for this cycle but my plan is 2 more pull requests
> with the last one at risk because of timing.  This stuff can only be
> in that final pull request.
> 
> Once it's all in place I will take a final look for but not anticipating
> needing any changes.
> 
> Jonathan
> 

Hi Jonathan,

Ok, since it is not lost perfect! No need to hurry or anything. Thanks!

Cheers,
Vasilis

> 
> 
> > 
> > Cheers,
> > Vasilis
> > 
> 

