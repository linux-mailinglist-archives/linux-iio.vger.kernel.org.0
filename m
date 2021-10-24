Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07BE3438ACE
	for <lists+linux-iio@lfdr.de>; Sun, 24 Oct 2021 18:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbhJXRBS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 24 Oct 2021 13:01:18 -0400
Received: from mail-eopbgr20092.outbound.protection.outlook.com ([40.107.2.92]:4160
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229755AbhJXRBR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 24 Oct 2021 13:01:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NwXi4RrA3BcEaqw9NobISEQr87gmY46V0uie0fOf4uW7irtOr9JgdOmpDwzgQjVHl+MJlTTyzfW5TGXY60sJ3+ixPNYJ9OLdGQYm9P9ZldBCD31WxTBOzkRQhYVyGez2L6ZuZUW4b+zyX1CXxXH0IkJsZIxOzY8g93WSIDe7ROGHDMoVoTMrUtGC8bS00wDpsgaEoriZ/n/kdlqD2zYWKPc0jf5dH2DArAM+VPzXfYfhpgUwhAMuT/oE4jJA6DnZ9GjyCDPxsQHr0z711ow8P61ssYhAVXBdQ2Rexi410YHFuiyye04Gc0dt3KeiRXrT1hAFK/dwwV7WmNGJA1lRgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ajyP5t0BodbQUOtFTyhc7GeH3XezqY82puybX1Kfd9I=;
 b=J1li4KLLEyr6p+FQRCJtaWKrZYORZvBhLWUXsz/pmvbHrGUNAgVDTFdBoEz96hzPB8L+XijruMMFrWmx0kGjxcodabb/2G5XbOW7jrB75HviEGSsXj94ce3xkHBYvRKcTCEppUFPT1B+kfhsl5wA1D9lMname/sRQM01CDjTHJolubzZ6n4ab5UE702P9hzu4BMdARi9jMWbQ9R1CA2ycGX94jRN4BbPld379FK5F75xttd9N8quoPoEVgHEbMtcc78c209HWxv5RVDqiudPzLFl3iZJgcfvdKmRRS3p+x+OBQqsppIfUTRULJli+QFmCp2egE1n0KWvIlF6o/qLRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ajyP5t0BodbQUOtFTyhc7GeH3XezqY82puybX1Kfd9I=;
 b=N54bNGpTJSpziB8He1qjBiYLgN9TSF0iqv3S28b1zXPB1tnLPNv4cy/Ng1p3SHPn2jeVb60n7F8btLpA0HSksO33PFI+z1yC6vCFjxC6NAKwEfu9xFFIl+MBK3QCbXJA3buQcwfGe52I5t+yt6lhg0M769wlaRezS7laqXExEK8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <20912d4e-8417-73d6-a42f-ceaada6e3cf3@opensynergy.com>
Date:   Sun, 24 Oct 2021 19:58:52 +0300
Subject: Re: [PATCH v7 1/2] iio: core: Introduce IIO_VAL_INT_64.
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     jbhayana@google.com, lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vasyl.Vavrychuk@opensynergy.com,
        andy.shevchenko@gmail.com
References: <20211024091627.28031-1-andriy.tryshnivskyy@opensynergy.com>
 <20211024091627.28031-2-andriy.tryshnivskyy@opensynergy.com>
 <20211024171015.3b6b46e5@jic23-huawei>
From:   Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>
In-Reply-To: <20211024171015.3b6b46e5@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR06CA0287.eurprd06.prod.outlook.com
 (2603:10a6:20b:45a::21) To AM6PR04MB6359.eurprd04.prod.outlook.com
 (2603:10a6:20b:fc::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2847dec4-c6de-4053-f4c5-08d9970f8fc2
X-MS-TrafficTypeDiagnostic: AM7PR04MB6950:
X-Microsoft-Antispam-PRVS: <AM7PR04MB6950EE33A116D5B929E31ECFE6829@AM7PR04MB6950.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AEkxlmFSxTWSETSZR9b7+xpJsdGWFee7xcn1AARgkRYz2j1yz1JgErD5Wbr5IDnRIz2DgNkWfXnNXL2XktfccR+4B8RkfiL0r0jMfMAy2wisJ4+p12eo3Y1fHzTSb12mmOwaa1OA+bUbWLwZZc3nroQXfrf0KvI88/LTZEJrE6EboCOeBRJx597iNli1G/mqUGe90Y7YVbPcdL1k9bhhqZhiCxs2qV5mMirHu3e+Ctlo6bccBkGixIFQ4HVormZ8KHr1kv9VYtf2XENvyqWk8ovdVW2gXz8gRScb6EIDVFpQdJfYeZ4aQH6N26c4ihYAhfrj2KcssLZLGoFURzn586GDsBEblu8FnKVgesTgRZ40X8I/qPKYFYhPMgvGG3rEVwDCzXn5tk2iU5q09r7GCjxWn9U3ZZwQHoYJ68WUD0IeE8Amz4DjjAfUzikCy1MsQ7FrYuSMUFEfHCWRrVgkIIyxyhvEMVgI7tnYBgS4o7w8rJwe7431VjA5+keO8onlorYL6aXSmcptazcvH2DAW/6dFJoTNXqrzDXpdrvKHw9FDj1YPrfl2Kqa/naShWVFBYDwoZSIWtJaKgDP21S0qLlNACOxhJtcrEKP6gpfTSGTUuPdK3UZBubJAgSKPNdlTInP98zyi9Il+yAloklrGw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6359.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(366004)(376002)(346002)(39830400003)(44832011)(86362001)(5660300002)(2616005)(508600001)(4326008)(55236004)(31686004)(53546011)(186003)(42186006)(316002)(26005)(2906002)(36756003)(66556008)(66476007)(38100700002)(66946007)(31696002)(8676002)(6916009)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2x0ZURGTzdJY3V4OHdwZVl1aUI5cW9rc3oxejIvVHU0cExMWGVHeS9LUDVN?=
 =?utf-8?B?ZGRrYk9QZmswc2gvUnBlSGRRZW83clhMeGhmeUNWd0tNVlNqU21qdWpJSUtI?=
 =?utf-8?B?OGlOSTNWVTRqK0hJYUJPcjJDWG5ocHpjN3RMZFFVR2VIVGJEYVBqZ25xcXh2?=
 =?utf-8?B?VUwvYlNva1RyK2l0TU4vOS82S0RNd3ozekltZjZzcDlIZEZBV3ZvcmJpOFVz?=
 =?utf-8?B?TUV3Nit0bm1DSzA0OVVBcE1UU3JpZzlMYjZvNUVtWWdoUUNQVFlKR0hxUjB6?=
 =?utf-8?B?OWZsNE5OMVAxRnFobnhOOHBINWlvdEtJVXVlM2pwQWlRS1lTMm9mYkl6bEtF?=
 =?utf-8?B?Q2tGWlZ2M3dHQVo2anAxbk1sQ3Y3RHJpZzkrK09HSXJ5S29xUjArNCtuWTdh?=
 =?utf-8?B?TGh6MGpzcU43MmkzVkw5TGxNUVlKTjZWR3RvTEFwbXhCZHFsK2JsQWkwUysv?=
 =?utf-8?B?SFYrcUFHeGlTL0psdndkbUl3bTBHUDJZTkxVcHFIa1hsK1k5RTZLVDNJQVk5?=
 =?utf-8?B?QnpqVlZsRVQ2SllnNFhlQ0g1TFdBcGRaY3BkcEUzTW9LNURhTGxUVXp5elJo?=
 =?utf-8?B?U1l5U1pYSDBJS1YyZCswaDYrU3Z1bE9KcXllcGt1bk1Ha0hZZ2pSazk5b3Yw?=
 =?utf-8?B?dGtublJKNklmWEtCMWFET2toZVgrNVlZeXBqZ2FIVGJGdlJlckxPaGwzdEZa?=
 =?utf-8?B?L0ZSWC9sTkNSQ2haTzVIR3VPM0NVRUxvaG9kUWt2alhubnBUMkZ2bjhXNkhx?=
 =?utf-8?B?akh2clA1REQxejlieDFXbnlnL1A5c0gwZy85Y1o1dnVPc2Q4MTNCUEcrTGlP?=
 =?utf-8?B?bFlvdnB0VjN0WWZ3M1c2TmVEZTh5VzlDNUNJck0yR1QvWS9kR3I2eldWdjlC?=
 =?utf-8?B?cEx4bG9iTTNkbndoUDA2K3laQm9ZdHZKWGxoZnc4Q3ltMW9HWGVkVG4rZURv?=
 =?utf-8?B?L0h6dVI4MmhHVUw5cURQUWtQRlZodHBSUFZJelQydXl4UittNUpGU2psVUVD?=
 =?utf-8?B?TWcxNG9EcWZuNGxYeHFWR2lXV21zOGtDSjNQN29mQVA3US83OUhEdytrOGNm?=
 =?utf-8?B?UHpCZHJuNEY2U2t0U0NZREtuRmM5a2pVSjZvcUdkWnpHdlZZWkR2L1locUtD?=
 =?utf-8?B?RUx5WU03SDRodW8zd0RWWEJoK3VsMlRZTC9jbXo1MSs4Ulp6OEpjTG4xM1dY?=
 =?utf-8?B?djVPb3RiNkhocDBydDBzMldhaWVreE1OMUY2TTh6YlJwZzg5SHdOaWdRckRa?=
 =?utf-8?B?eEdnZGpiVlBxaDVrbExKQkVRd1VOMzR1ZDFlZGdUNjBLeGpON0FWcDNPd0hi?=
 =?utf-8?B?MDJ5dnhqSmVyRitOMGE4R3dMN3RKUUY1TFFQZnQwZjlqdFFMV0FObEl0YldF?=
 =?utf-8?B?aHY2MG1hS2Q4M3JyOEl6a2IyamJsZjJQZkY3bDB1UDQ5empNZGNHMGZDVkJS?=
 =?utf-8?B?NGZRQnJvd1QzOTlkVm5FZHB1SDRjZGc5TjJ3dElFZTYzY3g3VktnNGpLNmlW?=
 =?utf-8?B?Tmd2YWt4c0xVVEJQcDZTMXdFdklYeFlKUGpWK0ltUHdyWGdzQldvNndNTFVl?=
 =?utf-8?B?WmtTNDV6OC80ZW9yL0V0MjJwVG1ndzZaYkFqdGNUZ3M4YWEzOHVSSUhDSWN2?=
 =?utf-8?B?ZndyN1VXNmZaemYyV0dhMktkQkphWm1RbUw0RURTeTVBcG9OT2RXTWNnLzgz?=
 =?utf-8?B?N3lRM08vdkx5U1JlanBad202dHNKdkFzS2U3M2d2dWdncmVjSjNGTm9sSzYx?=
 =?utf-8?B?WmRzWU5YakZLVlJRSk55OWh2di9Yam5aSWtFRVdMYnZFU2I2akRIRHh2c3Rv?=
 =?utf-8?B?NVA0cW5rMmFtQ1RML09kc1I3TlgxTzZjbXVjNkN2MzFzVGk4UVpQTitVcGs3?=
 =?utf-8?B?cUpFZ0I1YTZoTnF4NlM1dWQ5ZEpZVXNvR2p5MlBEbTdzaDRGOFR1elU0cmFu?=
 =?utf-8?B?S0xEV1NacCtlVHJhTFpiK3ZMTFpCamNKMktTTGNBWnNEd3F6UFRSM1JMaHAz?=
 =?utf-8?B?Y1UrUFFoU0lNM3pmRitRUm9BaTYrNVcveEQ3QmEwNGEzQWVFaDVEeElpcGpB?=
 =?utf-8?B?WU9pQ1FpSEhKcjcxL0FsMnkrN2RvalNvTEVkYXpXc2JFY0hMVGo3Rm5SbTdY?=
 =?utf-8?B?ek9FcDRMZncxandieTN3eVc3LzJqbGxrdjRod3NURUdWZjBSbkxVWjc2Um5r?=
 =?utf-8?Q?OYf4KE8ZzJTXEq33ItxTucM=3D?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2847dec4-c6de-4053-f4c5-08d9970f8fc2
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6359.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2021 16:58:54.2997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zmRHKGEHf+hFDWB0Y+wQd6euJ3vi14N3YzbhriXO98pZP5BeKO7taZD1wKYmhRuDHGmYU0GF5rPlR0ZqrijzAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6950
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 24.10.21 19:10, Jonathan Cameron wrote:

> CAUTION: This email originated from outside of the organization.
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
>
> On Sun, 24 Oct 2021 12:16:26 +0300
> Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com> wrote:
>
>> Introduce IIO_VAL_INT_64 to read 64-bit value for
>> channel attribute. Val is used as lower 32 bits.
>>
>> Signed-off-by: Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>
>> ---
>>   drivers/iio/industrialio-core.c | 3 +++
>>   include/linux/iio/types.h       | 1 +
>>   2 files changed, 4 insertions(+)
>>
>> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
>> index 6d2175eb7af2..49e42d04ea16 100644
>> --- a/drivers/iio/industrialio-core.c
>> +++ b/drivers/iio/industrialio-core.c
>> @@ -702,6 +702,9 @@ static ssize_t __iio_format_value(char *buf, size_t offset, unsigned int type,
>>        }
>>        case IIO_VAL_CHAR:
>>                return sysfs_emit_at(buf, offset, "%c", (char)vals[0]);
>> +     case IIO_VAL_INT_64:
>> +             tmp2 = (s64)((((u64)vals[1]) << 32) | (u32)vals[0]);
>> +             return sysfs_emit_at(buf, offset, "%lld", tmp2);
>>        default:
>>                return 0;
>>        }
>> diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
>> index 84b3f8175cc6..bb6578a5ee28 100644
>> --- a/include/linux/iio/types.h
>> +++ b/include/linux/iio/types.h
>> @@ -24,6 +24,7 @@ enum iio_event_info {
>>   #define IIO_VAL_INT_PLUS_NANO 3
>>   #define IIO_VAL_INT_PLUS_MICRO_DB 4
>>   #define IIO_VAL_INT_MULTIPLE 5
>> +#define IIO_VAL_INT_64 6 /* 64-bit data, val is lower 32 bits) */
> I'm guessing the closing bracket is left over of some editing?
>
> Otherwise fine and I can tidy that up whilst applying.

Yes, it's a typo. Please remove it while applying. Thanks!

> Note that this is almost certainly too late for this cycle (we are
> about a week away from merge window subject to whatever Linus says
> for rc7 and new stuff needs some time to soak in next), but I'll
> plan to get it queued up early in the next one.
>
Noted. Thanks a lot!

>>   #define IIO_VAL_FRACTIONAL 10
>>   #define IIO_VAL_FRACTIONAL_LOG2 11
>>   #define IIO_VAL_CHAR 12

Best regards,
Andriy.


