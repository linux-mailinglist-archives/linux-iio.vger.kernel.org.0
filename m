Return-Path: <linux-iio+bounces-7716-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC996937CDA
	for <lists+linux-iio@lfdr.de>; Fri, 19 Jul 2024 21:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 326F6B216F5
	for <lists+linux-iio@lfdr.de>; Fri, 19 Jul 2024 19:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B98D14830F;
	Fri, 19 Jul 2024 19:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="UvSPgJGj"
X-Original-To: linux-iio@vger.kernel.org
Received: from msa.smtpout.orange.fr (smtp-79.smtpout.orange.fr [80.12.242.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D58C1482F0;
	Fri, 19 Jul 2024 19:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721415952; cv=none; b=MuMoR2dtmIudh5aj7m4WqUf6no0+b3Rt4mHnzZGsPmrO9ZvDe0dWPyxVFhScsfN9z4Kl7jbWOB09/w8BTNcFyIDi/9ERtYDFJtr0esUWavQk2uKjBlBeUWtXcfR8TMzAPakicDGV5ZzNDDkOTggAu5dVCkYUZBzDFM1qkng0CTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721415952; c=relaxed/simple;
	bh=p8HikwIIeukiOO2T7xEfP9pyjX35CUE030xEUIVNVdc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QrqYCKiMbtZA6VuNvmZNzcFAeyQ9CFGZQc5WaFytXXHWrJGKy5hc7AUzefnU9Sc+BXUlmgT0ma4Qd52hB7M25KTE1RofEOV1j7GtFSVolYfeCXf/lmhhAQyGIPFx8P8NnmFAWnlJ/jc42HWJilFWuxOAyF/QYWlCKRBx+R9nk5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=UvSPgJGj; arc=none smtp.client-ip=80.12.242.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id Usu0sMnHb6NRTUsu0sbMuM; Fri, 19 Jul 2024 21:04:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1721415869;
	bh=bmqhLid6vk3HCiDiwtRF2597OrEf17EQmbVOpAkwA5w=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=UvSPgJGjL2LoMwoC6xk4IPuYzZ91rxoOYZdbyRdO5VeXyW1VQhqZfas77e8eFZV3x
	 NsG8Sf23aXVYvkvrOiEy/VO5S7CkHRj9GWHoqsGdxmasZmWKiOpq6q8zWTdsywzlTr
	 m/zhULgphWgE4R2ta0v5Cn29C4nVAgrZTLawqkuxWnjTpfmQCyeyDhmEtZ+iXUuoHB
	 TTIryiw8U+L9P6dkPIQIT4O8xmwStJQuY95Tlbs4ymqMeRVUZIusC046RtQCrV6jeO
	 WzBsVgquuhfPvA0giu5IZvKCcn9qrGSpzI3ZDBV54jhsXavUAxMwI01KukBKR7sglf
	 RMf193+Eqmo2g==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Fri, 19 Jul 2024 21:04:29 +0200
X-ME-IP: 90.11.132.44
Message-ID: <7312b1f8-6314-49df-9ccf-092f4ae84027@wanadoo.fr>
Date: Fri, 19 Jul 2024 21:04:23 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] iio: adc: adding support for PAC194X
To: marius.cristea@microchip.com
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, jic23@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, lars@metafoo.de,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org
References: <20240719173855.53261-1-marius.cristea@microchip.com>
 <20240719173855.53261-3-marius.cristea@microchip.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240719173855.53261-3-marius.cristea@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 19/07/2024 à 19:38, 
marius.cristea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org a écrit :
> From: Marius Cristea <marius.cristea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
> 
> This is the iio driver for Microchip PAC194X and PAC195X
> series of Power Monitors with Accumulator.
> 
> Signed-off-by: Marius Cristea <marius.cristea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
> ---
>   .../ABI/testing/sysfs-bus-iio-adc-pac1944     |    9 +
>   MAINTAINERS                                   |    7 +
>   drivers/iio/adc/Kconfig                       |   13 +
>   drivers/iio/adc/Makefile                      |    1 +
>   drivers/iio/adc/pac1944.c                     | 3528 +++++++++++++++++
>   5 files changed, 3558 insertions(+)
>   create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-pac1944
>   create mode 100644 drivers/iio/adc/pac1944.c
> 

Hi,

below a few comments and nitpicks.

   - You could slightly improve style by removing extra spaces in 
several places where you have <SPACE><SPACE>= or =<SPACE><SPACE>.

   - pac1944_oc_limit_nsamples_store(),
     pac1944_uc_limit_nsamples_store(),
     pac1944_op_limit_nsamples_store(),
     pac1944_ov_limit_nsamples_store(),
     pac1944_uv_limit_nsamples_store()
     look really similar and could be defined with a macro with 3 
parameters to save some LoC

    - same for pac1944_slow_alert_store() and 
pac1944_gpio_alert_store(), if it makes sense for just 2 functions

   - the same could be done for some show functions

   - (unlikely(check_add_overflow()): unlikely is not needed, I think 
that it is already handled that way (see __must_check_overflow())

...
> +static int pac1944_send_refresh(struct pac1944_chip_info *info,
> +				u8 refresh_cmd, u32 wait_time)
> +{
> +	struct i2c_client *client = info->client;
> +	int ret;
> +
> +	/* Writing a REFRESH or a REFRESH_V command */
> +	ret = i2c_smbus_write_byte(client, refresh_cmd);
> +	if (ret) {
> +		dev_err(&client->dev, "%s - cannot send Refresh cmd (0x%02X) to PAC1944\n",
> +			__func__, refresh_cmd);
> +		return ret;
> +	}
> +
> +	/* Register data retrieval timestamp */
> +	info->chip_reg_data.jiffies_tstamp = jiffies;
> +	/* Wait till the data is available */
> +	usleep_range(wait_time, wait_time + 100);
> +
> +	return ret;

Nitpick : return 0;

> +}

...

> +static int pac1944_retrieve_data(struct pac1944_chip_info *info, u32 wait_time)
> +{
> +	int ret;

Missing newline

> +	/*
> +	 * Check if the minimal elapsed time has passed and if so,
> +	 * re-read the chip, otherwise the cached info is just fine
> +	 */
> +	if (time_after(jiffies, info->chip_reg_data.jiffies_tstamp +
> +		       msecs_to_jiffies(PAC1944_MIN_POLLING_TIME_MS))) {
> +		/*
> +		 * We need to re-read the chip values
> +		 * call the pac1944_reg_snapshot
> +		 */
> +		ret = pac1944_reg_snapshot(info, true,
> +					   PAC1944_REFRESH_REG_ADDR,
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

...

> +static ssize_t pac1944_in_voltage_acc_raw_show(struct device *dev,
> +					       struct device_attribute *attr,
> +					       char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct pac1944_chip_info *info = iio_priv(indio_dev);
> +	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
> +	int ret;
> +	s64 acc_voltage;
> +	u32 samples_count;
> +	u64 tmp_u64;
> +
> +	ret = pac1944_retrieve_data(info, PAC1944_MIN_UPDATE_WAIT_TIME_US);
> +	if (ret < 0)
> +		return 0;
> +
> +	acc_voltage = info->chip_reg_data.acc_val[this_attr->address];
> +	samples_count = info->chip_reg_data.total_samples_nr[this_attr->address];
> +
> +	tmp_u64 = div_u64(abs(acc_voltage), samples_count);
> +
> +	if (unlikely(is_negative(acc_voltage)))

unlikely() does not seem really needed here. It does not look like a hot 
path.

> +		return sysfs_emit(buf, "-%lld\n", tmp_u64);
> +	else
> +		return sysfs_emit(buf, "%lld\n", tmp_u64);
> +}

...

> +static int pac1944_read_thresh(struct iio_dev *indio_dev,
> +			       const struct iio_chan_spec *chan, enum iio_event_type type,
> +			       enum iio_event_direction dir, enum iio_event_info info,
> +			       int *val, int *val2)
> +{
> +	struct pac1944_chip_info *chip_info = iio_priv(indio_dev);
> +	int idx;
> +
> +	/* into the datasheet channels are noted from 1 to 4 */
> +	idx = chan->channel - 1;
> +
> +	switch (chan->type) {

Should it be protected by chip_info->lock, as done in 
pac1944_read_event_config()?


> +	case IIO_VOLTAGE:
> +		switch (dir) {
> +		case IIO_EV_DIR_RISING:
> +			*val = chip_info->overvoltage[idx];
> +			return IIO_VAL_INT;
> +		case IIO_EV_DIR_FALLING:
> +			*val = chip_info->undervoltage[idx];
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CURRENT:
> +		switch (dir) {
> +		case IIO_EV_DIR_RISING:
> +			*val = chip_info->overcurrent[idx];
> +			return IIO_VAL_INT;
> +		case IIO_EV_DIR_FALLING:
> +			*val = chip_info->undercurrent[idx];
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_POWER:
> +		switch (dir) {
> +		case IIO_EV_DIR_RISING:
> +			*val = chip_info->overpower[idx];
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
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

Why are scoped_guard() in each cases?
Could'nt it be done as ni pac1944_read_event_config()?

> +	switch (chan->type) {
> +	case IIO_VOLTAGE:
> +		switch (dir) {
> +		case IIO_EV_DIR_RISING:
> +			scoped_guard(mutex, &chip_info->lock) {
> +				ret = pac1944_update_alert_16b(&indio_dev->dev,
> +							       PAC1944_OV_LIMIT_REG_ADDR + idx,
> +							       (int)(PAC1944_CH01UV_MASK >> idx),
> +							       val);
> +				if (!ret)
> +					chip_info->overvoltage[idx] = val;
> +			}
> +			return ret;

...

> +static int pac1944_write_event_config(struct iio_dev *indio_dev,
> +				      const struct iio_chan_spec *chan,
> +				      enum iio_event_type type,
> +				      enum iio_event_direction dir,
> +				      int state)
> +{
> +	struct pac1944_chip_info *info = iio_priv(indio_dev);
> +	struct i2c_client *client = info->client;
> +	int idx, val, mask, ret;
> +	bool update = false;
> +	u8 tmp[PAC1944_ALERT_ENABLE_REG_LEN];
> +
> +	/* into the datasheet channels are noted from 1 to 4 */
> +	idx = chan->channel - 1;
> +
> +	guard(mutex)(&info->lock);

This could maybe be moved after the switch(), if this makes sense?

> +
> +	switch (chan->type) {
> +	case IIO_VOLTAGE:
> +		switch (dir) {
> +		case IIO_EV_DIR_RISING:

...

> +static int pac1944_prep_iio_channels(struct pac1944_chip_info *info,
> +				     struct iio_dev *indio_dev)
> +{
> +	struct device *dev = &info->client->dev;
> +	struct iio_chan_spec *ch_sp;
> +	int channel_size, attribute_count;
> +	int cnt;
> +	void *dyn_ch_struct, *tmp_data;
> +
> +	/* Finding out dynamically how many IIO channels we need */
> +	attribute_count = 0;
> +	channel_size = 0;
> +	for (cnt = 0; cnt < info->phys_channels; cnt++) {
> +		if (!info->active_channels[cnt])
> +			continue;
> +
> +		/* add the size of the properties of one chip physical channel */
> +		channel_size += sizeof(pac1944_single_channel);
> +		/* count how many enabled channels we have */
> +		attribute_count += ARRAY_SIZE(pac1944_single_channel);
> +		dev_info(dev, ":%s: Channel %d active\n", __func__, cnt + 1);
> +	}
> +
> +	dyn_ch_struct = devm_kzalloc(dev, channel_size, GFP_KERNEL);
> +	if (!dyn_ch_struct)
> +		return -EINVAL;

-ENOMEM?

> +
> +	tmp_data = dyn_ch_struct;
> +	/* Populate the dynamic channels and make all the adjustments */
> +	for (cnt = 0; cnt < info->phys_channels; cnt++) {
> +		if (!info->active_channels[cnt])
> +			continue;

...

> +static int pac1944_probe(struct i2c_client *client)
> +{
> +	struct pac1944_chip_info *info;
> +	struct iio_dev *indio_dev;
> +	const struct pac1944_features *chip;
> +	bool match = false;
> +	int cnt, ret;
> +	struct device *dev = &client->dev;
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
> +		/*
> +		 * If failed to identify the hardware based on internal
> +		 * registers,try using fallback compatible in device tree to

Nitpick: space missing after the comma.

> +		 * deal with some newer part number.
> +		 */
> +		chip = i2c_get_match_data(client);
> +		if (!chip)
> +			return -EINVAL;
> +
> +		info->chip_variant = chip->prod_id;
> +		info->phys_channels = chip->phys_channels;
> +		indio_dev->name = chip->name;
> +	} else {

...

> +	ret = pac1944_reg_snapshot(info, true, false,
> +				   PAC1944_MIN_UPDATE_WAIT_TIME_US);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = devm_iio_device_register(&client->dev, indio_dev);
> +

Nitpick: needeless new line

> +	if (ret < 0)
> +		return dev_err_probe(dev, ret,
> +				     "Can't register IIO device\n");
> +
> +	return 0;
> +}

CJ

...


