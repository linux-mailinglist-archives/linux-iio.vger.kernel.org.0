Return-Path: <linux-iio+bounces-9214-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B4C96E2FF
	for <lists+linux-iio@lfdr.de>; Thu,  5 Sep 2024 21:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8318D288A06
	for <lists+linux-iio@lfdr.de>; Thu,  5 Sep 2024 19:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2BB318D655;
	Thu,  5 Sep 2024 19:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Zw+VJ3zR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330B6189509
	for <linux-iio@vger.kernel.org>; Thu,  5 Sep 2024 19:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725563964; cv=none; b=jh0HHAZxerZtU7LYqCwYxnMP39QTZGNyTRZuviHtfzneYmnqmWmO51W2WCfPwJjbqqPpy3657g3zg5qJvutVfz19w+2Z77pjSM/4/sN1RhwdrSTXG1V7bJ6zdAsBXGuiR0qHLSnqQnzaDeUuxuWchUDSNCRznz3sVbIsSg5v/4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725563964; c=relaxed/simple;
	bh=XkIZG7ovIrbjuw3op4BVEREfqbUEEO14cCEXB6FApTU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gNNYpqdlv6hgbZVRKFPlk97tDBv21MLPUkT5tp3UdgutO1fn1zt7KBQzuog3nGsw7Yxx5GKYs9ZQEmYMcLBPCd8bQeSqQNHNfBgELGZLpGw0yxwpNHWkwZ6oI7kzvavC9b4mWEzzDfctucQIvs8CbiqJAwMNlfR2973n8NTD748=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Zw+VJ3zR; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3df1e26de08so689231b6e.3
        for <linux-iio@vger.kernel.org>; Thu, 05 Sep 2024 12:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725563960; x=1726168760; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DKI175OvUgk2/hVEXHdZ/ZCtyuF+3PlpxqWpXuSByso=;
        b=Zw+VJ3zRfIE1utls28rYHZ8OB9VMjPKiRDPvhVGMpJLacej/xEprkhx7Tm0na3BcJp
         TM4W0YTmWbm9Q27aX+V8kpQi7dDfPWEHlHxuBzFNh+vK60CDd2000QZd9ITWEA8KvHW6
         9ANAA1C1Lq75my1g60zojt5RyknYv3w4x+VmeZJ2aDxH8zEHdPruomi0mVHhpq6t98L2
         m0PcKKJvUYlfmsXjRxiX72V6fu9paDPAy4uGVhV9bxq1/r1jPlHforKVUAShfuYebAbY
         mBq2Sjtu6RAFQreAeQ9r2yPemgCCPtMq+XxDvCispe+wMihPPSw1qP6PUKNFHmkNV3Jd
         hT3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725563960; x=1726168760;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DKI175OvUgk2/hVEXHdZ/ZCtyuF+3PlpxqWpXuSByso=;
        b=n5gGbe/SNVmOKbEhoBQqGEJJErYTRUjkLVotqS61sxtYl/vaycjyobdDZ7b5pyPscd
         Jyjzc+rYUcnKXb0mg5CQ4AJREyrhJM6Klsih9F5FHTIls+0Y8BNhvDOrddrDb8pQDj+b
         WVHKAgjonDy4liys2NqgYWCzexgg8MMl6izHhs7tLn2msdwnxJhlnsVH3QdmnW6dY48F
         9iaDsXWTtmcOEXdCELHZJMczU7KWwHHI1dzkLhXPFQKl48BbFZh22/HTum3mkbsXmqwJ
         BOSG5H98HOmAcM0/klIyw92q8JHev/wstnXB7pQZIb1wyfPXLiJRkB01je4LYkIiNMxk
         cbVA==
X-Gm-Message-State: AOJu0Yxkjf8YaJX49/EAFBr5Dkg2Jmx2WjnxQEYAZqlrN6cJGbH5/kyN
	yjIocJHfeME9+eIFBd4IVLZ8ciPvquU47R5GnXEt1n9LxupqiYIbAFh1nDBOwDg=
X-Google-Smtp-Source: AGHT+IFqFdkvkFKkfaD7b8Xx4D7Lpe8EI0i2NfBtPzhi06qyf8Nobt4f4horoUF8GOfQ8LSac3fhsA==
X-Received: by 2002:a05:6808:1705:b0:3db:15a9:4a1f with SMTP id 5614622812f47-3df05eb021fmr26126208b6e.49.1725563960297;
        Thu, 05 Sep 2024 12:19:20 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3df1188612fsm3335300b6e.58.2024.09.05.12.19.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2024 12:19:19 -0700 (PDT)
Message-ID: <7bd162bb-dce8-4aff-9f56-1ab73b091a28@baylibre.com>
Date: Thu, 5 Sep 2024 14:19:19 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/9] iio: backend adi-axi-dac: add registering of child
 fdt node
To: Angelo Dureghello <adureghello@baylibre.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-0-87d669674c00@baylibre.com>
 <20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-4-87d669674c00@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-4-87d669674c00@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/5/24 10:17 AM, Angelo Dureghello wrote:
> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Change to obtain the fdt use case as reported in the
> adi,ad3552r.yaml file in this patchset, with the DAC device that
> is actually using the backend set as a child node of the backend.
> 
> To obtain this, registering all the child fdt nodes as platform
> devices.
> 
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> Co-developed-by: David Lechner <dlechner@baylibre.com>
> Co-developed-by: Nuno Sá <nuno.sa@analog.com>
> ---
>  drivers/iio/dac/adi-axi-dac.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.c
> index cc31e1dcd1df..e883cd557b6a 100644
> --- a/drivers/iio/dac/adi-axi-dac.c
> +++ b/drivers/iio/dac/adi-axi-dac.c
> @@ -783,6 +783,7 @@ static int axi_dac_probe(struct platform_device *pdev)
>  {
>  	struct axi_dac_state *st;
>  	const struct axi_dac_info *info;
> +	struct platform_device *child_pdev;
>  	void __iomem *base;
>  	unsigned int ver;
>  	struct clk *clk;
> @@ -862,6 +863,20 @@ static int axi_dac_probe(struct platform_device *pdev)
>  		return dev_err_probe(&pdev->dev, ret,
>  				     "failed to register iio backend\n");
>  
> +	device_for_each_child_node_scoped(&pdev->dev, child) {

This should use fwnode_for_each_available_child_node() so that it skips
nodes with status != "okay".

Would be nice to introduce a scoped version of this function too.

Also, if we are allowing multiple devices on the bus, the DT bindings
need to have a reg property that is unique for each child.

> +		struct platform_device_info pi;
> +
> +		memset(&pi, 0, sizeof(pi));

struct platform_device_info pi = { };

avoids the need for memset().

> +
> +		pi.name = fwnode_get_name(child);
> +		pi.id = PLATFORM_DEVID_AUTO;
> +		pi.fwnode = child;

Need to have pi.parent = &pdev->dev;

It could also make sense to have all of the primary bus functions
(reg read/write, ddr enable/disable, etc.) passed here as platform
data instead of having everything go through the IIO backend.

> +
> +		child_pdev = platform_device_register_full(&pi);
> +		if (IS_ERR(child_pdev))
> +			return PTR_ERR(child_pdev);

These devices need to be unregistered on any error return and when
the parent device is removed.

> +	}
> +
>  	dev_info(&pdev->dev, "AXI DAC IP core (%d.%.2d.%c) probed\n",
>  		 ADI_AXI_PCORE_VER_MAJOR(ver),
>  		 ADI_AXI_PCORE_VER_MINOR(ver),
> 


