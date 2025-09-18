Return-Path: <linux-iio+bounces-24247-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA59FB8422B
	for <lists+linux-iio@lfdr.de>; Thu, 18 Sep 2025 12:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57E7E3A8E59
	for <lists+linux-iio@lfdr.de>; Thu, 18 Sep 2025 10:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA1127D782;
	Thu, 18 Sep 2025 10:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ECE/eJDI"
X-Original-To: linux-iio@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1B92628C;
	Thu, 18 Sep 2025 10:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758191706; cv=none; b=WXSrfQ9EWkPHUqkwBhSCQrS9KR9JR/PAF/T0ryHzX1kt82dLn9dv46jKt0L2hl6M06k7iTrrc98bRgeJ/oXhvUv0Iy/c+s8A5TfnJN0Xke9VvYUbZn/ylOnqix6wgHbZ03R3FG9pGqka+ojx0WxGy2EPNnqrEs6AQ1J2oeHJHx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758191706; c=relaxed/simple;
	bh=YNsKPzaZ6AgTQoBOz/hSXbRFBaG5rmvbLT9PedPLSy0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R3YxAmXwde64CtkWdAvsavHND9yc0Ym8nNZ77owEM92LKPYp6T+R8LsbelIqer8kjMSFVgQHqATUoOkd0Y8nvvx+FYh3PdQfv9/w3ky7WEI3Z8i65hD7d8CUicgKY96uaeTbDf9x43hd/JUhHH9Vku18atFxitgGHqMS8J/Fn1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ECE/eJDI; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1758191695;
	bh=YNsKPzaZ6AgTQoBOz/hSXbRFBaG5rmvbLT9PedPLSy0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ECE/eJDI4/xYR8VJnLZWEqqndGErFRs7khdiSy0O852oSN8HCV+XvrsH+QFGhcscS
	 7pXlqidkb9VAd179d05qQyQ94smT6EGKUWu2zqGluJrFvuZIoU5CVHCMCFlwYwhF14
	 YFR7ItdDIA1K6S/Ai1t6Mk2BlDlS59PddCftk/u5VJOaTh6r8MUdNVAA/qotaFYvne
	 wX/oeFTBoXaMkQeKDvTbv54IgkBK9n1p2V9SD5eOByrrm3eSSn8XfhfrHgxy4N43+c
	 +nMuKXUVVLrwdcH5LpI3OrZPfCIGvLTFoYsJyGMS/yJ92PFQFW2JimSMY9m2+gc4bs
	 jjwUlPS/zBHNw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A44F017E0DC2;
	Thu, 18 Sep 2025 12:34:54 +0200 (CEST)
Message-ID: <a724814a-2517-4855-a183-e80117ab4b01@collabora.com>
Date: Thu, 18 Sep 2025 12:34:53 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/7] spmi: Implement spmi_subdevice_alloc_and_add() and
 devm variant
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: sboyd@kernel.org, jic23@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, arnd@arndb.de,
 gregkh@linuxfoundation.org, srini@kernel.org, vkoul@kernel.org,
 kishon@kernel.org, sre@kernel.org, krzysztof.kozlowski@linaro.org,
 linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-pm@vger.kernel.org, kernel@collabora.com, wenst@chromium.org,
 casey.connolly@linaro.org, Jonathan Cameron <jonathan.cameron@huawei.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
References: <20250916084445.96621-1-angelogioacchino.delregno@collabora.com>
 <20250916084445.96621-2-angelogioacchino.delregno@collabora.com>
 <mr7gqhvom5soofn2oujzxtsuczsnx2yizkushar64cojwnvhd6@dt64ojgjqdxw>
 <a16cafd4-4d6c-45be-b241-45d2d6479bb1@collabora.com>
 <hsemgg5s3nptxeh3jyim6ahgb37yb3h3hcbdtwixiisyf7ehqk@r7zlg23yz5cv>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <hsemgg5s3nptxeh3jyim6ahgb37yb3h3hcbdtwixiisyf7ehqk@r7zlg23yz5cv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 17/09/25 16:57, Uwe Kleine-König ha scritto:
> Hello AngeloGioacchino,
> 
> On Wed, Sep 17, 2025 at 01:41:40PM +0200, AngeloGioacchino Del Regno wrote:
>> Il 16/09/25 15:25, Uwe Kleine-König ha scritto:
>>> Hello AngeloGioacchino,
>>>
>>> On Tue, Sep 16, 2025 at 10:44:39AM +0200, AngeloGioacchino Del Regno wrote:
>>>> +/**
>>>> + * spmi_subdevice_alloc_and_add(): Allocate and add a new SPMI sub-device
>>>> + * @sparent:	SPMI parent device with previously registered SPMI controller
>>>> + *
>>>> + * Returns:
>>>> + * Pointer to newly allocated SPMI sub-device for success or negative ERR_PTR.
>>>> + */
>>>> +struct spmi_subdevice *spmi_subdevice_alloc_and_add(struct spmi_device *sparent)
>>>> +{
>>>> +	struct spmi_subdevice *sub_sdev;
>>>> +	struct spmi_device *sdev;
>>>> +	int ret;
>>>> +
>>>> +	sub_sdev = kzalloc(sizeof(*sub_sdev), GFP_KERNEL);
>>>> +	if (!sub_sdev)
>>>> +		return ERR_PTR(-ENOMEM);
>>>> +
>>>> +	ret = ida_alloc(&spmi_subdevice_ida, GFP_KERNEL);
>>>> +	if (ret < 0) {
>>>> +		kfree(sub_sdev);
>>>> +		return ERR_PTR(ret);
>>>> +	}
>>>> +
>>>> +	sdev = &sub_sdev->sdev;
>>>> +	sdev->ctrl = sparent->ctrl;
>>>> +	device_initialize(&sdev->dev);
>>>> +	sdev->dev.parent = &sparent->dev;
>>>> +	sdev->dev.bus = &spmi_bus_type;
>>>> +	sdev->dev.type = &spmi_subdev_type;
>>>> +
>>>> +	sub_sdev->devid = ret;
>>>> +	sdev->usid = sparent->usid;
>>>> +
>>>> +	ret = dev_set_name(&sdev->dev, "%d-%02x.%d.auto",
>>>> +			   sdev->ctrl->nr, sdev->usid, sub_sdev->devid);
>>>
>>> If I understand correctly sub_sdev->devid is globally unique. I wonder
>>> if a namespace that is specific to the parent spmi device would be more
>>> sensible?!
>>
>> Only in the context of the children of sdev. I'm not sure of what you're proposing
>> here, looks like it would complicate the code for no big reason - unless I am
>> misunderstanding something here.
> 
> The thing that I wondered about is: Why use sdev->usid if
> sub_sdev->devid is already a unique description of the subdevice? And
> for other device types (platform devices, mfd) the device identifiers
> are not globally unique. So I just wondered why spmi is different here.
> 

That gives a clear representation of the tree of devices on a SPMI bus, more
or less like it's done for some other addressable (or discoverable) busses
where you may have a tree like controller->hub->device (just as a fast example eh).

The SPMI devices are anyway already following this naming even before my changes,
as those are simply "%d-%02x" (ctrlid-devaddr), so what I wrote here is aimed to
  1. Not reinvent the wheel
  2. Be consistent with previous naming
  3. Be nice to whoever is trying to understand "where" a device is
     3a. ...And make it immediately easy to see that
     3b. ...And make it easier to debug, in case it's needed
  4. Not exclude a possible future where SPMI may become discoverable somehow
     (...which is questionably kind of a thing already, but then for multiple
      reasons it's not really feasible right now)

...I would be able to go on with more reasons, but let's not open this loophole :-)

>>>> +	if (ret)
>>>> +		goto err_put_dev;
>>>> +
>>>> +	ret = device_add(&sdev->dev);
>>>> +	if (ret) {
>>>> +		dev_err(&sdev->dev, "Can't add %s, status %d\n",
>>>
>>> I'd use %pe instead of %d here.
>>>
>>
>> The only reason why I am using %d is for consistency with the rest of the code that
>> is in SPMI - there is another device_add() call in spmi_device_add() which prints
>> the same error in the very same way as I'm doing here.
>>
>> I agree that using %pe makes error prints more readable, but perhaps that should be
>> done as a later cleanup to keep prints consistent (and perhaps that should not be
>> done only in SPMI anyway).
>>
>> If you have really strong opinions about doing that right now I can do it, but I
>> anyway prefer seeing that as a later commit doing that in the entire SPMI codebase.
> 
> My approach would be to first convert the driver to use %pe and then
> add the new code. But I don't feel strong.
> 

That'd be right, but %pe being better is (imo..) just an opinion and, while I agree
with you in that it's nicer, it'd be great if this doesn't become a blocker and if
we could get this patch picked in the current merge window.

This is because otherwise the other patches (of which, two are not yet ready as
they need some Kconfig fixes) would need immutable branches between multiple
trees (as those are touching nvmem, power, phy, misc and iio), and that would
get a bit complicated.

Of course while resending the other patches, I can add a %pe conversion for the
whole SPMI framework code. One more line isn't the end of the world anyway.

Mind you - the main reason for this patch is that I am using it for new drivers
for MediaTek PMICs (and a SPMI v2 bus implementation for the new MTK SPMI Arbiter)
that I will introduce after this gets picked.

Cheers,
Angelo




