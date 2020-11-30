Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 739692C8FA5
	for <lists+linux-iio@lfdr.de>; Mon, 30 Nov 2020 22:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387637AbgK3VIk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Nov 2020 16:08:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:37700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387520AbgK3VIk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 30 Nov 2020 16:08:40 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD3E020674;
        Mon, 30 Nov 2020 21:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606770478;
        bh=ugJffCE8sM9Xt42rl+LX9ZsdYcLab0uYg5kWqh5DguI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nReQoWzJXYGKGpeubc3uPkgMhcxrXNkKqNqRlSc3QnLQMvIAvL+0deMMG+dVJZT05
         Nbt9zzqfsgSXKtUmzwmuwln63FkwBM2qopZPoUncrDGvNBw/xU3wQNL1EiHTKhTrV/
         FybHxWhairg/NA2wUHohFNiFsGBMO01pOLs1y3g8=
Date:   Mon, 30 Nov 2020 21:07:52 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH 2/2] iio: gyro: mpu3050: Store timestamp in poll
 function
Message-ID: <20201130210752.5028588c@archlinux>
In-Reply-To: <20201130125915.1315667-2-linus.walleij@linaro.org>
References: <20201130125915.1315667-1-linus.walleij@linaro.org>
        <20201130125915.1315667-2-linus.walleij@linaro.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 30 Nov 2020 13:59:15 +0100
Linus Walleij <linus.walleij@linaro.org> wrote:

> If something other than the MPU3050 itself is using this
> trigger, the timestamp needs to be stored in the poll
> function.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
I'm a bit confused here.

pollfuncs are per device using the trigger, so writing to the
timestamp of the one from this device, won't have an affect on
any others.

If it did, we'd still have an issue as there are no ordering
guarantees amongst different consumers of a trigger.

Jonathan

> ---
>  drivers/iio/gyro/mpu3050-core.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
> index 0d0850945d3a..b892487394ea 100644
> --- a/drivers/iio/gyro/mpu3050-core.c
> +++ b/drivers/iio/gyro/mpu3050-core.c
> @@ -457,7 +457,7 @@ static int mpu3050_write_raw(struct iio_dev *indio_dev,
>  
>  static irqreturn_t mpu3050_trigger_handler(int irq, void *p)
>  {
> -	const struct iio_poll_func *pf = p;
> +	struct iio_poll_func *pf = p;
>  	struct iio_dev *indio_dev = pf->indio_dev;
>  	struct mpu3050 *mpu3050 = iio_priv(indio_dev);
>  	int ret;
> @@ -482,6 +482,9 @@ static irqreturn_t mpu3050_trigger_handler(int irq, void *p)
>  	else
>  		timestamp = iio_get_time_ns(indio_dev);
>  
> +	/* Someone else may be using us as trigger */
> +	pf->timestamp = timestamp;
> +
>  	mutex_lock(&mpu3050->lock);
>  
>  	/* Using the hardware IRQ trigger? Check the buffer then. */

