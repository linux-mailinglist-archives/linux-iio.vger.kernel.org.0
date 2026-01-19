Return-Path: <linux-iio+bounces-27933-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED57D39FDB
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 08:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38C3F3044987
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 07:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93127335BC0;
	Mon, 19 Jan 2026 07:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MkFflOT7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0F8264602;
	Mon, 19 Jan 2026 07:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768807886; cv=none; b=e4+mUBPxPVwTkDJfLpAXJR7RZRhZnF1TOI46l1aw/e4Fhxj4LQubqofcWNEj/FAWOSz3PKvCsGKfPwDi6teoH42ZmW/3pSlqhArZ2sN5N61JqTFVWe+OshMauldczz8lRK6+0WDrfPeOzR/xYhT1xGHHC3tbECWkC/GlDnUMgOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768807886; c=relaxed/simple;
	bh=M94l9HqI0Iz56gFKjcR/DnvFfzrFroQ7YgA3Yn5iLcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tVL2ZE6LUneKWNIZzYDdffVcsvslRUU/4XPhMavWFmDroZMEuz23LHtWcZkWKwEwkT9jmZPNGO5M+5N1J2sdRoAbYNkpSGCZ6L9r/riGIjT//aZUwC5L5JDEIYD8qwEXCuC9qffzsNlDVsanRK/9S2RZrm5X7pCy0BOVgPJQNus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MkFflOT7; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768807885; x=1800343885;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=M94l9HqI0Iz56gFKjcR/DnvFfzrFroQ7YgA3Yn5iLcQ=;
  b=MkFflOT7TL1pq3LenuByLJIgX7sGaNj0g5d75Is0x/rJyi80S4T8cQfc
   KTcXyNEHBheMNDR3eZuSgkGpvXN8z++YZQFyvQP4okXCrN9GbFI/LRDXB
   oJE1hhGZsVpvUD9mBvvwJJTbR2D44sL4AT7tv6urfIovTxn+abGv35Cv4
   Mj1vjLUE8MrIFccudscbTlLkBr1bcJL++UmL0Scct5zykXYaDIMQLxomE
   v/Glo5AZ1eQE01fhDug21ggSLtaDMPMzFuVZxoQwqJjcNLVkAwKhXxvQ9
   392pIxFOLGYR7qUW8P/gOxqP5Ax9YyVR0eGEWIpcSQg3OoIR2ryHb9FAf
   A==;
X-CSE-ConnectionGUID: X/fHS5uMT5Gk3CJPojDPdg==
X-CSE-MsgGUID: sf24WH0rTmCOlG2MHBVSsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11675"; a="72604153"
X-IronPort-AV: E=Sophos;i="6.21,237,1763452800"; 
   d="scan'208";a="72604153"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2026 23:31:24 -0800
X-CSE-ConnectionGUID: dj46uFbzQd+Dv/dajzN5dg==
X-CSE-MsgGUID: oariiDyPRgqSaSY4rqvQMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,237,1763452800"; 
   d="scan'208";a="205412637"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.37])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2026 23:31:20 -0800
Date: Mon, 19 Jan 2026 09:31:18 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: rodrigo.alencar@analog.com
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v4 3/7] iio: frequency: adf41513: driver implementation
Message-ID: <aW3dxuelYDM67pqZ@smile.fi.intel.com>
References: <20260116-adf41513-iio-driver-v4-0-dbb7d6782217@analog.com>
 <20260116-adf41513-iio-driver-v4-3-dbb7d6782217@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260116-adf41513-iio-driver-v4-3-dbb7d6782217@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jan 16, 2026 at 02:32:22PM +0000, Rodrigo Alencar via B4 Relay wrote:

> The driver is based on existing PLL drivers in the IIO subsystem and
> implements the following key features:
> 
> - Integer-N and fractional-N (fixed/variable modulus) synthesis modes
> - High-resolution frequency calculations using microhertz (µHz) precision
>   to handle sub-Hz resolution across multi-GHz frequency ranges
> - IIO debugfs interface for direct register access
> - FW property parsing from devicetree including charge pump settings,
>   reference path configuration and muxout options
> - Power management support with suspend/resume callbacks
> - Lock detect GPIO monitoring
> 
> The driver uses 64-bit microhertz values throughout PLL calculations to
> maintain precision when working with frequencies that exceed 32-bit Hz
> representation while requiring fractional Hz resolution.

...

> +#define ADF41513_MAX_PFD_FREQ_INT_N_UHZ		(250ULL * MEGA * MICROHZ_PER_HZ)
> +#define ADF41513_MAX_PFD_FREQ_FRAC_N_UHZ	(125ULL * MEGA * MICROHZ_PER_HZ)
> +#define ADF41513_MAX_FREQ_RESOLUTION_UHZ	(100ULL * KILO * MICROHZ_PER_HZ)

Yep, thanks, looks much better now!

...

> +struct adf41513_chip_info {
> +	bool has_prescaler_8_9;
> +	u64 max_rf_freq_hz;

If you swap them, it might be a 4 bytes gain in some cases. Have you run
`pahole`?

> +};

...

> +struct adf41513_pll_settings {
> +	enum adf41513_pll_mode mode;

Sounds to me like a room to improve the layout here,

> +	/* reference path parameters */
> +	u8 r_counter;
> +	u8 ref_doubler;
> +	u8 ref_div2;
> +	u8 prescaler;
> +
> +	/* frequency parameters */
> +	u64 target_frequency_uhz;
> +	u64 actual_frequency_uhz;
> +	u64 pfd_frequency_uhz;
> +
> +	/* pll parameters */
> +	u16 int_value;
> +	u32 frac1;
> +	u32 frac2;
> +	u32 mod2;
> +};

...

> + * See iio_write_channel_info and __iio_str_to_fixpoint in

Refer to function as func(), i.o.w. mind the parentheses.

> + * drivers/iio/industrialio-core.c

Missing period at the end.

...

> +static int adf41513_parse_uhz(const char *str, u64 *freq_uhz)
> +{
> +	u64 uhz = 0;
> +	int f_count = ADF41513_HZ_DECIMAL_PRECISION;
> +	bool frac_part = false;
> +
> +	if (str[0] == '+')
> +		str++;
> +
> +	while (*str && f_count > 0) {
> +		if ('0' <= *str && *str <= '9') {
> +			uhz = uhz * 10 + *str - '0';
> +			if (frac_part)
> +				f_count--;
> +		} else if (*str == '\n') {
> +			if (*(str + 1) == '\0')
> +				break;
> +			return -EINVAL;

> +		} else if (*str == '.' && !frac_part) {

This can be found by strchr() / strrchr() (depending on the expectations of
the input).

> +			frac_part = true;
> +		} else {
> +			return -EINVAL;
> +		}
> +		str++;
> +	}

With the above the rest becomes just a couple of simple_strtoull() calls with
a couple of int_pow(10) calls (and some validation on top).

> +	for (; f_count > 0; f_count--)
> +		uhz *= 10;

This is int_pow(10).

> +	*freq_uhz = uhz;
> +
> +	return 0;
> +}

...

> +static int adf41513_uhz_to_str(u64 freq_uhz, char *buf)
> +{
> +	u32 frac_part;
> +	u64 int_part = div_u64_rem(freq_uhz, MICRO, &frac_part);

Perhaps MICROHZ_PER_HZ? This will be consistent with the int_value in
_calc_*() below.

> +	return sysfs_emit(buf, "%llu.%06u\n", int_part, frac_part);
> +}

...

> +	cfg->pfd_frequency_uhz = div_u64(cfg->pfd_frequency_uhz,
> +					 cfg->r_counter);

Here 81 characters...

> +	cfg->actual_frequency_uhz = (u64)cfg->int_value * cfg->pfd_frequency_uhz;

...and here, but in one case the line is wrapped. I would unwrap the first one.


...

> +	result->ref_div2 = st->data.ref_div2_en ? 1 : 0;
> +	result->ref_doubler = st->data.ref_doubler_en ? 1 : 0;

Seems like "? 1 : 0" just redundant.

...

> +static int adf41513_calc_integer_n(struct adf41513_state *st,
> +				   struct adf41513_pll_settings *result)
> +{
> +	u16 max_int = (st->chip_info->has_prescaler_8_9) ?

Redundant parentheses.

> +		      ADF41513_MAX_INT_8_9 : ADF41513_MAX_INT_4_5;
> +	u64 freq_error_uhz;
> +	u16 int_value = div64_u64_rem(result->target_frequency_uhz, result->pfd_frequency_uhz,
> +				      &freq_error_uhz);

> +	/* check if freq error is within a tolerance of 1/2 resolution */
> +	if (freq_error_uhz > (result->pfd_frequency_uhz >> 1) && int_value < max_int) {
> +		int_value++;
> +		freq_error_uhz = result->pfd_frequency_uhz - freq_error_uhz;
> +	}

This and below the part for frac check seems very similar, I would consider
adding a helper.

> +	if (freq_error_uhz > st->data.freq_resolution_uhz)
> +		return -ERANGE;
> +
> +	/* set prescaler */
> +	if (st->chip_info->has_prescaler_8_9 && int_value >= ADF41513_MIN_INT_8_9 &&
> +	    int_value <= ADF41513_MAX_INT_8_9)
> +		result->prescaler = 1;
> +	else if (int_value >= ADF41513_MIN_INT_4_5 && int_value <= ADF41513_MAX_INT_4_5)
> +		result->prescaler = 0;
> +	else
> +		return -ERANGE;
> +
> +	result->actual_frequency_uhz = (u64)int_value * result->pfd_frequency_uhz;
> +	result->mode = ADF41513_MODE_INTEGER_N;
> +	result->int_value = int_value;
> +	result->frac1 = 0;
> +	result->frac2 = 0;
> +	result->mod2 = 0;
> +
> +	return 0;
> +}

...

> +static int adf41513_calc_variable_mod(struct adf41513_state *st,
> +				      struct adf41513_pll_settings *result)
> +{
> +	u64 freq_error_uhz;
> +	u32 frac1, frac2, mod2;
> +	u16 int_value = div64_u64_rem(result->target_frequency_uhz,
> +				      result->pfd_frequency_uhz,
> +				      &freq_error_uhz);
> +
> +	if (st->chip_info->has_prescaler_8_9 && int_value >= ADF41513_MIN_INT_FRAC_8_9 &&
> +	    int_value <= ADF41513_MAX_INT_8_9)
> +		result->prescaler = 1;
> +	else if (int_value >= ADF41513_MIN_INT_FRAC_4_5 && int_value <= ADF41513_MAX_INT_4_5)
> +		result->prescaler = 0;
> +	else
> +		return -ERANGE;

> +	/* calculate required mod2 based on target resolution / 2 */
> +	mod2 = DIV64_U64_ROUND_CLOSEST(result->pfd_frequency_uhz << 1,
> +				       st->data.freq_resolution_uhz * ADF41513_FIXED_MODULUS);

This also seems familiar with the above mentioned check (for 50% tolerance).

> +	/* ensure mod2 is at least 2 for meaningful operation */
> +	mod2 = clamp(mod2, 2, ADF41513_MAX_MOD2);
> +
> +	/* calculate frac1 and frac2 */
> +	frac1 = mul_u64_u64_div_u64(freq_error_uhz, ADF41513_FIXED_MODULUS,
> +				    result->pfd_frequency_uhz);
> +	freq_error_uhz -= mul_u64_u64_div_u64(frac1, result->pfd_frequency_uhz,
> +					      ADF41513_FIXED_MODULUS);
> +	frac2 = mul_u64_u64_div_u64(freq_error_uhz, (u64)mod2 * ADF41513_FIXED_MODULUS,

I'm wondering why mod2 can't be defined as u64. This will allow to drop castings.

> +				    result->pfd_frequency_uhz);
> +
> +	/* integer part */
> +	result->actual_frequency_uhz = (u64)int_value * result->pfd_frequency_uhz;
> +	/* fractional part */
> +	result->actual_frequency_uhz += mul_u64_u64_div_u64((u64)frac1 * mod2 + frac2,
> +							    result->pfd_frequency_uhz,
> +							    (u64)mod2 * ADF41513_FIXED_MODULUS);
> +	result->mode = ADF41513_MODE_VARIABLE_MODULUS;
> +	result->int_value = int_value;
> +	result->frac1 = frac1;
> +	result->frac2 = frac2;
> +	result->mod2 = mod2;
> +
> +	return 0;
> +}

...

> +	/* apply computed results to pll settings */
> +	memcpy(&st->settings, &result, sizeof(st->settings));

Can't we simply use

	st->settings = result;

?

...

> +static ssize_t adf41513_read_powerdown(struct iio_dev *indio_dev,
> +				       uintptr_t private,
> +				       const struct iio_chan_spec *chan,
> +				       char *buf)
> +{
> +	struct adf41513_state *st = iio_priv(indio_dev);
> +	u32 val;
> +
> +	guard(mutex)(&st->lock);
> +
> +	switch ((u32)private) {

Why casting? Ditto for similar cases.

> +	case ADF41513_POWER_DOWN:
> +		val = FIELD_GET(ADF41513_REG6_POWER_DOWN_MSK,
> +				st->regs_hw[ADF41513_REG6]);
> +		return sysfs_emit(buf, "%u\n", val);
> +	default:
> +		return -EINVAL;
> +	}
> +}

...

> +static ssize_t adf41513_write_uhz(struct iio_dev *indio_dev,
> +				  uintptr_t private,
> +				  const struct iio_chan_spec *chan,
> +				  const char *buf, size_t len)
> +{
> +	struct adf41513_state *st = iio_priv(indio_dev);
> +	u64 freq_uhz;
> +	int ret;
> +
> +	ret = adf41513_parse_uhz(buf, &freq_uhz);
> +	if (ret)
> +		return ret;
> +
> +	guard(mutex)(&st->lock);
> +
> +	switch ((u32)private) {
> +	case ADF41513_FREQ:
> +		ret = adf41513_set_frequency(st, freq_uhz, ADF41513_SYNC_DIFF);
> +		break;
> +	case ADF41513_FREQ_RESOLUTION:
> +		if (freq_uhz == 0 || freq_uhz > ADF41513_MAX_FREQ_RESOLUTION_UHZ)
> +			return -EINVAL;
> +		st->data.freq_resolution_uhz = freq_uhz;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}

> +	return ret ? ret : len;

It can be Elvis operator:

	return ret ?: len;

Ditto for similar cases.

> +}

...

> +static int adf41513_read_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int *val, int *val2, long info)
> +{
> +	struct adf41513_state *st = iio_priv(indio_dev);
> +	u64 phase_urad;
> +	u16 phase_val;
> +
> +	guard(mutex)(&st->lock);
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_PHASE:
> +		phase_val = FIELD_GET(ADF41513_REG2_PHASE_VAL_MSK,
> +				      st->regs_hw[ADF41513_REG2]);
> +		phase_urad = (u64)phase_val * ADF41513_MAX_PHASE_MICRORAD;
> +		phase_urad >>= 12;

> +		*val = (u32)phase_urad / MICRO;
> +		*val2 = (u32)phase_urad % MICRO;

This needs a short comment explaining why castings are okay
(i.o.w. why the 64-bit variable will contain 32-bit value).

> +		return IIO_VAL_INT_PLUS_MICRO;
> +	default:
> +		return -EINVAL;
> +	}
> +}

...

> +static int adf41513_write_raw(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan,
> +			      int val, int val2, long info)
> +{
> +	struct adf41513_state *st = iio_priv(indio_dev);
> +	u64 phase_urad;
> +	u16 phase_val;
> +
> +	guard(mutex)(&st->lock);
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_PHASE:
> +		phase_urad = (u64)val * MICRO + val2;
> +		if (val < 0 || val2 < 0 || phase_urad >= ADF41513_MAX_PHASE_MICRORAD)
> +			return -EINVAL;

It's better to check val* before use them.

> +		phase_val = DIV_U64_ROUND_CLOSEST(phase_urad << 12,
> +						  ADF41513_MAX_PHASE_MICRORAD);
> +		phase_val = min(phase_val, ADF41513_MAX_PHASE_VAL);
> +		st->regs[ADF41513_REG2] |= ADF41513_REG2_PHASE_ADJ_MSK;
> +		FIELD_MODIFY(ADF41513_REG2_PHASE_VAL_MSK,
> +			     &st->regs[ADF41513_REG2], phase_val);
> +		return adf41513_sync_config(st, ADF41513_SYNC_REG0);
> +	default:
> +		return -EINVAL;
> +	}
> +}

...

> +static void adf41513_power_down(void *data)
> +{
> +	struct adf41513_state *st = data;
> +
> +	adf41513_suspend(st);

> +	if (st->chip_enable)

Remove this dup check.

> +		gpiod_set_value_cansleep(st->chip_enable, 0);
> +}

...

> +static int adf41513_probe(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev;
> +	struct adf41513_state *st;
> +	struct device *dev = &spi->dev;
> +	int ret;

Please, use reversed xmas tree ordering.

> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +	st->spi = spi;
> +	st->chip_info = spi_get_device_match_data(spi);
> +	if (!st->chip_info)
> +		return -EINVAL;
> +
> +	spi_set_drvdata(spi, st);
> +
> +	st->ref_clk = devm_clk_get_enabled(dev, NULL);
> +	if (IS_ERR(st->ref_clk))
> +		return PTR_ERR(st->ref_clk);
> +
> +	st->ref_freq_hz = clk_get_rate(st->ref_clk);
> +	if (st->ref_freq_hz < ADF41513_MIN_REF_FREQ_HZ ||
> +	    st->ref_freq_hz > ADF41513_MAX_REF_FREQ_HZ)
> +		return dev_err_probe(dev, -ERANGE,
> +				     "reference frequency %u Hz out of range\n",
> +				     st->ref_freq_hz);
> +
> +	ret = adf41513_parse_fw(st);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_regulator_bulk_get_enable(dev,
> +					     ARRAY_SIZE(adf41513_power_supplies),
> +					     adf41513_power_supplies);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "failed to get and enable regulators\n");
> +
> +	st->chip_enable = devm_gpiod_get_optional(dev, "enable", GPIOD_OUT_HIGH);
> +	if (IS_ERR(st->chip_enable))
> +		return dev_err_probe(dev, PTR_ERR(st->chip_enable),
> +				     "fail to request chip enable GPIO\n");
> +
> +	st->lock_detect = devm_gpiod_get_optional(dev, "lock-detect", GPIOD_IN);
> +	if (IS_ERR(st->lock_detect))
> +		return dev_err_probe(dev, PTR_ERR(st->lock_detect),
> +				     "fail to request lock detect GPIO\n");
> +
> +	ret = devm_mutex_init(dev, &st->lock);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->name = spi_get_device_id(spi)->name;
> +	indio_dev->info = &adf41513_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = &adf41513_chan;
> +	indio_dev->num_channels = 1;
> +
> +	ret = adf41513_setup(st);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "failed to setup device\n");
> +
> +	ret = devm_add_action_or_reset(dev, adf41513_power_down, st);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to add power down action\n");
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}

-- 
With Best Regards,
Andy Shevchenko



