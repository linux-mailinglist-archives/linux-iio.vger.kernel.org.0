Return-Path: <linux-iio+bounces-21708-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9242B06F02
	for <lists+linux-iio@lfdr.de>; Wed, 16 Jul 2025 09:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09C661887F00
	for <lists+linux-iio@lfdr.de>; Wed, 16 Jul 2025 07:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E5328C02E;
	Wed, 16 Jul 2025 07:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RweUfreE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40551A2398;
	Wed, 16 Jul 2025 07:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752651275; cv=none; b=q1505mW3kQ4eY0w1hsatwsPrzzPSBLD9+xmSJ0N54CArv5AGPdkZUGdn24qrXAL9D2qigCnyHEmty5UQUlgz05cdUjh5cxUeGGe2FZkXFvN8iaMXZTznCUyahgtMZJjvpkFvyA7DvhhCj/UJzGEB2oHqT6ed/vRD8PuqWCfH59w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752651275; c=relaxed/simple;
	bh=zJBkCq9nG4bFfG6dyPIdRv/h4JagCaQuSj9HeSyqV0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cdkpb2D9m3KmtWPlQKed/z+c4YqKwwcTiGx6KLxb13KD2BLJwaBVVwG8k6qcfqfP3soqjcheKecA7NCgaZGM7ijB0wCjz5GoLzMRoCSlbfLNciblKY9v1xuEDoD5nJ0joGITtW+Bhmjefntrjo2LuMwhEpa/VUVopRSDLCN4q8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RweUfreE; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752651274; x=1784187274;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zJBkCq9nG4bFfG6dyPIdRv/h4JagCaQuSj9HeSyqV0k=;
  b=RweUfreEk1mLdJeU4awmn22xcRt3dlF6V7I9qMRSNh9JSvgM8APYlJOC
   /C254vv67PGW6uETCW06L+0WpIMgILPKidiTEkt+scjaiPPO1/3kYpBfk
   PlNMR1KX0TZpy8GZ1Iz2iuRtUkV/mBLXexPftnevSU2k9lVmul5RgJIwQ
   +pZFy8XXtraKZj0MXIbu3/WhiZrQnEUAnIxmVXEFzheFn67rGgl5deXvo
   LTTxv97BwDrSwTtClQ2G7XbktpsYVkpPNXviD83kfKD4nRI1w56QDRnBF
   HwXZ7oZmMeOI65fpH9noT8GeVmBW61+YZlq5DsRDPRNiCco2M9Qnf9HsY
   w==;
X-CSE-ConnectionGUID: 0ihm17xxS8WuKNRcwTQY7w==
X-CSE-MsgGUID: oxsgkGkzQiqBQ+Os36FbrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="54594996"
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="54594996"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 00:34:34 -0700
X-CSE-ConnectionGUID: OPt0dNK1TvaGjhnyo5ZyHQ==
X-CSE-MsgGUID: 64ff7W5kSMmW1SEZYNvOjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="161981683"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 00:34:29 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1ubwen-0000000Fr2b-3mjg;
	Wed, 16 Jul 2025 10:34:25 +0300
Date: Wed, 16 Jul 2025 10:34:25 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andreas Klinger <ak@it-klinger.de>
Cc: jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, lars@metafoo.de,
	javier.carrasco.cruz@gmail.com, mazziesaccount@gmail.com,
	arthur.becker@sentec.com, perdaniel.olsson@axis.com,
	mgonellabolduc@dimonoff.com, muditsharma.info@gmail.com,
	clamor95@gmail.com, emil.gedenryd@axis.com,
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/3] iio: light: add support for veml6046x00 RGBIR
 color sensor
Message-ID: <aHdWAUMMH43tIqV4@smile.fi.intel.com>
References: <20250715085810.7679-1-ak@it-klinger.de>
 <20250715085810.7679-3-ak@it-klinger.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715085810.7679-3-ak@it-klinger.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jul 15, 2025 at 10:58:09AM +0200, Andreas Klinger wrote:
> Add Vishay VEML6046X00 high accuracy RGBIR color sensor.
> 
> This sensor provides three colour (red, green and blue) as well as one
> infrared (IR) channel through I2C.
> 
> Support direct and buffered mode.
> 
> An optional interrupt for signaling green colour threshold underflow or
> overflow is not supported so far.

...

> +#define	VEML6046X00_GAIN_1          0x0
> +#define	VEML6046X00_GAIN_2          0x1
> +#define	VEML6046X00_GAIN_0_66       0x2
> +#define	VEML6046X00_GAIN_0_5        0x3

Is it defined as hexadecimal in the datasheet? Otherwise use plain decimal
numbers.

...

> +static int veml6046x00_get_it_usec(struct veml6046x00_data *data, unsigned int *it_usec)
> +{
> +	int ret;
> +	unsigned int reg;
> +
> +	ret = regmap_field_read(data->rf.it, &reg);
> +	if (ret)
> +		return ret;
> +
> +	if (reg >= ARRAY_SIZE(veml6046x00_it))
> +		return -EINVAL;
> +
> +	*it_usec = (unsigned int)veml6046x00_it[reg][1];

Is this casting needed? According to the C standard unsigned has higher rank
than signed.

> +	return IIO_VAL_INT_PLUS_MICRO;
> +}

...

> +static int veml6046x00_wait_data_available(struct iio_dev *iio, unsigned int usecs)
> +{
> +	struct veml6046x00_data *data = iio_priv(iio);
> +	int ret;
> +
> +	ret = veml6046x00_read_data_ready(data);

> +	if (ret == 0) {

What's wrong with the regular pattern, i.e.

	if (ret)
		return ret;

?

> +		fsleep(usecs);
> +		ret = veml6046x00_read_data_ready(data);
> +	}
> +
> +	return ret;
> +}

...

> +	ret = veml6046x00_wait_data_available(iio, it_usec * 4);
> +	if (ret < 0)
> +		return ret;
> +	if (ret == 0)
> +		return -EAGAIN;
> +
> +	if (!iio_device_claim_direct(iio))
> +		return -EBUSY;
> +
> +	ret = regmap_bulk_read(data->regmap, addr, &reg, sizeof(reg));
> +	iio_device_release_direct(iio);
> +	if (ret)
> +		return ret;

All error paths above are missing the below runtime PM calls, is it on purpose?
If so, comment is a must to explain what's going on here.

> +	pm_runtime_mark_last_busy(dev);
> +	pm_runtime_put_autosuspend(dev);
> +
> +	*val = le16_to_cpu(reg);
> +
> +	return IIO_VAL_INT;
> +
> +no_data:
> +	pm_runtime_mark_last_busy(dev);
> +	pm_runtime_put_autosuspend(dev);
> +
> +	return -EAGAIN;

...

> +static irqreturn_t veml6046x00_trig_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *iio = pf->indio_dev;
> +	struct veml6046x00_data *data = iio_priv(iio);
> +	int ret;
> +	struct {
> +		__le16 chans[4];
> +		aligned_s64 timestamp;
> +	} scan = {};

Do you need this (nullification) assignment?

> +	ret = regmap_bulk_read(data->regmap, VEML6046X00_REG_R,
> +			       &scan.chans, sizeof(scan.chans));
> +	if (ret)
> +		goto done;
> +
> +	iio_push_to_buffers_with_timestamp(iio, &scan, iio_get_time_ns(iio));
> +
> +done:
> +	iio_trigger_notify_done(iio->trig);
> +
> +	return IRQ_HANDLED;
> +}

...

> +static int veml6046x00_validate_part_id(struct veml6046x00_data *data)
> +{
> +	struct device *dev = regmap_get_device(data->regmap);
> +	unsigned int part_id;
> +	int ret;
> +	__le16 reg;
> +
> +	ret = regmap_bulk_read(data->regmap, VEML6046X00_REG_ID,
> +			       &reg, sizeof(reg));
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to read ID\n");
> +
> +	part_id = le16_to_cpu(reg);
> +	if (part_id != 0x0001)
> +		dev_info(dev, "Unknown ID %#04x\n", part_id);

For 0 it will print 0 and not 0x0000. Is it okay?

> +	return 0;
> +}

...

> +static int veml6046x00_setup_device(struct iio_dev *iio)
> +{
> +	struct veml6046x00_data *data = iio_priv(iio);
> +	struct device *dev = regmap_get_device(data->regmap);
> +	int ret;
> +	__le16 reg16;
> +	u8 reg[2] = { VEML6046X00_CONF0_AF, 0x00 };

0x00 looks like a part of the reg. If so, this should be actually typed as
__le16. Otherwise, in case this is just a simple terminator, use (decimal) 0.

> +	ret = regmap_bulk_write(data->regmap, VEML6046X00_REG_CONF0,
> +				reg, sizeof(reg));
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to set configuration\n");

So, this actually will be as simple as

	reg16 = cpu_to_le16(VEML6046X00_CONF0_AF);
	ret = regmap_bulk_write(data->regmap, VEML6046X00_REG_CONF0,
				&reg16, sizeof(reg16));
	if (ret)
		return dev_err_probe(dev, ret, "Failed to set configuration\n");

> +	reg16 = cpu_to_le16(0);
> +	ret = regmap_bulk_write(data->regmap, VEML6046X00_REG_THDL,
> +				&reg16, sizeof(reg16));
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to set low threshold\n");
> +
> +	reg16 = cpu_to_le16(U16_MAX);
> +	ret = regmap_bulk_write(data->regmap, VEML6046X00_REG_THDH,
> +				&reg16, sizeof(reg16));
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to set high threshold\n");
> +
> +	ret = regmap_bulk_read(data->regmap, VEML6046X00_REG_INT,
> +			       &reg16, sizeof(reg16));
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to clear interrupts\n");
> +
> +	return 0;
> +}

...

> +static const struct of_device_id veml6046x00_of_match[] = {
> +	{
> +		.compatible = "vishay,veml6046x00",
> +	},

Can be just a single line.

	{ .compatible = "vishay,veml6046x00" },

> +	{ }
> +};

-- 
With Best Regards,
Andy Shevchenko



