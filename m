Return-Path: <linux-iio+bounces-25365-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A261BFFFF7
	for <lists+linux-iio@lfdr.de>; Thu, 23 Oct 2025 10:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B1C28358DAC
	for <lists+linux-iio@lfdr.de>; Thu, 23 Oct 2025 08:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B0F3019D9;
	Thu, 23 Oct 2025 08:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JS6fqkMR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4A83002AD;
	Thu, 23 Oct 2025 08:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761209212; cv=none; b=UKCPSLOPeSgA7ea2TKMWVdCNggl36rt6yPAkhq+poWvZu5UGA70t3EEQmW3LSKwpC+jYhCVFrxjsSFI1qMqVfxUDzkwrJ7h83hni/Ml34kUfw1hwAMK8PxoM0vNkphz8e8WWr8993qT0LbgObLCBkXkbkyfjk6zhlohiDwPdF2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761209212; c=relaxed/simple;
	bh=rewCY3koomIClorOda9EO46YEMXqpxYEnh31NtOGVa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RXeqfL4MbX3cmKWd7189ydFWAwY1yuJgkKUNA5IO9UEgyJKJpLk3V9Y9DF782WYrK0JzUSMr4ENsyBncgrtrlajGDCkvblXjMaD3A310wgXIqplbmB/owrU8JbPxB0HIrNE1k0sADkRlbA9JIU+Btnjliy25xsIhZV21PPQEPK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JS6fqkMR; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761209211; x=1792745211;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rewCY3koomIClorOda9EO46YEMXqpxYEnh31NtOGVa8=;
  b=JS6fqkMRqzyWshPz1mPy6uQ+QEoPN2AFcRDlecJZMgqb9fyRFGfx0Eml
   egNpobmzF2VUuuu5xsu+xxmZwb8JNyuG14nbUOmxSFbqUNH7JFPri9xdF
   aViGYahlPsLd7cSs/4OkAuei4E3zhzZCZ+TMcD5ntWDDteXxJM3NIPjRC
   aeihn77dqyoepdeSIojdtgz6mv5ZmTdlicKQ+eaVocAiPko10RrEOo+Ut
   SCTbVZLfI7oqPWFJNN5BqpZh6cnWWGsddXORui8LeRa6FJfAiLwc53999
   c4ZAtOSVAvuMAx6FvdllMy1Pd68Io9UPnbKCoxCa8sPX/ogpdkzp3Yetk
   w==;
X-CSE-ConnectionGUID: 1ViLI2/QTx+pMutxSBJVMQ==
X-CSE-MsgGUID: po3g4FD+R9C2ahGcxh839g==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63409788"
X-IronPort-AV: E=Sophos;i="6.19,249,1754982000"; 
   d="scan'208";a="63409788"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 01:46:50 -0700
X-CSE-ConnectionGUID: Be3E+UtjQHyxw+5QccHYvw==
X-CSE-MsgGUID: gQaKyS2VTbyyxLDQfSa6MQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,249,1754982000"; 
   d="scan'208";a="215029445"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.163])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 01:46:46 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vBqy3-00000001tjU-2RIT;
	Thu, 23 Oct 2025 11:46:43 +0300
Date: Thu, 23 Oct 2025 11:46:43 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-iio@vger.kernel.org, joshua.yeong@starfivetech.com,
	devicetree@vger.kernel.org, Carlos Song <carlos.song@nxp.com>,
	Adrian Fluturel <fluturel.adrian@gmail.com>
Subject: Re: [PATCH v6 5/5] iio: magnetometer: Add mmc5633 sensor
Message-ID: <aPnrc-Z5WVJorGr7@smile.fi.intel.com>
References: <20251014-i3c_ddr-v6-0-3afe49773107@nxp.com>
 <20251014-i3c_ddr-v6-5-3afe49773107@nxp.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014-i3c_ddr-v6-5-3afe49773107@nxp.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 14, 2025 at 12:40:04PM -0400, Frank Li wrote:
> Add mmc5633 sensor basic support.
> - Support read 20 bits X/Y/Z magnetic.
> - Support I3C HDR mode to send start measurememt command.
> - Support I3C HDR mode to read all sensors data by one command.

...

> +#include <linux/delay.h>
> +#include <linux/i2c.h>
> +#include <linux/i3c/device.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/init.h>
> +#include <linux/iopoll.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/pm.h>
> +#include <linux/regmap.h>
> +#include <linux/unaligned.h>

Follow IWYU principle, many are missing.

...

> +#define MMC5633_STATUS1_MEAS_T_DONE_BIT	BIT(7)
> +#define MMC5633_STATUS1_MEAS_M_DONE_BIT	BIT(6)

+ bits.h

...

> +#define MMC5633_WAIT_SET_RESET_US	1000

Perhaps (1 * MSEC_PER_USEC) ?

...

> +#define MMC5633_HDR_CTRL0_MEAS_M	0x01
> +#define MMC5633_HDR_CTRL0_MEAS_T	0x03
> +#define MMC5633_HDR_CTRL0_SET		0X05

Keep the style of the values consistent.

> +#define MMC5633_HDR_CTRL0_RESET		0x07

...

> +struct mmc5633_data {
> +	struct device *dev;
> +	struct i3c_device *i3cdev;
> +	struct mutex mutex; /* protect to finish one whole measurement */

+ mutex.h

> +	struct regmap *regmap;
> +};

...

> +static int mmc5633_get_samp_freq_index(struct mmc5633_data *data,
> +				       int val, int val2)
> +{
> +	int i;

Why signed?

> +	for (i = 0; i < ARRAY_SIZE(mmc5633_samp_freq); i++)

+ array_size.h

> +		if (mmc5633_samp_freq[i].val == val &&
> +		    mmc5633_samp_freq[i].val2 == val2)
> +			return i;
> +	return -EINVAL;
> +}

...

> +static int mmc5633_init(struct mmc5633_data *data)
> +{
> +	unsigned int reg_id, ret;

Have you ever compiled this?
Why ret is unsigned?

> +	ret = regmap_read(data->regmap, MMC5633_REG_ID, &reg_id);
> +	if (ret < 0)
> +		return dev_err_probe(data->dev, ret,
> +				     "Error reading product id\n");

+ dev_printk.h

> +	/*
> +	 * Make sure we restore sensor characteristics, by doing
> +	 * a SET/RESET sequence, the axis polarity being naturally
> +	 * aligned after RESET.
> +	 */
> +	ret = regmap_write(data->regmap, MMC5633_REG_CTRL0, MMC5633_CTRL0_SET);
> +	if (ret < 0)
> +		return ret;

> +	fsleep(MMC5633_WAIT_SET_RESET_US);

Do you have a reference to a datasheet? Perhaps add a small comment with it.

> +	ret = regmap_write(data->regmap, MMC5633_REG_CTRL0, MMC5633_CTRL0_RESET);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* set default sampling frequency */
> +	return regmap_update_bits(data->regmap, MMC5633_REG_CTRL1,
> +				  MMC5633_CTRL1_BW_MASK,
> +				  FIELD_PREP(MMC5633_CTRL1_BW_MASK, 0));
> +}

...

> +static int mmc5633_take_measurement(struct mmc5633_data *data, int address)
> +{
> +	unsigned int reg_status;
> +	int ret;
> +	int val;
> +
> +	val = (address == MMC5633_TEMPERATURE) ? MMC5633_CTRL0_MEAS_T : MMC5633_CTRL0_MEAS_M;
> +	ret = regmap_write(data->regmap, MMC5633_REG_CTRL0, val);
> +	if (ret < 0)
> +		return ret;
> +
> +	val = (address == MMC5633_TEMPERATURE) ?
> +	      MMC5633_STATUS1_MEAS_T_DONE_BIT : MMC5633_STATUS1_MEAS_M_DONE_BIT;
> +	ret = regmap_read_poll_timeout(data->regmap, MMC5633_REG_STATUS1, reg_status,
> +				       reg_status & val, 10000, 10000 * 100);

10 * MSEC_PER_USEC, 100 * 10 * MSEC_PER_USEC

> +	if (ret) {
> +		dev_err(data->dev, "data not ready\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}

...

> +static int mmc5633_read_measurement(struct mmc5633_data *data, int address, void *buf, size_t sz)
> +{
> +	u8 data_cmd[2], status[2];
> +	int ret, val, ready;
> +
> +	if (mmc5633_is_support_hdr(data)) {
> +		struct i3c_xfer xfers_wr_cmd[] = {
> +			{
> +				.cmd = 0x3b,
> +				.len = 2,
> +				.data.out = data_cmd,
> +			}
> +		};

> +

Redundant blank line.

> +		struct i3c_xfer xfers_rd_sta_cmd[] = {
> +			{
> +				.cmd = 0x23 | BIT(7), /* RDSTA CMD */
> +				.len = 2,
> +				.data.in = status,
> +			},
> +		};
> +

Ditto.

> +		struct i3c_xfer xfers_rd_data_cmd[] = {
> +			{
> +				.cmd = 0x22 | BIT(7), /* RDLONG CMD */
> +				.len = sz,
> +				.data.in = buf,
> +			},
> +		};
> +
> +		data_cmd[0] = 0;
> +		data_cmd[1] = (address == MMC5633_TEMPERATURE) ?
> +			      MMC5633_HDR_CTRL0_MEAS_T : MMC5633_HDR_CTRL0_MEAS_M;
> +
> +		ret = i3c_device_do_xfers(data->i3cdev, xfers_wr_cmd, 1, I3C_HDR_DDR);
> +		if (ret < 0)
> +			return ret;
> +
> +		ready = (address == MMC5633_TEMPERATURE) ?
> +			MMC5633_STATUS1_MEAS_T_DONE_BIT : MMC5633_STATUS1_MEAS_M_DONE_BIT;
> +		ret = read_poll_timeout(i3c_device_do_xfers, val,
> +					val ||
> +					status[0] & ready,
> +					10000, 10000 * 100, 0,

Use MSEC_PER_USEC as per above.

> +					data->i3cdev, xfers_rd_sta_cmd, 1, I3C_HDR_DDR);

> +

Redundant blank line, and instead...

> +		if (ret || val) {
> +			dev_err(data->dev, "data not ready\n");
> +			return ret ? ret : -EIO;
> +		}

...split this conditional to the linear ones.

> +		return i3c_device_do_xfers(data->i3cdev, xfers_rd_data_cmd, 1, I3C_HDR_DDR);
> +	}
> +
> +	/* Fallback to use SDR/I2C mode */
> +	ret = mmc5633_take_measurement(data, address);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (address == MMC5633_TEMPERATURE)
> +		/*
> +		 * Put tempeature to last byte of buff to align HDR case.
> +		 * I3C will early terminate data read if previous data is not
> +		 * available.
> +		 */
> +		return regmap_bulk_read(data->regmap, MMC5633_REG_TOUT, buf + sz - 1, 1);


> +	return regmap_bulk_read(data->regmap, MMC5633_REG_XOUT_L, buf, sz);
> +}

...

> +#define MMC5633_ALL_SIZE (3 * 3 + 1) /* each channel have 3 byte and TEMP */

have --> has and put comment on top of the definition.

...

> +	char buf[MMC5633_ALL_SIZE];
> +	unsigned int reg;
> +	int ret, i;

Why is 'i' signed?

> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		scoped_guard(mutex, &data->mutex) {

+ cleanup.h

> +			ret = mmc5633_read_measurement(data, chan->address, buf, MMC5633_ALL_SIZE);
> +			if (ret < 0)
> +				return ret;
> +		}
> +
> +		ret = mmc5633_get_raw(data, chan->address, buf, val);
> +		if (ret < 0)
> +			return ret;
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		if (chan->type == IIO_MAGN) {
> +			*val = 0;
> +			*val2 = 62500;
> +		} else {
> +			*val = 0;
> +			*val2 = 800000000; /* 0.8C */
> +		}
> +		return IIO_VAL_INT_PLUS_NANO;
> +	case IIO_CHAN_INFO_OFFSET:
> +		if (chan->type == IIO_TEMP) {
> +			*val = -75;
> +			return IIO_VAL_INT;
> +		}
> +		return -EINVAL;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		scoped_guard(mutex, &data->mutex) {
> +			ret = regmap_read(data->regmap, MMC5633_REG_CTRL1, &reg);
> +			if (ret < 0)
> +				return ret;
> +		}
> +
> +		i = FIELD_GET(MMC5633_CTRL1_BW_MASK, reg);

+ bitfield.h

> +		if (i >= ARRAY_SIZE(mmc5633_samp_freq))
> +			return -EINVAL;
> +
> +		*val = mmc5633_samp_freq[i].val;
> +		*val2 = mmc5633_samp_freq[i].val2;
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	default:
> +		return -EINVAL;
> +	}

...

> +static bool mmc5633_is_writeable_reg(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case MMC5633_REG_CTRL0:
> +	case MMC5633_REG_CTRL1:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}

+ types.h

...

> +static int mmc5633_common_probe(struct device *dev, struct regmap *regmap,
> +				char *name, struct i3c_device *i3cdev)
> +{
> +	struct mmc5633_data *data;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;

+ errno.h

> +	dev_set_drvdata(dev, indio_dev);

+ device.h

> +	data = iio_priv(indio_dev);
> +
> +	data->regmap = regmap;
> +	data->i3cdev = i3cdev;
> +	data->dev = dev;
> +
> +	ret = devm_mutex_init(dev, &data->mutex);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->info = &mmc5633_info;
> +	indio_dev->name = name;
> +	indio_dev->channels = mmc5633_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(mmc5633_channels);
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	ret = mmc5633_init(data);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "mmc5633 chip init failed\n");
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}

...

> +static DEFINE_SIMPLE_DEV_PM_OPS(mmc5633_pm_ops, mmc5633_suspend,
> +				mmc5633_resume);

One line (despite of being longer than 80).

...

> +static const struct of_device_id mmc5633_of_match[] = {
> +	{ .compatible = "memsic,mmc5603", },
> +	{ .compatible = "memsic,mmc5633", },

Remove inner commas.

> +	{ }
> +};

...

> +static int mmc5633_i3c_probe(struct i3c_device *i3cdev)
> +{
> +	struct device *dev = i3cdev_to_dev(i3cdev);
> +	struct regmap *regmap;
> +
> +	regmap = devm_regmap_init_i3c(i3cdev, &mmc5633_regmap_config);
> +	if (IS_ERR(regmap))

+ err.h

> +		return dev_err_probe(dev, PTR_ERR(regmap),
> +				     "Failed to register i3c regmap\n");
> +
> +	return mmc5633_common_probe(dev, regmap, "mmc5633_i3c", i3cdev);
> +}

...

> +static struct i3c_driver mmc5633_i3c_driver = {
> +	.driver = {
> +		.name = "mmc5633_i3c",
> +	},
> +	.probe = mmc5633_i3c_probe,
> +	.id_table = mmc5633_i3c_ids,
> +};

> +

Redundant blank line.

> +module_i3c_i2c_driver(mmc5633_i3c_driver, &mmc5633_i2c_driver)

-- 
With Best Regards,
Andy Shevchenko



