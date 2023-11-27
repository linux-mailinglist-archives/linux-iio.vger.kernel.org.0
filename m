Return-Path: <linux-iio+bounces-422-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B44F17F9CDB
	for <lists+linux-iio@lfdr.de>; Mon, 27 Nov 2023 10:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 137E52812D5
	for <lists+linux-iio@lfdr.de>; Mon, 27 Nov 2023 09:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BCC217734;
	Mon, 27 Nov 2023 09:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qrJijozY"
X-Original-To: linux-iio@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FEF712D;
	Mon, 27 Nov 2023 01:41:18 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AR9eoS7115669;
	Mon, 27 Nov 2023 03:40:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1701078050;
	bh=pCY7DFG3/xlRNRpTV4E9IgPYvQLv9m8bh6SdbTCVMzU=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=qrJijozY4EaHxw4gRYDAWMHEkjPhU8ia4QDFiM2IAAS49+geRBHnsJ1ualldgIjf2
	 4pLSLCuyYW6oCFRlii1SJme8GRLTIR2MKk2ndlrgeH/WZjG9QaKg/GH2Pk69ZttS5+
	 /JP7r8nJmmp72r6CHA8P37zF8JRNU1Rrm0aREDeo=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AR9eofU035872
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 27 Nov 2023 03:40:50 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 27
 Nov 2023 03:40:49 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 27 Nov 2023 03:40:49 -0600
Received: from [172.24.227.133] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
	by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AR9ek0v123777;
	Mon, 27 Nov 2023 03:40:46 -0600
Message-ID: <53edd2e5-ffc3-4406-baac-3582edcdbf93@ti.com>
Date: Mon, 27 Nov 2023 15:10:45 +0530
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iio: adc: ti_am335x_adc: Fix return value check of
 tiadc_request_dma()
Content-Language: en-US
To: Jonathan Cameron <jic23@kernel.org>, Wadim Egorov <w.egorov@phytec.de>
CC: <lars@metafoo.de>, <robh@kernel.org>, <heiko@sntech.de>,
        <peter.ujfalusi@ti.com>, <mugunthanvnm@ti.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nm@ti.com>, <upstream@lists.phytec.de>
References: <20230925134427.214556-1-w.egorov@phytec.de>
 <20231005150917.2d0c833e@jic23-huawei>
From: Bhavya Kapoor <b-kapoor@ti.com>
In-Reply-To: <20231005150917.2d0c833e@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180


On 05/10/23 7:39 pm, Jonathan Cameron wrote:
> On Mon, 25 Sep 2023 15:44:27 +0200
> Wadim Egorov <w.egorov@phytec.de> wrote:
>
>> Fix wrong handling of a DMA request where the probing only failed
>> if -EPROPE_DEFER was returned. Instead, let us fail if a non -ENODEV
>> value is returned. This makes DMAs explicitly optional. Even if the
>> DMA request is unsuccessfully, the ADC can still work properly.
>> We do also handle the defer probe case by making use of dev_err_probe().
>>
>> Fixes: f438b9da75eb ("drivers: iio: ti_am335x_adc: add dma support")
>> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
> +CC Bhavya,
>
> Could you take a look at this given you had comments on v1.
>
> Thanks,
>
> Jonathan

Hi Jonathan, Patch Looks Good To Me and Should now work fine for every case.

Regards

~B-Kapoor

>
>> ---
>> v2:
>>    - Update description
>>    - Drop line break after Fixes tag
>>    - Move decision about optional DMA into probe/caller
>> ---
>>   drivers/iio/adc/ti_am335x_adc.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
>> index 8db7a01cb5fb..5f8795986995 100644
>> --- a/drivers/iio/adc/ti_am335x_adc.c
>> +++ b/drivers/iio/adc/ti_am335x_adc.c
>> @@ -670,8 +670,10 @@ static int tiadc_probe(struct platform_device *pdev)
>>   	platform_set_drvdata(pdev, indio_dev);
>>   
>>   	err = tiadc_request_dma(pdev, adc_dev);
>> -	if (err && err == -EPROBE_DEFER)
>> +	if (err && err != -ENODEV) {
>> +		dev_err_probe(&pdev->dev, err, "DMA request failed\n");
>>   		goto err_dma;
>> +	}
>>   
>>   	return 0;
>>   

