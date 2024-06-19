Return-Path: <linux-iio+bounces-6593-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6960890F3A0
	for <lists+linux-iio@lfdr.de>; Wed, 19 Jun 2024 18:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4DBA2823FD
	for <lists+linux-iio@lfdr.de>; Wed, 19 Jun 2024 16:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4B9156653;
	Wed, 19 Jun 2024 16:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="bfdDthOX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB1C1E4A1;
	Wed, 19 Jun 2024 16:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718812888; cv=none; b=fAnnCy4jcdFXOYL/40by+Lflc+QMf8jDjQP0cIEF0iyMZgFe8emarfrMOrRvbQ2R/SVLhrXcESDM7Q0cGka7K1XOEPtgE16tPyRYXoOvoFEKXKWlldULKJXcUGnR6a4CzwtfUPA+Kqa/XNMYZXE6GBkEr+0Mbs2J9I4ptHqqBjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718812888; c=relaxed/simple;
	bh=XIqMzWq2FXZP43Aoqwmf5WS4y3Av1YoQAVAQ1ChKZ78=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TRIwfuMgqqCFxqbFvms/PYgkhB49/nJv25TBURN1pQzRryjPstNyZsGofVEw53n8gb67JdSnthp8whmHw2Bo7fDLj/xmLCNd4945RsUoWv9SFZ80b5BOJycjZp0mOoFF6tj1tiKOQZPYHHonaIJkip5iX39l6Gf8YdyGV7O+Zf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=bfdDthOX; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45JCNqPx015603;
	Wed, 19 Jun 2024 18:01:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	rOgynnZfeUmPpXc76l1o3B8z/AsRIKwmsK/HY9cMWgY=; b=bfdDthOXWkqViv+V
	p6qXGah60Xh3ff3FOkqW0NIJH4PFjna16dzatGVWH31r0zd6+0Vs1bNTcUIno1zR
	esu4pqUbYckFFuzVyWQL94I/BReY1Dl3HO6naJrNjBwmA87k/eF7C1UPolIxoZkC
	6I5bEoufpr6UqYG+ky4ZBn9b8wyfS8pLalwxtD0cU3boER7yI2TR49mtjXVjkSdl
	gBJimlOiOdDdby19Ff7pRRwhiKJqjQKNaV2JuYRoVdXnw7EkBHrXGd6tbKas1EQt
	UeXhg1NICzFAqbPCLNoycOMjyoFXFKBXabDuAJsbyElPmbYqvRTA3NNOGZbNWmz6
	ySDEVg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3yuj9s4e9s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 18:01:07 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 1C8A34002D;
	Wed, 19 Jun 2024 18:00:58 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 584A7220B46;
	Wed, 19 Jun 2024 18:00:31 +0200 (CEST)
Received: from [10.252.1.130] (10.252.1.130) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 19 Jun
 2024 18:00:30 +0200
Message-ID: <1a5989f2-1285-4c55-833e-e18dfe973363@foss.st.com>
Date: Wed, 19 Jun 2024 18:00:30 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] iio: add child nodes support in iio backend framework
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
        Nuno Sa
	<nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen
	<lars@metafoo.de>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240618160836.945242-1-olivier.moysan@foss.st.com>
 <20240618160836.945242-4-olivier.moysan@foss.st.com>
 <4ee7d979736bb9e1518ce78ccb4a5b1a3766289c.camel@gmail.com>
Content-Language: en-US
From: Olivier MOYSAN <olivier.moysan@foss.st.com>
In-Reply-To: <4ee7d979736bb9e1518ce78ccb4a5b1a3766289c.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-19_02,2024-06-19_01,2024-05-17_01



On 6/19/24 07:31, Nuno Sá wrote:
> On Tue, 2024-06-18 at 18:08 +0200, Olivier Moysan wrote:
>> Add an API to support IIO generic channels binding:
>> http://devicetree.org/schemas/iio/adc/adc.yaml#
>> This new API is needed, as generic channel DT node
>> isn't populated as a device.
>> Add devm_iio_backend_subnode_get() to allow an IIO device
>> backend consumer to configure backend phandles in its
>> child nodes.
>>
>> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
>> ---
> 
> Again small notes nits. With it:
> 
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
> 
>>   drivers/iio/industrialio-backend.c | 48 ++++++++++++++++++++++--------
>>   include/linux/iio/backend.h        |  2 ++
>>   2 files changed, 38 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-
>> backend.c
>> index d3db048c086b..e9d29131634d 100644
>> --- a/drivers/iio/industrialio-backend.c
>> +++ b/drivers/iio/industrialio-backend.c
>> @@ -575,17 +575,8 @@ static int __devm_iio_backend_get(struct device *dev, struct
>> iio_backend *back)
>>   	return 0;
>>   }
>>   
>> -/**
>> - * devm_iio_backend_get - Device managed backend device get
>> - * @dev: Consumer device for the backend
>> - * @name: Backend name
>> - *
>> - * Get's the backend associated with @dev.
>> - *
>> - * RETURNS:
>> - * A backend pointer, negative error pointer otherwise.
>> - */
>> -struct iio_backend *devm_iio_backend_get(struct device *dev, const char *name)
>> +static struct iio_backend *__devm_iio_backend_node_get(struct device *dev, const
>> char *name,
>> +						       struct fwnode_handle *node)
> 
> I would call it __devm_iio_backend_fwnode_get(). Also the parameter node -> fwnode.
> 
>>   {
>>   	struct fwnode_handle *fwnode;
>>   	struct iio_backend *back;
>> @@ -602,7 +593,7 @@ struct iio_backend *devm_iio_backend_get(struct device *dev,
>> const char *name)
>>   		index = 0;
>>   	}
>>   
>> -	fwnode = fwnode_find_reference(dev_fwnode(dev), "io-backends", index);
>> +	fwnode = fwnode_find_reference(node, "io-backends", index);
>>   	if (IS_ERR(fwnode)) {
>>   		dev_err_probe(dev, PTR_ERR(fwnode),
>>   			      "Cannot get Firmware reference\n");
>> @@ -625,8 +616,41 @@ struct iio_backend *devm_iio_backend_get(struct device *dev,
>> const char *name)
>>   	fwnode_handle_put(fwnode);
>>   	return ERR_PTR(-EPROBE_DEFER);
>>   }
>> +
>> +/**
>> + * devm_iio_backend_get - Device managed backend device get
>> + * @dev: Consumer device for the backend
>> + * @name: Backend name
>> + *
>> + * Get's the backend associated with @dev.
>> + *
>> + * RETURNS:
>> + * A backend pointer, negative error pointer otherwise.
>> + */
>> +struct iio_backend *devm_iio_backend_get(struct device *dev, const char *name)
>> +{
>> +	return __devm_iio_backend_node_get(dev, name, dev_fwnode(dev));
>> +}
>>   EXPORT_SYMBOL_NS_GPL(devm_iio_backend_get, IIO_BACKEND);
>>   
>> +/**
>> + * devm_iio_backend_subnode_get - Device managed backend device get
>> + * @dev: Consumer device for the backend
>> + * @name: Backend name
>> + * @node: Firmware node of the backend consumer
>> + *
>> + * Get's the backend associated with @dev.
>> + *
>> + * RETURNS:
>> + * A backend pointer, negative error pointer otherwise.
>> + */
>> +struct iio_backend *devm_iio_backend_subnode_get(struct device *dev, const char
>> *name,
>> +						 struct fwnode_handle *node)
> 
> Again, for consistency devm_iio_backend_fwnode_get(). And node -> fwnode
> 

Done.
Thanks
Olivier

> - Nuno Sá
> 
> 

