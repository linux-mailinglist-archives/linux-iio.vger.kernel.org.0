Return-Path: <linux-iio+bounces-6155-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F06109023BE
	for <lists+linux-iio@lfdr.de>; Mon, 10 Jun 2024 16:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B85F1F250B3
	for <lists+linux-iio@lfdr.de>; Mon, 10 Jun 2024 14:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AAF712F5BE;
	Mon, 10 Jun 2024 14:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UdLzdP7x"
X-Original-To: linux-iio@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658E956452;
	Mon, 10 Jun 2024 14:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718028721; cv=none; b=YW30TPSYvcydNR2m/nShhmWpyHzhrjWtyuKMr3qIAniEMYrC7382FYyAI0D2FyG4i5+1+YjL0M088nw9jD7X2/Zx8jBtBV31xsGGUPZfj3E+WyPNTolBiVoks3N+eoZO48URc+FFgwjhXwvYTQiSoE9y9TyDVK1Od8LpcvmeL40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718028721; c=relaxed/simple;
	bh=HR+lksdyc5JYfCfjZIT+yqIKvZpO1Qoxls2Zl7YzbDE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HTvQ4wHEeUdbFRZ+U8DLh0AYHf06MTo7XFnrv/94CfyGgJQ0Lytyebw7yf6kYLNBDqZIkTQ7XUjvj6gSSEH7GrQavh4VX9El5hdq1HupOOlqZcfyswcsGDI79XEnjJSNbgcgzQoHIG+oMJBqPjb3mE+s5BazVrM3t+AlQ0fNGZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=UdLzdP7x; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45AEBsI6127506;
	Mon, 10 Jun 2024 09:11:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718028714;
	bh=V/x3U3X0mcaP5gaC2fbscMMkAEeKf/QY7Cd2x5DBz6k=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=UdLzdP7xMufku7MfzPk0J556NgUtQpPk/tD6ZJF+PaaCXsFwa2DY7PrWQlgLo6jH2
	 NbM8yJVtNj9T/m07/oljuI7V5uIe6X8NY5xvVq03CIR8cH8Zoia1efShGrriz00oOM
	 6u3eoQrQDDuEv/0SiigEqKUnQDO3o/PG5VsVFR7M=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45AEBsbc095560
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 10 Jun 2024 09:11:54 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 10
 Jun 2024 09:11:53 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 10 Jun 2024 09:11:54 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45AEBsKl065670;
	Mon, 10 Jun 2024 09:11:54 -0500
Message-ID: <573a01e0-0954-4238-b5d6-3bb2b30ecace@ti.com>
Date: Mon, 10 Jun 2024 09:11:54 -0500
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
 <c08d2d51-e2e1-4b68-a4fb-ebf3a919c1b8@ti.com>
 <e1c7bc9f-3ecd-446f-a6a2-f97d6a8aa78d@baylibre.com>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <e1c7bc9f-3ecd-446f-a6a2-f97d6a8aa78d@baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi David,

On 6/10/24 8:53 AM, David Lechner wrote:
> On 6/10/24 8:44 AM, Judith Mendez wrote:
>> Hi David,
>>
>> On 6/9/24 3:27 PM, David Lechner wrote:
>>> The TI eQEP clock is both a functional and interface clock. Since it is
>>> required for the device to function, we should be enabling it at probe.
>>>
>>> Up to now, we've just been lucky that the clock was enabled by something
>>> else on the system already.
>>>
>>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>>> ---
>>>    drivers/counter/ti-eqep.c | 6 ++++++
>>>    1 file changed, 6 insertions(+)
>>>
>>> diff --git a/drivers/counter/ti-eqep.c b/drivers/counter/ti-eqep.c
>>> index 072b11fd6b32..825ae22c3ebc 100644
>>> --- a/drivers/counter/ti-eqep.c
>>> +++ b/drivers/counter/ti-eqep.c
>>> @@ -6,6 +6,7 @@
>>>     */
>>>      #include <linux/bitops.h>
>>> +#include <linux/clk.h>
>>>    #include <linux/counter.h>
>>>    #include <linux/kernel.h>
>>>    #include <linux/mod_devicetable.h>
>>> @@ -376,6 +377,7 @@ static int ti_eqep_probe(struct platform_device *pdev)
>>>        struct counter_device *counter;
>>>        struct ti_eqep_cnt *priv;
>>>        void __iomem *base;
>>> +    struct clk *clk;
>>>        int err;
>>>          counter = devm_counter_alloc(dev, sizeof(*priv));
>>> @@ -415,6 +417,10 @@ static int ti_eqep_probe(struct platform_device *pdev)
>>>        pm_runtime_enable(dev);
>>>        pm_runtime_get_sync(dev);
>>>    +    clk = devm_clk_get_enabled(dev, NULL);
>>> +    if (IS_ERR(clk))
>>
>> I think it would be nice to have print here in case the we fail to get
>> the clock.
> 
> Do you mean that we should call devm_clk_get() and clk_prepare_enable()
> separately so that we get two different error messages?
> 
> The dev_err_probe() below will already print a message on any error
> (other that EPROBE_DEFER).

Apologies, I misread. The way you have it is good, thanks.

Reviewed-by: Judith Mendez <jm@ti.com>

> 
>>
>> ~ Judith
>>
>>> +        return dev_err_probe(dev, PTR_ERR(clk), "failed to enable clock\n");
>>> +
>>>        err = counter_add(counter);
>>>        if (err < 0) {
>>>            pm_runtime_put_sync(dev);
>>>
>>> ---
>>> base-commit: bb3f1c5fc434b0b177449f7f73ea9b112b397dd1
>>> change-id: 20240609-ti-eqep-enable-clock-91697095ca81
>>
> 


