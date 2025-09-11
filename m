Return-Path: <linux-iio+bounces-23984-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D784B5332A
	for <lists+linux-iio@lfdr.de>; Thu, 11 Sep 2025 15:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F1A75A4A87
	for <lists+linux-iio@lfdr.de>; Thu, 11 Sep 2025 13:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C8C324B0C;
	Thu, 11 Sep 2025 13:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pb1dCeLi"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9B561FFE;
	Thu, 11 Sep 2025 13:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757596030; cv=none; b=o5jjKQa2VkjibvV+KEk/xtUr3aIHJ7cxJm8rDCtmP+n88JsCQQgBI3KHHggjEPHGhabLuLJl7I3ektVRtWlxI7reYu/64OLbtuHSq4B21lFDZvUIDhqk+VMVlk0qpsHrJDw7usBPuOIMEgHtUaESfBaf2Sxxwgjk8NdIBNBQpk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757596030; c=relaxed/simple;
	bh=RWKhIIzKw74Ldz2LKrbaS8ybBgR7LLoijT68vLLdbEw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N2UZnypAev0kJDZdnkLXLcoFco9B7Fm/EV30qaCGohzPv81NC1BZZtLKc3HNz7AiSb7PipEGEVp4wGNu6zSpEEqBgwGUS9vr3HeiwpffGGKUhNX4qrEP78Y8X03XRYl6Ph2Bs39OVIIK4erlA0+cPTCWcAr2Fu856J/AGHo6GdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pb1dCeLi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65712C4CEF8;
	Thu, 11 Sep 2025 13:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757596030;
	bh=RWKhIIzKw74Ldz2LKrbaS8ybBgR7LLoijT68vLLdbEw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Pb1dCeLieglj3LY662S/zagkYDg6b+Reom8hm93YAod/fn+IlJZxmiPkr6DtVR5kR
	 JZjILz0Q+viONNkBiBkq30jtzdGvM4EYUlM7ZhFI6/LLQMNNGZjRzSWCX+Nn99sdYJ
	 jNVqI4miqoTC2S51iPBEn1jnEIB2YmxV00CaqrQ2pm7qdELNCC51z09GufEsMPLUsY
	 Vaa6kNFKIM1McObmdnCWUrsVLxVSb++vJDOL/+NU0DC5ccsa8mtt+tOgLvGipICB/9
	 9jh1I85BcXaqBkuknpf4VALTe5kjKd/92ZZFHrQ5fexims1n6iiSThurvJigJcibLZ
	 qBNS0wL8R2Nbw==
Message-ID: <391229ff-d85a-4707-8e7c-ea64e0e3d7cb@kernel.org>
Date: Thu, 11 Sep 2025 15:07:05 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/14] iio: accel: bma220: reset registers during init
 stage
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno S?? <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250910-bma220_improvements-v2-0-e23f4f2b9745@subdimension.ro>
 <20250910-bma220_improvements-v2-7-e23f4f2b9745@subdimension.ro>
 <a10a2f6d-6cb7-4922-b505-dc6994f0415f@kernel.org> <aMLCWFatVkePTxCa@sunspire>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <aMLCWFatVkePTxCa@sunspire>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/09/2025 14:36, Petre Rodan wrote:
> 
> Hi Krzysztof,
> 
> On Thu, Sep 11, 2025 at 09:35:52AM +0200, Krzysztof Kozlowski wrote:
>> On 10/09/2025 09:57, Petre Rodan wrote:
>>> Bring all configuration registers to default values during device probe().
>>>
>>> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
>>> ---
>>>  drivers/iio/accel/bma220_core.c | 71 ++++++++++++++++++++++++++++-------------
>>>  1 file changed, 49 insertions(+), 22 deletions(-)
>>>
>>> diff --git a/drivers/iio/accel/bma220_core.c b/drivers/iio/accel/bma220_core.c
>>> index b6f1374a9cca52966c1055113710061a7284cf5a..322df516c90a7c645eeca579cae9803eb31caad1 100644
>>> --- a/drivers/iio/accel/bma220_core.c
>>> -static int bma220_init(struct spi_device *spi)
>>> +static int bma220_reset(struct spi_device *spi, bool up)
>>>  {
>>> -	int ret;
>>> -	static const char * const regulator_names[] = { "vddd", "vddio", "vdda" };
>>> +	int i, ret;
>>>  
>>> -	ret = devm_regulator_bulk_get_enable(&spi->dev,
>>
>>
>> You just added this code in patch 6. Don't add code which immediately
>> you remove. I understand you re-add this later, so basically it is a
>> move, but such patch diff is still confusing.
> 
> sorry, but this is an artefact of 'git diff' I don't think I have no control of.


Don't think so. Before bma220_init() was above bma220_power(). After
your patch bma220_init() is BELOW bma220_power(), so that's a move.



> 
> the bma220_reset() function was added to bma220_core.c with this patch and the
> diff process merged lines from this new function with lines from bma220_init()
> causing the apparent removal of the lines added in the previous patch.
> if you look a few lines below your cut, the bma220_init() function contains the
> code:
> 
> +static int bma220_init(struct spi_device *spi)
> +{
> +	int ret;
> +	static const char * const regulator_names[] = { "vddd", "vddio", "vdda" };
> +
> +	ret = devm_regulator_bulk_get_enable(&spi->dev,
> +					     ARRAY_SIZE(regulator_names),
> +					     regulator_names);
> +	if (ret)
> +		return dev_err_probe(&spi->dev, ret, "Failed to get regulators\n");
> [..]
> 
> Just for my curiosity, do reviewers apply the patches one by one to (a branch of)
> the tree itself or do they provide feedback directly based on the diffs?


Each commit must stand on its own, is reviewed independently and entire
patchset must be 100% bisectable.


Best regards,
Krzysztof

