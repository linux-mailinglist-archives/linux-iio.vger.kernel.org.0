Return-Path: <linux-iio+bounces-6140-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4181A901C3B
	for <lists+linux-iio@lfdr.de>; Mon, 10 Jun 2024 10:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E19701F227DF
	for <lists+linux-iio@lfdr.de>; Mon, 10 Jun 2024 08:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4AC5588E;
	Mon, 10 Jun 2024 08:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="E0dNFPWF"
X-Original-To: linux-iio@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F562B9D4;
	Mon, 10 Jun 2024 08:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718006461; cv=none; b=aijPMY/0k06MG319ByyVD247kcx05rQWL3iUTWnPM/Cioi9ei0mZmd2Rp7ssg4ewE8pE2YEcTjncpvbeLd38lDldwa8bb18rUXMfHSXRYSoZ+7zpRXl8ELmocgIBSt66AqTYRI2lwyaTqJoO713N3z1Pu6vRkglzPrqH+PCjS6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718006461; c=relaxed/simple;
	bh=1qc8sEPJXgX5QVHao+W1jv64OvLM7kYZ9yU+Gf0Z1dI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GCYD8uCflWRNlj71PV9OHQuG3ZY2ZxdyLbgsMcNlDYyvzilpWoM7pzfgD6jpteiK90wf6pdA84F5GAiNLevkaTz044D949+eL6Ms6szn1Pncx2916gjj+5bIblPOttFxXfrOH5OWT067dQFJcDLGFKTJvJ6TN+at9xe09Dl+usY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=E0dNFPWF; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718006457;
	bh=1qc8sEPJXgX5QVHao+W1jv64OvLM7kYZ9yU+Gf0Z1dI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=E0dNFPWFdu9QwVQ4mckqkzCeoKk+njabiRFivBjbv15atGBo7I9qaQPBmaW7/n6Uc
	 3X3nXznhVVgzRjDCKXiBHSrwf8uH9+5XcjX7PneBkrSZonZZ0bholbelAR5GMynrKP
	 M1zLUkSI4x65uIz3V3SlFVXoGCfXab9tc3iZbFaIfwtSEhOCfsRL8D6EvAIiw577VJ
	 NJsd6JIp7RTwYZNluGNt+1Z9n+ex0jMkaE7lYtqDIPp0/jlF1Qu1eEJTyPR6vM3MLs
	 04o9wsTQ2sRbMYpQFf0QjwrMnspMkN2pVwlhjDRiofbx3NigwoeW9PLdWONe53j33Q
	 Z8ATGX7jzsuIw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E996B3780575;
	Mon, 10 Jun 2024 08:00:55 +0000 (UTC)
Message-ID: <e71a38a9-7a92-4156-a7f0-52f71d461d61@collabora.com>
Date: Mon, 10 Jun 2024 10:00:55 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] dt-bindings: iio: adc: Add MediaTek MT6359 PMIC
 AUXADC
To: Rob Herring <robh@kernel.org>
Cc: jic23@kernel.org, lars@metafoo.de, krzk+dt@kernel.org,
 conor+dt@kernel.org, matthias.bgg@gmail.com, lee@kernel.org,
 andy@kernel.org, nuno.sa@analog.com, bigunclemax@gmail.com,
 dlechner@baylibre.com, marius.cristea@microchip.com,
 marcelo.schmitt@analog.com, fr0st61te@gmail.com, mitrutzceclan@gmail.com,
 mike.looijmans@topic.nl, marcus.folkesson@gmail.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, andy.shevchenko@gmail.com,
 kernel@collabora.com
References: <20240604123008.327424-1-angelogioacchino.delregno@collabora.com>
 <20240604123008.327424-2-angelogioacchino.delregno@collabora.com>
 <20240605235239.GA3455504-robh@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240605235239.GA3455504-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 06/06/24 01:52, Rob Herring ha scritto:
> On Tue, Jun 04, 2024 at 02:30:04PM +0200, AngeloGioacchino Del Regno wrote:
>> Add a new binding for the MT6350 Series (MT6357/8/9) PMIC AUXADC,
>> providing various ADC channels for both internal temperatures and
>> voltages, audio accessory detection (hp/mic/hp+mic and buttons,
>> usually on a 3.5mm jack) other than some basic battery statistics
>> on boards where the battery is managed by this PMIC.
>>
>> Also add the necessary dt-binding headers for devicetree consumers.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   .../iio/adc/mediatek,mt6359-auxadc.yaml       | 33 +++++++++++++++++++
>>   .../iio/adc/mediatek,mt6357-auxadc.h          | 21 ++++++++++++
>>   .../iio/adc/mediatek,mt6358-auxadc.h          | 22 +++++++++++++
>>   .../iio/adc/mediatek,mt6359-auxadc.h          | 22 +++++++++++++
>>   4 files changed, 98 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/iio/adc/mediatek,mt6359-auxadc.yaml
>>   create mode 100644 include/dt-bindings/iio/adc/mediatek,mt6357-auxadc.h
>>   create mode 100644 include/dt-bindings/iio/adc/mediatek,mt6358-auxadc.h
>>   create mode 100644 include/dt-bindings/iio/adc/mediatek,mt6359-auxadc.h
>>
>> diff --git a/Documentation/devicetree/bindings/iio/adc/mediatek,mt6359-auxadc.yaml b/Documentation/devicetree/bindings/iio/adc/mediatek,mt6359-auxadc.yaml
>> new file mode 100644
>> index 000000000000..6497c416094d
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/adc/mediatek,mt6359-auxadc.yaml
>> @@ -0,0 +1,33 @@
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
> 
> Why do you need a node here? Just add #io-channel-cells to the parent
> node.
> 

Because some boards will want to avoid probing the related driver, as that will
trigger a reset and this may not play well with ECs (namely, some Chromebooks),
which are reading the same AUXADC block.

If I avoid using a new node, instead of just using `status`, I'll have to add a
"mediatek,disable-auxadc" property to the parent node, which isn't pretty...

Cheers,
Angelo

>> +
>> +required:
>> +  - compatible
>> +  - "#io-channel-cells"
>> +
>> +additionalProperties: false



