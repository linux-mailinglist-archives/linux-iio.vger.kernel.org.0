Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAF871D6201
	for <lists+linux-iio@lfdr.de>; Sat, 16 May 2020 17:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgEPP0b (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 16 May 2020 11:26:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:34620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726912AbgEPP0b (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 16 May 2020 11:26:31 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B2032065C;
        Sat, 16 May 2020 15:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589642790;
        bh=nDbUVuOquedVBMSlekX/um2ijibgd7PztzBZZtIjYoQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NJAdXr4if+08kLp8IF4icRyERQLXm2arFvo2eG4HXOaUfPHcM+UXmYWlYE8G4Ulxv
         qDP2ZmeDPcO6n29o3nRZfL0qagJJcdqGaUtocgclUY/FTYuK5+J6NshDOdH/66gAtq
         D8rxXli2/Xmq7xRF6YsqcQANQd1XfQkCK79lLo7E=
Date:   Sat, 16 May 2020 16:26:26 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        "Stefan Popa" <stefan.popa@analog.com>,
        "Hartmut Knaack" <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH] iio: dac: ad5380: Replace indio_dev->mlock with own
 device lock
Message-ID: <20200516162626.26d04b06@archlinux>
In-Reply-To: <20200514091312.81032-1-sergiu.cuciurean@analog.com>
References: <20200514091312.81032-1-sergiu.cuciurean@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 14 May 2020 12:13:11 +0300
Sergiu Cuciurean <sergiu.cuciurean@analog.com> wrote:

> As part of the general cleanup of indio_dev->mlock, this change replaces
> it with a local lock on the device's state structure.
> 
> Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>

Applied,

Thanks,

Jonathan

> ---
>  drivers/iio/dac/ad5380.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad5380.c b/drivers/iio/dac/ad5380.c
> index 2ebe08326048..b37e5675f716 100644
> --- a/drivers/iio/dac/ad5380.c
> +++ b/drivers/iio/dac/ad5380.c
> @@ -51,6 +51,7 @@ struct ad5380_chip_info {
>   * @vref_reg:		vref supply regulator
>   * @vref:		actual reference voltage used in uA
>   * @pwr_down:		whether the chip is currently in power down mode
> + * @lock		lock to protect the data buffer during regmap ops
>   */
>  
>  struct ad5380_state {
> @@ -59,6 +60,7 @@ struct ad5380_state {
>  	struct regulator		*vref_reg;
>  	int				vref;
>  	bool				pwr_down;
> +	struct mutex			lock;
>  };
>  
>  enum ad5380_type {
> @@ -98,7 +100,7 @@ static ssize_t ad5380_write_dac_powerdown(struct iio_dev *indio_dev,
>  	if (ret)
>  		return ret;
>  
> -	mutex_lock(&indio_dev->mlock);
> +	mutex_lock(&st->lock);
>  
>  	if (pwr_down)
>  		ret = regmap_write(st->regmap, AD5380_REG_SF_PWR_DOWN, 0);
> @@ -107,7 +109,7 @@ static ssize_t ad5380_write_dac_powerdown(struct iio_dev *indio_dev,
>  
>  	st->pwr_down = pwr_down;
>  
> -	mutex_unlock(&indio_dev->mlock);
> +	mutex_unlock(&st->lock);
>  
>  	return ret ? ret : len;
>  }
> @@ -390,6 +392,8 @@ static int ad5380_probe(struct device *dev, struct regmap *regmap,
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->num_channels = st->chip_info->num_channels;
>  
> +	mutex_init(&st->lock);
> +
>  	ret = ad5380_alloc_channels(indio_dev);
>  	if (ret) {
>  		dev_err(dev, "Failed to allocate channel spec: %d\n", ret);

