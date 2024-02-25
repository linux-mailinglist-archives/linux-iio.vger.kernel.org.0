Return-Path: <linux-iio+bounces-3051-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A15C0862A58
	for <lists+linux-iio@lfdr.de>; Sun, 25 Feb 2024 13:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C89C028184A
	for <lists+linux-iio@lfdr.de>; Sun, 25 Feb 2024 12:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806D3F9DB;
	Sun, 25 Feb 2024 12:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bQpK6m8V"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEE2DDDA
	for <linux-iio@vger.kernel.org>; Sun, 25 Feb 2024 12:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708865138; cv=none; b=bwg/AQFR2NzdyjLyqOFte4WW/zHdvj8+eU4quAFj2mv3YyzJXpQBh3c9tHICmXuQPLY9NSheInGf9Zu2zbx4L4xldZ1zMq0pgqsNyvCkPYX+D+Ir0mLyygOUbiPElvL1kYceumSgVJ5dLJzu26hhp0bQSy2zqEOlvy8tD6LFKS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708865138; c=relaxed/simple;
	bh=N/SwJfYt4SiLf7WKFQPK7H57U/HGLRhosDmbv64zqR0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VDzDG0wuLLkvtl6Nc42djW+Q6UdIPFCZb1ta1uhCxFaIB2jqGvlVgVzoyRFVFk2jNMI3gGbLF0k7eR5n/rrWvTEfoPxwBIp2WrFaD81c/5Uv9VR+E6CRH1j6oPa6LZwK8+Z2l7brlI0BsePffGznY3Kpnk/eOGqj3w5lWt3yaLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bQpK6m8V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29347C433F1;
	Sun, 25 Feb 2024 12:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708865137;
	bh=N/SwJfYt4SiLf7WKFQPK7H57U/HGLRhosDmbv64zqR0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bQpK6m8VIx7P5aMLUYrg+BMsEsSZFYeOjmQYHChvwWJd0duuXzxxfIVrGQLYoP6+T
	 I0tYgLlCBUQsuBLoebILHn1iVvYdYQUVcRiP9KQYVAGkZ8idHsvjuqZe3073aisVA1
	 Ujn1B8NufuC1YmlVi1TE9vVbHSriJPfKVLtoGZzNjvcgktQqH3sqkOlI7mdru2/Esr
	 atBkPDykKxqVBMvC7UFfduCFG2dSREnVkN/U6Nkgo6a+NMKkzy4veP+Jk0vt6sCF0M
	 AxrpnC+UAOYYhvEcSybyJzHrKBCTE+uptXz9aylPw6YgezR2nc8dHFEAJQQW1AQvam
	 U9421fcqnylyA==
Date: Sun, 25 Feb 2024 12:45:24 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa <nuno.sa@analog.com>
Cc: <linux-iio@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 3/5] iio: trigger: move to the cleanup.h magic
Message-ID: <20240225124524.5f0288e1@jic23-huawei>
In-Reply-To: <20240223-iio-use-cleanup-magic-v2-3-f6b4848c1f34@analog.com>
References: <20240223-iio-use-cleanup-magic-v2-0-f6b4848c1f34@analog.com>
	<20240223-iio-use-cleanup-magic-v2-3-f6b4848c1f34@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 Feb 2024 13:43:46 +0100
Nuno Sa <nuno.sa@analog.com> wrote:

> Use the new cleanup magic for handling mutexes in IIO. This allows us to
> greatly simplify some code paths.
> 
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
Hi Nuno,

Thanks for doing these.

A few minor comments inline.

Trick with these cleanup.h series (that I am still perfecting)
is spotting the places the code can be improved that are exposed by
the simplifications. Often we've gone through an elaborate dance with
error handling etc that is no longer necessary.

> ---
>  drivers/iio/industrialio-trigger.c | 64 ++++++++++++++++----------------------
>  1 file changed, 26 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
> index 18f83158f637..e4f0802fdd1d 100644
> --- a/drivers/iio/industrialio-trigger.c
> +++ b/drivers/iio/industrialio-trigger.c
> @@ -4,6 +4,7 @@
>   * Copyright (c) 2008 Jonathan Cameron
>   */
>  
> +#include <linux/cleanup.h>
>  #include <linux/kernel.h>
>  #include <linux/idr.h>
>  #include <linux/err.h>
> @@ -80,19 +81,18 @@ int iio_trigger_register(struct iio_trigger *trig_info)
>  		goto error_unregister_id;
>  
>  	/* Add to list of available triggers held by the IIO core */
> -	mutex_lock(&iio_trigger_list_lock);
> -	if (__iio_trigger_find_by_name(trig_info->name)) {
> -		pr_err("Duplicate trigger name '%s'\n", trig_info->name);
> -		ret = -EEXIST;
> -		goto error_device_del;
> +	scoped_guard(mutex, &iio_trigger_list_lock) {
> +		if (__iio_trigger_find_by_name(trig_info->name)) {
> +			pr_err("Duplicate trigger name '%s'\n", trig_info->name);
> +			ret =  -EEXIST;

Bonus space after =

> +			goto error_device_del;
> +		}
> +		list_add_tail(&trig_info->list, &iio_trigger_list);
>  	}
> -	list_add_tail(&trig_info->list, &iio_trigger_list);
> -	mutex_unlock(&iio_trigger_list_lock);
>  
>  	return 0;
>  
>  error_device_del:
> -	mutex_unlock(&iio_trigger_list_lock);
>  	device_del(&trig_info->dev);
>  error_unregister_id:
>  	ida_free(&iio_trigger_ida, trig_info->id);


> @@ -145,18 +143,14 @@ static struct iio_trigger *__iio_trigger_find_by_name(const char *name)
>  
>  static struct iio_trigger *iio_trigger_acquire_by_name(const char *name)
>  {
> -	struct iio_trigger *trig = NULL, *iter;
> +	struct iio_trigger *iter;
>  
> -	mutex_lock(&iio_trigger_list_lock);
> +	guard(mutex)(&iio_trigger_list_lock);
>  	list_for_each_entry(iter, &iio_trigger_list, list)
> -		if (sysfs_streq(iter->name, name)) {
> -			trig = iter;
> -			iio_trigger_get(trig);
> -			break;
> -		}
> -	mutex_unlock(&iio_trigger_list_lock);
> +		if (sysfs_streq(iter->name, name))
> +			return iio_trigger_get(iter);

Nice :)
>  
> -	return trig;
> +	return NULL;
>  }
>  
>  static void iio_reenable_work_fn(struct work_struct *work)
> @@ -259,11 +253,10 @@ static int iio_trigger_get_irq(struct iio_trigger *trig)
>  {
>  	int ret;
>  
> -	mutex_lock(&trig->pool_lock);
> -	ret = bitmap_find_free_region(trig->pool,
> -				      CONFIG_IIO_CONSUMERS_PER_TRIGGER,
> -				      ilog2(1));
> -	mutex_unlock(&trig->pool_lock);
> +	scoped_guard(mutex, &trig->pool_lock)
> +		ret = bitmap_find_free_region(trig->pool,
> +					      CONFIG_IIO_CONSUMERS_PER_TRIGGER,
> +					      ilog2(1));

This presents an opportunity make this more idiomatic as a result
	scoped_guard(mutex, &trig->pool_lock) {
		ret = bitmap_find_free_region(trig->pool,
					      CONFIG_IIO_CONSUMERS_PER_TRIGGER,
					      ilog2(1));
		if (ret < 0)
			return ret;
	}

	return trig->subirq_base + ret;

Getting rid of 'non-standard' error handling conditions is one of the nicest
things this cleanup.h stuff enables as we don't dance around to avoid lots
of unlock paths.

Jonathan
>  	if (ret >= 0)
>  		ret += trig->subirq_base;
>  


