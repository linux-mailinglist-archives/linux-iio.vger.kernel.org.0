Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67A35CCABF
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2019 17:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbfJEPOY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Oct 2019 11:14:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:51836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725826AbfJEPOY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 5 Oct 2019 11:14:24 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33CCA20867;
        Sat,  5 Oct 2019 15:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570288463;
        bh=Y4zFh0TUS+7GcaD5js1KQUN4mWYAHTEKfvS62OhJxew=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zH03kK6c055Yx5iC41cWV3SE1kFaxg1JO4xtKddgA5PAJ/B4TPPvFaBasiBEkZGTO
         9qZxbvd+Hccn5c2RWEcC/uE8TyCyrrLKtEOvMjrp3LOt+OG9BbSHNI3O0ArL/z+0tX
         ioi2xqLiZVkjANFi+TUVKZNYRguKkVXGH8pHeGs8=
Date:   Sat, 5 Oct 2019 16:14:20 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <gregor.boirie@parrot.com>
Subject: Re: [PATCH] iio: pressure: zpa2326: fix
 iio_triggered_buffer_postenable position
Message-ID: <20191005161420.34c17eea@archlinux>
In-Reply-To: <20190920080348.29995-1-alexandru.ardelean@analog.com>
References: <20190920080348.29995-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 20 Sep 2019 11:03:48 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> The iio_triggered_buffer_{predisable,postenable} functions attach/detach
> the poll functions.
> 
> The iio_triggered_buffer_postenable() should be called before (to attach
> the poll func) and then the
> 
> The iio_triggered_buffer_predisable() function is hooked directly without
> anything, which is probably fine, as the postenable() version seems to also
> do some reset/wake-up of the device.
> This will mean it will be easier when removing it; i.e. it just gets
> removed.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Seems straight forward but I've often been wrong before.
Not heard from Gregor for a while, but we should give him a little more
time to spot this one.  If nothing for another week I'll just take a
gamble and apply it.  If I seem to have forgotten any of these give
me a bump.

Thanks,

Jonathan

> ---
>  drivers/iio/pressure/zpa2326.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/pressure/zpa2326.c b/drivers/iio/pressure/zpa2326.c
> index 9d0d07930236..99dfe33ee402 100644
> --- a/drivers/iio/pressure/zpa2326.c
> +++ b/drivers/iio/pressure/zpa2326.c
> @@ -1243,6 +1243,11 @@ static int zpa2326_postenable_buffer(struct iio_dev *indio_dev)
>  	const struct zpa2326_private *priv = iio_priv(indio_dev);
>  	int                           err;
>  
> +	/* Plug our own trigger event handler. */
> +	err = iio_triggered_buffer_postenable(indio_dev);
> +	if (err)
> +		goto err;
> +
>  	if (!priv->waken) {
>  		/*
>  		 * We were already power supplied. Just clear hardware FIFO to
> @@ -1250,7 +1255,7 @@ static int zpa2326_postenable_buffer(struct iio_dev *indio_dev)
>  		 */
>  		err = zpa2326_clear_fifo(indio_dev, 0);
>  		if (err)
> -			goto err;
> +			goto err_buffer_predisable;
>  	}
>  
>  	if (!iio_trigger_using_own(indio_dev) && priv->waken) {
> @@ -1260,16 +1265,13 @@ static int zpa2326_postenable_buffer(struct iio_dev *indio_dev)
>  		 */
>  		err = zpa2326_config_oneshot(indio_dev, priv->irq);
>  		if (err)
> -			goto err;
> +			goto err_buffer_predisable;
>  	}
>  
> -	/* Plug our own trigger event handler. */
> -	err = iio_triggered_buffer_postenable(indio_dev);
> -	if (err)
> -		goto err;
> -
>  	return 0;
>  
> +err_buffer_predisable:
> +	iio_triggered_buffer_predisable(indio_dev);
>  err:
>  	zpa2326_err(indio_dev, "failed to enable buffering (%d)", err);
>  

