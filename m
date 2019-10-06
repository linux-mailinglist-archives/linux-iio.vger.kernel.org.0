Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6A2CCFE5
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2019 11:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbfJFJUZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Oct 2019 05:20:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:52856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726224AbfJFJUZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 6 Oct 2019 05:20:25 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4C71206C2;
        Sun,  6 Oct 2019 09:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570353624;
        bh=WC0qCehrmsgYxWvrMftPXEck5k1unK7BM0rd/dKhVHA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jVzcLNljNb3WNlxjxRnYifGIHN0hYnvuBVx9Ph2D76fLihaHMJY1TRfgyn6jKLZRf
         C3IBXx5A2pbPaHH8jKjidd/dlsu7W13CABWI6WfPOx9ELgM8wAMCvarNOo4P3eNr4W
         ZkHyibrRznA9JDNwxOc0E6k1+eM59/ZS2KetMx4I=
Date:   Sun, 6 Oct 2019 10:20:20 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 07/10] iio: imu: adis: group single conversion under a
 single state lock
Message-ID: <20191006102020.737cf0d4@archlinux>
In-Reply-To: <20190926111812.15957-8-alexandru.ardelean@analog.com>
References: <20190926111812.15957-1-alexandru.ardelean@analog.com>
        <20190926111812.15957-8-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 26 Sep 2019 14:18:09 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied.
Thanks,

J
> ---
>  drivers/iio/imu/adis.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
> index 7468294d1776..5e28464ea05b 100644
> --- a/drivers/iio/imu/adis.c
> +++ b/drivers/iio/imu/adis.c
> @@ -404,15 +404,15 @@ int adis_single_conversion(struct iio_dev *indio_dev,
>  	unsigned int uval;
>  	int ret;
>  
> -	mutex_lock(&indio_dev->mlock);
> +	mutex_lock(&adis->state_lock);
>  
> -	ret = adis_read_reg(adis, chan->address, &uval,
> +	ret = __adis_read_reg(adis, chan->address, &uval,
>  			chan->scan_type.storagebits / 8);
>  	if (ret)
>  		goto err_unlock;
>  
>  	if (uval & error_mask) {
> -		ret = adis_check_status(adis);
> +		ret = __adis_check_status(adis);
>  		if (ret)
>  			goto err_unlock;
>  	}
> @@ -424,7 +424,7 @@ int adis_single_conversion(struct iio_dev *indio_dev,
>  
>  	ret = IIO_VAL_INT;
>  err_unlock:
> -	mutex_unlock(&indio_dev->mlock);
> +	mutex_unlock(&adis->state_lock);
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(adis_single_conversion);

