Return-Path: <linux-iio+bounces-6721-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 553B5913585
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jun 2024 20:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 786751C20F6B
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jun 2024 18:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A92383AC;
	Sat, 22 Jun 2024 18:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R41chvNt"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A7A381AA;
	Sat, 22 Jun 2024 18:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719079456; cv=none; b=eukuW0WQsxJxPe4+hDrmfO1oTSN8MAPxbxeaPfx8j8q++7yIc/4cjo2w1T3Z9SOeWryKn3pAbrabL9cl+QSWVC8sNZaWgIg7OVIpyUG+WzFbNuJdHn5x8CQDBVcZhTixdByZTRjRdLgl7SX83XdXa74rWFtDhEkqX+13qENJWgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719079456; c=relaxed/simple;
	bh=QoGfE8cQ3Ncm2RINmc7UjozNPcoaLETzKNCmZeMz/zU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kl10zXi+3lVCs9qbVrJoeYMIo2i8pV42zklJd0VQn29aXPG+mvxslLXOjCIioFvgWi7DjrkYubh6fz6dVmaAL2CB4+wnEfkA2rCBRAbpwnf4G8IMAyypOLyQweDsr6nfC0wdD6U52MW7cMwKQ5wxZFR2l4GE5hDRWOTFyYu19dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R41chvNt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ECD8C32786;
	Sat, 22 Jun 2024 18:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719079455;
	bh=QoGfE8cQ3Ncm2RINmc7UjozNPcoaLETzKNCmZeMz/zU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=R41chvNtSZL18SM7BcTw+6ViMHnJ9VQeuge4yBLhR0aCJ0c1KXGvybG9HiEIMMp7U
	 mqnXQG82RQu/WumMHhpjss783uWoaZojdazFpDVr3imUxf1Cef2ee8x3jQXS7gMAfJ
	 DL8oUlrePZycWT0eQnyXReI70CxOhkOkBuj9ePwUHi/Dhq/J03zW2pOp7GXI4UEds1
	 lIU2rXKBCKwfyTBhC+d/GnZPtxfMZ34NfEBMXzOCiMJ9xXIIL6rfr4UliEob4UKqRl
	 IxWqBbpcBPO1uLoXvMuw25CCrHFIlmbrhZkW4r0rxB5foqcjUNFjt2aDWgw2cEIUYZ
	 OGqn/7DX+3uRw==
Message-ID: <3541cd63-882b-4b91-871a-7d0385e12957@kernel.org>
Date: Sat, 22 Jun 2024 20:04:06 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/3] dt-bindings: iio: proximity: Add TYHX HX9023S
To: Yasin Lee <yasin.lee.x@gmail.com>, Conor Dooley <conor@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, yasin.lee.x@outlook.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
References: <20240621-add-tyhx-hx9023s-sensor-driver-v6-0-65196a9020f1@gmail.com>
 <20240621-add-tyhx-hx9023s-sensor-driver-v6-2-65196a9020f1@gmail.com>
 <d35f5eba-abb4-4924-89d6-0beb878a0bf7@kernel.org>
 <385a7a64-fc76-4655-bc7f-d89d00b053d5@gmail.com>
 <20240622-superjet-dusk-cfd19f899cc2@spud>
 <26db1f7b-bde9-43a5-8c9b-4323ccfc59cf@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 xsFNBFVDQq4BEAC6KeLOfFsAvFMBsrCrJ2bCalhPv5+KQF2PS2+iwZI8BpRZoV+Bd5kWvN79
 cFgcqTTuNHjAvxtUG8pQgGTHAObYs6xeYJtjUH0ZX6ndJ33FJYf5V3yXqqjcZ30FgHzJCFUu
 JMp7PSyMPzpUXfU12yfcRYVEMQrmplNZssmYhiTeVicuOOypWugZKVLGNm0IweVCaZ/DJDIH
 gNbpvVwjcKYrx85m9cBVEBUGaQP6AT7qlVCkrf50v8bofSIyVa2xmubbAwwFA1oxoOusjPIE
 J3iadrwpFvsZjF5uHAKS+7wHLoW9hVzOnLbX6ajk5Hf8Pb1m+VH/E8bPBNNYKkfTtypTDUCj
 NYcd27tjnXfG+SDs/EXNUAIRefCyvaRG7oRYF3Ec+2RgQDRnmmjCjoQNbFrJvJkFHlPeHaeS
 BosGY+XWKydnmsfY7SSnjAzLUGAFhLd/XDVpb1Een2XucPpKvt9ORF+48gy12FA5GduRLhQU
 vK4tU7ojoem/G23PcowM1CwPurC8sAVsQb9KmwTGh7rVz3ks3w/zfGBy3+WmLg++C2Wct6nM
 Pd8/6CBVjEWqD06/RjI2AnjIq5fSEH/BIfXXfC68nMp9BZoy3So4ZsbOlBmtAPvMYX6U8VwD
 TNeBxJu5Ex0Izf1NV9CzC3nNaFUYOY8KfN01X5SExAoVTr09ewARAQABzSVLcnp5c3p0b2Yg
 S296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+wsGVBBMBCgA/AhsDBgsJCAcDAgYVCAIJCgsE
 FgIDAQIeAQIXgBYhBJvQfg4MUfjVlne3VBuTQ307QWKbBQJgPO8PBQkUX63hAAoJEBuTQ307
 QWKbBn8P+QFxwl7pDsAKR1InemMAmuykCHl+XgC0LDqrsWhAH5TYeTVXGSyDsuZjHvj+FRP+
 gZaEIYSw2Yf0e91U9HXo3RYhEwSmxUQ4Fjhc9qAwGKVPQf6YuQ5yy6pzI8brcKmHHOGrB3tP
 /MODPt81M1zpograAC2WTDzkICfHKj8LpXp45PylD99J9q0Y+gb04CG5/wXs+1hJy/dz0tYy
 iua4nCuSRbxnSHKBS5vvjosWWjWQXsRKd+zzXp6kfRHHpzJkhRwF6ArXi4XnQ+REnoTfM5Fk
 VmVmSQ3yFKKePEzoIriT1b2sXO0g5QXOAvFqB65LZjXG9jGJoVG6ZJrUV1MVK8vamKoVbUEe
 0NlLl/tX96HLowHHoKhxEsbFzGzKiFLh7hyboTpy2whdonkDxpnv/H8wE9M3VW/fPgnL2nPe
 xaBLqyHxy9hA9JrZvxg3IQ61x7rtBWBUQPmEaK0azW+l3ysiNpBhISkZrsW3ZUdknWu87nh6
 eTB7mR7xBcVxnomxWwJI4B0wuMwCPdgbV6YDUKCuSgRMUEiVry10xd9KLypR9Vfyn1AhROrq
 AubRPVeJBf9zR5UW1trJNfwVt3XmbHX50HCcHdEdCKiT9O+FiEcahIaWh9lihvO0ci0TtVGZ
 MCEtaCE80Q3Ma9RdHYB3uVF930jwquplFLNF+IBCn5JRzsFNBFVDXDQBEADNkrQYSREUL4D3
 Gws46JEoZ9HEQOKtkrwjrzlw/tCmqVzERRPvz2Xg8n7+HRCrgqnodIYoUh5WsU84N03KlLue
 MNsWLJBvBaubYN4JuJIdRr4dS4oyF1/fQAQPHh8Thpiz0SAZFx6iWKB7Qrz3OrGCjTPcW6ei
 OMheesVS5hxietSmlin+SilmIAPZHx7n242u6kdHOh+/SyLImKn/dh9RzatVpUKbv34eP1wA
 GldWsRxbf3WP9pFNObSzI/Bo3kA89Xx2rO2roC+Gq4LeHvo7ptzcLcrqaHUAcZ3CgFG88CnA
 6z6lBZn0WyewEcPOPdcUB2Q7D/NiUY+HDiV99rAYPJztjeTrBSTnHeSBPb+qn5ZZGQwIdUW9
 YegxWKvXXHTwB5eMzo/RB6vffwqcnHDoe0q7VgzRRZJwpi6aMIXLfeWZ5Wrwaw2zldFuO4Dt
 91pFzBSOIpeMtfgb/Pfe/a1WJ/GgaIRIBE+NUqckM+3zJHGmVPqJP/h2Iwv6nw8U+7Yyl6gU
 BLHFTg2hYnLFJI4Xjg+AX1hHFVKmvl3VBHIsBv0oDcsQWXqY+NaFahT0lRPjYtrTa1v3tem/
 JoFzZ4B0p27K+qQCF2R96hVvuEyjzBmdq2esyE6zIqftdo4MOJho8uctOiWbwNNq2U9pPWmu
 4vXVFBYIGmpyNPYzRm0QPwARAQABwsF8BBgBCgAmAhsMFiEEm9B+DgxR+NWWd7dUG5NDfTtB
 YpsFAmA872oFCRRflLYACgkQG5NDfTtBYpvScw/9GrqBrVLuJoJ52qBBKUBDo4E+5fU1bjt0
 Gv0nh/hNJuecuRY6aemU6HOPNc2t8QHMSvwbSF+Vp9ZkOvrM36yUOufctoqON+wXrliEY0J4
 ksR89ZILRRAold9Mh0YDqEJc1HmuxYLJ7lnbLYH1oui8bLbMBM8S2Uo9RKqV2GROLi44enVt
 vdrDvo+CxKj2K+d4cleCNiz5qbTxPUW/cgkwG0lJc4I4sso7l4XMDKn95c7JtNsuzqKvhEVS
 oic5by3fbUnuI0cemeizF4QdtX2uQxrP7RwHFBd+YUia7zCcz0//rv6FZmAxWZGy5arNl6Vm
 lQqNo7/Poh8WWfRS+xegBxc6hBXahpyUKphAKYkah+m+I0QToCfnGKnPqyYIMDEHCS/RfqA5
 t8F+O56+oyLBAeWX7XcmyM6TGeVfb+OZVMJnZzK0s2VYAuI0Rl87FBFYgULdgqKV7R7WHzwD
 uZwJCLykjad45hsWcOGk3OcaAGQS6NDlfhM6O9aYNwGL6tGt/6BkRikNOs7VDEa4/HlbaSJo
 7FgndGw1kWmkeL6oQh7wBvYll2buKod4qYntmNKEicoHGU+x91Gcan8mCoqhJkbqrL7+nXG2
 5Q/GS5M9RFWS+nYyJh+c3OcfKqVcZQNANItt7+ULzdNJuhvTRRdC3g9hmCEuNSr+CLMdnRBY fv0=
In-Reply-To: <26db1f7b-bde9-43a5-8c9b-4323ccfc59cf@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 22/06/2024 14:35, Yasin Lee wrote:
> 
> On 2024/6/22 18:51, Conor Dooley wrote:
>> On Sat, Jun 22, 2024 at 01:56:42PM +0800, Yasin Lee wrote:
>>> On 2024/6/21 18:12, Krzysztof Kozlowski wrote:
>>>
>>> Hi ,Krzysztof
>>> Thank you for your reply. I have some questions inline.
>>>
>>> Best regards,
>>> Yasin
>>>
>>>> On 21/06/2024 09:40, Yasin Lee wrote:
>>>>> A capacitive proximity sensor
>>>>>
>>>>> Signed-off-by: Yasin Lee <yasin.lee.x@gmail.com>
>>>>> ---
>>>>>    .../bindings/iio/proximity/tyhx,hx9023s.yaml       | 115 +++++++++++++++++++++
>>>>>    1 file changed, 115 insertions(+)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml b/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml
>>>>> new file mode 100644
>>>>> index 000000000000..beca70ce7609
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml
>>>>> @@ -0,0 +1,115 @@
>>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>>> +%YAML 1.2
>>>>> +---
>>>>> +$id: http://devicetree.org/schemas/iio/proximity/tyhx,hx9023s.yaml#
>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>> +
>>>>> +title: TYHX HX9023S capacitive proximity sensor
>>>>> +
>>>>> +maintainers:
>>>>> +  - Yasin Lee <yasin.lee.x@gmail.com>
>>>>> +
>>>>> +description: |
>>>>> +  TYHX HX9023S proximity sensor. Datasheet can be found here:
>>>>> +    http://www.tianyihexin.com/ueditor/php/upload/file/20240614/1718336303992081.pdf
>>>>> +
>>>>> +allOf:
>>>>> +  - $ref: /schemas/iio/iio.yaml#
>>>> Which part of iio.yaml binding do you use here? I cannot find anything,
>>>> so this looks wrong.	
>>>>
>>> I will remove this reference.
>>>
>>>
>>>>> +
>>>>> +properties:
>>>>> +  compatible:
>>>>> +    const: tyhx,hx9023s
>>>>> +
>>>>> +  reg:
>>>>> +    maxItems: 1
>>>>> +
>>>>> +  interrupts:
>>>>> +    description:
>>>>> +      Generated by device to announce preceding read request has finished
>>>>> +      and data is available or that a close/far proximity event has happened.
>>>>> +    maxItems: 1
>>>>> +
>>>>> +  vdd-supply: true
>>>>> +
>>>>> +  "#address-cells":
>>>>> +    const: 1
>>>>> +
>>>>> +  "#size-cells":
>>>>> +    const: 0
>>>>> +
>>>>> +patternProperties:
>>>>> +  "^channel@[0-4]$":
>>>>> +    $ref: /schemas/iio/adc/adc.yaml
>>>>> +    type: object
>>>>> +
>>>>> +    properties:
>>>>> +      reg:
>>>>> +        minimum: 0
>>>>> +        maximum: 4
>>>>> +        description: The channel number.
>>>>> +
>>>>> +      input-channel:
>>>> Isn't this duplicating single-channel property?
>>>>
>>>> Where is this property defined (which common schema)?
>>>>
>>> |input-channel| is indeed intended for single-ended configuration, but I
>>> couldn't find a definition
>>>
>>> or reference for |single-channel| anywhere. If possible, should I rename
>>> |input-channel| to |single-channel|?
>> Single-channel is new, it should be the next branch of the iio tree and
>> in linux-next.
> 
> Hi Conor，
> 
> Thank you for informing me. I plan to temporarily add a prefix to this 
> attribute to distinguish it and update it in the future. Is this the 
> correct approach?

No, because there is no need. You are supposed to work on maintainer
tree (linux-next works usually as well).

Best regards,
Krzysztof


