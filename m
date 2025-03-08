Return-Path: <linux-iio+bounces-16560-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7CDCA57B34
	for <lists+linux-iio@lfdr.de>; Sat,  8 Mar 2025 15:47:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59FB83AD7A0
	for <lists+linux-iio@lfdr.de>; Sat,  8 Mar 2025 14:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92DC21DEFF7;
	Sat,  8 Mar 2025 14:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JD5hCXxb"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6241FC8;
	Sat,  8 Mar 2025 14:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741445243; cv=none; b=l3PH73AFQjsrxt7sVfYoUFkheHA2ejFAkVF2Zrht2/53naMlKzECN75UMbVe6aThz6ctjnKNxSK7sCb63qrChjX73uZZD7ri2MQV74H/ZXbPJ/ZvtEDt4UphEWLg1zMnSF9XmnVRtok/Zf9wV9cQntgbl+E0ob8yDcMRd3lua08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741445243; c=relaxed/simple;
	bh=os97FRvbvVvqKERqW/jIpJB9PQbmjx0HIcQp6SM/oq0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mY39eybPCHhfIKb5OmlkbguO0Y7pmOuWi43NnrbnYaj5FVyKvfNVvlvnhDvMgahaSj23HM8zBtDm00V1kdHpNyhYUV7mROa+PbEopcJdoIJdxS/Mz7NWRpaGU5eNSD1A87+RHn6b8fKg87bZZFiZGyV5cFC0T0MLL7Z6Ohj0Rr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JD5hCXxb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F18E6C4CEE0;
	Sat,  8 Mar 2025 14:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741445242;
	bh=os97FRvbvVvqKERqW/jIpJB9PQbmjx0HIcQp6SM/oq0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JD5hCXxbWO7E5Ov1ucfl1+LKi5Hwxt+t+x7yVHRxX2TT8UByV6bGc4Br1EFkOZOJp
	 nJNrxewpUnOtTkSm6RVG/wWrWr0qJIcA7qclCOIaA87ZE3svuo1qUWXuibBrtPyL6z
	 6iPgF2y3wzKPtFeiyqH3nScXa7wb/c1UA8KUtSAFMvVIvPz7Pn5yav3PO6KCFdQDH/
	 vYYe9Hm+YGe/mTfVoY2OpsE7DxWgZih2iQ3AeJhCFS72cSgktUJxxYQ13PCzVADId3
	 GeD/yxNbnDRBvZTyRAZwS5oFLxusWaYrt2mt0Blh9y1T36K33mGPFIjBNT+XxFzoIv
	 3Eh0VyviIWk1g==
Date: Sat, 8 Mar 2025 14:47:17 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Saalim Quadri <danascape@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v2] staging: iio: ad9834: Use
 devm_regulator_get_enable()
Message-ID: <20250308144717.6a14022f@jic23-huawei>
In-Reply-To: <20250306000459.1554007-1-danascape@gmail.com>
References: <20250306000459.1554007-1-danascape@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  6 Mar 2025 05:34:59 +0530
Saalim Quadri <danascape@gmail.com> wrote:

> The regulators are only enabled at probe(),
> hence replace the boilerplate code by making use of
> devm_regulator_get_enable() helper.
> 
> Signed-off-by: Saalim Quadri <danascape@gmail.com>
rewrapped description and applied.

Thanks,

Jonathan

> ---
> V1 -> V2: Update commit description and return the correct error content
> 
>  drivers/staging/iio/frequency/ad9834.c | 22 ++--------------------
>  1 file changed, 2 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
> index 6e99e008c5f4..50413da2aa65 100644
> --- a/drivers/staging/iio/frequency/ad9834.c
> +++ b/drivers/staging/iio/frequency/ad9834.c
> @@ -387,33 +387,15 @@ static const struct iio_info ad9833_info = {
>  	.attrs = &ad9833_attribute_group,
>  };
>  
> -static void ad9834_disable_reg(void *data)
> -{
> -	struct regulator *reg = data;
> -
> -	regulator_disable(reg);
> -}
> -
>  static int ad9834_probe(struct spi_device *spi)
>  {
>  	struct ad9834_state *st;
>  	struct iio_dev *indio_dev;
> -	struct regulator *reg;
>  	int ret;
>  
> -	reg = devm_regulator_get(&spi->dev, "avdd");
> -	if (IS_ERR(reg))
> -		return PTR_ERR(reg);
> -
> -	ret = regulator_enable(reg);
> -	if (ret) {
> -		dev_err(&spi->dev, "Failed to enable specified AVDD supply\n");
> -		return ret;
> -	}
> -
> -	ret = devm_add_action_or_reset(&spi->dev, ad9834_disable_reg, reg);
> +	ret = devm_regulator_get_enable(&spi->dev, "avdd");
>  	if (ret)
> -		return ret;
> +		return dev_err_probe(&spi->dev, ret, "Failed to enable specified AVDD supply\n");
>  
>  	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
>  	if (!indio_dev) {


