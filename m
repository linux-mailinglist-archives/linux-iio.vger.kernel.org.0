Return-Path: <linux-iio+bounces-16251-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE0DA4B8E1
	for <lists+linux-iio@lfdr.de>; Mon,  3 Mar 2025 09:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D02B164837
	for <lists+linux-iio@lfdr.de>; Mon,  3 Mar 2025 08:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943CA1C5D76;
	Mon,  3 Mar 2025 08:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D6u85m+E"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4848A13A3F7;
	Mon,  3 Mar 2025 08:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740989586; cv=none; b=X68R5eV1rV1h1gzrytYCDNi2IoxXRAcASW6q5HmmrDyw+xVNCEJSAL4t+CVg0PGx8vNnW3XcXyVeJ1yMnGRgzEs7RdbzOQ9ASKwJPwpKMqyMopE8zv9TqLSbjkJfJsCciAyzJ3V/A5HGVetjhlA90+RcXweuUGy1YQC8JKA7dI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740989586; c=relaxed/simple;
	bh=9ihAOKn6ZNhaDzfg12Z6+9NZGqg9rcVXIcfZg7IpUaA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZU2L31buIGT/Zt0yuNHDc4YB56Yh2rioM1SqFbExfrW9svFvM1a/xSyhtrrwamHu295Lvfb/a2xGBUES9PTyrtkLu2UB2+ynEVr26W8CmqCtmxojvV5s6oo4d1SSlKO8Ww3qWXZenlQyTmJEiEOSu5meik9x4B+L3wiBm5Xh1CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D6u85m+E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8143C4CED6;
	Mon,  3 Mar 2025 08:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740989585;
	bh=9ihAOKn6ZNhaDzfg12Z6+9NZGqg9rcVXIcfZg7IpUaA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=D6u85m+EBq9ZLj1Pg0JuX6T2Y68uywurmz2t89blqKWj8+HcP16bXplru+fexQ14T
	 YIBwtHftM36+A5dNOxrui45NP6HMuueD77J/rDXNtOWsjId4doq72zu287C9oq0tsU
	 VpZlbeUAGzUw45s+OdVyUseIRPXRljRZOT7zfOGyBv3CKUutWpX6XD9RuN/3NWmQ/z
	 Kny1gq2RBdZmWtRzD38WADDN2bpBZe62UPs44OYJpKZMM7acXIkv3jb6FOjX/wt442
	 0gWfQKVtFGnhTuUEyf4uCz0czQj7c1G/RU1Ht0j/rzBKJjyZBuErMvVaT4DIs9Bti+
	 FvVdStH4CTVDA==
Message-ID: <8fef9b19-a1de-4153-a186-1aeee87dea9d@kernel.org>
Date: Mon, 3 Mar 2025 09:13:00 +0100
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
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <Z7-SojPPx3kOVa4y@65YTFL3.secure.tethers.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/02/2025 23:16, Sam Winchenbach wrote:
>>>>> +  adi,hpf-margin-hz:
>>>>> +    description:
>>>>> +      Sets maximum high-pass corner frequency to the frequency of rf_in minus
>>>>> +      this value when in auto mode.
>>>>
>>>> IIUC, these are two bounds - lower and upper - in relation to something
>>>> else (like rf_in frequency)? If so, make it an array (naming to be
>>>> discuss, I assume you know better what's that):
>>>
>>> It is true that these are both related to rf_in but both the low and high pass
>>> filters can operate independently. Logically, IMO, it makes more sense to have
>>
>>
>> You mean you can set only low or high pass and keep other as default?
>> But what is the default then - something from reset value or "0" means
>> disabled?
> 
> This value isn't setting the corner frequency of the filter, but the minimum
> distance the corner must be from the fundamental frequency. So, for example,
> if rf_in is 3.35 GHz and you set lpf-margin-hz to 0 then the corner frequency
> will be set to 3.35 GHz because that is an exact value supported by the device.
> 
> If lpf-margin-hz is set to 30 MHz (for example), then corner frequency would be
> at least 3.35 GHz + 30 MHz = 3.38 GHz.  3.49 GHz is the closest corner
> frequency without going below 3.38 GHz that is supported by the device, so that
> is what will be selected.
> 
> This prevents the situation where your fundamental frequency falls on, or close
> to, a corner frequency which could result in 3dB (half power) loss in your
> signal.
> 
> This is all completely indepent of the high-pass filter.

Description is confusing a bit, because it suggests the value sets the
corner frequency. It explicitly says this - "sets ... corner frequency"
and such meaning for properties we usually associate with the property
doing this. Here however corner frequency will be always set to rf_in
and you just adjust the value.

> 
>>
>>> them as separate controls but I am happy to put them into an array if that is
>>> the idiomatic approach to situations like this. That said, I am having a
>>> difficult time getting dt_binding_check to pass when I have an array of uint64.
>>>
>>> When listing two items, as in your example below, I get the following:
>>> adi,admv8818.example.dtb: admv8818@0: adi,filter-margins-hz: [[0, 30000000], [0, 30000000]] is too long
>>
>> Tricky to say without seeing your code. Magic crystal ball had
>> malfunction today.
> 
> This is the property:
> 
>   adi,filter-margins-hz:
>     items:
>       - description: |
>           The minimum distance, in Hz, between rf_in and the low-pass corner
>           frequency when the device is used in "auto" mode. If the sum of
>           rf_in and this value is greater than 18.85 GHz then the low-pass
>           filter will be put into bypass mode, otherwise the closest corner
>           frequency that is greater than or equal to the sum of rf_in plus this
>           value will be used.
>         minimum: 0
>         maximum: 0xFFFFFFFFFFFFFFFF
>         default: 0
>       - description: |
>           The minimum distance, in Hz, between rf_in and the high-pass corner
>           frequency when the device is used in "auto" mode. If the difference
>           between rf_in and this value is less than 1.75 GHz then the high-pass
>           filter will be put into bypass mode, otherwise the closest corner
>           frequency that is less than or equal to the difference of rf_in and
>           this value will be used.
>         minimum: 0
>         maximum: 0xFFFFFFFFFFFFFFFF
>         default: 0
> 
> And this is the example:
> 
> examples:
>   - |
>     spi {
>       #address-cells = <1>;
>       #size-cells = <0>;
>       admv8818@0 {
>         compatible = "adi,admv8818";
>         reg = <0>;
>         spi-max-frequency = <10000000>;
>         clocks = <&admv8818_rfin>;
>         clock-names = "rf_in";
>         adi,filter-margins-hz = /bits/ 64 <30000000 30000000>;


foo-hz is in 32-bit, so basically you have here 4 32-bit numbers which
indeed reported by dtschema - property is too long. Drop 64-bit here.

Device allows multiple LPF/HPF values to be stored in LUT tables and it
actually has four independent filters. Shouldn't these be included here?
Maybe not LUT tables, but the configuration for all filters?

Best regards,
Krzysztof

