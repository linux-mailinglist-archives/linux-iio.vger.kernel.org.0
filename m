Return-Path: <linux-iio+bounces-11330-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5734B9B179E
	for <lists+linux-iio@lfdr.de>; Sat, 26 Oct 2024 13:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 195A6283D69
	for <lists+linux-iio@lfdr.de>; Sat, 26 Oct 2024 11:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99FC11D433F;
	Sat, 26 Oct 2024 11:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N3EP1xmj"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5357B1D2B37;
	Sat, 26 Oct 2024 11:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729943603; cv=none; b=mvTGmwSECBDkcNa53MSdGmFNkM8EGg5YUfG+/LHdWvWqaPLUieTxZ2QxpJLX+1mcD+s4NlVGBeY40diyPSrf86uWukvvsCG2rWQu+twtkP17mEpe1vcgQwcEZEuuKki75MGA2ffZpU/BKU1dSRv0ByPZBTOEvxgu/NC3aZfflQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729943603; c=relaxed/simple;
	bh=XfAr3XStNZEekdYddwHa04ZWkeXyvdCG8kSc+DIE/p4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qBSu7secZ11dLUc4DGN0kDAK5RfRjLHXoJkk+hYPcqAu2gGJWUwqu5o1IwMV7mMO4OetK9+3SwRhhX/An+coQ/ZvepnZUSejKdzyPWTKicF8LMDTBx1wGn3mPdMmMxoYxj1MWJgP43dU0ZxHWKAuVBIDJS4BRE4WiECuhGaAb3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N3EP1xmj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE72CC4CEC6;
	Sat, 26 Oct 2024 11:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729943602;
	bh=XfAr3XStNZEekdYddwHa04ZWkeXyvdCG8kSc+DIE/p4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=N3EP1xmjmt0RnZysW3uxLZDpHqMOAaTdp3/4kXeyYzsMV4qHfO+NrPb7AZixaOXT8
	 aKzYDa8i+Vb6jXaN05y36fIxnvHqmGTRgPeqHU0uMEv72edaMhliIrWohKTLgxs8aT
	 kZpl+7jd6svRmDwcxEvNOKpZiJLwAIfNKiul7gU+8LpZ09AScSORm61TSZGN1jqVKO
	 C6++E0Gg8AuVGdx9+fzFofTK0hbxqjWW5oR2rMyPmYaoSdnHwH/e8pCGg5d54HgSQt
	 IbuaQrRQ6X7TSGu1lXtwjhzH1/HQJsIwy5yGgQG7ko8wCuJ9/eU69yB2AqAgoJ6dGN
	 MROLelAbURcxg==
Date: Sat, 26 Oct 2024 12:52:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Marius Cristea
 <marius.cristea@microchip.com>, Trevor Gamblin <tgamblin@baylibre.com>,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, Hans de Goede
 <hdegoede@redhat.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v3 21/24] iio: light: isl29018: drop ACPI_PTR() and
 CONFIG_ACPI guards
Message-ID: <20241026125249.68d7b0b1@jic23-huawei>
In-Reply-To: <20241024191200.229894-22-andriy.shevchenko@linux.intel.com>
References: <20241024191200.229894-1-andriy.shevchenko@linux.intel.com>
	<20241024191200.229894-22-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Oct 2024 22:05:10 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> The complexity of config guards needed for ACPI_PTR() is not worthwhile
> for the small amount of saved data. This example was doing it correctly
> but I am proposing dropping this so as to reduce chance of cut and paste
> where it is done wrong.  Also drop now unneeded linux/acpi.h include and
> added linux/mod_devicetable.h for struct acpi_device_id definition.
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
I made one trivial tweak.

> ---
>  drivers/iio/light/isl29018.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/light/isl29018.c b/drivers/iio/light/isl29018.c
> index 526ee5619d26..56e1c915af64 100644
> --- a/drivers/iio/light/isl29018.c
> +++ b/drivers/iio/light/isl29018.c
> @@ -8,17 +8,18 @@
>   * Copyright (c) 2010, NVIDIA Corporation.
>   */
>  
> -#include <linux/module.h>
>  #include <linux/i2c.h>
>  #include <linux/err.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/delay.h>
>  #include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/slab.h>
> +
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> -#include <linux/acpi.h>
>  
>  #define ISL29018_CONV_TIME_MS		100
>  
> @@ -819,15 +820,13 @@ static int isl29018_resume(struct device *dev)
>  static DEFINE_SIMPLE_DEV_PM_OPS(isl29018_pm_ops, isl29018_suspend,
>  				isl29018_resume);
>  
> -#ifdef CONFIG_ACPI
>  static const struct acpi_device_id isl29018_acpi_match[] = {
>  	{"ISL29018", isl29018},
>  	{"ISL29023", isl29023},
>  	{"ISL29035", isl29035},
> -	{},
> +	{}
>  };
>  MODULE_DEVICE_TABLE(acpi, isl29018_acpi_match);
> -#endif
>  
>  static const struct i2c_device_id isl29018_id[] = {
>  	{"isl29018", isl29018},
> @@ -841,14 +840,14 @@ static const struct of_device_id isl29018_of_match[] = {
>  	{ .compatible = "isil,isl29018", },
>  	{ .compatible = "isil,isl29023", },
>  	{ .compatible = "isil,isl29035", },
> -	{ },
> +	{}
	{ }

is my preference where possible. I'm not going to modify the others as would
involve fixing up spacing in lots of code not otherwise touched, but I put the
space back here to simplify a future 'tidy up' patch a tiny bit.

Jonathan

>  };
>  MODULE_DEVICE_TABLE(of, isl29018_of_match);
>  
>  static struct i2c_driver isl29018_driver = {
>  	.driver	 = {
>  			.name = "isl29018",
> -			.acpi_match_table = ACPI_PTR(isl29018_acpi_match),
> +			.acpi_match_table = isl29018_acpi_match,
>  			.pm = pm_sleep_ptr(&isl29018_pm_ops),
>  			.of_match_table = isl29018_of_match,
>  		    },


