Return-Path: <linux-iio+bounces-16567-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0433EA57BC0
	for <lists+linux-iio@lfdr.de>; Sat,  8 Mar 2025 17:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E34CF3B2580
	for <lists+linux-iio@lfdr.de>; Sat,  8 Mar 2025 16:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C79E1CB9EA;
	Sat,  8 Mar 2025 16:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pVnsmIeE"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A79B14A8B;
	Sat,  8 Mar 2025 16:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741449788; cv=none; b=chRPPgkMVMYLldHrLhoE4IlxgMSfK7XtMvdTPIHJLun74RjFrapCgf/NxgBOWxQkiymuK2uVd7X3AlyjOQNt3uFNJu6tJb+qpvTeYaERR7q3kSDUyP9Y7i5I4gAe6dUmKUse2KJ1/uyTQV0YxZouiRsHYYzjjegSjAxU1mFxNCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741449788; c=relaxed/simple;
	bh=yNpXGRdIbNprpAo0UvjJaSSc/x6ILCPYEZiyzp8Uzcw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wx/rY8bxX5ARtLAeKx3h9MVS7Ir8KtLpO++SYjRHKbtJFf0uDg3EDRp2c0ETOEsC9UbSAtMaFsY38fQF4N9mEpM3mpLaQ0BQRloGG7w8cJAg2DvS9NZ16O0lJCFNVmU/9bTm6x9RYYhMgkOBQ3kAq7EK2kGE7u9TFk9pHT5aeds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pVnsmIeE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35235C4CEE0;
	Sat,  8 Mar 2025 16:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741449787;
	bh=yNpXGRdIbNprpAo0UvjJaSSc/x6ILCPYEZiyzp8Uzcw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pVnsmIeEV3wZ9deYFezvHoHfv0oAs/mI7rbPUuCipX+v0JNZ2+atNnfDeRP+aJnJC
	 Nm/9OSxsv0qwt+kj+XjPM0HeTHcfspboXy2rRnxHFnlxYAkF6WL5e35vTErFllr8cc
	 /1ZRef7cCmvufVQFzS0g6L7lyafrekT8z9uRrH/UADjQ/mdKLuC0AcePkU+suUQOUC
	 vXKK1uygg7EmzgA5nfdu7iAidsrEbfMbXZn1gNwVol8OfZh//VGZdhcM2uqFKV7UMo
	 diGIwAj+L3TntiRpIHOmgKUInlc6xG5531FHsO/WXfE4qtuDwX7JmTq/BLEdRhnqwt
	 zV1EC8g/3XFsA==
Date: Sat, 8 Mar 2025 16:02:57 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jorge Marques <jorge.marques@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, David Lechner <dlechner@baylibre.com>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH 4/4] iio: adc: add support for ad4052
Message-ID: <20250308160257.051395fa@jic23-huawei>
In-Reply-To: <20250306-iio-driver-ad4052-v1-4-2badad30116c@analog.com>
References: <20250306-iio-driver-ad4052-v1-0-2badad30116c@analog.com>
	<20250306-iio-driver-ad4052-v1-4-2badad30116c@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Mar 2025 15:03:17 +0100
Jorge Marques <jorge.marques@analog.com> wrote:

> The AD4052/AD4058/AD4050/AD4056 are versatile, 16-bit/12-bit,
> successive approximation register (SAR) analog-to-digital converter (ADC)
> that enables low-power, high-density data acquisition solutions without
> sacrificing precision.
> This ADC offers a unique balance of performance and power efficiency,
> plus innovative features for seamlessly switching between high-resolution
> and low-power modes tailored to the immediate needs of the system.
> The AD4052/AD4058/AD4050/AD4056 are ideal for battery-powered,
> compact data acquisition and edge sensing applications.
> 
> Signed-off-by: Jorge Marques <jorge.marques@analog.com>
Hi Jorge

Various fairly minor comments inline.

Jonathan

> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 27413516216cb3f83cf1d995b9ffc22bf01776a4..f518dadbdd3a6b0543d0b78206fcbc203898454c 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -62,6 +62,20 @@ config AD4130
>  	  To compile this driver as a module, choose M here: the module will be
>  	  called ad4130.
>  
> +config AD4052
Aim for alphanumeric order so this should at least be before AD4130

> +	tristate "Analog Devices AD4052 Driver"
> +	depends on SPI
> +	select SPI_OFFLOAD
> +	select IIO_BUFFER
> +	select IIO_BUFFER_DMAENGINE
> +	select REGMAP_SPI
> +	help
> +	  Say yes here to build support for Analog Devices AD4052 SPI analog
> +	  to digital converters (ADC).
> +
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called ad4052.
> +

> diff --git a/drivers/iio/adc/ad4052.c b/drivers/iio/adc/ad4052.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..29452963fb15ab1b11e3a2fc59c34a2579f25910
> --- /dev/null
> +++ b/drivers/iio/adc/ad4052.c
> @@ -0,0 +1,1289 @@

...

> +#define AD4052_REG_FUSE_CRC		0x40
> +#define AD4052_REG_DEVICE_STATUS	0x41
> +#define AD4052_REG_MIN_SAMPLE		0x45
> +#define AD4052_MAX_REG			0x45
> +/* GP_CONFIG */
Where possible it makes for easier to follow code if the field defines
include what register they are in rather than relying on comments. 
e.g.
#define AD4052_GP_CONFIG_MODE_MASK(x) etc

> +#define AD4052_GP_MODE_MSK(x)		(GENMASK(2, 0) << (x) * 4)
Macro is a bit too 'clever'.  I think it would easier to just have
AD4052_GP_CONFIG_GP0_MODE_MSK	GENMMSK(2, 0)
AD4052_GP_CONFIG_GP1_MODE_MSK	GENMASK(6, 4)

> +/* INTR_CONFIG */
> +#define AD4052_INTR_EN_MSK(x)		(GENMASK(1, 0) << (x) * 4)
Similar for this one.
> +/* ADC_MODES */
> +#define AD4052_DATA_FORMAT		BIT(7)
> +/* DEVICE_CONFIG */
> +#define AD4052_POWER_MODE_MSK		GENMASK(1, 0)
> +#define AD4052_LOW_POWER_MODE		3
> +/* DEVICE_STATUS */
> +#define AD4052_DEVICE_RESET		BIT(6)
> +#define AD4052_THRESH_OVERRUN		BIT(4)
> +#define AD4052_MAX_FLAG			BIT(3)
> +#define AD4052_MIN_FLAG			BIT(2)
> +#define AD4052_EVENT_CLEAR		(AD4052_THRESH_OVERRUN | AD4052_MAX_FLAG | AD4052_MIN_FLAG)
Wrap the define with \ to break the line.

> +/* TIMER_CONFIG */
> +#define AD4052_FS_MASK			GENMASK(7, 4)
> +#define AD4052_300KSPS			0x2
> +
> +#define AD4052_SPI_VENDOR		0x0456
> +
> +#define AD4050_MAX_AVG			0x7
> +#define AD4052_MAX_AVG			0xB
> +#define AD4052_CHECK_OVERSAMPLING(x, y)	({typeof(y) y_ = (y); \
> +					  ((y_) < 0 || (y_) > BIT((x) + 1)); })

Don't have single use macros like these.  Better to have the code inline
where we can see what it is doing.

> +#define AD4052_MAX_RATE(x)		((x) == AD4052_500KSPS ? 500000 : 2000000)
> +#define AD4052_CHECK_RATE(x, y)		({typeof(y) y_ = (y);				\
> +					  ((y_) > AD4052_MAX_RATE(x) || (y_) <= 0); })
> +#define AD4052_FS_OFFSET(g)		((g) == AD4052_500KSPS ? 2 : 0)
> +#define AD4052_FS(g)			(&ad4052_sample_rates[AD4052_FS_OFFSET(g)])
> +#define AD4052_FS_LEN(g)		(ARRAY_SIZE(ad4052_sample_rates) - (AD4052_FS_OFFSET(g)))

...

> +static const int ad4052_sample_rate_avail[] = {
> +	2000000, 1000000, 300000, 100000, 33300,
> +	10000, 3000, 500, 333, 250, 200,
> +	166, 140, 125, 111

trailing comma missing

> +};
> +
> +static const char *const ad4052_sample_rates[] = {
> +	"2000000", "1000000", "300000", "100000", "33300",
> +	"10000", "3000", "500", "333", "250", "200",
> +	"166", "140", "124", "111",
Not sure why this can't be done with read_avail and the values above.
> +};
> +
> +static int ad4052_iio_device_claim_direct(struct iio_dev *indio_dev,
> +					  struct ad4052_state *st)
> +{
> +	if (!iio_device_claim_direct(indio_dev))
> +		return false;

This might stretch sparses ability to keep track or __acquire / __release.
Make sure to check that with a C=1 build. If the cond_acquires
stuff is merged into sparse, this may need a revisit for markings.

> +
> +	/**

Not kernel-doc, so /*

> +	 * If the device is in monitor mode, no register access is allowed,
> +	 * since it would put the device back in configuration mode.
> +	 */
> +	if (st->wait_event) {
> +		iio_device_release_direct(indio_dev);
> +		return false;
> +	}
> +	return true;
> +}
> +
> +static int ad4052_sample_rate_get(struct iio_dev *indio_dev,
> +				  const struct iio_chan_spec *chan)
> +{
> +	struct ad4052_state *st = iio_priv(indio_dev);
> +	int ret, val;
> +
> +	if (!ad4052_iio_device_claim_direct(indio_dev, st))
> +		return -EBUSY;
> +
> +	ret = regmap_read(st->regmap, AD4052_REG_TIMER_CONFIG, &val);
> +	val = FIELD_GET(AD4052_FS_MASK, val);

I don't really like the double use of the val variable as it loses
meaning we could otherwise provide in the variable naming.

> +
> +	iio_device_release_direct(indio_dev);
> +	return ret ? ret : val - AD4052_FS_OFFSET(st->chip->grade);
> +}
> +
> +static int ad4052_sample_rate_set(struct iio_dev *indio_dev,
> +				  const struct iio_chan_spec *chan,
> +				  unsigned int val)
> +{
> +	struct ad4052_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	if (!ad4052_iio_device_claim_direct(indio_dev, st))
> +		return -EBUSY;
> +
> +	val += AD4052_FS_OFFSET(st->chip->grade);
> +	val = FIELD_PREP(AD4052_FS_MASK, val);

Using val for two different things here. I'd avoid that
by just having this last line merged with the next one.

> +	ret = regmap_write(st->regmap, AD4052_REG_TIMER_CONFIG, val);
> +
> +	iio_device_release_direct(indio_dev);
> +	return ret;
> +}

> +
> +#define AD4052_EXT_INFO(grade)								\
> +static struct iio_chan_spec_ext_info grade##_ext_info[] = {				\
> +	IIO_ENUM("sample_rate", IIO_SHARED_BY_ALL, &grade##_sample_rate_enum),		\
> +	IIO_ENUM_AVAILABLE("sample_rate", IIO_SHARED_BY_ALL, &grade##_sample_rate_enum),\
> +	{}										\
{ }
preferred slightly.

> +}


> +static int ad4052_get_oversampling_ratio(struct ad4052_state *st,
> +					 unsigned int *val)
> +{
> +	int ret;
> +
> +	if (st->mode == AD4052_SAMPLE_MODE) {
> +		*val = 0;

Probably = 1 to reflect no oversampling.
IIRC the attribute allows either but to me at least a default of 1
is more logical.

> +		return 0;
> +	}
> +
> +	ret = regmap_read(st->regmap, AD4052_REG_AVG_CONFIG, val);
> +	if (ret)
> +		return ret;
> +
> +	*val = BIT(*val + 1);
> +
> +	return 0;
> +}
> +
> +static int ad4052_assert(struct ad4052_state *st)
Slighly odd name.  check_ids or something like that.

> +{
> +	int ret;
> +	u16 val;
> +
> +	ret = regmap_bulk_read(st->regmap, AD4052_REG_PROD_ID_1, &st->d16, 2);

sizeof(st->d16) here and in similar places.

> +	if (ret)
> +		return ret;
> +
> +	val = be16_to_cpu(st->d16);
> +	if (val != st->chip->prod_id)
> +		return -ENODEV;

Should not be treated as a failure as that breaks the future use of
fallback compatible values in DT (support new hardware on old kernel)
Instead just print a message saying it didn't match and carry on as if it did.

> +
> +	ret = regmap_bulk_read(st->regmap, AD4052_REG_VENDOR_H, &st->d16, 2);
> +	if (ret)
> +		return ret;
> +
> +	val = be16_to_cpu(st->d16);
> +	if (val != AD4052_SPI_VENDOR)
> +		return -ENODEV;
> +
> +	return 0;
> +}

> +
> +static int ad4052_set_operation_mode(struct ad4052_state *st, enum ad4052_operation_mode mode)
> +{
> +	u8 val = st->data_format | mode;

Maybe regmap_update_bits so we don't have to store st->data_format if
that bit has already been written.

> +	int ret;
> +
> +	ret = regmap_write(st->regmap, AD4052_REG_ADC_MODES, val);
> +	if (ret)
> +		return ret;
> +
> +	val = BIT(0);

This should have some sort of define and then use that inline
in the regmap_write() call.


> +	return regmap_write(st->regmap, AD4052_REG_MODE_SET, val);
> +}

> +
> +static int ad4052_set_non_defaults(struct iio_dev *indio_dev,
i kind of get where you are coming from with the 'non defaults'
but we are setting software driven defaults here.

Maybe just rename as ad4052_setup() or something similarly vague.

> +				   struct iio_chan_spec const *chan)
> +{
> +	struct ad4052_state *st = iio_priv(indio_dev);
> +	const struct iio_scan_type *scan_type;
> +
> +	scan_type = iio_get_current_scan_type(indio_dev, chan);
> +
> +	u8 val = FIELD_PREP(AD4052_GP_MODE_MSK(0), AD4052_GP_INTR) |
> +		 FIELD_PREP(AD4052_GP_MODE_MSK(1), AD4052_GP_DRDY);
> +	int ret;
> +
> +	ret = regmap_update_bits(st->regmap, AD4052_REG_GP_CONFIG,
> +				 AD4052_GP_MODE_MSK(1) | AD4052_GP_MODE_MSK(0),
> +				 val);
> +	if (ret)
> +		return ret;
> +
> +	val = FIELD_PREP(AD4052_INTR_EN_MSK(0), (AD4052_INTR_EN_EITHER)) |
> +	      FIELD_PREP(AD4052_INTR_EN_MSK(1), (AD4052_INTR_EN_NEITHER));
> +
> +	ret = regmap_update_bits(st->regmap, AD4052_REG_INTR_CONFIG,
> +				 AD4052_INTR_EN_MSK(0) | AD4052_INTR_EN_MSK(1),
> +				 val);
> +	if (ret)
> +		return ret;
> +
> +	val = 0;
> +	if (scan_type->sign == 's')
> +		val |= AD4052_DATA_FORMAT;
> +
> +	st->data_format = val;
> +
> +	if (st->chip->grade == AD4052_500KSPS) {
> +		ret = regmap_write(st->regmap, AD4052_REG_TIMER_CONFIG,
> +				   FIELD_PREP(AD4052_FS_MASK, AD4052_300KSPS));
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return regmap_write(st->regmap, AD4052_REG_ADC_MODES, val);
> +}

> +
> +static int ad4052_request_irq(struct iio_dev *indio_dev)
> +{
> +	struct ad4052_state *st = iio_priv(indio_dev);
> +	struct device *dev = &st->spi->dev;
> +	int ret = 0;
> +
> +	ret = fwnode_irq_get(dev_fwnode(&st->spi->dev), 0);

As per the binding review, use named variant as we should
not be controlling the order, but rather specifying which
is which in the dt-binding.

> +	if (ret <= 0)
> +		return ret ? ret : -EINVAL;
> +
> +	ret = devm_request_threaded_irq(dev,
> +					ret, NULL, ad4052_irq_handler_thresh,

odd wrap.  Take each line up to 80 chars before wrapping to next one.

> +					IRQF_TRIGGER_RISING | IRQF_ONESHOT,

Direction should come from firmware, not be specified here.
There might be an inverter in the path.  That used to be a common cheap
way of doing level conversion for interrupt lines and it is handled by
flipping the sense of the interrupt in the dts.

> +					indio_dev->name, indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = fwnode_irq_get(dev_fwnode(&st->spi->dev), 1);
> +	if (ret <= 0)
> +		return ret ? ret : -EINVAL;
> +
> +	st->gp1_irq = ret;
> +	ret = devm_request_threaded_irq(dev,
> +					ret, NULL, ad4052_irq_handler_drdy,
> +					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> +					indio_dev->name, st);
return devm_request_thread_irq.

> +	return ret;
> +}
> +
> +static const int ad4052_oversampling_avail[] = {
> +	0, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096

Always a trailing comma unless it is some form of terminator.

Oversampling ratio of 0 is a bit strange. That should probably be 1
to reflect 1 sample per reading output (or no oversampling).

> +};

> +
> +static ssize_t ad4052_set_sampling_freq(struct ad4052_state *st, unsigned int val)
> +{
> +	int ret;
> +
> +	if (AD4052_CHECK_RATE(st->chip->grade, val))
> +		return -EINVAL;
> +
> +	ret = __ad4052_set_sampling_freq(st, val);
> +
> +	return ret;
	return __ad4052_set_sampling_freq(st, val);

> +}



> +static int ad4052_write_event_config(struct iio_dev *indio_dev,
> +				     const struct iio_chan_spec *chan,
> +				     enum iio_event_type type,
> +				     enum iio_event_direction dir,
> +				     bool state)
> +{
> +	struct ad4052_state *st = iio_priv(indio_dev);
> +	int ret = -EBUSY;
> +
> +	if (!iio_device_claim_direct(indio_dev))
> +		return -EBUSY;
> +
> +	if (st->wait_event == state)
> +		goto out_release;
> +
> +	if (state) {
> +		ret = pm_runtime_resume_and_get(&st->spi->dev);
> +		if (ret)
> +			goto out_release;
> +
> +		ret = ad4052_set_operation_mode(st, AD4052_MONITOR_MODE);
> +		if (ret)
> +			goto out_err_suspend;
Given the error handling is different in the two paths, I'd
split this into two helpers - one each for enable and disable.
Probably take the direct claim around where they are called.

> +	} else {
> +		pm_runtime_mark_last_busy(&st->spi->dev);
> +		pm_runtime_put_autosuspend(&st->spi->dev);
> +
> +		ret = ad4052_exit_command(st);
> +	}
> +	st->wait_event = state;
> +	iio_device_release_direct(indio_dev);
> +	return ret;
> +
> +out_err_suspend:
> +	pm_runtime_mark_last_busy(&st->spi->dev);
> +	pm_runtime_put_autosuspend(&st->spi->dev);
> +
> +out_release:
> +	iio_device_release_direct(indio_dev);
> +	return ret;
> +}
> +
> +static int ad4052_read_event_value(struct iio_dev *indio_dev,
> +				   const struct iio_chan_spec *chan,
> +				   enum iio_event_type type,
> +				   enum iio_event_direction dir,
> +				   enum iio_event_info info, int *val,
> +				   int *val2)
> +{
> +	struct ad4052_state *st = iio_priv(indio_dev);
> +	u8 reg, size = 1;
> +	int ret;
> +
> +	if (!ad4052_iio_device_claim_direct(indio_dev, st))
> +		return -EBUSY;
> +
> +	switch (info) {
> +	case IIO_EV_INFO_VALUE:
> +		if (dir == IIO_EV_DIR_RISING)
> +			reg = AD4052_REG_MAX_LIMIT;
> +		else
> +			reg = AD4052_REG_MIN_LIMIT;
> +		size++;

As below.  Seems to me better to just set size to 2 here.

> +		break;
> +	case IIO_EV_INFO_HYSTERESIS:
> +		if (dir == IIO_EV_DIR_RISING)
> +			reg = AD4052_REG_MAX_HYST;
> +		else
> +			reg = AD4052_REG_MIN_HYST;
> +		break;
> +	default:
> +		iio_device_release_direct(indio_dev);
> +		return -EINVAL;
Maybe use an error block and goto.  You could factor
out the stuff under the direct claim as an alternative
path to simpler code.

> +	}
> +
> +	ret = regmap_bulk_read(st->regmap, reg, &st->d32, size);
> +	if (ret) {
> +		iio_device_release_direct(indio_dev);
> +		return ret;
> +	}
> +
> +	if (reg == AD4052_REG_MAX_LIMIT || reg == AD4052_REG_MIN_LIMIT) {
> +		*val = be16_to_cpu(st->d16);
> +		if (st->data_format & AD4052_DATA_FORMAT)
> +			*val = sign_extend32(*val, 11);
> +	} else {
> +		*val = st->d32;
> +	}
> +
> +	iio_device_release_direct(indio_dev);
> +	return IIO_VAL_INT;
> +}
> +
> +static int ad4052_write_event_value(struct iio_dev *indio_dev,
> +				    const struct iio_chan_spec *chan,
> +				    enum iio_event_type type,
> +				    enum iio_event_direction dir,
> +				    enum iio_event_info info, int val,
> +				    int val2)
> +{
> +	struct ad4052_state *st = iio_priv(indio_dev);
> +	int ret = -EINVAL;
> +	u8 reg, size = 1;
> +
> +	if (!ad4052_iio_device_claim_direct(indio_dev, st))
> +		return -EBUSY;
> +
> +	st->d16 = cpu_to_be16(val);
> +
> +	switch (type) {
> +	case IIO_EV_TYPE_THRESH:
> +		switch (info) {
> +		case IIO_EV_INFO_VALUE:
> +			if (st->data_format & AD4052_DATA_FORMAT) {
> +				if (val > 2047 || val < -2048)
> +					goto out_release;
> +			} else if (val > 4095 || val < 0) {
> +				goto out_release;
> +			}
> +			if (dir == IIO_EV_DIR_RISING)
> +				reg = AD4052_REG_MAX_LIMIT;
> +			else
> +				reg = AD4052_REG_MIN_LIMIT;
> +			size++;
Set size directly to 2 perhaps. I'm not really understanding why
the increment scheme makes more sense.

> +			break;
> +		case IIO_EV_INFO_HYSTERESIS:
> +			if (val & BIT(7))
> +				goto out_release;
> +			if (dir == IIO_EV_DIR_RISING)
> +				reg = AD4052_REG_MAX_HYST;
> +			else
> +				reg = AD4052_REG_MIN_HYST;
> +			st->d16 >>= 8;
> +			break;
> +		default:
> +			goto out_release;
> +		}
> +		break;
> +	default:
> +		goto out_release;
> +	}
> +
> +	ret = regmap_bulk_write(st->regmap, reg, &st->d16, size);
> +
> +out_release:
> +	iio_device_release_direct(indio_dev);
> +	return ret;
> +}
> +
> +static int ad4052_buffer_preenable(struct iio_dev *indio_dev)
> +{
> +	struct ad4052_state *st = iio_priv(indio_dev);
> +	struct spi_offload_trigger_config config = {
> +		.type = SPI_OFFLOAD_TRIGGER_PERIODIC,
> +		.periodic = {
> +			.frequency_hz = st->offload_trigger_hz,
> +		},
> +	};
> +	int ret;
> +
> +	if (st->wait_event)
> +		return -EBUSY;
> +
> +	ret = pm_runtime_resume_and_get(&st->spi->dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad4052_set_operation_mode(st, st->mode);
> +	if (ret)
> +		goto out_error;
> +
> +	ret = ad4052_update_xfer_offload(indio_dev, indio_dev->channels);
> +	if (ret)
> +		goto out_error;
> +
> +	disable_irq(st->gp1_irq);

Add a comment on why.

> +
> +	ret = spi_offload_trigger_enable(st->offload, st->offload_trigger,
> +					 &config);
> +	if (ret)
> +		goto out_offload_error;
> +
> +	return 0;
> +
> +out_offload_error:
> +	enable_irq(st->gp1_irq);
> +out_error:
> +	pm_runtime_mark_last_busy(&st->spi->dev);
> +	pm_runtime_put_autosuspend(&st->spi->dev);
> +
> +	return ret;
> +}


> +static int ad4052_get_current_scan_type(const struct iio_dev *indio_dev,
> +					const struct iio_chan_spec *chan)
> +{
> +	struct ad4052_state *st = iio_priv(indio_dev);
> +
> +	/*
> +	 * REVISIT: the supported offload has a fixed length of 32-bits
> +	 * to fit the 24-bits oversampled case, requiring the additional
> +	 * offload scan types.
> +	 */

That's an additional feature I think. We don't need to have a comment
about things we haven't done in the driver.

> +	if (iio_buffer_enabled(indio_dev))
> +		return st->mode == AD4052_BURST_AVERAGING_MODE ?
> +				   AD4052_SCAN_TYPE_OFFLOAD_BURST_AVG :
> +				   AD4052_SCAN_TYPE_OFFLOAD_SAMPLE;
> +
> +	return st->mode == AD4052_BURST_AVERAGING_MODE ?
> +			   AD4052_SCAN_TYPE_BURST_AVG :
> +			   AD4052_SCAN_TYPE_SAMPLE;
> +}

> +static int ad4052_probe(struct spi_device *spi)
> +{
> +	const struct ad4052_chip_info *chip;
> +	struct device *dev = &spi->dev;
> +	struct iio_dev *indio_dev;
> +	struct ad4052_state *st;
> +	int ret;
> +	u8 buf;
> +
> +	chip = spi_get_device_match_data(spi);
> +	if (!chip)
> +		return dev_err_probe(dev, -ENODEV,
> +				     "Could not find chip info data\n");
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +	st->spi = spi;
> +	spi_set_drvdata(spi, st);
> +	init_completion(&st->completion);
> +
> +	st->regmap = devm_regmap_init_spi(spi, &ad4052_regmap_config);
> +	if (IS_ERR(st->regmap))
> +		return dev_err_probe(&spi->dev,  PTR_ERR(st->regmap),

Use dev instead of spi->dev

> +				     "Failed to initialize regmap\n");
> +
> +	st->mode = AD4052_SAMPLE_MODE;
> +	st->wait_event = false;
> +	st->chip = chip;
> +
> +	st->cnv_gp = devm_gpiod_get_optional(dev, "cnv",
> +					     GPIOD_OUT_LOW);

wrap to 80 chars - so don't wrap the above.

> +	if (IS_ERR(st->cnv_gp))
> +		return dev_err_probe(dev, PTR_ERR(st->cnv_gp),
> +				    "Failed to get cnv gpio\n");
> +
> +	indio_dev->modes = INDIO_BUFFER_HARDWARE | INDIO_DIRECT_MODE;
> +	indio_dev->num_channels = 1;
> +	indio_dev->info = &ad4052_info;
> +	indio_dev->name = chip->name;
> +
> +	st->offload = devm_spi_offload_get(dev, spi, &ad4052_offload_config);
> +	ret = PTR_ERR_OR_ZERO(st->offload);

Use IS_ERR() to detect error and PTR_ERR() to get it if needed (will
end up calling PTR_ERR() twice but similar anyway.

> +	if (ret && ret != -ENODEV)
> +		return dev_err_probe(dev, ret, "Failed to get offload\n");
> +
> +	if (ret == -ENODEV) {
> +		st->offload_trigger = NULL;
> +		indio_dev->channels = chip->channels;
> +	} else {
> +		indio_dev->channels = chip->offload_channels;
> +		ret = ad4052_request_offload(indio_dev);
> +		if (ret)
> +			return dev_err_probe(dev, ret, "Failed to configure offload\n");
> +	}
> +
> +	st->xfer.rx_buf = &st->d32;
> +
> +	ret = ad4052_soft_reset(st);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "AD4052 failed to soft reset\n");

No need to wrap as fairly sure that's under 80 chars anyway.

> +
> +	ret = ad4052_assert(st);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "AD4052 fields assertions failed\n");
> +
> +	ret = ad4052_set_non_defaults(indio_dev, indio_dev->channels);
> +	if (ret)
> +		return ret;
> +
> +	buf = AD4052_DEVICE_RESET;

Pass directly into regmap_write()

> +	ret = regmap_write(st->regmap, AD4052_REG_DEVICE_STATUS, buf);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad4052_request_irq(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ad4052_update_xfer_raw(indio_dev, indio_dev->channels);
> +
> +	pm_runtime_set_autosuspend_delay(dev, 1000);
> +	pm_runtime_use_autosuspend(dev);

These autosuspend things are normally done after enabling runtime pm.
If nothing else that keeps the devm cleanup as being in opposite
order of what is set up here.  
https://elixir.bootlin.com/linux/v6.13.5/source/drivers/base/power/runtime.c#L1548

> +	pm_runtime_set_active(dev);
> +	ret = devm_pm_runtime_enable(dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to enable pm_runtime\n");
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +
> +static int ad4052_runtime_suspend(struct device *dev)
> +{
> +	u8 val = FIELD_PREP(AD4052_POWER_MODE_MSK, AD4052_LOW_POWER_MODE);

Put that inline and no need for local variable val.

> +	struct ad4052_state *st = dev_get_drvdata(dev);
> +
> +	return regmap_write(st->regmap, AD4052_REG_DEVICE_CONFIG, val);
> +}
> +
> +static int ad4052_runtime_resume(struct device *dev)
> +{
> +	struct ad4052_state *st = dev_get_drvdata(dev);
> +	u8 val = FIELD_PREP(AD4052_POWER_MODE_MSK, 0);
Put that inline - no real point in the local variable.
> +	int ret;
> +
> +	ret = regmap_write(st->regmap, AD4052_REG_DEVICE_CONFIG, val);
	ret = regmap_write(st->regmap, AD4052_REG_DEVICE_CONFIG,
			   FIELD_PREP(AD4052_POWER_MODE_MSK, 0));

> +	if (ret)
> +		return ret;
> +
> +	fsleep(2000);

Sleeps like this should ideally have a spec reference as a comment to
justify why that value is chosen.

> +	return 0;
> +}
> +
> +static const struct dev_pm_ops ad4052_pm_ops = {
> +	RUNTIME_PM_OPS(ad4052_runtime_suspend, ad4052_runtime_resume, NULL)
Can you allow this to be used for suspend and resume as well?  e.g.
DEFINE_RUNTIME_DEV_PM_OPS()

It is a rare case where that isn't safe to do even if there might be
deeper sleep states available that would be even better.

> +};
> +
> +static const struct spi_device_id ad4052_id_table[] = {
> +	{"ad4050", (kernel_ulong_t)&ad4050_chip_info },
> +	{"ad4052", (kernel_ulong_t)&ad4052_chip_info },
> +	{"ad4056", (kernel_ulong_t)&ad4056_chip_info },
> +	{"ad4058", (kernel_ulong_t)&ad4058_chip_info },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(spi, ad4052_id_table);
> +
> +static const struct of_device_id ad4052_of_match[] = {
> +	{ .compatible = "adi,ad4050", .data = &ad4050_chip_info },
> +	{ .compatible = "adi,ad4052", .data = &ad4052_chip_info },
> +	{ .compatible = "adi,ad4056", .data = &ad4056_chip_info },
> +	{ .compatible = "adi,ad4058", .data = &ad4058_chip_info },
> +	{}
Trivial but I'm slowly trying to standardize formatting of these tables
in IIO and I randomly decided to go with 
	{ }
Please use that for terminating entries in this new driver.

> +};
> +MODULE_DEVICE_TABLE(of, ad4052_of_match);

