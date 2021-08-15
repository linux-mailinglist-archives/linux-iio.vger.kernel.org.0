Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC3303EC9CE
	for <lists+linux-iio@lfdr.de>; Sun, 15 Aug 2021 17:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232896AbhHOPCM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Aug 2021 11:02:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:57226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232412AbhHOPCM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Aug 2021 11:02:12 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D337D6115A;
        Sun, 15 Aug 2021 15:01:33 +0000 (UTC)
Date:   Sun, 15 Aug 2021 16:04:32 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Puranjay Mohan <puranjay12@gmail.com>
Cc:     Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, lars@metafoo.de,
        Dragos.Bogdan@analog.com, Darius.Berghe@analog.com,
        andy.shevchenko@gmail.com
Subject: Re: [PATCH] iio: accel: adxl355: Add triggered buffer support
Message-ID: <20210815160432.7be30909@jic23-huawei>
In-Reply-To: <20210813083455.252986-1-puranjay12@gmail.com>
References: <20210813083455.252986-1-puranjay12@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 13 Aug 2021 14:04:55 +0530
Puranjay Mohan <puranjay12@gmail.com> wrote:

> Provide a way for continuous data capture by setting up buffer support. The
> data ready signal exposed at the DRDY pin of the ADXL355 is exploited as
> a hardware interrupt which triggers to fill the buffer.
> 
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>

Hi.

A few comments additions to add to what Andy has highlighted.
Other than these details and those Andy highlighted, this looks good to me.

...

> @@ -157,6 +162,7 @@ static const struct adxl355_chan_info adxl355_chans[] = {
>  };
>  
>  struct adxl355_data {
> +	int irq;
>  	struct regmap *regmap;
>  	struct device *dev;
>  	struct mutex lock; /* lock to protect op_mode */
> @@ -165,7 +171,14 @@ struct adxl355_data {
>  	enum adxl355_hpf_3db hpf_3db;
>  	int calibbias[3];
>  	int adxl355_hpf_3db_table[7][2];
> -	u8 transf_buf[3] ____cacheline_aligned;
> +	struct iio_trigger      *dready_trig;

As the rest of the structure doesn't have extra spaces
for alignment of variable names, don't do it here either.

> +	union {
> +		u8 transf_buf[3];
> +		struct {
> +			u8 buf[14];
> +			s64 ts;
> +		} buffer;
> +	} ____cacheline_aligned;
>  };
>  
>  static int adxl355_set_op_mode(struct adxl355_data *data,
> @@ -186,6 +199,23 @@ static int adxl355_set_op_mode(struct adxl355_data *data,
>  	return ret;
>  }
>  


...

> +static const struct iio_trigger_ops adxl355_trigger_ops = {
> +	.set_trigger_state = &adxl355_data_rdy_trigger_set_state,
> +	.validate_device = &iio_trigger_validate_own_device,
> +};
> +
> +static irqreturn_t adxl355_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct adxl355_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	mutex_lock(&data->lock);
> +
> +	ret = regmap_bulk_read(data->regmap, ADXL355_XDATA3_REG,
> +			       &data->buffer.buf[1],

I would add some comments on the data layout here given you are
writing the bottom 24bits of a 32 bit big endian variable and that
may be non obvious.

There is also an issue as a result of the union used for the buffer.
It is (I think) possible that earlier read has put a non 0 value
into transf_buf[0].  Now C doesn't guarantee that will be visible
if accessed via buffer.buf[0], but it's certainly possible.
As such you may get garbage in that top byte.  It's not a 'problem'
from an ABI point of view, but it might well confused someone
who is for example logging the data stream unprocessed.
We have drivers where the hardware puts something in the bits
that will get screened out using the type (often status info and
similar) but we probably don't want it to be from an entirely different
read or write.

Perhaps just set buf[0] = 0 somewhere in this funciton with a comment
on why.

> +			       3);
> +	if (ret)
> +		goto out_unlock_notify;
> +

...

>  
> +static int adxl355_probe_trigger(struct iio_dev *indio_dev)
> +{
> +	struct adxl355_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	if (!data->irq) {
> +		dev_info(data->dev, "no irq, using polling\n");
> +		return 0;
> +	}
> +
> +	data->dready_trig = devm_iio_trigger_alloc(data->dev, "%s-dev%d",
> +						   indio_dev->name,
> +						   indio_dev->id);
> +	if (!data->dready_trig)
> +		return -ENOMEM;
> +
> +	data->dready_trig->ops = &adxl355_trigger_ops;
> +	iio_trigger_set_drvdata(data->dready_trig, indio_dev);
> +
> +	ret = devm_request_irq(data->dev, data->irq,
> +			       &iio_trigger_generic_data_rdy_poll,
> +			       IRQF_ONESHOT, "adxl355_irq", data->dready_trig);
> +	if (ret < 0)
if (ret)

If you follow through what devm_request_irq calls, you will see
devm_request_threaded_irq internally checks for errors with if (rc) so
we should do the same here.  It would also be more consistent with the
rest of your code in this function.

> +		return dev_err_probe(data->dev, ret, "request irq %d failed\n",
> +				     data->irq);
> +
> +	ret = devm_iio_trigger_register(data->dev, data->dready_trig);
> +	if (ret) {
> +		dev_err(data->dev, "iio trigger register failed\n");
> +		return ret;
> +	}
> +
> +	indio_dev->trig = iio_trigger_get(data->dready_trig);
> +
> +	return 0;
> +}
> +
>  int adxl355_core_probe(struct device *dev, struct regmap *regmap,
>  		       const char *name)
>  {
> @@ -563,18 +692,37 @@ int adxl355_core_probe(struct device *dev, struct regmap *regmap,
>  	data->op_mode = ADXL355_STANDBY;
>  	mutex_init(&data->lock);
>  
> +	/*
> +	 * Would be good to move it to the generic version.
> +	 */
> +	ret = of_irq_get_byname(dev->of_node, "DRDY");
> +	if (ret > 0)
> +		data->irq = ret;
> +
>  	indio_dev->name = name;
>  	indio_dev->info = &adxl355_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->channels = adxl355_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(adxl355_channels);
> +	indio_dev->available_scan_masks = adxl355_avail_scan_masks;
>  
>  	ret = adxl355_setup(data);
> -	if (ret < 0) {
> +	if (ret) {

Nitpick. Ideally this would have been in an earlier patch, but it's trivial here so
I'm not that bothered (so don't bother moving it).

>  		dev_err(dev, "ADXL355 setup failed\n");
>  		return ret;
>  	}
>  
> +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
> +					      &iio_pollfunc_store_time,
> +					      &adxl355_trigger_handler, NULL);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "iio triggered buffer setup failed\n");
> +
> +	ret = adxl355_probe_trigger(indio_dev);
> +	if (ret)
> +		return ret;
> +
>  	return devm_iio_device_register(dev, indio_dev);
>  }
>  EXPORT_SYMBOL_GPL(adxl355_core_probe);

