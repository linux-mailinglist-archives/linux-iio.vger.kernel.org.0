Return-Path: <linux-iio+bounces-2355-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E71C8504EA
	for <lists+linux-iio@lfdr.de>; Sat, 10 Feb 2024 16:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 815BF1C21700
	for <lists+linux-iio@lfdr.de>; Sat, 10 Feb 2024 15:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7385BAD4;
	Sat, 10 Feb 2024 15:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MXas5F6Y"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E36C36AF0
	for <linux-iio@vger.kernel.org>; Sat, 10 Feb 2024 15:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707578763; cv=none; b=K0/q5FmkAy6dgDiwylv32Ok6j+HpWTIhNmxpfiQMYHeB9Bj3ZO6M6jd0amEP5mqXoDL/Gk7C11ZcjihIKpBUHwUH1Uk0PLgNzgDhSo0qdb7+ftj1L8yQiU8t/d95f/l32sRSRStghUz5L6iP2M4EsYjMFhXZTflemWGhdf6oO2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707578763; c=relaxed/simple;
	bh=nNa/n1J9sAHR1IMjOe5MiFHr1M+ApWsIbZ6ImRqeUKU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gA16Ad+9HrnB/B2J6v+NklwXa+IXaArLQA/sPFpF8cuniZXi8llKhzWG3dFTGL8yM0gDUwblFNNZ+/fqK5ua618mLfyNM7vG3QZmdZRmPsmFXOzbIJ+kcow28SbVvKfVQIJWXtk8yt0hcmGntrCksVn7QaQObZgg+rd0XVpgL4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MXas5F6Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 206D3C433C7;
	Sat, 10 Feb 2024 15:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707578763;
	bh=nNa/n1J9sAHR1IMjOe5MiFHr1M+ApWsIbZ6ImRqeUKU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MXas5F6YJoAUtBeZq/a6tN7GbVhQAivzQcYVMhxwvNEpwPqQ1l3XN2IDfU1PJBAiO
	 CgXaXC+JcqvpkTP6iNbmWMEzXXI6hYX1jzJrlCEUqxcrdRUMWYsgFr52JoUcok/nsQ
	 gO4fQALKIfR0op01T/PVvuEGxsgmTwLoEHbAxUsB234VR2ZIu8uPX0E+X+TslLlmOf
	 6WEO/Ws1qp/nDK0oWvpNsCULiDJD/LB8Qe51EH2nkqAWCH5kGiJTC0AbbnR23x8CjF
	 R5nuObdo/g340irWlgG7ScTwSS/m9W+q0nknR/8NuuP0OyzYhNbpS+DIfir4wVuPcY
	 ybSvPak5gFlLQ==
Date: Sat, 10 Feb 2024 15:25:50 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan LoBue <jlobue10@gmail.com>, lkml@antheas.dev
Cc: jagathjog1996@gmail.com, luke@ljones.dev, dbenato.denis96@gmail.com,
 linux-iio@vger.kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] iio: imu: bmi323: Support loading of bmi323 driver for
 ASUS ROG ALLY
Message-ID: <20240210152550.72449a50@jic23-huawei>
In-Reply-To: <5769241.DvuYhMxLoT@nobara-ally-pc>
References: <5769241.DvuYhMxLoT@nobara-ally-pc>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 09 Feb 2024 08:05:14 -0800
Jonathan LoBue <jlobue10@gmail.com> wrote:

> Due to an ACPI match of "BOSC0200" and existing gyro drivers, the ASUS ROG ALLY attempts to incorrectly load the bmc150 driver.
> This leaves the gyro inoperable for ASUS ROG ALLY. The correct gyro driver, bmi323, has already been upstreamed as part of the 6.8 kernel changes.
> In order to load the correct bmi323 driver for ASUS ROG ALLY's gyro, this patch uses a DMI match to unhook the ASUS ROG ALLY from loading the bmc150 driver.
> This unhooking is also added for the Ayaneo AIR Plus device, as requested by ChimeraOS devs.
> 

Please reformat as a patch as per the documentation for submitting patches.
Wrap the lines to 75 chars in the description.

> ---
The cut lines affect what git will pick up and I don't think that's your
intent.

More generally I'd just like to confirm I have understood the correctly.
We have two incompatible devices advertised with the same ACPI ID?
If anyone has contacts with Bosch or Asus can we chase down how this happened
and preferably point out to them that it causes problems if they
through device that don't have actually compatible register sets into
the same ID.

I assume this occurred because there is some hyrda of a driver on
windows that copes with all sorts of different Bosch devices.

It's a valid bosch ID - I've no idea how bosch issues these but
normal practice is one per device interface (so if a device register
compatible you can share an ID, not otherwise).  They have lots of
ID space (and can trivially get more if they need it)...

Solution wise, I'm not keen on having having a DMI check against
particular boards.  Possibly we can add another driver that
binds just to the BOSCH ID and does just enough querying of the part
ID (not the identify of the board) to figure out what it is and
kick of probing the right driver.

Andy, you see more of this mess I think than anyway, any thoughts on
how to handle this elegantly?

Jonathan


> 
> --- a/drivers/iio/accel/bmc150-accel-core.c
> +++ b/drivers/iio/accel/bmc150-accel-core.c
> @@ -10,6 +10,7 @@
>  #include <linux/delay.h>
>  #include <linux/slab.h>
>  #include <linux/acpi.h>
> +#include <linux/dmi.h>
>  #include <linux/of_irq.h>
>  #include <linux/pm.h>
>  #include <linux/pm_runtime.h>
> @@ -1670,6 +1671,9 @@ int bmc150_accel_core_probe(struct device *dev, struct regmap *regmap, int irq,
>  	struct iio_dev *indio_dev;
>  	int ret;
>  
> +	if (dmi_match(DMI_BOARD_NAME, "RC71L") || (dmi_match(DMI_BOARD_NAME, "AB05-AMD") && dmi_match(DMI_PRODUCT_NAME, "AIR Plus")))
> +		return -ENODEV; // Abort loading bmc150 for ASUS ROG ALLY, Ayaneo Air Plus
> +
>  	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
>  	if (!indio_dev)
>  		return -ENOMEM;
> 
> ---
> 
> Now, after this unhooking from bmc150, loading the correct bmi323 driver needs to occur. In order to accomplish this, an ACPI match table is added to bmi323.
> 
> ---
> 
> --- a/drivers/iio/imu/bmi323/bmi323_i2c.c
> +++ b/drivers/iio/imu/bmi323/bmi323_i2c.c
> @@ -5,6 +5,7 @@
>   * Copyright (C) 2023, Jagath Jog J <jagathjog1996@gmail.com>
>   */
>  
> +#include <linux/acpi.h>
>  #include <linux/i2c.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/module.h>
> @@ -93,6 +94,12 @@ static int bmi323_i2c_probe(struct i2c_c
>  	return bmi323_core_probe(dev);
>  }
>  
> +static const struct acpi_device_id bmi323_acpi_match[] = {
> +	{"BOSC0200"},
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(acpi, bmi323_acpi_match);
> +
>  static const struct i2c_device_id bmi323_i2c_ids[] = {
>  	{ "bmi323" },
>  	{ }
> @@ -109,6 +116,7 @@ static struct i2c_driver bmi323_i2c_driv
>  	.driver = {
>  		.name = "bmi323",
>  		.of_match_table = bmi323_of_i2c_match,
> +		.acpi_match_table = ACPI_PTR(bmi323_acpi_match),
>  	},
>  	.probe = bmi323_i2c_probe,
>  	.id_table = bmi323_i2c_ids,
> 
> ---
> 
> Patching these two files in this manner successfully accomplishes unhooking the ASUS ROG ALLY from the bmc150 driver and loading of the bmi323 driver.
> 
> Best Regards,
> Jon LoBue
> 
> Co-developed-by: Jonathan LoBue <jlobue10@gmail.com>
> Signed-off-by: Jonathan LoBue <jlobue10@gmail.com>
> Co-developed-by: Luke D. Jones <luke@ljones.dev>
> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> Co-developed-by: Denis Benato <dbenato.denis96@gmail.com>
> Signed-off-by: Denis Benato <dbenato.denis96@gmail.com>
> Co-developed-by: Antheas Kapenekakis <lkml@antheas.dev>
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
As above, look up how to submit a kernel patch.

https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html

Thanks,

Jonathan




