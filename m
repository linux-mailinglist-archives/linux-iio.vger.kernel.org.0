Return-Path: <linux-iio+bounces-25336-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 91577BF74A4
	for <lists+linux-iio@lfdr.de>; Tue, 21 Oct 2025 17:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 65FFA501444
	for <lists+linux-iio@lfdr.de>; Tue, 21 Oct 2025 15:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF449340DA5;
	Tue, 21 Oct 2025 15:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d/haoI2D"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DD5175A5;
	Tue, 21 Oct 2025 15:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761060061; cv=none; b=KciqlxwTBzB8k3MXg0903LWSrW78QyhjoXwvuMjYNzF+itf05CgpDyQ8/OUPgMnXPoM4zwNoDpMj9AUUSuxSwvR0xMGv988mtum/xQ55+66GW636baQ36g7VKZpBn7UhFORAQYMBD8QUyJBS71Cad6HTY8YdaafQ+HubTL4zyFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761060061; c=relaxed/simple;
	bh=WMiGD5hddPzM8cfebkgUj5fxaHTk5wF5HlqRL6rO1Pg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JPse+0N0WuL1Eiro666p5eS57XnqJ51Cxem2YTYUaR0YGI+h671DAyrQORUv1BdW+hc0nxZM1Uxl5gBKEAe+yhjUB8lagZPRjvS2DCepzo9ESJ4f9YKBOyVG6bPBar4eHYdb+ma2u2tcCOVzVT7rqqatbqrJP+uAHMnMYPfiQyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d/haoI2D; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761060060; x=1792596060;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WMiGD5hddPzM8cfebkgUj5fxaHTk5wF5HlqRL6rO1Pg=;
  b=d/haoI2D9h+virSnpAwYjxRiPo4zWefQNP08aK67eMBjvD3+slK6JUXI
   V1CGidodxVO7cn8qI45Yy2sv0CX1zODtnPrfvxVS7u3dvih3ttrIEgSHr
   1Pw311995+hpQQDedf6nBT+Gt8FwvUuSGbYFWFdpHr6wKPTQlNIpPcnTX
   dlZrhPCQSMac9DXvhEBFL32kIB2yZYqVi0KVoX2kuVXruGPl2iCFjfIW+
   oe5kzu3yDKL9ybtUd8xq2yYc229o/MM9xaQ7bKqcBs1y5dyJTNNxnYndD
   nmee1DebYDlBDgyn8JfW7Rnoc6oAPG8AfTDzZMwIRwy9L/70lPgjs4oEQ
   g==;
X-CSE-ConnectionGUID: 8oGMnwSPTxGe5bv+VfVQsQ==
X-CSE-MsgGUID: i+DWGNXNQFuToFkG/mzNKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="88656154"
X-IronPort-AV: E=Sophos;i="6.19,245,1754982000"; 
   d="scan'208";a="88656154"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 08:20:59 -0700
X-CSE-ConnectionGUID: UROx0HfPSC2FQZ8NlxkCgw==
X-CSE-MsgGUID: GZIbf8neSJ+S7D3yTMQ7hA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,245,1754982000"; 
   d="scan'208";a="182778213"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.245.148])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 08:20:55 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vBEAO-00000001WlQ-1Zoy;
	Tue, 21 Oct 2025 18:20:52 +0300
Date: Tue, 21 Oct 2025 18:20:52 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
Cc: jic23@kernel.org, dlechner@baylibre.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, nuno.sa@analog.com,
	andy@kernel.org, marcelo.schmitt1@gmail.com, vassilisamir@gmail.com,
	salah.triki@gmail.com, skhan@linuxfoundation.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, akhileshpatilvnit@gmail.com
Subject: Re: [PATCH v3 2/2] iio: pressure: adp810: Add driver for adp810
 sensor
Message-ID: <aPek1GqhhyOWFfLG@smile.fi.intel.com>
References: <cover.1761022919.git.akhilesh@ee.iitb.ac.in>
 <5cf1419bff57b906faeb942c5d782d7fe70ad41d.1761022919.git.akhilesh@ee.iitb.ac.in>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cf1419bff57b906faeb942c5d782d7fe70ad41d.1761022919.git.akhilesh@ee.iitb.ac.in>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 21, 2025 at 11:20:30AM +0530, Akhilesh Patil wrote:
> Add driver for Aosong adp810 differential pressure and temperature sensor.
> This sensor provides an I2C interface for reading data.
> Calculate CRC of the data received using standard crc8 library to verify
> data integrity.

Thanks for an update! Looks almost good to me, some comments below.

...

> +M:	Akhilesh Patil <akhilesh@ee.iitb.ac.in>
> +L:	linux-iio@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/iio/pressure/aosong,adp810.yaml

Putting it here makes checkpatch unhappy. If someone thinks that is a false
positive of the tool, perhaps one needs to fix that.

> +F:	drivers/iio/pressure/adp810.c

...

>  # When adding new entries keep the list in alphabetical order
>  obj-$(CONFIG_ABP060MG) += abp060mg.o
> +obj-$(CONFIG_ADP810) += adp810.o
>  obj-$(CONFIG_ROHM_BM1390) += rohm-bm1390.o
>  obj-$(CONFIG_BMP280) += bmp280.o
>  bmp280-objs := bmp280-core.o bmp280-regmap.o
> @@ -15,6 +16,7 @@ obj-$(CONFIG_DPS310) += dps310.o
>  obj-$(CONFIG_IIO_CROS_EC_BARO) += cros_ec_baro.o
>  obj-$(CONFIG_HID_SENSOR_PRESS)   += hid-sensor-press.o
>  obj-$(CONFIG_HP03) += hp03.o
> +obj-$(CONFIG_HP206C) += hp206c.o
>  obj-$(CONFIG_HSC030PA) += hsc030pa.o
>  obj-$(CONFIG_HSC030PA_I2C) += hsc030pa_i2c.o
>  obj-$(CONFIG_HSC030PA_SPI) += hsc030pa_spi.o
> @@ -34,11 +36,9 @@ obj-$(CONFIG_SDP500) += sdp500.o
>  obj-$(CONFIG_IIO_ST_PRESS) += st_pressure.o
>  st_pressure-y := st_pressure_core.o
>  st_pressure-$(CONFIG_IIO_BUFFER) += st_pressure_buffer.o
> +obj-$(CONFIG_IIO_ST_PRESS_I2C) += st_pressure_i2c.o
> +obj-$(CONFIG_IIO_ST_PRESS_SPI) += st_pressure_spi.o
>  obj-$(CONFIG_T5403) += t5403.o
> -obj-$(CONFIG_HP206C) += hp206c.o
>  obj-$(CONFIG_ZPA2326) += zpa2326.o
>  obj-$(CONFIG_ZPA2326_I2C) += zpa2326_i2c.o
>  obj-$(CONFIG_ZPA2326_SPI) += zpa2326_spi.o
> -
> -obj-$(CONFIG_IIO_ST_PRESS_I2C) += st_pressure_i2c.o
> -obj-$(CONFIG_IIO_ST_PRESS_SPI) += st_pressure_spi.o

I would split order fix into a separate change, but if maintainers are okay
with this approach, I would not object.

...

> +#include <linux/cleanup.h>
> +#include <linux/crc8.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/dev_printk.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/mutex.h>
> +#include <linux/unaligned.h>

Something is still missing.

...

> +struct adp810_read_buf {
> +	__be16 dp;
> +	u8 dp_crc;
> +	__be16 tmp;
> +	u8 tmp_crc;
> +	__be16 sf;
> +	u8 sf_crc;

All these types are provided in types.h

> +} __packed;

...

> +static int adp810_measure(struct adp810_data *data, struct adp810_read_buf *buf)
> +{
> +	struct i2c_client *client = data->client;
> +	struct device *dev = &client->dev;
> +	int ret;
> +	u16 trig_cmd = ADP810_TRIGGER_COMMAND;

Shouldn't this be __be16 or __le16? Or is that really a full 16-bit command?
I have a gut feeling that this should be u8 x[2] = { ... }; instead.

> +	/* Send trigger to the sensor for measurement */
> +	ret = i2c_master_send(client, (char *)&trig_cmd, sizeof(trig_cmd));
> +	if (ret < 0) {
> +		dev_err(dev, "Error sending trigger command\n");
> +		return ret;
> +	}
> +	if (ret != sizeof(trig_cmd))
> +		return -EIO;

-EIO is defined down from linux/errno.h.

> +	/*
> +	 * Wait for the sensor to acquire data. As per datasheet section 5.3.1,
> +	 * wait for at least 10ms before reading measurements from the sensor.
> +	 */
> +	msleep(ADP810_MEASURE_LATENCY_MS);
> +
> +	/* Read sensor values */
> +	ret = i2c_master_recv(client, (char *)buf, sizeof(*buf));
> +	if (ret < 0) {
> +		dev_err(dev, "Error reading from sensor\n");
> +		return ret;
> +	}
> +	if (ret != sizeof(*buf))
> +		return -EIO;
> +
> +	/* CRC checks */
> +	crc8_populate_msb(crc_table, ADP810_CRC8_POLYNOMIAL);
> +	if (buf->dp_crc != crc8(crc_table, (u8 *)&buf->dp, 0x2, CRC8_INIT_VALUE)) {
> +		dev_err(dev, "CRC error for pressure\n");
> +		return -EIO;
> +	}
> +
> +	if (buf->tmp_crc != crc8(crc_table, (u8 *)&buf->tmp, 0x2, CRC8_INIT_VALUE)) {
> +		dev_err(dev, "CRC error for temperature\n");
> +		return -EIO;
> +	}
> +
> +	if (buf->sf_crc != crc8(crc_table, (u8 *)&buf->sf, 0x2, CRC8_INIT_VALUE)) {
> +		dev_err(dev, "CRC error for scale\n");
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}

...

> +	indio_dev->num_channels = ARRAY_SIZE(adp810_channels);

ARRAY_SIZE() is defined in a specific header.

-- 
With Best Regards,
Andy Shevchenko



