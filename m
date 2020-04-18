Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D810D1AF17B
	for <lists+linux-iio@lfdr.de>; Sat, 18 Apr 2020 17:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbgDRPN0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Apr 2020 11:13:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:43934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbgDRPN0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Apr 2020 11:13:26 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D95C12076A;
        Sat, 18 Apr 2020 15:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587222806;
        bh=KqCHTGwt1fa8Is/VnfHILiRPxUCKBCE00PJ3kjgWfxo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ImQbeWIiNMFkrxK1BHv32y8eAViALymou+rPJ3kCDM0yLC0GgbMmxy4uJT6Q0PFHw
         RqA1jsnDU4xUn+O5udmI+Q/+LeB7YjA/Y5cFi5kuZPksYqMlIe35vvbZLySrDPlBpE
         EYYQSqHXinXD2lun8YC24sZnrBnMkSoofJPf9tcc=
Date:   Sat, 18 Apr 2020 16:13:22 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: adc: ti-ads8344: optimize consumption
Message-ID: <20200418161322.71b2b353@archlinux>
In-Reply-To: <20200416205428.437503-3-alexandre.belloni@bootlin.com>
References: <20200416205428.437503-1-alexandre.belloni@bootlin.com>
        <20200416205428.437503-3-alexandre.belloni@bootlin.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 16 Apr 2020 22:54:28 +0200
Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:

> Set the clock mode only once, at probe time and then keep the ADC powered
> down between conversions.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Looks fine to me. I'd like to be lazy and not take this until the fix is
in my upstream (even though I suspect the merge would be fine).

Give me a poke if I seem to have forgotten this after that is true!

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ti-ads8344.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-ads8344.c b/drivers/iio/adc/ti-ads8344.c
> index abe4b56c847c..40e7a9eee189 100644
> --- a/drivers/iio/adc/ti-ads8344.c
> +++ b/drivers/iio/adc/ti-ads8344.c
> @@ -72,7 +72,7 @@ static const struct iio_chan_spec ads8344_channels[] = {
>  };
>  
>  static int ads8344_adc_conversion(struct ads8344 *adc, int channel,
> -				  bool differential)
> +				  bool differential, u8 clock)
>  {
>  	struct spi_device *spi = adc->spi;
>  	int ret;
> @@ -81,7 +81,7 @@ static int ads8344_adc_conversion(struct ads8344 *adc, int channel,
>  	if (!differential)
>  		adc->tx_buf |= ADS8344_SINGLE_END;
>  	adc->tx_buf |= ADS8344_CHANNEL(channel);
> -	adc->tx_buf |= ADS8344_CLOCK_INTERNAL;
> +	adc->tx_buf |= clock;
>  
>  	ret = spi_write(spi, &adc->tx_buf, 1);
>  	if (ret)
> @@ -106,7 +106,7 @@ static int ads8344_read_raw(struct iio_dev *iio,
>  	case IIO_CHAN_INFO_RAW:
>  		mutex_lock(&adc->lock);
>  		*value = ads8344_adc_conversion(adc, channel->scan_index,
> -						channel->differential);
> +						channel->differential, 0);
>  		mutex_unlock(&adc->lock);
>  		if (*value < 0)
>  			return *value;
> @@ -161,6 +161,11 @@ static int ads8344_probe(struct spi_device *spi)
>  	if (ret)
>  		return ret;
>  
> +	/* Do a dummy read and set external clock mode */
> +	ret = ads8344_adc_conversion(adc, 0, 0, ADS8344_CLOCK_INTERNAL);
> +	if (ret < 0)
> +		return ret;
> +
>  	spi_set_drvdata(spi, indio_dev);
>  
>  	ret = iio_device_register(indio_dev);

