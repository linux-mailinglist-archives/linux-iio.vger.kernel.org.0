Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58501E645D
	for <lists+linux-iio@lfdr.de>; Sun, 27 Oct 2019 17:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbfJ0Q6R (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 27 Oct 2019 12:58:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:52082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727077AbfJ0Q6R (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 27 Oct 2019 12:58:17 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D6EB20679;
        Sun, 27 Oct 2019 16:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572195496;
        bh=pll53aE69hNh/m9+0yjyt0oK8R/ifUVvZeFh6O6x0ZU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CoJhD2lx+d2js2/l6XApHESbsgX4LN5CwSVt831hukm+28D3BUBwVmoY15WJh3DpI
         5suwFYnGxih1+pV0XT7UNiHbgB8SJ5/1+ERw6ggd0UVH86QZ7MqXk2zV6+mfkTTvPy
         o51pcTVLJHQbePIQDUomgD4SjhkhSvUzH8BzB/qs=
Date:   Sun, 27 Oct 2019 16:58:13 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: Re: [PATCH] iio: hdc100x: fix
 iio_triggered_buffer_{predisable,postenable} positions
Message-ID: <20191027165813.5a5b0519@archlinux>
In-Reply-To: <20191023082714.18681-1-alexandru.ardelean@analog.com>
References: <20191023082714.18681-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 23 Oct 2019 11:27:14 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> The iio_triggered_buffer_postenable() hook should be called first to
> attach the poll function and the iio_triggered_buffer_predisable() hook
> should be called last in the predisable hook.
> 
> This change updates the driver to attach/detach the poll func in the
> correct order.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Seems fine, but should have cc'd Matt and I'd like to give him time
to take a quick look.

+CC Matt.

Thanks,

Jonathan

> ---
>  drivers/iio/humidity/hdc100x.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/humidity/hdc100x.c b/drivers/iio/humidity/hdc100x.c
> index bfe1cdb16846..963ff043eecf 100644
> --- a/drivers/iio/humidity/hdc100x.c
> +++ b/drivers/iio/humidity/hdc100x.c
> @@ -278,31 +278,34 @@ static int hdc100x_buffer_postenable(struct iio_dev *indio_dev)
>  	struct hdc100x_data *data = iio_priv(indio_dev);
>  	int ret;
>  
> +	ret = iio_triggered_buffer_postenable(indio_dev);
> +	if (ret)
> +		return ret;
> +
>  	/* Buffer is enabled. First set ACQ Mode, then attach poll func */
>  	mutex_lock(&data->lock);
>  	ret = hdc100x_update_config(data, HDC100X_REG_CONFIG_ACQ_MODE,
>  				    HDC100X_REG_CONFIG_ACQ_MODE);
>  	mutex_unlock(&data->lock);
>  	if (ret)
> -		return ret;
> +		iio_triggered_buffer_predisable(indio_dev);
>  
> -	return iio_triggered_buffer_postenable(indio_dev);
> +	return ret;
>  }
>  
>  static int hdc100x_buffer_predisable(struct iio_dev *indio_dev)
>  {
>  	struct hdc100x_data *data = iio_priv(indio_dev);
> -	int ret;
> -
> -	/* First detach poll func, then reset ACQ mode. OK to disable buffer */
> -	ret = iio_triggered_buffer_predisable(indio_dev);
> -	if (ret)
> -		return ret;
> +	int ret, ret2;
>  
>  	mutex_lock(&data->lock);
>  	ret = hdc100x_update_config(data, HDC100X_REG_CONFIG_ACQ_MODE, 0);
>  	mutex_unlock(&data->lock);
>  
> +	ret2 = iio_triggered_buffer_predisable(indio_dev);
> +	if (ret == 0)
> +		ret = ret2;
> +
>  	return ret;
>  }
>  

