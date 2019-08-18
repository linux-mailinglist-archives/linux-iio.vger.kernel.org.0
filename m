Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18EC0918F7
	for <lists+linux-iio@lfdr.de>; Sun, 18 Aug 2019 20:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbfHRSks (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Aug 2019 14:40:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:48904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726247AbfHRSks (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 18 Aug 2019 14:40:48 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2521820B7C;
        Sun, 18 Aug 2019 18:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566153647;
        bh=xbKF9nBPTFlOUppqVQ15SfctyUzM/6FbCjJp8GNqP88=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=17ysbt1Dw9AT6Oetc8OwNZg1hrRKA7iM3Q77HVTxCjdrBxd1OJwxIlDuYFiwGm0Jv
         P5ejNdCz422xRe/tpmoHTB0jdUP4TdhXapVd0/JCz9suOkYOMFmOWr73iXwwWk0XLm
         V49td6Run7Iehm3PYZU6HTHT05Ahf/afnMFb6GNk=
Date:   Sun, 18 Aug 2019 19:35:33 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mircea Caprioru <mircea.caprioru@analog.com>
Cc:     <Michael.Hennerich@analog.com>, <stefan.popa@analog.com>,
        <lars@metafoo.de>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>
Subject: Re: [PATCH V3 2/4] iio: adc: ad_sigma_delta: Export ad_sd_calibrate
Message-ID: <20190818193533.172fd2ef@archlinux>
In-Reply-To: <20190814073150.4602-2-mircea.caprioru@analog.com>
References: <20190814073150.4602-1-mircea.caprioru@analog.com>
        <20190814073150.4602-2-mircea.caprioru@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 14 Aug 2019 10:31:48 +0300
Mircea Caprioru <mircea.caprioru@analog.com> wrote:

> This patch exports the ad_sd_calibrate function in order to be able to
> call it from outside ad_sigma_delta.
> 
> There are cases where the option to calibrate one channel at a time is
> necessary (ex. system calibration for zero scale and full scale).
> 
> Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
Applied,

Thanks,

Jonathan

> ---
> Changelog V2:
> - no changes here
> 
> Changelog V3:
> - no changes here
> 
>  drivers/iio/adc/ad_sigma_delta.c       | 3 ++-
>  include/linux/iio/adc/ad_sigma_delta.h | 2 ++
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
> index 2640b75fb774..8ba90486c787 100644
> --- a/drivers/iio/adc/ad_sigma_delta.c
> +++ b/drivers/iio/adc/ad_sigma_delta.c
> @@ -205,7 +205,7 @@ int ad_sd_reset(struct ad_sigma_delta *sigma_delta,
>  }
>  EXPORT_SYMBOL_GPL(ad_sd_reset);
>  
> -static int ad_sd_calibrate(struct ad_sigma_delta *sigma_delta,
> +int ad_sd_calibrate(struct ad_sigma_delta *sigma_delta,
>  	unsigned int mode, unsigned int channel)
>  {
>  	int ret;
> @@ -242,6 +242,7 @@ static int ad_sd_calibrate(struct ad_sigma_delta *sigma_delta,
>  
>  	return ret;
>  }
> +EXPORT_SYMBOL_GPL(ad_sd_calibrate);
>  
>  /**
>   * ad_sd_calibrate_all() - Performs channel calibration
> diff --git a/include/linux/iio/adc/ad_sigma_delta.h b/include/linux/iio/adc/ad_sigma_delta.h
> index 7716fa0c9fce..8a4e25a7080c 100644
> --- a/include/linux/iio/adc/ad_sigma_delta.h
> +++ b/include/linux/iio/adc/ad_sigma_delta.h
> @@ -119,6 +119,8 @@ int ad_sd_reset(struct ad_sigma_delta *sigma_delta,
>  
>  int ad_sigma_delta_single_conversion(struct iio_dev *indio_dev,
>  	const struct iio_chan_spec *chan, int *val);
> +int ad_sd_calibrate(struct ad_sigma_delta *sigma_delta,
> +	unsigned int mode, unsigned int channel);
>  int ad_sd_calibrate_all(struct ad_sigma_delta *sigma_delta,
>  	const struct ad_sd_calib_data *cd, unsigned int n);
>  int ad_sd_init(struct ad_sigma_delta *sigma_delta, struct iio_dev *indio_dev,

