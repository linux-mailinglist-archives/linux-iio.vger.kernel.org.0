Return-Path: <linux-iio+bounces-1582-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8FA982B173
	for <lists+linux-iio@lfdr.de>; Thu, 11 Jan 2024 16:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9235628C779
	for <lists+linux-iio@lfdr.de>; Thu, 11 Jan 2024 15:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD414CE0D;
	Thu, 11 Jan 2024 15:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="SfXU/F0Y"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D1D4CB43;
	Thu, 11 Jan 2024 15:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40B9Udgf025452;
	Thu, 11 Jan 2024 16:08:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=48m0KM3M3p1BNfuTKIibxYou1ae1j2s2qCj5kFQZ3RU=; b=Sf
	XU/F0YScjfl/KbJBUqiAvL0C1nd6H5iuKhlsgijUBVygkqcrMzBvIzbYbeqIChS9
	UvXV04LyddMUbpI31ZeV54/XESWrU/RMlufZ/k9SlUZFdROSOejAtqnp98aOo9gN
	WZQUNAjF2HlzUm1/kItLJfAQkG86XUKNgml37qaVDz4/g35xMqhi9Dp+0N8ygh1q
	Gq3jvO0p+ov4kLuxRfJL9wiXEf6eMM+lnKwXEowiCpxV06u/hGjMqCigzB1ULaLu
	aOLTTlAgUeaaY47eACI+wmzVMP9oteIvbsVXnOQhPM9xfmQH1ON4sa9dLm9ghmkF
	JOViNAn7heE/YZe3Ub9A==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3vexrcdnwb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jan 2024 16:08:16 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DB8C310002A;
	Thu, 11 Jan 2024 16:08:12 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C9C14288908;
	Thu, 11 Jan 2024 16:08:12 +0100 (CET)
Received: from [10.201.22.187] (10.201.22.187) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 11 Jan
 2024 16:08:12 +0100
Message-ID: <625c4e0f-ff66-4e2f-8e0a-1fe89db6c46b@foss.st.com>
Date: Thu, 11 Jan 2024 16:07:52 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/8] iio: add the IIO backend framework
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
        Jonathan Cameron
	<jic23@kernel.org>
CC: Nuno Sa <nuno.sa@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Michael
 Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Frank Rowand
	<frowand.list@gmail.com>
References: <20231220-iio-backend-v4-0-998e9148b692@analog.com>
 <20231220-iio-backend-v4-6-998e9148b692@analog.com>
 <20231221174437.5935a5c3@jic23-huawei>
 <f7df488b33c89ce7078c39a87ba1108fac5a10bd.camel@gmail.com>
 <20231226155904.043fee13@jic23-huawei>
 <8085910199d4b653edb61c51fc80a503ee50131d.camel@gmail.com>
Content-Language: en-US
From: Olivier MOYSAN <olivier.moysan@foss.st.com>
In-Reply-To: <8085910199d4b653edb61c51fc80a503ee50131d.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-05_08,2024-01-05_01,2023-05-22_02

Hi Nuno,

On 1/9/24 13:15, Nuno Sá wrote:
> On Tue, 2023-12-26 at 15:59 +0000, Jonathan Cameron wrote:
>>
>>>>> +
>>>>> +       ret = devm_add_action_or_reset(dev, iio_backend_release, back);
>>>>> +       if (ret)
>>>>> +               return ret;
>>>>> +
>>>>> +       link = device_link_add(dev, back->dev,
>>>>> DL_FLAG_AUTOREMOVE_CONSUMER);
>>>>> +       if (!link)
>>>>> +               pr_warn("%s: Could not link to supplier(%s)\n",
>>>>> dev_name(dev),
>>>>> +                       dev_name(back->dev));
>>>>
>>>> Why is that not an error and we try to carry on?
>>>
>>> I guess having the links are not really mandatory for the whole thing to
>>> work (more
>>> like a nice to have). That's also how this is handled in another subsystems
>>> so I
>>> figured it would be fine.
>>>
>>> But since you are speaking about this... After you pointing me to Bartosz's
>>> talk and
>>> sawing it (as stuff like this is mentioned), I started to question this. The
>>> goal
>>> with the above comment is that if you remove the backend, all the consumers
>>> are
>>> automatically removed (unbound). Just not sure if that's what we always want
>>> (and we
>>> are already handling the situation where a backend goes away with -ENODEV)
>>> as some
>>> frontends could still be useful without the backend (I guess that could be
>>> plausible). I think for now we don't really have such usecases so the links
>>> can make
>>> sense (and we can figure something like optionally creating these links if
>>> we ever
>>> need too) but having your inputs on this will definitely be valuable.
>>
>> I'm not keen on both trying to make everything tear down cleanly AND making
>> sure
>> it all works even if we don't. That just adds two code paths to test when
>> either
>> should be sufficient on its own.  I don't really mind which.  Bartosz's stuff
> 
> Agreed...
> 
>> is nice, but it may not be the right solution here.
> 
> There's pros and cons on both options...
> 
> For the device links the cons I see is that it depends on patch 3 for it to work
> (or some other approach if the one in that patch is not good) - not really a
> real con though :). The biggest concern is (possible) future uses where we end
> up with cases where removing a backend is not really a "deal breaker". I could
> think of frontends that have multiple backends (one per data path) and removing
> one backend would not tear the whole thing down (we would just have one non
> functional data paths/port where the others are still ok).
> 
> Olivier, for STM usecases, do we always need the backend? I mean, does it make
> sense to always remove/unbind the frontend in case the backend is unbound?
> 

In STM usecases we may have severals backends linked to a frontend. But 
I cannot find a usecase where it may be necessary to remove a backend 
while keeping the others alive. So from my side it is acceptable to tear 
everythings down if a backend if removed.

Olivier

> Maybe some of your usecases already "forces" us with a decision.
> 
> The biggest pro I see is code simplicity. If we can assume the frontend can
> never exist in case one of the backends is gone, we can:
> 
>   * get rid of the sync mutex;
>   * get rid of the kref and bind the backend object lifetime to the backend
> device (using devm_kzalloc() instead of kzalloc + refcount.
> 
> Basically, we would not need to care about syncing the backend existence with
> accessing it...
> To sum up, the device_links approach tends to be similar (not identical) to the
> previous approach using the component API.
> 
> The biggest pro I see in Bartosz's stuff is flexibility. So it should just work
> in whatever future usecases we might have. I fear that going the device_links
> road we might end up needing this stuff anyways.
> 
> Obviously, the biggest con is code complexity (not that bad though) as we always
> need to properly sync any backend callback.
> 
> - Nuno Sá
>>

