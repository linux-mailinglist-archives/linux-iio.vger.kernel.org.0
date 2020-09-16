Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D58526C6E2
	for <lists+linux-iio@lfdr.de>; Wed, 16 Sep 2020 20:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbgIPSIe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 16 Sep 2020 14:08:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:46868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727694AbgIPR6T (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 16 Sep 2020 13:58:19 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBFFB2076B;
        Wed, 16 Sep 2020 17:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600279098;
        bh=+43Ykv5x1hiK5lShKkt7YXFXa30fYFn37g4imfPEGAw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aC4gj2s/TStjch59l/IETDWoNMUVrg7j9dOaL9oIebdieLYD4PwANdubD+Wgf6iU+
         bE4Eq+8EsY6YOyTYHkfmhNHQbqxuH7kMVzecCyitE7T93PRdknjG6rbrX8erbK3JUV
         hUtwXrpdzH+wNxt/SuxkOboTXXZ3iAW9V9aKopVk=
Date:   Wed, 16 Sep 2020 18:58:16 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Subject: Re: [PATCH v2] iio: frequency: adf4350: Replace indio_dev->mlock
 with own device lock
Message-ID: <20200916185816.7d1075f3@archlinux>
In-Reply-To: <20200916092731.77220-1-alexandru.ardelean@analog.com>
References: <20200826064257.53475-1-alexandru.ardelean@analog.com>
        <20200916092731.77220-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 16 Sep 2020 12:27:31 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> 
> As part of the general cleanup of indio_dev->mlock, this change replaces
> it with a local lock.
> The lock protect the state of the device from potential concurrent writes.
> The device is configured via a sequence of SPI writes, and this lock is
> meant to prevent the start of another sequence before another one has
> finished.
> 
> This is part of a bigger cleanup.
> Link: https://lore.kernel.org/linux-iio/CA+U=Dsoo6YABe5ODLp+eFNPGFDjk5ZeQEceGkqjxXcVEhLWubw@mail.gmail.com/
> 
> Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

Applied

> ---
>  drivers/iio/frequency/adf4350.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/frequency/adf4350.c b/drivers/iio/frequency/adf4350.c
> index 409c9c47161e..82c050a3899d 100644
> --- a/drivers/iio/frequency/adf4350.c
> +++ b/drivers/iio/frequency/adf4350.c
> @@ -47,6 +47,13 @@ struct adf4350_state {
>  	unsigned long			regs[6];
>  	unsigned long			regs_hw[6];
>  	unsigned long long		freq_req;
> +	/*
> +	 * Lock to protect the state of the device from potential concurrent
> +	 * writes. The device is configured via a sequence of SPI writes,
> +	 * and this lock is meant to prevent the start of another sequence
> +	 * before another one has finished.
> +	 */
> +	struct mutex			lock;
>  	/*
>  	 * DMA (thus cache coherency maintenance) requires the
>  	 * transfer buffers to live in their own cache lines.
> @@ -99,7 +106,7 @@ static int adf4350_reg_access(struct iio_dev *indio_dev,
>  	if (reg > ADF4350_REG5)
>  		return -EINVAL;
>  
> -	mutex_lock(&indio_dev->mlock);
> +	mutex_lock(&st->lock);
>  	if (readval == NULL) {
>  		st->regs[reg] = writeval & ~(BIT(0) | BIT(1) | BIT(2));
>  		ret = adf4350_sync_config(st);
> @@ -107,7 +114,7 @@ static int adf4350_reg_access(struct iio_dev *indio_dev,
>  		*readval =  st->regs_hw[reg];
>  		ret = 0;
>  	}
> -	mutex_unlock(&indio_dev->mlock);
> +	mutex_unlock(&st->lock);
>  
>  	return ret;
>  }
> @@ -254,7 +261,7 @@ static ssize_t adf4350_write(struct iio_dev *indio_dev,
>  	if (ret)
>  		return ret;
>  
> -	mutex_lock(&indio_dev->mlock);
> +	mutex_lock(&st->lock);
>  	switch ((u32)private) {
>  	case ADF4350_FREQ:
>  		ret = adf4350_set_freq(st, readin);
> @@ -295,7 +302,7 @@ static ssize_t adf4350_write(struct iio_dev *indio_dev,
>  	default:
>  		ret = -EINVAL;
>  	}
> -	mutex_unlock(&indio_dev->mlock);
> +	mutex_unlock(&st->lock);
>  
>  	return ret ? ret : len;
>  }
> @@ -309,7 +316,7 @@ static ssize_t adf4350_read(struct iio_dev *indio_dev,
>  	unsigned long long val;
>  	int ret = 0;
>  
> -	mutex_lock(&indio_dev->mlock);
> +	mutex_lock(&st->lock);
>  	switch ((u32)private) {
>  	case ADF4350_FREQ:
>  		val = (u64)((st->r0_int * st->r1_mod) + st->r0_fract) *
> @@ -338,7 +345,7 @@ static ssize_t adf4350_read(struct iio_dev *indio_dev,
>  		ret = -EINVAL;
>  		val = 0;
>  	}
> -	mutex_unlock(&indio_dev->mlock);
> +	mutex_unlock(&st->lock);
>  
>  	return ret < 0 ? ret : sprintf(buf, "%llu\n", val);
>  }
> @@ -539,6 +546,8 @@ static int adf4350_probe(struct spi_device *spi)
>  	indio_dev->channels = &adf4350_chan;
>  	indio_dev->num_channels = 1;
>  
> +	mutex_init(&st->lock);
> +
>  	st->chspc = pdata->channel_spacing;
>  	if (clk) {
>  		st->clk = clk;

