Return-Path: <linux-iio+bounces-16319-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE682A4D77B
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 10:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A98CA188AA38
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 09:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21527202C46;
	Tue,  4 Mar 2025 08:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="AL2XNqTy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48681FDE2B
	for <linux-iio@vger.kernel.org>; Tue,  4 Mar 2025 08:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741078744; cv=none; b=N5Uf0lfRe/VgAnoSElviIRfm9qg9JUwMaWG26b9DPYpfS/T8YC7vAfDUeSFs301Z7FGDUxCa2KNp8b2ssHcP+BNATCex2U+d0PeB3ar/HEL1vuscy+B1heLl5bdQK6ACSJBF8mWBHpYB2Uql4lY98B4u/luq8me9OL+mggaczkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741078744; c=relaxed/simple;
	bh=HSILkVA5vBIiizFYSmaF6BrUL10+HFIpOlfWfW+K+44=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cT2Bjzr27uy6E3tXKRxrEY2QQM9wcFTHrI7OUt7ik1dIHJFDF4MhqLeQ3LQVKmevpOW7w9EE4FWoNjl/ieTFe1KfyflNeoor83Kx/GU5Da4TXj4TRw+tO/Zw2egMrnhYdQwbF2FWppC13GhE0GwBKA5mAL7/3XCYCAm890KPeao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=AL2XNqTy; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-390edaee0cfso2889797f8f.2
        for <linux-iio@vger.kernel.org>; Tue, 04 Mar 2025 00:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1741078741; x=1741683541; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fqP3ahwggB+Ec4UF+o8yzis0/YWb9Mn4LNCx06esETg=;
        b=AL2XNqTyEqpvqxJdMsPnVcHHbnptPqPa9Ld/TXA+le0iKCLZTThVFE5yuMkmeDcczl
         8XTMBCUyTZntsyDvCWirv4W8jue2pixtWs8150XqBO9yi4LSrYhlr9j922DInlFc0Nvl
         ovQkwG+pZNMCrXZ1dB/g9MqunpzFIheLJUKnWRGIKEiLTgHiBZMJB5qMiT9HTqs4PM2k
         qLvIwDDu/TfvtGGIu2+6ic4glNE4wCrVedYkiYMVdD99cmyjCejc+gFdWraHY2x+1onw
         XUsfQ7Dd5OGyljUR+oI/X7XeG4vwxrfz+MOsLhMwp2ZViW1UWH68nLiMx2O88aSpx6Zw
         wP+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741078741; x=1741683541;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fqP3ahwggB+Ec4UF+o8yzis0/YWb9Mn4LNCx06esETg=;
        b=iQV2cQ2vxxcDPbNZTePcnlRI17Xz3QgCXJIc0DiCTDWOs9z+i+C4cCUQ57rZo7mCfv
         LaG14o7j0cfZKqXbbdFZz7VqH3TC6GwCwmOHDIhHSCPMxeGmNaJbel5wrbvWdh5PyasX
         K2HpKKccD1ltvV3aJtDKbSzzjNa8VGSfFxwLXAPXa2GtVwtIFfHVIHqIHQ05A5N9d8t5
         kgsWJyAIH7VT7T0F3E2AWlGVrXgFdcPZuJr2zAhsMjzOD7/AQt9JgWWRBZuq2I160VQE
         qekmbs7/REatqjQl0p/oa87y3oasJXIatRcEKjJIYpJqGCEV37IMEGou5V/HElGDocWm
         XreQ==
X-Gm-Message-State: AOJu0YxLGS8/jplByOzJJ/qZoUcewWOXXJnX4zGUShCaOZADo4oDM2Lm
	t/oc1OVb9FMvzcaWF15l0K7N1yux9R2Zl/+TsuE9tZNppffNg2H8YcaEB0LSfH8=
X-Gm-Gg: ASbGnctDxSBf0x2UIMftoVHNi5oLZR5MP+jufTCBM2eb+EIaKS56Xeeo1uHy33G/qKL
	8mShk3V6o/zKOHe7Dqcc3XqAVeH9b4hJWlnwow0JLIEnsM8HIqTmLnwHyaWswPRfHv9prDJtfwA
	/I9G+FXWtor1J5Tumnm3SPml57dWj3eiJTod9PRV9GLR5cStL1hEHwelRB2PUbNVy0tsnhPkfzj
	wYyZVRWPXocGmONNlcB3+hOS2ZViX1M7k3C3SlfXoi0NuIn/bqyUoEYUcjchqyGEDPv/g0Tf6SX
	QYV8uBxQMMhZJnLs+0tgg0T8OLtGmDUNihn7VXp2u+btej8SSR9i2g==
X-Google-Smtp-Source: AGHT+IEEccYK+D24g35rR7y+28h/qCLlvYXo70nHWkcjc7tufX7M7+n3T60EL+5hB1uyjzyEXD8y5g==
X-Received: by 2002:a5d:6d0e:0:b0:390:ff25:79c8 with SMTP id ffacd0b85a97d-390ff257cccmr7156094f8f.20.1741078740828;
        Tue, 04 Mar 2025 00:59:00 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e479608fsm17236647f8f.14.2025.03.04.00.58.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 00:59:00 -0800 (PST)
Message-ID: <1100c663-362a-433c-9c70-8435807b29ac@tuxon.dev>
Date: Tue, 4 Mar 2025 10:58:59 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] iio: adc: rzg2l_adc: Open a devres group
To: prabhakar.mahadev-lad.rj@bp.renesas.com, jic23@kernel.org, lars@metafoo.de
Cc: linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20250224120608.1769039-1-claudiu.beznea.uj@bp.renesas.com>
 <20250224120608.1769039-2-claudiu.beznea.uj@bp.renesas.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <20250224120608.1769039-2-claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Jonathan,

On 24.02.2025 14:06, Claudiu wrote:
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
> Open a devres group in the driver probe and release it in the driver
> remove. This ensures the runtime PM is disabled (though the devres group)
> after the rzg2l_adc_remove() finishes its execution avoiding the described
> scenario.

Can you please let me know if you consider this approach acceptable?

Thank you,
Claudiu

