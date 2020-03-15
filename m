Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B54D0185C8D
	for <lists+linux-iio@lfdr.de>; Sun, 15 Mar 2020 14:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbgCONRB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Mar 2020 09:17:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:48590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728541AbgCONRB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Mar 2020 09:17:01 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8BCDD205ED;
        Sun, 15 Mar 2020 13:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584278220;
        bh=X10LSDl+tgR7wxLhrOkAitKNHf55x2311G9Mgz947d0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xWudyr8E5oAujeyIgdwtB/1wUEZb2qp4oXoLEVOA0tuL1mt3bYAAH8SYQhH5/vBtt
         p5aJiPO6GBZWsuUrTSEI1yk1/s0x/YcDoLRjbGGcuMnKad65M67PK7C+exUQ73X6DK
         dHwFl0yRWVV0jMio9DIJLuSJ0lSlY/gI5al3rdek=
Date:   Sun, 15 Mar 2020 13:16:56 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Beniamin Bia <beniamin.bia@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <Michael.Hennerich@analog.com>, <biabeniamin@outlook.com>,
        Dragos Bogdan <dragos.bogdan@analog.com>
Subject: Re: [PATCH 2/4] iio: adc: ad7476: Add IIO_CHAN_INFO_RAW for AD7091R
Message-ID: <20200315131656.5baa8a42@archlinux>
In-Reply-To: <20200311084328.17680-2-beniamin.bia@analog.com>
References: <20200311084328.17680-1-beniamin.bia@analog.com>
        <20200311084328.17680-2-beniamin.bia@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 11 Mar 2020 10:43:26 +0200
Beniamin Bia <beniamin.bia@analog.com> wrote:

> From: Dragos Bogdan <dragos.bogdan@analog.com>
> 
> When CONVST signal is generated internally, IIO_CHAN_INFO_RAW can be
> made available for AD7091R for single reads. This patch enables it and
> makes supporting more devices by this driver easier.
> 
> Signed-off-by: Dragos Bogdan <dragos.bogdan@analog.com>
> Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
Applied.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ad7476.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
> index 32e857dfec9c..3b48073dd62d 100644
> --- a/drivers/iio/adc/ad7476.c
> +++ b/drivers/iio/adc/ad7476.c
> @@ -29,6 +29,8 @@ struct ad7476_state;
>  struct ad7476_chip_info {
>  	unsigned int			int_vref_uv;
>  	struct iio_chan_spec		channel[2];
> +	/* channels used when convst gpio is defined */
> +	struct iio_chan_spec		convst_channel[2];
>  	void (*reset)(struct ad7476_state *);
>  };
>  
> @@ -109,6 +111,8 @@ static int ad7476_scan_direct(struct ad7476_state *st)
>  {
>  	int ret;
>  
> +	ad7091_convst(st);
> +
>  	ret = spi_sync(st->spi, &st->msg);
>  	if (ret)
>  		return ret;
> @@ -176,6 +180,8 @@ static int ad7476_read_raw(struct iio_dev *indio_dev,
>  #define AD7940_CHAN(bits) _AD7476_CHAN((bits), 15 - (bits), \
>  		BIT(IIO_CHAN_INFO_RAW))
>  #define AD7091R_CHAN(bits) _AD7476_CHAN((bits), 16 - (bits), 0)
> +#define AD7091R_CONVST_CHAN(bits) _AD7476_CHAN((bits), 16 - (bits), \
> +		BIT(IIO_CHAN_INFO_RAW))
>  #define ADS786X_CHAN(bits) _AD7476_CHAN((bits), 12 - (bits), \
>  		BIT(IIO_CHAN_INFO_RAW))
>  
> @@ -183,6 +189,8 @@ static const struct ad7476_chip_info ad7476_chip_info_tbl[] = {
>  	[ID_AD7091R] = {
>  		.channel[0] = AD7091R_CHAN(12),
>  		.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
> +		.convst_channel[0] = AD7091R_CONVST_CHAN(12),
> +		.convst_channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
>  		.reset = ad7091_reset,
>  	},
>  	[ID_AD7276] = {
> @@ -288,6 +296,9 @@ static int ad7476_probe(struct spi_device *spi)
>  	indio_dev->channels = st->chip_info->channel;
>  	indio_dev->num_channels = 2;
>  	indio_dev->info = &ad7476_info;
> +
> +	if (st->convst_gpio && st->chip_info->convst_channel)
> +		indio_dev->channels = st->chip_info->convst_channel;
>  	/* Setup default message */
>  
>  	st->xfer.rx_buf = &st->data;

