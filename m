Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D66E410C61
	for <lists+linux-iio@lfdr.de>; Sun, 19 Sep 2021 18:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233853AbhISQj0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 19 Sep 2021 12:39:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:43498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233840AbhISQjY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 19 Sep 2021 12:39:24 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92D2161041;
        Sun, 19 Sep 2021 16:37:56 +0000 (UTC)
Date:   Sun, 19 Sep 2021 17:41:36 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Roan van Dijk <roan@protonic.nl>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, david@protonic.nl,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 3/4] drivers: iio: chemical: Add support for
 Sensirion SCD4x CO2 sensor
Message-ID: <20210919174136.600139aa@jic23-huawei>
In-Reply-To: <20210913080020.1265027-4-roan@protonic.nl>
References: <20210913080020.1265027-1-roan@protonic.nl>
        <20210913080020.1265027-4-roan@protonic.nl>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 13 Sep 2021 10:00:19 +0200
Roan van Dijk <roan@protonic.nl> wrote:

> This is a driver for the SCD4x CO2 sensor from Sensirion. The sensor is
> able to measure CO2 concentration, temperature and relative humdity.
> The sensor uses a photoacoustic principle for measuring CO2 concentration.
> An I2C interface is supported by this driver in order to communicate with
> the sensor.
> 
> Reviewed-by: Jonathan Cameron <jic23@kernel.org>
A small process thing.

Don't add a tag from someone else.  They must explicitly give the tag
on a version of the series.  Given I sign off on IIO patches, I never
give a reviewed-by for anything that will go through the IIO tree
(making this easy to spot :)

In the past there have been discussions about whether it's acceptable
for maintainers taking a patch to add reviewed-by tags to reflect the
review work done. General consensus now is that it is not acceptable and
if anyone wishes to do this they must confirm with the person before doing
so.


> Signed-off-by: Roan van Dijk <roan@protonic.nl>

I took another look at this (was hoping I could just fix anything trivial
and apply) but I think there is just enough to be worth asking you to do a v3
to tidy up a last few corners.  In particular I'm not sure what the right
approach to take for calibbias scaling is.

Thanks,

Jonathan

> ---
>  drivers/iio/chemical/Kconfig  |  13 +
>  drivers/iio/chemical/Makefile |   1 +
>  drivers/iio/chemical/scd4x.c  | 682 ++++++++++++++++++++++++++++++++++
>  3 files changed, 696 insertions(+)
>  create mode 100644 drivers/iio/chemical/scd4x.c
...
> +static int scd4x_read(struct scd4x_state *state, enum scd4x_cmd cmd,
> +			void *response, int byte_cnt)

As for the equivalent write_and_fetch, change the parameter to
reflect the size of response and scale it to the byte_cnt inside
this function.  That is a complexity we want to keep hidden from
as much of the driver as possible.

> +{
> +	struct i2c_client *client = state->client;
> +	char buf[SCD4X_READ_BUF_SIZE];
> +	char *rsp = response;
> +	int i, ret;
> +	char crc;
> +
> +	/*
> +	 * Measurement needs to be stopped before sending commands.
> +	 * Except for reading measurement and data ready command.
> +	 */
> +	if ((cmd != CMD_GET_DATA_READY) && (cmd != CMD_READ_MEAS)) {
> +		ret = scd4x_send_command(state, CMD_STOP_MEAS);
> +		if (ret)
> +			return ret;
> +
> +		/* execution time for stopping measurement */
> +		msleep_interruptible(500);
> +	}
> +
> +	put_unaligned_be16(cmd, buf);
> +	ret = scd4x_i2c_xfer(state, buf, 2, buf, byte_cnt);
> +	if (ret)
> +		return ret;
> +
> +	for (i = 0; i < byte_cnt; i += 3) {
> +		crc = crc8(scd4x_crc8_table, buf + i, 2, CRC8_INIT_VALUE);
> +		if (crc != buf[i + 2]) {
> +			dev_err(&client->dev, "CRC error\n");
> +			return -EIO;
> +		}
> +
> +		*rsp++ = buf[i];
> +		*rsp++ = buf[i + 1];
> +	}
> +
> +	/* start measurement */
> +	if ((cmd != CMD_GET_DATA_READY) && (cmd != CMD_READ_MEAS)) {
> +		ret = scd4x_send_command(state, CMD_START_MEAS);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int scd4x_write(struct scd4x_state *state, enum scd4x_cmd cmd, uint16_t arg)
> +{
> +	char buf[SCD4X_WRITE_BUF_SIZE];
> +	int ret;
> +	char crc;
> +
> +	put_unaligned_be16(cmd, buf);
> +	put_unaligned_be16(arg, buf + 2);
> +
> +	crc = crc8(scd4x_crc8_table, buf + 2, 2, CRC8_INIT_VALUE);
> +	buf[4] = crc;
> +
> +	/* measurement needs to be stopped before sending commands */
> +	ret = scd4x_send_command(state, CMD_STOP_MEAS);
> +	if (ret)
> +		return ret;
> +
> +	/* execution time */
> +	msleep_interruptible(500);
> +
> +	ret = scd4x_i2c_xfer(state, buf, SCD4X_WRITE_BUF_SIZE, buf, 0);
> +	if (ret)
> +		return ret;
> +
> +	/* start measurement, except for forced calibration command */
> +	if (cmd != CMD_FRC) {
> +		ret = scd4x_send_command(state, CMD_START_MEAS);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int scd4x_write_and_fetch(struct scd4x_state *state, enum scd4x_cmd cmd,
> +				uint16_t arg, void *response, int byte_cnt)
> +{
> +	struct i2c_client *client = state->client;
> +	char buf[SCD4X_READ_BUF_SIZE];
> +	char *rsp = response;
> +	int i, ret;
> +	char crc;
> +
> +	ret = scd4x_write(state, CMD_FRC, arg);
> +	if (ret)
> +		goto err;
> +
> +	/* Execution time */
> +	msleep_interruptible(400);
> +
> +	ret = i2c_master_recv(client, buf, byte_cnt);
> +	if (ret < 0)
> +		goto err;
> +	if (ret != byte_cnt) {
> +		ret = -EIO;
> +		goto err;
> +	}
> +
> +	for (i = 0; i < byte_cnt; i += 3) {

Given the relationship between the size of the response buffer and the
actual bytes sent is simply (I think) 3/2* sizeof(response),
I would pass instead int response_sz so that at the callers you can use
a sizeof() call to get that value correct rather that just having it
as a fairly random seeming parameter.

> +		crc = crc8(scd4x_crc8_table, buf + i, 2, CRC8_INIT_VALUE);
> +		if (crc != buf[i + 2]) {
> +			dev_err(&client->dev, "CRC error\n");
> +			ret = -EIO;
> +			goto err;
> +		}
> +
> +		*rsp++ = buf[i];
> +		*rsp++ = buf[i + 1];
> +	}
> +
> +	return scd4x_send_command(state, CMD_START_MEAS);
> +
> +err:
> +	/*
> +	 * on error try to start the measurement,
> +	 * puts sensor back into continuous measurement
> +	 */
> +	scd4x_send_command(state, CMD_START_MEAS);
> +
> +	return ret;
> +}
> +
> +static int scd4x_read_meas(struct scd4x_state *state, uint16_t *meas)
> +{
> +	int i, ret;
> +	uint16_t buf[3];
> +
> +	ret = scd4x_read(state, CMD_READ_MEAS, buf, 9);

See above, this is sufficiently odd that I'd try to hide
the existence of the CRC bytes from anything outside of the
scd4x_read() function.

> +	if (ret)
> +		return ret;
> +
> +	for (i = 0; i < ARRAY_SIZE(buf); i++)
> +		meas[i] = be16_to_cpu(buf[i]);
> +
> +	return 0;
> +}
> +
> +static int scd4x_wait_meas_poll(struct scd4x_state *state)
> +{
> +	struct i2c_client *client = state->client;
> +	int tries = 6;
> +	int ret;
> +
> +	do {
> +		uint16_t val;
> +
> +		ret = scd4x_read(state, CMD_GET_DATA_READY, &val, 3);
> +		if (ret)
> +			return -EIO;
> +		val = be16_to_cpu(val);
> +
> +		/* new measurement available */
> +		if (val & 0x7FF)
> +			return 0;
> +
> +		msleep_interruptible(1000);
> +	} while (--tries);
> +
> +	/* try to start sensor on timeout */
> +	ret = scd4x_send_command(state, CMD_START_MEAS);
> +	if (ret)
> +		dev_err(&client->dev, "failed to start measurement: %d\n", ret);
> +
> +	return -ETIMEDOUT;
> +}
> +
> +static int scd4x_read_poll(struct scd4x_state *state, uint16_t *buf)
> +{
> +	int ret;
> +
> +	ret = scd4x_wait_meas_poll(state);
> +	if (ret)
> +		return ret;
> +
> +	return scd4x_read_meas(state, buf);
> +}
> +
> +static int scd4x_read_channel(struct scd4x_state *state, int chan)
> +{
> +	int ret;
> +	uint16_t buf[3];
> +
> +	ret = scd4x_read_poll(state, buf);
> +	if (ret)
> +		return ret;
> +
> +	return buf[chan];
> +}

Blank line here.  Please check for similar places.  These only make a small
difference to readability, but it's worth having.

> +static int scd4x_read_raw(struct iio_dev *indio_dev,
> +			struct iio_chan_spec const *chan, int *val,
> +			int *val2, long mask)
> +{
> +	struct scd4x_state *state = iio_priv(indio_dev);
> +	int ret;
> +	uint16_t tmp;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = iio_device_claim_direct_mode(indio_dev);
> +		if (ret)
> +			return ret;
> +
> +		mutex_lock(&state->lock);
> +		ret = scd4x_read_channel(state, chan->address);
> +		mutex_unlock(&state->lock);
> +
> +		iio_device_release_direct_mode(indio_dev);
> +		if (ret < 0)
> +			return ret;
> +
> +		*val = ret;
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		if (chan->type == IIO_TEMP) {
> +			*val = 175000;
> +			*val2 = 65536;
> +			return IIO_VAL_FRACTIONAL;
> +		} else if (chan->type == IIO_HUMIDITYRELATIVE) {
> +			*val = 100000;
> +			*val2 = 65536;
> +			return IIO_VAL_FRACTIONAL;

You could use IIO_VAL_FACTIONAL_LOG2;  However, as it's expressed this
way in the datasheet, I don't mind if you leave it as you have it now.

> +		}
> +		return -EINVAL;
> +	case IIO_CHAN_INFO_OFFSET:
> +		*val = -16852;
> +		*val2 = 114286;
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		mutex_lock(&state->lock);
> +		ret = scd4x_read(state, CMD_GET_TEMP_OFFSET, &tmp, 3);
> +		mutex_unlock(&state->lock);
> +		if (ret)
> +			return ret;
> +
> +		*val = 175000 * be16_to_cpu(tmp) / 65536;

Calibbias often applies to some random tuning DAC deep inside a device and that
sometimes has a value that isn't related the actual sensor reading any any sensible
fashion.  As such, we don't put any rules on what it's 'units' are.

Here, (I think) it's a digital offset applied to the raw ADC reading.  As such,
I would probably have chosen to keep it in those units (ADC) counts rather than
converting to milli degrees C. 

Do you have a strong reason to make the conversion as you have done?
If so, it might be worth adding a special case to the docs for this in sysfs-bus-iio
(there is one there already for the icm42600 which is similar to what you have
here in that the units expressed are real world ones).

> +
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int scd4x_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
> +				int val, int val2, long mask)
> +{
> +	struct scd4x_state *state = iio_priv(indio_dev);
> +	int ret = 0;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		val = val * 65536 / 175000;
> +
> +		mutex_lock(&state->lock);
> +		ret = scd4x_write(state, CMD_SET_TEMP_OFFSET, val);
> +		mutex_unlock(&state->lock);
> +
> +		return ret;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static ssize_t calibration_auto_enable_show(struct device *dev,
> +			struct device_attribute *attr, char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct scd4x_state *state = iio_priv(indio_dev);
> +	int ret;
> +	uint16_t val;
> +
> +	mutex_lock(&state->lock);
> +	ret = scd4x_read(state, CMD_GET_ASC, &val, 3);
> +	mutex_unlock(&state->lock);
> +	if (ret) {
> +		dev_err(dev, "failed to read automatic calibration");
> +		return ret;
> +	}
> +
> +	val = be16_to_cpu(val) & SCD4X_READY_MASK;
Whilst is the same thing because SCD4X_READ_MASK == 0x1, this would become
more obviously correct if you forced the value to 0,1 here.

	val = (be16_to_cpu(val) & SCD4X_READY_MASK) ? 1 : 0;
> +
> +	return sprintf(buf, "%d\n", val);
> +}
> +
> +static ssize_t calibration_auto_enable_store(struct device *dev,
> +					struct device_attribute *attr,
> +					const char *buf, size_t len)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct scd4x_state *state = iio_priv(indio_dev);
> +	bool val;
> +	int ret;
> +	uint16_t value;
> +
> +	ret = kstrtobool(buf, &val);
> +	if (ret)
> +		return ret;
> +
> +	value = val;
> +
> +	mutex_lock(&state->lock);
> +	ret = scd4x_write(state, CMD_SET_ASC, value);
> +	mutex_unlock(&state->lock);
> +	if (ret)
> +		dev_err(dev, "failed to set automatic calibration");
> +
> +	return ret ?: len;
> +}
> +
> +static ssize_t calibration_forced_value_store(struct device *dev,
> +					struct device_attribute *attr,
> +					const char *buf, size_t len)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct scd4x_state *state = iio_priv(indio_dev);
> +	uint16_t val, arg;
> +	int ret;
> +
> +	ret = kstrtou16(buf, 0, &arg);
> +	if (ret)
> +		return ret;
> +
> +	if (arg < SCD4X_FRC_MIN_PPM || arg > SCD4X_FRC_MAX_PPM)
> +		return -EINVAL;

Ideally add an _available attribute to provide the range as

[FRC_MIN_PPM 1 SCD4X_FRC_MAX_PPM]
the _available attribute will also need documentation.

> +
> +	mutex_lock(&state->lock);
> +	ret = scd4x_write_and_fetch(state, CMD_FRC, arg, &val, 3);
> +	mutex_unlock(&state->lock);
> +
> +	if (val == 0xff) {
> +		dev_err(dev, "forced calibration has failed");
> +		return -EINVAL;
> +	}
> +
> +	return ret ?: len;
> +}
> +
> +static IIO_DEVICE_ATTR_RW(calibration_auto_enable, 0);
> +static IIO_DEVICE_ATTR_WO(calibration_forced_value, 0);
> +
> +static struct attribute *scd4x_attrs[] = {
> +	&iio_dev_attr_calibration_auto_enable.dev_attr.attr,
> +	&iio_dev_attr_calibration_forced_value.dev_attr.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group scd4x_attr_group = {
> +	.attrs = scd4x_attrs,
> +};

Looks a bit odd without a blank line here.

> +static const struct iio_info scd4x_info = {
> +	.attrs = &scd4x_attr_group,
> +	.read_raw = scd4x_read_raw,
> +	.write_raw = scd4x_write_raw,
> +};
> +
> +static const struct iio_chan_spec scd4x_channels[] = {
> +	{
> +		.type = IIO_CONCENTRATION,
> +		.channel2 = IIO_MOD_CO2,
> +		.modified = 1,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.address = SCD4X_CO2,
> +		.scan_index = SCD4X_CO2,
> +		.scan_type = {
> +			.sign = 'u',
> +			.realbits = 16,
> +			.storagebits = 16,
> +			.endianness = IIO_BE,
> +		},
> +	},
> +	{
> +		.type = IIO_TEMP,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +					BIT(IIO_CHAN_INFO_SCALE) |
> +					BIT(IIO_CHAN_INFO_OFFSET) |
> +					BIT(IIO_CHAN_INFO_CALIBBIAS),
> +		.address = SCD4X_TEMP,
> +		.scan_index = SCD4X_TEMP,
> +		.scan_type = {
> +			.sign = 'u',
> +			.realbits = 16,
> +			.storagebits = 16,
> +			.endianness = IIO_BE,
> +		},
> +	},
> +	{
> +		.type = IIO_HUMIDITYRELATIVE,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +					BIT(IIO_CHAN_INFO_SCALE),
> +		.address = SCD4X_HR,
> +		.scan_index = SCD4X_HR,
> +		.scan_type = {
> +			.sign = 'u',
> +			.realbits = 16,
> +			.storagebits = 16,
> +			.endianness = IIO_BE,
> +		},
> +	},
> +};

...

> +
> +static int scd4x_probe(struct i2c_client *client, const struct i2c_device_id *id)
> +{
> +	static const unsigned long scd4x_scan_masks[] = { 0x07, 0x00 };
> +	struct device *dev = &client->dev;
> +	struct iio_dev *indio_dev;
> +	struct scd4x_state *state;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*state));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	state = iio_priv(indio_dev);
> +	mutex_init(&state->lock);
> +	state->client = client;
> +	crc8_populate_msb(scd4x_crc8_table, SCD4X_CRC8_POLYNOMIAL);
> +
> +	indio_dev->info = &scd4x_info;
> +	indio_dev->name = client->name;
> +	indio_dev->channels = scd4x_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(scd4x_channels);
> +	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_TRIGGERED;

Not need to include BUFFER_TRIGGERED.  It is done inside
devm_iio_triggered_buffer_setup() as calling that function always means it should
be set.
 
> +	indio_dev->available_scan_masks = scd4x_scan_masks;
> +
> +	state->vdd = devm_regulator_get(dev, "vdd");
> +	if (IS_ERR(state->vdd))
> +		return dev_err_probe(dev, PTR_ERR(state->vdd), "failed to get regulator\n");
> +
> +	ret = regulator_enable(state->vdd);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_add_action_or_reset(dev, scd4x_disable_regulator, state);
> +	if (ret)
> +		return ret;
> +
> +	ret = scd4x_send_command(state, CMD_STOP_MEAS);
> +	if (ret) {
> +		dev_err(dev, "failed to stop measurement: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* execution time */
> +	msleep_interruptible(500);
> +
> +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL, scd4x_trigger_handler, NULL);
> +	if (ret)
> +		return ret;
> +
> +	ret = scd4x_send_command(state, CMD_START_MEAS);
> +	if (ret) {
> +		dev_err(dev, "failed to start measurement: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = devm_add_action_or_reset(dev, scd4x_stop_meas, state);
> +	if (ret)
> +		return ret;
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +
> +static const struct of_device_id scd4x_dt_ids[] = {
> +	{ .compatible = "sensirion,scd40" },
> +	{ .compatible = "sensirion,scd41" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, scd4x_dt_ids);
> +
> +static struct i2c_driver scd4x_i2c_driver = {
> +	.driver = {
> +		.name = KBUILD_MODNAME,
> +		.of_match_table = scd4x_dt_ids,
> +		.pm = &scd4x_pm_ops
> +	},
> +	.probe = scd4x_probe,
> +};
> +module_i2c_driver(scd4x_i2c_driver);
> +
> +MODULE_AUTHOR("Roan van Dijk <roan@protonic.nl>");
> +MODULE_DESCRIPTION("Sensirion SCD4X carbon dioxide sensor core driver");
> +MODULE_LICENSE("GPL v2");

