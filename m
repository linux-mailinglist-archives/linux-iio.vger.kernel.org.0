Return-Path: <linux-iio+bounces-8205-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4889946A2D
	for <lists+linux-iio@lfdr.de>; Sat,  3 Aug 2024 16:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B6DE281C69
	for <lists+linux-iio@lfdr.de>; Sat,  3 Aug 2024 14:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8ED153582;
	Sat,  3 Aug 2024 14:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gsRBaiDq"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017342747F;
	Sat,  3 Aug 2024 14:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722697038; cv=none; b=tHJSijRmv0qp8A5pXWTYeUR6qrPcZ3jcUOLNxSZPLXIJYxMwjBLd/+XsSqUwxWQh3wSMvyKwNKGK09BwW1mZ6tdyJ+24fJdc9i3JGr+0AH4zUu77+ioony+m6y6HYMni5H1dX36ue4sjcLXXlRxyGlMGv4IyDr+7fahnpD7W9uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722697038; c=relaxed/simple;
	bh=7Dld65ctMYD0N9kQFVgdV6Ykjlv5zOKh99n+yj1wF1M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gBKZdbJwi07b0PDRTQZhTFeGBgtfag48SadW7LPeGsDBjT7UlSPP6jMmReDqB8rQVeb9dedfnnSnZFWC0mgbyRKI4eKRwRm+kUlg0NC9ClsoW+SFyyiFd4yXEbcx8mnO6/VDr4xPTGPadR7/0kchiflTlgdI/wZB2ocq6Sfxdjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gsRBaiDq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C861AC116B1;
	Sat,  3 Aug 2024 14:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722697037;
	bh=7Dld65ctMYD0N9kQFVgdV6Ykjlv5zOKh99n+yj1wF1M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gsRBaiDq2TGOeXlLmGi3MzY6UchfeIFKyTgovohwExLFlB/UTqQepNYB901xCIDxE
	 vgOfo+FVGaRv/CYUK6PhcE90ILLsEmzlXE92STOd6VzPgHWAoKZLLk40z+EeFctXIX
	 +sZyQtpX8qN85P8/ZgU5KURk/uYWzBZvAtbKG7d7nzVIlGz1PgxPQYpCQfB6O7HVZ1
	 ZxGzNQMFdMHyCmS8GcYDP0OmtE+dA243daDIclsCZPxrDjBCMZ4ZAehYl45xUY7Hqr
	 PaBkweO+lcK8iYmbfE9+Zy+Dp9hBEf2nugiubYCpLcgpxYB98hYcNlOKAn/QkJe69Z
	 O/cJnvU6x4Fpg==
Date: Sat, 3 Aug 2024 15:57:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Trevor Gamblin <tgamblin@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, David
 Lechner <dlechner@baylibre.com>, Uwe Kleine-Konig
 <u.kleine-koenig@baylibre.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH RFC 2/3] iio: adc: ad7625: add driver
Message-ID: <20240803155709.69c5d803@jic23-huawei>
In-Reply-To: <20240731-ad7625_r1-v1-2-a1efef5a2ab9@baylibre.com>
References: <20240731-ad7625_r1-v1-0-a1efef5a2ab9@baylibre.com>
	<20240731-ad7625_r1-v1-2-a1efef5a2ab9@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 31 Jul 2024 09:48:04 -0400
Trevor Gamblin <tgamblin@baylibre.com> wrote:

> This adds a driver for the ad762x and ad796x family of ADCs. These are
> pin-compatible devices using an LVDS interface for data transfer,
> capable of sampling at rates of 6 and 10 MSPS, respectively. They also
> feature multiple voltage reference options based on the configuration of
> the EN1/EN0 pins, which can be set in the devicetree.
> 
> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
Hi Trevor

A few comments inline,

Thanks,

Jonathan

> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index d370e066544e..6bf429ca24ea 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -23,6 +23,7 @@ obj-$(CONFIG_AD7476) += ad7476.o
>  obj-$(CONFIG_AD7606_IFACE_PARALLEL) += ad7606_par.o
>  obj-$(CONFIG_AD7606_IFACE_SPI) += ad7606_spi.o
>  obj-$(CONFIG_AD7606) += ad7606.o
> +obj-$(CONFIG_AD7625) += ad7625.o
>  obj-$(CONFIG_AD7766) += ad7766.o
>  obj-$(CONFIG_AD7768_1) += ad7768-1.o
>  obj-$(CONFIG_AD7780) += ad7780.o
> diff --git a/drivers/iio/adc/ad7625.c b/drivers/iio/adc/ad7625.c
> new file mode 100644
> index 000000000000..b74760c2fee2
> --- /dev/null
> +++ b/drivers/iio/adc/ad7625.c
> @@ -0,0 +1,626 @@


> +
> +static int devm_ad7625_pwm_get(struct device *dev, struct clk *ref_clk,
> +				       struct ad7625_state *st)
> +{
> +	unsigned long ref_clk_rate_hz;
> +	int ret;
> +
> +	st->cnv_pwm = devm_pwm_get(dev, "cnv");
> +	if (IS_ERR(st->cnv_pwm))
> +		return dev_err_probe(dev, PTR_ERR(st->cnv_pwm),
> +				     "failed to get cnv pwm\n");
> +
> +	ret = devm_add_action_or_reset(dev, ad7625_pwm_disable, st->cnv_pwm);

Add a comment on why we are disabling the pwm but don't seem to have enabled it.
If this is unwinding something later in probe, move it there.

btw, your cover letter has a link to that patch set mentioned, but I'm not
seeing an actual link.

> +	if (ret)
> +		return ret;
> +
> +	st->clk_gate_pwm = devm_pwm_get(dev, "clk_gate");
> +	if (IS_ERR(st->clk_gate_pwm))
> +		return dev_err_probe(dev, PTR_ERR(st->clk_gate_pwm),
> +				     "failed to get clk_gate pwm\n");
> +
> +	ret = devm_add_action_or_reset(dev, ad7625_pwm_disable,
> +				       st->clk_gate_pwm);
> +	if (ret)
> +		return ret;
> +
> +	ref_clk = devm_clk_get_enabled(dev, NULL);
> +	if (IS_ERR(ref_clk))
> +		return dev_err_probe(dev, PTR_ERR(ref_clk),
> +				     "failed to get ref_clk");
> +
> +	ref_clk_rate_hz = clk_get_rate(ref_clk);
> +	if (!ref_clk_rate_hz)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "failed to get ref_clk rate");
> +
> +	st->ref_clk_rate_hz = ref_clk_rate_hz;
> +
> +	return 0;
> +}


...

> +static int ad7625_parse_mode(struct device *dev, struct ad7625_state *st, int num_gpios)
> +{
> +	bool en_always_on[4], en_always_off[4],
> +	     en_may_be_on[4], en_may_be_off[4];
Add another bool. Same number of chars and I think a tiny bit easier to read.

> +	char en_gpio_buf[4];
> +	char always_on_buf[18];
> +	int i;
> +
> +	for (i = 0; i < num_gpios; i++) {
> +		snprintf(en_gpio_buf, sizeof(en_gpio_buf), "en%d", i);
> +		snprintf(always_on_buf, sizeof(always_on_buf),
> +			 "adi,en%d-always-on", i);
> +		/* Set the device to 0b0000 (power-down mode) by default */
> +		st->en_gpios[i] = devm_gpiod_get_optional(dev, en_gpio_buf,
> +							  GPIOD_OUT_LOW);
> +		if (IS_ERR(st->en_gpios[i]))
> +			return dev_err_probe(dev, PTR_ERR(st->en_gpios[i]),
> +					     "failed to get EN%d GPIO\n", i);
> +
> +		en_always_on[i] = device_property_present(dev, always_on_buf);
> +		if (st->en_gpios[i] && en_always_on[i])
> +			return dev_err_probe(dev, -EINVAL,
> +				"cannot have both adi,en%d-always-on and en%d-gpios\n", i, i);
> +
> +		en_may_be_off[i] = !en_always_on[i];
> +		en_may_be_on[i] = en_always_on[i] || st->en_gpios[i];
> +		en_always_off[i] = !en_always_on[i] && !st->en_gpios[i];
> +	}
> +
> +	/*
> +	 * Power down is mode 0bXX00, but not all devices have a valid
> +	 * power down state.
> +	 */
> +	st->can_power_down = en_may_be_off[1] && en_may_be_off[0] &&
> +			     st->info->has_power_down_state;
> +	/*
> +	 * The REFIN pin can take a 1.2V (AD762x) or 2.048V (AD796x)
> +	 * external reference when the mode is 0bXX01.
> +	 */
> +	st->can_refin = en_may_be_off[1] && en_may_be_on[0];
> +	/* 4.096V can be applied to REF when the EN mode is 0bXX10. */
> +	st->can_ref_4v096 = en_may_be_on[1] && en_may_be_off[0];
> +
> +	/* Avoid AD796x-specific setup if the part is an AD762x */
> +	if (num_gpios == 2)
> +		return 0;
> +
> +	/* mode 0b1100 (AD796x) is invalid */
> +	if (en_always_on[3] && en_always_on[2] && en_always_off[1] && en_always_off[0])
> +		return dev_err_probe(dev, -EINVAL,
> +				     "EN GPIOs set to invalid mode 0b1100\n");
> +	/*
> +	 * 5V can be applied to the AD796x REF pin when the EN mode is
> +	 * the same (0bX001 or 0bX101) as for can_refin, and REFIN is
> +	 * 0V.
> +	 */
> +	st->can_ref_5v = st->can_refin;
> +	/*
> +	 * Bandwidth (AD796x) is controlled solely by EN2. If it's
> +	 * specified and not hard-wired, then we can configure it to
> +	 * change the bandwidth between 28MHz and 9MHz.
> +	 */
> +	st->can_narrow_bandwidth = en_may_be_on[2];
> +	/* Wide bandwidth mode is possible if EN2 can be 0. */
> +	st->can_wide_bandwidth = en_may_be_off[2];
> +	/* Snooze mode (AD796x) is 0bXX11 when REFIN = 0V. */
> +	st->can_snooze = en_may_be_on[1] && en_may_be_on[0];
> +	/* Test pattern mode (AD796x) is 0b0100. */
> +	st->can_test_pattern = en_may_be_off[3] && en_may_be_on[2] &&
> +			       en_may_be_off[1] && en_may_be_off[0];
> +
> +	return 0;
> +}//

> +
> +static int ad7960_set_mode(struct ad7625_state *st, enum ad7960_mode mode,
> +			   bool have_refin, int ref_mv)
> +{
> +	switch (mode) {
> +	case AD7960_MODE_POWER_DOWN:
> +		if (!st->can_power_down)
> +			return -EINVAL;
> +
> +		gpiod_set_value_cansleep(st->en_gpios[2], 0);
> +		gpiod_set_value_cansleep(st->en_gpios[1], 0);
> +		gpiod_set_value_cansleep(st->en_gpios[0], 0);

Blank lines before simple 'good' returns can make things a little easier to read.
So here.

> +		return 0;
> +
> +	case AD7960_MODE_SNOOZE:
> +		if (!st->can_snooze)
> +			return -EINVAL;
> +
> +		gpiod_set_value_cansleep(st->en_gpios[1], 1);
> +		gpiod_set_value_cansleep(st->en_gpios[0], 1);
here
> +		return 0;
> +
> +	case AD7960_MODE_NARROW_BANDWIDTH:
> +		if (!st->can_narrow_bandwidth)
> +			return -EINVAL;
> +
> +		gpiod_set_value_cansleep(st->en_gpios[2], 1);
> +		ad7625_set_en_gpios_for_vref(st, have_refin, ref_mv);
here etc

> +		return 0;
> +
> +	case AD7960_MODE_WIDE_BANDWIDTH:
> +		if (!st->can_wide_bandwidth)
> +			return -EINVAL;
> +
> +		gpiod_set_value_cansleep(st->en_gpios[2], 0);
> +		ad7625_set_en_gpios_for_vref(st, have_refin, ref_mv);
> +		return 0;
> +
> +	case AD7960_MODE_TEST_PATTERN:
> +		if (!st->can_test_pattern)
> +			return -EINVAL;
> +
> +		gpiod_set_value_cansleep(st->en_gpios[3], 0);
> +		gpiod_set_value_cansleep(st->en_gpios[2], 1);
> +		gpiod_set_value_cansleep(st->en_gpios[1], 0);
> +		gpiod_set_value_cansleep(st->en_gpios[0], 0);
> +		return 0;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad7625_probe(struct platform_device *pdev)
> +{
> +	/*
> +	 * Power-up info for the device says to bring up vio, then
> +	 * vdd2, then vdd1
> +	 */
> +	static const char * const regulator_names[] = { "vio", "vdd2", "vdd1" };
> +	struct device *dev = &pdev->dev;
> +	struct iio_dev *indio_dev;
> +	struct ad7625_state *st;
> +	struct clk *ref_clk;
> +	int ret, ref_mv;
> +	int default_sample_freq;
> +	bool have_refin;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +
> +	st->info = device_get_match_data(dev);
> +	if (!st->info)
> +		return dev_err_probe(dev, -EINVAL, "no chip info\n");
> +
> +	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(regulator_names),
> +		regulator_names);
Align after (

> +	if (ret)
> +		return ret;
> +
> +	if (st->info->has_bandwidth_control)
> +		ret = ad7625_parse_mode(dev, st, 4);
> +	else
> +		ret = ad7625_parse_mode(dev, st, 2);
> +
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Determine the source of the reference voltage:
> +	 * - internal reference: neither REF or REFIN is connected
> +	 *   (invalid for AD796x)
> +	 * - internal buffer, external reference: REF not connected,
> +	 *   is REFIN connected
> +	 * - external reference: REF connected, REFIN not connected
> +	 */
> +	ret = devm_regulator_get_enable_read_voltage(dev, "ref");

Given this regulator related block of code is complex, perhaps lift it
to a separate function where you can add docs for the function as
a whole?

> +	if (ret < 0 && ret != -ENODEV)
> +		return dev_err_probe(dev, ret, "failed to get REF voltage\n");
> +
> +	ref_mv = ret == -ENODEV ? 0 : ret / 1000;
> +
> +	ret = devm_regulator_get_enable_optional(dev, "refin");
> +	if (ret < 0 && ret != -ENODEV)
> +		return dev_err_probe(dev, ret, "failed to get REFIN voltage\n");
> +
> +	have_refin = ret != -ENODEV;
> +
> +	if (have_refin && !st->can_refin)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "REFIN provided in unsupported mode\n");
> +
> +	if (!st->info->has_internal_vref && !have_refin && !ref_mv)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Need either REFIN or REF");
> +
> +	if (have_refin && ref_mv)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "cannot have both REFIN and REF supplies\n");
> +
> +	st->vref_mv = ref_mv ?: AD7625_INTERNAL_REF_MV;
> +
> +	if (ref_mv == 4096 && !st->can_ref_4v096)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "REF is 4.096V in unsupported mode\n");
> +
> +	if (ref_mv == 5000 && !st->can_ref_5v)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "REF is 5V in unsupported mode\n");
> +
> +	/* Set the device mode based on detected EN configuration. */
> +	if (!st->info->has_bandwidth_control) {
> +		ad7625_set_en_gpios_for_vref(st, have_refin, ref_mv);
> +	} else {
> +		/*
> +		 * If neither sampling mode is available, then report an error,
> +		 * since the other modes are not useful defaults.
> +		 */
> +		if (st->can_wide_bandwidth) {
> +			ret = ad7960_set_mode(st, AD7960_MODE_WIDE_BANDWIDTH,
> +				have_refin, ref_mv);

Align just after (

> +		} else if (st->can_narrow_bandwidth) {
> +			ret = ad7960_set_mode(st, AD7960_MODE_NARROW_BANDWIDTH,
> +				have_refin, ref_mv);
> +		} else {
> +			return dev_err_probe(dev, -EINVAL,
> +				"couldn't set device to wide or narrow bandwidth modes\n");
Fine to not align this one as it won't fit on a reasonable short line if you do.
For other cases, aligning is preferred.

> +		}
> +
> +		if (ret)
> +			return dev_err_probe(dev, -EINVAL,
> +					     "failed to set EN pins\n");
> +	}
> +
> +	ret = devm_ad7625_pwm_get(dev, ref_clk, st);
> +	if (ret)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "failed to set ref_clk_rate_hz\n");
> +
> +	indio_dev->channels = &st->info->chan_spec;
> +	indio_dev->num_channels = 1;
> +	indio_dev->name = st->info->name;
> +	indio_dev->info = &ad7625_info;
> +
> +	st->back = devm_iio_backend_get(dev, NULL);
> +	if (IS_ERR(st->back))
> +		return dev_err_probe(dev, PTR_ERR(st->back),
> +				     "failed to get IIO backend");
> +
> +	ret = devm_iio_backend_request_buffer(dev, st->back, indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_iio_backend_enable(dev, st->back);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Set the initial sampling frequency to the maximum, unless the
> +	 * AD796x device is limited to narrow bandwidth, in which case

Maybe add 'why' it is limited here - which I think is down to one of the
gpios not being wired up in a controllable fashion.

> +	 * the sampling frequency should be limited to 2MSPS
> +	 */
> +	if (!st->info->has_bandwidth_control) {
> +		default_sample_freq = st->info->max_sample_rate_hz;
> +	} else {
> +		default_sample_freq = !st->can_wide_bandwidth ? AD7960_MAX_NBW_FREQ :
> +				      st->info->max_sample_rate_hz;
> +	}
> +
> +	ret = ad7625_set_sampling_freq(st, default_sample_freq);
> +	if (ret < 0)
> +		dev_err_probe(dev, ret, "failed to set sampling frequency\n");

return dev_err_probe();
If it's not a fatal error, then dev_err* is not appropriate.

> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +
> +static const struct of_device_id ad7625_of_match[] = {
> +	{ .compatible = "adi,ad7625", .data = &ad7625_chip_info, },

Trivial but inconsistent to have , after last entry here, but not in platform_device_id
entries below.  I don't mind which but pick one.

> +	{ .compatible = "adi,ad7626", .data = &ad7626_chip_info, },
> +	{ .compatible = "adi,ad7960", .data = &ad7960_chip_info, },
> +	{ .compatible = "adi,ad7961", .data = &ad7961_chip_info, },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, ad7625_of_match);
> +
> +static const struct platform_device_id ad7625_device_ids[] = {
> +	{ .name = "ad7625", .driver_data = (kernel_ulong_t)&ad7625_chip_info },
> +	{ .name = "ad7626", .driver_data = (kernel_ulong_t)&ad7626_chip_info },
> +	{ .name = "ad7960", .driver_data = (kernel_ulong_t)&ad7960_chip_info },
> +	{ .name = "ad7961", .driver_data = (kernel_ulong_t)&ad7961_chip_info },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(platform, ad7625_device_ids);
> +
> +static struct platform_driver ad7625_driver = {
> +	.probe = ad7625_probe,
> +	.driver = {
> +		.name = "ad7625",
> +		.of_match_table = ad7625_of_match,
> +	},
> +	.id_table = ad7625_device_ids,
> +};
> +module_platform_driver(ad7625_driver);
> +
> +MODULE_AUTHOR("Trevor Gamblin <tgamblin@baylibre.com>");
> +MODULE_DESCRIPTION("Analog Devices AD7625 ADC");
> +MODULE_LICENSE("Dual BSD/GPL");
> +MODULE_IMPORT_NS(IIO_BACKEND);
> 


