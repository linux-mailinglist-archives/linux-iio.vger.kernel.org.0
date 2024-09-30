Return-Path: <linux-iio+bounces-9941-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E5998ACB2
	for <lists+linux-iio@lfdr.de>; Mon, 30 Sep 2024 21:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15BCF2831F1
	for <lists+linux-iio@lfdr.de>; Mon, 30 Sep 2024 19:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7D315E97;
	Mon, 30 Sep 2024 19:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="d7sqlWWJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D00199234
	for <linux-iio@vger.kernel.org>; Mon, 30 Sep 2024 19:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727724020; cv=none; b=rDhfvNZDeXfQ7oFmwOrG2zxU9YkhSoVUJxJqSlTHuQNoRdOKXfV1W07PRGiCAOscKI5PvY0cbXl4cAySMV4DcTJ3cIhxNmGRNpmMPAqeQhzy5FJnsV/OKiDE4E+IUvc1gJoOGyL8UGqZBQCbbVvGDJy2+/Ryun/3+D8+pHSNsTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727724020; c=relaxed/simple;
	bh=v33zJJImsgWY5WZ6J+4rL4X+i9E5OfT0yAer3DbY/EI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LmLFJvCoVR/BIRZsD5jsB9OqnTMUFLmYV8bqAEBUDTn/EERkSUDtdoESZU8Zw1dkhliJbtjdK6YAv+8dVrcHdVqiR9ovZ5y7H4BKMODca3NuQCCPsy6fgeTOdfCuyOqM+lCofzdmfoTTfYwrqaBuGgQgVuhvU2Zlc8BZvyJUXII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=d7sqlWWJ; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3e03974b6a5so2694889b6e.3
        for <linux-iio@vger.kernel.org>; Mon, 30 Sep 2024 12:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727724018; x=1728328818; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kTVVRMqsPGHu6bOYdoMoWVl7/YgauExSen9EjsdvUOQ=;
        b=d7sqlWWJ0WM8T13ksJ6durhLMp4VrSp2wIWSmh1uP7M41GI5LPl4cenP4THoSt40Ax
         1UFlXEoeb8YS9mbuUDNi4OEzNtdpRjsSRauRtGVCD866tMrI9nBbAT4/U/I41+S/joBA
         Vkv7BGqbhA8VTSUiHnde2KHP6xwyKFHHct/i7vxT5CeCLMTQ8k0agdXiDeyBmK0UZ95S
         a1TVR0lcYUPPuIJQLuRy11R5a4lUKfcyA0l/khVcM33Ft/523UZVVnepVBqBou+6E8uf
         p8fNX3rQiYVVH9qNFwzLueC2p7tx0WS257dpePu+85VMI8QOUaXoxIJ7U429tHoQU0FK
         v0Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727724018; x=1728328818;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kTVVRMqsPGHu6bOYdoMoWVl7/YgauExSen9EjsdvUOQ=;
        b=RCF+ldF3kvC6FNu6Cj3VE6A12rY9ipgH2pyO5R8gbvFKaSac8UQeE/N3i8IFWG8v7d
         h9X98pmlOj9hh55ad6zhvxeC+9Kjvy4Fo2vOmLE8losy4sVzXitasjZsYflB0hCSO4KO
         /h/ZBXFsFeUvgvG/Hu+ogR3NfAI7PxZCMGvdJcaCinjlpJSO2Q5U1mw/jxLKQm4dgCVM
         nX53S2BYvnGdiRAl3LNgb93Qo2OrFYGvRJVaANZwUAuHZ2ipWZLLma2aarXFGSUItGvd
         VeA6bSMbKEoJBOm0ZS55ZZRhR2D2woK977xz3/nMVhiBCO3qswVXVEHkswA5uGhexuvG
         SqWw==
X-Forwarded-Encrypted: i=1; AJvYcCX/rHLKkuMdIRbd1U3dI5mM4ESbfx7BOOeSDRPb51RyWHt7QTy+mPfFUqiqNudr9p6wQJ62+csgygw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxcjs12rB2Nz4HGAH537IknHWEh5ec4SIH83+uFlp3B0vFXCYEg
	8pcUninYwKYgdYbRQjjYiH7IBNgBSudgr4hS07C47bvbgAsCUoa6QmW62JBM2bU=
X-Google-Smtp-Source: AGHT+IFHzPyHZYh+zdE2H8Gm2U7gQ3q4+OkB0iAnn6eHXVEkNp8HCjYM7po70AdANgZRBSb9KNsr6Q==
X-Received: by 2002:a05:6808:bd5:b0:3d9:350b:4159 with SMTP id 5614622812f47-3e3939dcb37mr8405496b6e.31.1727724017728;
        Mon, 30 Sep 2024 12:20:17 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5e770da39fcsm2352823eaf.1.2024.09.30.12.20.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2024 12:20:16 -0700 (PDT)
Message-ID: <453ab98b-618f-45ba-9eab-e462829d25ae@baylibre.com>
Date: Mon, 30 Sep 2024 14:20:14 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/10] dt-bindings: iio: dac: ad3552r: add io-backend
 support
To: Angelo Dureghello <adureghello@baylibre.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Nuno Sa <nuno.sa@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-0-a17b9b3d05d9@baylibre.com>
 <20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-4-a17b9b3d05d9@baylibre.com>
 <20240929115150.6d1c22b3@jic23-huawei>
 <oh2xoym6dwvfn5lbzx3j5ckd3gfzvl2ukohrs4ukumkv6kzwi5@ume3z224gjta>
 <20240930154958.00004507@Huawei.com>
 <ipnqs4uektoysenkr7jvf6ic2rh56n3e5fmmheay323yhavs7u@th7qmxwmkiqo>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <ipnqs4uektoysenkr7jvf6ic2rh56n3e5fmmheay323yhavs7u@th7qmxwmkiqo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/30/24 10:08 AM, Angelo Dureghello wrote:
> On 30.09.2024 15:49, Jonathan Cameron wrote:
>> On Mon, 30 Sep 2024 16:15:41 +0200
>> Angelo Dureghello <adureghello@baylibre.com> wrote:
>>
>>> On 29.09.2024 11:51, Jonathan Cameron wrote:
>>>> On Thu, 19 Sep 2024 11:20:00 +0200
>>>> Angelo Dureghello <adureghello@baylibre.com> wrote:
>>>>   
>>>>> From: Angelo Dureghello <adureghello@baylibre.com>
>>>>>
>>>>> There is a version AXI DAC IP block (for FPGAs) that provides
>>>>> a physical bus for AD3552R and similar chips, and acts as
>>>>> an SPI controller.  
>>>>
>>>> Wrap is a bit short. Aim for < 75 chars for patch descriptions.
>>>>   
>>>>>
>>>>> For this case, the binding is modified to include some
>>>>> additional properties.
>>>>>
>>>>> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
>>>>> ---
>>>>>  .../devicetree/bindings/iio/dac/adi,ad3552r.yaml   | 42 ++++++++++++++++++++++
>>>>>  1 file changed, 42 insertions(+)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
>>>>> index 41fe00034742..aca4a41c2633 100644
>>>>> --- a/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
>>>>> +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
>>>>> @@ -60,6 +60,18 @@ properties:
>>>>>      $ref: /schemas/types.yaml#/definitions/uint32
>>>>>      enum: [0, 1, 2, 3]
>>>>>  
>>>>> +  io-backends:
>>>>> +    description: The iio backend reference.  
>>>>
>>>> Give a description of what the backend does in this case.  I.e. that it is
>>>> a qspi DDR backend with ...
>>>>   
>>>>> +      An example backend can be found at
>>>>> +        https://analogdevicesinc.github.io/hdl/library/axi_ad3552r/index.html
>>>>> +    maxItems: 1
>>>>> +
>>>>> +  adi,synchronous-mode:
>>>>> +    description: Enable waiting for external synchronization signal.
>>>>> +      Some AXI IP configuration can implement a dual-IP layout, with internal
>>>>> +      wirings for streaming synchronization.  
>>>>
>>>> I've no idea what a dual-IP layout is.  Can you provide a little more info
>>>> here?  What are the two IPs?
>>>>  
>>> IP is a term used in fpga design as "intellectual property", that is
>>> intended as a functional block of logic or data used to make a 
>>> field-programmable gate array module.
>>>
>>> A dual layout is just 2 same fpga modules in place of one.
>>>  
>>> I can add a "fpga" regerence to be more clear.
>>
>> IP I was familiar with.  I'm more interested in what each IP is doing in this
>> case.  Or at least an example of what sort of split of functionality might
>> make use of this.
>>
> 
> I have an image of the project (that is under development or testing now),
> not sure how to attach the image here, btw, something as
>  
>           axi_ad3552r_0  ----------->---- qspi0
>               sync_ext_device --.
>        .- external_sync          |
>        |                         |
>        |-------------<-----------                        
>        |
>        |   axi_ad3552r_1 ----------->---- qspi1
>        `- external_sync
>  
> My understanding is that it's just a method to use a octal spi,
> duplicating the transfer rate. I can collect more info in case.
> 

No, it's not for octal SPI. It is for synchronizing the data
transfer to two different DAC chips.

I think we need a bit more in the DT bindings for this to fully
describe the wiring shown. We need to indicate that both of the
two AXI AD3552R IP blocks have external_sync connected, so a
adi,external-sync flag could be used for this. Then we also need
to describe that sync_ext_device is only wired up on one of the
IP blocks. So we would need a separate adi,sync-ext-device flag.

Then the driver would use this information to A) know that we
need to set the external sync arm bit when starting buffered
reads and B) know that the buffered read for the IP block
instance with sync_ext_device needs to be started last so that
the data streams for both DACs will be synchronized.

