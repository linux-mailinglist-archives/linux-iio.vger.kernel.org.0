Return-Path: <linux-iio+bounces-14964-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CAD8A271D7
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 13:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2B583A12C4
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 12:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529CF20DD7B;
	Tue,  4 Feb 2025 12:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="ixySQ/IH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB51185E4A
	for <linux-iio@vger.kernel.org>; Tue,  4 Feb 2025 12:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738671945; cv=none; b=DpmcpdGIGGIuAdlmEJBrZrua+tiSsyM9zKrKYUXTrjQcdi4hb+OFqfYpI2LOCT8O8+lQce8lQA9BNfrO8I85oGHS7DW21k8FTkPi1X8VrHiyXzbplloCUJO/0oaJ2VPR8Jkek6lGvCcfDfPYwjPP+noV0zfOZ0vy2d1fdWUlPRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738671945; c=relaxed/simple;
	bh=UF8GapJmGo29AFZeeR/1BFU1zOCQJ5GoPWEKGnnavmM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P2wkgP2EUe/X80ua/QeD/1jLnGfte/OUgaD+xpYt3yeSwkxbQtOAdMJ6U34uOv1lkFnoSaOYQptQFfJ5c9/X4NXnbm/xZxzmoO6LWgK01+ukSi+3i99W4wwFdMm1LIySIj+B4WJsRpHFovax3oKeXMMvr8g5x5HiwkBD1rtWt4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=ixySQ/IH; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5d0d32cd31aso7966952a12.0
        for <linux-iio@vger.kernel.org>; Tue, 04 Feb 2025 04:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1738671941; x=1739276741; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vc6R+5OOxcNOuD/zaO6f9SUtDza8IUtwA/z2Z7xjXzA=;
        b=ixySQ/IHU4XHhEuvcXBaJWLj9S6xym1/KbE4KThmfrpW0pyVXtUefQyWJWrPPkrFW2
         v8RywWQE0kdLw5AVaMNrRWK85o1XeZi8R8fo/rZtZhzVjVOK3a0mgyyYVUns3+T3gBe7
         a8tNbeYOzEdGci4PuTVQzNckLEzzwSafZS/kQ3VhJshC2CHbwgHPzVKrDDG6j6S9lJP+
         h04o275FhWFPxN1gwJ21QKk4Cw8HnZ/PFxfHV5ToefHZNhb9dSKL374SYizu0LjVXAro
         fYAey9FFZ40uzyVOh1PReDSMz1s0Uc9+OPdx9XPCjhlif3iexF+J330VioUC63QYxYOw
         wtdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738671941; x=1739276741;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vc6R+5OOxcNOuD/zaO6f9SUtDza8IUtwA/z2Z7xjXzA=;
        b=W45lRumD7AhnKvwC4ToNXtLsfpSXxIdbjGLer6VjXHPBEpUuiIG5nqg2hH7OzSQrTq
         df/l2vizgYx+/pabhvr+P/+kqe0NRMe4aL5xsFFGv7wHsq4t/FHim2KWVQ4ISR2Ja9BW
         oAUk0STNNKLRJGdH5mgmuZf6XOm2yNp/RqwtbLDk1/NN6Shqw8jnklGzGFkb2jvw0dhX
         YBYcmXEAjmSBEfdcgUsF+qYw3TFAjOceMCB4nHyqZUOzJaSetNL8O/8WMTF6n+7tkk3M
         3yV0tnNQFNk5flkHPZwZn6UIGxbRhaEP5lTMBOr34qePSjFxXrJNjrsgtEEFtvJrXCVO
         csqg==
X-Gm-Message-State: AOJu0YxePDgM/LEFVCLC0vDDmW5RJvUjXTf+9US2qaUTRnOXF7VpOOg3
	Nk/qNI5GpsAqHjb2ICQMF7qR0B5ZhHsRNlvkbI2i2P/kGEQbn0yhQ907qLiJTmI=
X-Gm-Gg: ASbGncsmmdTYn2pfM6L1j0Bishuu/MbGGiIY7bLBlaf7aBggZ06kvb6hDEz2LQgiogk
	whgdi7sBR/s6vnOV3l2xUOdAHGBzmY4Jb72B/7O5m8NG4xdTW8bE4zGdlINTYuL+ipcE4ka0L9Y
	pmcXty8nBUwAX9RNeBKadoXB2HxpZBsq2OBYCW8oPH+yPosNCEbkoOHExsjfvQ+b8GGFobk/+FH
	a3nhQ5zmiU6zstzllg4hcDfHWZ2M0lMSEXF24qln+YPVIvdlZ2JZ3yR8YS/N+BYGBzZkZ8Htxjv
	3MfuzscPrlIDxbPalrht/myd
X-Google-Smtp-Source: AGHT+IH8oagarziM8PLmDhoL6DDR+DiVeWD1pSDTDCV03o98SK6xK1MGwh6xnR9MLRXiwKmejmc6UA==
X-Received: by 2002:a05:6402:268d:b0:5dc:740b:3cdb with SMTP id 4fb4d7f45d1cf-5dc740b3efcmr57701205a12.29.1738671940727;
        Tue, 04 Feb 2025 04:25:40 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.173])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6e4a31b37sm920440966b.143.2025.02.04.04.25.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2025 04:25:40 -0800 (PST)
Message-ID: <427572c8-72b7-41fa-b065-fcb398a30779@tuxon.dev>
Date: Tue, 4 Feb 2025 14:25:38 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] iio: adc: rzg2l_adc: Drop devm_pm_runtime_enable()
To: prabhakar.mahadev-lad.rj@bp.renesas.com, jic23@kernel.org,
 lars@metafoo.de, ulf.hansson@linaro.org
Cc: linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20250117114540.289248-1-claudiu.beznea.uj@bp.renesas.com>
 <20250117114540.289248-2-claudiu.beznea.uj@bp.renesas.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <20250117114540.289248-2-claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Jonathan,

On 17.01.2025 13:45, Claudiu wrote:
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
> Drop the devres API for runtime PM enable along with the other devres APIs
> after it (devm_request_irq(), devm_register_iio_device()).
> 
> Fixes: 89ee8174e8c8 ("iio: adc: rzg2l_adc: Simplify the runtime PM code")
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---

As of my understanding, currently there is is no conclusion from the
discussion at [1]. If it's not too early in the discussion, can you please
let me know how would you prefer to go forward for fixing this driver?

Thank you,
Claudiu

[1]
https://lore.kernel.org/all/20250103140042.1619703-2-claudiu.beznea.uj@bp.renesas.com/

