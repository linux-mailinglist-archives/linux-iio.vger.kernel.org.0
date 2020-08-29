Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59DC52568CD
	for <lists+linux-iio@lfdr.de>; Sat, 29 Aug 2020 17:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbgH2PsZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 29 Aug 2020 11:48:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:52652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728196AbgH2PsY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 29 Aug 2020 11:48:24 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76C0820707;
        Sat, 29 Aug 2020 15:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598716104;
        bh=olaj4mfRdSNKVp9/w5JZeBiiV/a623ih5qbSllfvqhQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ILwj7qduSFuIparMmv+ZbPBC0XyqsOztCZDqfBWKxyRY1iMPcT5jk/MKI1yKuwtQM
         v22Q+lDk9/n8lvVOaWO3tp3Rj5bH2CH0WbphBCxjKf1OwwQJCJ8WaShBo1i2zwrZg9
         GS/nlNson9vioAJbt0SyGgFRg3K43dVBAZCbX/L8=
Date:   Sat, 29 Aug 2020 16:48:19 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Subject: Re: [PATCH] iio: frequency: adf4350: Replace indio_dev->mlock with
 own device lock
Message-ID: <20200829164819.7425030d@archlinux>
In-Reply-To: <20200826064257.53475-1-alexandru.ardelean@analog.com>
References: <20200826064257.53475-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 26 Aug 2020 09:42:57 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> 
> As part of the general cleanup of indio_dev->mlock, this change replaces
> it with a local lock on the device's state structure.
> 
> Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>  drivers/iio/frequency/adf4350.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/frequency/adf4350.c b/drivers/iio/frequency/adf4350.c
> index 409c9c47161e..3f37a57cd3c3 100644
> --- a/drivers/iio/frequency/adf4350.c
> +++ b/drivers/iio/frequency/adf4350.c
> @@ -47,6 +47,7 @@ struct adf4350_state {
>  	unsigned long			regs[6];
>  	unsigned long			regs_hw[6];
>  	unsigned long long		freq_req;
> +	struct mutex			lock;
Same thing about need for a comment in the code on what the lock scope is.
I'm sure checkpatch used to moan about this.  I guess maybe it stopped
doing so at some stage.

Jonathan

>  	/*
>  	 * DMA (thus cache coherency maintenance) requires the
>  	 * transfer buffers to live in their own cache lines.
> @@ -99,7 +100,7 @@ static int adf4350_reg_access(struct iio_dev *indio_dev,
>  	if (reg > ADF4350_REG5)
>  		return -EINVAL;
>  
> -	mutex_lock(&indio_dev->mlock);
> +	mutex_lock(&st->lock);
>  	if (readval == NULL) {
>  		st->regs[reg] = writeval & ~(BIT(0) | BIT(1) | BIT(2));
>  		ret = adf4350_sync_config(st);
> @@ -107,7 +108,7 @@ static int adf4350_reg_access(struct iio_dev *indio_dev,
>  		*readval =  st->regs_hw[reg];
>  		ret = 0;
>  	}
> -	mutex_unlock(&indio_dev->mlock);
> +	mutex_unlock(&st->lock);
>  
>  	return ret;
>  }
> @@ -254,7 +255,7 @@ static ssize_t adf4350_write(struct iio_dev *indio_dev,
>  	if (ret)
>  		return ret;
>  
> -	mutex_lock(&indio_dev->mlock);
> +	mutex_lock(&st->lock);
>  	switch ((u32)private) {
>  	case ADF4350_FREQ:
>  		ret = adf4350_set_freq(st, readin);
> @@ -295,7 +296,7 @@ static ssize_t adf4350_write(struct iio_dev *indio_dev,
>  	default:
>  		ret = -EINVAL;
>  	}
> -	mutex_unlock(&indio_dev->mlock);
> +	mutex_unlock(&st->lock);
>  
>  	return ret ? ret : len;
>  }
> @@ -309,7 +310,7 @@ static ssize_t adf4350_read(struct iio_dev *indio_dev,
>  	unsigned long long val;
>  	int ret = 0;
>  
> -	mutex_lock(&indio_dev->mlock);
> +	mutex_lock(&st->lock);
>  	switch ((u32)private) {
>  	case ADF4350_FREQ:
>  		val = (u64)((st->r0_int * st->r1_mod) + st->r0_fract) *
> @@ -338,7 +339,7 @@ static ssize_t adf4350_read(struct iio_dev *indio_dev,
>  		ret = -EINVAL;
>  		val = 0;
>  	}
> -	mutex_unlock(&indio_dev->mlock);
> +	mutex_unlock(&st->lock);
>  
>  	return ret < 0 ? ret : sprintf(buf, "%llu\n", val);
>  }
> @@ -539,6 +540,8 @@ static int adf4350_probe(struct spi_device *spi)
>  	indio_dev->channels = &adf4350_chan;
>  	indio_dev->num_channels = 1;
>  
> +	mutex_init(&st->lock);
> +
>  	st->chspc = pdata->channel_spacing;
>  	if (clk) {
>  		st->clk = clk;

