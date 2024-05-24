Return-Path: <linux-iio+bounces-5284-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DEB8CEBE1
	for <lists+linux-iio@lfdr.de>; Fri, 24 May 2024 23:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 235531F229C1
	for <lists+linux-iio@lfdr.de>; Fri, 24 May 2024 21:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA0884D0A;
	Fri, 24 May 2024 21:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jIf3eBBW"
X-Original-To: linux-iio@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFC27494;
	Fri, 24 May 2024 21:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716587100; cv=none; b=DIwCLUIrdZhIg2K7EQv24jVcubvbmA0R2sur9OYGzzFXx6ixgkwJWDZMJk8U5hld3PqrDwdNmMCNuor2gpVse0/btuqClvajL+UZrEzPdhRGxZ7WLG0eJVRcNUdQSS91usxNZbpJ1w2S58sw84IuMLc0K0U4FAZko9pfxSt2uMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716587100; c=relaxed/simple;
	bh=iIpi6Ch4M3B1vpV4Uv5PWmxbCILHTV+ZWD5Gc0J/Rto=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ValM/Gg63FEViL3wgMUXpnGNwDrAuEBty/yGeQ9p/zPkX34tQu0wApFGLXEoHiOg1OSaPH0SDE6JNLzSA1/iOzfSSB1IoFshqgIgNCOK2oXCiA1rKpC7SikjmHdPkz24dy42legJmhfNNPomPBhUnntCD53/xSv6Lhtc8zkPa9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=jIf3eBBW; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44OLi5bL059590;
	Fri, 24 May 2024 16:44:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716587045;
	bh=OaRZEYWqGOOnWQDxBFM0TF55WqnPavGwkPqJDH3YcFU=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=jIf3eBBWnuO7lLDlgALIa2nw+VR9R3vfrsjQYEHBydCz+RptAFUSUwF+s4W8mT1ew
	 M7TcJm/HTYSet1a4USrkVpXSgjhr08+Q2+d5fx+aWpGsTY/f1Ei8wPkawG+hd9Scms
	 +A8cb05YSkfpb3SULogvt1bXxpUW2NeR15zLkEWA=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44OLi5e4015119
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 24 May 2024 16:44:05 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 24
 May 2024 16:44:05 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 24 May 2024 16:44:05 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44OLi5MB093108;
	Fri, 24 May 2024 16:44:05 -0500
Message-ID: <2339db0d-db21-4372-808d-8648500e971a@ti.com>
Date: Fri, 24 May 2024 16:44:05 -0500
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
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <e6a03921-532c-4aa7-92b6-812cd9a356d6@lechnology.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 5/24/24 3:57 PM, David Lechner wrote:
> On 5/24/24 3:50 PM, David Lechner wrote:
>> On 5/23/24 6:15 PM, Judith Mendez wrote:
>>> Add new compatible ti,am62-eqep for TI K3 devices. If a device
>>> uses this compatible, require power-domains property.
>>>
>>> Since there is only one functional and interface clock for eqep,
>>> clock-names is not really required. The clock-name also changed
>>> for TI K3 SoCs so make clock-names optional for the new compatible
>>> since there is only one clock that is routed to the IP.
>>>
>>> While we are here, add an example using ti,am62-eqep compatible.
>>>
>>> Signed-off-by: Judith Mendez <jm@ti.com>
>>> ---
>>> Changes since v1:
>>> - Fix eqep binding for new compatible, require
>>>   power-domains for new compatible
>>> ---
>>>   .../devicetree/bindings/counter/ti-eqep.yaml  | 53 +++++++++++++++++--
>>>   1 file changed, 48 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/counter/ti-eqep.yaml b/Documentation/devicetree/bindings/counter/ti-eqep.yaml
>>> index 85f1ff83afe72..c4bb0231f166a 100644
>>> --- a/Documentation/devicetree/bindings/counter/ti-eqep.yaml
>>> +++ b/Documentation/devicetree/bindings/counter/ti-eqep.yaml
>>> @@ -11,7 +11,9 @@ maintainers:
>>>   
>>>   properties:
>>>     compatible:
>>> -    const: ti,am3352-eqep
>>> +    enum:
>>> +      - ti,am3352-eqep
>>> +      - ti,am62-eqep
>>>   
>>>     reg:
>>>       maxItems: 1
>>> @@ -21,19 +23,43 @@ properties:
>>>       maxItems: 1
>>>   
>>>     clocks:
>>> -    description: The clock that determines the SYSCLKOUT rate for the eQEP
>>> -      peripheral.
>>> +    description: The functional and interface clock that determines the clock
>>> +      rate for the eQEP peripheral.
>>>       maxItems: 1
>>>   
>>>     clock-names:
>>> -    const: sysclkout
>>> +    enum:
>>> +      - sysclkout
>>> +      - fck
>>> +
>>
>> If we are making this optional for ti,am62-eqep, why add a new name?
>>
>> Also, we could change the description to say that sysclockout is not a
>> great name but is required for backwards compatibility.
>>
>>> +  power-domains:
>>> +    maxItems: 1
>>> +
>>> +allOf:
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          contains:
>>> +            enum:
>>> +              - ti,am3352-eqep
>>> +    then:
>>> +      required:
>>> +        - clock-names
> 
> I just looked at the Linux driver for this and the clock name is
> not used in the driver. So we could probably just deprecate the
> clock-names property here and not make it required for
> ti,am3352-eqep (and not allowed for any new compatibles as
> suggested below).

We could do this, although I was under the impression that we should
not drop DT properties just because the linux driver isn't using it,
that is why I went with keeping clock-names around for am335x compatible
and making it optional for am62x compatible.

But if it is all the same, we could drop the the DT property.

~ Judith

> 
>>
>> What if we just add
>>
>>    else:
>>      clock-names: false
>>
>> since there is only one clock and not worry about the name?
>>
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          contains:
>>> +            enum:
>>> +              - ti,am62-eqep
>>> +    then:
>>> +      required:
>>> +        - power-domains
>>>   
>>>   required:
>>>     - compatible
>>>     - reg
>>>     - interrupts
>>>     - clocks
>>> -  - clock-names
>>>   
> 


