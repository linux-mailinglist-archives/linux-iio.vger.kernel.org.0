Return-Path: <linux-iio+bounces-24936-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC9FBCF35B
	for <lists+linux-iio@lfdr.de>; Sat, 11 Oct 2025 11:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 379B2189FEF0
	for <lists+linux-iio@lfdr.de>; Sat, 11 Oct 2025 09:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835ED2475C7;
	Sat, 11 Oct 2025 09:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HKIp3WXP"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D1723B62C;
	Sat, 11 Oct 2025 09:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760176371; cv=none; b=XtbTuOG12BssWPGSj5Yc0p3N17emZf2jKhcVgGTrrH3v9nop3ajYu+4CT71U5tiIjOh4RnjTVvqcBFr61oEqFlZBGE3oTfYanen7TGe6SCI0h5aBHed5PXZxA8kFR9xm8C9Qgvombvctwucofxuf7wcNE5aaqU8BzJ+uLkWxlfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760176371; c=relaxed/simple;
	bh=jc9YZsle3WLAtfJzis9aeE92ql/1xDWBDtwmj5gNJAA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fig4F6yQuHU5qOTW3pUXvu4SZUFZCZpwfVqedPbA183eQ7QcSUfLrAyRlHjJ6qnq4Wm7lR3Navg4d0mMuCpbwuTrv97B5eA463UVCOw70Umpcwbd5Dc4YMJT9g+JxsMpuu5OZALjnQ2q02oDK4x3V8fAN2wiiWPxGaV/JO+toLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HKIp3WXP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A29EEC4CEF8;
	Sat, 11 Oct 2025 09:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760176370;
	bh=jc9YZsle3WLAtfJzis9aeE92ql/1xDWBDtwmj5gNJAA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HKIp3WXPyfB84fp5zyGifttUxZkr0IRSM8nxihrtsvt7E6XHkmbbAnNWInWsXujB5
	 qEjcRPqrWHlTRdfwShTF9rntiupGS24f4CZPNQqT3U9OqDxsZch6q6dYr9Wy+XICyt
	 QVa2XvBCsQwYGtHpwTpvyFTr2d4dMZ5VBQ6l4yfUkirsva0UBaOg9TRE5UNdCDx7ua
	 Dqq6nYx46JrPIF2RBClntQI1JNg0e5R7RWuKKiPWOIVrM7JdaFYuWcWGx2Mkwzs5Jt
	 dMQA9xuobUFlt7sfiatKA8LtVFFAQ9+Y9zOmfn8IJ4QXK/q5S3BpWt0SbWZYYWo/J+
	 NYexfH06tu+xg==
Message-ID: <0beae4dd-2feb-4891-b7b0-0f63db8f5615@kernel.org>
Date: Sat, 11 Oct 2025 11:52:43 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/6] Battery temperature ADC plumbing on Qualcomm
 platforms
To: David Lechner <dlechner@baylibre.com>,
 Luca Weiss <luca.weiss@fairphone.com>, Jonathan Cameron <jic23@kernel.org>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Laxman Dewangan <ldewangan@nvidia.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Jens Reidel <adrian@mainlining.org>,
 Casey Connolly <casey.connolly@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20251010-bat-temp-adc-v1-0-d51ec895dac6@fairphone.com>
 <c770c799-4318-4c40-bd62-3cefbbbef731@baylibre.com>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <c770c799-4318-4c40-bd62-3cefbbbef731@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi All,

Luca thank you for Cc-ing me.

On 10-Oct-25 10:56 PM, David Lechner wrote:
> On 10/10/25 6:21 AM, Luca Weiss wrote:
>> This is an RFC which implements a potential solution to get battery
>> temperature readings working on for example smartphones with Qualcomm
>> SoCs.
>>
> 
> ...
> 
>> 3. Add temperature-lookup-table as property to simple-battery
>>
>> Since the NTC is a part of the battery pack, adding a
>> temperature-lookup-table property to simple-battery would make sense
>> instead of having this lookup table be standalone in the
>> generic-adc-thermal node. However being able to re-use the existing code
>> in generic-adc-thermal lead me to the current proposal.
>>
> Did you consider creating a specific compatible string for the battery pack?
> Then the battery node could have the io-channels property for the ADC
> connected to the temperature sensor. Then a specific battery driver could
> handle the conversion as needed rather than filling the devicetree with
> conversion tables.

That will require a driver update, filling the driver (and thus memory)
with conversion tables each time a new battery model (one model phone
can have multiple battery revisions) comes out.

That seems undesirable. To me these conversion tables are very much
something which belongs in DT rather then being hardcoded in
the driver.

Also contrast this to ACPI where there actually is a mechanism defined
for thermal lookup tables and there all these things typically just
work when the ACPI tables are written properly. IMHO we want to move
more towards this direction where things just work without requiring
kernel code changes for every new model.

And we already have a mechanism in DT to map an ADC voltage to
a temperature in the generic-adc-thermal driver.

So all that is left to do really is to come up with a clean way
to export the temperature from the generic-adc-thermal driver
to the generic-adc-battery driver.

> The simple-battery bindings are already far from simple! So I would not
> be inclined to add more to it.

I think we all agree on this and we also don't want to duplicate
the generic-adc-thermal bindings + code implementing that functionality.

IMHO not wanting to duplicate the bindings + functionality applies to
both: a) directly exporting an IIO temp channel from the ADC driver and
b) adding volt -> temp mapping functionality to the simple-battery bindings.

So that basically leaves us with coming up with a way for
the generic-adc-battery code to consume the temperature coming out of
the generic-adc-thermal code and there are 2 ways to do this:

1. Modify the generic-adc-thermal driver to export an IIO channel
2. Modify the thermal-zone core to allow referencing to a thermal-zone
   with a phandle *and* modify generic-adc-battery to be able to
   optionally get the temperature from a thermal-zone instead of
   from an IIO-channel

Of these two options 1. clear is the most KISS option. SO I agree with
Luca that 1. as implemented in this series is the best way forward.

Regards,

Hans



