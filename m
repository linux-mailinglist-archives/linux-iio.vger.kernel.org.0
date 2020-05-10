Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6C61CCA2C
	for <lists+linux-iio@lfdr.de>; Sun, 10 May 2020 12:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725994AbgEJKUs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 10 May 2020 06:20:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:41788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725839AbgEJKUr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 10 May 2020 06:20:47 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D1E5207DD;
        Sun, 10 May 2020 10:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589106046;
        bh=5i70s4OyllLpBXCIVzWuGh73mp5oczUpR2uKHtbqmW0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qydJXYu5FWAoZNyCJvtDm+57uDSVlA4tBscTSdYjoXY+N7G2eu1W6W2G+yE/G04/a
         /xgPJmJLC9puXYh0VvRSDLp7Fro77HsrFv4Yq2+gOMsVv/3eCJy7aa1kMNKGjjN5D5
         fGj3eOTXDxmFbxKXjxVY+kBB/S4ScynFiJ53+HYE=
Date:   Sun, 10 May 2020 11:20:42 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jonathan Bakker <xc-racer2@live.ca>
Cc:     linus.walleij@linaro.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: light: gp2ap002: Take runtime PM reference on
 light read
Message-ID: <20200510112042.3f995867@archlinux>
In-Reply-To: <BN6PR04MB0660DD24B7B4418DCC2806FBA3A30@BN6PR04MB0660.namprd04.prod.outlook.com>
References: <BN6PR04MB0660DD24B7B4418DCC2806FBA3A30@BN6PR04MB0660.namprd04.prod.outlook.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri,  8 May 2020 18:42:21 -0700
Jonathan Bakker <xc-racer2@live.ca> wrote:

> The light sensor needs the regulators to be enabled which means
> the runtime PM needs to be on.  This only happened when the
> proximity part of the chip was enabled.
> 
> As fallout from this change, only report changes to the prox
> state in the interrupt handler when it is explicitly enabled.
> 
> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
Looks good to me, but needs a fixes tag as we'll want to fix
this up in all kernels where it applies (just the current
RCs I think..)

Thanks,

Jonathan

> ---
>  drivers/iio/light/gp2ap002.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/light/gp2ap002.c b/drivers/iio/light/gp2ap002.c
> index b7ef16b28280..7a2679bdc987 100644
> --- a/drivers/iio/light/gp2ap002.c
> +++ b/drivers/iio/light/gp2ap002.c
> @@ -158,6 +158,9 @@ static irqreturn_t gp2ap002_prox_irq(int irq, void *d)
>  	int val;
>  	int ret;
>  
> +	if (!gp2ap002->enabled)
> +		goto err_retrig;
> +
>  	ret = regmap_read(gp2ap002->map, GP2AP002_PROX, &val);
>  	if (ret) {
>  		dev_err(gp2ap002->dev, "error reading proximity\n");
> @@ -247,6 +250,8 @@ static int gp2ap002_read_raw(struct iio_dev *indio_dev,
>  	struct gp2ap002 *gp2ap002 = iio_priv(indio_dev);
>  	int ret;
>  
> +	pm_runtime_get_sync(gp2ap002->dev);
> +
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
>  		switch (chan->type) {
> @@ -255,13 +260,21 @@ static int gp2ap002_read_raw(struct iio_dev *indio_dev,
>  			if (ret < 0)
>  				return ret;
>  			*val = ret;
> -			return IIO_VAL_INT;
> +			ret = IIO_VAL_INT;
> +			goto out;
>  		default:
> -			return -EINVAL;
> +			ret = -EINVAL;
> +			goto out;
>  		}
>  	default:
> -		return -EINVAL;
> +		ret = -EINVAL;
>  	}
> +
> +out:
> +	pm_runtime_mark_last_busy(gp2ap002->dev);
> +	pm_runtime_put_autosuspend(gp2ap002->dev);
> +
> +	return ret;
>  }
>  
>  static int gp2ap002_init(struct gp2ap002 *gp2ap002)

