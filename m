Return-Path: <linux-iio+bounces-21031-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17EBFAEC7FC
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 16:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF1327A63CF
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 14:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558DC248F70;
	Sat, 28 Jun 2025 14:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VTFZO5Zo"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065981FECB1;
	Sat, 28 Jun 2025 14:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751122529; cv=none; b=h07tzBl12aPKXSi0cRz0i5hd0PUYpJIsgN5UbFqYdCaFwN4vYWjiRL0buw+JAFdEYBrkMIZc5a5TqXpsLAAo4Mj6vombJhUJnhidxOvsIFTqaIHjvzKAaDj3fz14t1Ikd6Or3/IETZIIbD4+j4Wb3qx0vFAlLgvknF0sV+i+avw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751122529; c=relaxed/simple;
	bh=Kfhu+oPsade3bpUuF2PAiWvJJ89BZQNz4OgJrDixL7A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WWOlltc364Wo57Ns+7ifUdnRzboDxApDJRI85AMMjr1DHB0TXHiCiN0EeD1oP0ypC0+Uh/57JXgPFJSsjVFno3HCULOUhqyrsiPlfE//tnKpCNTYV2u1dsbvGcBMh2fFdce3RkmnRbks7eYTcm7y6nidJ04EHSXHlwwmCo98Cvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VTFZO5Zo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36749C4CEEA;
	Sat, 28 Jun 2025 14:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751122528;
	bh=Kfhu+oPsade3bpUuF2PAiWvJJ89BZQNz4OgJrDixL7A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VTFZO5ZoagUXKhxfPuxOX7lVGUnivXvVy5V73bTiVfEZAOtnafrOJPIr4/IPTYJAQ
	 6s59npzlj9fQkZJdm0fDH8DlwrFSjf7f2u09q17yvnTX2IbW0FRu1Dj8Zwn1/fgwFy
	 kAqTpZPrGZ5tiPafw8/NPa9/4S9+T3b2sKOiSNvQAq3xWFxwRlKJIBKonNV47z5nGY
	 tIEzr7M2tbEssoXpKPaWpTarDngyrb4q2+/SGjdrnsEaUn9h99YN1Dgc3h3+eWOXTB
	 l+xtjihtC50igud4tOA5M0i+1MyPsf0s5zM80Zxnsify5WfvrSEDy5rVstGkKWZCiU
	 X90S8u59QASWw==
Date: Sat, 28 Jun 2025 15:55:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v2 01/11] iio: adc: ad_sigma_delta: don't overallocate
 scan buffer
Message-ID: <20250628155521.056b3394@jic23-huawei>
In-Reply-To: <20250627-iio-adc-ad7173-add-spi-offload-support-v2-1-f49c55599113@baylibre.com>
References: <20250627-iio-adc-ad7173-add-spi-offload-support-v2-0-f49c55599113@baylibre.com>
	<20250627-iio-adc-ad7173-add-spi-offload-support-v2-1-f49c55599113@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Jun 2025 18:39:57 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Fix overallocating the size of the scan buffer by converting bits to
> bytes. The size is meant to be in bytes, so scanbits needs to be
> divided by 8.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  drivers/iio/adc/ad_sigma_delta.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
> index 4c5f8d29a559fea7226b84141bcb148fb801f62c..6b3ef7ef403e00804abeb81025ed293b188e492b 100644
> --- a/drivers/iio/adc/ad_sigma_delta.c
> +++ b/drivers/iio/adc/ad_sigma_delta.c
> @@ -489,7 +489,7 @@ static int ad_sd_buffer_postenable(struct iio_dev *indio_dev)
>  			return ret;
>  	}
>  
> -	samples_buf_size = ALIGN(slot * indio_dev->channels[0].scan_type.storagebits, 8);
> +	samples_buf_size = ALIGN(slot * indio_dev->channels[0].scan_type.storagebits / 8, 8);

Seems like a good place for BITS_TO_BYTES() from bitops.h.  Given we have another 8
kicking around in the same code line it might be a tiny bit confusing as / 8

If everything else is good I'll tweak this whilst applying (and add the include if needed).

>  	samples_buf_size += sizeof(int64_t);
>  	samples_buf = devm_krealloc(&sigma_delta->spi->dev, sigma_delta->samples_buf,
>  				    samples_buf_size, GFP_KERNEL);
> 


