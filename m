Return-Path: <linux-iio+bounces-14377-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F339A1274A
	for <lists+linux-iio@lfdr.de>; Wed, 15 Jan 2025 16:23:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F6CE188449B
	for <lists+linux-iio@lfdr.de>; Wed, 15 Jan 2025 15:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640B214AD2B;
	Wed, 15 Jan 2025 15:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="onDMpf90"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1518812EBDB
	for <linux-iio@vger.kernel.org>; Wed, 15 Jan 2025 15:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736954626; cv=none; b=OZnFtqFt+vIiGEcCQO9AXQ4SIsCKMfZVmdAspj7O01JJXNxszUBRZglXOQQx+GphfYjWOAloY1eDaOVoe8oMqSsRmqkjTQRSfvTpwEceNBPxoMuwKJcbWwoarDmwJ1OCYbBHR2H0nh2XWvKgtiz4bBRl5+arjBLomCQSsvB68+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736954626; c=relaxed/simple;
	bh=NvcZZ2zTPdRnzTy1wIG0+X6AL7u7YBv+mw450nAFKVs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZzU2z2L9x6FK3mQfA0uHY8wLkOr0y9OMHZbDAVmbUZKcwhmF4hCeGzt/EfJjHYRP7b00yFWV+Kjx4orq2lO4eyoj5WIpAGx5pHed57JXUdHq3H1HoHmS/zxfniWvrn03j7ntRlFNutkwRCCOISOOjztbxbIcxrtXN/dVVwnwYRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=onDMpf90; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e3a0acba5feso9276937276.2
        for <linux-iio@vger.kernel.org>; Wed, 15 Jan 2025 07:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736954623; x=1737559423; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GvPjzMEd2JAiCdYoWPMvuemLPTserXKwtGTKO+pdseA=;
        b=onDMpf90SHURclFPIXr7EI4CpABLNHHXlBEayPdPX1CzOyAvvY/ALGYbchk1R8j/3A
         VJOik+ZkAV5JF4oRjLsMq3PHLGe9swOYU2ZLqyxG02DGkZ6z7xFxIUofgSDZYRecFpaA
         ohe29qfc9UlyIP/fAVl6tq+zIK7XILgUusfkCAUoN23rH+wPGgIecPWA46p6z/0fyqAl
         DGWmdZQz/m6QiN4Camp8ndB+ZD+s/+9C6lqo9upWc8QPOckp2WBw6fzE/k9pvO/Hllaz
         aIdqTOPv+Zp6awF0+nogqimtMf6T8UL9xeX+D2dkbWFEwtYdYFOjWYvvfXzg4X7bpyo5
         UzlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736954623; x=1737559423;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GvPjzMEd2JAiCdYoWPMvuemLPTserXKwtGTKO+pdseA=;
        b=LXoEX0Py9XMN2p7YgwJ3OrS7vWId6IaJZQq5qIuat6ZQpGUKjYbVdgi8qiwIEENh8W
         NKYy2EX9HVfScBq5IOCJlmm7zvIFH5o4kDfB6WBt7cbhdoS3YFlelDsa7wgPrhSuT4H+
         n36HYYRL0GOTWzAlFJBDlkk9RplS5/z4ybZoAm6LLoVOtaL+5+8ANsa2x9SMugbbNnMF
         Ozcp4gYNQwNQ0ENe8H4ZC46j0oByHWL/qBPQn5MUe5bCqoDDOtSJ5cWTY2VGk0/IbU+k
         stuegMw33fzo5SkI04aA5Kzr93vE4o3jqTAnQxMo9jW/eSeq0ytJfwq1u+3mGLqr4mpz
         C+ZA==
X-Forwarded-Encrypted: i=1; AJvYcCU8pgKKfxzWVklKS0AoRe7ugTdj8o124MERW3kTzGwiNqPBp0EEs85dZ+btGhJ+5i0C5+ZJKfEzxSA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyrh+gSnIr8nL4EJXWFiu0R+Wj1BX9F+xQLmVuCJOgd6EcTki0I
	a0VyLwwdme8DTvlfSJTliqSGC2tGIevUvdbZM4hjJcgfaaOAO3E81yukINL1UHMM4NHS1b1ti48
	e4tiDfwJrnGYdiQCzLcOzOVxMBtEeX0+afVpoiQ==
X-Gm-Gg: ASbGncttUEwBEc0hUQ2jvT83BtO3WRanbJshMvnp02BFHKAsLukCJQTcGd8dUG21vuo
	sQMWX+NWK4chtU7V2VOHZaAUcXQonmtlWZA1uJ8g=
X-Google-Smtp-Source: AGHT+IHq+VY8fZyKxdGTe872mx4tKi0ZEDJpXCYICXahxO4ZSjiC2jQqcpc20X7o5FT7xpkj9s+0h39mC43cl38+Ifw=
X-Received: by 2002:a05:690c:4b8d:b0:6ef:77e3:efe6 with SMTP id
 00721157ae682-6f5312271bfmr249233087b3.13.1736954622894; Wed, 15 Jan 2025
 07:23:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250103140042.1619703-1-claudiu.beznea.uj@bp.renesas.com> <20250103140042.1619703-2-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20250103140042.1619703-2-claudiu.beznea.uj@bp.renesas.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 15 Jan 2025 16:23:07 +0100
X-Gm-Features: AbW1kva1mpx2eO_g_VipjhHlhUP2OCmEGx0ZzSGNH_0fp6wSWNAWBa93buB8DJI
Message-ID: <CAPDyKFoZq_Xtr3XB+tiRUhyUAqp-3O9gZB8ywcvWg2pk8wp4-g@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: adc: rzg2l_adc: Drop devm_pm_runtime_enable()
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: prabhakar.mahadev-lad.rj@bp.renesas.com, jic23@kernel.org, lars@metafoo.de, 
	linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 3 Jan 2025 at 15:00, Claudiu <claudiu.beznea@tuxon.dev> wrote:
>
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> On all systems where the rzg2l_adc driver is used, the ADC clocks are part
> of a PM domain. The code that implements the PM domains support is in
> drivers/clk/renesas/rzg2l-cpg.c, the functions of interest for this commit
> being rzg2l_cpg_attach_dev() and rzg2l_cpg_deattach_dev(). The PM
> domains support is registered with GENPD_FLAG_PM_CLK which, according to
> the documentation, instructs genpd to use the PM clk framework while
> powering on/off attached devices.
>
> During probe, the ADC device is attached to the PM domain
> controlling the ADC clocks. Similarly, during removal, the ADC device is
> detached from the PM domain.
>
> The detachment call stack is as follows:
>
> device_driver_detach() ->
>   device_release_driver_internal() ->
>     __device_release_driver() ->
>       device_remove() ->
>         platform_remove() ->
>           dev_pm_domain_detach()
>
> During driver unbind, after the ADC device is detached from its PM domain,
> the device_unbind_cleanup() function is called, which subsequently invokes
> devres_release_all(). This function handles devres resource cleanup.
>
> If runtime PM is enabled via devm_pm_runtime_enable(), the cleanup process
> triggers the action or reset function for disabling runtime PM. This
> function is pm_runtime_disable_action(), which leads to the following call
> stack of interest when called:
>
> pm_runtime_disable_action() ->
>   pm_runtime_dont_use_autosuspend() ->
>     __pm_runtime_use_autosuspend() ->
>       update_autosuspend() ->
>         rpm_idle()
>
> The rpm_idle() function attempts to runtime resume the ADC device. However,
> at the point it is called, the ADC device is no longer part of the PM
> domain (which manages the ADC clocks). Since the rzg2l_adc runtime PM
> APIs directly modifies hardware registers, the
> rzg2l_adc_pm_runtime_resume() function is invoked without the ADC clocks
> being enabled. This is because the PM domain no longer resumes along with
> the ADC device. As a result, this leads to system aborts.
>
> Drop the devres API for runtime PM enable.
>
> Fixes: 89ee8174e8c8 ("iio: adc: rzg2l_adc: Simplify the runtime PM code")
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/iio/adc/rzg2l_adc.c | 33 ++++++++++++++++++++++++---------
>  1 file changed, 24 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
> index 883c167c0670..f12f3daf08cc 100644
> --- a/drivers/iio/adc/rzg2l_adc.c
> +++ b/drivers/iio/adc/rzg2l_adc.c
> @@ -464,25 +464,26 @@ static int rzg2l_adc_probe(struct platform_device *pdev)
>
>         pm_runtime_set_autosuspend_delay(dev, 300);
>         pm_runtime_use_autosuspend(dev);
> -       ret = devm_pm_runtime_enable(dev);
> -       if (ret)
> -               return ret;
> +       pm_runtime_enable(dev);
>
>         platform_set_drvdata(pdev, indio_dev);
>
>         ret = rzg2l_adc_hw_init(dev, adc);
> -       if (ret)
> -               return dev_err_probe(&pdev->dev, ret,
> -                                    "failed to initialize ADC HW\n");
> +       if (ret) {
> +               dev_err_probe(&pdev->dev, ret, "failed to initialize ADC HW\n");
> +               goto rpm_disable;
> +       }
>
>         irq = platform_get_irq(pdev, 0);
> -       if (irq < 0)
> -               return irq;
> +       if (irq < 0) {
> +               ret = irq;
> +               goto rpm_disable;
> +       }
>
>         ret = devm_request_irq(dev, irq, rzg2l_adc_isr,
>                                0, dev_name(dev), adc);
>         if (ret < 0)
> -               return ret;
> +               goto rpm_disable;
>
>         init_completion(&adc->completion);
>
> @@ -493,6 +494,19 @@ static int rzg2l_adc_probe(struct platform_device *pdev)
>         indio_dev->num_channels = adc->data->num_channels;
>
>         return devm_iio_device_register(dev, indio_dev);
> +
> +rpm_disable:
> +       pm_runtime_disable(dev);
> +       pm_runtime_dont_use_autosuspend(dev);
> +       return ret;
> +}
> +
> +static void rzg2l_adc_remove(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
> +
> +       pm_runtime_disable(dev);
> +       pm_runtime_dont_use_autosuspend(dev);
>  }
>
>  static const struct rzg2l_adc_hw_params rzg2l_hw_params = {
> @@ -614,6 +628,7 @@ static const struct dev_pm_ops rzg2l_adc_pm_ops = {
>
>  static struct platform_driver rzg2l_adc_driver = {
>         .probe          = rzg2l_adc_probe,
> +       .remove         = rzg2l_adc_remove,
>         .driver         = {
>                 .name           = DRIVER_NAME,
>                 .of_match_table = rzg2l_adc_match,
> --
> 2.43.0
>

