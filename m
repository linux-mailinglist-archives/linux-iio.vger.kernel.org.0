Return-Path: <linux-iio+bounces-13204-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D5D9E8186
	for <lists+linux-iio@lfdr.de>; Sat,  7 Dec 2024 19:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6B3C165035
	for <lists+linux-iio@lfdr.de>; Sat,  7 Dec 2024 18:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB3F15278E;
	Sat,  7 Dec 2024 18:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OSy1Nm2u"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7463A3FF1;
	Sat,  7 Dec 2024 18:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733595823; cv=none; b=jN13tm66xvQV+mm+Hg1jI3YRzuYGFcFstuRwStcq/3sPMxHRuk3Xr9WNQ87HhChCLWRX13DStSWJh/dqk7aNVa/7ve2O1gJG428yE+H9+RcmFSDFb3gEyPZbhtLTRZUtSDq1qWdeLpWY5y+Rd0Rq4mXaZ+LCcoNCP5EXpeT6y+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733595823; c=relaxed/simple;
	bh=6jJ9hrDq2Vko12yWvek+YEszmdvXKFWq1vKnooFBH1k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s+iHBIRPuUMnIY6PGEVF5GElBazjqnAZmGk9v2RgXfYf6P9hPSiEljDPgOK4nFSbTeLGyaZCaXQywtwzQwVKdlTo2nU77CjsV+JHUWoA1S4cXRRl6xPtpqLqpRZp6Fvdgd9cK2Y0/9yIBkd+zSnNkc8FLW03tZGPvERIfTFM4/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OSy1Nm2u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 335BFC4CECD;
	Sat,  7 Dec 2024 18:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733595823;
	bh=6jJ9hrDq2Vko12yWvek+YEszmdvXKFWq1vKnooFBH1k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OSy1Nm2ujbr2e9KnONQJ1EnuRVNUUafOUvN+eJUPuI6f/eVfYYpjXa9VB6ylyKtax
	 ckPhd0zFAWF/w6TZHI+Ho9lW8eiI/ZK8sLk4lfD+TU9q11JYUPXIcC/mWmsTJdfSs1
	 k/AmOVYVM9Lr1F9DJ1wde/xrGsRZANI+b1SabNInM8nJE7MM64VZKLrubXzfL679jH
	 jSKiD12YIx6mvwkT+XNVBhgxMjxGUqMaGiP5TaluL4OFESAhSj3oaRRU2H98G85sw0
	 Bs9fKTBNVEL/hlmC/B5OUINl2uP5y8rK/MIO96YrXcU4Tth+7cCcn+UGgBXSA72K5B
	 07ZAn/wrueDaQ==
Date: Sat, 7 Dec 2024 18:23:33 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: prabhakar.mahadev-lad.rj@bp.renesas.com, lars@metafoo.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 geert+renesas@glider.be, magnus.damm@gmail.com, mturquette@baylibre.com,
 sboyd@kernel.org, p.zabel@pengutronix.de, linux-iio@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, Claudiu Beznea
 <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH v2 03/15] iio: adc: rzg2l_adc: Use devres helpers to
 request pre-deasserted reset controls
Message-ID: <20241207182333.00a23c47@jic23-huawei>
In-Reply-To: <20241206111337.726244-4-claudiu.beznea.uj@bp.renesas.com>
References: <20241206111337.726244-1-claudiu.beznea.uj@bp.renesas.com>
	<20241206111337.726244-4-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  6 Dec 2024 13:13:25 +0200
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
> ---
> 
> Changes in v2:
> - rebased on top of patch 2/15 from this version
> - used "failed to get/deassert" failure messages
> 
>  drivers/iio/adc/rzg2l_adc.c | 37 ++++++-------------------------------
>  1 file changed, 6 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
> index 8a804f81c04b..c0c13e99aa92 100644
> --- a/drivers/iio/adc/rzg2l_adc.c
> +++ b/drivers/iio/adc/rzg2l_adc.c
> @@ -411,11 +411,6 @@ static void rzg2l_adc_pm_runtime_set_suspended(void *data)
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
> @@ -448,34 +443,14 @@ static int rzg2l_adc_probe(struct platform_device *pdev)
>  	if (IS_ERR(adc->adclk))
>  		return dev_err_probe(dev, PTR_ERR(adc->adclk), "Failed to get adclk");
>  
> -	adc->adrstn = devm_reset_control_get_exclusive(dev, "adrst-n");
> +	adc->adrstn = devm_reset_control_get_exclusive_deasserted(dev, "adrst-n");
>  	if (IS_ERR(adc->adrstn))
> -		return dev_err_probe(dev, PTR_ERR(adc->adrstn), "failed to get adrstn\n");
> -
> -	adc->presetn = devm_reset_control_get_exclusive(dev, "presetn");
> -	if (IS_ERR(adc->presetn))
> -		return dev_err_probe(dev, PTR_ERR(adc->presetn), "failed to get presetn\n");
> -
> -	ret = reset_control_deassert(adc->adrstn);
> -	if (ret)
> -		return dev_err_probe(&pdev->dev, ret, "failed to deassert adrstn pin, %d\n", ret);
> -
> -	ret = devm_add_action_or_reset(&pdev->dev,
> -				       rzg2l_adc_reset_assert, adc->adrstn);
> -	if (ret) {
Huh. Missed this in previous. These brackets shouldn't be there.
> -		return dev_err_probe(&pdev->dev, ret,
> -				     "failed to register adrstn assert devm action, %d\n", ret);
> -	}
> +		return dev_err_probe(dev, PTR_ERR(adc->adrstn), "failed to get/deassert adrst-n\n");
>  
> -	ret = reset_control_deassert(adc->presetn);
> -	if (ret)
> -		return dev_err_probe(&pdev->dev, ret, "failed to deassert presetn pin, %d\n", ret);
> -
> -	ret = devm_add_action_or_reset(&pdev->dev,
> -				       rzg2l_adc_reset_assert, adc->presetn);
> -	if (ret) {
> -		return dev_err_probe(&pdev->dev, ret,
> -				     "failed to register presetn assert devm action, %d\n", ret);
> +	adc->presetn = devm_reset_control_get_exclusive_deasserted(dev, "presetn");
> +	if (IS_ERR(adc->presetn)) {
Adding bracket here both makes limited sense and messes up the diff. I dropped them.

Jonathan

> +		return dev_err_probe(dev, PTR_ERR(adc->presetn),
> +				     "failed to get/deassert presetn\n");
>  	}
>  
>  	ret = rzg2l_adc_hw_init(adc);


