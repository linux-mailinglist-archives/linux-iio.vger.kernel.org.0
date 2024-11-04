Return-Path: <linux-iio+bounces-11878-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3FB9BAA17
	for <lists+linux-iio@lfdr.de>; Mon,  4 Nov 2024 02:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5B121C203FF
	for <lists+linux-iio@lfdr.de>; Mon,  4 Nov 2024 01:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DFFA15A848;
	Mon,  4 Nov 2024 01:15:04 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77ED464A8F;
	Mon,  4 Nov 2024 01:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730682903; cv=none; b=UBUnIGsmDCXKbku/HhlQci0jKGJrjWMr3d2qFlZPd5W0JRH9egt5syWHQleyNJV8PU5f3/kGHxZfpIV8HRJ2FAgAFyKhk6FVnD1mIdGRaQqzb4zmEamcvyT+2tNKgCqe0bbbAETXHA6rC1ZP7YW0meMNj924jPPV8Y49A1jhPxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730682903; c=relaxed/simple;
	bh=2sLLZZEpzcDpW+d6iEMd/uqbYcQ5CycLlYps/tyOOLs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UYvMR5IGGSOrzta7/GrO73hjHcsBz5dDDE3JvzLuuVL8c2oOjFG05pg/DwI4E+vFU0p1jEnWjh9oktegyKsLNoV0bskJlX2ZhdZv9elASAQQ/U7xyCeiGcngHf6MG1A07rbq/RQgOtFizcPzdcaJD7ka30VsSxKKa6qcMD7gUYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 2ed0c24a9a4a11efa216b1d71e6e1362-20241104
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:904603b0-5bd3-4011-9813-1654b379fa8a,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:f5f0a59fe6f9f85a74ec417bd17f5ee5,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,URL:0
	,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
	NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 2ed0c24a9a4a11efa216b1d71e6e1362-20241104
Received: from node4.com.cn [(10.44.16.170)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 617807153; Mon, 04 Nov 2024 09:14:47 +0800
Received: from node4.com.cn (localhost [127.0.0.1])
	by node4.com.cn (NSMail) with SMTP id 5BB2E16002081;
	Mon,  4 Nov 2024 09:14:47 +0800 (CST)
X-ns-mid: postfix-67282007-30317774
Received: from [10.42.116.241] (unknown [10.42.116.241])
	by node4.com.cn (NSMail) with ESMTPA id ECF1216002081;
	Mon,  4 Nov 2024 01:14:45 +0000 (UTC)
Message-ID: <34ab4d22-0b07-43ba-9d4f-eb4b2867f36a@kylinos.cn>
Date: Mon, 4 Nov 2024 09:14:45 +0800
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: test : check null return of kunit_kmalloc in
 iio_rescale_test_scale
To: Jonathan Cameron <jic23@kernel.org>
Cc: liambeguin@gmail.com, lars@metafoo.de, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, xiaopeitux@foxmail.com
References: <ecd56a85e54a96c2f0313c114075a21a76071ea2.1730259869.git.xiaopei01@kylinos.cn>
 <20241101172926.4e8e3f43@jic23-huawei>
Content-Language: en-US
From: Pei Xiao <xiaopei01@kylinos.cn>
In-Reply-To: <20241101172926.4e8e3f43@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/11/2 01:29, Jonathan Cameron Wrote:
> On Wed, 30 Oct 2024 11:48:54 +0800
> Pei Xiao <xiaopei01@kylinos.cn> wrote:
> 
>> kunit_kmalloc may fail, return value might be NULL and will cause
>> NULL pointer dereference.Add KUNIT_ASSERT_NOT_ERR_OR_NULL fix it.
> Can it be an error?  If not why not use KUNIT_ASSERT_NOT_NULL?
As you thought, initially I felt that we should use 
KUNIT_ASSERT_NOT_NULL. However, when I used grep 
KUNIT_ASSERT_NOT_ERR_OR_NULL -nr drivers/iio/test/, I found that the 
drivers/iio/test/ directory exclusively uses 
KUNIT_ASSERT_NOT_ERR_OR_NULL instead of KUNIT_ASSERT_NOT_NULL. To 
maintain consistency, I have changed it to KUNIT_ASSERT_NOT_ERR_OR_NULL.

drivers/iio/test/iio-test-format.c:22: 
KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf);
drivers/iio/test/iio-test-format.c:52: 
KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf);
drivers/iio/test/iio-test-format.c:113: 
KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf);
drivers/iio/test/iio-test-format.c:153: 
KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf);
drivers/iio/test/iio-test-format.c:193: 
KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf);
drivers/iio/test/iio-test-format.c:208: 
KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf);
>>
>> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
>> Fixes: 8e74a48d17d5 ("iio: test: add basic tests for the iio-rescale driver")
>> ---
>>   drivers/iio/test/iio-test-rescale.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/iio/test/iio-test-rescale.c b/drivers/iio/test/iio-test-rescale.c
>> index 31ee55a6faed..11bfff6636a3 100644
>> --- a/drivers/iio/test/iio-test-rescale.c
>> +++ b/drivers/iio/test/iio-test-rescale.c
>> @@ -652,6 +652,8 @@ static void iio_rescale_test_scale(struct kunit *test)
>>   	int rel_ppm;
>>   	int ret;
>>   
>> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buff);
>> +
>>   	rescale.numerator = t->numerator;
>>   	rescale.denominator = t->denominator;
>>   	rescale.offset = t->offset;
>> @@ -681,6 +683,8 @@ static void iio_rescale_test_offset(struct kunit *test)
>>   	int values[2];
>>   	int ret;
>>   
>> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buff_off);
>> +
>>   	rescale.numerator = t->numerator;
>>   	rescale.denominator = t->denominator;
>>   	rescale.offset = t->offset;
> 

