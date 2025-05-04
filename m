Return-Path: <linux-iio+bounces-19032-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8207EAA86BB
	for <lists+linux-iio@lfdr.de>; Sun,  4 May 2025 16:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60124188FB9D
	for <lists+linux-iio@lfdr.de>; Sun,  4 May 2025 14:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3ADC1A8401;
	Sun,  4 May 2025 14:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DuAVgRb5"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0C125771;
	Sun,  4 May 2025 14:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746368689; cv=none; b=tCwSzKOq5s9lRpaweo8KeN54sOIGXH27uT1f5LbA3va3OgcdZVjHd4tWGJ0qiawPNffvsKLMYChhAWxirSai5CJMGB4t+T+715K+NmpLqWitcY/qJHIKIHCWEZsqgINa8ZHCCGHrXgeUQyFT/g1vN/Nb5jo3HWMYQLfIfsu/2pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746368689; c=relaxed/simple;
	bh=9oFF4M4fnGD6l1jvQQayepPHQFR2JZudW+JXfOm0bZg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XsAUhnK9son9s1g83OjNA5mWDou7F6UwxUeEjJ4cr9xBio+IYQE2reEaNSVfiYYZ2v1vIuGFyHbYBk8okwXMw+ohjVtb9iJ3CDLFFbXq3NV5+PYpZZy4MLgX8+N4HS9s7/JnsaIt/Bq5e+tEjs+kcMZNrKxeeXNvZmjcWWjNrCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DuAVgRb5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6882BC4CEE7;
	Sun,  4 May 2025 14:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746368688;
	bh=9oFF4M4fnGD6l1jvQQayepPHQFR2JZudW+JXfOm0bZg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DuAVgRb5X4H17qvo6PMBKRfnhYwiOyMQJ6lZY2QBIHhu1yQMgNSSJwkPegyGSUIcm
	 VgiNgBp28kgk47W4HkUz24GoFBICt6WTLqtsgHHvXZPPzzCkxKZSCcDDV5mUCVSzvx
	 XHzZmhOdo2H6Er+m8MFIJLbe0Q+oJz525ThoIXcCzNAeMDeCydAGILAB0pvtZ3xwzI
	 r9ps7vZOMeBAXWyFEXlt2NoArMcfmNi2EP0iJX+KfF8TahS5so/MvWnLENDk0DYEVv
	 cuvBbVwoXXn7wq/eaOJj4kRf8TKtKfRwehlc91jBaFD1vGfB19sIOegMcvizGIHc+v
	 1SDy/951AUe1g==
Date: Sun, 4 May 2025 15:24:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Gyeyoung Baek <gye976@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: trigger: Add validation to reject devices
 requiring top half
Message-ID: <20250504152441.13772899@jic23-huawei>
In-Reply-To: <20250503190044.32511-1-gye976@gmail.com>
References: <20250503190044.32511-1-gye976@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  4 May 2025 04:00:43 +0900
Gyeyoung Baek <gye976@gmail.com> wrote:

> Some device drivers implement top-half handler,
> which is not compatible with threaded handler trigger.
> This patch adds a validation function to reject such devices,
> allowing only iio_pollfunc_store_time().

This needs more reasoning.  What makes it not work?
+ what do we mean by not compatible?
I'd expect at least a reference to it using iio_trigger_poll_nested()
directly.

It's unfortunately hard to tell whether a top half handler is
actually needed or not.  As a follow up question, what cases do we have
of top half / interrupt context handlers other than iio_pollfunc_store_time()?

Maybe we don't need this code to be this complex any more at all
(i.e. could it become a flag to say whether the timestamp is useful or not)
rather than registering the callback.

Jonathan


> 
> Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
> ---
>  drivers/iio/trigger/iio-trig-loop.c | 29 +++++++++++++++++++++--------
>  1 file changed, 21 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/trigger/iio-trig-loop.c b/drivers/iio/trigger/iio-trig-loop.c
> index 7aaed0611899..a37615567a6c 100644
> --- a/drivers/iio/trigger/iio-trig-loop.c
> +++ b/drivers/iio/trigger/iio-trig-loop.c
> @@ -7,18 +7,12 @@
>   *
>   * Note this is still rather experimental and may eat babies.
>   *
> - * Todo
> - * * Protect against connection of devices that 'need' the top half
> - *   handler.
> - * * Work out how to run top half handlers in this context if it is
> - *   safe to do so (timestamp grabbing for example)
> - *
>   * Tested against a max1363. Used about 33% cpu for the thread and 20%
>   * for generic_buffer piping to /dev/null. Watermark set at 64 on a 128
>   * element kfifo buffer.
>   */
>  
> -#include <linux/kernel.h>
> +#include <linux/errno.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
> @@ -27,8 +21,10 @@
>  #include <linux/freezer.h>
>  
>  #include <linux/iio/iio.h>
> -#include <linux/iio/trigger.h>
>  #include <linux/iio/sw_trigger.h>
> +#include <linux/iio/trigger.h>
> +

Improving header ordering / which headers are here is good to do, but
it needs to be in a separate patch.

> +#include "linux/iio/trigger_consumer.h"
>  
>  struct iio_loop_info {
>  	struct iio_sw_trigger swt;
> @@ -71,8 +67,25 @@ static int iio_loop_trigger_set_state(struct iio_trigger *trig, bool state)
>  	return 0;
>  }
>  
> +/*
> + * Protect against connection of devices that 'need' the top half
> + * handler.
> + */
> +static int iio_loop_trigger_validate_device(struct iio_trigger *trig,
> +						struct iio_dev *indio_dev)
> +{
> +	struct iio_poll_func *pf = indio_dev->pollfunc;
> +
> +	/* Only iio timestamp grabbing is allowed. */
> +	if (pf->h && pf->h != iio_pollfunc_store_time)

Why is iio_pollfunc_store_time useable here?  It's not going to store the
time if we don't call it...  We could special case it probably but we'd
need to ensure the call is actually made.


> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
>  static const struct iio_trigger_ops iio_loop_trigger_ops = {
>  	.set_trigger_state = iio_loop_trigger_set_state,
> +	.validate_device = iio_loop_trigger_validate_device,
>  };
>  
>  static struct iio_sw_trigger *iio_trig_loop_probe(const char *name)


