Return-Path: <linux-iio+bounces-8749-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BF595DD38
	for <lists+linux-iio@lfdr.de>; Sat, 24 Aug 2024 11:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADAFB1F2168C
	for <lists+linux-iio@lfdr.de>; Sat, 24 Aug 2024 09:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AEBB1547C0;
	Sat, 24 Aug 2024 09:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HMO0V3zv"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F8025745;
	Sat, 24 Aug 2024 09:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724492815; cv=none; b=YAGDBkPR+47rcEWVknxPLo22FtsRyYehC0Hwkzus5FyXYdcUcw+juPddCdfIhOLaEEvmTXYWGIwzMmB+BjchOeN4qtAQpRWo96wSG8I+MdCMWKRRdm4hoyq7UUTiyrnZwdK4n+lcgF24dU0SJdZ/n5B6btNPheHpZm5LFHgu5jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724492815; c=relaxed/simple;
	bh=uS6UOPtJz12j0Ad9FW9Rj2atWNnzbA+O22puULeYpFA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ysu5p/mqAG3XWF8oonqR73kt0u5Yac0WN/4Yh6Ne5m21VqgtUwper8bkxvkaPGQvgC42m2cjiALIDd5r8tDUDu1AxdgVNbBaCuGx6z/E6bMsXDYHV6ou5wpsJwZxZpbfM/eAbJ6fr7KRe0XtPqcdOGiHg5w+XFowj0aO7O+OnR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HMO0V3zv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75CC2C32781;
	Sat, 24 Aug 2024 09:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724492815;
	bh=uS6UOPtJz12j0Ad9FW9Rj2atWNnzbA+O22puULeYpFA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HMO0V3zvHP1bNVd4vGMUgzwjUyuXa9JxpB+vVyyvTgGvYHjspGHvsNt3ZlhTGctJ9
	 RCNb6t+b/K6PZtr/MaTZF5n4F1YUB9GSPhOfsVCkNq/OHcGzlWR1uzuKBpAZQh33/0
	 YkkHdzgvxX7T+J/5EtzSc1CIgGQRZTfo2Dzdk037az5qMzRGPRj2nTn595/EcUPhxm
	 tQFisCr5WUCN+G+1ZdOtNViBZFouu2pa8ilwZC33EHj7IDXTUHD/w9imBe5PNDRerO
	 k4F+GnT5fdUiRDFgFBovDBEbma7XH+9ipqrM5ZFM41uWChLqwIKTzftIGwyi5KEPEi
	 5/7dtPNOGLsjg==
Date: Sat, 24 Aug 2024 10:46:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@pengutronix.de>,
 linux-iio@vger.kernel.org, chrome-platform@lists.linux.dev,
 linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Benson
 Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH v1 1/1] iio: proximity: cros_ec_mkbp_proximity: Switch
 to including mod_devicetable.h for struct of_device_id definition
Message-ID: <20240824104646.6445cebb@jic23-huawei>
In-Reply-To: <20240823220718.743596-1-andy.shevchenko@gmail.com>
References: <20240823220718.743596-1-andy.shevchenko@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 24 Aug 2024 01:07:18 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> of.h was only included for this definition, so include the correct header
> instead.
> 
> Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Applied.
> ---
>  drivers/iio/proximity/cros_ec_mkbp_proximity.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/proximity/cros_ec_mkbp_proximity.c b/drivers/iio/proximity/cros_ec_mkbp_proximity.c
> index 4df506bb8b38..cff57d851762 100644
> --- a/drivers/iio/proximity/cros_ec_mkbp_proximity.c
> +++ b/drivers/iio/proximity/cros_ec_mkbp_proximity.c
> @@ -6,10 +6,10 @@
>   */
>  
>  #include <linux/kernel.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/notifier.h>
> -#include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  #include <linux/types.h>


