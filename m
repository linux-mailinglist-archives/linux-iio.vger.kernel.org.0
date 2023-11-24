Return-Path: <linux-iio+bounces-318-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6047C7F7378
	for <lists+linux-iio@lfdr.de>; Fri, 24 Nov 2023 13:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9065B1C20C99
	for <lists+linux-iio@lfdr.de>; Fri, 24 Nov 2023 12:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D6320303;
	Fri, 24 Nov 2023 12:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="KwsU0tK+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 840019A
	for <linux-iio@vger.kernel.org>; Fri, 24 Nov 2023 04:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1700827885; x=1703419885;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ueaYiJio+rr5h9VoUpW5qtG1LvpMOX1vur0Jso/gkfY=;
	b=KwsU0tK+RKdsBGwBJcAEEJeHeo/3QC0NQ5rALA+33W8m2Xn8V7CU36UW3GbS9Fge
	8UJSBA0NjZxv3yrYIsJDV0C3Jy8oMEgJtzu6x2jjfB9CvjnY9LUckBH7N5NUIWRD
	b6S0M/NXtc4ULSCNLyJGTgxMge4i0sx23uf8jIr6zuw=;
X-AuditID: ac14000a-fbefe7000000290d-17-656092eda846
Received: from florix.phytec.de (Unknown_Domain [172.25.0.13])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id C1.7D.10509.DE290656; Fri, 24 Nov 2023 13:11:25 +0100 (CET)
Received: from [172.25.39.28] (172.25.0.11) by Florix.phytec.de (172.25.0.13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Fri, 24 Nov
 2023 13:11:24 +0100
Message-ID: <a58ae80e-e281-425a-9b72-bad8fd305e6a@phytec.de>
Date: Fri, 24 Nov 2023 13:11:24 +0100
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
To: Jonathan Cameron <jic23@kernel.org>
CC: <lars@metafoo.de>, <robh@kernel.org>, <heiko@sntech.de>,
	<peter.ujfalusi@ti.com>, <mugunthanvnm@ti.com>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <nm@ti.com>, <upstream@lists.phytec.de>,
	Bhavya Kapoor <b-kapoor@ti.com>
References: <20230925134427.214556-1-w.egorov@phytec.de>
 <20231005150917.2d0c833e@jic23-huawei>
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20231005150917.2d0c833e@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Florix.phytec.de
 (172.25.0.13)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMIsWRmVeSWpSXmKPExsWyRpKBV/ftpIRUgwmvrCxWbn/OaPH/0WtW
	iwdNq5gslkyez2ox78g7FovLu+awWVx9UG7x5sdZJotZH3+wWvzfs4PdovudugO3x6ZVnWwe
	/d0trB5L3hxi9dh+bR6zx/Eb25k8Pm+SC2CL4rJJSc3JLEst0rdL4Mr4/OYAY8F83oodZ1qZ
	GxhPcHUxcnJICJhI3G9/z9jFyMUhJLCYSeJ172sWCOcuo8SjT02sIFW8AjYSWz69YQSxWQRU
	JX4sO8ACEReUODnzCZgtKiAvcf/WDHYQW1ggQWLWzjVsIDazgLjErSfzmUBsEQF1iWkzrjCB
	LGAW+MEosXjfC7CEkECixIfDc8BsNqCiOxu+gS3mFDCWmPtpDzvEIAuJxW8OQtnyEtvfzmGG
	6JWXeHFpOQvEO/IS0869ZoawQyXmr/nOPoFReBaSW2chuWkWkrGzkIxdwMiyilEoNzM5O7Uo
	M1uvIKOyJDVZLyV1EyMo4kQYuHYw9s3xOMTIxMF4iFGCg1lJhDf3T3yqEG9KYmVValF+fFFp
	TmrxIUZpDhYlcd7VHcGpQgLpiSWp2ampBalFMFkmDk6pBsYtZr6rnbJ94lZ//fV+7y27qcmn
	1qxdHLzAlWVb9oer2oZpCjo52qEebSFnk577BH2QD9kR26wat+NxR5+b8K6EB3kfxO7veBMr
	9cu2Y972C0uteOf4ydxeMGPy+tBwrkm9mgdtths873u6vrnmvMTuST68Ntvjl2yoL92+Wsa7
	vOl5Ybzcv7NKLMUZiYZazEXFiQAcMclBpgIAAA==


Am 05.10.23 um 16:09 schrieb Jonathan Cameron:
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

Bhavya, any comments on this?
If not, is there anything else that is blocking this patch?

Regards,
Wadim

>
> Thanks,
>
> Jonathan
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

