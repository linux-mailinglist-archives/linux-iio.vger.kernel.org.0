Return-Path: <linux-iio+bounces-27268-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1208CCD3FCD
	for <lists+linux-iio@lfdr.de>; Sun, 21 Dec 2025 13:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 121D630065A5
	for <lists+linux-iio@lfdr.de>; Sun, 21 Dec 2025 12:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58972F7AB0;
	Sun, 21 Dec 2025 12:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oqDNeUcy"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95679274670;
	Sun, 21 Dec 2025 12:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766318690; cv=none; b=KjQ4yiyzBR2LkrFJNOVULUZ4TQjjbmfZ6G3PmSRcjrNFz3Lf8yFNd3kgY2ILsdw82+qIZJSFRgfZWZjXrD+aEE2MPNVEKDk5x5k3y4Gr0G9W9mADeLtpjC+vd9Uy18b6AfyD5PNqlIZ5UU6FKnX4K8gS9GRsn9dzMG8m/QJaFnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766318690; c=relaxed/simple;
	bh=7LVQ8OFSH90aBTKeJHbT6h52O5X5Gibty3PLGF89PDw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I+bW1+kpN+jER0duKhGgcv7kGI/gDjwdLkzS6WiystS4QeR//0HMRvnctg+uW14S8MTTlpu9OvE38H+weFnucE3s0fV5d4MSD4jlTWEjn6tFgrtJNtc5UVsfp0oqa/w7cLVJz+pKOiPIybdAy7nGlqwPaWCirYjn44wIWdDqF44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oqDNeUcy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22B2BC4CEFB;
	Sun, 21 Dec 2025 12:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766318690;
	bh=7LVQ8OFSH90aBTKeJHbT6h52O5X5Gibty3PLGF89PDw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oqDNeUcywridYkQcEhbD4MFn2rDVLVbge9+UENfHQXADzdMeBATSju97wySENj2Pz
	 d+tUuRRLIJykix21Wv9ZJG0k4s53SmnsutnxtFtp0VFZIs5vft8m2o/J1L5aEvtaOF
	 aFA5GwrQ6lJTn3IS1Top2ShQDW/vlOEBj+NbCfUDh9HUhPwrlkU346ODM9jUH4+sXx
	 6jt72+9OwPTJh3U4HXnoQvVIFc27XFg8FaOeG1A5s9L3t+2fR6KVzhYlVTA+fz/Zkc
	 /tGUuMTQf8qyeR4Jbar9BIkUSnemwSK+KZxq6Dj4Z1zc9YfGxCL7wvZNh8yb+MWc7m
	 p8kgIzemsGaAA==
Date: Sun, 21 Dec 2025 12:04:39 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Joel Stanley
 <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, Krzysztof
 Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, Heiko
 Stuebner <heiko@sntech.de>, Orson Zhai <orsonzhai@gmail.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>,
 linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 0/5] iio: adc: Simplify with dev_err_probe
Message-ID: <20251221120439.3aa841ca@jic23-huawei>
In-Reply-To: <20251219-iio-dev-err-probe-v1-0-bd0fbc83c8a0@oss.qualcomm.com>
References: <20251219-iio-dev-err-probe-v1-0-bd0fbc83c8a0@oss.qualcomm.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Dec 2025 15:31:49 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com> wrote:

> Use dev_err_probe() to make error code handling simpler and handle
> deferred probe nicely (avoid spamming logs).
> 
> Best regards,
> Krzysztof
Thanks. Series applied.

Jonathan

> 
> ---
> Krzysztof Kozlowski (5):
>       iio: adc: aspeed: Simplify with dev_err_probe
>       iio: adc: exynos: Simplify with dev_err_probe
>       iio: adc: qcom-spmi-rradc: Simplify with dev_err_probe
>       iio: adc: rockchip: Simplify with dev_err_probe
>       iio: adc: sc27xx: Simplify with dev_err_probe
> 
>  drivers/iio/adc/aspeed_adc.c      |  9 ++++---
>  drivers/iio/adc/exynos_adc.c      | 29 ++++++++---------------
>  drivers/iio/adc/qcom-spmi-rradc.c | 20 ++++++----------
>  drivers/iio/adc/rockchip_saradc.c | 13 ++++-------
>  drivers/iio/adc/sc27xx_adc.c      | 49 ++++++++++++++-------------------------
>  5 files changed, 43 insertions(+), 77 deletions(-)
> ---
> base-commit: cc3aa43b44bdb43dfbac0fcb51c56594a11338a8
> change-id: 20251219-iio-dev-err-probe-59b3104c8d4b
> 
> Best regards,


