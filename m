Return-Path: <linux-iio+bounces-23583-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AFD8B3EB3C
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 17:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66FDB487BEB
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 15:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C5A306490;
	Mon,  1 Sep 2025 15:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ErM8g35d"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9792F1FFE;
	Mon,  1 Sep 2025 15:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756740934; cv=none; b=Xym71lldwKX9rtF8+KUs/llvW3VIygddPt+fUOSHhnzvl+RA/FReroVmBOWlQcGqOXaGbQrf/TIxRWFd7oXq4IwSu4vqfkhPNJiGHiJ5G/LZ7J56cnl3aDy75r0Hdyjdm23Lr524FRcP36NKb3nFGvb7KYLG5hDmFZGg2ZJzxBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756740934; c=relaxed/simple;
	bh=R0K0uO78kkNj9O0JCBudz8MUoczEiC4rdOw3y+eElXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FmONakTBOV6R6Q1j7BZ9HuLIYybAK6zZ8iTCKP8dmhLPk6lDDQsOo4m/SvDnswruqcJVPRDeOnNKeQvUqDJGoMmSXrnRDGT1Xcr0fVwyn8qep7lkrlEee/4YJDGW/GcHebSo8ld2x5WO/3EmWFswMu03zn2VgiSLK/k54htrqYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ErM8g35d; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756740932; x=1788276932;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=R0K0uO78kkNj9O0JCBudz8MUoczEiC4rdOw3y+eElXg=;
  b=ErM8g35dHGvbCPRy+NzTP+5nodOWMBvR/RaA97KdL60mmW5+dFyhK4w8
   p+jUQKPoUpcZSUu1g6LZI9pY4eo7F28YuNcL5/ZdP3PX4Phpdb61LhWuS
   lwrlJNqUKQH3DNcOFjaDAat3TIOinvlziMtPAi3JyeuOAkct95zoflIMF
   7b/tQyhd4y6zZmUs3nIrgMfO+euVvRKIaHiq8EEbHYxKdTdPVgexVWRZp
   huqJxhcQSiaCRUUlRzStBdNOd6IEns+00ee7l8GQSH+tC5eKTYewsaAi2
   m7EJU32tEzhgqk6zxe8ohBjQ4qIaaUAVQPzq/BR573Wh+e31jqW0jTjss
   A==;
X-CSE-ConnectionGUID: GE8PYFcGQRi9XsEPSoXI9A==
X-CSE-MsgGUID: 2gch+IlgQGCU/BMgvQ2nRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11540"; a="76600594"
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="76600594"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2025 08:35:31 -0700
X-CSE-ConnectionGUID: OpyYnceHSnu1cIHprjYhlw==
X-CSE-MsgGUID: erdoT8FRTcGzNI6NcgYriQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; 
   d="scan'208";a="170327749"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2025 08:35:27 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1ut6Z1-0000000ASUk-1fIP;
	Mon, 01 Sep 2025 18:35:23 +0300
Date: Mon, 1 Sep 2025 18:35:23 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Duje =?utf-8?Q?Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Karel Balej <balejk@matfyz.cz>,
	Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Wronek <david@mainlining.org>, phone-devel@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/3] iio: adc: Add driver for Marvell 88PM886 PMIC ADC
Message-ID: <aLW9O1rnhUqqh02r@smile.fi.intel.com>
References: <20250831-88pm886-gpadc-v2-0-759c1e14d95f@dujemihanovic.xyz>
 <20250831-88pm886-gpadc-v2-2-759c1e14d95f@dujemihanovic.xyz>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250831-88pm886-gpadc-v2-2-759c1e14d95f@dujemihanovic.xyz>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Aug 31, 2025 at 12:33:05PM +0200, Duje Mihanović wrote:
> Marvell's 88PM886 PMIC has a so-called General Purpose ADC used for
> monitoring various system voltages and temperatures. Add the relevant
> register definitions to the MFD header and a driver for the ADC.

...

> +#define ADC_CHANNEL_RESISTANCE(index, lsb, name) { \

Please, make those { on the separate lines

{

> +	.type = IIO_RESISTANCE, \
> +	.indexed = 1, \
> +	.channel = index, \
> +	.address = lsb, \
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED), \
> +	.datasheet_name = name, \
> +}

Also it's easier to read when \:s are TABbed to the same column.

...

> +static const struct regmap_config pm886_gpadc_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = PM886_REG_GPADC_VBAT_SLP + 1,

What is this + 1 register? Why is it not defined / documented?

> +};

...

> +static int gpadc_get_raw(struct iio_dev *iio, enum pm886_gpadc_channel chan)
> +{
> +	struct pm886_gpadc *gpadc = iio_priv(iio);
> +	__be16 buf;
> +	int ret;
> +
> +	ret = regmap_bulk_read(gpadc->map, pm886_gpadc_regs[chan], &buf, sizeof(buf));
> +	return !ret ? be16_to_cpu(buf) >> 4 : ret;

This is hard to read. Note, the more LoCs is fine as long as it helps (and
actually a lot in this case) readability.

> +}

...

> +static int
> +gpadc_find_bias_current(struct iio_dev *iio, struct iio_chan_spec const *chan,
> +			unsigned int *raw_uv, unsigned int *raw_ua)
> +{
> +	struct pm886_gpadc *gpadc = iio_priv(iio);
> +	unsigned int gpadc_num = chan->channel - GPADC0_CHAN;
> +	unsigned int reg = PM886_REG_GPADC_CONFIG(0xb + gpadc_num);
> +	unsigned long lsb = chan->address;
> +	int ret;
> +
> +	for (unsigned int i = 0; i < PM886_GPADC_BIAS_LEVELS; i++) {
> +		ret = regmap_update_bits(gpadc->map, reg, GENMASK(3, 0), i);
> +		if (ret)
> +			return ret;

Sleep needs to be explained.

> +		fsleep(5000);

5 * USEC_PER_MSEC

> +		*raw_ua = PM886_GPADC_INDEX_TO_BIAS_UA(i);
> +		*raw_uv = gpadc_get_raw(iio, chan->channel) * lsb;

Can we use uA and uV suffixes?

> +		/*
> +		 * Vendor kernel errors out above 1.25V, but testing shows that
> +		 * the resistance of the battery detection channel (GPADC2 on
> +		 * coreprimevelte) reaches about 1.4Mohm when the battery is
> +		 * removed, which can't be measured with such a low upper
> +		 * limit. Therefore, to be able to detect the battery without
> +		 * ugly externs as used in the vendor fuelgauge driver,
> +		 * increase this limit a bit.
> +		 */
> +		if (WARN_ON(*raw_uv > 1500 * (MICRO / MILLI)))
> +			return -EIO;
> +
> +		/*
> +		 * Vendor kernel errors out under 300mV, but for the same
> +		 * reason as above (except the channel hovers around 3.5kohm
> +		 * with battery present) reduce this limit.
> +		 */
> +		if (*raw_uv < 200 * (MICRO / MILLI)) {
> +			dev_dbg(&iio->dev, "bad bias for chan %d: %duA @ %duV\n", chan->channel,
> +				*raw_ua, *raw_uv);
> +			continue;
> +		}
> +
> +		dev_dbg(&iio->dev, "good bias for chan %d: %duA @ %duV\n", chan->channel,
> +			*raw_ua, *raw_uv);
> +		return 0;
> +	}
> +
> +	dev_err(&iio->dev, "failed to find good bias for chan %d\n", chan->channel);
> +	return -EINVAL;
> +}

...

> +static int
> +gpadc_get_resistance_ohm(struct iio_dev *iio, struct iio_chan_spec const *chan)
> +{
> +	struct pm886_gpadc *gpadc = iio_priv(iio);
> +	unsigned int raw_uv, raw_ua;
> +	int ret;
> +
> +	ret = gpadc_set_bias(gpadc, chan->channel, true);
> +	if (ret)
> +		goto err;
> +
> +	ret = gpadc_find_bias_current(iio, chan, &raw_uv, &raw_ua);
> +	if (ret)
> +		goto err;
> +
> +	ret = gpadc_set_bias(gpadc, chan->channel, false);
> +	if (ret)
> +		return ret;
> +
> +	return DIV_ROUND_CLOSEST(raw_uv, raw_ua);
> +err:
> +	gpadc_set_bias(gpadc, chan->channel, false);

You do the same in the other branch and checking there for an error. Why this
one is so special?

> +	return ret;
> +}

...

> +		dev_dbg(&iio->dev, "chan: %d, raw: %d\n", chan->channel, *val);

How is this useful? The userspace gets the same value. Do you expect problems
on its way to the user space?

...

> +	case IIO_CHAN_INFO_SCALE:
> +		*val = lsb;
> +		*val2 = (MICRO / MILLI);
> +		return chan->type == IIO_VOLTAGE
> +		       ? IIO_VAL_FRACTIONAL
> +		       : IIO_VAL_INT;

Make it one line, it is much easier to follow or even split to a regular 'if'.

> +	case IIO_CHAN_INFO_OFFSET:
> +		/* Raw value is 104 millikelvin/LSB, convert it to 104 millicelsius/LSB */
> +		*val = ABSOLUTE_ZERO_MILLICELSIUS;
> +		*val2 = lsb;
> +		return IIO_VAL_FRACTIONAL;

...

> +static int pm886_gpadc_setup(struct regmap *map, bool enable)
> +{
> +	const u8 config[] = {
> +		PM886_GPADC_CONFIG1_EN_ALL,
> +		PM886_GPADC_CONFIG2_EN_ALL,
> +		PM886_GPADC_GND_DET2_EN

Leave trailing comma. This doesn't look like a terminator entry.

> +	};
> +	int ret;
> +
> +	/* Enable/disable the ADC block */
> +	ret = regmap_assign_bits(map, PM886_REG_GPADC_CONFIG(0x6), BIT(0), enable);
> +	if (ret)
> +		return ret;

> +	if (!enable)
> +		return 0;
> +
> +	/* If enabling, enable all channels */
> +	return regmap_bulk_write(map, PM886_REG_GPADC_CONFIG(0x1), config, ARRAY_SIZE(config));
> +}

...

> +static int pm886_gpadc_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct pm886_chip *chip = dev_get_drvdata(dev->parent);
> +	struct i2c_client *client = chip->client;
> +	struct pm886_gpadc *gpadc;
> +	struct i2c_client *page;
> +	struct iio_dev *iio;
> +	int ret;
> +
> +	iio = devm_iio_device_alloc(dev, sizeof(*gpadc));
> +	if (!iio)
> +		return -ENOMEM;
> +
> +	gpadc = iio_priv(iio);
> +	dev_set_drvdata(dev, iio);
> +
> +	page = devm_i2c_new_dummy_device(dev, client->adapter,
> +					 client->addr + PM886_PAGE_OFFSET_GPADC);
> +	if (IS_ERR(page))
> +		return dev_err_probe(dev, PTR_ERR(page), "Failed to initialize GPADC page\n");
> +
> +	gpadc->map = devm_regmap_init_i2c(page, &pm886_gpadc_regmap_config);
> +	if (IS_ERR(gpadc->map))
> +		return dev_err_probe(dev, PTR_ERR(gpadc->map),
> +				     "Failed to initialize GPADC regmap\n");
> +
> +	iio->name = "88pm886-gpadc";

> +	iio->dev.of_node = dev->parent->of_node;

No, use device_set_node() with the respective parameters.

But rather debug why firmware node (or OF in your case) is not propagated from
the parent device.

> +	iio->modes = INDIO_DIRECT_MODE;
> +	iio->info = &pm886_gpadc_iio_info;
> +	iio->channels = pm886_gpadc_channels;
> +	iio->num_channels = ARRAY_SIZE(pm886_gpadc_channels);
> +
> +	pm_runtime_set_autosuspend_delay(dev, 50);
> +	pm_runtime_use_autosuspend(dev);

Hmm... Shouldn't this be better after enabling PM?

> +	ret = devm_pm_runtime_enable(dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to enable runtime PM\n");
> +
> +	ret = devm_iio_device_register(dev, iio);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to register ADC\n");
> +
> +	return 0;
> +}

> +static int pm886_gpadc_runtime_resume(struct device *dev)
> +{
> +	struct iio_dev *iio = dev_get_drvdata(dev);
> +	struct pm886_gpadc *gpadc = iio_priv(iio);
> +
> +	return pm886_gpadc_setup(gpadc->map, true);
> +}
> +
> +static int pm886_gpadc_runtime_suspend(struct device *dev)
> +{
> +	struct iio_dev *iio = dev_get_drvdata(dev);
> +	struct pm886_gpadc *gpadc = iio_priv(iio);
> +
> +	return pm886_gpadc_setup(gpadc->map, false);
> +}

Okay, Now I see that the _setup() is better to be split to two functions with
the proper naming, like _gpadc_hw_enable() and disable.

...

> +#define PM886_GPADC_CONFIG1_EN_ALL (PM886_GPADC_VSC_EN | \
> +				    PM886_GPADC_VBAT_EN | \
> +				    PM886_GPADC_GNDDET1_EN | \
> +				    PM886_GPADC_VBUS_EN | \
> +				    PM886_GPADC_VCHG_PWR_EN | \
> +				    PM886_GPADC_VCF_OUT_EN)

Better formatting is

#define PM886_GPADC_CONFIG1_EN_ALL	\
	(PM886_GPADC_VSC_EN |		\
	 PM886_GPADC_VBAT_EN |		\
	 PM886_GPADC_GNDDET1_EN |	\
	 PM886_GPADC_VBUS_EN |		\
	 PM886_GPADC_VCHG_PWR_EN |	\
	 PM886_GPADC_VCF_OUT_EN)

...

> +#define PM886_GPADC_CONFIG2_EN_ALL (PM886_GPADC_TINT_EN | \
> +				    PM886_GPADC_GPADC0_EN | \
> +				    PM886_GPADC_GPADC1_EN | \
> +				    PM886_GPADC_GPADC2_EN | \
> +				    PM886_GPADC_GPADC3_EN | \
> +				    PM886_GPADC_MIC_DET_EN)

Ditto.

...

> +#define PM886_GPADC_INDEX_TO_BIAS_UA(i)	(1 + (i) * 5)

_uA (yes, it's okay to use small 'u' for clarity).


-- 
With Best Regards,
Andy Shevchenko



