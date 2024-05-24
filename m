Return-Path: <linux-iio+bounces-5282-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EA78CEBD3
	for <lists+linux-iio@lfdr.de>; Fri, 24 May 2024 23:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8853B1F21FD5
	for <lists+linux-iio@lfdr.de>; Fri, 24 May 2024 21:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B6B4642B;
	Fri, 24 May 2024 21:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wNlifsgj"
X-Original-To: linux-iio@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3D17494;
	Fri, 24 May 2024 21:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716586289; cv=none; b=IyIsPO45J0YgNla3JVMEN8rAlz2N1yU5YEdsDXugY8vse5pcOfSqMkWMcxUo53KLuJEF9/SXHJ0+my0MXny9CLTsicmBdxqIj2OQaSgpUGV5y12WpFHdp194f85oUeYbEW5LqO07V8OeM++Dcfsu4BzyS56R1UZ8+KRKwc0zZME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716586289; c=relaxed/simple;
	bh=iRsfZhHHk71N/q9aE51lLLyvA9UPU40D5vl1+FqnZ9s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KnCbVv1qfs2h48cYdTEts+BN+Pb6Z/93k5WnULL4rtFdsp209DayHqpFk7JTV5gHa4dyfkqYLKylpZ3StdlCCGm4SWD0KHfRLw3CRosLZlHTcEX34dKKWi58gHzlv8x9lAje8cLWYkY+E+Zdz961UqZ9uu8n1KePKfh8GzfIYFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=wNlifsgj; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44OLUXdN074423;
	Fri, 24 May 2024 16:30:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716586233;
	bh=D2pCSFcs7g2kozusYYwZ2vVwg6i86RchvcpGVG5lRMA=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=wNlifsgj8VBfqBup3/kAVMgUQeXAI00abMy0LNki1nv1BurZ8nlJI7fPpd3rmu1yv
	 miYMiGVATO4OgwapDHnGpVtfU8urBkAXgb5uhV3+TCraxd55QvQuKiuXkP0sqP6ubt
	 K0aopZY4CFAP0P4ux+s2+ltl59zY4CKJRvWOfKA0=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44OLUWSp007969
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 24 May 2024 16:30:32 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 24
 May 2024 16:30:32 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 24 May 2024 16:30:32 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44OLUWcn076348;
	Fri, 24 May 2024 16:30:32 -0500
Message-ID: <57e4f7b1-2955-4dd5-b9d9-f3b1f27aab75@ti.com>
Date: Fri, 24 May 2024 16:30:32 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] dt-bindings: counter: Add new ti,am62-eqep
 compatible
To: Conor Dooley <conor@kernel.org>
CC: Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        David Lechner
	<david@lechnology.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>, Vignesh Raghavendra
	<vigneshr@ti.com>
References: <20240523231516.545085-1-jm@ti.com>
 <20240523231516.545085-3-jm@ti.com>
 <20240524-wrecker-busybody-2c082b87ddef@spud>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <20240524-wrecker-busybody-2c082b87ddef@spud>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 5/24/24 1:38 PM, Conor Dooley wrote:
> On Thu, May 23, 2024 at 06:15:10PM -0500, Judith Mendez wrote:
>> Add new compatible ti,am62-eqep for TI K3 devices. If a device
>> uses this compatible, require power-domains property.
>>
>> Since there is only one functional and interface clock for eqep,
>> clock-names is not really required. The clock-name also changed
>> for TI K3 SoCs so make clock-names optional for the new compatible
>> since there is only one clock that is routed to the IP.
> 
> Really the clock should be named after the function it has in the IP
> block - it looks like "sysoutclk" is more likely the name of the clock
> routed to the IP rather than the role it has?

It is the name of the clock, though id like to keep sysclkout for
backwards compatibility, even though the name is confusing.
~ Judith


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
> 
> I'm going to ack this even though the driver makes it seem like the
> devices are compatible (there's no match data etc) given the addition of
> the power domain and changes in required properties.
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> 
> Cheers,
> Conor.
> 


