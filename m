Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20AC52F9252
	for <lists+linux-iio@lfdr.de>; Sun, 17 Jan 2021 13:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728867AbhAQMcv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 17 Jan 2021 07:32:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:42512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728852AbhAQMcf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 17 Jan 2021 07:32:35 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C65F92071C;
        Sun, 17 Jan 2021 12:31:52 +0000 (UTC)
Date:   Sun, 17 Jan 2021 12:31:49 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     <tomislav.denis@avl.com>
Cc:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] iio: adc: Add driver for Texas Instruments
 ADS131E0x ADC family
Message-ID: <20210117123149.13f0209b@archlinux>
In-Reply-To: <20210112095128.7112-2-tomislav.denis@avl.com>
References: <20210112095128.7112-1-tomislav.denis@avl.com>
 <20210112095128.7112-2-tomislav.denis@avl.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 12 Jan 2021 10:51:27 +0100
<tomislav.denis@avl.com> wrote:

> From: Tomislav Denis <tomislav.denis@avl.com>
> 
> The ADS131E0x are a family of multichannel, simultaneous sampling,
> 24-bit, delta-sigma, analog-to-digital converters (ADCs) with a
> built-in programmable gain amplifier (PGA), internal reference
> and an onboard oscillator.
> 
> Signed-off-by: Tomislav Denis <tomislav.denis@avl.com>
Hi Tomislav,

I previous failed to look in detail at how this driver will interact with
triggers that are not it's own data ready signal.  There are a few corners
around that which need fixing up.  You could just not allow that case, 
but it can be very handy to use an hrtimer trigger to do slow polling for
example and it's not that hard to enable.

Although I haven't done the necessary audit I suspect we have a few drivers
that don't get this right that got through review :(

A few other minor things below which I'd probably just have tidied up whilst
applying if not for the above.

...

> diff --git a/drivers/iio/adc/ti-ads131e08.c b/drivers/iio/adc/ti-ads131e08.c
> new file mode 100644
> index 0000000..dcd5d34
> --- /dev/null
> +++ b/drivers/iio/adc/ti-ads131e08.c
> @@ -0,0 +1,960 @@
...

> +
> +static int ads131e08_initial_config(struct iio_dev *indio_dev)
> +{
> +	struct ads131e08_state *st = iio_priv(indio_dev);
> +	const struct iio_chan_spec *channel = indio_dev->channels;
> +	int ret, i;
> +	u8 active_channels = 0;
> +
> +	ret = ads131e08_exec_cmd(st, ADS131E08_CMD_RESET);
> +	if (ret)
> +		return ret;
> +
> +	udelay(st->reset_delay_us);
> +
> +	/* Disable read data in continuous mode (enabled by default) */
> +	ret = ads131e08_exec_cmd(st, ADS131E08_CMD_SDATAC);
> +	if (ret)
> +		return ret;
> +
> +	ret = ads131e08_set_data_rate(st, ADS131E08_DEFAULT_DATA_RATE);
> +	if (ret)
> +		return ret;
> +
> +	ret = ads131e08_config_reference_voltage(st);
> +	if (ret)
> +		return ret;
> +
> +	for (i = 0;  i < indio_dev->num_channels; ++i) {
> +		ret = ads131e08_set_pga_gain(st, channel->channel,
> +			st->channel_config[i].pga_gain);
> +		if (ret)
> +			return ret;
> +
> +		ret = ads131e08_set_channel_mux(st, channel->channel,
> +			st->channel_config[i].mux);
> +		if (ret)
> +			return ret;
> +
> +		active_channels |= BIT(channel->channel);
> +		channel++;
> +	}
> +
> +	/* Power down unused channels */
> +	for (i = 0; i < st->info->max_channels; ++i) {
> +		if (!(active_channels & BIT(i))) {
> +			ret = ads131e08_power_down_channel(st, i, true);
> +			if (ret)
> +				return ret;
> +		}
> +	}
> +
> +	/* Request channel offset calibration */
> +	ret = ads131e08_exec_cmd(st, ADS131E08_CMD_OFFSETCAL);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Channel offset calibration is triggered with first START command.
> +	 * Since calibration take more time than settling operation,
> +	 * this causes timeout error when command START is sent first
> +	 * time (e.g. first call of the ads131e08_read_direct method).
> +	 * To avoid this problem offset calibration is triggered here.
> +	 */
> +	ret = ads131e08_exec_cmd(st, ADS131E08_CMD_START);
> +	if (ret)
> +		return ret;
> +
> +	msleep(ADS131E08_WAIT_OFFSETCAL_MS);
> +
> +	ret = ads131e08_exec_cmd(st, ADS131E08_CMD_STOP);
> +	if (ret)
> +		return ret;

trivial but nicer to just do

return ads131e...

> +
> +	return 0;
> +}
> +
> +static int ads131e08_read_direct(struct iio_dev *indio_dev,
> +	struct iio_chan_spec const *channel, int *value)
> +{
> +	struct ads131e08_state *st = iio_priv(indio_dev);
> +	int ret;
> +	u8 num_bits, *src;
> +
> +	reinit_completion(&st->completion);
> +
> +	ret = ads131e08_exec_cmd(st, ADS131E08_CMD_START);
> +	if (ret)
> +		return ret;
> +
> +	ret = wait_for_completion_timeout(&st->completion,
> +		msecs_to_jiffies(ADS131E08_MAX_SETTLING_TIME_MS));
> +	if (!ret)
> +		return -ETIMEDOUT;
> +
> +	ret = ads131e08_read_data(st, st->readback_len);
> +	if (ret)
> +		return ret;
> +
> +	ret = ads131e08_exec_cmd(st, ADS131E08_CMD_STOP);
> +	if (ret)
> +		return ret;
> +
> +	src = st->rx_buf + ADS131E08_NUM_STATUS_BYTES +
> +		channel->channel * ADS131E08_NUM_DATA_BYTES(st->data_rate);
> +
> +	num_bits = ADS131E08_NUM_DATA_BITS(st->data_rate);
> +	*value = sign_extend32(
> +		get_unaligned_be32(src) >> (32 - num_bits), num_bits - 1);
> +
> +	return ret;
> +}
> +

...

> +
> +static int ads131e08_set_trigger_state(struct iio_trigger *trig, bool state)
> +{
> +	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
> +	struct ads131e08_state *st = iio_priv(indio_dev);
> +	u8 cmd = state ? ADS131E08_CMD_START : ADS131E08_CMD_STOP;
> +
> +	return ads131e08_exec_cmd(st, cmd);
> +}
> +
> +static const struct iio_trigger_ops ads131e08_trigger_ops = {
> +	.set_trigger_state = &ads131e08_set_trigger_state,
.validate_device = &iio_trigger_validate_own_device,

(see below for why!)

> +};
> +
> +static irqreturn_t ads131e08_trigger_handler(int irq, void *private)
> +{
> +	struct iio_poll_func *pf = private;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct ads131e08_state *st = iio_priv(indio_dev);
> +	int ret;
> +	unsigned int chn, i = 0;
> +	u8 *src, *dest;
> +	/*
> +	 * The number of data bits per channel depends on the data rate.
> +	 * For 32 and 64 ksps data rates, number of data bits per channel
> +	 * is 16. This case is not compliant with used (fixed) scan element
> +	 * type (be:s24/32>>8). So we use a litle tweek to pack properly
> +	 * 16 bits of data into the buffer.
> +	 */
> +	unsigned int num_bytes = ADS131E08_NUM_DATA_BYTES(st->data_rate);
> +	u8 tweek_offset = num_bytes == 2 ? 1 : 0;
> +
> +	ret = ads131e08_read_data(st, st->readback_len);
> +	if (ret)
> +		goto out;
> +
> +	for_each_set_bit(chn, indio_dev->active_scan_mask,
> +		indio_dev->masklength) {
> +		src = st->rx_buf + ADS131E08_NUM_STATUS_BYTES + chn * num_bytes;
> +		dest = st->tmp_buf.data + i * ADS131E08_NUM_STORAGE_BYTES;
> +
> +		/*
> +		 * Tweek offset is 0:
> +		 * +---+---+---+---+
> +		 * |D0 |D1 |D2 | X | (3 data bytes)
> +		 * +---+---+---+---+
> +		 *  a+0 a+1 a+2 a+3
> +		 *
> +		 * Tweek offset is 1:
> +		 * +---+---+---+---+
> +		 * |P0 |D0 |D1 | X | (one padding byte and 2 data bytes)
> +		 * +---+---+---+---+
> +		 *  a+0 a+1 a+2 a+3
> +		 */
> +		memcpy(dest + tweek_offset, src, num_bytes);
> +
> +		/*
> +		 * Data conversion from 16 bits of data to 24 bits of data
> +		 * is done by sign etension (properly filling padding byte).
> +		 */
> +		if (tweek_offset)
> +			memset(dest, *src & BIT(7) ? 0xff : 0x00, 1);
> +
> +		i++;
> +	}
> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, st->tmp_buf.data,
> +		iio_get_time_ns(indio_dev));
> +
> +out:
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t ads131e08_interrupt(int irq, void *private)
> +{
> +	struct iio_dev *indio_dev = private;
> +	struct ads131e08_state *st = iio_priv(indio_dev);
> +
> +	if (iio_buffer_enabled(indio_dev))
> +		iio_trigger_poll(st->trig);

There is a corner case here we may want to close
I don't think you are currently ensuring that another device
isn't using this trigger.  In theory that could happen whilst this
device doesn't have it's buffer enabled.  This corner case is common
with devices that use the interrupt for polled reads.

If you add a validate_device() callback to the trigger it will stop
that happening. 

That will still let this device be used with other triggers (e.g. sysfs
or hrtimer) However, I think there is a problem there as well.

Currently you do the start for the device in the set_trigger_state() cb
and that won't be called if we are using another device.

So to enable the use of other triggers, you would need to check whether
the trigger in use is this one provided by this driver and if it isn't
you will need to so the extra steps to initialize a capture on demand
(same as read_raw more or less)

Look at iio_trigger_using_own() and the users of that function to see
how they handle this.


> +	else
> +		complete(&st->completion);
> +
> +	return IRQ_HANDLED;
> +}
> +

...


> +
> +static int ads131e08_probe(struct spi_device *spi)
> +{
> +	const struct ads131e08_info *info;
> +	struct iio_dev *indio_dev;
> +	struct ads131e08_state *st;
> +	int ret;
> +	unsigned long adc_clk_hz, adc_clk_ns;
> +
> +	info = of_device_get_match_data(&spi->dev);
> +	if (!info) {
> +		dev_err(&spi->dev, "failed to get match data\n");
> +		return -ENODEV;
> +	}
> +
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	if (!indio_dev) {
> +		dev_err(&spi->dev, "failed to allocate IIO device\n");
> +		return -ENOMEM;
> +	}
> +
> +	st = iio_priv(indio_dev);
> +	st->info = info;
> +	st->spi = spi;
> +
> +	ret = ads131e08_parse_dt(indio_dev, spi->dev.of_node);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->name = st->info->name;
> +	indio_dev->dev.parent = &spi->dev;
> +	indio_dev->dev.of_node = spi->dev.of_node;
> +	indio_dev->info = &ads131e08_iio_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	init_completion(&st->completion);
> +
> +	if (spi->irq) {
> +		ret = devm_request_irq(&spi->dev, spi->irq,
> +			ads131e08_interrupt,
> +			IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> +			spi->dev.driver->name, indio_dev);
> +		if (ret) {
> +			dev_err(&spi->dev, "failed to allocate IRQ\n");

Very small tweak here. dev_err_probe() so that we don't print a message
if the return value indicates that we are just deferring whilst waiting
for the irq chip driver to load.

> +			return ret;
> +		}
> +	} else {
> +		dev_err(&spi->dev, "data ready IRQ missing\n");
> +		return -ENODEV;
> +	}
> +
> +	st->trig = devm_iio_trigger_alloc(&spi->dev, "%s-dev%d",
> +		indio_dev->name, indio_dev->id);
> +	if (!st->trig) {
> +		dev_err(&spi->dev, "failed to allocate IIO trigger\n");
> +		return -ENOMEM;
> +	}
> +
> +	st->trig->ops = &ads131e08_trigger_ops;
> +	st->trig->dev.parent = &spi->dev;
> +	iio_trigger_set_drvdata(st->trig, indio_dev);
> +	ret = devm_iio_trigger_register(&spi->dev, st->trig);
> +	if (ret) {
> +		dev_err(&spi->dev, "failed to register IIO trigger\n");
> +		return -ENOMEM;
> +	}
> +
> +	indio_dev->trig = iio_trigger_get(st->trig);
> +
> +	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
> +		NULL, &ads131e08_trigger_handler, NULL);
> +	if (ret) {
> +		dev_err(&spi->dev, "failed to setup IIO buffer\n");
> +		return ret;
> +	}
> +
> +	st->vref_reg = devm_regulator_get_optional(&spi->dev, "vref");
> +	if (!IS_ERR(st->vref_reg)) {
> +		ret = regulator_enable(st->vref_reg);
> +		if (ret) {
> +			dev_err(&spi->dev,
> +				"failed to enable external vref supply\n");
> +			return ret;
> +		}
> +
> +		ret = devm_add_action_or_reset(&spi->dev,
> +			ads131e08_regulator_disable, st);
> +		if (ret) {
> +			regulator_disable(st->vref_reg);
> +			return ret;
> +		}
> +	} else {
> +		if (PTR_ERR(st->vref_reg) != -ENODEV)
> +			return PTR_ERR(st->vref_reg);
> +	}
> +
> +	st->adc_clk = devm_clk_get(&spi->dev, "adc-clk");
> +	if (IS_ERR(st->adc_clk)) {
> +		dev_err(&spi->dev, "failed to get the ADC clock\n");

Here again, dev_err_probe() to avoid the message in the -EPROBE_DEFER case.

> +		return PTR_ERR(st->adc_clk);
> +	}
> +
> +	ret = clk_prepare_enable(st->adc_clk);
> +	if (ret) {
> +		dev_err(&spi->dev, "failed to prepare/enable the ADC clock\n");
> +		return ret;
> +	}
> +
> +	ret = devm_add_action_or_reset(&spi->dev, ads131e08_clk_disable, st);
> +	if (ret) {
> +		clk_disable_unprepare(st->adc_clk);
> +		return ret;
> +	}
> +
> +	adc_clk_hz = clk_get_rate(st->adc_clk);
> +	if (!adc_clk_hz) {
> +		dev_err(&spi->dev, "failed to get the ADC clock rate\n");
> +		return  -EINVAL;
> +	}
> +
> +	adc_clk_ns = NSEC_PER_SEC / adc_clk_hz;
> +	st->sdecode_delay_us = DIV_ROUND_UP(
> +		ADS131E08_WAIT_SDECODE_CYCLES * adc_clk_ns, 1000);
> +	st->reset_delay_us = DIV_ROUND_UP(
> +		ADS131E08_WAIT_RESET_CYCLES * adc_clk_ns, 1000);
> +
> +	ret = ads131e08_initial_config(indio_dev);
> +	if (ret) {
> +		dev_err(&spi->dev, "initial configuration failed\n");
> +		return ret;
> +	}
> +
> +	ret = devm_iio_device_register(&spi->dev, indio_dev);
> +	if (ret) {
> +		dev_err(&spi->dev, "failed to register IIO device\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
...

