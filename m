Return-Path: <linux-iio+bounces-7295-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2ECD9271D6
	for <lists+linux-iio@lfdr.de>; Thu,  4 Jul 2024 10:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DE25284DEA
	for <lists+linux-iio@lfdr.de>; Thu,  4 Jul 2024 08:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96131A4F2E;
	Thu,  4 Jul 2024 08:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WUyqWIIg"
X-Original-To: linux-iio@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0931A4F1C;
	Thu,  4 Jul 2024 08:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720082132; cv=none; b=F6+p18tf2S02BVYISEEDyp7090ffbf9hgKl4VFDWMFupndTVESPLrwkvUPTMm+HAyv4dMDs9JoqqPRkBv6lqITISRWkXuHMmnNyo+amRMX5lrmWJL0ku324QOyZVgSrUTQ9dUbSjks3NgKjRVoEJS6zdCICWquJ9+OYx6hmgFcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720082132; c=relaxed/simple;
	bh=ha80nLRuPkxl6TD3WGhJxFUjmnwZGetl3R4YGxxUPRg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K5cuqUwYjdJlQyaJ1KlYHAFcJ6QgLPD+x3q4nmRLz1Cv3nNMkCat11CCbG0GTPv5QJSepsydn4jqxwTae+v54jh5ikYuKN6LHlSrQKDeCXxU294hvsT7NVEEJ8eUoE8wZ+LWtNQ6n2V0xajTSaZLe88VRoyEOZS6imsJYYe6PQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WUyqWIIg; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A56C3E0006;
	Thu,  4 Jul 2024 08:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720082128;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VWar8m3O4fo/jZOi8A6VIxRWgKYWwe4SDSJKBXm4MU8=;
	b=WUyqWIIgLtb7ykFLsUTyM+0/eHHcIhl5IRjvw2bfVzhIjxXfCwGVhH1pwDAF7crb5ffXu4
	cORDlXxTlzHgnTdNGHo8uxhVGRZKgXBA9owVfPuSPdG3tcV8HN1G8CBnQopHwcG5SJeK8H
	BvBfeOHHL9L9NoEuDbh24zce/yRjNMbY6HLX39ovWFAXjSe9Jr40Veeuu209ulSqFDaSFD
	X1hUKGz6XVt34aElqd5YYkObjRogHKEAdZqAXHnDnLp2kP6g5wEHE6qv59gLVmY/SCSMkZ
	SABmtWRB7y6xLa1EKLnaz0mID5g2lObdb/lF9i6JUanYXdQi+TFsY1yJaQlrlQ==
Message-ID: <8d368347-7cee-41af-a033-c495eeb62e2a@bootlin.com>
Date: Thu, 4 Jul 2024 10:35:25 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: iio: adc: sophgo,cv18xx-saradc.yaml: Add
 Sophgo SARADC binding documentation
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Albert Ou <aou@eecs.berkeley.edu>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Inochi Amaoto <inochiama@outlook.com>, Chen Wang <unicorn_wang@outlook.com>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org
References: <20240702-sg2002-adc-v1-0-ac66e076a756@bootlin.com>
 <20240702-sg2002-adc-v1-1-ac66e076a756@bootlin.com>
 <b7913f90-7405-4a77-9c57-97ef124de6e1@kernel.org>
Content-Language: en-US
From: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
In-Reply-To: <b7913f90-7405-4a77-9c57-97ef124de6e1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: thomas.bonnefille@bootlin.com

Hello Krzysztof,
Thank you for your feedback

On 7/3/24 7:08 AM, Krzysztof Kozlowski wrote:
> On 02/07/2024 13:52, Thomas Bonnefille wrote:
>> The Sophgo SARADC is a Successive Approximation ADC that can be found in
>> the Sophgo SoC.
>>
>> Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
>> ---
>>   .../bindings/iio/adc/sophgo,cv18xx-saradc.yaml     | 51 ++++++++++++++++++++++
>>   MAINTAINERS                                        |  5 +++
>>   2 files changed, 56 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/iio/adc/sophgo,cv18xx-saradc.yaml b/Documentation/devicetree/bindings/iio/adc/sophgo,cv18xx-saradc.yaml
>> new file mode 100644
>> index 000000000000..21fd5dc8e24e
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/adc/sophgo,cv18xx-saradc.yaml
>> @@ -0,0 +1,51 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/iio/adc/sophgo,cv18xx-adc.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Sophgo 3 channels Successive Approximation Analog to Digital Converters
>> +
>> +maintainers:
>> +  - Thomas Bonnefille <thomas.bonnefille@bootlin.com>
>> +
>> +description:
>> +  Datasheet at https://github.com/sophgo/sophgo-doc/releases
>> +
>> +properties:
>> +  compatible:
>> +    const: sophgo,cv18xx-saradc
> 
> Except that this was never tested... wild-cards are generally not allowed.
> 

I realized I made a mistake when using the "make dt_binding_check" 
command, which led to some errors in this dt_binding. I have now 
addressed all of them, but I'm not sure I understand your comment.

I don't see any wildcards in the YAML file. Could you please provide 
more details on what you expect?

Best regards,
Thomas

