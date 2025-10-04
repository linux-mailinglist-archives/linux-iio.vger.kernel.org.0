Return-Path: <linux-iio+bounces-24719-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 175E0BB8F2E
	for <lists+linux-iio@lfdr.de>; Sat, 04 Oct 2025 16:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C75134E677C
	for <lists+linux-iio@lfdr.de>; Sat,  4 Oct 2025 14:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D60223C516;
	Sat,  4 Oct 2025 14:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WPi+BIyx"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B9423C50A;
	Sat,  4 Oct 2025 14:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759589719; cv=none; b=CBjXOp3E8iytY6P2Kt4eUluDWjT1AKAKAXC4CWmDh+IaPBimYfCcxSDPT53VCEo69DL3PMbpyyNXb9qbbaALNqu8O/sOnrdhfDvoQ/DzV+kV5UMSoNrasJw25dSuOvqHiyZs6XbGx5ZxpHQ7FOvvHCDae5wJ3ReRp+JAPJdoU0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759589719; c=relaxed/simple;
	bh=fqd/1/Wyatmf5aspgaffyoDM0tdTiAxhBNfRUMozzVI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ue7CKR20MSglJluCachl6AoXiUM+zXNLZDjoaBz3NE1+kEqc5YrUY0oNlz+IQVJnyd00qs4UjusWPWEm5J23UQcpZ62z/J/1B5ZZX4FMz/M/lZcXcxBV4YphVQQSaP9vHY+t8ZeacsgedJ4x6xLdOr85LqLlflm69VCJ45u02Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WPi+BIyx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7CA1C4CEF1;
	Sat,  4 Oct 2025 14:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759589719;
	bh=fqd/1/Wyatmf5aspgaffyoDM0tdTiAxhBNfRUMozzVI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WPi+BIyxMiohCopaFMsaNJdENYyeJv/Yoo/sG/2RZSKG+E9K1cGFKGEW+PD0I7mZH
	 trx3koPhQhKjhxJnSGrlxHGLTv0rpOC1YnVZG/4LNk/CnZxenW2qPM/tTAIgQPOuz4
	 lr6juvg6AEVNdHmHI0bAiXgcoL/HQyztZKYl/zQC+oNja1yV+KkVX4sSMsZLSodjBW
	 SAYkTemdfmRnVEgtAT9N9BUryBYFmV+UV+GSwNaRyImnIisXClYSlfmn/FuHU+IIoj
	 GAO+EWCFqHTSXnfcafTlcOoVIrX1hdxJPznf6Jyd+QZeKYzqkO+9E8cCQMCklWjmTO
	 ptNRxrnxQZc0g==
Date: Sat, 4 Oct 2025 15:55:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lakshay Piplani <lakshay.piplani@nxp.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 marcelo.schmitt1@gmail.com, gregkh@linuxfoundation.org,
 viro@zeniv.linux.org.uk, peterz@infradead.org, jstephan@baylibre.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, jonathan.cameron@huawei.com,
 vikash.bansal@nxp.com, priyanka.jain@nxp.com, shashank.rebbapragada@nxp.com
Subject: Re: [PATCH v3 2/2] iio: temperature: Add driver for NXP P3T175x
 temperature sensor
Message-ID: <20251004155507.44798db5@jic23-huawei>
In-Reply-To: <20250929094543.2512264-2-lakshay.piplani@nxp.com>
References: <20250929094543.2512264-1-lakshay.piplani@nxp.com>
	<20250929094543.2512264-2-lakshay.piplani@nxp.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Sep 2025 15:15:43 +0530
Lakshay Piplani <lakshay.piplani@nxp.com> wrote:

> Add support for the NXP P3T175x (P3T1750/P3T1755) family of temperature
> sensor devices. These devices communicates via both I2C or I3C interfaces.
> 
> Signed-off-by: Lakshay Piplani <lakshay.piplani@nxp.com>
Hi Lakshay,

Please add a cover letter. I would have replied to that if there was one.

After some recent feedback on hwmon vs IIO sensors and the fact we do
indeed seem to be slowly drifting wrt to the boundary for what I let into IIO
I'm asking people to +CC the hwmon maintainers and provide an explanation of why
they think a particular device should be supported with an IIO driver rather than
a hwmon one. 

So +CC Guenter and Jean,

Sorry I didn't raise this earlier. I've clearly not been paying quite enough attention
to this.  Had my head down in code reviews rather than looking at the bigger picture.

I'm not immediately spotting characteristics that would clearly justify this being
in IIO.

Review comments inline.

Thanks,

Jonathan


> ---
> V2 -> V3: Changes since V2:
>           - Dropped nxp,interrupt-mode and nxp,fault-queue from driver and YAML (not suitable for DT)
>           - Removed trigger_one_shot sysfs attribute and its ABI doc
>           - Applied IWYU principle: cleaned up unused headers
>           - Fixed sampling frequency handling
>           - Removed dev_err/dev_dbg statements wherever not necessary
> V1 -> V2: Changes since V1:
>           - Added endian-safe handling for register read (__be16 conversion)
>           - Replaced manual bit masking with FIELD_GET bit extraction
>           - Dropped sysfs attributes for fault queue length and thermostat mode (comparator or interrupt)
>           - Added ABI doc: Documentation/ABI/testing/sysfs-bus-iio-temperature-p3t1755 describing
>             trigger_one_shot attribute
>           - Updated Kconfig to allow building both I2C and I3C drivers simultaneously
>           - I3C: switched to device_property_* from of_property_*
>           - Added devm_add_action_or_reset() for IBI disable/free
> 
>  drivers/iio/temperature/Kconfig            |   2 +
>  drivers/iio/temperature/p3t/Kconfig        |  28 ++
>  drivers/iio/temperature/p3t/Makefile       |   5 +
>  drivers/iio/temperature/p3t/p3t1755.h      |  45 +++
>  drivers/iio/temperature/p3t/p3t1755_core.c | 362 +++++++++++++++++++++
>  drivers/iio/temperature/p3t/p3t1755_i2c.c  |  68 ++++
>  drivers/iio/temperature/p3t/p3t1755_i3c.c  | 108 ++++++
>  7 files changed, 618 insertions(+)
>  create mode 100644 drivers/iio/temperature/p3t/Kconfig
>  create mode 100644 drivers/iio/temperature/p3t/Makefile
>  create mode 100644 drivers/iio/temperature/p3t/p3t1755.h
>  create mode 100644 drivers/iio/temperature/p3t/p3t1755_core.c
>  create mode 100644 drivers/iio/temperature/p3t/p3t1755_i2c.c
>  create mode 100644 drivers/iio/temperature/p3t/p3t1755_i3c.c
> 

> diff --git a/drivers/iio/temperature/p3t/p3t1755.h b/drivers/iio/temperature/p3t/p3t1755.h
> new file mode 100644
> index 000000000000..1dc0e37322c6
> --- /dev/null
> +++ b/drivers/iio/temperature/p3t/p3t1755.h

> diff --git a/drivers/iio/temperature/p3t/p3t1755_core.c b/drivers/iio/temperature/p3t/p3t1755_core.c
> new file mode 100644
> index 000000000000..61486eb0e265
> --- /dev/null
> +++ b/drivers/iio/temperature/p3t/p3t1755_core.c


> +
> +static int p3t1755_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *channel, int *val,
> +			    int *val2, long mask)
> +{
> +	struct p3t1755_data *data = iio_priv(indio_dev);
> +	unsigned int cfgr;
> +	__be16 be;
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = regmap_bulk_read(data->regmap, P3T1755_REG_TEMP, &be, sizeof(be));
> +		if (ret)
> +			return ret;
> +
> +		*val = sign_extend32(be16_to_cpu(be) >> 4, 11);
> +
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = 625;
> +		*val2 = 10000;
> +
> +		return IIO_VAL_FRACTIONAL;
> +
> +	case IIO_CHAN_INFO_ENABLE:
> +		ret = regmap_read(data->regmap, P3T1755_REG_CFGR, &cfgr);
> +		if (ret)
> +			return ret;
> +
> +		*val = !FIELD_GET(P3T1755_SHUTDOWN_BIT, cfgr);
> +
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_SAMP_FREQ: {
> +		unsigned int freq_uhz;
> +		u8 sel;
> +
> +		ret = regmap_read(data->regmap, P3T1755_REG_CFGR, &cfgr);
> +		if (ret)
> +			return ret;
> +
> +		sel = FIELD_GET(P3T1755_CONVERSION_TIME_BITS, cfgr);
> +		if (sel >= ARRAY_SIZE(p3t1755_samp_freqs_uhz))
> +			return -EINVAL;
> +
> +		freq_uhz = p3t1755_samp_freqs_uhz[sel];
> +
> +		*val = freq_uhz / 1000000;
> +		*val2 = freq_uhz % 1000000;

MICRO (see below).

> +
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	}
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int p3t1755_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan, int val,
> +			     int val2, long mask)
> +{
> +	struct p3t1755_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_ENABLE:
> +		ret = regmap_update_bits(data->regmap, P3T1755_REG_CFGR,
> +					 P3T1755_SHUTDOWN_BIT,
> +					 val == 0 ? P3T1755_SHUTDOWN_BIT : 0);
> +		if (ret)
> +			return ret;
> +
> +		return 0;
> +	case IIO_CHAN_INFO_SAMP_FREQ: {
> +		unsigned int i;
> +		u32 regbits;
> +		u64 input_uhz;
> +
> +		input_uhz = (u64)val * 1000000 + val2;

MICRO perhaps as that's on the border of how many zeros are easy to count.

> +
> +		for (i = 0; i < ARRAY_SIZE(p3t1755_samp_freqs_uhz); i++) {
> +			if (p3t1755_samp_freqs_uhz[i] == input_uhz)
> +				break;
> +		}
> +
> +		if (i == ARRAY_SIZE(p3t1755_samp_freqs_uhz))
> +			return -EINVAL;
> +
> +		regbits = FIELD_PREP(P3T1755_CONVERSION_TIME_BITS, i);
> +
> +		return regmap_update_bits(data->regmap, P3T1755_REG_CFGR,
> +					  P3T1755_CONVERSION_TIME_BITS,
> +					  regbits);
> +	}
> +	default:
> +		return -EINVAL;
> +	}
> +}

> +
> +static int p3t1755_write_event_value(struct iio_dev *indio_dev,
> +				     const struct iio_chan_spec *chan,
> +				     enum iio_event_type type,
> +				     enum iio_event_direction dir,
> +				     enum iio_event_info info,
> +				     int val, int val2)
> +{
> +	struct p3t1755_data *data = iio_priv(indio_dev);
> +	unsigned int reg;
> +	__be16 be;
> +	int raw;
> +
> +	if (type != IIO_EV_TYPE_THRESH || info != IIO_EV_INFO_VALUE)
> +		return -EINVAL;
> +
> +	if (val2)
> +		return -EINVAL;
> +
> +	reg = (dir == IIO_EV_DIR_RISING) ? P3T1755_REG_HIGH_LIM :
> +	       P3T1755_REG_LOW_LIM;
> +
> +	raw = DIV_ROUND_CLOSEST(val * 2, 125);
> +
> +	if (raw < -2048 || raw > 2047)
> +		return -ERANGE;
> +
> +	be = cpu_to_be16((u16)(raw << 4));
> +
> +	return regmap_raw_write(data->regmap, reg, &be, sizeof(be));

Why is raw write appropriate here rather than bulk_write ?
Perhaps a comment would be a good idea for anyone wondering in future.

> +}

> +
> +MODULE_AUTHOR("Lakshay Piplani <lakshay.piplani@nxp.com>");
> +MODULE_DESCRIPTION("NXP P3T175x Driver");

As below wrt to wild cards.

> +MODULE_LICENSE("GPL");
> diff --git a/drivers/iio/temperature/p3t/p3t1755_i2c.c b/drivers/iio/temperature/p3t/p3t1755_i2c.c
> new file mode 100644
> index 000000000000..f5d7799f091c
> --- /dev/null
> +++ b/drivers/iio/temperature/p3t/p3t1755_i2c.c

> +static int p3t1755_i2c_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	const struct p3t1755_info *chip;
> +	struct regmap *regmap;
> +	int ret;
> +
> +	regmap = devm_regmap_init_i2c(client, &p3t1755_i2c_regmap_config);
> +	if (IS_ERR(regmap))
> +		return dev_err_probe(dev, PTR_ERR(regmap),
> +				     "regmap init failed\n");
> +
> +	chip = i2c_get_match_data(client);
> +
> +	ret = p3t1755_probe(dev, chip, regmap, client->irq);
> +
Drop this blank line. We want the error handling closely coupled with the call.

> +	if (ret)
> +		return dev_err_probe(dev, ret, "p3t175x probe failed: %d\n", ret);
> +
> +	return 0;
> +}
> +
> +static struct i2c_driver p3t1755_driver = {
> +	.driver = {
> +		.name = "p3t175x_i2c",

Pick a part number rather than using a wild card. Wildcards often down withstand
the desire of marketing departments to fill in the holes.

> +		.of_match_table = p3t1755_i2c_of_match,
> +	},
> +	.probe = p3t1755_i2c_probe,
> +	.id_table = p3t1755_i2c_id_table,
> +};
> +module_i2c_driver(p3t1755_driver);
> +
> +MODULE_AUTHOR("Lakshay Piplani <lakshay.piplani@nxp.com>");
> +MODULE_DESCRIPTION("NXP P3T175x I2C Driver");

I'd use a part number rather than wild card here as well.

> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS(IIO_P3T1755);
> diff --git a/drivers/iio/temperature/p3t/p3t1755_i3c.c b/drivers/iio/temperature/p3t/p3t1755_i3c.c
> new file mode 100644
> index 000000000000..df031280e08d
> --- /dev/null
> +++ b/drivers/iio/temperature/p3t/p3t1755_i3c.c
> @@ -0,0 +1,108 @@

...

> +
> +static void p3t1755_disable_ibi(void *data)
> +{
> +	i3c_device_disable_ibi((struct i3c_device *)data);

As below - unnecessary cast.

> +}
> +
> +static void p3t1755_free_ibi(void *data)
> +{
> +	i3c_device_free_ibi((struct i3c_device *)data);

That cast isn't needed.  Casting from void * to any other pointer is implicitly allowed
by the c spec.  So just pass data directly.

> +}
> +
> +static int p3t1755_i3c_probe(struct i3c_device *i3cdev)
> +{
> +	const struct i3c_device_id *id = i3c_device_match_id(i3cdev, p3t1755_i3c_ids);
> +	const struct p3t1755_info *chip;
> +	struct device *dev = &i3cdev->dev;
> +	struct i3c_ibi_setup ibi_setup;
> +	struct regmap *regmap;
> +	int ret;
> +
> +	chip = id ? id->data : NULL;
> +
> +	regmap = devm_regmap_init_i3c(i3cdev, &p3t1755_i3c_regmap_config);
> +	if (IS_ERR(regmap))
> +		return dev_err_probe(&i3cdev->dev, PTR_ERR(regmap),
> +				     "Failed to register I3C regmap %ld\n", PTR_ERR(regmap));
> +
> +	ret = p3t1755_probe(dev, chip, regmap, 0);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "p3t175x probe failed: %d\n", ret);
> +
> +	ibi_setup = (struct i3c_ibi_setup) {
> +		.handler = p3t1755_ibi_handler,
> +		.num_slots = 4,
> +		.max_payload_len = 0,
> +	};
> +
> +	ret = i3c_device_request_ibi(i3cdev, &ibi_setup);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to request IBI\n");
> +
> +	ret = devm_add_action_or_reset(dev, p3t1755_free_ibi, i3cdev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to register IBI free action\n");

As below.

> +
> +	ret = i3c_device_enable_ibi(i3cdev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to enable IBI\n");
> +
> +	ret = devm_add_action_or_reset(dev, p3t1755_disable_ibi, i3cdev);
> +	if (ret)

Don't bother with error prints for devm_add_action_or_reset().
The only failure path returns -ENOMEM which doesn't result in a print in
dev_err_probe() because the expectation is that it is an unlikely condition
which results in plenty of prints anyway.
So simple
		return ret;
appropriate for these calls.


> +		return dev_err_probe(dev, ret, "Failed to register IBI disable action\n");
> +
> +	return 0;
> +}

