Return-Path: <linux-iio+bounces-6973-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8941B9187F4
	for <lists+linux-iio@lfdr.de>; Wed, 26 Jun 2024 18:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42551281256
	for <lists+linux-iio@lfdr.de>; Wed, 26 Jun 2024 16:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5883718F2EA;
	Wed, 26 Jun 2024 16:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="oG2GH6+e"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BF61F94C;
	Wed, 26 Jun 2024 16:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719420845; cv=none; b=Ql+4xW0ZiySVYsI4R1hEWat8k6OYWIsS6FyXau8jRKcXBWWb2H3aiUIOKyKLetjH9bDlNhNMHYrVY4LBwhGAImn7OczuDsJLTuKVnu+7BYWW/6GiBAzcSGBzAtIltflzEGe8gbK6JmIBgIBWEGvoNIQD5x06vRsjLcSo7cFf84Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719420845; c=relaxed/simple;
	bh=DwUVMG9lyAJbQuLl5/qPx6F0m9rrULtE4ojzyZI781A=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Vk4NrtEa7XTKG+jXGg5C/uC3VPqMnL9LfYL0UGSNiiS6sVdQ/k2YEmOqE8sJ5OWfyDFTwBWBoibWhkyJa9xFXFUDuV1ROJMLnpsedSMKEyzklDFog+ScCnPEHSOF/hSl5xkmAG8VNb7FD+U+nRS5/jZvDGp10h3ipslgk5ZcWI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=oG2GH6+e; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45QDc3bB026443;
	Wed, 26 Jun 2024 18:13:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	fR7TTargwvIeSd0xLsj6iyjHFV1aUNl1Yiwk6NPTJ2A=; b=oG2GH6+eWyLOM9JF
	Ila1Ejr88Md5ityD9o8Do7D0U3x65gFY67pYuKfvA3ISk+ERMqKiqWxwniz0jPoD
	38HsH06i5BNllKOHK8Nx4YzSoob4MRUTQfn6QEWoUfko7sPoeevOKmozfVV8/eMw
	yA6FmTTB3gDNJ8twgBNp06oYavVyxLXNOGkTaQS5H2LOEn6d8qOLHrRkd28fOF27
	xrRJsuNIVfVlybaGE5Q0b5FKnlIyY1jhYiKw6NJ7Az4cPcefokwUnimGXxeAOp2w
	nnf/WsxO5zeOZj9y5yLRMkpN/wArK051Ou0ISibiQZwoOA748ljUaArXkEtojFyO
	bzV8sQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ywngdgxas-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 18:13:05 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 08D0D40050;
	Wed, 26 Jun 2024 18:12:55 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 520CA228A5F;
	Wed, 26 Jun 2024 18:12:29 +0200 (CEST)
Received: from [10.252.26.2] (10.252.26.2) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 26 Jun
 2024 18:12:28 +0200
Message-ID: <5dd04746-c929-40ff-85ae-5d0e3776f097@foss.st.com>
Date: Wed, 26 Jun 2024 18:12:28 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] iio: add read raw service to iio backend framework
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
        <fabrice.gasnier@foss.st.com>, Nuno Sa <nuno.sa@analog.com>,
        Jonathan Cameron
	<jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240625150717.1038212-1-olivier.moysan@foss.st.com>
 <20240625150717.1038212-2-olivier.moysan@foss.st.com>
 <0a5f82ad9ba032d03b389fce54360a82914c15af.camel@gmail.com>
Content-Language: en-US
From: Olivier MOYSAN <olivier.moysan@foss.st.com>
In-Reply-To: <0a5f82ad9ba032d03b389fce54360a82914c15af.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_07,2024-06-25_01,2024-05-17_01

Hi Nuno,

On 6/26/24 10:50, Nuno Sá wrote:
> On Tue, 2024-06-25 at 17:07 +0200, Olivier Moysan wrote:
>> Add iio_backend_read_raw() service to support attributes read
>> from an IIO backend.
>>
>> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
>> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
>> ---
>>   drivers/iio/industrialio-backend.c | 21 +++++++++++++++++++++
>>   include/linux/iio/backend.h        |  6 +++++-
>>   2 files changed, 26 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-
>> backend.c
>> index 929aff4040ed..0e2653de1956 100644
>> --- a/drivers/iio/industrialio-backend.c
>> +++ b/drivers/iio/industrialio-backend.c
>> @@ -357,6 +357,27 @@ int devm_iio_backend_request_buffer(struct device *dev,
>>   }
>>   EXPORT_SYMBOL_NS_GPL(devm_iio_backend_request_buffer, IIO_BACKEND);
>>   
>> +/**
>> + * iio_backend_read_raw - Request a channel attribute from the IIO backend.
>> + * @back:	Backend device
>> + * @chan:	IIO channel reference
>> + * @val:	First element of the returned value
>> + * @val2:	Second element of the returned value
>> + * @mask:	Specify value to retrieve
>> + *
>> + * This callback replicates the read_raw callback of the IIO framework, and
>> is intended to
>> + * request miscellaneous channel attributes from the backend device.
>> + *
>> + * RETURNS:
>> + * 0 on success, negative error number on failure.
>> + */
>> +int iio_backend_read_raw(struct iio_backend *back, struct iio_chan_spec const
>> *chan, int *val,
>> +			 int *val2, long mask)
>> +{
>> +	return iio_backend_op_call(back, read_raw, chan, val, val2, mask);
>> +}
>> +EXPORT_SYMBOL_NS_GPL(iio_backend_read_raw, IIO_BACKEND);
> 
> I actually got an idea when looking at this for my existential crisis between
> dedicated APIs and a catch all .read_raw() :). What we can do is just provide
> the .read_raw() or write_raw() ops to backends (so we minimize the number of
> ops) and then we build on top of them for providing more readable (depending on
> the case; some cases it does make sense to just call iio_backend_read_raw())
> APIs to frontends.
> 
> So in your case you could have in backend.h
> 
> static inline int iio_backend_read_scale(...)
> {
> 	return iio_backend_read_raw(..., IIO_CHAN_INFO_SCALE);
> }
> 
> Naturally no need for you to do this right now in your series. Just wanted to
> write it down before I go into other stuff and forget about this :)
> 

Yes, this is a good compromise. Such helpers are more user-friendly for 
the consumer. As long as I have to push a v3, I might take the 
opportunity to add this.

BRs
Olivier

> - Nuno Sá
> 
> 

