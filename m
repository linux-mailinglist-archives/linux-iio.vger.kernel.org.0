Return-Path: <linux-iio+bounces-8959-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0570968355
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 11:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 300811F2337F
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 09:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3A51D1F6B;
	Mon,  2 Sep 2024 09:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Y1OIv6H4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869E11D175A
	for <linux-iio@vger.kernel.org>; Mon,  2 Sep 2024 09:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725269631; cv=none; b=WDz/ZXpR1QRl+sTTUGCKs2mRRcgdPpeie9lKnpmxtUDJjYDv3LLczv+OX0a1Qw7aka000UTE72ckoPIrgmELDuSpjpVm9cqDk6whRFaeFplY8GVCLhyu4ZiIMfMMZVMoBT3VXpg1mpFceXbdZ1hDxkP79YHi6r76BOxB8gvE+po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725269631; c=relaxed/simple;
	bh=y+A77ehSMEo77rzqIfCQrVuaDj0WsgnwwsiyZ6QCQpA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=if5eg/R8yojmEAVkjuCBzEy1r16EeDMeUlzObCid64U02yifaAz1jHY6Y6SDEshgRsHE+LB2koycUaQ0FL60VvhestbDEUYvITaIsIOvOEf4OsJgLt2KN0nh9I7S2zR2NM8uPwZb7SmZgycndX9xUa5OoBjODWwlYsYHXGrfpuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Y1OIv6H4; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a83597ce5beso646676566b.1
        for <linux-iio@vger.kernel.org>; Mon, 02 Sep 2024 02:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725269626; x=1725874426; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MuJrpNL8FCioT2AsoPcDxssxH9cmo7gkd/f4U8NOJoI=;
        b=Y1OIv6H4aP6aPjEgvJe35WnAw7YrVq5NTLI7310C1QLHLPSrK7JL5PlkyLQjVjl7cl
         Uf92eMVQGhRuiBhRKNR4VHTQkD70wXlcWcSNaRywyc2Udywt86//LXDJNn4R9yP4O/5L
         W+w76Iv0L3KrclgTwjklP3xG9UPfVR8PpHVxSBO4VreHBmBeySvUN4zXBkf1HxDMFa/U
         biaMd85eeMgk5Q+Yp6BXJlFRcP9LRNJb+qYjHS3cGcOKibKXic1edJg2JTEWamJ4L2SW
         op1WSIO8z7KdxRo4RthOTZ45WJhmBQ02KcTJ5Q7US90UY1Zs0qHuYtaxYhI3gVjY79Mm
         ZTfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725269626; x=1725874426;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MuJrpNL8FCioT2AsoPcDxssxH9cmo7gkd/f4U8NOJoI=;
        b=R05FY9bzBSGcQXmSY7507iEATumflk+jcP0pg64QNUjSzBel6hU4K5Gn/v3/H8Ixdj
         Fa+4+VfyA4ANUu85TjgcPFTB5vPjihXMgLlSwjEEBpiJVxEyCLgp1En6ZjLq9cfMk+ML
         jAN+S5Ks/JYnAcevCGhPb78lug2NPYWiROE/r4+qmTgqntgNaSlQL9EiDOm8GUFo0bKL
         KtHhtm18xQ0AUxxkYtSCTS2d8qcV7cYUZwQi7nrrayMV7wBv0NuzEhIiC31a3P2ig4cf
         rZpqs3ia2uA8gRRwAsAZonyxZpexWFY7MNXmRUIH3gHFP2YAq2Exf0ML0m0TvuJs5qZP
         9eUA==
X-Forwarded-Encrypted: i=1; AJvYcCUdsvRqLS50J8HYZ5dkuBiK1GxbqAqIftlOcPWUJ2S67PqyVjnJwybj6NgJH3wkrgr+YemGSXNkfCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3NIhis/O92sLbKTKiKpO7gXNAZ12OeE05Z+kcCTof0K9CfnWJ
	sOhsSFY2fw6CgsJr+/waiaeZcGac5HCkMjFHfQ1ZhAe52ji/7PS+IR1v0oV0za4=
X-Google-Smtp-Source: AGHT+IH8IQSF54TrqnirzVUPM3gfRxOSIM2bNewiLS95Tg3bVdPb9PXS0rBILBbHq5Vdn1sRY++FLw==
X-Received: by 2002:a17:907:6d25:b0:a86:94cd:97f0 with SMTP id a640c23a62f3a-a89a26bfcb7mr1097377466b.19.1725269625733;
        Mon, 02 Sep 2024 02:33:45 -0700 (PDT)
Received: from [192.168.0.2] (host-95-233-232-76.retail.telecomitalia.it. [95.233.232.76])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a898900e73bsm532665366b.50.2024.09.02.02.33.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 02:33:45 -0700 (PDT)
Message-ID: <9015bc26-1a3a-49df-8728-12ceb8993035@baylibre.com>
Date: Mon, 2 Sep 2024 11:32:37 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 4/8] dt-bindings: iio: dac: add adi axi-dac bus
 property
To: Conor Dooley <conor@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dlechner@baylibre.com
References: <20240829-wip-bl-ad3552r-axi-v0-v1-0-b6da6015327a@baylibre.com>
 <20240829-wip-bl-ad3552r-axi-v0-v1-4-b6da6015327a@baylibre.com>
 <20240829-stopwatch-morality-a933abb4d688@spud>
 <d4eddc24-9192-4a4a-ac67-4cfbd429a6a9@baylibre.com>
 <20240830-quilt-appointee-4a7947e84988@spud>
Content-Language: en-US
From: Angelo Dureghello <adureghello@baylibre.com>
In-Reply-To: <20240830-quilt-appointee-4a7947e84988@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Conor,


On 30/08/24 5:33 PM, Conor Dooley wrote:
> On Fri, Aug 30, 2024 at 10:19:49AM +0200, Angelo Dureghello wrote:
>> Hi Conor,
>>
>> On 29/08/24 5:46 PM, Conor Dooley wrote:
>>> On Thu, Aug 29, 2024 at 02:32:02PM +0200, Angelo Dureghello wrote:
>>>> From: Angelo Dureghello <adureghello@baylibre.com>
>>>>
>>>> Add bus property.
>>> RFC it may be, but you do need to explain what this bus-type actually
>>> describes for commenting on the suitability of the method to be
>>> meaningful.
>> thanks for the feedbacks,
>>
>> a "bus" is intended as a generic interface connected to the target,
>> may be used from a custom IP (fpga) to communicate with the target
>> device (by read/write(reg and value)) using a special custom interface.
>>
>> The bus could also be physically the same of some well-known existing
>> interfaces (as parallel, lvds or other uncommon interfaces), but using
>> an uncommon/custom protocol over it.
>>
>> In concrete, actually bus-type is added to the backend since the
>> ad3552r DAC chip can be connected (for maximum speed) by a 5 lanes DDR
>> parallel bus (interface that i named QSPI, but it's not exactly a QSPI
>> as a protocol), so it's a device-specific interface.
>>
>> With additions in this patchset, other frontends, of course not only
>> DACs, will be able to add specific busses and read/wrtie to the bus
>> as needed.
>>
>>>> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
>>>> ---
>>>>    Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml | 9 +++++++++
>>>>    1 file changed, 9 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml b/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
>>>> index a55e9bfc66d7..a7ce72e1cd81 100644
>>>> --- a/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
>>>> +++ b/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
>>>> @@ -38,6 +38,15 @@ properties:
>>>>      clocks:
>>>>        maxItems: 1
>>> You mentioned about new compatible strings, does the one currently
>>> listed in this binding support both bus types?
> You didn't answer this, and there's insufficient explanation of the
> "hardware" in this RFC, but I found this which is supposedly the
> backend:
> https://github.com/analogdevicesinc/hdl/tree/main/library/axi_ad3552r
> adi,axi-dac.yaml has a single compatible, and that compatible has
> nothing to do with "axi_ad3552r" as it is "adi,axi-dac-9.1.b". I would
> expect either justification for reuse of the compatible, or a brand new
> compatible for this backend, even if the driver can mostly be reused.
>
> Could you please link to whatever ADI wiki has detailed information on
> how this stuff works so that I can look at it to better understand the
> axes of configuration here?

https://analogdevicesinc.github.io/hdl/library/axi_ad3552r/index.html

that has same structure and register set of the generic ADI AXI-DAC IP:
https://wiki.analog.com/resources/fpga/docs/axi_dac_ip


>>> Making the bus type decision based on compatible only really makes sense
>>> if they're different versions of the IP, but not if they're different
>>> configuration options for a given version.
>>>
>>>> +  bus-type:
>> DAC IP on fpga actually respects same structure and register set, except
>> for a named "custom" register that may use specific bitfields depending
>> on the application of the IP.
> To paraphrase:
> "The register map is the same, except for the bit that is different".
> If ADI is shipping several different configurations of this IP for
> different DACs, I'd be expecting different compatibles for each backend
> to be honest

i am still quite new to this fpga-based implementations, at least for how
such IPs are actually interfacing to the linux subsystem, so i may miss
some point.

About the "adi,axi-dac-9.1.b" compatible, the generic DAC IP register set
is mostly the same structure of this ad3552r IP (links above), except for
bitfields in the DAC_CUSTOM_CTRL register.

My choice for now was to add a bus-type property.

Not an HDL expert, but i think a different bus means, from an hardware 
point of
view, a different IP in terms of internal fpga circuitry, even if not as a
register-set.


> .
> If each DAC specific backend was to have a unique compatible, would the
> type of bus used be determinable from it? Doesn't have to work for all
> devices from now until the heath death of the universe, but at least for
> the devices that you're currently aware of?
>
>>> If, as you mentioned, there are multiple bus types, a non-flag property
>>> does make sense. However, I am really not keen on these "forced" numerical
>>> properties at all, I'd much rather see strings used here.
>>>> +    maxItems: 1
>>>> +    description: |
>>>> +      Configure bus type:
>>>> +        - 0: none
>>>> +        - 1: qspi
> Also, re-reading the cover letter, it says "this platform driver uses a 4
> lanes parallel bus, plus a clock line, similar to a qspi."
> I don't think we should call this "qspi" if it is not actually qspi,
> that's just confusing.

Agree, name should be something different.


> Cheers,
> Conor.

Thanks,
regards,

Angelo


>>>> +    enum: [0, 1]
>>>> +    default: 0
>>>> +
>>>>      '#io-backend-cells':
>>>>        const: 0
>>>>
>>>> -- 
>>>> 2.45.0.rc1
>>>>
>> -- 
>>   ,,,      Angelo Dureghello
>> :: :.     BayLibre -runtime team- Developer
>> :`___:
>>   `____:
>>
-- 
  ,,,      Angelo Dureghello
:: :.     BayLibre -runtime team- Developer
:`___:
  `____:


