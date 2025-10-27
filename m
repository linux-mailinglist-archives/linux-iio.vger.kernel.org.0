Return-Path: <linux-iio+bounces-25500-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6956C0F4DF
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 17:31:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 229641897038
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 16:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E10313526;
	Mon, 27 Oct 2025 16:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mcXhTAsh"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE323313274;
	Mon, 27 Oct 2025 16:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761582642; cv=none; b=mzFTfaSDCKAl9BXbQKOXVc4+K7TkOnkVhoCu74YR5/FOb3P14jtH99rBDy1wbh796WKM8uDawWQY2csohBmIDUm56uScS9pjTgbl1vZ2VyjURg4gY14CXjcET7/OJvXbrPRIO8WDP9wBdu+f2vM0PAFej9gbrCalMnP0G5Gq0Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761582642; c=relaxed/simple;
	bh=1iQHHc3ie6VSCmvyt8zIha++Bkx/J8azUGjstOWVHYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fn0lRmw1mja2SBfMxEWcgOBWCnQ1jYHQ/9nyyM9ctd6SRqRPyS8pWbzAx1gP/JC6q/0hDCNZNUbPz5kmrDlwGYk9QDishGrhdvpS2R32nTHpz3okgFn/TzXwKGcSa7kj8fnyQgQKWoZv+pzPjqFnYY0Rq8SV1Tp297au3AtPa6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mcXhTAsh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76449C4CEFD;
	Mon, 27 Oct 2025 16:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761582642;
	bh=1iQHHc3ie6VSCmvyt8zIha++Bkx/J8azUGjstOWVHYE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mcXhTAshqT1JJEjAY0s3orD7wYbhMh2J5d2pp8pM+SQXySBLk4HoOHCIvuL7ygWsX
	 LvsnwAeAP2gsaj6dIfyq8LNW++egwK9zFKcG0yMjA66UKmSOiTp7Lx3PdEnkynd3Cj
	 Q14HTriBh8rQpIvpdwR013B+hQlWpBZiYF/ORw/h/u/LGKtV9KQjvUor7AEs4cDiep
	 0BBzzXoZe5XWByb4qOFas8DD7ldt9ZCZo69Zc9D3fvx5YsiEI0Zqd635WH4rFGzO8D
	 lgDViTuAJTEzM95/co8wTRxGaPJ75WLKoc/CrviaiTSU74+jeaMt7UZcYNOZv2/8TZ
	 BR4WF+ww75MuQ==
Message-ID: <d7627a5d-893a-4bc3-8b67-c151ee0bea32@kernel.org>
Date: Mon, 27 Oct 2025 17:30:33 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 3/5] dt-bindings: iio: adc: Add support for QCOM PMIC5
 Gen3 ADC
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, agross@kernel.org, andersson@kernel.org,
 lumag@kernel.org, dmitry.baryshkov@oss.qualcomm.com, konradybcio@kernel.org,
 daniel.lezcano@linaro.org, sboyd@kernel.org, amitk@kernel.org,
 thara.gopinath@gmail.com, lee@kernel.org, rafael@kernel.org,
 subbaraman.narayanamurthy@oss.qualcomm.com, david.collins@oss.qualcomm.com,
 anjelique.melendez@oss.qualcomm.com, kamal.wadhwa@oss.qualcomm.com,
 rui.zhang@intel.com, lukasz.luba@arm.com, devicetree@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 cros-qcom-dts-watchers@chromium.org, quic_kotarake@quicinc.com,
 neil.armstrong@linaro.org, stephan.gerhold@linaro.org,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250826083657.4005727-1-jishnu.prakash@oss.qualcomm.com>
 <20250826083657.4005727-4-jishnu.prakash@oss.qualcomm.com>
 <20250829-classic-dynamic-clam-addbd8@kuoka>
 <5d662148-408f-49e1-a769-2a5d61371cae@oss.qualcomm.com>
 <4e974e77-adfc-49e5-90c8-cf8996ded513@kernel.org>
 <a0e885be-e87d-411a-884e-3e38a0d761e5@oss.qualcomm.com>
 <8c90cc3f-115e-4362-9293-05d9bee24214@linaro.org>
 <5d4edecf-51f3-4d4a-861f-fce419e3a314@oss.qualcomm.com>
 <20250927144757.4d36d5c8@jic23-huawei>
 <a3158843-dfac-4adc-838a-35bb4b0cbea4@oss.qualcomm.com>
 <CAGE=qrrCvq28pr9Y7it-CGMW=szKUnU+XBj1TmpoUwuASM05ig@mail.gmail.com>
 <31bd08ce-823a-4a71-baca-a9d1e02fcb6a@oss.qualcomm.com>
 <08eb477f-ea34-4a31-b181-bfc629aef4c8@kernel.org>
 <68a9b8e8-bdf4-430f-baef-6a293ccea78d@oss.qualcomm.com>
 <d8a78b7c-e3a9-44b5-986d-8ac32f328eb6@kernel.org>
 <3a32746a-5b0e-4c0a-8322-00cd3a84394a@oss.qualcomm.com>
 <4979bd26-0a77-4390-9db2-6d40cd7f963c@kernel.org>
 <c4b2c474-c6d0-4b1d-bcc3-a3fddea699c7@oss.qualcomm.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <c4b2c474-c6d0-4b1d-bcc3-a3fddea699c7@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/10/2025 13:02, Konrad Dybcio wrote:
>>>>>>>
>>>>>>> On 10/4/2025 12:22 PM, Krzysztof Kozlowski wrote:
>>>>>>>> On Sat, 4 Oct 2025 at 11:42, Jishnu Prakash
>>>>>>>> <jishnu.prakash@oss.qualcomm.com> wrote:
>>>>>>>>>
>>>>>>>>> Hi Jonathan,
>>>>>>>>>
>>>>>>>>> On 9/27/2025 7:17 PM, Jonathan Cameron wrote:
>>>>>>>>>> On Fri, 19 Sep 2025 20:17:43 +0530
>>>>>>>>>> Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:
>>>
>>> [...]
>>>
>>>>> Can you please provide your suggestions on changes we can make
>>>>> in the above points ?
>>>>
>>>> You just pasted DT. I asked about SW, software. Please read carefully
>>>> previous comments.
>>>
>>> Is the problem that Jishnu included some indices in dt-bindings without
>>> also adding them in the driver's adc5_gen3_chans_pmic[] array?
>>>
>>> As in, would the resolution to this thread be simply handling all of
>>> them in the driver correctly?
>>
>> The solution is to remove them from the bindings, just like we do with
>> many other hardware constants. Of course if these are not hardware
>> constants, but part of ABI, then solution would be different but no one
>> provided proof or argument that this is any binding. All proofs were
>> "but I want to use it in my DTS", which proofs nothing. Not a binding.
>>
>> While this issue is not that important, we keep discussing it because
>> author does not try to understand the problem or even keep up the
>> discussion. Instead repeats the same without really reading my
>> messages... and then disappears for month or more.
> 
> In Bulgaria, people shake their heads left to right to say "yes", and
> up&down to say "no" (or so I've heard).. I feel like we're having a
> similar situation here..
> 
> I'll try to make a case for keeping these defines in some form.
> Here's hopefully all the related aspects, condensed down:
> 
> 1. In a multi-PMIC setup, only the main PMIC's ADC is accessible by the OS.
>    It then mediates accesses to secondary PMICs' ADCs through internal
>    mechanisms, which requires the SID of the target to be retrieved and written
>    to a register, along with the physical index of the desired channel to be
>    measured (see patch 3/5 commit msg).


SID is still a hardware value, right? Combination of two hardware values
is still a hardware value, not a software ABI construct. Even if you
claim only the driver can decode it. These are still the hardware values.

If you had two IIO cells - one for SID and one for ADC channel - would
you claim they are both needed for software? Probably not.

io-channels = <&pm8550_adc SID_whatever CHANNEL_XYZ>

It's basically the same as some pin muxes, like NXP:
git grep MX8MM_IOMUXC_GPIO1_IO04_GPIO1_IO4

Complex value, which driver parses. Is it SW construct? No. These are
register values.


> 
> 2. The PMIC SIDs are fixed per board and are the values of PMIC top-level
>    nodes' reg property (since forever)
> 
> 3. The channel indices are fixed in HW, but this patchset proposed to reuse
>    them for logical mappings consumed through io-channels = <> as well (because
>    of 1.), with the drivers taking the lower 8 bits that of reg/io-channels[1]
>    value as the ADC channel id and the higher 8 bits as the SID (this is the
>    define macros with an argument)
> 
> 4. Fixing 3. in a "simply define all possible options and bind them to
>    consecutive integers" fashion would require a huge table matching 0..n to
>    [0-max_sid][0-max_chan] which is unreasonable

I do not insist on fixing anything or changing the interface. I only
question their necessity to be a binding.

> 
> The alternative to the SID packing would be to reference the target PMIC
> somehow, be it by referencing the PMIC itself:
> 
> io-channels = <&pm8550_adc &pmr735a CHANNEL_XYZ>
> 
> or by creating a faux node for the actual inaccessible ADC onboard each of
> the PMICs:
> 
> io-channels = <&pm8550_adc &pmr735a_adc CHANNEL_XYZ>
> 
> and have the OS retrieve the SID from the DT node & encode that value instead
> of hardcoding it in the DT, leaving just the actual channel IDs in dt-bindings.
> 
> 
> The define macros without an argument do specify physical channel indices, but
> we do need some sort of an identifier to put into io-channels (which is why this
> lives in dt-bindings in the first place), and a 1:1 mapping to the physical id
> sounds like a good option.
> 
> 
> I don't think anyone objects to any of these resolutions, so long as they
> are acceptable from your side

You can go these ways, but I never proposed to change the interface.
Just don't store these as bindings, so they don't have to be treated as
ABI, because they are not. They do not constitute the contract between
software (driver) and DTS. Treat them the same as we treat all hardware
constants - directly encoded or moved to DTS headers (which we did for
many of such cases already - see commit
9d9292576810d0b36897718c24dfbc1a2835314b 3 years ago and other)

Best regards,
Krzysztof

