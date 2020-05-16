Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDC381D61F3
	for <lists+linux-iio@lfdr.de>; Sat, 16 May 2020 17:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbgEPPXi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 16 May 2020 11:23:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:33070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726362AbgEPPXi (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 16 May 2020 11:23:38 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9BE32065C;
        Sat, 16 May 2020 15:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589642618;
        bh=5+Zfs6hpFVkDklYLEV8HU1cCRNSqPjDrqAYAj/UgYYI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=z9Yq8eTGA0OEJVQ1KLm89KSgdrdazl9Dog3pch0X3Jiq3Cm97iwfSZ360Opg0U0cA
         wglZ82WExXDCRRuQE1RIJwqudXgVlbkKRuvW1U1qNKVUSgly+tR0j03BvjINTxRYSS
         ORB0cMGchKSHCosgi2n/+Idr/7kHJyVWI9TSqTvw=
Date:   Sat, 16 May 2020 16:23:33 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        "Stefan Popa" <stefan.popa@analog.com>,
        "Hartmut Knaack" <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH] iio: dac: ad5761: Replace indio_dev->mlock with own
 device lock
Message-ID: <20200516162333.647979d5@archlinux>
In-Reply-To: <20200514091032.80883-1-sergiu.cuciurean@analog.com>
References: <20200514091032.80883-1-sergiu.cuciurean@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 14 May 2020 12:10:28 +0300
Sergiu Cuciurean <sergiu.cuciurean@analog.com> wrote:

> As part of the general cleanup of indio_dev->mlock, this change replaces
> it with a local lock on the device's state structure.
> 
> Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Applied to the togreg branch of iio.git.

Thanks,

J
> ---
>  drivers/iio/dac/ad5761.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad5761.c b/drivers/iio/dac/ad5761.c
> index 4fb42b743f0f..67179944e5c5 100644
> --- a/drivers/iio/dac/ad5761.c
> +++ b/drivers/iio/dac/ad5761.c
> @@ -57,11 +57,13 @@ enum ad5761_supported_device_ids {
>   * @use_intref:		true when the internal voltage reference is used
>   * @vref:		actual voltage reference in mVolts
>   * @range:		output range mode used
> + * @lock		lock to protect the data buffer during SPI ops
>   * @data:		cache aligned spi buffer
>   */
>  struct ad5761_state {
>  	struct spi_device		*spi;
>  	struct regulator		*vref_reg;
> +	struct mutex			lock;
>  
>  	bool use_intref;
>  	int vref;
> @@ -124,9 +126,9 @@ static int ad5761_spi_write(struct iio_dev *indio_dev, u8 addr, u16 val)
>  	struct ad5761_state *st = iio_priv(indio_dev);
>  	int ret;
>  
> -	mutex_lock(&indio_dev->mlock);
> +	mutex_lock(&st->lock);
>  	ret = _ad5761_spi_write(st, addr, val);
> -	mutex_unlock(&indio_dev->mlock);
> +	mutex_unlock(&st->lock);
>  
>  	return ret;
>  }
> @@ -163,9 +165,9 @@ static int ad5761_spi_read(struct iio_dev *indio_dev, u8 addr, u16 *val)
>  	struct ad5761_state *st = iio_priv(indio_dev);
>  	int ret;
>  
> -	mutex_lock(&indio_dev->mlock);
> +	mutex_lock(&st->lock);
>  	ret = _ad5761_spi_read(st, addr, val);
> -	mutex_unlock(&indio_dev->mlock);
> +	mutex_unlock(&st->lock);
>  
>  	return ret;
>  }
> @@ -368,6 +370,8 @@ static int ad5761_probe(struct spi_device *spi)
>  	if (pdata)
>  		voltage_range = pdata->voltage_range;
>  
> +	mutex_init(&st->lock);
> +
>  	ret = ad5761_spi_set_range(st, voltage_range);
>  	if (ret)
>  		goto disable_regulator_err;

