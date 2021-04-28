Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D93336DDB5
	for <lists+linux-iio@lfdr.de>; Wed, 28 Apr 2021 18:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241383AbhD1Q7A (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 28 Apr 2021 12:59:00 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2946 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241257AbhD1Q67 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 28 Apr 2021 12:58:59 -0400
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FVl4J3mPXz6896L;
        Thu, 29 Apr 2021 00:50:24 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Wed, 28 Apr 2021 18:58:11 +0200
Received: from localhost (10.52.123.69) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 28 Apr
 2021 17:58:10 +0100
Date:   Wed, 28 Apr 2021 17:56:36 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
CC:     Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        "Robin van der Gracht" <robin@protonic.nl>,
        <linux-iio@vger.kernel.org>,
        "Lars-Peter Clausen" <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v6 3/3] iio: adc: add ADC driver for the TI TSC2046
 controller
Message-ID: <20210428175636.00001170@Huawei.com>
In-Reply-To: <20210428073208.19570-4-o.rempel@pengutronix.de>
References: <20210428073208.19570-1-o.rempel@pengutronix.de>
        <20210428073208.19570-4-o.rempel@pengutronix.de>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.123.69]
X-ClientProxiedBy: lhreml751-chm.china.huawei.com (10.201.108.201) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 28 Apr 2021 09:32:08 +0200
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> Basically the TI TSC2046 touchscreen controller is 8 channel ADC optimized for
> the touchscreen use case. By implementing it as an IIO ADC device, we can
> make use of resistive-adc-touch and iio-hwmon drivers.
> 
> Polled readings are currently not implemented to keep this patch small, so
> iio-hwmon will not work out of the box for now.
> 
> So far, this driver was tested with a custom version of resistive-adc-touch driver,
> since it needs to be extended to make use of Z1 and Z2 channels. The X/Y
> are working without additional changes.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

A few really small things inline that I'm happy to clean up whilst applying,
or can get rolled into a v7 if you have to do one due to review from others.

...

> +
> +static int tsc2046_adc_read_one(struct tsc2046_adc_priv *priv, int ch_idx,
> +				u32 *effective_speed_hz)
> +{
> +	struct spi_transfer xfer;
> +	struct spi_message msg;
> +	int ret;
> +
> +	memset(&xfer, 0, sizeof(xfer));
> +	priv->tx_one->cmd = tsc2046_adc_get_cmd(priv, ch_idx, false);
> +	priv->tx_one->data = 0;
> +	xfer.tx_buf = priv->tx_one;
> +	xfer.rx_buf = priv->rx_one;
> +	xfer.len = sizeof(*priv->tx_one);
> +	spi_message_init(&msg);
> +	spi_message_add_tail(&xfer, &msg);

Slight preference for 
	spi_message_init_with_transfers(&msg, &xfer, 1);

Same elsewhere where we get this pattern.

> +
> +	/*
> +	 * We aren't using spi_write_then_read() because we need to be able
> +	 * to get hold of the effective_speed_hz from the xfer
> +	 */
> +	ret = spi_sync(priv->spi, &msg);
> +	if (ret) {
> +		dev_err_ratelimited(&priv->spi->dev, "SPI transfer failed %pe\n",
> +				    ERR_PTR(ret));
> +		return ret;
> +	}
> +
> +	if (effective_speed_hz)
> +		*effective_speed_hz = xfer.effective_speed_hz;
> +
> +	return tsc2046_adc_get_value(priv->rx_one);
> +}
> +
...

> +static int tsc2046_adc_setup_spi_msg(struct tsc2046_adc_priv *priv)
> +{
> +	unsigned int ch_idx;
> +	size_t size;
> +	int ret;
> +
> +	priv->tx_one = devm_kzalloc(&priv->spi->dev, sizeof(*priv->tx_one),
> +				    GFP_KERNEL);
> +	if (!priv->tx_one)
> +		return -ENOMEM;
> +
> +	priv->rx_one = devm_kzalloc(&priv->spi->dev, sizeof(*priv->rx_one),
> +				    GFP_KERNEL);
> +	if (!priv->rx_one)
> +		return -ENOMEM;
> +
> +	/*
> +	 * Make dummy read to set initial power state and get real SPI clock
> +	 * freq. It seems to be not important which channel is used for this
> +	 * case.
> +	 */
> +	ret = tsc2046_adc_read_one(priv, TI_TSC2046_ADDR_TEMP0,
> +				   &priv->effective_speed_hz);
> +	if (ret < 0)
> +		return ret;
> +
> +	/*
> +	 * In case SPI controller do not report effective_speed_hz, use
> +	 * configure value and hope it will match.
> +	 */
> +	if (!priv->effective_speed_hz)
> +		priv->effective_speed_hz = priv->spi->max_speed_hz;
> +
> +
> +	priv->scan_interval_us = TI_TSC2046_SAMPLE_INTERVAL_US;
> +	priv->time_per_bit_ns = DIV_ROUND_UP(NSEC_PER_SEC,
> +					     priv->effective_speed_hz);
> +
> +	/*
> +	 * Calculate and allocate maximal size buffer if all channels are
> +	 * enabled.
> +	 */
> +	size = 0;
> +	for (ch_idx = 0; ch_idx < priv->dcfg->num_channels; ch_idx++)
> +		size += tsc2046_adc_group_set_layout(priv, ch_idx, ch_idx);
> +
> +	priv->tx = devm_kzalloc(&priv->spi->dev, size, GFP_KERNEL);
> +	if (!priv->tx)
> +		return -ENOMEM;
> +
> +	priv->rx = devm_kzalloc(&priv->spi->dev, size, GFP_KERNEL);
> +	if (!priv->rx)
> +		return -ENOMEM;
> +
> +	spi_message_init(&priv->msg);
> +	priv->msg.context = priv;

Why is this set as we never set priv->msg.complete?
I can drop this whilst merging if we aren't going around again.
> +
> +	priv->xfer.tx_buf = priv->tx;
> +	priv->xfer.rx_buf = priv->rx;
> +	priv->xfer.len = size;
> +	spi_message_add_tail(&priv->xfer, &priv->msg);

Having dropped the above, can also change to
spi_message_init_with_transfers()

> +
> +	return 0;
> +}
> +
...

> +static int tsc2046_adc_probe(struct spi_device *spi)
> +{
> +	const struct tsc2046_adc_dcfg *dcfg;
> +	struct device *dev = &spi->dev;
> +	struct tsc2046_adc_priv *priv;
> +	struct iio_dev *indio_dev;
> +	struct iio_trigger *trig;
> +	int ret;
> +
> +	if (spi->max_speed_hz > TI_TSC2046_MAX_CLK_FREQ) {
> +		dev_err(dev, "SPI max_speed_hz is too high: %d Hz. Max supported freq is %zu Hz\n",
> +			spi->max_speed_hz, TI_TSC2046_MAX_CLK_FREQ);
> +		return -EINVAL;
> +	}
> +
> +	dcfg = device_get_match_data(dev);
> +	if (!dcfg)
> +		return -EINVAL;
> +
> +	spi->bits_per_word = 8;
> +	spi->mode &= ~SPI_MODE_X_MASK;
> +	spi->mode |= SPI_MODE_0;
> +	ret = spi_setup(spi);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Error in SPI setup\n");
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*priv));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	priv = iio_priv(indio_dev);
> +	priv->dcfg = dcfg;
> +
> +	spi_set_drvdata(spi, indio_dev);
> +
> +	priv->spi = spi;
> +
> +	indio_dev->name = TI_TSC2046_NAME;
> +	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_TRIGGERED;
> +	indio_dev->channels = dcfg->channels;
> +	indio_dev->num_channels = dcfg->num_channels;
> +	indio_dev->info = &tsc2046_adc_info;
> +
> +	tsc2046_adc_parse_fwnode(priv);
> +
> +	ret = tsc2046_adc_setup_spi_msg(priv);
> +	if (ret)
> +		return ret;
> +
> +	mutex_init(&priv->slock);
> +
> +	/* TODO: remove IRQ_NOAUTOEN after needed patches are mainline */
> +	irq_set_status_flags(spi->irq, IRQ_NOAUTOEN);

They are now but I can do this whilst merging if that's all we have to change.

> +	ret = devm_request_irq(dev, spi->irq, &tsc2046_adc_irq,
> +			       0, indio_dev->name, indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	trig = devm_iio_trigger_alloc(dev, "touchscreen-%s", indio_dev->name);
> +	if (!trig)
> +		return -ENOMEM;
> +
> +	priv->trig = trig;
> +	iio_trigger_set_drvdata(trig, indio_dev);
> +	trig->ops = &tsc2046_adc_trigger_ops;
> +
> +	spin_lock_init(&priv->trig_lock);
> +	hrtimer_init(&priv->trig_timer, CLOCK_MONOTONIC,
> +		     HRTIMER_MODE_REL_SOFT);
> +	priv->trig_timer.function = tsc2046_adc_trig_more;
> +
> +	ret = devm_iio_trigger_register(dev, trig);
> +	if (ret) {
> +		dev_err(dev, "failed to register trigger\n");
> +		return ret;
> +	}
> +
> +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
> +					      &tsc2046_adc_trigger_handler, NULL);
> +	if (ret) {
> +		dev_err(dev, "Failed to setup triggered buffer\n");
> +		return ret;
> +	}
> +
> +	/* set default trigger */
> +	indio_dev->trig = iio_trigger_get(priv->trig);
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +

thanks,

J
