Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9FDA37FBCE
	for <lists+linux-iio@lfdr.de>; Thu, 13 May 2021 18:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232602AbhEMQxW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 13 May 2021 12:53:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:40838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230037AbhEMQxV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 13 May 2021 12:53:21 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79BDB613CA;
        Thu, 13 May 2021 16:52:08 +0000 (UTC)
Date:   Thu, 13 May 2021 17:53:16 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linux-iio@vger.kernel.org, Julia Lawall <Julia.Lawall@inria.fr>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 24/28] iio: temp: mlx90614: Handle failure in
 pm_runtime_resume_and_get()
Message-ID: <20210513175316.1fa0f479@jic23-huawei>
In-Reply-To: <20210512165150.2250356e@coco.lan>
References: <20210509113354.660190-1-jic23@kernel.org>
        <20210509113354.660190-25-jic23@kernel.org>
        <20210512165150.2250356e@coco.lan>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 12 May 2021 16:51:57 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Em Sun,  9 May 2021 12:33:50 +0100
> Jonathan Cameron <jic23@kernel.org> escreveu:
> 
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Converts from using pm_runtime_get_sync() with no error handling over
> > to pm_runtime_resume_and_get() which will ensure we don't end up
> > holding a reference.  Ensure this error return is then handled at
> > calls to mlx90614_power_get(). These are all direct returns.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>  
> 
> LGTM.
> 
> Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Applied,

Thanks,

Jonathan

> 
> > ---
> >  drivers/iio/temperature/mlx90614.c | 25 ++++++++++++++++++++-----
> >  1 file changed, 20 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/iio/temperature/mlx90614.c b/drivers/iio/temperature/mlx90614.c
> > index ef0fec94d269..afcb10ea7c44 100644
> > --- a/drivers/iio/temperature/mlx90614.c
> > +++ b/drivers/iio/temperature/mlx90614.c
> > @@ -176,11 +176,14 @@ static inline s32 mlx90614_iir_search(const struct i2c_client *client,
> >  static int mlx90614_power_get(struct mlx90614_data *data, bool startup)
> >  {
> >  	unsigned long now;
> > +	int ret;
> >  
> >  	if (!data->wakeup_gpio)
> >  		return 0;
> >  
> > -	pm_runtime_get_sync(&data->client->dev);
> > +	ret = pm_runtime_resume_and_get(&data->client->dev);
> > +	if (ret < 0)
> > +		return ret;
> >  
> >  	if (startup) {
> >  		now = jiffies;
> > @@ -267,7 +270,10 @@ static int mlx90614_read_raw(struct iio_dev *indio_dev,
> >  		*val = MLX90614_CONST_SCALE;
> >  		return IIO_VAL_INT;
> >  	case IIO_CHAN_INFO_CALIBEMISSIVITY: /* 1/65535 / LSB */
> > -		mlx90614_power_get(data, false);
> > +		ret = mlx90614_power_get(data, false);
> > +		if (ret < 0)
> > +			return ret;
> > +
> >  		mutex_lock(&data->lock);
> >  		ret = i2c_smbus_read_word_data(data->client,
> >  					       MLX90614_EMISSIVITY);
> > @@ -287,7 +293,10 @@ static int mlx90614_read_raw(struct iio_dev *indio_dev,
> >  		return IIO_VAL_INT_PLUS_NANO;
> >  	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY: /* IIR setting with
> >  							     FIR = 1024 */
> > -		mlx90614_power_get(data, false);
> > +		ret = mlx90614_power_get(data, false);
> > +		if (ret < 0)
> > +			return ret;
> > +
> >  		mutex_lock(&data->lock);
> >  		ret = i2c_smbus_read_word_data(data->client, MLX90614_CONFIG);
> >  		mutex_unlock(&data->lock);
> > @@ -319,7 +328,10 @@ static int mlx90614_write_raw(struct iio_dev *indio_dev,
> >  		val = val * MLX90614_CONST_RAW_EMISSIVITY_MAX +
> >  			val2 / MLX90614_CONST_EMISSIVITY_RESOLUTION;
> >  
> > -		mlx90614_power_get(data, false);
> > +		ret = mlx90614_power_get(data, false);
> > +		if (ret < 0)
> > +			return ret;
> > +
> >  		mutex_lock(&data->lock);
> >  		ret = mlx90614_write_word(data->client, MLX90614_EMISSIVITY,
> >  					  val);
> > @@ -331,7 +343,10 @@ static int mlx90614_write_raw(struct iio_dev *indio_dev,
> >  		if (val < 0 || val2 < 0)
> >  			return -EINVAL;
> >  
> > -		mlx90614_power_get(data, false);
> > +		ret = mlx90614_power_get(data, false);
> > +		if (ret < 0)
> > +			return ret;
> > +
> >  		mutex_lock(&data->lock);
> >  		ret = mlx90614_iir_search(data->client,
> >  					  val * 100 + val2 / 10000);  
> 
> 
> 
> Thanks,
> Mauro

