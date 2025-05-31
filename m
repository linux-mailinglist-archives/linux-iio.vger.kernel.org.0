Return-Path: <linux-iio+bounces-20093-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D48AC9C3A
	for <lists+linux-iio@lfdr.de>; Sat, 31 May 2025 20:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C1187A5635
	for <lists+linux-iio@lfdr.de>; Sat, 31 May 2025 18:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1BE156C63;
	Sat, 31 May 2025 18:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U7kEA2CN"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E922907;
	Sat, 31 May 2025 18:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748715420; cv=none; b=kcnq555hB8Jndy1yzUbgfwxZOEeLAikOdJ15v3PtlRGGqKRPnL8lgbsR+1SHS7tyOpU7wFfEMlbP2s9kVgSybshxOJ1DgLxgoDd7P/dMmySz/mTNcxIC4uhvaNObajMPSwU3y1oZ6+ogt9bumxALk2NBAco3XWxQx+kz70Lvb2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748715420; c=relaxed/simple;
	bh=FzAtl4E/kjariHEmYDAKBVDCXj0UnW3tqyh8pyA7pfc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NeL1roo6WIMy3nE93Gt1HzBIeyeNPPdSl/7WNJ0Cvl5nRvi80QR58JdgxiCS8du+xNf3ltrebK+L2myv68MzEU651W2ZQMslvkjGPI7Q5+UdK7XLlgJGA6z3LsnJ/IQ+DOByAC37H2ZnHHra2aUUeMM7rxxm/JubO66qb1sDop4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U7kEA2CN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E8FAC4CEE3;
	Sat, 31 May 2025 18:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748715419;
	bh=FzAtl4E/kjariHEmYDAKBVDCXj0UnW3tqyh8pyA7pfc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=U7kEA2CNs8rb7hTj2WFBORGxIvXq9nJgZvtImNnTI4lfjzsZ7bnMhjw15+Z3wM85T
	 lN2wwjvCUMR3f7kwPrPecCsrhj9atWNQSuVHSLjR/+uSIVLHui7D0hIGiaI6WkDQBQ
	 WrL4QkWmEJAM0fwAY1EPEOb8FoeZoFvCeVMvFRv8cUZ3+JauOgXu6ATggOsE8kVTZ4
	 rFK4IBUozp/3zGGWQEuYPzJ5wJm2ypftwCtxOZydO/DTux7vocbFN8/P1a96DAxj74
	 WgvauYglNIL0CbEH/MlmEahUamAXNaNGT1tVToNGfTVN3+xJK97wldf+TVNAB/DxFA
	 Iyg5mzmWTuCvw==
Date: Sat, 31 May 2025 19:16:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Gyeyoung Baek <gye976@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 3/9] iio: consumer: Add new APIs of
 triggered_buffer_setup() family
Message-ID: <20250531191652.488ff1b6@jic23-huawei>
In-Reply-To: <20250519-timestamp-v1-3-fcb4f6c2721c@gmail.com>
References: <20250519-timestamp-v1-0-fcb4f6c2721c@gmail.com>
	<20250519-timestamp-v1-3-fcb4f6c2721c@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 May 2025 23:25:55 +0900
Gyeyoung Baek <gye976@gmail.com> wrote:

> Add new versions of the `iio_triggered_buffer_setup_ext()` APIs.
> (API names are tentative)
> 	iio_triggered_buffer_setup_new
> 	iio_triggered_buffer_setup_ext_new
> 	devm_iio_triggered_buffer_setup_new
> 	devm_iio_triggered_buffer_setup_ext_new
> 	iio_alloc_pollfunc_new
> these APIs take a bool parameter named `timestamp_enabled`.
> 
> Signed-off-by: Gyeyoung Baek <gye976@gmail.com>

See if you can find a way (probably a common shared function) to make it
more obvious that these are very nearly the same as the existing code.

Right now it is harder than I'd like to spot the differences.


> ---
>  drivers/iio/buffer/industrialio-triggered-buffer.c | 82 ++++++++++++++++++++++
>  drivers/iio/industrialio-trigger.c                 | 33 +++++++++
>  include/linux/iio/trigger_consumer.h               |  7 ++
>  include/linux/iio/triggered_buffer.h               | 25 +++++++
>  4 files changed, 147 insertions(+)
> 
> diff --git a/drivers/iio/buffer/industrialio-triggered-buffer.c b/drivers/iio/buffer/industrialio-triggered-buffer.c
> index 9bf75dee7ff8..9b99bf884ccb 100644
> --- a/drivers/iio/buffer/industrialio-triggered-buffer.c
> +++ b/drivers/iio/buffer/industrialio-triggered-buffer.c
> @@ -14,6 +14,68 @@
>  #include <linux/iio/triggered_buffer.h>
>  #include <linux/iio/trigger_consumer.h>
>  
> +int iio_triggered_buffer_setup_ext_new(struct iio_dev *indio_dev,
> +					irqreturn_t (*thread)(int irq, void *p),
> +					bool timestamp_enabled,
> +					enum iio_buffer_direction direction,
> +					const struct iio_buffer_setup_ops *setup_ops,
> +					const struct iio_dev_attr **buffer_attrs)
> +{
> +	struct iio_buffer *buffer;
> +	int ret;
> +
> +	/*
> +	 * iio_triggered_buffer_cleanup() assumes that the buffer allocated here
> +	 * is assigned to indio_dev->buffer but this is only the case if this
> +	 * function is the first caller to iio_device_attach_buffer(). If
> +	 * indio_dev->buffer is already set then we can't proceed otherwise the
> +	 * cleanup function will try to free a buffer that was not allocated here.
> +	 */
> +	if (indio_dev->buffer)
> +		return -EADDRINUSE;
> +
> +	buffer = iio_kfifo_allocate();
> +	if (!buffer) {
> +		ret = -ENOMEM;
> +		goto error_ret;
> +	}
> +
> +	indio_dev->pollfunc = iio_alloc_pollfunc_new(thread,
> +							timestamp_enabled,
> +							IRQF_ONESHOT,
> +							indio_dev,
> +							"%s_consumer%d",
> +							indio_dev->name,
> +							iio_device_id(indio_dev));
> +	if (indio_dev->pollfunc == NULL) {
> +		ret = -ENOMEM;
> +		goto error_kfifo_free;
> +	}
> +
> +	/* Ring buffer functions - here trigger setup related */
> +	indio_dev->setup_ops = setup_ops;
> +
> +	/* Flag that polled ring buffering is possible */
> +	indio_dev->modes |= INDIO_BUFFER_TRIGGERED;
> +
> +	buffer->direction = direction;
> +	buffer->attrs = buffer_attrs;
> +
> +	ret = iio_device_attach_buffer(indio_dev, buffer);
> +	if (ret < 0)
> +		goto error_dealloc_pollfunc;
> +
> +	return 0;
> +
> +error_dealloc_pollfunc:
> +	iio_dealloc_pollfunc(indio_dev->pollfunc);
> +error_kfifo_free:
> +	iio_kfifo_free(buffer);
> +error_ret:
> +	return ret;
> +}
> +EXPORT_SYMBOL(iio_triggered_buffer_setup_ext_new);
> +
>  /**
>   * iio_triggered_buffer_setup_ext() - Setup triggered buffer and pollfunc
>   * @indio_dev:		IIO device structure
> @@ -114,6 +176,26 @@ static void devm_iio_triggered_buffer_clean(void *indio_dev)
>  	iio_triggered_buffer_cleanup(indio_dev);
>  }
>  
> +int devm_iio_triggered_buffer_setup_ext_new(struct device *dev,
> +						struct iio_dev *indio_dev,
> +						irqreturn_t (*thread)(int irq, void *p),
> +						bool timestamp_enabled,
> +						enum iio_buffer_direction direction,
> +						const struct iio_buffer_setup_ops *ops,
> +						const struct iio_dev_attr **buffer_attrs)
> +{
> +	int ret;
> +
> +	ret = iio_triggered_buffer_setup_ext_new(indio_dev, thread, timestamp_enabled, direction,
> +						     ops, buffer_attrs);
> +	if (ret)
> +		return ret;
> +
> +	return devm_add_action_or_reset(dev, devm_iio_triggered_buffer_clean,
> +					indio_dev);
> +}
> +EXPORT_SYMBOL_GPL(devm_iio_triggered_buffer_setup_ext_new);
> +
>  int devm_iio_triggered_buffer_setup_ext(struct device *dev,
>  					struct iio_dev *indio_dev,
>  					irqreturn_t (*h)(int irq, void *p),
> diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
> index 54416a384232..527c3cf84be0 100644
> --- a/drivers/iio/industrialio-trigger.c
> +++ b/drivers/iio/industrialio-trigger.c
> @@ -361,6 +361,39 @@ irqreturn_t iio_pollfunc_store_time(int irq, void *p)
>  }
>  EXPORT_SYMBOL(iio_pollfunc_store_time);
>  
> +struct iio_poll_func
> +*iio_alloc_pollfunc_new(irqreturn_t (*thread)(int irq, void *p),
> +			bool timestamp_enabled,
> +			int type,
> +			struct iio_dev *indio_dev,
> +			const char *fmt,
> +			...)
> +{
> +	va_list vargs;
> +	struct iio_poll_func *pf;
> +
> +	pf = kmalloc(sizeof(*pf), GFP_KERNEL);
> +	if (!pf)
> +		return NULL;
> +	va_start(vargs, fmt);
> +	pf->name = kvasprintf(GFP_KERNEL, fmt, vargs);
> +	va_end(vargs);
> +	if (pf->name == NULL) {
> +		kfree(pf);
> +		return NULL;
> +	}
> +	pf->timestamp_enabled = timestamp_enabled;
> +	pf->h = NULL;
> +	pf->thread = thread;
> +	pf->type = type;
> +	pf->indio_dev = indio_dev;
> +
> +	pf->timestamp = 0;
> +	pf->timestamp_type = 0;
> +	return pf;
> +}
> +EXPORT_SYMBOL_GPL(iio_alloc_pollfunc_new);
> +
>  struct iio_poll_func
>  *iio_alloc_pollfunc(irqreturn_t (*h)(int irq, void *p),
>  		    irqreturn_t (*thread)(int irq, void *p),
> diff --git a/include/linux/iio/trigger_consumer.h b/include/linux/iio/trigger_consumer.h
> index 5e6ff8738386..213cd8560518 100644
> --- a/include/linux/iio/trigger_consumer.h
> +++ b/include/linux/iio/trigger_consumer.h
> @@ -50,6 +50,13 @@ struct iio_poll_func {
>  	bool timestamp_enabled;
>  };
>  
> +__printf(5, 6) struct iio_poll_func
> +*iio_alloc_pollfunc_new(irqreturn_t (*thread)(int irq, void *p),
> +			bool timestamp_enabled,
> +			int type,
> +			struct iio_dev *indio_dev,
> +			const char *fmt,
> +			...);
>  
>  __printf(5, 6) struct iio_poll_func
>  *iio_alloc_pollfunc(irqreturn_t (*h)(int irq, void *p),
> diff --git a/include/linux/iio/triggered_buffer.h b/include/linux/iio/triggered_buffer.h
> index 29e1fe146879..5648c382a506 100644
> --- a/include/linux/iio/triggered_buffer.h
> +++ b/include/linux/iio/triggered_buffer.h
> @@ -9,6 +9,13 @@ struct iio_dev;
>  struct iio_dev_attr;
>  struct iio_buffer_setup_ops;
>  
> +int iio_triggered_buffer_setup_ext_new(struct iio_dev *indio_dev,
> +	irqreturn_t (*thread)(int irq, void *p),
> +	bool timestamp_enabled,
> +	enum iio_buffer_direction direction,
> +	const struct iio_buffer_setup_ops *setup_ops,
> +	const struct iio_dev_attr **buffer_attrs);
> +
>  int iio_triggered_buffer_setup_ext(struct iio_dev *indio_dev,
>  	irqreturn_t (*h)(int irq, void *p),
>  	irqreturn_t (*thread)(int irq, void *p),
> @@ -17,11 +24,24 @@ int iio_triggered_buffer_setup_ext(struct iio_dev *indio_dev,
>  	const struct iio_dev_attr **buffer_attrs);
>  void iio_triggered_buffer_cleanup(struct iio_dev *indio_dev);
>  
> +#define iio_triggered_buffer_setup_new(indio_dev, h, timestamp_enabled, setup_ops)	\
> +	iio_triggered_buffer_setup_ext_new((indio_dev), (h), (timestamp_enabled),	\
> +					IIO_BUFFER_DIRECTION_IN, (setup_ops),		\
> +					NULL)
> +
>  #define iio_triggered_buffer_setup(indio_dev, h, thread, setup_ops)		\
>  	iio_triggered_buffer_setup_ext((indio_dev), (h), (thread),		\
>  					IIO_BUFFER_DIRECTION_IN, (setup_ops),	\
>  					NULL)
>  
> +int devm_iio_triggered_buffer_setup_ext_new(struct device *dev,
> +					struct iio_dev *indio_dev,
> +					irqreturn_t (*thread)(int irq, void *p),
> +					bool timestamp_enabled,
> +					enum iio_buffer_direction direction,
> +					const struct iio_buffer_setup_ops *ops,
> +					const struct iio_dev_attr **buffer_attrs);
> +
>  int devm_iio_triggered_buffer_setup_ext(struct device *dev,
>  					struct iio_dev *indio_dev,
>  					irqreturn_t (*h)(int irq, void *p),
> @@ -30,6 +50,11 @@ int devm_iio_triggered_buffer_setup_ext(struct device *dev,
>  					const struct iio_buffer_setup_ops *ops,
>  					const struct iio_dev_attr **buffer_attrs);
>  
> +#define devm_iio_triggered_buffer_setup_new(dev, indio_dev, thread, timestamp_enabled, setup_ops)	\
> +	devm_iio_triggered_buffer_setup_ext_new((dev), (indio_dev), (thread), (timestamp_enabled),	\
> +					    IIO_BUFFER_DIRECTION_IN,					\
> +					    (setup_ops), NULL)
> +
>  #define devm_iio_triggered_buffer_setup(dev, indio_dev, h, thread, setup_ops)	\
>  	devm_iio_triggered_buffer_setup_ext((dev), (indio_dev), (h), (thread),	\
>  					    IIO_BUFFER_DIRECTION_IN,		\
> 


