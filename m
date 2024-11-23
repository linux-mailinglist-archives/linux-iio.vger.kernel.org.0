Return-Path: <linux-iio+bounces-12557-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8766E9D6A42
	for <lists+linux-iio@lfdr.de>; Sat, 23 Nov 2024 17:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4757C28197B
	for <lists+linux-iio@lfdr.de>; Sat, 23 Nov 2024 16:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082DB13CFBD;
	Sat, 23 Nov 2024 16:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KeBM6OwB"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBC712FF70;
	Sat, 23 Nov 2024 16:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732380152; cv=none; b=Cb8zJiX380Eyir0+3x0yp/d+E2Fcwwu94QQ72ovwd1gE2E/6tQWqQescNmZhxbm/jYxa4ceZft3JOn4tNaTNf1630WUDEYYqxjEjgtWdggAnrrI3sQIGy+eFtVXGIRsTDaZuKx93GuqMZ6OdibxdgY73dqw/E8OgE3TCkbPyFuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732380152; c=relaxed/simple;
	bh=MO1KYulozHKhO5Y78u67HXAWx12VemXEAhNdobLx5NY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HgMKLwTpJvaiC0LK2A8ZwL/kTa+4FG5LnYVaMnIvXF9LuPF8HzF510AxPyxJoD9KVK9L3k/nJy3lE4qSK2dTD/oqya+SRQAPzaqplmIcOMRLnZ5dqYJLDFg9LIyaJY3FXSaRR/3P6/mP+ITxCJveysNskWz2FSsradmGKayVpVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KeBM6OwB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEE58C4CECD;
	Sat, 23 Nov 2024 16:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732380152;
	bh=MO1KYulozHKhO5Y78u67HXAWx12VemXEAhNdobLx5NY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KeBM6OwBAEk4cX1z+VZKX+bfrYqtFeERekYG8wnxlgAVd4orJaCs+oveUvojiu6Sl
	 OQAJe8rkaywKN9a4Qxyzoc9q/a9zg5TnbdyfemQeLXPAibTxP7ooxVT8es4HheRSF9
	 3CZAY7l+jK1ZHGikyrknQbMjJuGntiMrTFCachK2GAIQnMync3QYyNvo6KHeZ7d+vx
	 RW/es7JjfJC7AvPXrkGmA9ZFawwSy43ZKDi2o0BDD0kmrOPIlJQW1xvHDaqXZMpIDe
	 VMhbcKZ5PhTa+8HhmccanUmlcidD6GJZDJ0vfubPK298u1iqz99TrglXv9+I/08B4+
	 v/qy5vR60RbEg==
Date: Sat, 23 Nov 2024 16:42:23 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/8] iio: accel: kx022a: Use cleanup.h helpers
Message-ID: <20241123164223.25656985@jic23-huawei>
In-Reply-To: <037985fe50fe79c79b9df95fa7b4e577378f9a60.1732105157.git.mazziesaccount@gmail.com>
References: <cover.1732105157.git.mazziesaccount@gmail.com>
	<037985fe50fe79c79b9df95fa7b4e577378f9a60.1732105157.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Nov 2024 10:20:23 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> A few functions in KX022A need to use mutex for protecting the
> enabling/disabling of the measurement while configurations are being
> made. Some of the functions can be slightly simplified by using the
> __cleanup based scoped mutexes, which allows dropping the goto based
> unlocking at error path.
> 
> Simplify error paths using guard(mutex).
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Now we have guard(), the main reason (I think) for the
combined on + lock and off + unlock paths is gone. So can
we just flatten those and do the locking at caller.

After this patch there are only 4 more users anyway and the
ones in the switch statement can be easily done with {}
and guard.

The ones in probe() can be done with a scoped_guard()

Jonathan


> ---
> 
> Revision history:
>   v1 => v2:
>   - patch number changed because a change was added to the series.
>   - rebased on iio/testing to avoid conflicts with queued fixes
> ---
>  drivers/iio/accel/kionix-kx022a.c | 61 ++++++++++++-------------------
>  1 file changed, 23 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-kx022a.c
> index b6664299e0d5..98953178a580 100644
> --- a/drivers/iio/accel/kionix-kx022a.c
> +++ b/drivers/iio/accel/kionix-kx022a.c
> @@ -5,6 +5,7 @@
>   * ROHM/KIONIX accelerometer driver
>   */
>  
> +#include <linux/cleanup.h>
>  #include <linux/delay.h>
>  #include <linux/device.h>
>  #include <linux/interrupt.h>
> @@ -448,7 +449,7 @@ static void kx022a_reg2scale(unsigned int val, unsigned int *val1,
>  	*val2 = kx022a_scale_table[val][1];
>  }
>  
> -static int kx022a_turn_on_off_unlocked(struct kx022a_data *data, bool on)
> +static int __kx022a_turn_on_off(struct kx022a_data *data, bool on)
>  {
>  	int ret;
>  
> @@ -469,7 +470,7 @@ static int kx022a_turn_off_lock(struct kx022a_data *data)
>  	int ret;
>  
>  	mutex_lock(&data->mutex);
> -	ret = kx022a_turn_on_off_unlocked(data, false);
> +	ret = __kx022a_turn_on_off(data, false);
>  	if (ret)
>  		mutex_unlock(&data->mutex);
>  
> @@ -480,7 +481,7 @@ static int kx022a_turn_on_unlock(struct kx022a_data *data)
>  {
>  	int ret;
>  
> -	ret = kx022a_turn_on_off_unlocked(data, true);
> +	ret = __kx022a_turn_on_off(data, true);
>  	mutex_unlock(&data->mutex);
>  
>  	return ret;
> @@ -912,18 +913,19 @@ static int kx022a_fifo_disable(struct kx022a_data *data)
>  {
>  	int ret = 0;
>  
> -	ret = kx022a_turn_off_lock(data);
> +	guard(mutex)(&data->mutex);
> +	ret = __kx022a_turn_on_off(data, false);
>  	if (ret)
>  		return ret;
>  
>  	ret = regmap_clear_bits(data->regmap, data->ien_reg, KX022A_MASK_WMI);
>  	if (ret)
> -		goto unlock_out;
> +		return ret;
>  
>  	ret = regmap_clear_bits(data->regmap, data->chip_info->buf_cntl2,
>  				KX022A_MASK_BUF_EN);
>  	if (ret)
> -		goto unlock_out;
> +		return ret;
>  
>  	data->state &= ~KX022A_STATE_FIFO;
>  
> @@ -931,12 +933,7 @@ static int kx022a_fifo_disable(struct kx022a_data *data)
>  
>  	kfree(data->fifo_buffer);
>  
> -	return kx022a_turn_on_unlock(data);
> -
> -unlock_out:
> -	mutex_unlock(&data->mutex);
> -
> -	return ret;
> +	return __kx022a_turn_on_off(data, true);
>  }
>  
>  static int kx022a_buffer_predisable(struct iio_dev *idev)
> @@ -959,33 +956,29 @@ static int kx022a_fifo_enable(struct kx022a_data *data)
>  	if (!data->fifo_buffer)
>  		return -ENOMEM;
>  
> -	ret = kx022a_turn_off_lock(data);
> +	guard(mutex)(&data->mutex);
> +	ret = __kx022a_turn_on_off(data, false);
>  	if (ret)
>  		return ret;
>  
>  	/* Update watermark to HW */
>  	ret = kx022a_fifo_set_wmi(data);
>  	if (ret)
> -		goto unlock_out;
> +		return ret;
>  
>  	/* Enable buffer */
>  	ret = regmap_set_bits(data->regmap, data->chip_info->buf_cntl2,
>  			      KX022A_MASK_BUF_EN);
>  	if (ret)
> -		goto unlock_out;
> +		return ret;
>  
>  	data->state |= KX022A_STATE_FIFO;
>  	ret = regmap_set_bits(data->regmap, data->ien_reg,
>  			      KX022A_MASK_WMI);
>  	if (ret)
> -		goto unlock_out;
> -
> -	return kx022a_turn_on_unlock(data);
> -
> -unlock_out:
> -	mutex_unlock(&data->mutex);
> +		return ret;
>  
> -	return ret;
> +	return __kx022a_turn_on_off(data, true);
>  }
>  
>  static int kx022a_buffer_postenable(struct iio_dev *idev)
> @@ -1053,7 +1046,7 @@ static irqreturn_t kx022a_irq_thread_handler(int irq, void *private)
>  	struct kx022a_data *data = iio_priv(idev);
>  	irqreturn_t ret = IRQ_NONE;
>  
> -	mutex_lock(&data->mutex);
> +	guard(mutex)(&data->mutex);
>  
>  	if (data->trigger_enabled) {
>  		iio_trigger_poll_nested(data->trig);
> @@ -1068,8 +1061,6 @@ static irqreturn_t kx022a_irq_thread_handler(int irq, void *private)
>  			ret = IRQ_HANDLED;
>  	}
>  
> -	mutex_unlock(&data->mutex);
> -
>  	return ret;
>  }
>  
> @@ -1079,32 +1070,26 @@ static int kx022a_trigger_set_state(struct iio_trigger *trig,
>  	struct kx022a_data *data = iio_trigger_get_drvdata(trig);
>  	int ret = 0;
>  
> -	mutex_lock(&data->mutex);
> +	guard(mutex)(&data->mutex);
>  
>  	if (data->trigger_enabled == state)
> -		goto unlock_out;
> +		return 0;
>  
>  	if (data->state & KX022A_STATE_FIFO) {
>  		dev_warn(data->dev, "Can't set trigger when FIFO enabled\n");
> -		ret = -EBUSY;
> -		goto unlock_out;
> +		return -EBUSY;
>  	}
>  
> -	ret = kx022a_turn_on_off_unlocked(data, false);
> +	ret = __kx022a_turn_on_off(data, false);
>  	if (ret)
> -		goto unlock_out;
> +		return ret;
>  
>  	data->trigger_enabled = state;
>  	ret = kx022a_set_drdy_irq(data, state);
>  	if (ret)
> -		goto unlock_out;
> -
> -	ret = kx022a_turn_on_off_unlocked(data, true);
> -
> -unlock_out:
> -	mutex_unlock(&data->mutex);
> +		return ret;
>  
> -	return ret;
> +	return __kx022a_turn_on_off(data, true);
>  }
>  
>  static const struct iio_trigger_ops kx022a_trigger_ops = {


