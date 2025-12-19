Return-Path: <linux-iio+bounces-27209-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8947CD06B1
	for <lists+linux-iio@lfdr.de>; Fri, 19 Dec 2025 15:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 98E01304621F
	for <lists+linux-iio@lfdr.de>; Fri, 19 Dec 2025 14:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3404E339710;
	Fri, 19 Dec 2025 14:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="L3Mqft++"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-m15596.qiye.163.com (mail-m15596.qiye.163.com [101.71.155.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED181FF7B3;
	Fri, 19 Dec 2025 14:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766156233; cv=none; b=iFPy0eDy/WbXBTFuj634BEoQwGiiSu+XPpRbyFQQom0/N+XFCQYsp+wMzfQAxtHc7Ut3enLJ2WoKuDBQqcWnO/PLg/pFQo/0nyHHwx/ZgoXT5nXyUO8sLz5R0hnDizi7gSr40M87oGfJoSjyORs8exkjCdxcwIPkE6P3veduSNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766156233; c=relaxed/simple;
	bh=tg2uhjnb2sKL7o1HVa8W2iAZx+MaYDiybQb1untzHz0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ExKJ4O6qdBpLXx0SqHn1WG/Wh3/EBa6eleWoz6qtW/1IFDj+efTg/q6j89kh1zcaxvIZguDPqVmgnh6gYww5Mu5iF/Q5BaQ1PqF2kddaswTFmv4mJfuOm61wgJf93rC2m4TpJfuoL9bS+Z1HEQ1jpqGRLGdBZJWg13+eoxoo2Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=L3Mqft++; arc=none smtp.client-ip=101.71.155.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2de8ecb5a;
	Fri, 19 Dec 2025 22:51:48 +0800 (GMT+08:00)
Message-ID: <1ca8f181-7784-469a-b498-622a39737e1e@rock-chips.com>
Date: Fri, 19 Dec 2025 22:51:47 +0800
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, linux-iio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 4/5] iio: adc: rockchip: Simplify with dev_err_probe
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar
 <alim.akhtar@samsung.com>, Heiko Stuebner <heiko@sntech.de>,
 Orson Zhai <orsonzhai@gmail.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>
References: <20251219-iio-dev-err-probe-v1-0-bd0fbc83c8a0@oss.qualcomm.com>
 <20251219-iio-dev-err-probe-v1-4-bd0fbc83c8a0@oss.qualcomm.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20251219-iio-dev-err-probe-v1-4-bd0fbc83c8a0@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9b371876c109cckunm523b6161c55b6
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkpLQlZISkxISh9MSUxPTUxWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=L3Mqft++QW1keeakifFX4r26Bo0K6b98n4bO3SkNmgCq8A7i7LaIGFWE33BuWDvjygTygfaTOhEhZeN8KwRErxShB2KrucqxNKw+Kd0nc3xTFXibEhJOhbcD08iJuqEY8SBejR1zFuRW/6LxVsItsK6il0sxsFTK4A2FeCidGBw=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=+dpxgpVjronVSwUPCPFj5OzYc6xfTN7Fz/RJWrifxaw=;
	h=date:mime-version:subject:message-id:from;

在 2025/12/19 星期五 22:31, Krzysztof Kozlowski 写道:
> Use dev_err_probe() to make error code handling simpler and handle
> deferred probe nicely (avoid spamming logs).
> 

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
>   drivers/iio/adc/rockchip_saradc.c | 13 +++++--------
>   1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
> index 6721da0ed7bb..263d80c5fc50 100644
> --- a/drivers/iio/adc/rockchip_saradc.c
> +++ b/drivers/iio/adc/rockchip_saradc.c
> @@ -492,10 +492,9 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
>   	 */
>   	info->reset = devm_reset_control_get_optional_exclusive(&pdev->dev,
>   								"saradc-apb");
> -	if (IS_ERR(info->reset)) {
> -		ret = PTR_ERR(info->reset);
> -		return dev_err_probe(&pdev->dev, ret, "failed to get saradc-apb\n");
> -	}
> +	if (IS_ERR(info->reset))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(info->reset),
> +				     "failed to get saradc-apb\n");
>   
>   	init_completion(&info->completion);
>   
> @@ -505,10 +504,8 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
>   
>   	ret = devm_request_irq(&pdev->dev, irq, rockchip_saradc_isr,
>   			       0, dev_name(&pdev->dev), info);
> -	if (ret < 0) {
> -		dev_err(&pdev->dev, "failed requesting irq %d\n", irq);
> -		return ret;
> -	}
> +	if (ret < 0)
> +		return dev_err_probe(&pdev->dev, ret, "failed requesting irq %d\n", irq);
>   
>   	info->vref = devm_regulator_get(&pdev->dev, "vref");
>   	if (IS_ERR(info->vref))
> 


