Return-Path: <linux-iio+bounces-26418-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1C1C8041E
	for <lists+linux-iio@lfdr.de>; Mon, 24 Nov 2025 12:48:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E28AD4E3E36
	for <lists+linux-iio@lfdr.de>; Mon, 24 Nov 2025 11:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF7B2FB0A3;
	Mon, 24 Nov 2025 11:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aaD5YM9D"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FE32737FC;
	Mon, 24 Nov 2025 11:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763984896; cv=none; b=FAXeyWJDoZ0bJPoFrmljBVa5T6gkqldai2gevTooaG9Www2bWMX6encBNDtJNYXtmwzi5cT8brMHe9mHG45ToRdTUxC8/TQvQK8QpmKQh5/s8KbFbVBYYzxBmNnuRJcXEurV4gICyf2vG15xZmVqouVMvlMSXpwwaRNtDzNCfBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763984896; c=relaxed/simple;
	bh=I+2odTLDrAVk5fiUAwlku5IDKTpr0ym0N4sJMaOLlMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gyGcAkZmGXhBB6vIoEg2lEhLqXDDxd4XMmj47see1r5YVSdLU4a4kjoiit6JEmYbRVZTTh8w69VZMULLk7HhkFCKDqfkgtQBh+gd23u7+IWIP1hy0WBhrYmyf4UYjnwNkCpVvOHHlG/bZJDVwhNvLTKszRmkEfsLSZeG4KUy9hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aaD5YM9D; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763984894; x=1795520894;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=I+2odTLDrAVk5fiUAwlku5IDKTpr0ym0N4sJMaOLlMM=;
  b=aaD5YM9Dvc0HvUckQeZWhzZzV7bnXWxnLbwGfgsngMpppskULou7Tbfx
   o+7PNeQmIvf26yYYWmyrvXWG7aPcMCN3ZFeIJblQLBNzaMiUR8JhEvKkg
   +4zTr/fVJXkejZr1kgQaGb8HAVPcPN7If/wNngo2sjfGKPKBmyOzc9ra0
   DYNPdOjYPl++9aDNhL4g0WHATsnkts/wRPw9bC6m03aXyf4fElxqLSWCf
   LOB2Zo926qzCyHYv1F2FhapyhXEQtMFdN1buk1BLp2pEm9GR8VXcx+M8D
   N8BkrKyBZ2vr7cbVnUkdv+nciIYV/x45TPRBbOdijGMny5FAi8W7s7tuf
   A==;
X-CSE-ConnectionGUID: L+F/DDM1QEidxeolFF3nSQ==
X-CSE-MsgGUID: 3vLWnud6QQS+jz++lzB5Ag==
X-IronPort-AV: E=McAfee;i="6800,10657,11622"; a="53544540"
X-IronPort-AV: E=Sophos;i="6.20,222,1758610800"; 
   d="scan'208";a="53544540"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 03:48:13 -0800
X-CSE-ConnectionGUID: JXrenaKRSJanYeLoqtWJsg==
X-CSE-MsgGUID: 5r+rlbgdRy6wGRI+RBD9XA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,222,1758610800"; 
   d="scan'208";a="192779750"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.5])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 03:48:10 -0800
Date: Mon, 24 Nov 2025 13:48:08 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: pressure: add Honeywell ABP2 driver
Message-ID: <aSRF-DL3rKjyFleg@smile.fi.intel.com>
References: <20251122-honeywell_abp2_driver-v1-0-7a8e265f9627@subdimension.ro>
 <20251122-honeywell_abp2_driver-v1-2-7a8e265f9627@subdimension.ro>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251122-honeywell_abp2_driver-v1-2-7a8e265f9627@subdimension.ro>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Nov 22, 2025 at 11:42:45PM +0200, Petre Rodan wrote:
> Adds driver for digital Honeywell ABP2 series of board mount
> pressure and temperature sensors.
> 
> This driver covers 113 different pressure ranges and units on
> both i2c and SPI buses.
> 
> The i2c address is hardcoded and depends on the part number.
> 
> Optional end of conversion interrupt control is present on the
> i2c variants of the chips.
> The EOC gpio can also be defined for the SPI variants if a
> non-ABP2 but compatible chip is to be driven.
> 
> Tested on two different sensors.

> datasheet:
> https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/basic-abp2-series/documents/sps-siot-abp2-series-datasheet-32350268-en.pdf
> 
> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>

Make it Datasheet tag:

Datasheet: https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/basic-abp2-series/documents/sps-siot-abp2-series-datasheet-32350268-en.pdf
Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>

...

> +config ABP2030PA
> +	tristate "Honeywell ABP2 pressure sensor series"
> +	depends on (I2C || SPI_MASTER)
> +	select ABP2030PA_I2C if I2C
> +	select ABP2030PA_SPI if SPI_MASTER
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
> +	help
> +	  Say Y here to build support for the Honeywell ABP2 board mount
> +	  pressure and temperature sensor series.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called abp2030pa.
> +
> +config ABP2030PA_I2C
> +	tristate
> +	depends on ABP2030PA
> +	depends on I2C
> +
> +config ABP2030PA_SPI
> +	tristate
> +	depends on ABP2030PA
> +	depends on SPI_MASTER

Please, do it other way around, i.e. let user define if they want or not to
have the respective glue driver and select the core from each.

...

> +/*
> + * Honeywell ABP2 series pressure sensor driver
> + *
> + * Copyright (c) 2025 Petre Rodan <petre.rodan@subdimension.ro>
> + *
> + * Datasheet: https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/basic-abp2-series/documents/sps-siot-abp2-series-datasheet-32350268-en.pdf

> + *

Redundant blank line.

> + */
> +
> +#include <linux/array_size.h>

+ bits.h
+ completion.h ?

> +#include <linux/delay.h>

+ dev_printk.h
+ device.h
+ errno.h
+ export.h

> +#include <linux/gpio/consumer.h>

+ interrupt.h

> +#include <linux/math64.h>
> +#include <linux/module.h>
> +#include <linux/property.h>
> +#include <linux/regulator/consumer.h>

> +#include <linux/string.h>
> +#include <linux/types.h>
> +#include <linux/units.h>

> +

Redundant blank line.

> +#include <linux/unaligned.h>

...


> +/*
> + * transfer function A: 10%   to 90%   of 2^24

Too many spaces, also this may be a one-line comment.

> + */
> +static const struct abp2_func_spec abp2_func_spec[] = {
> +	[ABP2_FUNCTION_A] = { .output_min = 1677722, .output_max = 15099494 },
> +};

...

> +enum abp2_variants {

Why explicit assignments? Is it related to some HW register?

> +	ABP2001BA = 0x0, ABP21_6BA = 0x1, ABP22_5BA = 0x2, ABP2004BA = 0x3,
> +	ABP2006BA = 0x4, ABP2008BA = 0x5, ABP2010BA = 0x6, ABP2012BA = 0x7,
> +	ABP2001BD = 0x8, ABP21_6BD = 0x9, ABP22_5BD = 0xa, ABP2004BD = 0xb,
> +	ABP2001BG = 0xc, ABP21_6BG = 0xd, ABP22_5BG = 0xe, ABP2004BG = 0xf,
> +	ABP2006BG = 0x10, ABP2008BG = 0x11, ABP2010BG = 0x12, ABP2012BG = 0x13,
> +	ABP2001GG = 0x14, ABP21_2GG = 0x15, ABP2100KA = 0x16, ABP2160KA = 0x17,
> +	ABP2250KA = 0x18, ABP2001KD = 0x19, ABP21_6KD = 0x1a, ABP22_5KD = 0x1b,
> +	ABP2004KD = 0x1c, ABP2006KD = 0x1d, ABP2010KD = 0x1e, ABP2016KD = 0x1f,
> +	ABP2025KD = 0x20, ABP2040KD = 0x21, ABP2060KD = 0x22, ABP2100KD = 0x23,
> +	ABP2160KD = 0x24, ABP2250KD = 0x25, ABP2400KD = 0x26, ABP2001KG = 0x27,
> +	ABP21_6KG = 0x28, ABP22_5KG = 0x29, ABP2004KG = 0x2a, ABP2006KG = 0x2b,
> +	ABP2010KG = 0x2c, ABP2016KG = 0x2d, ABP2025KG = 0x2e, ABP2040KG = 0x2f,
> +	ABP2060KG = 0x30, ABP2100KG = 0x31, ABP2160KG = 0x32, ABP2250KG = 0x33,
> +	ABP2400KG = 0x34, ABP2600KG = 0x35, ABP2800KG = 0x36, ABP2250LD = 0x37,
> +	ABP2600LD = 0x38, ABP2600LG = 0x39, ABP22_5MD = 0x3a, ABP2006MD = 0x3b,
> +	ABP2010MD = 0x3c, ABP2016MD = 0x3d, ABP2025MD = 0x3e, ABP2040MD = 0x3f,
> +	ABP2060MD = 0x40, ABP2100MD = 0x41, ABP2160MD = 0x42, ABP2250MD = 0x43,
> +	ABP2400MD = 0x44, ABP2600MD = 0x45, ABP2006MG = 0x46, ABP2010MG = 0x47,
> +	ABP2016MG = 0x48, ABP2025MG = 0x49, ABP2040MG = 0x4a, ABP2060MG = 0x4b,
> +	ABP2100MG = 0x4c, ABP2160MG = 0x4d, ABP2250MG = 0x4e, ABP2400MG = 0x4f,
> +	ABP2600MG = 0x50, ABP2001ND = 0x51, ABP2002ND = 0x52, ABP2004ND = 0x53,
> +	ABP2005ND = 0x54, ABP2010ND = 0x55, ABP2020ND = 0x56, ABP2030ND = 0x57,
> +	ABP2002NG = 0x58, ABP2004NG = 0x59, ABP2005NG = 0x5a, ABP2010NG = 0x5b,
> +	ABP2020NG = 0x5c, ABP2030NG = 0x5d, ABP2015PA = 0x5e, ABP2030PA = 0x5f,
> +	ABP2060PA = 0x60, ABP2100PA = 0x61, ABP2150PA = 0x62, ABP2175PA = 0x63,
> +	ABP2001PD = 0x64, ABP2005PD = 0x65, ABP2015PD = 0x66, ABP2030PD = 0x67,
> +	ABP2060PD = 0x68, ABP2001PG = 0x69, ABP2005PG = 0x6a, ABP2015PG = 0x6b,
> +	ABP2030PG = 0x6c, ABP2060PG = 0x6d, ABP2100PG = 0x6e, ABP2150PG = 0x6f,
> +	ABP2175PG = 0x70, ABP2_VARIANTS_MAX

If required at all, make sure _MAX occupies a full line:

	ABP2175PG,
	ABP2_VARIANTS_MAX

This allow to avoid unnecessary churn in the future in case of changes here.

> +};

...

> +static const char * const abp2_triplet_variants[ABP2_VARIANTS_MAX] = {
> +	[ABP2001BA] = "001BA", [ABP21_6BA] = "1.6BA", [ABP22_5BA] = "2.5BA",
> +	[ABP2004BA] = "004BA", [ABP2006BA] = "006BA", [ABP2008BA] = "008BA",
> +	[ABP2010BA] = "010BA", [ABP2012BA] = "012BA", [ABP2001BD] = "001BD",
> +	[ABP21_6BD] = "1.6BD", [ABP22_5BD] = "2.5BD", [ABP2004BD] = "004BD",
> +	[ABP2001BG] = "001BG", [ABP21_6BG] = "1.6BG", [ABP22_5BG] = "2.5BG",
> +	[ABP2004BG] = "004BG", [ABP2006BG] = "006BG", [ABP2008BG] = "008BG",
> +	[ABP2010BG] = "010BG", [ABP2012BG] = "012BG", [ABP2001GG] = "001GG",
> +	[ABP21_2GG] = "1.2GG", [ABP2100KA] = "100KA", [ABP2160KA] = "160KA",
> +	[ABP2250KA] = "250KA", [ABP2001KD] = "001KD", [ABP21_6KD] = "1.6KD",
> +	[ABP22_5KD] = "2.5KD", [ABP2004KD] = "004KD", [ABP2006KD] = "006KD",
> +	[ABP2010KD] = "010KD", [ABP2016KD] = "016KD", [ABP2025KD] = "025KD",
> +	[ABP2040KD] = "040KD", [ABP2060KD] = "060KD", [ABP2100KD] = "100KD",
> +	[ABP2160KD] = "160KD", [ABP2250KD] = "250KD", [ABP2400KD] = "400KD",
> +	[ABP2001KG] = "001KG", [ABP21_6KG] = "1.6KG", [ABP22_5KG] = "2.5KG",
> +	[ABP2004KG] = "004KG", [ABP2006KG] = "006KG", [ABP2010KG] = "010KG",
> +	[ABP2016KG] = "016KG", [ABP2025KG] = "025KG", [ABP2040KG] = "040KG",
> +	[ABP2060KG] = "060KG", [ABP2100KG] = "100KG", [ABP2160KG] = "160KG",
> +	[ABP2250KG] = "250KG", [ABP2400KG] = "400KG", [ABP2600KG] = "600KG",
> +	[ABP2800KG] = "800KG", [ABP2250LD] = "250LD", [ABP2600LD] = "600LD",
> +	[ABP2600LG] = "600LG", [ABP22_5MD] = "2.5MD", [ABP2006MD] = "006MD",
> +	[ABP2010MD] = "010MD", [ABP2016MD] = "016MD", [ABP2025MD] = "025MD",
> +	[ABP2040MD] = "040MD", [ABP2060MD] = "060MD", [ABP2100MD] = "100MD",
> +	[ABP2160MD] = "160MD", [ABP2250MD] = "250MD", [ABP2400MD] = "400MD",
> +	[ABP2600MD] = "600MD", [ABP2006MG] = "006MG", [ABP2010MG] = "010MG",
> +	[ABP2016MG] = "016MG", [ABP2025MG] = "025MG", [ABP2040MG] = "040MG",
> +	[ABP2060MG] = "060MG", [ABP2100MG] = "100MG", [ABP2160MG] = "160MG",
> +	[ABP2250MG] = "250MG", [ABP2400MG] = "400MG", [ABP2600MG] = "600MG",
> +	[ABP2001ND] = "001ND", [ABP2002ND] = "002ND", [ABP2004ND] = "004ND",
> +	[ABP2005ND] = "005ND", [ABP2010ND] = "010ND", [ABP2020ND] = "020ND",
> +	[ABP2030ND] = "030ND", [ABP2002NG] = "002NG", [ABP2004NG] = "004NG",
> +	[ABP2005NG] = "005NG", [ABP2010NG] = "010NG", [ABP2020NG] = "020NG",
> +	[ABP2030NG] = "030NG", [ABP2015PA] = "015PA", [ABP2030PA] = "030PA",
> +	[ABP2060PA] = "060PA", [ABP2100PA] = "100PA", [ABP2150PA] = "150PA",
> +	[ABP2175PA] = "175PA", [ABP2001PD] = "001PD", [ABP2005PD] = "005PD",
> +	[ABP2015PD] = "015PD", [ABP2030PD] = "030PD", [ABP2060PD] = "060PD",
> +	[ABP2001PG] = "001PG", [ABP2005PG] = "005PG", [ABP2015PG] = "015PG",
> +	[ABP2030PG] = "030PG", [ABP2060PG] = "060PG", [ABP2100PG] = "100PG",
> +	[ABP2150PG] = "150PG", [ABP2175PG] = "175PG"

Leave trailing comma in place.

> +};

Can be done easier with a macro with more robustness against typos:

#define ABP2_VARIANT(v)		[ABP2 ## v] = ##v

static const char * const abp2_triplet_variants[] = {
	ABP2_VARIANT(001BA), ABP2_VARIANT(1_6BA), ABP2_VARIANT(2_5BA), ABP2_VARIANT(004BA),
	...
};

but this will loose the possibility to make '.' in the name. Up to you.

> +/**
> + * struct abp2_range_config - list of pressure ranges based on nomenclature
> + * @pmin: lowest pressure that can be measured
> + * @pmax: highest pressure that can be measured
> + */
> +struct abp2_range_config {
> +	const s32 pmin;
> +	const s32 pmax;

What is the meaning of 'const' here, please?

> +};

...

> +static int abp2_get_measurement(struct abp2_data *data)
> +{
> +	struct device *dev = data->dev;
> +	int ret;
> +
> +	memset(data->buffer, 0, sizeof(data->buffer));
> +	reinit_completion(&data->completion);
> +
> +	ret = data->ops->write(data, ABP2_CMD_SYNC, ABP2_PKT_SYNC_LEN);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (data->irq > 0) {
> +		ret = wait_for_completion_timeout(&data->completion, HZ);

Where is HZ defined? Include that.

> +		if (!ret) {
> +			dev_err(dev, "timeout waiting for EOC interrupt\n");
> +			return -ETIMEDOUT;
> +		}
> +	} else
> +		fsleep(5000);

Better to have 5 * USEC_PER_MSEC. Also missed comment why this long delay
is needed (will require time.h).

Missed {} as well.

> +	ret = data->ops->read(data, ABP2_CMD_NOP, ABP2_PKT_NOP_LEN);
> +	if (ret < 0)
> +		return ret;
> +
> +	/*
> +	 * status byte flags
> +	 *  bit7 SANITY_CHK     - must always be 0
> +	 *  bit6 ABP2_ST_POWER  - 1 if device is powered
> +	 *  bit5 ABP2_ST_BUSY   - 1 if device has no new conversion ready
> +	 *  bit4 SANITY_CHK     - must always be 0
> +	 *  bit3 SANITY_CHK     - must always be 0
> +	 *  bit2 MEMORY_ERR     - 1 if integrity test has failed
> +	 *  bit1 SANITY_CHK     - must always be 0
> +	 *  bit0 MATH_ERR       - 1 during internal math saturation err
> +	 */
> +
> +	if (data->buffer[0] == (ABP2_ST_POWER | ABP2_ST_BUSY))
> +		return -ETIMEDOUT;
> +
> +	if (data->buffer[0] != ABP2_ST_POWER) {
> +		dev_err(data->dev,
> +			"unexpected status byte 0x%02x\n", data->buffer[0]);
> +		return -ETIMEDOUT;
> +	}

I am not sure the chosen error code in both cases is good enough.

> +	return 0;
> +}

...

> +int abp2_common_probe(struct device *dev, const struct abp2_ops *ops, int irq)
> +{
> +	int ret;
> +	struct abp2_data *data;
> +	struct iio_dev *indio_dev;
> +	const char *triplet;
> +	s64 tmp;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	data->dev = dev;
> +	data->ops = ops;
> +	data->irq = irq;
> +
> +	init_completion(&data->completion);
> +
> +	indio_dev->name = "abp2030pa";
> +	indio_dev->info = &abp2_info;
> +	indio_dev->channels = abp2_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(abp2_channels);

> +	indio_dev->modes = INDIO_DIRECT_MODE;

Doesn't IIO core take care of this?

> +	ret = devm_regulator_get_enable(dev, "vdd");
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "can't get and enable vdd supply\n");
> +
> +	ret = data->ops->init(data->dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = device_property_read_string(dev, "honeywell,pressure-triplet",
> +					  &triplet);
> +	if (ret) {
> +		ret = device_property_read_u32(dev, "honeywell,pmin-pascal",
> +					       &data->pmin);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +				   "honeywell,pmin-pascal could not be read\n");
> +
> +		ret = device_property_read_u32(dev, "honeywell,pmax-pascal",
> +					       &data->pmax);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +				   "honeywell,pmax-pascal could not be read\n");
> +	} else {
> +		ret = device_property_match_property_string(dev,
> +						   "honeywell,pressure-triplet",
> +						   abp2_triplet_variants,
> +						   ABP2_VARIANTS_MAX);
> +		if (ret < 0)
> +			return dev_err_probe(dev, -EINVAL,
> +				     "honeywell,pressure-triplet is invalid\n");
> +
> +		data->pmin = abp2_range_config[ret].pmin;
> +		data->pmax = abp2_range_config[ret].pmax;
> +	}
> +
> +	if (data->pmin >= data->pmax)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "pressure limits are invalid\n");
> +
> +	data->outmin = abp2_func_spec[data->function].output_min;
> +	data->outmax = abp2_func_spec[data->function].output_max;
> +
> +	tmp = div_s64(((s64)(data->pmax - data->pmin)) * NANO,
> +		      data->outmax - data->outmin);
> +	data->p_scale = div_s64_rem(tmp, NANO, &data->p_scale_dec);
> +
> +	tmp = div_s64((s64)data->pmin * (s64)(data->outmax - data->outmin),
> +		      (s64)(data->pmax - data->pmin)) - (s64)(data->outmin);
> +	data->p_offset = tmp;
> +
> +	if (data->irq > 0) {
> +		ret = devm_request_irq(dev, data->irq, abp2_eoc_handler,
> +				       IRQF_TRIGGER_RISING,
> +				       dev_name(dev),
> +				       data);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					  "request irq %d failed\n", data->irq);
> +	}
> +
> +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
> +					      abp2_trigger_handler, NULL);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "iio triggered buffer setup failed\n");
> +
> +	ret = devm_iio_device_register(dev, indio_dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "unable to register iio device\n");
> +
> +	return 0;
> +}

...

> +#ifndef _ABP2030PA_H
> +#define _ABP2030PA_H
> +
> +#include <linux/types.h>
> +
> +#include <linux/iio/iio.h>
> +

> +struct completion;

No, you need a full header because it's not a pointer.

> +struct device;

> +struct iio_chan_spec;
> +struct iio_dev;

When iio/iio.h is included, do we need these two?

> +struct abp2_data;
> +struct abp2_ops;
> +
> +enum abp2_func_id {
> +	ABP2_FUNCTION_A,
> +};
> +
> +/**
> + * struct abp2_data
> + * @dev: current device structure
> + * @ops: pointers for bus specific read, write and init functions
> + * @pmin: minimal pressure in pascal
> + * @pmax: maximal pressure in pascal
> + * @outmin: minimum raw pressure in counts (based on transfer function)
> + * @outmax: maximum raw pressure in counts (based on transfer function)
> + * @function: transfer function
> + * @p_scale: pressure scale
> + * @p_scale_dec: pressure scale, decimal number
> + * @p_offset: pressure offset
> + * @irq: end of conversion - applies only to the i2c sensor
> + * @completion: handshake from irq to read
> + * @scan: channel values for buffered mode
> + * @buffer: raw data provided by sensor
> + */
> +struct abp2_data {
> +	struct device *dev;
> +	const struct abp2_ops *ops;
> +	s32 pmin;
> +	s32 pmax;
> +	u32 outmin;
> +	u32 outmax;
> +	enum abp2_func_id function;
> +	int p_scale;
> +	int p_scale_dec;
> +	int p_offset;
> +	int irq;
> +	struct completion completion;
> +	struct {
> +		u32 chan[2];
> +		aligned_s64 timestamp;
> +	} scan;
> +	u8 buffer[ABP2_MEASUREMENT_RD_SIZE] __aligned(IIO_DMA_MINALIGN);
> +};

> +struct abp2_ops {
> +	int (*init)(struct device *dev);
> +	int (*read)(struct abp2_data *data, const u8 cmd, const u8 cnt);
> +	int (*write)(struct abp2_data *data, const u8 cmd, const u8 cnt);

What is the meaning of const for the POD type parameters? I mean this gives
really a little protection if any. I do not see a point here to have them being const.

> +};

> +int abp2_common_probe(struct device *dev, const struct abp2_ops *ops, int irq);
> +
> +#endif

...

> +#include <linux/device.h>
> +#include <linux/errno.h>
> +#include <linux/i2c.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/types.h>

> +static int abp2_i2c_init(struct device *dev)
> +{
> +	return 0;
> +}

Is this stub required?

...

> +static int abp2_i2c_read(struct abp2_data *data, const u8 unused, const u8 cnt)
> +{
> +	struct i2c_client *client = to_i2c_client(data->dev);
> +	int ret;
> +
> +	if (cnt > ABP2_MEASUREMENT_RD_SIZE)
> +		return -EOVERFLOW;
> +
> +	ret = i2c_master_recv(client, data->buffer, cnt);
> +	if (ret < 0)
> +		return ret;

> +	else if (ret != cnt)

Redundant 'else'.

> +		return -EIO;
> +
> +	return 0;
> +}
> +
> +static int abp2_i2c_write(struct abp2_data *data, const u8 cmd, const u8 unused)
> +{
> +	struct i2c_client *client = to_i2c_client(data->dev);
> +	u8 wdata[ABP2_PKT_SYNC_LEN] = { cmd };
> +	int ret;
> +
> +	ret = i2c_master_send(client, wdata, ABP2_PKT_SYNC_LEN);
> +	if (ret < 0)
> +		return ret;
> +	else if (ret != ABP2_PKT_SYNC_LEN)
> +		return -EIO;

Ditto.

> +	return 0;
> +}
> +
> +static const struct abp2_ops abp2_i2c_ops = {
> +	.init = abp2_i2c_init,
> +	.read = abp2_i2c_read,
> +	.write = abp2_i2c_write,
> +};

So, why can't regmap I²C be used?

...

> +#include <linux/device.h>

Is it used? Or only device/devres.h?

> +#include <linux/errno.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/spi/spi.h>
> +#include <linux/types.h>

...

> +static int abp2_spi_init(struct device *dev)
> +{
> +	struct spi_device *spi = to_spi_device(dev);
> +	struct abp2_spi_buf *buf;
> +
> +	buf = devm_kzalloc(dev, sizeof(*buf), GFP_KERNEL);

Using devm_*() here is most likely a mistake. What is the object lifetime in
comparison to the used device?

> +	if (!buf)
> +		return -ENOMEM;
> +
> +	spi_set_drvdata(spi, buf);
> +
> +	return 0;
> +}

...

> +static int abp2_spi_xfer(struct abp2_data *data, const u8 cmd, const u8 pkt_len)
> +{
> +	struct spi_device *spi = to_spi_device(data->dev);
> +	struct abp2_spi_buf *buf = spi_get_drvdata(spi);
> +	struct spi_transfer xfer;
> +
> +	if (pkt_len > ABP2_MEASUREMENT_RD_SIZE)
> +		return -EOVERFLOW;
> +
> +	buf->tx[0] = cmd;
> +	xfer.tx_buf = buf->tx;
> +	xfer.rx_buf = data->buffer;
> +	xfer.len = pkt_len;
> +
> +	return spi_sync_transfer(spi, &xfer, 1);
> +}
> +
> +static const struct abp2_ops abp2_spi_ops = {
> +	.init = abp2_spi_init,
> +	.read = abp2_spi_xfer,
> +	.write = abp2_spi_xfer,
> +};

Why not regmap SPI?

-- 
With Best Regards,
Andy Shevchenko



