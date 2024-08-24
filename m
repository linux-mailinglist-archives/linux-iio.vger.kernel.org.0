Return-Path: <linux-iio+bounces-8753-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C81195DD5F
	for <lists+linux-iio@lfdr.de>; Sat, 24 Aug 2024 12:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 745311C2116B
	for <lists+linux-iio@lfdr.de>; Sat, 24 Aug 2024 10:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42DB1155758;
	Sat, 24 Aug 2024 10:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F+1DW4jd"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F00A5F;
	Sat, 24 Aug 2024 10:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724495343; cv=none; b=ZbUf2XTSeqBF/fgg7aOsCWfOWv8ffl0WKsOF29MFz4sV1/pCBFdWZrngMuXEBIy62JPNPSv+cu9GBPeHcUmqAELtH9t3NPBQcW8WdEg8q2IB9ZHXn4Fok+nZqT9GmvzGh5m+wF+qwEOdolcqS7avBwpF+aKgheOjiM21p7ZiK8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724495343; c=relaxed/simple;
	bh=Ir8a/p3Eh/1DATQxjlROpyZ6wXcEi93r41qDbI6jZro=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P4664nE4o3oRoc2ePJhwy27sCFyGGSzQXNk3HVi0Bm+jEB/8dDDnnkEvpr2h4/rgLYKChLAQv6lx/KwGBpfsekQ2Cw5/Orm61fFvahi4CoZ2BTfte4zNmd0Gz5uz4xfzuaWc6O83qGZpZKNQHpBFed04cRX4x4epczTej1IRwOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F+1DW4jd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF593C32781;
	Sat, 24 Aug 2024 10:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724495342;
	bh=Ir8a/p3Eh/1DATQxjlROpyZ6wXcEi93r41qDbI6jZro=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F+1DW4jdXz4wjj7iBP6onTooGz7/6axBV5tyyLOWQavR1Ku7sBj1Z5taLxsx/qltx
	 mwphItsKcfWcZ6Q+ObD+renS6vd9YFZWjIBrWf+RhomIVdh3Q1gQFp4vc5M0Tdv4xA
	 XIPurZL0wlOqhbBTjUC37QFPTCjEOlJ/1EBrjwjyJvYqONKw8zkK+kHeqJsZ8eJ+p+
	 Md+7Y/x78gzv00/k+bB8AB/l+CJCu3ELosKGMLONOAhvpNG9S4XU19RQYdMNvW+y+2
	 9BfSo1YPNXW7RcR4ln2VP4Bxjgpk41U5SmE7x4pHnhAsYVu6nYtu6VmCM1DFd0X18w
	 Ywd5hJ0lZHSGg==
Date: Sat, 24 Aug 2024 11:28:47 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: wangshuaijie@awinic.com
Cc: lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, kees@kernel.org, gustavoars@kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 liweilei@awinic.com, kangjiajun@awinic.com
Subject: Re: [PATCH V8 2/2] iio: proximity: aw96103: Add support for
 aw96103/aw96105 proximity sensor
Message-ID: <20240824112847.16ea6521@jic23-huawei>
In-Reply-To: <20240823094947.3511730-3-wangshuaijie@awinic.com>
References: <20240823094947.3511730-1-wangshuaijie@awinic.com>
	<20240823094947.3511730-3-wangshuaijie@awinic.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 Aug 2024 09:49:46 +0000
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

Hi shuaijie wang,

This is coming together nicely now so we are down to the fine details
in this review.

Some comments may be a bit brief. I'm trying to finish this before train
enters a tunnel under London :)

> diff --git a/drivers/iio/proximity/aw96103.c b/drivers/iio/proximity/aw96103.c
> new file mode 100644
> index 000000000000..c9514712c307


> +static int aw96103_write_hysteresis(struct aw96103 *aw96103,
> +				    const struct iio_chan_spec *chan, int val)
> +{
> +	unsigned int reg, reg_val;
> +
> +	reg = AW96103_REG_PROXCTRL_CH(chan->channel);
> +	reg_val = FIELD_PREP(AW96103_THHYST_MASK, val);
> +
> +	return regmap_update_bits(aw96103->regmap, reg,
> +				  AW96103_THHYST_MASK, reg_val);

I'd put reg and regval directly inline in the call.
The local variables aren't adding much.

Same for other related calls. Better to make the association
super obvious by not having the intermediate variables.


> +}
> +
> +static int aw96103_read_hysteresis(struct aw96103 *aw96103,
> +				   const struct iio_chan_spec *chan, int *val)
> +{
> +	unsigned int reg, reg_val;
> +	int ret;
> +
> +	reg = AW96103_REG_PROXCTRL_CH(chan->channel);
Put that inline in the regmap_call.
	ret = regmap_read(aw96103->regmap,
			  AW96013-REG_PROXCTRL_CH(chan->channel), &reg_val);
or similar
> +	ret = regmap_read(aw96103->regmap, reg, &reg_val);
> +	if (ret)
> +		return ret;
> +	*val = FIELD_GET(AW96103_THHYST_MASK, reg_val);
> +
> +	return IIO_VAL_INT;
> +}


> +static int aw96103_bin_valid_loaded(struct aw96103 *aw96103,
> +				    struct aw_bin *aw_bin_data_s)
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
This is going to be unaligned.  May cause problems for some ancient platforms.
Also I'm going to guess the endianness of the fw file is fixed.
As such, probably
	get_unaligned_le16() and get_unaligned_le32()
are appropriate?

Just guessing you aren't testing on a big endian platform!

> +		if ((reg_addr == AW96103_REG_EEDA0) ||
> +		    (reg_addr == AW96103_REG_EEDA1))
> +			continue;
> +		if (reg_addr == AW96103_REG_IRQEN) {
> +			aw96103->hostirqen = reg_data;
> +			continue;
> +		}
> +		if (reg_addr == AW96103_REG_SCANCTRL0)
> +			aw96103->chan_en = FIELD_GET(AW96103_CHAN_EN_MASK,
> +						     reg_data);
blank line here.

> +		ret = regmap_write(aw96103->regmap, reg_addr, reg_data);
> +		if (ret < 0)
> +			return ret;
> +
no blank line here.
> +	}
but add one here.

> +	ret = aw96103_reg_version_comp(aw96103, aw_bin_data_s);
> +	if (ret)
> +		return ret;
> +
> +	return aw96103_channel_scan_start(aw96103);
> +}


> +static void aw96103_irq_handle(struct iio_dev *indio_dev)

As below, squash this into the callsite as there is little
else done there.

> +{
> +	struct aw96103 *aw96103 = iio_priv(indio_dev);
> +	u32 curr_status_val;
> +	u32 curr_status;

Combine same type of variable on one line (if none of them or all of them
are initialised)

> +	unsigned char i;

For an iterator just use int. The compiler can choose to do cleverer things
with the storage if it likes.

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
> +	for (i = 0; i < aw96103->max_channels; i++) {
> +		if (!aw96103->channels_arr[i].used)
> +			continue;
> +
> +		curr_status = (((curr_status_val >> (24 + i)) & 0x1)) |
> +			      (((curr_status_val >> (16 + i)) & 0x1) << 1) |
> +			      (((curr_status_val >> (8 + i)) & 0x1) << 2) |
> +			      (((curr_status_val >> i) & 0x1) << 3);
> +		if (aw96103->channels_arr[i].old_irq_status == curr_status)
> +			continue;
> +
> +		switch (curr_status) {
> +		case FAR:
> +			iio_push_event(indio_dev,
> +				       IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY, i,
> +							    IIO_EV_TYPE_THRESH,
> +							    IIO_EV_DIR_RISING),
> +				       iio_get_time_ns(indio_dev));
> +			break;
> +		case TRIGGER_TH0:
> +		case TRIGGER_TH1:
> +		case TRIGGER_TH2:
> +		case TRIGGER_TH3:
> +			iio_push_event(indio_dev,
> +				       IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY, i,
> +							    IIO_EV_TYPE_THRESH,
> +							    IIO_EV_DIR_FALLING),
> +				       iio_get_time_ns(indio_dev));
> +			break;
> +		default:
> +			return;
> +		}
> +		aw96103->channels_arr[i].old_irq_status = curr_status;
> +	}
> +}
> +
> +static irqreturn_t aw96103_irq(int irq, void *data)
> +{
> +	struct iio_dev *indio_dev = data;
> +	struct aw96103 *aw96103 = iio_priv(indio_dev);
> +	unsigned int irq_status;
> +	int ret;
> +
> +	ret = regmap_read(aw96103->regmap, AW96103_REG_IRQSRC, &irq_status);
> +	if (ret)
> +		return IRQ_HANDLED;
> +
> +	aw96103_irq_handle(indio_dev);

Separating out the details of the irq handle from this function doesn't
seem to add much. I'd pull the code in this function down here.

> +
> +	return IRQ_HANDLED;
> +}

> +
> +static int aw96103_wait_chip_init(struct aw96103 *aw96103)
> +{
> +	unsigned int cnt = 20;
> +	u32 reg_data;
> +	int ret;
> +
> +	while (cnt--) {
> +		/*
> +		 * The device should generate an initialization completion
> +		 * interrupt within 20ms.
> +		 */
> +		ret = regmap_read(aw96103->regmap, AW96103_REG_IRQSRC,
> +				  &reg_data);
> +		if (ret)
> +			return ret;
> +
> +		if (FIELD_GET(AW96103_INITOVERIRQ_MASK, reg_data))
> +			return 0;
> +		mdelay(1);

fsleep(1000); seems more appropriate here.  I don't think it
matters if it sleeps for a while before trying again.

> +	}
> +
> +	return -EINVAL;
-ETIMEDOUT probably more appropriate
> +}
> +
> +static int aw96103_read_chipid(struct aw96103 *aw96103)
> +{
> +	unsigned char cnt = 0;
> +	u32 reg_val = 0;
> +	int ret;
> +
> +	while (cnt < 3) {
> +		/*
> +		 * This retry mechanism and the subsequent delay are just
> +		 * attempts to read the chip ID as much as possible,
> +		 * preventing occasional communication failures from causing
> +		 * the chip ID read to fail.
> +		 */
> +		ret = regmap_read(aw96103->regmap, AW96103_REG_CHIPID,
> +				  &reg_val);
> +		if (ret < 0) {
> +			cnt++;
> +			usleep_range(2000, 3000);

For these sorts of cases we have fsleep(2000);
Keeps the amount of 'slack' allowed in the sleeping standard across
drivers and avoids need for reviewers to think about appropriate ranges
for the different sleep functions.

It's not yet used in drivers as I think it's relatively new.
I got reminded of this by Andy's review of another series.


> +			continue;
> +		}
> +		break;
> +	}
> +	if (cnt == 3)
> +		return -ETIMEDOUT;
> +
> +	if (FIELD_GET(AW96103_CHIPID_MASK, reg_val) != AW96103_CHIP_ID)
> +		dev_info(aw96103->dev,
> +			 "unexpected chipid, id=0x%08X\n", reg_val);
> +
> +	return 0;
> +}
> +
> +static int aw96103_i2c_probe(struct i2c_client *i2c)
> +{
> +	struct iio_dev *aw_iio_dev;
> +	struct aw96103 *aw96103;
> +	int ret;
> +
> +	aw_iio_dev = devm_iio_device_alloc(&i2c->dev, sizeof(*aw96103));

Better to stick to more common naming of indio_dev, or iio_dev
This threw me a bit further down.

> +	if (!aw_iio_dev)
> +		return -ENOMEM;
> +
> +	aw96103 = iio_priv(aw_iio_dev);
> +	aw96103->dev = &i2c->dev;
> +	aw96103->chip_info = i2c_get_match_data(i2c);
> +	aw96103->max_channels = aw96103->chip_info->num_channels;
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
> +	ret = request_firmware_nowait(THIS_MODULE, true, "aw96103_0.bin",
> +				      aw96103->dev, GFP_KERNEL, aw96103,
> +				      aw96103_cfg_update);
> +	if (ret)
> +		return ret;
> +
> +	ret = aw96103_interrupt_init(aw_iio_dev, i2c);
> +	if (ret)
> +		return ret;

Trivial: blank line here to separate the previous block from
the next one.

> +	aw_iio_dev->modes = INDIO_DIRECT_MODE;
> +	aw_iio_dev->num_channels = aw96103->chip_info->num_channels;
> +	aw_iio_dev->channels = aw96103->chip_info->channels;
> +	aw_iio_dev->info = &iio_info;
> +	aw_iio_dev->name = aw96103->chip_info->name;
> +	aw_iio_dev->dev.parent = aw96103->dev;

No need to do this. The devm_iio_device_alloc() call did it for you
already.

> +
> +	return devm_iio_device_register(aw96103->dev, aw_iio_dev);
> +}


