Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEADA4F451
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jun 2019 10:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbfFVI2l (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 22 Jun 2019 04:28:41 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:50022 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbfFVI2l (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 22 Jun 2019 04:28:41 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id EA9D69E7B57;
        Sat, 22 Jun 2019 09:28:38 +0100 (BST)
Date:   Sat, 22 Jun 2019 09:28:31 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Denis CIOCCA <denis.ciocca@st.com>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH][V3] iio: st_accel: fix
 iio_triggered_buffer_{pre,post}enable positions
Message-ID: <20190622092831.2df4e7cb@archlinux>
In-Reply-To: <0420c90b027249eb9dd28bd9e266088a@SFHDAG2NODE1.st.com>
References: <20190529135848.11964-1-alexandru.ardelean@analog.com>
        <20190614104725.4535-1-alexandru.ardelean@analog.com>
        <0420c90b027249eb9dd28bd9e266088a@SFHDAG2NODE1.st.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 17 Jun 2019 22:12:02 +0000
Denis CIOCCA <denis.ciocca@st.com> wrote:

> Hi Alexandru,
> 
> Looks good to me.
> 
> Acked-by: Denis Ciocca <denis.ciocca@st.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan


> 
> Thanks,
> Denis
> 
> 
> -----Original Message-----
> From: linux-iio-owner@vger.kernel.org <linux-iio-owner@vger.kernel.org> On Behalf Of Alexandru Ardelean
> Sent: Friday, June 14, 2019 3:47 AM
> To: linux-iio@vger.kernel.org
> Cc: Alexandru Ardelean <alexandru.ardelean@analog.com>
> Subject: [PATCH][V3] iio: st_accel: fix iio_triggered_buffer_{pre,post}enable positions
> 
> The iio_triggered_buffer_{predisable,postenable} functions attach/detach the poll functions.
> 
> For the predisable hook, the disable code should occur before detaching the poll func, and for the postenable hook, the poll func should be attached before the enable code.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
> 
> Changelog v1 -> v2:
> * record the first error in st_accel_buffer_predisable() and return that 
> 
> Changelog v2 -> v3:
> * move iio_triggered_buffer_postenable() after the allocation, but before
>   `st_sensors_set_axis_enable()` based on comment from
>   `Denis Ciocca <denis.ciocca@st.com>`
> 
>  drivers/iio/accel/st_accel_buffer.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/accel/st_accel_buffer.c b/drivers/iio/accel/st_accel_buffer.c
> index 7fddc137e91e..802ab7d2d93f 100644
> --- a/drivers/iio/accel/st_accel_buffer.c
> +++ b/drivers/iio/accel/st_accel_buffer.c
> @@ -46,17 +46,19 @@ static int st_accel_buffer_postenable(struct iio_dev *indio_dev)
>  		goto allocate_memory_error;
>  	}
>  
> -	err = st_sensors_set_axis_enable(indio_dev,
> -					(u8)indio_dev->active_scan_mask[0]);
> +	err = iio_triggered_buffer_postenable(indio_dev);
>  	if (err < 0)
>  		goto st_accel_buffer_postenable_error;
>  
> -	err = iio_triggered_buffer_postenable(indio_dev);
> +	err = st_sensors_set_axis_enable(indio_dev,
> +					(u8)indio_dev->active_scan_mask[0]);
>  	if (err < 0)
> -		goto st_accel_buffer_postenable_error;
> +		goto st_sensors_set_axis_enable_error;
>  
>  	return err;
>  
> +st_sensors_set_axis_enable_error:
> +	iio_triggered_buffer_predisable(indio_dev);
>  st_accel_buffer_postenable_error:
>  	kfree(adata->buffer_data);
>  allocate_memory_error:
> @@ -65,20 +67,22 @@ static int st_accel_buffer_postenable(struct iio_dev *indio_dev)
>  
>  static int st_accel_buffer_predisable(struct iio_dev *indio_dev)  {
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
> --
> 2.20.1
> 

