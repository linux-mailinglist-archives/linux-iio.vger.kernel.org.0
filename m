Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1BE570BA
	for <lists+linux-iio@lfdr.de>; Wed, 26 Jun 2019 20:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbfFZSf2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 26 Jun 2019 14:35:28 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:35694 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbfFZSf2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 26 Jun 2019 14:35:28 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id BAC2A9E7F55;
        Wed, 26 Jun 2019 19:35:25 +0100 (BST)
Date:   Wed, 26 Jun 2019 19:35:24 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: Re: [PATCH 3/5] iio: imu: adis: Add support for SPI transfer
 cs_change_stall_delay_us
Message-ID: <20190626193524.2bf08a14@archlinux>
In-Reply-To: <20190625131328.11883-3-alexandru.ardelean@analog.com>
References: <20190625131328.11883-1-alexandru.ardelean@analog.com>
        <20190625131328.11883-3-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 25 Jun 2019 16:13:26 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> The ADIS16460 requires a higher delay before the next transfer. Since the
> SPI framework supports configuring the delay before the next transfer, this
> driver will become the first user of it.
> 
> The support for this functionality in ADIS16460 requires an addition to the
> ADIS lib to support the `cs_change_stall_delay_us` functionality in SPI.
> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject to previous patch naming etc, this is fine and I'll pick it up once
that's sorted.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/adis.c       | 9 +++++++++
>  include/linux/iio/imu/adis.h | 2 ++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
> index c771ae6803a9..90dac69910b3 100644
> --- a/drivers/iio/imu/adis.c
> +++ b/drivers/iio/imu/adis.c
> @@ -40,28 +40,33 @@ int adis_write_reg(struct adis *adis, unsigned int reg,
>  			.len = 2,
>  			.cs_change = 1,
>  			.delay_usecs = adis->data->write_delay,
> +			.cs_change_stall_delay_us = adis->data->cs_stall_delay,
>  		}, {
>  			.tx_buf = adis->tx + 2,
>  			.bits_per_word = 8,
>  			.len = 2,
>  			.cs_change = 1,
>  			.delay_usecs = adis->data->write_delay,
> +			.cs_change_stall_delay_us = adis->data->cs_stall_delay,
>  		}, {
>  			.tx_buf = adis->tx + 4,
>  			.bits_per_word = 8,
>  			.len = 2,
>  			.cs_change = 1,
>  			.delay_usecs = adis->data->write_delay,
> +			.cs_change_stall_delay_us = adis->data->cs_stall_delay,
>  		}, {
>  			.tx_buf = adis->tx + 6,
>  			.bits_per_word = 8,
>  			.len = 2,
>  			.delay_usecs = adis->data->write_delay,
> +			.cs_change_stall_delay_us = adis->data->cs_stall_delay,
>  		}, {
>  			.tx_buf = adis->tx + 8,
>  			.bits_per_word = 8,
>  			.len = 2,
>  			.delay_usecs = adis->data->write_delay,
> +			.cs_change_stall_delay_us = adis->data->cs_stall_delay,
>  		},
>  	};
>  
> @@ -134,12 +139,14 @@ int adis_read_reg(struct adis *adis, unsigned int reg,
>  			.len = 2,
>  			.cs_change = 1,
>  			.delay_usecs = adis->data->write_delay,
> +			.cs_change_stall_delay_us = adis->data->cs_stall_delay,
>  		}, {
>  			.tx_buf = adis->tx + 2,
>  			.bits_per_word = 8,
>  			.len = 2,
>  			.cs_change = 1,
>  			.delay_usecs = adis->data->read_delay,
> +			.cs_change_stall_delay_us = adis->data->cs_stall_delay,
>  		}, {
>  			.tx_buf = adis->tx + 4,
>  			.rx_buf = adis->rx,
> @@ -147,11 +154,13 @@ int adis_read_reg(struct adis *adis, unsigned int reg,
>  			.len = 2,
>  			.cs_change = 1,
>  			.delay_usecs = adis->data->read_delay,
> +			.cs_change_stall_delay_us = adis->data->cs_stall_delay,
>  		}, {
>  			.rx_buf = adis->rx + 2,
>  			.bits_per_word = 8,
>  			.len = 2,
>  			.delay_usecs = adis->data->read_delay,
> +			.cs_change_stall_delay_us = adis->data->cs_stall_delay,
>  		},
>  	};
>  
> diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
> index 469a493f7ae0..4aa248b6b3bd 100644
> --- a/include/linux/iio/imu/adis.h
> +++ b/include/linux/iio/imu/adis.h
> @@ -27,6 +27,7 @@ struct adis_burst;
>   * struct adis_data - ADIS chip variant specific data
>   * @read_delay: SPI delay for read operations in us
>   * @write_delay: SPI delay for write operations in us
> + * @cs_stall_delay: SPI stall delay between transfers in us
>   * @glob_cmd_reg: Register address of the GLOB_CMD register
>   * @msc_ctrl_reg: Register address of the MSC_CTRL register
>   * @diag_stat_reg: Register address of the DIAG_STAT register
> @@ -36,6 +37,7 @@ struct adis_burst;
>  struct adis_data {
>  	unsigned int read_delay;
>  	unsigned int write_delay;
> +	unsigned int cs_stall_delay;
>  
>  	unsigned int glob_cmd_reg;
>  	unsigned int msc_ctrl_reg;

