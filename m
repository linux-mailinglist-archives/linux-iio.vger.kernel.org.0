Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C63F94309E2
	for <lists+linux-iio@lfdr.de>; Sun, 17 Oct 2021 16:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238176AbhJQO6o (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 17 Oct 2021 10:58:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:39832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237361AbhJQO6o (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 17 Oct 2021 10:58:44 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D07E60EE5;
        Sun, 17 Oct 2021 14:56:33 +0000 (UTC)
Date:   Sun, 17 Oct 2021 16:00:47 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 1/2] iio: frequency: adrf6780: add support for
 ADRF6780
Message-ID: <20211017160047.17e3adb7@jic23-huawei>
In-Reply-To: <20211011110011.104063-1-antoniu.miclaus@analog.com>
References: <20211011110011.104063-1-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 11 Oct 2021 14:00:10 +0300
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> The ADRF6780 is a silicon germanium (SiGe) design, wideband,
> microwave upconverter optimized for point to point microwave
> radio designs operating in the 5.9 GHz to 23.6 GHz frequency
> range.
> 
> Datasheet:
> https://www.analog.com/media/en/technical-documentation/data-sheets/ADRF6780.pdf
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>

Hi Antoniu,

A few things went wrong with the addition of the remove path changes that you
will want to clean up.

Also just noticed your ADC channel is an output which seems unlikely...

See comments inline.

Thanks,

Jonathan

> ---
> changes in v7:
>  - add device remove path and disable all circuitry controlled via 
>    Enable Register.
>  - rename `adrf6780_dt_parse` -> `adrf6780_properties_parse`
> 
>  drivers/iio/frequency/Kconfig    |  12 +
>  drivers/iio/frequency/Makefile   |   1 +
>  drivers/iio/frequency/adrf6780.c | 503 +++++++++++++++++++++++++++++++
>  3 files changed, 516 insertions(+)
>  create mode 100644 drivers/iio/frequency/adrf6780.c
> 

...

> diff --git a/drivers/iio/frequency/adrf6780.c b/drivers/iio/frequency/adrf6780.c
> new file mode 100644
> index 000000000000..2daa728d2ff4
> --- /dev/null
> +++ b/drivers/iio/frequency/adrf6780.c
> @@ -0,0 +1,503 @@

...

> +#define ADRF6780_CHAN_ADC(_channel) {			\
> +	.type = IIO_ALTVOLTAGE,				\
> +	.output = 1,					\
> +	.indexed = 1,					\
> +	.channel = _channel,				\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW)	\
> +}
> +
> +#define ADRF6780_CHAN_RDAC(_channel) {			\
> +	.type = IIO_ALTVOLTAGE,				\
> +	.output = 1,					\
> +	.indexed = 1,					\
> +	.channel = _channel,				\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_SCALE)	\
> +}

Just noticed, but as you use the same index for ADC(0) and RDAC(0)
and both are output channels(odd for something called ADC?) you might
as well combine the info_masks and have just one entry.

I'm guessing that ADC channel might not be an output one though...

> +
> +#define ADRF6780_CHAN_IQ_PHASE(_channel, rf_comp) {		\
> +	.type = IIO_ALTVOLTAGE,					\
> +	.modified = 1,						\
> +	.output = 1,						\
> +	.indexed = 1,						\
> +	.channel2 = IIO_MOD_##rf_comp,				\
> +	.channel = _channel,					\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_PHASE)		\
> +}
> +
> +static const struct iio_chan_spec adrf6780_channels[] = {
> +	ADRF6780_CHAN_ADC(0),
> +	ADRF6780_CHAN_RDAC(0),
> +	ADRF6780_CHAN_IQ_PHASE(0, I),
> +	ADRF6780_CHAN_IQ_PHASE(0, Q),
> +};
> +
>

...

> +static int adrf6780_init(struct adrf6780_dev *dev)
> +{
> +	int ret;
> +	unsigned int chip_id, enable_reg, enable_reg_msk;
> +	struct spi_device *spi = dev->spi;
> +
> +	/* Perform a software reset */
> +	ret = adrf6780_reset(dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = adrf6780_spi_read(dev, ADRF6780_REG_CONTROL, &chip_id);
> +	if (ret)
> +		return ret;
> +
> +	chip_id = FIELD_GET(ADRF6780_CHIP_ID_MSK, chip_id);
> +	if (chip_id != ADRF6780_CHIP_ID) {
> +		dev_err(&spi->dev, "ADRF6780 Invalid Chip ID.\n");
> +		return -EINVAL;
> +	}
> +
> +	enable_reg_msk = ADRF6780_VGA_BUFFER_EN_MSK |
> +			ADRF6780_DETECTOR_EN_MSK |
> +			ADRF6780_LO_BUFFER_EN_MSK |
> +			ADRF6780_IF_MODE_EN_MSK |
> +			ADRF6780_IQ_MODE_EN_MSK |
> +			ADRF6780_LO_X2_EN_MSK |
> +			ADRF6780_LO_PPF_EN_MSK |
> +			ADRF6780_LO_EN_MSK |
> +			ADRF6780_UC_BIAS_EN_MSK;
> +
> +	enable_reg = FIELD_PREP(ADRF6780_VGA_BUFFER_EN_MSK, dev->vga_buff_en) |
> +			FIELD_PREP(ADRF6780_DETECTOR_EN_MSK, 1) |
> +			FIELD_PREP(ADRF6780_LO_BUFFER_EN_MSK, dev->lo_buff_en) |
> +			FIELD_PREP(ADRF6780_IF_MODE_EN_MSK, dev->if_mode_en) |
> +			FIELD_PREP(ADRF6780_IQ_MODE_EN_MSK, dev->iq_mode_en) |
> +			FIELD_PREP(ADRF6780_LO_X2_EN_MSK, dev->lo_x2_en) |
> +			FIELD_PREP(ADRF6780_LO_PPF_EN_MSK, dev->lo_ppf_en) |
> +			FIELD_PREP(ADRF6780_LO_EN_MSK, dev->lo_en) |
> +			FIELD_PREP(ADRF6780_UC_BIAS_EN_MSK, dev->uc_bias_en);
> +
> +	ret = adrf6780_spi_update_bits(dev, ADRF6780_REG_ENABLE, enable_reg_msk, enable_reg);
> +	if (ret)
> +		return ret;
> +
> +	ret = adrf6780_spi_update_bits(dev, ADRF6780_REG_LO_PATH,
> +						ADRF6780_LO_SIDEBAND_MSK,
> +						FIELD_PREP(ADRF6780_LO_SIDEBAND_MSK, dev->lo_sideband));
> +	if (ret)
> +		return ret;
> +
> +	return adrf6780_spi_update_bits(dev, ADRF6780_REG_ADC_CONTROL,
> +						ADRF6780_VDET_OUTPUT_SELECT_MSK,
> +						FIELD_PREP(ADRF6780_VDET_OUTPUT_SELECT_MSK, dev->vdet_out_en));

Very long line so perhaps add an additional line break after the ,


> +}
> +

...

> +
> +static int adrf6780_probe(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev;
> +	struct adrf6780_dev *dev;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*dev));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	dev = iio_priv(indio_dev);
> +
> +	indio_dev->info = &adrf6780_info;
> +	indio_dev->name = "adrf6780";
> +	indio_dev->channels = adrf6780_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(adrf6780_channels);
> +
> +	dev->spi = spi;
> +
> +	adrf6780_properties_parse(dev);
> +
> +	dev->clkin = devm_clk_get(&spi->dev, "lo_in");

Please add an error message to things that might result in a deferred probe
via dev_err_probe() as it stores more debugging information for those trying
to chase down why a probe was deferred. Note this is a new thing, but as you
are going to need to do another version anyway, nice to tidy it up in the
initial driver rather than as a follow up patch.

> +	if (IS_ERR(dev->clkin))
> +		return PTR_ERR(dev->clkin);
> +
> +	ret = clk_prepare_enable(dev->clkin);
> +	if (ret < 0)
> +		goto error_disable_clk;
> +
> +	mutex_init(&dev->lock);
> +
> +	ret = adrf6780_init(dev);
> +	if (ret)
> +		goto error_disable_clk;;
> +
> +	ret = iio_device_register(indio_dev);
> +	if (ret)
> +		goto error_disable_clk;
> +
> +	return 0;
> +
> +error_disable_clk:

An easy way to spot inconsistencies is to compare what is done
in the error path in probe() with what occurs in remove().
They should only differ in that the first element in remove() often
won't appear in the probe error handling.  So why am I not seeing the
disable write to the device here?

> +	clk_disable_unprepare(dev->clkin);
> +
> +	return ret;
> +}
> +
> +static int adrf6780_remove(struct spi_device *spi)
> +{
> +	int ret;
> +	struct iio_dev *indio_dev = spi_get_drvdata(spi);
> +	struct adrf6780_dev *dev = iio_priv(indio_dev);
> +
> +	/* Disable all components in the Enable Register */
> +	ret = adrf6780_spi_write(dev, ADRF6780_REG_ENABLE, 0x0);

What call in probe() is this matched against?   Looks to be the
_init() call.  In which case this should be after the iio_device_unregister().
Particularly obvious here as turning off the device 'before' we remove the
userspace interface is never a good plan.

Also, there is no point in returning an error code from probe so just
carry on if this fails and we'll disable as much as possible.
Note that there are lots of patches removing returns from spi driver
remove functions at the moment.

Everything you are doing in this remove could be easily handled automatically
with a few devm_add_action_or_reset() calls in probe.  See the many
patches Alexandru Ardelean has sent converting driver to that approach.
One side effect is that the ordering is automatically correct.

> +	if(ret)
> +		return ret;
> +
> +	iio_device_unregister(indio_dev);
> +
> +	clk_disable_unprepare(dev->clkin);
> +
> +	return 0;
> +}
> +
> +

One blank line is almost always enough.

> +static const struct spi_device_id adrf6780_id[] = {
> +	{ "adrf6780", 0 },
> +	{}
> +};
