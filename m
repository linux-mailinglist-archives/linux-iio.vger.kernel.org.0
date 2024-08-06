Return-Path: <linux-iio+bounces-8273-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E3589490E8
	for <lists+linux-iio@lfdr.de>; Tue,  6 Aug 2024 15:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 587C128477B
	for <lists+linux-iio@lfdr.de>; Tue,  6 Aug 2024 13:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24D51D6DC6;
	Tue,  6 Aug 2024 13:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="tBbKpwkc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A441D2793
	for <linux-iio@vger.kernel.org>; Tue,  6 Aug 2024 13:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722950271; cv=none; b=S+3/ABjb7xW+rnWRr7zNF8FIHBEL+/pLULyrocG3BeuWy3qu3qXQVpFdWLmCiPkD4e7+lfXEikiEpScU9mUmUriKC+7JTbhyDGH3wBdAWOIHDZSvl0o3QE+f5C4J3l+w6t+ieCm3HOKBJXHLjLgQMuu+DBONuvEf3gs3Z/YbRMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722950271; c=relaxed/simple;
	bh=TpcolhcYzJa7mTrUihg1Dco8chyK0t/QbKkXU6IEoTI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GHo0D9imx1usNFn0IP9OkdM48PZVQGgXXvss9rVx2EL8R6BmgwvGNCEAXTgfuPip8M5JhHhfWYPABtRELB6H9nj2uB431/i7d1T9qzjWVgWwdp3godpbb1uBou6Q+XUMeMjjcLnn5M1Gnyo9Oa4AoRV4yXF5zloB5SiE4a9w7dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=tBbKpwkc; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7a20b8fa6dcso39997385a.3
        for <linux-iio@vger.kernel.org>; Tue, 06 Aug 2024 06:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722950267; x=1723555067; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JwGghAF8hyP3IJRX7Y5WfGijoa+R+QrWJZw4g1mdI54=;
        b=tBbKpwkcloYsK/Rfm8DOjgilCDlSHMZ64fPM0ELbw2bxI/Skkfj1XmKk+ymMa6Eycl
         vy09e48+h8WHDxTUMFU9Xj7CnrCdi07zGXGXbG1g+40G7y3gjyD/QmGC9c7SD60hUagB
         /ID8Pa7AOt+XIU2bYqr7t7XFWIQRLRjXNZhf8Bdqn18GJOzQJxV/1d6J2k5zQlYmNsU/
         UAio2wKr7C4Ob6m3WFddrSQlFMMpN9A/HSR11o+9NvkoaYQ0K0fMSDeY932rAP5Epg9+
         UnVJyOccrH4Q8VFDgPPBhen3I9ny2cSFaVcilKpOGDGDUomgPemtgS5r4KH5jqL1KP0q
         rirw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722950267; x=1723555067;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JwGghAF8hyP3IJRX7Y5WfGijoa+R+QrWJZw4g1mdI54=;
        b=OhUZYJPINZ/H4z3RIKrI8l6ndazHLaKDr9T/++B5nDp1fC60K/wfPzIw87V/zG6pLf
         OSwu8ovZGROK35mtHMYAFrDLina+3OwZAza7mGTydmquExo4qE0ANpHCj8Bnsrl2iGxV
         Yo69w52ZQ+fKXe+dk8gdQfnG9j06ijQ3sadwHripM04U0an2VZbEIMS3hFQ+BoDAnRVB
         geJmANatUeWoJYdjshVwSdSxmRZhItEK8eYudeHob1v5LmKACpfTbZq9uLdXHrZTr75K
         bZY41G3scJsO7VdHdVnwdtZi84EKELz/XwmtMBWHmrr7DHciw3SQmWzewEDkRexTPXI9
         GIug==
X-Forwarded-Encrypted: i=1; AJvYcCXWVI4sdGe3ROBPGmQ6QHxgBAaaSW9TKUhoGqI+XqGIpTKuMdvzoEmYGVXdjogWjiGQ51UdbkrD/Ls=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN3SeK8qKkGiJ/Axv6G5ncpMDTDPmb+5saeyPx0uK4R3KHww4Q
	CNR57SPzMrsNLPSoKgzsbasZ0j204vt4zS/3XZJmP/7kGHYxYr73Mz5gwl/FPoU=
X-Google-Smtp-Source: AGHT+IHzKLrhY/8VXF9noaAho1m5/YXRwzmbEuqnqzJp2DTDVn5/I6ZeJjvlf35HsDfdnjpYKyPiiw==
X-Received: by 2002:a05:620a:4153:b0:7a1:d08b:5b7d with SMTP id af79cd13be357-7a34efdd375mr1620618585a.62.1722950267494;
        Tue, 06 Aug 2024 06:17:47 -0700 (PDT)
Received: from [192.168.40.12] (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a35f3fc336sm310851385a.22.2024.08.06.06.17.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 06:17:47 -0700 (PDT)
Message-ID: <46be10c0-7ee9-489b-afc9-0e0411200d7e@baylibre.com>
Date: Tue, 6 Aug 2024 09:17:45 -0400
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/3] dt-bindings: iio: adc: add AD762x/AD796x ADCs
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 David Lechner <dlechner@baylibre.com>,
 Uwe Kleine-Konig <u.kleine-koenig@baylibre.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>
References: <20240731-ad7625_r1-v1-0-a1efef5a2ab9@baylibre.com>
 <20240731-ad7625_r1-v1-1-a1efef5a2ab9@baylibre.com>
 <20240803153540.17627489@jic23-huawei>
Content-Language: en-US
From: Trevor Gamblin <tgamblin@baylibre.com>
In-Reply-To: <20240803153540.17627489@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

On 2024-08-03 10:35 a.m., Jonathan Cameron wrote:
> On Wed, 31 Jul 2024 09:48:03 -0400
> Trevor Gamblin <tgamblin@baylibre.com> wrote:
>
>> This adds a binding specification for the Analog Devices Inc. AD7625,
>> AD7626, AD7960, and AD7961 ADCs.
> Given the RFC question is effectively about the binding and may influence
> it a lot - make sure it's talked about here!
>
>> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
>> ---
>>   .../devicetree/bindings/iio/adc/adi,ad7625.yaml    | 176 +++++++++++++++++++++
>>   MAINTAINERS                                        |   9 ++
>>   2 files changed, 185 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7625.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7625.yaml
>> new file mode 100644
>> index 000000000000..e88db0ac2534
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7625.yaml
>> @@ -0,0 +1,176 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/iio/adc/adi,ad7625.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Analog Devices Fast PulSAR Analog to Digital Converters
>> +
>> +maintainers:
>> +  - Michael Hennerich <Michael.Hennerich@analog.com>
>> +  - Nuno Sá <nuno.sa@analog.com>
>> +
>> +description: |
>> +  A family of single channel differential analog to digital converters
>> +  in a LFCSP package. Note that these bindings are for the device when
>> +  used with the PulSAR LVDS project:
>> +  http://analogdevicesinc.github.io/hdl/projects/pulsar_lvds/index.html.
> As per the discussion in the cover letter I think the need to represent
> if the DCO+ is connected between ADC and LVDS converter strongly suggests
> we shouldn't represent it as one aggregate device.

Just to be sure, do you mean that the PulSAR LVDS functionality should 
be split into its own driver and then utilized by ad7625?

Thank you for the feedback. I'll work on updates for all of your replies.

- Trevor

>
>> +
>> +  * https://www.analog.com/en/products/ad7625.html
>> +  * https://www.analog.com/en/products/ad7626.html
>> +  * https://www.analog.com/en/products/ad7960.html
>> +  * https://www.analog.com/en/products/ad7961.html
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - adi,ad7625
>> +      - adi,ad7626
>> +      - adi,ad7960
>> +      - adi,ad7961
>> +
>> +  vdd1-supply:
>> +    description: A supply that powers the analog and digital circuitry.
> Doesn't really tell us anything. I'd just go with
>      vdd1-supply: true
>      vdd2-supply: true
>      vio-supply: true
>
>
>> +
>> +  vdd2-supply:
>> +    description: A supply that powers the analog and digital circuitry.
>> +
>> +  vio-supply:
>> +    description: A supply for the inputs and outputs.
>> +
>> +  ref-supply:
>> +    description:
>> +      Voltage regulator for the external reference voltage (REF).
>> +
>> +  refin-supply:
>> +    description:
>> +      Voltage regulator for the reference buffer input (REFIN).
>> +
>> +  clocks:
>> +    description:
>> +      The clock connected to the CLK pins, gated by the clk_gate PWM.
>> +    maxItems: 1
>> +
>> +  pwms:
>> +    maxItems: 2
>> +
>> +  pwm-names:
>> +    maxItems: 2
>> +    items:
>> +      - const: cnv
>> +        description: PWM connected to the CNV input on the ADC.
>> +      - const: clk_gate
>> +        description: PWM that gates the clock connected to the ADC's CLK input.
>> +
>> +  io-backends:
>> +    description:
>> +      The AXI ADC IP block connected to the D+/- and DCO+/- lines of the ADC.
> So you have a backend. Great - we have something to indicate a connection
> to or not for the DCO+/o lines.  It's a bit ugly to just repesent it as a clk
> but that would I think work.
>
>> +    maxItems: 1
>> +
>> +  adi,en0-always-on:
>> +    $ref: /schemas/types.yaml#/definitions/flag
>> +    description:
>> +      Indicates if EN0 is hard-wired to the high state. If neither this
>> +      nor en0-gpios are present, then EN0 is hard-wired low.
> It's unfortunate there isn't a special 'fixed' gpio-chip option where we could
> just query it is fixed and what the state of the pin is.  This is getting
> quite common so would be good to have a better solution.
>
> Linus, Bartosz - is there a better way to do this?
>
>> +
>> +  adi,en1-always-on:
>> +    $ref: /schemas/types.yaml#/definitions/flag
>> +    description:
>> +      Indicates if EN1 is hard-wired to the high state. If neither this
>> +      nor en1-gpios are present, then EN1 is hard-wired low.
>> +
>> +  adi,en2-always-on:
>> +    $ref: /schemas/types.yaml#/definitions/flag
>> +    description:
>> +      Indicates if EN2 is hard-wired to the high state. If neither this
>> +      nor en2-gpios are present, then EN2 is hard-wired low.
>> +
>> +  adi,en3-always-on:
>> +    $ref: /schemas/types.yaml#/definitions/flag
>> +    description:
>> +      Indicates if EN3 is hard-wired to the high state. If neither this
>> +      nor en3-gpios are present, then EN3 is hard-wired low.
>> +
>> +  en0-gpios:
>> +    description:
>> +      Configurable EN0 pin.
>> +
>> +  en1-gpios:
>> +    description:
>> +      Configurable EN1 pin.
>> +
>> +  en2-gpios:
>> +    description:
>> +      Configurable EN2 pin.
>> +
>> +  en3-gpios:
>> +    description:
>> +      Configurable EN3 pin.
>> +
>> +required:
>> +  - compatible
>> +  - vdd1-supply
>> +  - vdd2-supply
>> +  - vio-supply
>> +  - clocks
>> +  - pwms
>> +  - pwm-names
>> +  - io-backends
>> +
>> +- if:
>> +  properties:
>> +    compatible:
>> +      contains:
>> +        enum:
>> +	  - adi,ad7625
>> +	  - adi,ad7626
>> +  then:
>> +    properties:
>> +      en2-gpios: false
>> +      en3-gpios: false
>> +      adi,en2-always-on: false
>> +      adi,en3-always-on: false
>> +    allOf:
>> +      # ref-supply and refin-supply are mutually-exclusive (neither is also
>> +      # valid)
>> +      - if:
>> +          required:
>> +            - ref-supply
>> +        then:
>> +          properties:
>> +            refin-supply: false
>> +      - if:
>> +          required:
>> +            - refin-supply
>> +        then:
>> +          properties:
>> +            ref-supply: false
>> +
>> +- if:
>> +  properties:
>> +    compatible:
>> +      contains:
>> +        enum:
>> +	  - adi,ad7960
>> +	  - adi,ad7961
>> +  then:
>> +    oneOf:
>> +      required:
>> +        - ref-supply
>> +      required:
>> +        - refin-supply
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    adc {
>> +        compatible = "adi,ad7625";
>> +        vdd1-supply = <&supply_5V>;
>> +        vdd2-supply = <&supply_2_5V>;
>> +        vio-supply = <&supply_2_5V>;
>> +        io-backends = <&axi_adc>;
>> +        clock = <&ref_clk>;
>> +        pwms = <&axi_pwm_gen 0 0>, <&axi_pwm_gen 1 0>;
>> +        pwm-names = "cnv", "clk_gate";
>> +    };
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 42decde38320..2361f92751dd 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1260,6 +1260,15 @@ F:	Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml
>>   F:	drivers/iio/addac/ad74413r.c
>>   F:	include/dt-bindings/iio/addac/adi,ad74413r.h
>>   
>> +ANALOG DEVICES INC AD7625 DRIVER
>> +M:	Michael Hennerich <Michael.Hennerich@analog.com>
>> +M:	Nuno Sá <nuno.sa@analog.com>
>> +R:	Trevor Gamblin <tgamblin@baylibre.com>
>> +S:	Supported
>> +W:	https://ez.analog.com/linux-software-drivers
>> +W:	http://analogdevicesinc.github.io/hdl/projects/pulsar_lvds/index.html
>> +F:	Documentation/devicetree/bindings/iio/adc/adi,ad7625.yaml
>> +
>>   ANALOG DEVICES INC AD7768-1 DRIVER
>>   M:	Michael Hennerich <Michael.Hennerich@analog.com>
>>   L:	linux-iio@vger.kernel.org
>>

