Return-Path: <linux-iio+bounces-19804-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F268AC0E25
	for <lists+linux-iio@lfdr.de>; Thu, 22 May 2025 16:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F3E11BA80E2
	for <lists+linux-iio@lfdr.de>; Thu, 22 May 2025 14:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09DBC28C025;
	Thu, 22 May 2025 14:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CMqrnovc"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AEF28A1E3;
	Thu, 22 May 2025 14:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747924395; cv=none; b=X2CVZijH1hjzT0IEPFJ2qnU3gsxgTpgoXVtNQUvoKx/pYMMfLNWUcwNrWtgFzzHop8889+uRuf4JhwqEPZSyvAc/ij3tklGsWoK2yXTSx4vT4z2BiqApn16xrX6eJ8HtPG5HUfPk1yKASiP/dzi/d7X+GfUNMuty3nTsJS5XT50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747924395; c=relaxed/simple;
	bh=DJKs6Q7Dqz8+aybYX0U4dC30YuBlJrtErU/MK3V46QE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z5416MQkpltk5thumjhqyfei0vMoq+Q8rzGBcr8frjlXLTBi3HVxQbL9GeLGjsQeKxO091/oIPde0nyb42md+SGhkI2f15mA6oeq48WGtsg9avda+zw6iGOeXhgdMiwblDf3fwCdMs38m/qiLkYXvQx6v3zDo44hMyxkiK8omEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CMqrnovc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9834C4CEE4;
	Thu, 22 May 2025 14:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747924395;
	bh=DJKs6Q7Dqz8+aybYX0U4dC30YuBlJrtErU/MK3V46QE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CMqrnovcHVWVuc3u/CUiT/cqgMzY16zqBcFlJI8s/Uavv6xzqnejwTL8rrF8O2I2N
	 gNE44hAp4VSoMH3h2B1ZNvI6nYfepyKAsHH8E1BVz8OxIM4UZOl1fEWXLh7Sh6EMsm
	 0CjKLxVRKsxR+bqIvgk06sY5ZKXcTzcz48n5Vhy9dB/uNscKVde3Iy9L2fW77rlblD
	 YKt5V71dLuLFYQpHwBuqs6hADi7P5z09QLXhV3LYuBgTPSgiVJzLOcQeNbhOPY61j6
	 Ka9esymGb0jdUuhDMNRvG48/ItghTZCDgL5T5EGHETWhukGRofLsAn6rTzyqK454tZ
	 Y2DVt0kKBnYiQ==
Date: Thu, 22 May 2025 15:33:09 +0100
From: Lee Jones <lee@kernel.org>
To: Alexandru Soponar <asoponar@taladin.ro>
Cc: linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-leds@vger.kernel.org,
	linux-watchdog@vger.kernel.org, jdelvare@suse.com,
	linux@roeck-us.net, jic23@kernel.org, pavel@ucw.cz,
	baocheng.su@siemens.com, wim@linux-watchdog.org,
	tobias.schaffner@siemens.com,
	angelogioacchino.delregno@collabora.com,
	benedikt.niedermayr@siemens.com, matthias.bgg@gmail.com,
	aardelean@baylibre.com, contact@sopy.one
Subject: Re: [PATCH 13/16] leds: eds-mt6370-rgb: Fix type incompatibility
 with find_closest()
Message-ID: <20250522143309.GA1378991@google.com>
References: <20250515081332.151250-1-asoponar@taladin.ro>
 <20250515081332.151250-14-asoponar@taladin.ro>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250515081332.151250-14-asoponar@taladin.ro>

On Thu, 15 May 2025, Alexandru Soponar wrote:

> The common_tfreqs and mt6372_tfreqs arrays were previously declared as
> unsigned int but used with find_closest(), which now takes signed int
> parameters. Change these arrays from unsigned int to int to maintain type
> compatibility with the find_closest() function signature and prevent
> compilation errors.
> 
> Signed-off-by: Alexandru Soponar <asoponar@taladin.ro>
> ---
>  drivers/leds/rgb/leds-mt6370-rgb.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Acked-by: Lee Jones <lee@kernel.org>

> diff --git a/drivers/leds/rgb/leds-mt6370-rgb.c b/drivers/leds/rgb/leds-mt6370-rgb.c
> index ebd3ba878dd5..6ce11432dd96 100644
> --- a/drivers/leds/rgb/leds-mt6370-rgb.c
> +++ b/drivers/leds/rgb/leds-mt6370-rgb.c
> @@ -135,7 +135,7 @@ struct mt6370_led {
>  };
>  
>  struct mt6370_pdata {
> -	const unsigned int *tfreq;
> +	const int *tfreq;
>  	unsigned int tfreq_len;
>  	u16 reg_rgb1_tr;
>  	s16 reg_rgb_chrind_tr;
> @@ -212,11 +212,11 @@ static const struct linear_range mt6372_led_ranges[R_MAX_RANGES] = {
>  	[R_LED_TOFF]	= { 250, 0, 15, 500 },
>  };
>  
> -static const unsigned int common_tfreqs[] = {
> +static const int common_tfreqs[] = {
>  	10000, 5000, 2000, 1000, 500, 200, 5, 1,
>  };
>  
> -static const unsigned int mt6372_tfreqs[] = {
> +static const int mt6372_tfreqs[] = {
>  	8000, 4000, 2000, 1000, 500, 250, 8, 4,
>  };
>  
> @@ -304,7 +304,8 @@ static int mt6370_set_led_freq(struct mt6370_priv *priv, unsigned int led_no, un
>  	const struct mt6370_pdata *pdata = priv->pdata;
>  	enum mt6370_led_field sel_field;
>  	unsigned int tfreq_len = pdata->tfreq_len;
> -	unsigned int tsum, sel;
> +	unsigned int sel;
> +	int tsum;
>  
>  	tsum = ton + toff;
>  
> -- 
> 2.49.0
> 

-- 
Lee Jones [李琼斯]

