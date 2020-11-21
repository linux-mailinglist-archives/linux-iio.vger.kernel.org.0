Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7DB72BC035
	for <lists+linux-iio@lfdr.de>; Sat, 21 Nov 2020 16:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbgKUPSS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Nov 2020 10:18:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:43826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727741AbgKUPSS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Nov 2020 10:18:18 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 383B022201;
        Sat, 21 Nov 2020 15:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605971898;
        bh=WBsO3Tr7YjChRwgBz3RH04Ic5nPlrLKcKZZELJ3j8p8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZnjWmyFOsHwmrmBx5pt7frlx/YXNq/awuzAYv/mLc15AqBexTFVs7K70Vxd1qpCVS
         VyRe+uQD7wzDS4rV0GdUpH/FmTj02vurCJeSI2dFKVrovETxHnDxNZ0VbtMnRdEzcT
         Uo+jnW4DkIBtqhd7GVwnW8Qk9zc5/s0D41p31jGM=
Date:   Sat, 21 Nov 2020 15:18:14 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: accel: adis16201: remove unneeded
 spi_set_drvdata()
Message-ID: <20201121151814.47752f38@archlinux>
In-Reply-To: <20201119141729.84185-1-alexandru.ardelean@analog.com>
References: <20201119141729.84185-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 19 Nov 2020 16:17:29 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> There is no matching spi_get_drvdata() in the driver. This looks like a
> left-over from before the driver was converted to device-managed functions.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied.

Thanks,

Jonathan

> ---
>  drivers/iio/accel/adis16201.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/adis16201.c b/drivers/iio/accel/adis16201.c
> index f955cccb3e77..3633a4e302c6 100644
> --- a/drivers/iio/accel/adis16201.c
> +++ b/drivers/iio/accel/adis16201.c
> @@ -268,7 +268,6 @@ static int adis16201_probe(struct spi_device *spi)
>  		return -ENOMEM;
>  
>  	st = iio_priv(indio_dev);
> -	spi_set_drvdata(spi, indio_dev);
>  
>  	indio_dev->name = spi->dev.driver->name;
>  	indio_dev->info = &adis16201_info;

