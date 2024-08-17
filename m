Return-Path: <linux-iio+bounces-8527-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D0395576B
	for <lists+linux-iio@lfdr.de>; Sat, 17 Aug 2024 13:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9BAEB215D5
	for <lists+linux-iio@lfdr.de>; Sat, 17 Aug 2024 11:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAFDF14AD1A;
	Sat, 17 Aug 2024 11:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QbG2xxb8"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B19F149DE8;
	Sat, 17 Aug 2024 11:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723894207; cv=none; b=db3JNNB/tnl1tXYO1f89/NsI7emeQjMm2cZmGrNnjOecFjANVl1V/l0qZUO25axh8x+sD1IfhB1ElBs4jI/BojsLNUe+AJOxJMW7QmVQKit/XV+6K/sg15ax8iiuhA4Le7RPsJDXrnJ/cni6PyZedjOjutbC6ncAlIZcTbSP3zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723894207; c=relaxed/simple;
	bh=m2uWl406YVaPWrI6JcR4DevVm121UHwVoW5qUxh4yGY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JV3ZlSjVA2rPedVbbOBmNh7X2uBepQOau+4RoXJmi/rTsxaA3g6+vQUvbK/Roh8GQq20q0DHuUTX0/0Z8qOirok7fGo1VyON1EFNxn0y7npnWty3ghDfC6pYR9sFmCScywCT+vaHWwX8ewP9T/EpGUyfYhUZLA+r0uzOCPTO9Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QbG2xxb8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 433FEC116B1;
	Sat, 17 Aug 2024 11:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723894207;
	bh=m2uWl406YVaPWrI6JcR4DevVm121UHwVoW5qUxh4yGY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QbG2xxb8FrwkNscTKi+5U+ZzW42mfY5w116DAnKd8rx/HHjaGSulwk+EEL3EG1xNC
	 u8raWQ8XNVqObSi6DIErT2C/0a0WqNHZ1DBtoN6IJyIYtYPDqH7NHQL7tqp9ngFEF9
	 r7Fq2j5ybBRQFeMrJsZsFmnMtpkt3Nz5RL/WeJXh7k2S/Qa2XM1x/nOLNwQet3shCp
	 mRvs496vobgmnXzULVF6CCr8IAPV9O4ZZo92qJBnr4npfm2lS+lrkRwND1oycEPC1l
	 qMWUfUaEshTVmojM4xGyDU1igF/lDUkLjDeRpVRj8wTS9lKj3OYUSUFUq3xTM8eCpu
	 1UYiJqd7hXAYQ==
Date: Sat, 17 Aug 2024 12:29:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: wangshuaijie@awinic.com
Cc: lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, kees@kernel.org, gustavoars@kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 liweilei@awinic.com, kangjiajun@awinic.com
Subject: Re: [PATCH V7 2/2] iio: proximity: aw96103: Add support for
 aw96103/aw96105 proximity sensor
Message-ID: <20240817122944.072eee19@jic23-huawei>
In-Reply-To: <20240814031808.2852418-3-wangshuaijie@awinic.com>
References: <20240814031808.2852418-1-wangshuaijie@awinic.com>
	<20240814031808.2852418-3-wangshuaijie@awinic.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Aug 2024 03:18:08 +0000
wangshuaijie@awinic.com wrote:

> From: shuaijie wang <wangshuaijie@awinic.com>
> 
> AW96103 is a low power consumption capacitive touch and proximity controller.
> Each channel can be independently config as sensor input, shield output.
> 
> Channel Information:
>   aw96103: 3-channel
>   aw96105: 5-channel
> 
> Signed-off-by: shuaijie wang <wangshuaijie@awinic.com>
> ---
>  drivers/iio/proximity/Kconfig   |  11 +
>  drivers/iio/proximity/Makefile  |   1 +
>  drivers/iio/proximity/aw96103.c | 814 ++++++++++++++++++++++++++++++++
>  drivers/iio/proximity/aw96103.h | 116 +++++

I've lost track on whether we discussed this earlier, but the header is an unnecessary
addition of complexity. It would be better to have those definitions all in the c file.

Various other comments inline.

Jonathan

>  4 files changed, 942 insertions(+)
>  create mode 100644 drivers/iio/proximity/aw96103.c
>  create mode 100644 drivers/iio/proximity/aw96103.h
> 


> diff --git a/drivers/iio/proximity/aw96103.c b/drivers/iio/proximity/aw96103.c
> new file mode 100644
> index 000000000000..d8ca138de46e
> --- /dev/null
> +++ b/drivers/iio/proximity/aw96103.c
> @@ -0,0 +1,814 @@

> +
> +static void aw96103_parsing_bin_file(struct aw_bin *bin)
> +{
> +	int i;
> +
> +	bin->valid_data_addr = AW96103_BIN_VALID_DATA_OFFSET;
> +	bin->valid_data_len =
> +		*(unsigned int *)(bin->data + AW96103_BIN_DATA_LEN_OFFSET) -
> +		AW96103_BIN_DATA_REG_NUM_SIZE;
> +	for (i = 0; i < AW96103_BIN_CHIP_TYPE_SIZE; i++) {
> +		bin->chip_type[i] =
> +			*(bin->data + AW96103_BIN_CHIP_TYPE_OFFSET + i);
looks like an opencoded memcpy, use memcpy instead.
> +	}
> +}
> +

> +
> +static int aw96103_get_diff_raw(struct aw96103 *aw96103,
> +		unsigned int chan, int *buf)
> +{
> +	u32 data;
> +	int ret;
> +
> +	ret = regmap_read(aw96103->regmap,
> +			AW96103_REG_DIFF_CH0 + chan * 4, &data);
> +	if (ret)
> +		return ret;
> +	*buf = (int)(data / AW_DATA_PROCESS_FACTOR);
> +
> +	return 0;
> +}
> +
> +static int aw96103_read_raw(struct iio_dev *indio_dev,
> +		const struct iio_chan_spec *chan,
> +		int *val, int *val2, long mask)
> +{
> +	struct aw96103 *aw96103;
	struct aw96103 *aw96103 = iio_priv(indio_dev);

> +	int ret;
> +
> +	aw96103 = iio_priv(indio_dev);
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = aw96103_get_diff_raw(aw96103, chan->channel, val);
> +		if (ret)
> +			return ret;
> +
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}


> +
> +static int aw96103_write_hysteresis(struct aw96103 *aw96103,
> +			       const struct iio_chan_spec *chan, int val)
> +{
> +	unsigned int reg, reg_val;
> +	int ret;
> +
> +	reg = AW96103_REG_PROXCTRL_CH0 + chan->channel * AW96103_PROXTH_CH_STEP;
Perhaps worth a macro
#define AW96103_REG_PROXCTRL_CH(x) \
	AW96103_REG_PROXCTRL_CH0 + (x) * AW96103_PROXTH_CH_STEP
> +	reg_val = FIELD_PREP(AW96103_THHYST_MASK, val);
> +	mutex_lock(&aw96103->mutex);

	guard(mutex)(&aw96103->mutex);
	return regmap_update_bits(aw96103->regmap,
				  AS96103_REG_PROXCTRL_CH(chan->channel),
				  AW96103_THHYST_MASK,
				  FIELD_PREP(AW96103_THHYST_MASK, val));
Same for all other cod that looks like this.

> +	ret = regmap_update_bits(aw96103->regmap, reg,
> +			AW96103_THHYST_MASK, reg_val);
> +	mutex_unlock(&aw96103->mutex);
> +
> +	return ret;
> +}


...

> +static int aw96103_write_event_config(struct iio_dev *indio_dev,
> +				 const struct iio_chan_spec *chan,
> +				 enum iio_event_type type,
> +				 enum iio_event_direction dir, int state)
> +{
> +	struct aw96103 *aw96103 = iio_priv(indio_dev);
> +
> +	aw96103->channels_arr[chan->channel].used = !!state;
> +
> +	if (!!state)
> +		return regmap_update_bits(aw96103->regmap,
> +				AW96103_REG_SCANCTRL0,
> +				BIT(chan->channel), BIT(chan->channel));
> +	else
> +		return regmap_update_bits(aw96103->regmap,
> +				AW96103_REG_SCANCTRL0,
> +				BIT(chan->channel), 0);

	unsigned int val = !!state;

	ad96103->channels_ar[chan->channel].used = val;

	return regmap_update_bits(aw96103->regmap, AW96103_REG_SCAN_CTRL0,
				  val);

> +}

...

> +
> +static int aw96103_iio_init(struct iio_dev *indio_dev)
> +{
> +	struct aw96103 *aw96103 = iio_priv(indio_dev);
> +	struct iio_chan_spec *aw96103_channels;
> +	unsigned int i;
> +
> +	/*
> +	 * There is one more logical channel than the actual channels,
> +	 * and the extra logical channel is used for temperature detection
> +	 * but not for status detection. The specific channel used for
> +	 * temperature detection is determined by the register configuration.
> +	 */
> +	aw96103->channels_arr = devm_kcalloc(aw96103->dev,
> +			aw96103->max_channels + 1,
> +			sizeof(struct aw_channels_info), GFP_KERNEL);
> +	if (!aw96103->channels_arr)
> +		return -ENOMEM;
Simpler to just embed an array of the maximum size.  Given overheads of
allocator etc and small size of structure that may be more efficient as well
as reduce amount of code.
> +
> +	aw96103_channels = devm_kcalloc(aw96103->dev, aw96103->max_channels + 1,
> +			sizeof(*aw96103_channels), GFP_KERNEL);
> +	if (!aw96103_channels)
> +		return -ENOMEM;
Same for this one. Just embed the maximum size you might need in the
iio_priv() structure rather than allocating fresh.

However, max_channels is only either 3 or 5.  Better to just have
to static const arrays of channels and pick between them thus removing
need to do any dynamic instantiating here.
See a driver like adc/max1363 for an extreme example of this.


> +
> +	for (i = 0; i <= aw96103->max_channels; i++) {
> +		aw96103_channels[i].type = IIO_PROXIMITY;
> +		aw96103_channels[i].info_mask_separate =
> +			BIT(IIO_CHAN_INFO_RAW);
> +		aw96103_channels[i].indexed = 1;
> +		aw96103_channels[i].channel = i;
> +		aw96103_channels[i].event_spec = aw_common_events;
> +		aw96103_channels[i].num_event_specs =
> +			ARRAY_SIZE(aw_common_events);
> +	}
With all the above as a simple one line pick of data from the
per device type structure you'll be adding (See below) this
function will do very little. So just have the code inline at
the caller.
> +
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->num_channels = aw96103->max_channels + 1;
> +	indio_dev->channels = aw96103_channels;
> +	indio_dev->info = &iio_info;
> +	indio_dev->name = "aw96103_sensor";
> +	indio_dev->dev.parent = aw96103->dev;
> +
> +	return devm_iio_device_register(aw96103->dev, indio_dev);
> +}
> +
> +static int aw96103_channel_scan_start(struct aw96103 *aw96103)
> +{
> +	int ret;
> +
> +	ret = regmap_write(aw96103->regmap, AW96103_REG_CMD,
> +			AW96103_ACTIVE_MODE);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_write(aw96103->regmap, AW96103_REG_IRQEN,
> +			aw96103->hostirqen);
> +}
> +
> +static int aw96103_reg_version_comp(struct aw96103 *aw96103,
> +		struct aw_bin *aw_bin)
> +{
> +	u32 blfilt1_data, blfilt1_tmp;
> +	unsigned char i;
> +	int ret;
> +
> +	/*
> +	 * If the chip version is AW96103A and the loaded register
> +	 * configuration file is for AW96103, special handling of the
> +	 * AW96103_REG_BLRSTRNG_CH0 register is required.
> +	 */
> +	if ((aw96103->vers == AW96103A) && (aw_bin->chip_type[7] == '\0')) {
Pull the version register read to here so that you don't need to store
the value in your iio_priv() structure.
> +		for (i = 0; i <= aw96103->max_channels; i++) {
> +			ret = regmap_read(aw96103->regmap,
> +					AW96103_REG_BLFILT_CH0 +
> +					(AW96103_BLFILT_CH_STEP * i),
> +					&blfilt1_data);
> +			if (ret)
> +				return ret;
> +			blfilt1_tmp = FIELD_GET(AW96103_BLERRTRIG_MASK,
> +					blfilt1_data);
> +			if (blfilt1_tmp == 1) {
> +				ret = regmap_update_bits(aw96103->regmap,
> +					AW96103_REG_BLRSTRNG_CH0 +
> +					(AW96103_BLFILT_CH_STEP * i),
> +					AW96103_BLRSTRNG_MASK, 1 << i);
> +				if (ret)
> +					return ret;
> +			}
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int aw96103_bin_valid_loaded(struct aw96103 *aw96103,
> +		struct aw_bin *aw_bin_data_s)

Align to just after (

> +{
> +	unsigned int start_addr = aw_bin_data_s->valid_data_addr;
> +	u32 i, reg_data;
> +	u16 reg_addr;
> +	int ret;
> +
> +	for (i = 0; i < aw_bin_data_s->valid_data_len;
> +	     i += 6, start_addr += 6) {
> +		reg_addr = *(u16 *)(aw_bin_data_s->data + start_addr);
> +		reg_data = *(u32 *)(aw_bin_data_s->data + start_addr + 2);
> +		if ((reg_addr == AW96103_REG_EEDA0) ||
> +		    (reg_addr == AW96103_REG_EEDA1))
> +			continue;
> +		if (reg_addr == AW96103_REG_IRQEN) {
> +			aw96103->hostirqen = reg_data;
> +			continue;
> +		}
> +		if (reg_addr == AW96103_REG_SCANCTRL0)
> +			aw96103->chan_en = FIELD_GET(AW96103_CHAN_EN_MASK,
> +					reg_data);
> +		ret = regmap_write(aw96103->regmap, reg_addr, reg_data);
> +		if (ret < 0)
> +			return ret;
> +
> +	}
> +	ret = aw96103_reg_version_comp(aw96103, aw_bin_data_s);
> +	if (ret)
> +		return ret;
> +
> +	return aw96103_channel_scan_start(aw96103);
> +}

> +
> +static void aw96103_cfg_update(const struct firmware *fw, void *data)
> +{
> +	struct aw96103 *aw96103 = data;
> +	int ret, i;
> +
> +	if (!fw || !fw->data) {
> +		dev_err(aw96103->dev, "%s: No firmware.\n", __func__);

The func isn't really useful, so drop it.  The error message + device
is enough for debugging.

> +		return;
> +	}
> +
> +	ret = aw96103_cfg_all_loaded(fw, aw96103);
> +	if (ret)

Add a comment here on why this makes sense on error.

> +		ret = aw96103_para_loaded(aw96103);

If this returns an error handle it.

> +	release_firmware(fw);
> +
> +	for (i = 0; i <= aw96103->max_channels; i++) {
> +		if ((aw96103->chan_en >> i) & 0x01)
> +			aw96103->channels_arr[i].used = true;
> +		else
> +			aw96103->channels_arr[i].used = false;
> +	}
> +}
> +
> +static int aw96103_sw_reset(struct aw96103 *aw96103)
> +{
> +	int ret;
> +
> +	ret = regmap_write(aw96103->regmap, AW96103_REG_RESET, 0);
> +	msleep(20);

Add a comment / reference for why 20 msecs.

> +
> +	return ret;
> +}
> +
> +static void aw96103_irq_handle(struct iio_dev *indio_dev)
> +{
> +	struct aw96103 *aw96103 = iio_priv(indio_dev);
> +	u32 curr_status_val;
> +	u32 curr_status;
> +	unsigned char i;
> +	int ret;
> +
> +	ret = regmap_read(aw96103->regmap, AW96103_REG_STAT0, &curr_status_val);
> +	if (ret)
> +		return;
> +
> +	/*
> +	 * Iteratively analyze the interrupt status of different channels,
> +	 * with each channel having 4 interrupt states.
> +	 */
> +	for (i = 0; i < AW_CHANNEL_MAX; i++) {
> +		curr_status = (((curr_status_val >> (24 + i)) & 0x1)) |
> +			(((curr_status_val >> (16 + i)) & 0x1) << 1) |
> +			(((curr_status_val >> (8 + i)) & 0x1) << 2) |
> +			(((curr_status_val >> i) & 0x1) << 3);
> +
> +		if (!aw96103->channels_arr[i].used ||

I'd do this check before computing curr_status as no point in looking at data
that we don't care about.

> +		    (aw96103->channels_arr[i].last_channel_info == curr_status))

and keep this one here.

> +			continue;
> +
> +		switch (curr_status) {
> +		case FAR:
> +			iio_push_event(indio_dev,
> +					IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY, i,
> +						IIO_EV_TYPE_THRESH,
> +						IIO_EV_DIR_RISING),
> +					iio_get_time_ns(indio_dev));
> +			break;
> +		case TRIGGER_TH0:
> +		case TRIGGER_TH1:
> +		case TRIGGER_TH2:
> +		case TRIGGER_TH3:
> +			iio_push_event(indio_dev,
> +					IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY, i,
> +						IIO_EV_TYPE_THRESH,
> +						IIO_EV_DIR_FALLING),
> +					iio_get_time_ns(indio_dev));
> +			break;
> +		default:
> +			return;
> +		}
> +		aw96103->channels_arr[i].last_channel_info = curr_status;
> +	}
> +}
> +
> +static void aw96103_interrupt_clear(struct iio_dev *indio_dev)
> +{
> +	struct aw96103 *aw96103 = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = regmap_read(aw96103->regmap, AW96103_REG_IRQSRC,
> +			&aw96103->irq_status);
> +	if (ret)
> +		return;

As below. Use a local variable for irq_status here as nothing
else ever reads what you are storing into it here
> +
> +	aw96103_irq_handle(indio_dev);
Even this nesting doesn't add much. I'd bring that code inline as well
as the suggestion below.

> +}
> +
> +static irqreturn_t aw96103_irq(int irq, void *data)
> +{
> +	struct iio_dev *indio_dev = (struct iio_dev *)data;
Never need to cast explicitly from a void * to another pointer type
(the C specification defines this as always fine).

> +
> +	aw96103_interrupt_clear(indio_dev);
Very little code in interrupt_clear() just have it inline here instead.

> +
> +	return IRQ_HANDLED;
> +}

> +static int aw96103_wait_chip_init(struct aw96103 *aw96103)
> +{
> +	unsigned int cnt = 20;
> +	u32 reg_data;
> +	int ret;
> +
> +	while (cnt--) {

Document why this retry count etc. 

> +		ret = regmap_read(aw96103->regmap, AW96103_REG_IRQSRC,
> +				&reg_data);
> +		if (ret)
> +			return ret;
> +
> +		if (FIELD_GET(AW96103_INITOVERIRQ_MASK, reg_data))
> +			return 0;
> +		mdelay(1);
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int aw96103_read_chipid(struct aw96103 *aw96103)
> +{
> +	unsigned char cnt = 0;
> +	u32 reg_val = 0;
> +	int ret;
> +
> +	while (cnt < AW_READ_CHIPID_RETRIES) {

As below. The retry number and sleep length needs documenting.
If it's just 'this works' not something from the datasheet that is fine, but
say it.

> +		ret = regmap_read(aw96103->regmap, AW96103_REG_CHIPID,
> +				&reg_val);
> +		if (ret < 0) {
> +			cnt++;
> +			usleep_range(2000, 3000);
> +		} else {
> +			reg_val = FIELD_GET(AW96103_CHIPID_MASK, reg_val);
> +			break;
> +		}
> +	}
Two things here and a failure to read anything should be an error.

	if (cnt == AW_READ_CHIPID_RETRIES)
		return -ETIMEDOUT;

	if (FIELD_GET(AW...) != AW6103_CHIP_ID)
		dev_info(...)

	return 0;

	
> +
> +	if (reg_val != AW96103_CHIP_ID)
dev_info() only as this may be a DT fallback compatible situation which
is not an err.
> +		dev_err(aw96103->dev,
> +				"chipid error, error_id=0x%08X\n", reg_val);
Also change comment to
"unexpected chipid"

> +
> +	return 0;
> +}
> +
> +static int aw96103_version_init(struct aw96103 *aw96103)
> +{
> +	u32 fw_ver;
> +	int ret;
> +
> +	ret = regmap_read(aw96103->regmap, AW96103_REG_FWVER2, &fw_ver);
> +	if (ret)

As above, just read this when you need it and match directly on the field
rather than converting to another representation.

> +		return ret;
> +	if (fw_ver == AW_CHIP_AW96103A)
> +		aw96103->vers = AW96103A;
> +	else
> +		aw96103->vers = AW96103;
> +
> +	return 0;
> +}
> +
> +static int aw96103_i2c_probe(struct i2c_client *i2c)
> +{
> +	const struct i2c_device_id *id = i2c_client_get_device_id(i2c);

This is fragile. Fix the enum vs pointer thing (see below)
and use i2c_get_match_data() to get the structure.


> +	enum aw96103_sensor_type sensor_type;
> +	struct iio_dev *aw_iio_dev;
> +	struct aw96103 *aw96103;
> +	int ret;
> +
> +	aw_iio_dev = devm_iio_device_alloc(&i2c->dev, sizeof(*aw96103));
> +	if (!aw_iio_dev)
> +		return -ENOMEM;
> +
> +	aw96103 = iio_priv(aw_iio_dev);
> +	aw96103->dev = &i2c->dev;
> +	aw96103->i2c = i2c;
> +	mutex_init(&aw96103->mutex);
> +	i2c_set_clientdata(i2c, aw96103);

Is this used? If not don't set it.

> +
> +	sensor_type = (enum aw96103_sensor_type)id->driver_data;
> +	switch (sensor_type) {
> +	case AW96103_VAL:
> +		aw96103->max_channels = AW_CHANNEL3;

Encode this in the per type structure you are going to use to replace
sensor_type in the match tables below.
Where possible it is better to use data than code to differentiate
particular device variants.  As you add more parts it scales much better than
thsi.


> +		break;
> +	case AW96105_VAL:
> +		aw96103->max_channels = AW_CHANNEL5;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	aw96103->regmap = devm_regmap_init_i2c(i2c, &aw96103_regmap_confg);
> +	if (IS_ERR(aw96103->regmap))
> +		return PTR_ERR(aw96103->regmap);
> +
> +	ret = devm_regulator_get_enable(aw96103->dev, "vcc");
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = aw96103_read_chipid(aw96103);
> +	if (ret)
> +		return ret;
> +
> +	ret = aw96103_sw_reset(aw96103);
> +	if (ret)
> +		return ret;
> +
> +	ret = aw96103_wait_chip_init(aw96103);
> +	if (ret)
> +		return ret;
> +
> +	ret = aw96103_version_init(aw96103);
> +	if (ret)
> +		return ret;
> +
> +	ret = request_firmware_nowait(THIS_MODULE, true, "aw96103_0.bin",
> +			aw96103->dev, GFP_KERNEL, aw96103, aw96103_cfg_update);
> +	if (ret)
> +		return ret;
> +
> +	ret = aw96103_interrupt_init(aw_iio_dev);
> +	if (ret)
> +		return ret;
> +
> +	return aw96103_iio_init(aw_iio_dev);
> +}
> +
> +static const struct of_device_id aw96103_dt_match[] = {
> +	{ .compatible = "awinic,aw96103", (void *)AW96103_VAL },
> +	{ .compatible = "awinic,aw96105", (void *)AW96105_VAL },
Don't use enums in here. Define a structure for each one with all
relevant data in it.



> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, aw96103_dt_match);
> +
> +static const struct i2c_device_id aw96103_i2c_id[] = {
> +	{ "aw96103", AW96103_VAL },
> +	{ "aw96105", AW96105_VAL },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, aw96103_i2c_id);
> +
> +static struct i2c_driver aw96103_i2c_driver = {
> +	.driver = {
> +		.name = "aw96103_sensor",
> +		.of_match_table = aw96103_dt_match,
> +	},
> +	.probe = aw96103_i2c_probe,
> +	.id_table = aw96103_i2c_id,
> +};
> +module_i2c_driver(aw96103_i2c_driver);
> +
> +MODULE_AUTHOR("Wang Shuaijie <wangshuaijie@awinic.com>");
> +MODULE_DESCRIPTION("Driver for Awinic AW96103 proximity sensor");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/iio/proximity/aw96103.h b/drivers/iio/proximity/aw96103.h
> new file mode 100644
> index 000000000000..78716e34b54c
> --- /dev/null
> +++ b/drivers/iio/proximity/aw96103.h
> @@ -0,0 +1,116 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef _AW96103_H_
> +#define _AW96103_H_
> +
> +#define AW_DATA_PROCESS_FACTOR			1024
> +#define AW_CHIP_AW96103A			0x03000b00
> +#define AW_READ_CHIPID_RETRIES			3

Why?  If you are going to do a retry count to allow a chip to finish booting
or similar add a comment on why you chose this value.
May be better to get rid of define and document the behaviour at the one
place it is used.  There the delay per retry is also visible.

> +#define AW96103_CHIP_ID				0xa961
> +#define AW96103_BIN_VALID_DATA_OFFSET		64
> +#define AW96103_BIN_DATA_LEN_OFFSET		16
> +#define AW96103_BIN_DATA_REG_NUM_SIZE		4
> +#define AW96103_BIN_CHIP_TYPE_SIZE		8
> +#define AW96103_BIN_CHIP_TYPE_OFFSET		24
> +
> +#define AW96103_REG_SCANCTRL0			0x0000
> +#define AW96103_REG_STAT0			0x0090
> +#define AW96103_REG_BLFILT_CH0			0x00A8
> +#define AW96103_REG_BLRSTRNG_CH0		0x00B4
> +#define AW96103_REG_DIFF_CH0			0x0240
> +#define AW96103_REG_FWVER2			0x0410
> +#define AW96103_REG_CMD				0xF008
> +#define AW96103_REG_IRQSRC			0xF080
> +#define AW96103_REG_IRQEN			0xF084
> +#define AW96103_REG_RESET			0xFF0C
> +#define AW96103_REG_CHIPID			0xFF10
> +#define AW96103_REG_EEDA0			0x0408
> +#define AW96103_REG_EEDA1			0x040C
> +#define AW96103_REG_PROXCTRL_CH0		0x00B0
> +#define AW96103_REG_PROXTH0_CH0			0x00B8
> +#define AW96103_PROXTH_CH_STEP			0x3C
> +#define AW96103_THHYST_MASK			GENMASK(13, 12)
> +#define AW96103_INDEB_MASK			GENMASK(11, 10)
> +#define AW96103_OUTDEB_MASK			GENMASK(9, 8)
> +#define AW96103_INITOVERIRQ_MASK		BIT(0)
> +#define AW96103_BLFILT_CH_STEP			0x3C
> +#define AW96103_BLRSTRNG_MASK			GENMASK(5, 0)
> +#define AW96103_CHIPID_MASK			GENMASK(31, 16)
> +#define AW96103_BLERRTRIG_MASK			BIT(25)
> +#define AW96103_CHAN_EN_MASK			GENMASK(5, 0)
> +
> +/**
> + * struct aw_bin - Store the data obtained from parsing the configuration file.
> + * @chip_type: Frame header information-chip type
> + * @valid_data_len: Length of valid data obtained after parsing
> + * @valid_data_addr: The offset address of the valid data obtained
> + *		     after parsing relative to info
> + * @len: The size of the bin file obtained from the firmware
> + * @data: Store the bin file obtained from the firmware
> + */
> +struct aw_bin {
> +	unsigned char chip_type[8];
> +	unsigned int valid_data_len;
> +	unsigned int valid_data_addr;
> +	unsigned int len;
> +	unsigned char data[] __counted_by(len);
> +};
> +
> +enum aw96103_sar_vers {
> +	AW96103 = 2,
> +	AW96103A = 6,
> +	AW96103B = 0xa,
> +};
> +
> +enum aw96103_operation_mode {
> +	AW96103_ACTIVE_MODE = 1,
I would specify all values given they don't start at 0.
> +	AW96103_SLEEP_MODE,
> +	AW96103_DEEPSLEEP_MODE,
> +	AW96103B_DEEPSLEEP_MODE,
> +};
> +
> +enum aw96103_channel {
> +	AW_CHANNEL0,
> +	AW_CHANNEL1,
> +	AW_CHANNEL2,
> +	AW_CHANNEL3,
> +	AW_CHANNEL4,
> +	AW_CHANNEL5,
> +	AW_CHANNEL_MAX
This is just encodeing 0 == 0. Drop this and use the values directly
they are not magic numebrs!
> +};
> +
> +enum aw96103_irq_trigger_position {
> +	FAR,
> +	TRIGGER_TH0,
Given non obvious later values, better to specify them all

This is only used in one place and isn't directly related
to device state (due to the prior bit manipulations applied
to the register), so I'd put the definition right above the code.


> +	TRIGGER_TH1 = 0x03,
> +	TRIGGER_TH2 = 0x07,
> +	TRIGGER_TH3 = 0x0f,
> +};
> +
> +enum aw96103_sensor_type {
> +	AW96103_VAL,
> +	AW96105_VAL,
> +};
> +
> +struct aw_channels_info {
> +	bool used;
> +	unsigned int last_channel_info;
Add a comment on this or rename - name doesn't make it sufficiently obvious what
info is being stored in here.

> +};
> +
> +struct aw96103 {
> +	unsigned char vers;

As mentioned above, I'd just read the register when ever you need
this information.  No point in storing a copy - it's not in a high
performance path.

> +	unsigned int irq_status;

This is only ever read into as part of clearing interrupts.  Just use a local variable

> +	unsigned int hostirqen;
> +	struct delayed_work cfg_work;
> +	struct i2c_client *i2c;

Unused (or certainly should be as you have regmap).

> +	struct regmap *regmap;
> +	struct device *dev;
> +	struct aw_bin *aw_bin;

Not used?

> +	struct aw_channels_info *channels_arr;
> +	unsigned char chip_type[9];

I think this is only used locally in parsing code.  Better to keep the
data in a local variable that you pass to relevant functions.

> +	unsigned int max_channels;
> +	unsigned int chan_en;
> +	struct mutex mutex;

Any lock must have documentation comment.  What data is this protecting?
The scope of many locks is non obvious and failing to document them
can lead to future bugs as a driver is modified over time.

> +};
> +
> +#endif
> +


