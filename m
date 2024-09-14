Return-Path: <linux-iio+bounces-9584-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A758997923F
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 19:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBE6A1C214F6
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 17:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0BA1D0DDC;
	Sat, 14 Sep 2024 17:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c0tU4ifW"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718F6208DA;
	Sat, 14 Sep 2024 17:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726333619; cv=none; b=V8RcDyYVAQhfWe2d23lbpc7BzMvKNXEpsV6cmsjxvNgXkHfaTAgp5SuwPF4pci2ZSW9QTB7LhQHjaoMKCUCgeKfPJuqOnaCnJhxRcMeR/UY9IsTqWiUSxIoT7UD6Sfry5FIU0zP470oUf51D+9rekO5PwtCQJHJKc+4f8Najz8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726333619; c=relaxed/simple;
	bh=Hc328JVFbmZz+imPdU0ZX1xC9jylhpvtV+oaxa8mRLw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eoafTLvaFlsghpPII4nX0rMUsCVKVmK8kOxccTBYgIkziZD9jCEMfyX1fysWlI46HLQQVJgMXt3GWNnHtPp8M1+l7ssavkdvBI+jj1qmtCua2+libt24/nEduzsOSDSkF+RxTdY6eAUAaYdLWvztKW/Rbs7npOMmEXECmUUyjD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c0tU4ifW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EA78C4CEC0;
	Sat, 14 Sep 2024 17:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726333619;
	bh=Hc328JVFbmZz+imPdU0ZX1xC9jylhpvtV+oaxa8mRLw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=c0tU4ifW5PomF3ZO3nf5H9wJkgggx2GjQ7FdFnKkI5H8p4Wc7mSz9eCknG3PCFBAD
	 xoxRtRLV6IvWVHaa9MigveIphZhVX0vRcMqj5z4ZDUZi1yY6R7+9qylLUsGEa4TFUo
	 Iuv52q2j63ejLdVqdhXyXfuXpIwPmquF7EGftyk49fLhkwiXB1zuuP4oachjtO4TMn
	 EBNecDtQtnnq0Uc2F9HC3irtm/E2zSjepinWA0n+mT8E+1UulQR5bFdjy6+Y6p1Jt5
	 vsZXZO35sC1hXpmcn46lMALKopUp/ZoIWUwy70+vKA62YSoyytBHV4D4Ghf5Z6UaBS
	 LgC16mpV6Xn8A==
Date: Sat, 14 Sep 2024 18:06:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Ramona Alexandra Nechita <ramona.nechita@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Cosmin Tanislav
 <cosmin.tanislav@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nuno
 Sa <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Olivier Moysan <olivier.moysan@foss.st.com>, Dumitru Ceclan
 <mitrutzceclan@gmail.com>, Matteo Martelli <matteomartelli3@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Alisa-Dariana Roman <alisadariana@gmail.com>, Ivan Mikhaylov
 <fr0st61te@gmail.com>, Mike Looijmans <mike.looijmans@topic.nl>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>
Subject: Re: [PATCH v5 3/3] drivers: iio: adc: add support for ad777x family
Message-ID: <20240914180648.592cd69e@jic23-huawei>
In-Reply-To: <20240912121609.13438-4-ramona.nechita@analog.com>
References: <20240912121609.13438-1-ramona.nechita@analog.com>
	<20240912121609.13438-4-ramona.nechita@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Sep 2024 15:15:47 +0300
Ramona Alexandra Nechita <ramona.nechita@analog.com> wrote:

> Add support for AD7770, AD7771, AD7779 ADCs. The device is capable of
> sending out data both on DOUT lines interface,as on the SDO line.
> The driver currently implements only the SDO data streaming mode. SPI
> communication is used alternatively for accessing registers and streaming
> data. Register access are protected by crc8.
> 
> Signed-off-by: Ramona Alexandra Nechita <ramona.nechita@analog.com>
Hi Ramona,

A few additional comments inline,

Jonathan
> diff --git a/drivers/iio/adc/ad7779.c b/drivers/iio/adc/ad7779.c
> new file mode 100644
> index 000000000000..05ae72257c9e
> --- /dev/null
> +++ b/drivers/iio/adc/ad7779.c
> @@ -0,0 +1,917 @@

> +static int ad7779_set_calibbias(struct ad7779_state *st, int channel, int val)
> +{
> +	int ret;
> +	u8 calibbias[3];
> +
> +	put_unaligned_be24(val, calibbias);
> +	ret = ad7779_spi_write(st,
> +			       AD7779_REG_CH_OFFSET_UPPER_BYTE(channel),
> +			       calibbias[0]);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad7779_spi_write(st,
> +			       AD7779_REG_CH_OFFSET_MID_BYTE(channel),
> +			       calibbias[1]);
> +	if (ret)
> +		return ret;
> +
> +	return ad7779_spi_write(st,
> +				AD7779_REG_CH_OFFSET_LOWER_BYTE(channel),
Wrap closer to 80 chars.
	return ad7779_spi_write(st, AD7779_REG_CH_OFFSET_LOWER_BYTE(channel),
				calibbias[2]);

etc as it'll shorted the code a little bit for no significant loss
of readability.  Do the same for all other such cases.
> +}

> +
> +static irqreturn_t ad7779_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct ad7779_state *st = iio_priv(indio_dev);
> +	int ret;
> +	int bit;
> +	int k = 0;
> +	/*
> +	 * Each channel shifts out HEADER + 24 bits of data therefore 8 * u32
> +	 * for the data and 64 bits for the timestamp
> +	 */
> +	u32 tmp[10];
> +
> +	struct spi_transfer sd_readback_tr[] = {
> +		{
> +			.rx_buf = st->spidata_rx,
> +			.tx_buf = st->spidata_tx,
> +			.len = AD7779_NUM_CHANNELS * AD7779_CHAN_DATA_SIZE,
> +		}
> +	};
> +
> +	if (!iio_buffer_enabled(indio_dev))
> +		goto exit_handler;

If buffers aren't enabled, the push to buffers won't do anything. So this race
shouldn't matter.  If it does, what happens?
I'm curious because I'd expect any races that cause trouble in this case
to be pretty universal across drivers.


> +
> +	st->spidata_tx[0] = AD7779_SPI_READ_CMD;
> +	ret = spi_sync_transfer(st->spi, sd_readback_tr,
> +				ARRAY_SIZE(sd_readback_tr));
> +	if (ret) {
> +		dev_err(&st->spi->dev,
> +			"spi transfer error in irq handler");
> +		goto exit_handler;
> +	}
> +
> +	for_each_set_bit(bit, indio_dev->active_scan_mask, AD7779_NUM_CHANNELS - 1)
> +		tmp[k++] = st->spidata_rx[bit];

If you can't use the core demux handling + available_scan_masks, please add
a comment here to say why.  That would allow you to do the SPI transfer directly
into the buffer you then push below. The IIO core will figure out how to
pull data out of that if the user wants a subset of channels.


> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, &tmp[0], pf->timestamp);
> +
> +exit_handler:
> +	iio_trigger_notify_done(indio_dev->trig);
> +	return IRQ_HANDLED;
> +}
> +
> +static int ad7779_reset(struct iio_dev *indio_dev, struct gpio_desc *reset_gpio)
> +{
> +	struct ad7779_state *st = iio_priv(indio_dev);
> +	int ret;
> +	struct spi_transfer reg_read_tr[] = {
> +		{
> +			.tx_buf = st->reset_buf,
> +			.len = 8,
> +		},
> +	};
> +
> +	memset(st->reset_buf, 0xff, sizeof(st->reset_buf));
> +
> +	if (reset_gpio) {
> +		/* Delay for reset to occur is 225 microseconds*/
> +		gpiod_set_value(reset_gpio, 1);
> +		fsleep(230);
> +		return 0;

 +	}
	if (reset_gpio) {
		/* Delay for reset to occur is 225 microseconds*/
		gpiod_set_value(reset_gpio, 1);

	} else {
		struct spi_transfer reg_read_tr[] = {
			{
				.tx_buf = st->reset_buf,
				.len = 8,
			},
		};
		int ret;

		memset(st->reset_buf, 0xff, sizeof(st->reset_buf));
		ret = spi_sync_transfer(st->spi, reg_read_tr,
					ARRAY_SIZE(reg_read_tr));
		if (ret)
			return ret;
	}
	fsleep(230);
	return 0;

or something along those lines.  Shares the sleep so showing the wait
is the same in both types of reset and doesn't do a memset that I think
is otherwise irrelevant if there is a gpio.
> +
> +	ret = spi_sync_transfer(st->spi, reg_read_tr,
> +				ARRAY_SIZE(reg_read_tr));
> +	if (ret)
> +		return ret;
> +
> +	/* Delay for reset to occur is 225 microseconds*/
> +	fsleep(230);
> +
> +	return 0;
> +}

> +static int ad7779_probe(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev;
> +	struct ad7779_state *st;
> +	struct gpio_desc *reset_gpio, *start_gpio;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +
> +	st->mclk = devm_clk_get_enabled(&spi->dev, "mclk");
> +	if (IS_ERR(st->mclk))
> +		return PTR_ERR(st->mclk);
> +
> +	if (!spi->irq)
> +		return dev_err_probe(&spi->dev, ret,
> +				     "DRDY irq not present\n");
> +
> +	reset_gpio = devm_gpiod_get_optional(&spi->dev, "reset", GPIOD_OUT_LOW);
> +	if (IS_ERR(reset_gpio))
> +		return PTR_ERR(reset_gpio);
> +
> +	start_gpio = devm_gpiod_get(&spi->dev, "start", GPIOD_OUT_HIGH);
> +	if (IS_ERR(start_gpio))
> +		return PTR_ERR(start_gpio);
> +
> +	crc8_populate_msb(ad7779_crc8_table, AD7779_CRC8_POLY);
> +	st->spi = spi;
> +
> +	st->chip_info = spi_get_device_match_data(spi);
> +	if (!st->chip_info)
> +		return -ENODEV;
> +
> +	ret = ad7779_reset(indio_dev, reset_gpio);
> +	if (ret)
> +		return ret;
> +
> +	ad7779_powerup(st, start_gpio);
> +	if (ret)
> +		return ret;
What powers the device down again if we hit an error?

Probably need a devm_add_action_or_reset() or if it self powers down
may a comment on that.

> +
> +	indio_dev->name = st->chip_info->name;
> +	indio_dev->info = &ad7779_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = st->chip_info->channels;
> +	indio_dev->num_channels = ARRAY_SIZE(ad7779_channels);
> +
> +	st->trig = devm_iio_trigger_alloc(&spi->dev, "%s-dev%d",
> +					  indio_dev->name, iio_device_id(indio_dev));
> +	if (!st->trig)
> +		return -ENOMEM;
> +
> +	st->trig->ops = &ad7779_trigger_ops;
> +
> +	iio_trigger_set_drvdata(st->trig, st);
> +
> +	ret = devm_request_irq(&spi->dev, spi->irq,
> +			      iio_trigger_generic_data_rdy_poll,
> +			      IRQF_ONESHOT | IRQF_NO_AUTOEN,
> +			      indio_dev->name, st->trig);
> +	if (ret)
> +		return dev_err_probe(&spi->dev, ret, "request irq %d failed\n",
> +				     st->spi->irq);
> +
> +	ret = devm_iio_trigger_register(&spi->dev, st->trig);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->trig = iio_trigger_get(st->trig);
> +
> +	init_completion(&st->completion);
> +
> +	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
> +					      &iio_pollfunc_store_time,
> +					      &ad7779_trigger_handler,
> +					      &ad7779_buffer_setup_ops);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad7779_spi_write_mask(st, AD7779_REG_DOUT_FORMAT,
> +				    AD7779_DCLK_CLK_DIV_MSK,
> +				    FIELD_PREP(AD7779_DCLK_CLK_DIV_MSK, 7));
> +	if (ret)
> +		return ret;
> +
> +	return devm_iio_device_register(&spi->dev, indio_dev);
> +}
> +
> +static int ad7779_suspend(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct ad7779_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = ad7779_spi_write_mask(st, AD7779_REG_GENERAL_USER_CONFIG_1,
> +				    AD7779_MOD_POWERMODE_MSK,
> +				    FIELD_PREP(AD7779_MOD_POWERMODE_MSK,
> +					       AD7779_LOW_POWER));
> +	if (ret)
> +		return ret;
As below.  Given if !ret, ret == 0 so same as just returning it unconditionally.


> +
> +	return 0;
> +}
> +
> +static int ad7779_resume(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct ad7779_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = ad7779_spi_write_mask(st, AD7779_REG_GENERAL_USER_CONFIG_1,
> +				    AD7779_MOD_POWERMODE_MSK,
> +				    FIELD_PREP(AD7779_MOD_POWERMODE_MSK,
> +					       AD7779_HIGH_POWER));
> +	if (ret)
> +		return ret;
	return ad7779_spi_write_mask...

> +
> +	return 0;
> +}


