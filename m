Return-Path: <linux-iio+bounces-5110-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E7F8C94FD
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2024 16:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 686A42818E6
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2024 14:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509654AEF6;
	Sun, 19 May 2024 14:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bBnaWIzv"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D0D4C60B;
	Sun, 19 May 2024 14:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716128707; cv=none; b=HXS8bjjUlfzJWQXIuVjTO5Sy4Ez3OBfTXNMUve+r9FgIZiSbz74lRagESCfCyP8EjjJYEbbbZrAZCDovg5H3/m8vHH3ATvNIHiJmjNAL08qSh2S+fsvk5fPM/2MdplEmBleCPKMfZ7R9OgT9n3wb0iBLYP7U5ClDqgtaOU+XGew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716128707; c=relaxed/simple;
	bh=pCcNl44FrZEJTOobvt2e7CkCg2Eq+SUXEeb2lVVtgZU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fC5u2mtUn9Vpat87Hinn5TInBM0YapDJba83G1OGOqwYm1r/8X8sLX7J47bxADIK+ZsaUza0A/HEsxa1WUleflxm1IKVJ1Y4sDd0K8vCa6TcD43wpT4xB+UVVfXNjhQnt3A5UHAQwVTjwXtlQt9oiWAUkIwdnuBgIBSz9+CILX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bBnaWIzv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 275C5C32781;
	Sun, 19 May 2024 14:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716128706;
	bh=pCcNl44FrZEJTOobvt2e7CkCg2Eq+SUXEeb2lVVtgZU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bBnaWIzvlIM+BbOhX1rbGJUfm+kbQLJ+ndqY+twEgI3lOQtc0J+7uXxSGrtmmDH+f
	 nn4AMlV9jtOdcCL1xeKOjILspygTI/nnjhU+iw9UXYDH+B4QZYkUXHhLWbKSGgeG22
	 /+sG+SvrTC/viFqTPUzlY4eP0BBktxxlIgULAlpDOOeRjmrS79llT4ozK1mip8yBfX
	 yAOI8kQX1yw0itWaugy+wUuk0AU+vp2472Xt9yd1ENm91jCJXynFE/2BnlLHU5nECf
	 69Nz0MCZaLaH+kWxMziSqU6zM54wTx2nhhsBhltPeCmMozsdbCdHYlMKbgvVeN7F1P
	 aIt8oJdT9yPfg==
Date: Sun, 19 May 2024 15:24:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, andriy.shevchenko@linux.intel.com,
 ang.iglesiasg@gmail.com, mazziesaccount@gmail.com, ak@it-klinger.de,
 petre.rodan@subdimension.ro, phil@raspberrypi.com, 579lpy@gmail.com,
 linus.walleij@linaro.org, semen.protsenko@linaro.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v7 2/5] iio: pressure: bmp280: Introduce new cleanup
 routines
Message-ID: <20240519152451.4e2782f5@jic23-huawei>
In-Reply-To: <20240512230524.53990-3-vassilisamir@gmail.com>
References: <20240512230524.53990-1-vassilisamir@gmail.com>
	<20240512230524.53990-3-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 May 2024 01:05:21 +0200
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> Introduce new linux/cleanup.h with the guard(mutex) functionality.
> 
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>

I put back the line accidentally deleted in this one whilst applying.

Jonathan


> +static int bmp580_nvmem_write(void *priv, unsigned int offset, void *val,
> +			      size_t bytes)
> +{
> +	struct bmp280_data *data = priv;
> +	int ret;
> +
> +	pm_runtime_get_sync(data->dev);
> +	ret = bmp580_nvmem_write_impl(priv, offset, val, bytes);
>  	pm_runtime_mark_last_busy(data->dev);
>  	pm_runtime_put_autosuspend(data->dev);
> +
>  	return ret;
>  }
> -

grump.

>  static int bmp580_preinit(struct bmp280_data *data)
>  {
>  	struct nvmem_config config = {


