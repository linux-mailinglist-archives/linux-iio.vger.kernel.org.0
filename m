Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2E5B3A00A
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2019 15:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbfFHNuH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 8 Jun 2019 09:50:07 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:32898 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfFHNuG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 8 Jun 2019 09:50:06 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 16B289E8552;
        Sat,  8 Jun 2019 14:50:04 +0100 (BST)
Date:   Sat, 8 Jun 2019 14:50:03 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: adxl372: fix iio_triggered_buffer_{pre,post}enable
 positions
Message-ID: <20190608145003.2c099d10@archlinux>
In-Reply-To: <20190529130108.30331-1-alexandru.ardelean@analog.com>
References: <20190529130108.30331-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 29 May 2019 16:01:08 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> The iio_triggered_buffer_{predisable,postenable} functions attach/detach
> the poll functions.
> 
> For the predisable hook, the disable code should occur before detaching
> the poll func, and for the postenable hook, the poll func should be
> attached before the enable code.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Looks good to me.

Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/accel/adxl372.c | 27 ++++++++++++++++-----------
>  1 file changed, 16 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
> index 3b84cb243a87..055227cb3d43 100644
> --- a/drivers/iio/accel/adxl372.c
> +++ b/drivers/iio/accel/adxl372.c
> @@ -782,10 +782,14 @@ static int adxl372_buffer_postenable(struct iio_dev *indio_dev)
>  	unsigned int mask;
>  	int i, ret;
>  
> -	ret = adxl372_set_interrupts(st, ADXL372_INT1_MAP_FIFO_FULL_MSK, 0);
> +	ret = iio_triggered_buffer_postenable(indio_dev);
>  	if (ret < 0)
>  		return ret;
>  
> +	ret = adxl372_set_interrupts(st, ADXL372_INT1_MAP_FIFO_FULL_MSK, 0);
> +	if (ret < 0)
> +		goto err;
> +
>  	mask = *indio_dev->active_scan_mask;
>  
>  	for (i = 0; i < ARRAY_SIZE(adxl372_axis_lookup_table); i++) {
> @@ -793,8 +797,10 @@ static int adxl372_buffer_postenable(struct iio_dev *indio_dev)
>  			break;
>  	}
>  
> -	if (i == ARRAY_SIZE(adxl372_axis_lookup_table))
> -		return -EINVAL;
> +	if (i == ARRAY_SIZE(adxl372_axis_lookup_table)) {
> +		ret = -EINVAL;
> +		goto err;
> +	}
>  
>  	st->fifo_format = adxl372_axis_lookup_table[i].fifo_format;
>  	st->fifo_set_size = bitmap_weight(indio_dev->active_scan_mask,
> @@ -814,26 +820,25 @@ static int adxl372_buffer_postenable(struct iio_dev *indio_dev)
>  	if (ret < 0) {
>  		st->fifo_mode = ADXL372_FIFO_BYPASSED;
>  		adxl372_set_interrupts(st, 0, 0);
> -		return ret;
> +		goto err;
>  	}
>  
> -	return iio_triggered_buffer_postenable(indio_dev);
> +	return 0;
> +
> +err:
> +	iio_triggered_buffer_predisable(indio_dev);
> +	return ret;
>  }
>  
>  static int adxl372_buffer_predisable(struct iio_dev *indio_dev)
>  {
>  	struct adxl372_state *st = iio_priv(indio_dev);
> -	int ret;
> -
> -	ret = iio_triggered_buffer_predisable(indio_dev);
> -	if (ret < 0)
> -		return ret;
>  
>  	adxl372_set_interrupts(st, 0, 0);
>  	st->fifo_mode = ADXL372_FIFO_BYPASSED;
>  	adxl372_configure_fifo(st);
>  
> -	return 0;
> +	return iio_triggered_buffer_predisable(indio_dev);
>  }
>  
>  static const struct iio_buffer_setup_ops adxl372_buffer_ops = {

