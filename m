Return-Path: <linux-iio+bounces-10799-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2D69A4F0A
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2024 17:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A29F2B21DB6
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2024 15:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB9D61FEB;
	Sat, 19 Oct 2024 15:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lbfXxFBN"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8646410E4;
	Sat, 19 Oct 2024 15:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729350992; cv=none; b=mpnFUVlH+bn5wKRdRnGt9Fz8kFC4YOacRTwBLPYPZllpNI2UniLlWwYxDINfjPO0OZNOcZ+Qd8vZZJ1loPW8SCtnvSes085U2BkgLVzgyx82Z005Drv3Bh+llr/zw+odD/Mm4sZNBarkOJ/c2FQK/rhmdjsUkmzRv5ivKMzh1MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729350992; c=relaxed/simple;
	bh=3/eaC3Oc0bPaRKKVcrfUBzt/D2U5MUHCT+S7BOLzJtY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R12rCP2v32hyOumlhHzkYkMz8qzAr6B2or+u5FgTdQ3vWU1U1tCM3Gwj7+V1cHcFTQ0S7Sz+i7fu+WfFwj4kPhY9Vgq+Qt4eQS7btCkIFyrsJEf0y9A1OFvnJkFJULedQchomMlL75f0l9qyLAXfmedauV3MFNGg+UfOhd99OLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lbfXxFBN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECDD3C4CEC5;
	Sat, 19 Oct 2024 15:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729350991;
	bh=3/eaC3Oc0bPaRKKVcrfUBzt/D2U5MUHCT+S7BOLzJtY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lbfXxFBN7TMDXS/C8c0H7QXTadXfiatUwzfLzl5AjNp/CXIKZ6A8xtG8R429xeGIb
	 Jcg8Z9/1eCxXwsCPJBX35Nq5lC4mNoD1b5CeYNfycTVuFW09xnqJwBnVc8NR8QOG3K
	 nWIaUvmxOXsqRQao7kKib56VRQofuDhfV8zAIG6jn2OfN5YaLh36N8Fadv4U/PBKFn
	 6rZzU3j1MEUOzRlLdLVNgqnTq06VKJU7KOhKJT6PPzx/LFMuOyz+K6zkbanD2IezLa
	 6i4KGCwaIUEnEnySCSy0H9D3Fm6YzhVx3bCaj0LNbDwNNrE8s2+bHFi0ZTHCsHQBz6
	 lcOGH5IDdu1PQ==
Date: Sat, 19 Oct 2024 16:15:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dlechner@baylibre.com, Mark Brown
 <broonie@kernel.org>
Subject: Re: [PATCH v6 6/8] iio: dac: ad3552r: extract common code (no
 changes in behavior intended)
Message-ID: <20241019161546.026f02e7@jic23-huawei>
In-Reply-To: <20241014-wip-bl-ad3552r-axi-v0-iio-testing-v6-6-eeef0c1e0e56@baylibre.com>
References: <20241014-wip-bl-ad3552r-axi-v0-iio-testing-v6-0-eeef0c1e0e56@baylibre.com>
	<20241014-wip-bl-ad3552r-axi-v0-iio-testing-v6-6-eeef0c1e0e56@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Oct 2024 12:08:12 +0200
Angelo Dureghello <adureghello@baylibre.com> wrote:

> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Extracting common code, to share common code to be used later
> by the AXI driver version (ad3552r-axi.c).
> 
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
One suggestion inline.

Jonathan

> ---
>  drivers/iio/dac/Makefile         |   2 +-
>  drivers/iio/dac/ad3552r-common.c | 170 ++++++++++++++++++++++
>  drivers/iio/dac/ad3552r.c        | 303 ++++-----------------------------------
>  drivers/iio/dac/ad3552r.h        | 200 ++++++++++++++++++++++++++
>  4 files changed, 398 insertions(+), 277 deletions(-)
> 
> diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
> index 621d553bd6e3..c92de0366238 100644
> --- a/drivers/iio/dac/Makefile
> +++ b/drivers/iio/dac/Makefile
> @@ -4,7 +4,7 @@
>  #
>  
>  # When adding new entries keep the list in alphabetical order
> -obj-$(CONFIG_AD3552R) += ad3552r.o
> +obj-$(CONFIG_AD3552R) += ad3552r.o ad3552r-common.o
>  obj-$(CONFIG_AD5360) += ad5360.o
>  obj-$(CONFIG_AD5380) += ad5380.o
>  obj-$(CONFIG_AD5421) += ad5421.o
> diff --git a/drivers/iio/dac/ad3552r-common.c b/drivers/iio/dac/ad3552r-common.c
> new file mode 100644
> index 000000000000..9a892abf99ac
> --- /dev/null
> +++ b/drivers/iio/dac/ad3552r-common.c
> @@ -0,0 +1,170 @@

> +
> +u16 ad3552r_calc_custom_gain(u8 p, u8 n, s16 goffs)
> +{
> +	u16 reg;
> +
> +	reg = FIELD_PREP(AD3552R_MASK_CH_RANGE_OVERRIDE, 1);
> +	reg |= FIELD_PREP(AD3552R_MASK_CH_GAIN_SCALING_P, p);
> +	reg |= FIELD_PREP(AD3552R_MASK_CH_GAIN_SCALING_N, n);
> +	reg |= FIELD_PREP(AD3552R_MASK_CH_OFFSET_BIT_8, abs(goffs));
> +	reg |= FIELD_PREP(AD3552R_MASK_CH_OFFSET_POLARITY, goffs < 0);
Trivial but whilst here, to me this is no more readable than.

	return FIELD_PREP(AD3552R_MASK_CH_RANGE_OVERRIDE, 1) |
	       FIELD_PREP(AD3552R_MASK_CH_GAIN_SCALING_P, p) |
	       FIELD_PREP(AD3552R_MASK_CH_GAIN_SCALING_N, n) |
	       FIELD_PREP(AD3552R_MASK_CH_OFFSET_BIT_8, abs(goffs)) |
	       FIELD_PREP(AD3552R_MASK_CH_OFFSET_POLARITY, goffs < 0);

> +
> +	return reg;
> +}
>

