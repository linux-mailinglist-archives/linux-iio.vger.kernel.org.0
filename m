Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA5962E72C7
	for <lists+linux-iio@lfdr.de>; Tue, 29 Dec 2020 18:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726158AbgL2Rmu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 29 Dec 2020 12:42:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:55416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726168AbgL2Rmu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 29 Dec 2020 12:42:50 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75C0D20825;
        Tue, 29 Dec 2020 17:42:08 +0000 (UTC)
Date:   Tue, 29 Dec 2020 17:42:05 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mircea Caprioru <mircea.caprioru@analog.com>
Cc:     <Michael.Hennerich@analog.com>, <alexandru.ardelean@analog.com>,
        <lars@metafoo.de>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        Dragos Bogdan <dragos.bogdan@analog.com>
Subject: Re: [PATCH V3] iio: adc: ad7476: Add LTC2314-14 support
Message-ID: <20201229174205.1844dcc8@archlinux>
In-Reply-To: <20201216083639.89425-1-mircea.caprioru@analog.com>
References: <20201216083639.89425-1-mircea.caprioru@analog.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 16 Dec 2020 10:36:39 +0200
Mircea Caprioru <mircea.caprioru@analog.com> wrote:

> From: Dragos Bogdan <dragos.bogdan@analog.com>
> 
> The LTC2314-14 is a 14-bit, 4.5Msps, serial sampling A/D converter that draws only
> 6.2mA from a wide range analog supply adjustable from 2.7V to 5.25V.
> 
> Signed-off-by: Dragos Bogdan <dragos.bogdan@analog.com>
> Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
Applied to the togreg branch of iio.git.

thanks,

Jonathan

> ---
>  drivers/iio/adc/ad7476.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
> index 66c55ae67791..17402714b387 100644
> --- a/drivers/iio/adc/ad7476.c
> +++ b/drivers/iio/adc/ad7476.c
> @@ -67,6 +67,7 @@ enum ad7476_supported_device_ids {
>  	ID_ADS7866,
>  	ID_ADS7867,
>  	ID_ADS7868,
> +	ID_LTC2314_14,
>  };
>  
>  static void ad7091_convst(struct ad7476_state *st)
> @@ -250,6 +251,10 @@ static const struct ad7476_chip_info ad7476_chip_info_tbl[] = {
>  		.channel[0] = ADS786X_CHAN(8),
>  		.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
>  	},
> +	[ID_LTC2314_14] = {
> +		.channel[0] = AD7940_CHAN(14),
> +		.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
> +	},
>  };
>  
>  static const struct iio_info ad7476_info = {
> @@ -365,6 +370,7 @@ static const struct spi_device_id ad7476_id[] = {
>  	{"ads7866", ID_ADS7866},
>  	{"ads7867", ID_ADS7867},
>  	{"ads7868", ID_ADS7868},
> +	{"ltc2314-14", ID_LTC2314_14},
>  	{}
>  };
>  MODULE_DEVICE_TABLE(spi, ad7476_id);

