Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4153A030
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2019 16:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbfFHOJs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 8 Jun 2019 10:09:48 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:33222 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfFHOJr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 8 Jun 2019 10:09:47 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 4842B9E7C38;
        Sat,  8 Jun 2019 15:09:46 +0100 (BST)
Date:   Sat, 8 Jun 2019 15:09:44 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, Denis Ciocca <denis.ciocca@st.com>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Subject: Re: [PATCH][V2] iio: st_accel: fix
 iio_triggered_buffer_{pre,post}enable positions
Message-ID: <20190608150944.5764158f@archlinux>
In-Reply-To: <20190529135848.11964-1-alexandru.ardelean@analog.com>
References: <20190529130121.30532-1-alexandru.ardelean@analog.com>
        <20190529135848.11964-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 29 May 2019 16:58:48 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> The iio_triggered_buffer_{predisable,postenable} functions attach/detach
> the poll functions.
> 
> For the predisable hook, the disable code should occur before detaching
> the poll func, and for the postenable hook, the poll func should be
> attached before the enable code.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
I think this is fine, but I'd like an ack from Lorenzo / Denis.

Note to those who have missed the background on this, the aim is
to both tidy up drivers, but long term to allow for simpler reworking
of the core by ensuring consistency of ordering and what is done
in each of these hooks.

Thanks,

Jonathan

> ---
> Changelog v1 -> v2:
> * record the first error in st_accel_buffer_predisable() and return that 
> 
>  drivers/iio/accel/st_accel_buffer.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/accel/st_accel_buffer.c b/drivers/iio/accel/st_accel_buffer.c
> index 7fddc137e91e..711ecd9bc898 100644
> --- a/drivers/iio/accel/st_accel_buffer.c
> +++ b/drivers/iio/accel/st_accel_buffer.c
> @@ -40,6 +40,10 @@ static int st_accel_buffer_postenable(struct iio_dev *indio_dev)
>  	int err;
>  	struct st_sensor_data *adata = iio_priv(indio_dev);
>  
> +	err = iio_triggered_buffer_postenable(indio_dev);
> +	if (err < 0)
> +		return err;
> +
>  	adata->buffer_data = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
>  	if (adata->buffer_data == NULL) {
>  		err = -ENOMEM;
> @@ -51,34 +55,33 @@ static int st_accel_buffer_postenable(struct iio_dev *indio_dev)
>  	if (err < 0)
>  		goto st_accel_buffer_postenable_error;
>  
> -	err = iio_triggered_buffer_postenable(indio_dev);
> -	if (err < 0)
> -		goto st_accel_buffer_postenable_error;
> -
>  	return err;
>  
>  st_accel_buffer_postenable_error:
>  	kfree(adata->buffer_data);
>  allocate_memory_error:
> +	iio_triggered_buffer_predisable(indio_dev);
>  	return err;
>  }
>  
>  static int st_accel_buffer_predisable(struct iio_dev *indio_dev)
>  {
> -	int err;
> +	int err, err2;
>  	struct st_sensor_data *adata = iio_priv(indio_dev);
>  
> -	err = iio_triggered_buffer_predisable(indio_dev);
> -	if (err < 0)
> -		goto st_accel_buffer_predisable_error;
> -
>  	err = st_sensors_set_axis_enable(indio_dev, ST_SENSORS_ENABLE_ALL_AXIS);
>  	if (err < 0)
>  		goto st_accel_buffer_predisable_error;
>  
>  	err = st_sensors_set_enable(indio_dev, false);
> +	if (err < 0)
> +		goto st_accel_buffer_predisable_error;
>  
>  st_accel_buffer_predisable_error:
> +	err2 = iio_triggered_buffer_predisable(indio_dev);
> +	if (!err)
> +		err = err2;
> +
>  	kfree(adata->buffer_data);
>  	return err;
>  }

