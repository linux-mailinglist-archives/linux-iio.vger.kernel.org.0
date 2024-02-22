Return-Path: <linux-iio+bounces-2919-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF55860334
	for <lists+linux-iio@lfdr.de>; Thu, 22 Feb 2024 20:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8778AB32FF5
	for <lists+linux-iio@lfdr.de>; Thu, 22 Feb 2024 19:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99265548E7;
	Thu, 22 Feb 2024 19:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XkBF1Uc5"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8EE14B827
	for <linux-iio@vger.kernel.org>; Thu, 22 Feb 2024 19:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708629783; cv=none; b=jQOgyowsF4arx7EEIGDjDOba+cyZr639e6XI3E7LcI8e+lrhvRtC1ZjhGAZsKaURT65pVrZfxDNLMLC60SqYQHkxn0LmaA3e/cIpvR2UPJdqZC+tcRdmmFx6p0qnv7Kjrn8HLrS6tfpSxmtrqqJ6a5/5HWwbcHb1cuv92LbKKbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708629783; c=relaxed/simple;
	bh=aGX5XdH3PgPUi/VluEDFxcx7y8btnESG3+MY7xTrQGo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IiUhF787bSEwweATYFcGTWFs635bfNpTWR+VlVUNcUq3GW460TpVLgwmJQotmkCxrHa4p03kUbPUlpoTE+/dZTFUu5wMacxAs4khnLBi7B827g4Aq9CC7M+ytM0domYbdlxVYajZAYLrV0ZSuKC+zRQ4U8teNbPacJOKhnm6CAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XkBF1Uc5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEC3CC433F1;
	Thu, 22 Feb 2024 19:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708629783;
	bh=aGX5XdH3PgPUi/VluEDFxcx7y8btnESG3+MY7xTrQGo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XkBF1Uc57WsAR8RJjCBwHev1KEE/8n3CEQ5uS6g5uwhmG+biyu7pCprl0+ef94r3n
	 4cm9F+iU8dnXtQezcWXiqEQD+MYFSyKral9Iyz5BBquxNNOY4QIm6TAIIXwPo0Swvb
	 /xap/HqtGCNYbfBCMSjorG4DhimDYuPOofX9dCWod0nSuEmmldNt2In+uX+/mGjO0d
	 B9q3IQolhbxxiHEfpWzmzrCWYutVGpFQF30ynJLW0TcbbYGgJHUQV65aR7xiFlVkEk
	 nn9xsynffsRoCLkAqcEHa/GUQBHTA6OdiQkyGvjXjVA8Jw68fYTMrfa69hBYdfRVgc
	 BJGWSO9JR90Mg==
Date: Thu, 22 Feb 2024 19:22:45 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Cc: <nuno.sa@analog.com>, linux-iio@vger.kernel.org, Lars-Peter Clausen
 <lars@metafoo.de>
Subject: Re: [PATCH 1/5] iio: core: move to cleanup.h magic
Message-ID: <20240222192245.6470638c@jic23-huawei>
In-Reply-To: <20240221-iio-use-cleanup-magic-v1-1-f9c292666f26@analog.com>
References: <20240221-iio-use-cleanup-magic-v1-0-f9c292666f26@analog.com>
	<20240221-iio-use-cleanup-magic-v1-1-f9c292666f26@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Feb 2024 14:26:52 +0100
Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:

> From: Nuno Sa <nuno.sa@analog.com>
> 
> Use the new cleanup magic for handling mutexes in IIO. This allows us to
> greatly simplify some code paths.
> 
> Note that we keep the plain mutex calls in the
> iio_device_release|acquire() APIs since in there the macros would likely
> not help much (as we want to keep the lock acquired when he leave the
> APIs).
> 
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> ---
>  drivers/iio/industrialio-core.c | 52 +++++++++++++++--------------------------
>  1 file changed, 19 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 9b2877fe8689..7e6497828364 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -11,6 +11,7 @@



> @@ -1806,31 +1803,22 @@ static long iio_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  	struct iio_dev *indio_dev = ib->indio_dev;
>  	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
>  	struct iio_ioctl_handler *h;
> -	int ret = -ENODEV;
> -
> -	mutex_lock(&iio_dev_opaque->info_exist_lock);
>  
> +	guard(mutex)(&iio_dev_opaque->info_exist_lock);
>  	/*
>  	 * The NULL check here is required to prevent crashing when a device
>  	 * is being removed while userspace would still have open file handles
>  	 * to try to access this device.
>  	 */
>  	if (!indio_dev->info)
> -		goto out_unlock;
> +		return -ENODEV;
>  
>  	list_for_each_entry(h, &iio_dev_opaque->ioctl_handlers, entry) {
> -		ret = h->ioctl(indio_dev, filp, cmd, arg);
> -		if (ret != IIO_IOCTL_UNHANDLED)
> -			break;
> +		if (h->ioctl(indio_dev, filp, cmd, arg) != IIO_IOCTL_UNHANDLED)
> +			return 0;

Changes the return value if ret returns something other than IIO_IOCTL_UNHANDLED
which it can I think...

>  	}
>  
> -	if (ret == IIO_IOCTL_UNHANDLED)
> -		ret = -ENODEV;
> -
> -out_unlock:
> -	mutex_unlock(&iio_dev_opaque->info_exist_lock);
> -
> -	return ret;
> +	return -ENODEV;
>  }



