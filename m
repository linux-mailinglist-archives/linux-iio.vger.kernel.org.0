Return-Path: <linux-iio+bounces-10493-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 230D599B489
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2024 13:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2117282631
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2024 11:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F1717838C;
	Sat, 12 Oct 2024 11:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nwciaWCx"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FE9154C09;
	Sat, 12 Oct 2024 11:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728732943; cv=none; b=ZgZgvoEVjhZJrcrZkCW9svE4H15nPB8xt43Lzili0aIE/TwKwYtI9zs/Z7hcb6mIrAXpXR0/NVr83O1DVo8U43I+5nA9suCw2jWJBtYV3TZW8HKBRdXxUU3Ab9mzu6+4FMH/NaQj9vmFgy+9hkevqvKgcq1dYXGRpEUicaCkQq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728732943; c=relaxed/simple;
	bh=Mmw8E9XEJYN7Y6YwQ28MPhIkLPtQ7v0uIPyho5WVcBw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LjVROvsKa3SpUA41X5UpCXrYWnrfjeoTYK1ue8OibtcXaDK95qsBia41f1GJl3TNkEL9C2khRB3laImugQj6PrSFHpjzOgigurjslbofl+fACl/Prg1biOGOSQu/jt9jCrfy0XlZxXe9DXdS5CDdTqOITI3bWvKS+VJx5ru4x6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nwciaWCx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A398C4CEC6;
	Sat, 12 Oct 2024 11:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728732942;
	bh=Mmw8E9XEJYN7Y6YwQ28MPhIkLPtQ7v0uIPyho5WVcBw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nwciaWCxQ5uRSutiR0I/mEs7M0h8WJRLFe9eUAh5gBWz/Fvz2PDLy9H/PY4SZLKLU
	 tAc4WRwn7w5M0EGawe29Hwj89KCRCOA/qhGdGPVNpDLWviaGqPHrnu2xKrBYgGtZu8
	 UnXS265ezZJQjxWiYivRurskm2M+Z6kss4v8GgBW2e3OAMJb/n2lM5NfV/SkYHvBQj
	 5zX2PMp96Xmk3X6WI+bfOxZV/69nnsuOIraL0THcH7QdjENPLO3cMm9oCopkVStvrt
	 Ey5v8W/NRgoUwu+hDIRH68L/NWtLz1aShCc0cEj3SjiSfTef5zo4WgZtPGdL5uf2mE
	 KOp/qve0bD0Bw==
Date: Sat, 12 Oct 2024 12:35:35 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Justin Weiss <justin@justinweiss.com>
Cc: Alex Lanzano <lanzano.alex@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Derek J . Clark" <derekjohn.clark@gmail.com>, Philip =?UTF-8?B?TcO8bGxl?=
 =?UTF-8?B?cg==?= <philm@manjaro.org>
Subject: Re: [PATCH 3/3] iio: imu: Add scale and sampling frequency to
 BMI270 IMU
Message-ID: <20241012123535.1abe63bd@jic23-huawei>
In-Reply-To: <20241011153751.65152-4-justin@justinweiss.com>
References: <20241011153751.65152-1-justin@justinweiss.com>
	<20241011153751.65152-4-justin@justinweiss.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Oct 2024 08:37:49 -0700
Justin Weiss <justin@justinweiss.com> wrote:

> Add read and write functions and create _available entries. Use
> IIO_CHAN_INFO_SAMP_FREQ instead of IIO_CHAN_INFO_FREQUENCY to match
> the BMI160 / BMI323 drivers.

Ah.  Please break dropping _FREQUENCY change out as a separate fix
with fixes tag etc and drag it to start of the patch. It was never
wired to anything anyway

That's a straight forward ABI bug so we want that to land ahead
of the rest of the series.

Does this device have a data ready interrupt and if so what affect
do the different ODRs for each type of sensor have on that?
If there are separate data ready signals, you probably want to 
go with a dual buffer setup from the start as it is hard to unwind
that later.

> 
> Signed-off-by: Justin Weiss <justin@justinweiss.com>
> ---
>  drivers/iio/imu/bmi270/bmi270_core.c | 293 ++++++++++++++++++++++++++-
>  1 file changed, 291 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/imu/bmi270/bmi270_core.c b/drivers/iio/imu/bmi270/bmi270_core.c
> index f49db5d1bffd..ce7873dc3211 100644
> --- a/drivers/iio/imu/bmi270/bmi270_core.c
> +++ b/drivers/iio/imu/bmi270/bmi270_core.c
> @@ -7,6 +7,7 @@
>  #include <linux/regmap.h>
>  
>  #include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
>  #include <linux/iio/triggered_buffer.h>
>  #include <linux/iio/trigger_consumer.h>
>  
> @@ -34,6 +35,9 @@
>  #define BMI270_ACC_CONF_BWP_NORMAL_MODE			0x02
>  #define BMI270_ACC_CONF_FILTER_PERF_MSK			BIT(7)
>  
> +#define BMI270_ACC_CONF_RANGE_REG			0x41
> +#define BMI270_ACC_CONF_RANGE_MSK			GENMASK(1, 0)
> +
>  #define BMI270_GYR_CONF_REG				0x42
>  #define BMI270_GYR_CONF_ODR_MSK				GENMASK(3, 0)
>  #define BMI270_GYR_CONF_ODR_200HZ			0x09
> @@ -42,6 +46,9 @@
>  #define BMI270_GYR_CONF_NOISE_PERF_MSK			BIT(6)
>  #define BMI270_GYR_CONF_FILTER_PERF_MSK			BIT(7)
>  
> +#define BMI270_GYR_CONF_RANGE_REG			0x43
> +#define BMI270_GYR_CONF_RANGE_MSK			GENMASK(2, 0)
> +
>  #define BMI270_INIT_CTRL_REG				0x59
>  #define BMI270_INIT_CTRL_LOAD_DONE_MSK			BIT(0)
>  
> @@ -85,6 +92,236 @@ const struct bmi270_chip_info bmi270_chip_info[] = {
>  };
>  EXPORT_SYMBOL_NS_GPL(bmi270_chip_info, IIO_BMI270);
>  
> +enum bmi270_sensor_type {
> +	BMI270_ACCEL	= 0,
> +	BMI270_GYRO,
> +};
> +
> +struct bmi270_scale {
> +	u8 bits;
> +	int uscale;
> +};
> +
> +struct bmi270_odr {
> +	u8 bits;
> +	int odr;
> +	int uodr;
> +};
> +
> +static const struct bmi270_scale bmi270_accel_scale[] = {
> +	{ 0x00, 598},
	{ 0x00, 598 },

So space before } for all these.

> +	{ 0x01, 1197},
> +	{ 0x02, 2394},
> +	{ 0x03, 4788},
> +};
> +
> +static const struct bmi270_scale bmi270_gyro_scale[] = {
> +	{ 0x00, 1065},
> +	{ 0x01, 532},
> +	{ 0x02, 266},
> +	{ 0x03, 133},
> +	{ 0x04, 66},
> +};
> +
> +struct bmi270_scale_item {
> +	const struct bmi270_scale *tbl;
> +	int num;
> +};
> +
> +static const struct bmi270_scale_item bmi270_scale_table[] = {
> +	[BMI270_ACCEL] = {
> +		.tbl	= bmi270_accel_scale,
> +		.num	= ARRAY_SIZE(bmi270_accel_scale),
> +	},
> +	[BMI270_GYRO] = {
> +		.tbl	= bmi270_gyro_scale,
> +		.num	= ARRAY_SIZE(bmi270_gyro_scale),
> +	},
> +};
> +
> +static const struct bmi270_odr bmi270_accel_odr[] = {
> +	{0x01, 0, 781250},
> +	{0x02, 1, 562500},
> +	{0x03, 3, 125000},
> +	{0x04, 6, 250000},
> +	{0x05, 12, 500000},
> +	{0x06, 25, 0},
> +	{0x07, 50, 0},
> +	{0x08, 100, 0},
> +	{0x09, 200, 0},
> +	{0x0A, 400, 0},
> +	{0x0B, 800, 0},
> +	{0x0C, 1600, 0},
> +};
> +
> +static const struct bmi270_odr bmi270_gyro_odr[] = {
> +	{0x06, 25, 0},
> +	{0x07, 50, 0},
> +	{0x08, 100, 0},
> +	{0x09, 200, 0},
> +	{0x0A, 400, 0},
> +	{0x0B, 800, 0},
> +	{0x0C, 1600, 0},
> +	{0x0D, 3200, 0},
> +};
> +
> +struct bmi270_odr_item {
> +	const struct bmi270_odr *tbl;
> +	int num;
> +};
> +
> +static const struct  bmi270_odr_item bmi270_odr_table[] = {
> +	[BMI270_ACCEL] = {
> +		.tbl	= bmi270_accel_odr,
> +		.num	= ARRAY_SIZE(bmi270_accel_odr),
> +	},
> +	[BMI270_GYRO] = {
> +		.tbl	= bmi270_gyro_odr,
> +		.num	= ARRAY_SIZE(bmi270_gyro_odr),
> +	},
> +};
> +
> +static int bmi270_set_scale(struct bmi270_data *data,
> +			    int chan_type, int uscale)
> +{
> +	int i;
> +	int reg;
> +	struct bmi270_scale_item bmi270_scale_item;
> +
> +	switch (chan_type) {
> +	case IIO_ACCEL:
> +		reg = BMI270_ACC_CONF_RANGE_REG;
> +		bmi270_scale_item = bmi270_scale_table[BMI270_ACCEL];
> +		break;
> +	case IIO_ANGL_VEL:
> +		reg = BMI270_GYR_CONF_RANGE_REG;
> +		bmi270_scale_item = bmi270_scale_table[BMI270_GYRO];
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	for (i = 0; i < bmi270_scale_item.num; i++)
> +		if (bmi270_scale_item.tbl[i].uscale == uscale)
> +			break;
> +
> +	if (i == bmi270_scale_item.num)
> +		return -EINVAL;
> +
> +	return regmap_write(data->regmap, reg,
> +			    bmi270_scale_item.tbl[i].bits);
Maybe do the write in the if above, (or use the continue approach mentioned
below + do the write in the for loop.
Then any exit from the loop that isn't a return is a failure and you an save the check.

> +}
> +
> +static int bmi270_get_scale(struct bmi270_data *bmi270_device,
> +			    int chan_type, int *uscale)
> +{
> +	int i, ret, val;
> +	int reg;
> +	struct bmi270_scale_item bmi270_scale_item;
> +
> +	switch (chan_type) {
> +	case IIO_ACCEL:
> +		reg = BMI270_ACC_CONF_RANGE_REG;
> +		bmi270_scale_item = bmi270_scale_table[BMI270_ACCEL];
> +		break;
> +	case IIO_ANGL_VEL:
> +		reg = BMI270_GYR_CONF_RANGE_REG;
> +		bmi270_scale_item = bmi270_scale_table[BMI270_GYRO];
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	ret = regmap_read(bmi270_device->regmap, reg, &val);
> +	if (ret)
> +		return ret;

No masking?

> +
> +	for (i = 0; i < bmi270_scale_item.num; i++)
> +		if (bmi270_scale_item.tbl[i].bits == val) {
Flip the condition to reduce indent

		if (bmi270_scale_item.tbl[i].bits != val)
			continue;

		*uscale.

> +			*uscale = bmi270_scale_item.tbl[i].uscale;
> +			return 0;
> +		}
> +
> +	return -EINVAL;
> +}
> +
> +static int bmi270_set_odr(struct bmi270_data *data, int chan_type,
> +			  int odr, int uodr)
> +{
> +	int i;
> +	int reg, mask;
> +	struct bmi270_odr_item bmi270_odr_item;
> +
> +	switch (chan_type) {
> +	case IIO_ACCEL:
> +		reg = BMI270_ACC_CONF_REG;
> +		mask = BMI270_ACC_CONF_ODR_MSK;
> +		bmi270_odr_item = bmi270_odr_table[BMI270_ACCEL];
> +		break;
> +	case IIO_ANGL_VEL:
> +		reg = BMI270_GYR_CONF_REG;
> +		mask = BMI270_GYR_CONF_ODR_MSK;
> +		bmi270_odr_item = bmi270_odr_table[BMI270_GYRO];
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	for (i = 0; i < bmi270_odr_item.num; i++)
> +		if (bmi270_odr_item.tbl[i].odr == odr &&
> +		    bmi270_odr_item.tbl[i].uodr == uodr)
> +			break;
> +
> +	if (i >= bmi270_odr_item.num)
> +		return -EINVAL;
> +
> +	return regmap_update_bits(data->regmap,
> +				  reg,
> +				  mask,
> +				  bmi270_odr_item.tbl[i].bits);

combine parameters on each line to get nearer to 80 char limit.

> +}
> +
> +static int bmi270_get_odr(struct bmi270_data *data, int chan_type,
> +			  int *odr, int *uodr)
> +{
> +	int i, val, ret;
> +	int reg, mask;
> +	struct bmi270_odr_item bmi270_odr_item;
> +
> +	switch (chan_type) {
> +	case IIO_ACCEL:
> +		reg = BMI270_ACC_CONF_REG;
> +		mask = BMI270_ACC_CONF_ODR_MSK;
> +		bmi270_odr_item = bmi270_odr_table[BMI270_ACCEL];
> +		break;
> +	case IIO_ANGL_VEL:
> +		reg = BMI270_GYR_CONF_REG;
> +		mask = BMI270_GYR_CONF_ODR_MSK;
> +		bmi270_odr_item = bmi270_odr_table[BMI270_GYRO];
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	ret = regmap_read(data->regmap, reg, &val);
> +	if (ret)
> +		return ret;
> +
> +	val &= mask;

I'd just duplicate the regmap_read to allow easy use FIELD_GET etc.


	switch (chan_type) {
	case IIO_ACCEL:
		ret = regmap_read(data->regmap, BMI270_ACC_CONF_REG, &val);
		if (ret)
			return ret;		
		val = FIELD_GET(val, BMI270_ACC_CONF_ODR_MSK);
		bmi270_odr_item = bmi270_odr_table[BMI270_ACCEL];
		break;
	case IIO_ANGL_VEL:
		ret = regmap_read(data->regmap, BMI270_GYR_CONF_REG, &val);
		if (ret)
			return ret;
		val = FIELD_GET(val, BMI270_GYR_CONF_ODR_MSK);
		bmi270_odr_item = bmi270_odr_table[BMI270_GYRO];
		break;
	default:
		return -EINVAL;
	}


> +
> +	for (i = 0; i < bmi270_odr_item.num; i++)
> +		if (val == bmi270_odr_item.tbl[i].bits)
> +			break;
> +
> +	if (i >= bmi270_odr_item.num)
> +		return -EINVAL;
> +
> +	*odr = bmi270_odr_item.tbl[i].odr;
> +	*uodr = bmi270_odr_item.tbl[i].uodr;
> +
> +	return 0;
> +}
> +
> +static
> +IIO_CONST_ATTR(in_accel_sampling_frequency_available,
> +	       "0.78125 1.5625 3.125 6.25 12.5 25 50 100 200 400 800 1600");
> +static
> +IIO_CONST_ATTR(in_anglvel_sampling_frequency_available,
> +	       "25 50 100 200 400 800 1600 3200");
> +static
> +IIO_CONST_ATTR(in_accel_scale_available,
> +	       "0.000598 0.001197 0.002394 0.004788");
> +static
> +IIO_CONST_ATTR(in_anglvel_scale_available,
> +	       "0.001065 0.000532 0.000266 0.000133 0.000066");
> +
> +static struct attribute *bmi270_attrs[] = {
> +	&iio_const_attr_in_accel_sampling_frequency_available.dev_attr.attr,
> +	&iio_const_attr_in_anglvel_sampling_frequency_available.dev_attr.attr,
> +	&iio_const_attr_in_accel_scale_available.dev_attr.attr,
> +	&iio_const_attr_in_anglvel_scale_available.dev_attr.attr,
Please use the read_avail callback and info_mask_xxx_avail masks to specify
these exist for all the channels.

Doing this as custom attrs predates that infrastructure and we are
slowly converting drivers over.  The main advantage beyond enforced
ABI is that can get to the values from in kernel consumers of the data.

> +	NULL,
No comma here.
> +};
> +
> +static const struct attribute_group bmi270_attrs_group = {
> +	.attrs = bmi270_attrs,
> +};

