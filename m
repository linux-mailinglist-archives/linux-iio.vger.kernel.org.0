Return-Path: <linux-iio+bounces-13662-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 662629F802C
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 17:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4F8518888B3
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 16:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140C7227586;
	Thu, 19 Dec 2024 16:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k82xrasY"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9908226551;
	Thu, 19 Dec 2024 16:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734626683; cv=none; b=IrKCgySz+xOYaAhEr8766HjBrD5Z9TGATGyiAH5s9kquAtW30sB6h8J/XoMf4flB7fWWIFBoxXz0mDPsYg7JMBLt6Sk0KXiBlPkl0Q7SvZG1yPtxavOJvmglKvrVf0u3qSXZclmnlPX42ekIMDQThpBbMsDVmMFKViuD9KC26qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734626683; c=relaxed/simple;
	bh=W7DmPfTWunQKyt+FmcKAdyVnCKmG2sadKaoayNBTnUw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NsJh9IYhWFhGZ0NpJ4LnQwR0nmLb/uuWH4xMOm7j0zMUY2YZpUyfVMvxU09y+nlx6gBXt/J68L3skmtJjbYDGeuCFI35mqcnkE0JqcxCEbGyi/5Ev5OF6NKU2U+T3mL/6NpaWCuLweMOlUNxf0a5BRJcu/nvsby9gC254nfwH0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k82xrasY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D27ACC4CECE;
	Thu, 19 Dec 2024 16:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734626683;
	bh=W7DmPfTWunQKyt+FmcKAdyVnCKmG2sadKaoayNBTnUw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=k82xrasYaDdsX03utNUy5WZl2aVvBogZIoBI++Z2aMkcfHUKvRzJIfb/cD5jigOcw
	 P+lowRo0acGDQVQsRM3plvhNsNjqszgz/aoSuuKBcwXkrEbcbUHCJojraHySaPUThP
	 Ufsg0SF9bwqGrnq8AZzH1ds2aqrp4b+9LyTaXPz62BH8u48NdRHV+S6H+9TMlNwbUn
	 WAI+TUUApdL7zBLuORQvvfAvAXpxsykfU6nO1wTTna17fNaSjV2SDzdCUQOi83RNhR
	 5gQx6Ri7sTCC/ZSJMheOBx4Hqq1L5HX2nJFdfd8n28wK9y/35geaur5FuThfjt66BT
	 +Ualzi1lmDuaw==
Date: Thu, 19 Dec 2024 16:44:34 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Mihail Chindris
 <mihail.chindris@analog.com>, Nuno Sa <nuno.sa@analog.com>, David Lechner
 <dlechner@baylibre.com>, Olivier Moysan <olivier.moysan@foss.st.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] iio: dac: ad3552r-common: fix ad3541/2r ranges
Message-ID: <20241219164434.19d1e537@jic23-huawei>
In-Reply-To: <20241216-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v1-1-856ff71fc930@baylibre.com>
References: <20241216-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v1-0-856ff71fc930@baylibre.com>
	<20241216-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v1-1-856ff71fc930@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Dec 2024 21:36:21 +0100
Angelo Dureghello <adureghello@baylibre.com> wrote:

> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Fix ad3541/2r voltage ranges to be as per ad3542r datasheet,
> rev. C, table 38 (page 57).
> 
> Fixes: 8f2b54824b28 ("drivers:iio:dac: Add AD3552R driver support")
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>

Could you provide a brief statement of the impact of these being wrong.
What does it look like to userspace / configuration of what we are
measuring?

Thanks,

Jonathan

> ---
>  drivers/iio/dac/ad3552r-common.c | 5 ++---
>  drivers/iio/dac/ad3552r.h        | 8 +++-----
>  2 files changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad3552r-common.c b/drivers/iio/dac/ad3552r-common.c
> index 0f495df2e5ce..03e0864f5084 100644
> --- a/drivers/iio/dac/ad3552r-common.c
> +++ b/drivers/iio/dac/ad3552r-common.c
> @@ -22,11 +22,10 @@ EXPORT_SYMBOL_NS_GPL(ad3552r_ch_ranges, "IIO_AD3552R");
>  
>  const s32 ad3542r_ch_ranges[AD3542R_MAX_RANGES][2] = {
>  	[AD3542R_CH_OUTPUT_RANGE_0__2P5V]	= { 0, 2500 },
> -	[AD3542R_CH_OUTPUT_RANGE_0__3V]		= { 0, 3000 },
>  	[AD3542R_CH_OUTPUT_RANGE_0__5V]		= { 0, 5000 },
>  	[AD3542R_CH_OUTPUT_RANGE_0__10V]	= { 0, 10000 },
> -	[AD3542R_CH_OUTPUT_RANGE_NEG_2P5__7P5V]	= { -2500, 7500 },
> -	[AD3542R_CH_OUTPUT_RANGE_NEG_5__5V]	= { -5000, 5000 }
> +	[AD3542R_CH_OUTPUT_RANGE_NEG_5__5V]	= { -5000, 5000 },
> +	[AD3542R_CH_OUTPUT_RANGE_NEG_2P5__7P5V]	= { -2500, 7500 }
>  };
>  EXPORT_SYMBOL_NS_GPL(ad3542r_ch_ranges, "IIO_AD3552R");
>  
> diff --git a/drivers/iio/dac/ad3552r.h b/drivers/iio/dac/ad3552r.h
> index fd5a3dfd1d1c..4b5581039ae9 100644
> --- a/drivers/iio/dac/ad3552r.h
> +++ b/drivers/iio/dac/ad3552r.h
> @@ -131,7 +131,7 @@
>  #define AD3552R_CH1_ACTIVE				BIT(1)
>  
>  #define AD3552R_MAX_RANGES	5
> -#define AD3542R_MAX_RANGES	6
> +#define AD3542R_MAX_RANGES	5
>  #define AD3552R_QUAD_SPI	2
>  
>  extern const s32 ad3552r_ch_ranges[AD3552R_MAX_RANGES][2];
> @@ -189,16 +189,14 @@ enum ad3552r_ch_vref_select {
>  enum ad3542r_ch_output_range {
>  	/* Range from 0 V to 2.5 V. Requires Rfb1x connection */
>  	AD3542R_CH_OUTPUT_RANGE_0__2P5V,
> -	/* Range from 0 V to 3 V. Requires Rfb1x connection  */
> -	AD3542R_CH_OUTPUT_RANGE_0__3V,
>  	/* Range from 0 V to 5 V. Requires Rfb1x connection  */
>  	AD3542R_CH_OUTPUT_RANGE_0__5V,
>  	/* Range from 0 V to 10 V. Requires Rfb2x connection  */
>  	AD3542R_CH_OUTPUT_RANGE_0__10V,
> -	/* Range from -2.5 V to 7.5 V. Requires Rfb2x connection  */
> -	AD3542R_CH_OUTPUT_RANGE_NEG_2P5__7P5V,
>  	/* Range from -5 V to 5 V. Requires Rfb2x connection  */
>  	AD3542R_CH_OUTPUT_RANGE_NEG_5__5V,
> +	/* Range from -2.5 V to 7.5 V. Requires Rfb2x connection  */
> +	AD3542R_CH_OUTPUT_RANGE_NEG_2P5__7P5V,
>  };
>  
>  enum ad3552r_ch_output_range {
> 


