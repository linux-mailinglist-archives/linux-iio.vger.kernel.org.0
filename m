Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7487227D36E
	for <lists+linux-iio@lfdr.de>; Tue, 29 Sep 2020 18:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729600AbgI2QOr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 29 Sep 2020 12:14:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:57732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728672AbgI2QOr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 29 Sep 2020 12:14:47 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13F522075E;
        Tue, 29 Sep 2020 16:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601396086;
        bh=DB3SrWQpST+TPzcN24MAbbQXiKaUKnra5iYvA7PGPYI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PTPYidm3vqUEgaAIu0kCJqrAOGIWZymyrwDyraC21xxJc7QRmgs07Pr4AA1A993io
         tNRYjc2jFlhU+kguDRBWj0q+aLwGmw8Ly+GL/mTtpo6qi+i54CFs+HFtGmOUtkB3em
         WzZKIhtf+yVccggNp9fzXFThhs/Bgto6jKA43YZU=
Date:   Tue, 29 Sep 2020 17:14:41 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mircea Caprioru <mircea.caprioru@analog.com>
Cc:     <Michael.Hennerich@analog.com>, <alexandru.ardelean@analog.com>,
        <lars@metafoo.de>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Subject: Re: [PATCH 4/5] iio: adc: vf610_adc: Replace indio_dev->mlock with
 own device lock
Message-ID: <20200929171441.5b4ff8c8@archlinux>
In-Reply-To: <20200928131333.36646-4-mircea.caprioru@analog.com>
References: <20200928131333.36646-1-mircea.caprioru@analog.com>
        <20200928131333.36646-4-mircea.caprioru@analog.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 28 Sep 2020 16:13:32 +0300
Mircea Caprioru <mircea.caprioru@analog.com> wrote:

> From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> 
> As part of the general cleanup of indio_dev->mlock, this change replaces
> it with a local lock on the device's state structure.
> 
> This is part of a bigger cleanup.
> Link: https://lore.kernel.org/linux-iio/CA+U=Dsoo6YABe5ODLp+eFNPGFDjk5ZeQEceGkqjxXcVEhLWubw@mail.gmail.com/
> 
> Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>

There are more problems in the locking in here than just this one.
See below.  The taking of mlock like this was what originally motivated
the efforts to hide it away from drivers.

In this particular case I don't think a local lock is the correct solution.

Thanks,

Jonathan


> ---
>  drivers/iio/adc/vf610_adc.c | 28 ++++++++++++++++++++--------
>  1 file changed, 20 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c
> index 1d794cf3e3f1..b7d583993f0b 100644
> --- a/drivers/iio/adc/vf610_adc.c
> +++ b/drivers/iio/adc/vf610_adc.c
> @@ -168,6 +168,15 @@ struct vf610_adc {
>  
>  	struct completion completion;
>  	u16 buffer[8];

Side note.  That buffer isn't correctly aligned.  I'll add this one to
my next series fixing those.

> +	/*
> +	 * Lock to protect the device state during a potential concurrent
> +	 * read access from userspace. Reading a raw value requires a sequence
> +	 * of register writes, then a wait for a completion callback,
> +	 * and finally a register read, during which userspace could issue
> +	 * another read request. This lock protects a read access from
> +	 * ocurring before another one has finished.
> +	 */
> +	struct mutex lock;
>  };
>  
>  static const u32 vf610_hw_avgs[] = { 1, 4, 8, 16, 32 };
> @@ -464,11 +473,11 @@ static int vf610_set_conversion_mode(struct iio_dev *indio_dev,
>  {
>  	struct vf610_adc *info = iio_priv(indio_dev);
>  
> -	mutex_lock(&indio_dev->mlock);
> +	mutex_lock(&info->lock);
Hmm. So there is a bit of a question on what the locking here is doing.
(see below for a different use of mlock).

What it will do currently is to prevent the conversion mode changing whilst
we are in buffered mode.  It will also protect against concurrent
calls of this function.

I would replace this with iio_device_claim_direct_mode() rather than a
local lock.

>  	info->adc_feature.conv_mode = mode;
>  	vf610_adc_calculate_rates(info);
>  	vf610_adc_hw_init(info);
> -	mutex_unlock(&indio_dev->mlock);
> +	mutex_unlock(&info->lock);
>  
>  	return 0;
>  }
> @@ -632,9 +641,9 @@ static int vf610_read_raw(struct iio_dev *indio_dev,
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
>  	case IIO_CHAN_INFO_PROCESSED:
> -		mutex_lock(&indio_dev->mlock);
> +		mutex_lock(&info->lock);
>  		if (iio_buffer_enabled(indio_dev)) {
> -			mutex_unlock(&indio_dev->mlock);
> +			mutex_unlock(&info->lock);

Should be use iio_device_claim_direct_mode()

mlock is being taken here to stop us entering buffered mode.

Whilst I'd rather a driver didn't rely on internal details of
IIO, it is rather fiddly to get the locking right when there is a completion
going on, so I think here you are safe to do so.

>  			return -EBUSY;
>  		}
>  
> @@ -645,11 +654,11 @@ static int vf610_read_raw(struct iio_dev *indio_dev,
>  		ret = wait_for_completion_interruptible_timeout
>  				(&info->completion, VF610_ADC_TIMEOUT);
>  		if (ret == 0) {
> -			mutex_unlock(&indio_dev->mlock);
> +			mutex_unlock(&info->lock);
>  			return -ETIMEDOUT;
>  		}
>  		if (ret < 0) {
> -			mutex_unlock(&indio_dev->mlock);
> +			mutex_unlock(&info->lock);
>  			return ret;
>  		}
>  
> @@ -668,11 +677,11 @@ static int vf610_read_raw(struct iio_dev *indio_dev,
>  
>  			break;
>  		default:
> -			mutex_unlock(&indio_dev->mlock);
> +			mutex_unlock(&info->lock);
>  			return -EINVAL;
>  		}
>  
> -		mutex_unlock(&indio_dev->mlock);
> +		mutex_unlock(&info->lock);
>  		return IIO_VAL_INT;
>  
>  	case IIO_CHAN_INFO_SCALE:
> @@ -807,6 +816,9 @@ static int vf610_adc_probe(struct platform_device *pdev)
>  	}
>  
>  	info = iio_priv(indio_dev);
> +
> +	mutex_init(&info->lock);
> +
>  	info->dev = &pdev->dev;
>  
>  	info->regs = devm_platform_ioremap_resource(pdev, 0);

