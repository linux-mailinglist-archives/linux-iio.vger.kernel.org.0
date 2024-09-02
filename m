Return-Path: <linux-iio+bounces-9028-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF31F968E97
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 21:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 974FF28379A
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 19:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56261D54FA;
	Mon,  2 Sep 2024 19:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OsbFPBeM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60AA1C62BA
	for <linux-iio@vger.kernel.org>; Mon,  2 Sep 2024 19:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725307141; cv=none; b=b7OBnJA2vwPHNZrj9Bv+f5O5eKPKHxNiovT89meQnsxhFDfbNDaRQ0a/wllGDipNhKdqyv5/DTfJzVGV3PMI3KPGKY56jwgHvsnB7CUm0YoMpBRcC31BxBL2WHJd/eFtE5JozF6KJjl2sjwosBKUNS+i6CHVUiw6NwGx8V6AH8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725307141; c=relaxed/simple;
	bh=BwxqahULdSizwPJVSw8Q70Qp+MrKvqymtoV6o/RZaBE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t98NjbtvPeUOZd2+WjJbyxhFOz1107VwgUHfbcaVSnqtde5QK3AezedzkoxMg+DOrABd5khBmJZ2YOXgoAZacHb3BFzalyIyPHA+LAwkWb7EDouOo7RgYHDS0Xayb7wt7mWQLDO8HCkes5z2WQkKn2PiJoMyStSTcnBBWzhUFz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=OsbFPBeM; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5da686531d3so3077496eaf.3
        for <linux-iio@vger.kernel.org>; Mon, 02 Sep 2024 12:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725307138; x=1725911938; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QNrRj9OEWwXS7/Ii5F9yvEAGtDcXpYbQpO+jVkJw2nQ=;
        b=OsbFPBeMHZXpCQpigZnLrz2k0Utkf+AXHVpcQ8U6ANVc/Z0irpOMqZMjRNirh5t5Fc
         qxczXMJwpIxzoGWJEQ+4ngPghNRPFzBajeeV5hj63GlgYvcl+CaBN9AkRW4GMIvV3EKU
         nqrx1Ehv6Ok4g/BALp/BJZTeveIoVxNnPDioVuXpR6nwvH3rV1+AAmuQP0qu9KfWafK6
         +m+PJC84NxKQcnYDXobz1w0qVNxqQ6rC8KDpZbg2bxwD3bl35ZPA+VbMXxnnkvu3GSOO
         az3ABydfptHYvgzOfiZh6DgMtazMAKpos7tBjw+kfZAmvTwglp/M1g8BnziQAgXF5Yuw
         gxAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725307138; x=1725911938;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QNrRj9OEWwXS7/Ii5F9yvEAGtDcXpYbQpO+jVkJw2nQ=;
        b=V0SDNsI+/XFvmKk4wRc+I4rsbdHlmHd1hEts343lqEMGXwPueXW6g2ctlicOn1elvD
         bCFeImb4vElIyy7W7OMAAxsPuBIpuc/HGjFqAeD4L+edPfgSV8qcq/eSFp15a6gddvW0
         6ZcVFvql3XjIRUM7mrPr8hAZvBefjXV8vsZO4DEt1N6/9HXdcujLyFGBwS2MjGf7VHK5
         INvTzHlwy1fMq5XZwFp2+0DTiG746rFNhV9DjqNOv9Ck5xfajCGWfUA5Eb2kQI7MIXSz
         4/Kzl95ILXYNLHHwiD+8XVuDh6bETMe2bpr12xEodZUC605kcOcWYiFprsaPG8I5qMy1
         lclQ==
X-Gm-Message-State: AOJu0Yw9TTftfLqWYL/BHFNlqdH8JaVa5tmmKCyxbJG7FFAaUnB51kpd
	1yWJWCqdyvRQZu9uFb8vhuF+aBV6M7An1DMjlDB5MpYv6i4n/bFnVxxfGhtUgPg=
X-Google-Smtp-Source: AGHT+IFsaUEAvbfS9yCZfI6sbEtSOoGmThw+rj8MCi9eKTvz1FT2KgJBN8CmrO9BcPde4ptYtlffFw==
X-Received: by 2002:a05:6870:239e:b0:25e:d90:fe70 with SMTP id 586e51a60fabf-277d06c6275mr9311658fac.43.1725307138011;
        Mon, 02 Sep 2024 12:58:58 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-277fe2c5577sm546463fac.33.2024.09.02.12.58.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 12:58:57 -0700 (PDT)
Message-ID: <7cd270b3-9df3-41a6-82ee-43bab78f379b@baylibre.com>
Date: Mon, 2 Sep 2024 14:58:56 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/8] dt-bindings: iio: adc: add adi,ad7606c-{16,18}
 compatible strings
To: Alexandru Ardelean <aardelean@baylibre.com>,
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, jic23@kernel.org, krzk+dt@kernel.org,
 robh@kernel.org, lars@metafoo.de, michael.hennerich@analog.com,
 gstols@baylibre.com
References: <20240902103638.686039-1-aardelean@baylibre.com>
 <20240902103638.686039-8-aardelean@baylibre.com>
 <rdk2f6c457k462g5v6s5vumdmhejefyfareio5f6bogslg4wg5@ket4vfwwbyi7>
 <CA+GgBR-aQw+JHky5XwRDQj=6y1pHD=OvBeGW1ocd=ZR6ieBJrw@mail.gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <CA+GgBR-aQw+JHky5XwRDQj=6y1pHD=OvBeGW1ocd=ZR6ieBJrw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/2/24 1:38 PM, Alexandru Ardelean wrote:
> On Mon, Sep 2, 2024 at 2:55 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>
>> On Mon, Sep 02, 2024 at 01:36:30PM +0300, Alexandru Ardelean wrote:
>>>    reg:
>>> @@ -114,6 +118,25 @@ properties:
>>>        assumed that the pins are hardwired to VDD.
>>>      type: boolean
>>>
>>> +patternProperties:
>>> +  "^channel@([0-7])$":
>>> +    type: object
>>> +    $ref: adc.yaml
>>> +    unevaluatedProperties: false
>>> +
>>> +    properties:
>>> +      reg:
>>> +        description: The channel number.
>>> +        minimum: 0
>>> +        maximum: 7
>>> +
>>> +      diff-channels: true
>>
>> Shouldn't this be specific?
> 
> Umm.
> Specific how?
> Like if:then check for certain compatible strings?
> 

diff-channels is not a boolean property, it is an array of two
integers that specify the positive and negative pins. So this
should have e.g. minimum: and maximum: constraints for each
item in the array. Even if we only use this like a boolean flag
in the driver, we need to make the bindings use the already
established definition of diff-channels from adc.yaml.

It would look like this in the .dts:

    diff-channels = <1 1>;

The datasheet numbers the pins 1 to 8 instead of 0 to 7,
so it would make sense to have the pin number be reg + 1
(or redefine reg to be minimum: 1, maximum: 8).

We also recently introduced a single-channel property
that can be used when the pin number of of the input
doesn't match the reg number.

>>
>>> +
>>> +      bipolar: true
>>> +
>>> +    required:
>>> +      - reg
>>> +
>>>  required:
>>>    - compatible
>>>    - reg
>>> @@ -202,4 +225,44 @@ examples:
>>>              standby-gpios = <&gpio 24 GPIO_ACTIVE_LOW>;
>>>          };
>>>      };
>>> +  - |
>>> +    #include <dt-bindings/gpio/gpio.h>
>>> +    #include <dt-bindings/interrupt-controller/irq.h>
>>> +    spi {
>>> +        #address-cells = <1>;
>>> +        #size-cells = <0>;
>>> +
>>> +        adc@0 {
>>> +            compatible = "adi,ad7606c-18";
>>> +            reg = <0>;
>>> +            spi-max-frequency = <1000000>;
>>> +            spi-cpol;
>>> +            spi-cpha;
>>> +
>>> +            avcc-supply = <&adc_vref>;
>>> +            vdrive-supply = <&vdd_supply>;
>>> +
>>> +            interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
>>> +            interrupt-parent = <&gpio>;
>>> +
>>> +            adi,conversion-start-gpios = <&gpio 17 GPIO_ACTIVE_HIGH>;
>>> +
>>> +            adi,conversion-start-gpios = <&gpio 17 GPIO_ACTIVE_HIGH>;
>>> +            reset-gpios = <&gpio 27 GPIO_ACTIVE_HIGH>;
>>> +            adi,first-data-gpios = <&gpio 22 GPIO_ACTIVE_HIGH>;
>>> +            standby-gpios = <&gpio 24 GPIO_ACTIVE_LOW>;
>>> +
>>> +            adi,sw-mode;
>>> +
>>> +            channel@1 {
>>> +                reg = <1>;
>>> +                diff-channel;
>>
>> Where is this property defined (which schema)?
>>
>> Did you test it?
> 
> Tested on my board.
> But forgot to update the DT schema docs.
> Though, if you're referring to testing it somehow via some make
> command, I'm a little behind on how all this works now.
> I'll go re-check the "make dtbs_check" and similar commands.
> 
> Maybe I sound a bit old (now), but when I last saw these DT bindings
> going from txt-to-yaml, they seemed relatively simple.
> Now, they're almost like their own programming language.
> I'll search for some quick setup guides for these; any pointers are welcome :)

I can help you with this.



