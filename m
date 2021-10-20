Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7531D435479
	for <lists+linux-iio@lfdr.de>; Wed, 20 Oct 2021 22:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbhJTUVr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 20 Oct 2021 16:21:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:53676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230020AbhJTUVq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 20 Oct 2021 16:21:46 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4900611EF;
        Wed, 20 Oct 2021 20:19:30 +0000 (UTC)
Date:   Wed, 20 Oct 2021 21:23:48 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v8 1/2] iio: frequency: adrf6780: add support for
 ADRF6780
Message-ID: <20211020212348.3a110ebc@jic23-huawei>
In-Reply-To: <20211018110931.82225-1-antoniu.miclaus@analog.com>
References: <20211018110931.82225-1-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 18 Oct 2021 14:09:30 +0300
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

The 'problem' with rereading drivers lots of times is sometimes
you notice a new issue that you've missed before.  Unfortunately
the locking in here is inconsistent and there is not protection against
various functions using the dev->data[] array at the same time.
Sorry I missed this in earlier reviews!

It's a little bit too fiddly for me to simply make the changes
whilst applying, so please add the missing mutex_lock/unlock
and send out a v9.  I would suggest doing it by renaming the existing
unlocked versions to
__XXX_write() /read()
and then adding functions which take the mutex called after their
original names.

I made a small additional comment on naming that would also be good to
clear up.

Plus please run scripts/checkpatch.pl over the file and fix the warnings.
Preferably with --strict

Thanks,

Jonathan

> ---
> changes in v8:
> 	- condense lines that are very long
> 	- set ADC channel as input
> 	- add `dev_err_probe`
> 	- handle device powerdown via `devm_add_action_or_reset`
>  drivers/iio/frequency/Kconfig    |  12 +
>  drivers/iio/frequency/Makefile   |   1 +
>  drivers/iio/frequency/adrf6780.c | 496 +++++++++++++++++++++++++++++++
>  3 files changed, 509 insertions(+)
>  create mode 100644 drivers/iio/frequency/adrf6780.c
> 
> diff --git a/drivers/iio/frequency/Kconfig b/drivers/iio/frequency/Kconfig
> index 240b81502512..2c9e0559e8a4 100644
> --- a/drivers/iio/frequency/Kconfig
> +++ b/drivers/iio/frequency/Kconfig
> @@ -49,5 +49,17 @@ config ADF4371
>  
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called adf4371.
> +
> +config ADRF6780
> +        tristate "Analog Devices ADRF6780 Microwave Upconverter"
> +        depends on SPI
> +        depends on COMMON_CLK
> +        help
> +          Say yes here to build support for Analog Devices ADRF6780
> +          5.9 GHz to 23.6 GHz, Wideband, Microwave Upconverter.
> +
> +          To compile this driver as a module, choose M here: the
> +          module will be called adrf6780.
> +
>  endmenu
>  endmenu
> diff --git a/drivers/iio/frequency/Makefile b/drivers/iio/frequency/Makefile
> index 518b1e50caef..ae3136c79202 100644
> --- a/drivers/iio/frequency/Makefile
> +++ b/drivers/iio/frequency/Makefile
> @@ -7,3 +7,4 @@
>  obj-$(CONFIG_AD9523) += ad9523.o
>  obj-$(CONFIG_ADF4350) += adf4350.o
>  obj-$(CONFIG_ADF4371) += adf4371.o
> +obj-$(CONFIG_ADRF6780) += adrf6780.o
> diff --git a/drivers/iio/frequency/adrf6780.c b/drivers/iio/frequency/adrf6780.c
> new file mode 100644
> index 000000000000..4097b31bdf0b
> --- /dev/null
> +++ b/drivers/iio/frequency/adrf6780.c

> +
> +static int adrf6780_spi_read(struct adrf6780_dev *dev, unsigned int reg,
> +			      unsigned int *val)

I've highlighted a few paths inline where this isn't protected by a
mutex.  As such we will be racing on the content of dev->data[]
and results are going to be very unpredicatable.

> +{
> +	int ret;
> +	struct spi_transfer t = {0};
> +
> +	dev->data[0] = 0x80 | (reg << 1);
> +	dev->data[1] = 0x0;
> +	dev->data[2] = 0x0;
> +
> +	t.rx_buf = &dev->data[0];
> +	t.tx_buf = &dev->data[0];
> +	t.len = 3;
> +
> +	ret = spi_sync_transfer(dev->spi, &t, 1);
> +	if (ret)
> +		return ret;
> +
> +	*val = (get_unaligned_be24(&dev->data[0]) >> 1) & GENMASK(15, 0);
> +
> +	return ret;
> +}
> +
> +static int adrf6780_spi_write(struct adrf6780_dev *dev,
> +				      unsigned int reg,
> +				      unsigned int val)
> +{
> +	put_unaligned_be24((val << 1) | (reg << 17), &dev->data[0]);
> +
> +	return spi_write(dev->spi, &dev->data[0], 3);
> +}
> +
...

> +static int adrf6780_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int *val, int *val2, long info)
> +{
> +	struct adrf6780_dev *dev = iio_priv(indio_dev);
> +	unsigned int data;
> +	int ret;
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = adrf6780_read_adc_raw(dev, &data);

This takes the mutex inside the call which is good.

> +		if (ret)
> +			return ret;
> +
> +		*val = data & ADRF6780_ADC_VALUE_MSK;
> +
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_SCALE:

But need locks here as well (see below)

> +		ret = adrf6780_spi_read(dev, ADRF6780_REG_LINEARIZE, &data);
> +		if (ret)
> +			return ret;
> +
> +		*val = data & ADRF6780_RDAC_LINEARIZE_MSK;
> +
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_PHASE:

And here.

> +		ret = adrf6780_spi_read(dev, ADRF6780_REG_LO_PATH, &data);
> +		if (ret)
> +			return ret;
> +
> +		switch (chan->channel2) {
> +		case IIO_MOD_I:
> +			*val = data & ADRF6780_I_PATH_PHASE_ACCURACY_MSK;
> +
> +			return IIO_VAL_INT;
> +		case IIO_MOD_Q:
> +			*val = FIELD_GET(ADRF6780_Q_PATH_PHASE_ACCURACY_MSK, data);
> +
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int adrf6780_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int val, int val2, long info)
> +{
> +	struct adrf6780_dev *dev = iio_priv(indio_dev);

Minor point but there is a fairly strong expectation than anything
called simply 'dev' is a struct device.  Consider renaming.

> +	int ret;
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_SCALE:

This needs to take the lock or you can have this using dev->data at the
same time as other calls which have taken the mutex.

> +		return adrf6780_spi_write(dev, ADRF6780_REG_LINEARIZE, val);
> +	case IIO_CHAN_INFO_PHASE:
> +		switch (chan->channel2) {
> +		case IIO_MOD_I:
> +			mutex_lock(&dev->lock);
> +			ret = adrf6780_spi_update_bits(dev, ADRF6780_REG_LO_PATH,
> +							ADRF6780_I_PATH_PHASE_ACCURACY_MSK,
> +							FIELD_PREP(ADRF6780_I_PATH_PHASE_ACCURACY_MSK, val));
> +			mutex_unlock(&dev->lock);
> +
> +			return ret;
> +		case IIO_MOD_Q:
> +			mutex_lock(&dev->lock);
> +			ret = adrf6780_spi_update_bits(dev, ADRF6780_REG_LO_PATH,
> +							ADRF6780_Q_PATH_PHASE_ACCURACY_MSK,
> +							FIELD_PREP(ADRF6780_Q_PATH_PHASE_ACCURACY_MSK, val));
> +			mutex_unlock(&dev->lock);
> +
> +			return ret;
> +		default:
> +			return -EINVAL;
> +		}
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int adrf6780_reg_access(struct iio_dev *indio_dev,
> +				unsigned int reg,
> +				unsigned int write_val,
> +				unsigned int *read_val)
> +{
> +	struct adrf6780_dev *dev = iio_priv(indio_dev);
> +
> +	if (read_val)

Nothing prevents these being concurrent with other accesses
using the st->buf either.

> +		return adrf6780_spi_read(dev, reg, read_val);
> +	else
> +		return adrf6780_spi_write(dev, reg, write_val);
> +}
> +
...

