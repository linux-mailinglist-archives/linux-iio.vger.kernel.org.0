Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB7FCCFD7
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2019 11:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbfJFJOE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Oct 2019 05:14:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:51536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726248AbfJFJOE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 6 Oct 2019 05:14:04 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AF9921479;
        Sun,  6 Oct 2019 09:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570353243;
        bh=4Ao58n0YBG7JzwX6J2bssxav0wHxzNJhNBxcSQmuXf0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aboWM/KwsWfy0RYsBPW9bGIIpZ/6ZF14Tyfh3THY/YPXfRdvZ5e68w0TzLjk7ZcJc
         PeniIy3ztUktELGUgnbmSIXUYosGneH8O5TSpXbM0vJcja1kHGk8MxPTWXw6ijfngt
         j4P4RF40gXJSAOA9HDtjoMuyu0NAloPSxPVgTaac=
Date:   Sun, 6 Oct 2019 10:13:59 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 04/10] iio: imu: adis: create an unlocked version of
 adis_check_status()
Message-ID: <20191006101359.1f256fd7@archlinux>
In-Reply-To: <20190926111812.15957-5-alexandru.ardelean@analog.com>
References: <20190926111812.15957-1-alexandru.ardelean@analog.com>
        <20190926111812.15957-5-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 26 Sep 2019 14:18:06 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> This one also gets re-used in certain operations, so it makes sense to
> have an unlocked version of this to group it with other
> reads/writes/operations to have a single lock for the whole state change.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied.

Thanks,

J
> ---
>  drivers/iio/imu/adis.c       |  8 ++++----
>  include/linux/iio/imu/adis.h | 13 ++++++++++++-
>  2 files changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
> index dc30f70d36f3..e461b9ae22a5 100644
> --- a/drivers/iio/imu/adis.c
> +++ b/drivers/iio/imu/adis.c
> @@ -277,18 +277,18 @@ int adis_enable_irq(struct adis *adis, bool enable)
>  EXPORT_SYMBOL(adis_enable_irq);
>  
>  /**
> - * adis_check_status() - Check the device for error conditions
> + * __adis_check_status() - Check the device for error conditions (unlocked)
>   * @adis: The adis device
>   *
>   * Returns 0 on success, a negative error code otherwise
>   */
> -int adis_check_status(struct adis *adis)
> +int __adis_check_status(struct adis *adis)
>  {
>  	uint16_t status;
>  	int ret;
>  	int i;
>  
> -	ret = adis_read_reg_16(adis, adis->data->diag_stat_reg, &status);
> +	ret = __adis_read_reg_16(adis, adis->data->diag_stat_reg, &status);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -306,7 +306,7 @@ int adis_check_status(struct adis *adis)
>  
>  	return -EIO;
>  }
> -EXPORT_SYMBOL_GPL(adis_check_status);
> +EXPORT_SYMBOL_GPL(__adis_check_status);
>  
>  /**
>   * adis_reset() - Reset the device
> diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
> index 3a028c40e04e..f4ffba0c36b1 100644
> --- a/include/linux/iio/imu/adis.h
> +++ b/include/linux/iio/imu/adis.h
> @@ -263,7 +263,18 @@ static inline int adis_read_reg_32(struct adis *adis, unsigned int reg,
>  }
>  
>  int adis_enable_irq(struct adis *adis, bool enable);
> -int adis_check_status(struct adis *adis);
> +int __adis_check_status(struct adis *adis);
> +
> +static inline int adis_check_status(struct adis *adis)
> +{
> +	int ret;
> +
> +	mutex_lock(&adis->state_lock);
> +	ret = __adis_check_status(adis);
> +	mutex_unlock(&adis->state_lock);
> +
> +	return ret;
> +}
>  
>  int adis_initial_startup(struct adis *adis);
>  

