Return-Path: <linux-iio+bounces-27524-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9792ECFE920
	for <lists+linux-iio@lfdr.de>; Wed, 07 Jan 2026 16:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74E053101E3F
	for <lists+linux-iio@lfdr.de>; Wed,  7 Jan 2026 15:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E639C3A1CE9;
	Wed,  7 Jan 2026 15:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJRGttIf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1A73A1CE3
	for <linux-iio@vger.kernel.org>; Wed,  7 Jan 2026 15:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767799139; cv=none; b=shWgqHxr9IwAZpVq8ZHJS5XoUg3dFjCR+a47jj3pVLP4nSPZJFSplIYVhhQWhIzOOGyI96xbKN1yuXMXJLNkgg4qtFG52iMhoe6twhqgWyydy4jGTponV8Pi1S9Qd85j25IjL1OANaxFnOe9zBphG8F+IV2IS1aoibaEsUtbzlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767799139; c=relaxed/simple;
	bh=tNf3XDsjmbqCnuHq9LIYRFhLNf4mHQKLUrqjBbo6sxc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BkAiUTVdoNoSUst2Oxyw/iRh/1945lQKGMFVpv+Lh+PDIjSlNGiFeFh4Qv5gE1/MnKeRTVmKfXlZwtZUZ2el6/DMiZZ2lt7kdbTij0mYisp/F4UPeA/kIlnP2QbAkcCduko9isUpKalrnJEhMqrNenCpPUdWjVNGZfls5CIfqOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DJRGttIf; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-477a2ab455fso21121715e9.3
        for <linux-iio@vger.kernel.org>; Wed, 07 Jan 2026 07:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767799133; x=1768403933; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hs7UTF9OYygppRuc29mz8ACnbiOzTDxmVFUfRrLLvNQ=;
        b=DJRGttIfUTjuNqYAbCrcYn1s29wMz3hmuNIACO+L6w8JqNLE5Cf41zckEmhoh6pGfT
         PoWfGd7zN/RLVT4RIQ2AKaxgBwfnCebkCObY7RsI2EDWNfs1XjWAhgeyk1C0Q1heL0Xz
         X0TfbCuaTNomiDIG5Qakb48vEcd5cVFJJsl+q8MB0N96NRvpdaSENbH8w4doBBvtxZFt
         dkc1HO2oBf619ttAM7G0vWoVS98K5wh9Tf9Y8YPHvCebtZPIOMxDfm0EgjneM3B6fuli
         jU24/uhoR1qeYmLj7v0fMY93hZ3NQDihsbtH9t6YBdu4wyh9TAPHY21v1r8XuV0jhu8I
         Df9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767799133; x=1768403933;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hs7UTF9OYygppRuc29mz8ACnbiOzTDxmVFUfRrLLvNQ=;
        b=hbPYpIeNhzqF+nNa94FICYmhRQtcIeCf1oyJtpnkOIIahYKrLquiyHtAJkew8rGMZO
         6/ozO+winFgy4MnJVYGZmi+oeleN3A2vWAKmbWydcinSB6p4sEJ5IkekYalOmQ8AjcC4
         2a4M8vLyXiLhdzfwD87kzv2xz5l/4SAN6HT5R+Sc0EVXpc0VVxetvGYykMIzMwnxi6PG
         5pSBijXHqN9zkGfpZtFP9YtZS/U9k5mZ18jvcCt9IGPKVwvbsYFGltRs2kGYv3/Ygoli
         Ob5GljPL0Avnk2dl2g1rHsRyUrwU3q355dREm3Yu6WBfBSzrXBQSKc1Dx4CQknjcf7bA
         ON6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWCAii52ypDCiCyJLEU3e9h6MU4gUj+TN7bS1WCWc2xDn/sYLfT2sMAcTOUGAPuYbrT1XxXMM3SVgY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9CDdBLPimwiyJ1DFTfm3k7+t9yuN8SjCiKTmEuyuVtC20fobN
	1VeJKSbNzM2ONjv8nxz1OIVQ86t/UmFkKsIae/xqGzagEQt6d2wxn4s/
X-Gm-Gg: AY/fxX50FvpibXOtawGLpLK1VoXWuQZTYLG8rOlGqoxzhvGzFjKL8Q0vAZHqfHUuZCl
	3BjyK4npuG7AjKzekdbKlv74wXRNYLOwWs5ggO9DIOQI14rWxNN9AaW3lDJ7oTvILO8Dp6eodq0
	SSP3Es8Lvmc1Tnz5bHFH3PD943odXWwC8CnG8tD5ZZzGn7x3fkyPWf09qyRfRFpLpwTffpZjP9y
	PSAED9L1XSeI/ARuurB5U1o3GlrF0mOoEG7NcaZj1LiL9V5TC9ktrDDwEM56/nGnA3ZhRRZxuXE
	Ca+I2nRu2ji6/9gHmIidNUK4irND3MRRLqJbyItvONu5i38S+mnHjL/nbJ/N7mW3m9pL+nGco/w
	7Q5IvlHMrsaim3tYT74YLCqBpvtCG7TbkU2iwFL0kiXtUFaGHPI8byfgpRHcaS+R4PqC3ehhzlw
	Zb3OHrAyxli1l6Vt8=
X-Google-Smtp-Source: AGHT+IHTvz1Je3JayvbprZONkEuGoye7ddyIvvyBYEi4WT32a73ymDQLhohQBmrkRjpi5o5aSJm9iw==
X-Received: by 2002:a05:6000:2504:b0:432:aa5a:3916 with SMTP id ffacd0b85a97d-432c37950b7mr3983445f8f.40.1767799133334;
        Wed, 07 Jan 2026 07:18:53 -0800 (PST)
Received: from [172.24.138.145] ([137.71.226.102])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0e199bsm10937637f8f.16.2026.01.07.07.18.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jan 2026 07:18:52 -0800 (PST)
Message-ID: <2b675aed-eef0-462c-b412-5cc8cd91e864@gmail.com>
Date: Wed, 7 Jan 2026 16:18:49 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: iio: dac: Add max22007
To: Jonathan Cameron <jonathan.cameron@huawei.com>,
 Janani Sunil <janani.sunil@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Alexandru Ardelean <alexandru.ardelean@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 jan.sun97@gmail.com, gastmaier@gmail.com
References: <20251219-max22007-dev-v1-0-242da2c2b868@analog.com>
 <20251219-max22007-dev-v1-1-242da2c2b868@analog.com>
 <20251219164002.00004c74@huawei.com>
Content-Language: en-US
From: Janani Sunil <jan.sun97@gmail.com>
In-Reply-To: <20251219164002.00004c74@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Johnathan,

Thank you for your reviewing the patch.

On 12/19/25 17:40, Jonathan Cameron wrote:
> On Fri, 19 Dec 2025 16:31:15 +0100
> Janani Sunil <janani.sunil@analog.com> wrote:
>
> Hi Janani and welcome to IIO.
>
>
>> Devicetree bindings for MAX22007 4-channel
>> 12-bit DAC that drives a voltage or current
>> output on each channel
> This is a very short wrap. Aim for 75 characters in patch description lines
> (so slightly shorter than 80 chars standard for everything else).

Noted your point. Will update the message.

>> Signed-off-by: Janani Sunil <janani.sunil@analog.com>
>> ---
>>   .../devicetree/bindings/iio/dac/adi,max22007.yaml  | 116 +++++++++++++++++++++
>>   MAINTAINERS                                        |   7 ++
>>   2 files changed, 123 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/iio/dac/adi,max22007.yaml b/Documentation/devicetree/bindings/iio/dac/adi,max22007.yaml
>> new file mode 100644
>> index 000000000000..c2f65d9e42d4
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/dac/adi,max22007.yaml
> ...
>
>> +  vdd-supply:
>> +    description: Low-Voltage Power Supply from +2.7V to +5.5V.
>> +
>> +  hvdd-supply:
>> +    description:
>> +      Positive High-Voltage Power Supply from +8V to (HVSS +24V) for
>> +      the Output Channels.
>> +
>> +  hvss-supply:
>> +    description:
>> +      Negative High-Voltage Power Supply from -2V to 0V for the Output Channels.
>> +
>> +  reset-gpios:
>> +    maxItems: 1
>> +    description:
>> +      GPIO used for hardware reset of the device.
>> +
>> +patternProperties:
>> +  "^channel@[0-3]$":
>> +    allOf:
>> +      - $ref: /schemas/iio/dac/dac.yaml#
>> +      - type: object
>> +        description:
>> +          Represents the external channels which are connected to the DAC.
>> +          Channels not specified in the device tree will be powered off.
>> +
>> +        properties:
>> +          reg:
>> +            description: Channel number
>> +            maxItems: 1
> min / max?

Shall add the values.

>
>> +
>> +          adi,type:
>> +            description: Channel output type.
>> +            $ref: /schemas/types.yaml#/definitions/string
>> +            enum: [voltage, current]
> This is much more constrained (as only two types of channel) but we do have
> precedence for adi,ch-func in adi,ad74115.yaml and adi,ad74413r.yaml
>
> That's not a particularly pretty binding but we should probably stick to
> it anyway.
>
> adi,type is too vague a name for this property anyway.

Agreed. adi,ch-func seems to be a best fit here. Shall reuse it.

>
>> +
>> +        required:
>> +          - reg
>> +          - adi,type
>> +
>> +        unevaluatedProperties: false
>> +
>> +required:
>> +  - compatible
> For supplies we document as required any that are needed for the device
> to function, whether or not we happen to need to specify them on
> a given board (given fallbacks that apply on assumption that fixes
> always on supplies are in use).  So I'd expect to see at least some
> of the supplies listed here.

Noted. I shall update the required power supplies.

>> +  - reg
>> +
>> +anyOf:
>> +  - required: [channel@0]
>> +  - required: [channel@1]
>> +  - required: [channel@2]
>> +  - required: [channel@3]
> Interesting. I'm not sure we have never bothered to document this before and there
> are other devices for which some sort of channel config is pretty much needed.
> What is the justification to have this explicitly listed here?

There is no need for the channels to be explicitly mentioned here. I Shall drop them.

>
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/gpio/gpio.h>
>> +    spi {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +
>> +        dac@0 {
>> +            compatible = "adi,max22007";
>> +            reg = <0>;
>> +            spi-max-frequency = <500000>;
>> +            reset-gpios = <&gpio 19 GPIO_ACTIVE_LOW>;
>> +            #address-cells = <1>;
>> +            #size-cells = <0>;
>> +
>> +            channel@0 {
>> +                reg = <0>;
>> +                adi,type = "voltage";
>> +            };
>> +
>> +            channel@1 {
>> +                reg = <1>;
>> +                adi,type = "current";
>> +            };
>> +        };
>> +    };
>> +...

Thank you,
Janani Sunil


