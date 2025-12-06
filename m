Return-Path: <linux-iio+bounces-26836-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB77CAAB3B
	for <lists+linux-iio@lfdr.de>; Sat, 06 Dec 2025 18:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5CF0430A417E
	for <lists+linux-iio@lfdr.de>; Sat,  6 Dec 2025 17:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0E425C809;
	Sat,  6 Dec 2025 17:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hi4i11rr"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63C51DF73C;
	Sat,  6 Dec 2025 17:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765042511; cv=none; b=hb0a6zaa1HisjTQUr+fQ5sWqGDQcIefX+ki08Pf7S54M5DK4DeJ5VAdWIZl6TfyA1IsUPq4Ca2k3qSbwzgE0S8jm3hvvvMFOprt8/HMvPZHyO/xasG28IU6ob2u1VpXf1RI8FidM1ojmLNKJzTSvH9cXIVyz8cAft3Eg75u6JDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765042511; c=relaxed/simple;
	bh=MfNfHi+eD1nxLs9TPMaUYJq8ZjXXoAwrE8JjufcN7Qw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AHpYosJ9JBp8Jyk9fKx0BNpxbtknKmU6Ip12pUWdRCrB/YoZe+KyT1Dje+elfMmnNuGsLM/rYuzi6EuC43M3iyPcERsAujazR2UR6YRFNXDIbQbL/ldzUlwdRKQ7MryBDWHOLkChTyAJhzDplgdoF0EGdswQxkggj8kLV14uLlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hi4i11rr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A042C4CEF5;
	Sat,  6 Dec 2025 17:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765042511;
	bh=MfNfHi+eD1nxLs9TPMaUYJq8ZjXXoAwrE8JjufcN7Qw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Hi4i11rryOlbi2SBIzZBFpxk8STag4t0Mc0kXEWxf7mL1VYogpyUq8nksigxHfr7o
	 ddSu93lG1GN1B78AjJDTME+WE6olSCHeNWTyj6vq+9RjN1LKRdO4fDT/417bNAU9FZ
	 ovBeak8gmoCmFiXM7qXQsp7XB+8GxySa/5eqChEJ0e3dOMQC5YVs++FEiX2Uqr7Rsl
	 nTDOUgtlbDiKjFNL6GNPFk4HR7f9EM7FdJaEFUc2pOBcEDNJ/6KqgSbRvImfX0FsgX
	 8D2TtyeK+zadyqLUGPEO5ZK3X/u7Y3vIjNeK9kiA65LIlgpxO1nyauy/LHj7Jv5P8w
	 WCGXIhl4RNJyw==
Date: Sat, 6 Dec 2025 17:34:59 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jorge Marques <jorge.marques@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Linus
 Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH v3 3/9] iio: adc: Add support for ad4062
Message-ID: <20251206173459.727fb3f5@jic23-huawei>
In-Reply-To: <20251205-staging-ad4062-v3-3-8761355f9c66@analog.com>
References: <20251205-staging-ad4062-v3-0-8761355f9c66@analog.com>
	<20251205-staging-ad4062-v3-3-8761355f9c66@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 5 Dec 2025 16:12:04 +0100
Jorge Marques <jorge.marques@analog.com> wrote:

> The AD4060/AD4062 are versatile, 16-bit/12-bit, successive approximation
> register (SAR) analog-to-digital converter (ADC) with low-power and
> threshold monitoring modes.
>=20
> Signed-off-by: Jorge Marques <jorge.marques@analog.com>
Hi Jorge,

I replied late to some of the earlier review discussion as I've been
away.  Make sure you check those as well as this review as I may have
forgotten to repeat something here.

Thanks,

Jonathan

> diff --git a/drivers/iio/adc/ad4062.c b/drivers/iio/adc/ad4062.c
> new file mode 100644
> index 0000000000000..54f7f69e40879
> --- /dev/null
> +++ b/drivers/iio/adc/ad4062.c
> @@ -0,0 +1,879 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Analog Devices AD4062 I3C ADC driver
> + *
> + * Copyright 2025 Analog Devices Inc.
> + */
> +#include <linux/array_size.h>
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/completion.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/i3c/device.h>
> +#include <linux/i3c/master.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>

What is this here for?  It is not needed in a typical modern IIO driver.
(One day I hope to finish getting rid of the remaining users and drop this
header!)

> +#include <linux/interrupt.h>
> +#include <linux/jiffies.h>
> +#include <linux/math.h>
> +#include <linux/minmax.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/string.h>
> +#include <linux/types.h>
> +#include <linux/units.h>
> +#include <linux/unaligned.h>
> +#include <linux/util_macros.h>

> +static const struct iio_scan_type ad4062_scan_type_12_s[] =3D {
> +	[AD4062_SCAN_TYPE_SAMPLE] =3D {
> +		.sign =3D 's',
> +		.realbits =3D 16,

Not 12?

> +		.storagebits =3D 32,
Given we are doing data mangling anyway why not store in a 16 bit value.

BTW it would have been easier to spot issues with this if you'd introduced
the scan type stuff with the use of scans in the patch that adds buffered
support.  So please move this stuff there.

> +		.endianness =3D IIO_BE,
> +	},
> +	[AD4062_SCAN_TYPE_BURST_AVG] =3D {
> +		.sign =3D 's',
> +		.realbits =3D 16,
> +		.storagebits =3D 32,
> +		.endianness =3D IIO_BE,
> +	},
> +};

> +struct ad4062_state {
> +	const struct ad4062_chip_info *chip;
> +	const struct ad4062_bus_ops *ops;
> +	enum ad4062_operation_mode mode;
> +	struct completion completion;
> +	struct iio_trigger *trigger;
> +	struct iio_dev *indio_dev;
> +	struct i3c_device *i3cdev;
> +	struct regmap *regmap;
> +	int vref_uV;
> +	unsigned int samp_freqs[ARRAY_SIZE(ad4062_conversion_freqs)];
> +	union {
> +		__be32 be32;
> +		__be16 be16;
> +		u8 bytes[4];
> +	} buf __aligned(IIO_DMA_MINALIGN);
> +	u16 sampling_frequency;

See my response to the original thread about this.  This looks like
it breaks the dance we do to ensure DMA buffers don't share a cacheline
with anything else.

> +	u8 oversamp_ratio;
> +	u8 reg_addr_conv;
> +};

> +
> +static const struct ad4062_chip_info ad4060_chip_info =3D {
> +	.name =3D "ad4060",
> +	.channels =3D { AD4062_CHAN(12) },
> +	.prod_id =3D 0x7A,
> +	.max_avg =3D AD4060_MAX_AVG,

This is a little confusing. I guess it's the maximum register value, not the
number of samples averaged.  Perhaps rename.

> +};
> +
> +static const struct ad4062_chip_info ad4062_chip_info =3D {
> +	.name =3D "ad4062",
> +	.channels =3D { AD4062_CHAN(16) },
> +	.prod_id =3D 0x7C,
> +	.max_avg =3D AD4062_MAX_AVG,
> +};
> +
> +static int ad4062_set_oversampling_ratio(struct ad4062_state *st, unsign=
ed int val)
> +{
> +	const u32 _max =3D GENMASK(st->chip->max_avg, 0)  + 1;

One too many spaces before +


> +static int ad4062_check_ids(struct ad4062_state *st)
> +{
> +	struct device *dev =3D &st->i3cdev->dev;
> +	int ret;
> +	u16 val;
> +
> +	ret =3D regmap_bulk_read(st->regmap, AD4062_REG_PROD_ID_1,
> +			       &st->buf.be16, sizeof(st->buf.be16));
> +	if (ret)
> +		return ret;
> +
> +	val =3D get_unaligned_be16(st->buf.bytes);
As below. use buf.be16 and aligned=20

> +	if (val !=3D st->chip->prod_id)
> +		dev_warn(dev, "Production ID x%x does not match known values", val);
> +
> +	ret =3D regmap_bulk_read(st->regmap, AD4062_REG_VENDOR_H,
> +			       &st->buf.be16, sizeof(st->buf.be16));
> +	if (ret)
> +		return ret;
> +
> +	val =3D get_unaligned_be16(st->buf.bytes);

As elsewhere, use the aligned conversions functions and buf.be16

> +	if (val !=3D AD4062_I3C_VENDOR) {
> +		dev_err(dev, "Vendor ID x%x does not match expected value\n", val);
> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}

...

> +static int ad4062_setup(struct iio_dev *indio_dev, struct iio_chan_spec =
const *chan,
> +			const bool *ref_sel)
> +{
> +	struct ad4062_state *st =3D iio_priv(indio_dev);
> +	const struct iio_scan_type *scan_type;
> +	int ret;
> +	u8 val;
> +
> +	scan_type =3D iio_get_current_scan_type(indio_dev, chan);
> +	if (IS_ERR(scan_type))
> +		return PTR_ERR(scan_type);
> +
> +	val =3D FIELD_PREP(AD4062_REG_GP_CONF_MODE_MSK_1, AD4062_GP_DRDY);
Not clear to me why you need a local variable val here, but not in the next
call. Wrapped similarly to that you'd have
	ret =3D regmap_update_bits(st->regmap, AD4062_REG_GP_CONF,
				 AD4062_REG_GP_CONF_MODE_MSK_1,
				 FIELD_PREP(AD4062_REG_GP_CONF_MODE_MSK_1,
					    AD4062_GP_DRDY));
Looks fine to me.  What I really after here is consistent style.
I slightly prefer inline and no local variable but I'd be happy with either
approach for all of them.
=09
> +	ret =3D regmap_update_bits(st->regmap, AD4062_REG_GP_CONF,
> +				 AD4062_REG_GP_CONF_MODE_MSK_1, val);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_update_bits(st->regmap, AD4062_REG_ADC_CONFIG,
> +				 AD4062_REG_ADC_CONFIG_REF_EN_MSK,
> +				 FIELD_PREP(AD4062_REG_ADC_CONFIG_REF_EN_MSK,
> +					    *ref_sel));
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_write(st->regmap, AD4062_REG_DEVICE_STATUS,
> +			   AD4062_REG_DEVICE_STATUS_DEVICE_RESET);
> +	if (ret)
> +		return ret;
> +
> +	val =3D FIELD_PREP(AD4062_REG_INTR_CONF_EN_MSK_1, AD4062_INTR_EN_NEITHE=
R);
> +	ret =3D regmap_update_bits(st->regmap, AD4062_REG_INTR_CONF,
> +				 AD4062_REG_INTR_CONF_EN_MSK_1, val);

As above, I don't really see val as adding value.

> +	if (ret)
> +		return ret;
> +
> +	put_unaligned_be16(AD4062_MON_VAL_MIDDLE_POINT, st->buf.bytes);

	st->buf.be16 =3D cpu_to_be16(AD4062_MON_VAL_MIDDLE_POINT);

Don't need the unaligned dance as be16 will be aligned.

> +	return regmap_bulk_write(st->regmap, AD4062_REG_MON_VAL,
> +				 &st->buf.be16, sizeof(st->buf.be16));
> +}

...

> +static void ad4062_remove_ibi(void *data)
> +{
> +	struct i3c_device *i3cdev =3D data;
> +
> +	i3c_device_disable_ibi(i3cdev);
> +	i3c_device_free_ibi(i3cdev);
> +}
> +
> +static int ad4062_request_ibi(struct i3c_device *i3cdev)
> +{
> +	const struct i3c_ibi_setup ibireq =3D {
> +		.max_payload_len =3D 1,
> +		.num_slots =3D 1,
> +		.handler =3D ad4062_ibi_handler,
> +	};
> +	int ret;
> +
> +	ret =3D i3c_device_request_ibi(i3cdev, &ibireq);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D i3c_device_enable_ibi(i3cdev);
> +	if (ret)
> +		goto err_enable_ibi;
> +
> +	return devm_add_action_or_reset(&i3cdev->dev, ad4062_remove_ibi, i3cdev=
);
It would probably be cleaner to just register two separate callbacks.  Some=
thing like

	ret =3D i3c_device_request_ibi(i3cdev, &ibireq);
	if (ret)
		return ret;

	ret =3D devm_add_action_or_reset(&i3cdev->dev, ad4062_free_ibi, i3cdev);
	if (ret)
		return ret;

	ret =3D i3c_device_enable_ibi(i3cdev);
	if (ret)
		return ret;

	return devm_add_action_or_reset(&i3cdev->devm ad4062_unregister_ibi, i3cde=
v);

> +
> +err_enable_ibi:
> +	i3c_device_free_ibi(i3cdev);
> +	return ret;
> +}
> +
> +static int ad4062_request_irq(struct iio_dev *indio_dev)
> +{
> +	struct ad4062_state *st =3D iio_priv(indio_dev);
> +	struct device *dev =3D &st->i3cdev->dev;
> +	int ret;
> +
> +	ret =3D fwnode_irq_get_byname(dev_fwnode(&st->i3cdev->dev), "gp1");
> +	if (ret =3D=3D -EPROBE_DEFER) {
> +		return ret;

you returned, no need to follow with else.
	if (ret =3D=3D -EPROBE_DEFER)
		return ret;

	if (ret < 0)
		return regmap_update_bits()
(see discussion elsewhere about consistency around {} or not in these cases=
.)


> +	} else if (ret < 0) {
> +		return regmap_update_bits(st->regmap, AD4062_REG_ADC_IBI_EN,
> +					  AD4062_REG_ADC_IBI_EN_CONV_TRIGGER,
> +					  AD4062_REG_ADC_IBI_EN_CONV_TRIGGER);
> +	}
> +	return devm_request_threaded_irq(dev, ret,
> +					 ad4062_irq_handler_drdy,
> +					 NULL, IRQF_ONESHOT, indio_dev->name,
> +					 indio_dev);
> +}


> +static int ad4062_get_chan_calibscale(struct ad4062_state *st, int *val,=
 int *val2)
> +{
> +	int ret;
> +
> +	ret =3D regmap_bulk_read(st->regmap, AD4062_REG_MON_VAL,
> +			       &st->buf.be16, sizeof(st->buf.be16));
> +	if (ret)
> +		return ret;
> +
> +	/* From datasheet: code out =3D code in =C3=97 mon_val/0x8000 */
> +	*val =3D get_unaligned_be16(st->buf.bytes) * 2;

As above, use st->buf.be16 which we know is aligned so be16_to_cpu()


> +	*val2 =3D 16;
> +
> +	return IIO_VAL_FRACTIONAL_LOG2;
> +}
> +
> +static int ad4062_set_chan_calibscale(struct ad4062_state *st, int gain_=
int,
> +				      int gain_frac)
> +{
> +	/* Divide numerator and denumerator by known great common divider */
> +	const u32 mon_val =3D AD4062_MON_VAL_MIDDLE_POINT / 64;
> +	const u32 micro =3D MICRO / 64;
> +	const u32 gain_fp =3D gain_int * MICRO + gain_frac;
> +	const u32 reg_val =3D DIV_ROUND_CLOSEST(gain_fp * mon_val, micro);
> +	int ret;
> +
> +	/* Checks if the gain is in range and the value fits the field */
> +	if (gain_int < 0 || gain_int > 1 || reg_val > BIT(16) - 1)
> +		return -EINVAL;
> +
> +	put_unaligned_be16(reg_val, st->buf.bytes);

Same as above on using be16

> +	ret =3D regmap_bulk_write(st->regmap, AD4062_REG_MON_VAL,
> +				&st->buf.be16, sizeof(st->buf.be16));
> +	if (ret)
> +		return ret;
> +
> +	/* Enable scale if gain is not equal to one */
> +	return regmap_update_bits(st->regmap, AD4062_REG_ADC_CONFIG,
> +				  AD4062_REG_ADC_CONFIG_SCALE_EN_MSK,
> +				  FIELD_PREP(AD4062_REG_ADC_CONFIG_SCALE_EN_MSK,
> +					     !(gain_int =3D=3D 1 && gain_frac =3D=3D 0)));
> +}
> +
> +static int ad4062_read_chan_raw(struct ad4062_state *st, int *val)
> +{
> +	int ret;
> +	struct i3c_device *i3cdev =3D st->i3cdev;
> +	struct i3c_priv_xfer t0 =3D {

Can we give these names for what they are doing rather than t0 and t1?

> +		.data.out =3D &st->reg_addr_conv,
> +		.len =3D sizeof(st->reg_addr_conv),
> +		.rnw =3D false,
> +	};
> +	struct i3c_priv_xfer t1 =3D {
> +		.data.in =3D &st->buf.be32,
> +		.len =3D sizeof(st->buf.be32),
> +		.rnw =3D true,
> +	};
> +
> +	ACQUIRE(pm_runtime_active_try_enabled, pm)(&st->i3cdev->dev);

Rafael did propose a cleaner way of doing this. I'm not sure if it went
in during the merge window or not.  Take a look to see if it anything
has been added in the PM pull request (IIRC Rafael converted all existing
users to the new scheme in that patch set so should be easy to find.)

> +	ret =3D ACQUIRE_ERR(pm_runtime_active_try_enabled, &pm);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D ad4062_set_operation_mode(st, st->mode);
> +	if (ret)
> +		return ret;
> +
> +	reinit_completion(&st->completion);
> +	/* Change address pointer to trigger conversion */
> +	ret =3D i3c_device_do_priv_xfers(i3cdev, &t0, 1);
> +	if (ret)
> +		return ret;
> +	/*
> +	 * Single sample read should be used only for oversampling and
> +	 * sampling frequency pairs that take less than 1 sec.
> +	 */
> +	ret =3D wait_for_completion_timeout(&st->completion,
> +					  msecs_to_jiffies(1000));
> +	if (!ret)
> +		return -ETIMEDOUT;
> +
> +	ret =3D i3c_device_do_priv_xfers(i3cdev, &t1, 1);
> +	if (ret)
> +		return ret;
> +	*val =3D get_unaligned_be32(st->buf.bytes);

As with the be16 cases, we know the __be32 variable is aligned so can
use the be32_to_cpu() to do the conversion.

> +	return 0;
> +}
> +


> +static int ad4062_write_raw_dispatch(struct ad4062_state *st, int val, i=
nt val2,
> +				     long info)
> +{
> +	switch (info) {
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		return ad4062_set_oversampling_ratio(st, val);

Small thing but probably want to check if val2  =3D=3D 0 in cases where it's
not used.

> +
> +	case IIO_CHAN_INFO_CALIBSCALE:
> +		return ad4062_set_chan_calibscale(st, val, val2);
> +
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		return ad4062_set_sampling_frequency(st, val);
> +
> +	default:
> +		return -EINVAL;
> +	}
> +};


> +static int ad4062_regulators_get(struct ad4062_state *st, bool *ref_sel)
> +{
> +	struct device *dev =3D &st->i3cdev->dev;
> +	int ret;
> +
> +	ret =3D devm_regulator_get_enable(dev, "vio");
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to enable vio voltage\n");

Fairly sure that's 80 chars on one line so no need to wrap.

> +
> +	st->vref_uV =3D devm_regulator_get_enable_read_voltage(dev, "ref");
> +	*ref_sel =3D st->vref_uV =3D=3D -ENODEV;
> +	if (st->vref_uV < 0 && !*ref_sel) {

For consistency, no {} here or add them elsewhere for multiline statements
due to line breaks rather than multiple real lines.


> +		return dev_err_probe(dev, st->vref_uV,
> +				     "Failed to enable and read ref voltage\n");
> +	}
> +
> +	if (*ref_sel) {
> +		st->vref_uV =3D devm_regulator_get_enable_read_voltage(dev, "vdd");
> +		if (st->vref_uV < 0)
> +			return dev_err_probe(dev, st->vref_uV,
> +					     "Failed to enable and read vdd voltage\n");
> +	} else {
> +		ret =3D devm_regulator_get_enable(dev, "vdd");
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Failed to enable vdd regulator\n");
> +	}
> +
> +	return 0;
> +}

>


