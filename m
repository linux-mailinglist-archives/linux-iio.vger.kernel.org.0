Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7B5E3A031
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2019 16:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbfFHOK5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 8 Jun 2019 10:10:57 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:33252 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfFHOK5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 8 Jun 2019 10:10:57 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 044129E8FD6;
        Sat,  8 Jun 2019 15:10:54 +0100 (BST)
Date:   Sat, 8 Jun 2019 15:10:53 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: ad_sigma_delta: return directly in
 ad_sd_buffer_postenable()
Message-ID: <20190608151053.7d09c1b3@archlinux>
In-Reply-To: <20190530072541.22268-1-alexandru.ardelean@analog.com>
References: <20190530072541.22268-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 30 May 2019 10:25:41 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> There is nothing being done after the `err_predisable` label, so just
> remove it.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
applied.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ad_sigma_delta.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
> index a4310600a853..ec0e38566ece 100644
> --- a/drivers/iio/adc/ad_sigma_delta.c
> +++ b/drivers/iio/adc/ad_sigma_delta.c
> @@ -358,7 +358,7 @@ static int ad_sd_buffer_postenable(struct iio_dev *indio_dev)
>  	ret = ad_sigma_delta_set_channel(sigma_delta,
>  		indio_dev->channels[channel].address);
>  	if (ret)
> -		goto err_predisable;
> +		return ret;
>  
>  	spi_bus_lock(sigma_delta->spi->master);
>  	sigma_delta->bus_locked = true;
> @@ -375,7 +375,6 @@ static int ad_sd_buffer_postenable(struct iio_dev *indio_dev)
>  
>  err_unlock:
>  	spi_bus_unlock(sigma_delta->spi->master);
> -err_predisable:
>  
>  	return ret;
>  }

