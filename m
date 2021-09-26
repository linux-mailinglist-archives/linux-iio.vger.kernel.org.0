Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 680C44189F0
	for <lists+linux-iio@lfdr.de>; Sun, 26 Sep 2021 17:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232136AbhIZPXk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sun, 26 Sep 2021 11:23:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:38572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231998AbhIZPXX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 26 Sep 2021 11:23:23 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34FB460F21;
        Sun, 26 Sep 2021 15:21:45 +0000 (UTC)
Date:   Sun, 26 Sep 2021 16:25:34 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Cc:     <linux-iio@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Dragos Bogdan <dragos.bogdan@analog.com>
Subject: Re: [PATCH 4/5] iio: adis16460: make use of the new unmasked_drdy
 flag
Message-ID: <20210926162534.56ceb50f@jic23-huawei>
In-Reply-To: <20210903141423.517028-5-nuno.sa@analog.com>
References: <20210903141423.517028-1-nuno.sa@analog.com>
        <20210903141423.517028-5-nuno.sa@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 3 Sep 2021 16:14:22 +0200
Nuno Sá <nuno.sa@analog.com> wrote:

> The library can now handle enabling/disabling IRQs for devices that
> cannot unmask the data ready pin. Hence there's no need to provide an
> 'enable_irq' callback anymore.
> 
> The library will also automatically request the IRQ with 'IRQF_NO_AUTOEN'
> so that we can also remove that from the driver.
> 
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
Hi Nuno,

1-4 applied to the togreg branch of iio.git and pushed out as testing for 0-day
to see if it can find anything we missed.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/adis16460.c | 18 +-----------------
>  1 file changed, 1 insertion(+), 17 deletions(-)
> 
> diff --git a/drivers/iio/imu/adis16460.c b/drivers/iio/imu/adis16460.c
> index a6f9fba3e03f..b01988170118 100644
> --- a/drivers/iio/imu/adis16460.c
> +++ b/drivers/iio/imu/adis16460.c
> @@ -319,20 +319,6 @@ static const struct iio_info adis16460_info = {
>  	.debugfs_reg_access = adis_debugfs_reg_access,
>  };
>  
> -static int adis16460_enable_irq(struct adis *adis, bool enable)
> -{
> -	/*
> -	 * There is no way to gate the data-ready signal internally inside the
> -	 * ADIS16460 :(
> -	 */
> -	if (enable)
> -		enable_irq(adis->spi->irq);
> -	else
> -		disable_irq(adis->spi->irq);
> -
> -	return 0;
> -}
> -
>  #define ADIS16460_DIAG_STAT_IN_CLK_OOS	7
>  #define ADIS16460_DIAG_STAT_FLASH_MEM	6
>  #define ADIS16460_DIAG_STAT_SELF_TEST	5
> @@ -373,7 +359,7 @@ static const struct adis_data adis16460_data = {
>  		BIT(ADIS16460_DIAG_STAT_OVERRANGE) |
>  		BIT(ADIS16460_DIAG_STAT_SPI_COMM) |
>  		BIT(ADIS16460_DIAG_STAT_FLASH_UPT),
> -	.enable_irq = adis16460_enable_irq,
> +	.unmasked_drdy = true,
>  	.timeouts = &adis16460_timeouts,
>  };
>  
> @@ -400,8 +386,6 @@ static int adis16460_probe(struct spi_device *spi)
>  	if (ret)
>  		return ret;
>  
> -	/* We cannot mask the interrupt, so ensure it isn't auto enabled */
> -	st->adis.irq_flag |= IRQF_NO_AUTOEN;
>  	ret = devm_adis_setup_buffer_and_trigger(&st->adis, indio_dev, NULL);
>  	if (ret)
>  		return ret;

