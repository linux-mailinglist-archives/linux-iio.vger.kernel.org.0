Return-Path: <linux-iio+bounces-22829-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97EDDB28E45
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 15:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49BBDAC396B
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 13:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928D52E7F18;
	Sat, 16 Aug 2025 13:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FEbBkEaD"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498AB86348;
	Sat, 16 Aug 2025 13:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755352423; cv=none; b=h97IJqGLec7A1p/p6tS+AKlPs7Wj4bY7sFeG2zqZ9kfZG6VOauVFi0VFV6YZP/tUUJzFVSy9b7PwTirS4VnHB33pUHQ5OcoC2/A4mcdsxpSR9jahQcOet9Ly1eA9O0tYZ1Yjzb8k7xuBI5NzuglZKKZ2Gn91GkoZ9zkWNh3Skuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755352423; c=relaxed/simple;
	bh=bwfSR2vpQAcZH0AnlNv87di+ENSkFjj270WCdZY3OkE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ncbkC9hb4hCXsmvYHFqJg1n6VcG4/BdeFL5O9wFEZe1+UDdyFZNxfzBcEa6HO03+33G5GY78VLHQa7cDq637n4aQvvNCsWXY8HBFoiGSmddnph2Yucm6T7NomBC2/rjUS+Yz88mkA0tVcsOsp7GPDLXwFZCfjuqq3Sq15imaS34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FEbBkEaD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01625C4CEEF;
	Sat, 16 Aug 2025 13:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755352422;
	bh=bwfSR2vpQAcZH0AnlNv87di+ENSkFjj270WCdZY3OkE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FEbBkEaDF4KMYkZqkMad0JkUrCRg7brmtL9QUcPec9Dq2Zqd6rzVsSfQzEJFnTEs4
	 gLf8MKDl8mHYPJWuW0rBOIvBy3om6/ccBgrbnZP4Qpk+XumH0w45uI0nW+/eelLY6b
	 fk3Gh4zmgBHLZGmma5ryGScBxBdLmIoDuLgsLMleSRI6tTS96sJCwkSeJZEsL9olX0
	 IUKRPv7K8BEtsUka6HVGjKK8Rb9iekXyFkLgVu1jt+lJR5U4Yp2cZzBzXjBg5EtSp4
	 z9zCN/5VtsOgV9JpmY5vavHVH0F5AOuFPosW5vSCLTuyYk+aCaAuh/nNRPkFmDqKKF
	 fpjdjxN7EYKgg==
Date: Sat, 16 Aug 2025 14:53:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: prabhakar.mahadev-lad.rj@bp.renesas.com, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Claudiu
 Beznea <claudiu.beznea.uj@bp.renesas.com>, Ulf Hansson
 <ulf.hansson@linaro.org>
Subject: Re: [PATCH v5 1/2] iio: adc: rzg2l: Cleanup suspend/resume path
Message-ID: <20250816145334.7a538a19@jic23-huawei>
In-Reply-To: <20250810123328.800104-2-claudiu.beznea.uj@bp.renesas.com>
References: <20250810123328.800104-1-claudiu.beznea.uj@bp.renesas.com>
	<20250810123328.800104-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 10 Aug 2025 15:33:27 +0300
Claudiu <claudiu.beznea@tuxon.dev> wrote:

> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> There is no need to manually track the runtime PM status in the driver.
> The pm_runtime_force_suspend() and pm_runtime_force_resume() functions
> already call pm_runtime_status_suspended() to check the runtime PM state.
> 
> Additionally, avoid calling pm_runtime_put_autosuspend() during the
> suspend/resume path, as this would decrease the usage counter of a
> potential user that had the ADC open before the suspend/resume cycle.
> 
> Fixes: cb164d7c1526 ("iio: adc: rzg2l_adc: Add suspend/resume support")
That SHA isn't upstream. I think it should be.
563cf94f9329

With that fixes up, applied these to the fixes-togreg branch of iio.git and
marked them for stable.

> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
> 
> Changes in v5:
> - none
> 
> Changes in v4:
> - collected tags
> 
> Changes in v3:
> - collected tags
> 
> Changes in v2:
> - none
> 
>  drivers/iio/adc/rzg2l_adc.c | 29 ++++++++---------------------
>  1 file changed, 8 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
> index 9674d48074c9..0cb5a67fd497 100644
> --- a/drivers/iio/adc/rzg2l_adc.c
> +++ b/drivers/iio/adc/rzg2l_adc.c
> @@ -89,7 +89,6 @@ struct rzg2l_adc {
>  	struct completion completion;
>  	struct mutex lock;
>  	u16 last_val[RZG2L_ADC_MAX_CHANNELS];
> -	bool was_rpm_active;
>  };
>  
>  /**
> @@ -541,14 +540,9 @@ static int rzg2l_adc_suspend(struct device *dev)
>  	};
>  	int ret;
>  
> -	if (pm_runtime_suspended(dev)) {
> -		adc->was_rpm_active = false;
> -	} else {
> -		ret = pm_runtime_force_suspend(dev);
> -		if (ret)
> -			return ret;
> -		adc->was_rpm_active = true;
> -	}
> +	ret = pm_runtime_force_suspend(dev);
> +	if (ret)
> +		return ret;
>  
>  	ret = reset_control_bulk_assert(ARRAY_SIZE(resets), resets);
>  	if (ret)
> @@ -557,9 +551,7 @@ static int rzg2l_adc_suspend(struct device *dev)
>  	return 0;
>  
>  rpm_restore:
> -	if (adc->was_rpm_active)
> -		pm_runtime_force_resume(dev);
> -
> +	pm_runtime_force_resume(dev);
>  	return ret;
>  }
>  
> @@ -577,11 +569,9 @@ static int rzg2l_adc_resume(struct device *dev)
>  	if (ret)
>  		return ret;
>  
> -	if (adc->was_rpm_active) {
> -		ret = pm_runtime_force_resume(dev);
> -		if (ret)
> -			goto resets_restore;
> -	}
> +	ret = pm_runtime_force_resume(dev);
> +	if (ret)
> +		goto resets_restore;
>  
>  	ret = rzg2l_adc_hw_init(dev, adc);
>  	if (ret)
> @@ -590,10 +580,7 @@ static int rzg2l_adc_resume(struct device *dev)
>  	return 0;
>  
>  rpm_restore:
> -	if (adc->was_rpm_active) {
> -		pm_runtime_mark_last_busy(dev);
> -		pm_runtime_put_autosuspend(dev);
> -	}
> +	pm_runtime_force_suspend(dev);
>  resets_restore:
>  	reset_control_bulk_assert(ARRAY_SIZE(resets), resets);
>  	return ret;


