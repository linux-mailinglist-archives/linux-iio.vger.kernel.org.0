Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62CF737733A
	for <lists+linux-iio@lfdr.de>; Sat,  8 May 2021 18:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbhEHQjx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 8 May 2021 12:39:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:51418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229544AbhEHQjx (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 8 May 2021 12:39:53 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B4896140F;
        Sat,  8 May 2021 16:38:49 +0000 (UTC)
Date:   Sat, 8 May 2021 17:39:47 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     linux-iio@vger.kernel.org, andy.shevchenko@gmail.com,
        lars@metafoo.de, Nuno.Sa@analog.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, tomas.melin@vaisala.com
Subject: Re: [PATCH v5 5/6] iio: accel: fxls8962af: add hw buffered sampling
Message-ID: <20210508173947.47d18328@jic23-huawei>
In-Reply-To: <20210506070940.312959-5-sean@geanix.com>
References: <20210506070940.312959-1-sean@geanix.com>
        <20210506070940.312959-5-sean@geanix.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu,  6 May 2021 09:09:39 +0200
Sean Nyekjaer <sean@geanix.com> wrote:

> When buffered sampling is enabled, the accelerometer will dump data into
> the internal fifo and interrupt at watermark. Then the driver flushes
> all data to the iio buffer.
> As the accelerometer doesn't have internal timestamps, they are
> approximated between the current and last interrupt.
> 
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>

Hi Sean,

Couple of things I adjusted whilst applying this.
1) trigger.h isn't used as no triggers are involved currently in this driver so
   I dropped it.
2) kfifo allocation etc has changed in the IIO core whilst this driver was in
   development. Now we have devm_iio_kfifo_setup() which does everything your
   locals _setup() function does. 

I've made changes for both of the above whilst applying so please take a look
at the result which I'll shortly push out as testing for the autobuilders to
poke at as well.

Other than that I tweaked a bit of whilespace in the id tables in patch 1.

Series applied to the togreg branch of iio.git but initially just pushed out as
testing to let 0-day work it's magic.

Thanks,

Jonathan


> ---
> Changes from RFC:
>  - Dropped the claim stuff for read_raw
>  - Added watermark get/set
>  - Consistent use of u16 for buffer size
> 
> Changes for v5:
>  - removed redundant blank lines and redundant assignments
> 
>  drivers/iio/accel/fxls8962af-core.c | 207 ++++++++++++++++++++++++++++
>  1 file changed, 207 insertions(+)
> 
> diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
> index b909ba23e47c..889e470658b9 100644
> --- a/drivers/iio/accel/fxls8962af-core.c
> +++ b/drivers/iio/accel/fxls8962af-core.c
> @@ -20,13 +20,17 @@
>  #include <linux/regulator/consumer.h>
>  #include <linux/regmap.h>
>  
> +#include <linux/iio/buffer.h>
>  #include <linux/iio/iio.h>
> +#include <linux/iio/kfifo_buf.h>
>  #include <linux/iio/sysfs.h>
> +#include <linux/iio/trigger.h>
>  
>  #include "fxls8962af.h"
>  
>  #define FXLS8962AF_INT_STATUS			0x00
>  #define FXLS8962AF_INT_STATUS_SRC_BOOT		BIT(0)
> +#define FXLS8962AF_INT_STATUS_SRC_BUF		BIT(5)
>  #define FXLS8962AF_INT_STATUS_SRC_DRDY		BIT(7)
>  #define FXLS8962AF_TEMP_OUT			0x01
>  #define FXLS8962AF_VECM_LSB			0x02
> @@ -34,6 +38,9 @@
>  #define FXLS8962AF_OUT_Y_LSB			0x06
>  #define FXLS8962AF_OUT_Z_LSB			0x08
>  #define FXLS8962AF_BUF_STATUS			0x0b
> +#define FXLS8962AF_BUF_STATUS_BUF_CNT		GENMASK(5, 0)
> +#define FXLS8962AF_BUF_STATUS_BUF_OVF		BIT(6)
> +#define FXLS8962AF_BUF_STATUS_BUF_WMRK		BIT(7)
>  #define FXLS8962AF_BUF_X_LSB			0x0c
>  #define FXLS8962AF_BUF_Y_LSB			0x0e
>  #define FXLS8962AF_BUF_Z_LSB			0x10
> @@ -66,6 +73,7 @@
>  #define FXLS8962AF_ASLP_COUNT_LSB		0x1e
>  
>  #define FXLS8962AF_INT_EN			0x20
> +#define FXLS8962AF_INT_EN_BUF_EN		BIT(6)
>  #define FXLS8962AF_INT_PIN_SEL			0x21
>  #define FXLS8962AF_INT_PIN_SEL_MASK		GENMASK(7, 0)
>  #define FXLS8962AF_INT_PIN_SEL_INT1		0x00
> @@ -76,7 +84,10 @@
>  #define FXLS8962AF_OFF_Z			0x24
>  
>  #define FXLS8962AF_BUF_CONFIG1			0x26
> +#define FXLS8962AF_BC1_BUF_MODE_MASK		GENMASK(6, 5)
> +#define FXLS8962AF_BC1_BUF_MODE_PREP(x)		FIELD_PREP(FXLS8962AF_BC1_BUF_MODE_MASK, (x))
>  #define FXLS8962AF_BUF_CONFIG2			0x27
> +#define FXLS8962AF_BUF_CONFIG2_BUF_WMRK		GENMASK(5, 0)
>  
>  #define FXLS8962AF_ORIENT_STATUS		0x28
>  #define FXLS8962AF_ORIENT_CONFIG		0x29
> @@ -106,6 +117,7 @@
>  
>  #define FXLS8962AF_AUTO_SUSPEND_DELAY_MS	2000
>  
> +#define FXLS8962AF_FIFO_LENGTH			32
>  #define FXLS8962AF_SCALE_TABLE_LEN		4
>  #define FXLS8962AF_SAMP_FREQ_TABLE_LEN		13
>  
> @@ -133,7 +145,13 @@ struct fxls8962af_data {
>  	struct regmap *regmap;
>  	const struct fxls8962af_chip_info *chip_info;
>  	struct regulator *vdd_reg;
> +	struct {
> +		__le16 channels[3];
> +		s64 ts __aligned(8);
> +	} scan;
> +	int64_t timestamp, old_timestamp;	/* Only used in hw fifo mode. */
>  	struct iio_mount_matrix orientation;
> +	u8 watermark;
>  };
>  
>  const struct regmap_config fxls8962af_regmap_conf = {
> @@ -433,6 +451,18 @@ static int fxls8962af_write_raw(struct iio_dev *indio_dev,
>  	}
>  }
>  
> +static int fxls8962af_set_watermark(struct iio_dev *indio_dev, unsigned val)
> +{
> +	struct fxls8962af_data *data = iio_priv(indio_dev);
> +
> +	if (val > FXLS8962AF_FIFO_LENGTH)
> +		val = FXLS8962AF_FIFO_LENGTH;
> +
> +	data->watermark = val;
> +
> +	return 0;
> +}
> +
>  #define FXLS8962AF_CHANNEL(axis, reg, idx) { \
>  	.type = IIO_ACCEL, \
>  	.address = reg, \
> @@ -493,6 +523,7 @@ static const struct iio_info fxls8962af_info = {
>  	.write_raw = &fxls8962af_write_raw,
>  	.write_raw_get_fmt = fxls8962af_write_raw_get_fmt,
>  	.read_avail = fxls8962af_read_avail,
> +	.hwfifo_set_watermark = fxls8962af_set_watermark,
>  };
>  
>  static int fxls8962af_reset(struct fxls8962af_data *data)
> @@ -517,6 +548,157 @@ static int fxls8962af_reset(struct fxls8962af_data *data)
>  	return ret;
>  }
>  
> +static int __fxls8962af_fifo_set_mode(struct fxls8962af_data *data, bool onoff)
> +{
> +	int ret;
> +
> +	/* Enable watermark at max fifo size */
> +	ret = regmap_update_bits(data->regmap, FXLS8962AF_BUF_CONFIG2,
> +				 FXLS8962AF_BUF_CONFIG2_BUF_WMRK,
> +				 data->watermark);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_update_bits(data->regmap, FXLS8962AF_BUF_CONFIG1,
> +				  FXLS8962AF_BC1_BUF_MODE_MASK,
> +				  FXLS8962AF_BC1_BUF_MODE_PREP(onoff));
> +}
> +
> +static int fxls8962af_buffer_preenable(struct iio_dev *indio_dev)
> +{
> +	return fxls8962af_power_on(iio_priv(indio_dev));
> +}
> +
> +static int fxls8962af_buffer_postenable(struct iio_dev *indio_dev)
> +{
> +	struct fxls8962af_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	fxls8962af_standby(data);
> +
> +	/* Enable buffer interrupt */
> +	ret = regmap_update_bits(data->regmap, FXLS8962AF_INT_EN,
> +				 FXLS8962AF_INT_EN_BUF_EN,
> +				 FXLS8962AF_INT_EN_BUF_EN);
> +	if (ret)
> +		return ret;
> +
> +	ret = __fxls8962af_fifo_set_mode(data, true);
> +
> +	fxls8962af_active(data);
> +
> +	return ret;
> +}
> +
> +static int fxls8962af_buffer_predisable(struct iio_dev *indio_dev)
> +{
> +	struct fxls8962af_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	fxls8962af_standby(data);
> +
> +	/* Disable buffer interrupt */
> +	ret = regmap_update_bits(data->regmap, FXLS8962AF_INT_EN,
> +				 FXLS8962AF_INT_EN_BUF_EN, 0);
> +	if (ret)
> +		return ret;
> +
> +	ret = __fxls8962af_fifo_set_mode(data, false);
> +
> +	fxls8962af_active(data);
> +
> +	return ret;
> +}
> +
> +static int fxls8962af_buffer_postdisable(struct iio_dev *indio_dev)
> +{
> +	struct fxls8962af_data *data = iio_priv(indio_dev);
> +
> +	return fxls8962af_power_off(data);
> +}
> +
> +static const struct iio_buffer_setup_ops fxls8962af_buffer_ops = {
> +	.preenable = fxls8962af_buffer_preenable,
> +	.postenable = fxls8962af_buffer_postenable,
> +	.predisable = fxls8962af_buffer_predisable,
> +	.postdisable = fxls8962af_buffer_postdisable,
> +};
> +
> +static int fxls8962af_fifo_transfer(struct fxls8962af_data *data,
> +				    u16 *buffer, int samples)
> +{
> +	struct device *dev = regmap_get_device(data->regmap);
> +	int sample_length = 3 * sizeof(*buffer);
> +	int ret;
> +	int total_length = samples * sample_length;
> +
> +	ret = regmap_raw_read(data->regmap, FXLS8962AF_BUF_X_LSB, buffer,
> +			      total_length);
> +	if (ret)
> +		dev_err(dev, "Error transferring data from fifo: %d\n", ret);
> +
> +	return ret;
> +}
> +
> +static int fxls8962af_fifo_flush(struct iio_dev *indio_dev)
> +{
> +	struct fxls8962af_data *data = iio_priv(indio_dev);
> +	struct device *dev = regmap_get_device(data->regmap);
> +	u16 buffer[FXLS8962AF_FIFO_LENGTH * 3];
> +	uint64_t sample_period;
> +	unsigned int reg;
> +	int64_t tstamp;
> +	int ret, i;
> +	u8 count;
> +
> +	ret = regmap_read(data->regmap, FXLS8962AF_BUF_STATUS, &reg);
> +	if (ret)
> +		return ret;
> +
> +	if (reg & FXLS8962AF_BUF_STATUS_BUF_OVF) {
> +		dev_err(dev, "Buffer overflow");
> +		return -EOVERFLOW;
> +	}
> +
> +	count = reg & FXLS8962AF_BUF_STATUS_BUF_CNT;
> +	if (!count)
> +		return 0;
> +
> +	data->old_timestamp = data->timestamp;
> +	data->timestamp = iio_get_time_ns(indio_dev);
> +
> +	/*
> +	 * Approximate timestamps for each of the sample based on the sampling,
> +	 * frequency, timestamp for last sample and number of samples.
> +	 */
> +	sample_period = (data->timestamp - data->old_timestamp);
> +	do_div(sample_period, count);
> +	tstamp = data->timestamp - (count - 1) * sample_period;
> +
> +	ret = fxls8962af_fifo_transfer(data, buffer, count);
> +	if (ret)
> +		return ret;
> +
> +	/* Demux hw FIFO into kfifo. */
> +	for (i = 0; i < count; i++) {
> +		int j, bit;
> +
> +		j = 0;
> +		for_each_set_bit(bit, indio_dev->active_scan_mask,
> +				 indio_dev->masklength) {
> +			memcpy(&data->scan.channels[j++], &buffer[i * 3 + bit],
> +			       sizeof(data->scan.channels[0]));
> +		}
> +
> +		iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
> +						   tstamp);
> +
> +		tstamp += sample_period;
> +	}
> +
> +	return count;
> +}
> +
>  static irqreturn_t fxls8962af_interrupt(int irq, void *p)
>  {
>  	struct iio_dev *indio_dev = p;
> @@ -528,9 +710,32 @@ static irqreturn_t fxls8962af_interrupt(int irq, void *p)
>  	if (ret)
>  		return IRQ_NONE;
>  
> +	if (reg & FXLS8962AF_INT_STATUS_SRC_BUF) {
> +		ret = fxls8962af_fifo_flush(indio_dev);
> +		if (ret)
> +			return IRQ_NONE;
> +
> +		return IRQ_HANDLED;
> +	}
> +
>  	return IRQ_NONE;
>  }
>  
> +static int fxls8962af_fifo_setup(struct iio_dev *indio_dev)
> +{
> +	struct iio_buffer *buffer;
> +
> +	buffer = devm_iio_kfifo_allocate(&indio_dev->dev);
> +	if (!buffer)
> +		return -ENOMEM;
> +
> +	iio_device_attach_buffer(indio_dev, buffer);
> +	indio_dev->modes |= INDIO_BUFFER_SOFTWARE;
> +	indio_dev->setup_ops = &fxls8962af_buffer_ops;
> +
> +	return 0;
> +}
> +
>  static void fxls8962af_regulator_disable(void *data_ptr)
>  {
>  	struct fxls8962af_data *data = data_ptr;
> @@ -694,6 +899,8 @@ int fxls8962af_core_probe(struct device *dev, struct regmap *regmap, int irq)
>  		ret = fxls8962af_irq_setup(indio_dev, irq);
>  		if (ret)
>  			return ret;
> +
> +		fxls8962af_fifo_setup(indio_dev);
>  	}
>  
>  	ret = pm_runtime_set_active(dev);

