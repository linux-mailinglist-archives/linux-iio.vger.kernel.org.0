Return-Path: <linux-iio+bounces-22833-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F886B28EA0
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 16:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90B4C1C21A5F
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 14:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5CA2E9728;
	Sat, 16 Aug 2025 14:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EeaA/dHV"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D08921CC49
	for <linux-iio@vger.kernel.org>; Sat, 16 Aug 2025 14:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755355938; cv=none; b=I1pxV41tbyV2rR8612TJQay8wjqrRdKtBVddrvHeFjjZGG4EMWD43CVFr4aaLeXJLS/c5uTj3xDREn4mEj5MoUnmO7/kI29EjZ5A8w9anSemdT7YWBKDJl2G5o9Dfh/IlzQFjpaju3UMVnbAUXo9UrvLH7jypziPtCgxKY9RyOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755355938; c=relaxed/simple;
	bh=YF38eKMjvktAWDcdiMVdig2AOTr2ncptz8/Ms4qM41g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q0uFyhU4uP8OsxpBPoX1zOy089ufGeN9alTqFo+LsrF+shYBmNSW7fXeYWCRPpG49Xjw339pt2BLjs2eS5HfeZk3Zk/Wygf/isqzWEv/RjPbZNa7JbX5mVpnyIIW/8t9QeY9WArOloVf2CpFWW4PTv7t8jMjNpbUEFq7BGYM1+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EeaA/dHV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0C0CC4CEEF;
	Sat, 16 Aug 2025 14:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755355937;
	bh=YF38eKMjvktAWDcdiMVdig2AOTr2ncptz8/Ms4qM41g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EeaA/dHVmSKafyD3/wc1SBx4l6dFZSJylfw4hgZNk70os6cD4B8mSi+wukMf34Ufs
	 nYiSqUSMZIJXLBdWREI2al71CnfPLJnWsoIYCkbDysHe+qe5hofcQOyYO/6EQbKkb/
	 J1ImSXWhZeLqSOeuyROLMKj5XrGmtkbsNw6D+5QEh447hSPOHT965VzSRuXRTJ6pld
	 HggtSPU6IrTAVTYw9vuEv68NkzpvipUK8WoL7aHWm3HcT07jdaEvJQJ7I9wFBlobL9
	 9sNqlyCjACGmwoD87x8Cp+32lbiDjKn5Acqg9G0lX+jtFNFDykYeJu2kgwCs7qYVi1
	 JjBxTF+wEWyKg==
Date: Sat, 16 Aug 2025 15:52:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Cc: Mudit Sharma <muditsharma.info@gmail.com>, Jiri Kosina
 <jikos@kernel.org>, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>, Javier Carrasco
 <javier.carrasco.cruz@gmail.com>, Matti Vaittinen
 <mazziesaccount@gmail.com>, Abhash Jha <abhashkumarjha123@gmail.com>,
 Astrid Rost <astrid.rost@axis.com>, =?UTF-8?B?TcOlcnRlbg==?= Lindahl
 <marten.lindahl@axis.com>, Gwendal Grignou <gwendal@chromium.org>,
 Christian Eggers <ChristianEggersceggers@arri.de>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 07/16] iio: light: acpi-als: Use
 iio_push_to_buffers_with_ts() to allow runtime source size check
Message-ID: <20250816155206.6d412214@jic23-huawei>
In-Reply-To: <20250802164436.515988-8-jic23@kernel.org>
References: <20250802164436.515988-1-jic23@kernel.org>
	<20250802164436.515988-8-jic23@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  2 Aug 2025 17:44:27 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> This function allows for runtime detection of undersized storage which
> can be non obvious due to the injection of a timestamp within the helper.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Gwendal Grignou <gwendal@chromium.org>
Applied
> ---
>  drivers/iio/light/acpi-als.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/acpi-als.c b/drivers/iio/light/acpi-als.c
> index 511ed37e783e..d5d1a8b9c035 100644
> --- a/drivers/iio/light/acpi-als.c
> +++ b/drivers/iio/light/acpi-als.c
> @@ -167,7 +167,7 @@ static irqreturn_t acpi_als_trigger_handler(int irq, void *p)
>  	if (!pf->timestamp)
>  		pf->timestamp = iio_get_time_ns(indio_dev);
>  
> -	iio_push_to_buffers_with_timestamp(indio_dev, &scan, pf->timestamp);
> +	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan), pf->timestamp);
>  out:
>  	mutex_unlock(&als->lock);
>  	iio_trigger_notify_done(indio_dev->trig);


