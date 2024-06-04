Return-Path: <linux-iio+bounces-5734-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6F78FAE40
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 11:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33203285DBB
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 09:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2DF7142E8F;
	Tue,  4 Jun 2024 09:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="C14T5kpt"
X-Original-To: linux-iio@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0DF652;
	Tue,  4 Jun 2024 09:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717491870; cv=none; b=kJxDsuLg3zNZPVsVONoXVRKhiVM0QMMCNq/q4VqlEg8KBjO0XyIJc7kv75GcSCoJqWAX3B9ju9FTuXA3sww37PNu2e2oASdITu0v6oRr0+TUZ4a4cZRBOhj4GRSGfdwCOJjqtgRctkHra3SntghuZSkVc4E8cDm7JnQCM8oSZRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717491870; c=relaxed/simple;
	bh=6gaQ6oKnGp6twTwt7O/Eu8NE4XPFTLMcvrtlmUV6Pvk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f6oNC5NGtbPW/gwqgnlAOySfy3s1OCIyqO+Rq95xIiOCc0A1XIvVMAhFj5u/Wdi+cehf6OFGdaAJF6djse7D/YB+c+vpVw9mhzQS5mpFDzSYRqoxVhHbcwlo0VRWsCjoLJePUZVKIDq0VTj5D2fwTnnlxsdlsW6ACVimMaI9jrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=C14T5kpt; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717491867;
	bh=6gaQ6oKnGp6twTwt7O/Eu8NE4XPFTLMcvrtlmUV6Pvk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=C14T5kpt1ijCs+O/AFWzu3gcqA6QQtqHgtSGAzhF7ELdM8ofGfVfCrBi2jgRm/dAL
	 qVXziJCUTF7tGiP0GDhih47sl5dFL1QlyLiWv+jxKW6nQmTpMR1uWHFBIrdSuS83S4
	 lLn3WUtpafuMdoN0MoPeB013e3ErRgY6gU2CcAx/4i1DRWWGHcSZPBKg4lOiAfatAG
	 2LfPsDVwY9LCPz1oyiur+zgFv8Am2CegfaquI89B0+KJoJJaB0XzhbmBRxECbrbrWx
	 lg+CrdvTv9GbByEY+DOMBvjoKJSr3ANjyu2ZQSnl1yHuqKbJVAvsY7SirvEjorfkAW
	 fq5LddqPz+w6A==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A84FE37820A7;
	Tue,  4 Jun 2024 09:04:25 +0000 (UTC)
Message-ID: <3d364430-96c7-4f9f-98e7-e68b1e57f69e@collabora.com>
Date: Tue, 4 Jun 2024 11:04:25 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/4] dt-bindings: iio: adc: Add MediaTek MT6359 PMIC
 AUXADC
To: Jonathan Cameron <jic23@kernel.org>
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
 <20240602104048.14c75d7b@jic23-huawei>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240602104048.14c75d7b@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 02/06/24 11:40, Jonathan Cameron ha scritto:
> On Thu, 30 May 2024 11:34:07 +0200
> AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> wrote:
> 
>> Add a new binding for the MT6350 Series (MT6357/8/9) PMIC AUXADC,
>> providing various ADC channels for both internal temperatures and
>> voltages, audio accessory detection (hp/mic/hp+mic and buttons,
>> usually on a 3.5mm jack) other than some basic battery statistics
>> on boards where the battery is managed by this PMIC.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Hi,
> 
> What are all the headers for given the binding doc doesn't use anything from
> them?
> 

The binding document doesn't use them, yes, but those are part of the devicetree
binding itself, as those can be used by devicetrees to reference an ADC channel
like <&pmic_adc MT6359_AUXADC_ACCDET>.

I think growing the binding example to add an "external" node using one of those
channels is irrelevant, as that is "outside" of the description of the AUXADC HW.

Cheers,
Angelo

> Jonathan
> 
>> ---
>>   .../iio/adc/mediatek,mt6359-auxadc.yaml       | 43 +++++++++++++++++++
>>   .../iio/adc/mediatek,mt6357-auxadc.h          | 21 +++++++++
>>   .../iio/adc/mediatek,mt6358-auxadc.h          | 22 ++++++++++
>>   .../iio/adc/mediatek,mt6359-auxadc.h          | 22 ++++++++++
>>   4 files changed, 108 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/iio/adc/mediatek,mt6359-auxadc.yaml
>>   create mode 100644 include/dt-bindings/iio/adc/mediatek,mt6357-auxadc.h
>>   create mode 100644 include/dt-bindings/iio/adc/mediatek,mt6358-auxadc.h
>>   create mode 100644 include/dt-bindings/iio/adc/mediatek,mt6359-auxadc.h
>>
>> diff --git a/Documentation/devicetree/bindings/iio/adc/mediatek,mt6359-auxadc.yaml b/Documentation/devicetree/bindings/iio/adc/mediatek,mt6359-auxadc.yaml
>> new file mode 100644
>> index 000000000000..dd6c331905cf
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/adc/mediatek,mt6359-auxadc.yaml
>> @@ -0,0 +1,43 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/iio/adc/mediatek,mt6359-auxadc.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: MediaTek MT6350 series PMIC AUXADC
>> +
>> +maintainers:
>> +  - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> +
>> +description:
>> +  The Auxiliary Analog/Digital Converter (AUXADC) is an ADC found
>> +  in some MediaTek PMICs, performing various PMIC related measurements
>> +  such as battery and PMIC internal voltage regulators temperatures,
>> +  accessory detection resistance (usually, for a 3.5mm audio jack)
>> +  other than voltages for various PMIC internal components.
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - mediatek,mt6357-auxadc
>> +      - mediatek,mt6358-auxadc
>> +      - mediatek,mt6359-auxadc
>> +
>> +  "#io-channel-cells":
>> +    const: 1
>> +
>> +additionalProperties: false
>> +
>> +required:
>> +  - compatible
>> +  - "#io-channel-cells"
>> +
>> +examples:
>> +  - |
>> +    pmic {
>> +        pmic_adc: adc {
>> +            compatible = "mediatek,mt6359-auxadc";
>> +            #io-channel-cells = <1>;
>> +        };
>> +    };
>> +...
>> diff --git a/include/dt-bindings/iio/adc/mediatek,mt6357-auxadc.h b/include/dt-bindings/iio/adc/mediatek,mt6357-auxadc.h
>> new file mode 100644
>> index 000000000000..03ebb1d23953
>> --- /dev/null
>> +++ b/include/dt-bindings/iio/adc/mediatek,mt6357-auxadc.h
>> @@ -0,0 +1,21 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
>> +
>> +#ifndef _DT_BINDINGS_MEDIATEK_MT6357_AUXADC_H
>> +#define _DT_BINDINGS_MEDIATEK_MT6357_AUXADC_H
>> +
>> +/* ADC Channel Index */
>> +#define MT6357_AUXADC_BATADC		0
>> +#define MT6357_AUXADC_ISENSE		1
>> +#define MT6357_AUXADC_VCDT		2
>> +#define MT6357_AUXADC_BAT_TEMP		3
>> +#define MT6357_AUXADC_CHIP_TEMP		4
>> +#define MT6357_AUXADC_ACCDET		5
>> +#define MT6357_AUXADC_VDCXO		6
>> +#define MT6357_AUXADC_TSX_TEMP		7
>> +#define MT6357_AUXADC_HPOFS_CAL		8
>> +#define MT6357_AUXADC_DCXO_TEMP		9
>> +#define MT6357_AUXADC_VCORE_TEMP	10
>> +#define MT6357_AUXADC_VPROC_TEMP	11
>> +#define MT6357_AUXADC_VBAT		12
>> +
>> +#endif
>> diff --git a/include/dt-bindings/iio/adc/mediatek,mt6358-auxadc.h b/include/dt-bindings/iio/adc/mediatek,mt6358-auxadc.h
>> new file mode 100644
>> index 000000000000..efa08398fafd
>> --- /dev/null
>> +++ b/include/dt-bindings/iio/adc/mediatek,mt6358-auxadc.h
>> @@ -0,0 +1,22 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
>> +
>> +#ifndef _DT_BINDINGS_MEDIATEK_MT6358_AUXADC_H
>> +#define _DT_BINDINGS_MEDIATEK_MT6358_AUXADC_H
>> +
>> +/* ADC Channel Index */
>> +#define MT6358_AUXADC_BATADC		0
>> +#define MT6358_AUXADC_VCDT		1
>> +#define MT6358_AUXADC_BAT_TEMP		2
>> +#define MT6358_AUXADC_CHIP_TEMP		3
>> +#define MT6358_AUXADC_ACCDET		4
>> +#define MT6358_AUXADC_VDCXO		5
>> +#define MT6358_AUXADC_TSX_TEMP		6
>> +#define MT6358_AUXADC_HPOFS_CAL		7
>> +#define MT6358_AUXADC_DCXO_TEMP		8
>> +#define MT6358_AUXADC_VBIF		9
>> +#define MT6358_AUXADC_VCORE_TEMP	10
>> +#define MT6358_AUXADC_VPROC_TEMP	11
>> +#define MT6358_AUXADC_VGPU_TEMP		12
>> +#define MT6358_AUXADC_VBAT		13
>> +
>> +#endif
>> diff --git a/include/dt-bindings/iio/adc/mediatek,mt6359-auxadc.h b/include/dt-bindings/iio/adc/mediatek,mt6359-auxadc.h
>> new file mode 100644
>> index 000000000000..59826393ee7e
>> --- /dev/null
>> +++ b/include/dt-bindings/iio/adc/mediatek,mt6359-auxadc.h
>> @@ -0,0 +1,22 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
>> +
>> +#ifndef _DT_BINDINGS_MEDIATEK_MT6359_AUXADC_H
>> +#define _DT_BINDINGS_MEDIATEK_MT6359_AUXADC_H
>> +
>> +/* ADC Channel Index */
>> +#define MT6359_AUXADC_BATADC		0
>> +#define MT6359_AUXADC_BAT_TEMP		1
>> +#define MT6359_AUXADC_CHIP_TEMP		2
>> +#define MT6359_AUXADC_ACCDET		3
>> +#define MT6359_AUXADC_VDCXO		4
>> +#define MT6359_AUXADC_TSX_TEMP		5
>> +#define MT6359_AUXADC_HPOFS_CAL		6
>> +#define MT6359_AUXADC_DCXO_TEMP		7
>> +#define MT6359_AUXADC_VBIF		8
>> +#define MT6359_AUXADC_VCORE_TEMP	9
>> +#define MT6359_AUXADC_VPROC_TEMP	10
>> +#define MT6359_AUXADC_VGPU_TEMP		11
>> +#define MT6359_AUXADC_VBAT		12
>> +#define MT6359_AUXADC_IBAT		13
>> +
>> +#endif
> 


