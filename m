Return-Path: <linux-iio+bounces-27269-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 601D6CD4084
	for <lists+linux-iio@lfdr.de>; Sun, 21 Dec 2025 14:03:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3BF3A300C5D0
	for <lists+linux-iio@lfdr.de>; Sun, 21 Dec 2025 13:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82B62FB630;
	Sun, 21 Dec 2025 13:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o20VzUNC"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8783D286422;
	Sun, 21 Dec 2025 13:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766322180; cv=none; b=X0+XLpLOyUCwnLqmZlQoeJiwZ2m3VocoYFgSgwWbtDxDoMDnBROMMV0tZ0u+3ZjwdfLR8W3Yg1o6O8HIMHaXNjIVA7sXPJn2fdZIGZaFUQ3Tv6FaAw4ByHf6YHDW5OQNAE3J9PEHXmjfknWlNZUVIGw8zj/DuGoFhp1kKJK8vgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766322180; c=relaxed/simple;
	bh=tpcVf81xYJEjtwqPKa0hlT7quahUwBDwxVtEoAIA+bI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FJXoFmHx3XCNwrA86oYBZxouj7dXwJ2X+CfBPgEuh+aphFWWX3bLlKjsLQ/HMQ2kDl+L5xUcylYJwVdMhBu/R8WeKD/7814sm2ruRmW+HU5uRlh8+SW1/IBwgUZualJM1cbWlaIhfG0twKmd3gns8581H13indH7sdLP7cPEjPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o20VzUNC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AC1CC116C6;
	Sun, 21 Dec 2025 13:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766322180;
	bh=tpcVf81xYJEjtwqPKa0hlT7quahUwBDwxVtEoAIA+bI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=o20VzUNC0RvFOBwdM6RUA43CEcYZD8UzAP4g0bn0/Ia2PqpCvlmHCQHe1ZnRfxgMU
	 0Yu4fS7Id1dzDxgMEwCKBHFhtWhgOJe8mi1eN5cJoe4v/+V/zB00ko5c/Py+4eDe55
	 rNJM0K+PxS8FMTz5s4SMavXEY65CryOFZU6kIeqGeiHmSrF8rM+knSc2Z20yb7Nba8
	 4pY3Ldeea9Byo1SISKKVao5OpghXO3nQtG5igbtaFW4uiIrEHSBZsvB854ciXEbcJL
	 xb5V6+k9JV2DAlE7Yds2LiL81Bd015Pkwp6Pns8p66gZC8fniDjmR/2hKdJKE2rLJT
	 O1cnOVgSaBpGw==
Message-ID: <326c3e83-059e-4e96-ab99-d4a33eb3b56f@kernel.org>
Date: Sun, 21 Dec 2025 14:02:51 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] dt-bindings: iio: frequency: add adf41513
To: 455.rodrigo.alencar@gmail.com,
 Rodrigo Alencar <rodrigo.alencar@analog.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
References: <20251219-adf41513-iio-driver-v2-0-be29a83d5793@analog.com>
 <20251219-adf41513-iio-driver-v2-1-be29a83d5793@analog.com>
 <20251220-bouncy-perky-tarantula-d9b3be@quoll>
 <gz36kmewv4bhwqz6d3xqatcx65uzukqcgsvfbwhr7c3yhw225z@edeggfhjws2h>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <gz36kmewv4bhwqz6d3xqatcx65uzukqcgsvfbwhr7c3yhw225z@edeggfhjws2h>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/12/2025 19:05, 455.rodrigo.alencar@gmail.com wrote:
> Hi Krzystof,
> 
> thanks for taking a look into this again. It was my first patch it didn't want
> to draw more attention or discussion to the V1 patch as it was declared not ready
> at its very first review.
> 
> On 25/12/20 10:21AM, Krzysztof Kozlowski wrote:
>> On Fri, Dec 19, 2025 at 12:34:48PM +0000, Rodrigo Alencar wrote:
>>> dt-bindings for ADF41513, an ultralow noise PLL frequency synthesizer that
>>> can be used to implement local oscillators (LOs) as high as 26.5 GHz.
>>> Most properties refer to existing PLL driver properties (e.g. ADF4350).
>>
>> What is "existing PLL driver"? I know about motor drivers, but can you
>> drive PLL?
>>
>> And how is ADF4350 related to this binding. I do not see ADF4350
>> compatible here at all. Describe hardware, a real one.
> 
> ADF4350 is an older one, and its bindings can be found at:
> Documentation/devicetree/bindings/iio/frequency/adi,adf4350.yaml
> It is a similar part, but yet very different.
> 
>>
>> Nothing improved.
>>
>> You ignored comments, did not bother to respond to them and then sent
>> the same.
> 
> Sorry for not responding on the V1 thread, but the previous patch had to be reviewed internally
> first. It is not true that nothing is improved, in fact, it has changed a lot, here are some notes:

Process is not like that. You first review internally, then you send.
After you sent and receive comments, you respond to these comments.

> * adi,power-up-frequency is not carrying the -hz postfix because it forces to be a uint32 by
> the dt-bindings check. For that variable it needs to be uint64 as the part supports up to 26.5 GHz > 2^32

And what granularity do you need? Why mhz does not work?

> * The properties related to the reference input signal path: reference-div-factor, reference-doubler-enable
> reference-div2-enable are declared here because they are constraints for the PFD frequency definition,
> which is the frequency that the output signal is updated, important for the loop-filter and VCO design.
> * added support for all different power supply regulators.

Sorry, but I cannot respond that way. We discuss inline, so I have
entire picture, not some parts of message semi-quoted here. I don't
remember what was there and I am not going to keep looking for that.

You need to adjust to mailing list discussion style, not introduce the
others. I have just way too many other patches to deal with, so
implement the feedback or respond properly.

Best regards,
Krzysztof

