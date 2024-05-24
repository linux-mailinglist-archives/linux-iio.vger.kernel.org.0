Return-Path: <linux-iio+bounces-5283-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C8FE8CEBD8
	for <lists+linux-iio@lfdr.de>; Fri, 24 May 2024 23:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E3B31C21BB3
	for <lists+linux-iio@lfdr.de>; Fri, 24 May 2024 21:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7162B82487;
	Fri, 24 May 2024 21:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ORvcqXpC"
X-Original-To: linux-iio@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E41D7494;
	Fri, 24 May 2024 21:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716586454; cv=none; b=jhoEjFoiR4By0GaemcXdqZrkPjjeLGKhf/6E5FXHcbG1g5OC78Q5RiMcrN5Div50z36eKQDykCAcmnaHNlDN/Wvb4gVesZGyaxfgMDGo9aqaBnDw8JCRA/XPnKLXnWQQfENxSuYQWW3EFN9t3GPyMzUjv/Oudpwxb2E7/fUBzyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716586454; c=relaxed/simple;
	bh=l+VQrpFRNc7+TdUwO3FMDbaqqwUSEBvD/mZPzJ+2JV8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DRklqPEQ5+dp4Nxrm52/uvLZIH/cTAQFL9lybgnVGzrrawFE9ejnaTPQNrDV86CQuhxb4YCbtatMzbleUNlXmM7IbFayuHJLYiVUslZNqp2hNXHJujerioJIM3L099WAO/DzkrDnUL+9X/qbxxTU+wrobtTQpaIOScV3T/BFX2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ORvcqXpC; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44OLXLmI074714;
	Fri, 24 May 2024 16:33:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716586402;
	bh=1kkNmkqxllZ3zCa7BVvoRScSljb1MlWuM7LHHhSw1Xo=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=ORvcqXpCnRpXLs8AgRe+IDku0DcgdMt+cqa5I+Ry/5iCBisKRGBwmF7q/cGfCoK/h
	 nNya9BU1FddHXSrPgIo3xbrteD0Z5V0rQdZy0R6SOhBpwLQtq8+34riI2WYo4e4sLS
	 Pgz27vnfHijUzEiitpbCFavGPzYK1+p75xcicZp8=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44OLXLbZ038831
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 24 May 2024 16:33:21 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 24
 May 2024 16:33:21 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 24 May 2024 16:33:21 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44OLXLpT080430;
	Fri, 24 May 2024 16:33:21 -0500
Message-ID: <d0abda4f-2e8c-49ff-bdeb-63fb5e969e84@ti.com>
Date: Fri, 24 May 2024 16:33:21 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] dt-bindings: counter: Add new ti,am62-eqep
 compatible
To: David Lechner <david@lechnology.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon
	<will@kernel.org>,
        William Breathitt Gray <william.gray@linaro.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        Nishanth Menon
	<nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
References: <20240523231516.545085-1-jm@ti.com>
 <20240523231516.545085-3-jm@ti.com>
 <2956d10b-d2cf-4019-adc8-d8053e435767@lechnology.com>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <2956d10b-d2cf-4019-adc8-d8053e435767@lechnology.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 5/24/24 3:50 PM, David Lechner wrote:
> On 5/23/24 6:15 PM, Judith Mendez wrote:
>> Add new compatible ti,am62-eqep for TI K3 devices. If a device
>> uses this compatible, require power-domains property.
>>
>> Since there is only one functional and interface clock for eqep,
>> clock-names is not really required. The clock-name also changed
>> for TI K3 SoCs so make clock-names optional for the new compatible
>> since there is only one clock that is routed to the IP.
>>
>> While we are here, add an example using ti,am62-eqep compatible.
>>
>> Signed-off-by: Judith Mendez <jm@ti.com>
>> ---
>> Changes since v1:
>> - Fix eqep binding for new compatible, require
>>   power-domains for new compatible
>> ---
>>   .../devicetree/bindings/counter/ti-eqep.yaml  | 53 +++++++++++++++++--
>>   1 file changed, 48 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/counter/ti-eqep.yaml b/Documentation/devicetree/bindings/counter/ti-eqep.yaml
>> index 85f1ff83afe72..c4bb0231f166a 100644
>> --- a/Documentation/devicetree/bindings/counter/ti-eqep.yaml
>> +++ b/Documentation/devicetree/bindings/counter/ti-eqep.yaml
>> @@ -11,7 +11,9 @@ maintainers:
>>   
>>   properties:
>>     compatible:
>> -    const: ti,am3352-eqep
>> +    enum:
>> +      - ti,am3352-eqep
>> +      - ti,am62-eqep
>>   
>>     reg:
>>       maxItems: 1
>> @@ -21,19 +23,43 @@ properties:
>>       maxItems: 1
>>   
>>     clocks:
>> -    description: The clock that determines the SYSCLKOUT rate for the eQEP
>> -      peripheral.
>> +    description: The functional and interface clock that determines the clock
>> +      rate for the eQEP peripheral.
>>       maxItems: 1
>>   
>>     clock-names:
>> -    const: sysclkout
>> +    enum:
>> +      - sysclkout
>> +      - fck
>> +
> 
> If we are making this optional for ti,am62-eqep, why add a new name?
> 
> Also, we could change the description to say that sysclockout is not a
> great name but is required for backwards compatibility.

This is fine with me. Will update for v3.

> 
>> +  power-domains:
>> +    maxItems: 1
>> +
>> +allOf:
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - ti,am3352-eqep
>> +    then:
>> +      required:
>> +        - clock-names
> 
> What if we just add
> 
>    else:
>      clock-names: false
> 
> since there is only one clock and not worry about the name?


Yes, can do, thanks.

> 
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - ti,am62-eqep
>> +    then:
>> +      required:
>> +        - power-domains
>>   
>>   required:
>>     - compatible
>>     - reg
>>     - interrupts
>>     - clocks
>> -  - clock-names
>>   


