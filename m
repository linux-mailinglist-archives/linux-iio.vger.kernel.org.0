Return-Path: <linux-iio+bounces-16292-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01AABA4C322
	for <lists+linux-iio@lfdr.de>; Mon,  3 Mar 2025 15:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 129223ABE56
	for <lists+linux-iio@lfdr.de>; Mon,  3 Mar 2025 14:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7A72147EE;
	Mon,  3 Mar 2025 14:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SxyMUG4H"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B7B2144D4;
	Mon,  3 Mar 2025 14:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741011367; cv=none; b=qiCsmJ4fxUPnbIsYwx3ndU6ukVDGJOacVl1Spz3GIC9Gc9kkoJhInHDqxQEBxYt8FDY9ugoJ3ljx05O1tRePA4kFVtkmjnq06MjgxwV1aVlKzo4mTIW5/MrMiNSTanCZMvzgBo0Ik8OBqoK96dMf584wsGlUZi0jf7YVDHqM9kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741011367; c=relaxed/simple;
	bh=fIWG9PNPnAaZZc8vm719SkiMppJ/JW5erMwVVYRtNn8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=soqJ/IwbJxWqMGlBJBt2yUJ8sN80kMUZHS+wQaJKrn8f2Tp6qgzfK9pel09fhKRf8R+5zxApSDotzj7cOMhV0+WKl8e0fjLIDELYxF1ue1s0rx2mZfqmNLnMh8U+Jy/QIuPoRlxJNHSv8r+RohZDxAO8eyUDx2kAXj2cN1J6jSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SxyMUG4H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8380C4CEED;
	Mon,  3 Mar 2025 14:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741011366;
	bh=fIWG9PNPnAaZZc8vm719SkiMppJ/JW5erMwVVYRtNn8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SxyMUG4HKz8fgzM7u4Tzz8+pJGeVh7B/sulgn54jxExXb+kCeQcqGTS5Lbg7M2z3k
	 jhVJ2y2Yfx2oyLgRgBGEjRtyq6j3sXgRyVQoYVsMgK9Fhkptxc6nCmZ0EfyE4pClfQ
	 Bwz2cfNJBTFGLfs64ACM+DMz7HTAGE9Ru49YMJpj3dMPYI0qzq3GP8qGy6qnjdsDr1
	 sUXT5Nawtg7/oFbov/yCxpA21Xf1DBHtankPpofZGQtZPsd+2anGVK8gITm8dmo4vj
	 EQnUv5+s7TRNc/EjcUv2RVGluzsKdrHqOAyYdnZzv5AngKJxfXFup0pDhh7eP4L8SQ
	 2G3VldzEq3rDw==
Message-ID: <b3f98745-39c3-4b1f-a0e6-51e5138d840c@kernel.org>
Date: Mon, 3 Mar 2025 15:16:00 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] dt-bindings: iio: filter: Add lpf/hpf freq margins
To: Sam Winchenbach <sam.winchenbach@framepointer.org>
Cc: linux-kernel@vger.kernel.org, lars@metafoo.de,
 Michael.Hennerich@analog.com, antoniu.miclaus@analog.com, jic23@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org
References: <20250225134612.577022-1-sam.winchenbach@framepointer.org>
 <20250225134612.577022-2-sam.winchenbach@framepointer.org>
 <20250226-sparkling-caped-saluki-b1cbad@krzk-bin>
 <Z79K8Ag4SJYtJTtM@65YTFL3.secure.tethers.com>
 <05e56d15-059b-425b-9e55-66993d988f8d@kernel.org>
 <Z7-SojPPx3kOVa4y@65YTFL3.secure.tethers.com>
 <8fef9b19-a1de-4153-a186-1aeee87dea9d@kernel.org>
 <Z8WvKNcCnQI_UYZJ@65YTFL3.secure.tethers.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <Z8WvKNcCnQI_UYZJ@65YTFL3.secure.tethers.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/03/2025 14:31, Sam Winchenbach wrote:
>>> This prevents the situation where your fundamental frequency falls on, or close
>>> to, a corner frequency which could result in 3dB (half power) loss in your
>>> signal.
>>>
>>> This is all completely indepent of the high-pass filter.
>>
>> Description is confusing a bit, because it suggests the value sets the
>> corner frequency. It explicitly says this - "sets ... corner frequency"
>> and such meaning for properties we usually associate with the property
>> doing this. Here however corner frequency will be always set to rf_in
>> and you just adjust the value.
>>
> 
> How about: "Sets the minimum distance (in Hz) between the fundamental
> frequency of `rf_in` and the corner frequency of the high-pass, input filter
> when operatred in 'auto' mode. The selected high-pass corner frequency will
> be less than, or equal to, `rf_in` - `hpf-margin-hz`. If not setting is found
> that satisfies this relationship the filter will be put into 'bypass'."
> 
> Perhaps that is a bit more clear on the intention of this parameter?

Yes

> 
>>>
>>>>
>>>>> them as separate controls but I am happy to put them into an array if that is
>>>>> the idiomatic approach to situations like this. That said, I am having a
>>>>> difficult time getting dt_binding_check to pass when I have an array of uint64.
>>>>>
>>>>> When listing two items, as in your example below, I get the following:
>>>>> adi,admv8818.example.dtb: admv8818@0: adi,filter-margins-hz: [[0, 30000000], [0, 30000000]] is too long
>>>>
>>>> Tricky to say without seeing your code. Magic crystal ball had
>>>> malfunction today.
>>>
>>> This is the property:
>>>
>>>   adi,filter-margins-hz:
>>>     items:
>>>       - description: |
>>>           The minimum distance, in Hz, between rf_in and the low-pass corner
>>>           frequency when the device is used in "auto" mode. If the sum of
>>>           rf_in and this value is greater than 18.85 GHz then the low-pass
>>>           filter will be put into bypass mode, otherwise the closest corner
>>>           frequency that is greater than or equal to the sum of rf_in plus this
>>>           value will be used.
>>>         minimum: 0
>>>         maximum: 0xFFFFFFFFFFFFFFFF
>>>         default: 0
>>>       - description: |
>>>           The minimum distance, in Hz, between rf_in and the high-pass corner
>>>           frequency when the device is used in "auto" mode. If the difference
>>>           between rf_in and this value is less than 1.75 GHz then the high-pass
>>>           filter will be put into bypass mode, otherwise the closest corner
>>>           frequency that is less than or equal to the difference of rf_in and
>>>           this value will be used.
>>>         minimum: 0
>>>         maximum: 0xFFFFFFFFFFFFFFFF
>>>         default: 0
>>>
>>> And this is the example:
>>>
>>> examples:
>>>   - |
>>>     spi {
>>>       #address-cells = <1>;
>>>       #size-cells = <0>;
>>>       admv8818@0 {
>>>         compatible = "adi,admv8818";
>>>         reg = <0>;
>>>         spi-max-frequency = <10000000>;
>>>         clocks = <&admv8818_rfin>;
>>>         clock-names = "rf_in";
>>>         adi,filter-margins-hz = /bits/ 64 <30000000 30000000>;
>>
>>
>> foo-hz is in 32-bit, so basically you have here 4 32-bit numbers which
>> indeed reported by dtschema - property is too long. Drop 64-bit here.
>>
> 
> I was hoping to keep this 64 bits seeing this is a 18 GHz+ filter. I suppose
> I could change this to MHz and just lose a bit of resolution. Does that sound
> like a better approach?

Does the hardware accept Hz resolution? How many bits do you have in the
registers per each value?

Anyway, the value was 32-bit even in your original patch and your DTS
example was not correct.


> 
>> Device allows multiple LPF/HPF values to be stored in LUT tables and it
>> actually has four independent filters. Shouldn't these be included here?
>> Maybe not LUT tables, but the configuration for all filters?
>>
> 
> There are two filters, the input (high-pass) filter, and the output (low-pass)
> filter. Each filter has four banks, each with a different range of frequencies.
> Only one bank can be selected at a time. Each bank has 16 different possible
> cutoff/corner frequencies. That is a total of 64 distinct values for each of
> the two filters.

Hm, datasheet says:
"four independently controlled high-
pass filters (HPFs) and four independently controlled low-pass
filters (LPFs)"

so four each, not one each, but I guess they wanted to say banks as only
one filter/bank can be active in given time?

> 
> The issue with setting the corner frequency directly is that in certain
> applications (such as software defined radios) the fundamental frequency
> is adjustable, necessitating that the corner frequencies of the filter are
> adjusted accordingly. When the filter is in "auto" mode it is notified via
> the clock system of frequency changes, so using this information it should be
> possible to select new corner frequencies if you know the minimum distance
> between your fundamental frequency and the corner.

I am not advocating to set the corner frequency directly, but just
pointing that your current binding seems incomplete.


Best regards,
Krzysztof

