Return-Path: <linux-iio+bounces-6802-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2156914AEC
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 14:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 355561F23FD8
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 12:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985BB13C90C;
	Mon, 24 Jun 2024 12:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="5lCwp+j5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E971E13B2B0;
	Mon, 24 Jun 2024 12:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719233051; cv=none; b=ByNfmHw1M7fG+CTH2m14FQyr+OPfXUVxFdsB91idKFvIdHJ63KDgR5u9757q6gMZc8LzRiTYvgs9GW+ihQfbdh+1Pcz3kSz6EnI8blevnxqrq5g5S9v6zcj8GxFptVgk4wUsRdKRfOrQZ9yCwRD4NCtpAMDJkxGyZf5Ss5EhEsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719233051; c=relaxed/simple;
	bh=9QzHvNMSrd927Ul1vR/P0Zu759vbk/x0FpwQ5Rhzye0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CFCwszPtcT0EZAK2K7wXlBrfh6txg2F64QLFJPhMFATiPdv7nFrmw/rrktnKdnTMk8j86MUwtyvDLDcyj6OsG+pyT7VcZE6QvWg7pBNebniKUaRTNQhC39FWtMaASrP0BZKSx/wpej7V5HIPBCtixTs123YuRUq/JndXFvdLa0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=5lCwp+j5; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45O8F0F3015936;
	Mon, 24 Jun 2024 14:43:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	IlsgFsAcO1uqpyrlrE1+2fKb1OAQS1hIZLOa2Ncu/0I=; b=5lCwp+j53k4bIFEW
	SJ3CCbDT+QmEt2eBLeLiat1tmhJMQN/Y6yub4lurBZQjc8JE3MtJvwnOaexlT1tu
	pp5Dlgnb8Vz6RNZk/O8tUN3XZCb6WZTte3tnWoeex4fe0HeDimtbqAPuh+YkXEU/
	6xryg2L0DdaoVF50z1H5lcYRP2Z2SwCsYeZstNtIOLUhJsb0+CwOancebOdplqOe
	7XRAaG4pobeiNsxD8M5wdhWyAjG1Ge29Z+e/bZ3X+bdFDKH6IyWKaPLwKZHgt+57
	kVv1UkcW/oBL0lTgYAXJ9anqTnia9NababrkqHv3D4gLudi4ACyXqwb9N0ecdyHj
	Kqk4dg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ywkr5759r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 14:43:50 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 8A79940045;
	Mon, 24 Jun 2024 14:43:45 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0A74321B51A;
	Mon, 24 Jun 2024 14:43:21 +0200 (CEST)
Received: from [10.48.86.132] (10.48.86.132) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 24 Jun
 2024 14:43:20 +0200
Message-ID: <2dbd160b-135e-4882-9fd3-9d921742f49d@foss.st.com>
Date: Mon, 24 Jun 2024 14:43:19 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] iio: add sd modulator generic iio backend
To: Jonathan Cameron <jic23@kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>
References: <20240618160836.945242-1-olivier.moysan@foss.st.com>
 <20240618160836.945242-8-olivier.moysan@foss.st.com>
 <20240623161150.358f95bf@jic23-huawei>
Content-Language: en-US
From: Olivier MOYSAN <olivier.moysan@foss.st.com>
In-Reply-To: <20240623161150.358f95bf@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_09,2024-06-24_01,2024-05-17_01

Hi Jonathan,

On 6/23/24 17:11, Jonathan Cameron wrote:
> On Tue, 18 Jun 2024 18:08:33 +0200
> Olivier Moysan <olivier.moysan@foss.st.com> wrote:
> 
>> Add a generic driver to support sigma delta modulators.
>> Typically, this device is a hardware connected to an IIO device
>> in charge of the conversion. The device is exposed as an IIO backend
>> device. This backend device and the associated conversion device
>> can be seen as an aggregate device from IIO framework.
>>
>> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> 
> Trivial comments inline.
> 
>> diff --git a/drivers/iio/adc/sd_adc_backend.c b/drivers/iio/adc/sd_adc_backend.c
>> new file mode 100644
>> index 000000000000..556a49dc537b
>> --- /dev/null
>> +++ b/drivers/iio/adc/sd_adc_backend.c
>> @@ -0,0 +1,110 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Generic sigma delta modulator IIO backend
>> + *
>> + * Copyright (C) 2024, STMicroelectronics - All Rights Reserved
>> + */
>> +
>> +#include <linux/iio/backend.h>
>> +#include <linux/iio/iio.h>
>> +#include <linux/module.h>
>> +#include <linux/mod_devicetable.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/regulator/consumer.h>
>> +
>> +struct iio_sd_backend_priv {
>> +	struct regulator *vref;
>> +	int vref_mv;
>> +};
>> +
>> +static int sd_backend_enable(struct iio_backend *backend)
>> +{
>> +	struct iio_sd_backend_priv *priv = iio_backend_get_priv(backend);
>> +
>> +	return regulator_enable(priv->vref);
>> +};
>> +
>> +static void sd_backend_disable(struct iio_backend *backend)
>> +{
>> +	struct iio_sd_backend_priv *priv = iio_backend_get_priv(backend);
>> +
>> +	regulator_disable(priv->vref);
>> +};
>> +
>> +static int sd_backend_read(struct iio_backend *backend, int *val, int *val2, long mask)
> Nothing to do with this patch as such:
> 
> One day I'm going to bit the bullet and fix that naming.
> Long long ago when the Earth was young it actually was a bitmap which
> I miscalled a mask - it only had one bit ever set, which was a dumb
> bit of API.  It's not been true for a long time.
> Anyhow, one more instances isn't too much of a problem I guess.
> 

I changed the callback .read_raw to .ext_info_get to take Nuno's comment 
about iio_backend_read_raw() API, into account.
So, I changed this function to
static int sd_backend_ext_info_get(struct iio_backend *back, uintptr_t 
private, const struct iio_chan_spec *chan, char *buf)
for v2 version.

>> +{
>> +	struct iio_sd_backend_priv *priv = iio_backend_get_priv(backend);
>> +
>> +	switch (mask) {
>> +	case IIO_CHAN_INFO_SCALE:
>> +		*val = priv->vref_mv;
> 
> This doesn't really feel right as what are we calling to?  Using it to pass the
> reference voltage doesn't make sense under normal handling of these.  So at very
> least needs a comment.
> 
> 
>> +		*val2 = 0;
> No need to set val2.

Removed in v2 also.

>> +		return IIO_VAL_INT;
>> +
>> +	case IIO_CHAN_INFO_OFFSET:
>> +		*val = 0;
>> +		*val2 = 0;
>> +		return IIO_VAL_INT;
> Normally we just don't provide this but I guess you are requiring all of these?
> Long term that won't scale, so you need your caller to handle a suitable
> error return, -EINVAL will work to say not supported.
>

Offset support is not strictly required for time being, as reported as 
zero. The aim was to anticipate further needs, but it may be dropped for 
now. I will remove it from v2, If you suggest keeping only the bare 
essentials here.

Error changed to "-EOPNOTSUPP" for unknown requests.

>> +	}
>> +
>> +	return -EINVAL;
>> +};
>> +
>> +static const struct iio_backend_ops sd_backend_ops = {
>> +	.enable = sd_backend_enable,
>> +	.disable = sd_backend_disable,
>> +	.read_raw = sd_backend_read,
>> +};
>> +
>> +static int iio_sd_backend_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct regulator *vref;
>> +	struct iio_sd_backend_priv *priv;
>> +	int ret;
>> +
>> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>> +	if (!priv)
>> +		return -ENOMEM;
>> +
>> +	vref = devm_regulator_get_optional(dev, "vref");
> 
> New devm_regulator_get_enable_read_voltage() slightly simplifies this
> and means you don't need to keep vref around.
> 
>> +	if (IS_ERR(vref)) {
>> +		if (PTR_ERR(vref) != -ENODEV)
>> +			return dev_err_probe(dev, PTR_ERR(vref), "Failed to get vref\n");
>> +	} else {
>> +		ret = regulator_get_voltage(vref);
> You haven't turned it on so it's not guaranteed to give you a useful
> answer.
> 

My understanding is that regulator_get_voltage() always returns the 
regulator voltage, whatever the regulator state, as documented in the 
API description:
"* NOTE: If the regulator is disabled it will return the voltage value.
* This function should not be used to determine regulator state."

So, my logic was to enable the regulator only when requested, through 
enable/disable callbacks to manage power.

Please, let me know if I missed something here.

> Use the enable_read_voltage variant and that will handle this for you.
> 
>> +		if (ret < 0)
>> +			return ret;
>> +
>> +		priv->vref = vref;
>> +		priv->vref_mv = ret / 1000;
>> +	}
>> +
>> +	ret = devm_iio_backend_register(&pdev->dev, &sd_backend_ops, priv);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return 0;
> 
> return devm_iio_....
> 

Done

>> +};
>> +
>> +static const struct of_device_id sd_backend_of_match[] = {
>> +	{ .compatible = "sd-backend" },
>> +	{ .compatible = "ads1201" },
> 
> Conor pointed out ti,ads1201
> At least I assume ti?
> 

Ack. changed to ti,ads1201

>> +	{ }
>> +};
> 
> 

Regards
Olivier

