Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0F0DB2F83
	for <lists+linux-iio@lfdr.de>; Sun, 15 Sep 2019 12:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbfIOKOs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Sep 2019 06:14:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:55114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726131AbfIOKOs (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Sep 2019 06:14:48 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC23A20830;
        Sun, 15 Sep 2019 10:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568542486;
        bh=mUjjCdVtQEY5PULCjlGlyPg9stI7X2VqcSFOCcPSTBM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ps9OR+Wifm4BEjnEmgjNwrZlQKM94dXX8lTVQYYHJK2+O/nh6wTRvW/cHP/Zbdt7E
         WTxbTaUrJfVAzrbUlALMgkIil9WLyXAnvvCUoFZpPEMlEPVD0Tcg6mKcdbnDcn9jJS
         WN4Vkqjw6TIWb7t5Bdmoo1pn5xboOcHalBgoA5bk=
Date:   Sun, 15 Sep 2019 11:14:42 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <broonie@kernel.org>
Subject: Re: [PATCH v2 4/4] iio: imu: adis: convert cs_change_delay to
 spi_delay struct
Message-ID: <20190915111442.27e3c221@archlinux>
In-Reply-To: <20190913115549.3823-5-alexandru.ardelean@analog.com>
References: <20190913115549.3823-1-alexandru.ardelean@analog.com>
        <20190913115549.3823-5-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 13 Sep 2019 14:55:49 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> The ADIS library is one of the few users of the new `cs_change_delay`
> parameter for an spi_transfer.
> 
> The introduction of the `spi_delay` struct, requires that the users of of
> `cs_change_delay` get an update. This change updates the ADIS library.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

Looks to me like the build is broken between patches 3 and 4.
Don't do that as it breaks bisectability.

If you are changing an interface like this it has to occur in one patch,
of you have to have intermediate code that deals with the smooth transition.

Otherwise, looks like a sensible bit of rework to me.

Jonathan

> ---
>  drivers/iio/imu/adis.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
> index 1631c255deab..2cd2cc2316c6 100644
> --- a/drivers/iio/imu/adis.c
> +++ b/drivers/iio/imu/adis.c
> @@ -39,24 +39,24 @@ int adis_write_reg(struct adis *adis, unsigned int reg,
>  			.len = 2,
>  			.cs_change = 1,
>  			.delay_usecs = adis->data->write_delay,
> -			.cs_change_delay = adis->data->cs_change_delay,
> -			.cs_change_delay_unit = SPI_DELAY_UNIT_USECS,
> +			.cs_change_delay.value = adis->data->cs_change_delay,
> +			.cs_change_delay.unit = SPI_DELAY_UNIT_USECS,
>  		}, {
>  			.tx_buf = adis->tx + 2,
>  			.bits_per_word = 8,
>  			.len = 2,
>  			.cs_change = 1,
>  			.delay_usecs = adis->data->write_delay,
> -			.cs_change_delay = adis->data->cs_change_delay,
> -			.cs_change_delay_unit = SPI_DELAY_UNIT_USECS,
> +			.cs_change_delay.value = adis->data->cs_change_delay,
> +			.cs_change_delay.unit = SPI_DELAY_UNIT_USECS,
>  		}, {
>  			.tx_buf = adis->tx + 4,
>  			.bits_per_word = 8,
>  			.len = 2,
>  			.cs_change = 1,
>  			.delay_usecs = adis->data->write_delay,
> -			.cs_change_delay = adis->data->cs_change_delay,
> -			.cs_change_delay_unit = SPI_DELAY_UNIT_USECS,
> +			.cs_change_delay.value = adis->data->cs_change_delay,
> +			.cs_change_delay.unit = SPI_DELAY_UNIT_USECS,
>  		}, {
>  			.tx_buf = adis->tx + 6,
>  			.bits_per_word = 8,
> @@ -139,16 +139,16 @@ int adis_read_reg(struct adis *adis, unsigned int reg,
>  			.len = 2,
>  			.cs_change = 1,
>  			.delay_usecs = adis->data->write_delay,
> -			.cs_change_delay = adis->data->cs_change_delay,
> -			.cs_change_delay_unit = SPI_DELAY_UNIT_USECS,
> +			.cs_change_delay.value = adis->data->cs_change_delay,
> +			.cs_change_delay.unit = SPI_DELAY_UNIT_USECS,
>  		}, {
>  			.tx_buf = adis->tx + 2,
>  			.bits_per_word = 8,
>  			.len = 2,
>  			.cs_change = 1,
>  			.delay_usecs = adis->data->read_delay,
> -			.cs_change_delay = adis->data->cs_change_delay,
> -			.cs_change_delay_unit = SPI_DELAY_UNIT_USECS,
> +			.cs_change_delay.value = adis->data->cs_change_delay,
> +			.cs_change_delay.unit = SPI_DELAY_UNIT_USECS,
>  		}, {
>  			.tx_buf = adis->tx + 4,
>  			.rx_buf = adis->rx,
> @@ -156,8 +156,8 @@ int adis_read_reg(struct adis *adis, unsigned int reg,
>  			.len = 2,
>  			.cs_change = 1,
>  			.delay_usecs = adis->data->read_delay,
> -			.cs_change_delay = adis->data->cs_change_delay,
> -			.cs_change_delay_unit = SPI_DELAY_UNIT_USECS,
> +			.cs_change_delay.value = adis->data->cs_change_delay,
> +			.cs_change_delay.unit = SPI_DELAY_UNIT_USECS,
>  		}, {
>  			.rx_buf = adis->rx + 2,
>  			.bits_per_word = 8,

