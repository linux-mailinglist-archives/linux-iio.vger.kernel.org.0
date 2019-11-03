Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B264ED2D0
	for <lists+linux-iio@lfdr.de>; Sun,  3 Nov 2019 11:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbfKCKVv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 Nov 2019 05:21:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:51908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727377AbfKCKVv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 3 Nov 2019 05:21:51 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3596E20842;
        Sun,  3 Nov 2019 10:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572776510;
        bh=o9AtmyH3J8PgAoJS/7BLVWch2sOfTC8MPD603XhOUxA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BsC6z7EucrX1HzkONV/yzGgC/YZ0f7uD9+Lgm74aLds5UsCNJfsjBxDmPM+loT7FZ
         n+DYHq4ROc53SqNAxO6PTl63DAu84Dvy84wfbFH1d8FhBZv2gkT2ja5xNprLqnVZ1F
         coy44WiQ9AnkHq7aL8NuXESxccoguPrgyqCk8NQY=
Date:   Sun, 3 Nov 2019 10:21:45 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <dragos.bogdan@analog.com>
Subject: Re: [PATCH 02/10] iio: imu: adis16400: check ret val for non-zero
 vs less-than-zero
Message-ID: <20191103102145.2ff4e810@archlinux>
In-Reply-To: <20191101093505.9408-3-alexandru.ardelean@analog.com>
References: <20191101093505.9408-1-alexandru.ardelean@analog.com>
        <20191101093505.9408-3-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 1 Nov 2019 11:34:57 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> The ADIS library functions return zero on success, and negative values for
> error. Positive values aren't returned, but we only care about the success
> value (which is zero).
> 
> This change is mostly needed so that the compiler won't make any inferences
> about some about values being potentially un-initialized. This only
> triggers after making some functions inline, because the compiler can
> better follow return paths.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied,

An observation whilst I was looking at the driver though...

It has some cases of goto label; where the label doesn't then do anything
in *_initial_setup.  Direct returns would be a bit neater.

Really minor point but if you happen to be touching that driver again
soon nice to tidy up ;)

Thanks,

Jonathan


> ---
>  drivers/iio/imu/adis16400.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iio/imu/adis16400.c b/drivers/iio/imu/adis16400.c
> index 0575ff706bd4..44e46dc96e00 100644
> --- a/drivers/iio/imu/adis16400.c
> +++ b/drivers/iio/imu/adis16400.c
> @@ -217,16 +217,16 @@ static ssize_t adis16400_show_serial_number(struct file *file,
>  	int ret;
>  
>  	ret = adis_read_reg_16(&st->adis, ADIS16334_LOT_ID1, &lot1);
> -	if (ret < 0)
> +	if (ret)
>  		return ret;
>  
>  	ret = adis_read_reg_16(&st->adis, ADIS16334_LOT_ID2, &lot2);
> -	if (ret < 0)
> +	if (ret)
>  		return ret;
>  
>  	ret = adis_read_reg_16(&st->adis, ADIS16334_SERIAL_NUMBER,
>  			&serial_number);
> -	if (ret < 0)
> +	if (ret)
>  		return ret;
>  
>  	len = snprintf(buf, sizeof(buf), "%.4x-%.4x-%.4x\n", lot1, lot2,
> @@ -249,7 +249,7 @@ static int adis16400_show_product_id(void *arg, u64 *val)
>  	int ret;
>  
>  	ret = adis_read_reg_16(&st->adis, ADIS16400_PRODUCT_ID, &prod_id);
> -	if (ret < 0)
> +	if (ret)
>  		return ret;
>  
>  	*val = prod_id;
> @@ -266,7 +266,7 @@ static int adis16400_show_flash_count(void *arg, u64 *val)
>  	int ret;
>  
>  	ret = adis_read_reg_16(&st->adis, ADIS16400_FLASH_CNT, &flash_count);
> -	if (ret < 0)
> +	if (ret)
>  		return ret;
>  
>  	*val = flash_count;
> @@ -327,7 +327,7 @@ static int adis16334_get_freq(struct adis16400_state *st)
>  	uint16_t t;
>  
>  	ret = adis_read_reg_16(&st->adis, ADIS16400_SMPL_PRD, &t);
> -	if (ret < 0)
> +	if (ret)
>  		return ret;
>  
>  	t >>= ADIS16334_RATE_DIV_SHIFT;
> @@ -359,7 +359,7 @@ static int adis16400_get_freq(struct adis16400_state *st)
>  	uint16_t t;
>  
>  	ret = adis_read_reg_16(&st->adis, ADIS16400_SMPL_PRD, &t);
> -	if (ret < 0)
> +	if (ret)
>  		return ret;
>  
>  	sps = (t & ADIS16400_SMPL_PRD_TIME_BASE) ? 52851 : 1638404;
> @@ -416,7 +416,7 @@ static int adis16400_set_filter(struct iio_dev *indio_dev, int sps, int val)
>  	}
>  
>  	ret = adis_read_reg_16(&st->adis, ADIS16400_SENS_AVG, &val16);
> -	if (ret < 0)
> +	if (ret)
>  		return ret;
>  
>  	ret = adis_write_reg_16(&st->adis, ADIS16400_SENS_AVG,
> @@ -615,7 +615,7 @@ static int adis16400_read_raw(struct iio_dev *indio_dev,
>  		ret = adis_read_reg_16(&st->adis,
>  						ADIS16400_SENS_AVG,
>  						&val16);
> -		if (ret < 0) {
> +		if (ret) {
>  			mutex_unlock(&indio_dev->mlock);
>  			return ret;
>  		}
> @@ -626,12 +626,12 @@ static int adis16400_read_raw(struct iio_dev *indio_dev,
>  			*val2 = (ret % 1000) * 1000;
>  		}
>  		mutex_unlock(&indio_dev->mlock);
> -		if (ret < 0)
> +		if (ret)
>  			return ret;
>  		return IIO_VAL_INT_PLUS_MICRO;
>  	case IIO_CHAN_INFO_SAMP_FREQ:
>  		ret = st->variant->get_freq(st);
> -		if (ret < 0)
> +		if (ret)
>  			return ret;
>  		*val = ret / 1000;
>  		*val2 = (ret % 1000) * 1000;

