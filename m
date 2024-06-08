Return-Path: <linux-iio+bounces-6069-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E719012ED
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2024 19:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34B471C20EBA
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2024 17:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111F117A939;
	Sat,  8 Jun 2024 17:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WC1wwfHB"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2E0178385;
	Sat,  8 Jun 2024 17:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717866820; cv=none; b=jbDnoL1IaY0Q3PsbkssONSBShi10u26WO6v1VtvdyMDxbcL92UE3hDP77GChaqGV5BKyH4tFBT6FzsATJTyB4Nz1yHjPFLafLpVmlt+ziCeaeLLV3Fti7WhV9r0FAfyK5gsV3V4BQBvJWTB0CuWWNc9hYJNGXrQ4yk/fcIObKoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717866820; c=relaxed/simple;
	bh=oyk08jJTd4P/lbAfjl+F1fIWUwXEKAgCFOZ0/O924I0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aYk6bmX4HSb2eyVjNbH9iYGST7ey9MxOrB7HtehQ8mmKIahv0W6v5u34HlfJJqzQGVTsqql7LRddyyH4V+VHRv1kPkVUne0LmVBTsGS4uexN+HryxNP7pdwf5p/hhUnKquJcYDSYnDaacvQWB6V/F5jR3DscYw0YEFCWtkQktRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WC1wwfHB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB5D6C2BD11;
	Sat,  8 Jun 2024 17:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717866820;
	bh=oyk08jJTd4P/lbAfjl+F1fIWUwXEKAgCFOZ0/O924I0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WC1wwfHB2CHpCX5NQJvmUFlwHygoApizYbjjqp+su9AbTlfbf6FkpPHAqh5TmEuai
	 6g5nuYRmhlyrTqFDcsBeY+TuvDHA292aJQ5r9WA5xmq//bFgshEiytvYqQxZijOMgJ
	 AqWOYCjNreXH1OOs4nml5elqNJY8/WC/Y2L5b/2FGV4HcgRJwWTxmBms83+rLCYduV
	 H/qAm2sx2P3G/C7A+GR14Hg6B0jYJkR9lQkb7mDQdHTfrSHqx84+D7w/c+DXcon2bV
	 OEDqdGSJ3/fSkL2C39GEuwFOv0EUCpCIk8RMY6K0N1W354AMC/99kpZHHLFUURmmz5
	 eqEuN+nyunOLQ==
Date: Sat, 8 Jun 2024 18:13:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Yasin Lee <yasin.lee.x@outlook.com>
Cc: andy.shevchenko@gmail.com, lars@metafoo.de, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, nuno.a@analog.com, swboyd@chromium.org,
 u.kleine-koenig@pengutronix.de, yasin.lee.x@gmail.com
Subject: Re: [PATCH v4 2/2] iio:proximity:hx9023s: Add TYHX HX9023S sensor
 driver
Message-ID: <20240608181331.46cd4ae7@jic23-huawei>
In-Reply-To: <SN7PR12MB81017291E79E6B61A8DEC9A5A4FB2@SN7PR12MB8101.namprd12.prod.outlook.com>
References: <20240607114138.390272-1-yasin.lee.x@outlook.com>
	<SN7PR12MB81017291E79E6B61A8DEC9A5A4FB2@SN7PR12MB8101.namprd12.prod.outlook.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  7 Jun 2024 19:41:38 +0800
Yasin Lee <yasin.lee.x@outlook.com> wrote:

> From: Yasin Lee <yasin.lee.x@gmail.com>
> 
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
As Andy already did a detailed review, I only took a fairly quick look.
A few comments inline

Jonathan

> diff --git a/drivers/iio/proximity/hx9023s.c b/drivers/iio/proximity/hx9023s.c
> new file mode 100644
> index 000000000000..b4a583105e03
> --- /dev/null
> +++ b/drivers/iio/proximity/hx9023s.c
> @@ -0,0 +1,1162 @@

> +
> +static int hx9023s_data_lock(struct hx9023s_data *data, bool locked)
> +{
> +	int ret;
> +
> +	if (locked)
> +		ret = regmap_update_bits(data->regmap, HX9023S_DSP_CONFIG_CTRL1,
> +					HX9023S_DATA_LOCK_MASK, HX9023S_DATA_LOCK_MASK);
> +	else
> +		ret = regmap_update_bits(data->regmap, HX9023S_DSP_CONFIG_CTRL1, GENMASK(4, 3), 0);
Odd to write one bit and clear 2.  If really the case, add some documentation
comments.

> +
> +	return ret;
> +}
> +
> +static int hx9023s_ch_cfg(struct hx9023s_data *data)
> +{
> +	int ret;
> +	int i;
> +	u16 reg;
> +	u8 reg_list[HX9023S_CH_NUM * 2];
> +	u8 ch_pos[HX9023S_CH_NUM];
> +	u8 ch_neg[HX9023S_CH_NUM];
> +
> +	data->ch_data[0].cs_position = 0;
> +	data->ch_data[1].cs_position = 2;
> +	data->ch_data[2].cs_position = 4;
> +	data->ch_data[3].cs_position = 6;
> +	data->ch_data[4].cs_position = 8;
> +
> +	for (i = 0; i < HX9023S_CH_NUM; i++) {
> +		if (data->ch_data[i].channel_positive == 255)
> +			ch_pos[i] = 16;
> +		else
> +			ch_pos[i] = data->ch_data[data->ch_data[i].channel_positive].cs_position;
> +		if (data->ch_data[i].channel_negative == 255)
> +			ch_neg[i] = 16;
> +		else
> +			ch_neg[i] = data->ch_data[data->ch_data[i].channel_negative].cs_position;
> +	}
> +
> +	for (i = 0; i < HX9023S_CH_NUM; i++) {
> +		reg = (u16)((0x03 << ch_pos[i]) | (0x02 << ch_neg[i]));
> +		reg_list[i * 2] = (u8)(reg);
> +		reg_list[i * 2 + 1] = (u8)(reg >> 8);

Looks like an odd form of endian manipulation. Try to set reg_list directly or use
an appropriate put_unaligned_*


> +	}
> +
> +	ret = regmap_bulk_write(data->regmap, HX9023S_CH0_CFG_7_0, reg_list, HX9023S_CH_NUM * 2);
> +
> +	return ret;
> +}
>
> +
> +static int hx9023s_ch_en(struct hx9023s_data *data, u8 ch_id, bool en)
> +{
> +	int ret;
> +	unsigned int buf;
> +
> +	ret = regmap_read(data->regmap, HX9023S_CH_NUM_CFG, &buf);
> +	if (ret)
> +		return ret;
> +
> +	data->ch_en_stat = buf;
> +
> +	if (en) {
> +		if (data->ch_en_stat == 0)
> +			data->prox_state_reg = 0;
> +		set_bit(ch_id, &data->ch_en_stat);
> +		ret = regmap_bulk_write(data->regmap, HX9023S_CH_NUM_CFG, &data->ch_en_stat, 1);
> +		if (ret)
> +			return ret;
> +		data->ch_data[ch_id].enable = true;
> +	} else {
> +		clear_bit(ch_id, &data->ch_en_stat);
> +		ret = regmap_bulk_write(data->regmap, HX9023S_CH_NUM_CFG, &data->ch_en_stat, 1);

regmap_write() it's length 1 so not bulk!
Make sure to fix all other cases of this.

>
...


> +
> +static int hx9023s_get_proximity(struct hx9023s_data *data,
> +				const struct iio_chan_spec *chan,
> +				int *val)
> +{
> +	hx9023s_sample(data);
handle errors and return them to userspace.

> +	hx9023s_get_prox_state(data);
handle errors etc.

> +	*val = data->ch_data[chan->channel].diff;
> +	return IIO_VAL_INT;
> +}
> +
>
> +
> +static int hx9023s_set_samp_freq(struct hx9023s_data *data, int val, int val2)
> +{
> +	int i;
> +	int ret;
> +	int period_ms;
> +	struct device *dev = regmap_get_device(data->regmap);
> +
> +	period_ms = div_u64(1000000000ULL, (val * 1000000ULL + val2));
> +
> +	for (i = 0; i < ARRAY_SIZE(hx9023s_samp_freq_table); i++) {
> +		if (period_ms == hx9023s_samp_freq_table[i])
> +			break;
> +	}
> +	if (i == ARRAY_SIZE(hx9023s_samp_freq_table)) {
> +		dev_err(dev, "Period:%dms NOT found!\n", period_ms);
> +		return -EINVAL;
> +	}
> +
> +	ret = regmap_bulk_write(data->regmap, HX9023S_PRF_CFG, &i, 1);
> +
> +	return ret;
return regmap_bulk_write()

> +}


> +static int hx9023s_set_trigger_state(struct iio_trigger *trig, bool state)
> +{
> +	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
> +	struct hx9023s_data *data = iio_priv(indio_dev);
> +
> +	guard(mutex)(&data->mutex);
> +	if (state)
> +		hx9023s_interrupt_enable(data);
> +	else if (!data->chan_read)
> +		hx9023s_interrupt_disable(data);
> +	data->trigger_enabled = state;

Ah. So you store this but you also need to use it in resume
along with checking if events are enabled or not.

> +
> +	return 0;
> +}
> +
> +static const struct iio_trigger_ops hx9023s_trigger_ops = {
> +	.set_trigger_state = hx9023s_set_trigger_state,
> +};
> +
> +static irqreturn_t hx9023s_trigger_handler(int irq, void *private)
> +{
> +	struct iio_poll_func *pf = private;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct hx9023s_data *data = iio_priv(indio_dev);
> +	int bit;
> +	int i;
> +
> +	guard(mutex)(&data->mutex);
> +	hx9023s_sample(data);
> +	hx9023s_get_prox_state(data);
No error handling?  If these failed we don't want to provide bad data to
userspace.  Normally we just skip on to iio_trigger_notify_done()
with a warning print to indicate something went wrong.

> +
> +	for_each_set_bit(bit, indio_dev->active_scan_mask, indio_dev->masklength)
> +		data->buffer.channels[i++] =
> +			cpu_to_be16(data->ch_data[indio_dev->channels[bit].channel].diff);

In IIO, for the buffered interface, we general prefer to leave data in the endian
ordering we get from the bus and describe that to userspace.  The basic
philosophy is that userspace has better knowledge on what it is doing with the data
so we provide it the information to process it rather than doing the work in kernel.

> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, &data->buffer, pf->timestamp);
> +
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}
> 
> +
> +static const struct iio_buffer_setup_ops hx9023s_buffer_setup_ops = {
> +	.preenable = hx9023s_buffer_preenable,
> +	.postdisable = hx9023s_buffer_postdisable,
> +};
> +
> +static int hx9023s_probe(struct i2c_client *client)
> +{
> +	int ret;
> +	unsigned int id;
> +	struct device *dev = &client->dev;
> +	struct iio_dev *indio_dev;
> +	struct hx9023s_data *data;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(struct hx9023s_data));
> +	if (!indio_dev)
> +		return dev_err_probe(dev, -ENOMEM, "device alloc failed\n");
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
> +	fsleep(1000);

If possible, add a specification reference for why that time.
If not add a comment saying that it has been found to work by experimentation.
That can be useful information if it turns out to be a bit short for someone else.

> +
> +	ret = regmap_read(data->regmap, HX9023S_DEVICE_ID, &id);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "id check failed\n");

Having read the ID, normally we'd compare it with expected and print a
warning if it doesn't match, then carry on anyway (to allow for fallback compatibles
being used for future devices that are backwards compatible for this one but
have a different ID).

> +
> +	indio_dev->channels = hx9023s_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(hx9023s_channels);
> +	indio_dev->info = &hx9023s_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->name = "hx9023s";
> +	i2c_set_clientdata(client, indio_dev);
> +
> +	ret = hx9023s_reg_init(data);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "device init failed\n");
> +
> +	ret = hx9023s_ch_cfg(data);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "channel config failed\n");
> +
> +	ret = regcache_sync(data->regmap);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "regcache sync failed\n");
> +
> +	if (client->irq) {
> +		ret = devm_request_threaded_irq(dev, client->irq, hx9023s_irq_handler,
> +						hx9023s_irq_thread_handler, IRQF_ONESHOT,
> +						"hx9023s_event", indio_dev);
> +		if (ret)
> +			return dev_err_probe(dev, ret, "irq request failed\n");
> +
> +		data->trig = devm_iio_trigger_alloc(dev, "%s-dev%d", indio_dev->name,
> +						iio_device_id(indio_dev));
> +		if (!data->trig)
> +			return dev_err_probe(dev, -ENOMEM,
> +					"iio trigger alloc failed\n");
> +
> +		data->trig->ops = &hx9023s_trigger_ops;
> +		iio_trigger_set_drvdata(data->trig, indio_dev);
> +
> +		ret = devm_iio_trigger_register(dev, data->trig);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					"iio trigger register failed\n");
> +	}
> +
> +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, iio_pollfunc_store_time,
> +					hx9023s_trigger_handler, &hx9023s_buffer_setup_ops);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				"iio triggered buffer setup failed\n");
> +
> +	ret = devm_iio_device_register(dev, indio_dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "iio device register failed\n");
> +
> +	return 0;
> +}
> +
> +static int hx9023s_suspend(struct device *dev)
> +{
> +	struct hx9023s_data *data = iio_priv(dev_get_drvdata(dev));
> +
> +	hx9023s_interrupt_disable(data);

You call these even if the trigger isn't enabled.  The disable is fine, but
you then enable the interrupt on resume even if it wasn't previously enabled.
This needs some state tracking so you restore to previous state.

> +
> +	return 0;
> +}
> +
> +static int hx9023s_resume(struct device *dev)
> +{
> +	struct hx9023s_data *data = iio_priv(dev_get_drvdata(dev));
> +
> +	hx9023s_interrupt_enable(data);
> +
> +	return 0;
> +}
> +
> +static DEFINE_SIMPLE_DEV_PM_OPS(hx9023s_pm_ops, hx9023s_suspend, hx9023s_resume);
> +
> +static const struct acpi_device_id hx9023s_acpi_match[] = {
> +	{ "TYHX9023" },
> +	{}

As Andy mentioned, drop this or add a comment on what device uses it.

> +};
> +MODULE_DEVICE_TABLE(acpi, hx9023s_acpi_match);
> +
> +static const struct of_device_id hx9023s_of_match[] = {
> +	{ .compatible = "tyhx,hx9023s" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, hx9023s_of_match);
> +
> +static const struct i2c_device_id hx9023s_id[] = {
> +	{ "hx9023s" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, hx9023s_id);
> +
> +static struct i2c_driver hx9023s_driver = {
> +	.driver = {
> +		.name = "hx9023s",
> +		.acpi_match_table = hx9023s_acpi_match,
> +		.of_match_table = hx9023s_of_match,
> +		.pm = &hx9023s_pm_ops,
> +
> +		/*
> +		 * The I2C operations in hx9023s_reg_init() and hx9023s_ch_cfg()
> +		 * are time-consuming. prefer async so we don't delay boot
Prefer (capital P as new sentence)

> +		 * if we're builtin to the kernel.
> +		 */
> +		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
> +	},
> +	.probe = hx9023s_probe,
> +	.id_table = hx9023s_id,
> +};
> +module_i2c_driver(hx9023s_driver);
> +
> +MODULE_AUTHOR("Yasin Lee <yasin.lee.x@gmail.com>");
> +MODULE_DESCRIPTION("Driver for TYHX HX9023S SAR sensor");
> +MODULE_LICENSE("GPL");


