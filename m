Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E01B81DFF24
	for <lists+linux-iio@lfdr.de>; Sun, 24 May 2020 15:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728403AbgEXNih (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 24 May 2020 09:38:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:35732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbgEXNih (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 24 May 2020 09:38:37 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E9BE20878;
        Sun, 24 May 2020 13:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590327515;
        bh=rgDtiiZkuP0WaMXUBcY+ZQBNE08tb64n4l11jGM/PRM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JEay15jsDP5myvzwvbjr2GWxsJlw0tTb3ZiauAt5bqJlWFVevOzd14iI49yfq56ri
         pyGnS47DCoaMJBDHRBswz3o4xBrma7QYO1z17JdTbMPjfytlqElJJm7U3QI2aOYSob
         0PB7pWz76gqkUDQcwgCQcAKJhN/5D9J3sHWffC0o=
Date:   Sun, 24 May 2020 14:38:30 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>, <shawnguo@kernel.org>,
        <s.hauer@pengutronix.de>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <linus.walleij@linaro.org>,
        <lorenzo.bianconi83@gmail.com>, <songqiang1304521@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 3/3] iio: remove
 iio_triggered_buffer_postenable()/iio_triggered_buffer_predisable()
Message-ID: <20200524143830.11c2d97e@archlinux>
In-Reply-To: <20200522104632.517470-3-alexandru.ardelean@analog.com>
References: <20200522104632.517470-1-alexandru.ardelean@analog.com>
        <20200522104632.517470-3-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 22 May 2020 13:46:32 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> From: Lars-Peter Clausen <lars@metafoo.de>
> 
> This patch should be squashed into the first one, as the first one is
> breaking the build (intentionally) to make the IIO core files easier to
> review.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

Yeah!  Didn't realise you'd finally gotten to the end of your mammoth rework
leading to this.

A few really minor things inline to tidy up.

Thanks,

Jonathan

 
> diff --git a/drivers/iio/accel/st_accel_buffer.c b/drivers/iio/accel/st_accel_buffer.c
> index b5c814ef1637..c87f9a7d2453 100644
> --- a/drivers/iio/accel/st_accel_buffer.c
> +++ b/drivers/iio/accel/st_accel_buffer.c
> @@ -33,13 +33,9 @@ static int st_accel_buffer_postenable(struct iio_dev *indio_dev)
>  {
>  	int err;
>  
> -	err = iio_triggered_buffer_postenable(indio_dev);
> -	if (err < 0)
> -		return err;
> -
>  	err = st_sensors_set_axis_enable(indio_dev, indio_dev->active_scan_mask[0]);
>  	if (err < 0)
> -		goto st_accel_buffer_predisable;
> +		return err;
>  
>  	err = st_sensors_set_enable(indio_dev, true);
>  	if (err < 0)
> @@ -49,8 +45,6 @@ static int st_accel_buffer_postenable(struct iio_dev *indio_dev)
>  
>  st_accel_buffer_enable_all_axis:
>  	st_sensors_set_axis_enable(indio_dev, ST_SENSORS_ENABLE_ALL_AXIS);
> -st_accel_buffer_predisable:
> -	iio_triggered_buffer_predisable(indio_dev);
>  	return err;
>  }
>  
> @@ -60,12 +54,10 @@ static int st_accel_buffer_predisable(struct iio_dev *indio_dev)
>  
>  	err = st_sensors_set_enable(indio_dev, false);
>  	if (err < 0)
> -		goto st_accel_buffer_predisable;
> -
> -	err = st_sensors_set_axis_enable(indio_dev, ST_SENSORS_ENABLE_ALL_AXIS);
> +		return err;
>  
> -st_accel_buffer_predisable:
> -	err2 = iio_triggered_buffer_predisable(indio_dev);
> +	err2 = st_sensors_set_axis_enable(indio_dev,
> +					  ST_SENSORS_ENABLE_ALL_AXIS);
>  	if (!err)
I don't think you can get here with err set.
>  		err = err2;
>  


...
  
> diff --git a/drivers/iio/gyro/st_gyro_buffer.c b/drivers/iio/gyro/st_gyro_buffer.c
> index 9c92ff7a82be..7b86502d5da3 100644
> --- a/drivers/iio/gyro/st_gyro_buffer.c
> +++ b/drivers/iio/gyro/st_gyro_buffer.c
> @@ -33,13 +33,9 @@ static int st_gyro_buffer_postenable(struct iio_dev *indio_dev)
>  {
>  	int err;
>  
> -	err = iio_triggered_buffer_postenable(indio_dev);
> -	if (err < 0)
> -		return err;
> -
>  	err = st_sensors_set_axis_enable(indio_dev, indio_dev->active_scan_mask[0]);
>  	if (err < 0)
> -		goto st_gyro_buffer_predisable;
> +		return err;
>  
>  	err = st_sensors_set_enable(indio_dev, true);
>  	if (err < 0)
> @@ -49,8 +45,6 @@ static int st_gyro_buffer_postenable(struct iio_dev *indio_dev)
>  
>  st_gyro_buffer_enable_all_axis:
>  	st_sensors_set_axis_enable(indio_dev, ST_SENSORS_ENABLE_ALL_AXIS);
> -st_gyro_buffer_predisable:
> -	iio_triggered_buffer_predisable(indio_dev);
>  	return err;
>  }
>  
> @@ -59,13 +53,8 @@ static int st_gyro_buffer_predisable(struct iio_dev *indio_dev)
>  	int err, err2;
>  
>  	err = st_sensors_set_enable(indio_dev, false);
> -	if (err < 0)
> -		goto st_gyro_buffer_predisable;

Previously we didn't bother trying to carry on if this failed. I don't think we
should start doing so now.

> -
> -	err = st_sensors_set_axis_enable(indio_dev, ST_SENSORS_ENABLE_ALL_AXIS);
>  
> -st_gyro_buffer_predisable:
> -	err2 = iio_triggered_buffer_predisable(indio_dev);
> +	err2 = st_sensors_set_axis_enable(indio_dev, ST_SENSORS_ENABLE_ALL_AXIS);
>  	if (!err)
>  		err = err2;
>  

...

> diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
> index 070d4cd0cf54..29d7af33efa1 100644
> --- a/drivers/iio/light/gp2ap020a00f.c
> +++ b/drivers/iio/light/gp2ap020a00f.c
> @@ -1390,12 +1390,6 @@ static int gp2ap020a00f_buffer_postenable(struct iio_dev *indio_dev)
>  
>  	mutex_lock(&data->lock);
I guess it doesn't matter, but no idea why this was ever under the local lock!

>  
> -	err = iio_triggered_buffer_postenable(indio_dev);
> -	if (err < 0) {
> -		mutex_unlock(&data->lock);
> -		return err;
> -	}
> -
>  	/*
>  	 * Enable triggers according to the scan_mask. Enabling either
>  	 * LIGHT_CLEAR or LIGHT_IR scan mode results in enabling ALS
> @@ -1430,8 +1424,6 @@ static int gp2ap020a00f_buffer_postenable(struct iio_dev *indio_dev)
>  		err = -ENOMEM;
>  
>  error_unlock:
> -	if (err < 0)
> -		iio_triggered_buffer_predisable(indio_dev);
>  	mutex_unlock(&data->lock);
>  
>  	return err;
> @@ -1465,8 +1457,6 @@ static int gp2ap020a00f_buffer_predisable(struct iio_dev *indio_dev)
>  	if (err == 0)
>  		kfree(data->buffer);
>  
> -	iio_triggered_buffer_predisable(indio_dev);
> -
>  	mutex_unlock(&data->lock);
>  
>  	return err;
  
...

> diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> index 2a4b3d331055..0fee767af026 100644
> --- a/drivers/iio/light/vcnl4000.c
> +++ b/drivers/iio/light/vcnl4000.c
> @@ -957,29 +957,20 @@ static int vcnl4010_buffer_postenable(struct iio_dev *indio_dev)
>  	int ret;
>  	int cmd;
>  
> -	ret = iio_triggered_buffer_postenable(indio_dev);
> -	if (ret)
> -		return ret;
> -
>  	/* Do not enable the buffer if we are already capturing events. */
> -	if (vcnl4010_is_in_periodic_mode(data)) {
> -		ret = -EBUSY;
> -		goto end;
> -	}
> +	if (vcnl4010_is_in_periodic_mode(data))
> +		return -EBUSY;
>  
>  	ret = i2c_smbus_write_byte_data(data->client, VCNL4010_INT_CTRL,
>  					VCNL4010_INT_PROX_EN);
>  	if (ret < 0)
> -		goto end;
> +		return ret;
>  
>  	cmd = VCNL4000_SELF_TIMED_EN | VCNL4000_PROX_EN;
> +	
>  	ret = i2c_smbus_write_byte_data(data->client, VCNL4000_COMMAND, cmd);
>  	if (ret < 0)
> -		goto end;
> -
> -	return 0;
> -end:
> -	iio_triggered_buffer_predisable(indio_dev);
> +		i2c_smbus_write_byte_data(data->client, VCNL4010_INT_CTRL, 0);
>  
>  	return ret;
>  }
> @@ -987,18 +978,14 @@ static int vcnl4010_buffer_postenable(struct iio_dev *indio_dev)
>  static int vcnl4010_buffer_predisable(struct iio_dev *indio_dev)
>  {
>  	struct vcnl4000_data *data = iio_priv(indio_dev);
> -	int ret, ret_disable;
> +	int ret, ret2;
>  
>  	ret = i2c_smbus_write_byte_data(data->client, VCNL4010_INT_CTRL, 0);
> -	if (ret < 0)
> -		goto end;
>  
> -	ret = i2c_smbus_write_byte_data(data->client, VCNL4000_COMMAND, 0);
> +	ret2 = i2c_smbus_write_byte_data(data->client, VCNL4000_COMMAND, 0);

hmm. This does change the flow a tiny bit.   I wonder if we really
care about carrying on if we get an error on the first write?
We are device not responding territory at that point.   Maybe just return
immediately and avoid the dance with the two ret variables?

>  
> -end:
> -	ret_disable = iio_triggered_buffer_predisable(indio_dev);
>  	if (ret == 0)
> -		ret = ret_disable;
> +		ret = ret2;
>  
>  	return ret;
>  }

...
  
>  static const struct iio_buffer_setup_ops st_press_buffer_setup_ops = {
> diff --git a/drivers/iio/pressure/zpa2326.c b/drivers/iio/pressure/zpa2326.c
> index 37fe851f89af..e082ad007b22 100644
> --- a/drivers/iio/pressure/zpa2326.c
> +++ b/drivers/iio/pressure/zpa2326.c
> @@ -1240,12 +1240,7 @@ static int zpa2326_preenable_buffer(struct iio_dev *indio_dev)
>  static int zpa2326_postenable_buffer(struct iio_dev *indio_dev)
>  {
>  	const struct zpa2326_private *priv = iio_priv(indio_dev);
> -	int                           err;
> -
> -	/* Plug our own trigger event handler. */
> -	err = iio_triggered_buffer_postenable(indio_dev);
> -	if (err)
> -		goto err;
> +	int                           err = 0;
>  
>  	if (!priv->waken) {
>  		/*
> @@ -1254,7 +1249,7 @@ static int zpa2326_postenable_buffer(struct iio_dev *indio_dev)
>  		 */
>  		err = zpa2326_clear_fifo(indio_dev, 0);
>  		if (err)
> -			goto err_buffer_predisable;
> +			goto out;
>  	}
>  
>  	if (!iio_trigger_using_own(indio_dev) && priv->waken) {
> @@ -1264,14 +1259,10 @@ static int zpa2326_postenable_buffer(struct iio_dev *indio_dev)
>  		 */
>  		err = zpa2326_config_oneshot(indio_dev, priv->irq);
>  		if (err)
> -			goto err_buffer_predisable;
> +			goto out;
>  	}
>  
> -	return 0;
> -
> -err_buffer_predisable:
> -	iio_triggered_buffer_predisable(indio_dev);
> -err:
> +out:
>  	zpa2326_err(indio_dev, "failed to enable buffering (%d)", err);

Doesn't this now print the error in the good path?

Probably still want the return 0.   It's a bit messier but I'd
just move the prints into the error paths and return directly from
each.   Will be cleaner code that this.


>  
>  	return err;
> @@ -1287,7 +1278,6 @@ static int zpa2326_postdisable_buffer(struct iio_dev *indio_dev)
>  static const struct iio_buffer_setup_ops zpa2326_buffer_setup_ops = {
>  	.preenable   = zpa2326_preenable_buffer,
>  	.postenable  = zpa2326_postenable_buffer,
> -	.predisable  = iio_triggered_buffer_predisable,
>  	.postdisable = zpa2326_postdisable_buffer
>  };
>  
