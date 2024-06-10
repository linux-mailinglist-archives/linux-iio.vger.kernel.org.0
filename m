Return-Path: <linux-iio+bounces-6151-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F14DD90231E
	for <lists+linux-iio@lfdr.de>; Mon, 10 Jun 2024 15:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED7841C222C2
	for <lists+linux-iio@lfdr.de>; Mon, 10 Jun 2024 13:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005C7157E74;
	Mon, 10 Jun 2024 13:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Z7NC400z"
X-Original-To: linux-iio@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A04157A49;
	Mon, 10 Jun 2024 13:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718027055; cv=none; b=qp88rAj7KRZEI3yj0WMJLiwtnWqpTH0jcFWf4bxcrYqB1RNi186adkbaJNNGhgkTbd+Kd2zKXfb/npBWlunL4F+Xluo/WokZqmKjYEE+ml+fqlTIi5a2UcpF51TjKNtDzzhrOrPWaob4P62Do8l5O4iN8fwMrVwkKaiGnvJ8Tl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718027055; c=relaxed/simple;
	bh=6whD5BlfPkc/QXVawZYc6zaMAcHZDXkfeq80yqWQhFI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EDtvC97M9ijiwUMvPqzrgzf0m4KBBeCzcsVHjZv8cTeCbcyR0mdlO24aDIA9wDtue0hEz8SdI1LTB9cG5/hhheWjp4pbDgNGbOq5gJQhwLzjOW+uTa2m10EhKkIRso/COqcLWzWIJ3fdJzK8FjaWs6olW9K714KzpMYvK4zd3eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Z7NC400z; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45ADi9xj027827;
	Mon, 10 Jun 2024 08:44:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718027049;
	bh=vXTNQpYiFCEGscRvW5gsaNUTZPm4hZbQ7RlNRX5SwOg=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=Z7NC400zQSneRRg3jYzLhE0gmiJObRspKLkJWwL++nI8k/PI1g/+c/gGpYkDkRaMz
	 Wchxe/byMX/ktu2fvO+bzsnlj33JnQRGuBTPMc5wotjoDlB7iRz6x0aThj0HH5jZei
	 4vApvXwmgO+iPhI0fXhu4rYLp4LLBGdzHnEMkyFM=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45ADi97k030826
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 10 Jun 2024 08:44:09 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 10
 Jun 2024 08:44:08 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 10 Jun 2024 08:44:08 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45ADi8T7018764;
	Mon, 10 Jun 2024 08:44:08 -0500
Message-ID: <c08d2d51-e2e1-4b68-a4fb-ebf3a919c1b8@ti.com>
Date: Mon, 10 Jun 2024 08:44:08 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] counter: ti-eqep: enable clock at probe
To: David Lechner <dlechner@baylibre.com>,
        William Breathitt Gray
	<wbg@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240609-ti-eqep-enable-clock-v1-1-1e9e7626467e@baylibre.com>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <20240609-ti-eqep-enable-clock-v1-1-1e9e7626467e@baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi David,

On 6/9/24 3:27 PM, David Lechner wrote:
> The TI eQEP clock is both a functional and interface clock. Since it is
> required for the device to function, we should be enabling it at probe.
> 
> Up to now, we've just been lucky that the clock was enabled by something
> else on the system already.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>   drivers/counter/ti-eqep.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/counter/ti-eqep.c b/drivers/counter/ti-eqep.c
> index 072b11fd6b32..825ae22c3ebc 100644
> --- a/drivers/counter/ti-eqep.c
> +++ b/drivers/counter/ti-eqep.c
> @@ -6,6 +6,7 @@
>    */
>   
>   #include <linux/bitops.h>
> +#include <linux/clk.h>
>   #include <linux/counter.h>
>   #include <linux/kernel.h>
>   #include <linux/mod_devicetable.h>
> @@ -376,6 +377,7 @@ static int ti_eqep_probe(struct platform_device *pdev)
>   	struct counter_device *counter;
>   	struct ti_eqep_cnt *priv;
>   	void __iomem *base;
> +	struct clk *clk;
>   	int err;
>   
>   	counter = devm_counter_alloc(dev, sizeof(*priv));
> @@ -415,6 +417,10 @@ static int ti_eqep_probe(struct platform_device *pdev)
>   	pm_runtime_enable(dev);
>   	pm_runtime_get_sync(dev);
>   
> +	clk = devm_clk_get_enabled(dev, NULL);
> +	if (IS_ERR(clk))

I think it would be nice to have print here in case the we fail to get
the clock.

~ Judith

> +		return dev_err_probe(dev, PTR_ERR(clk), "failed to enable clock\n");
> +
>   	err = counter_add(counter);
>   	if (err < 0) {
>   		pm_runtime_put_sync(dev);
> 
> ---
> base-commit: bb3f1c5fc434b0b177449f7f73ea9b112b397dd1
> change-id: 20240609-ti-eqep-enable-clock-91697095ca81


