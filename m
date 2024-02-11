Return-Path: <linux-iio+bounces-2403-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7298F850A55
	for <lists+linux-iio@lfdr.de>; Sun, 11 Feb 2024 17:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A56621C216C0
	for <lists+linux-iio@lfdr.de>; Sun, 11 Feb 2024 16:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1152837D;
	Sun, 11 Feb 2024 16:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nHEs/4k9"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5999A1DFEF
	for <linux-iio@vger.kernel.org>; Sun, 11 Feb 2024 16:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707669091; cv=none; b=NWbW00+gVmHEJhyPndGAbnATMj6U5DSmLchBUHx+RQxKq+DSJ8kE7VauV4ly4FVJELvWhrcYmzfff6SUBn7hboguRb0KRiyqPZLPoug/mEq7f6bTR9/X6rEyXmd3GLTDJHB7x6EMa2JseVkRlfC6TkCJ8dzDlRDyIz3xi/F5WdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707669091; c=relaxed/simple;
	bh=QkvVoB/NWsbvyEaccJTSMzAhAii4oyZGM3cTdcHV9vc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BXq7cZd2cLPkogVCjQ1MNl7zoSATBou+DEGyvVaUFUuhbAhYFclWFvPaLOi1eGCD2ZeK+hmMBEMcn/sj9sA1Sba5HWL1Y9mpB8lukKZNNvl0c2bkko3dLKjV7lCuG4GMLsSzT9HCK7CcUcrNKDemv/19K3e7q6l5CV0kHz0dT/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nHEs/4k9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43B66C433F1;
	Sun, 11 Feb 2024 16:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707669090;
	bh=QkvVoB/NWsbvyEaccJTSMzAhAii4oyZGM3cTdcHV9vc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nHEs/4k9U2o5sS4zrko8jSHy0MTveeYP7kXc1Gxf0Rv+4+rrUBSLNE766JzduH3oH
	 6UC2wzxMmj+ydr8CQ/b/fyaU1B+DxKa7DcdZLAYngJ4NgoZmOKSHjLtOlUXYY2MjRi
	 rkorxeA/i6hO9+ZGNOQGPuTnSvBw26+ZezYMB5Q9zDcPM85bAnH9NUZeBa6UuCAoMk
	 DrMzUa2jbpwJ1gI+ScDu/fCKFS892gAdrVui7AU+JKIgO//RUrUPYRHKKz7Yv2U+SJ
	 YL6NZQV7U8Tk/Al0rD59kp31eLuD9wDn16mBKCKaIcDVLzcqJbuHM9aOyrm/GVDQPu
	 2gNaziM+NX9rQ==
Date: Sun, 11 Feb 2024 16:31:18 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan LoBue <jlobue10@gmail.com>
Cc: jagathjog1996@gmail.com, luke@ljones.dev, benato.denis96@gmail.com,
 linux-iio@vger.kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>,
 lkml@antheas.dev
Subject: Re: [PATCH 2/2] iio: imu: bmi323: Add and enable ACPI Match Table
Message-ID: <20240211163118.5c306a13@jic23-huawei>
In-Reply-To: <4956451.31r3eYUQgx@nobara-ally-pc>
References: <5769241.DvuYhMxLoT@nobara-ally-pc>
	<20240210164956.3d29e3ee@jic23-huawei>
	<4923946.31r3eYUQgx@nobara-ally-pc>
	<4956451.31r3eYUQgx@nobara-ally-pc>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 10 Feb 2024 14:34:11 -0800
Jonathan LoBue <jlobue10@gmail.com> wrote:

> From c65d1ef44d749958f02d2b9a50a0e788b4497854 Mon Sep 17 00:00:00 2001
> From: Jonathan LoBue <jlobue10@gmail.com>
> Date: Sat, 10 Feb 2024 12:31:54 -0800
> Subject: [PATCH 2/2] iio: imu: bmi323: Add and enable ACPI Match Table
> 
> This patch adds the ACPI match table for ASUS ROG ALLY to load the bmi323
> driver with an ACPI match of "BOSC0200".
> 
> Co-developed-by: Jonathan LoBue <jlobue10@gmail.com>
> Signed-off-by: Jonathan LoBue <jlobue10@gmail.com>
> Co-developed-by: Luke D. Jones <luke@ljones.dev>
> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> Co-developed-by: Denis Benato <benato.denis96@gmail.com>
> Signed-off-by: Denis Benato <benato.denis96@gmail.com>
> Co-developed-by: Antheas Kapenekakis <lkml@antheas.dev>
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>

This approach is sustainable or maintainable. Let's wait to see
what people think of the suggestion I made of a wrapper driver that
is capable of identifying the device and causing the correct driver
to be loaded.

If nothing else this has no DMI type protections so if this one loads on
a board where it is a BMC150 compatible part we'll end up in the same
mess you were seeing just the other way around.

Jonathan



> ---
>  drivers/iio/imu/bmi323/bmi323_i2c.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/iio/imu/bmi323/bmi323_i2c.c b/drivers/iio/imu/bmi323/bmi323_i2c.c
> index 20a8001b9956..346ba2d1a169 100644
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
> @@ -93,6 +94,12 @@ static int bmi323_i2c_probe(struct i2c_client *i2c)
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
> @@ -109,6 +116,7 @@ static struct i2c_driver bmi323_i2c_driver = {
>  	.driver = {
>  		.name = "bmi323",
>  		.of_match_table = bmi323_of_i2c_match,
> +		.acpi_match_table = ACPI_PTR(bmi323_acpi_match),
>  	},
>  	.probe = bmi323_i2c_probe,
>  	.id_table = bmi323_i2c_ids,


