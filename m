Return-Path: <linux-iio+bounces-26415-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3B7C7FD8D
	for <lists+linux-iio@lfdr.de>; Mon, 24 Nov 2025 11:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 223C33439F7
	for <lists+linux-iio@lfdr.de>; Mon, 24 Nov 2025 10:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8C92741AC;
	Mon, 24 Nov 2025 10:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fkzf4W/0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EED26E175;
	Mon, 24 Nov 2025 10:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763979666; cv=none; b=iY22npu/DwTCDIf0XVbeiESNgCQVrn37erSGF9DRIK96RJwNodPrzlPRyPtQtF9PuK7bM7Vw1dZ4Fm9rEsQup71XLLUfRXPIBucw1eKFswG7res4bi0US49gTClRIJmNkgEHHUe8KKZFe2+x5e9BDM2Gyp+6xNo314MgWo35T3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763979666; c=relaxed/simple;
	bh=97Id1iupUhtI/OhnNJgcjDWkaZUiS859ZgDQ6dsjMWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XQoSwDZRU02GJv6oTeJD7jqh+C2bHWkKOGYClH0DYTghDnI+6E7qqsQTmN0cHi0rHSDyLpibL0H9l84FW0t3Sog3JuKO/n2yRxtbeIqvKyRqhQ3c4sPsL0MGf0lIZZx1V8i7GQeUBY3oEhv7EFqt/l60z8fb67+DvVS0JlFCM5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fkzf4W/0; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763979664; x=1795515664;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=97Id1iupUhtI/OhnNJgcjDWkaZUiS859ZgDQ6dsjMWI=;
  b=Fkzf4W/0Wm+snjb2kbIGcEzHBPb5YBzl8syiZRvsz6uaOOhK8nOc2CWO
   wrumS+c89ajJ+6pWMHGxNnmvzC9A2nGGv3fNPP+Dm7rpBhr7p/KNnFQdR
   XPh0gLZ10153fjSqbnB38LBURITSrK1TvsXST6lIBJubymfsjEnyN+Q8g
   LhsbClXiO44Z1IZyGjobPERied1OEnKiDb3v7v7tZCa47MeauthEEXYz7
   WfxTpesAbbJu51TtzLDFJkiS61GoREYbQClpBIuG5xM9e2WYotpLgvFik
   hp6WTNWZK9tAdnUtpxoRIuxnht0NzNCjGJ7Oag65ERS3oYFArt2QEA2SJ
   Q==;
X-CSE-ConnectionGUID: MJen92qxRB2iTl9q+bnBpQ==
X-CSE-MsgGUID: sfKvDJKCRYeSjyza7/ZgHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11622"; a="91461252"
X-IronPort-AV: E=Sophos;i="6.20,222,1758610800"; 
   d="scan'208";a="91461252"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 02:21:03 -0800
X-CSE-ConnectionGUID: 9QJRWjszSRKXAuSPIM0JBA==
X-CSE-MsgGUID: grgx7fhYSIaex/4j1wecQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,222,1758610800"; 
   d="scan'208";a="196744019"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.5])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 02:20:59 -0800
Date: Mon, 24 Nov 2025 12:20:57 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jorge Marques <jorge.marques@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2 3/9] iio: adc: Add support for ad4062
Message-ID: <aSQxiSoZcI_ol3S5@smile.fi.intel.com>
References: <20251124-staging-ad4062-v2-0-a375609afbb7@analog.com>
 <20251124-staging-ad4062-v2-3-a375609afbb7@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251124-staging-ad4062-v2-3-a375609afbb7@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 24, 2025 at 10:18:02AM +0100, Jorge Marques wrote:
> The AD4060/AD4062 are versatile, 16-bit/12-bit, successive approximation
> register (SAR) analog-to-digital converter (ADC) with low-power and
> threshold monitoring modes.

...

> +#define AD4062_SOFT_RESET	0x81

The grouping seems a bit strange. Haven't you forgotten a blank line here?
Ditto for other similar cases.

> +#define AD4060_MAX_AVG		0x7
> +#define AD4062_MAX_AVG		0xB

> +#define AD4062_MON_VAL_MAX_GAIN		1999970

This is decimal...

> +#define AD4062_MON_VAL_MIDDLE_POINT	0x8000

...and this is hexadecimal. Can you make these consistent?
Also, is there any explanation of the number above? To me
it looks like 2000000 - 30. Is it so? Or is this a fraction
number multiplied by 1000000 or so? In any case some elaboration
would be good to have.

> +#define AD4062_GP_DRDY		0x2
> +#define AD4062_INTR_EN_NEITHER	0x0
> +#define AD4062_TCONV_NS		270

...

> +struct ad4062_state {
> +	const struct ad4062_chip_info *chip;
> +	const struct ad4062_bus_ops *ops;
> +	enum ad4062_operation_mode mode;
> +	struct completion completion;
> +	struct iio_trigger *trigger;
> +	struct iio_dev *indio_dev;
> +	struct i3c_device *i3cdev;
> +	struct regmap *regmap;
> +	u16 sampling_frequency;
> +	int vref_uv;
> +	int samp_freqs[ARRAY_SIZE(ad4062_conversion_freqs)];
> +	u8 oversamp_ratio;
> +	union {
> +		__be32 be32;
> +		__be16 be16;
> +		u8 bytes[4];
> +	} buf __aligned(IIO_DMA_MINALIGN);
> +	u8 reg_addr_conv;

Can't we group u8:s to save a few bytes of memory?

> +};

...

> +static int ad4062_set_oversampling_ratio(struct ad4062_state *st, unsigned int val)
> +{
> +	int ret;
> +
> +	if (val < 1 || val > BIT(st->chip->max_avg + 1))

in_range() ?

	in_range(val, 1, GENMASK(st->chip->max_avg, 0))

if I am not mistaken. Also note, the GENMASK() approach makes possible
to have all 32 bits set, however it's most unlikely to happen here anyway.

> +		return -EINVAL;
> +
> +	/* 1 disables oversampling */
> +	val = ilog2(val);
> +	if (val == 0) {
> +		st->mode = AD4062_SAMPLE_MODE;
> +	} else {
> +		st->mode = AD4062_BURST_AVERAGING_MODE;
> +		ret = regmap_write(st->regmap, AD4062_REG_AVG_CONFIG, val - 1);
> +		if (ret)
> +			return ret;
> +	}
> +	st->oversamp_ratio = BIT(val);
> +
> +	return 0;
> +}

...

> +static int ad4062_get_oversampling_ratio(struct ad4062_state *st,
> +					 unsigned int *val)
> +{
> +	int ret, buf;
> +
> +	if (st->mode == AD4062_SAMPLE_MODE) {
> +		*val = 1;
> +		return 0;
> +	}

> +	ret = regmap_read(st->regmap, AD4062_REG_AVG_CONFIG, &buf);
> +	return 0;

This is strange piece of code. Why do we have ret at all?
Please, try to compile kernel also with `make LLVM=1 W=1 ...`
assuming you have clang installed. It catches such issues quite
well.

> +}

...

> +static int ad4062_calc_sampling_frequency(int fosc, unsigned int n_avg)
> +{
> +	/* See datasheet page 31 */
> +	u64 duration = div_u64((u64)(n_avg - 1) * NSEC_PER_SEC, fosc) + AD4062_TCONV_NS;
> +
> +	return DIV_ROUND_UP_ULL(NSEC_PER_SEC, duration);

Why u64?

The DIV_ROUND_UP_ULL() seems an overkill here. Or do you expect duration be
more than 4 billions?

> +}
> +
> +static int ad4062_populate_sampling_frequency(struct ad4062_state *st)
> +{
> +	for (int i = 0; i < ARRAY_SIZE(ad4062_conversion_freqs); i++)

Why signed iterator?

> +		st->samp_freqs[i] = ad4062_calc_sampling_frequency(ad4062_conversion_freqs[i],
> +								   st->oversamp_ratio);

Perhaps

		st->samp_freqs[i] =
			ad4062_calc_sampling_frequency(ad4062_conversion_freqs[i],
						       st->oversamp_ratio);

But I am not insisting on this case and similar.


> +	return 0;
> +}

> +static int ad4062_get_sampling_frequency(struct ad4062_state *st, int *val)
> +{
> +	*val = ad4062_calc_sampling_frequency(ad4062_conversion_freqs[st->sampling_frequency],
> +					      st->oversamp_ratio);

Oh, temporary variable makes this better for readability.

> +	return 0;
> +}

...

> +static int ad4062_check_ids(struct ad4062_state *st)
> +{

	struct device *dev = &st->i3cdev->dev;

> +	int ret;
> +	u16 val;
> +
> +	ret = regmap_bulk_read(st->regmap, AD4062_REG_PROD_ID_1,
> +			       &st->buf.be16, sizeof(st->buf.be16));
> +	if (ret)
> +		return ret;
> +
> +	val = get_unaligned_be16(st->buf.bytes);
> +	if (val != st->chip->prod_id)
> +		dev_warn(&st->i3cdev->dev,
> +			 "Production ID x%x does not match known values", val);

		dev_warn(dev, "Production ID x%x does not match known values", val);

> +	ret = regmap_bulk_read(st->regmap, AD4062_REG_VENDOR_H,
> +			       &st->buf.be16, sizeof(st->buf.be16));
> +	if (ret)
> +		return ret;
> +
> +	val = get_unaligned_be16(st->buf.bytes);
> +	if (val != AD4062_I3C_VENDOR) {
> +		dev_err(&st->i3cdev->dev,
> +			"Vendor ID x%x does not match expected value\n", val);

		dev_err(dev, "Vendor ID x%x does not match expected value\n", val);

> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}

...

> +static int ad4062_soft_reset(struct ad4062_state *st)
> +{
> +	u8 val = AD4062_SOFT_RESET;
> +	int ret;
> +
> +	ret = regmap_write(st->regmap, AD4062_REG_INTERFACE_CONFIG_A, val);
> +	if (ret)
> +		return ret;
> +
> +	/* Wait AD4062 treset time */
> +	fsleep(5000);

5 * USEC_PER_MSEC

This gives a hint on the units without even a need to comment or look somewhere
else.

> +	return 0;
> +}

...

> +static int ad4062_request_irq(struct iio_dev *indio_dev)
> +{
> +	struct ad4062_state *st = iio_priv(indio_dev);
> +	struct device *dev = &st->i3cdev->dev;
> +	int ret;
> +
> +	ret = fwnode_irq_get_byname(dev_fwnode(&st->i3cdev->dev), "gp1");
> +	if (ret == -EPROBE_DEFER) {
> +		return ret;

> +	} else if (ret < 0) {

Redundant 'else'

> +		ret = regmap_update_bits(st->regmap, AD4062_REG_ADC_IBI_EN,
> +					 AD4062_REG_ADC_IBI_EN_CONV_TRIGGER,
> +					 AD4062_REG_ADC_IBI_EN_CONV_TRIGGER);
> +	} else {
> +		ret = devm_request_threaded_irq(dev, ret,
> +						ad4062_irq_handler_drdy,
> +						NULL, IRQF_ONESHOT, indio_dev->name,
> +						indio_dev);
> +	}
> +
> +	return ret;
> +}

...

> +static const int ad4062_oversampling_avail[] = {
> +	1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096,

It's not easy to count them at glance, please add a comment with indices.

> +};

...

> +static int ad4062_read_avail(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan, const int **vals,
> +			     int *type, int *len, long mask)
> +{
> +	struct ad4062_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		*vals = ad4062_oversampling_avail;
> +		*len = ARRAY_SIZE(ad4062_oversampling_avail);
> +		*type = IIO_VAL_INT;
> +
> +		return IIO_AVAIL_LIST;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		ret = ad4062_populate_sampling_frequency(st);
> +		if (ret)
> +			return ret;
> +		*vals = st->samp_freqs;
> +		*len = st->oversamp_ratio != 1 ? ARRAY_SIZE(ad4062_conversion_freqs) : 1;

Why not using positive conditional?

Funny trick that Elvis operator can be used in this case, but please don't,
it will make code harder to follow.

> +		*type = IIO_VAL_INT;
> +
> +		return IIO_AVAIL_LIST;
> +	default:
> +		return -EINVAL;
> +	}
> +}

...

> +static int ad4062_get_chan_scale(struct iio_dev *indio_dev, int *val, int *val2)
> +{
> +	struct ad4062_state *st = iio_priv(indio_dev);
> +	const struct iio_scan_type *scan_type;
> +
> +	scan_type = iio_get_current_scan_type(indio_dev, st->chip->channels);
> +	if (IS_ERR(scan_type))
> +		return PTR_ERR(scan_type);
> +
> +	*val = (st->vref_uv * 2) / MILLI;

It's most likely (MICRO / MILLI) instead of MILLI. Am I right?

> +	*val2 = scan_type->realbits - 1; /* signed */
> +
> +	return IIO_VAL_FRACTIONAL_LOG2;
> +}

...

> +static int ad4062_get_chan_calibscale(struct ad4062_state *st, int *val, int *val2)
> +{
> +	u16 gain;
> +	int ret;
> +
> +	ret = regmap_bulk_read(st->regmap, AD4062_REG_MON_VAL,
> +			       &st->buf.be16, sizeof(st->buf.be16));
> +	if (ret)
> +		return ret;
> +
> +	gain = get_unaligned_be16(st->buf.bytes);
> +
> +	/* From datasheet: code out = code in × mon_val/0x8000 */
> +	*val = gain / AD4062_MON_VAL_MIDDLE_POINT;

> +	*val2 = mul_u64_u32_div(gain % AD4062_MON_VAL_MIDDLE_POINT, NANO,
> +				AD4062_MON_VAL_MIDDLE_POINT);

I don't see the need for 64-bit division. Can you elaborate what I miss here?

> +	return IIO_VAL_INT_PLUS_NANO;
> +}

...

> +static int ad4062_set_chan_calibscale(struct ad4062_state *st, int gain_int, int gain_frac)

Forgot to wrap this line.

> +{
> +	u64 gain;
> +	int ret;
> +
> +	if (gain_int < 0 || gain_frac < 0)
> +		return -EINVAL;
> +
> +	gain = mul_u32_u32(gain_int, MICRO) + gain_frac;

> +

Redundant blank line.

> +	if (gain > AD4062_MON_VAL_MAX_GAIN)
> +		return -EINVAL;
> +
> +	put_unaligned_be16(DIV_ROUND_CLOSEST_ULL(gain * AD4062_MON_VAL_MIDDLE_POINT,
> +						 MICRO),
> +			   st->buf.bytes);

Also in doubt here about 64-bit division.

> +	ret = regmap_bulk_write(st->regmap, AD4062_REG_MON_VAL,
> +				&st->buf.be16, sizeof(st->buf.be16));
> +	if (ret)
> +		return ret;
> +
> +	/* Enable scale if gain is not one. */

"...is not equal to one."

Also be consistent with the style for one-line comments. Choose one and
use it everywhere. Usual cases:
- my one-line comment
- My one-line comment
- My one-line comment.


> +	return regmap_update_bits(st->regmap, AD4062_REG_ADC_CONFIG,
> +				  AD4062_REG_ADC_CONFIG_SCALE_EN_MSK,
> +				  FIELD_PREP(AD4062_REG_ADC_CONFIG_SCALE_EN_MSK,
> +					     !(gain_int == 1 && gain_frac == 0)));
> +}

...

> +static int __ad4062_read_chan_raw(struct ad4062_state *st, int *val)

Can be named without leading double underscore? Preference is to use
the suffix, like _no_pm (but you can find better one).

> +{
> +	struct i3c_device *i3cdev = st->i3cdev;
> +	struct i3c_priv_xfer t[2] = {
> +		{
> +			.data.out = &st->reg_addr_conv,
> +			.len = sizeof(st->reg_addr_conv),
> +			.rnw = false,
> +		},
> +		{
> +			.data.in = &st->buf.be32,
> +			.len = sizeof(st->buf.be32),
> +			.rnw = true,
> +		}
> +	};
> +	int ret;
> +
> +	reinit_completion(&st->completion);
> +	/* Change address pointer to trigger conversion */
> +	ret = i3c_device_do_priv_xfers(i3cdev, &t[0], 1);

Why array? Just split them on per transfer and use separately. This gives a bit
odd feeling that the two goes together, but no. They are semi-related as we
have a special condition after the first one.

> +	if (ret)
> +		return ret;
> +	/*
> +	 * Single sample read should be used only for oversampling and
> +	 * sampling frequency pairs that take less than 1 sec.
> +	 */
> +	ret = wait_for_completion_timeout(&st->completion,
> +					  msecs_to_jiffies(1000));
> +	if (!ret)
> +		return -ETIMEDOUT;
> +
> +	ret = i3c_device_do_priv_xfers(i3cdev, &t[1], 1);
> +	if (ret)
> +		return ret;
> +	*val = get_unaligned_be32(st->buf.bytes);
> +	return 0;
> +}

...

> +static int ad4062_read_raw_dispatch(struct ad4062_state *st, int *val, int *val2,
> +				    long info)

The parameters are split in a logical way here...

(however preference is

static int ad4062_read_raw_dispatch(struct ad4062_state *st,
				    int *val, int *val2, long info)

to fit 80 characters)

...

> +static int ad4062_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan, int *val,
> +			   int *val2, long info)

...but here. Why not

static int ad4062_read_raw(struct iio_dev *indio_dev,
			   struct iio_chan_spec const *chan,
			   int *val, int *val2, long info)

?

> +	struct ad4062_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	if (info == IIO_CHAN_INFO_SCALE)
> +		return ad4062_get_chan_scale(indio_dev, val, val2);
> +
> +	if (!iio_device_claim_direct(indio_dev))
> +		return -EBUSY;
> +
> +	ret = ad4062_read_raw_dispatch(st, val, val2, info);
> +
> +	iio_device_release_direct(indio_dev);
> +	return ret ? ret : IIO_VAL_INT;

	return ret ?: IIO_VAL_INT;

> +}

...

> +static int ad4062_debugfs_reg_access(struct iio_dev *indio_dev, unsigned int reg,
> +				     unsigned int writeval, unsigned int *readval)
> +{
> +	struct ad4062_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	if (readval)
> +		ret = regmap_read(st->regmap, reg, readval);
> +	else
> +		ret = regmap_write(st->regmap, reg, writeval);
> +
> +	return ret;

Do you expand this in the following patches? If not, ret is not needed.
Just return directly.

> +}

...

> +static int ad4062_regulators_get(struct ad4062_state *st, bool *ref_sel)
> +{
> +	struct device *dev = &st->i3cdev->dev;
> +	int ret;
> +
> +	ret = devm_regulator_get_enable(dev, "vio");
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to enable vio voltage\n");
> +
> +	st->vref_uv = devm_regulator_get_enable_read_voltage(dev, "ref");
> +	*ref_sel = st->vref_uv == -ENODEV;

_uV ?

> +	if (st->vref_uv < 0 && st->vref_uv != -ENODEV) {

You already has the second part

	if (st->vref_uV < 0 && !*ref_sel) {

I believe this is better to understand as we check that ref_sel is not chosen.

> +		return dev_err_probe(dev, st->vref_uv,
> +				     "Failed to enable and read ref voltage\n");

> +	} else if (st->vref_uv == -ENODEV) {

Redundant 'else'

	if (*ref_sel) {

(also in similar way as above)

I don't know if the above was asked specifically, but if so, I ask
the requestor(s) to reconsider.

> +		st->vref_uv = devm_regulator_get_enable_read_voltage(dev, "vdd");
> +		if (st->vref_uv < 0)
> +			return dev_err_probe(dev, st->vref_uv,
> +					     "Failed to enable and read vdd voltage\n");
> +	} else {
> +		ret = devm_regulator_get_enable(dev, "vdd");
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Failed to enable vdd regulator\n");
> +	}
> +
> +	return 0;
> +}

...

> +static int ad4062_runtime_resume(struct device *dev)
> +{
> +	struct ad4062_state *st = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = regmap_clear_bits(st->regmap, AD4062_REG_DEVICE_CONFIG,
> +				AD4062_REG_DEVICE_CONFIG_POWER_MODE_MSK);
> +	if (ret)
> +		return ret;
> +
> +	fsleep(4000);

4 * USEC_PER_MSEC, also would be good to add a comment for this long delay.

> +	return 0;
> +}

...

> +static DEFINE_RUNTIME_DEV_PM_OPS(ad4062_pm_ops, ad4062_runtime_suspend,
> +				 ad4062_runtime_resume, NULL);

I think the logical split is slightly better:

static DEFINE_RUNTIME_DEV_PM_OPS(ad4062_pm_ops,
				 ad4062_runtime_suspend, ad4062_runtime_resume, NULL);

OR

static DEFINE_RUNTIME_DEV_PM_OPS(ad4062_pm_ops,
				 ad4062_runtime_suspend,
				 ad4062_runtime_resume,
				 NULL);

-- 
With Best Regards,
Andy Shevchenko



