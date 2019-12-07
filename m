Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E582115BF1
	for <lists+linux-iio@lfdr.de>; Sat,  7 Dec 2019 12:05:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbfLGLFJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 7 Dec 2019 06:05:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:43602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726025AbfLGLFI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 7 Dec 2019 06:05:08 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 346FC21835;
        Sat,  7 Dec 2019 11:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575716707;
        bh=5qUetxT7lVLLT3D+MI17t6HtuFzj8D2c2u0mgdBjM4U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=G6J2VL2OY83IIVDK7p8doX2MoRZU35GZMpY3K9S+07LvEXgATuSq5xFbzVXaV4zAy
         /qRPHWoO8QrMyxum3NqrnUsS7Q3eIUmnZ/lfVRzGQeXWqhjL9vIl6GDjriuXAvKUOt
         jFLeW0W3tHqtYDl91n38mjV/Gnt0ASKH3WxeMing=
Date:   Sat, 7 Dec 2019 11:05:04 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: imu: adis: use new `delay` structure for SPI
 transfer delays
Message-ID: <20191207110504.6db10b0a@archlinux>
In-Reply-To: <20191204080904.2557-1-alexandru.ardelean@analog.com>
References: <20191204080904.2557-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 4 Dec 2019 10:09:04 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> In a recent change to the SPI subsystem [1], a new `delay` struct was added
> to replace the `delay_usecs`. This change replaces the current `delay_secs`
> with `delay` for this driver.
> 
> The `spi_transfer_delay_exec()` function [in the SPI framework] makes sure
> that both `delay_usecs` & `delay` are used (in this order to preserve
> backwards compatibility).
> 
> [1] commit bebcfd272df6485 ("spi: introduce `delay` field for
> `spi_transfer` + spi_transfer_delay_exec()")
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
I don't yet have that patch in my upstream so this will have to wait until
it gets there. Give me a poke if I seem to have forgotten about it.

Thanks,

Jonathan


> ---
>  drivers/iio/imu/adis.c | 27 ++++++++++++++++++---------
>  1 file changed, 18 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
> index 2cd2cc2316c6..95af67470668 100644
> --- a/drivers/iio/imu/adis.c
> +++ b/drivers/iio/imu/adis.c
> @@ -38,7 +38,8 @@ int adis_write_reg(struct adis *adis, unsigned int reg,
>  			.bits_per_word = 8,
>  			.len = 2,
>  			.cs_change = 1,
> -			.delay_usecs = adis->data->write_delay,
> +			.delay.value = adis->data->write_delay,
> +			.delay.unit = SPI_DELAY_UNIT_USECS,
>  			.cs_change_delay.value = adis->data->cs_change_delay,
>  			.cs_change_delay.unit = SPI_DELAY_UNIT_USECS,
>  		}, {
> @@ -46,7 +47,8 @@ int adis_write_reg(struct adis *adis, unsigned int reg,
>  			.bits_per_word = 8,
>  			.len = 2,
>  			.cs_change = 1,
> -			.delay_usecs = adis->data->write_delay,
> +			.delay.value = adis->data->write_delay,
> +			.delay.unit = SPI_DELAY_UNIT_USECS,
>  			.cs_change_delay.value = adis->data->cs_change_delay,
>  			.cs_change_delay.unit = SPI_DELAY_UNIT_USECS,
>  		}, {
> @@ -54,19 +56,22 @@ int adis_write_reg(struct adis *adis, unsigned int reg,
>  			.bits_per_word = 8,
>  			.len = 2,
>  			.cs_change = 1,
> -			.delay_usecs = adis->data->write_delay,
> +			.delay.value = adis->data->write_delay,
> +			.delay.unit = SPI_DELAY_UNIT_USECS,
>  			.cs_change_delay.value = adis->data->cs_change_delay,
>  			.cs_change_delay.unit = SPI_DELAY_UNIT_USECS,
>  		}, {
>  			.tx_buf = adis->tx + 6,
>  			.bits_per_word = 8,
>  			.len = 2,
> -			.delay_usecs = adis->data->write_delay,
> +			.delay.value = adis->data->write_delay,
> +			.delay.unit = SPI_DELAY_UNIT_USECS,
>  		}, {
>  			.tx_buf = adis->tx + 8,
>  			.bits_per_word = 8,
>  			.len = 2,
> -			.delay_usecs = adis->data->write_delay,
> +			.delay.value = adis->data->write_delay,
> +			.delay.unit = SPI_DELAY_UNIT_USECS,
>  		},
>  	};
>  
> @@ -138,7 +143,8 @@ int adis_read_reg(struct adis *adis, unsigned int reg,
>  			.bits_per_word = 8,
>  			.len = 2,
>  			.cs_change = 1,
> -			.delay_usecs = adis->data->write_delay,
> +			.delay.value = adis->data->write_delay,
> +			.delay.unit = SPI_DELAY_UNIT_USECS,
>  			.cs_change_delay.value = adis->data->cs_change_delay,
>  			.cs_change_delay.unit = SPI_DELAY_UNIT_USECS,
>  		}, {
> @@ -146,7 +152,8 @@ int adis_read_reg(struct adis *adis, unsigned int reg,
>  			.bits_per_word = 8,
>  			.len = 2,
>  			.cs_change = 1,
> -			.delay_usecs = adis->data->read_delay,
> +			.delay.value = adis->data->read_delay,
> +			.delay.unit = SPI_DELAY_UNIT_USECS,
>  			.cs_change_delay.value = adis->data->cs_change_delay,
>  			.cs_change_delay.unit = SPI_DELAY_UNIT_USECS,
>  		}, {
> @@ -155,14 +162,16 @@ int adis_read_reg(struct adis *adis, unsigned int reg,
>  			.bits_per_word = 8,
>  			.len = 2,
>  			.cs_change = 1,
> -			.delay_usecs = adis->data->read_delay,
> +			.delay.value = adis->data->read_delay,
> +			.delay.unit = SPI_DELAY_UNIT_USECS,
>  			.cs_change_delay.value = adis->data->cs_change_delay,
>  			.cs_change_delay.unit = SPI_DELAY_UNIT_USECS,
>  		}, {
>  			.rx_buf = adis->rx + 2,
>  			.bits_per_word = 8,
>  			.len = 2,
> -			.delay_usecs = adis->data->read_delay,
> +			.delay.value = adis->data->read_delay,
> +			.delay.unit = SPI_DELAY_UNIT_USECS,
>  		},
>  	};
>  

