Return-Path: <linux-iio+bounces-5511-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A67C8D4F23
	for <lists+linux-iio@lfdr.de>; Thu, 30 May 2024 17:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16DEF286D54
	for <lists+linux-iio@lfdr.de>; Thu, 30 May 2024 15:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C01182D0C;
	Thu, 30 May 2024 15:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Bc3mevJp"
X-Original-To: linux-iio@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C247D187562;
	Thu, 30 May 2024 15:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717083146; cv=none; b=LJd7tfxkcFuLB/gUKnZECG0RLTVMixUjZz26iHKalX6qh1bNW4KBqdHy4zRDGf6MNBl+RbVbP5bzAshxhaV3GhGYasMSrWnO1yKa/NIPrj2Z/q639ShO79CqdnbFNMBZIpFHrH0+unRyJka4+xbByEwSwkLJdRu6ttzH2Q/b3Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717083146; c=relaxed/simple;
	bh=xU78c35cySFprEs0gAWdyzNuzHJJhmMy0Bc5xuRB+/4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=g7xEV6uQ391hqoURnNFkpzldNCPM8nvy2dNincREMCC81hkzsBPRiUux0FNr3LoUdIEWMP5CZU1d0nToFwRki1WfpaqGYxE/IDttsPT0Zg3KSZDk3FZwP4NP8KUDMk+3gmDv03CKMN+l0vEAbqsvow0gBhs0MgaK1+3UGvoyyqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Bc3mevJp; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44UFVLIh035363;
	Thu, 30 May 2024 10:31:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717083081;
	bh=U5EUOfv2mrP9qldUr1bHrOoxb/sZHG7SQL8d6HDZlBM=;
	h=Date:Subject:From:To:CC:References:In-Reply-To;
	b=Bc3mevJpy/5QCSBtAJAItZ+EAWKAFR+p10nDu9Yjm0hgqb4/HqwsZICaYOIuCfHkv
	 VWdyrEX9HmqjFMoVWO4duSieEA3QLxdQZJOs+X6H+KtL04oYsNc8ZEpEZJnTtj2rRr
	 6P1+a5t6BYIsZ87OeD16WBxyP9v9RWQXBXWbaNwk=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44UFVLYm010838
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 30 May 2024 10:31:21 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 30
 May 2024 10:31:20 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 30 May 2024 10:31:20 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44UFVK6Q118224;
	Thu, 30 May 2024 10:31:20 -0500
Message-ID: <223d9482-ede8-4f58-b11a-d82f2556c26b@ti.com>
Date: Thu, 30 May 2024 10:31:20 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/8] arm64: defconfig: Enable TI eQEP Driver
From: Judith Mendez <jm@ti.com>
To: Nishanth Menon <nm@ti.com>, <devicetree@vger.kernel.org>
CC: Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        David Lechner
	<david@lechnology.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, Vignesh
 Raghavendra <vigneshr@ti.com>
References: <20240523231516.545085-1-jm@ti.com>
 <20240523231516.545085-9-jm@ti.com>
 <20240524055923.zyfthiwcsbwbjg5k@undecided>
 <ddcab8c0-3772-4134-a3bb-27729e864627@ti.com>
Content-Language: en-US
In-Reply-To: <ddcab8c0-3772-4134-a3bb-27729e864627@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Nishanth,

On 5/24/24 9:13 AM, Judith Mendez wrote:
> Hi Nishanth,
> 
> On 5/24/24 12:59 AM, Nishanth Menon wrote:
>> On 18:15-20240523, Judith Mendez wrote:
>>> TI K3 SoC's support eQEP hardware, so enable TI eQEP driver
>>> to be built as a module.
>>
>> All the nodes seem to be only in disabled mode, is there even a single
>> board that is actually using this? if so, why isn't it enabled?
> 
> I will add pinmux and enable in the board level dts file.

Question about the above... If I enable eQEP at the board level,
there will be pinmux conflicts. So, I could:
1. Leave eQEP disabled
2. Enable eQEP and disable main_uart1 at the board level dts file
3. Enable eQEP in an overlay and also disable main_uart1

Let me know which option works for you.

~ Judith

> 
>>
>>>
>>> Signed-off-by: Judith Mendez <jm@ti.com>
>>> ---
>>> Changes since v1:
>>> - No change
>>> ---
>>>   arch/arm64/configs/defconfig | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
>>> index 2c30d617e1802..23d11a1b20195 100644
>>> --- a/arch/arm64/configs/defconfig
>>> +++ b/arch/arm64/configs/defconfig
>>> @@ -1593,6 +1593,7 @@ CONFIG_INTERCONNECT_QCOM_SM8550=y
>>>   CONFIG_INTERCONNECT_QCOM_SM8650=y
>>>   CONFIG_INTERCONNECT_QCOM_X1E80100=y
>>>   CONFIG_COUNTER=m
>>> +CONFIG_TI_EQEP=m
>>>   CONFIG_RZ_MTU3_CNT=m
>>>   CONFIG_HTE=y
>>>   CONFIG_HTE_TEGRA194=y
>>> -- 
>>> 2.45.1
>>>
>>
> 
> 


