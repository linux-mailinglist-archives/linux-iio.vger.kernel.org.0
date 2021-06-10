Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93AA83A3504
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jun 2021 22:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbhFJUoO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Jun 2021 16:44:14 -0400
Received: from mail-eopbgr40117.outbound.protection.outlook.com ([40.107.4.117]:25918
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230353AbhFJUoN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 10 Jun 2021 16:44:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oSwgvWWFzzKWbsS5/OvIe9+wafKJv5OuF9yq2/xLGeFBKpYtgl/TvqZpcqDQ6/M2pWtjE30y76p8gmaRxFo9abOkQs1TNgf1gDrsYh6h5/bOz/1oVNcJurheVhzSuSreGE5sDf1y/9+y1XwX8kUc2NQ6t3ikWyRawmh8H156oyYLERWX54PA+DkwSeilY58EsFHFs79w+KOd1d8r9qKxftLjQ2gcdqpeAxwcUWolyYeCU9V6gS4yC8BNDUog6ORY+20Qh025fBDr64N3sfHHGTrnAuDVHCXd0FmIiz+HhtrAxggrnawKX7VSHPMz86F9XroL+B5hq+k3Bk0+WL4X4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z5vSUTGPfhaep9EpuM5TaExfLoWaZPLuxUtP1m6nBgY=;
 b=Vwkda68rXzvQRlg9yZEV9QdiUVI9DOfk7dnOswYWbtG6vW7X+ssp1tkj/zcyy7ysVokgapPMM8WnvpbNARWtDOZrU9IAALv0S7PZkmdNBhkJncf44BRupaG8zvldjSg5XVBF5b+/9maU4fTJ4Fv8aS3kvXOiGmFXrX6SjLMiDAFRCSf4mywyvaAVMxCSb557nxcyg8//2F1V+7+5AY/xxesQi7G8Gn5kg0OKtqkE1oqh3ghCB2MlpthuS+TT/oKaNPAIgbsnflsvuxV5LaRRouBkGtTJ+1mreuKiOugnNlS5yzvDLzNZZCuxEaFxPup9jSy7dwAjQDxCFXqYjU+Jhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z5vSUTGPfhaep9EpuM5TaExfLoWaZPLuxUtP1m6nBgY=;
 b=DytHbxhX0DBiummk7oqPUj4M97XUnLUv45PD154K4TgQhfPYf1M46mz/PmmtJRY82YZ9ecWymTMvBHquQH/Jo6NL8hhw9nm+t2xMoO3o1wdctM/EIHIJR/Y1Du5dRZtihUv+qHIL87WQwQOLsXBk7rHwV+I3pH1FGBH8iyAFzlk=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DBAPR02MB6261.eurprd02.prod.outlook.com (2603:10a6:10:193::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Thu, 10 Jun
 2021 20:42:14 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::d47d:ca8c:4fe6:3908]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::d47d:ca8c:4fe6:3908%3]) with mapi id 15.20.4219.022; Thu, 10 Jun 2021
 20:42:14 +0000
Subject: Re: [PATCH v2 3/8] iio: inkern: error out on unsupported offset type
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Liam Beguin <liambeguin@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org
References: <20210607144718.1724413-1-liambeguin@gmail.com>
 <20210607144718.1724413-4-liambeguin@gmail.com>
 <20210609212850.008d7f84@jic23-huawei> <CBZEWQ0YIIEC.3A2WESVVMHPJM@shaak>
 <20210610100655.000010ff@Huawei.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <4f8352d0-09a8-8c93-fd05-ad7b50f3cb52@axentia.se>
Date:   Thu, 10 Jun 2021 22:42:11 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
In-Reply-To: <20210610100655.000010ff@Huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: sv-SE
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.229.94.233]
X-ClientProxiedBy: AM6PR04CA0011.eurprd04.prod.outlook.com
 (2603:10a6:20b:92::24) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.13.3] (85.229.94.233) by AM6PR04CA0011.eurprd04.prod.outlook.com (2603:10a6:20b:92::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend Transport; Thu, 10 Jun 2021 20:42:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9bd718c1-2458-4ba9-19a6-08d92c503a9f
X-MS-TrafficTypeDiagnostic: DBAPR02MB6261:
X-Microsoft-Antispam-PRVS: <DBAPR02MB6261D13B321786774C7EF748BC359@DBAPR02MB6261.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XidCtPDBcaCSTn8HnXbsjufyAGt2tU/UAVzuJA1PXRTNfcoz4N6VrLNeN3zTtph+bY4oAVGfaG1siAj6fmW1eLXkMnlTEAWnQsZA3JJjDTOcRcq4cGmlZrq7Ku7QllaqqutgduM1g8dED9iEEhvTCqI5iNA0EMa4Xc3i/kcr29LlGis9B17O8AEl+0SmlYFekDApw2XhFapScWkZKHD3g/Nm4L8SKJpArNU9bGfYq/0HBKSCjWnx323VuUeb24hVQS1rTvbwzUanA9X3mPr/eL7KTRl6HlipVXL+CGUscFRkfquCRxVXl6cuet7Op2fnOQ/UY00xtmq+xpvGo/Cy8qs+7zaXOvV++Fce8JWlpyfJ9C6S3h6ubeDGkXHcDCeSbkctL+vWEBd/57cpa4iHHMd6pLJH7szPuNbxcGFetModBkZarTGmYDHUvgRISmfYG7aNd2+PvOU5RH6SZHPzhsksqhQBL1D8EgxxkTc2WVl3xJT9baxQCNVsbfkppb5IN3kXFfYasGuMiYv19XIIaVKrrsp+NSmj6zECmfP/y/bg7gXzs7ZZknSLrn5gWfntNXRoZ3rDHg0e4fUJ/TJKrg9jglkCTHZZ9cmsJjAjfqJN9AnB8rNhbR3N9YfkaMmjGCknCB1qONiu57+KpPRjlBpLJ3XD/rGC/8ZNEdytxnEmCQkT4tlfb3Z6qX+sfOOJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(39830400003)(346002)(366004)(376002)(110136005)(26005)(5660300002)(186003)(16526019)(956004)(8676002)(31696002)(36916002)(53546011)(8936002)(16576012)(31686004)(86362001)(6486002)(4326008)(478600001)(66556008)(83380400001)(316002)(38100700002)(2616005)(66476007)(2906002)(66946007)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzdsQ0RmMXlhQzVVcVk2T2tBdUQ5c3B5UWtiM0xqZFJrRmJPMGoyc1BDajRa?=
 =?utf-8?B?a09yM3dybm9PS09qa0FSbGM3R01rcXc3MVhNaWtCVDUrT2VzWWVXd09EdHUw?=
 =?utf-8?B?aHpNT3g4Z2I0NXhReVpCcytCaW16QkloRXRUVy9wclo3WkszbUlOeHpFZnpR?=
 =?utf-8?B?R3dCQjJkdWtKbUVRbzJpL1RYNlRlazk1OUNRbkJvTGd1SGlpSWc2SVJ4a0tz?=
 =?utf-8?B?dkxlZFBFRDlzSVZCT2NkL3dkMUg5NUdBdStaMnZUSkFXMUU5YWh1bE5zbFhI?=
 =?utf-8?B?NlZsMUJrSTBjTldCU0cwcmVUOHAyN3dQWWRTejZNOWl6dWVGZWhtVDBydjBx?=
 =?utf-8?B?d3lZaVdQMUdSZEZMYnNycW16WFdSTXdhR3JMZWpGdG9SZTVCMlIyOU52U0Nx?=
 =?utf-8?B?dk9MMWQxVkkrK2pha3dWY3ZWSGZxS0RiM2tneDJWbTN0c3JMU2lkSnZZZVFS?=
 =?utf-8?B?Nk9KTWRMa1p4N0M3Z0svWlJSeGo1WEhWdmVjeU5LOC90bnRsd04vUWlIa0pi?=
 =?utf-8?B?MjNscmNNTmtZOTBrYXRVNzFFcy9hOTZqaGZBbjBJc3lTM3ZEeWJDZHNzNTM2?=
 =?utf-8?B?cVpKdTcySlZhZ005SEdTSVlRRjNJcTFHV3dpQlN0VlJVbTZpZ2Q5RFJuZk5F?=
 =?utf-8?B?cWozWUtMNHJCdHZ2TDNuQ2dmZFVLTVE1aGVzdWlydHBuOGZmeVo4L1RqQkYr?=
 =?utf-8?B?amdvSUhMSENKY0JhMkNEZmViTWd1Mjc2dFBWaFR3QlF2ejFDaWlUeWxaZW1K?=
 =?utf-8?B?aVYwRFpPejV2MHFtZzhEdVBZMWFiUU42elRIdXg2SXQ4UTdPR1hTRW83aFRu?=
 =?utf-8?B?WlpWd3pmV2hiQVRRNnVldlkycXBGQkNYeHRhaVNianRxQ0RkeUdnTDg0eUVR?=
 =?utf-8?B?NU8waVFXdDNZcWFDVy9qWGRTRmNQYXN1QWNnMTI3b3BGMThJOXgwVldLUjg5?=
 =?utf-8?B?bFZkL0FDdW1yLzh3RGxDNzNkS0lvZ1dmK1E5TklKd05QS2IzNHRJYks2Uy9P?=
 =?utf-8?B?b0pHRUExSlNZYzZvcDlJZkExRXVVMVpIK2dsWVdyQ3U1VE8yNzhwTEJnYTJh?=
 =?utf-8?B?MHBIcmI2WHhJTGJvQjFOUFBuMURPdkhuaGQ5c1FOSkp3VEF4M0dvQVBsYlc2?=
 =?utf-8?B?Y28reWxmWmNqWndvSkdWVmxBTXNvUXJOR1l4V21xdmJTN0NuMjlIYmtwMmpC?=
 =?utf-8?B?TzlMVDYxY1ExVG1RZmRkWHFIMXpCMzU4VEFEQ1ZIVW1CeUdHL1VCS3ZMcjh0?=
 =?utf-8?B?SmNjQUdOM0JKWjZRR3pvazVTaHhUK1E1NjZrYWs3Nzl6b09TYW8zRGhiSEN1?=
 =?utf-8?B?UDZGNUladXZVK3F6MlQ2d1NDdWRNc29qVUFDYi94czZNTHYvQytobjVMSzZS?=
 =?utf-8?B?SlRFTXA0amRKY2lHYVJVVEt2bVpueDQ4aXpzYU5LdStLRXIrNlZrQThta3ls?=
 =?utf-8?B?aGIxV05JUWNyZ1NqRTdVRGp0SkhuZVlJR1dmQ0F0aGNRaG16WERJUmk3anRv?=
 =?utf-8?B?ZExiK29VWHFDUHFUeUNQRmFSWHZLTHY3dXJKUGl1cHdPS2xEeTB6YnlaQnAy?=
 =?utf-8?B?VWRaeHpyRU53UnVpaWVZVWs0azhBSzNhM3BVZHNMYzJZd0xiM1VaVXdJSExK?=
 =?utf-8?B?cytXQW5PVWFkcmxaUEtyVUQ2aStlYjhWOHR0TGRjcGNmUVdiTzJvanl1eTJj?=
 =?utf-8?B?WU5rSHB3ZGZCY3VuWDhhVkk4bDNWMCtaUmJNZlZpc1BjWDhmVzBrMWFmSWxS?=
 =?utf-8?Q?O2uK+rh7phXdMBbeMKxfQjTgzkbjVfMVbH38gUx?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bd718c1-2458-4ba9-19a6-08d92c503a9f
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2021 20:42:14.3766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c43PV54HSAni9MJ1zaAp8W6+q9xVr2nvxrpKe0oWoCFVJkyCOgoWW8T7GAjhVNlk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR02MB6261
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi!

On 2021-06-10 11:06, Jonathan Cameron wrote:
> On Wed, 09 Jun 2021 17:40:47 -0400
> "Liam Beguin" <liambeguin@gmail.com> wrote:
> 
>> Hi Jonathan,
>>
>> On Wed Jun 9, 2021 at 4:28 PM EDT, Jonathan Cameron wrote:
>>> On Mon, 7 Jun 2021 10:47:13 -0400
>>> Liam Beguin <liambeguin@gmail.com> wrote:
>>>  
>>>> From: Liam Beguin <lvb@xiphos.com>
>>>>
>>>> iio_convert_raw_to_processed_unlocked() assumes the offset is an
>>>> integer.
>>>> Make that clear to the consumer by returning an error on unsupported
>>>> offset types without breaking valid implicit truncations.
>>>>
>>>> Signed-off-by: Liam Beguin <lvb@xiphos.com>
>>>> ---
>>>>  drivers/iio/inkern.c | 34 +++++++++++++++++++++++++++++-----
>>>>  1 file changed, 29 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
>>>> index b69027690ed5..0b5667f22b1d 100644
>>>> --- a/drivers/iio/inkern.c
>>>> +++ b/drivers/iio/inkern.c
>>>> @@ -578,13 +578,37 @@ EXPORT_SYMBOL_GPL(iio_read_channel_average_raw);
>>>>  static int iio_convert_raw_to_processed_unlocked(struct iio_channel *chan,
>>>>  	int raw, int *processed, unsigned int scale)
>>>>  {
>>>> -	int scale_type, scale_val, scale_val2, offset;
>>>> +	int scale_type, scale_val, scale_val2;
>>>> +	int offset_type, offset_val, offset_val2;
>>>>  	s64 raw64 = raw;
>>>> -	int ret;
>>>>  
>>>> -	ret = iio_channel_read(chan, &offset, NULL, IIO_CHAN_INFO_OFFSET);
>>>> -	if (ret >= 0)
>>>> -		raw64 += offset;
>>>> +	offset_type = iio_channel_read(chan, &offset_val, &offset_val2,
>>>> +				       IIO_CHAN_INFO_OFFSET);
>>>> +	if (offset_type >= 0) {
>>>> +		switch (offset_type) {
>>>> +		case IIO_VAL_INT:
>>>> +			break;
>>>> +		case IIO_VAL_INT_PLUS_MICRO:
>>>> +			if (offset_val2 > 1000)  
>>>
>>> What's the logic behind this one? > 1000000
>>> would be an interesting corner case, though I'm not sure we've ever
>>> explicitly disallowed it before.
>>>
>>> Why are we at 1000th of that for the check?
>>>  
>>
>> For these the idea was to go with one milli of precision.
>> I don't know if that's a good criteria but I wanted to start with
>> something. Do you have any suggestions?
>>
>>>> +				return -EINVAL;
>>>> +			break;
>>>> +		case IIO_VAL_INT_PLUS_NANO:
>>>> +			if (offset_val2 > 1000000)  
>>>
>>> Similar this is a bit odd.
>>>  
>>>> +				return -EINVAL;
>>>> +		case IIO_VAL_FRACTIONAL:
>>>> +			if (offset_val2 != 1)
>>>> +				return -EINVAL;  
>>>
>>> We could be more flexible on this, but I don't recall any
>>> channels using this so far.
>>>  
>>>> +			break;
>>>> +		case IIO_VAL_FRACTIONAL_LOG2:
>>>> +			if (offset_val2)
>>>> +				return -EINVAL;  
>>>
>>> Same in this case.
>>>  
>>
>> For these two cases, I went with what Peter suggested in the previous
>> version, to not break on valid implicit truncations.
>>
>> What would be a good precision criteria for all offset types?
> 
> @Peter, what were your thoughts on this.
> 
> I was thinking we'd just not worry about how much truncation was happening
> and just silently eat it.

For the "integer-plus" formats, that was my thinking too. Previously that
was exactly what was happeneing, and v1 randomly broke any user that relied
on 42.424242 being truncated to 42. This is still the case with this v2, as
v2 is allowing only a very slim set of truncations. I meant that this new
code needs to allow all truncations, just as before. Anything short of that
must have a much better description of why it is safe to all of a sudden
disallow truncation. I.e. such a change needs to come with traces of an
audit of how this function is used, and why changing the semantics will not
cause regressions.

For IIO_VAL_FRACTIONAL and IIO_VAL_FRACTIONAL_LOG2, it seems correct to
error out if the denominator isn't 1, because relying on using an offset of
e.g. 187 for a IIO_VAL_FRACTIONAL of 187/169 is not at all healthy.

Both erroring out and doing a best effort calculation for these fractional
cases with denominator != 1 would be ok by me, because they are plain and
simple severly broken at the moment.

Cheers,
Peter

> J
>>
>>>> +			break;
>>>> +		default:
>>>> +			return -EINVAL;
>>>> +		}
>>>> +
>>>> +		raw64 += offset_val;
>>>> +	}
>>>>  
>>>>  	scale_type = iio_channel_read(chan, &scale_val, &scale_val2,
>>>>  					IIO_CHAN_INFO_SCALE);  
>>
>> Thanks for looking at this,
>> Liam
> 
