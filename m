Return-Path: <linux-iio+bounces-2371-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF70D850570
	for <lists+linux-iio@lfdr.de>; Sat, 10 Feb 2024 17:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1F7F1C24572
	for <lists+linux-iio@lfdr.de>; Sat, 10 Feb 2024 16:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9EC5CDF3;
	Sat, 10 Feb 2024 16:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="moIPOB/J"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2535CDF0
	for <linux-iio@vger.kernel.org>; Sat, 10 Feb 2024 16:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707583809; cv=none; b=pa41u19B0N1xuVJ8XR2bNUt36rCr7SEpOVQoHGRBhtGr5R/4V59NE8Di5C1nrjZjOhNQa2gh35yzUxU6R4iHXw3zu4Bk6XuDI3qioczKXXPGVkz18KZnzgjGUPqxn5D77s05Xx6CvUXfhYu3P4nDetshsNe+R17sp8RWbSlYlt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707583809; c=relaxed/simple;
	bh=ElrJ4rSy6lZztBFfl72kAcpsMnvEIJy8Y/lv0py/YXU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BVCUYA5qg9qH7TqurMH0qoqf004LRf5YkBKUEcO/DjYjWKcr4Ar6B3Q6PSdAbUNWfYZ3h0iAWxfAuFQ6oxwwO9417JXtcBSRLphy3K66xmYhAHnmrG3As77WoID3FvCflrYQ29S+WrZWSWBn1PCUY3oq4capX+M0snkw1hluJhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=moIPOB/J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF007C433F1;
	Sat, 10 Feb 2024 16:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707583808;
	bh=ElrJ4rSy6lZztBFfl72kAcpsMnvEIJy8Y/lv0py/YXU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=moIPOB/JUMb9QweYQf8BARPoz3xcXkIBClcwlYchYSPhY750i0OV3TkmMxwLeipqs
	 U3+3SfjbSu+OPCXhxLFhDBMEdDQ8FoqnO888fQTDRI5xERLBeTV5zcga2dRhrdZnF+
	 yIopuX/uIAoJwK00YXiu6dkBE04QxkCD4DbGu16G98JXEBMb+WYVD9e48w/v+8MPMS
	 mwEHbVFezjxaS3N8JidWnmK+5ngCDfvVb28qRrJb8/nIR+a00q8DEuwnpnwaE/9i8s
	 5t1UYdfkr56ApPqKyzMhZ7piTMwu5roKoCMn89ldvr5LyfAGmzfWIHvkReLBNZ3f6W
	 a+Hl/flV9dB6g==
Date: Sat, 10 Feb 2024 16:49:56 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan LoBue <jlobue10@gmail.com>
Cc: jagathjog1996@gmail.com, luke@ljones.dev, benato.denis96@gmail.com,
 linux-iio@vger.kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>,
 lkml@antheas.dev
Subject: Re: [PATCH] iio: imu: bmi323: Support loading of bmi323 driver for
 ASUS ROG ALLY
Message-ID: <20240210164956.3d29e3ee@jic23-huawei>
In-Reply-To: <13464735.uLZWGnKmhe@nobara-ally-pc>
References: <5769241.DvuYhMxLoT@nobara-ally-pc>
	<20240210152550.72449a50@jic23-huawei>
	<13464735.uLZWGnKmhe@nobara-ally-pc>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 10 Feb 2024 08:23:00 -0800
Jonathan LoBue <jlobue10@gmail.com> wrote:

> On Saturday, February 10, 2024 7:25:50 AM PST Jonathan Cameron wrote:
> > On Fri, 09 Feb 2024 08:05:14 -0800
> > Jonathan LoBue <jlobue10@gmail.com> wrote:
> >   
> > > Due to an ACPI match of "BOSC0200" and existing gyro drivers, the ASUS ROG ALLY attempts to incorrectly load the bmc150 driver.
> > > This leaves the gyro inoperable for ASUS ROG ALLY. The correct gyro driver, bmi323, has already been upstreamed as part of the 6.8 kernel changes.
> > > In order to load the correct bmi323 driver for ASUS ROG ALLY's gyro, this patch uses a DMI match to unhook the ASUS ROG ALLY from loading the bmc150 driver.
> > > This unhooking is also added for the Ayaneo AIR Plus device, as requested by ChimeraOS devs.
> > >   
> > 
> > Please reformat as a patch as per the documentation for submitting patches.
> > Wrap the lines to 75 chars in the description.
> >   
> > > ---  
> > The cut lines affect what git will pick up and I don't think that's your
> > intent.
> > 
> > More generally I'd just like to confirm I have understood the correctly.
> > We have two incompatible devices advertised with the same ACPI ID?
> > If anyone has contacts with Bosch or Asus can we chase down how this happened
> > and preferably point out to them that it causes problems if they
> > through device that don't have actually compatible register sets into
> > the same ID.
> > 
> > I assume this occurred because there is some hyrda of a driver on
> > windows that copes with all sorts of different Bosch devices.
> > 
> > It's a valid bosch ID - I've no idea how bosch issues these but
> > normal practice is one per device interface (so if a device register
> > compatible you can share an ID, not otherwise).  They have lots of
> > ID space (and can trivially get more if they need it)...
> > 
> > Solution wise, I'm not keen on having having a DMI check against
> > particular boards.  Possibly we can add another driver that
> > binds just to the BOSCH ID and does just enough querying of the part
> > ID (not the identify of the board) to figure out what it is and
> > kick of probing the right driver.
> > 
> > Andy, you see more of this mess I think than anyway, any thoughts on
> > how to handle this elegantly?
> > 
> > Jonathan
> > 
> >   
> > > 
> > > --- a/drivers/iio/accel/bmc150-accel-core.c
> > > +++ b/drivers/iio/accel/bmc150-accel-core.c
> > > @@ -10,6 +10,7 @@
> > >  #include <linux/delay.h>
> > >  #include <linux/slab.h>
> > >  #include <linux/acpi.h>
> > > +#include <linux/dmi.h>
> > >  #include <linux/of_irq.h>
> > >  #include <linux/pm.h>
> > >  #include <linux/pm_runtime.h>
> > > @@ -1670,6 +1671,9 @@ int bmc150_accel_core_probe(struct device *dev, struct regmap *regmap, int irq,
> > >  	struct iio_dev *indio_dev;
> > >  	int ret;
> > >  
> > > +	if (dmi_match(DMI_BOARD_NAME, "RC71L") || (dmi_match(DMI_BOARD_NAME, "AB05-AMD") && dmi_match(DMI_PRODUCT_NAME, "AIR Plus")))
> > > +		return -ENODEV; // Abort loading bmc150 for ASUS ROG ALLY, Ayaneo Air Plus
> > > +
> > >  	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> > >  	if (!indio_dev)
> > >  		return -ENOMEM;
> > > 
> > > ---
> > > 
> > > Now, after this unhooking from bmc150, loading the correct bmi323 driver needs to occur. In order to accomplish this, an ACPI match table is added to bmi323.
> > > 
> > > ---
> > > 
> > > --- a/drivers/iio/imu/bmi323/bmi323_i2c.c
> > > +++ b/drivers/iio/imu/bmi323/bmi323_i2c.c
> > > @@ -5,6 +5,7 @@
> > >   * Copyright (C) 2023, Jagath Jog J <jagathjog1996@gmail.com>
> > >   */
> > >  
> > > +#include <linux/acpi.h>
> > >  #include <linux/i2c.h>
> > >  #include <linux/mod_devicetable.h>
> > >  #include <linux/module.h>
> > > @@ -93,6 +94,12 @@ static int bmi323_i2c_probe(struct i2c_c
> > >  	return bmi323_core_probe(dev);
> > >  }
> > >  
> > > +static const struct acpi_device_id bmi323_acpi_match[] = {
> > > +	{"BOSC0200"},
> > > +	{ },
> > > +};
> > > +MODULE_DEVICE_TABLE(acpi, bmi323_acpi_match);
> > > +
> > >  static const struct i2c_device_id bmi323_i2c_ids[] = {
> > >  	{ "bmi323" },
> > >  	{ }
> > > @@ -109,6 +116,7 @@ static struct i2c_driver bmi323_i2c_driv
> > >  	.driver = {
> > >  		.name = "bmi323",
> > >  		.of_match_table = bmi323_of_i2c_match,
> > > +		.acpi_match_table = ACPI_PTR(bmi323_acpi_match),
> > >  	},
> > >  	.probe = bmi323_i2c_probe,
> > >  	.id_table = bmi323_i2c_ids,
> > > 
> > > ---
> > > 
> > > Patching these two files in this manner successfully accomplishes unhooking the ASUS ROG ALLY from the bmc150 driver and loading of the bmi323 driver.
> > > 
> > > Best Regards,
> > > Jon LoBue
> > > 
> > > Co-developed-by: Jonathan LoBue <jlobue10@gmail.com>
> > > Signed-off-by: Jonathan LoBue <jlobue10@gmail.com>
> > > Co-developed-by: Luke D. Jones <luke@ljones.dev>
> > > Signed-off-by: Luke D. Jones <luke@ljones.dev>
> > > Co-developed-by: Denis Benato <benato.denis96@gmail.com>
> > > Signed-off-by: Denis Benato <benato.denis96@gmail.com>
> > > Co-developed-by: Antheas Kapenekakis <lkml@antheas.dev>
> > > Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>  
> > As above, look up how to submit a kernel patch.
> > 
> > https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html
> > 
> > Thanks,
> > 
> > Jonathan  
> 
> Thank you for the feedback. I will work to fix the formatting. I must have made a mistake somewhere. I was referring to that exact website while doing this.
> The original source for the patch is here: https://github.com/jlobue10/ALLY_Nobara_fixes/raw/main/0003-iio-imu_Add_ROG_ALLY_bmi323-support.patch .
> Several Linux distros have been unofficially using it for a while now that I know of (Nobara, Bazzite, Manjaro, ChimeraOS soon).
> I will fix that in a future reply. I normally use git diff and perhaps made a mistake trying to do the diff -up method instead. I will fix it.
> I understand that other canonical parts may be missing too. This will also be fixed in a future reply.
> 
> I completely agree with your assessment. This proposed patch is really meant as a temporary "band-aid" solution.
> There should be consensus reached about a better long term solution going forward.
> Needing to do the DMI match and abort the loading of the bmc150 driver for ASUS ROG ALLY is a symptom of a larger problem.
> The generic identifier "BOSC0200" is not adequate when referring to multiple different devices that the kernel wants to load, which then happens on a first come basis.
> I think a better identifier in this case would be something like "BMI323" but this decision should be left up to BOSCH (and ASUS in this case).
It needs to be a compliant ACPI ID.  BOSC is Bosch's valid manufacturer ID.
The code after that tends to just be allocated by someone inside the company
who keeps a bit list of IDs  (I have access to the list of HiSilicon HISIXXXX ones for
example but no idea how Bosch manages this.)

> The problem is that these identifiers don't really matter for the Windows' side drivers so manufacturers give them little to no extra thought or consideration.
> There needs to be some agreement or consensus reached by the manufacturers in this regard. This is a much larger problem with several gyro drivers.
> I've had this conversation before and confirmed the larger issue with some ChimeraOS devs. Thanks.

Sure. Please also wrap your emails to the mailing list to under 80 chars (roughly).


> 
> Best Regards,
> Jon LoBue


