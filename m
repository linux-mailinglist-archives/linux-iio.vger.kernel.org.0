Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D27ED1B87D4
	for <lists+linux-iio@lfdr.de>; Sat, 25 Apr 2020 18:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbgDYQ4C (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 25 Apr 2020 12:56:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:39388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726155AbgDYQ4B (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 25 Apr 2020 12:56:01 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0090C206D4;
        Sat, 25 Apr 2020 16:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587833761;
        bh=lWJRZMKU7ZKa8caQKiw8rpYmlkUz6xS+OTQG5tRamzw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=W55jGr8p11hbuSb/odaJ0GuELcrU19OL2GjGK3O0V9caZx78vnBTLm/iQ7Y3PyFzo
         aBqQBaazWQS3ZctZkpdEDdENlD6EEYmHIGQIcVOgA7X/FQNxqTvAYuB+k7PxV/1cRW
         nNFdIRLuO0nfmNJ8RUZZVIqtXyBWCoj7LESflanE=
Date:   Sat, 25 Apr 2020 17:55:57 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com,
        stefan.popa@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio: dac: ad5592r: Fix a typo in the name of a function
Message-ID: <20200425175557.20cd9256@archlinux>
In-Reply-To: <20200425070056.31664-1-christophe.jaillet@wanadoo.fr>
References: <20200425070056.31664-1-christophe.jaillet@wanadoo.fr>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 25 Apr 2020 09:00:56 +0200
Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> This module is related to AD5592R, not AD5593R, so be consistent in naming.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied

Thanks,

Jonathan

> ---
>  drivers/iio/dac/ad5592r.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad5592r.c b/drivers/iio/dac/ad5592r.c
> index 34ba059a77da..49308ad13c4b 100644
> --- a/drivers/iio/dac/ad5592r.c
> +++ b/drivers/iio/dac/ad5592r.c
> @@ -98,7 +98,7 @@ static int ad5592r_reg_read(struct ad5592r_state *st, u8 reg, u16 *value)
>  	return 0;
>  }
>  
> -static int ad5593r_gpio_read(struct ad5592r_state *st, u8 *value)
> +static int ad5592r_gpio_read(struct ad5592r_state *st, u8 *value)
>  {
>  	int ret;
>  
> @@ -121,7 +121,7 @@ static const struct ad5592r_rw_ops ad5592r_rw_ops = {
>  	.read_adc = ad5592r_read_adc,
>  	.reg_write = ad5592r_reg_write,
>  	.reg_read = ad5592r_reg_read,
> -	.gpio_read = ad5593r_gpio_read,
> +	.gpio_read = ad5592r_gpio_read,
>  };
>  
>  static int ad5592r_spi_probe(struct spi_device *spi)

