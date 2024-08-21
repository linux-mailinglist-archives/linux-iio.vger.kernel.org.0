Return-Path: <linux-iio+bounces-8647-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A28E9594C5
	for <lists+linux-iio@lfdr.de>; Wed, 21 Aug 2024 08:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06B0E1F24811
	for <lists+linux-iio@lfdr.de>; Wed, 21 Aug 2024 06:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E33F16DC32;
	Wed, 21 Aug 2024 06:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PWytuUB+"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B279015C157;
	Wed, 21 Aug 2024 06:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724222290; cv=none; b=k+71oJJaILMrCfWprc4dkQJWaNQglyIIUi4Pl9qutbrHNOUUdUU4grFEK4vIJIkNRiEpZw3ZA5P9fx4cvb2nwhYyIvjGkd7d6kItJZdA3ymVDEs3GkMNwa99eEB3nwTHGtRwPqscNZdP9l2Fpr9k8Vy1+kHtegw3l7t7yeSD1xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724222290; c=relaxed/simple;
	bh=xVRhAQ9bT5Qo2E6sPCbDp3obzvw4LNK3id11C4MN8ww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dWM2eNBZyycWjVtTZUc+J7vCZ3pnPun897d4N3U2Og0mKlAJzjG1jxG3Agp86KX4bimI02Fd3i7gFFHxyE9X2xHMpf03oikoj+bYvvAyF9c8NfasM4fQvKGuGpy8UAYes2TnyIpagA0y8YdWEtszzcrCFsUK9ku/NZUeLOmYLUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PWytuUB+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFCFDC32782;
	Wed, 21 Aug 2024 06:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724222289;
	bh=xVRhAQ9bT5Qo2E6sPCbDp3obzvw4LNK3id11C4MN8ww=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PWytuUB+G7K9oHNXrWZFNBsc0fLgJBsuskY70YOG5/fWd3Lwq+sNRx5v4m4/5D05A
	 xw9tQOTWRETdrPxhkc5CJPYeBcPXhEN9GESWRJXLommhGF4hA+8igpW0ptjbtaXUXF
	 W9G6agqwnXILo4xIvjYz2PfUHQu2u7YBZwgFKnO9aoQLDV027v9ENAmPkMPRFuc2XX
	 ENhYrDnh6tLj1A9sbSJQAawgePvo+Q3nO25arRP1FDEzKS4e3D7pofKxoLguEHSMH8
	 ilL8ihMZFZvxwDGFIMifASe8L98Do+IQPBpnZs0yqVPR9XvuMWLP3z0rNzsS8/GMGP
	 p3cy5/dmUkH3g==
Message-ID: <6b9e528f-e9fc-453c-a024-1cf812cffd0d@kernel.org>
Date: Wed, 21 Aug 2024 08:37:59 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 05/15] dt-bindings: power: supply: axp20x: Add
 input-current-limit-microamp
To: Chris Morgan <macromorgan@hotmail.com>
Cc: Chris Morgan <macroalpha82@gmail.com>, linux-sunxi@lists.linux.dev,
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
 quentin.schulz@free-electrons.com, mripard@kernel.org,
 tgamblin@baylibre.com, aidanmacdonald.0x0@gmail.com,
 u.kleine-koenig@pengutronix.de, lee@kernel.org, samuel@sholland.org,
 jernej.skrabec@gmail.com, sre@kernel.org, wens@csie.org,
 conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org, lars@metafoo.de,
 jic23@kernel.org, jonathan.cameron@huawei.com
References: <20240819164619.556309-1-macroalpha82@gmail.com>
 <20240819164619.556309-6-macroalpha82@gmail.com>
 <ro43ccn3w2qsvcnjej7appuasuqphtf54vkyrsex6ypr4dlwhh@vi2jg4nemkvl>
 <MN2PR16MB2941EF5AF5C003640B20CDFFA58D2@MN2PR16MB2941.namprd16.prod.outlook.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <MN2PR16MB2941EF5AF5C003640B20CDFFA58D2@MN2PR16MB2941.namprd16.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/08/2024 22:15, Chris Morgan wrote:
> On Tue, Aug 20, 2024 at 09:42:06AM +0200, Krzysztof Kozlowski wrote:
>> On Mon, Aug 19, 2024 at 11:46:09AM -0500, Chris Morgan wrote:
>>> From: Chris Morgan <macromorgan@hotmail.com>
>>>
>>> Allow specifying a hard limit of the maximum input current. Some PMICs
>>> such as the AXP717 can pull up to 3.25A, so allow a value to be
>>> specified that clamps this in the event the hardware is not designed
>>> for it.
>>>
>>> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
>>> ---
>>>  .../x-powers,axp20x-usb-power-supply.yaml     | 69 ++++++++++++++++++-
>>>  1 file changed, 66 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml b/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml
>>> index 34b7959d6772..9cc300e78f60 100644
>>> --- a/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml
>>> +++ b/Documentation/devicetree/bindings/power/supply/x-powers,axp20x-usb-power-supply.yaml
>>> @@ -15,9 +15,6 @@ maintainers:
>>>    - Chen-Yu Tsai <wens@csie.org>
>>>    - Sebastian Reichel <sre@kernel.org>
>>>  
>>> -allOf:
>>> -  - $ref: power-supply.yaml#
>>> -
>>>  properties:
>>>    compatible:
>>>      oneOf:
>>> @@ -31,8 +28,74 @@ properties:
>>>            - const: x-powers,axp803-usb-power-supply
>>>            - const: x-powers,axp813-usb-power-supply
>>>  
>>> +  input-current-limit-microamp:
>>> +    description:
>>> +      Optional value to clamp the maximum input current limit to for
>>> +      the device. If omitted, the programmed value from the EFUSE will
>>> +      be used.
>>
>> minimum: 100000
>> maximum: 4000000
>> (or whatever the values are)
> 
> It varies based on the compatible string. I've added all of the
> restrictions below. Basically all but the axp717 have a table
> of values available (as an enum), and the axp717 which is added
> in a subsequent commit gets added as a minimum/maximum with a
> description noting that steps are in values of 50000.

And you still need widest constraints here, because there is no final
"else" for all not-matched ifs, right?

Best regards,
Krzysztof


