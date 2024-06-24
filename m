Return-Path: <linux-iio+bounces-6822-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 722BB9153AB
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 18:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DDDB285F5D
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 16:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF8319DF57;
	Mon, 24 Jun 2024 16:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="un0jjADL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6ED17BCC;
	Mon, 24 Jun 2024 16:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719246423; cv=none; b=iifuDiQMsWGTM2W/a3KC31pjPCgfC1HVKCXdj9OAzWkgbUm4fGnNhZgVH6lGO9t25urC99q6PDkHBu8dW+IzX+OcepV0jDo4HDHz0ZSTjsPOQQQMWB2OcqoFeIN9lmDRkGevNW4o4W88fzxVz6yM628FMlzFudAgAUyR+u4YFRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719246423; c=relaxed/simple;
	bh=GtBXMM2l9qltUcRpEfiyfnmn0l5n+kJwq5wpvy24ioA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EwMCU5V/RwG426kYXYZBoJpLC2EC4KLrXM7cUPTOvxnGrfKVvOg1qmUVH5RZnOdmPLG0apK1eeNJz2jhR+93Kw0VIICiETAcWkPwopyvunG2AATB4ZRVuJ5Pkp+s9ES50kcAs0ERLx7tFIDXesOmG0MEHqsSizQyioecQLkOJZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=un0jjADL; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45OD8opO012232;
	Mon, 24 Jun 2024 18:26:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	4QBZ38ztMruEJ9solYAFSw8IkaHBHzsJsK1yBZ6dTB0=; b=un0jjADLge9jtcZk
	46XPAmMtQaoPUNlZ5BX5wxFSSdehfPZhp4EHZDezWH64C0J3EBh1WqjLJgfoobY8
	3Dguqbryw+2KTnmm2pT82xK+n4ORj+mPFEX7tPAtQhQLr68XTeHYvgfjn0NfTKMG
	nbpT+UHor04eeul3tGdL0O0lBQNqjULYjKUh8bA04Vbgp6fXFO/JZ7izudfLOxSG
	6yT6jPUZk/LR2P/lLH/xoHnj9tWEiaPultdanS7UYKzIDb2hOKvixUalbwdDvWGW
	z9FAmOprjWg+7owgMNgE8KKXvgRT4uIyMmVs0JCmbrUBlPUzBQniL1tLCtn+btjz
	FRZ+4g==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ywngd7qt1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 18:26:43 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 7EB084002D;
	Mon, 24 Jun 2024 18:26:39 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D078721A911;
	Mon, 24 Jun 2024 18:26:11 +0200 (CEST)
Received: from [10.48.86.132] (10.48.86.132) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 24 Jun
 2024 18:26:11 +0200
Message-ID: <06edd10d-eab4-41db-83d4-232fc43e1759@foss.st.com>
Date: Mon, 24 Jun 2024 18:26:10 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] iio: add sd modulator generic iio backend
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
        Jonathan Cameron
	<jic23@kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>
References: <20240618160836.945242-1-olivier.moysan@foss.st.com>
 <20240618160836.945242-8-olivier.moysan@foss.st.com>
 <20240623161150.358f95bf@jic23-huawei>
 <2dbd160b-135e-4882-9fd3-9d921742f49d@foss.st.com>
 <1ef85cdcffefee6b6a68927816f3d26c074a5331.camel@gmail.com>
Content-Language: en-US
From: Olivier MOYSAN <olivier.moysan@foss.st.com>
In-Reply-To: <1ef85cdcffefee6b6a68927816f3d26c074a5331.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_13,2024-06-24_01,2024-05-17_01

Hi Nuno,

On 6/24/24 17:22, Nuno Sá wrote:
> Hi Olivier,
> 
> On Mon, 2024-06-24 at 14:43 +0200, Olivier MOYSAN wrote:
>> Hi Jonathan,
>>
>> On 6/23/24 17:11, Jonathan Cameron wrote:
>>> On Tue, 18 Jun 2024 18:08:33 +0200
>>> Olivier Moysan <olivier.moysan@foss.st.com> wrote:
>>>
>>>> Add a generic driver to support sigma delta modulators.
>>>> Typically, this device is a hardware connected to an IIO device
>>>> in charge of the conversion. The device is exposed as an IIO backend
>>>> device. This backend device and the associated conversion device
>>>> can be seen as an aggregate device from IIO framework.
>>>>
>>>> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
>>>
>>> Trivial comments inline.
>>>
>>>> diff --git a/drivers/iio/adc/sd_adc_backend.c
>>>> b/drivers/iio/adc/sd_adc_backend.c
>>>> new file mode 100644
>>>> index 000000000000..556a49dc537b
>>>> --- /dev/null
>>>> +++ b/drivers/iio/adc/sd_adc_backend.c
>>>> @@ -0,0 +1,110 @@
>>>> +// SPDX-License-Identifier: GPL-2.0-only
>>>> +/*
>>>> + * Generic sigma delta modulator IIO backend
>>>> + *
>>>> + * Copyright (C) 2024, STMicroelectronics - All Rights Reserved
>>>> + */
>>>> +
>>>> +#include <linux/iio/backend.h>
>>>> +#include <linux/iio/iio.h>
>>>> +#include <linux/module.h>
>>>> +#include <linux/mod_devicetable.h>
>>>> +#include <linux/platform_device.h>
>>>> +#include <linux/regulator/consumer.h>
>>>> +
>>>> +struct iio_sd_backend_priv {
>>>> +	struct regulator *vref;
>>>> +	int vref_mv;
>>>> +};
>>>> +
>>>> +static int sd_backend_enable(struct iio_backend *backend)
>>>> +{
>>>> +	struct iio_sd_backend_priv *priv = iio_backend_get_priv(backend);
>>>> +
>>>> +	return regulator_enable(priv->vref);
>>>> +};
>>>> +
>>>> +static void sd_backend_disable(struct iio_backend *backend)
>>>> +{
>>>> +	struct iio_sd_backend_priv *priv = iio_backend_get_priv(backend);
>>>> +
>>>> +	regulator_disable(priv->vref);
>>>> +};
>>>> +
>>>> +static int sd_backend_read(struct iio_backend *backend, int *val, int *val2,
>>>> long mask)
>>> Nothing to do with this patch as such:
>>>
>>> One day I'm going to bit the bullet and fix that naming.
>>> Long long ago when the Earth was young it actually was a bitmap which
>>> I miscalled a mask - it only had one bit ever set, which was a dumb
>>> bit of API.  It's not been true for a long time.
>>> Anyhow, one more instances isn't too much of a problem I guess.
>>>
>>
>> I changed the callback .read_raw to .ext_info_get to take Nuno's comment
>> about iio_backend_read_raw() API, into account.
>> So, I changed this function to
>> static int sd_backend_ext_info_get(struct iio_backend *back, uintptr_t
>> private, const struct iio_chan_spec *chan, char *buf)
>> for v2 version.
>>
> 
> Maybe I'm missing something but I think I did not explained myself very well. What I
> had in mind was that since you're calling .read_raw() from IIO_CHAN_INFO_SCALE and
> IIO_CHAN_INFO_OFFSET, it could make sense to have more dedicated API's. Meaning:
> 
> iio_backend_read_scale(...)
> iio_backend_read_offset(...)
> 
> The iio_backend_read_raw() may make sense when frontends call
> iio_backend_extend_chan_spec() and have no idea what the backend may have added to
> the channel. So, in those cases something like this could make sense:
> 
> switch (mask)
> IIO_CHAN_INFO_RAW:
> 
> ...
> 
> default:
> 	return iio_backend_read_raw();
> 
> but like I said maybe this is me over-complicating and a simple
> iio_backend_read_raw() is sufficient. But I think I never mentioned something like
> .read_raw -> .ext_info_get.
> 

Thanks for clarification. Your previous message was actually clear 
enough regarding iio_backend_read_raw() API.

However, your comment about extend_chan_spec(), let me think that I 
could maybe spare a new API, and just re-use iio_backend_ext_info_get() 
callback.
Nevertheless, this API cannot be used directly, as it can be used only 
for a frontend associated to a single backend. There is a comment in 
iio_backend_ext_info_get() about the need of another API for such case.

So I considered introducing this new API (instead of read_raw):
ssize_t iio_backend_ext_info_get_from_backend(struct iio_backend *back, 
uintptr_t private, const struct iio_chan_spec *chan, char *buf)
(I'm not sure this name is the most relevant).

But if you don't like this alternative too much, I will keep the initial 
"catch all" iio_backend_read_raw() API.

BRs
Olivier

> The other thing I mentioned was to instead of having:
> 
> 
> if (child) {
> 	ch->info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> 				 BIT(IIO_CHAN_INFO_SCALE) |
> 				 BIT(IIO_CHAN_INFO_OFFSET);
> }
> 
> You could use iio_backend_extend_chan_spec() and have the backend set the SCALE and
> OFFSET bits for you as it seems these functionality depends on the backend.
> 
> But none of the above were critical or things that I feel to strong about.
> 
> Anyways, just wanted to give some clarification as it seems there were some
> misunderstandings (I think).
> > - Nuno Sá
> 
>>>

