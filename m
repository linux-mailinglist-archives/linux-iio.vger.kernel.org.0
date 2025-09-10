Return-Path: <linux-iio+bounces-23960-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C60B52024
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 20:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DBA4467F89
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 18:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748EC25A63D;
	Wed, 10 Sep 2025 18:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cECr3I+s"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A2821254A;
	Wed, 10 Sep 2025 18:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757528216; cv=none; b=dV9RwBkfLSK3RVbLAd19wUcCUy/ajiZmAQerFk2WZsPCGwF1GtdcmrsXSjmSfDO4ngBE+emYqSzIM1c2GuX0vMGXmPCgTBQL3zdaxJnOWc0AaImehiZiqrsyjKFCFS66qHW7s9yfDm2prVTT6IGa5i/cwbMXApqm23Y+QnvKU74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757528216; c=relaxed/simple;
	bh=VSANkXBvBsja1CxVgGJ2SrU3/V9mFAfauT3SVfIvl94=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ORChIqmyP+moH4jfImJNjqSJaMnPT34uMEaokmoYT/C/+Qr5KdQKGhi3CqdkYZRkMCQjbiAmTJNDaJYRcgN45Mm+3t8HIn+zFXE1Tcrk2f02yqH7MrHhj2Gbu6lLZOFIzOGQz05vQei/Ei7Zh7rPizglle7BZVDMZQMtbE34tKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cECr3I+s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 470B2C4CEEB;
	Wed, 10 Sep 2025 18:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757528214;
	bh=VSANkXBvBsja1CxVgGJ2SrU3/V9mFAfauT3SVfIvl94=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cECr3I+saLHEALRreECE8VuHKHWmje6SlAFNJJW6nik+7d0Cic66vxwL2IjVjO7NK
	 Clj5vBH3QPdPG/fEfDY+lGBvDcubvw2ZkaQJauNV5EwiwYAY+RF409SFgQe1eMc5aP
	 +9fww6Yqu+ZJcgTIfuO/GRJtdIl0Ydu/HYwFSoPMT96XVHQwl+ey7r+ro3MfswPpeA
	 Ho6WqoElGcLuhhK9yJ8dfx7bYDpIAOoHdrh2huJY9u/IgEwi+KmKAfI6cBgIb02Rgq
	 /3+Qlk9kCSNE7jyWmlKUiYavNojXfXOS0tOZjfgkGBCO87uy17TbvMyw13LFuGn2Rh
	 1fmyUWLm/1xoA==
Date: Wed, 10 Sep 2025 19:16:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 12/14] iio: accel: bma220: add LPF cut-off frequency
 mapping
Message-ID: <20250910191644.3327042c@jic23-huawei>
In-Reply-To: <20250910-bma220_improvements-v2-12-e23f4f2b9745@subdimension.ro>
References: <20250910-bma220_improvements-v2-0-e23f4f2b9745@subdimension.ro>
	<20250910-bma220_improvements-v2-12-e23f4f2b9745@subdimension.ro>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Sep 2025 10:57:17 +0300
Petre Rodan <petre.rodan@subdimension.ro> wrote:

> Add mapping for the low pass filter cut-off frequency.
> Make valid values visible for both the cut-off frequency and the scale.
> 
> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
> ---
8 @@ static const struct iio_chan_spec bma220_channels[] = {
>  	IIO_CHAN_SOFT_TIMESTAMP(3),
>  };
>  
> +/*
> + * Available cut-off frequencies of the low pass filter in Hz.
> + */

Completely trivial, but stick to single line comments when it fits under 80 chars.

> +static const int bma220_lpf_3dB_freq_Hz_table[] = {
> +	[BMA220_COF_1000Hz] = 1000,
> +	[BMA220_COF_500Hz] = 500,
> +	[BMA220_COF_250Hz] = 250,
> +	[BMA220_COF_125Hz] = 125,
> +	[BMA220_COF_64Hz] = 64,
> +	[BMA220_COF_32Hz] = 32,
> +};

