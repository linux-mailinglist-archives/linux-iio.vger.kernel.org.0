Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5E21E9825
	for <lists+linux-iio@lfdr.de>; Sun, 31 May 2020 16:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgEaOci (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 31 May 2020 10:32:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:38458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbgEaOci (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 31 May 2020 10:32:38 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 876A32076B;
        Sun, 31 May 2020 14:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590935558;
        bh=OBpQx/MAxbnDUPvygnhKRHE92gg4+Whs9mb2nJw00e0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZPwpKij/7X9I3MTTHAHIMQO+BdbRr0l17BAAvPgS8y8YA7BWV+aeE0PtjIRJc86Mo
         cHtSGp06CYq7rlnt1P07t9aOI8QrbNvMuwrHh7sxZ7H0jOYnJus2bvBaMea8q8K05Y
         1czY2vwXuaqJ2pLTuJzXhSN5zeVkvKP91nS6LWjw=
Date:   Sun, 31 May 2020 15:32:33 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: dac: ad5592r: remove usage of iio_priv_to_dev()
 helper
Message-ID: <20200531153233.2fff02e3@archlinux>
In-Reply-To: <20200525131034.230738-1-alexandru.ardelean@analog.com>
References: <20200525131034.230738-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 25 May 2020 16:10:34 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> This was partially removed when the mlock cleanup was done. Only one more
> call is left in the ad5592r_alloc_channels() function.
> This one is simple. We just need to pass the iio_dev object and get the
> state via iio_priv().
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to poke at.

Thanks,

Jonathan

> ---
>  drivers/iio/dac/ad5592r-base.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad5592r-base.c b/drivers/iio/dac/ad5592r-base.c
> index 410e90e5f75f..272c97bb841c 100644
> --- a/drivers/iio/dac/ad5592r-base.c
> +++ b/drivers/iio/dac/ad5592r-base.c
> @@ -508,11 +508,11 @@ static void ad5592r_setup_channel(struct iio_dev *iio_dev,
>  	chan->ext_info = ad5592r_ext_info;
>  }
>  
> -static int ad5592r_alloc_channels(struct ad5592r_state *st)
> +static int ad5592r_alloc_channels(struct iio_dev *iio_dev)
>  {
> +	struct ad5592r_state *st = iio_priv(iio_dev);
>  	unsigned i, curr_channel = 0,
>  		 num_channels = st->num_channels;
> -	struct iio_dev *iio_dev = iio_priv_to_dev(st);
>  	struct iio_chan_spec *channels;
>  	struct fwnode_handle *child;
>  	u32 reg, tmp;
> @@ -636,7 +636,7 @@ int ad5592r_probe(struct device *dev, const char *name,
>  	if (ret)
>  		goto error_disable_reg;
>  
> -	ret = ad5592r_alloc_channels(st);
> +	ret = ad5592r_alloc_channels(iio_dev);
>  	if (ret)
>  		goto error_disable_reg;
>  

