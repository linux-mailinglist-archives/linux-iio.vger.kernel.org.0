Return-Path: <linux-iio+bounces-9064-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8115E969512
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 09:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 387C828527F
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 07:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A943E1D6C61;
	Tue,  3 Sep 2024 07:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VhbI5/Jy"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B631D6C46;
	Tue,  3 Sep 2024 07:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725347884; cv=none; b=LW9yuFhSJpsjj8zKzvSaO8+NIBG3C+nPyWC0jnxubf+iaFDbfZ6bC1jRcP4Tf3PGerM5Q14OGkv0k3Skg2vj0BetNIoykxr4ShWNfki2RRD4JbZaIhoeO2BOR6W2IqtPN1ovw37+Atb8BwTE9nwhzbxvwZBcUPPcZt7aooNUYZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725347884; c=relaxed/simple;
	bh=HVeAkL5CWXAqfefRARoQz/L8jPq0kRqOZGCOf0JhsUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z1dVeQtcJ89RVbIXPxO8byLigc4KQJadDYtCHsqqjgBqcwrmAi7Ou1nFFVaEtAmB18TK+HxdS/i3Sp9KYuObfZ+tz7zQTm5yuQiBT5jVuZxIcXUWnMjKHSlZDIotMekb9db9HLco62gdYCISFa09CtTRvNbaw1Iey5ukqENSd8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VhbI5/Jy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79C40C4CEC5;
	Tue,  3 Sep 2024 07:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725347883;
	bh=HVeAkL5CWXAqfefRARoQz/L8jPq0kRqOZGCOf0JhsUw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VhbI5/Jy2nRZ6EQLWpC7i5bKPl8N16vUcAu+c/A79MwFFt49GTAmkDoMerhNrYWiL
	 hOMvKqFYey+NdmMLgUoC2TfqLKo7PFrOvAUHStOiJ8Js44HN/woAsVFksV89Ur2gPf
	 DA6kQcVMWPL2J3ikhREOakDilI9Mu1do3OynDDj0pC52VYx99AntORYAf4vtPPvPhA
	 wVtiseVcigXS39MyQQjWzTQku7LoN74cs1dnlqj77toc+F733S9QarJujNNMUjByoF
	 scgwmKHWlNvVucyr1k9T5pHFSQT82GJ7lQJZL3EQEsALX3n6FwjO4AngrjxTwROVla
	 DZf7c8d1iM1ww==
Message-ID: <05d3bdc1-22f7-4c4d-995d-84eceae3c3eb@kernel.org>
Date: Tue, 3 Sep 2024 09:17:57 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/8] dt-bindings: iio: adc: add adi,ad7606c-{16,18}
 compatible strings
To: Alexandru Ardelean <aardelean@baylibre.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, jic23@kernel.org, krzk+dt@kernel.org,
 robh@kernel.org, lars@metafoo.de, michael.hennerich@analog.com,
 gstols@baylibre.com
References: <20240902103638.686039-1-aardelean@baylibre.com>
 <20240902103638.686039-8-aardelean@baylibre.com>
 <rdk2f6c457k462g5v6s5vumdmhejefyfareio5f6bogslg4wg5@ket4vfwwbyi7>
 <CA+GgBR-aQw+JHky5XwRDQj=6y1pHD=OvBeGW1ocd=ZR6ieBJrw@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <CA+GgBR-aQw+JHky5XwRDQj=6y1pHD=OvBeGW1ocd=ZR6ieBJrw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 02/09/2024 20:38, Alexandru Ardelean wrote:
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

Ah, no, list is already constrained to two items. Then just drop it.
What's the point of listing it here?


> 
>>
>>> +
>>> +      bipolar: true

Same, drop.

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

How can you test a binding on a board?

> But forgot to update the DT schema docs.
> Though, if you're referring to testing it somehow via some make
> command, I'm a little behind on how all this works now.
> I'll go re-check the "make dtbs_check" and similar commands.

Please read carefully writing-schema and writing-bindings.


Best regards,
Krzysztof


