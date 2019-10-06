Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E02D6CCFD5
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2019 11:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbfJFJNl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Oct 2019 05:13:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:51448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726248AbfJFJNk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 6 Oct 2019 05:13:40 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66BBD21479;
        Sun,  6 Oct 2019 09:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570353220;
        bh=3uMh7/c4FY924RL9Zr8hJOe6xF2jDdHe3dTV3df+uqs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PsRi+0dS3XAGFYxq5PLc4cWH/iXT79Wd7vW2xQdTAUb2mIz9E0b4Fe2zAIGqO8DFu
         RQUUezftz89Y6uLIVSUYbwruBPE3CmQ5t669Arw/jCqa6mMzgsMgTy/cYTv72ksMsu
         LUatb/JwH0oaxsZzuk2uXLhUumt50oBB2GiXPnb0=
Date:   Sun, 6 Oct 2019 10:13:36 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 03/10] iio: imu: adis[16480]: group RW into a single
 lock in adis_enable_irq()
Message-ID: <20191006101336.2fdf927f@archlinux>
In-Reply-To: <20190926111812.15957-4-alexandru.ardelean@analog.com>
References: <20190926111812.15957-1-alexandru.ardelean@analog.com>
        <20190926111812.15957-4-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 26 Sep 2019 14:18:05 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> The adis_enable_irq() does a read & a write. This change keeps a lock for
> the duration of both operations vs for each op.
> 
> The change is also needed in adis16480, since that has it's own
> implementation for adis_enable_irq().
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/adis.c      | 17 +++++++++++------
>  drivers/iio/imu/adis16480.c |  4 ++--
>  2 files changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
> index 4f3be011c898..dc30f70d36f3 100644
> --- a/drivers/iio/imu/adis.c
> +++ b/drivers/iio/imu/adis.c
> @@ -250,12 +250,16 @@ int adis_enable_irq(struct adis *adis, bool enable)
>  	int ret = 0;
>  	uint16_t msc;
>  
> -	if (adis->data->enable_irq)
> -		return adis->data->enable_irq(adis, enable);
> +	mutex_lock(&adis->state_lock);
> +
> +	if (adis->data->enable_irq) {
> +		ret = adis->data->enable_irq(adis, enable);
> +		goto out_unlock;
> +	}
>  
> -	ret = adis_read_reg_16(adis, adis->data->msc_ctrl_reg, &msc);
> +	ret = __adis_read_reg_16(adis, adis->data->msc_ctrl_reg, &msc);
>  	if (ret)
> -		goto error_ret;
> +		goto out_unlock;
>  
>  	msc |= ADIS_MSC_CTRL_DATA_RDY_POL_HIGH;
>  	msc &= ~ADIS_MSC_CTRL_DATA_RDY_DIO2;
> @@ -264,9 +268,10 @@ int adis_enable_irq(struct adis *adis, bool enable)
>  	else
>  		msc &= ~ADIS_MSC_CTRL_DATA_RDY_EN;
>  
> -	ret = adis_write_reg_16(adis, adis->data->msc_ctrl_reg, msc);
> +	ret = __adis_write_reg_16(adis, adis->data->msc_ctrl_reg, msc);
>  
> -error_ret:
> +out_unlock:
> +	mutex_unlock(&adis->state_lock);
>  	return ret;
>  }
>  EXPORT_SYMBOL(adis_enable_irq);
> diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
> index b99d73887c9f..dc13d8a33612 100644
> --- a/drivers/iio/imu/adis16480.c
> +++ b/drivers/iio/imu/adis16480.c
> @@ -936,14 +936,14 @@ static int adis16480_enable_irq(struct adis *adis, bool enable)
>  	uint16_t val;
>  	int ret;
>  
> -	ret = adis_read_reg_16(adis, ADIS16480_REG_FNCTIO_CTRL, &val);
> +	ret = __adis_read_reg_16(adis, ADIS16480_REG_FNCTIO_CTRL, &val);
>  	if (ret < 0)
>  		return ret;
>  
>  	val &= ~ADIS16480_DRDY_EN_MSK;
>  	val |= ADIS16480_DRDY_EN(enable);
>  
> -	return adis_write_reg_16(adis, ADIS16480_REG_FNCTIO_CTRL, val);
> +	return __adis_write_reg_16(adis, ADIS16480_REG_FNCTIO_CTRL, val);
>  }
>  
>  static int adis16480_initial_setup(struct iio_dev *indio_dev)

