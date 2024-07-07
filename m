Return-Path: <linux-iio+bounces-7394-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F789297BB
	for <lists+linux-iio@lfdr.de>; Sun,  7 Jul 2024 14:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E29C1C209F2
	for <lists+linux-iio@lfdr.de>; Sun,  7 Jul 2024 12:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0931C6A4;
	Sun,  7 Jul 2024 12:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nA14nBv0"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88913FBEA;
	Sun,  7 Jul 2024 12:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720353765; cv=none; b=N0QvJt7B/Ba7Qf8r5fIqX9cU8tJW28FjnW4dJT84uoL9/Kg6/GQXvsQHrPVZH1O1zp/94a9F//DhiyE9rU9OCqSPjDPYVR9A0ric+vxo6zFJINtg6dmqxedHSkeqsYsBMudLgSky6qtIk/7rqHadqcMxiLDc3YHB/5qalk8QAD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720353765; c=relaxed/simple;
	bh=6TaseJNEX8nKaVfJr1mJuYNLBqyiWY02WbWt6CHT2HY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oTiirr14L9MdWAS3jST2Bvt5s4pCuYfJOTK96gU8JCj9emwJB+etnYafiTbd545+YU/mRCGqPgKxYegeRhV2csBcnGwkEZvYNcFEDRbaRMxmwJz47sY68Vw0r+AXfR9I/a6834PTI3ndUSzI3Ma8NGmhe8SHcu3NSPfaME6NFR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nA14nBv0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B724C3277B;
	Sun,  7 Jul 2024 12:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720353765;
	bh=6TaseJNEX8nKaVfJr1mJuYNLBqyiWY02WbWt6CHT2HY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nA14nBv00dk6F6SiGXlusTnU5ztjde3wQxqxQ++dM7SI8CREJJ82Ith4fcVDWMbZ/
	 pR1x5w/RzsgGSvROJv51lqLP/KrJEK6iQw3OOGlCI8X17uX5YaroHXYlSGeFY7FRET
	 +maKHu0k6+BaNf7cxi3uDx/6q9geQw/nmJhfkaw2DiCzb+b0EtGdzPsnNDNnJgPCcw
	 H84cQ2Z5J1lxqYN/DsSDXYE0S3RZuz6760q3Q/nxPqXsSko529Q4XgeLAFC5lWCqPO
	 8nBSMen6q0uLaBG0Rcty2p943X6HvY6+nHYFjDSskmhIPjOqnR8dF11E3OSGCunMhu
	 VI/6tCqFPwWBg==
Message-ID: <98992b1d-c94a-4053-a755-32a25d7fdc46@kernel.org>
Date: Sun, 7 Jul 2024 14:02:39 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: light: ltrf216a: Drop undocumented ltr,ltrf216a
 compatible string
To: Shreeya Patel <shreeya.patel@collabora.com>, Marek Vasut <marex@denx.de>
Cc: linux-iio@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
 Jonathan Cameron <jic23@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
 kernel@collabora.com
References: <20240705095047.90558-1-marex@denx.de>
 <3b2ca0-6687ce00-3-4dab7280@52083650>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <3b2ca0-6687ce00-3-4dab7280@52083650>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/07/2024 12:42, Shreeya Patel wrote:
> On Friday, July 05, 2024 15:20 IST, Marek Vasut <marex@denx.de> wrote:
> 
>> The "ltr,ltrf216a" compatible string is not documented in DT binding
>> document, remove it.
>>
>> Signed-off-by: Marek Vasut <marex@denx.de>
>> ---
>> Cc: Conor Dooley <conor+dt@kernel.org>
>> Cc: Jonathan Cameron <jic23@kernel.org>
>> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
>> Cc: Lars-Peter Clausen <lars@metafoo.de>
>> Cc: Marek Vasut <marex@denx.de>
>> Cc: Rob Herring <robh@kernel.org>
>> Cc: Shreeya Patel <shreeya.patel@collabora.com>
>> Cc: devicetree@vger.kernel.org
>> Cc: linux-iio@vger.kernel.org
>> ---
>>  drivers/iio/light/ltrf216a.c | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/iio/light/ltrf216a.c b/drivers/iio/light/ltrf216a.c
>> index 68dc48420a886..78fc910fcb18c 100644
>> --- a/drivers/iio/light/ltrf216a.c
>> +++ b/drivers/iio/light/ltrf216a.c
>> @@ -528,7 +528,6 @@ MODULE_DEVICE_TABLE(i2c, ltrf216a_id);
>>  
>>  static const struct of_device_id ltrf216a_of_match[] = {
>>  	{ .compatible = "liteon,ltrf216a" },
>> -	{ .compatible = "ltr,ltrf216a" },
>>  	{}
> 
> This compatible string with a different vendor prefix was added for a specific reason.
> Please see the commit message of the following patch :-
> https://lore.kernel.org/all/20220511094024.175994-2-shreeya.patel@collabora.com/

And adding this specific compatible was clearly NAKed:
https://lore.kernel.org/all/20220516170406.GB2825626-robh@kernel.org/

yet you still added it. That's a deliberate going around maintainer's
decision.

> 
> We were very well aware that not documenting this was going to generate a warning so

You *CANNOT* have undocumented compatibles.

> we tried to fix that with a deprecated tag but it was NAKd by Rob. What we understood

Because the driver was NAKed obviously as well.

> from his last message was that it wasn't necessary to fix the DT warning.

I am quite angry that maintainer tells you something, but you push your
patch through because apparently you need to fulfill your project
requirements.

Best regards,
Krzysztof


