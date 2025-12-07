Return-Path: <linux-iio+bounces-26878-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E151BCAB58C
	for <lists+linux-iio@lfdr.de>; Sun, 07 Dec 2025 14:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C43883045F4B
	for <lists+linux-iio@lfdr.de>; Sun,  7 Dec 2025 13:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5902D97AF;
	Sun,  7 Dec 2025 13:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YfXBt6S9"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C10A1E5B9E;
	Sun,  7 Dec 2025 13:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765114902; cv=none; b=DCrhmuSaHi+LIEi6oYSLXaWG1RUOH0lA3HZO8r3jRGXmeoDmKa/9BFNj0ARmoFYuIcGGJC0nyaarPQu2JuE4dXNgJ90TZ60OLZ1pIC3bqzyAulN7fpnPnT8CjU+XjxeGIMCGvPWw7WYm4kT7BtOCQ3lnAJzVV9iHpgfHM/xZsmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765114902; c=relaxed/simple;
	bh=eOKxloQZSKnEuMHoDAJ+och1P2JGXo4BV3PNqIIwi/8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oIPxv32DKeCxXixH7HVGs/3XQp0Tj3PeVo1oSX2gQBYYcH5fbWW0XOmHZ7a3UmnXFmlBUP9hz2q1ZjLxHkUEV32oTLN9X3/RDqJXuYuhAUTSQ5rNleknsVCYZhr+KZZfSJ5e61wjAC/ofewNe2p+W+nABv7K+nbWOln8Y57c1hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YfXBt6S9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37B5CC4CEFB;
	Sun,  7 Dec 2025 13:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765114901;
	bh=eOKxloQZSKnEuMHoDAJ+och1P2JGXo4BV3PNqIIwi/8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YfXBt6S9NSwPIAptYHrGdi+h+2LJFAZ37VQUCRWLBJEaLAPY0RdJwcpqGGiNrP8NJ
	 97SJ+C9syOBQ+e+sEKscF0dUkl0gbt5zbqR19qp46sXmM1jlwQ+Z1y8ej/TaL8Vm1X
	 TcmjfUfoK9E44FgiWp7tPPQtqTgWG6T4j/DG0uyf+BUsabKSo99dTcRUCJAkF2zqW7
	 +8jKwBH2YGsIjkOSnRBt0sSdG32ShtBWy660rSxtNyxC6oFqwteqnuGHwJQRMxbUKI
	 s4DjnGr+ZmdOi9Ebu7oLDxGdbTn013xa7AeJ6jd1be2d4r+v8LPhYCp/StuCQv2wXq
	 nIv88NbMPpwBg==
Date: Sun, 7 Dec 2025 13:41:32 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nuno.sa@analog.com>, <dlechner@baylibre.com>, <andy@kernel.org>,
 <Michael.Hennerich@analog.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <corbet@lwn.net>, <marcelo.schmitt1@gmail.com>
Subject: Re: [PATCH v3 2/3] iio: adc: Initial support for AD4134
Message-ID: <20251207134132.33f80c08@jic23-huawei>
In-Reply-To: <c189c25b1c46f406c3f7942e5ac4cdb0b964ee52.1764708608.git.marcelo.schmitt@analog.com>
References: <cover.1764708608.git.marcelo.schmitt@analog.com>
	<c189c25b1c46f406c3f7942e5ac4cdb0b964ee52.1764708608.git.marcelo.schmitt@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 2 Dec 2025 17:55:21 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> AD4134 is a 24-bit, 4-channel, simultaneous sampling, precision
> analog-to-digital converter (ADC). The device can be managed through SPI or
> direct control of pin logical levels (pin control mode). The AD4134 design
> also features a dedicated bus for ADC sample data output. Though, this
> initial driver for AD4134 only supports usual SPI connections.
> 
> Add basic support for AD4134 that enables single-shot ADC sample read.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
Hi Marcelo

Nice and clean which makes for pleasant reviewing :)
A few minor comments inline.

Jonathan

> diff --git a/drivers/iio/adc/ad4134.c b/drivers/iio/adc/ad4134.c
> new file mode 100644
> index 000000000000..7158eefcd877
> --- /dev/null
> +++ b/drivers/iio/adc/ad4134.c


> +static int ad4134_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan,
> +			   int *val, int *val2, long info)
> +{
> +	struct ad4134_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_RAW:
> +		gpiod_set_value_cansleep(st->odr_gpio, 1);
> +		fsleep(1);
Any section reference for required pulse width that you can add as a comment here?

It's useful if people end up wondering if the pulse is long enough if they have
problems with a board.

> +		gpiod_set_value_cansleep(st->odr_gpio, 0);
> +		ret = regmap_read(st->regmap, AD4134_CH_VREG(chan->channel), val);
> +		if (ret)
> +			return ret;
> +
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = st->refin_mv;
> +		*val2 = AD4134_CHAN_PRECISION_BITS - 1;
> +
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +	default:
> +		return -EINVAL;
> +	}
> +}

> +
> +static const char * const ad4143_regulator_names[] = {
> +	"avdd5", "dvdd5", "iovdd", "refin",
> +	"avdd1v8", "dvdd1v8", "clkvdd",	"ldoin",
> +};
> +
> +static int ad4134_regulator_setup(struct ad4134_state *st)
> +{
> +	struct device *dev = &st->spi->dev;
> +	bool use_internal_ldo_regulator;
> +	int ret;
> +
> +	/* Required regulators */
> +	ret = devm_regulator_bulk_get_enable(dev, 3, ad4143_regulator_names);

Why list names of regulators in that array that you don't use? I'd call it
ad4143_required_regulator_names and then you can use ARRAY_SIZE() to replace
that 3.

> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to enable power supplies\n");
> +
> +	/* Required regulator that we need to read the voltage */
> +	ret = devm_regulator_get_enable_read_voltage(dev, "refin");
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "failed to get REFIN voltage.\n");
> +
> +	st->refin_mv = ret / (MICRO / MILLI);
> +
> +	/*
> +	 * If ldoin is not provided, then avdd1v8, dvdd1v8, and clkvdd are
> +	 * required.
> +	 */
> +	ret = devm_regulator_get_enable_optional(dev, "ldoin");
> +	if (ret < 0 && ret != -ENODEV)
> +		return dev_err_probe(dev, ret, "failed to enable ldoin supply\n");
> +
> +	use_internal_ldo_regulator = ret == 0;
> +
> +	if (use_internal_ldo_regulator)
> +		return 0;
> +

For these 3 you can use a second array of names and devm_regulator_bulk_get_enable()
Finding a short descriptive name for that array might be tricky however.

> +	ret = devm_regulator_get_enable(dev, "avdd1v8");
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "failed to enable avdd1v8 supply\n");
> +
> +	ret = devm_regulator_get_enable(dev, "dvdd1v8");
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "failed to enable dvdd1v8 supply\n");
> +
> +	ret = devm_regulator_get_enable(dev, "clkvdd");
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "failed to enable clkvdd supply\n");
> +
> +	return 0;
> +}
> +
> +static int ad4134_clock_select(struct ad4134_state *st)
> +{
> +	struct device *dev = &st->spi->dev;
> +	struct clk *sys_clk;
> +
> +	/*
> +	 * AD4134 requires one external clock source and only one external clock
> +	 * source can be provided at a time. Try get a crystal provided clock.
> +	 * If that fails, try to get a CMOS clock.
> +	 */
> +	sys_clk = devm_clk_get_optional_enabled(dev, "xtal1-xtal2");

I should have noticed this in the binding review.  Why do we need to call out which
xtal pins?  Previous cases of this have just used the name "xtal" for the clock
type selection.  Maybe there was some discussion I missed.

> +	if (IS_ERR_OR_NULL(sys_clk)) {
> +		if (PTR_ERR(sys_clk) == -EPROBE_DEFER)
> +			return -EPROBE_DEFER;
> +
> +		/* Try the CMOS clock */
> +		sys_clk = devm_clk_get_enabled(dev, "clkin");
> +		if (IS_ERR(sys_clk)) {
> +			if (PTR_ERR(sys_clk) == -EPROBE_DEFER)
> +				return -EPROBE_DEFER;
> +
> +			return dev_err_probe(dev, PTR_ERR(sys_clk),
> +					     "failed to get external clock\n");
> +		}
> +	}
> +
> +	st->sys_clk_hz = clk_get_rate(sys_clk);
> +	if (st->sys_clk_hz != AD4134_EXT_CLOCK_MHZ)
> +		dev_warn(dev, "invalid external clock frequency %lu\n",
> +			 st->sys_clk_hz);
> +
> +	return 0;
> +}

