Return-Path: <linux-iio+bounces-9359-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05940970E0D
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2024 08:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B21CA282D83
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2024 06:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42481AD3F3;
	Mon,  9 Sep 2024 06:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bPcQaViU"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71445171E65;
	Mon,  9 Sep 2024 06:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725864121; cv=none; b=qWy+nNG4SajxJWN990yAd2l/vHsJ+aQF3+9GyQ297ODROIOKVnBvjDH5C4oLmElLLUjDOs9D64CO1oGzSch0jyIIsqTcYBfavv8ZLqXEe7y3ini+ZlIMHGmAKfiiIqM9z4kMrSNZSa4ccpFPfYNywUkB2ulhd6OLZKaiMledchA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725864121; c=relaxed/simple;
	bh=4iXun05Kzx9rkFVBPuYlYKvBb13Sq3zv17iVwK9G5U4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZRdV6BZBuIhOBUPcO9Sqp3RFH+1ENgcVth1LtNONIcS83OEarF4qnqMCa1eotfzPd43i6nCET5j5Wl09XOiigBbqxEvfQOAvRuXrVOFxfe6dzRLtKapA3mGycoHUxD/OdL+mo2mjV2fN1a+0WsWppTEvfzStBXaWLXQ8lY/1OsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bPcQaViU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72C02C4CEC5;
	Mon,  9 Sep 2024 06:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725864121;
	bh=4iXun05Kzx9rkFVBPuYlYKvBb13Sq3zv17iVwK9G5U4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bPcQaViUtPZmEvU1QCn9Zs3KZj/WKez5XPkHL4+kvQATB63am95GsdCm0byaoC8IF
	 q+h8GsV0/ZWcGyBd1yZ0jDDjZrXrCJOKCHmpQ+JoqmrGiCljGW7nyaWtLbC6oBhVnC
	 HBG9wcu9eNCByZ79xK+UNUgg8kzeYfVJjhT9JNt65jkRA08lPXbX20M1DVAyRqawLr
	 xJMfEcnvFfXuBYxSsIv7lJLk2pma3HNYmzP2KlpIaVRgoiZtH5L5DtON4569sRedHd
	 CpJDm5JdiTzrBnREZvQktA6ubWnewOQYn8ZCJx6bKoJhZ/kSJg2hfkMRPp33XCxRzc
	 mrVgrwtNaYMnQ==
Message-ID: <9889af99-9da4-48ea-aa7e-64529222f2cb@kernel.org>
Date: Mon, 9 Sep 2024 08:41:53 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: dac: add docs for ad8460
To: "Tinaco, Mariel" <Mariel.Tinaco@analog.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 "Hennerich, Michael" <Michael.Hennerich@analog.com>,
 Conor Dooley <conor+dt@kernel.org>,
 Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
 Dimitri Fedrau <dima.fedrau@gmail.com>, David Lechner
 <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>
References: <20240904023040.23352-1-Mariel.Tinaco@analog.com>
 <20240904023040.23352-2-Mariel.Tinaco@analog.com>
 <pp3r4ygrialun2x6vtghp27ianggjzs3g3436b6mi6mttfy57a@q7kcwolkkn27>
 <20240907180149.67fdc636@jic23-huawei>
 <SJ0PR03MB6224860552845EF2B3339DF591992@SJ0PR03MB6224.namprd03.prod.outlook.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <SJ0PR03MB6224860552845EF2B3339DF591992@SJ0PR03MB6224.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 09/09/2024 08:22, Tinaco, Mariel wrote:
> 
> 
>> -----Original Message-----
>> From: Jonathan Cameron <jic23@kernel.org>
>> Sent: Sunday, September 8, 2024 1:02 AM
>> To: Krzysztof Kozlowski <krzk@kernel.org>
>> Cc: Tinaco, Mariel <Mariel.Tinaco@analog.com>; linux-iio@vger.kernel.org;
>> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Lars-Peter Clausen
>> <lars@metafoo.de>; Rob Herring <robh@kernel.org>; Krzysztof Kozlowski
>> <krzk+dt@kernel.org>; Hennerich, Michael <Michael.Hennerich@analog.com>;
>> Conor Dooley <conor+dt@kernel.org>; Marcelo Schmitt
>> <marcelo.schmitt1@gmail.com>; Dimitri Fedrau <dima.fedrau@gmail.com>;
>> David Lechner <dlechner@baylibre.com>; Nuno Sá
>> <noname.nuno@gmail.com>
>> Subject: Re: [PATCH v3 1/2] dt-bindings: iio: dac: add docs for ad8460
>>
>> [External]
>>
>> On Wed, 4 Sep 2024 08:20:53 +0200
>> Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>
>>> On Wed, Sep 04, 2024 at 10:30:39AM +0800, Mariel Tinaco wrote:
>>>> This adds the bindings documentation for the 14-bit
>>>
>>> Please do not use "This commit/patch/change", but imperative mood. See
>>> longer explanation here:
>>> https://urldefense.com/v3/__https://elixir.bootlin.com/linux/v5.17.1/s
>>> ource/Documentation/process/submitting-
>> patches.rst*L95__;Iw!!A3Ni8CS0y
>>> 2Y!7lj0hq-U2ClkGNYfHqjR3-k-
>> ea6TFUFsgEYQokkU95K6TXPHIPU33VxQcl_iH_etJ4k
>>> pbPEV39dP1oAd$
>>>
>>>> High Voltage, High Current, Waveform Generator Digital-to-Analog
>>>> converter.
>>>>
>>>> Signed-off-by: Mariel Tinaco <Mariel.Tinaco@analog.com>
>>>> ---
>>>>  .../bindings/iio/dac/adi,ad8460.yaml          | 154 ++++++++++++++++++
>>>>  MAINTAINERS                                   |   7 +
>>>>  2 files changed, 161 insertions(+)
>>>>  create mode 100644
>>>> Documentation/devicetree/bindings/iio/dac/adi,ad8460.yaml
>>>
>>>> +  adi,range-microvolt:
>>>> +    description: Voltage output range specified as <minimum, maximum>
>>>> +    oneOf:
>>>
>>> This oneOf does not make sense. There is only one condition. Drop.
>>>
>>>> +      - items:
>>>> +          - enum: [0, -10000000, -20000000, -30000000, -40000000, -
>> 55000000]
>>>> +          - enum: [10000000, 20000000, 30000000, 40000000,
>>>> + 55000000]
>>>
>>> What's the default? It's not a required property.
>>>
>>>> +
>>>> +  adi,range-microamp:
>>>> +    description: Current output range specified as <minimum, maximum>
>>>> +    oneOf:
>>>> +      - items:
>>>> +          - enum: [-50000, -100000, -300000, -500000, -1000000]
>>>
>>> I don't understand why 0 is not listed here.
>>
>> I'm not sure why it is a list at all. Seems like the hardware allows a continuous
>> value so this should just specify max and min.
>>
> 
> That's right, the values can be flexible but only at a certain range. 
> The first element of the array should only be in the negative range, while
> The second element of the array should only be in the positive range.
> 
> Is there a way to do this with the max and min attribute?
> 
> Items:
> 	Item 1
> 		min: -10000
> 		max: 0
> 	item 2
> 		min: 0
> 		max: 10000 

items:
  - minimum: -10000
    maximum: 0
  - minimum: 0
    maximum: 10000

should work, try.

Best regards,
Krzysztof


