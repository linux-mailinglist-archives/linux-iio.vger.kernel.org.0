Return-Path: <linux-iio+bounces-4981-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A1A8C3651
	for <lists+linux-iio@lfdr.de>; Sun, 12 May 2024 14:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DDC51F21297
	for <lists+linux-iio@lfdr.de>; Sun, 12 May 2024 12:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D67ED208D0;
	Sun, 12 May 2024 12:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qOr9SS8n"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90987200C1;
	Sun, 12 May 2024 12:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715515640; cv=none; b=cObU8pRQ5j10HuqgFyDE0uMZHIVOaKxUrF3nORv765+rT+UODyLEFPaZMdJPGyFd5Conj4zCMf9xb4y8Z1e80d5rhPqZNDak+a2RXUSF6OGZrlicRYONqtGrmYMolYwlfaky2aS47Ko2Zshymg2k3OW5OytueVFfvQkJeWRB0eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715515640; c=relaxed/simple;
	bh=H9fooofH8v7EdNtnyTSlW47/IHPiUXxb224cVnj5tck=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sc8/IBObXljGJGPqUSirqoBgNRC+AIzUcFbB16nixLQbSsLOLNLxSRmnTfZg5UXckChtPcK2+PfhNFdlmDYQvJE4u6tqBiMSUoD5QVRN8HfFDGjE4wcWvvZa0taOkMYRLs1Ctc1xBwMkafF91PKd4G9X4dBBu8rbXC61Dr9FLIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qOr9SS8n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 993CCC116B1;
	Sun, 12 May 2024 12:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715515640;
	bh=H9fooofH8v7EdNtnyTSlW47/IHPiUXxb224cVnj5tck=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qOr9SS8n+16sJFjXJ46njugvpIr03iQvp+pRFgSx92ekyfLMbUAj442IPDcRyq9dN
	 6+Ucvq+QxdVzwaV/n2UH3NSpqKcWsDNb8WnJhi9vdEQfc8hODL/zpFBpJTqu2ApgPQ
	 0WEhXprBqvDj/W1S2dHJ4cPjg0iwoZcagIHxK25NJPdXctO5dL1HVp7Mjf0GJjC/wf
	 j6WwJRkp/p9WM1o7JZzkWKEe4W8f6EUcWP0tQjE0zG1xQjNk137Syw7qF/jJ4dCnRD
	 b5ocVlOeShejr30p+PrD9ZwJTkNiF7lZQnmvzQLYPNSGbAZ24rrT4AEIjKM8Jwemvt
	 7BbIgujxHSAsw==
Date: Sun, 12 May 2024 13:07:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, andriy.shevchenko@linux.intel.com,
 ang.iglesiasg@gmail.com, mazziesaccount@gmail.com, ak@it-klinger.de,
 petre.rodan@subdimension.ro, phil@raspberrypi.com, 579lpy@gmail.com,
 linus.walleij@linaro.org, semen.protsenko@linaro.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/9] iio: pressure: bmp280: Remove dead error checks
Message-ID: <20240512130706.6a86c870@jic23-huawei>
In-Reply-To: <20240508165207.145554-2-vassilisamir@gmail.com>
References: <20240508165207.145554-1-vassilisamir@gmail.com>
	<20240508165207.145554-2-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  8 May 2024 18:51:59 +0200
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> The ret value is being checked already in all the previous
> paths which exit in case of error, so this path can never
> become true.
> 
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
Applied to the togreg branch of iio.git, but only initially pushed out
as testing because I'll be rebasing that branch on 6.10-rc1 in about 2 weeks
time.

Jonathan

> ---
>  drivers/iio/pressure/bmp280-core.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> index ed49e0779d41..311a011604da 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c
> @@ -1350,10 +1350,6 @@ static int bmp580_nvm_operation(struct bmp280_data *data, bool is_write)
>  		poll = 50;
>  		timeout = 400;
>  	}
> -	if (ret) {
> -		dev_err(data->dev, "failed to write command sequence\n");
> -		return -EIO;
> -	}
>  
>  	/* Wait until NVM is ready again */
>  	ret = regmap_read_poll_timeout(data->regmap, BMP580_REG_STATUS, reg,
> 
> base-commit: dccb07f2914cdab2ac3a5b6c98406f765acab803
> prerequisite-patch-id: 97b99b1106cbfd65cef8d256e4dc1a3a9257511e
> prerequisite-patch-id: c60e8ef6fae62417c3430b7598b1a3d2a551be79
> prerequisite-patch-id: 6a49484a6d154ddcd1b45b71a6be2c3542ae0be6
> prerequisite-patch-id: 5aae62fa92c719fb65a8701ec4e1c4284bef7fd9
> prerequisite-patch-id: 6943297d5f70f74bfcf5d5b26198423e428773d9


