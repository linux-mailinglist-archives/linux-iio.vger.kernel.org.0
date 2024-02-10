Return-Path: <linux-iio+bounces-2365-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B228F85051A
	for <lists+linux-iio@lfdr.de>; Sat, 10 Feb 2024 17:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4365528304C
	for <lists+linux-iio@lfdr.de>; Sat, 10 Feb 2024 16:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84485BAFC;
	Sat, 10 Feb 2024 16:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="grNJuQwq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FC32B9C2
	for <linux-iio@vger.kernel.org>; Sat, 10 Feb 2024 16:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707582184; cv=none; b=ZBA7n105O47LMy8lybH2ckK7MG77NJWLQoONql+1dEWEW2JfeKlTgyyujHawykyCzYs3qkV9b8PciSE+k5Pa05w+cuosEQoIWXxGMhFhE1qqiQJtkrmketuekkc2dSdaM35rM2tn/VAMKJd1ceynJ1teD/3ThI8Xi/I9IV0bKjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707582184; c=relaxed/simple;
	bh=m5/IhIWvmGMm69QFI1/hmppqp7NDn5OiZ39WOLYAVdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cBiJlptGBd5hYrgJKeIkjiOIsEk2sTsJhtzDkKlFVYDbaIvCEHPIstXd2KnCH9iv4H8LQxT2yCwlBFzT0e4gtoqUBTxG01vkF2rKzPU+8rvbfE8HzhfsPZFTzdBWYzRGA98XEOCt3ZT4F1qkxhhbE7yEyAkv1HN+7iJZaSVq6yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=grNJuQwq; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-297108e7001so763374a91.1
        for <linux-iio@vger.kernel.org>; Sat, 10 Feb 2024 08:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707582182; x=1708186982; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=RqGCAFwdmgpX98tFOq11832/GToazAa+G+LCy7HSWuw=;
        b=grNJuQwq6spg/e8dMzyhmfGyUDncG9iXkXSKPf5vnzG9fTdtlcJeXJCl9WZt4CSptR
         DpCH3mi8ClwvhMTNkiKnL1/f4aVE8jdVMKfVbucIxnD+XwjIGoQtLE35oZMFdfIDkat/
         IPBDBhhIyJB466yK6PQgtEl3ueh9CKvsCf7VvGF4zNZ7IfOwfuMj83NnrPfdDhX1Ra1m
         TJoyPsE0SHM0CY/4XK2YZrb5+r9tVTCl0zxbQkLVFgf++BzHhroBNQH/S2uII3nZj5NS
         9mucQjXzO06U8YxxDBpvE0F+EPLMTzgz7H1Bog8mQ7zpMsFfxf0X/nQOb5Llsh27B3T8
         9KTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707582182; x=1708186982;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RqGCAFwdmgpX98tFOq11832/GToazAa+G+LCy7HSWuw=;
        b=hpHPN3r/TUsshdJOS2kcvJC5zZ8lkCluvY8zT2SJBnhgNojiJbWYLWC6iRmJD1GKPF
         X344uNp9U7ujcMlozxRYz8u93MgObgJPacVTYpgDq6IEc4M5XMhYd9c0qeJZDMt8gUcx
         BNoy6G6WoSiAD6kF0qfdnbNPv38g8LfrMnHSxu3iYF57nZjwtiqmPZGBu1if8DUcEhwl
         s8Ew5y2iuIt1GIi+c/hmpwHi79c7+QsyBuJ9UeBf8O1cGcPkYwWqY2Drl5yYuQvgRGlG
         AC8wcT4z2ktsle8FLwSys5usY+twCc1iARCoQ+h62ECLAJACYvOIJnq4rBVI+yN8ovMQ
         SbhQ==
X-Gm-Message-State: AOJu0YwkzqQxJFyBPiFUH04VifJHQVN+BbKWH0SQRshvPw1TB1kOsvUk
	blewRkwecsnvhLkVFSN3t1y6NQkK3EeNqWLw/q9ibOx2wkJGvFI2
X-Google-Smtp-Source: AGHT+IGL6TYRvEfkfpGFhArelSu4NQtB1cyM6pzklZR5NlFlu4RbSmtp3ZZVKLOKtqTmnBwUVVUsjQ==
X-Received: by 2002:a17:90a:fb43:b0:290:4637:1808 with SMTP id iq3-20020a17090afb4300b0029046371808mr1560189pjb.26.1707582181931;
        Sat, 10 Feb 2024 08:23:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXmMU1TrxjG/x/h68Ibtzy5s17P4RR7F/jHizdLDB0m6TiJD2/smf79UFtjqwX+2ZTfZ0hlojeRs6+SilxYPaLUeEHlePBSK6qdMiEOXasi/md5WQaozaexYA9C2tsLrWIgAS0wjWKVbWa/LZMjvyFtB5pdGLEihqZ7wFceLGLNTtbjVS8ToziybzK7rzBQnmamWN9FIoGMF8CEFfyr72c/kg==
Received: from nobara-ally-pc.localnet (076-167-168-058.res.spectrum.com. [76.167.168.58])
        by smtp.gmail.com with ESMTPSA id rs3-20020a17090b2b8300b00296fcb4e668sm3797659pjb.25.2024.02.10.08.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 08:23:01 -0800 (PST)
From: Jonathan LoBue <jlobue10@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: jagathjog1996@gmail.com, luke@ljones.dev, benato.denis96@gmail.com,
 linux-iio@vger.kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>,
 lkml@antheas.dev
Subject:
 Re: [PATCH] iio: imu: bmi323: Support loading of bmi323 driver for ASUS ROG
 ALLY
Date: Sat, 10 Feb 2024 08:23:00 -0800
Message-ID: <13464735.uLZWGnKmhe@nobara-ally-pc>
In-Reply-To: <20240210152550.72449a50@jic23-huawei>
References:
 <5769241.DvuYhMxLoT@nobara-ally-pc> <20240210152550.72449a50@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2938150.e9J7NaK4W3";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart2938150.e9J7NaK4W3
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Jonathan LoBue <jlobue10@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Date: Sat, 10 Feb 2024 08:23:00 -0800
Message-ID: <13464735.uLZWGnKmhe@nobara-ally-pc>
In-Reply-To: <20240210152550.72449a50@jic23-huawei>
MIME-Version: 1.0

On Saturday, February 10, 2024 7:25:50 AM PST Jonathan Cameron wrote:
> On Fri, 09 Feb 2024 08:05:14 -0800
> Jonathan LoBue <jlobue10@gmail.com> wrote:
> 
> > Due to an ACPI match of "BOSC0200" and existing gyro drivers, the ASUS ROG ALLY attempts to incorrectly load the bmc150 driver.
> > This leaves the gyro inoperable for ASUS ROG ALLY. The correct gyro driver, bmi323, has already been upstreamed as part of the 6.8 kernel changes.
> > In order to load the correct bmi323 driver for ASUS ROG ALLY's gyro, this patch uses a DMI match to unhook the ASUS ROG ALLY from loading the bmc150 driver.
> > This unhooking is also added for the Ayaneo AIR Plus device, as requested by ChimeraOS devs.
> > 
> 
> Please reformat as a patch as per the documentation for submitting patches.
> Wrap the lines to 75 chars in the description.
> 
> > ---
> The cut lines affect what git will pick up and I don't think that's your
> intent.
> 
> More generally I'd just like to confirm I have understood the correctly.
> We have two incompatible devices advertised with the same ACPI ID?
> If anyone has contacts with Bosch or Asus can we chase down how this happened
> and preferably point out to them that it causes problems if they
> through device that don't have actually compatible register sets into
> the same ID.
> 
> I assume this occurred because there is some hyrda of a driver on
> windows that copes with all sorts of different Bosch devices.
> 
> It's a valid bosch ID - I've no idea how bosch issues these but
> normal practice is one per device interface (so if a device register
> compatible you can share an ID, not otherwise).  They have lots of
> ID space (and can trivially get more if they need it)...
> 
> Solution wise, I'm not keen on having having a DMI check against
> particular boards.  Possibly we can add another driver that
> binds just to the BOSCH ID and does just enough querying of the part
> ID (not the identify of the board) to figure out what it is and
> kick of probing the right driver.
> 
> Andy, you see more of this mess I think than anyway, any thoughts on
> how to handle this elegantly?
> 
> Jonathan
> 
> 
> > 
> > --- a/drivers/iio/accel/bmc150-accel-core.c
> > +++ b/drivers/iio/accel/bmc150-accel-core.c
> > @@ -10,6 +10,7 @@
> >  #include <linux/delay.h>
> >  #include <linux/slab.h>
> >  #include <linux/acpi.h>
> > +#include <linux/dmi.h>
> >  #include <linux/of_irq.h>
> >  #include <linux/pm.h>
> >  #include <linux/pm_runtime.h>
> > @@ -1670,6 +1671,9 @@ int bmc150_accel_core_probe(struct device *dev, struct regmap *regmap, int irq,
> >  	struct iio_dev *indio_dev;
> >  	int ret;
> >  
> > +	if (dmi_match(DMI_BOARD_NAME, "RC71L") || (dmi_match(DMI_BOARD_NAME, "AB05-AMD") && dmi_match(DMI_PRODUCT_NAME, "AIR Plus")))
> > +		return -ENODEV; // Abort loading bmc150 for ASUS ROG ALLY, Ayaneo Air Plus
> > +
> >  	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> >  	if (!indio_dev)
> >  		return -ENOMEM;
> > 
> > ---
> > 
> > Now, after this unhooking from bmc150, loading the correct bmi323 driver needs to occur. In order to accomplish this, an ACPI match table is added to bmi323.
> > 
> > ---
> > 
> > --- a/drivers/iio/imu/bmi323/bmi323_i2c.c
> > +++ b/drivers/iio/imu/bmi323/bmi323_i2c.c
> > @@ -5,6 +5,7 @@
> >   * Copyright (C) 2023, Jagath Jog J <jagathjog1996@gmail.com>
> >   */
> >  
> > +#include <linux/acpi.h>
> >  #include <linux/i2c.h>
> >  #include <linux/mod_devicetable.h>
> >  #include <linux/module.h>
> > @@ -93,6 +94,12 @@ static int bmi323_i2c_probe(struct i2c_c
> >  	return bmi323_core_probe(dev);
> >  }
> >  
> > +static const struct acpi_device_id bmi323_acpi_match[] = {
> > +	{"BOSC0200"},
> > +	{ },
> > +};
> > +MODULE_DEVICE_TABLE(acpi, bmi323_acpi_match);
> > +
> >  static const struct i2c_device_id bmi323_i2c_ids[] = {
> >  	{ "bmi323" },
> >  	{ }
> > @@ -109,6 +116,7 @@ static struct i2c_driver bmi323_i2c_driv
> >  	.driver = {
> >  		.name = "bmi323",
> >  		.of_match_table = bmi323_of_i2c_match,
> > +		.acpi_match_table = ACPI_PTR(bmi323_acpi_match),
> >  	},
> >  	.probe = bmi323_i2c_probe,
> >  	.id_table = bmi323_i2c_ids,
> > 
> > ---
> > 
> > Patching these two files in this manner successfully accomplishes unhooking the ASUS ROG ALLY from the bmc150 driver and loading of the bmi323 driver.
> > 
> > Best Regards,
> > Jon LoBue
> > 
> > Co-developed-by: Jonathan LoBue <jlobue10@gmail.com>
> > Signed-off-by: Jonathan LoBue <jlobue10@gmail.com>
> > Co-developed-by: Luke D. Jones <luke@ljones.dev>
> > Signed-off-by: Luke D. Jones <luke@ljones.dev>
> > Co-developed-by: Denis Benato <benato.denis96@gmail.com>
> > Signed-off-by: Denis Benato <benato.denis96@gmail.com>
> > Co-developed-by: Antheas Kapenekakis <lkml@antheas.dev>
> > Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> As above, look up how to submit a kernel patch.
> 
> https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html
> 
> Thanks,
> 
> Jonathan

Thank you for the feedback. I will work to fix the formatting. I must have made a mistake somewhere. I was referring to that exact website while doing this.
The original source for the patch is here: https://github.com/jlobue10/ALLY_Nobara_fixes/raw/main/0003-iio-imu_Add_ROG_ALLY_bmi323-support.patch .
Several Linux distros have been unofficially using it for a while now that I know of (Nobara, Bazzite, Manjaro, ChimeraOS soon).
I will fix that in a future reply. I normally use git diff and perhaps made a mistake trying to do the diff -up method instead. I will fix it.
I understand that other canonical parts may be missing too. This will also be fixed in a future reply.

I completely agree with your assessment. This proposed patch is really meant as a temporary "band-aid" solution.
There should be consensus reached about a better long term solution going forward.
Needing to do the DMI match and abort the loading of the bmc150 driver for ASUS ROG ALLY is a symptom of a larger problem.
The generic identifier "BOSC0200" is not adequate when referring to multiple different devices that the kernel wants to load, which then happens on a first come basis.
I think a better identifier in this case would be something like "BMI323" but this decision should be left up to BOSCH (and ASUS in this case).
The problem is that these identifiers don't really matter for the Windows' side drivers so manufacturers give them little to no extra thought or consideration.
There needs to be some agreement or consensus reached by the manufacturers in this regard. This is a much larger problem with several gyro drivers.
I've had this conversation before and confirmed the larger issue with some ChimeraOS devs. Thanks.

Best Regards,
Jon LoBue

--nextPart2938150.e9J7NaK4W3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEgd5eGdGJaPFBoUcS4obKiQwb1x0FAmXHouQACgkQ4obKiQwb
1x0iuggAqqvKZTNrvfoLRfsGyXgjJZv4SoRhaupy6mi0xiTxgXjep4aABa+2spur
JGztgnSc+mTDplQaWfGopueJdyBZ83pmxRAlPZLlFwO9OPQ34MxTz2GtEbwsCECN
EfUrmntqMlAmZMMuAJgSNmplD4YM+HFha5NVkLJ05AU4pnFGiytQDUmfbzXCM6Y/
UAbi2b5jP1+5Xyx3INhSApw2fX9fetU/qQ3CLSO+0iiJ7QMZlzCzIicj2X0XWEhp
W8/55mr7H+7rwmhVWKELGEndYiYhhe4oq01Kgoyd4oBH7H9wRhCsyZr3GjW2EYdQ
0So+fDQtvaZeJ7OoSZvNkylXNut2Sg==
=Xt1L
-----END PGP SIGNATURE-----

--nextPart2938150.e9J7NaK4W3--




