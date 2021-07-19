Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15F423CCF8D
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jul 2021 11:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235373AbhGSISF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 19 Jul 2021 04:18:05 -0400
Received: from mail-db8eur05on2105.outbound.protection.outlook.com ([40.107.20.105]:61760
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235366AbhGSISF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 19 Jul 2021 04:18:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kAkCbaBiY3EX3tK0EhkTNtJXHX/97fWv7xsCwUGfaltqDoPH//yWXolapny/ASQYDPDdGWuEwPAPNuROyu4KSeaT5C6Xg83GvpeFhEMrP6+ug0lawRbHb0q0M/In8Q4uJqaq0wtILjarH3x0RGE9tCWmjy+se5GSyrqyV+I13Ub23g0MB25SPrCeGsj/vJ7hoKNiNGLOUQe4NnP1kLS9aJrb5k0HsIGg76i2yb8b+f7k3bi42hsj2FlDvR6l+bLqARE7uIf7c9zckwNRu2DWFkSbO54kpCGoioDUyQ+m2F/vSn3ip6UcIGhUSneebGYbOgcdWbO9eEfmAioQ1RHt+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Yt6S9Z0fftJlKBEZPmZV8O1h5tSE2Nyx57YAvrucnU=;
 b=EbhZjrUSw+UBPIQuLknsCS6lJwMXGdd3ouh9P+xKlXREWpA8qtcITnOyQvGG1jnzXBJPLpBb+IBoQmnDQfdlOCT03KDVzZy5uT6HrUTxltKyZOTb0tUQvkcfHuPGMCS2fXANtaODF3CTTmlqubkrCx2XorbE5epCBAj/8LzBcYbMdbZDvDUBbJMrNEGuiQ15gNlqQbWoz5clid4bZ/IRTfO44X1JDuxji/iKvZK81aOc4GpFqVbV451oXbMVyNO+cIwId3FRRRc5r40UfP2NZUkm8/HSh0ChIIkaltqAKI887xHNkBUWbO6yHVdlBO3HqGTkPC+dO4SEMeQSt/Fcfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Yt6S9Z0fftJlKBEZPmZV8O1h5tSE2Nyx57YAvrucnU=;
 b=j+3G9ux4+keVw0TT02pPI5N50WTWl0fKg//ZV1wiD3P85IbWNBrR37HiBBSzvO6a1Udq+O7zcGJD9QbA0hroiYwEtGv2HSc6C4S79BzvQApaVTLCKnpAvP1ohtoXyh3JDeWwC80ZXmX0fPhe+rFXgXH7BlJTiBntqC1C0ODf6Lc=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB7PR02MB5244.eurprd02.prod.outlook.com (2603:10a6:10:34::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.26; Mon, 19 Jul
 2021 08:31:06 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::14ca:a41:2218:3578]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::14ca:a41:2218:3578%6]) with mapi id 15.20.4331.032; Mon, 19 Jul 2021
 08:31:05 +0000
Subject: Re: [PATCH v5 05/10] iio: afe: rescale: add INT_PLUS_{MICRO,NANO}
 support
To:     Liam Beguin <liambeguin@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     lars@metafoo.de, pmeerw@pmeerw.net, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org
References: <20210715031215.1534938-1-liambeguin@gmail.com>
 <20210715031215.1534938-6-liambeguin@gmail.com>
 <8417f698-eef2-3311-625a-1ceb17d3e5b2@axentia.se>
 <CCUT1ZDDWS1J.3CGKX5J1MNFOX@shaak> <20210717175551.20265ac4@jic23-huawei>
 <CCWNYFYK095U.B3ZVEH0JYVLA@shaak>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <e6358b95-aaa8-dd66-079e-8ddec547c5a2@axentia.se>
Date:   Mon, 19 Jul 2021 10:31:03 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <CCWNYFYK095U.B3ZVEH0JYVLA@shaak>
Content-Type: text/plain; charset=utf-8
Content-Language: sv-SE
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR0901CA0044.eurprd09.prod.outlook.com
 (2603:10a6:3:45::12) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.13.3] (85.229.94.233) by HE1PR0901CA0044.eurprd09.prod.outlook.com (2603:10a6:3:45::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Mon, 19 Jul 2021 08:31:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b0d47931-9aeb-4ae3-6a52-08d94a8f8cef
X-MS-TrafficTypeDiagnostic: DB7PR02MB5244:
X-Microsoft-Antispam-PRVS: <DB7PR02MB5244148C832F39B61A0651FBBCE19@DB7PR02MB5244.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KVRjIOzefAPSZEmDa1SEwaCEyeADEJVJsDk7QJrdtLkolwILoXSXnXGPhC4x/HN/SC7DyEN/9/Zlm/u7rvRu0l7DnhUaJEC21F/Ul8zP/ZoKzkDgJ83ESMvrwsBcy7kihxzWRg42eCTuuaqp7OKQ51kDV9y55DkskFGMgFv8VbMOFVc6zrdBcAqbnvNftW5KRUoxzZxu13xChNTlNUa0FOpgFnkr+3Pi0ZislpgVw0YuR2NldyqbTbXO7aWBmSdGWzbza2C79KYzBuWHrILt5OrRiqNNxW83MPtlUU0ieLN3Spymu86bkGqi8mQRaPcqYX8/vNUci6c8+r9XQgIW8UuLQRQ1mzRWbKjhhtXYWh8KkdZy7C5dYZ3rE7VF8+8fmNTTmBGqUzeZbf7tzOC7Zm+Mzk8o6uvGg8FJ618TbFSRA8P/DFS6WItXxGxs5KTkcrxUy7lw/ZQeZTFDe8sVpS7byEuCSF2gXihjCS/fJ4DgjoMOnN3V4f3Zd8eBti5N8dNjn5hmhImIgeSto5Kslx5+ll4l3bZ2jjhTpc7ft7FDXuyChhT50l4oSam73NmxbDFcS7wiRpoFn95UoCw6/S643pOwZEVXOqtXdxm+/0/+gA3KLdidCyw+Kh1ATDtVOxt/8c5m30tf4pADV70YVdZJoPGpZuI0AC4aaDrvZfldR/+Qyo64XERvafntIe2rOAOrd22gJNgoZFyOGEwo+M+MpGnXsLkYRxaZuo7CQok=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39830400003)(366004)(376002)(346002)(396003)(66946007)(66556008)(26005)(36756003)(31686004)(2616005)(36916002)(956004)(478600001)(53546011)(2906002)(6486002)(86362001)(66476007)(110136005)(5660300002)(16576012)(8676002)(4326008)(316002)(8936002)(31696002)(186003)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjVORzVDUy94RUFPOERvZnROYktyUEcwSEVZUnpSV09pOGV6b0dRSW5sZ2NX?=
 =?utf-8?B?Z0tJRWlXWGUvanFNSTgybnF1RnZocE1xL0VQOXNaaGgrai91cEJSZ29Ta20v?=
 =?utf-8?B?bkY3VzU5QVoxQ00vMzNVQW1pRkIrRjdFNTJHRFV2TWJtalZ4VDU2d2RoMis5?=
 =?utf-8?B?RGlpY2FoS2ZmNWQxbk5kMlFyS2tzQkhDYVZTYlNWK0dMOG8yRTJUMG1Ddkkw?=
 =?utf-8?B?RFJEcmt0ZG5OcW91RkNkYUw2dHk2QXRqWTh3TDFtdHIzT2hKSmpzSWxFbWFu?=
 =?utf-8?B?eExoVXZDSUZnRlh0K01sVmVPOU56bFVJWWVVa2pESHNnYWhDK09CU09YWHh0?=
 =?utf-8?B?N1paUU5uQXF1d1RaUUJCQjd3a250ZjhQK0N5UnE3eW9YekZCVFV5TEJJdlJY?=
 =?utf-8?B?ZmpodUtVVlpXUXV6M0VyZEdoZkZaNXN1N3RwVFN4MWlFZnQyZmdCK3JsSFJY?=
 =?utf-8?B?YVg5TDhKQkVlRWRhYUVaUnZtR3lrbWUzd1cxUkxSUHpzOXd6eENPSDUxbmxn?=
 =?utf-8?B?cWhqd3QreVZaVmF1NWFqem5UcGVMdVhqQTMvWW4xRXlMTTJWRkVudHRQNVRZ?=
 =?utf-8?B?cmJReFI4UjRNRkdSNGtQL1JvUjc0dE80TU5TS3JjYnA0Q1ZueXBzR1ltSEJp?=
 =?utf-8?B?SEd6cUNYMlpOc0hPSjZYaEZZa0s1VmptS2pvdGI5OWMwQjRtblNjbjhCcDNJ?=
 =?utf-8?B?cVZndHVya2UrTy9VVitzTitIcEIyOUZKS2hsazdKVW5pbUI4eG1DQVp3TlNp?=
 =?utf-8?B?Tnl6RXZZN2owd0NtQXlHelU5eDR4dFozZEdZMVBIU1BmNDJNODFyN1JROHdY?=
 =?utf-8?B?WkxVUlF4UVpwcWtPYXhlNGUrbzRnYjhSVFQzTFNPc3ZnbjVyTDlPaXZnN2w4?=
 =?utf-8?B?ZFZnUTNuUldzRkdyVnFiZzlDUXZXdXI4VTZoVGxGUUZqdE9OMlVpeDJQL1R0?=
 =?utf-8?B?UDJmSXdDSTdMU25oNEc1MEIyekNRb21qMXJPVDF1Yk0wM2M1aHZGWkdjNDVH?=
 =?utf-8?B?WmNrN2crVzZzOGcxcU5adzhla2hpa2wrMC9IaUlVVWY3VFlkVFhJekpPditC?=
 =?utf-8?B?Ri9OS2oycnhxdkVKaFc3ampRano1TTYvOVVPYy9xMU1lL29oU1pUeDBxOWFM?=
 =?utf-8?B?TEd1L1JtVGJ4bzFYdFBhZHNOZC9odXBzYS9DblRkODRDS3hDOEp5ZCtrSjh1?=
 =?utf-8?B?N2FWd2xXbFVWdkpHODVQaWYzMlBUREdiSW1iNGl1RnEwRElYeWRFSHcwQXFW?=
 =?utf-8?B?UG1yRE5xNTlNeXF3Uis1UlZGbjdMZzdEY2R0RVgrUnhSZHZLbEczNzVUQUZo?=
 =?utf-8?B?WlFqNk1GSlJ5YUxBRjRoaVhSa3FlNlJyOEVYKzVxUWpKVDRDTUcvSm45cUtI?=
 =?utf-8?B?amo5TDF2blY3RU1QN2Jmb0xZL1gvdTNqYi9xTHkyTzZkSlIzRGJHaWZ1cnc0?=
 =?utf-8?B?aVpWYlM1TGF0UFJZaTg0cTZLbk5YN3A1d20wdCtMRnRqajNHcHBBZTdrR3FN?=
 =?utf-8?B?NUFGTGJHRGxRZnFsWFlzNDllMGt6RFRCS1VSS0hjVzFnL2tsdjRGNms0WGcx?=
 =?utf-8?B?QzRCQ0pxWloydFBEMEhsaVArOEFhZVJSUEhQUld2K1lwdVRLeXVnSWRzMlJz?=
 =?utf-8?B?eHUxWlRpbmljMzZJU3J2MTBQVGhyd3VscnBuTFhGUVg4eEdqaGR5bitGVC95?=
 =?utf-8?B?bm5Ga1MrNG1yM2FtOEgxUmRBMlVPVEc0akoycml1L09qcGljdlFjZTN6MVJD?=
 =?utf-8?Q?1eSMqnQgLtGDNugLw/priZVHvuCo0jFRrBrsCI1?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: b0d47931-9aeb-4ae3-6a52-08d94a8f8cef
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2021 08:31:05.7563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PXxs+UQ4LNgTucW32Z6QO0EznyCvoQYqV93l8sgVmn+B/VrjYkeliVCkD4SMkx5W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR02MB5244
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 2021-07-19 01:44, Liam Beguin wrote:
> On Sat Jul 17, 2021 at 12:55 PM EDT, Jonathan Cameron wrote:
>> On Fri, 16 Jul 2021 15:18:33 -0400
>> "Liam Beguin" <liambeguin@gmail.com> wrote:
>>
>>> On Thu Jul 15, 2021 at 5:48 AM EDT, Peter Rosin wrote:
>>>>
>>>> On 2021-07-15 05:12, Liam Beguin wrote:  
>>>>> From: Liam Beguin <lvb@xiphos.com>
>>>>>
>>>>> Some ADCs use IIO_VAL_INT_PLUS_{NANO,MICRO} scale types.
>>>>> Add support for these to allow using the iio-rescaler with them.
>>>>>
>>>>> Signed-off-by: Liam Beguin <lvb@xiphos.com>
>>>>> ---
>>>>>  drivers/iio/afe/iio-rescale.c | 15 +++++++++++++++
>>>>>  1 file changed, 15 insertions(+)
>>>>>
>>>>> diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
>>>>> index 4c3cfd4d5181..a2b220b5ba86 100644
>>>>> --- a/drivers/iio/afe/iio-rescale.c
>>>>> +++ b/drivers/iio/afe/iio-rescale.c
>>>>> @@ -92,7 +92,22 @@ static int rescale_read_raw(struct iio_dev *indio_dev,
>>>>>  			do_div(tmp, 1000000000LL);
>>>>>  			*val = tmp;
>>>>>  			return ret;
>>>>> +		case IIO_VAL_INT_PLUS_NANO:
>>>>> +			tmp = ((s64)*val * 1000000000LL + *val2) * rescale->numerator;
>>>>> +			do_div(tmp, rescale->denominator);
>>>>> +
>>>>> +			*val = div_s64(tmp, 1000000000LL);
>>>>> +			*val2 = tmp - *val * 1000000000LL;
>>>>> +			return ret;  
>>>>
>>>> This is too simplistic and prone to overflow. We need something like
>>>> this
>>>> (untested)
>>>>
>>>> tmp = (s64)*val * rescale->numerator;
>>>> rem = do_div(tmp, rescale->denominator);
>>>> *val = tmp;
>>>> tmp = ((s64)rem * 1000000000LL + (s64)*val2) * rescale->numerator;
>>>> do_div(tmp, rescale->denominator);
>>>> *val2 = tmp;
>>>>
>>>> Still not very safe with numerator and denominator both "large", but
>>>> much
>>>> better. And then we need normalizing the fraction part after the above,
>>>> of
>>>> course.
>>>>  
>>>
>>> Understood, I'll test that.
>>>
>>>> And, of course, I'm not sure what *val == -1 and *val2 == 500000000
>>>> really
>>>> means. Is that -1.5 or -0.5? The above may very well need adjusting for
>>>> negative values...
>>>>  
>>>
>>> I would've assumed the correct answer is -1 + 500000000e-9 = -0.5
>>> but adding a test case to iio-test-format.c seems to return -1.5...
>>
> 
> Hi Jonathan,
> 
>> No. -1.5 is as intended, though the IIO_VAL_PLUS_MICRO is rather
>> confusing
>> naming :( We should perhaps add more documentation for that. Signs were
>> always a bit of a pain with this two integer scheme for fixed point.
>>
>> The intent is to have moderately readable look up tables with the
>> problem that
>> we don't have a signed 0 available. Meh, maybe this decision a long time
>> back wasn't a the right one, but it may be a pain to change now as too
>> many
>> drivers to check!
>>
>> 1, 0000000 == 1
>> 0, 5000000 == 0.5
>> 0, 0000000 == 0
>> 0, -5000000 == -0.5
>> -1, 5000000 == -1.5
>>
> 
> Understood, thanks for clearing that out.

I just realized that do_div assumes unsigned operands...

:-(

Cheers,
Peter
