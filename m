Return-Path: <linux-iio+bounces-21605-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C00DB0314C
	for <lists+linux-iio@lfdr.de>; Sun, 13 Jul 2025 15:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F81A189DF81
	for <lists+linux-iio@lfdr.de>; Sun, 13 Jul 2025 14:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D9D277C8A;
	Sun, 13 Jul 2025 13:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VgMMWCsF"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9163D17C91;
	Sun, 13 Jul 2025 13:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752415178; cv=none; b=cPBZswJD6asHA699h/eCiaDeNq1gH1O41Y80msxjSVavQmDHSTgidLIQ4neNHhRkWwQSMiSH3lRMLIklujTQqnVVqJqiH+AHCRQW7X7O83Y7BY88XfvGXfWqRumqpzRUEiFzl2O52G3O73VXdffsi4rsu5AMBMi+bN54k3IhQDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752415178; c=relaxed/simple;
	bh=f5r8Liehv9bHzgoiMDtO+bZSOaoNFH9KrEiBywoRAGs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fMjuBcqGN6l/22uLtm4z6VTKZWJSEsR+ZW3bT6Pmh6NzK4BHnRFi7XEHNkWVCLrNr6nYV1+E/RcViCTr9KaABQb2mpoB4cFotiPewaXpVxh6rV8QjDp5LXfsqjIzwU9pi1kMQN8102JXkGLm0iNouUw8sLpjkakRK4J0n969Oss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VgMMWCsF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0E9EC4CEE3;
	Sun, 13 Jul 2025 13:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752415177;
	bh=f5r8Liehv9bHzgoiMDtO+bZSOaoNFH9KrEiBywoRAGs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VgMMWCsFe3pKfTgQp5/TnFcRxBR58AbtyVQFa48UNGiJ+PBClqsMmVJ8Y/VMoxS90
	 ncRJ0S+Y7kWCnxtUV/0qiUovbNFEcNNb8TOAKhBB0Eb+V0PiJ9UaQBbb7zg+p2vLwU
	 PrRgCJP5Ba3qRRibAvrS0aLvXpwdbImrn17DDtzfGdHmDZGaFn3pqGw59VYxwxIt4x
	 M93UrA9lF+G26BTvYcYvi2spffmMbQtej+kDS2xT4XAQWg+MpnmqM8g/hKKPGCwSFz
	 7legxwYCpj4yjnMj3KJPEn7aL9eZQJJsI6nnZryc3q4yqVEMuQzjBTTPb1rBPI5jed
	 2NVdIRjodQDfw==
Date: Sun, 13 Jul 2025 14:59:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: proximity: sx_common: use stack allocated buffer
 for scan data
Message-ID: <20250713145931.16d98029@jic23-huawei>
In-Reply-To: <20250711-iio-use-more-iio_declare_buffer_with_ts-5-v1-1-4209f54e010f@baylibre.com>
References: <20250711-iio-use-more-iio_declare_buffer_with_ts-5-v1-1-4209f54e010f@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Jul 2025 10:55:07 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Use IIO_DECLARE_BUFFER_WITH_TS() to declare a stack allocated buffer
> in sx_common_trigger_handler(). Since the scan buffer isn't used outside
> of this function and doesn't need to be DMA-safe, it doesn't need to be
> in struct sx_common_data.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Same question - why not the structure which is more descriptive than
the buffer macro?  To me that's cleaner when we can do it with the magic
of the buffer macro being great when we can't because we have more than
8 bytes of potential channels before the timestamp.

> ---
>  drivers/iio/proximity/sx_common.c | 7 ++++---
>  drivers/iio/proximity/sx_common.h | 6 ------
>  2 files changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/proximity/sx_common.c b/drivers/iio/proximity/sx_common.c
> index 59b35e40739b0d931dbac076ca5c83ba421ba766..fae035e8d2f5a40ed7379dd6e306f84878a9bef0 100644
> --- a/drivers/iio/proximity/sx_common.c
> +++ b/drivers/iio/proximity/sx_common.c
> @@ -361,6 +361,7 @@ static irqreturn_t sx_common_irq_thread_handler(int irq, void *private)
>  
>  static irqreturn_t sx_common_trigger_handler(int irq, void *private)
>  {
> +	IIO_DECLARE_BUFFER_WITH_TS(__be16, buffer, SX_COMMON_MAX_NUM_CHANNELS);
>  	struct iio_poll_func *pf = private;
>  	struct iio_dev *indio_dev = pf->indio_dev;
>  	struct sx_common_data *data = iio_priv(indio_dev);
> @@ -376,11 +377,11 @@ static irqreturn_t sx_common_trigger_handler(int irq, void *private)
>  		if (ret)
>  			goto out;
>  
> -		data->buffer.channels[i++] = val;
> +		buffer[i++] = val;
>  	}
>  
> -	iio_push_to_buffers_with_ts(indio_dev, &data->buffer,
> -				    sizeof(data->buffer), pf->timestamp);
> +	iio_push_to_buffers_with_ts(indio_dev, buffer, sizeof(buffer),
> +				    pf->timestamp);
>  
>  out:
>  	mutex_unlock(&data->mutex);
> diff --git a/drivers/iio/proximity/sx_common.h b/drivers/iio/proximity/sx_common.h
> index 259b5c695233b4e295ad8ae2b05fceeaa4a7ae61..97b264aa50b0c9811ce6b42be34eace03eae2627 100644
> --- a/drivers/iio/proximity/sx_common.h
> +++ b/drivers/iio/proximity/sx_common.h
> @@ -122,12 +122,6 @@ struct sx_common_data {
>  	unsigned long chan_prox_stat;
>  	bool trigger_enabled;
>  
> -	/* Ensure correct alignment of timestamp when present. */
> -	struct {
> -		__be16 channels[SX_COMMON_MAX_NUM_CHANNELS];
> -		aligned_s64 ts;
> -	} buffer;
> -
>  	unsigned int suspend_ctrl;
>  	unsigned long chan_read;
>  	unsigned long chan_event;
> 
> ---
> base-commit: f8f559752d573a051a984adda8d2d1464f92f954
> change-id: 20250711-iio-use-more-iio_declare_buffer_with_ts-5-f4c91d73037d
> 
> Best regards,


