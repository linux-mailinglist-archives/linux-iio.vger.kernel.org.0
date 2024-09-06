Return-Path: <linux-iio+bounces-9249-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 361C196F96B
	for <lists+linux-iio@lfdr.de>; Fri,  6 Sep 2024 18:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF63328603E
	for <lists+linux-iio@lfdr.de>; Fri,  6 Sep 2024 16:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E951D416C;
	Fri,  6 Sep 2024 16:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C9Fw4W08"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DD61D4150;
	Fri,  6 Sep 2024 16:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725640585; cv=none; b=O3Nq1zrVeUj+2VWqaKbMtA2H1Vyz+KfdDcGIZeFK6NE5TVYQ714K/qqqCTvQoTSoNMaeXtZAEcA/SoSRoOJh9UsQgpD5eM1aSbuem4CeWvJzpAS1zV3D4L52jBqmmlG9RNlL2+sEnYSK/KRHRX0j71kmjoGvCZE8UfXWAyJBmDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725640585; c=relaxed/simple;
	bh=LKu3YT52k6QNabMuexKasL6ypZOkOFQUU+FbBMglm1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ui8ZcTxGB61s5AAmV+j0tyrzuNWhRb/RwkHyi4GKKEZgtcdGzEOF1z1g2W0DOGgNDpUMKEs3hN+Z4YwVXvqUx4O2WeHkp0GtUwGVnOUQUjdiCYRer1lpqULRGFaOjf1wMz3xC7VnmOlVG3SYVdOl/O73VbSJhtqtuGiiiHc5SOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C9Fw4W08; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A059CC4CEC4;
	Fri,  6 Sep 2024 16:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725640585;
	bh=LKu3YT52k6QNabMuexKasL6ypZOkOFQUU+FbBMglm1E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=C9Fw4W088jtv5MCHmOLUa7sZOApLCIq2Ms0rL9CJ8AwkGNqjiRR6dCJFq8DsIddP9
	 JkL1ihFA9DBqpZ2t2iobsBYRP2sA/YWBtZei7s1O4l1yeSgkBLumoxswowaDfHitaC
	 Y+utY0wjSOpSAHa189GuRd9pNiEiGnnZhUxiITq30M16wjn5bVoZOZ8ouG1XtjY1YY
	 53pw2TguF0AVmWQoQaS4NWWxOcRMMU0fYufe4mj11uxsylc3MCoIpvsjBCWlopN05z
	 vkb2JBwZolGj8EKNdJtUJy6hGv7d54zII69n9oZ+UZUZznG78cBSkuQNwFmHFSOEZF
	 78Tzr7ke9WVIQ==
Message-ID: <bb25003f-3a30-4d73-9b40-447d2d513fb3@kernel.org>
Date: Fri, 6 Sep 2024 18:36:18 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/9] dt-bindings: iio: dac: add ad3552r axi-dac
 compatible
To: David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <noname.nuno@gmail.com>, Angelo Dureghello <adureghello@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-0-87d669674c00@baylibre.com>
 <20240905-wip-bl-ad3552r-axi-v0-iio-testing-v2-5-87d669674c00@baylibre.com>
 <boahpvyzzmocnnpae2u6meub34yvqr2q3v5pzf2egp2fretlwk@ibas62hdypwo>
 <fd3f4874-b410-4e98-acba-d0fac041a40e@baylibre.com>
 <1928d0ce-cad9-4737-880e-3759c47fddbc@kernel.org>
 <058937fa93d484f3e81807d08a39bd8dfd3358e8.camel@gmail.com>
 <47c56239-51a0-4ff2-9db2-0e0184cfb086@kernel.org>
 <a0d213442b4de0b06991be2be1d7b2bb091f2b52.camel@gmail.com>
 <de4718f5-a36f-4e5c-b5e1-f1c6e2484420@baylibre.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <de4718f5-a36f-4e5c-b5e1-f1c6e2484420@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 06/09/2024 16:04, David Lechner wrote:
> On 9/6/24 8:52 AM, Nuno Sá wrote:
>> On Fri, 2024-09-06 at 14:13 +0200, Krzysztof Kozlowski wrote:
>>> On 06/09/2024 13:53, Nuno Sá wrote:
>>>> On Fri, 2024-09-06 at 11:37 +0200, Krzysztof Kozlowski wrote:
>>>>> On 06/09/2024 11:11, Angelo Dureghello wrote:
>>>>>> Hi Krzysztof,
>>>>>>
>>>>>> On 06/09/24 9:22 AM, Krzysztof Kozlowski wrote:
>>>>>>> On Thu, Sep 05, 2024 at 05:17:35PM +0200, Angelo Dureghello wrote:
>>>>>>>> From: Angelo Dureghello <adureghello@baylibre.com>
>>>>>>>>
>>>>>>>> Add a new compatible for the ad3552r variant of the generic DAC IP.
>>>>>>>>
>>>>>>>> The ad3552r DAC IP variant is very similar to the generic DAC IP,
>>>>>>>> register map is the same, but some register fields are specific to
>>>>>>>> this IP, and also, a DDR QSPI bus has been included in the IP.
>>>>>>>>
>>>>>>>> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
>>>>>>>> ---
>>>>>>>>   Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml | 1 +
>>>>>>>>   1 file changed, 1 insertion(+)
>>>>>>>>
>>>>>>>> diff --git a/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
>>>>>>>> b/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
>>>>>>>> index a55e9bfc66d7..c0cccb7a99a4 100644
>>>>>>>> --- a/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
>>>>>>>> +++ b/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
>>>>>>>> @@ -24,6 +24,7 @@ properties:
>>>>>>>>     compatible:
>>>>>>>>       enum:
>>>>>>>>         - adi,axi-dac-9.1.b
>>>>>>>> +      - adi,axi-dac-ad3552r
>>>>>>> I am sorry, but what is the product here? It looks like either wrong
>>>>>>> order or even completely redundant. What is ad3552r?
>>>>>>>
>>>>>>> And why versions are mixed with real products but without any
>>>>>>> compatibility. What does the version express in such case?
>>>>>>
>>>>>> dac-ad3552r IP (fpga) is a variant of the dac IP, very similar,
>>>>>> about the version, it still reads as 9.1.b
>>>>>>
>>>>>> so i can eventually change it to:
>>>>>>
>>>>>> adi,axi-dac-ad3552-9.1.b
>>>>>>
>>>>>> Should be more correct.
>>>>>
>>>>> No. First ad3552r is the product, so axi-dac is redundant. Second why
>>>>> adding versions if you have product names? Versioning was allowed
>>>>> because apparently that's how these are called, but now it turns out it
>>>>> is not version but names.
>>>>>
>>>>
>>>> Let me try to explain on how this whole thing works...
>>>>
>>>> We have a generic FPGA IP called axi-dac (same story is true for the other axi-
>>>> adc
>>>> IP) which adds some basic and generic capabilities like DDS (Direct digital
>>>> synthesis) and the generic one is the compatible existing now. This IP is a so
>>>> called
>>>> IIO backend because it then connects to a real converter (in this case DACs)
>>>> extending it's capabilities and also serving as an interface between another
>>>> block
>>>> (typical DMA as this is used for really high speed stuff) and the device. Now,
>>>> depending on the actual device, we may need to add/modify some features of the IP
>>>> and
>>>> this is what's happening for the ad3552r DAC (it's still build on top of the 
>>>
>>> What is "ad3552"? DAC right? Then as I said axi-dac is redundant. We do
>>> not call ti,tmp451 a ti,sensor-tmp451, right?
>>>
>>
>> Yes, I agree the DAC part is redundant. But I think the axi prefix (or suffix) is
>> meaningful to differentiate it from the bindings for the device itself.
>>
> The binding is for this [1] IP core. The documentation calls the core
> "AXI AD3552R", so I agree that "adi,axi-ad2552r" is the most sensible
> compatible name.
> 
> http://analogdevicesinc.github.io/hdl/library/axi_ad3552r/index.html

I don't see any AXI here:
https://www.analog.com/en/products/ad3552r.html
Neither here:
https://www.analog.com/media/en/technical-documentation/data-sheets/ad3552r.pdf

Are these different?

Best regards,
Krzysztof


