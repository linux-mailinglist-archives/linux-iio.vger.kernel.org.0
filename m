Return-Path: <linux-iio+bounces-17136-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 886A7A6A04D
	for <lists+linux-iio@lfdr.de>; Thu, 20 Mar 2025 08:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C980E8834D7
	for <lists+linux-iio@lfdr.de>; Thu, 20 Mar 2025 07:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188311EE01F;
	Thu, 20 Mar 2025 07:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fqY8rxlz"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE2A1DD889;
	Thu, 20 Mar 2025 07:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742455134; cv=none; b=fH7cpBkhLphdNgeZ6yqVkgvjxy221oxcBxkOjdjNKBM39GZqnSy+dCbfevwVlYNN7iX+8XxYY5QyEaaYymZFhj0CZh3dcS4LDRlT/3oP2nxHO7HUplczDwxKJ7NfYOd/Ura6JCCxT0aijNJ5VFnkocEKKHkF3dVJ1zbuOb7SAYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742455134; c=relaxed/simple;
	bh=kxKAgq/NDsPF5TQtNFMo6zJ1/0mznWY2fOwgsNoN6Ps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R8qq0VRtFI9NYQ8VM2mWkf1ZvdkZFxLDUaRdfRB1HInmFRJN9EoEUxNZZMa48FPgjQOltll8bKNAGMIbpXyzgaIxEuVkxzs8UP4HmLK1TuI/Sw0PCmurijZoat5BsvIJ9l1tdowWEBeM1XaCe41T8UlWjP3LRFecuHoc6oVcJks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fqY8rxlz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F030C4CEDD;
	Thu, 20 Mar 2025 07:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742455134;
	bh=kxKAgq/NDsPF5TQtNFMo6zJ1/0mznWY2fOwgsNoN6Ps=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fqY8rxlzJz6oUqi9P/lkEIP5zOvuDoKEmloABF4AuzQnj4lPqPGh0gHU5ABr6WTSI
	 eKM7OmGTjqkjmWKqFcye6xa/9mm1pykSptLiCNABwD4PDK5eTlbDtg9vRHf60hPokq
	 2cIy0p3qFnm0+/JzwfU9UvEiVETbZqAjWmqpr0plBPBaR7oSPRL4moEeSrL0GrTYsV
	 336wcIwKUAQbckJ9g7thJfkXKamJFSSbyvHFbAKbclAgxUp5HYToIbXszoR6BY1RW8
	 13u+recotEWIiIPwoT/Io/VEcwBYjlnqg3vRdKD3PPMuI5fWsFXYu9sxZwmmIczkLC
	 Wwtt1w649HRaA==
Message-ID: <f4556511-3123-4131-af2f-c4044302979e@kernel.org>
Date: Thu, 20 Mar 2025 08:18:48 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: light: bh1750: Add hardware reset support via GPIO
To: =?UTF-8?Q?Sergio_P=C3=A9rez?= <sergio@pereznus.es>,
 linux-iio@vger.kernel.org
Cc: tduszyns@gmail.com, jic23@kernel.org, lars@metafoo.de, robh@kernel.org,
 conor+dt@kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20250316145514.627-1-sergio@pereznus.es>
 <01f48f6d-55a4-4dbe-b1ae-ef8c54dcc1ff@kernel.org>
 <f0536d74-5433-4086-9dfc-1ce6aeeebe00@pereznus.es>
 <8992a79d-0859-4d7f-9b47-52e20b11260a@kernel.org>
 <144b5c43-f8c6-44d1-bcff-83158ac29781@pereznus.es>
 <202b4446-0ce4-4288-8588-6edfc32125d1@kernel.org>
 <bde38364-5c20-4030-ad7d-9ae38971b260@kernel.org>
 <bf16371c-189c-4e51-91e5-129f1dcad317@pereznus.es>
 <ac008fb8-7c82-4b9c-9d24-52ea38b920e5@kernel.org>
 <0507608a-91fd-4206-b921-942677c5f8d3@kernel.org>
 <4474831c-a8f6-496e-8348-a10e3fb7c798@pereznus.es>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <4474831c-a8f6-496e-8348-a10e3fb7c798@pereznus.es>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 19/03/2025 17:26, Sergio Pérez wrote:
> 
> El 19/03/2025 a las 9:46, Krzysztof Kozlowski escribió:
>> On 18/03/2025 18:37, Krzysztof Kozlowski wrote:
>>>> I've now run the tool correctly on my patch file and have fixed the
>>>> identified issues:
>>>> - Removed trailing whitespace
>>>> - Fixed lines exceeding 79 characters
>>>> - Fixed the inconsistency between the description and example for
>>>> reset-gpios
>>>> - Modified the existing example instead of adding a new one
>>>> - Ensured proper line endings and formatting
>>>> - Used proper get_maintainers.pl to include all recipients
>>>>
>>> Please read the guides carefully. The process is extremely simple as:
>>>
>>> git add ...
>>> git commit --signed-off
>>> git format-patch -v3 -2
>>> scripts/chekpatch.pl v3*
>>> scripts/get_maintainers.pl --no-git-fallback v3*
>>> git send-email *
>> Please read this again. I gave you detailed instruction which you still
>> decided not to follow. The instructions are quite precise on purpose,
>> because other method leads to wrong patchset - broken that or other way.
>>
> I transcribe exactly the commands I have executed:
> 
> $ git add Documentation/devicetree/bindings/iio/light/bh1750.yaml
> 
> $ git commit --signed-off
> 
> $ git add drivers/iio/light/bh1750.c
> 
> $ git commit --signed-off
> 
> $ git format-patch -v3 -2

So v3 or v4 or v5? After this email (dated 18th March), you sent v4, two
hours later not following mentioned process.

And then yesterday you sent v3 again, why this is supposed to be v5.

Read the help of these commands, instead of copying them blindly without
thinking. Every version is v3?

Best regards,
Krzysztof

