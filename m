Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78AB23D8911
	for <lists+linux-iio@lfdr.de>; Wed, 28 Jul 2021 09:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233407AbhG1Hrk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 28 Jul 2021 03:47:40 -0400
Received: from mail-eopbgr30109.outbound.protection.outlook.com ([40.107.3.109]:42048
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232691AbhG1Hrj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 28 Jul 2021 03:47:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N6JRrHLKcCVwOOLcoxC+DeoLeTSsJRgJYJampwu7NU5Wm+fvSM6eR8Jxfzzay1d59IU3ebn47wtYZx8RjvMJP73qCH7NmhWyyE4fFlZ+tzWsTABYbQe/thzb95g3iKty0Uj45bblJlrqN8ogsssXZ5NdL7tOZg/0oZK3QXPBY1rk6QsQTWEMxv/4ayff7Nh7effd/m+VXzp8+vJLwK5WFOKLmjrO3xb6mXY7rDYMjSDDHerAGHGZV5e73YGFPNsCBRekXskO+sd1Qzgp4xKxevtoEXE+UMIZMalv9pqo0rHm32CqU4bRyGmA/FAYMIUuE404QqGMhmNFMLffaolf8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pEAjb3SinWqutE0Ycqvmrket1m8pDYUQeuJPVFR2cJE=;
 b=hOcBXwuCSQkwebj+9AwRrtIXhsBGsm144LC21FCMckhoQKgNQwnM0f902VXhfVfl4cZ682nazkU4v4H5XglcSFMnpvI/MAwt2hVIbLPhaFptRq0LIFUM2kAfcyc7QPzoDK4YbnPB5t6sBFDd6rmKgAZRERZlCK63zdPxDde7pERnr/IsHg+Yw76MUMvfIwooOFhdhHfSE7SIVe/TUODiHlCZD7P9F5oSso07sCybJGtctOUb3Ab0IXJfWRtEC+5ysATfDdBhVfkrKhktWI1wLdOj0MPU0kkktgyYoyWm1NXmamYZn+FFKzOChqerrzhLSUmH++ENgVFTVGNZ5XAcfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pEAjb3SinWqutE0Ycqvmrket1m8pDYUQeuJPVFR2cJE=;
 b=k5ZQWCaoAuo/67C6FFP23xfzIn2lbad58B4rrSSrpF8AcqF7dj7R/g7q9gbX1PXqZHdNCW3vvqFgIcFxkBzg30WVGrkjUy9wbd6kxTcXDdBAw4RxKy/7RUU0B49dYNZCOTA2fHYnXQCYWMaHxgG468wzV5sf9AmNfdysBPZeb8A=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB7PR02MB4106.eurprd02.prod.outlook.com (2603:10a6:10:4c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.29; Wed, 28 Jul
 2021 07:47:35 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::14ca:a41:2218:3578]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::14ca:a41:2218:3578%6]) with mapi id 15.20.4352.031; Wed, 28 Jul 2021
 07:47:35 +0000
Subject: Re: [PATCH v6 08/13] iio: afe: rescale: reduce risk of integer
 overflow
To:     Liam Beguin <liambeguin@gmail.com>, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
References: <20210721030613.3105327-1-liambeguin@gmail.com>
 <20210721030613.3105327-9-liambeguin@gmail.com>
 <9e0e4398-873e-b5c0-0f0c-50a186ed2228@axentia.se>
 <CD4C37PEMPOM.91UZ60Q6534Q@shaak>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <1a6e4851-9119-f524-76ff-a31ef0db8988@axentia.se>
Date:   Wed, 28 Jul 2021 09:47:32 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <CD4C37PEMPOM.91UZ60Q6534Q@shaak>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6PR10CA0061.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:209:80::38) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.13.3] (85.229.94.233) by AM6PR10CA0061.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:209:80::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend Transport; Wed, 28 Jul 2021 07:47:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f5743b47-2743-4d3d-38f5-08d9519bf6cc
X-MS-TrafficTypeDiagnostic: DB7PR02MB4106:
X-Microsoft-Antispam-PRVS: <DB7PR02MB4106431A7F686DC2DB0B726BBCEA9@DB7PR02MB4106.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: plYmx25QaHQ0tLqHFqu9q+qMp5El8vxeHOsvtzys7+f/vM+VKSvnZclMDMSkvozf1TwlDDPb0J4MpR9iUdBX03IvDnWgikJ72GL53uxNyoNoFIqp7tcaP6qH9NH9rPR+yZtoP534lMOW34tZW6olnGd1dhHMN91Z6QFRYRDtNrNZKuDq4KvYyyDqZKeKPqo2DsyOF0boAWtvzUX2/EhEujauZEZ+bLIzdpwwbcCOz4wa6LRY4WHDfmxflAK8zRfRy3jjwZW+lLW18emrZbZU8UiPZ/Lg9/i+MrS03lVlgco3kCpiXvQwIVTWcaLxS+vYF10UbKIvGH0slfx7gKbK3xqCr4VTIf6Bh2oaH8gDk0jEB6cCsKmB8mxeQzL/TKwJqtNGsnSsknJpWHwmH1042QhlfUYqUh1PnHYi6HBbzeb++VKI2FVS+dQBU6OmD1Wstgu2nSt3lmx2Hc1vIohBtL2M8fzkf2yleSZwLAydFEdDSV6ViNDZi4zU43HaA9QmOR89CWKOl3oXRyoJcxOOIcf5sN5r2o0OW+XrBs6lA4Wcj9UXc6Y9zx6sa2fFt1icuhYbbWbJ0pV9VJfiuITOcfkLoVIkxc2E9Uw+4cpPXkFE6InldtQwWLs25DqPaBdUKnVbmASrmAymbcfzIC44rzs2WPyQjWOixLIMaFDpmxgOnV5sLqr0v7wATwes4PCGhTLuPgs2CMMfdYXHr36sZkwHwwUyBmrtSePT+vuhyV4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39830400003)(366004)(376002)(396003)(136003)(38100700002)(2616005)(31686004)(66556008)(956004)(6486002)(66476007)(186003)(8676002)(36916002)(4326008)(478600001)(53546011)(8936002)(316002)(86362001)(16576012)(66946007)(36756003)(5660300002)(31696002)(83380400001)(2906002)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXExOVIvM0t3ekhQbE1BNmxVd0ZOOUdvYmdITkV3anIyR3RMQkxzTzhMa0Ex?=
 =?utf-8?B?TGhkVHFNUDhvMkxrQyt5endVWHhud1NpS0pLQ2tGU1VLMTRsS3ZaSVFzelJM?=
 =?utf-8?B?TDhmUzlIMkFCZjNMcDA2SHpBd1RiY0wrUS9ER1p0K3Q3VDNsR1NobGN5eGFh?=
 =?utf-8?B?QkcwdUpMTW9XWkIwRXhGVmp1SWM2SlJGUmxERkloY0FBT1hKUGg3Y2h6L0xh?=
 =?utf-8?B?Z0Q2WHNCdXV6aWVDcHcrWXBHNnM2TzVmemhxTk1pOWcxb01WYUNLRzNtRWFn?=
 =?utf-8?B?aGpCTmNiVWw3Yko1SGl4RFBOWnl3eFlYN1d4SHFPL3U3YklIcnY5S0RqdWRH?=
 =?utf-8?B?Q1dabDcvZ0NHdUx1Y0ZNWHZpK05LQ3N5cC9kRXBaeDUvZHRYdnhyWEE5SmxY?=
 =?utf-8?B?R3FYQVNOVVBPK2N1NjdwTTJUUVVqWG5ydUQwMlk5TFBObCtYRElNN21LN0V0?=
 =?utf-8?B?d2hpSm03QnlTRXltR2JpY2dvaXBzaW54L3lOMklTSGlKZkFFVDE2T1BlOXpq?=
 =?utf-8?B?bW1HR21HZS9WWlNVM2pPL2RyZEJGeFBuTXg2UUI2MVpTQ2FEOGNpTUpKcXFC?=
 =?utf-8?B?ek56WkQwY1h3YnhzRHVnVmRwR3g3YlUwcFQ3Z1R2QmlpV0c4ZUFXUGlDeW5G?=
 =?utf-8?B?eXNFWUtrbTA1R1BXWWxSTHRkM05SVCtQdmI3V0YwN2VZY25TZmp3cE96c3Yy?=
 =?utf-8?B?TmNGaEMyV2FiZkU0bWp5NTlyY1hFWmlUWTVTL29jaDNwbXIxRElWSSttYmJZ?=
 =?utf-8?B?VFRRZ3I5dkdzUTIyWUVFZ0FzeTZuRW9JSkJxUFR2RDd6bk0vS0lJc1F2SXBj?=
 =?utf-8?B?YjEvcjkrTE12S0pXSWpIMyttdlVlWTZUeWpCQ2gyYWMzNEF5bUZEU0xQdFhC?=
 =?utf-8?B?SkRtQzV3V0s5TmgxUGxmM2kySjRpRnNOdEp2eUtTbXZUMTh0T1JOdm5YSXl2?=
 =?utf-8?B?WDVYaE9IOXRhS1hSZmZkdkk5UVJ2Q2o2OFRqK3lWQWhyNldFVVZIN0M4cEpN?=
 =?utf-8?B?QW51NkFPMmtUUWdnMFhxL1NLWUVNYTR6c29LaW5vWmZ1Tk1ud2JCd1p6dVdq?=
 =?utf-8?B?dzMxaDh2dFRNaXRnUGFwd0NMNThyWm5qZ20wdWNYR211T1NMS1FVWUgvTWkw?=
 =?utf-8?B?ZUFmZG5vbVZlMlMrOXMrd2htL3RsMnVVdTBqMzJMZCtDZVhYTG5ka1hUTWNO?=
 =?utf-8?B?YXBtMzVhM3pSM1ZpcWVXWHR4Nm14K08wcThXYXplQ2wrcWFIZExDeDJKQ0VI?=
 =?utf-8?B?czhmdlZlanB4VFFXS3E4cFhXRzBsU1I5Uk8zNStMZDljMEVaSlJ6RFZuS0Vu?=
 =?utf-8?B?b2NaZTRBclBCNW9yeVB1REtjOUlxejh1eTV6Q0t3b0dqRkpzNDRUV0pIcTI2?=
 =?utf-8?B?VWV6a21Fc2wvZmdzRWFuc0JQNi8xcEN6ZzZVTWhDTzRYOTRBejhJa0Y4Q291?=
 =?utf-8?B?YndvcXN1OXJSaGtzOEpMZFNsbnBaVSt4UlozVXJxY1hjazdLQ1d4a3lvdGRP?=
 =?utf-8?B?ZDlhWStOZlFRTzA5eUpFaWI4RWpwc3Y3L2lGanM2cWVhZHNHNnBJYWI5QnJH?=
 =?utf-8?B?UDNFMVhkZDUzcUR1RXFtTTB1eGlndzdqUW9rUXB5bUFNOENzczc0M09BL1Z2?=
 =?utf-8?B?MGk3T1R5c25qbFdLRmQ2OGNEVTh3NXQwWDZEOVlwaGM5UUFvcWFEaW9EbFY5?=
 =?utf-8?B?SjZHVnN5Y1RSRjY3TUJ5Mkpaby9EYStnWlpnQWYrSkxIdVpyd3ZBeTRlV2hM?=
 =?utf-8?Q?++8+gI1lnJi8TUBaUtDp29LxOWL9ZlLN5B1bryu?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: f5743b47-2743-4d3d-38f5-08d9519bf6cc
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2021 07:47:35.2785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wP/xRvPcZ6NdoYq3W6Nkl7eBZZCj/1mt88C6O/rHDkfdmQ2Lb9dAJlM1/LlLIvMk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR02MB4106
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 2021-07-28 02:07, Liam Beguin wrote:
> On Fri Jul 23, 2021 at 5:17 PM EDT, Peter Rosin wrote:
>> On 2021-07-21 05:06, Liam Beguin wrote:
>>> From: Liam Beguin <lvb@xiphos.com>
>>>
>>> Reduce the risk of integer overflow by doing the scale calculation with
>>> 64bit integers and looking for a Greatest Common Divider for both parts
>>> of the fractional value when required.
>>>
>>> Signed-off-by: Liam Beguin <lvb@xiphos.com>
>>> ---
>>>  drivers/iio/afe/iio-rescale.c | 15 ++++++++++++---
>>>  1 file changed, 12 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
>>> index 6f6a711ae3ae..35fa3b4e53e0 100644
>>> --- a/drivers/iio/afe/iio-rescale.c
>>> +++ b/drivers/iio/afe/iio-rescale.c
>>> @@ -21,12 +21,21 @@
>>>  int rescale_process_scale(struct rescale *rescale, int scale_type,
>>>  			  int *val, int *val2)
>>>  {
>>> -	unsigned long long tmp;
>>> +	s64 tmp, tmp2;
>>> +	u32 factor;
>>>  
>>>  	switch (scale_type) {
>>>  	case IIO_VAL_FRACTIONAL:
>>> -		*val *= rescale->numerator;
>>> -		*val2 *= rescale->denominator;
>>> +		if (check_mul_overflow(*val, rescale->numerator, (s32 *)&tmp) ||
>>> +		    check_mul_overflow(*val2, rescale->denominator, (s32 *)&tmp2)) {
>>> +			tmp = (s64)*val * rescale->numerator;
>>> +			tmp2 = (s64)*val2 * rescale->denominator;
>>> +			factor = gcd(tmp, tmp2);
> 
> Hi Peter,
> 
>>
>> Hi!
>>
>> Reiterating that gcd() only works for unsigned operands, so this is
>> broken for
>> negative values.
> 
> Apologies, I didn't mean to make it seem like I ignored your comments. I
> should've added a note. After you pointed out that gcd() only works for
> unsigned elements, I added test cases for negative values, and all tests
> passed. I'll look into it more.

Maybe I've misread the code and gcd is in fact working for negative
numbers? However, I imagine it might be arch specific, so testing on
a single arch feels insufficient and deeper analysis is required.

However, looking at lib/math/gcd.c it certainly still looks like
negative values will work very poorly, and there is no macro magic
in include/linux/gcd.h to handle it by wrapping the core C routine.

> rescale_voltage_divider_props() seems to also use gcd() with signed
> integers.

The type of the operands may be s32, but if you look at how those values
are populated, and with what they are populated, I think you will find that
only positive scale factors are sensible for a voltage divider. Using
resistors with so high resistance that s32 is not enough is simply not
supported.

Cheers,
Peter

> Thanks,
> Liam
> 
>>
>> Cheers,
>> Peter
>>
>>> +			tmp = div_s64(tmp, factor);
>>> +			tmp2 = div_s64(tmp2, factor);
>>> +		}
>>> +		*val = tmp;
>>> +		*val2 = tmp2;
>>>  		return scale_type;
>>>  	case IIO_VAL_INT:
>>>  		*val *= rescale->numerator;
>>>
> 
