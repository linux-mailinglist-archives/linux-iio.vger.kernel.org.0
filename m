Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C42C1AF172
	for <lists+linux-iio@lfdr.de>; Sat, 18 Apr 2020 17:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725914AbgDRPGN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Apr 2020 11:06:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:41642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbgDRPGN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Apr 2020 11:06:13 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2AA42076A;
        Sat, 18 Apr 2020 15:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587222373;
        bh=WSSh4VYHIuXqS25vztwkH7Z0icJIFqorESdXxBszA/Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mfvJmDye3Fg0GYmcb8DGBu8CgrjFGuIGzOVuiVZIbjxX04w1Yry3WSUHv8/wHMg4o
         NdeWO5t7yRzeg3BBuOXJsc2BQfebtaDlxk4KTaIk3PGC7929vRXCtDm5UYSKXjvzMg
         bBTQVMVF6JB9EIEXzIXBp2Bs8dlhmReFMfEzhYsM=
Date:   Sat, 18 Apr 2020 16:06:08 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iio: adc: ti-ads8344: properly byte swap value
Message-ID: <20200418160608.55046663@archlinux>
In-Reply-To: <20200416205428.437503-2-alexandre.belloni@bootlin.com>
References: <20200416205428.437503-1-alexandre.belloni@bootlin.com>
        <20200416205428.437503-2-alexandre.belloni@bootlin.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 16 Apr 2020 22:54:27 +0200
Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:

> The first received byte is the MSB, followed by the LSB so the value needs
> to be byte swapped.
> 
> Also, the ADC actually has a delay of one clock on the SPI bus. Read three
> bytes to get the last bit.
> 
> Fixes: 8dd2d7c0fed7 ("iio: adc: Add driver for the TI ADS8344 A/DC chips")
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Applied to the fixes-togreg branch of iio.git.  Marked for stable.

Random aside that I'll probably forget to clean up.

Driver includes iio/buffer.h and doesn't use it...

Thanks,

Jonathan


> ---
>  drivers/iio/adc/ti-ads8344.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-ads8344.c b/drivers/iio/adc/ti-ads8344.c
> index 9a460807d46d..abe4b56c847c 100644
> --- a/drivers/iio/adc/ti-ads8344.c
> +++ b/drivers/iio/adc/ti-ads8344.c
> @@ -29,7 +29,7 @@ struct ads8344 {
>  	struct mutex lock;
>  
>  	u8 tx_buf ____cacheline_aligned;
> -	u16 rx_buf;
> +	u8 rx_buf[3];
>  };
>  
>  #define ADS8344_VOLTAGE_CHANNEL(chan, si)				\
> @@ -89,11 +89,11 @@ static int ads8344_adc_conversion(struct ads8344 *adc, int channel,
>  
>  	udelay(9);
>  
> -	ret = spi_read(spi, &adc->rx_buf, 2);
> +	ret = spi_read(spi, adc->rx_buf, sizeof(adc->rx_buf));
>  	if (ret)
>  		return ret;
>  
> -	return adc->rx_buf;
> +	return adc->rx_buf[0] << 9 | adc->rx_buf[1] << 1 | adc->rx_buf[2] >> 7;
>  }
>  
>  static int ads8344_read_raw(struct iio_dev *iio,

