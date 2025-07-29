Return-Path: <linux-iio+bounces-22126-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB75B14C72
	for <lists+linux-iio@lfdr.de>; Tue, 29 Jul 2025 12:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62C963A73B8
	for <lists+linux-iio@lfdr.de>; Tue, 29 Jul 2025 10:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13EBC28A727;
	Tue, 29 Jul 2025 10:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="lC0oIZO9"
X-Original-To: linux-iio@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62F8289838;
	Tue, 29 Jul 2025 10:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753785881; cv=none; b=HUYiX4IhG4RYPf8ENjAulBUm/MYPomg9TJ7YYR1JTjXun7EF9sLK+LHGc6t9kJ0d+zBNEVUEmDaOlJmgQbr4j5eo6ic1Z5MYnUhGShTq4nK8CpkCjkPwVEExSgS3ruhho+uoTgBK5GtsXDVRS6zAYNJFyHeYRfvd63v57EUHs88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753785881; c=relaxed/simple;
	bh=nU5WXYZ5Ubm0JEqaTpOcsj1mUeZ2KBa1iqurY0olt6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V8C3JPE1ieBBonXTgfrPWR3VV5DhRoIKRia7dcdXV6fAHA/pt9TKLUZtSJaklUlyPQiSs51QxSt6odT7ToDa0mXuFFjIR/NCvmkPAdDnNYflNmo0e++Quu1Tbqg1BYK8s2KVbtKyL9yLS/CLr8h75HnwlsCjEVH/bUmCW85aI5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=lC0oIZO9; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1753785876;
	bh=nU5WXYZ5Ubm0JEqaTpOcsj1mUeZ2KBa1iqurY0olt6s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lC0oIZO9yZLVv56w72qdXrBp+FWFHozmGeMG3NEBw3vYJ6e+pKmI/o2/UmjPoxxhz
	 hh+L3KbyyrJUgIhaEWY963l2K2c1YrRFvgP7ZE1N8xj0apn7hALiTaMjdBSaxeI3iT
	 RtPOeeUi6ONSQVNIrkH3/P2HK4Z5CqgsqLoclTcN0usdXwU41Z77//5oW3cRzGIaxa
	 j0QjzrK6rDCSSrxzxpfqN3oBEMMUdfWKHFWzLYQSdD0GP5nvU1zT9X/TKaPhsoLcEq
	 C4ClcgnC7vjnQlbCD0g0WFVMa7xDUx1/6JNXhBOxSN419VS6UCtIN+P8MpGe/IuU68
	 wTkJ680R0i9DA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6637B17E0EC0;
	Tue, 29 Jul 2025 12:44:35 +0200 (CEST)
Message-ID: <6ea0495e-21d8-41a8-b1b0-1c99c2929de5@collabora.com>
Date: Tue, 29 Jul 2025 12:44:34 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] spmi: Implement spmi_subdevice_alloc_and_add() and
 devm variant
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: sboyd@kernel.org, jic23@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, arnd@arndb.de,
 gregkh@linuxfoundation.org, srini@kernel.org, vkoul@kernel.org,
 kishon@kernel.org, sre@kernel.org, krzysztof.kozlowski@linaro.org,
 u.kleine-koenig@baylibre.com, linux-arm-msm@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-pm@vger.kernel.org,
 kernel@collabora.com, wenst@chromium.org, casey.connolly@linaro.org
References: <20250722101317.76729-1-angelogioacchino.delregno@collabora.com>
 <20250722101317.76729-2-angelogioacchino.delregno@collabora.com>
 <20250722150930.00000a2f@huawei.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250722150930.00000a2f@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 22/07/25 16:09, Jonathan Cameron ha scritto:
> On Tue, 22 Jul 2025 12:13:11 +0200
> AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> wrote:
> 
>> Some devices connected over the SPMI bus may be big, in the sense
>> that those may be a complex of devices managed by a single chip
>> over the SPMI bus, reachable through a single SID.
>>
>> Add new functions aimed at managing sub-devices of a SPMI device
>> spmi_subdevice_alloc_and_add() and a spmi_subdevice_put_and_remove()
>> for adding a new subdevice and removing it respectively, and also
>> add their devm_* variants.
>>
>> The need for such functions comes from the existance of	those
>> complex Power Management ICs (PMICs), which feature one or many
>> sub-devices, in some cases with these being even addressable on
>> the chip in form of SPMI register ranges.
>>
>> Examples of those devices can be found in both Qualcomm platforms
>> with their PMICs having PON, RTC, SDAM, GPIO controller, and other
>> sub-devices, and in newer MediaTek platforms showing similar HW
>> features and a similar layout with those also having many subdevs.
>>
>> Also, instead of generally exporting symbols, export them with a
>> new "SPMI" namespace: all users will have to import this namespace
>> to make use of the newly introduced exports.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   drivers/spmi/spmi-devres.c | 23 +++++++++++
>>   drivers/spmi/spmi.c        | 83 ++++++++++++++++++++++++++++++++++++++
>>   include/linux/spmi.h       | 16 ++++++++
>>   3 files changed, 122 insertions(+)
>>
>> diff --git a/drivers/spmi/spmi-devres.c b/drivers/spmi/spmi-devres.c
>> index 62c4b3f24d06..7e00e38be2ff 100644
>> --- a/drivers/spmi/spmi-devres.c
>> +++ b/drivers/spmi/spmi-devres.c
>> @@ -60,5 +60,28 @@ int devm_spmi_controller_add(struct device *parent, struct spmi_controller *ctrl
>>   }
>>   EXPORT_SYMBOL_GPL(devm_spmi_controller_add);
>>   
>> +static void devm_spmi_subdevice_remove(void *res)
>> +{
>> +	spmi_subdevice_remove((struct spmi_subdevice *)res);
> 
> Why the cast?  Implicit casts are fine for void * to any other pointer type
> so
> 	spmi_subdevice_remove(res);
> should be fine.
> 

Because style consistency across the file... but yeah, I'm removing the cast.

> 
>> +}
> 
>>   MODULE_LICENSE("GPL");
>>   MODULE_DESCRIPTION("SPMI devres helpers");
>> diff --git a/drivers/spmi/spmi.c b/drivers/spmi/spmi.c
>> index 3cf8d9bd4566..62bb782b2bbc 100644
>> --- a/drivers/spmi/spmi.c
>> +++ b/drivers/spmi/spmi.c
>> @@ -19,6 +19,7 @@
>>   
>>   static bool is_registered;
>>   static DEFINE_IDA(ctrl_ida);
>> +static DEFINE_IDA(spmi_subdevice_ida);
>>   
>>   static void spmi_dev_release(struct device *dev)
>>   {
>> @@ -31,6 +32,18 @@ static const struct device_type spmi_dev_type = {
>>   	.release	= spmi_dev_release,
>>   };
>>   
>> +static void spmi_subdev_release(struct device *dev)
>> +{
>> +	struct spmi_device *sdev = to_spmi_device(dev);
>> +	struct spmi_subdevice *sub_sdev = container_of(sdev, struct spmi_subdevice, sdev);
>> +
>> +	kfree(sub_sdev);
>> +}
>> +
>> +static const struct device_type spmi_subdev_type = {
>> +	.release	= spmi_subdev_release,
>> +};
>> +
>>   static void spmi_ctrl_release(struct device *dev)
>>   {
>>   	struct spmi_controller *ctrl = to_spmi_controller(dev);
>> @@ -90,6 +103,19 @@ void spmi_device_remove(struct spmi_device *sdev)
>>   }
>>   EXPORT_SYMBOL_GPL(spmi_device_remove);
>>   
>> +/**
>> + * spmi_subdevice_remove() - Remove an SPMI subdevice
>> + * @sub_sdev:	spmi_device to be removed
>> + */
>> +void spmi_subdevice_remove(struct spmi_subdevice *sub_sdev)
>> +{
>> +	struct spmi_device *sdev = &sub_sdev->sdev;
>> +
>> +	device_unregister(&sdev->dev);
>> +	ida_free(&spmi_subdevice_ida, sub_sdev->devid);
> 
> Why not make the ida free part of the release? If not
> the device_unregister could (I think) result in a reference
> count drop and freeing of sub_sdev before you dereference it here.
> 

That's right, I moved it to the release, before the kfree.

> 
>> +}
>> +EXPORT_SYMBOL_NS_GPL(spmi_subdevice_remove, "SPMI");
>> +
>>   static inline int
>>   spmi_cmd(struct spmi_controller *ctrl, u8 opcode, u8 sid)
>>   {
>> @@ -431,6 +457,63 @@ struct spmi_device *spmi_device_alloc(struct spmi_controller *ctrl)
>>   }
>>   EXPORT_SYMBOL_GPL(spmi_device_alloc);
>>   
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
>> +	if (!sparent)
>> +		return ERR_PTR(-EINVAL);
> 
> Is this protecting against a real possibility? Feels like something went
> very wrong if you are allocating a subdevice of 'nothing'.
> If it's just defensive programming I'd drop it.
> 

That was defensive programming. Dropping.

>> +
>> +	sub_sdev = kzalloc(sizeof(*sub_sdev), GFP_KERNEL);
>> +	if (!sub_sdev)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	ret = ida_alloc(&spmi_subdevice_ida, GFP_KERNEL);
> 
>> +	if (ret < 0)
>> +		goto err_ida_alloc;
>> +
>> +	sdev = &sub_sdev->sdev;
>> +	sdev->ctrl = sparent->ctrl;
>> +	device_initialize(&sdev->dev);
> 
> Read the device_initialize() documentation for what you need to do
> if an error occurs after this point. Specifically the last 'NOTE'.
> 

Sorry. That was a bad miss :-)

> 
>> +	sdev->dev.parent = &sparent->dev;
>> +	sdev->dev.bus = &spmi_bus_type;
>> +	sdev->dev.type = &spmi_subdev_type;
>> +
>> +	sub_sdev->devid = ret;
>> +	sdev->usid = sparent->usid;
>> +
>> +	ret = dev_set_name(&sdev->dev, "%d-%02x.%d.auto",
>> +			   sdev->ctrl->nr, sdev->usid, sub_sdev->devid);
>> +	if (ret)
>> +		goto err_set_name;
>> +
>> +	ret = device_add(&sdev->dev);
>> +	if (ret) {
>> +		dev_err(&sdev->dev, "Can't add %s, status %d\n",
>> +			dev_name(&sdev->dev), ret);
>> +		put_device(&sdev->dev);
>> +		return ERR_PTR(ret);
>> +	}
>> +
>> +	return sub_sdev;
>> +
>> +err_set_name:
>> +	ida_free(&ctrl_ida, sub_sdev->devid);
>> +err_ida_alloc:
>> +	kfree(sub_sdev);
>> +	return ERR_PTR(ret);
>> +}
>> +EXPORT_SYMBOL_NS_GPL(spmi_subdevice_alloc_and_add, "SPMI");
>> +
>>   /**
>>    * spmi_controller_alloc() - Allocate a new SPMI controller
>>    * @parent:	parent device
>> diff --git a/include/linux/spmi.h b/include/linux/spmi.h
>> index 28e8c8bd3944..7cea0a5b034b 100644
>> --- a/include/linux/spmi.h
>> +++ b/include/linux/spmi.h
>> @@ -69,6 +69,22 @@ int spmi_device_add(struct spmi_device *sdev);
>>   
>>   void spmi_device_remove(struct spmi_device *sdev);
>>   
>> +/**
>> + * struct spmi_subdevice - Basic representation of an SPMI sub-device
>> + * @sdev:	Sub-device representation of an SPMI device
>> + * @devid:	Platform Device ID of an SPMI sub-device
>> + */
>> +struct spmi_subdevice {
>> +	struct spmi_device	sdev;
> 
> Having something called a subdevice containing an instance of a device
> does seem a little odd.  Maybe the spmi_device naming is inappropriate after
> this patch?
> 

A SPMI Sub-Device is a SPMI Device on its own, but one that is child of a device.

Controller -> Device -> Sub-Device

Before this version, I initially added devid to spmi_device, but that felt wrong
because:
  1. Sub-devices are children of devices (though, still also devices themselves)
  2. The devid field would be useless in "main" SPMI devices (struct spmi_device)
     and would not only waste (a very small amount of) memory for each device but,
     more importantly, would confuse people with an unused field there.

So, this defines a SPMI Sub-Device as an extension of a SPMI Device, where:
  - Device has controller-device numbers
  - Sub-device has controller-device.subdev_id numbers.

I don't really see any cleaner way of defining this, but I am completely open to
any idea :-)

Cheers,
Angelo



