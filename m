Return-Path: <linux-iio+bounces-8750-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 364D995DD3A
	for <lists+linux-iio@lfdr.de>; Sat, 24 Aug 2024 11:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2E31283642
	for <lists+linux-iio@lfdr.de>; Sat, 24 Aug 2024 09:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B71154C07;
	Sat, 24 Aug 2024 09:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DzwdW320"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E166F2F29;
	Sat, 24 Aug 2024 09:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724492922; cv=none; b=TDVIXPi2xg3Mpbs2ubZeq0aqUyEUFOs09uotPQGmJTEd7SyHwmg6iHaPLlYkEAglpxQxrDOVpiGuzFQXO3fPjWxsgZ09yymGsHfYjeLFM/59BQHl0TXDs2OX8D1A0i/LbdetqnmkzDgZAmj1lc1bC/QUfvy/2YuQiyjEe3xm8Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724492922; c=relaxed/simple;
	bh=U9qA75G3HAmwwPtyCBr0VKQBu2e5YyeylXMjH6DLAr8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OwDL82GxTnYDj/d9kKRoUyEKu0A4/8a8XKwSt08x4mFFF3hs84O760JJlsBryTA47+SNTDgsEcYaBtrAMBtIqy0HcPN5s7IPtrE/6RVJfCxYm1wnSaiBW7wH3mQbQHOLnvjR7xgBgdnG3eUhnpPzRgc32Vjcyvjk2oFc2jgfqEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DzwdW320; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 124DAC32781;
	Sat, 24 Aug 2024 09:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724492921;
	bh=U9qA75G3HAmwwPtyCBr0VKQBu2e5YyeylXMjH6DLAr8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DzwdW320glzfcJQpFUSeBLxnrDc1M8/oKE1nh843+zRpjXB+4oE7VXJSUPidaLuE0
	 fmBxxBZB+Pubd7VC4lutZhRM6YE+wxGwKJD3kys5ALItoDmyFVQA3tX5UN/Uc7Tg+g
	 luJ0CoWAl40MVDLdOac9kOXIFqUPaW8z32v8D/Zo+r2eqxqyY4dnpU085HrS4rAX98
	 XhppKuiR/xdD4bLQ2QHYfPt21X0Qn2gFMXSDnhCNsIXdSM0j+8dJP14UnvzJECcOPC
	 JWKHV4Osgw74YU67TWZJBue9A1D7nwbstWBtf20xrD8B4+jPR90gZlBM71bHybRE96
	 6QvTj9/X1M10A==
Date: Sat, 24 Aug 2024 10:48:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 1/1] iio: accel: bmc150: use fwnode_irq_get_byname()
Message-ID: <20240824104832.68575484@jic23-huawei>
In-Reply-To: <20240823230056.745872-1-andy.shevchenko@gmail.com>
References: <20240823230056.745872-1-andy.shevchenko@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 24 Aug 2024 02:00:56 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> Use the generic fwnode_irq_get_byname() in place of of_irq_get_byname()
> to get the IRQ number from the interrupt pin.
> 
> Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Applied
> ---
>  drivers/iio/accel/bmc150-accel-core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
> index 03121d020470..14ce03c70ab5 100644
> --- a/drivers/iio/accel/bmc150-accel-core.c
> +++ b/drivers/iio/accel/bmc150-accel-core.c
> @@ -10,9 +10,9 @@
>  #include <linux/delay.h>
>  #include <linux/slab.h>
>  #include <linux/acpi.h>
> -#include <linux/of_irq.h>
>  #include <linux/pm.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/property.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
>  #include <linux/iio/buffer.h>
> @@ -514,7 +514,7 @@ static void bmc150_accel_interrupts_setup(struct iio_dev *indio_dev,
>  	 */
>  	irq_info = bmc150_accel_interrupts_int1;
>  	if (data->type == BOSCH_BMC156 ||
> -	    irq == of_irq_get_byname(dev->of_node, "INT2"))
> +	    irq == fwnode_irq_get_byname(dev_fwnode(dev), "INT2"))
>  		irq_info = bmc150_accel_interrupts_int2;
>  
>  	for (i = 0; i < BMC150_ACCEL_INTERRUPTS; i++)


