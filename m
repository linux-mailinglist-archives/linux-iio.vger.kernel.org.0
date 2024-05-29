Return-Path: <linux-iio+bounces-5468-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B878D3EA2
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 20:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E04CF286F88
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 18:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE761C2312;
	Wed, 29 May 2024 18:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nWmzA2l1"
X-Original-To: linux-iio@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD131C0DEE;
	Wed, 29 May 2024 18:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717008934; cv=none; b=U+XXSOK3eb8EnLV0BF+kEoDH1RjoqSsyBRkpW4gNAeEYYJKczMfi6Ra/iTX1lD534zPI4k6w7h+PwUT7QqmGG11Y0PX5frISrMWRqLi8cv8br8X+7zvQfB++evMf19LjhV+V8UMK7JaProfdpJvqK+/mI5HBzd/UxRGpHThcPrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717008934; c=relaxed/simple;
	bh=U4Rsy2pPhz/359g6Rk4fJeQdhXCIaeRtqzSU/shOa0Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pWUCb7za2ys2xQb8HhCxCZKOw0yEl+YPX1LnSrhQAaAejeeLqiC80L8qyibFzI0Pghyv6T0E+vv5OfSYBBdR/Y0+fygG5IDSuz5lj9Nk8xnFX7hUfHqTX2059qzP2UIDfnBr6r5bMz4hfHoJ8Hh7iPJhUvf/+FPJRuvvjrtqw+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=nWmzA2l1; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44TIsZuq101155;
	Wed, 29 May 2024 13:54:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717008875;
	bh=9EEbQ1P0bS7o94PZeSQIGVykCCKi5H729feXlk6MNGI=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=nWmzA2l1edBES7eoreuhEJ0nVh+lzRPIJrE9aeQ63a4Ero/cIcjJ2rtRZaU/0MBAy
	 41HrlIVyqkzB30zAqQ2Znee1eYUuKh0Dn/L8Lgrij/5BZGoCZahHzs7UrmjOubVPUd
	 5YULvNhERV0fBGYaMADcCoJMa/vj3gx1i3WMYa6M=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44TIsY3j019806
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 29 May 2024 13:54:34 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 29
 May 2024 13:54:34 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 29 May 2024 13:54:34 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44TIsYDc007851;
	Wed, 29 May 2024 13:54:34 -0500
Message-ID: <10c57c70-5e12-4baf-b986-d060858949ce@ti.com>
Date: Wed, 29 May 2024 13:54:34 -0500
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
 <e6a03921-532c-4aa7-92b6-812cd9a356d6@lechnology.com>
 <2339db0d-db21-4372-808d-8648500e971a@ti.com>
 <55a21233-918f-4cf4-800c-3e0eee0cd467@lechnology.com>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <55a21233-918f-4cf4-800c-3e0eee0cd467@lechnology.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi David,

On 5/25/24 12:49 PM, David Lechner wrote:
> On 5/24/24 4:44 PM, Judith Mendez wrote:
>> On 5/24/24 3:57 PM, David Lechner wrote:
>>> On 5/24/24 3:50 PM, David Lechner wrote:
>>>> On 5/23/24 6:15 PM, Judith Mendez wrote:
>>>>> Add new compatible ti,am62-eqep for TI K3 devices. If a device
>>>>> uses this compatible, require power-domains property.
>>>>>
>>>>> Since there is only one functional and interface clock for eqep,
>>>>> clock-names is not really required. The clock-name also changed
>>>>> for TI K3 SoCs so make clock-names optional for the new compatible
>>>>> since there is only one clock that is routed to the IP.
>>>>>
>>>>> While we are here, add an example using ti,am62-eqep compatible.
>>>>>
>>>>> Signed-off-by: Judith Mendez <jm@ti.com>
>>>>> ---
>>>>> Changes since v1:
>>>>> - Fix eqep binding for new compatible, require
>>>>>    power-domains for new compatible
>>>>> ---
>>>>>    .../devicetree/bindings/counter/ti-eqep.yaml  | 53 +++++++++++++++++--
>>>>>    1 file changed, 48 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/counter/ti-eqep.yaml b/Documentation/devicetree/bindings/counter/ti-eqep.yaml
>>>>> index 85f1ff83afe72..c4bb0231f166a 100644
>>>>> --- a/Documentation/devicetree/bindings/counter/ti-eqep.yaml
>>>>> +++ b/Documentation/devicetree/bindings/counter/ti-eqep.yaml
>>>>> @@ -11,7 +11,9 @@ maintainers:
>>>>>      properties:
>>>>>      compatible:
>>>>> -    const: ti,am3352-eqep
>>>>> +    enum:
>>>>> +      - ti,am3352-eqep
>>>>> +      - ti,am62-eqep
>>>>>        reg:
>>>>>        maxItems: 1
>>>>> @@ -21,19 +23,43 @@ properties:
>>>>>        maxItems: 1
>>>>>        clocks:
>>>>> -    description: The clock that determines the SYSCLKOUT rate for the eQEP
>>>>> -      peripheral.
>>>>> +    description: The functional and interface clock that determines the clock
>>>>> +      rate for the eQEP peripheral.
>>>>>        maxItems: 1
>>>>>        clock-names:
>>>>> -    const: sysclkout
>>>>> +    enum:
>>>>> +      - sysclkout
>>>>> +      - fck
>>>>> +
>>>>
>>>> If we are making this optional for ti,am62-eqep, why add a new name?
>>>>
>>>> Also, we could change the description to say that sysclockout is not a
>>>> great name but is required for backwards compatibility.
>>>>
>>>>> +  power-domains:
>>>>> +    maxItems: 1
>>>>> +
>>>>> +allOf:
>>>>> +  - if:
>>>>> +      properties:
>>>>> +        compatible:
>>>>> +          contains:
>>>>> +            enum:
>>>>> +              - ti,am3352-eqep
>>>>> +    then:
>>>>> +      required:
>>>>> +        - clock-names
>>>
>>> I just looked at the Linux driver for this and the clock name is
>>> not used in the driver. So we could probably just deprecate the
>>> clock-names property here and not make it required for
>>> ti,am3352-eqep (and not allowed for any new compatibles as
>>> suggested below).
>>
>> We could do this, although I was under the impression that we should
>> not drop DT properties just because the linux driver isn't using it,
>> that is why I went with keeping clock-names around for am335x compatible
>> and making it optional for am62x compatible.
>>
>> But if it is all the same, we could drop the the DT property.
>>
>> ~ Judith
>>
> 
> I wasn't suggesting to remove clock-names from the bindings, just
> deprecate that property in this binding and not use it with any
> new compatibles.
> 
> In the AM62x technical reference manual, it looks like it calls
> the functional and interface clock FICLK rather than FCK. So
> I'm just suggesting maybe it just easier to not give it a name
> rather than try to get the right name? No name will work with
> any future SoCs as well. :-)

Understood, so I will make clock-names optional for ti,am3352-eqep
compatible and not allowed for ti,am62-eqep compatible.

Thanks for your feedback (:

~ Judith
> 


