Return-Path: <linux-iio+bounces-23855-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A79CAB47B52
	for <lists+linux-iio@lfdr.de>; Sun,  7 Sep 2025 14:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78805189B803
	for <lists+linux-iio@lfdr.de>; Sun,  7 Sep 2025 12:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DB626C3BF;
	Sun,  7 Sep 2025 12:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OrBnPpY9"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E5D10E3;
	Sun,  7 Sep 2025 12:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757248150; cv=none; b=TPwNcRWBKrXbHP2V8FJZIicPQXcyZFxTAsM+CCDQkVpfpP4oEkg0qA3Xh8pqun7m2bpN4Y9DRFYC47xFLO95CFd1xx3Qb8SLaZpIKt4WAZPyHkPjJT8jHuMDd4XFUTDFG9BLXdCwkSRh9R9bNWp1CBJgiiIRfhXsMDbJ4oT7XY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757248150; c=relaxed/simple;
	bh=lrOk0VA+R6ZwUntMvXNUuRMuI5E8D5LF46JNcQ9uRZs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TLTs5G2binfYg2Pack2VoiwYWK2z2KzaGBNhIVyIKsc3NYDP7X7OIz7PdmYRgzM9o4xqquCZLRGC4pqPfsF1IAOC1mudh9/FO34Yx+ebDTbIHsgDQ6NH0pSPZPsMqn3a3xSODVR0iwJOABkyElb2NSL4bwtHgnn3bi/ylIRmJEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OrBnPpY9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC887C4CEF0;
	Sun,  7 Sep 2025 12:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757248150;
	bh=lrOk0VA+R6ZwUntMvXNUuRMuI5E8D5LF46JNcQ9uRZs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OrBnPpY9uDuCCp/0d+JhZD1M20+sOsKJVKiogmHhlSxP+Smh2UciyoYTFRqdfFVZ6
	 /LOFZAsKTd0MnAvsuogDi/c9PHDQPD8FI3hPIPrbrtXPPQOCwKQZlz2xzQavWj4dRE
	 EtFNCsz+wQfliV4UMXxmnnv31G6aONxA1TM7BKJkF1l2hTjUAABxhE896IqRbm18EN
	 irb3OxVzxmCDXCC1gzdPC2Su+aylUgBLn87ybmqkAkjguVAi6kRu/1gQ2gsopL+Yyy
	 0g665dT/yV3EEYfHzWVXW3yL+ZyhZ+C3tV8MJeNE+yX3YFJXMFHIByU1MuPOKbRcol
	 gBz2aCC+qUgRQ==
Date: Sun, 7 Sep 2025 13:29:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>
Subject: Re: [PATCH 02/10] iio: accel: BMA220 split original spi driver
Message-ID: <20250907132902.0286cbe7@jic23-huawei>
In-Reply-To: <20250901194742.11599-3-petre.rodan@subdimension.ro>
References: <20250901194742.11599-1-petre.rodan@subdimension.ro>
	<20250901194742.11599-3-petre.rodan@subdimension.ro>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  1 Sep 2025 22:47:28 +0300
Petre Rodan <petre.rodan@subdimension.ro> wrote:

> Split original driver from bma220_spi.c into bma220_core.c and bma220.h
> with a minimal number of changes in preparation for the next patches.
> 
> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
Hi Petre,

A few comments inline.

Jonathan

> diff --git a/drivers/iio/accel/bma220.h b/drivers/iio/accel/bma220.h
> new file mode 100644
> index 000000000000..0606cf478f5f
> --- /dev/null
> +++ b/drivers/iio/accel/bma220.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Forward declarations needed by the bma220 sources.
> + *
> + * Copyright 2025 Petre Rodan <petre.rodan@subdimension.ro>
> + */
> +
> +#ifndef _BMA220_H
> +#define _BMA220_H
> +
> +#include <linux/iio/iio.h>
Not used so far so don't include it in this header.
> +
> +extern const struct dev_pm_ops bma220_pm_ops;

Probably want a header for that, though I'm not 100% sure if needed
for an extern or not...

> +

struct spi_device;
> +int bma220_common_probe(struct spi_device *dev);
> +
> +#endif
> diff --git a/drivers/iio/accel/bma220_core.c b/drivers/iio/accel/bma220_core.c
> new file mode 100644
> index 000000000000..60fd35637d2d
> --- /dev/null
> +++ b/drivers/iio/accel/bma220_core.c
> @@ -0,0 +1,310 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * BMA220 Digital triaxial acceleration sensor driver
> + *
> + * Copyright (c) 2016,2020 Intel Corporation.
> + */
> +
> +#include <linux/bits.h>
> +#include <linux/kernel.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/types.h>
> +#include <linux/spi/spi.h>
> +
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>

Would expect to see this including the new header.

> +
>  static const struct spi_device_id bma220_spi_id[] = {
>  	{"bma220", 0},
>  	{ }
> @@ -314,17 +33,25 @@ static const struct acpi_device_id bma220_acpi_id[] = {
>  };
>  MODULE_DEVICE_TABLE(spi, bma220_spi_id);
> 
> -static struct spi_driver bma220_driver = {
> +static const struct of_device_id bma220_of_spi_match[] = {

This looks like an unrelated change. Do this in a separate patch.

> +	{ .compatible = "bosch,bma220" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, bma220_of_spi_match);
> +
> +static struct spi_driver bma220_spi_driver = {
>  	.driver = {
>  		.name = "bma220_spi",
>  		.pm = pm_sleep_ptr(&bma220_pm_ops),
> +		.of_match_table = bma220_of_spi_match,
>  		.acpi_match_table = bma220_acpi_id,
>  	},
> -	.probe =            bma220_probe,
> +	.probe =            bma220_spi_probe,
>  	.id_table =         bma220_spi_id,
>  };
> -module_spi_driver(bma220_driver);
> +module_spi_driver(bma220_spi_driver);
> 
>  MODULE_AUTHOR("Tiberiu Breana <tiberiu.a.breana@intel.com>");
> -MODULE_DESCRIPTION("BMA220 acceleration sensor driver");
> -MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("BMA220 triaxial acceleration sensor spi driver");
> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS("IIO_BOSCH_BMA220");
> --
> 2.49.1
> 
> 


