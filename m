Return-Path: <linux-iio+bounces-16545-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B904A57A74
	for <lists+linux-iio@lfdr.de>; Sat,  8 Mar 2025 14:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6859616D2C4
	for <lists+linux-iio@lfdr.de>; Sat,  8 Mar 2025 13:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2F71C5F1D;
	Sat,  8 Mar 2025 13:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jb5zoLXO"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1293B8BEC;
	Sat,  8 Mar 2025 13:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741440270; cv=none; b=asbyxf2fMIJQOPn6/d+q7kOZEavs/370PSD0uVF0Cwhf59lWEa/lYneK1MFW+Poi4lNfXtS6Q3ssG9TrdSRS1rYuuECUUvbMXbeFDS2vDNhrkXRvRRquOGn/JGdKtyGLI0/4qmqjaP4crlZt47+XtwUBG70Vk/b9V8Pqytsbnao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741440270; c=relaxed/simple;
	bh=dTDm8xkg7Q7HNIkbBzs2xatMRchzur0EuNZ+RwR/AgA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W/g7sQsDxqWRwR4kpY/QkVJ6DgGeJwCKAT5XkG2dvXKAtXWU9K9RhOVOPwXM+F1XZvodtvXh9AJzJOVcJfjliTjwPYGIJRYnbJUC+018oyXWhjIcrfWzx+ILlYBnUwnXVI3Z9GpRBlWYH+sNyBWw62CcZxSvcYXs0U3PoW/7OGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jb5zoLXO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48511C4CEE0;
	Sat,  8 Mar 2025 13:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741440269;
	bh=dTDm8xkg7Q7HNIkbBzs2xatMRchzur0EuNZ+RwR/AgA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Jb5zoLXOcy/mkzD8h2ln0JZtm1mshMY+y/G9y7BNUBtYTt4XpdhKOZH1o4S+Cb8WF
	 Sh1KRrHFlYOsVmfQxKQeJvlHl1y1LSyPmklJhKkllC+H0gOfwlt9EK/ZsSnuV/QfsL
	 wfH2Ll9xBqJXTdcUvhDi4BFkFsm7As32OZpSNX9XUkA+N127AF07CMVzDDvoNTv7S5
	 cGohVy7X3mXIExEX0XiLWf3DotLjInjdb9cRwBuyPpJTl7aOgW9TfpjGVVYZJSuJ4S
	 RrsMRxJBr4iKefYPosxjFrwd6d6EuLHZu6AYUuTyDuvFQBzXPlttjymxNOcqVAmTpe
	 I/mVrBOKSa3Ug==
Date: Sat, 8 Mar 2025 13:24:20 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
 <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
 <marcelo.schmitt@analog.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <linus.walleij@linaro.org>, <brgl@bgdev.pl>,
 <lgirdwood@gmail.com>, <broonie@kernel.org>, <dlechner@baylibre.com>,
 <marcelo.schmitt1@gmail.com>, <jonath4nns@gmail.com>
Subject: Re: [PATCH v4 07/17] iio: adc: ad7768-1: remove unnecessary locking
Message-ID: <20250308132420.29d8dc90@jic23-huawei>
In-Reply-To: <d0450b7c5d8467e54913ef905f6147baa2b866b3.1741268122.git.Jonathan.Santos@analog.com>
References: <cover.1741268122.git.Jonathan.Santos@analog.com>
	<d0450b7c5d8467e54913ef905f6147baa2b866b3.1741268122.git.Jonathan.Santos@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Mar 2025 18:01:51 -0300
Jonathan Santos <Jonathan.Santos@analog.com> wrote:

> The current locking is only preventing a triggered buffer Transfer and a
> debugfs register access from happening at the same time. If a register
> access happens during a buffered read, the action is doomed to fail anyway,
> since we need to write a magic value to exit continuous read mode.
> 
> Remove locking from the trigger handler and use
> iio_device_claim_direct_mode() instead in the register access function.
> 
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
I don't really want more of the old school direct_mode calls
so I applied this with following tweak.  Please take a look
at the result on testing branch of iio.git.

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index a427427aa324..5a863005aca6 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -255,9 +255,8 @@ static int ad7768_reg_access(struct iio_dev *indio_dev,
        struct ad7768_state *st = iio_priv(indio_dev);
        int ret;
 
-       ret = iio_device_claim_direct_mode(indio_dev);
-       if (ret)
-               return ret;
+       if (!iio_device_claim_direct(indio_dev))
+               return -EBUSY;
 
        if (readval) {
                ret = ad7768_spi_reg_read(st, reg, 1);
@@ -269,7 +268,7 @@ static int ad7768_reg_access(struct iio_dev *indio_dev,
                ret = ad7768_spi_reg_write(st, reg, writeval);
        }
 err_release:
-       iio_device_release_direct_mode(indio_dev);
+       iio_device_release_direct(indio_dev);
 
        return ret;
 }


> ---
> v4 Changes:
> * None.
> 
> v3 Changes:
> * Also removed the mutex_init and lock variable.
> 
> v2 Changes:
> * New patch in v2. It replaces the guard(mutex) patch. 
> ---
>  drivers/iio/adc/ad7768-1.c | 21 +++++++++------------
>  1 file changed, 9 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
> index 2e2d50ccb744..f5509a0a36ab 100644
> --- a/drivers/iio/adc/ad7768-1.c
> +++ b/drivers/iio/adc/ad7768-1.c
> @@ -154,7 +154,6 @@ static const struct iio_chan_spec ad7768_channels[] = {
>  struct ad7768_state {
>  	struct spi_device *spi;
>  	struct regulator *vref;
> -	struct mutex lock;
>  	struct clk *mclk;
>  	unsigned int mclk_freq;
>  	unsigned int samp_freq;
> @@ -256,18 +255,21 @@ static int ad7768_reg_access(struct iio_dev *indio_dev,
>  	struct ad7768_state *st = iio_priv(indio_dev);
>  	int ret;
>  
> -	mutex_lock(&st->lock);
> +	ret = iio_device_claim_direct_mode(indio_dev);
> +	if (ret)
> +		return ret;
> +
>  	if (readval) {
>  		ret = ad7768_spi_reg_read(st, reg, 1);
>  		if (ret < 0)
> -			goto err_unlock;
> +			goto err_release;
>  		*readval = ret;
>  		ret = 0;
>  	} else {
>  		ret = ad7768_spi_reg_write(st, reg, writeval);
>  	}
> -err_unlock:
> -	mutex_unlock(&st->lock);
> +err_release:
> +	iio_device_release_direct_mode(indio_dev);
>  
>  	return ret;
>  }
> @@ -471,18 +473,15 @@ static irqreturn_t ad7768_trigger_handler(int irq, void *p)
>  	struct ad7768_state *st = iio_priv(indio_dev);
>  	int ret;
>  
> -	mutex_lock(&st->lock);
> -
>  	ret = spi_read(st->spi, &st->data.scan.chan, 3);
>  	if (ret < 0)
> -		goto err_unlock;
> +		goto out;
>  
>  	iio_push_to_buffers_with_timestamp(indio_dev, &st->data.scan,
>  					   iio_get_time_ns(indio_dev));
>  
> -err_unlock:
> +out:
>  	iio_trigger_notify_done(indio_dev->trig);
> -	mutex_unlock(&st->lock);
>  
>  	return IRQ_HANDLED;
>  }
> @@ -611,8 +610,6 @@ static int ad7768_probe(struct spi_device *spi)
>  
>  	st->mclk_freq = clk_get_rate(st->mclk);
>  
> -	mutex_init(&st->lock);
> -
>  	indio_dev->channels = ad7768_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(ad7768_channels);
>  	indio_dev->name = spi_get_device_id(spi)->name;


