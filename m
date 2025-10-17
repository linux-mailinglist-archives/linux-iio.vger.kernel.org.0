Return-Path: <linux-iio+bounces-25194-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A547BE8F58
	for <lists+linux-iio@lfdr.de>; Fri, 17 Oct 2025 15:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA9323B6569
	for <lists+linux-iio@lfdr.de>; Fri, 17 Oct 2025 13:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48C42F691D;
	Fri, 17 Oct 2025 13:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jDTH5z6Q"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BA32F6903;
	Fri, 17 Oct 2025 13:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760708413; cv=none; b=h/4KyqMakFfkmznleCylONYGkt6agwv7o/WlGMqJ0co6i2on3PYaev8ulScMcIQ9NfJvoCatSgauWJx6PztuaTrqKfedLNs7o60RS+sZFrWxgRUODYU/ujleZaDmLYsbTj4oWMuVWzJoiSRdnZQalhy7MBl4ntLA7WA/yGEGw/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760708413; c=relaxed/simple;
	bh=X8SCmld5sXx4ricWkl9PJ7pW6tb6c1+ScVBZg/V93ag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=asWlSfbSQzHTVD+8vORYT0fkSTRj8+ZBb3jKRmvOM8MDVhUDpLX9P7iVAjwnpUzWLPMwLAjhRbBXf5Ld6OHBHDMBQatjVkv4o61nb+2pxT+xVIB5B5YtiolYVwvodrd8UTTpVUw56nuA5qdbptQKnaWqpOVb/iUqm4/xYjKNboY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jDTH5z6Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F3A6C4CEE7;
	Fri, 17 Oct 2025 13:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760708409;
	bh=X8SCmld5sXx4ricWkl9PJ7pW6tb6c1+ScVBZg/V93ag=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jDTH5z6QJhJU+7m9ezxCXn64ywZmOGeLZmaJ8S+ttQNGXoXd1YNoF24GOfTSUCyuj
	 A657tHYBDsX0urWgWMt+2rvB+HLGyo5/6OGLgYwXAIwXOM5K6ub/qVmNyAVSYDvymq
	 VJZ+6LPtvzGbPeKBV2D8z5VR6JYzudMj5cj1Na0rYmKbKc8UYdHVPSEZ5RPqoET1Bf
	 M8NglehC1zaGCAygv5NgSuucwLWjU3qu+wFojZXivPgqgPH3TrxOABs+50hk7s7uS1
	 BHxiir8DmbXlDfSA83RSdsMjaxAT/b3/gkRyHbIIKPRcquQJ/4/fakqeQUNZc1Xfae
	 TmQUeAf20bx6A==
Message-ID: <d8a78b7c-e3a9-44b5-986d-8ac32f328eb6@kernel.org>
Date: Fri, 17 Oct 2025 15:40:00 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 3/5] dt-bindings: iio: adc: Add support for QCOM PMIC5
 Gen3 ADC
To: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
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
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <68a9b8e8-bdf4-430f-baef-6a293ccea78d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/10/2025 13:18, Jishnu Prakash wrote:
> Hi Krzysztof,
> 
> On 10/9/2025 5:22 AM, Krzysztof Kozlowski wrote:
>> On 08/10/2025 23:20, Jishnu Prakash wrote:
>>> Hi Krzysztof,
>>>
>>> On 10/4/2025 12:22 PM, Krzysztof Kozlowski wrote:
>>>> On Sat, 4 Oct 2025 at 11:42, Jishnu Prakash
>>>> <jishnu.prakash@oss.qualcomm.com> wrote:
>>>>>
>>>>> Hi Jonathan,
>>>>>
>>>>> On 9/27/2025 7:17 PM, Jonathan Cameron wrote:
>>>>>> On Fri, 19 Sep 2025 20:17:43 +0530
>>>>>> Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:
>>>>>>
>>>>>>> Hi Krzysztof,
>>>>>>>
>>>>>>> On 9/18/2025 5:45 AM, Krzysztof Kozlowski wrote:
>>>>>>>> On 18/09/2025 04:47, Jishnu Prakash wrote:
>>>>>>>>> Hi Krzysztof,
>>>>>>>>>
>>>>>>>>> On 9/17/2025 5:59 AM, Krzysztof Kozlowski wrote:
>>>>>>>>>> On 16/09/2025 16:28, Jishnu Prakash wrote:
>>>>>>>>>>>> You cannot have empty spaces in ID constants. These are abstract
>>>>>>>>>>>> numbers.
>>>>>>>>>>>>
>>>>>>>>>>>> Otherwise please point me to driver using this constant.
>>>>>>>>>>>
>>>>>>>>>>> These constants are for ADC channel numbers, which are fixed in HW.
>>>>>>>>>>>
>>>>>>>>>>> They are used in this driver: drivers/iio/adc/qcom-spmi-adc5-gen3.c,
>>>>>>>>>>> which is added in patch 4 of this series.
>>>>>>>>>>>
>>>>>>>>>>> They can be found in the array named adc5_gen3_chans_pmic[].
>>>>>>>>>>
>>>>>>>>>> Really? So point me to the line there using ADC5_GEN3_VREF_BAT_THERM.
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> We may not be using all of these channels right now - we can add them
>>>>>>>>> later based on requirements coming up. For now, I'll remove the channels
>>>>>>>>> not used in adc5_gen3_chans_pmic[].
>>>>>>>>
>>>>>>>> You are not implementing the feedback then. Please read it carefully.
>>>>>>>>
>>>>>>>
>>>>>>> Sorry, I misunderstood - so you actually meant I should remove the
>>>>>>> empty spaces in the definitions, like this?
>>>>>>>
>>>>>>> -#define ADC5_GEN3_VREF_BAT_THERM               0x15
>>>>>>> +#define ADC5_GEN3_VREF_BAT_THERM 0x15
>>>>>>>
>>>>>>> I thought this at first, but I somehow doubted this later, as I saw some
>>>>>>> other recently added files with empty spaces in #define lines, like:
>>>>>>>
>>>>>>> include/dt-bindings/iio/adc/mediatek,mt6373-auxadc.h
>>>>>>> include/dt-bindings/regulator/st,stm32mp15-regulator.h
>>>>>>>
>>>>>>> I can make this change, if you prefer this. Please let me know
>>>>>>> if I'm still missing something.
>>>>>>>
>>>>>>> Also please let me know if you want me to remove the unused
>>>>>>> channels - I would prefer to keep them if there's no issue,
>>>>>>> as we might need them later.
>>>>>>>
>>>>>> He is referring to 0x14 and below not being defined values.  So what
>>>>>> do they mean if they turn up in the DT?
>>>>>>
>>>>>
>>>>> Thanks for your clarification. To address your first point above, the macros
>>>>> added here only represent the ADC channel numbers which are supported for
>>>>> ADC5 Gen3 devices. If there are numbers missing in between (like 0x14),
>>>>> that is because there exist no valid ADC channels in HW matching those
>>>>> channel numbers.
>>>>>
>>>>> For your question above, if any of the undefined channels are used in the DT,
>>>>> they should ideally be treated as invalid when parsed in the driver probe and
>>>>> lead to an error. When I checked the code again, I saw we do not have such an
>>>>> explicit check right now, so I will add that in the next patch series.
>>>>>
>>>>> And to be clear on which channel numbers are supported, I think it may be
>>>>> best if, for now, we only add support for the channel numbers referenced in
>>>>> the array adc5_gen3_chans_pmic[] in drivers/iio/adc/qcom-spmi-adc5-gen3.c.
>>>>>
>>>>> There are only 18 channel numbers used in this array and I would remove
>>>>> all channels except for these from the binding files. During parsing, we
>>>>> would use this array to confirm if an ADC channel added in DT is supported.
>>>>>
>>>>> In case we need to add support for any more channels later, we could add
>>>>> their macros in the binding file and update the array correspondingly at
>>>>> that time.
>>>>>
>>>>> Does all this sound fine? Please let me know if you have any more concerns
>>>>> or queries.
>>>>
>>>> No, it doesn't.  You keep ignoring my arguments and responding to
>>>> something else. I prefer not to store hardware values as bindings,
>>>> because these are not bindings (and you failed to prove which SW
>>>> interface they bind) and it's really not necessary.
> 
> Sorry about the delay in replying. Let me go step by step
> over the use of the macros and how they are used by clients
> SW.
> 
> 1. In ADC Gen3, this is the superset of channels supported on all
> PMICs (with ADC):
> 
> Ref: include/dt-bindings/iio/adc/qcom,spmi-vadc.h

That's not a driver. Not SW.

> 
> /* ADC channels for PMIC5 Gen3 */
> 
> #define ADC5_GEN3_REF_GND		0x00
> #define ADC5_GEN3_1P25VREF		0x01
> #define ADC5_GEN3_VREF_VADC		0x02
> #define ADC5_GEN3_DIE_TEMP		0x03
> ....
> 
> 
> 2. Since some PMICs may not have all of these channels supported in
> HW, we have the PMIC-specific channel definitions (starting with PMIC
> name like PM8550_..) made referencing the above definitions.
> 
> Ref: include/dt-bindings/iio/adc/qcom,pm8550-adc5-gen3.h:

That's not a driver. Not SW.


> ...
>     #define PM8550_ADC5_GEN3_DIE_TEMP(sid)	((sid) << 8 | ADC5_GEN3_DIE_TEMP)
> ...
> 
> side note: This is also used for the "reg" property in the ADC channel
> definition DT nodes.
> 
> Here `sid` is needed as there can be different instances of same PMIC
> using different `sid`s on a single SoC, and also on different SoCs, the
> same PMIC may have different `sid`s.
> 
> 
> 3. This PMIC-specific definition will be used by clients like below
> (in io-channels) to get the ADC channel they need to read.
> 
>     pmic@1 {
>         temp-alarm@a00 {
>             compatible = "qcom,spmi-temp-alarm";
> 	    ...
>             io-channels = <&pmk8550_adc PM8550_ADC5_GEN3_DIE_TEMP(1)>;
>             io-channel-names = "thermal";
>         };
>     };

That's not a driver. Not SW.

> 
> 
> Can you please provide your suggestions on changes we can make
> in the above points ?

You just pasted DT. I asked about SW, software. Please read carefully
previous comments.


Best regards,
Krzysztof

