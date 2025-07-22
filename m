Return-Path: <linux-iio+bounces-21857-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A59B0D474
	for <lists+linux-iio@lfdr.de>; Tue, 22 Jul 2025 10:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ABD13A5343
	for <lists+linux-iio@lfdr.de>; Tue, 22 Jul 2025 08:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923CE2D322A;
	Tue, 22 Jul 2025 08:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="T6Z23uPn"
X-Original-To: linux-iio@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814FE2C158F;
	Tue, 22 Jul 2025 08:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753172598; cv=none; b=gOuYNogbqc4XB6AOSSRSuap6usw5aSkhD5xdiuqrLDJxFR2o/tk8iBg2fGwAo15tCTfo/97iqvQ5N4TPX7iJpgkp4V5C8RohLXZGFRaJ9x25N91FTRnSfXHIT5YO032Kd+MU0EbHBzI/Ghn3JYpV1Fz4Iuf5ENzeHcM5s/eIuJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753172598; c=relaxed/simple;
	bh=N0IwDglj6zSDqLUhBc9b9TtUj63SYVStoAHb/ApAGa8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mFIkFxMejPPPFtREsaugl+T/j6mBdD37IvvH4q/n2akq5ajkAOaZ5pDC/7ipME1DYrZg3UDAI+Q+KmksDN7sXGIV0fDDGHCV+em39ASSi+UzKsldCQ1me0RqwTYjUgilO5kbcNwfanHNLJreFwQSi+PBcMTmJgEd9vZZi/r+gvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=T6Z23uPn; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1753172593;
	bh=N0IwDglj6zSDqLUhBc9b9TtUj63SYVStoAHb/ApAGa8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=T6Z23uPnpPGz0LE3TTjwNcaxdcsZMHNY8/rod19dpxEoFcaVzm6Tzmt7zNWezEc/q
	 8LiN4xJzF0rlqKYeSpr8ruwFD5pv+9hzjLzoBrnvYe8ldcXFebnXhIRLukAeR5ZnS5
	 HX4alCC8uCPyliygXz6lSmWLP5W7KLjb2gjaBrfcs3KXo2bmWNSWNpk/yy2T4snXl9
	 UtxsWmLfEmelygGOfZFcCqf/g8JWGQZbqkhfJQyEDVp6CqE7tTAxolmiyVGDxVSqNu
	 5T6h4YmbmLH7Z8JQpJefVcR10xHil5WgcFKwkf+7BX3vYMOsBRNMA4ZfWJFeL/rC1O
	 z36DYY3p4OsSw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B5F3E17E0D15;
	Tue, 22 Jul 2025 10:23:12 +0200 (CEST)
Message-ID: <d14b616c-3d74-477e-a45f-5b890df4fe46@collabora.com>
Date: Tue, 22 Jul 2025 10:23:12 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/7] power: reset: qcom-pon: Migrate to
 devm_spmi_subdevice_alloc_and_add()
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: sboyd@kernel.org, jic23@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, arnd@arndb.de,
 gregkh@linuxfoundation.org, srini@kernel.org, vkoul@kernel.org,
 kishon@kernel.org, sre@kernel.org, krzysztof.kozlowski@linaro.org,
 u.kleine-koenig@baylibre.com, linux-arm-msm@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-pm@vger.kernel.org,
 kernel@collabora.com, wenst@chromium.org
References: <20250721075525.29636-1-angelogioacchino.delregno@collabora.com>
 <20250721075525.29636-4-angelogioacchino.delregno@collabora.com>
 <aH4mWfgQt_Q0O-7S@smile.fi.intel.com>
 <f5d529c3-b898-48ac-8e5a-f587db72dc82@collabora.com>
 <aH51idxbwW1SAExG@smile.fi.intel.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <aH51idxbwW1SAExG@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 21/07/25 19:14, Andy Shevchenko ha scritto:
> On Mon, Jul 21, 2025 at 03:05:46PM +0200, AngeloGioacchino Del Regno wrote:
>> Il 21/07/25 13:36, Andy Shevchenko ha scritto:
>>> On Mon, Jul 21, 2025 at 09:55:21AM +0200, AngeloGioacchino Del Regno wrote:
> 
> ...
> 
>>>> +	if (!pdev->dev.parent)
>>>> +		return -ENODEV;
>>>
>>> You can start using
>>>
>>> 	struct device *dev = &pdev->dev;
>>>
>>> here and perhaps one may convert the rest to it...
>>>
>>> ...
>>>
>>>>    	error = of_property_read_u32(pdev->dev.of_node, "reg",
>>>
>>> ...including, but not limited to, use of device_property_read_u32(dev, ...) here.
>>>
>>
>> I didn't do that for one single reason: I did not want to add noise to the commits
>> and wanted those to exclusively migrate the drivers to the new API, literally
>> without doing *anything* else unnecessary, even if I have located some almost
>> effortless improvements that I could've done to those drivers.
>>
>> Please - I prefer to keep it this way: these are the first commits that add the
>> usage of the new functions and of the concept of SPMI subdevices, and I really
>> want those to contain just that and nothing else - because I suspect that these
>> will be taken as example and will be read by the next person that is implementing
>> a new SPMI (sub)driver or converting any remaining ones to subdevice.
> 
> You can introduce a temporary variable in this change and use it only in the
> lines you have added/touched. We have similar approach in several drivers.
> Then somebody (not specifically should be you) can move it forward.
> 

Makes sense, okay!

Cheers,
Angelo

