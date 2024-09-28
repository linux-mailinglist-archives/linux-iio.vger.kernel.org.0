Return-Path: <linux-iio+bounces-9807-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82ED8988F26
	for <lists+linux-iio@lfdr.de>; Sat, 28 Sep 2024 14:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DDBC1F218D7
	for <lists+linux-iio@lfdr.de>; Sat, 28 Sep 2024 12:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64B0187350;
	Sat, 28 Sep 2024 12:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bojNiA6l"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEC0C139;
	Sat, 28 Sep 2024 12:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727526037; cv=none; b=nDlMqqjApIX77510U06Y5m0s9jKBei2l4kc/V8fOy/ZxkIYjuhBycDLFrEevNM1kCVyC6GBSQuSAh//4D3zMof0zLaQxRezpjCSnnLE7SLyAPvf4c9rsRdcmpas7QJQvgPIhtisw5eBjzPvqlJxvE0UsbvPheUJ76/StkTY+NrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727526037; c=relaxed/simple;
	bh=VlJucxXTuioDoY6O7y4XDszULEPjMWJaI+McDBEM6kY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=biDu1IT11ZqgIOIr9iPhhf+/tmV1Vk+6FFMTHnxhc6+lZSTJyRPxNpgL2ShVKBcre7wG1eX/nfhIV1IAzDfBJcIAKUX8BQY6ZAiZAVoYcIPesMZFUzEAJUDQrCzEcAwqKRicSuyeNpd9xfDcYVaRbRD5U7DA9/v+J+7++dnjHvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bojNiA6l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E97E3C4CEC3;
	Sat, 28 Sep 2024 12:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727526036;
	bh=VlJucxXTuioDoY6O7y4XDszULEPjMWJaI+McDBEM6kY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bojNiA6ldaXTfYQI641aopuu8I3gzz3B56wd5VCZFUU7dpKOdCb0pGe2qtCooYt9W
	 UaJK+CkzjQ/A+uAvMrpm06/mJC9uN1oVlFcAsEmwBsm6Qq1oMft0tEF9Zaj3tEdtiR
	 /Kjp/5kBwTocZR73VJlHysszOcqLNtjNkD3y2VwRyGR46ifZI5E/XZ/ZcMRmOuZhd/
	 GeeMoF9v4rycVIvqpVXy45rOKFOug9d7Y4d5Oj57TA+H5GSz3byB4iLjn233O5RBoW
	 26E/nWBSPg2MpIav7n+rgnH+c8ThCHZc6viD7jeUAHdVrNrHuDALwFFSjyYeUCtpVj
	 63PtPfCM9A++w==
Message-ID: <28834db1-3e9e-47f4-b00e-a548589d77e9@kernel.org>
Date: Sat, 28 Sep 2024 14:20:29 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/10] dt-bindings: iio: dac: ad3552r: add io-backend
 support
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Angelo Dureghello <adureghello@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Olivier Moysan <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 dlechner@baylibre.com
References: <20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-0-a17b9b3d05d9@baylibre.com>
 <20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-4-a17b9b3d05d9@baylibre.com>
 <gojq6ardhvt6vcs2kawdhdn2cj6qbpzp4p5mjjgwsypuatm5eo@3u6k4q7le46s>
 <418a8a9b-3bcf-4b8f-92a0-619a3bf26ab5@baylibre.com>
 <e8af0f3f-a09c-42d7-b8ca-dd633539af73@kernel.org>
 <0279203b6cd9f1312d9c03654c262c04ac12fbd9.camel@gmail.com>
 <fa27dc74-7b1f-4ef5-81dc-cc434da4ff89@kernel.org>
 <c721861809c17776c0fe89ead331b6e2e6b9d4b4.camel@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <c721861809c17776c0fe89ead331b6e2e6b9d4b4.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 25/09/2024 13:55, Nuno Sá wrote:
> On Wed, 2024-09-25 at 09:22 +0200, Krzysztof Kozlowski wrote:
>> On 24/09/2024 14:27, Nuno Sá wrote:
>>> On Tue, 2024-09-24 at 10:02 +0200, Krzysztof Kozlowski wrote:
>>>> On 23/09/2024 17:50, Angelo Dureghello wrote:
>>>>> Hi Krzysztof,
>>>>>
>>>>> On 22/09/24 23:02, Krzysztof Kozlowski wrote:
>>>>>> On Thu, Sep 19, 2024 at 11:20:00AM +0200, Angelo Dureghello wrote:
>>>>>>> From: Angelo Dureghello <adureghello@baylibre.com>
>>>>>>>
>>>>>>> There is a version AXI DAC IP block (for FPGAs) that provides
>>>>>>> a physical bus for AD3552R and similar chips, and acts as
>>>>>>> an SPI controller.
>>>>>>>
>>>>>>> For this case, the binding is modified to include some
>>>>>>> additional properties.
>>>>>>>
>>>>>>> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
>>>>>>> ---
>>>>>>>   .../devicetree/bindings/iio/dac/adi,ad3552r.yaml   | 42
>>>>>>> ++++++++++++++++++++++
>>>>>>>   1 file changed, 42 insertions(+)
>>>>>>>
>>>>>>> diff --git
>>>>>>> a/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
>>>>>>> b/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
>>>>>>> index 41fe00034742..aca4a41c2633 100644
>>>>>>> --- a/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
>>>>>>> +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
>>>>>>> @@ -60,6 +60,18 @@ properties:
>>>>>>>       $ref: /schemas/types.yaml#/definitions/uint32
>>>>>>>       enum: [0, 1, 2, 3]
>>>>>>>   
>>>>>>> +  io-backends:
>>>>>>> +    description: The iio backend reference.
>>>>>>> +      An example backend can be found at
>>>>>>> +       
>>>>>>> https://analogdevicesinc.github.io/hdl/library/axi_ad3552r/index.html
>>>>>>> +    maxItems: 1
>>>>>>> +
>>>>>>> +  adi,synchronous-mode:
>>>>>>> +    description: Enable waiting for external synchronization
>>>>>>> signal.
>>>>>>> +      Some AXI IP configuration can implement a dual-IP layout,
>>>>>>> with
>>>>>>> internal
>>>>>>> +      wirings for streaming synchronization.
>>>>>>> +    type: boolean
>>>>>>> +
>>>>>>>     '#address-cells':
>>>>>>>       const: 1
>>>>>>>   
>>>>>>> @@ -128,6 +140,7 @@ patternProperties:
>>>>>>>             - custom-output-range-config
>>>>>>>   
>>>>>>>   allOf:
>>>>>>> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
>>>>>>>     - if:
>>>>>>>         properties:
>>>>>>>           compatible:
>>>>>>> @@ -238,4 +251,33 @@ examples:
>>>>>>>               };
>>>>>>>           };
>>>>>>>       };
>>>>>>> +
>>>>>>> +  - |
>>>>>>> +    axi_dac: spi@44a70000 {
>>>>>>> +        compatible = "adi,axi-ad3552r";
>>>>>> That is either redundant or entire example should go to the parent
>>>>>> node,
>>>>>> if this device is fixed child of complex device (IOW, adi,ad3552r
>>>>>> cannot
>>>>>> be used outside of adi,axi-ad3552r).
>>>>>
>>>>> ad3552r can still be used by a generic "classic" spi
>>>>> controller (SCLK/CS/MISO) but at a slower samplerate, fpga
>>>>> controller only (axi-ad3552r) can reach 33MUPS.
>>>>
>>>> OK, then this is just redundant. Drop the node. Parent example should
>>>> contain the children, though.
>>>>>
>>>>>>
>>>>>>> +        reg = <0x44a70000 0x1000>;
>>>>>>> +        dmas = <&dac_tx_dma 0>;
>>>>>>> +        dma-names = "tx";
>>>>>>> +        #io-backend-cells = <0>;
>>>>>>> +        clocks = <&ref_clk>;
>>>>>>> +
>>>>>>> +        #address-cells = <1>;
>>>>>>> +        #size-cells = <0>;
>>>>>>> +
>>>>>>> +        dac@0 {
>>>>>>> +            compatible = "adi,ad3552r";
>>>>>>> +            reg = <0>;
>>>>>>> +            reset-gpios = <&gpio0 92 0>;
>>>>>> Use standard defines for GPIO flags.
>>>>>
>>>>> fixed, thanks
>>>>>
>>>>>>> +            io-backends = <&axi_dac>;
>>>>>> Why do you need to point to the parent? How much coupled are these
>>>>>> devices? Child pointing to parent is not usually expected, because
>>>>>> that's obvious.
>>>>>
>>>>>
>>>>> "io-backends" is actually the way to refer to the backend module,
>>>>> (used already for i.e. ad9739a),
>>>>> it is needed because the backend is not only acting as spi-controller,
>>>>> but is also providing some APIs for synchronization and bus setup
>>>>> support.
>>>>
>>>>
>>>> But if backend is the parent, then this is redundant. You can take it
>>>> from the child-parent relationship. Is this pointing to other devices
>>>> (non-parent) in other ad3552r configurations?
>>>>
>>>
>>> The backend is a provider-consumer type of API. On the consumer side (which
>>> is the
>>> driver the child node will probe on), we need to call devm_iio_backend_get()
>>> to get
>>> the backend object (which obviously is the parent). For that, 'io-backends'
>>> is being
>>
>> You described the driver, so how does it matter? Driver can call
>> get_backend_from_parent(), right? Or get_backend_from_fwnode(parent)?
> 
> Well yes, just stating what the framework (also in terms of bindings) is
> expecting. Of course that on the driver side we can paper around it the way we
> want. But my main point was that we can only paper around it if we use code that
> is meant not to be used.
> 
> And, FWIW, I was (trying) replying to your comment
> 
> "You can take it from the child-parent relationship"
> 
> Again, we can only do that by introducing new code or use code that's not meant
> to be used. The way we're supposed to reference backends is by explicitly using
> the proper FW property.
> 
> Put it in another way and a completely hypothetical case. If we have a spi
> controller which happens to export some clock and one of it's peripherals ends
> up using that clock, wouldn't we still use 'clocks' to reference that clock?

I asked how coupled are these devices. Never got the answer and you are
reflecting with question. Depends. Please do not create hypothetical,
generic scenarios and then apply them to your one particular opposite case.

Best regards,
Krzysztof


