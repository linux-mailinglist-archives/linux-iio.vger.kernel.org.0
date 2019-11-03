Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78BB4ED2CD
	for <lists+linux-iio@lfdr.de>; Sun,  3 Nov 2019 11:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbfKCKPw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 3 Nov 2019 05:15:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:51498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726408AbfKCKPw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 3 Nov 2019 05:15:52 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C74AB20842;
        Sun,  3 Nov 2019 10:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572776151;
        bh=AImPUpJvwDFBOvPVzXsfaYHwUgChmpKojFhSxQwfKCs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TquEUuaFHXng+9+cD/1iOKKo0tW5wYg2iHWue5MIVp1DheKD95CAt0twJG8K6pNEn
         rbIHvpOaDdgmcCcYS6tYXFvfpm9jrshKTj5O+EkfuO7tl0T+FKyHcerK8lF9Ieeruc
         SLgBXFCqqu5P21I2Nxlc/2plieqqePRDANrGQdNo=
Date:   Sun, 3 Nov 2019 10:15:46 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <dragos.bogdan@analog.com>
Subject: Re: [PATCH 01/10] iio: gyro: adis16136: check ret val for non-zero
 vs less-than-zero
Message-ID: <20191103101546.47ceb7a2@archlinux>
In-Reply-To: <20191101093505.9408-2-alexandru.ardelean@analog.com>
References: <20191101093505.9408-1-alexandru.ardelean@analog.com>
        <20191101093505.9408-2-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 1 Nov 2019 11:34:56 +0200
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
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to work their magic.

Thanks,

Jonathan

> ---
>  drivers/iio/gyro/adis16136.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iio/gyro/adis16136.c b/drivers/iio/gyro/adis16136.c
> index 5bec7ad53d8b..d637d52d051a 100644
> --- a/drivers/iio/gyro/adis16136.c
> +++ b/drivers/iio/gyro/adis16136.c
> @@ -80,19 +80,19 @@ static ssize_t adis16136_show_serial(struct file *file,
>  
>  	ret = adis_read_reg_16(&adis16136->adis, ADIS16136_REG_SERIAL_NUM,
>  		&serial);
> -	if (ret < 0)
> +	if (ret)
>  		return ret;
>  
>  	ret = adis_read_reg_16(&adis16136->adis, ADIS16136_REG_LOT1, &lot1);
> -	if (ret < 0)
> +	if (ret)
>  		return ret;
>  
>  	ret = adis_read_reg_16(&adis16136->adis, ADIS16136_REG_LOT2, &lot2);
> -	if (ret < 0)
> +	if (ret)
>  		return ret;
>  
>  	ret = adis_read_reg_16(&adis16136->adis, ADIS16136_REG_LOT3, &lot3);
> -	if (ret < 0)
> +	if (ret)
>  		return ret;
>  
>  	len = snprintf(buf, sizeof(buf), "%.4x%.4x%.4x-%.4x\n", lot1, lot2,
> @@ -116,7 +116,7 @@ static int adis16136_show_product_id(void *arg, u64 *val)
>  
>  	ret = adis_read_reg_16(&adis16136->adis, ADIS16136_REG_PROD_ID,
>  		&prod_id);
> -	if (ret < 0)
> +	if (ret)
>  		return ret;
>  
>  	*val = prod_id;
> @@ -134,7 +134,7 @@ static int adis16136_show_flash_count(void *arg, u64 *val)
>  
>  	ret = adis_read_reg_16(&adis16136->adis, ADIS16136_REG_FLASH_CNT,
>  		&flash_count);
> -	if (ret < 0)
> +	if (ret)
>  		return ret;
>  
>  	*val = flash_count;
> @@ -191,7 +191,7 @@ static int adis16136_get_freq(struct adis16136 *adis16136, unsigned int *freq)
>  	int ret;
>  
>  	ret = adis_read_reg_16(&adis16136->adis, ADIS16136_REG_SMPL_PRD, &t);
> -	if (ret < 0)
> +	if (ret)
>  		return ret;
>  
>  	*freq = 32768 / (t + 1);
> @@ -228,7 +228,7 @@ static ssize_t adis16136_read_frequency(struct device *dev,
>  	int ret;
>  
>  	ret = adis16136_get_freq(adis16136, &freq);
> -	if (ret < 0)
> +	if (ret)
>  		return ret;
>  
>  	return sprintf(buf, "%d\n", freq);
> @@ -256,7 +256,7 @@ static int adis16136_set_filter(struct iio_dev *indio_dev, int val)
>  	int i, ret;
>  
>  	ret = adis16136_get_freq(adis16136, &freq);
> -	if (ret < 0)
> +	if (ret)
>  		return ret;
>  
>  	for (i = ARRAY_SIZE(adis16136_3db_divisors) - 1; i >= 1; i--) {
> @@ -277,11 +277,11 @@ static int adis16136_get_filter(struct iio_dev *indio_dev, int *val)
>  	mutex_lock(&indio_dev->mlock);
>  
>  	ret = adis_read_reg_16(&adis16136->adis, ADIS16136_REG_AVG_CNT, &val16);
> -	if (ret < 0)
> +	if (ret)
>  		goto err_unlock;
>  
>  	ret = adis16136_get_freq(adis16136, &freq);
> -	if (ret < 0)
> +	if (ret)
>  		goto err_unlock;
>  
>  	*val = freq / adis16136_3db_divisors[val16 & 0x07];
> @@ -318,7 +318,7 @@ static int adis16136_read_raw(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_CALIBBIAS:
>  		ret = adis_read_reg_32(&adis16136->adis,
>  			ADIS16136_REG_GYRO_OFF2, &val32);
> -		if (ret < 0)
> +		if (ret)
>  			return ret;
>  
>  		*val = sign_extend32(val32, 31);

