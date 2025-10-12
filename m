Return-Path: <linux-iio+bounces-24960-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 69FF2BD043C
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 16:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E0B9334718B
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 14:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE4D28D82A;
	Sun, 12 Oct 2025 14:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t/jcCrKj"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F69627380A;
	Sun, 12 Oct 2025 14:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760280732; cv=none; b=e0y7DvA3zGAKIndpzoplWxBKbSzMJsBFchDr+AJ2zRuHzCM7tSO5dpQmXoKjiRgn4AGmZje/INO2oA4w3ApXgTXiRlVVNan0DwY433it+YiIJVc1k0CWV/ROBp9I6A5Jst3r5iafQi04Mhj8wgFrL4r1Qk4Hj28arASPJYHpd64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760280732; c=relaxed/simple;
	bh=+hns1WRqUbed1dLoztky59qwC2WsXMTpyZW91wvppkc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZE4oagr8WWIiCiQi+kxs5JUwbUlBymZCxKJJEmoVZzToN6JuFfLTGJFVFe+zPFUEGZEifSRCIsyCHIWZSArsQ/kepLcOyfWpmuIeVF85BrBxfwjYYfGpLV4XVHb2TvWUiZs/AaR8M0Y/7lfhm8wd8fK9u2ilCBDNgiHqMSyE60g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t/jcCrKj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AED7BC4CEE7;
	Sun, 12 Oct 2025 14:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760280730;
	bh=+hns1WRqUbed1dLoztky59qwC2WsXMTpyZW91wvppkc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=t/jcCrKjGaFso5Md/GcJxrgGkj6gjjY9HcddlPtzxVL/WUEXGF91eP9nO7QRCjULO
	 6KvSIognubU1EDigxzePcyGq0FNFYtmYJOMZq+Vnnako1deunxU+fS3EvJ/KNhHDF0
	 PgtYJ1Z+mo9saa0+ZyUxFVmYFhks3ESsJVgNpnn9iyIKPgtsPL3IUjzG90dQ9AL2yc
	 F+gytXl+7F5/AcqQw6whJB8L7FVFDbt3LZ37U3XRiIO5jW20YtKwbohIwrQkvVnr3a
	 JFI9xV2tbldjT0OGfFG76iGVX3ZDcUMdHiSpuNB2R90FgxDxD04IzW4Lc++j2Cxdar
	 ARUdCQNn/SUkA==
Date: Sun, 12 Oct 2025 15:52:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 07/19] iio: accel: bma220: split original driver
Message-ID: <20251012155201.137d330b@jic23-huawei>
In-Reply-To: <20251005-b4-bma220_improvements-v4-7-0f449ba31585@subdimension.ro>
References: <20251005-b4-bma220_improvements-v4-0-0f449ba31585@subdimension.ro>
	<20251005-b4-bma220_improvements-v4-7-0f449ba31585@subdimension.ro>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 05 Oct 2025 16:12:16 +0300
Petre Rodan <petre.rodan@subdimension.ro> wrote:

> In preparation for the i2c module, move the original code into multiple
> source files without any other functional change.
> 
> Create the additional bma220_core module which currently is not
> providing an abstracted bus type (this will change with the regmap
> patch).
> Fix a few includes in the context of this patch.
> 
> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>

It required a bit of hand tweaking after the include tweak I made in the previous patch.
Also due to comments in here I tweaked a bit more:

Please check the result on the iio.git / testing branch.

Whilst I'm not entirely sure Andy won't want to take another look at this it
seemed ok to apply a bit speculatively,

Thanks,

Jonathan

diff --git a/drivers/iio/accel/bma220_core.c b/drivers/iio/accel/bma220_core.c
index 00fe1064486a..050282f20d90 100644
--- a/drivers/iio/accel/bma220_core.c
+++ b/drivers/iio/accel/bma220_core.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/bits.h>
+#include <linux/errno.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
diff --git a/drivers/iio/accel/bma220_spi.c b/drivers/iio/accel/bma220_spi.c
index 70b8bd94895e..761f475a5942 100644
--- a/drivers/iio/accel/bma220_spi.c
+++ b/drivers/iio/accel/bma220_spi.c
@@ -5,7 +5,6 @@
  * Copyright (c) 2016,2020 Intel Corporation.
  */
 
-#include <linux/errno.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/types.h>
@@ -19,12 +18,12 @@ static int bma220_spi_probe(struct spi_device *spi)
 }
 
 static const struct spi_device_id bma220_spi_id[] = {
-       { "bma220", 0 },
+       {"bma220", 0},
        { }
 };
 
 static const struct acpi_device_id bma220_acpi_id[] = {
-       { "BMA0220", 0 },
+       {"BMA0220", 0},
        { }
 };
 MODULE_DEVICE_TABLE(spi, bma220_spi_id);

> ---
> v1->v2
> - split out open firmware table modification into separate patch
> - bma220_write_raw() exits without dev_err() based on similar feedback
>   from David
> - change includes in bma220.h (Jonathan)
> - include bma220.h in bma220_core.c (Jonathan)
> - add mutex.h and pm.h includes to bma220_core.c
> - cleanup struct spacing in bma220_spi.c
> v2->v3
> - keep depends on SPI (David)
> - fix a few includes in bma220_spi.c (Jonathan)
> v2->v3
> - keep depends on SPI (David)
> - fix a few includes in bma220_spi.c (Jonathan)
> - mention new includes in commit body (Jonathan)
> v4 move some of the changes into precursor patches (01-07) (Andy)
> ---
>  drivers/iio/accel/Kconfig       |   8 +-
>  drivers/iio/accel/Makefile      |   3 +-
>  drivers/iio/accel/bma220.h      |  18 +++
>  drivers/iio/accel/bma220_core.c | 319 ++++++++++++++++++++++++++++++++++++++++
>  drivers/iio/accel/bma220_spi.c  | 314 ++-------------------------------------
>  5 files changed, 357 insertions(+), 305 deletions(-)

> diff --git a/drivers/iio/accel/bma220_core.c b/drivers/iio/accel/bma220_core.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..00fe1064486aa469f7ad15593027c7ec86197365
> --- /dev/null
> +++ b/drivers/iio/accel/bma220_core.c
> @@ -0,0 +1,319 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * BMA220 Digital triaxial acceleration sensor driver
> + *
> + * Copyright (c) 2016,2020 Intel Corporation.
> + */
> +
> +#include <linux/bits.h>

Looks like this needs errno.h as per the one you added to _spi.c below.

> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/pm.h>
> +#include <linux/types.h>
> +#include <linux/spi/spi.h>
> +
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
> +
> +#include "bma220.h"
> +
> +#define BMA220_REG_ID				0x00
> +#define BMA220_REG_ACCEL_X			0x02
> +#define BMA220_REG_ACCEL_Y			0x03
> +#define BMA220_REG_ACCEL_Z			0x04
> +#define BMA220_REG_RANGE			0x11
> +#define BMA220_REG_SUSPEND			0x18
> +
> +#define BMA220_CHIP_ID				0xDD
> +#define BMA220_READ_MASK			BIT(7)
> +#define BMA220_RANGE_MASK			GENMASK(1, 0)
> +#define BMA220_SUSPEND_SLEEP			0xFF
> +#define BMA220_SUSPEND_WAKE			0x00
> +
> +#define BMA220_DEVICE_NAME			"bma220"
> +
> +#define BMA220_ACCEL_CHANNEL(index, reg, axis) {			\
> +	.type = IIO_ACCEL,						\
> +	.address = reg,							\
> +	.modified = 1,							\
> +	.channel2 = IIO_MOD_##axis,					\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),		\
> +	.scan_index = index,						\
> +	.scan_type = {							\
> +		.sign = 's',						\
> +		.realbits = 6,						\
> +		.storagebits = 8,					\
> +		.shift = 2,						\
> +		.endianness = IIO_CPU,					\
> +	},								\
> +}
> +
> +enum bma220_axis {
> +	AXIS_X,
> +	AXIS_Y,
> +	AXIS_Z,
> +};
> +
> +static const int bma220_scale_table[][2] = {
> +	{0, 623000}, {1, 248000}, {2, 491000}, {4, 983000},

If you do a white space bracket related separate patch as suggested below
feel free to include this one as:
	{ 0, 623000 }, { 1, 248000 }, { 2, 491000 }, { 4, 983000 },

But don't do it in this split patch.  I don't mind that much if you don't
do it at all.

> +};


> diff --git a/drivers/iio/accel/bma220_spi.c b/drivers/iio/accel/bma220_spi.c
> index abff24a48e5aaa5efb05cdf1924ffea24f4da4c5..70b8bd94895e95936c7294271b5d46d9ec9903c6 100644
> --- a/drivers/iio/accel/bma220_spi.c
> +++ b/drivers/iio/accel/bma220_spi.c
> @@ -5,334 +5,42 @@
>   * Copyright (c) 2016,2020 Intel Corporation.
>   */
>  
> -#include <linux/bits.h>
> +#include <linux/errno.h>

It seems rather unlikely that the split out spi.c file needs this but the previous
more generic one that incorporate pretty much all this code did not.
I checked and it should always have been here so I've added it by tweaking patch 6.


>  #include <linux/mod_devicetable.h>
>  #include <linux/module.h>
> -#include <linux/mutex.h>
> -#include <linux/pm.h>
>  #include <linux/types.h>
>  #include <linux/spi/spi.h>
>  
> -#include <linux/iio/buffer.h>
> -#include <linux/iio/iio.h>
> -#include <linux/iio/sysfs.h>
> -#include <linux/iio/trigger_consumer.h>
> -#include <linux/iio/triggered_buffer.h>
> +#include "bma220.h"

...

> -static int bma220_resume(struct device *dev)
> -{
> -	struct spi_device *spi = to_spi_device(dev);
> -
> -	return bma220_power(spi, true);
> +	return bma220_common_probe(spi);
>  }
> -static DEFINE_SIMPLE_DEV_PM_OPS(bma220_pm_ops, bma220_suspend, bma220_resume);
>  
>  static const struct spi_device_id bma220_spi_id[] = {
> -	{"bma220", 0},
> +	{ "bma220", 0 },

Whist good this is technically an unrelated white space change so
shouldn't really be in this patch.  However if this is only thing that
needs a new spin lets not bother.  Sometimes it's better to just be
a little relaxed on patch split up so we don't waste time on more versions!

>  	{ }
>  };
>  
>  static const struct acpi_device_id bma220_acpi_id[] = {
> -	{"BMA0220", 0},
> +	{ "BMA0220", 0 },
Same here.
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(spi, bma220_spi_id);
>  
> -static struct spi_driver bma220_driver = {
> +static struct spi_driver bma220_spi_driver = {
>  	.driver = {
>  		.name = "bma220_spi",
>  		.pm = pm_sleep_ptr(&bma220_pm_ops),
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
> +MODULE_DESCRIPTION("BMA220 triaxial acceleration sensor spi driver");
>  MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS("IIO_BOSCH_BMA220");
> 


