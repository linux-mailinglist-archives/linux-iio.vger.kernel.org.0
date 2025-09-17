Return-Path: <linux-iio+bounces-24205-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F06CB7D2B4
	for <lists+linux-iio@lfdr.de>; Wed, 17 Sep 2025 14:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B696F4858DF
	for <lists+linux-iio@lfdr.de>; Wed, 17 Sep 2025 11:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892C9369989;
	Wed, 17 Sep 2025 11:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="OgsObV8Y"
X-Original-To: linux-iio@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC9E22D78A;
	Wed, 17 Sep 2025 11:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758109306; cv=none; b=h1ojiu3sHqx5hWVEaN3vYcOHIGJEHW5YxaGme3GfU05WI5ZBtzVbRCgSfJxsNEUNanSF5GcCMELoHFH5+L+AZrlQO5DHIZUVX2ujVe49XBEYT9yx4qAd5en4N70nsyLfoKRSGjKtHpZeBPQ35Ul/ci0VdGuc326oaDZHy2AZKts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758109306; c=relaxed/simple;
	bh=0OtD0Y91eraXp7qlae6rfKOz1LeKFfNmCmaZ1OElvSI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jF3KQ9OTKHVMUopSxuqpAf64gdycgG8N1uHlj+RTMTrNCth2MPaL9DjEWiyfBh7aQaPdkPaX5Q7FEBKc6zrcGiwozByLuQM79cX1KXPSjtO7pzubHIfLXwrm1LkVmnfkzHzQ6ZLhyRzCseQgv3XZQDy+X/J402D6zbo26Q2cRKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=OgsObV8Y; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1758109302;
	bh=0OtD0Y91eraXp7qlae6rfKOz1LeKFfNmCmaZ1OElvSI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OgsObV8YW7tOY5+PL28HwItU/FdPf6MHC4mP4i613Caz1L/lU2AKXzio9nx+qjykZ
	 C3X7qT+n+A2gpIo6dPrCSdsecp6k4lbQyCGEUHpJnuup2V6zoK+atoFaY7bFvbm8FF
	 /cwuWNvMSDp70uMeD1uiUA86GbGkwX9WC39Fqgw6z08vVFx0uowzHqMBJfSzyuqpH/
	 Dwfvs2LGSvQM85kAQhlxrPFLvLXTkcHFxPp/a3IRM78Ev6WUgqpoLhoGb4BdiGWlCR
	 vxXQch2XyjzydceRQfztY4bXwHNcq0iRCr/rlr0qTQjZiG7WqpKzbIF9Z/i9TpceB0
	 S4vEPuGN/zcQA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 49AA317E10F3;
	Wed, 17 Sep 2025 13:41:41 +0200 (CEST)
Message-ID: <a16cafd4-4d6c-45be-b241-45d2d6479bb1@collabora.com>
Date: Wed, 17 Sep 2025 13:41:40 +0200
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
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <mr7gqhvom5soofn2oujzxtsuczsnx2yizkushar64cojwnvhd6@dt64ojgjqdxw>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 16/09/25 15:25, Uwe Kleine-König ha scritto:
> Hello AngeloGioacchino,
> 
> On Tue, Sep 16, 2025 at 10:44:39AM +0200, AngeloGioacchino Del Regno wrote:
>> +/**
>> + * spmi_subdevice_alloc_and_add(): Allocate and add a new SPMI sub-device
>> + * @sparent:	SPMI parent device with previously registered SPMI controller
>> + *
>> + * Returns:
>> + * Pointer to newly allocated SPMI sub-device for success or negative ERR_PTR.
>> + */
>> +struct spmi_subdevice *spmi_subdevice_alloc_and_add(struct spmi_device *sparent)
>> +{
>> +	struct spmi_subdevice *sub_sdev;
>> +	struct spmi_device *sdev;
>> +	int ret;
>> +
>> +	sub_sdev = kzalloc(sizeof(*sub_sdev), GFP_KERNEL);
>> +	if (!sub_sdev)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	ret = ida_alloc(&spmi_subdevice_ida, GFP_KERNEL);
>> +	if (ret < 0) {
>> +		kfree(sub_sdev);
>> +		return ERR_PTR(ret);
>> +	}
>> +
>> +	sdev = &sub_sdev->sdev;
>> +	sdev->ctrl = sparent->ctrl;
>> +	device_initialize(&sdev->dev);
>> +	sdev->dev.parent = &sparent->dev;
>> +	sdev->dev.bus = &spmi_bus_type;
>> +	sdev->dev.type = &spmi_subdev_type;
>> +
>> +	sub_sdev->devid = ret;
>> +	sdev->usid = sparent->usid;
>> +
>> +	ret = dev_set_name(&sdev->dev, "%d-%02x.%d.auto",
>> +			   sdev->ctrl->nr, sdev->usid, sub_sdev->devid);
> 
> If I understand correctly sub_sdev->devid is globally unique. I wonder
> if a namespace that is specific to the parent spmi device would be more
> sensible?!
> 

Only in the context of the children of sdev. I'm not sure of what you're proposing
here, looks like it would complicate the code for no big reason - unless I am
misunderstanding something here.

>> +	if (ret)
>> +		goto err_put_dev;
>> +
>> +	ret = device_add(&sdev->dev);
>> +	if (ret) {
>> +		dev_err(&sdev->dev, "Can't add %s, status %d\n",
> 
> I'd use %pe instead of %d here.
> 

The only reason why I am using %d is for consistency with the rest of the code that
is in SPMI - there is another device_add() call in spmi_device_add() which prints
the same error in the very same way as I'm doing here.

I agree that using %pe makes error prints more readable, but perhaps that should be
done as a later cleanup to keep prints consistent (and perhaps that should not be
done only in SPMI anyway).

If you have really strong opinions about doing that right now I can do it, but I
anyway prefer seeing that as a later commit doing that in the entire SPMI codebase.

Cheers,
Angelo

>> +			dev_name(&sdev->dev), ret);
>> +		goto err_put_dev;
>> +	}
>> +
>> +	return sub_sdev;
>> +
>> +err_put_dev:
>> +	put_device(&sdev->dev);
>> +	return ERR_PTR(ret);
>> +}
>> +EXPORT_SYMBOL_NS_GPL(spmi_subdevice_alloc_and_add, "SPMI");
>> +
> 
> Best regards
> Uwe


