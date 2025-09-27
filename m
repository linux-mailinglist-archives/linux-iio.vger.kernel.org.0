Return-Path: <linux-iio+bounces-24512-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB4FBA62B3
	for <lists+linux-iio@lfdr.de>; Sat, 27 Sep 2025 20:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC57D4A46E7
	for <lists+linux-iio@lfdr.de>; Sat, 27 Sep 2025 18:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39AED22F389;
	Sat, 27 Sep 2025 18:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1Qugc1n"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA251632C8;
	Sat, 27 Sep 2025 18:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758999549; cv=none; b=X9cq8BdxP1IpTT12dXJVp3iXGVwfLB9qYf2d5brQbl2CrmYN+dQyM9DbLLMEreWh1yMZASNQJvEoz4gD6GmkQ4faZThZdKYRoTnw/Jd8JGZPb30LX69ApmWE1QwZn434kYM05++QgedvajUX2c2xdkVqjGQ/0kBo/wByLm7posw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758999549; c=relaxed/simple;
	bh=1OSBLp+ttR8asbRvrYHxL+vC8NOwayV1Z9SDsTwxsds=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rjecOvSuKc+AJqFYZPoI/MELxkdPpKIjsSCTj+PXA89codq5KUvTjBLgOpriEaaE+esz92iVZocRag1Qzc2Mjk0sqeqShU9ZxX8gTwoAOzvuc0oYXfs4Zh0tp6WBY07FJF+KACNNW2FuiqE780fTn7/9ARyp2km00ylvFar/M+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n1Qugc1n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D3E6C4CEE7;
	Sat, 27 Sep 2025 18:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758999548;
	bh=1OSBLp+ttR8asbRvrYHxL+vC8NOwayV1Z9SDsTwxsds=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=n1Qugc1n/7qqhn6TamTuS738XeJlrTckf1cUScCmq7GIX27zuh5Euk8VTTbhSiRFd
	 n46Avvw0lBz/09SA/+gNV30ChokxznBIE+ASVU4nci40ODmvYphyY1fax9ptgAU6NU
	 Wcoq/GwG6QUUNYE9bXFzd3d0qM1O1bsfnhf0NpJ8V8/TQLNvGzGcMtYFGiC5mF5wDg
	 arZ+IbA+8zNJo5CM0RqcyKpFKnu+qTg3+1wFOZAPnpp9da8a1j1ndTDN5VimErMxhe
	 +vXQ5B2JWNbKuDx16YHkXFMXOH1K9YNTvndQG4SypuY9JaDeqp8W1WWNYk0WLEZOa+
	 FdEeReYeLdeSQ==
Date: Sat, 27 Sep 2025 19:58:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, Miquel Raynal
 <miquel.raynal@bootlin.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-iio@vger.kernel.org, Carlos Song
 <carlos.song@nxp.com>
Subject: Re: [PATCH v2 4/4] iio: magnetometer: Add mmc5633 sensor
Message-ID: <20250927195859.28a6069e@jic23-huawei>
In-Reply-To: <20250924-i3c_ddr-v2-4-682a0eb32572@nxp.com>
References: <20250924-i3c_ddr-v2-0-682a0eb32572@nxp.com>
	<20250924-i3c_ddr-v2-4-682a0eb32572@nxp.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Sep 2025 10:30:05 -0400
Frank Li <Frank.Li@nxp.com> wrote:

> Add mmc5633 sensor basic support.
> - Support read 20 bits X/Y/Z magnetic.
> - Support I3C HDR mode to send start measurememt command.
> - Support I3C HDR mode to read all sensors data by one command.
> 
> Co-developed-by: Carlos Song <carlos.song@nxp.com>
> Signed-off-by: Carlos Song <carlos.song@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> change in v2
> - new patch
> ---
HI Frank,

Some minor comments inline,

Thanks,

Jonathan

>  drivers/iio/magnetometer/Kconfig   |  12 +
>  drivers/iio/magnetometer/Makefile  |   1 +
>  drivers/iio/magnetometer/mmc5633.c | 543 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 556 insertions(+)
> 
> diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/Kconfig
> index 81b812a29044e2b0b9ff84889c21aa3ebc20be35..cfb74a4a083630678a1db1132a14264de451a31a 100644
> --- a/drivers/iio/magnetometer/Kconfig
> +++ b/drivers/iio/magnetometer/Kconfig

> diff --git a/drivers/iio/magnetometer/mmc5633.c b/drivers/iio/magnetometer/mmc5633.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..b1a6973ea175634bbc2247ff84488ea5393eba0e
> --- /dev/null
> +++ b/drivers/iio/magnetometer/mmc5633.c
> @@ -0,0 +1,543 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * MMC5633 - MEMSIC 3-axis Magnetic Sensor
> + *
> + * Copyright (c) 2015, Intel Corporation.
> + * Copyright (c) 2025, NXP
> + *
> + * IIO driver for MMC5633, base on mmc35240.c
> + *
Trivial but this blank line doesn't add anything, so drop it.

> + */

> +static const struct {
> +	int val;
> +	int val2;
> +} mmc5633_samp_freq[] = { {1, 200000},
> +			  {2, 0},
> +			  {3, 500000},
> +			  {6, 600000},
> +			};

Generally prefer { 1, 20000 } 
style for IIO and here I'd format this as:

static const struct {
	int val;
	int val2;
} mmc5633_samp_freq[] = {
	{ 1, 200000 },
	{ 2, 0 },
	{ 3, 500000 },
	{ 6, 600000 },
};

> +
> +static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("1.2 2.0 3.5 6.6");

> +
> +static struct attribute *mmc5633_attributes[] = {
> +	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
Please use the read_avail() callback and the associated masks.

That makes it available for in kernel users and generally is preferred
for new drivers.  One day I'll get rid of the defines you are using here
but it will take a while yet!

> +	NULL
> +};
> +
> +static const struct attribute_group mmc5633_attribute_group = {
> +	.attrs = mmc5633_attributes,
> +};

> +
> +static int mmc5633_hw_set(struct mmc5633_data *data, bool set)
> +{
> +	u8 coil_bit;
> +
> +	if (set)
> +		coil_bit = MMC5633_CTRL0_SET;
> +	else
> +		coil_bit = MMC5633_CTRL0_RESET;
> +
> +	return regmap_write(data->regmap, MMC5633_REG_CTRL0, coil_bit);

This helper doesn't provide all that much value. Maybe just
call the regmap_write() inline and let the value written make
it obvious which is set and reset?

> +}
> +
> +static int mmc5633_init(struct mmc5633_data *data)
> +{
> +	unsigned int reg_id, ret;
> +
> +	ret = regmap_read(data->regmap, MMC5633_REG_ID, &reg_id);
> +	if (ret < 0)
> +		return dev_err_probe(data->dev, ret,
> +				     "Error reading product id\n");
> +
> +	/*
> +	 * make sure we restore sensor characteristics, by doing

Make

> +	 * a SET/RESET sequence, the axis polarity being naturally
> +	 * aligned after RESET

RESET.

> +	 */
> +	ret = mmc5633_hw_set(data, true);
> +	if (ret < 0)
> +		return ret;
> +
> +	usleep_range(MMC5633_WAIT_SET_RESET, MMC5633_WAIT_SET_RESET + 1);
> +
> +	ret = mmc5633_hw_set(data, false);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* set default sampling frequency */
> +	ret = regmap_update_bits(data->regmap, MMC5633_REG_CTRL1,
> +				 MMC5633_CTRL1_BW_MASK,
> +				 FIELD_PREP(MMC5633_CTRL1_BW_MASK, 0));
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;

	return regmap_upate_bits()

Given regmap always returns negative for errors of 0 for success it
would be better to check if (ret) which then makes this sort of final
call look more obviously correct.


> +}
> +
> +static int mmc5633_take_measurement(struct mmc5633_data *data)
> +{
> +	unsigned int reg_status;
> +	int ret;
> +
> +	ret = regmap_write(data->regmap, MMC5633_REG_CTRL0, MMC5633_CTRL0_MEAS_M);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = regmap_read_poll_timeout(data->regmap, MMC5633_REG_STATUS1, reg_status,
> +				       reg_status & MMC5633_STATUS1_MEAS_M_DONE_BIT,
> +				       10000, 10000 * 100);
> +
Drop the blank line here to keep the error check associated with the call
> +	if (ret) {
> +		dev_err(data->dev, "data not ready\n");
> +		return -EIO;
Why not return ret
> +	}
> +
> +	return 0;
> +}
> +
> +static int mmc5633_read_measurement(struct mmc5633_data *data, void *buf, size_t sz)
> +{
> +	__le16 data_word;
> +	__le16 status;
Might as well combine on one line.

> +	int ret, val;
> +
> +	if (data->i3cdev &&
> +	    (i3c_device_get_supported_xfer_mode(data->i3cdev) & BIT(I3C_HDR_DDR))) {

I'd factor this lot out as a helper function to improve readability a little.

> +		struct i3c_xfer xfers_wr_cmd[] = {
> +			{
> +				.cmd = 0x3b,
> +				.len = 2,
> +				.data.out = &data_word,
> +			}
> +		};
> +
> +		struct i3c_xfer xfers_rd_sta_cmd[] = {
> +			{
> +				.cmd = 0x23 | BIT(7), /* RDSTA CMD */
> +				.len = 2,
> +				.data.in = &status,
> +			},
> +		};
> +
> +		struct i3c_xfer xfers_rd_data_cmd[] = {
> +			{
> +				.cmd = 0x22 | BIT(7), /* RDLONG CMD */
> +				.len = sz,
> +				.data.in = buf,
> +			},
> +		};
> +
> +		data_word = cpu_to_le16(MMC5633_HDR_CTRL0_MEAS_M << 8);

if you are shifting it by 8 bits and it's an 16 bit value, feels like it's actually not
and it's a pair of bytes. Perhaps just set the relevant byte in a u8 [2] would be clearer?
If this is how it's described on the datasheet I guess I don't mind that much.

> +
> +		ret = i3c_device_do_xfers(data->i3cdev, xfers_wr_cmd, 1, I3C_HDR_DDR);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = read_poll_timeout(i3c_device_do_xfers, val,
> +					val ||
> +					(le16_to_cpu(status) & MMC5633_STATUS1_MEAS_M_DONE_BIT),
> +					10000, 10000 * 100, 0,
> +					data->i3cdev, xfers_rd_sta_cmd, 1, I3C_HDR_DDR);
> +
> +		if (ret || val) {
> +			dev_err(data->dev, "data not ready\n");
> +			return -EIO;
Nice to return ret if it is set.  

> +		}
> +
> +		return i3c_device_do_xfers(data->i3cdev, xfers_rd_data_cmd, 1, I3C_HDR_DDR);
> +	}
> +
> +	/* Fallback to use SDR/I2C mode */
> +	ret = mmc5633_take_measurement(data);
> +	if (ret < 0)
> +		return ret;
> +
> +	return regmap_bulk_read(data->regmap, MMC5633_REG_XOUT_L, buf, sz);
> +}
> +
> +static int mmc5633_get_raw(struct mmc5633_data *data, int index, unsigned char *buf, int *val)
> +{
> +	/*
> +	 * X[19..12] X[11..4] Y[19..12] Y[11..4] Z[19..12] Z[11..4] X[3..0] Y[3..0] Z[3..0]
> +	 */
> +	*val = buf[2 * index];
> +	*val <<= 8;
> +
> +	*val |= buf[2 * index + 1];
> +	*val <<= 8;

First bit could be a get_unaligned_be16() << 8 or something like that.

> +
> +	*val |= buf[index + 6];
> +
> +	*val >>= 4;
> +
> +	return 0;
> +}
> +
> +#define MMC5633_ALL_SIZE (3 * 3 + 1) /* each channel have 3 byte and TEMP */
> +
> +static int mmc5633_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan, int *val,
> +			    int *val2, long mask)
> +{
> +	struct mmc5633_data *data = iio_priv(indio_dev);
> +	char buf[MMC5633_ALL_SIZE];
> +	unsigned int reg;
> +	int ret, i;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		scoped_guard(mutex, &data->mutex) {
> +			ret = mmc5633_read_measurement(data, buf, MMC5633_ALL_SIZE);
> +			if (ret < 0)
> +				return ret;
> +		}
> +
> +		ret = mmc5633_get_raw(data, chan->address, buf, val);
> +		if (ret < 0)
> +			return ret;
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = 0;
> +		*val2 = 62500;
> +		return IIO_VAL_INT_PLUS_NANO;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		scoped_guard(mutex, &data->mutex) {
> +			ret = regmap_read(data->regmap, MMC5633_REG_CTRL1, &reg);
> +			if (ret < 0)
> +				return ret;
> +		}
> +
> +		i = FIELD_GET(MMC5633_CTRL1_BW_MASK, reg);
> +		if (i < 0 || i >= ARRAY_SIZE(mmc5633_samp_freq))

How does a FIELD_GET() give a negative?

> +			return -EINVAL;
> +
> +		*val = mmc5633_samp_freq[i].val;
> +		*val2 = mmc5633_samp_freq[i].val2;
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	default:
> +		return -EINVAL;
> +	}
> +}

>
> +static const struct of_device_id mmc5633_of_match[] = {
> +	{ .compatible = "memsic,mmc5633", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, mmc5633_of_match);
> +
> +static const struct i2c_device_id mmc5633_i2c_id[] = {
> +	{ "mmc5633" },
> +	{}
be consistent. I'd prefer
	{ }

> +};
> +MODULE_DEVICE_TABLE(i2c, mmc5633_i2c_id);

