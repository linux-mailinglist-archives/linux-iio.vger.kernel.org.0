Return-Path: <linux-iio+bounces-7054-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F18091CE98
	for <lists+linux-iio@lfdr.de>; Sat, 29 Jun 2024 20:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0B2D282A9E
	for <lists+linux-iio@lfdr.de>; Sat, 29 Jun 2024 18:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5970B1353FE;
	Sat, 29 Jun 2024 18:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kuFBWLuS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A22C5660;
	Sat, 29 Jun 2024 18:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719686491; cv=none; b=axxExUFfnfHFPDElEsHt4lyVO6RNaEGrGQ67j2JQb0KigEGagLJZwk+dSFLuhoqoavHvpbhKd0ZvRWfjze3qccNUwgqE+lWvq25dkaSfqkPai46GupJgeM4fA7Fzv3vYXmSJ5SMP1mpYwPRfha61+DTHxW/+j5UI/Ph/gOIik2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719686491; c=relaxed/simple;
	bh=QvapwvFyxd9QiVdG4fzZ/mb3LdJr5rEx0NRw7tsH71c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bDriwlEzXWu9alPuryeng96pGbXYRBMNDZ3KVLNQ9rWxQU4oLJHR49OYQfOSGZEIiDD8S/iJtaDB8iA9QUStMcDwfcBUE/WWiePkNQF1AXuGLPEqPa38oqnEbdJuoIqOPpfJrsNTNY9oAuST149DswOWoLpasg+DmlgjczaQkNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kuFBWLuS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B0D7C2BBFC;
	Sat, 29 Jun 2024 18:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719686490;
	bh=QvapwvFyxd9QiVdG4fzZ/mb3LdJr5rEx0NRw7tsH71c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kuFBWLuS430W9X4VWy0EakCHmQOIllvLPYbCpAf3lJvcnI1gPTZKk8eI6smAWKOoj
	 0wBfRTOdfh0WiZL7oaSYIsyJnHZDdf99nJPdVc2H+An/nOVm2sZ72zlfNZ6K7FQ3Z+
	 KD2pt8eiYlnupUvaFjjyx5PgSbN0SauL+wxuhanKi8RSZjQzNAebdslQi7oLcTGO2Y
	 Mh755ua2nTPCoYB4xD131sGjVENSy04pf8uycWZR9PPu5GKyR3a3/4J6Dhu6JXuipS
	 OCdMorKiARZRJRMcTh8m4b77OI4EG7+afS8NVvvGVfc5OL5lVxHMb9l4uV2th/rxNU
	 nYZIOj87KI8CA==
Date: Sat, 29 Jun 2024 19:41:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Yasin Lee <yasin.lee.x@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 yasin.lee.x@outlook.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v8 3/3] iio: proximity: Add driver support for TYHX's
 HX9023S capacitive proximity sensor
Message-ID: <20240629194122.1f4b7b3b@jic23-huawei>
In-Reply-To: <20240625-add-tyhx-hx9023s-sensor-driver-v8-3-0c224e3bddbc@gmail.com>
References: <20240625-add-tyhx-hx9023s-sensor-driver-v8-0-0c224e3bddbc@gmail.com>
	<20240625-add-tyhx-hx9023s-sensor-driver-v8-3-0c224e3bddbc@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Jun 2024 23:58:54 +0800
Yasin Lee <yasin.lee.x@gmail.com> wrote:

> A SAR sensor from NanjingTianyihexin Electronics Ltd.
> 
> The device has the following entry points:
> 
> Usual frequency:
> - sampling_frequency
> 
> Instant reading of current values for different sensors:
> - in_proximity0_raw
> - in_proximity1_raw
> - in_proximity2_raw
> - in_proximity3_raw
> - in_proximity4_raw
> and associated events in events/
> 
> Signed-off-by: Yasin Lee <yasin.lee.x@gmail.com>
Hi Yasin

Definitely getting close to ready to merge.
A few bits of review feedback inline to resolve.

Jonathan

> diff --git a/drivers/iio/proximity/hx9023s.c b/drivers/iio/proximity/hx9023s.c
> new file mode 100644
> index 000000000000..c455f20d784f
> --- /dev/null
> +++ b/drivers/iio/proximity/hx9023s.c
> @@ -0,0 +1,1131 @@

> +
> +#define HX9023S_CHIP_ID 0x1D
> +#define HX9023S_CH_NUM 5
> +#define HX9023S_2BYTES 2
> +#define HX9023S_3BYTES 3

Don't use defines where the number is actually more meaningful
when seen in the code.

> +#define HX9023S_BYTES_MAX HX9023S_3BYTES
This define is useful but just make it 3.

> +struct hx9023s_ch_data {
> +	int raw; /* Raw Data*/
> +	int lp; /* Low Pass Filter Data*/
> +	int bl; /* Base Line Data */
> +	int diff; /* difference of Low Pass Data and Base Line Data */
Difference

for consistency of capitalizaton.


> +static int hx9023s_ch_cfg(struct hx9023s_data *data)
> +{
> +	unsigned int i;
> +	u16 reg;
> +	u8 reg_list[HX9023S_CH_NUM * 2];
> +	u8 ch_pos[HX9023S_CH_NUM];
> +	u8 ch_neg[HX9023S_CH_NUM];
> +	/* Bit positions corresponding to input pin connections */
> +	u8 conn_cs[HX9023S_CH_NUM] = {0, 2, 4, 6, 8};

Space after { and before }

> +
> +	for (i = 0; i < HX9023S_CH_NUM; i++) {
> +		ch_pos[i] = data->ch_data[i].channel_positive == HX9023S_NOT_CONNECTED ?
> +			HX9023S_NOT_CONNECTED : conn_cs[data->ch_data[i].channel_positive];
> +		ch_neg[i] = data->ch_data[i].channel_negative == HX9023S_NOT_CONNECTED ?
> +			HX9023S_NOT_CONNECTED : conn_cs[data->ch_data[i].channel_negative];
> +
> +		reg = (HX9023S_POS << ch_pos[i]) | (HX9023S_NEG << ch_neg[i]);
> +		put_unaligned_le16(reg, &reg_list[i * 2]);
> +	}
> +
> +	return regmap_bulk_write(data->regmap, HX9023S_CH0_CFG_7_0, reg_list, HX9023S_CH_NUM * 2);
> +}

> +
> +static int hx9023s_sample(struct hx9023s_data *data)
> +{
> +	int ret, value;
> +	unsigned int i;
> +	u8 data_size, offset_data_size, *p, size, rx_buf[HX9023S_CH_NUM * HX9023S_BYTES_MAX];

Long line combining different data types. Break them up to improve readability.

	u8 rx_buf[HX9023S_CH_NUM * HX9023S_BYTES_MAX];
	u8 data_size, offset_data_size, size;
	u8 *p;

> +
> +	ret = hx9023s_data_lock(data, true);
> +	if (ret)
> +		return ret;
> +
> +	ret = hx9023s_data_select(data);
> +	if (ret)
> +		goto err;
> +
> +	data_size = HX9023S_3BYTES;
This local variable hurts readabilty.
> +
> +	/* ch0~ch3 */
> +	p = rx_buf;
Why local variable?
> +	size = (HX9023S_CH_NUM - 1) * data_size;

This is non obvious sizing.  Here a comment is appropriate.

/* 3 bytes for each of channels 0 to 3 which have contiguous registers */

> +	ret = regmap_bulk_read(data->regmap, HX9023S_RAW_BL_CH0_0, p, size);

Combining above comments.

	ret = regmap_bulk_read(data->regmap, HX9023S_RAW_BL_CH0_0, &rx_buf, size);

> +	if (ret)
> +		goto err;
> +
> +	/* ch4 */
> +	p = rx_buf + size;
> +	size = data_size;
Here as well provide a comment on the fact the channel is 3 contiguous registers.


> +	ret = regmap_bulk_read(data->regmap, HX9023S_RAW_BL_CH4_0, p, size);
> +	if (ret)
> +		goto err;
> +
> +	for (i = 0; i < HX9023S_CH_NUM; i++) {
> +		value = get_unaligned_le16(&rx_buf[i * data_size + 1]);
This seems odd.  From the datasheet I found seems there are some bits in
the ch0_0 register as well. Why just pull out 16 bits?

I would use a get_unaligned_le24() call to get the rest and then rely on
shift for userspace to drop bits 3:0

It it makes sense to just provide the top 16 bits thats fine.
> +		value = sign_extend32(value, 15);

Why use int to store an s16?  If you just use an s16 for value then no
need to sign extend and then store that into an s16 .raw in the channel
data structure.

> +		data->ch_data[i].raw = 0;
> +		data->ch_data[i].bl = 0;
> +		if (data->ch_data[i].sel_raw)
> +			data->ch_data[i].raw = value;
> +		if (data->ch_data[i].sel_bl)
> +			data->ch_data[i].bl = value;
> +	}
> +
> +	/* ch0~ch3 */
> +	p = rx_buf;
> +	size = (HX9023S_CH_NUM - 1) * data_size;
As above - use a comment to explain why this is 12 then just use 12.
Current form is far form obvious.

> +	ret = regmap_bulk_read(data->regmap, HX9023S_LP_DIFF_CH0_0, p, size);
> +	if (ret)
> +		goto err;
> +
> +	/* ch4 */
> +	p = rx_buf + size;
> +	size = data_size;
> +	ret = regmap_bulk_read(data->regmap, HX9023S_LP_DIFF_CH4_0, p, size);
> +	if (ret)
> +		goto err;
> +
> +	for (i = 0; i < HX9023S_CH_NUM; i++) {
> +		value = get_unaligned_le16(&rx_buf[i * data_size + 1]);
> +		value = sign_extend32(value, 15);
> +		data->ch_data[i].lp = 0;
> +		data->ch_data[i].diff = 0;
> +		if (data->ch_data[i].sel_lp)
> +			data->ch_data[i].lp = value;
> +		if (data->ch_data[i].sel_diff)
> +			data->ch_data[i].diff = value;
> +	}
> +
> +	for (i = 0; i < HX9023S_CH_NUM; i++) {
> +		if (data->ch_data[i].sel_lp && data->ch_data[i].sel_bl)
> +			data->ch_data[i].diff = data->ch_data[i].lp - data->ch_data[i].bl;
> +	}
> +
> +	/* offset DAC */
> +	offset_data_size = HX9023S_2BYTES;
> +	p = rx_buf;
> +	size = HX9023S_CH_NUM * offset_data_size;
> +	ret = regmap_bulk_read(data->regmap, HX9023S_OFFSET_DAC0_7_0, p, size);
> +	if (ret)
> +		goto err;
> +
> +	for (i = 0; i < HX9023S_CH_NUM; i++) {
> +		value = get_unaligned_le16(&rx_buf[i * offset_data_size]);
> +		value = FIELD_GET(GENMASK(11, 0), value);
> +		data->ch_data[i].dac = value;
> +	}
> +
> +err:
> +	return hx9023s_data_lock(data, false);
> +}


> +
> +static int hx9023s_property_get(struct hx9023s_data *data)
> +{
> +	struct fwnode_handle *child;
> +	struct device *dev = regmap_get_device(data->regmap);
> +	int ret;
> +	u32 i, reg, temp, array[2];
> +
> +	data->chan_in_use = 0;
> +	for (i = 0; i < HX9023S_CH_NUM; i++) {
> +		data->ch_data[i].channel_positive = HX9023S_NOT_CONNECTED;
> +		data->ch_data[i].channel_negative = HX9023S_NOT_CONNECTED;
> +	}
> +
> +	device_for_each_child_node(dev, child) {

Use
	device_for_each_child_node_scoped(dev, child) {
As then no need to call fwnode_handle_put() in error paths.

> +		ret = fwnode_property_read_u32(child, "reg", &reg);
> +		if (ret || reg >= HX9023S_CH_NUM) {
> +			fwnode_handle_put(child);
> +			return dev_err_probe(dev, ret, "Failed to read reg\n");
> +		}
> +		__set_bit(reg, &data->chan_in_use);
> +
> +		if (fwnode_property_read_u32(child, "input-channel", &temp) == 0) {
> +			data->ch_data[reg].channel_positive = temp;
> +			data->ch_data[reg].channel_negative = HX9023S_NOT_CONNECTED;
> +		} else if (fwnode_property_read_u32_array(child, "diff-channels",
> +							array, sizeof(array)) == 0) {
> +			data->ch_data[reg].channel_positive = array[0];
> +			data->ch_data[reg].channel_negative = array[1];
> +		} else {
> +			fwnode_handle_put(child);
> +			return dev_err_probe(dev, ret,
> +				"Failed to read channel input for channel %d\n", reg);
> +		}
> +	}
> +
> +	return 0;
> +}


> +
> +static void hx9023s_push_events(struct iio_dev *indio_dev)
> +{
> +	struct hx9023s_data *data = iio_priv(indio_dev);
> +	s64 timestamp = iio_get_time_ns(indio_dev);
> +	unsigned long prox_changed;
> +	unsigned int chan;
> +
> +	hx9023s_sample(data);

check the return codes for these calls that involve bus transactions.
If they fail, just return form this function having not pushed an event.

Otherwise we may push stale data.

> +	hx9023s_get_prox_state(data);
> +
> +	prox_changed = (data->chan_prox_stat ^ data->prox_state_reg) & data->chan_event;
> +	for_each_set_bit(chan, &prox_changed, HX9023S_CH_NUM) {
> +		unsigned int dir;
> +
> +		dir = (data->prox_state_reg & BIT(chan)) ? IIO_EV_DIR_FALLING : IIO_EV_DIR_RISING;
> +
> +		iio_push_event(indio_dev,
> +			       IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY, chan, IIO_EV_TYPE_THRESH, dir),
> +			       timestamp);
> +	}
> +	data->chan_prox_stat = data->prox_state_reg;
> +}






> +static int hx9023s_id_check(struct iio_dev *indio_dev)
> +{
> +	struct hx9023s_data *data = iio_priv(indio_dev);
> +	int ret;
> +	unsigned int id;
> +
> +	ret = regmap_read(data->regmap, HX9023S_DEVICE_ID, &id);
> +	if (ret || id != HX9023S_CHIP_ID)
> +		return -ENODEV;
This breaks the use of callback compatible IDs in future. It is only
appropriate to print a warning on an unknown ID .
Also don't eat the error value returned - it may provide a useful hint
of a problem.

	if (ret)
		return ret;

	if (id != HX9023S_CHIP_ID)
		dev_warn(&indio_dev->dev.parent,
			 "Unexpected chip ID, assuming compatible\n");

	return 0;

there are lots of older drivers where we did this wrong. We tend to
repair this when otherwise working on a driver, so it will take a
while before they are all fixed.


> +
> +	return 0;
> +}
> +
> +static int hx9023s_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct iio_dev *indio_dev;
> +	struct hx9023s_data *data;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(struct hx9023s_data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	mutex_init(&data->mutex);
> +
> +	data->regmap = devm_regmap_init_i2c(client, &hx9023s_regmap_config);
> +	if (IS_ERR(data->regmap))
> +		return dev_err_probe(dev, PTR_ERR(data->regmap), "regmap init failed\n");
> +
> +	ret = hx9023s_property_get(data);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "dts phase failed\n");
> +
> +	ret = devm_regulator_get_enable(dev, "vdd");
> +	if (ret)
> +		return dev_err_probe(dev, ret, "regulator get failed\n");
> +
> +	ret = hx9023s_id_check(indio_dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "id check failed\n");

As commented on above, this should not fail on a missmatch ont he ID, just
on a failure to read it at all.  That enables future devices that haven't
been made yet and happen to be compatible to be able to work with older
linux kernels that predate them.


> +}


