Return-Path: <linux-iio+bounces-8410-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F8E94E678
	for <lists+linux-iio@lfdr.de>; Mon, 12 Aug 2024 08:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4FD81F2255F
	for <lists+linux-iio@lfdr.de>; Mon, 12 Aug 2024 06:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2346114E2F0;
	Mon, 12 Aug 2024 06:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="poh6/GtF"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD34196;
	Mon, 12 Aug 2024 06:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723443478; cv=none; b=ImxDOkRfEZhqVT+yRcZCWI23MT9T1b0G9K39unPG9qk2LosV+xLHL48gwnB1p4SqyaRAuEf4D4jt8KdgCk1Sr0O1K5nPyZMFsI8H0/V1KmUDutCG0qWbTJ7Ep08CfQsxEKAY9YQbiFPRdqGJzep95rkZ0kUYAf5V6u9RePx5dl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723443478; c=relaxed/simple;
	bh=BKOkmVdp75WBE7jaE6OafPJ+mkaLpk0gJg8wZSnelNA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gh4y/8iu2mKk4h8V6yQdPAFU5p2ezvpkdrKEcm1XJ6dZlm6Dsh/IIVy5adMZMxm5ssFkG1MWvqcbqDN7YeO0vHIklyPw03IHl2xqx1o4CQWjWAV887AcwXehDzzI4OyXASEDl/+JnPuSQLLC45y+H9L584mSNsZ88ueH8kRo0v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=poh6/GtF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D801C32782;
	Mon, 12 Aug 2024 06:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723443477;
	bh=BKOkmVdp75WBE7jaE6OafPJ+mkaLpk0gJg8wZSnelNA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=poh6/GtFKuoinkoG2MElZV46nLLHN/gR0xFREya6FULdjQOjJJTAjkFdEo9U6XsnI
	 gbX2HW4Sb9pE5ZtAFwnVpZaE1BRVabusFo9/b2QBikkdCEUnXbQuJWOQ1p+SaXZ31M
	 /FFDVV4g0quY5RhfeyGLj00Hu4GSr5NYIvszdTpRBYl+UeZNNfwnyRszs8B2jMycPF
	 UelqWzoTk1+/UpTUmHnUQXNaciGS1feuSGFVl1PC9TcOuZ2Txmcb0Akiz1BDsbBBNf
	 lhOS95Yn2bx4s3J7FzomP+rikJDMtWAvQaaYnrOjgg8ejOpueLuQeckpQjauHNLhar
	 S4mwF0+npTIPw==
Message-ID: <8e4a2774-ed58-49cb-b970-b3c05c9c1daa@kernel.org>
Date: Mon, 12 Aug 2024 08:17:52 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] dt-bindings: iio: imu: magnetometer: Add ak09118
To: barnabas.czeman@mainlining.org
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Albrieux <jonathan.albrieux@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux@mainlining.org,
 Danila Tikhonov <danila@jiaxyga.com>
References: <20240809-ak09918-v3-0-6b036db4d5ec@mainlining.org>
 <20240809-ak09918-v3-3-6b036db4d5ec@mainlining.org>
 <1568980c-fc35-4445-a10c-8bb7fede2763@kernel.org>
 <45dc7e6de63f5b55f6a3488a82ad5b0d@mainlining.org>
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
In-Reply-To: <45dc7e6de63f5b55f6a3488a82ad5b0d@mainlining.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/08/2024 20:28, barnabas.czeman@mainlining.org wrote:
> On 2024-08-10 14:15, Krzysztof Kozlowski wrote:
>> On 09/08/2024 22:25, Barnabás Czémán wrote:
>>> From: Danila Tikhonov <danila@jiaxyga.com>
>>>
>>> Document asahi-kasei,ak09918 compatible.
>>
>> Not much improved here.
> I have removed Reviewed-by because fallback compatible is a different 
> approach
> and I would not mind second look.

You received specific comments. You ignored them, so I replied that you
ignored them. And your excuse is that you ask for review? This does not
work like this.  Read CAREFULLY form letter below.

>>
>> <form letter>
>> This is a friendly reminder during the review process.
>>
>> It seems my or other reviewer's previous comments were not fully
>> addressed. Maybe the feedback got lost between the quotes, maybe you
>> just forgot to apply it. Please go back to the previous discussion and
>> either implement all requested changes or keep discussing them.
>>
>> Thank you.
>> </form letter>
>>
>>>
>>> Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
>>> Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
>>> ---
>>>  .../devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml      
>>>  | 3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git 
>>> a/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml 
>>> b/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml
>>> index 9790f75fc669..ff93a935363f 100644
>>> --- 
>>> a/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml
>>> +++ 
>>> b/Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.yaml
>>> @@ -18,6 +18,9 @@ properties:
>>>            - asahi-kasei,ak09911
>>>            - asahi-kasei,ak09912
>>>            - asahi-kasei,ak09916
>>> +      - items:
>>> +          - const: asahi-kasei,ak09918
>>> +          - const: asahi-kasei,ak09912
>>
>> Why? Your driver suggests it might not be compatible... Can device bind
>> using ak09912 and operate up to ak09912 extend?
> It is register compatible and it can bind on 09112, as I understand 
> fallback compatible

ok

> was a request from Connor and Jonathan in the previous round.

Not entirely, you should read comments more carefully.

Best regards,
Krzysztof


