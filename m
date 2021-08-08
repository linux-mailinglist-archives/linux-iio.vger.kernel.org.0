Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0ED3E3B1D
	for <lists+linux-iio@lfdr.de>; Sun,  8 Aug 2021 17:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbhHHPd4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 Aug 2021 11:33:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:52838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229923AbhHHPd4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 8 Aug 2021 11:33:56 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8C2F60EAF;
        Sun,  8 Aug 2021 15:33:35 +0000 (UTC)
Date:   Sun, 8 Aug 2021 16:36:25 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Puranjay Mohan <puranjay12@gmail.com>
Cc:     Michael.Hennerich@analog.com, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        lars@metafoo.de, Dragos.Bogdan@analog.com, Darius.Berghe@analog.com
Subject: Re: [PATCH v8 3/3] iio: accel: adxl355: Add triggered buffer
 support
Message-ID: <20210808163625.33e1153b@jic23-huawei>
In-Reply-To: <20210808162936.7066403b@jic23-huawei>
References: <20210804140309.31468-1-puranjay12@gmail.com>
        <20210804140309.31468-4-puranjay12@gmail.com>
        <20210808162936.7066403b@jic23-huawei>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 8 Aug 2021 16:29:36 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Wed,  4 Aug 2021 19:33:09 +0530
> Puranjay Mohan <puranjay12@gmail.com> wrote:
> 
> > Provide a way for continuous data capture by setting up buffer support. The
> > data ready signal exposed at the DRDY pin of the ADXL355 is exploited as
> > a hardware interrupt which triggers to fill the buffer.
> > 
> > Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>  
> 
> Hi Puranjay,
> 
> This device has a hardware fifo, so we need to be careful how we add
> trigger support such that we can enable that smoothly.
Oops. I meant to come back and add some detail on this after taking a look
at the datasheet.

The device has an explicit data ready pin to indicate 'any data' not using
the fifo.  That's helpful for this mode.  I note that there is a way of
turning it off which is good and you should ensure it is off, except when
the trigger is enabled so that we aren't dealing with a stream of spurious
interrupts.

I would encourage you to also get the fifo mode up and running before sending
a new version of this patch.  It may well be the case that there is little
point in supporting this mode as it's just a special case of fifo mode with
the watermark set to 1.

> 
> There are a few things in here that suggest this isn't tested as much
> as I'd expect for a submission.  If you are posting early, but need
> to do more testing, please state that clearly.
> 
> Jonathan
> 
> > ---
> >  drivers/iio/accel/Kconfig        |   4 ++
> >  drivers/iio/accel/adxl355.h      |   2 +-
> >  drivers/iio/accel/adxl355_core.c | 102 ++++++++++++++++++++++++++++++-
> >  drivers/iio/accel/adxl355_i2c.c  |   3 +-
> >  drivers/iio/accel/adxl355_spi.c  |   2 +-
> >  5 files changed, 108 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> > index d0c45c809..9c16c1841 100644
> > --- a/drivers/iio/accel/Kconfig
> > +++ b/drivers/iio/accel/Kconfig
> > @@ -69,6 +69,8 @@ config ADXL355_I2C
> >  	depends on I2C
> >  	select ADXL355
> >  	select REGMAP_I2C
> > +	select IIO_BUFFER
> > +	select IIO_TRIGGERED_BUFFER
> >  	help
> >  	  Say Y here if you want to build i2c support for the Analog Devices
> >  	  ADXL355 3-axis digital accelerometer.
> > @@ -82,6 +84,8 @@ config ADXL355_SPI
> >  	depends on SPI
> >  	select ADXL355
> >  	select REGMAP_SPI
> > +	select IIO_BUFFER
> > +	select IIO_TRIGGERED_BUFFER
> >  	help
> >  	  Say Y here if you want to build spi support for the Analog Devices
> >  	  ADXL355 3-axis digital accelerometer.
> > diff --git a/drivers/iio/accel/adxl355.h b/drivers/iio/accel/adxl355.h
> > index 322b0abb8..f0a376e6d 100644
> > --- a/drivers/iio/accel/adxl355.h
> > +++ b/drivers/iio/accel/adxl355.h
> > @@ -15,5 +15,5 @@ extern const struct regmap_access_table adxl355_readable_regs_tbl;
> >  extern const struct regmap_access_table adxl355_writeable_regs_tbl;
> >  
> >  int adxl355_core_probe(struct device *dev, struct regmap *regmap,
> > -		       const char *name);
> > +		       const char *name, int irq);
> >  #endif /* _ADXL355_H_ */
> > diff --git a/drivers/iio/accel/adxl355_core.c b/drivers/iio/accel/adxl355_core.c
> > index 47fbb31bc..f9dc2a530 100644
> > --- a/drivers/iio/accel/adxl355_core.c
> > +++ b/drivers/iio/accel/adxl355_core.c
> > @@ -9,6 +9,10 @@
> >  
> >  #include <asm/unaligned.h>
> >  #include <linux/bitfield.h>
> > +#include <linux/iio/buffer.h>
> > +#include <linux/iio/trigger.h>
> > +#include <linux/iio/triggered_buffer.h>
> > +#include <linux/iio/trigger_consumer.h>
> >  #include <linux/iio/iio.h>
> >  #include <linux/limits.h>
> >  #include <linux/math64.h>
> > @@ -172,6 +176,7 @@ static const struct adxl355_chan_info adxl355_chans[] = {
> >  };
> >  
> >  struct adxl355_data {
> > +	int irq;
> >  	struct regmap *regmap;
> >  	struct device *dev;
> >  	struct mutex lock; /* lock to protect op_mode */
> > @@ -181,6 +186,12 @@ struct adxl355_data {
> >  	int calibbias[3];
> >  	int adxl355_hpf_3db_table[7][2];
> >  	u8 transf_buf[3] ____cacheline_aligned;
> > +	struct iio_trigger      *dready_trig;
> > +	/* Ensure correct alignment of timestamp when present */
> > +	struct {
> > +		__be32 channels[3];
> > +		s64 ts;
> > +	} buffer ____cacheline_aligned;  
> 
> Interesting quirk here is that we need to ensure that any of the
> buffers used for DMA don't share a cacheline with other data, but we don't
> need to ensure they don't share with each other.  As such, this can
> share fine with transf_buf, but definitely not with dready_trig (which
> can't share with transf_buf like it is right now).
> 
> So reorder to put the various DMA safe buffers at the end, and ensure
> the first one is cacheline aligned.
> 
> Even better, given you can only safely access one at a time anyway
> (and I think you always hold the lock so that is fine), put them in a union
> to make it explicit that only one is used at a time.
> 
> struct iio_trigger *dready_trig;
> union {
> 	u8 trans_buf[3];
> 	struct {
> 		__be32 channels[3];
> 		s64 ts;
> 	} buffer;
> } ___cacheline_algned;
> or something like that.
> 
> 
> 
> >  };
> >  
> >  static int adxl355_set_op_mode(struct adxl355_data *data,
> > @@ -499,12 +510,46 @@ static int adxl355_read_avail(struct iio_dev *indio_dev,
> >  	}
> >  }
> >  
> > +static const unsigned long adxl355_avail_scan_masks[] = {
> > +	GENMASK(3, 0),
> > +	0
> > +};
> > +
> >  static const struct iio_info adxl355_info = {
> >  	.read_raw	= adxl355_read_raw,
> >  	.write_raw	= adxl355_write_raw,
> >  	.read_avail	= &adxl355_read_avail
> >  };
> >  
> > +static const struct iio_trigger_ops adxl355_trigger_ops = {
> > +	.validate_device = &iio_trigger_validate_own_device,  
> 
> No means of turning it on?
> 
> > +};
> > +
> > +static irqreturn_t adxl355_trigger_handler(int irq, void *p)
> > +{
> > +	struct iio_poll_func *pf = p;
> > +	struct iio_dev *indio_dev = pf->indio_dev;
> > +	struct adxl355_data *data = iio_priv(indio_dev);
> > +	int ret;
> > +
> > +	mutex_lock(&data->lock);
> > +
> > +	ret = regmap_bulk_read(data->regmap, ADXL355_XDATA3_REG,
> > +			       data->buffer.channels,
> > +			       9);  
> 
> That doesn't look right.  you are reading 9 bytes into an array of 3 __be32 channels.
> You should check the data is turning up where it should.
> 
> 
> > +	if (ret)
> > +		goto out_unlock_notify;
> > +
> > +	iio_push_to_buffers_with_timestamp(indio_dev, &data->buffer,
> > +					   pf->timestamp);
> > +
> > +out_unlock_notify:
> > +	mutex_unlock(&data->lock);
> > +	iio_trigger_notify_done(indio_dev->trig);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> >  #define ADXL355_ACCEL_CHANNEL(index, reg, axis) {			\
> >  	.type = IIO_ACCEL,						\
> >  	.address = reg,							\
> > @@ -518,6 +563,7 @@ static const struct iio_info adxl355_info = {
> >  	.info_mask_shared_by_type_available =				\
> >  		BIT(IIO_CHAN_INFO_SAMP_FREQ) |				\
> >  		BIT(IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY),	\
> > +	.scan_index = index,						\
> >  	.scan_type = {							\
> >  		.sign = 's',						\
> >  		.realbits = 20,						\
> > @@ -537,17 +583,56 @@ static const struct iio_chan_spec adxl355_channels[] = {
> >  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> >  				      BIT(IIO_CHAN_INFO_SCALE) |
> >  				      BIT(IIO_CHAN_INFO_OFFSET),
> > +		.scan_index = 3,
> >  		.scan_type = {
> >  			.sign = 's',
> >  			.realbits = 12,
> >  			.storagebits = 16,
> >  			.endianness = IIO_BE,
> >  		},
> > -	}
> > +	},  
> 
> If you do end up respinning patch 2, add the comma in that patch as it'll reduced
> noise here.
> 
> > +	IIO_CHAN_SOFT_TIMESTAMP(4)
> >  };
> >  
> > +static int adxl355_probe_trigger(struct iio_dev *indio_dev)
> > +{
> > +	struct adxl355_data *data = iio_priv(indio_dev);
> > +	int ret;
> > +
> > +	if (!data->irq) {
> > +		dev_info(data->dev, "no irq, using polling\n");
> > +		return 0;
> > +	}
> > +
> > +	data->dready_trig = devm_iio_trigger_alloc(data->dev, "%s-dev%d",
> > +						   indio_dev->name,
> > +						   indio_dev->id);
> > +	if (!data->dready_trig)
> > +		return -ENOMEM;
> > +
> > +	data->dready_trig->ops = &adxl355_trigger_ops;
> > +	iio_trigger_set_drvdata(data->dready_trig, indio_dev);
> > +
> > +	ret = devm_request_irq(data->dev, data->irq,
> > +			       &iio_trigger_generic_data_rdy_poll,
> > +			       IRQF_ONESHOT, "adxl355_irq", data->dready_trig);
> > +	if (ret < 0)
> > +		return dev_err_probe(data->dev, ret, "request irq %d failed\n",
> > +				     data->irq);
> > +
> > +	ret = devm_iio_trigger_register(data->dev, data->dready_trig);
> > +	if (ret) {
> > +		dev_err(data->dev, "iio trigger register failed\n");
> > +		return ret;
> > +	}
> > +
> > +	indio_dev->trig = iio_trigger_get(data->dready_trig);
> > +
> > +	return 0;
> > +}
> > +
> >  int adxl355_core_probe(struct device *dev, struct regmap *regmap,
> > -		       const char *name)
> > +		       const char *name, int irq)
> >  {
> >  	struct adxl355_data *data;
> >  	struct iio_dev *indio_dev;
> > @@ -560,6 +645,7 @@ int adxl355_core_probe(struct device *dev, struct regmap *regmap,
> >  	data = iio_priv(indio_dev);
> >  	data->regmap = regmap;
> >  	data->dev = dev;
> > +	data->irq = irq;
> >  	data->op_mode = ADXL355_STANDBY;
> >  	mutex_init(&data->lock);
> >  
> > @@ -568,6 +654,7 @@ int adxl355_core_probe(struct device *dev, struct regmap *regmap,
> >  	indio_dev->modes = INDIO_DIRECT_MODE;
> >  	indio_dev->channels = adxl355_channels;
> >  	indio_dev->num_channels = ARRAY_SIZE(adxl355_channels);
> > +	indio_dev->available_scan_masks = adxl355_avail_scan_masks;
> >  
> >  	ret = adxl355_setup(data);
> >  	if (ret < 0) {
> > @@ -575,6 +662,17 @@ int adxl355_core_probe(struct device *dev, struct regmap *regmap,
> >  		return ret;
> >  	}
> >  
> > +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
> > +					      &iio_pollfunc_store_time,
> > +					      &adxl355_trigger_handler, NULL);
> > +	if (ret < 0)  
> 
> if (ret) preferred, because it is more consistent with returning devm_iio_device_register()
> below (where we are assuming negative or 0 only)
> 
> > +		return dev_err_probe(dev, ret,
> > +				     "iio triggered buffer setup failed\n");
> > +
> > +	ret = adxl355_probe_trigger(indio_dev);
> > +	if (ret < 0)
> > +		return ret;
> > +
> >  	return devm_iio_device_register(dev, indio_dev);
> >  }
> >  EXPORT_SYMBOL_GPL(adxl355_core_probe);
> > diff --git a/drivers/iio/accel/adxl355_i2c.c b/drivers/iio/accel/adxl355_i2c.c
> > index e3070ee81..c18521819 100644
> > --- a/drivers/iio/accel/adxl355_i2c.c
> > +++ b/drivers/iio/accel/adxl355_i2c.c
> > @@ -31,7 +31,8 @@ static int adxl355_i2c_probe(struct i2c_client *client)
> >  		return PTR_ERR(regmap);
> >  	}
> >  
> > -	return adxl355_core_probe(&client->dev, regmap, client->name);
> > +	return adxl355_core_probe(&client->dev, regmap, client->name,
> > +				  client->irq);  
> 
> We can't just use the first interrupt (which this corresponds to) because
> the device supports 3 and who knows if this is the right one?
> 
> Now to solve this, we run into a 'fun' issue.  We want to use the generic
> firmware property interfaces (include/linux/property.h) but that doesn't
> include a fwnode_irq_get_by_name()
> 
> We've had some recent discussion about this:
> https://lore.kernel.org/linux-iio/20210724190614.3593dcd1@jic23-huawei/
> 
> If it is something you would like to take on, that would be great.
> If not, for now use the of_irq_get_byname() method but add a comment
> saying it would good to move to a generic version.
> 
> >  }
> >  
> >  static const struct i2c_device_id adxl355_i2c_id[] = {
> > diff --git a/drivers/iio/accel/adxl355_spi.c b/drivers/iio/accel/adxl355_spi.c
> > index a16bd1407..f9ba153f6 100644
> > --- a/drivers/iio/accel/adxl355_spi.c
> > +++ b/drivers/iio/accel/adxl355_spi.c
> > @@ -34,7 +34,7 @@ static int adxl355_spi_probe(struct spi_device *spi)
> >  		return PTR_ERR(regmap);
> >  	}
> >  
> > -	return adxl355_core_probe(&spi->dev, regmap, id->name);
> > +	return adxl355_core_probe(&spi->dev, regmap, id->name, spi->irq);
> >  }
> >  
> >  static const struct spi_device_id adxl355_spi_id[] = {  
> 

