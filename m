Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA0439F5E
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2019 13:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbfFHL6h (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 8 Jun 2019 07:58:37 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:59626 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726883AbfFHL6h (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 8 Jun 2019 07:58:37 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id E9BFF9E8FD6;
        Sat,  8 Jun 2019 12:58:35 +0100 (BST)
Date:   Sat, 8 Jun 2019 12:58:33 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] staging: iio: ad2s1210: Remove platform data NULL check
 in probe
Message-ID: <20190608125833.7794417b@archlinux>
In-Reply-To: <20190606103409.28160-1-alexandru.ardelean@analog.com>
References: <20190606103409.28160-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 6 Jun 2019 13:34:09 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> The driver only needs to access GPIOs via GPIOLIB. And SPI can be
> configured via device-tree or ACPI.
> 
> The platform data is a remnant from another time, and should not cause the
> driver to error out during probing if it is NULL.
> Also, it's not used.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to do not much with it.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/resolver/ad2s1210.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
> index b6be0bc202f5..0c1bd108c386 100644
> --- a/drivers/staging/iio/resolver/ad2s1210.c
> +++ b/drivers/staging/iio/resolver/ad2s1210.c
> @@ -647,9 +647,6 @@ static int ad2s1210_probe(struct spi_device *spi)
>  	struct ad2s1210_state *st;
>  	int ret;
>  
> -	if (!spi->dev.platform_data)
> -		return -EINVAL;
> -
>  	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
>  	if (!indio_dev)
>  		return -ENOMEM;

