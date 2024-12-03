Return-Path: <linux-iio+bounces-13036-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A48A59E2D71
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 21:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85F24B3D167
	for <lists+linux-iio@lfdr.de>; Tue,  3 Dec 2024 19:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8BE2040BD;
	Tue,  3 Dec 2024 19:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kEd3yKzO"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEB22040BB;
	Tue,  3 Dec 2024 19:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733255497; cv=none; b=Mf0bHv9kDotkZhKV2yBIvLHbNqWLm2l7NchGPvp9dkXp/CS9PMBa5VALQCVM9VHvRV3rDgtButBOjW81P+Es+IGpA86pQjwNxUJPHdGQp+95GUPNYRblKurjSFSWoRN9yuMz9Yf3NLbskE9jkxMnies+RY+qFPrK/xbQMa+nIb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733255497; c=relaxed/simple;
	bh=mV7LLrltgDkaVfXGQHRmcEnjN0pqK4N33xm9mgi5Lp4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZkR6nsUGtj6zCK260/FPzC2wGSZ06XmXUNgwqdr+LrhrfPbtOyWfXgrbx+0JIw2YJrDbOei6rNSK6vXyn4Z5Ye7odW+3qMGRFD5B2ZzZxl/U2LsmQYqBU0bEqsPcd72SYV25UD8H0GVfQ+UNR6DNMaAI7ZrJhyQ8AWVn1rgbvXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kEd3yKzO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1690C4CED8;
	Tue,  3 Dec 2024 19:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733255497;
	bh=mV7LLrltgDkaVfXGQHRmcEnjN0pqK4N33xm9mgi5Lp4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kEd3yKzOnjt6LF6f8itwYdPhZXgHtKqKbpdh3EhIeEMrLyew3h4asNosGxjGNYgVh
	 pnDjgIdWRrTAyPmHmtmTcChKK7k5Jgn6TqjWWvLWP5+aVUf0FoEJWhAzan8aRKhhrB
	 PIpI+9aRHXIyk9wSwzU0QBU5J68CTO68EdHC6n8N4AsJFGXSJ8mUVsVhfcIhoBpvr/
	 Rbeo6etK/CaHF3BoGi/r81xdOvk90TQDXNTelLRS8ywg5PrNbk6mV5+47i4RyavVf+
	 dT/ZOHHKsf7aJHKO/tx2Q8gpoMXW+U3t137u1ow7PUh1wkqR3U24Rj0Uwv1XAVG2Q4
	 XyQdG3+VaUnJg==
Date: Tue, 3 Dec 2024 19:51:27 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: prabhakar.mahadev-lad.rj@bp.renesas.com, lars@metafoo.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 geert+renesas@glider.be, magnus.damm@gmail.com, mturquette@baylibre.com,
 sboyd@kernel.org, p.zabel@pengutronix.de, linux-iio@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, Claudiu Beznea
 <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH 02/14] iio: adc: rzg2l_adc: Use devres helpers to
 request pre-deasserted reset controls
Message-ID: <20241203195127.294245f6@jic23-huawei>
In-Reply-To: <20241203111314.2420473-3-claudiu.beznea.uj@bp.renesas.com>
References: <20241203111314.2420473-1-claudiu.beznea.uj@bp.renesas.com>
	<20241203111314.2420473-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  3 Dec 2024 13:13:02 +0200
Claudiu <claudiu.beznea@tuxon.dev> wrote:

> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Starting with commit d872bed85036 ("reset: Add devres helpers to request
> pre-deasserted reset controls"), devres helpers are available to simplify
> the process of requesting pre-deasserted reset controls. Update the
> rzg2l_adc driver to utilize these helpers, reducing complexity in this
> way.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Hi Claudia,

Minor comments below.

Thanks

Jonathan

> ---
>  drivers/iio/adc/rzg2l_adc.c | 37 ++-----------------------------------
>  1 file changed, 2 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
> index cd3a7e46ea53..7039949a7554 100644
> --- a/drivers/iio/adc/rzg2l_adc.c
> +++ b/drivers/iio/adc/rzg2l_adc.c
> @@ -415,11 +415,6 @@ static void rzg2l_adc_pm_runtime_set_suspended(void *data)
>  	pm_runtime_set_suspended(dev->parent);
>  }
>  
> -static void rzg2l_adc_reset_assert(void *data)
> -{
> -	reset_control_assert(data);
> -}
> -
>  static int rzg2l_adc_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -456,46 +451,18 @@ static int rzg2l_adc_probe(struct platform_device *pdev)
>  		return PTR_ERR(adc->adclk);
>  	}
>  
> -	adc->adrstn = devm_reset_control_get_exclusive(dev, "adrst-n");
> +	adc->adrstn = devm_reset_control_get_exclusive_deasserted(dev, "adrst-n");
>  	if (IS_ERR(adc->adrstn)) {
>  		dev_err(dev, "failed to get adrstn\n");
I'd be tempted to keep the error message from below rather than this one.
As we can only conclude the deassert failed to happen, not whether it was the
get step or the deassert itself.

Also, use dev_err_probe() throughout and definitely for anything you are touching
in this series. Ideally add a patch converting all the other places where it
is useful in things only called from probe.
	return dev_err_probe(dev, PTR_ERR(adc->adrstn),
			     "failed to deassert adrstn pin\n");

>  		return PTR_ERR(adc->adrstn);
>  	}
>  
> -	adc->presetn = devm_reset_control_get_exclusive(dev, "presetn");
> +	adc->presetn = devm_reset_control_get_exclusive_deasserted(dev, "presetn");
>  	if (IS_ERR(adc->presetn)) {
>  		dev_err(dev, "failed to get presetn\n");
>  		return PTR_ERR(adc->presetn);
>  	}
>  
> -	ret = reset_control_deassert(adc->adrstn);
> -	if (ret) {
> -		dev_err(&pdev->dev, "failed to deassert adrstn pin, %d\n", ret);
> -		return ret;
> -	}
> -
> -	ret = devm_add_action_or_reset(&pdev->dev,
> -				       rzg2l_adc_reset_assert, adc->adrstn);
> -	if (ret) {
> -		dev_err(&pdev->dev, "failed to register adrstn assert devm action, %d\n",
> -			ret);
> -		return ret;
> -	}
> -
> -	ret = reset_control_deassert(adc->presetn);
> -	if (ret) {
> -		dev_err(&pdev->dev, "failed to deassert presetn pin, %d\n", ret);
> -		return ret;
> -	}
> -
> -	ret = devm_add_action_or_reset(&pdev->dev,
> -				       rzg2l_adc_reset_assert, adc->presetn);
> -	if (ret) {
> -		dev_err(&pdev->dev, "failed to register presetn assert devm action, %d\n",
> -			ret);
> -		return ret;
> -	}
> -
>  	ret = rzg2l_adc_hw_init(adc);
>  	if (ret) {
>  		dev_err(&pdev->dev, "failed to initialize ADC HW, %d\n", ret);


