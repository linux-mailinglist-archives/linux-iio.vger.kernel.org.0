Return-Path: <linux-iio+bounces-22403-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F051FB1D987
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 15:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E77277AF137
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 13:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDBDF262FC1;
	Thu,  7 Aug 2025 13:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="C65Wv9YT"
X-Original-To: linux-iio@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0AA25D202;
	Thu,  7 Aug 2025 13:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754575001; cv=none; b=te5O9DAB7Za7GgA4ZQafmRkzladDZF+E0KheR41Vr1p9A/fp2gPm7d9lWGdhI54m5WhcVO0G5lID+ynlAUfUTj1b41eWX9mjH9CLGRtAnL2cJMtCKbuBjTKZ6hlEcpc9Jb70G5X8+hJhpHFwHLBrytAmhjXaNTUeW6QYhRbzQ7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754575001; c=relaxed/simple;
	bh=nT1zpSk6rGTxrru50YWAuKTr7MNceIHgrdP5v0fkZXQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=toET1yhtoeSqXYymrxdRvNqXbMC36XxoDaBv4cnpbWgBkePqsTQf4lfUoCL8lzV1IAwucYL+oPZpZZgCauJcuQw9bqja2ZSp6IZvXT7CQ/YATfbDqQctsuwFJE9+R2m0+7YXXI9Ti79REyzQovMPA8Rbb9YU5pzktI1zfb14mnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=C65Wv9YT; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 577DuTkD762015;
	Thu, 7 Aug 2025 08:56:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1754574989;
	bh=FMfZdYvWcj7ok+cOE4Q9MRpiB9xW2uWoiOdsYz0zI0w=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=C65Wv9YTl2fRaQKg2EksFl51HXGVR8c3bPnJ0HYJIwKOgPH535CGfMcN5saroH6ov
	 D+QVUZyydtE7iOnvrueejTr1xkv5eHCNcgxgk6pWp0P08b72Ss7O4tGJV2v9nEviJn
	 zqhZidxaT82xriM8Zlv8dkeFRqc2tvuJqF6N4lj0=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 577DuTcg923289
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 7 Aug 2025 08:56:29 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 7
 Aug 2025 08:56:28 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 7 Aug 2025 08:56:28 -0500
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 577DuSRL1410842;
	Thu, 7 Aug 2025 08:56:28 -0500
Message-ID: <c3277f21-14c4-40ca-9d48-a0aeecb54fb8@ti.com>
Date: Thu, 7 Aug 2025 08:56:28 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] counter: ti-ecap-capture: Use devm_pm_runtime_enable()
To: Waqar Hameed <waqar.hameed@axis.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Julien Panis <jpanis@baylibre.com>,
        William Breathitt Gray
	<wbg@kernel.org>
CC: <kernel@axis.com>, <linux-iio@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <pnda54bjmij.a.out@axis.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <pnda54bjmij.a.out@axis.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 8/7/25 8:21 AM, Waqar Hameed wrote:
> There is no need to register a manual `devm` action for
> `pm_runtime_disable()` when `devm_pm_runtime_enable()` exists. It does
> the same thing (but also calls `pm_runtime_dont_use_autosuspend()`,
> which should be fine here).
> 
> Moreover, when `devm_add_action_or_reset()` fails, it is due to a failed
> memory allocation and will thus return `-ENOMEM`. `dev_err_probe()`
> doesn't do anything when error is `-ENOMEM`. Therefore, the call to
> `dev_err_probe()` is useless. Note that `devm_pm_runtime_enable()` has a
> tail call to `devm_add_action_or_reset()` and thus returns that value.
> Therefore, replace `dev_err_probe()` with the returning value.
> 
> Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
> ---

Acked-by: Andrew Davis <afd@ti.com>

> Changes in v3:
> 
> * Remove the manual `devm_add_action_or_reset()` and use
>    `devm_pm_runtime_enable()` instead.
>    
> Link to v2: https://lore.kernel.org/lkml/pndms8em7tf.a.out@axis.com/
> 
> Changes in v2:
> 
> * Split the patch to one seperate patch for each sub-system.
> 
> Link to v1: https://lore.kernel.org/all/pnd7c0s6ji2.fsf@axis.com/
> 
> drivers/counter/ti-ecap-capture.c | 12 ++----------
>   1 file changed, 2 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/counter/ti-ecap-capture.c b/drivers/counter/ti-ecap-capture.c
> index 3faaf7f60539..3586a7ab9887 100644
> --- a/drivers/counter/ti-ecap-capture.c
> +++ b/drivers/counter/ti-ecap-capture.c
> @@ -465,11 +465,6 @@ static irqreturn_t ecap_cnt_isr(int irq, void *dev_id)
>   	return IRQ_HANDLED;
>   }
>   
> -static void ecap_cnt_pm_disable(void *dev)
> -{
> -	pm_runtime_disable(dev);
> -}
> -
>   static int ecap_cnt_probe(struct platform_device *pdev)
>   {
>   	struct device *dev = &pdev->dev;
> @@ -523,12 +518,9 @@ static int ecap_cnt_probe(struct platform_device *pdev)
>   
>   	platform_set_drvdata(pdev, counter_dev);
>   
> -	pm_runtime_enable(dev);
> -
> -	/* Register a cleanup callback to care for disabling PM */
> -	ret = devm_add_action_or_reset(dev, ecap_cnt_pm_disable, dev);
> +	ret = devm_pm_runtime_enable(dev);
>   	if (ret)
> -		return dev_err_probe(dev, ret, "failed to add pm disable action\n");
> +		return ret;
>   
>   	ret = devm_counter_add(dev, counter_dev);
>   	if (ret)
> 
> base-commit: 260f6f4fda93c8485c8037865c941b42b9cba5d2


