Return-Path: <linux-iio+bounces-6171-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31BDD90330D
	for <lists+linux-iio@lfdr.de>; Tue, 11 Jun 2024 08:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6B921F274DB
	for <lists+linux-iio@lfdr.de>; Tue, 11 Jun 2024 06:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E64B171E4C;
	Tue, 11 Jun 2024 06:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CRDA086L"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF61171672
	for <linux-iio@vger.kernel.org>; Tue, 11 Jun 2024 06:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718088712; cv=none; b=RoULpnhYukB13Z0+N7/rW0las+2HplZnAORTyQTSINEW7RheWoxDLiSwre9l4znYp9QwjMMxub+QdJ5xLEzge0FlZsrLUDZjQMopaxI3AhR5q5sbxdqC4LSOvEAraWtqcWXs9pR915WwqL9pBi4f/ZF8afBaJI3AcldQ1szIM00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718088712; c=relaxed/simple;
	bh=xPaKqZXY8+rZSzCNEHIXxp0fXCO0Yb0gtSM3Yp6G/P0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YjSfSOhYh4wiQwwyST75Uqz3TOGNZWpbHoQY25Sxb1i+z50FUHGzxcGVA6ZkGUy32S3EFcbUcjsFhqJrkJ0zSulKlTHDQ16T44CDBmXpEd3VF948zQG9XY7pX7t/M6vNlmEN0MiZewJE53zWc01M/TgoCiMJWd7VivonGK1CwBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CRDA086L; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52bc1261e8fso3975451e87.0
        for <linux-iio@vger.kernel.org>; Mon, 10 Jun 2024 23:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718088709; x=1718693509; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=z38MPwFQKXdREohYh3s3TC8Pf+UGMYC2uW4CqnuIGJA=;
        b=CRDA086Lk2Wscye+62Mbe4JIpQ1ZJ8QQGs7s+DnOzuf0Z/wGjvlebB78pvbxwZ9OIo
         KM2O1cKBMidNx+76/mwx96C4RIa6EiZ4LLNPBBVpfDHbHx7C5PE7lkcfSjKFpGzSnLP7
         U52CdnqFTwNHlMgAJM2gcSJXEEBXuBGtEtJku67C/W35cqG1KO2y9kQa0gFuFoUmN2uF
         AV1rpgVnE5pfe5ySFPcV8JaXVeuJiSIGuL9G9ARbWx/4lpdzXW+Mr54aBTjpRvBOoN/a
         Y76ALIBypekDrChWvasMFPTZpS+NR2+WclXR+0Z96/F2HBNlPJpcqxNACVudPUnQybah
         rvGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718088709; x=1718693509;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z38MPwFQKXdREohYh3s3TC8Pf+UGMYC2uW4CqnuIGJA=;
        b=PzLRwuz47pmekQ88oZYiE6NejfT6u3CHT/9tk+23ZQnfcVGbm4bWKOH01jS+a6g+VA
         697lJERa0AI5ovhCaKIkLGJauI9QBs0ozkuV02zZ4Rvs0zWsAzAME3FAYNf+EhGlFAFU
         w7EL2d4eFh7BwnYK5DNgxGhrX6wksIHvArbSB/EyfJK30YDYNaAsAr6/bzgpWwKkx718
         1RjUmRV6NF12aBgHFyBm2huSQO+5bO01NQI/b2JiGHOGe4+JCiE07ec9dqi5aaAXpx51
         oeYydgWFIqvP8414GL2Pz0vySfFBNvjcpnzqh0E5TsCirwIMSf46uZ2kIOPl7Ix8vg6A
         I9Tg==
X-Gm-Message-State: AOJu0YyJON+T4lkDyKCSYNTOKowlUaCZZBp4iw+1s2mWLaMYF/NaZA3o
	fRiOb8dJ75SN53KFiysM3jIaiPbN3yUMIk2dDEXO16Zd+QCs32ndlMmzL6/oTIY=
X-Google-Smtp-Source: AGHT+IFUXACqMPP5rYDfAaS7Ux21IP0rI+n3GTObz8SP/rhmlr6cYYe6cmvZgVJc+4n+xDE0bDIzog==
X-Received: by 2002:a05:6512:158e:b0:52c:8df9:2e6f with SMTP id 2adb3069b0e04-52c8df92eeemr2792169e87.42.1718088709319;
        Mon, 10 Jun 2024 23:51:49 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4221defede0sm31072695e9.7.2024.06.10.23.51.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 23:51:48 -0700 (PDT)
Message-ID: <b72164f9-1b1b-4329-8d4a-66fc626c45fe@linaro.org>
Date: Tue, 11 Jun 2024 08:51:47 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/8] dt-bindings: counter: Add new ti,am62-eqep
 compatible
To: Judith Mendez <jm@ti.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Vignesh Raghavendra <vigneshr@ti.com>,
 Tero Kristo <kristo@kernel.org>, linux-arm-kernel@lists.infradead.org,
 David Lechner <david@lechnology.com>, Nishanth Menon <nm@ti.com>,
 William Breathitt Gray <wbg@kernel.org>
References: <20240610144637.477954-1-jm@ti.com>
 <20240610144637.477954-2-jm@ti.com>
 <5ad5cf7a-c5c6-449e-9ed9-3d9f74959a19@linaro.org>
 <01433df1-aa19-4abb-9d87-c54e4c0dff17@ti.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <01433df1-aa19-4abb-9d87-c54e4c0dff17@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/06/2024 00:13, Judith Mendez wrote:
> 
> Hi Krzysztof,
> 
> On 6/10/24 9:58 AM, Krzysztof Kozlowski wrote:
>> On 10/06/2024 16:46, Judith Mendez wrote:
>>> Add new compatible ti,am62-eqep for TI K3 devices. If a device
>>> uses this compatible, require power-domains property.
>>>
>>> Since there is only one functional and interface clock for eqep,
>>> clock-names is not really required, so removed from required
>>> section, make it optional for ti,am3352-eqep compatible, and
>>> update the example.
>>>
>>
>> ...
>>
>>
>>>           interrupts = <79>;
>>>       };
>>>   
>>> +  - |
>>> +    #include <dt-bindings/interrupt-controller/irq.h>
>>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>>> +    #include <dt-bindings/soc/ti,sci_pm_domain.h>
>>> +
>>> +    bus {
>>> +        #address-cells = <2>;
>>> +        #size-cells = <2>;
>>> +        eqep1: counter@23210000 {
>>
>> No need for label
>>
>>> +          compatible = "ti,am62-eqep";
>>> +          reg = <0x00 0x23210000 0x00 0x100>;
>>> +          power-domains = <&k3_pds 60 TI_SCI_PD_EXCLUSIVE>;
>>> +          clocks = <&k3_clks 60 0>;
>>> +          interrupts = <GIC_SPI 117 IRQ_TYPE_EDGE_RISING>;
>>> +          status = "disabled";
>>
>> Drop... which also points to another comment - since this was no-op and
>> example is basically the same, then just don't add it. No point.
> 
> Ok, then I will drop the new example, thanks.
> 
> BTW..
> In the existing example for ti,am3352-eqep compatible,
> do you know if it is appropriate to drop clock-names
> from the example if it is no longer required?
> 

It does not really matter.

Best regards,
Krzysztof


