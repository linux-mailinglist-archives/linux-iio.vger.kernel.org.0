Return-Path: <linux-iio+bounces-8568-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68022955BB6
	for <lists+linux-iio@lfdr.de>; Sun, 18 Aug 2024 09:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5E1228205B
	for <lists+linux-iio@lfdr.de>; Sun, 18 Aug 2024 07:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1C7179A8;
	Sun, 18 Aug 2024 07:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VLqR5u51"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF121758B;
	Sun, 18 Aug 2024 07:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723964700; cv=none; b=sp4ZLh/eCuX39KcNH8jRBVf9PWnTmnea7cW1iIGtg+Qdy+u1VKgpWetQGUaz+Pc48vgHoA17PMJW+Zqi1BaeC4JKDdNiVuhJOFnHZFAbLTnSXpi6o78knQGVAfrX2eHIakhUG26YGrQPxAUpQI7j2cy9WmIGVXOT7EINJJEhkn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723964700; c=relaxed/simple;
	bh=JkCXrBddsAmPsjNruqRw2xUrMRsszkRxypNEw90PA3Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hR0t8vdO7owqUZHd8Nt8ZvGb5p1RoIaO6Dvj8YxsExPt5lWBExMhfHbk1YP+7P+hev1rNrkrobmyKL0v1Wgi4GDOPVpiA71FwPw8iDj/yFD/QGzz98P1tWCzS/qmMufqc87JmefgAG5OHqn0yUGjlZaKGClanWyyVISwCPg4uiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VLqR5u51; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73809C32786;
	Sun, 18 Aug 2024 07:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723964700;
	bh=JkCXrBddsAmPsjNruqRw2xUrMRsszkRxypNEw90PA3Q=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=VLqR5u51glNxnE0PkzxGdLmW0M2D6rfBpBQw89l1Oz4bUq4MW6z1VjCr+Zxarmb6m
	 g5apwXGFI9RSE8h8wqyntoaOi+YD4sD1Bh77mXm02ghk73ud9sjGFg+0/E2vMbNRTx
	 kOzCIm2vbWHzm3x06oBPUd/pC0bazgwQDM2+Cf62Yva92ED1zQda9sPTmBj1JI6NFK
	 XgQ1V60BAuThp6W6GRrCLqztbJI47Ds2f3L+4UzcyqyzXN9+T9IMiyOeItqnI/S3+v
	 o6onDzQitNsX2Zk4kXYX8bxiZc8diLgPhTuN+vzzIKtA5KCzX6AvYI0wAde1J5lnwJ
	 fuHfpwhR1cwMg==
Message-ID: <8d24b75a-18dd-4d54-98c3-d899c5502dad@kernel.org>
Date: Sun, 18 Aug 2024 09:04:52 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: dac: add docs for ad8460
To: "Tinaco, Mariel" <Mariel.Tinaco@analog.com>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 "Hennerich, Michael" <Michael.Hennerich@analog.com>,
 Conor Dooley <conor+dt@kernel.org>,
 Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
 Dimitri Fedrau <dima.fedrau@gmail.com>, David Lechner
 <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>
References: <20240730030509.57834-1-Mariel.Tinaco@analog.com>
 <20240730030509.57834-2-Mariel.Tinaco@analog.com>
 <71cbe674-b232-4327-929b-351630907540@kernel.org>
 <SJ0PR03MB6224EB6BB835741EA94DEB7491822@SJ0PR03MB6224.namprd03.prod.outlook.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <SJ0PR03MB6224EB6BB835741EA94DEB7491822@SJ0PR03MB6224.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/08/2024 13:18, Tinaco, Mariel wrote:
>>> +  clocks:
>>
>> maxItems: 1
>> and drop description (or use items: - description, but then do not
>> repeat redundant parts)
>>
> 
> Simplified the description for this item
> 
>   refio-1p2v-supply:
>     description: Reference voltage to adjust full scale output span
>     maxItems: 1
> 
> Should I put, "maxItems: 1" in the other vrefs as well?

No, why do you change supply? My comment was under clocks. Comments are
always under specific part of code which is being discussed.

> 
>>> +    description: The clock for the DAC. This is the sync clock
>>> +
>>> +  adi,rset-ohms:
>>> +    description: Specify value of external resistor connected to FS_ADJ pin
>>> +      to establish internal HVDAC's reference current I_REF
>>> +    default: 2000
>>> +    minimum: 2000
>>> +    maximum: 20000
>>> +
>>> +  adi,range-microvolt:
>>> +    description: |
>>> +      Voltage output range specified as <minimum, maximum>
>>> +    oneOf:
>>
>> Not an oneOf.
>>
> 
> You're right. I should have put all the possible values. I populated it with common
> Values found in the datasheet
> 
>   adi,range-microvolt:
>     description: Voltage output range specified as <minimum, maximum>
>     oneOf:
>       - items:
>           - enum: [0, -10000000, -20000000, -30000000, -40000000, -55000000]
>           - enum: [10000000, 20000000, 30000000, 40000000, 55000000]
> 
>>> +      - items:
>>> +          - const: -40000000
>>> +          - const: 40000000
>>
>> Why do you need this property if this cannot be anything else? Drop.
>>
>>> +
>>> +  adi,range-microamp:
>>> +    description: |
>>
>> Do not need '|' unless you need to preserve formatting.
>>
>>> +      Current output range specified as <minimum, maximum>
>>> +    oneOf:
>>> +      - items:
>>> +          - const: 0
>>> +          - const: 50000
>>> +      - items:
>>> +          - const: -50000
>>> +          - const: 50000
>>> +
>>> +  adi,temp-max-millicelsius:
>>> +    description: Overtemperature threshold
>>> +    default: 50000
>>> +    minimum: 20000
>>> +    maximum: 150000
>>> +
>>> +  sdn-reset-gpios:
>>
>> reset-gpios or shutdown-gpios or anything from gpio-consumer-common
>> which is not deprecated.
>>
> 
> Lifted from gpio-consumer-common yaml. Mapped to corresponding pins
> 
>   wakeup-gpios:
>     description: Corresponds to SDN_RESET pin. To exit shutdown
>       or sleep mode, pulse SDN_RESET HIGH, then leave LOW.

That's not a wakeup-gpio. I think my comment was imprecise. You have
something like three reset/shutdown GPIOs, so pick from
gpio-consumer-common the reset and shutdown. Remaining one could stay as
in your original code.

>     maxItems: 1
> 
>   reset-gpios:
>     description: Manual Power On Reset (POR). Pull this GPIO pin
>       LOW and then HIGH to reset all digital registers to default
>     maxItems: 1
> 
>   shutdown-gpios:
>     description: Corresponds to SDN_IO pin. Shutdown may be
>       initiated by the user, by pulsing SDN_IO high. To exit shutdown,
>       pulse SDN_IO low, then float.
>     maxItems: 1
> 


Best regards,
Krzysztof


