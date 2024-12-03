Return-Path: <linux-iio+bounces-13041-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C24479E2D94
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 21:51:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0EE6B61357
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 20:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C29205AAF;
	Tue,  3 Dec 2024 20:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QLBUnj3q"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85F420E003;
	Tue,  3 Dec 2024 20:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733256056; cv=none; b=A0aK8tO5qsmdh5EJC8Xnehufn/rRcLBMNb+vzplTu7NUAbnS3y86LJo1KEkjFqboQE1ERjOsHWQl5V3k9gwuh5kmuZdkuGQgJMQ04I9xnRYcHUC3vmhdpEpFvnedPVK2qTMhcMIkcq4jKadNQB9oKSj1hgrnoDpgLD0bIXBVTak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733256056; c=relaxed/simple;
	bh=g2jAFt9E6cPrLkzxjZNZdLFCazRG7f3JsLV0zDlhSZA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jqkRvnz27/uT02HMSmjSJ4xckG/jlhzR/FhWWWDO7iVKRX//NHq5Eqdr09+sKlLE2s++rYCHcRWmAM2z3FdWpewVjvXpqBopjnh7L9X1GNX0iNCpn6f4N+QdyyM2givjdS4wFwZhgAHLMGXGYBtnRhWIALKn/8uuxb/y46bYYyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QLBUnj3q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC630C4CECF;
	Tue,  3 Dec 2024 20:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733256056;
	bh=g2jAFt9E6cPrLkzxjZNZdLFCazRG7f3JsLV0zDlhSZA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QLBUnj3qLYHyh6+AEXIwE59KTq454t7fNSF4nUQzKVg4DPu/rbypW3lWsJxPXzy3T
	 d/uIKnYP+U5YwgVvpPE+yOA5123tkQYmkhAZZlP/K4YceHEohpb3LSymnVBd+qAWt3
	 cyDR5JV/vUHySt4TyHmARK1pHsgKmyw/iVp1rEgzzw02TvPpd2AV+dxySNkt7ZZuME
	 mkrl2PjKBJ89u1qQWztXA1Ln/KAQ+S0CSQyOSZS783DJfj7HnjAcVR9e9VQZJdEVro
	 /AUa4brl9XBaQK6HS59yWwhAVOwdIPc8NrUz6+kXGgxU+EVWu67E8PdIraJBp2nRBK
	 dj/nCDw+5OKLA==
Date: Tue, 3 Dec 2024 20:00:46 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: prabhakar.mahadev-lad.rj@bp.renesas.com, lars@metafoo.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 geert+renesas@glider.be, magnus.damm@gmail.com, mturquette@baylibre.com,
 sboyd@kernel.org, p.zabel@pengutronix.de, linux-iio@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, Claudiu Beznea
 <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH 07/14] iio: adc: rzg2l_adc: Enable runtime PM
 autosuspend support
Message-ID: <20241203200046.0dfb784a@jic23-huawei>
In-Reply-To: <20241203111314.2420473-8-claudiu.beznea.uj@bp.renesas.com>
References: <20241203111314.2420473-1-claudiu.beznea.uj@bp.renesas.com>
	<20241203111314.2420473-8-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  3 Dec 2024 13:13:07 +0200
Claudiu <claudiu.beznea@tuxon.dev> wrote:

> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Enable runtime PM autosuspend support for the rzg2l_adc driver. With this
> change, consecutive conversion requests will no longer cause the device to
> be runtime-enabled/disabled after each request. Instead, the device will
> transition based on the delay configured by the user.
> 
> This approach reduces the frequency of hardware register access during
> runtime PM suspend/resume cycles, thereby saving CPU cycles. The default
> autosuspend delay is set to zero to maintain the previous driver behavior.

Unless you have a weird user who is polling slow enough to not trigger
autosuspend with a non zero period, but is still saving power I'm not convinced
anyone will notice if you just enable this for a sensible autosuspend delay.
There will of course be a small increase in power usage for each read but
hopefully that is trivial.

So I'd not go with a default of 0, though what value makes sense depends
on the likely usecase + how much power is saved by going to sleep.

If you really want to keep 0 I don't mind that much, just seems odd!

Jonathan

> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>  drivers/iio/adc/rzg2l_adc.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
> index eed2944bd98d..fda8b42ded81 100644
> --- a/drivers/iio/adc/rzg2l_adc.c
> +++ b/drivers/iio/adc/rzg2l_adc.c
> @@ -207,7 +207,8 @@ static int rzg2l_adc_conversion(struct iio_dev *indio_dev, struct rzg2l_adc *adc
>  	rzg2l_adc_start_stop(adc, false);
>  
>  rpm_put:
> -	pm_runtime_put_sync(dev);
> +	pm_runtime_mark_last_busy(dev);
> +	pm_runtime_put_autosuspend(dev);
>  	return ret;
>  }
>  
> @@ -372,7 +373,8 @@ static int rzg2l_adc_hw_init(struct device *dev, struct rzg2l_adc *adc)
>  	rzg2l_adc_writel(adc, RZG2L_ADM(3), reg);
>  
>  exit_hw_init:
> -	pm_runtime_put_sync(dev);
> +	pm_runtime_mark_last_busy(dev);
> +	pm_runtime_put_autosuspend(dev);
>  	return ret;
>  }
>  
> @@ -412,6 +414,9 @@ static int rzg2l_adc_probe(struct platform_device *pdev)
>  		return PTR_ERR(adc->presetn);
>  	}
>  
> +	/* Default 0 for power saving. Can be overridden via sysfs. */
> +	pm_runtime_set_autosuspend_delay(dev, 0);
> +	pm_runtime_use_autosuspend(dev);
>  	ret = devm_pm_runtime_enable(dev);
>  	if (ret)
>  		return ret;


