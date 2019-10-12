Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBDC0D5026
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2019 15:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728399AbfJLNn5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 12 Oct 2019 09:43:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:53856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726821AbfJLNn4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 12 Oct 2019 09:43:56 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66D32206CD;
        Sat, 12 Oct 2019 13:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570887836;
        bh=3bI/HBzNZlXtxe6/bsN8faynkpLhluIM8dXQica5DY0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aVxzmlZeGHY1QJfTV3d6YKgpT1XbAStM1iqS1cajoUdWcxTiRLhjOEFB8DnF74zpq
         ZVo8Sa55z8EifLOU2Wpu8s3YV1goQJSpPlRi+tRqHj1HQcD9qPwvyIgAYxv3w2+UM4
         2u/9k5YaRmYzrPa0Py1kX7MwviwDCPPr47yRH0Yk=
Date:   Sat, 12 Oct 2019 14:43:50 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2] iio: gyro: adis16260: replace mlock with ADIS lib's
 state_lock
Message-ID: <20191012144350.4e3411c0@archlinux>
In-Reply-To: <20191008082225.4526-1-alexandru.ardelean@analog.com>
References: <20190919115716.25909-1-alexandru.ardelean@analog.com>
        <20191008082225.4526-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 8 Oct 2019 11:22:25 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> This change uses the ADIS library's state_lock to protect the state of the
> `max_speed_hz` change that is done during the set of the sampling
> frequency.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Looks good.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

p.s. personal preference is don't put a new patch version as a reply
to an earlier one.  Makes it a lot more likely I'll fail to notice
it!


> ---
> 
> Changelog v1 -> v2:
> * use ADIS library's state_lock instead indio_dev's mlock ; vs just
>   removing it (as V1 did)
> 
>  drivers/iio/gyro/adis16260.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/gyro/adis16260.c b/drivers/iio/gyro/adis16260.c
> index 207a0ce13439..726a0aa321a8 100644
> --- a/drivers/iio/gyro/adis16260.c
> +++ b/drivers/iio/gyro/adis16260.c
> @@ -293,7 +293,7 @@ static int adis16260_write_raw(struct iio_dev *indio_dev,
>  		addr = adis16260_addresses[chan->scan_index][1];
>  		return adis_write_reg_16(adis, addr, val);
>  	case IIO_CHAN_INFO_SAMP_FREQ:
> -		mutex_lock(&indio_dev->mlock);
> +		mutex_lock(&adis->state_lock);
>  		if (spi_get_device_id(adis->spi)->driver_data)
>  			t = 256 / val;
>  		else
> @@ -308,9 +308,9 @@ static int adis16260_write_raw(struct iio_dev *indio_dev,
>  			adis->spi->max_speed_hz = ADIS16260_SPI_SLOW;
>  		else
>  			adis->spi->max_speed_hz = ADIS16260_SPI_FAST;
> -		ret = adis_write_reg_8(adis, ADIS16260_SMPL_PRD, t);
> +		ret = __adis_write_reg_8(adis, ADIS16260_SMPL_PRD, t);
>  
> -		mutex_unlock(&indio_dev->mlock);
> +		mutex_unlock(&adis->state_lock);
>  		return ret;
>  	}
>  	return -EINVAL;

