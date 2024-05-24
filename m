Return-Path: <linux-iio+bounces-5278-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F1838CEB92
	for <lists+linux-iio@lfdr.de>; Fri, 24 May 2024 22:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35D4A28208F
	for <lists+linux-iio@lfdr.de>; Fri, 24 May 2024 20:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C9B83A12;
	Fri, 24 May 2024 20:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="c7iiMxL5"
X-Original-To: linux-iio@vger.kernel.org
Received: from vern.gendns.com (vern.gendns.com [98.142.107.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8EC7442A;
	Fri, 24 May 2024 20:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=98.142.107.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716584238; cv=none; b=Ke3GTL5hAglecUaiuyX+ZUrHFBErlBm9eUByQsnlY3WCmc4gB6gbx+B0JWwCYs5wVdmuVfgIjEYJ9VHLRi5LQEalGODZhTB2o+XznHnwDFnItbB9JZo85Dx3VvqHxS0L9S8QHuN6c8n/2IwthNXJM3pRySpy1rH1J8V61W2B7JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716584238; c=relaxed/simple;
	bh=Y46nXxlcFgBHM6KViWljK/mrz7E2aT075oMJjZi2WQY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=IFrsovovEZpa+esb/wLBQ7WzNDzazy6K3F1GEpCjCUZz3NVmEhq+wYTAu+0M40tYsBOoAt15QYUQaQDcxHcqizH6/+dFoz00HGyF+WLQLKtUJ/JSMVcLfaGh41b4s6Lx/TJAS0X1jzrg0BhU+uGDMPv3ELl/PYam9lS6JljMzmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com; spf=pass smtp.mailfrom=lechnology.com; dkim=pass (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b=c7iiMxL5; arc=none smtp.client-ip=98.142.107.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lechnology.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=t2DOCJNyKvOfcOpBuODL8F4YyXgFuY85iOz3SlWrWOg=; b=c7iiMxL55RaSq6FjgjofpJVK3J
	ZqhA0nDpMj8SZvzTPrYxvac9owiaU9xPm7Q4Bu+HrVOkkmFo6xUPSTlhUMvXcNJ2mhH22pqj6y/jD
	jtBamNqpPA1XbB86PvUY+ZIrSPWsSQECJb6pHFHR3weU9iwDQzlqhr9ZI7EOoH5B4/Lvx4/exiIka
	2i5CPKXcbgwGeY0XeBOPLlxd5sT9suJxQGxb2RJ6xMVlx4++97XqtWH57Q6ygTtyUo0nJkiJikyi1
	zf++IMt2P+lFttamkwDY/1hrAGYoXgNSx67EiJob0XkhgPC9leogG7JS9s+Ps6xAPoeQptP4Pwzy1
	q3c3QdWQ==;
Received: from ip98-183-112-25.ok.ok.cox.net ([98.183.112.25]:42048 helo=[192.168.0.142])
	by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <david@lechnology.com>)
	id 1sAc1o-0004Bn-1a;
	Fri, 24 May 2024 16:57:13 -0400
Message-ID: <e6a03921-532c-4aa7-92b6-812cd9a356d6@lechnology.com>
Date: Fri, 24 May 2024 15:57:11 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] dt-bindings: counter: Add new ti,am62-eqep
 compatible
From: David Lechner <david@lechnology.com>
To: Judith Mendez <jm@ti.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 William Breathitt Gray <william.gray@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
References: <20240523231516.545085-1-jm@ti.com>
 <20240523231516.545085-3-jm@ti.com>
 <2956d10b-d2cf-4019-adc8-d8053e435767@lechnology.com>
Content-Language: en-US
Autocrypt: addr=david@lechnology.com; keydata=
 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
In-Reply-To: <2956d10b-d2cf-4019-adc8-d8053e435767@lechnology.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

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
>>  power-domains for new compatible
>> ---
>>  .../devicetree/bindings/counter/ti-eqep.yaml  | 53 +++++++++++++++++--
>>  1 file changed, 48 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/counter/ti-eqep.yaml b/Documentation/devicetree/bindings/counter/ti-eqep.yaml
>> index 85f1ff83afe72..c4bb0231f166a 100644
>> --- a/Documentation/devicetree/bindings/counter/ti-eqep.yaml
>> +++ b/Documentation/devicetree/bindings/counter/ti-eqep.yaml
>> @@ -11,7 +11,9 @@ maintainers:
>>  
>>  properties:
>>    compatible:
>> -    const: ti,am3352-eqep
>> +    enum:
>> +      - ti,am3352-eqep
>> +      - ti,am62-eqep
>>  
>>    reg:
>>      maxItems: 1
>> @@ -21,19 +23,43 @@ properties:
>>      maxItems: 1
>>  
>>    clocks:
>> -    description: The clock that determines the SYSCLKOUT rate for the eQEP
>> -      peripheral.
>> +    description: The functional and interface clock that determines the clock
>> +      rate for the eQEP peripheral.
>>      maxItems: 1
>>  
>>    clock-names:
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

I just looked at the Linux driver for this and the clock name is
not used in the driver. So we could probably just deprecate the
clock-names property here and not make it required for
ti,am3352-eqep (and not allowed for any new compatibles as
suggested below).

> 
> What if we just add
> 
>   else:
>     clock-names: false
> 
> since there is only one clock and not worry about the name?
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
>>  required:
>>    - compatible
>>    - reg
>>    - interrupts
>>    - clocks
>> -  - clock-names
>>  


