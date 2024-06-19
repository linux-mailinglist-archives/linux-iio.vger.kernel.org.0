Return-Path: <linux-iio+bounces-6592-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 415E390F39A
	for <lists+linux-iio@lfdr.de>; Wed, 19 Jun 2024 18:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47E201C20DE3
	for <lists+linux-iio@lfdr.de>; Wed, 19 Jun 2024 16:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E5445009;
	Wed, 19 Jun 2024 16:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="M/8ixEAf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEB81E4A1;
	Wed, 19 Jun 2024 16:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718812822; cv=none; b=laCTTSPyyLQJDPcii2TBTI3rSS8DzSB0WAeGX4VNWq8XCk0INVu7+a5fzZzAApGzz9pjBCUdpAQW22dwGQ1sAmFBIUDpn6KeHFC/34PIsJJ4pLiz6WOvTS25CqIq+JKUlnfYo5IvG5nQknoZ5BVC6x4E+Un4pmLKzbKrFkRDkeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718812822; c=relaxed/simple;
	bh=lsQELVPlsQAcUQYMeUHH/b3zV6m6tBZUonHzjKQKzk4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RDzknp25+twwHzsbTwca4jAzQFLQ6F+u1v+HoAxh6THa09u/cwxUPG56phpCx02Arh0aCa6LuoD1e/Uf4xv4FffMkOjueNMFZwHD1OCRmrGEvM/BkXuTjDtZpHV7/PVrUJZpysjyK8gsHa0jgRNu8HEwxbIN+AhPKdoqzW4of/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=M/8ixEAf; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45JCejEg024133;
	Wed, 19 Jun 2024 18:00:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	b5I09re8UijZNQJy+2SehYcQsyJFUcqURWXJ6ZBkaI8=; b=M/8ixEAfgdzHtMR+
	N8TAh1MnQt+6Q1wSgaIk0MsWHHff+eg/0Q3bDzDX4/WUX3QwZXwfqU5btGRjsrXQ
	MlzIfkPsD+3zvkcHUvmfTAsXImBAsJVvL9IHs+C/4OmpHmc4XSAhVgN8kYAMMnHQ
	rY8+O27uMpxhgCAb7Z3C03tB+BXYQmCm0yYhvBpD9FghVeQm6ux2wfyhl8X08/B+
	Nho/lgWmpdVAouKiCTGFimgg4ynUDLriaK9rtPadjtMSuoFFTsgel7qThiqCpvHj
	DBttaPtVA47oHb1wqE6ZvgiWkHNEkPp5foG/J3AJRq3PCeRwvdym5xSNMYgc9XkR
	xPQsvQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3yuj9n46ut-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 18:00:03 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 1FAAA4002D;
	Wed, 19 Jun 2024 17:59:53 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3B777221940;
	Wed, 19 Jun 2024 17:59:27 +0200 (CEST)
Received: from [10.252.1.130] (10.252.1.130) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 19 Jun
 2024 17:59:26 +0200
Message-ID: <8c3de47c-bd72-4560-a43b-5275f2f7a059@foss.st.com>
Date: Wed, 19 Jun 2024 17:59:26 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] iio: add enable and disable services to iio backend
 framework
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
        Nuno Sa
	<nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen
	<lars@metafoo.de>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240618160836.945242-1-olivier.moysan@foss.st.com>
 <20240618160836.945242-3-olivier.moysan@foss.st.com>
 <5b7b8a7132934b77b43ffde0650c68c1dd9a5b7e.camel@gmail.com>
Content-Language: en-US
From: Olivier MOYSAN <olivier.moysan@foss.st.com>
In-Reply-To: <5b7b8a7132934b77b43ffde0650c68c1dd9a5b7e.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-19_02,2024-06-19_01,2024-05-17_01

Hi Nuno,

On 6/19/24 07:21, Nuno Sá wrote:
> On Tue, 2024-06-18 at 18:08 +0200, Olivier Moysan wrote:
>> Add iio_backend_disable() and iio_backend_enable() APIs to allow
>> IIO backend consumer to request backend disabling and enabling.
>>
>> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
>> ---
> 
> Hi Olivier,
> 
> small notes from me...
> 
>>   drivers/iio/industrialio-backend.c | 26 ++++++++++++++++++++++++++
>>   include/linux/iio/backend.h        |  2 ++
>>   2 files changed, 28 insertions(+)
>>
>> diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-
>> backend.c
>> index b950e30018ca..d3db048c086b 100644
>> --- a/drivers/iio/industrialio-backend.c
>> +++ b/drivers/iio/industrialio-backend.c
>> @@ -166,6 +166,32 @@ int devm_iio_backend_enable(struct device *dev, struct
>> iio_backend *back)
>>   }
>>   EXPORT_SYMBOL_NS_GPL(devm_iio_backend_enable, IIO_BACKEND);
>>   
>> +/**
>> + * iio_backend_enable - Backend enable
>> + * @dev: Consumer device for the backend
>> + * @back: Backend device
>> + *
>> + * RETURNS:
>> + * 0 on success, negative error number on failure.
>> + */
>> +int iio_backend_enable(struct device *dev, struct iio_backend *back)
>> +{
>> +	return iio_backend_op_call(back, enable);
>> +}
>> +EXPORT_SYMBOL_NS_GPL(iio_backend_enable, IIO_BACKEND);
> 
> We do already have devm_iio_backend_enable(). From a correctness stand point and even
> scalability, that API should now call your new iio_backend_enable() instead of
> directly call iio_backend_op_call(). I guess that change could be in this patch.
>

Sure. I have updated the patch.

>> +
>> +/**
>> + * iio_backend_disable - Backend disable
>> + * @dev: Consumer device for the backend
>> + * @back: Backend device
>> + *
>> + */
>> +void iio_backend_disable(struct device *dev, struct iio_backend *back)
>> +{
>> +	iio_backend_void_op_call(back, disable);
>> +}
>> +EXPORT_SYMBOL_NS_GPL(iio_backend_disable, IIO_BACKEND);
>> +
> 
> We also have __iio_backend_disable() which is static since all users were using
> devm_iio_backend_enable(). I understand that's not suitable for you but I would
> instead rename the existing function to iio_backend_disable() and export it.
> 

Just renaming is not sufficient. The reason is that 
devm_add_action_or_reset() require an action with action(void *) 
prototype. So the prototype of iio_backend_disable() has to be changed 
to void iio_backend_disable(void *back).
I placed the same arguments in enable and disable for symmetry, but *dev 
is not required for time being in disable API. So it can make sense to 
change iio_backend_disable() prototype.
alternatively, we can call __iio_backend_disable() through this API.
Please, let me know is you have a preference.

Thanks
Olivier

> With the above changes:
> 
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
> 
> - Nuno Sá
> 

