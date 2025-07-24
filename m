Return-Path: <linux-iio+bounces-21948-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB06B108AA
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 13:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 625485852E7
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 11:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A897826CE29;
	Thu, 24 Jul 2025 11:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LVoU7lZo"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6367A26B96A;
	Thu, 24 Jul 2025 11:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753355453; cv=none; b=uOJ2TRAih1YQK+Y6pB/VMalztMQxL+ckBRFD/M0Tg4HIwF5svYH0ZwGqS7kdNqf48go3FFFY8qA250nOe6Axssc7Qb3XIVNQcxt+Y/EaHuleSCcDhNaKGLUCpaf+H5MCCNkQPURYzAA8DRhxSDhkXN6b1iGd5/xekKTnY+GiuYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753355453; c=relaxed/simple;
	bh=93w4WklvcfDk1rUnurijeYy1veBmNllXt1DOuAntpCE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DA2542cLY1hZDcnloN2GFepoNZmrVKEEpRXamge8APf6nYubwsZwMCa0Z+LsN6Xzv60jGkZRG6eainxqteEOXLht8+0nVtMz9mYp45e8BfE7OrNq8wDBxJ/BeYN+0SxbDaiKFuaPlCfwlcXK8UcZImOcwh4UXNrzr5hn1VfbSHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LVoU7lZo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6B51C4CEED;
	Thu, 24 Jul 2025 11:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753355452;
	bh=93w4WklvcfDk1rUnurijeYy1veBmNllXt1DOuAntpCE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LVoU7lZo5l5aBdDvV3rvxBaeq7AV6hvt8eeAFwZQhmnX/B2a1SpTv6uBiERZBxuLz
	 ESHibWe8IHizx6WUyk7a7Rfuha8QOKlOp/GmqPYM/6TKvkR9pklX/IVv2hrM/3sVsz
	 Ikfp8oxYotUc6ctnZeKemuJXRaQptzukU3k4+lGtSyeRJFQdRzd2aeccAULm7+JyqS
	 UM2LlEDWr0Sm9Lp5BgiSdAHai68antfmJfTe4Fq1C7kYIiik/R86bx4b5c3MbAtsFS
	 bs4mpZPplZgXbi5x6A+mKhJFL1wtD05YeUmgA3tSiTc3Lli0e4W7LpYHU42Z/JhNim
	 DKnyFU8WusZmw==
Date: Thu, 24 Jul 2025 12:10:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: proximity: sx9500: use stack allocated struct
 for scan data
Message-ID: <20250724121046.65f640db@jic23-huawei>
In-Reply-To: <20250722-iio-use-more-iio_declare_buffer_with_ts-4-v2-1-9e566f3a4c6a@baylibre.com>
References: <20250722-iio-use-more-iio_declare_buffer_with_ts-4-v2-1-9e566f3a4c6a@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Jul 2025 14:35:02 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Use a stack-allocated struct in sx9500_trigger_handler() to hold the
> IIO buffer scan data. Since the scan buffer isn't used outside of this
> function, it doesn't need to be in struct sx9500_data.
> 
> By always allocating enough space for the maximum number of channels,
> we can avoid having to reallocate the buffer each time buffered reads
> are enabled.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Applied. 

If anyone is bored, switching the remainder of the unwinding done manually
in the remove() for devm based cleanup looks straight forward.

Jonathan

> ---
> Changes in v2:
> - Replaced `IIO_DECLARE_BUFFER_WITH_TS()` with struct.
> - I didn't pick up Andy's review tag since I don't consider this a trivial
>   change and deserves a 2nd look.
> - Link to v1: https://lore.kernel.org/r/20250711-iio-use-more-iio_declare_buffer_with_ts-4-v1-1-1a1e521cf747@baylibre.com
> ---
>  drivers/iio/proximity/sx9500.c | 27 ++++++---------------------
>  1 file changed, 6 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/iio/proximity/sx9500.c b/drivers/iio/proximity/sx9500.c
> index 05844f17a15f6980ab7d55536e5fecfc5e4fe8c0..6c67bae7488c4533ea513597f182af504a22c86d 100644
> --- a/drivers/iio/proximity/sx9500.c
> +++ b/drivers/iio/proximity/sx9500.c
> @@ -88,7 +88,6 @@ struct sx9500_data {
>  	bool prox_stat[SX9500_NUM_CHANNELS];
>  	bool event_enabled[SX9500_NUM_CHANNELS];
>  	bool trigger_enabled;
> -	u16 *buffer;
>  	/* Remember enabled channels and sample rate during suspend. */
>  	unsigned int suspend_ctrl0;
>  	struct completion completion;
> @@ -578,22 +577,6 @@ static int sx9500_write_event_config(struct iio_dev *indio_dev,
>  	return ret;
>  }
>  
> -static int sx9500_update_scan_mode(struct iio_dev *indio_dev,
> -				   const unsigned long *scan_mask)
> -{
> -	struct sx9500_data *data = iio_priv(indio_dev);
> -
> -	mutex_lock(&data->mutex);
> -	kfree(data->buffer);
> -	data->buffer = kzalloc(indio_dev->scan_bytes, GFP_KERNEL);
> -	mutex_unlock(&data->mutex);
> -
> -	if (data->buffer == NULL)
> -		return -ENOMEM;
> -
> -	return 0;
> -}
> -
>  static IIO_CONST_ATTR_SAMP_FREQ_AVAIL(
>  	"2.500000 3.333333 5 6.666666 8.333333 11.111111 16.666666 33.333333");
>  
> @@ -612,7 +595,6 @@ static const struct iio_info sx9500_info = {
>  	.write_raw = &sx9500_write_raw,
>  	.read_event_config = &sx9500_read_event_config,
>  	.write_event_config = &sx9500_write_event_config,
> -	.update_scan_mode = &sx9500_update_scan_mode,
>  };
>  
>  static int sx9500_set_trigger_state(struct iio_trigger *trig,
> @@ -649,6 +631,10 @@ static irqreturn_t sx9500_trigger_handler(int irq, void *private)
>  	struct iio_dev *indio_dev = pf->indio_dev;
>  	struct sx9500_data *data = iio_priv(indio_dev);
>  	int val, bit, ret, i = 0;
> +	struct {
> +		u16 chan[SX9500_NUM_CHANNELS];
> +		aligned_s64 timestamp;
> +	} scan = { };
>  
>  	mutex_lock(&data->mutex);
>  
> @@ -658,10 +644,10 @@ static irqreturn_t sx9500_trigger_handler(int irq, void *private)
>  		if (ret < 0)
>  			goto out;
>  
> -		data->buffer[i++] = val;
> +		scan.chan[i++] = val;
>  	}
>  
> -	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
> +	iio_push_to_buffers_with_timestamp(indio_dev, &scan,
>  					   iio_get_time_ns(indio_dev));
>  
>  out:
> @@ -984,7 +970,6 @@ static void sx9500_remove(struct i2c_client *client)
>  	iio_triggered_buffer_cleanup(indio_dev);
>  	if (client->irq > 0)
>  		iio_trigger_unregister(data->trig);
> -	kfree(data->buffer);
>  }
>  
>  static int sx9500_suspend(struct device *dev)
> 
> ---
> base-commit: cd2731444ee4e35db76f4fb587f12d327eec5446
> change-id: 20250711-iio-use-more-iio_declare_buffer_with_ts-4-66ddcde563fe
> 
> Best regards,


