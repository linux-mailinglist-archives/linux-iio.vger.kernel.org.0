Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1A9936DD1E
	for <lists+linux-iio@lfdr.de>; Wed, 28 Apr 2021 18:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbhD1QfA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 28 Apr 2021 12:35:00 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2945 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240929AbhD1QfA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 28 Apr 2021 12:35:00 -0400
Received: from fraeml737-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FVkb70Ngfz6yj82;
        Thu, 29 Apr 2021 00:28:35 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml737-chm.china.huawei.com (10.206.15.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 28 Apr 2021 18:34:13 +0200
Received: from localhost (10.52.123.69) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 28 Apr
 2021 17:34:12 +0100
Date:   Wed, 28 Apr 2021 17:32:38 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Sean Nyekjaer <sean@geanix.com>
CC:     <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        <andy.shevchenko@gmail.com>, <lars@metafoo.de>,
        <Nuno.Sa@analog.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [RFC PATCH 3/4] iio: accel: fxls8962af: add hw buffered
 sampling
Message-ID: <20210428173238.0000540d@Huawei.com>
In-Reply-To: <20210428082203.3587022-3-sean@geanix.com>
References: <20210428082203.3587022-1-sean@geanix.com>
        <20210428082203.3587022-3-sean@geanix.com>
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

On Wed, 28 Apr 2021 10:22:02 +0200
Sean Nyekjaer <sean@geanix.com> wrote:

> When buffered sampling is enabled, the accelerometer will dump data into
> the internal fifo and interrupt at watermark. Then the driver flushes
> all data to the iio buffer.
> As the accelerometer doesn't have internal timestamps, they are aproximated
> between to interrupts.

two? 

This tends to be a noisy approach, so people often try to apply a filter.
However, no need to do that for an initial version.

There are some things in here referring to enabling triggered modes, but I'm
not seeing code to actually do so.  The fun question when dealing with fifos
and triggered mode is what the interface is to switch between the two.
One option I think we've used before is to just have 'no trigger' match
up to fifo mode and if a trigger is set, don't use the fifo.

> 
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---
> This series depends on "iio: accel: add support for
> FXLS8962AF/FXLS8964AF accelerometers"
> 
> Any good pratice in general to how much to fill the fifo?
> The accelerometer a internal buffer with 32 samples and I have set the watermark to 16.

The watermark should be exposed to userspace and we have ABI for that.  Default is normally
set to 1 IIRC on basis it will look the same as a device without a fifo to userspace.
Possible we aren't consistent on that though.

> 
> 
>  drivers/iio/accel/fxls8962af-core.c | 215 +++++++++++++++++++++++++++-
>  1 file changed, 214 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
> index 848f3d68f5d4..2bd5c6d76b63 100644
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
> +#define FXLS8962AF_BC1_BUF_MODE_PREP(x)		FIELD_PREP(FXLS8962AF_BC1_BUF_MODE_MASK, x)
, (x))

Good practice to always bracket parameters to protect against odd inputs.

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
> @@ -133,6 +145,11 @@ struct fxls8962af_data {
>  	struct regmap *regmap;
>  	const struct fxls8962af_chip_info *chip_info;
>  	struct regulator *vdd_reg;
> +	struct {
> +		__le16 channels[3];
> +		s64 ts __aligned(8);
> +	} scan;
> +	int64_t timestamp, old_timestamp; /* Only used in hw fifo mode. */
>  	struct iio_mount_matrix orientation;
>  };
>  
> @@ -433,7 +450,10 @@ static int fxls8962af_read_raw(struct iio_dev *indio_dev,
>  			ret = fxls8962af_get_temp(data, val);
>  			break;
>  		case IIO_ACCEL:
> -			ret = fxls8962af_get_axis(data, chan, val);
> +			if (iio_buffer_enabled(indio_dev))

This races so use the claim_direct() stuff if you need the protection.
If you can drop it, then even better :)

> +				ret = -EBUSY;
> +			else
> +				ret = fxls8962af_get_axis(data, chan, val);
>  			break;
>  		default:
>  			ret = -EINVAL;
> @@ -572,6 +592,174 @@ static int fxls8962af_reset(struct fxls8962af_data *data)
>  	return ret;
>  }
>  
> +static int fxls8962af_fifo_set_mode(struct fxls8962af_data *data, bool onoff)
> +{
> +	int ret;
> +
> +	ret = regmap_update_bits(data->regmap, FXLS8962AF_BUF_CONFIG1,
> +				 FXLS8962AF_BC1_BUF_MODE_MASK,
> +				 FXLS8962AF_BC1_BUF_MODE_PREP(onoff));
> +
> +	return ret;

return regmap_update_bits(...

> +}

one line.

> +
> +
> +static int fxls8962af_buffer_preenable(struct iio_dev *indio_dev)
> +{
> +	struct fxls8962af_data *data = iio_priv(indio_dev);
> +
> +	return fxls8962af_power_on(data);

No real point in bothering with the local variable.

	fxls8962af_power_on(iio_priv(indio_dev));

> +}
> +
> +static int fxls8962af_buffer_postenable(struct iio_dev *indio_dev)
> +{
> +	struct fxls8962af_data *data = iio_priv(indio_dev);
> +	int ret = 0;

Don't think this value is used anywhere.

> +
> +	if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED)
> +		return 0;
> +
> +	fxls8962af_standby(data);
> +
> +	/* Enable buffer interrupt*/
> +	ret = regmap_update_bits(data->regmap, FXLS8962AF_INT_EN,
> +			FXLS8962AF_INT_EN_BUF_EN,
> +			FXLS8962AF_INT_EN_BUF_EN);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Enable watermark at max fifo size*/
> +	ret = regmap_update_bits(data->regmap, FXLS8962AF_BUF_CONFIG2,
> +			FXLS8962AF_BUF_CONFIG2_BUF_WMRK,
> +			FXLS8962AF_BUF_CONFIG2_BUF_WMRK / 2);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = fxls8962af_fifo_set_mode(data, true);
> +
> +	fxls8962af_active(data);
> +
> +	return ret;
> +}
> +
> +static int fxls8962af_buffer_predisable(struct iio_dev *indio_dev)
> +{
> +	struct fxls8962af_data *data = iio_priv(indio_dev);
> +	int ret = 0;
> +
> +	if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED)
> +		return 0;

Are you currently supporting this? 

> +
> +	fxls8962af_standby(data);
> +
> +	/* Disable buffer interrupt*/
> +	ret = regmap_update_bits(data->regmap, FXLS8962AF_INT_EN,
> +			FXLS8962AF_INT_EN_BUF_EN, 0);
> +	if (ret < 0)
> +		return ret;
> +
> +	fxls8962af_fifo_set_mode(data, false);
> +
> +	fxls8962af_active(data);
> +
> +	return 0;
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
> +				    char *buffer, int samples)

Why use a char * for buffer rather than the u16 it seems to be below?

> +{
> +	struct device *dev = regmap_get_device(data->regmap);
> +	int sample_length = 3 * 2;

3 * sizeof(*buffer) having fixed the type of that to u16 *

> +	int ret;
> +	int total_length = samples * sample_length;
> +
> +	ret = regmap_raw_read(data->regmap, FXLS8962AF_BUF_X_LSB, buffer,
> +			      total_length);
> +	if (ret < 0)
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
> +	if (ret < 0)
> +		return ret;
> +
> +	if (reg & FXLS8962AF_BUF_STATUS_BUF_OVF) {
> +		dev_err(dev, "Buffer overflown");
> +		return -1;
> +	}
> +
> +	count = reg & FXLS8962AF_BUF_STATUS_BUF_CNT;
> +
> +	if (!count)
> +		return 0;
> +
> +	data->old_timestamp = data->timestamp;
> +	data->timestamp = iio_get_time_ns(indio_dev);
> +
> +	/* Approximate timestamps for each of the sample based on the sampling,
/* 
 * Approximate

It's a bit kernel subsystem dependent but in IIO I try to keep us to this style.

> +	 * frequency, timestamp for last sample and number of samples.
> +	 */
> +	sample_period = (data->timestamp - data->old_timestamp);
> +	do_div(sample_period, count);
> +	tstamp = data->timestamp - (count - 1) * sample_period;
> +
> +

Single blank line.

> +	ret = fxls8962af_fifo_transfer(data, (u8 *)buffer, count);

As mentioned above change the type this takes to u16 * to avoid casting
fun that I don't think adds anything useful.

> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Ideally we want the IIO core to handle the demux when running in fifo
> +	 * mode but not when running in triggered buffer mode. Unfortunately
> +	 * this does not seem to be possible, so stick with driver demux for
> +	 * now.

At the moment I don't think you are supporting triggered buffer mode, so I'm
not totally sure what you mean here.  If you just mean the necessary parsing
of the hardware fifo input into the layout for the kfifo, then that's something
we've discussed a few times IIRC, but I'm not sure what needs doing is quite
consistent enough to make it practical.

> +	 */
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
> @@ -583,9 +771,32 @@ static irqreturn_t fxls8962af_interrupt(int irq, void *p)
>  	if (ret < 0)
>  		return IRQ_NONE;
>  
> +	if (reg & FXLS8962AF_INT_STATUS_SRC_BUF) {
> +		ret = fxls8962af_fifo_flush(indio_dev);
> +		if (ret < 0)
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
> @@ -751,6 +962,8 @@ int fxls8962af_core_probe(struct device *dev, struct regmap *regmap, int irq)
>  		ret = fxls8962af_irq_setup(indio_dev, irq);
>  		if (ret < 0)
>  			return ret;
> +
> +		fxls8962af_fifo_setup(indio_dev);
>  	}
>  
>  	ret = pm_runtime_set_active(dev);

