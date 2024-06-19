Return-Path: <linux-iio+bounces-6556-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 438AB90E3DE
	for <lists+linux-iio@lfdr.de>; Wed, 19 Jun 2024 08:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C76A71F235D1
	for <lists+linux-iio@lfdr.de>; Wed, 19 Jun 2024 06:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7759F6F319;
	Wed, 19 Jun 2024 06:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="AJelACkr"
X-Original-To: linux-iio@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2087.outbound.protection.outlook.com [40.92.18.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4202A6F306;
	Wed, 19 Jun 2024 06:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.18.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718780305; cv=fail; b=luu+BawbBn67hKIjEDK2xb1T5aV92aeulPu10Q5WMRLIbmVXMBEQb+wy/4mKzLctyrFq0pwZfDv7d+wZMN4vC1qX78oN1wTM1+y8vBwZEVY9AwuWg5eWYypw1h39nfQnIZbr+ipy4M+0bSOZLhgPVcLQxfdaZBZq9yPH1YLmym0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718780305; c=relaxed/simple;
	bh=87EUwm2zpt2U5YJmBvkl3qM5iSjHLukxRJDwOcejCpY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BI0ab1iXOjrZjTDvCO/QBh5Ld+VGsF2GjVQI1ac8noVz+mpMHABt3mMnk33WK03ILTRPgMaSIhM3YmXVYOmpxLHPpl/hklRjORaFVzDRpagiaKkBWYNmgJuxpmfol9YxKkhlZqvANBe40k6RewPa8AuNVNCbuxV+sZ1dkcR7rR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=AJelACkr; arc=fail smtp.client-ip=40.92.18.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i5LLgncNek9uhvDK3MhNExzRciUDYrgaJ3wKXEcXQFIvmR+tfr9Cs8j2jdxJ/7c4sLQc6AXh4dSC6kCWxBp09Z1o1e7/0SV20cys3g6qsOMT6vtHJH5BEZGI6bJZQU99GpxUR4puMDXwrOP1ZDAf8UcwawtyLSi1D5F3cWxyIhgZPnhBeCFQQ5NarLNAdu8kK9WVUF+vArlr/My6IcbHHJcqveUeOdxR+ElCkjQIuljsisQ7NE7dn3D+oFE9khwtvIECSDiH2SsGHUVnAe780NZFXhulxER4JxxW6vitRr3k7fa2zeK4zDglVgnQy16eXms6cOW7MVYPRkirgfCtVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BDhxMUTFVZS/kbE/ePMoz+skyOq2USykcJoSibLMpLg=;
 b=AkZQkUC3L93JIykm+O5QZNwvbpSIdGVVhf1rTBVJbz7LKe0PQgDB5TBY3a9xfbSuzUMu04fJgzYBDg4JPXkOw83vw0VpMI+2cv6KTe0g7F6jwEFJLSTHk7RZW2t68Gz+9ySjng/gxx6joUzHUZG7q7keUychMDdB1blLpxbjApyJfkTchYNxDZMS95J6wtgKM4A7hLRJ8kye+FHDQQLSciw4FkrnNxAZ3gbctfcpyOJFDzmsDZIzY/Gb9gbynR7M52zcpChFta0nN+ZblrB+A3x1jmNwIY5KabzYec274ZKqA+Zq0LVuhOMU+WsZuzcPpq+fI+Ot37y1vvTlhs7rVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BDhxMUTFVZS/kbE/ePMoz+skyOq2USykcJoSibLMpLg=;
 b=AJelACkrCSGr2q/9mnaY+Pxo4AIBrS76r5WC9zqtTmE3hRvonbpURbceuAC9mTkJa2we0i0XH2/DhwROEhIAhtF5QCp9Kk+Kmaf+eyaF+8gGLcnz1xJe1TS9FTOoP87/KsoxUFTorgwWJoLTaDBOqb3jIE2B2H6f5zbm3JuEB8F6D73XkrWVr3O7vj2o7af3xYm4JyA+WQo5JKrZ0KaXhi7xXrzuQWXucboHn5u2fEiLDTSDf8+SRYfUCsZTTD+J490JWk1UkxwSsH1SaM4H26OUKB+eOC8hIfiCM2Qrdd+rgoxuX1MMPbn/G1uhYcrL+i2IvQ+rxuCyhaw32QgDEg==
Received: from SN7PR12MB8101.namprd12.prod.outlook.com (2603:10b6:806:321::7)
 by LV3PR12MB9412.namprd12.prod.outlook.com (2603:10b6:408:211::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.20; Wed, 19 Jun
 2024 06:58:19 +0000
Received: from SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899]) by SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899%5]) with mapi id 15.20.7677.030; Wed, 19 Jun 2024
 06:58:19 +0000
Message-ID:
 <SN7PR12MB810152A24AA71B8C31805DC2A4CF2@SN7PR12MB8101.namprd12.prod.outlook.com>
Date: Wed, 19 Jun 2024 14:58:10 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] dt-bindings:iio:proximity: Add hx9023s binding
To: Jonathan Cameron <jic23@kernel.org>
Cc: andy.shevchenko@gmail.com, lars@metafoo.de, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, nuno.a@analog.com, swboyd@chromium.org,
 u.kleine-koenig@pengutronix.de, yasin.lee.x@gmail.com
References: <20240607114138.390272-1-yasin.lee.x@outlook.com>
 <SN7PR12MB810129D8180B1C9593A8E078A4FB2@SN7PR12MB8101.namprd12.prod.outlook.com>
 <20240608175758.73396584@jic23-huawei> <20240608180152.386db8a2@jic23-huawei>
Content-Language: en-US
From: Yasin Lee <yasin.lee.x@outlook.com>
In-Reply-To: <20240608180152.386db8a2@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [GcIOSATqzp6xtoLptqFZTEW5ee1l7ZRKpkMMliYeMNGUEYXfCFC5yFtgsowP+6kS]
X-ClientProxiedBy: SI1PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::14) To SN7PR12MB8101.namprd12.prod.outlook.com
 (2603:10b6:806:321::7)
X-Microsoft-Original-Message-ID:
 <62061428-eb67-4dc3-b430-01f9c37bc584@outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8101:EE_|LV3PR12MB9412:EE_
X-MS-Office365-Filtering-Correlation-Id: 5061bdc0-ab5b-46fc-a64e-08dc902d3341
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199025|3412199022|4302099010|440099025|1602099009;
X-Microsoft-Antispam-Message-Info:
	Ke4eUW08BkbBLGzCFofH+lobOAgOYO79Ok5ntJ7Wuzp0scgZTDK94shXKQ3/B9NzVb5ZJ5X7kNEOUq2LC98JJYmF1WuC+VlzJfuk42D1x0MZwDMy+AKk8tanJHf8uFeAGyzlkQgJ6XeY03p4leKk3kKPpFONtMExkl9ubpz18njtq5AFAwKx3Q/NBaTGd6fP/Cx2ej8JfQ8oSNx5U+lqX+uXMzy9DvfGTwbdfMDdrE/8iMoUmEKTWYNUIy5LyKvLU1jfLb2vAZxSZFrP6CF840jHbiw6lK7DOKrY2f1vChDYOhSCsplfuDF9s9DbVwWUgi54dMnKo7YYwVh30HxBcKVcya06GF+D/+eeM+/cKA4l+/EDSGl7Sy0dVHvEGJdrTAULyVrAM1s59v5VQuVi/7Ivvveni0hddr6pGz6Mzcs1BhvabKxO7xOWoBOL29JKZ3GSfksLkd3A/IsmkPvx1iSiyN48Bhsu9aUXog5ebFSPgZNuh1WV5vltOd7j6ad0+D4FaMQId0Jd8h9QAQspkilEuP5gYRhAismhNmHHMMgb9U/T4W3v/RGkM8TmqWH2Rf4KAhrnmOpFzMJh/vFDqjKEv8NfWueCC40+cHH6rF/TL/xUDjUl09JSBuRj9Tj710WKYex3epiIft43Wzda6sgNEXR9QgZjF9eLEitp8N3QGHW3JOi91RzW/SavJ+nPHHg6IL4YXCN7PxUIylQTIQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NWRyeWFEeExCVnRTdGRYQWtYOUI0dWZBUlRKL1VhN3pZeTFXYWZ1bTlqQlZz?=
 =?utf-8?B?YVVaZzIyYk9ZdGFvejlhcndPTythMk0zT1FEQWdweXN0Z2pqbVdFM2l3TkVu?=
 =?utf-8?B?dkg1R1gzZURMaTZwaXBCalhtSUdIS1dRdWlXWEtsclRYY2MwWFBGT3YySUp4?=
 =?utf-8?B?VllZK2RaemFmUUZEZDVLSFlWRXJOQndOS2FwSm9lc21SYytiSzN5Y2kzTU1X?=
 =?utf-8?B?WWRvNm5xcGtJTHpEQ2hmUTBrWUVVeEd1bWY5WjhseUtDTW05S1ZSa3I1ZDN2?=
 =?utf-8?B?b0VQZ0pGakxERmdkMGhKRG9NTDVndkxPWHVEc3ZPZk43Z1NpamNlbWwveTRV?=
 =?utf-8?B?SUpGYisxb04yMjBSbGt2TTdINm5NWTF4NWZraER2ZkZOU0h5Q3lRL0hlMCtY?=
 =?utf-8?B?RmwyQ1IxdmtHc0JBWjRTUXhTakZOZVpGQkw1eWpTWEFjYlRKK2Y1SjFBMURy?=
 =?utf-8?B?VDRtQjJYdFlIdjllWDlXYjFQRWFyTVNJWE9YT1ZKcGxPaUtHdFduc0RyTFNk?=
 =?utf-8?B?NnUrUzd3cHJtRS8reGQxOXA0dENFckoveURYVCtOOGJXTWRxcXhhTmQrR3Br?=
 =?utf-8?B?TU5xbDI0eTl5T0V2Wi9XeTYzTThUWVRWN29hN2VxOU1IaHB6U1ZCS3BUTE5k?=
 =?utf-8?B?YUJxYjd6VTdwV1puTTU3dHM1ekVXNkhqdXlIQUkzd3Rtb3VaZll0UlFFaGxN?=
 =?utf-8?B?TTRoU2dUTVZuV1NhbWlLUEJNMkJHQm5BY2FpVGhWM2xLSUxGUWk5bk1LNU4x?=
 =?utf-8?B?QWFHekpCdHRnVWhSa1dMbnJDZVF0N1FNaExLaURBelNkSTZRVHFoWjBnbkYr?=
 =?utf-8?B?ck52NHlkZXpwODhuUktNdHpDWVdCbnEvUU5MTDZsem5VVlB1K1hIS0pmZXNR?=
 =?utf-8?B?WjhVQ2p1NjNZTDBjMXNpbmdxN2NVMGtrOFFCNHpkWmpXcW9wU1ltRk9qM21W?=
 =?utf-8?B?Nm9GMFppK0Z2VElMVEtKZVRRTHZHcjJGdXk0eCszMzEwRzNlQitKbzJJMVZY?=
 =?utf-8?B?R1ovV0Z4Qmt1RWMxaGJCNGt3ZG81bFdkdmtHM1dYaTRrbkVlQzh6cVAyQVUy?=
 =?utf-8?B?UGdnRU1yKzF4ZmdmTWFzdnYvcGhUcU1xVHFxeXB6b2hVbHp6dHBmVzZDVys5?=
 =?utf-8?B?WldESXE4MWxzdDZYSmxncENQNzc3QjZFbDA3MUVMN1dHR3Nza3Y4OCtEdEky?=
 =?utf-8?B?N0JNWWtRQkd1TjJJWnMram1lZGVmcUdVblJQOXNBb3lFNG1OMk5YdVgwTjRH?=
 =?utf-8?B?bzVxcmdwNWlSL2pBY1dOcWYrRHZBc0g0czVqc2QwQXJaVjdINnFhSjJWbGUy?=
 =?utf-8?B?YklpRU45VkhMOUFoKy96MHFVd1M2d0tERDIxNkN1S3ZjeGJsTFFvcE5ILzdl?=
 =?utf-8?B?dmppTnZBUGw1VmpMQTViaXZKMTNnOU50VkdLVk1BTlRLbVJnbGdEOWQ0dDFq?=
 =?utf-8?B?dVRkdEdHN3BFeFF3UFloOS9Rc0IxaW9USEM3WEdSUzZPaG1sbGsrT1krSENG?=
 =?utf-8?B?dTltSmVtTjVGWk9pRTFvOFdUeWpBL2VtR0VYaElqWXRYd0MyVVFDSTRvcUd0?=
 =?utf-8?B?V0c0dy96bmxJSjVUTTJMd2xtNlorSG1Ib2M2dEk1VE5IK1pqa3NZcHR6MDZK?=
 =?utf-8?B?OHFUSHJGZVZ4d0czZmdKOTdyT0RxUWJkb3hXSHUrM05YTlZSaGpqWWVrVkRj?=
 =?utf-8?B?dlBiVGQvZnh5UDhFYzVNOW1GTWI5eGdRazUzTXB1TGUxZlRzOU5WZG9ReTlH?=
 =?utf-8?Q?g/vtQ+doO9X2Y+rxhzC4cxEw36O+q3d6OWSFQG5?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5061bdc0-ab5b-46fc-a64e-08dc902d3341
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 06:58:18.9739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9412


On 2024/6/9 01:01, Jonathan Cameron wrote:
> On Sat, 8 Jun 2024 17:57:58 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
>
>> On Fri,  7 Jun 2024 19:41:37 +0800
>> Yasin Lee <yasin.lee.x@outlook.com> wrote:
>>
>>> From: Yasin Lee <yasin.lee.x@gmail.com>
>>>
>>> A capacitive proximity sensor
>>>
>>> Signed-off-by: Yasin Lee <yasin.lee.x@gmail.com>
>> Hi Yasin
>>
>> Some improvements but seems you missed some of the feedback on v3.
>>
>> See inline.
>>
>> Jonathan
>>
>>> ---
>>>   .../bindings/iio/proximity/tyhx,hx9023s.yaml  | 103 ++++++++++++++++++
>>>   .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
>>>   2 files changed, 105 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml b/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml
>>> new file mode 100644
>>> index 000000000000..50bf2849d823
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml
>>> @@ -0,0 +1,103 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/iio/proximity/tyhx,hx9023s.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: TYHX HX9023S capacitive proximity sensor
>>> +
>>> +maintainers:
>>> +  - Yasin Lee <yasin.lee.x@gmail.com>
>>> +
>>> +description: |
>>> +  TYHX HX9023S proximity sensor
>>> +
>>> +allOf:
>>> +  - $ref: /schemas/iio/iio.yaml#
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: tyhx,hx9023s
>>> +
>>> +  reg:
>>> +    maxItems: 1
>> A device like this needs at least one power supply.  Make sure to document
>> all such supplies and make the ones that are required for functionality part of
>> your required properties.  Note that you should do this even if on your
>> board they are always turned on.
> Ignore this for obvious reasons given you have just below!  However should be
> required.

Fixed


>>> +
>>> +  interrupts:
>>> +    description: |
>>> +      Generated by device to announce preceding read request has finished
>>> +      and data is available or that a close/far proximity event has happened.
>>> +    maxItems: 1
>>> +
>>> +  vdd-supply:
>>> +    true
>>    vdd-supply: true
>>
>> on single line is commonly done for these.
>>
>>> +
>>> +  channel-in-use:
>>> +    description: |
>>> +      Bit flag indicating which channels are used,
>>> +      depends on the hardware circuit design.
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> Presence of the channel nodes below should make this clear
>> without a separate element.
>>

Deleted: channel-in-use

>>> +
>>> +patternProperties:
>>> +  "^channel@[0-9]+$":
>>> +    type: object
>>> +    properties:
>>> +      reg:
>>> +        description: Channel register address
>>> +        $ref: /schemas/types.yaml#/definitions/uint32
>>> +      channel-positive:
>>> +        description: Positive channel assignments
>>> +        $ref: /schemas/types.yaml#/definitions/uint32
>> That size seems implausible.  What are the limits. What does
>> 255 mean?
>>
>> In review of previous version I pointed you at the differential
>> channel bindings for ADCs.  If they cannot be applied here
>> explain why in your patch description.


Included adc.yaml and replaced this section with its diff-channels 
approach, so 255 is no longer needed here.


>>> +      channel-negative:
>>> +        description: Negative channel assignments
>>> +        $ref: /schemas/types.yaml#/definitions/uint32
>>> +    required:
>>> +      - reg
>>> +      - channel-positive
>>> +      - channel-negative
>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +
>>> +unevaluatedProperties: false
>>> +
>>> +examples:
>>> +  - |
>>> +    #include <dt-bindings/interrupt-controller/irq.h>
>>> +    i2c {
>>> +      #address-cells = <1>;
>>> +      #size-cells = <0>;
>>> +      hx9023s@2a {
>>> +        compatible = "tyhx,hx9023s";
>>> +        reg = <0x2a>;
>>> +        interrupt-parent = <&pio>;
>>> +        interrupts = <16 IRQ_TYPE_EDGE_FALLING>;
>>> +        vdd-supply = <&pp1800_prox>;
>>> +        channel-in-use = <0x1F>;
>>> +        channel@0 {
>>> +          reg = <0>;
>>> +          channel-positive = <0>;
>>> +          channel-negative = <255>;
>>> +        };
>>> +        channel@1 {
>>> +          reg = <1>;
>>> +          channel-positive = <1>;
>>> +          channel-negative = <255>;
>>> +        };
>>> +        channel@2 {
>>> +          reg = <2>;
>>> +          channel-positive = <2>;
>>> +          channel-negative = <255>;
>>> +        };
>>> +        channel@3 {
>>> +          reg = <3>;
>>> +          channel-positive = <3>;
>>> +          channel-negative = <255>;
>>> +        };
>>> +        channel@4 {
>>> +          reg = <4>;
>>> +          channel-positive = <4>;
>>> +          channel-negative = <255>;
>>> +        };
>>> +      };
>>> +    };
>>> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
>>> index b97d298b3eb6..e2224eea9ab9 100644
>>> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
>>> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
>>> @@ -1507,6 +1507,8 @@ patternProperties:
>>>       description: Turing Machines, Inc.
>>>     "^tyan,.*":
>>>       description: Tyan Computer Corporation
>>> +  "^tyhx,.*":
>>> +    description: NanjingTianyihexin Electronics Ltd.
>> Use a separate patch for the new vendor prefix.  Makes it easier for people to cherrypick that
>> if they are backporting some other tyhx dt binding.
>>

Done separately.


>>>     "^u-blox,.*":
>>>       description: u-blox
>>>     "^u-boot,.*":
>>

