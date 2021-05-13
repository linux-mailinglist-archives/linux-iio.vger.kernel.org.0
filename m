Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0987237FB2D
	for <lists+linux-iio@lfdr.de>; Thu, 13 May 2021 18:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234988AbhEMQDu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 13 May 2021 12:03:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:49762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234922AbhEMQDi (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 13 May 2021 12:03:38 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED232613BC;
        Thu, 13 May 2021 16:02:25 +0000 (UTC)
Date:   Thu, 13 May 2021 17:03:34 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Tang Bin <tangbin@cmss.chinamobile.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Subject: Re: [PATCH] iio:adc:ad7766: Fix unnecessary check in ad7766_probe()
Message-ID: <20210513170334.479953d3@jic23-huawei>
In-Reply-To: <20210511134739.948-1-tangbin@cmss.chinamobile.com>
References: <20210511134739.948-1-tangbin@cmss.chinamobile.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 11 May 2021 21:47:39 +0800
Tang Bin <tangbin@cmss.chinamobile.com> wrote:

> In the function ad7766_probe(), the return value of
> devm_iio_device_register() can be zero or ret, Thus it
> is unnecessary to repeated check here.
> 
> Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>

Hi Tang Bin,

A quick query on this sign off sequence as I'd like to check what the
intended meaning is.

If you both developed this patch, please use the Co-developed-by: tag
to indicate that.   If Zhang Shengju wrote the patch then you sent it
upstream, please fix the 'from' field on the email to reflect that.

Patch itself is good.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ad7766.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7766.c b/drivers/iio/adc/ad7766.c
> index b6b6765be..acf56e987 100644
> --- a/drivers/iio/adc/ad7766.c
> +++ b/drivers/iio/adc/ad7766.c
> @@ -291,10 +291,7 @@ static int ad7766_probe(struct spi_device *spi)
>  	if (ret)
>  		return ret;
>  
> -	ret = devm_iio_device_register(&spi->dev, indio_dev);
> -	if (ret)
> -		return ret;
> -	return 0;
> +	return devm_iio_device_register(&spi->dev, indio_dev);
>  }
>  
>  static const struct spi_device_id ad7766_id[] = {

