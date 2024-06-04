Return-Path: <linux-iio+bounces-5750-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A518FB216
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 14:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A35FB224A9
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 12:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EBB6146004;
	Tue,  4 Jun 2024 12:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="wYr4Iky7"
X-Original-To: linux-iio@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF99145FF6;
	Tue,  4 Jun 2024 12:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717503881; cv=none; b=X8+IX/73mbs9UO1E7I3lFyokhE19hzK2XXCDnmYU9yBmkWYbjhujDMTIweExabVs1GAtJcg7Beel+RGhJ0sFLviektSPevscC+1TlViC2Esx3lMtkYXK7fzVgYDnWhxqF4sBA8DxzmLQIvnYXFVM2tG/Or4STPW6MCPAq6szo9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717503881; c=relaxed/simple;
	bh=Lv9Ndc3v7OplGgEuObrkLWF5jfo0VwmttjMAF0BC7Yg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GJdXuNY7QH2EYEVPJAB9ngQV9eY+xyvaNUZ5//7EHkVTlXtek8ludwmHJP78TwNPfsxWQqBADPOA16Ehd8OsckwS1y2rUpt8PqWWMamF0+w0OJcXICI5WAUNvziTsiCto/vuQ0hHzWp4mwijeZ1qhtyn656RrA4timSQSjwP8NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=wYr4Iky7; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717503877;
	bh=Lv9Ndc3v7OplGgEuObrkLWF5jfo0VwmttjMAF0BC7Yg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=wYr4Iky7YMflG9JtezhvZtRBcZeFnpjwTSMcpN+b5X5cESTbE3GoiK7IFx9Qgw/sQ
	 6d/NUKDtM1reDJRZotpXohQC2N+7opEJiqseoukugOvnse6Pin5MpMgeMq8uE9ArWm
	 nm6OvNACcVFYGZjjGCpXQeR0nh9owN2hSJyo0pzFNRuc2p5Xvla51cRS9SsWa47dRv
	 74xee2CHTTmMsHkw4kY6reOt9KRaq1hWuass2Ls5E9iobh8YQbegJhA78kHlJ3020W
	 KF2vtCtt/JUF8+Fi2QdtGbtYEHbuQoPVrpeIUeD6ZE86udgWVwzvyU3+V//duffumK
	 pACLCgDn2sBPQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 2C687378214D;
	Tue,  4 Jun 2024 12:24:36 +0000 (UTC)
Message-ID: <c9066432-8849-49cb-8027-4f9c7f5d7686@collabora.com>
Date: Tue, 4 Jun 2024 14:24:35 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/4] dt-bindings: iio: adc: Add MediaTek MT6359 PMIC
 AUXADC
To: Krzysztof Kozlowski <krzk@kernel.org>, jic23@kernel.org
Cc: lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, matthias.bgg@gmail.com, lee@kernel.org,
 andy@kernel.org, nuno.sa@analog.com, bigunclemax@gmail.com,
 dlechner@baylibre.com, marius.cristea@microchip.com,
 marcelo.schmitt@analog.com, fr0st61te@gmail.com, mitrutzceclan@gmail.com,
 mike.looijmans@topic.nl, marcus.folkesson@gmail.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, kernel@collabora.com
References: <20240530093410.112716-1-angelogioacchino.delregno@collabora.com>
 <20240530093410.112716-2-angelogioacchino.delregno@collabora.com>
 <c2b97c8e-177e-4169-b001-ab0e3303734f@kernel.org>
 <dc46258b-caf9-46a7-84b4-2f229d48b8f7@collabora.com>
 <0d7d9f61-2590-4c72-9498-dc6540b571d5@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <0d7d9f61-2590-4c72-9498-dc6540b571d5@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 04/06/24 11:38, Krzysztof Kozlowski ha scritto:
> On 04/06/2024 10:55, AngeloGioacchino Del Regno wrote:
>> Il 01/06/24 17:32, Krzysztof Kozlowski ha scritto:
>>> On 30/05/2024 11:34, AngeloGioacchino Del Regno wrote:
>>>> Add a new binding for the MT6350 Series (MT6357/8/9) PMIC AUXADC,
>>>> providing various ADC channels for both internal temperatures and
>>>> voltages, audio accessory detection (hp/mic/hp+mic and buttons,
>>>> usually on a 3.5mm jack) other than some basic battery statistics
>>>> on boards where the battery is managed by this PMIC.
>>>>
>>>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>>> ---
>>>>    .../iio/adc/mediatek,mt6359-auxadc.yaml       | 43 +++++++++++++++++++
>>>>    .../iio/adc/mediatek,mt6357-auxadc.h          | 21 +++++++++
>>>>    .../iio/adc/mediatek,mt6358-auxadc.h          | 22 ++++++++++
>>>>    .../iio/adc/mediatek,mt6359-auxadc.h          | 22 ++++++++++
>>>>    4 files changed, 108 insertions(+)
>>>>    create mode 100644 Documentation/devicetree/bindings/iio/adc/mediatek,mt6359-auxadc.yaml
>>>>    create mode 100644 include/dt-bindings/iio/adc/mediatek,mt6357-auxadc.h
>>>>    create mode 100644 include/dt-bindings/iio/adc/mediatek,mt6358-auxadc.h
>>>>    create mode 100644 include/dt-bindings/iio/adc/mediatek,mt6359-auxadc.h
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/iio/adc/mediatek,mt6359-auxadc.yaml b/Documentation/devicetree/bindings/iio/adc/mediatek,mt6359-auxadc.yaml
>>>> new file mode 100644
>>>> index 000000000000..dd6c331905cf
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/iio/adc/mediatek,mt6359-auxadc.yaml
>>>> @@ -0,0 +1,43 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/iio/adc/mediatek,mt6359-auxadc.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: MediaTek MT6350 series PMIC AUXADC
>>>> +
>>>> +maintainers:
>>>> +  - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>>> +
>>>> +description:
>>>> +  The Auxiliary Analog/Digital Converter (AUXADC) is an ADC found
>>>> +  in some MediaTek PMICs, performing various PMIC related measurements
>>>> +  such as battery and PMIC internal voltage regulators temperatures,
>>>> +  accessory detection resistance (usually, for a 3.5mm audio jack)
>>>> +  other than voltages for various PMIC internal components.
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    enum:
>>>> +      - mediatek,mt6357-auxadc
>>>> +      - mediatek,mt6358-auxadc
>>>> +      - mediatek,mt6359-auxadc
>>>> +
>>>> +  "#io-channel-cells":
>>>> +    const: 1
>>>> +
>>>> +additionalProperties: false
>>>
>>> If there is going to be a re-spin, please move this below required: block.
>>>
>>
>> Yep, will do. Fixed up for v2.
>>
>>>> +
>>>> +required:
>>>> +  - compatible
>>>> +  - "#io-channel-cells"
>>>> +
>>>> +examples:
>>>> +  - |
>>>> +    pmic {
>>>> +        pmic_adc: adc {
>>>> +            compatible = "mediatek,mt6359-auxadc";
>>>> +            #io-channel-cells = <1>;
>>>> +        };
>>>
>>> This suggests that you should grow (make complete) the parent PMIC example.
>>
>> Uhm, should I instead add that to bindings/mfd/mediatek,mt6357.yaml and avoid
>> growing the parent example?
> 
> No. You should avoid this example and grow the parent example. Not avoid
> parent example...
> 

I will remove examples from here and move the example that I wrote in here
to mediatek,mt6357.yaml.

>>
>>     adc:
>>       type: object
>>       $ref: /schemas/iio/adc/mediatek,mt6359-auxadc.yaml
>>       unevaluatedProperties: false
>>
>>>
>>> Actually having this as a separate node is not really needed. Why it
>>> cannot be just part of the MFD/parent node?
>>>
>>
>> (glossary: PWRAP = PMIC [SPI] WRAPper)
>>
>> The top node is the PWRAP, an IP that is (mostly) used to dispatch commands to
>> the PMIC, but the AUXADC is not integrated into the PWRAP, but into the PMIC.
> 
> Eh? mediatek,mt6357.yaml says it is a PMIC...
> 

Eh, apparently my brain cells are somewhere else today.
I was thinking about the HW, and some synapse got disconnected in the process, lol.

Just pretend I never wrote this useless wall of text, sorry. Ugh :-)

Cheers,
Angelo


