Return-Path: <linux-iio+bounces-14224-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 421A9A0AA72
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 16:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 427991886A09
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 15:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1077E1BBBD7;
	Sun, 12 Jan 2025 15:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kXvUmjwY"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32391B6CE9;
	Sun, 12 Jan 2025 15:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736695620; cv=none; b=dXGjavWIERxUct1meXMKdgUzLP6QVlLbe9L36pSjsAiX8FMHBhLuCHst/uf9BpHukaPKKZqGraNivrcb93SJdQblNAtDB7Ofn3WF1jFtNBdcTXasCB46rEVQ11Ecbp093F51qzupjFFgPzT9YhN7CQwPHpK6Pf5/Z7Y/Ps2NRhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736695620; c=relaxed/simple;
	bh=oQB4d3mtZNWze0IAzdVih8xUg0nziFR7hFNGRVfmzgE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SfLRVevDS3K/TKjfLZsGsYU1DokIOOVHzu4AwSex0wAcjAkiMAHkswvmbK/FGhE07zwwA5LRrIVzyh2+flBNxh9scOjk53jPX4yFvK9txFVNMC9R9aHFONmVYO77yh+f+P9Vkqw9m8zcjxFs9K097yKT77fBOfZxn2I390LwiGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kXvUmjwY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22B44C4CEDF;
	Sun, 12 Jan 2025 15:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736695620;
	bh=oQB4d3mtZNWze0IAzdVih8xUg0nziFR7hFNGRVfmzgE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kXvUmjwYxKBceJrH7aU+jE3oW4MizvS+7TZOOGhRVef3y974AtqDgPhhSbN5MHvZ/
	 lNT3GFCnRq9q9j2ahjyqJXyLI5jTEN0bX3pKN6jqsPC/Ovmg86d2l8Sn2ARdOGBeNd
	 VxLvnzWvHhRW+it2C6E0v/8hG8d8b8pVfn8iMvaYCIzr7qWP6Pr4wtX72D0uV0LyDV
	 m9NcJ7bppwlg/g9ZhIMZdAWcniFm7wcCZMJO0ZyBIsY3qpcnxFKX0ZJjpioldI+jH9
	 p7qgS44K0n2rHjrHf3yVJCp+Cm2Xbbwix4fhCm1sUr2O9J8z+O7hkGAHl0ieVwyRfg
	 3ezxYbJcuTH+w==
Date: Sun, 12 Jan 2025 15:26:51 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark
 Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: stm32: Drop unnecessary DT property presence
 check
Message-ID: <20250112152651.30b343dd@jic23-huawei>
In-Reply-To: <20250109182325.3973684-2-robh@kernel.org>
References: <20250109182325.3973684-2-robh@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  9 Jan 2025 12:23:25 -0600
"Rob Herring (Arm)" <robh@kernel.org> wrote:

> There's no reason to check for regulator supply property presence before
> calling devm_regulator_get_optional() as that will return -ENODEV if
> the supply is not present.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
> The diff context doesn't show it, but the next line returns on error 
> other than -ENODEV.
Thanks for that. Saved me opening the file.

Applied to the testing branch of iio.git. Probably next cycle material now.

Jonathan

> 
>  drivers/iio/adc/stm32-adc-core.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
> index 2201ee9987ae..0914148d1a22 100644
> --- a/drivers/iio/adc/stm32-adc-core.c
> +++ b/drivers/iio/adc/stm32-adc-core.c
> @@ -615,8 +615,7 @@ static int stm32_adc_core_switches_probe(struct device *dev,
>  	}
>  
>  	/* Booster can be used to supply analog switches (optional) */
> -	if (priv->cfg->has_syscfg & HAS_VBOOSTER &&
> -	    of_property_read_bool(np, "booster-supply")) {
> +	if (priv->cfg->has_syscfg & HAS_VBOOSTER) {
>  		priv->booster = devm_regulator_get_optional(dev, "booster");
>  		if (IS_ERR(priv->booster)) {
>  			ret = PTR_ERR(priv->booster);
> @@ -628,8 +627,7 @@ static int stm32_adc_core_switches_probe(struct device *dev,
>  	}
>  
>  	/* Vdd can be used to supply analog switches (optional) */
> -	if (priv->cfg->has_syscfg & HAS_ANASWVDD &&
> -	    of_property_read_bool(np, "vdd-supply")) {
> +	if (priv->cfg->has_syscfg & HAS_ANASWVDD) {
>  		priv->vdd = devm_regulator_get_optional(dev, "vdd");
>  		if (IS_ERR(priv->vdd)) {
>  			ret = PTR_ERR(priv->vdd);


