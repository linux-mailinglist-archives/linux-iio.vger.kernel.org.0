Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 076F6173E94
	for <lists+linux-iio@lfdr.de>; Fri, 28 Feb 2020 18:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbgB1RcY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 28 Feb 2020 12:32:24 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2482 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726077AbgB1RcX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 28 Feb 2020 12:32:23 -0500
Received: from lhreml709-cah.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 5222997A451B7B731BF7;
        Fri, 28 Feb 2020 17:32:22 +0000 (GMT)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 lhreml709-cah.china.huawei.com (10.201.108.32) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 28 Feb 2020 17:32:21 +0000
Received: from localhost (10.202.226.57) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 28 Feb
 2020 17:32:21 +0000
Date:   Fri, 28 Feb 2020 17:32:20 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Rohit Sarkar <rohitsarkar5398@gmail.com>
CC:     <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2] iio: adc: max1363: replace mlock with own lock
Message-ID: <20200228173220.00002f01@Huawei.com>
In-Reply-To: <5e5813b9.1c69fb81.e3d1a.5426@mx.google.com>
References: <5e5813b9.1c69fb81.e3d1a.5426@mx.google.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.57]
X-ClientProxiedBy: lhreml727-chm.china.huawei.com (10.201.108.78) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 28 Feb 2020 00:38:37 +0530
Rohit Sarkar <rohitsarkar5398@gmail.com> wrote:

> This change replaces indio_dev's mlock with the drivers own lock. In
> each case the lock is needed to protect the driver's own state.
> 
> Changes from v1:
> Fix indentation.
> Add a mutex_init() in the probe function.
> 
> Signed-off-by: Rohit Sarkar <rohitsarkar5398@gmail.com>
Worth taking into account that perhaps some of the mlock cases aren't
actually taking it for local purposes, but rather to explicitly stop
the core from changing between buffered and polled modes (chrdev and sysfs
access).

> ---
>  drivers/iio/adc/max1363.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
> index 5c2cc61b666e..b9557f957f3c 100644
> --- a/drivers/iio/adc/max1363.c
> +++ b/drivers/iio/adc/max1363.c
> @@ -169,6 +169,7 @@ struct max1363_state {
>  	const struct max1363_mode	*current_mode;
>  	u32				requestedmask;
>  	struct regulator		*reg;
> +	struct mutex lock;

Scope of locks (what they protect) should always be described.
So please add documentation explaining exactly what this is protecting.

>  
>  	/* Using monitor modes and buffer at the same time is
>  	   currently not supported */
> @@ -364,7 +365,7 @@ static int max1363_read_single_chan(struct iio_dev *indio_dev,
>  	struct max1363_state *st = iio_priv(indio_dev);
>  	struct i2c_client *client = st->client;
>  
> -	mutex_lock(&indio_dev->mlock);
> +	mutex_lock(&st->lock);

This one is actually about preventing state changes.  So it shouldn't be
directly accessing the lock, but it should be calling
iio_device_claim_direct_mode.  Take a look at what else that function
does.

For this driver things are more complex than normal though as we need
to prevent either switching between polled and buffer mode or
trying to sample with the monitor running.

Hence we may also need to take the local lock to protect the monitor_mode flag.



>  	/*
>  	 * If monitor mode is enabled, the method for reading a single
>  	 * channel will have to be rather different and has not yet
> @@ -405,7 +406,7 @@ static int max1363_read_single_chan(struct iio_dev *indio_dev,
>  	}
>  	*val = data;
>  error_ret:
> -	mutex_unlock(&indio_dev->mlock);
> +	mutex_unlock(&st->lock);
>  	return ret;
>  
>  }
> @@ -705,9 +706,9 @@ static ssize_t max1363_monitor_store_freq(struct device *dev,
>  	if (!found)
>  		return -EINVAL;
>  
> -	mutex_lock(&indio_dev->mlock);
> +	mutex_lock(&st->mlock);
>  	st->monitor_speed = i;
> -	mutex_unlock(&indio_dev->mlock);
> +	mutex_unlock(&st->mlock);
>  
>  	return 0;
>  }
> @@ -810,12 +811,12 @@ static int max1363_read_event_config(struct iio_dev *indio_dev,
>  	int val;
>  	int number = chan->channel;
>  
> -	mutex_lock(&indio_dev->mlock);
> +	mutex_lock(&st->mlock);
>  	if (dir == IIO_EV_DIR_FALLING)
>  		val = (1 << number) & st->mask_low;
>  	else
>  		val = (1 << number) & st->mask_high;
> -	mutex_unlock(&indio_dev->mlock);
> +	mutex_unlock(&st->mlock);
>  
>  	return val;
>  }

Nothing for write_event_config?
That has the same problem that it should only be possible to change monitor mode
if we aren't running in buffered mode.  Hence it should try to claim direct
mode and if it fails return an error.

Fiddly stuff :)

Thanks,

Jonathan

