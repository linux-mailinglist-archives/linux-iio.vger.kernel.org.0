Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9DCB370E4A
	for <lists+linux-iio@lfdr.de>; Sun,  2 May 2021 19:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232151AbhEBRyA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 May 2021 13:54:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:41132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230110AbhEBRyA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 2 May 2021 13:54:00 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 167A8610FC;
        Sun,  2 May 2021 17:53:05 +0000 (UTC)
Date:   Sun, 2 May 2021 18:53:57 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ivan Mikhaylov <i.mikhaylov@yadro.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-hwmon@vger.kernel.org>
Subject: Re: [PATCH 3/4] iio: proximity: vncl3020: remove mutex from
 vcnl3020_data
Message-ID: <20210502185357.2d868cd2@jic23-huawei>
In-Reply-To: <20210430152419.261757-4-i.mikhaylov@yadro.com>
References: <20210430152419.261757-1-i.mikhaylov@yadro.com>
        <20210430152419.261757-4-i.mikhaylov@yadro.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 30 Apr 2021 18:24:18 +0300
Ivan Mikhaylov <i.mikhaylov@yadro.com> wrote:

> Remove the mutex from vcnl3020_data structure and change it on
> iio_device_claim_direct_mode/iio_device_release_direct_mode.
> 
> Signed-off-by: Ivan Mikhaylov <i.mikhaylov@yadro.com>
I'm not keen on doing this.  The reason is that
iio_device_claim_direct_mode() is today implemented via a mutex which could
be used as you have it here, but... It might not be in the future.
I can see we might for example optimize it to allow multiple concurrent
accesses that assume direct mode.

So don't make assumptions about what it does.  It should be used if
you are protecting against the device entering (or already being in) a buffered
mode, but nothing else.

If other scope is needed, then stick to a local lock.  It's perfectly
fine to claim direct mode and take a lock of course if you are protecting
against different things.

Jonathan

> ---
>  drivers/iio/proximity/vcnl3020.c | 40 ++++++++++++++++++--------------
>  1 file changed, 22 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/iio/proximity/vcnl3020.c b/drivers/iio/proximity/vcnl3020.c
> index 0dfa6a0b5eec..bff59c7af966 100644
> --- a/drivers/iio/proximity/vcnl3020.c
> +++ b/drivers/iio/proximity/vcnl3020.c
> @@ -71,13 +71,11 @@ static const int vcnl3020_prox_sampling_frequency[][2] = {
>   * @regmap:	device register map.
>   * @dev:	vcnl3020 device.
>   * @rev:	revision id.
> - * @lock:	lock for protecting access to device hardware registers.
>   */
>  struct vcnl3020_data {
>  	struct regmap *regmap;
>  	struct device *dev;
>  	u8 rev;
> -	struct mutex lock;
>  };
>  
>  /**
> @@ -149,7 +147,6 @@ static int vcnl3020_init(struct vcnl3020_data *data)
>  	}
>  
>  	data->rev = reg;
> -	mutex_init(&data->lock);
>  
>  	return vcnl3020_get_and_apply_property(data,
>  					       vcnl3020_led_current_property);
> @@ -161,11 +158,9 @@ static int vcnl3020_measure_proximity(struct vcnl3020_data *data, int *val)
>  	unsigned int reg;
>  	__be16 res;
>  
> -	mutex_lock(&data->lock);
> -
>  	rc = regmap_write(data->regmap, VCNL_COMMAND, VCNL_PS_OD);
>  	if (rc)
> -		goto err_unlock;
> +		return rc;
>  
>  	/* wait for data to become ready */
>  	rc = regmap_read_poll_timeout(data->regmap, VCNL_COMMAND, reg,
> @@ -174,20 +169,17 @@ static int vcnl3020_measure_proximity(struct vcnl3020_data *data, int *val)
>  	if (rc) {
>  		dev_err(data->dev,
>  			"Error (%d) reading vcnl3020 command register\n", rc);
> -		goto err_unlock;
> +		return rc;
>  	}
>  
>  	/* high & low result bytes read */
>  	rc = regmap_bulk_read(data->regmap, VCNL_PS_RESULT_HI, &res,
>  			      sizeof(res));
>  	if (rc)
> -		goto err_unlock;
> +		return rc;
>  
>  	*val = be16_to_cpu(res);
>  
> -err_unlock:
> -	mutex_unlock(&data->lock);
> -
>  	return rc;
>  }
>  
> @@ -450,25 +442,37 @@ static int vcnl3020_read_raw(struct iio_dev *indio_dev,
>  	int rc;
>  	struct vcnl3020_data *data = iio_priv(indio_dev);
>  
> +	rc = iio_device_claim_direct_mode(indio_dev);
> +	if (rc)
> +		return rc;
> +
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
>  
>  		/* Protect against event capture. */
> -		if (vcnl3020_is_in_periodic_mode(data))
> -			return -EBUSY;
> +		if (vcnl3020_is_in_periodic_mode(data)) {
> +			rc = -EBUSY;
> +			goto end;
> +		}
>  
>  		rc = vcnl3020_measure_proximity(data, val);
>  		if (rc)
> -			return rc;
> -		return IIO_VAL_INT;
> +			goto end;
> +		rc = IIO_VAL_INT;
> +		goto end;
>  	case IIO_CHAN_INFO_SAMP_FREQ:
>  		rc = vcnl3020_read_proxy_samp_freq(data, val, val2);
>  		if (rc < 0)
> -			return rc;
> -		return IIO_VAL_INT_PLUS_MICRO;
> +			goto end;
> +		rc = IIO_VAL_INT_PLUS_MICRO;
> +		goto end;
>  	default:
> -		return -EINVAL;
> +		rc = -EINVAL;
>  	}
> +
> +end:
> +	iio_device_release_direct_mode(indio_dev);
> +	return rc;
>  }
>  
>  static int vcnl3020_write_raw(struct iio_dev *indio_dev,

