Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22D651D61DF
	for <lists+linux-iio@lfdr.de>; Sat, 16 May 2020 17:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbgEPPQc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 16 May 2020 11:16:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:59512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726416AbgEPPQb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 16 May 2020 11:16:31 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C441206F4;
        Sat, 16 May 2020 15:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589642191;
        bh=6Z9hb2te2K0czF9eC2paUQgDl+fVWCezJ+/uOWzzXJ4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KxtFjtajna+Yf7zWSN5eXdFOiAJUdjkFb1PFk8Zlrb+wGEMWqwcbB3H5NP6DpdGE4
         lFjZAUIiXyOmo3Jy59WQzhtix1dcQaHHySO5xj0+s/UKaZjhrwUhVHvO0ovkCW9LDW
         aa/u2EZ54ZnCKOp3w6SBPTGv2IpSKz5rHyckFWKs=
Date:   Sat, 16 May 2020 16:16:27 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        "Stefan Popa" <stefan.popa@analog.com>,
        "Hartmut Knaack" <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH] iio: dac: ad5449: Replace indio_dev->mlock with own
 device lock
Message-ID: <20200516161627.60782bd9@archlinux>
In-Reply-To: <20200514090152.80436-1-sergiu.cuciurean@analog.com>
References: <20200514090152.80436-1-sergiu.cuciurean@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 14 May 2020 12:01:49 +0300
Sergiu Cuciurean <sergiu.cuciurean@analog.com> wrote:

> As part of the general cleanup of indio_dev->mlock, this change replaces
> it with a local lock on the device's state structure.
> 
> Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Applied.

Thanks,

J
> ---
>  drivers/iio/dac/ad5449.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad5449.c b/drivers/iio/dac/ad5449.c
> index fed3ebaccac4..d739b10e5236 100644
> --- a/drivers/iio/dac/ad5449.c
> +++ b/drivers/iio/dac/ad5449.c
> @@ -56,11 +56,13 @@ struct ad5449_chip_info {
>   * @has_sdo:		whether the SDO line is connected
>   * @dac_cache:		Cache for the DAC values
>   * @data:		spi transfer buffers
> + * @lock		lock to protect the data buffer during SPI ops
>   */
>  struct ad5449 {
>  	struct spi_device		*spi;
>  	const struct ad5449_chip_info	*chip_info;
>  	struct regulator_bulk_data	vref_reg[AD5449_MAX_VREFS];
> +	struct mutex			lock;
>  
>  	bool has_sdo;
>  	uint16_t dac_cache[AD5449_MAX_CHANNELS];
> @@ -87,10 +89,10 @@ static int ad5449_write(struct iio_dev *indio_dev, unsigned int addr,
>  	struct ad5449 *st = iio_priv(indio_dev);
>  	int ret;
>  
> -	mutex_lock(&indio_dev->mlock);
> +	mutex_lock(&st->lock);
>  	st->data[0] = cpu_to_be16((addr << 12) | val);
>  	ret = spi_write(st->spi, st->data, 2);
> -	mutex_unlock(&indio_dev->mlock);
> +	mutex_unlock(&st->lock);
>  
>  	return ret;
>  }
> @@ -112,7 +114,7 @@ static int ad5449_read(struct iio_dev *indio_dev, unsigned int addr,
>  		},
>  	};
>  
> -	mutex_lock(&indio_dev->mlock);
> +	mutex_lock(&st->lock);
>  	st->data[0] = cpu_to_be16(addr << 12);
>  	st->data[1] = cpu_to_be16(AD5449_CMD_NOOP);
>  
> @@ -123,7 +125,7 @@ static int ad5449_read(struct iio_dev *indio_dev, unsigned int addr,
>  	*val = be16_to_cpu(st->data[1]);
>  
>  out_unlock:
> -	mutex_unlock(&indio_dev->mlock);
> +	mutex_unlock(&st->lock);
>  	return ret;
>  }
>  
> @@ -302,6 +304,8 @@ static int ad5449_spi_probe(struct spi_device *spi)
>  	indio_dev->channels = st->chip_info->channels;
>  	indio_dev->num_channels = st->chip_info->num_channels;
>  
> +	mutex_init(&st->lock);
> +
>  	if (st->chip_info->has_ctrl) {
>  		unsigned int ctrl = 0x00;
>  		if (pdata) {

