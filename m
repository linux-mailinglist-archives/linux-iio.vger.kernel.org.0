Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A05FDCCAA4
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2019 16:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728480AbfJEOzj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Oct 2019 10:55:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:48176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727980AbfJEOzj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 5 Oct 2019 10:55:39 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 414EC20862;
        Sat,  5 Oct 2019 14:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570287338;
        bh=lT4+XQO5kabEOkBOW+mXH29PGOxKt5PvPJ3Z1ep493k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XwPXoTzFEn9qHo0Jl5cKtzhhaCnx6+Kmn1YLAL2hnHgor3mDWQb/a/Tu8E7a0Yuvn
         fGhHIrOOVo2DGBt+X8kNgydQzfRhcS5sXwSInp4NQyxshzDpuB+a3cRH3WL+aGu9tk
         zc49aTCBhKFUQp1sXOQLP7QRaFka0twdVVgY7ltQ=
Date:   Sat, 5 Oct 2019 15:55:33 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: gyro: adis16080: replace mlock with own lock
Message-ID: <20191005155525.1e72f9bb@archlinux>
In-Reply-To: <20190919132303.9663-1-alexandru.ardelean@analog.com>
References: <20190919132303.9663-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 19 Sep 2019 16:23:03 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> The lock is used to protect the buffer during reads. Though the spi
> routines have their own locks, it may be the case that the buffer needs to
> be protected before it's stored and passed to the IIO read hooks.
> 
> indio_dev's mlock was used before.
> This change replaces it with the driver's own lock.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to poke holes in it.

Thanks,

Jonathan

> ---
>  drivers/iio/gyro/adis16080.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/gyro/adis16080.c b/drivers/iio/gyro/adis16080.c
> index 236220d6de02..1b84b8e112fe 100644
> --- a/drivers/iio/gyro/adis16080.c
> +++ b/drivers/iio/gyro/adis16080.c
> @@ -38,10 +38,12 @@ struct adis16080_chip_info {
>   * @us:			actual spi_device to write data
>   * @info:		chip specific parameters
>   * @buf:		transmit or receive buffer
> + * @lock		lock to protect buffer during reads
>   **/
>  struct adis16080_state {
>  	struct spi_device		*us;
>  	const struct adis16080_chip_info *info;
> +	struct mutex			lock;
>  
>  	__be16 buf ____cacheline_aligned;
>  };
> @@ -82,9 +84,9 @@ static int adis16080_read_raw(struct iio_dev *indio_dev,
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> -		mutex_lock(&indio_dev->mlock);
> +		mutex_lock(&st->lock);
>  		ret = adis16080_read_sample(indio_dev, chan->address, val);
> -		mutex_unlock(&indio_dev->mlock);
> +		mutex_unlock(&st->lock);
>  		return ret ? ret : IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SCALE:
>  		switch (chan->type) {
> @@ -196,6 +198,8 @@ static int adis16080_probe(struct spi_device *spi)
>  	/* this is only used for removal purposes */
>  	spi_set_drvdata(spi, indio_dev);
>  
> +	mutex_init(&st->lock);
> +
>  	/* Allocate the comms buffers */
>  	st->us = spi;
>  	st->info = &adis16080_chip_info[id->driver_data];

