Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 519AB139C1E
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2020 23:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbgAMWEM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Jan 2020 17:04:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:39192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728641AbgAMWEM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 13 Jan 2020 17:04:12 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 658A42072B;
        Mon, 13 Jan 2020 22:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578953051;
        bh=eVSiDXH34AHp/qaoNToMAiWkYfhmwvXPgMqymdVD9Gw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Navce5AJQowEtwXrMVJx6JeK29AmN0rJ5LbNT5wEsfhEmzUW+vI0rxaCoO83eij4D
         ykF8bxxMuAuYawRwyEm9M4YJ/lCla3aCz8/6RSJq6LtbTy2HGYXngESlCwOAgS5IVn
         jtignMOKSJk3BEa5jH0/jMwjYBc4FtUvoPlsmMgQ=
Date:   Mon, 13 Jan 2020 22:04:07 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iio: imu: adis: use new `delay` structure for SPI
 transfer delays
Message-ID: <20200113220407.62d47084@archlinux>
In-Reply-To: <20191210140755.14305-1-alexandru.ardelean@analog.com>
References: <20191204080904.2557-1-alexandru.ardelean@analog.com>
        <20191210140755.14305-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 10 Dec 2019 16:07:55 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> In a recent change to the SPI subsystem [1], a new `delay` struct was added
> to replace the `delay_usecs`. This change replaces the current `delay_usecs`
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
Applied to the togreg branch of iio.git and pushed out as testing
for all the normal reasons.

Thanks,

Jonathan

> ---
> 
> Changelog v1 -> v2:
> * fixed typo in commit desc `delay_secs` ->  `delay_usecs`
> 
>  drivers/iio/imu/adis.c | 27 ++++++++++++++++++---------
>  1 file changed, 18 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
> index e14c8536fd09..3cc57ef22b2e 100644
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

