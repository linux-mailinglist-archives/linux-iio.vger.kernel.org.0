Return-Path: <linux-iio+bounces-5305-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E00858CF092
	for <lists+linux-iio@lfdr.de>; Sat, 25 May 2024 19:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 963A828224B
	for <lists+linux-iio@lfdr.de>; Sat, 25 May 2024 17:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A690126F2A;
	Sat, 25 May 2024 17:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="myOu/3SO"
X-Original-To: linux-iio@vger.kernel.org
Received: from vern.gendns.com (vern.gendns.com [98.142.107.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B6185934;
	Sat, 25 May 2024 17:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=98.142.107.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716659379; cv=none; b=K6xqPM7XBBCocsScrPa87yTCuR9a8dO7MU0mYNgTFHcpdhbbCW+wZSU7BCgeExyljihLU5QRWlsk8nS0BAxlPaySaTnLVvU9nHHNtEvICRAgMpZaDjkCvjSKRxuoS2ouAGx3FvsYgWAkPuzD3TH+IZ8cxcn0llXG9HNtamldmC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716659379; c=relaxed/simple;
	bh=RTlmd/o/bipWECdNpn03GqDf2Pj6GMMSx0MrlIDxkMg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qRwScgN2J6v/HSuH/hE6wexh3PLm+vcMiDs5mlAlRSrYOi3G0l9OQF0c8N2XVBwu3zidmHidtI6z2DY7aygNgs2skXVOh4RF2w+himRHqWo38hc3SMUVTC6YB8OtODE1ndUl+E2khyi71i3OBOBCTUnqQgq58/mo6c3po60FNhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com; spf=pass smtp.mailfrom=lechnology.com; dkim=pass (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b=myOu/3SO; arc=none smtp.client-ip=98.142.107.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lechnology.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=aboNR2B1zz5ySO8RWF0J/IIQS7AHGi1ebTyHSeYH+98=; b=myOu/3SOyXESqukrxqmYP8MeoH
	hqGmTV0phTXHEOyHEjNbYxFMBupA8BQe3YPeBQXrYEjUgF2uDCpdCHPYhjBW6C2icjDMdR70cCd6D
	Tu9zxwg0ADJb6epDCIa9/BIqCQht9mTeaqbrQVxfmzz8ZkNMYbxnYFNnyCMNpAOuZAsXTqrCvHkLM
	w3vYXgVCBnLtqF4unioQZbD/fdiY1Bv0rmaJ77lgOsewxs9mcUs9CeMA+wW91OEGZCNAqZosGR8BX
	oz8Afz/yCoYkqN99GEkkhTyUut/QC4j1VcKgJq1BKHWHFygNlWiWWCLxS+eU1vMhAlFNv2A0GSPQS
	4N8TDWOQ==;
Received: from ip98-183-112-25.ok.ok.cox.net ([98.183.112.25]:45978 helo=[192.168.0.142])
	by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <david@lechnology.com>)
	id 1sAvZz-000143-1I;
	Sat, 25 May 2024 13:49:34 -0400
Message-ID: <55a21233-918f-4cf4-800c-3e0eee0cd467@lechnology.com>
Date: Sat, 25 May 2024 12:49:31 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] dt-bindings: counter: Add new ti,am62-eqep
 compatible
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
 <e6a03921-532c-4aa7-92b6-812cd9a356d6@lechnology.com>
 <2339db0d-db21-4372-808d-8648500e971a@ti.com>
Content-Language: en-US
From: David Lechner <david@lechnology.com>
Autocrypt: addr=david@lechnology.com; keydata=
 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
In-Reply-To: <2339db0d-db21-4372-808d-8648500e971a@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

On 5/24/24 4:44 PM, Judith Mendez wrote:
> On 5/24/24 3:57 PM, David Lechner wrote:
>> On 5/24/24 3:50 PM, David Lechner wrote:
>>> On 5/23/24 6:15 PM, Judith Mendez wrote:
>>>> Add new compatible ti,am62-eqep for TI K3 devices. If a device
>>>> uses this compatible, require power-domains property.
>>>>
>>>> Since there is only one functional and interface clock for eqep,
>>>> clock-names is not really required. The clock-name also changed
>>>> for TI K3 SoCs so make clock-names optional for the new compatible
>>>> since there is only one clock that is routed to the IP.
>>>>
>>>> While we are here, add an example using ti,am62-eqep compatible.
>>>>
>>>> Signed-off-by: Judith Mendez <jm@ti.com>
>>>> ---
>>>> Changes since v1:
>>>> - Fix eqep binding for new compatible, require
>>>>   power-domains for new compatible
>>>> ---
>>>>   .../devicetree/bindings/counter/ti-eqep.yaml  | 53 +++++++++++++++++--
>>>>   1 file changed, 48 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/counter/ti-eqep.yaml b/Documentation/devicetree/bindings/counter/ti-eqep.yaml
>>>> index 85f1ff83afe72..c4bb0231f166a 100644
>>>> --- a/Documentation/devicetree/bindings/counter/ti-eqep.yaml
>>>> +++ b/Documentation/devicetree/bindings/counter/ti-eqep.yaml
>>>> @@ -11,7 +11,9 @@ maintainers:
>>>>     properties:
>>>>     compatible:
>>>> -    const: ti,am3352-eqep
>>>> +    enum:
>>>> +      - ti,am3352-eqep
>>>> +      - ti,am62-eqep
>>>>       reg:
>>>>       maxItems: 1
>>>> @@ -21,19 +23,43 @@ properties:
>>>>       maxItems: 1
>>>>       clocks:
>>>> -    description: The clock that determines the SYSCLKOUT rate for the eQEP
>>>> -      peripheral.
>>>> +    description: The functional and interface clock that determines the clock
>>>> +      rate for the eQEP peripheral.
>>>>       maxItems: 1
>>>>       clock-names:
>>>> -    const: sysclkout
>>>> +    enum:
>>>> +      - sysclkout
>>>> +      - fck
>>>> +
>>>
>>> If we are making this optional for ti,am62-eqep, why add a new name?
>>>
>>> Also, we could change the description to say that sysclockout is not a
>>> great name but is required for backwards compatibility.
>>>
>>>> +  power-domains:
>>>> +    maxItems: 1
>>>> +
>>>> +allOf:
>>>> +  - if:
>>>> +      properties:
>>>> +        compatible:
>>>> +          contains:
>>>> +            enum:
>>>> +              - ti,am3352-eqep
>>>> +    then:
>>>> +      required:
>>>> +        - clock-names
>>
>> I just looked at the Linux driver for this and the clock name is
>> not used in the driver. So we could probably just deprecate the
>> clock-names property here and not make it required for
>> ti,am3352-eqep (and not allowed for any new compatibles as
>> suggested below).
> 
> We could do this, although I was under the impression that we should
> not drop DT properties just because the linux driver isn't using it,
> that is why I went with keeping clock-names around for am335x compatible
> and making it optional for am62x compatible.
> 
> But if it is all the same, we could drop the the DT property.
> 
> ~ Judith
> 

I wasn't suggesting to remove clock-names from the bindings, just
deprecate that property in this binding and not use it with any
new compatibles.

In the AM62x technical reference manual, it looks like it calls
the functional and interface clock FICLK rather than FCK. So
I'm just suggesting maybe it just easier to not give it a name
rather than try to get the right name? No name will work with
any future SoCs as well. :-)


