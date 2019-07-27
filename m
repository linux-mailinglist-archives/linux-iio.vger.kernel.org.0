Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B55C577B32
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jul 2019 20:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388043AbfG0SsM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 27 Jul 2019 14:48:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:55172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387841AbfG0SsM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 27 Jul 2019 14:48:12 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74B6D206E0;
        Sat, 27 Jul 2019 18:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564253291;
        bh=iq1qYcN5ft+ngSPr5xmJXKhplcC7Tw4xClAiGLoEGzo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NQpSd8tu13qGxACuiCOrTviVGnN1T4m7tJOUd9k7TZK+b+MZInrD7pTp3nE8F/TaY
         Rp3w5lV28mEhORkcmWWbdOiQH1ozpeamfjHhhModSJrC80ckVeNF5CCzJvwb8odBeC
         /jpwjPVC8ku3cGdDNthQbtzyPDQt2/7TTnzH11PM=
Date:   Sat, 27 Jul 2019 19:48:05 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>, <broonie@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: Re: [PATCH 1/3][V4] iio: imu: adis: Add support for SPI transfer
 cs_change_delay
Message-ID: <20190727194805.455f9159@archlinux>
In-Reply-To: <20190723073641.27801-2-alexandru.ardelean@analog.com>
References: <20190723073641.27801-1-alexandru.ardelean@analog.com>
        <20190723073641.27801-2-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 23 Jul 2019 10:36:38 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> The ADIS16460 requires a higher delay before the next transfer. Since the
> SPI framework supports configuring the delay before the next transfer, this
> driver will become the first user of it.
> 
> The support for this functionality in ADIS16460 requires an addition to the
> ADIS lib to support the `cs_change_delay` functionality from the SPI
> subsystem.
> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/adis.c       | 12 ++++++++++++
>  include/linux/iio/imu/adis.h |  2 ++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
> index 30281e91dbf9..1631c255deab 100644
> --- a/drivers/iio/imu/adis.c
> +++ b/drivers/iio/imu/adis.c
> @@ -39,18 +39,24 @@ int adis_write_reg(struct adis *adis, unsigned int reg,
>  			.len = 2,
>  			.cs_change = 1,
>  			.delay_usecs = adis->data->write_delay,
> +			.cs_change_delay = adis->data->cs_change_delay,
> +			.cs_change_delay_unit = SPI_DELAY_UNIT_USECS,
>  		}, {
>  			.tx_buf = adis->tx + 2,
>  			.bits_per_word = 8,
>  			.len = 2,
>  			.cs_change = 1,
>  			.delay_usecs = adis->data->write_delay,
> +			.cs_change_delay = adis->data->cs_change_delay,
> +			.cs_change_delay_unit = SPI_DELAY_UNIT_USECS,
>  		}, {
>  			.tx_buf = adis->tx + 4,
>  			.bits_per_word = 8,
>  			.len = 2,
>  			.cs_change = 1,
>  			.delay_usecs = adis->data->write_delay,
> +			.cs_change_delay = adis->data->cs_change_delay,
> +			.cs_change_delay_unit = SPI_DELAY_UNIT_USECS,
>  		}, {
>  			.tx_buf = adis->tx + 6,
>  			.bits_per_word = 8,
> @@ -133,12 +139,16 @@ int adis_read_reg(struct adis *adis, unsigned int reg,
>  			.len = 2,
>  			.cs_change = 1,
>  			.delay_usecs = adis->data->write_delay,
> +			.cs_change_delay = adis->data->cs_change_delay,
> +			.cs_change_delay_unit = SPI_DELAY_UNIT_USECS,
>  		}, {
>  			.tx_buf = adis->tx + 2,
>  			.bits_per_word = 8,
>  			.len = 2,
>  			.cs_change = 1,
>  			.delay_usecs = adis->data->read_delay,
> +			.cs_change_delay = adis->data->cs_change_delay,
> +			.cs_change_delay_unit = SPI_DELAY_UNIT_USECS,
>  		}, {
>  			.tx_buf = adis->tx + 4,
>  			.rx_buf = adis->rx,
> @@ -146,6 +156,8 @@ int adis_read_reg(struct adis *adis, unsigned int reg,
>  			.len = 2,
>  			.cs_change = 1,
>  			.delay_usecs = adis->data->read_delay,
> +			.cs_change_delay = adis->data->cs_change_delay,
> +			.cs_change_delay_unit = SPI_DELAY_UNIT_USECS,
>  		}, {
>  			.rx_buf = adis->rx + 2,
>  			.bits_per_word = 8,
> diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
> index 3428d06b2f44..4c53815bb729 100644
> --- a/include/linux/iio/imu/adis.h
> +++ b/include/linux/iio/imu/adis.h
> @@ -26,6 +26,7 @@ struct adis_burst;
>   * struct adis_data - ADIS chip variant specific data
>   * @read_delay: SPI delay for read operations in us
>   * @write_delay: SPI delay for write operations in us
> + * @cs_change_delay: SPI delay between CS changes in us
>   * @glob_cmd_reg: Register address of the GLOB_CMD register
>   * @msc_ctrl_reg: Register address of the MSC_CTRL register
>   * @diag_stat_reg: Register address of the DIAG_STAT register
> @@ -35,6 +36,7 @@ struct adis_burst;
>  struct adis_data {
>  	unsigned int read_delay;
>  	unsigned int write_delay;
> +	unsigned int cs_change_delay;
>  
>  	unsigned int glob_cmd_reg;
>  	unsigned int msc_ctrl_reg;

