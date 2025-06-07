Return-Path: <linux-iio+bounces-20292-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D4BAD0E17
	for <lists+linux-iio@lfdr.de>; Sat,  7 Jun 2025 17:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E38D16CCC3
	for <lists+linux-iio@lfdr.de>; Sat,  7 Jun 2025 15:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D401D5145;
	Sat,  7 Jun 2025 15:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QTHaoh0V"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1361DFFD;
	Sat,  7 Jun 2025 15:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749310051; cv=none; b=RZv21b2I40wbGuf/6BiY+Dgo05Ij533C2vrvLog6DifBxdaTs9yxim1L+p8nPyBHEINcBeyscBmcXOqWjyRtS2RWc39VUuAUpaxoo0pd7TogWeGUzv1qj65RLqDo3whbw8XmXLHDJKkRQqAPtS/lDyw8iABwSNRfvBG1fWj7ezQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749310051; c=relaxed/simple;
	bh=PzwYYoi8L6LyODhWr57jsqAYPxQV+HMTDbT3gaW3r5k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pPXn7oEuEpxicSiRGoj7u0X9n4vQRHg/mJE/Ld8QP2S9z9H/+rRtDghP6D0Judz2ehxUwabFwr2bcRH+pzjDeZGiY5PPhGbY3cdPMYWN3UuH74Bn9jD9elP/6IFywNW2UGA9WWY87xM043TE7OPGoltisU5oepCQiSewJWkBwz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QTHaoh0V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB8B0C4CEE4;
	Sat,  7 Jun 2025 15:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749310051;
	bh=PzwYYoi8L6LyODhWr57jsqAYPxQV+HMTDbT3gaW3r5k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QTHaoh0VZl/3Ooj8nMBz2RFoBD30Rg4tKY8sLtaOP2A0OO995HfVwPfiBFghKnSLH
	 1FEbLNANNushlCsWjqArHemf1jptbhHSyRuIEi5nclBmH+Cd+Bs6YWft08Bbseqs3y
	 E+0kNtYqioG5Rkwz+d8fGVnZXAdH8loeXbp+KwrGjw7vDdpuzmygn01yGygcAXd9iK
	 nVS+BL9sCoSdelDPCu/e8TDje5ZeDv3p0wTGpFRRDlr34g7me758MVsqTB6mBzwpqQ
	 qy+Rdh7Uq5eye1f6VhpFKaL/YXgaH5vt9Bgm4wcHLjoCVsLQjlbJ8ZSU70dGGcadls
	 Fy1x031Io74pA==
Date: Sat, 7 Jun 2025 16:27:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: <marius.cristea@microchip.com>
Cc: <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <broonie@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] iio: adc: adding support for PAC194X
Message-ID: <20250607162721.0142ba42@jic23-huawei>
In-Reply-To: <20250606093929.100118-3-marius.cristea@microchip.com>
References: <20250606093929.100118-1-marius.cristea@microchip.com>
	<20250606093929.100118-3-marius.cristea@microchip.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 6 Jun 2025 12:39:29 +0300
<marius.cristea@microchip.com> wrote:

> From: Marius Cristea <marius.cristea@microchip.com>
> 
> This is the iio driver for Microchip PAC194X and PAC195X series of
> Power Monitors with Accumulator. The PAC194X family supports 9V
> Full-Scale Range and the PAC195X supports 32V Full-Scale Range.
> 
> There are two versions of the PAC194X/5X: the PAC194X/5X-1 devices
> are for high-side current sensing and the PAC194X/5X-2 devices are
> for low-side current sensing or floating VBUS applications. The
> PAC194X/5X-1 is named shortly PAC194X/5X.
> 
> Signed-off-by: Marius Cristea <marius.cristea@microchip.com>
Hi Marius,

I entirely agree with David on this wanting splitting up into
a base driver + patches that add features to that in order to
make it easier to review.  That also potentially allows me to pick up
the basic support whilst any more controversial parts are still under
discussion.

Jonathan

> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 09ae6edb2650..ee47d880babf 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -103,6 +103,7 @@ obj-$(CONFIG_NCT7201) += nct7201.o
>  obj-$(CONFIG_NPCM_ADC) += npcm_adc.o
>  obj-$(CONFIG_PAC1921) += pac1921.o
>  obj-$(CONFIG_PAC1934) += pac1934.o
> +obj-$(CONFIG_PAC1944) += pac1944.o
>  obj-$(CONFIG_PALMAS_GPADC) += palmas_gpadc.o
>  obj-$(CONFIG_QCOM_PM8XXX_XOADC) += qcom-pm8xxx-xoadc.o
>  obj-$(CONFIG_QCOM_SPMI_ADC5) += qcom-spmi-adc5.o
> diff --git a/drivers/iio/adc/pac1944.c b/drivers/iio/adc/pac1944.c
> new file mode 100644
> index 000000000000..ce09334b076a
> --- /dev/null
> +++ b/drivers/iio/adc/pac1944.c
> @@ -0,0 +1,2841 @@


> +/* Available Sample Modes */
> +static const char * const pac1944_frequency_avail[] = {
> +	"1024_ADAP",
> +	"256_ADAP",

This adaptive mode shouldn't be controlled via this standard
ABI.  That needs to be considered separately.

> +	"64_ADAP",
> +	"8_ADAP",
> +	"1024",
> +	"256",
> +	"64",
> +	"8",
This does not look even close to ABI complaint.

The numbers cases are fine. The others not really.
> +	"single_shot_1x",

That has nothing directly to do with the sampling frequency.
Some others look suspicious.  I'd stick to normal
sampling_frequency handling and have the discussion about the other
modes in here at a later date.

> +	"single_shot_8x",
> +	"fast",
> +	"burst",
> +};

>
> +
> +static const struct pac1944_features pac1944_chip_config[] = {
> +	/* PAC194X Family */
> +	[PAC1941] = {
> +		.phys_channels = 1,
> +		.prod_id = PAC_PRODUCT_ID_1941,
> +		.name = "pac1941",
> +	},
> +	[PAC1942] = {
> +		.phys_channels = 2,
> +		.prod_id = PAC_PRODUCT_ID_1942,
> +		.name = "pac1942",
> +	},
> +	[PAC1943] = {
> +		.phys_channels = 3,
> +		.prod_id = PAC_PRODUCT_ID_1943,
> +		.name = "pac1943",
> +	},
> +	[PAC1944] = {
> +		.phys_channels = 4,
> +		.prod_id = PAC_PRODUCT_ID_1944,
> +		.name = "pac1944",
> +	},
> +	[PAC1941_2] = {
> +		.phys_channels = 1,
> +		.prod_id = PAC_PRODUCT_ID_1941_2,
> +		.name = "pac1941_2",
> +	},
> +	[PAC1942_2] = {
> +		.phys_channels = 2,
> +		.prod_id = PAC_PRODUCT_ID_1942_2,
> +		.name = "pac1942_2",
> +	},
> +	/* PAC195X Family */

As mentioned below - just add the family in here as well
so no function is needed to look it up.

> +	[PAC1951] = {
> +		.phys_channels = 1,
> +		.prod_id = PAC_PRODUCT_ID_1951,
> +		.name = "pac1951",
> +	},
> +	[PAC1952] = {
> +		.phys_channels = 2,
> +		.prod_id = PAC_PRODUCT_ID_1952,
> +		.name = "pac1952_1",
> +	},
> +	[PAC1953] = {
> +		.phys_channels = 3,
> +		.prod_id = PAC_PRODUCT_ID_1953,
> +		.name = "pac1953",
> +	},
> +	[PAC1954] = {
> +		.phys_channels = 4,
> +		.prod_id = PAC_PRODUCT_ID_1954,
> +		.name = "pac1954",
> +	},
> +	[PAC1951_2] = {
> +		.phys_channels = 1,
> +		.prod_id = PAC_PRODUCT_ID_1951_2,
> +		.name = "pac1951_2",
> +	},
> +	[PAC1952_2] = {
> +		.phys_channels = 2,
> +		.prod_id = PAC_PRODUCT_ID_1952_2,
> +		.name = "pac1952_2",
> +	},
> +};
> +
> +static inline u64 pac1944_get_unaligned_be56(const u8 *p)
> +{
> +	return (u64)p[0] << 48 | (u64)p[1] << 40 | (u64)p[2] << 32 |
> +		(u64)p[3] << 24 | p[4] << 16 | p[5] << 8 | p[6];
> +}
> +
> +/* Low-level I2c functions used to transfer more then 32 bytes at once */
> +static int pac1944_i2c_read(struct i2c_client *client, u8 reg_addr,
> +			    void *databuf, u8 len)
> +{
> +	struct i2c_msg msgs[2] = {
> +		{ .addr = client->addr,
		{
			.addr = ...

etc

> +		 .len = 1,
> +		 .buf = (u8 *)&reg_addr,
> +		 .flags = 0
> +		},
> +		{ .addr = client->addr,
> +		 .len = len,
> +		 .buf = databuf,
> +		 .flags = I2C_M_RD
> +		}
> +	};
> +
> +	return i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
> +}
> +
> +static int pac1944_disable_alert_reg(struct device *dev, u32 mask, u8 *status)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct pac1944_chip_info *info = iio_priv(indio_dev);
> +	struct i2c_client *client = info->client;
> +	int ret;
> +	u32 val;
> +	u8 buf[PAC1944_ALERT_ENABLE_REG_LEN];
> +
> +	ret = i2c_smbus_read_i2c_block_data(client,
> +					    PAC1944_ALERT_ENABLE_REG_ADDR,
> +					    PAC1944_ALERT_ENABLE_REG_LEN,
> +					    status);
> +	if (ret < 0) {
> +		dev_err(dev, "failing to disable allert reg\n");
> +		return ret;
> +	}
> +
> +	val = get_unaligned_be24(status);
> +	val = val & (~mask);
> +	put_unaligned_be24(val, &buf[0]);
> +
> +	/* disable appropriate bit from the Alert enable register */
> +	return i2c_smbus_write_block_data(client, PAC1944_ALERT_ENABLE_REG_ADDR,
> +					  PAC1944_ALERT_ENABLE_REG_LEN,
> +					  (u8 *)&buf[0]);

I'd just use buf instead of that complex casting and array index (it's a u8 * anyway
so definitely no casting!

> +}

> +static int pac1944_update_alert_16b(struct device *dev, u8 addr, u32 mask,
> +				    u16 value)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct pac1944_chip_info *info = iio_priv(indio_dev);
> +	struct i2c_client *client = info->client;
> +	int ret;
> +	__be16 tmp_be16;
> +	u8 status[PAC1944_ALERT_ENABLE_REG_LEN];
> +
> +	ret = pac1944_disable_alert_reg(dev, mask, &status[0]);
> +	if (ret) {
> +		dev_err(dev, "failed to disable alert reg\n");
> +		return ret;
> +	}
> +
> +	tmp_be16 = cpu_to_be16(value);

As below - I think this wants to be using i2c_smbus_write_word_swapped()

> +
> +	ret = i2c_smbus_write_word_data(client, addr, tmp_be16);
> +	if (ret) {
> +		dev_err(dev, "failing to write at 0x%x\n", addr);
> +		return ret;
> +	}
> +
> +	return pac1944_restore_alert_reg(indio_dev, &status[0]);
> +}
> +
> +static int pac1944_update_alert_24b(struct device *dev, u8 addr, u32 mask,
> +				    u32 value)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct pac1944_chip_info *info = iio_priv(indio_dev);
> +	struct i2c_client *client = info->client;
> +	int ret;
> +	u8 status[PAC1944_ALERT_ENABLE_REG_LEN], tmp[3];
> +
> +	ret = pac1944_disable_alert_reg(dev, mask, &status[0]);

If you are going to parse an array just use status as the parameter, not
&status[0]

> +	if (ret) {
> +		dev_err(dev, "failed to disable alert reg\n");
> +		return ret;
> +	}
> +
> +	put_unaligned_be24(value, &tmp[0]);
, tmp) is fine here.
> +
> +	ret = i2c_smbus_write_block_data(client, addr, ARRAY_SIZE(tmp), (u8 *)&tmp[0]);
> +	if (ret) {
> +		dev_err(dev, "failing to write at 0x%x\n", addr);
> +		return ret;
> +	}
> +
> +	return pac1944_restore_alert_reg(indio_dev, &status[0]);

, status);
probably appropriate choice here as well.
> +}
> +
>
> +static int pac1944_retrieve_data(struct pac1944_chip_info *info, u32 wait_time)
> +{
> +	int ret = 0;
> +
> +	/*
> +	 * Check if the minimal elapsed time has passed and if so,
> +	 * re-read the chip, otherwise the cached info is just fine
> +	 */
> +	if (time_after(jiffies, info->chip_reg_data.jiffies_tstamp +
> +		       msecs_to_jiffies(PAC1944_MIN_POLLING_TIME_MS))) {
If you can exit early like here, it is worth flipping the logic.

	if (!time_after(jiff.....))
		return 0;

	ret = ...


> +		/*
> +		 * We need to re-read the chip values
> +		 * call the pac1944_reg_snapshot
> +		 */
> +		ret = pac1944_reg_snapshot(info, true, PAC1944_REFRESH_REG_ADDR,
> +					   wait_time);
> +		/*
> +		 * Re-schedule the work for the read registers timeout
> +		 * (to prevent chip regs saturation)
> +		 */
> +		cancel_delayed_work_sync(&info->work_chip_rfsh);
> +		schedule_delayed_work(&info->work_chip_rfsh,
> +				      msecs_to_jiffies(PAC1944_MAX_RFSH_LIMIT_MS));
> +	}
> +
> +	return ret;
> +}


> +static struct attribute *pac1944_power_acc_attr[] = {
> +	&iio_dev_attr_in_energy1_raw.dev_attr.attr,
> +	&iio_dev_attr_in_energy2_raw.dev_attr.attr,
> +	&iio_dev_attr_in_energy3_raw.dev_attr.attr,
> +	&iio_dev_attr_in_energy4_raw.dev_attr.attr,
> +	&iio_dev_attr_in_energy1_scale.dev_attr.attr,
> +	&iio_dev_attr_in_energy2_scale.dev_attr.attr,
> +	&iio_dev_attr_in_energy3_scale.dev_attr.attr,
> +	&iio_dev_attr_in_energy4_scale.dev_attr.attr,

These look like standard read_raw / info_mask based attributes will work.
So do that, not custom attributes that are both harder to review and
don't work with in kernel consumers (which we may well see for a power
monitoring chip).

> +	&iio_dev_attr_in_energy1_en.dev_attr.attr,
> +	&iio_dev_attr_in_energy2_en.dev_attr.attr,
> +	&iio_dev_attr_in_energy3_en.dev_attr.attr,
> +	&iio_dev_attr_in_energy4_en.dev_attr.attr,
> +	NULL
> +};
> +
> +static struct attribute *pac1944_current_acc_attr[] = {
> +	&iio_dev_attr_in_current_acc1_raw.dev_attr.attr,
> +	&iio_dev_attr_in_current_acc2_raw.dev_attr.attr,
> +	&iio_dev_attr_in_current_acc3_raw.dev_attr.attr,
> +	&iio_dev_attr_in_current_acc4_raw.dev_attr.attr,
> +	&iio_dev_attr_in_current_acc1_scale.dev_attr.attr,
> +	&iio_dev_attr_in_current_acc2_scale.dev_attr.attr,
> +	&iio_dev_attr_in_current_acc3_scale.dev_attr.attr,
> +	&iio_dev_attr_in_current_acc4_scale.dev_attr.attr,
> +	&iio_dev_attr_in_current_acc1_en.dev_attr.attr,
> +	&iio_dev_attr_in_current_acc2_en.dev_attr.attr,
> +	&iio_dev_attr_in_current_acc3_en.dev_attr.attr,
> +	&iio_dev_attr_in_current_acc4_en.dev_attr.attr,
> +	NULL
> +};
> +
> +static struct attribute *pac1944_voltage_acc_attr[] = {
> +	&iio_dev_attr_in_voltage_acc1_raw.dev_attr.attr,
> +	&iio_dev_attr_in_voltage_acc2_raw.dev_attr.attr,
> +	&iio_dev_attr_in_voltage_acc3_raw.dev_attr.attr,
> +	&iio_dev_attr_in_voltage_acc4_raw.dev_attr.attr,
> +	&iio_dev_attr_in_voltage_acc1_scale.dev_attr.attr,
> +	&iio_dev_attr_in_voltage_acc2_scale.dev_attr.attr,
> +	&iio_dev_attr_in_voltage_acc3_scale.dev_attr.attr,
> +	&iio_dev_attr_in_voltage_acc4_scale.dev_attr.attr,
> +	&iio_dev_attr_in_voltage_acc1_en.dev_attr.attr,
> +	&iio_dev_attr_in_voltage_acc2_en.dev_attr.attr,
> +	&iio_dev_attr_in_voltage_acc3_en.dev_attr.attr,

Where is this ABI documented?

> +	&iio_dev_attr_in_voltage_acc4_en.dev_attr.attr,
> +	NULL
> +};
> +
> +static int pac1944_prep_custom_attributes(struct pac1944_chip_info *info,
> +					  struct iio_dev *indio_dev)
> +{
> +	int ch, i, j;
> +	int active_channels_count = 0;
> +	struct attribute **pac1944_custom_attrs, **tmp_attr;
> +	struct attribute_group *pac1944_group;
> +	int custom_attr_cnt;
> +	struct i2c_client *client = info->client;
> +
> +	active_channels_count = info->num_enabled_channels;
> +
> +	pac1944_group = devm_kzalloc(&client->dev, sizeof(*pac1944_group), GFP_KERNEL);
> +	if (!pac1944_group)
> +		return -ENOMEM;
> +
> +	/*
> +	 * Attributes for channel X:
> +	 *	- in_shunt_value_X
> +	 *	- one of pair attributes:
> +	 *		- in_power_accX_raw and in_power_accX_scale
> +	 *		- in_current_accX_raw and in_current_accX_scale
> +	 *		- in_voltage_accX_raw and in_voltage_accX_scale
> +	 * Shared attributes:
> +	 *	- slow_alert1_cfg
> +	 *	- gpio_alert2_cfg
> +	 * NULL
> +	 */
> +	custom_attr_cnt = PAC1944_COMMON_DEVATTR * active_channels_count;
> +	custom_attr_cnt += PAC1944_ACC_DEVATTR * active_channels_count;
> +	custom_attr_cnt += PAC1944_SHARED_DEVATTRS_COUNT;
> +
> +	pac1944_custom_attrs = devm_kzalloc(&client->dev, custom_attr_cnt *
> +					    sizeof(*pac1944_group) + 1, GFP_KERNEL);
> +	if (!pac1944_custom_attrs)
> +		return -ENOMEM;
> +
> +	j = 0;
> +
> +	for_each_set_bit(ch, &info->active_channels_mask, info->phys_channels) {
> +		for (i = 0; i < PAC1944_COMMON_DEVATTR; i++)
> +			pac1944_custom_attrs[j++] =
> +				pac1944_all_attrs[PAC1944_COMMON_DEVATTR * ch + i];
> +
> +		switch (info->chip_reg_data.accumulation_mode[ch]) {
> +		case PAC1944_ACCMODE_VPOWER:
> +			tmp_attr = pac1944_power_acc_attr;
> +			break;
> +		case PAC1944_ACCMODE_VSENSE:
> +			tmp_attr = pac1944_current_acc_attr;
> +			break;
> +		case PAC1944_ACCMODE_VBUS:
> +			tmp_attr = pac1944_voltage_acc_attr;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +
> +		pac1944_custom_attrs[j++] = tmp_attr[ch];
> +		pac1944_custom_attrs[j++] = pac1944_power_acc_attr[PAC1944_MAX_CH + ch];
> +		pac1944_custom_attrs[j++] = pac1944_power_acc_attr[2 * PAC1944_MAX_CH + ch];
> +	}
> +
> +	for (i = 0; i < PAC1944_SHARED_DEVATTRS_COUNT; i++)
> +		pac1944_custom_attrs[j++] =
> +			pac1944_all_attrs[PAC1944_COMMON_DEVATTR * PAC1944_MAX_CH + i];
> +
> +	pac1944_group->attrs = pac1944_custom_attrs;
> +	info->iio_info.attrs = pac1944_group;
> +
> +	return 0;
> +}
> +
> +static int pac1944_frequency_set(struct iio_dev *indio_dev,
> +				 const struct iio_chan_spec *chan,
> +				 unsigned int mode)
> +{
> +	struct pac1944_chip_info *info = iio_priv(indio_dev);
> +	struct i2c_client *client = info->client;
> +	int ret;
> +	u16 tmp_u16;
> +	__be16 tmp_be16;
> +
> +	ret = i2c_smbus_read_i2c_block_data(client, PAC1944_CTRL_ACT_REG_ADDR,
> +					    sizeof(tmp_u16), (u8 *)&tmp_be16);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "cannot read PAC1944 regs from 0x%02X\n",
> +			PAC1944_CTRL_ACT_REG_ADDR);
> +		return ret;
> +	}
> +
> +	tmp_u16 = be16_to_cpu(tmp_be16);
> +	tmp_u16 &= ~PAC1944_CTRL_SAMPLE_MASK;
> +	tmp_u16 |= FIELD_PREP(PAC1944_CTRL_SAMPLE_MASK, mode);
> +	tmp_be16 = cpu_to_be16(tmp_u16);

Do that cpu_to_be16() inline below.

> +
> +	scoped_guard(mutex, &info->lock) {
> +		ret = i2c_smbus_write_word_data(client, PAC1944_CTRL_REG_ADDR, tmp_be16);
> +		if (ret < 0) {
> +			dev_err(&client->dev, "Failed to configure sampling mode\n");
> +			return ret;
> +		}
> +
> +		info->sampling_mode = mode;
> +		info->chip_reg_data.ctrl_act_reg = tmp_u16;
> +	}
> +
> +	return pac1944_retrieve_data(info, PAC1944_MIN_UPDATE_WAIT_TIME_US);
> +}
> +
> +static int pac1944_frequency_get(struct iio_dev *indio_dev,
> +				 const struct iio_chan_spec *chan)
> +{
> +	struct pac1944_chip_info *info = iio_priv(indio_dev);
> +
> +	return info->sampling_mode;
> +}
> +
> +static const struct iio_enum sampling_mode_enum = {
> +	.items = pac1944_frequency_avail,
> +	.num_items = ARRAY_SIZE(pac1944_frequency_avail),
> +	.set = pac1944_frequency_set,
> +	.get = pac1944_frequency_get,
> +};
Use the standard read_raw, and info_mask_shared, read_avail etc for this not
the path meant for custom ABI.

> +
> +static int pac1944_read_label(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan, char *label)
> +{
> +	struct pac1944_chip_info *info = iio_priv(indio_dev);
> +	int idx;
> +
> +	/* into the datasheet channels are noted from 1 to 4 */
> +	idx = chan->channel - 1;

Comment as suggested below would read better.

> +
> +	/*
> +	 * For AVG the index should be between 5 to 8.
> +	 * To calculate PAC1944_CH_VOLTAGE_AVERAGE and
> +	 * PAC1944_CH_CURRENT_AVERAGE real index, we need
> +	 * to remove the added offset (PAC1944_MAX_CH).
Wrap to 80 chars

> +	 */
> +	if (idx >= PAC1944_MAX_CH)
> +		idx = idx - PAC1944_MAX_CH;
Is this same as
	idx %= PA1944_MAX_CH;
or maybe keep the more obvious single subtraction version.

	if (idx >= PAC1944_MAX_CH)
		idx -= PAC1944_MAX_CH;

Various repeats of this occur elsewhere so apply an changes to all of them.

> +
> +	switch (chan->address) {
> +	case PAC1944_VBUS_1_ADDR:
> +	case PAC1944_VBUS_2_ADDR:
> +	case PAC1944_VBUS_3_ADDR:
> +	case PAC1944_VBUS_4_ADDR:
> +		if (info->labels[idx])
> +			return sysfs_emit(label, "%s_VBUS_%d\n", info->labels[idx], idx + 1);
> +		else

Technically else not needed as returned in other path.  I don't mind keeping it if
you strong prefer though.

> +			return sysfs_emit(label, "VBUS_%d\n", idx + 1);
> +	case PAC1944_VBUS_AVG_1_ADDR:
> +	case PAC1944_VBUS_AVG_2_ADDR:
> +	case PAC1944_VBUS_AVG_3_ADDR:
> +	case PAC1944_VBUS_AVG_4_ADDR:
> +		if (info->labels[idx])
> +			return sysfs_emit(label, "%s_VBUS_AVG_%d\n", info->labels[idx], idx + 1);
> +		else
> +			return sysfs_emit(label, "VBUS_AVG_%d\n", idx + 1);
> +	case PAC1944_VSENSE_1_ADDR:
> +	case PAC1944_VSENSE_2_ADDR:
> +	case PAC1944_VSENSE_3_ADDR:
> +	case PAC1944_VSENSE_4_ADDR:
> +		if (info->labels[idx])
> +			return sysfs_emit(label, "%s_IBUS_%d\n", info->labels[idx], idx + 1);
> +		else
> +			return sysfs_emit(label, "IBUS_%d\n", idx + 1);
> +	case PAC1944_VSENSE_AVG_1_ADDR:
> +	case PAC1944_VSENSE_AVG_2_ADDR:
> +	case PAC1944_VSENSE_AVG_3_ADDR:
> +	case PAC1944_VSENSE_AVG_4_ADDR:
> +		if (info->labels[idx])
> +			return sysfs_emit(label, "%s_IBUS_AVG_%d\n", info->labels[idx], idx + 1);
> +		else
> +			return sysfs_emit(label, "IBUS_AVG_%d\n", idx + 1);
> +	case PAC1944_VPOWER_1_ADDR:
> +	case PAC1944_VPOWER_2_ADDR:
> +	case PAC1944_VPOWER_3_ADDR:
> +	case PAC1944_VPOWER_4_ADDR:
> +		if (info->labels[idx])
> +			return sysfs_emit(label, "%s_POWER_%d\n", info->labels[idx], idx + 1);
> +		else
> +			return sysfs_emit(label, "POWER_%d\n", idx + 1);
> +	}
> +
> +	return 0;
> +}

> +static int pac1944_write_thresh(struct iio_dev *indio_dev,
> +				const struct iio_chan_spec *chan, enum iio_event_type type,
> +				enum iio_event_direction dir, enum iio_event_info info,
> +				int val, int val2)
> +{
> +	struct pac1944_chip_info *chip_info = iio_priv(indio_dev);
> +	int idx, ret;
> +
> +	/* into the datasheet channels are noted from 1 to 4 */
> +	idx = chan->channel - 1;
> +
> +	guard(mutex)(&chip_info->lock);
> +
> +	switch (chan->type) {
> +	case IIO_VOLTAGE:
> +		switch (dir) {
> +		case IIO_EV_DIR_RISING:
> +			ret = pac1944_update_alert_16b(&indio_dev->dev,
> +						       PAC1944_OV_LIMIT_REG_ADDR + idx,
> +						       pac1944_overvoltage_mask_tbl[idx], val);
> +			if (ret)
> +				return ret;
> +
> +			chip_info->overvoltage[idx] = val;
> +			return 0;
> +		case IIO_EV_DIR_FALLING:
> +			ret = pac1944_update_alert_16b(&indio_dev->dev,
> +						       PAC1944_UV_LIMIT_REG_ADDR + idx,
> +						       pac1944_undervoltage_mask_tbl[idx], val);
> +			if (ret)
> +				return ret;
> +
> +			chip_info->undervoltage[idx] = val;
> +			return 0;
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CURRENT:
> +		switch (dir) {
> +		case IIO_EV_DIR_RISING:
> +			ret = pac1944_update_alert_16b(&indio_dev->dev,
> +						       PAC1944_OC_LIMIT_REG_ADDR + idx,
> +						       pac1944_overcurrent_mask_tbl[idx], val);
> +			if (ret)
> +				return ret;
> +
> +			chip_info->overcurrent[idx] = val;
> +			return ret;
return 0;
> +		case IIO_EV_DIR_FALLING:
> +			ret = pac1944_update_alert_16b(&indio_dev->dev,
> +						       PAC1944_UC_LIMIT_REG_ADDR + idx,
> +						       pac1944_undercurrent_mask_tbl[idx], val);
> +			if (ret)
> +				return ret;
> +
> +			chip_info->undercurrent[idx] = val;
> +			return 0;
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_POWER:
> +		switch (dir) {
> +		case IIO_EV_DIR_RISING:
> +			ret = pac1944_update_alert_24b(&indio_dev->dev,
> +						       PAC1944_OP_LIMIT_REG_ADDR + idx,
> +						       pac1944_overpower_mask_tbl[idx],
> +						       val);
> +			if (ret)
> +				return ret;
> +
> +			chip_info->overpower[idx] = val;
> +			return 0;
> +		default:
> +			return -EINVAL;
> +		}
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int pac1944_read_event_config(struct iio_dev *indio_dev,
> +				     const struct iio_chan_spec *chan,
> +				     enum iio_event_type type,
> +				     enum iio_event_direction dir)
> +{
> +	struct pac1944_chip_info *info = iio_priv(indio_dev);
> +	int idx;
> +	u32 tmp;
> +
> +	/* into the datasheet channels are noted from 1 to 4 */
> +	idx = chan->channel - 1;
> +
> +	scoped_guard(mutex, &info->lock) {

guard() is fine and will reduce indent which will slightly help readability.
The tiny bit of maths at the end isn't significant enough to care if we
release the lock before it or not.

> +		switch (chan->type) {
> +		case IIO_VOLTAGE:
> +			switch (dir) {
> +			case IIO_EV_DIR_RISING:
> +				tmp = FIELD_GET(PAC1944_OV_MASK, info->alert_enable);
> +				break;
> +			case IIO_EV_DIR_FALLING:
> +				tmp = FIELD_GET(PAC1944_UV_MASK, info->alert_enable);
> +				break;
> +			default:
> +				return -EINVAL;
> +			}
> +			return -EINVAL;
> +		case IIO_CURRENT:
> +			switch (dir) {
> +			case IIO_EV_DIR_RISING:
> +				tmp = FIELD_GET(PAC1944_OC_MASK, info->alert_enable);
> +				break;
> +			case IIO_EV_DIR_FALLING:
> +				tmp = FIELD_GET(PAC1944_UC_MASK, info->alert_enable);
> +				break;
> +			default:
> +				return -EINVAL;
> +			}
> +			return -EINVAL;
> +		case IIO_POWER:
> +			if (dir == IIO_EV_DIR_RISING)
> +				tmp = FIELD_GET(PAC1944_OP_MASK, info->alert_enable);
> +			else
> +				return -EINVAL;
Flip logic to simplify.
			if (dir != IIO_EV_DIR_RISING)
				return -EINVal

			tmp = FIELD_GET(...

Of just use a switch to keep it looking like the other code.

> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +	}
> +
> +	tmp = tmp >> (3 - idx);
> +
> +	return tmp & 0x01;
> +}
> +
> +static int pac1944_write_event_config(struct iio_dev *indio_dev,
> +				      const struct iio_chan_spec *chan,
> +				      enum iio_event_type type,
> +				      enum iio_event_direction dir,
> +				      bool state)
> +{
> +	struct pac1944_chip_info *info = iio_priv(indio_dev);
> +	struct i2c_client *client = info->client;
> +	int idx, val, mask, ret;
> +	bool update = false;
> +	u8 tmp[PAC1944_ALERT_ENABLE_REG_LEN];
> +
> +	/* into the datasheet channels are noted from 1 to 4 */

In the datasheet channels are referred to as 1 to 4

> +	idx = chan->channel - 1;
> +
> +	switch (chan->type) {
> +	case IIO_VOLTAGE:
> +		switch (dir) {
> +		case IIO_EV_DIR_RISING:
> +			mask = pac1944_overvoltage_mask_tbl[idx];
> +			break;
> +		case IIO_EV_DIR_FALLING:
> +			mask = pac1944_undervoltage_mask_tbl[idx];
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		break;
> +	case IIO_CURRENT:
> +		switch (dir) {
> +		case IIO_EV_DIR_RISING:
> +			mask = pac1944_overcurrent_mask_tbl[idx];
> +			break;
> +		case IIO_EV_DIR_FALLING:
> +			mask = pac1944_undercurrent_mask_tbl[idx];
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		break;
> +	case IIO_POWER:
> +		if (dir != IIO_EV_DIR_RISING)
> +			return -EINVAL;
> +
> +		mask = pac1944_overpower_mask_tbl[idx];
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	guard(mutex)(&info->lock);
> +
> +	val = info->alert_enable & mask;
> +	if (state && !val) {
> +		/* enable the event in hardware */
> +		info->alert_enable |= mask;
> +		update = true;
> +	} else if (!state && val) {
> +		/* disable the event in hardware */
> +		info->alert_enable &= ~mask;
> +		update = true;
> +	}
> +
> +	/* do not update if not needed */
> +	if (update) {
> +		put_unaligned_be24(info->alert_enable, &tmp[0]);
> +
> +		/* update the Alert enable register */
> +		ret = pac1944_restore_alert_reg(indio_dev, &tmp[0]);
> +		if (ret) {
> +			dev_err(&client->dev, "failing to restore alert reg\n");
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}

> +
> +static int pac1944_of_parse_channel_config(struct i2c_client *client,
> +					   struct pac1944_chip_info *info)
> +{
> +	unsigned int current_channel;
> +	struct device *dev = &client->dev;
> +	int idx, ret, temp;
> +	bool is_bipolar, is_half_fsr;
> +
> +	current_channel = 1;
> +
> +	device_for_each_child_node_scoped(dev, child) {

Perhaps it is worth factoring out the parsing of a single channel as a helper
function.

> +		ret = fwnode_property_read_u32(child, "reg", &idx);
> +		if (ret)
> +			return dev_err_probe(dev, ret, "reading invalid channel index\n");
> +
> +		/* adjust idx to match channel index (1 to 4) from the datasheet */
> +		idx--;
> +
> +		if (current_channel >= (info->phys_channels + 1) ||
> +		    idx >= info->phys_channels || idx < 0)
> +			return dev_err_probe(dev, -EINVAL, "invalid channel index %d value\n",
> +					     idx + 1);
> +
> +		/* enable channel */
> +		set_bit(idx, &info->active_channels_mask);
> +
> +		ret = fwnode_property_read_u32(child, "shunt-resistor-micro-ohms",
> +					       &info->shunts[idx]);
> +		if (ret)
> +			return dev_err_probe(dev, ret, "%s: invalid shunt-resistor value: %d\n",
> +					     fwnode_get_name(child), info->shunts[idx]);
> +
> +		if (fwnode_property_present(child, "label"))
> +			fwnode_property_read_string(child, "label",
> +						    (const char **)&info->labels[idx]);

Given you don't check for errors for fwnode_property_read_string() is this not the same
after dropping the fwnode_property_present() check?

> +
> +		is_bipolar = false;
> +		if (fwnode_property_present(child, "microchip,vbus-bipolar"))
> +			is_bipolar = true;

		is_bipolar = fwnode_property_read_bool() probably appropriate here.
> +
> +		is_half_fsr = false;
> +		if (fwnode_property_present(child, "microchip,vbus-half-range"))
> +			is_half_fsr = true;

same here and the other cases below.

> +
> +		/* default value is unipolar and Full Scale Range */
> +		info->chip_reg_data.vbus_mode[idx] = PAC1944_UNIPOLAR_FSR_CFG;
> +		if (is_half_fsr)
> +			info->chip_reg_data.vbus_mode[idx] = PAC1944_BIPOLAR_HALF_FSR_CFG;
> +		else if (is_bipolar)
> +			info->chip_reg_data.vbus_mode[idx] = PAC1944_BIPOLAR_FSR_CFG;
> +
> +		is_bipolar = false;
> +		if (fwnode_property_present(child, "microchip,vsense-bipolar"))
> +			is_bipolar = true;
> +
> +		is_half_fsr = false;
> +		if (fwnode_property_present(child, "microchip,vsense-half-range"))
> +			is_half_fsr = true;
> +
> +		/* default value is unipolar and Full Scale Range */
> +		info->chip_reg_data.vsense_mode[idx] = PAC1944_UNIPOLAR_FSR_CFG;
> +		if (is_half_fsr)
> +			info->chip_reg_data.vsense_mode[idx] = PAC1944_BIPOLAR_HALF_FSR_CFG;
> +		else if (is_bipolar)
> +			info->chip_reg_data.vsense_mode[idx] = PAC1944_BIPOLAR_FSR_CFG;
> +
> +		ret = fwnode_property_read_u32(child, "microchip,accumulation-mode", &temp);

Given temp is only used for this, give it a meaninful name.   acc_mode or something like that.

> +		if (ret)
> +			return dev_err_probe(dev, ret, "invalid accumulation-mode value on %s\n",
> +					     fwnode_get_name(child));
> +		if (temp == PAC1944_ACCMODE_VPOWER ||
> +		    temp == PAC1944_ACCMODE_VSENSE ||
> +		    temp == PAC1944_ACCMODE_VBUS) {
> +			dev_dbg(dev, "Accumulation{%d} mode set to: %d\n", idx, temp);
> +			info->chip_reg_data.accumulation_mode[idx] = temp;
> +		} else {
> +			return dev_err_probe(dev, -EINVAL,
> +					     "invalid mode for accumulator value on %s\n",
> +					     fwnode_get_name(child));
> +		}
> +		current_channel++;
> +	}
> +
> +	return 0;
> +}
> +
> +static void pac1944_cancel_delayed_work(void *dwork)
> +{
> +	cancel_delayed_work_sync(dwork);
> +}
> +
> +static int pac1944_chip_identify(struct pac1944_chip_info *info)
> +{
> +	int ret = 0;

Always set below so don't initialize.

> +	struct i2c_client *client = info->client;
> +	u8 chip_rev_info[3];
> +
> +	ret = i2c_smbus_read_i2c_block_data(client, PAC1944_PID_REG_ADDR,
> +					    sizeof(chip_rev_info),
> +					    chip_rev_info);
> +	if (ret < 0)
> +		return dev_err_probe(&client->dev, ret, "cannot read revision\n");
> +
> +	dev_info(&client->dev, "Chip revision: 0x%02X\n", chip_rev_info[2]);
> +	info->chip_revision = chip_rev_info[2];

Why do we keep a copy?  Doesn't seem to be used again.

> +	info->chip_variant = chip_rev_info[0];
> +
> +	switch (chip_rev_info[0]) {
> +	case PAC_PRODUCT_ID_1941:
> +	case PAC_PRODUCT_ID_1942:
> +	case PAC_PRODUCT_ID_1943:
> +	case PAC_PRODUCT_ID_1944:
> +	case PAC_PRODUCT_ID_1941_2:
> +	case PAC_PRODUCT_ID_1942_2:
> +		info->is_pac195x_family = false;

This is a little odd.  We set one element of info in here, but return the
value of ret for the others. I'd be inclined to just set all the
stuff in info directly in this function.

I'm also not sure why that is_pac194x_family isn't just encoded in the
chip specific structures?  Why do we need to do it explicitly here.

> +		return chip_rev_info[0] - PAC_PRODUCT_ID_1941;
> +	case PAC_PRODUCT_ID_1951:
> +	case PAC_PRODUCT_ID_1952:
> +	case PAC_PRODUCT_ID_1953:
> +	case PAC_PRODUCT_ID_1954:
> +	case PAC_PRODUCT_ID_1951_2:
> +	case PAC_PRODUCT_ID_1952_2:
> +		info->is_pac195x_family = true;
> +		return (chip_rev_info[0] - PAC_PRODUCT_ID_1951) +
> +		       (PAC_PRODUCT_ID_1942_2 - PAC_PRODUCT_ID_1941) + 1;
> +	default:
> +		dev_err(&client->dev,
> +			"product ID (0x%02X, 0x%02X, 0x%02X) for this part doesn't match\n",
> +			chip_rev_info[0], chip_rev_info[1], chip_rev_info[2]);
> +		return -EINVAL;
> +	}
> +}
> +
> +static int pac1944_chip_configure(struct pac1944_chip_info *info)
> +{
> +	int cnt, ret;
> +	struct i2c_client *client = info->client;
> +	u8 regs[PAC1944_ALERTS_REG_LEN];
> +	u8 *offset_p;
> +	u32 wait_time;
> +	u8 tmp_u8;
> +	__be16 tmp_be16;
> +	u16 cfg;
> +
> +	/*
> +	 * Counting how many channels are enabled and store
Count how many...

> +	 * this information within the driver data

Wrap at 80 chars.  Also, when it's a sentence, nice to add a . at the end.


> +	 */
> +	info->num_enabled_channels = hweight_long(info->active_channels_mask);
> +
> +	/* get sampling rate from PAC */
> +	ret = i2c_smbus_read_i2c_block_data(client, PAC1944_CTRL_REG_ADDR,
> +					    sizeof(tmp_be16), (u8 *)&tmp_be16);
> +	if (ret < 0)
> +		return dev_err_probe(&client->dev, ret, "cannot read CTRL reg\n");
> +
> +	info->sampling_mode = FIELD_GET(PAC1944_CTRL_SAMPLE_MASK, be16_to_cpu(tmp_be16));
> +
> +	/*
> +	 * The current/voltage can be measured unidirectional, bidirectional or half FSR
> +	 * no SLOW triggered REFRESH, clear POR
> +	 */
> +	cfg = FIELD_PREP(PAC1944_NEG_PWR_CFG_VS1_MASK, info->chip_reg_data.vsense_mode[0]) |
> +		FIELD_PREP(PAC1944_NEG_PWR_CFG_VS2_MASK, info->chip_reg_data.vsense_mode[1]) |
> +		FIELD_PREP(PAC1944_NEG_PWR_CFG_VS3_MASK, info->chip_reg_data.vsense_mode[2]) |
> +		FIELD_PREP(PAC1944_NEG_PWR_CFG_VS4_MASK, info->chip_reg_data.vsense_mode[3]) |
> +		FIELD_PREP(PAC1944_NEG_PWR_CFG_VB1_MASK, info->chip_reg_data.vbus_mode[0]) |
> +		FIELD_PREP(PAC1944_NEG_PWR_CFG_VB2_MASK, info->chip_reg_data.vbus_mode[1]) |
> +		FIELD_PREP(PAC1944_NEG_PWR_CFG_VB3_MASK, info->chip_reg_data.vbus_mode[2]) |
> +		FIELD_PREP(PAC1944_NEG_PWR_CFG_VB4_MASK, info->chip_reg_data.vbus_mode[3]);
> +
> +	ret = i2c_smbus_write_word_data(client, PAC1944_NEG_PWR_FSR_REG_ADDR, cpu_to_be16(cfg));

Been a while, but from what I recall smbus has a defined byte ordering.  So independent of
CPU endianness if a u16 is written it should end up in the same order on the bus.
For that reason the swaps for word_data read/write, if needed, should be unconditional.

	ret = i2c_smbus_write_word_swapped()

I'm also a little curious that a device supports smbus_write_word, but not smbus_read_word
which would simplify the read above?  Looking at the family datasheet I'm not seeing
either word protocol as supported.

For the block access above, it's a different game as there is no ordering on bus going on
(as we don't know the word length) hence the swap is correctly be16_to_cpu().

> +	if (ret)
> +		return dev_err_probe(&client->dev, ret, "cannot write NEG_PWR_FSR reg\n");
> +
> +	ret = i2c_smbus_write_word_data(client, PAC1944_SLOW_REG_ADDR, 0);
> +	if (ret)
> +		return dev_err_probe(&client->dev, ret, "cannot write SLOW reg\n");
> +
> +	/* Write the CHANNEL_N_OFF from CTRL REGISTER */
> +	cfg = FIELD_PREP(PAC1944_CTRL_SAMPLE_MASK, info->sampling_mode) |
> +		FIELD_PREP(PAC1944_CTRL_GPIO_ALERT2_MASK, 0) |
> +		FIELD_PREP(PAC1944_CTRL_SLOW_ALERT1_MASK, 0) |
> +		FIELD_PREP(PAC1944_CTRL_CH_1_OFF_MASK, !test_bit(0, &info->active_channels_mask)) |
> +		FIELD_PREP(PAC1944_CTRL_CH_2_OFF_MASK, !test_bit(1, &info->active_channels_mask)) |
> +		FIELD_PREP(PAC1944_CTRL_CH_3_OFF_MASK, !test_bit(2, &info->active_channels_mask)) |
> +		FIELD_PREP(PAC1944_CTRL_CH_4_OFF_MASK, !test_bit(3, &info->active_channels_mask));
> +
> +	ret = i2c_smbus_write_word_data(client, PAC1944_CTRL_REG_ADDR, cpu_to_be16(cfg));
> +	if (ret)
> +		return dev_err_probe(&client->dev, ret, "cannot write CTRL reg\n");
> +
> +	tmp_u8 = ACCUM_REG(info->chip_reg_data.accumulation_mode[0],

Might as well give tmp_u8 a more meaningful name as it is only used for this.

> +			   info->chip_reg_data.accumulation_mode[1],
> +			   info->chip_reg_data.accumulation_mode[2],
> +			   info->chip_reg_data.accumulation_mode[3]);
> +
> +	ret = i2c_smbus_write_byte_data(client, PAC1944_ACCUM_CFG_REG_ADDR, tmp_u8);
> +	if (ret)
> +		return dev_err_probe(&client->dev, ret, "cannot write ACCUM_CFG reg\n");
> +
> +	/* reading all alerts, status and limits related registers */
> +	ret = pac1944_i2c_read(client, PAC1944_ALERT_STATUS_REG_ADDR, regs, sizeof(regs));
> +	if (ret < 0)
> +		return dev_err_probe(&client->dev, ret, "cannot read ALERT_STATUS reg\n");
> +
> +	offset_p = &regs[0];

...

> +static int pac1944_probe(struct i2c_client *client)
> +{
> +	struct pac1944_chip_info *info;
> +	struct iio_dev *indio_dev;
> +	const struct pac1944_features *chip;
> +	int cnt, ret;
> +	struct device *dev = &client->dev;

Where there is no other reason to pick an order for declarations, go with
reverse xmas tree. It's not important (to me anyway) but might as well
pick a style and keep to it.

> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*info));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	info = iio_priv(indio_dev);
> +	info->client = client;
> +
> +	ret = pac1944_chip_identify(info);
> +	if (ret < 0) {
> +		dev_dbg(dev, "Failed to identify the device based on HW ID\n");
> +		/*
> +		 * If failed to identify the hardware based on internal registers,
> +		 * try using fallback compatible in device tree to deal with
> +		 * some newer part number.
> +		 */
> +		chip = i2c_get_match_data(client);
> +		if (!chip)
> +			return -EINVAL;
> +
> +		info->chip_variant = chip->prod_id;

What is this for?  It's set but not I think used.

> +		info->phys_channels = chip->phys_channels;
> +		indio_dev->name = chip->name;
> +	} else {
> +		info->phys_channels = pac1944_chip_config[ret].phys_channels;
> +		indio_dev->name = pac1944_chip_config[ret].name;

This doesn't handle the the family bit of info or setting chip_variant. So looks
like it is missing at least some stuff overthe case where we don't match.

> +	}
> +
> +	for (cnt = 0; cnt < info->phys_channels; cnt++) {
> +		/* always start with accumulation channels enabled */
> +		info->enable_acc[cnt] = true;
> +	}
> +
> +	if (ACPI_HANDLE(dev))
> +		ret = pac1944_acpi_parse_channel_config(client, info);
> +	else
> +		ret = pac1944_of_parse_channel_config(client, info);
> +
> +	if (ret)
> +		return dev_err_probe(dev, ret, "parameter parsing returned an error\n");
> +
> +	ret = devm_mutex_init(dev, &info->lock);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = pac1944_chip_configure(info);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = pac1944_prep_iio_channels(info, indio_dev);
> +	if (ret < 0)
> +		return ret;
> +
> +	info->iio_info = pac1944_info;
> +	indio_dev->info = &info->iio_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	ret = pac1944_prep_custom_attributes(info, indio_dev);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Can't configure custom attributes for device\n");
> +
> +	ret = pac1944_reg_snapshot(info, true, false,
> +				   PAC1944_MIN_UPDATE_WAIT_TIME_US);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = devm_iio_device_register(dev, indio_dev);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Can't register IIO device\n");
> +
> +	return 0;
> +}
> +
> +static const struct i2c_device_id pac1944_id[] = {
> +	{ .name = "pac1941", .driver_data = (kernel_ulong_t)&pac1944_chip_config[PAC1941] },
> +	{ .name = "pac19412", .driver_data = (kernel_ulong_t)&pac1944_chip_config[PAC1941_2] },
> +	{ .name = "pac1942", .driver_data = (kernel_ulong_t)&pac1944_chip_config[PAC1942] },
> +	{ .name = "pac19422", .driver_data = (kernel_ulong_t)&pac1944_chip_config[PAC1942_2] },
> +	{ .name = "pac1943", .driver_data = (kernel_ulong_t)&pac1944_chip_config[PAC1943] },
> +	{ .name = "pac1944", .driver_data = (kernel_ulong_t)&pac1944_chip_config[PAC1944] },
> +	{ .name = "pac1951", .driver_data = (kernel_ulong_t)&pac1944_chip_config[PAC1951] },
> +	{ .name = "pac19512", .driver_data = (kernel_ulong_t)&pac1944_chip_config[PAC1951_2] },
> +	{ .name = "pac1952", .driver_data = (kernel_ulong_t)&pac1944_chip_config[PAC1952] },
> +	{ .name = "pac19522", .driver_data = (kernel_ulong_t)&pac1944_chip_config[PAC1952_2] },
> +	{ .name = "pac1953", .driver_data = (kernel_ulong_t)&pac1944_chip_config[PAC1953] },
> +	{ .name = "pac1954", .driver_data = (kernel_ulong_t)&pac1944_chip_config[PAC1954] },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, pac1944_id);
> +
> +static const struct of_device_id pac1944_of_match[] = {
> +	{
> +		.compatible = "microchip,pac1941",
> +		.data = (void *)&pac1944_chip_config[PAC1941]

Why do we need the cast to a void * ?
They should be const pointers anyway so assignment to a const void *
should be fine without cast.

> +	},
> +	{
> +		.compatible = "microchip,pac19412",
> +		.data = (void *)&pac1944_chip_config[PAC1941_2]
> +	},

> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, pac1944_of_match);
> +
> +static const struct acpi_device_id pac1944_acpi_match[] = {
> +	{ "MCHP1940", .driver_data = (kernel_ulong_t)&pac1944_chip_config[PAC1944] },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(acpi, pac1944_acpi_match);
> +
> +static struct i2c_driver pac1944_driver = {
> +	.driver = {
> +		.name = "pac1944",
> +		.of_match_table = pac1944_of_match,
> +		.acpi_match_table = pac1944_acpi_match
> +	},
> +	.probe = pac1944_probe,
> +	.id_table = pac1944_id,
> +};
> +module_i2c_driver(pac1944_driver);
> +
> +MODULE_AUTHOR("Marius Cristea <marius.cristea@microchip.com>");
> +MODULE_DESCRIPTION("Microchip PAC194X and PAC195X Power Monitor");
> +MODULE_LICENSE("GPL");


