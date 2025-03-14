Return-Path: <linux-iio+bounces-16837-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A618A60F1A
	for <lists+linux-iio@lfdr.de>; Fri, 14 Mar 2025 11:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E51781894B4F
	for <lists+linux-iio@lfdr.de>; Fri, 14 Mar 2025 10:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5011F4CA7;
	Fri, 14 Mar 2025 10:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="o8Jm4H04"
X-Original-To: linux-iio@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608361F3FD3;
	Fri, 14 Mar 2025 10:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741948562; cv=none; b=e/J49SZXO8EktCqTCZjRCtzNq4sRhFkYU8L5KFWaqdgxZBqJ1EGfkI6IYYaDqFfz724z5C4Q6RvebgWpcucw1RGmUrTKIM2wD8NNdL09n6B/NNV+Rel4YyHgXlUNqh9+gh2mCTZNTzFNBZhe9ANKVyEp6+X7sW/Co+zuIQd7c9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741948562; c=relaxed/simple;
	bh=LRk5FiXCZAm/QLOqWOprpG9wIHqysVDkW9SPn6Y74UY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mumjIPcPAo9afu3HhhiiffOg/B95Dn3v9c2HiyCAS64AJsZoViLlw47hRn16JloKtXqOuq96IzGq15fbALnZgafjpakyyRv+9uvjdEJXednm8Pollj/vP2l0p7bY5Dtffo41lgUdGIGtwyTi+RCHPeMARm3pO9x1ETwPVlYl1Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=o8Jm4H04; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741948558;
	bh=LRk5FiXCZAm/QLOqWOprpG9wIHqysVDkW9SPn6Y74UY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=o8Jm4H0499PVZUsmP41hbpJxEZtW+GATf073GkU3+PVx0hzH0NaAHMax6kJ4rVO4R
	 p7OiUuBgIMoXxI7pQALVCzDvtwFNq/Tr4yyUMtScGddFL4MBsgNm5zrscSh3t7eA7S
	 PhSWlOTThdGgqc2sW2NL0i1AA1+WD3Es7980ZMTkQlcHnq1Q36Eph+Ny8n3DVltn8b
	 zyHKWwtgyL4jqKWxxN9amhMZ1kTBjV50WJcKgpD4uf3wBNpdKkyt9YCE0oEn92R/dC
	 8/RT3RrUKLY5dM+NfW1qZcWTrmLgoKztvozDvd0a5yW588jt1zRoJBgtK7YzIGWWMs
	 yHnNmzH52vTzg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id F131717E0CA6;
	Fri, 14 Mar 2025 11:35:56 +0100 (CET)
Message-ID: <d4b3bc28-b96b-4b11-a99d-d3492ad19438@collabora.com>
Date: Fri, 14 Mar 2025 11:35:56 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] dt-bindings: pmic: mediatek: Add pmic documents
To: Krzysztof Kozlowski <krzk@kernel.org>, "Lu.Tang" <Lu.Tang@mediatek.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, Sean Wang <sean.wang@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, Chen Zhong <chen.zhong@mediatek.com>,
 Sen Chu <shen.chu@mediatek.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-gpio@vger.kernel.org, Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20250314073307.25092-1-Lu.Tang@mediatek.com>
 <20250314073307.25092-6-Lu.Tang@mediatek.com>
 <19ddb133-7f11-4c1b-b0e1-91523d42040c@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <19ddb133-7f11-4c1b-b0e1-91523d42040c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 14/03/25 11:32, Krzysztof Kozlowski ha scritto:
> On 14/03/2025 08:32, Lu.Tang wrote:
> 
> Please use subject prefixes matching the subsystem. You can get them for
> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
> your patch is touching. For bindings, the preferred subjects are
> explained here:
> https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html#i-for-patch-submitters
> 
> There is no subsystem "pmic".
> 
>> Add new pmic mfd and adc documents for mt8196
>>
>> Signed-off-by: Lu.Tang <Lu.Tang@mediatek.com>
> 
> Are you sure Latin transcription of your name includes '.' or you just
> copy-paste email address?
> 
> 
> ...
> 
>> +  - Lu Tang <lu.tang@mediatek.com>
>> +
>> +description:
>> +  The Auxiliary Analog/Digital Converter (AUXADC) is an ADC found
>> +  in some MediaTek PMICs, performing various PMIC related measurements
>> +  such as battery and PMIC internal voltage regulators temperatures,
>> +  other than voltages for various PMIC internal components.
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - mediatek,mt6363-auxadc
>> +      - mediatek,mt6373-auxadc
> 
> Just fold the device to the parent node.
> 
> 
> 
> ..
> 
> 
> 
>> diff --git a/Documentation/devicetree/bindings/mfd/mediatek,spmi-pmic.yaml b/Documentation/devicetree/bindings/mfd/mediatek,spmi-pmic.yaml
>> new file mode 100644
>> index 000000000000..a8f1231623cf
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mfd/mediatek,spmi-pmic.yaml
> 
> Filename matching one of the compatibles, e.g. the oldest one.
> 

Yeah but besides that I don't see valid reasons why this should be a different
binding (and also why this should use a different driver, fwiw) - when it can
most probably just extend the current PMIC MFD driver... and the same goes for
the PMIC AUXADC: there's a mt6359-auxadc binding and driver that can be extended
to 6363 and 6373 rather easily.

There's nothing "really special" about those.....

Cheers

>> @@ -0,0 +1,173 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/mfd/mediatek,spmi-pmic.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: MediaTek SPMI PMICs multi-function device
>> +
>> +maintainers:
>> +  - Lu Tang <lu.tang@mediatek.com>
>> +
>> +description: |
>> +  Some Mediatek PMICs are interfaced to the chip via the SPMI (System Power
>> +  Management Interface) bus.
>> +
>> +  The Mediatek SPMI series includes the MT6363, MT6373, MT6316 and other
>> +  PMICs.Please see the sub-modules below for supported features.
>> +
>> +   MT6363/MT6373 is a multifunction device with the following sub modules:
>> +  - Regulators
>> +  - ADC
>> +  - GPIO
>> +  - Keys
>> +   MT6316 is a multifunction device with the following sub modules:
>> +  - Regulators
> 
> I don't get why they are in the same schema. It would result in
> unnecessary big if:then with half of children not applicable for other
> variants.
> 
>> +
>> +properties:
>> +  compatible:
>> +    oneOf:
>> +      - enum:
>> +          - mediatek,mt6363
>> +          - mediatek,mt6373
>> +          - mediatek,mt6316
> Sort these with alphanumeric order.
> 
> Best regards,
> Krzysztof




