Return-Path: <linux-iio+bounces-9911-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2C0989B7B
	for <lists+linux-iio@lfdr.de>; Mon, 30 Sep 2024 09:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 482E31C21277
	for <lists+linux-iio@lfdr.de>; Mon, 30 Sep 2024 07:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A441D156653;
	Mon, 30 Sep 2024 07:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SXjlnw7/"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A1913D8A4;
	Mon, 30 Sep 2024 07:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727681522; cv=none; b=G4vJxoKk0mWPjEKu6pL4ZmElkMMYEcyNyzJn1YDEiKcrApSuHgzTevWNvQXqSfSKeeTefdo9qOLvbXGpfTRWR98q+wZKhTXYmxd3DR9Y6iqlr3wDYkmxi7Yb84MX9sv6KCpB+VuzjkvONfD4DpiEldwBTBXVMhV/ECCVEcE2TtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727681522; c=relaxed/simple;
	bh=8y4DZk4zrwaU3Yi99yTj4vQbY43hUWWXJi/BTH+cFcg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k0N/kGeMqJUQvSAjDMjj0F4pTjV6h7EgUogsq/Z2xHd/bl58eIksl4U5Zcxz8ikkar+4wTr0K8oJef0hx3mre87E9to23sxBblT4t5IjwEubvcJeYTOoSZke3lzakGRXraobuTxJDad1XkEecN1VpWpBW9OSxyDKV3EW+jXlrvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SXjlnw7/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A318C4CEC7;
	Mon, 30 Sep 2024 07:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727681521;
	bh=8y4DZk4zrwaU3Yi99yTj4vQbY43hUWWXJi/BTH+cFcg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SXjlnw7/2yYQxkbJbRLpcirNCm6oUADc8+DXRXCeKAYhyGcirYc6siRRoNUT9EA0o
	 V1whTr8NUK6RMcyFx1tpvYmUeJJqbKn0w8ExIpkDocYFbFVY5YFOz9vLfvl32KlxBb
	 XHlYX/wT0F3ljrEi7uLmTh4EuMh4TMn0EaGUVqffz6/hV0mJ+Q766Xru0rB3yB/M+p
	 3zZKewdSeQPJcOERsTF6rVTabV0H2q+tycIZ/9KTg5hEH0CzlVrBAXEmnlSxpcqTRd
	 pBULR0FYDU7s0s30gkHZqCeK5nOsSLz5h3UxzU6K2dSQF8RlFA0ZcWbU3W+Yle6EZB
	 bCWsWVheOVwWg==
Message-ID: <69e61fb9-b162-4574-927a-170b45fb3394@kernel.org>
Date: Mon, 30 Sep 2024 09:31:56 +0200
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
 Jonathan Cameron <jic23@kernel.org>
Cc: Angelo Dureghello <adureghello@baylibre.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Nuno Sa <nuno.sa@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, dlechner@baylibre.com
References: <20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-0-a17b9b3d05d9@baylibre.com>
 <20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-4-a17b9b3d05d9@baylibre.com>
 <gojq6ardhvt6vcs2kawdhdn2cj6qbpzp4p5mjjgwsypuatm5eo@3u6k4q7le46s>
 <418a8a9b-3bcf-4b8f-92a0-619a3bf26ab5@baylibre.com>
 <e8af0f3f-a09c-42d7-b8ca-dd633539af73@kernel.org>
 <0279203b6cd9f1312d9c03654c262c04ac12fbd9.camel@gmail.com>
 <fa27dc74-7b1f-4ef5-81dc-cc434da4ff89@kernel.org>
 <c721861809c17776c0fe89ead331b6e2e6b9d4b4.camel@gmail.com>
 <28834db1-3e9e-47f4-b00e-a548589d77e9@kernel.org>
 <20240929115919.0318034c@jic23-huawei>
 <ae4cfdfb9880e0a833c105fcb9e9442ef04f461b.camel@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <ae4cfdfb9880e0a833c105fcb9e9442ef04f461b.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 30/09/2024 09:20, Nuno Sá wrote:
>>>>>
>>>>> You described the driver, so how does it matter? Driver can call
>>>>> get_backend_from_parent(), right? Or get_backend_from_fwnode(parent)?  
>>>>
>>>> Well yes, just stating what the framework (also in terms of bindings) is
>>>> expecting. Of course that on the driver side we can paper around it the
>>>> way we
>>>> want. But my main point was that we can only paper around it if we use
>>>> code that
>>>> is meant not to be used.
>>>>
>>>> And, FWIW, I was (trying) replying to your comment
>>>>
>>>> "You can take it from the child-parent relationship"
>>>>
>>>> Again, we can only do that by introducing new code or use code that's not
>>>> meant
>>>> to be used. The way we're supposed to reference backends is by explicitly
>>>> using
>>>> the proper FW property.
>>>>
>>>> Put it in another way and a completely hypothetical case. If we have a spi
>>>> controller which happens to export some clock and one of it's peripherals
>>>> ends
>>>> up using that clock, wouldn't we still use 'clocks' to reference that
>>>> clock?  
>>>
>>> I asked how coupled are these devices. Never got the answer and you are
>>> reflecting with question. Depends. Please do not create hypothetical,
>>> generic scenarios and then apply them to your one particular opposite case.
>>
>> I'll throw a possible clarifying question in here.  Could we use this
>> device with a multimaster SPI setup such that the control is on a conventional
>> SPI controller (maybe a qspi capable one), and the data plane only goes
>> through
>> a specific purpose backend?  If so, then they are not tightly coupled and
>> the reference makes sense.  Putting it another way, the difference between
>> this case and all the prior iio-backend bindings is the control and dataplanes
>> use the same pins.  Does that have to be the case at the host end?  If it
>> does,
>> then the reference isn't strictly needed and this becomes a bit like
>> registering a single device on an spi bus or an i2c bus depending on who
>> does the registering (which is down to the parent in DT).
>>
> 
> So, we currently have two drivers (with a new one being added in this series)
> for the same device:
> 
> 1) A SPI one tied to a typical spi controller. This is the "low speed"
> implementation and does not use backends;
> 2) The new platform device that is connected like this to the backend.

Drivers, platform devices are Linux specifics. These were not our
questions here. You are responding with description matching current
Linux code.

> 
> So yes, my understanding (but Angelo should know better :)) is that they are
> tightly coupled. Putting it in another way, the new platform device is very much
> specific to this parent (and yeah, this is a very special usecase where control

Again, Linux stuff.

> and data planes are controlled by the IIO backend) and should not exist with it.

I pointed this issue already in this thread. You keep describing
drivers, so of course they will be coupled as much as you write them.

Best regards,
Krzysztof


