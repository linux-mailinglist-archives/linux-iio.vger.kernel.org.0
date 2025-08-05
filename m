Return-Path: <linux-iio+bounces-22317-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F23B1B9D9
	for <lists+linux-iio@lfdr.de>; Tue,  5 Aug 2025 20:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD20C189A65B
	for <lists+linux-iio@lfdr.de>; Tue,  5 Aug 2025 18:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BF82951D0;
	Tue,  5 Aug 2025 18:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VQX76VEs"
X-Original-To: linux-iio@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B67B1D416C;
	Tue,  5 Aug 2025 18:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754417434; cv=none; b=Cf48356qKKpOSqbgDSHZ1D9C1pdd9sxVg5gRa8iucQak6VecJcyGyUMKZiAflzeEZlLOa/1ukLlNT9Eq5+dytjMbbaWDn5OSCenGktcXteTMcHUU61QdwRBjFX5K2wSQD1IzwVaQOGu+kTkPgUh1xGXMXrW48Pss1d/g799/HNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754417434; c=relaxed/simple;
	bh=sa/3JAiyq8ZL8E8FmlxXoRlvOIA5cIslWUue21dg6sM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ls/OMGnIdwDt5pwmelmQFzh9+gs3fvLkv7D0GxVcnHl2f12YHbISHmMbuEHPgaRxI5htRMfbZTLxjTyjKVRyHanX+AznSa2hp40A8kj7CcO1HQBeZFu2RZS0awYSJzcMOGl/tS69d/75ce9OwbMRj+LL8ygRmPa6jFtHoJM+XpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=VQX76VEs; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 575IACYW339823;
	Tue, 5 Aug 2025 13:10:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1754417412;
	bh=MOcH7Tn7FRepfCA9WMf5Cox4+wmbp3ABsQWFgUyfQTA=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=VQX76VEsNx6p7wJTJxDsZRM1lUHY+MgM8T7ce01KveW078EDY89Vd8CXaAr1jlFDN
	 cBkC2e+cDCoQiRxmNh/nhx6OoUDIde+mBh9oqh/pngsPsS/Lmb0tQUzWRdCNsUyvaq
	 h7gPomLg45OIsbmOJu55s4ApRG9Ra+iOv02zVKms=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 575IAB2i3762105
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 5 Aug 2025 13:10:11 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 5
 Aug 2025 13:10:11 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 5 Aug 2025 13:10:11 -0500
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 575IAB5U2554228;
	Tue, 5 Aug 2025 13:10:11 -0500
Message-ID: <e0670467-65cb-441b-b14d-9775609ced8b@ti.com>
Date: Tue, 5 Aug 2025 13:10:11 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] counter: ti-ecap-capture: Remove error print for
 devm_add_action_or_reset()
To: Waqar Hameed <waqar.hameed@axis.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Julien Panis <jpanis@baylibre.com>,
        William Breathitt Gray
	<wbg@kernel.org>
CC: <kernel@axis.com>, <linux-iio@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <pndms8em7tf.a.out@axis.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <pndms8em7tf.a.out@axis.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 8/5/25 4:33 AM, Waqar Hameed wrote:
> When `devm_add_action_or_reset()` fails, it is due to a failed memory
> allocation and will thus return `-ENOMEM`. `dev_err_probe()` doesn't do
> anything when error is `-ENOMEM`. Therefore, remove the useless call to
> `dev_err_probe()` when `devm_add_action_or_reset()` fails, and just
> return the value instead.
> 
> Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
> ---
> Changes in v2:
> 
> * Split the patch to one seperate patch for each sub-system.
> 
> Link to v1: https://lore.kernel.org/all/pnd7c0s6ji2.fsf@axis.com/
> 
>   drivers/counter/ti-ecap-capture.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/counter/ti-ecap-capture.c b/drivers/counter/ti-ecap-capture.c
> index 3faaf7f60539..114f2d33f193 100644
> --- a/drivers/counter/ti-ecap-capture.c
> +++ b/drivers/counter/ti-ecap-capture.c
> @@ -528,7 +528,7 @@ static int ecap_cnt_probe(struct platform_device *pdev)
>   	/* Register a cleanup callback to care for disabling PM */
>   	ret = devm_add_action_or_reset(dev, ecap_cnt_pm_disable, dev);

Now that we have devm_pm_runtime_enable(), you can just turn the pm_enable()
call 3 lines above this into that, and not need this manual devm action at all.

Andrew

>   	if (ret)
> -		return dev_err_probe(dev, ret, "failed to add pm disable action\n");
> +		return ret;
>   
>   	ret = devm_counter_add(dev, counter_dev);
>   	if (ret)
> 
> base-commit: 260f6f4fda93c8485c8037865c941b42b9cba5d2


