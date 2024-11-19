Return-Path: <linux-iio+bounces-12414-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8379D2C02
	for <lists+linux-iio@lfdr.de>; Tue, 19 Nov 2024 18:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83DD71F246F7
	for <lists+linux-iio@lfdr.de>; Tue, 19 Nov 2024 17:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D453A1D0F5D;
	Tue, 19 Nov 2024 17:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="RCoQKTFR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E6B1D0DC8
	for <linux-iio@vger.kernel.org>; Tue, 19 Nov 2024 17:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732035774; cv=none; b=pVbdVXgtbzdYsqwsu/87Mk/BqHP52rGLIPlTbWW70OP5Xwf4twQAk24YNCuaS8jEuhfB4CQkJO51lrn53VfkKkLsUas8Eira1OoB3mLfbil35Tv4GWj+rmsDFaRrQCoDqAfA8CNL0UIfb61/QOnHlnBcRodhAc0u6iZDw4deotk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732035774; c=relaxed/simple;
	bh=h70w9vQazV5qNPLex4P1Yuwr7tbO2ict2Rq3hLHOPwo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hn/lSA7IKlugzt2AFjRna2R2so//X+nrYfRAiITF0bLuyENFRL1gBrP5weah3D4acIFsHvoWPifwUz0NFyXzShMIZcUSry4RYuZsOsqm0ItuZ+zFq7L9CkL9g+tOjJ3ZVcdFou4CWAeVDXBQqZAfBZci8pLv9nlgELP+VcD7msc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=RCoQKTFR; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-71808b6246bso1723665a34.2
        for <linux-iio@vger.kernel.org>; Tue, 19 Nov 2024 09:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732035771; x=1732640571; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wpSTIfTynaQ3ZBm9L5nQI/0DHuXfSVhBbTYYsw/NWVk=;
        b=RCoQKTFRkDyKzIugpZCX7EGVZNv3hoqWiWRp5uKbLXcvBTCDA9gRft/hzNjogYjsId
         eW4GWUY0wchbNvvSCPt3tPVMU+2O0cn8AsJu4RQIfIuoJvvLNCQLMIwi9Rl4LMDbNdV9
         MBofdd5jK/ACBTUkdRE7uupcNvZQolY+TX8O8TefYT8f+2iJ8S3UPw3SkFglIReAtPB7
         F9jN4VtfgLrNyLxViLTaFhaKWnTNv5stxZhpg8XqAx5LxOa9xdRAhRpfOVLC59drzETH
         PVa+R+hTq/Nmg4DEl9UC8CPvA/xEbdqwDA0qm7CUTU+rDpmDjC1kC8vu4DtE35bqjtO2
         9oVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732035771; x=1732640571;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wpSTIfTynaQ3ZBm9L5nQI/0DHuXfSVhBbTYYsw/NWVk=;
        b=kH8ct8DHjUMXel5kGwlYsijmFCcOn9sPMOLhS1gNJNHbY8aer7tq1JaXO35EghXg/j
         r1RuLUWkWT6jKJkrtMz7zwxIiL+MfNoCyDfYunSl76rJAviBG56TptSCEAigGVTQVWGJ
         F6v3N69i8OtKPMEja4OEPFwNIQq2q4LBZIcCkkA7d3zLNtZWpq5+II1/SPW1wp7pXGFz
         tfKT4Ten34nTU0eYXsbIMxtDhAHpiLNFMbdbb3lo0kvxOgOEHBAyfr+HymmCTScpeA43
         AbZcWfdPd6I1g/forGIqIve2u03kOES/W3k193Dt5QZwN/aSAnPav1qq0aznP4XGiTnO
         KWPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgYd9XxbE+E6iMTVaGFA+EXeZR5kiNtoYpSTy6PwX1IFAqHrHbQBP/aY88lzxn4X4xVBtMXHrZ228=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMZfMLpHh2iRcpGQM3+G+ak+n3steFBPnYLUE2UJZMDn/68Y5a
	QDVvOLPY70I50alOLY9FxtBUhVGU9Yd0RsMFUkcM2F/XvNy+NHuWFj2a853GXmQ=
X-Google-Smtp-Source: AGHT+IHBUbfDxf+BtmKDo3ex3QVTqeeoMBwE054v2Ptp4qL6Pugo7JcmWBAOaAA3GsD1txkLu4IiLA==
X-Received: by 2002:a05:6830:6281:b0:718:9f3e:6bcb with SMTP id 46e09a7af769-71a77931870mr15140177a34.10.1732035771323;
        Tue, 19 Nov 2024 09:02:51 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71a782133f4sm3475168a34.66.2024.11.19.09.02.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2024 09:02:50 -0800 (PST)
Message-ID: <f0e35a14-f870-400f-b26a-ce6f212484ca@baylibre.com>
Date: Tue, 19 Nov 2024 11:02:50 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 07/16] spi: dt-bindings: axi-spi-engine: add SPI
 offload properties
To: Rob Herring <robh@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>, David Jander <david@protonic.nl>,
 Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org
References: <20241115-dlech-mainline-spi-engine-offload-2-v5-0-bea815bd5ea5@baylibre.com>
 <20241115-dlech-mainline-spi-engine-offload-2-v5-7-bea815bd5ea5@baylibre.com>
 <20241119165646.GA1798301-robh@kernel.org>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20241119165646.GA1798301-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/19/24 10:56 AM, Rob Herring wrote:
> On Fri, Nov 15, 2024 at 02:18:46PM -0600, David Lechner wrote:
>> The AXI SPI Engine has support for hardware offloading capabilities.
>> This includes a connection to a DMA controller for streaming RX data
>> and a trigger input for starting execution of the SPI message programmed
>> in the offload.
>>
>> Each SPI Engine may have up to 1 offload. The spec actually says that
>> it could support up to 32, so we are using an index number in the
>> dma-names (e.g. offload0-rx) to allow for this possibility in the
>> future.
>>
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>> ---
>>
>> v5 changes:
>> * Also document offload0-tx DMA names since the hardware can support
>>   that now.
>> * Limit the number of offloads to 1 for now since it would require
>>   significant hardware changes to actually support more than that.
>>
>> v4 changes:
>> * Dropped #spi-offload-cells property.
>> * Changed subject line.
>>
>> v3 changes:
>> * Added #spi-offload-cells property.
>> * Added properties for triggers and RX data stream connected to DMA.
>>
>> v2 changes:
>> * This is basically a new patch. It partially replaces "dt-bindings:
>>   iio: offload: add binding for PWM/DMA triggered buffer".
>> * The controller no longer has an offloads object node and the
>>   spi-offloads property is now a standard SPI peripheral property.
>> ---
>>  .../bindings/spi/adi,axi-spi-engine.yaml           | 24 ++++++++++++++++++++++
>>  1 file changed, 24 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/spi/adi,axi-spi-engine.yaml b/Documentation/devicetree/bindings/spi/adi,axi-spi-engine.yaml
>> index d48faa42d025..d703b47eb498 100644
>> --- a/Documentation/devicetree/bindings/spi/adi,axi-spi-engine.yaml
>> +++ b/Documentation/devicetree/bindings/spi/adi,axi-spi-engine.yaml
>> @@ -41,6 +41,26 @@ properties:
>>        - const: s_axi_aclk
>>        - const: spi_clk
>>  
>> +  trigger-sources:
>> +    description:
>> +      An array of trigger source phandles for offload instances. The index in
>> +      the array corresponds to the offload instance number.
> 
> How can you have an index when you only allow 1 entry (other than 0 of 
> course)?

Same reason as below, but we can drop that part of the description for now.

> 
>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> 
> With my other comments implemented, this should be dropped.
> 
>> +    maxItems: 1
>> +
>> +  dmas:
>> +    description:
>> +      DMA channels connected to the input or output stream interface of an
>> +      offload instance.
>> +    minItems: 1
>> +    maxItems: 2
>> +
>> +  dma-names:
>> +    items:
>> +      pattern: "^offload0-[tr]x$"
> 
> Do you expect an offload1 or something?

Yes, I tried to make this clear in the commit message. The hardware
is designed to have up to 32 offload instances, but in practice
there can only be 1 for now. So I included the 0 here to make it
future-proof in case that changes in the future.

> 
>> +    minItems: 1
>> +    maxItems: 2
>> +
>>  required:
>>    - compatible
>>    - reg
>> @@ -59,6 +79,10 @@ examples:
>>          clocks = <&clkc 15>, <&clkc 15>;
>>          clock-names = "s_axi_aclk", "spi_clk";
>>  
>> +        trigger-sources = <&trigger_clock>;
>> +        dmas = <&dma 0>;
>> +        dma-names = "offload0-rx";
>> +
>>          #address-cells = <1>;
>>          #size-cells = <0>;
>>  
>>
>> -- 
>> 2.43.0
>>


