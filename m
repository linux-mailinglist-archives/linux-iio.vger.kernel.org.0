Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26731CCF8C
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2019 10:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbfJFIxi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Oct 2019 04:53:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:48370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726210AbfJFIxi (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 6 Oct 2019 04:53:38 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D20862084B;
        Sun,  6 Oct 2019 08:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570352017;
        bh=d214+8ALIhj4CcfRSSF8xhk2RquhOl+UqhMEsOp53UM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pEkcp7cbi6YkwrJ9czi6hsWVM1ZczLPvxPpmHa35r58j5f0qnK1ajVCMxxZ605Mfj
         7WsRwlsY3hKzqSF3QbQKUbqC4zWxgZ4dctIL3tHbpTi8PJUy64RceTIR+RkFT3W6mM
         CqRsP1UqF4MCu/6REq8FOFPn3HY0YCU0Ft3yNXc0=
Date:   Sun, 6 Oct 2019 09:53:33 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/10] iio: imu: adis: rename txrx_lock -> state_lock
Message-ID: <20191006095333.7532cc5e@archlinux>
In-Reply-To: <20190926111812.15957-2-alexandru.ardelean@analog.com>
References: <20190926111812.15957-1-alexandru.ardelean@analog.com>
        <20190926111812.15957-2-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 26 Sep 2019 14:18:03 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> The lock can be extended a bit to protect other elements that are not
> particular to just TX/RX. Another idea would have been to just add a new
> `state_lock`, but that would mean 2 locks which would be redundant, and
> probably cause more potential for dead-locks.
> 
> What will be done in the next patches, will be to add some unlocked
> versions for read/write_reg functions.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

Would be good to document the scope of the lock as a comment when it
is defined.  What exactly is 'state' in this case?

Thanks,

Jonathan

> ---
>  drivers/iio/imu/adis.c        | 10 +++++-----
>  drivers/iio/imu/adis_buffer.c |  4 ++--
>  include/linux/iio/imu/adis.h  |  2 +-
>  3 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
> index 1631c255deab..3c2d896e3a96 100644
> --- a/drivers/iio/imu/adis.c
> +++ b/drivers/iio/imu/adis.c
> @@ -70,7 +70,7 @@ int adis_write_reg(struct adis *adis, unsigned int reg,
>  		},
>  	};
>  
> -	mutex_lock(&adis->txrx_lock);
> +	mutex_lock(&adis->state_lock);
>  
>  	spi_message_init(&msg);
>  
> @@ -114,7 +114,7 @@ int adis_write_reg(struct adis *adis, unsigned int reg,
>  	}
>  
>  out_unlock:
> -	mutex_unlock(&adis->txrx_lock);
> +	mutex_unlock(&adis->state_lock);
>  
>  	return ret;
>  }
> @@ -166,7 +166,7 @@ int adis_read_reg(struct adis *adis, unsigned int reg,
>  		},
>  	};
>  
> -	mutex_lock(&adis->txrx_lock);
> +	mutex_lock(&adis->state_lock);
>  	spi_message_init(&msg);
>  
>  	if (adis->current_page != page) {
> @@ -211,7 +211,7 @@ int adis_read_reg(struct adis *adis, unsigned int reg,
>  	}
>  
>  out_unlock:
> -	mutex_unlock(&adis->txrx_lock);
> +	mutex_unlock(&adis->state_lock);
>  
>  	return ret;
>  }
> @@ -437,7 +437,7 @@ EXPORT_SYMBOL_GPL(adis_single_conversion);
>  int adis_init(struct adis *adis, struct iio_dev *indio_dev,
>  	struct spi_device *spi, const struct adis_data *data)
>  {
> -	mutex_init(&adis->txrx_lock);
> +	mutex_init(&adis->state_lock);
>  	adis->spi = spi;
>  	adis->data = data;
>  	iio_device_set_drvdata(indio_dev, adis);
> diff --git a/drivers/iio/imu/adis_buffer.c b/drivers/iio/imu/adis_buffer.c
> index 9ac8356d9a95..bf581a2c321d 100644
> --- a/drivers/iio/imu/adis_buffer.c
> +++ b/drivers/iio/imu/adis_buffer.c
> @@ -123,7 +123,7 @@ static irqreturn_t adis_trigger_handler(int irq, void *p)
>  		return -ENOMEM;
>  
>  	if (adis->data->has_paging) {
> -		mutex_lock(&adis->txrx_lock);
> +		mutex_lock(&adis->state_lock);
>  		if (adis->current_page != 0) {
>  			adis->tx[0] = ADIS_WRITE_REG(ADIS_REG_PAGE_ID);
>  			adis->tx[1] = 0;
> @@ -138,7 +138,7 @@ static irqreturn_t adis_trigger_handler(int irq, void *p)
>  
>  	if (adis->data->has_paging) {
>  		adis->current_page = 0;
> -		mutex_unlock(&adis->txrx_lock);
> +		mutex_unlock(&adis->state_lock);
>  	}
>  
>  	iio_push_to_buffers_with_timestamp(indio_dev, adis->buffer,
> diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
> index 4c53815bb729..3ed5eceaac2d 100644
> --- a/include/linux/iio/imu/adis.h
> +++ b/include/linux/iio/imu/adis.h
> @@ -61,7 +61,7 @@ struct adis {
>  	const struct adis_data	*data;
>  	struct adis_burst	*burst;
>  
> -	struct mutex		txrx_lock;
> +	struct mutex		state_lock;
>  	struct spi_message	msg;
>  	struct spi_transfer	*xfer;
>  	unsigned int		current_page;

