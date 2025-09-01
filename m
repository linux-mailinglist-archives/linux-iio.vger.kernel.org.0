Return-Path: <linux-iio+bounces-23590-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 987F6B3EC5A
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 18:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57DC648034B
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 16:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B885730F538;
	Mon,  1 Sep 2025 16:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ny/GUxBW"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFAB2DF13F;
	Mon,  1 Sep 2025 16:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756744688; cv=none; b=VVhu2cIaldqwe0QuNbGUggtJTaKwVgBODundfsj9Q+2YykLUyjiDxRiDrCz9SR04aqgbBNd3MM3rOl9wy+UuufPHxjjfyDfV2I7Ln4JwRxTLPdomNqrsFrAFx+5CvDl+45lF6igCNHK8B35kcFpr3n+oMkhKejZtotZZ5NsziqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756744688; c=relaxed/simple;
	bh=8G+3XGg+quEZEXW/fQFez+5wUY0vAqJwQES5pLF72xQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rHLCbizKqsGV2lhg+UHQpi6Y75CUXmY7xuLlM3dqiDhpYJXSQihrGrXsfphAMyauCmyNXJ5pl/Z9UN0h6N6bb00LqiV+EPrNGhKStAHDbowRAJBev7XmqNe0Xv/wrB3opWph21gtRcZXHsIXEfVN1nSGgEQQqvHceli2Pg6dk9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ny/GUxBW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64067C4CEF1;
	Mon,  1 Sep 2025 16:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756744688;
	bh=8G+3XGg+quEZEXW/fQFez+5wUY0vAqJwQES5pLF72xQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ny/GUxBWZwE4W1umy2rxcrMweeo9RKyZRsJLOg13X3WfmceJw7p0TpnGAA0vUst+i
	 zDQt2MMPOi8Zmlkr4jxd4j1hKfyqWGaTnxpiFmpmGRaPyKCiJ9fFRd8ZEVsdKLDoWu
	 whjRJXANxxKovvZPyx+1agpkPN60AqE8Lbt9tYRu8liNFOmXH8n9o1QT4DTitdgmf+
	 QuzcbdNo1IgRliehimrqSFLHPHg+FgUZcJrdQ/Po0MMR269d7c4BPSMupe+oZs0yj0
	 3XNYhWJuwuAK7UclXFwXI/16WrScUuZ2/VPgBNGDZorm4IAuU1fByO1VRE3EtjyxHU
	 4XKC7YTedG3aQ==
Date: Mon, 1 Sep 2025 17:38:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Krzysztof
 Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 0/5] iio: adc: samsung: Simplify, cleanup and drop
 S3C2410
Message-ID: <20250901173800.48133c60@jic23-huawei>
In-Reply-To: <20250830-s3c-cleanup-adc-v2-0-4f8299343d32@linaro.org>
References: <20250830-s3c-cleanup-adc-v2-0-4f8299343d32@linaro.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 30 Aug 2025 18:48:29 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> Changes in v2:
> - Patch #5: Fix S5Pv210 interrupts
> - Patch #3: Drop touchscreen-s3c2410.h
> - Add Rb tags
> - Link to v1: https://lore.kernel.org/r/20250830-s3c-cleanup-adc-v1-0-de54dfb1d9ea@linaro.org
> 
> S3C2410 is gone from kernel, so we can drop its support and remaining
> related pieces.

I've queued this up to get some test coverage from zero day.
I'll not push it out for linux-next for a few more days though so happy to
add tags (or drop it if anything comes up!)

Jonathan

> 
> Best regards,
> Krzysztof
> 
> ---
> Krzysztof Kozlowski (5):
>       iio: adc: exynos_adc: Drop S3C2410 support
>       iio: adc: exynos_adc: Drop touchscreen support
>       iio: adc: exynos_adc: Drop platform data support
>       dt-bindings: iio: adc: samsung,exynos: Drop S3C2410
>       dt-bindings: iio: adc: samsung,exynos: Drop touchscreen support
> 
>  .../bindings/iio/adc/samsung,exynos-adc.yaml       |  26 +-
>  drivers/iio/adc/exynos_adc.c                       | 282 +--------------------
>  include/linux/platform_data/touchscreen-s3c2410.h  |  22 --
>  3 files changed, 14 insertions(+), 316 deletions(-)
> ---
> base-commit: 642543fe9a04beda174633dff607429dc1734b2a
> change-id: 20250830-s3c-cleanup-adc-71ac80978520
> 
> Best regards,


