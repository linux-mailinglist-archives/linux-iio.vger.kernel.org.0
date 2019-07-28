Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7F777E87
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jul 2019 09:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbfG1H7Q (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 Jul 2019 03:59:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:50488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725886AbfG1H7Q (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 28 Jul 2019 03:59:16 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8F6B2085A;
        Sun, 28 Jul 2019 07:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564300755;
        bh=R3IQ/s9zr616QPlWMjMS7pZhgVKe0bAUG4LNFhzusq4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VfH5BLSEyppZK7zZBCxJUN1gpWBvbAEV/cZrIPU2pxiPh10zclrxe9Hr2qQSOmTtG
         2AdsZRoJEfErUeSMzGh5NT79JTu0ozjlN+bv/rD1qlysHIoRDVq0pIwjnzoJ/Xa8GZ
         Qla4ArdSyTP2zZDNSY6RNajZ6y0I/LUjso3gTWd4=
Date:   Sun, 28 Jul 2019 08:57:39 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Beniamin Bia <beniamin.bia@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <biabeniamin@outlook.com>
Subject: Re: [PATCH 2/5] iio: adc: ad7606: Move spi dependent features to
 spi file
Message-ID: <20190728085733.3ca64de3@archlinux>
In-Reply-To: <20190718062734.17306-2-beniamin.bia@analog.com>
References: <20190718062734.17306-1-beniamin.bia@analog.com>
        <20190718062734.17306-2-beniamin.bia@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 18 Jul 2019 09:27:31 +0300
Beniamin Bia <beniamin.bia@analog.com> wrote:

> Because software mode and register access are only available in spi, they
> were moved in spi file and are accessbile via bops structure.
> The write_os/scale will be overwritten by sw_mode_config function.
> This patch was made in order to support devices in software mode without
> making the driver dependent to spi and increase the abstraction of the
> core.
> 
> Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
> Acked-by: Jonathan Cameron <jic23@kernel.org>
Applied.

thanks,

Jonathan

> ---
> Changes in v2:
> -nothing changed
> 
>  drivers/iio/adc/ad7606.c | 20 ++------------------
>  drivers/iio/adc/ad7606.h | 12 +++---------
>  2 files changed, 5 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
> index a49dc106a21c..9eec3db01a17 100644
> --- a/drivers/iio/adc/ad7606.c
> +++ b/drivers/iio/adc/ad7606.c
> @@ -597,7 +597,7 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
>  	st->write_scale = ad7606_write_scale_hw;
>  	st->write_os = ad7606_write_os_hw;
>  
> -	if (st->chip_info->sw_mode_config)
> +	if (st->bops->sw_mode_config)
>  		st->sw_mode_en = device_property_present(st->dev,
>  							 "adi,sw-mode");
>  
> @@ -606,23 +606,7 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
>  		memset32(st->range, 2, ARRAY_SIZE(st->range));
>  		indio_dev->info = &ad7606_info_os_and_range;
>  
> -		/*
> -		 * In software mode, the range gpio has no longer its function.
> -		 * Instead, the scale can be configured individually for each
> -		 * channel from the range registers.
> -		 */
> -		if (st->chip_info->write_scale_sw)
> -			st->write_scale = st->chip_info->write_scale_sw;
> -
> -		/*
> -		 * In software mode, the oversampling is no longer configured
> -		 * with GPIO pins. Instead, the oversampling can be configured
> -		 * in configuratiion register.
> -		 */
> -		if (st->chip_info->write_os_sw)
> -			st->write_os = st->chip_info->write_os_sw;
> -
> -		ret = st->chip_info->sw_mode_config(indio_dev);
> +		ret = st->bops->sw_mode_config(indio_dev);
>  		if (ret < 0)
>  			return ret;
>  	}
> diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
> index d547e88f4c9d..a6aac33aa33c 100644
> --- a/drivers/iio/adc/ad7606.h
> +++ b/drivers/iio/adc/ad7606.h
> @@ -39,12 +39,6 @@
>   *			oversampling ratios.
>   * @oversampling_num	number of elements stored in oversampling_avail array
>   * @os_req_reset	some devices require a reset to update oversampling
> - * @write_scale_sw	pointer to the function which writes the scale via spi
> -			in software mode
> - * @write_os_sw		pointer to the function which writes the os via spi
> -			in software mode
> - * @sw_mode_config:	pointer to a function which configured the device
> - *			for software mode
>   */
>  struct ad7606_chip_info {
>  	const struct iio_chan_spec	*channels;
> @@ -52,9 +46,6 @@ struct ad7606_chip_info {
>  	const unsigned int		*oversampling_avail;
>  	unsigned int			oversampling_num;
>  	bool				os_req_reset;
> -	int (*write_scale_sw)(struct iio_dev *indio_dev, int ch, int val);
> -	int (*write_os_sw)(struct iio_dev *indio_dev, int val);
> -	int (*sw_mode_config)(struct iio_dev *indio_dev);
>  };
>  
>  /**
> @@ -124,10 +115,13 @@ struct ad7606_state {
>  /**
>   * struct ad7606_bus_ops - driver bus operations
>   * @read_block		function pointer for reading blocks of data
> + * @sw_mode_config:	pointer to a function which configured the device
> + *			for software mode
>   */
>  struct ad7606_bus_ops {
>  	/* more methods added in future? */
>  	int (*read_block)(struct device *dev, int num, void *data);
> +	int (*sw_mode_config)(struct iio_dev *indio_dev);
>  };
>  
>  int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,

