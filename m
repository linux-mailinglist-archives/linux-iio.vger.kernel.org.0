Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93DAFACC19
	for <lists+linux-iio@lfdr.de>; Sun,  8 Sep 2019 12:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728538AbfIHKkx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 Sep 2019 06:40:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:45702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726263AbfIHKkx (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 8 Sep 2019 06:40:53 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9361520854;
        Sun,  8 Sep 2019 10:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567939252;
        bh=Xg4HAGBZs32JUSG1Ob95Zi5NWz8k344jm7bFO/mamM8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fEVGTYk6h4JcGSou+mYr2a7AuTNlqX1CPgNBmI6/Hti1r5oTna1CKqD2DbhOXU9mg
         VyvZbWyV/Q0A8YezNXCFA0QADpr3fh3puG10i2NnSuK9k/7SVYPO5Ro4iFwP5NwclC
         ZzDLlM14eLjjCXbX+s6/opKWzpXUHNX0VW1BgaL4=
Date:   Sun, 8 Sep 2019 10:35:44 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mircea Caprioru <mircea.caprioru@analog.com>
Cc:     <Michael.Hennerich@analog.com>, <stefan.popa@analog.com>,
        <lars@metafoo.de>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>
Subject: Re: [PATCH V4 2/4] iio: adc: ad_sigma_delta: Export ad_sd_calibrate
Message-ID: <20190908103544.18568d02@archlinux>
In-Reply-To: <20190902130831.23057-2-mircea.caprioru@analog.com>
References: <20190902130831.23057-1-mircea.caprioru@analog.com>
        <20190902130831.23057-2-mircea.caprioru@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 2 Sep 2019 16:08:29 +0300
Mircea Caprioru <mircea.caprioru@analog.com> wrote:

> This patch exports the ad_sd_calibrate function in order to be able to
> call it from outside ad_sigma_delta.
> 
> There are cases where the option to calibrate one channel at a time is
> necessary (ex. system calibration for zero scale and full scale).
> 
> Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
Applied, Thanks,
> ---
> Changelog V2:
> - no changes here
> 
> Changelog V3:
> - no changes here
> 
> Changelog V4:
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

