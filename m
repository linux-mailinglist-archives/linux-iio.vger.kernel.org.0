Return-Path: <linux-iio+bounces-5740-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 538BD8FAEFD
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 11:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2B261F21C8F
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 09:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2151983CB2;
	Tue,  4 Jun 2024 09:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vPDst1bo"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA11815E97;
	Tue,  4 Jun 2024 09:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717493926; cv=none; b=p3YW+UppOOVmwq0m4o2uJ6G1nFDCM4L1/gKuWkFgZIc3o+El52PmrgDouGL5gzXzWDMqJOMK96AHbpycv3BGoDO71zlh3H3j+C0TlFSwmOpFoUZXSLMjlZaXveXjZzAu8F0ThS8ZGSXpTRQRRC8CmLzdiHW32bs0MljsHhwkKGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717493926; c=relaxed/simple;
	bh=8WSz0b/gsOg+WRLIH5jMyiwfhs13pbW3PQyc8W3rioM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mji7JjrpsvQ1Xtb0+Xtyc/4dAF2FYXlDZpmAR+FyGYfWrfArvxryyl2RbM+j4Fmcsxz1dDeTbu5vmY2jrylH7hsN4SUQ16lvA2498cZ1UNSTSMYnPCp4BQnRsRhyaruMbyPvHbRx0doE7sbapE7hDg2pQ/qXlEYoRiLFbR3dKes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vPDst1bo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72BABC2BBFC;
	Tue,  4 Jun 2024 09:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717493925;
	bh=8WSz0b/gsOg+WRLIH5jMyiwfhs13pbW3PQyc8W3rioM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=vPDst1booHkhgF8rUuSBd1IQeGWuK8zmNyaqa+quCrD8vu++Ai9pq1xY7ztk9IRnS
	 JLXlNMj3kP03AHb403qaZPx4DaTmch9u6Tdx5vHW0xRMDoJgE82LlUc/xQzWZlDA/H
	 3eruCWGJ+TGD0l16d6UcNUmNXn6x8avPacd4DJNIbgraE/h6I7r/f9ndaOwFeMRTQG
	 X+irrUA/ENq19mm911hBDSgfa2dm3TQU/HKmcRyvIPAmslwl1jkM9bZCQuWjib8OGT
	 XUvpgzAT99QSGKIqQ6TVXspX6J26qRxc6b9pbmzjjwT6uanU7uFp8X4T1C5oOdGlUY
	 2emmyGyY/eJiA==
Message-ID: <0d7d9f61-2590-4c72-9498-dc6540b571d5@kernel.org>
Date: Tue, 4 Jun 2024 11:38:35 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/4] dt-bindings: iio: adc: Add MediaTek MT6359 PMIC
 AUXADC
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 jic23@kernel.org
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
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <dc46258b-caf9-46a7-84b4-2f229d48b8f7@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/06/2024 10:55, AngeloGioacchino Del Regno wrote:
> Il 01/06/24 17:32, Krzysztof Kozlowski ha scritto:
>> On 30/05/2024 11:34, AngeloGioacchino Del Regno wrote:
>>> Add a new binding for the MT6350 Series (MT6357/8/9) PMIC AUXADC,
>>> providing various ADC channels for both internal temperatures and
>>> voltages, audio accessory detection (hp/mic/hp+mic and buttons,
>>> usually on a 3.5mm jack) other than some basic battery statistics
>>> on boards where the battery is managed by this PMIC.
>>>
>>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>> ---
>>>   .../iio/adc/mediatek,mt6359-auxadc.yaml       | 43 +++++++++++++++++++
>>>   .../iio/adc/mediatek,mt6357-auxadc.h          | 21 +++++++++
>>>   .../iio/adc/mediatek,mt6358-auxadc.h          | 22 ++++++++++
>>>   .../iio/adc/mediatek,mt6359-auxadc.h          | 22 ++++++++++
>>>   4 files changed, 108 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/iio/adc/mediatek,mt6359-auxadc.yaml
>>>   create mode 100644 include/dt-bindings/iio/adc/mediatek,mt6357-auxadc.h
>>>   create mode 100644 include/dt-bindings/iio/adc/mediatek,mt6358-auxadc.h
>>>   create mode 100644 include/dt-bindings/iio/adc/mediatek,mt6359-auxadc.h
>>>
>>> diff --git a/Documentation/devicetree/bindings/iio/adc/mediatek,mt6359-auxadc.yaml b/Documentation/devicetree/bindings/iio/adc/mediatek,mt6359-auxadc.yaml
>>> new file mode 100644
>>> index 000000000000..dd6c331905cf
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/iio/adc/mediatek,mt6359-auxadc.yaml
>>> @@ -0,0 +1,43 @@
>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/iio/adc/mediatek,mt6359-auxadc.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: MediaTek MT6350 series PMIC AUXADC
>>> +
>>> +maintainers:
>>> +  - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>> +
>>> +description:
>>> +  The Auxiliary Analog/Digital Converter (AUXADC) is an ADC found
>>> +  in some MediaTek PMICs, performing various PMIC related measurements
>>> +  such as battery and PMIC internal voltage regulators temperatures,
>>> +  accessory detection resistance (usually, for a 3.5mm audio jack)
>>> +  other than voltages for various PMIC internal components.
>>> +
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - mediatek,mt6357-auxadc
>>> +      - mediatek,mt6358-auxadc
>>> +      - mediatek,mt6359-auxadc
>>> +
>>> +  "#io-channel-cells":
>>> +    const: 1
>>> +
>>> +additionalProperties: false
>>
>> If there is going to be a re-spin, please move this below required: block.
>>
> 
> Yep, will do. Fixed up for v2.
> 
>>> +
>>> +required:
>>> +  - compatible
>>> +  - "#io-channel-cells"
>>> +
>>> +examples:
>>> +  - |
>>> +    pmic {
>>> +        pmic_adc: adc {
>>> +            compatible = "mediatek,mt6359-auxadc";
>>> +            #io-channel-cells = <1>;
>>> +        };
>>
>> This suggests that you should grow (make complete) the parent PMIC example.
> 
> Uhm, should I instead add that to bindings/mfd/mediatek,mt6357.yaml and avoid
> growing the parent example?

No. You should avoid this example and grow the parent example. Not avoid
parent example...

> 
>    adc:
>      type: object
>      $ref: /schemas/iio/adc/mediatek,mt6359-auxadc.yaml
>      unevaluatedProperties: false
> 
>>
>> Actually having this as a separate node is not really needed. Why it
>> cannot be just part of the MFD/parent node?
>>
> 
> (glossary: PWRAP = PMIC [SPI] WRAPper)
> 
> The top node is the PWRAP, an IP that is (mostly) used to dispatch commands to
> the PMIC, but the AUXADC is not integrated into the PWRAP, but into the PMIC.

Eh? mediatek,mt6357.yaml says it is a PMIC...

> 
> Declaring the AUXADC as a PWRAP child would therefore be an incorrect description
> of the hardware.
> 
> P.S.: not necessary, but to "complete the circle" ... note that the PWRAP can be
>        skipped on some SoCs/firmwares/configurations, even though afaik that's only
>        mostly for debugging purposes, it's not granted that you have pwrap between
>        SoC and PMIC on all SoCs/fws/confs, even though, all of the boards that are
>        supported upstream do have it and do require it.

Best regards,
Krzysztof


