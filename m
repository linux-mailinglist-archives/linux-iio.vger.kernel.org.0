Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37EE11B87C5
	for <lists+linux-iio@lfdr.de>; Sat, 25 Apr 2020 18:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbgDYQuK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 25 Apr 2020 12:50:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:36598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726148AbgDYQuK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 25 Apr 2020 12:50:10 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46A1D20714;
        Sat, 25 Apr 2020 16:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587833410;
        bh=ddMxxmplEYvOrsmlNc7BIWl6PERpaiqw7X0QTIAoAKo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=S4kqytA4gEg293ysVtwtQ4hbCzyOIjEzpWmWeRtIs8JqhgyicQd/UWfwXrG4hPx/b
         zTaJRirnyLyju5NsWO0uKA8zNKfsesMA4nlnje+8Wlk66M1wRjMQH4unkJxhsjkSmU
         1ppwcK66AQHGbrZi4WqWXyHalb/uJWVkhMId4eYU=
Date:   Sat, 25 Apr 2020 17:50:06 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v1 14/16] iio: pressure: zpa2326: Use
 get_unaligned_le24()
Message-ID: <20200425175006.3a244a3b@archlinux>
In-Reply-To: <20200421003135.23060-14-andriy.shevchenko@linux.intel.com>
References: <20200421003135.23060-1-andriy.shevchenko@linux.intel.com>
        <20200421003135.23060-14-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 21 Apr 2020 03:31:33 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> This makes the driver code slightly easier to read.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Include added and applied.

Thanks,

Jonathan

> ---
>  drivers/iio/pressure/zpa2326.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/pressure/zpa2326.c b/drivers/iio/pressure/zpa2326.c
> index 99dfe33ee402..c2ad106e3d5b 100644
> --- a/drivers/iio/pressure/zpa2326.c
> +++ b/drivers/iio/pressure/zpa2326.c
> @@ -1005,22 +1005,20 @@ static int zpa2326_fetch_raw_sample(const struct iio_dev *indio_dev,
>  	struct regmap *regs = ((struct zpa2326_private *)
>  			       iio_priv(indio_dev))->regmap;
>  	int            err;
> +	u8             v[3];
>  
>  	switch (type) {
>  	case IIO_PRESSURE:
>  		zpa2326_dbg(indio_dev, "fetching raw pressure sample");
>  
> -		err = regmap_bulk_read(regs, ZPA2326_PRESS_OUT_XL_REG, value,
> -				       3);
> +		err = regmap_bulk_read(regs, ZPA2326_PRESS_OUT_XL_REG, v, sizeof(v));
>  		if (err) {
>  			zpa2326_warn(indio_dev, "failed to fetch pressure (%d)",
>  				     err);
>  			return err;
>  		}
>  
> -		/* Pressure is a 24 bits wide little-endian unsigned int. */
> -		*value = (((u8 *)value)[2] << 16) | (((u8 *)value)[1] << 8) |
> -			 ((u8 *)value)[0];
> +		*value = get_unaligned_le24(&v[0]);
>  
>  		return IIO_VAL_INT;
>  

