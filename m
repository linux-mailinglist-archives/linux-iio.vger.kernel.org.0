Return-Path: <linux-iio+bounces-25890-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 137D4C32435
	for <lists+linux-iio@lfdr.de>; Tue, 04 Nov 2025 18:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 275E04F44B6
	for <lists+linux-iio@lfdr.de>; Tue,  4 Nov 2025 17:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2736340261;
	Tue,  4 Nov 2025 17:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HZcSvz0d"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50725339B4A;
	Tue,  4 Nov 2025 17:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762276054; cv=none; b=jBceTWW8XjrrNt1IzGvc5EFyW+TmKXfvd6DQxDjGi0w9Q0Uwcjhi27iWLGRW2qdIQPYYgADKvaNyeQtrAvniSHsFaNmiYaP8VgP6XNnuLC3bwNy/bShZ44riaFVfQmwxtwO+23S9zC8tJ28gGSpegp0cSZBNtayHL6sB38EBFo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762276054; c=relaxed/simple;
	bh=tjZDy+bbfTRIT7A33Ys+suJnpcHjHb0ey6JSW0sBkh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HmluXD71dDQC0i3/1HlGftnYCSdAy2tsVcGEo1bH98xCwg1SkyHeoiQ6ZR0Vq+AFPKyJfX8YjEufywdXePo9/sYLr0B4oOfCx9PPlAZUrTaIPTDNnlazSZW5R/Wau+Ixrei8imBvZ7qFzSNmySpUj81UGakX036fFE+Yyc4vvGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HZcSvz0d; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762276052; x=1793812052;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tjZDy+bbfTRIT7A33Ys+suJnpcHjHb0ey6JSW0sBkh4=;
  b=HZcSvz0dekH0p3u8JLe3SV8dEooJ5Fu5SuAuziPzPOHmuu/bj816Cmky
   FyU7MVOCQazLPDg6Z6+bDq446yIDrXNpVWKed88gEHYbv27CsummRxnGw
   DkVCbw5pAictM7s+fgPcJ7bQmfF6hZiSsnC36VXUOVzfstK2JY49mi+LO
   QSF595e8iC9/uoRlcOgCPyDrcwNRixyxIYMOZlRqIY3zKKYwZ80u5SEwO
   DHsFyOPh5J6M92j9s22VxVg9Y58EYr6LWU8BDeo0mQoLjvaE5v8EmRmav
   4BPkt7OfdVQMlvqJ7rcp7b1gu8b0V/io1dLvIvAnnFwGu1jhtwGgQK3Kc
   w==;
X-CSE-ConnectionGUID: nGBnL33gQ+y/Rx1EgpNJsQ==
X-CSE-MsgGUID: qCiRY6vCTkis7JTmkMVf7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="89841570"
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; 
   d="scan'208";a="89841570"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 09:07:31 -0800
X-CSE-ConnectionGUID: h07Mzje5RYuXU8oKHsBsng==
X-CSE-MsgGUID: Kaqmb30wTj+M6epZeJiUpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; 
   d="scan'208";a="210708461"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.245.146])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 09:07:28 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vGKVA-00000005WPE-32wY;
	Tue, 04 Nov 2025 19:07:24 +0200
Date: Tue, 4 Nov 2025 19:07:24 +0200
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
	devicetree@vger.kernel.org, linux@roeck-us.net,
	Carlos Song <carlos.song@nxp.com>,
	Adrian Fluturel <fluturel.adrian@gmail.com>
Subject: Re: [PATCH v10 6/6] iio: magnetometer: Add mmc5633 sensor
Message-ID: <aQoyzHrQB-egSPqR@smile.fi.intel.com>
References: <20251104-i3c_ddr-v10-0-e3e4cbc17034@nxp.com>
 <20251104-i3c_ddr-v10-6-e3e4cbc17034@nxp.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104-i3c_ddr-v10-6-e3e4cbc17034@nxp.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 04, 2025 at 10:46:44AM -0500, Frank Li wrote:
> Add mmc5633 sensor basic support.
> - Support read 20 bits X/Y/Z magnetic.
> - Support I3C HDR mode to send start measurememt command.
> - Support I3C HDR mode to read all sensors data by one command.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
with some nit-picks below.

...

> +static int mmc5633_take_measurement(struct mmc5633_data *data, int address)
> +{
> +	unsigned int reg_status;
> +	int ret;

> +	int val;

regmap API uses unsigned int for value field.

> +	val = (address == MMC5633_TEMPERATURE) ? MMC5633_CTRL0_MEAS_T : MMC5633_CTRL0_MEAS_M;
> +	ret = regmap_write(data->regmap, MMC5633_REG_CTRL0, val);
> +	if (ret < 0)
> +		return ret;
> +
> +	val = (address == MMC5633_TEMPERATURE) ?
> +	      MMC5633_STATUS1_MEAS_T_DONE_BIT : MMC5633_STATUS1_MEAS_M_DONE_BIT;
> +	ret = regmap_read_poll_timeout(data->regmap, MMC5633_REG_STATUS1, reg_status,
> +				       reg_status & val,
> +				       10 * USEC_PER_MSEC,
> +				       100 * 10 * USEC_PER_MSEC);
> +	if (ret) {
> +		dev_err(regmap_get_device(data->regmap), "data not ready\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}

...

> +static int mmc5633_read_measurement(struct mmc5633_data *data, int address, void *buf, size_t sz)
> +{
> +	struct device *dev = regmap_get_device(data->regmap);
> +	u8 data_cmd[2], status[2];
> +	int ret, val, ready;

Ditto.

> +	if (mmc5633_is_support_hdr(data)) {
> +		struct i3c_xfer xfers_wr_cmd[] = {
> +			{
> +				.cmd = 0x3b,
> +				.len = 2,
> +				.data.out = data_cmd,
> +			}
> +		};
> +		struct i3c_xfer xfers_rd_sta_cmd[] = {
> +			{
> +				.cmd = 0x23 | BIT(7), /* RDSTA CMD */
> +				.len = 2,
> +				.data.in = status,
> +			},
> +		};
> +		struct i3c_xfer xfers_rd_data_cmd[] = {
> +			{
> +				.cmd = 0x22 | BIT(7), /* RDLONG CMD */
> +				.len = sz,
> +				.data.in = buf,
> +			},
> +		};

Still do not see a justification for an array to use, but as I said I leave it
to Jonathan to decide.

> +		data_cmd[0] = 0;
> +		data_cmd[1] = (address == MMC5633_TEMPERATURE) ?
> +			      MMC5633_HDR_CTRL0_MEAS_T : MMC5633_HDR_CTRL0_MEAS_M;
> +
> +		ret = i3c_device_do_xfers(data->i3cdev, xfers_wr_cmd,
> +					  ARRAY_SIZE(xfers_wr_cmd), I3C_HDR_DDR);
> +		if (ret < 0)
> +			return ret;
> +
> +		ready = (address == MMC5633_TEMPERATURE) ?
> +			MMC5633_STATUS1_MEAS_T_DONE_BIT : MMC5633_STATUS1_MEAS_M_DONE_BIT;
> +		ret = read_poll_timeout(i3c_device_do_xfers, val,

> +					val ||
> +					status[0] & ready,

One line and probably you want to add parentheses for better understanding, not
everybody remembers the operator precedence by heart.

> +					10 * USEC_PER_MSEC,
> +					100 * 10 * USEC_PER_MSEC, 0,
> +					data->i3cdev, xfers_rd_sta_cmd,
> +					ARRAY_SIZE(xfers_rd_sta_cmd), I3C_HDR_DDR);
> +		if (ret) {
> +			dev_err(dev, "data not ready\n");
> +			return ret;
> +		}
> +		if (val) {
> +			dev_err(dev, "i3c transfer error\n");
> +			return val;
> +		}
> +		return i3c_device_do_xfers(data->i3cdev, xfers_rd_data_cmd,
> +					   ARRAY_SIZE(xfers_rd_data_cmd), I3C_HDR_DDR);
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
> +
> +	return regmap_bulk_read(data->regmap, MMC5633_REG_XOUT0, buf, sz);
> +}

...

> +static int mmc5633_read_avail(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan,
> +			      const int **vals,
> +			      int *type,
> +			      int *length,
> +			      long mask)

Other functions use different style, I believe it can occupy less LoCs.

...

> +static int mmc5633_i3c_probe(struct i3c_device *i3cdev)
> +{
> +	struct device *dev = i3cdev_to_dev(i3cdev);
> +	struct regmap *regmap;
> +	char *name;

> +	name = devm_kasprintf(dev, GFP_KERNEL, "mmc5633(%s)", dev_name(dev));

I agree on idea behind this, but I think () can be problematic for some shell
scripts, I would go with the simple mmc5633_%s or similar.

> +	if (!name)
> +		return -ENOMEM;
> +
> +	regmap = devm_regmap_init_i3c(i3cdev, &mmc5633_regmap_config);
> +	if (IS_ERR(regmap))
> +		return dev_err_probe(dev, PTR_ERR(regmap),
> +				     "Failed to register i3c regmap\n");
> +
> +	return mmc5633_common_probe(regmap, name, i3cdev);
> +}

-- 
With Best Regards,
Andy Shevchenko



