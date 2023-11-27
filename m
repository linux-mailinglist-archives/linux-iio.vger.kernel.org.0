Return-Path: <linux-iio+bounces-423-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F4A7F9CE1
	for <lists+linux-iio@lfdr.de>; Mon, 27 Nov 2023 10:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A234E1C20C4D
	for <lists+linux-iio@lfdr.de>; Mon, 27 Nov 2023 09:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3362A171DB;
	Mon, 27 Nov 2023 09:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="P9R6pejp"
X-Original-To: linux-iio@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DA9DE;
	Mon, 27 Nov 2023 01:44:53 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AR9iXg3103463;
	Mon, 27 Nov 2023 03:44:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1701078273;
	bh=c4TtKqduz23cMV1eZmISPwEE/csEVvL4e4+SaaESj70=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=P9R6pejpJK+lsHtH6xicrdIRfB/UOrt60nfqI3I9lYsIL77JuqHc7UuRDNDarUEIL
	 t8+Aa5AjPngsAxBZCTVgSZRKcfUHJsbItZ+E+kkk45bd/oeykEcWonfpOdFEmhB+yk
	 RIEJYp3GM3MuFrFprhcj9LFz9jWf9f0CBCvCN2vM=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AR9iXIR038381
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 27 Nov 2023 03:44:33 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 27
 Nov 2023 03:44:33 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 27 Nov 2023 03:44:33 -0600
Received: from [172.24.227.133] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
	by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AR9iTdX003241;
	Mon, 27 Nov 2023 03:44:30 -0600
Message-ID: <0c26613b-4aba-4e1e-bf0e-57feff23e303@ti.com>
Date: Mon, 27 Nov 2023 15:14:29 +0530
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
To: Wadim Egorov <w.egorov@phytec.de>, Jonathan Cameron <jic23@kernel.org>
CC: <lars@metafoo.de>, <robh@kernel.org>, <heiko@sntech.de>,
        <peter.ujfalusi@ti.com>, <mugunthanvnm@ti.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nm@ti.com>, <upstream@lists.phytec.de>
References: <20230925134427.214556-1-w.egorov@phytec.de>
 <20231005150917.2d0c833e@jic23-huawei>
 <a58ae80e-e281-425a-9b72-bad8fd305e6a@phytec.de>
From: Bhavya Kapoor <b-kapoor@ti.com>
In-Reply-To: <a58ae80e-e281-425a-9b72-bad8fd305e6a@phytec.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

LGTM !!🙂

On 24/11/23 5:41 pm, Wadim Egorov wrote:
>
> Am 05.10.23 um 16:09 schrieb Jonathan Cameron:
>> On Mon, 25 Sep 2023 15:44:27 +0200
>> Wadim Egorov <w.egorov@phytec.de> wrote:
>>
>>> Fix wrong handling of a DMA request where the probing only failed
>>> if -EPROPE_DEFER was returned. Instead, let us fail if a non -ENODEV
>>> value is returned. This makes DMAs explicitly optional. Even if the
>>> DMA request is unsuccessfully, the ADC can still work properly.
>>> We do also handle the defer probe case by making use of 
>>> dev_err_probe().
>>>
>>> Fixes: f438b9da75eb ("drivers: iio: ti_am335x_adc: add dma support")
>>> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
Reviewed-by: Bhavya Kapoor <b-kapoor@ti.com>
>> +CC Bhavya,
>>
>> Could you take a look at this given you had comments on v1.
>
> Bhavya, any comments on this?
> If not, is there anything else that is blocking this patch?
>
> Regards,
> Wadim
>
>>
>> Thanks,
>>
>> Jonathan
>>
>>> ---
>>> v2:
>>>    - Update description
>>>    - Drop line break after Fixes tag
>>>    - Move decision about optional DMA into probe/caller
>>> ---
>>>   drivers/iio/adc/ti_am335x_adc.c | 4 +++-
>>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/iio/adc/ti_am335x_adc.c 
>>> b/drivers/iio/adc/ti_am335x_adc.c
>>> index 8db7a01cb5fb..5f8795986995 100644
>>> --- a/drivers/iio/adc/ti_am335x_adc.c
>>> +++ b/drivers/iio/adc/ti_am335x_adc.c
>>> @@ -670,8 +670,10 @@ static int tiadc_probe(struct platform_device 
>>> *pdev)
>>>       platform_set_drvdata(pdev, indio_dev);
>>>         err = tiadc_request_dma(pdev, adc_dev);
>>> -    if (err && err == -EPROBE_DEFER)
>>> +    if (err && err != -ENODEV) {
>>> +        dev_err_probe(&pdev->dev, err, "DMA request failed\n");
>>>           goto err_dma;
>>> +    }
>>>         return 0;

