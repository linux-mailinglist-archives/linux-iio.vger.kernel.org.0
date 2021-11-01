Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B16A44142B
	for <lists+linux-iio@lfdr.de>; Mon,  1 Nov 2021 08:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbhKAHao (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 1 Nov 2021 03:30:44 -0400
Received: from mail-eopbgr80115.outbound.protection.outlook.com ([40.107.8.115]:3294
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229827AbhKAHan (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 1 Nov 2021 03:30:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nxdL1VRUvqp0gtkF4VGVJvu+AzDS9BZMp9BNSbuOZIDJ7rocrGXeoRimPTsMwf7dHAneC6fOxuss2uMgmnR3CUmHgzLoBetpjLWTKkHe0nNCxkXgvZbUJnK4zxUECrf6X4sKTuO8jn8PB65D8tDWHzg9/sARoF7t1PsPXMtIgMIeQOoZAipUqkie4g4cj0n9Kf333FFnpjNBBx4fAIcybENtVD3b55XG/u7twIG3G+KkcKrdI9KfsfKayjTS2vWwCztX6yWqtTtvF4CKA7eteDXKOqb25IkhcgRQdnRO+qV9F2DxEOSZtd+em24KEb/acB3QKcZmwpJwAw1x40fkqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yk/TVlE3lJ66b2w/uW363+h56aYWbRBJIqLxU4Y7Y7s=;
 b=oXdWLV3x+oAScxc1dEnkhpr8u8N8SH7e056w1WqVYfVDFfkGI+d76/9Y6YpwdEkX5Q//aFFHUnXbovY4YDbr0wvT0R1/aXwjwltcuLj4058d9kM4Z+E+CwvtyxlhQvKEG5a/1P8nLduCTKhQma0dOszKQF4jsewWdIxAYN9ej36fV87xmfsnhy+fkYKvjHv+y366UMvKnwW5/KVZNr70nZBwMy7z4t4FUe7/tspXqcJAViMvHJFLTlWxAVE6LVVAWg1Tcqri9/Pby1EKOeUhcbcnlUg7sA7gg5H1VxZgpLFcj0+eS4LP9aoKs9me2MX1X24sTxsJMW5mdo2YXooPNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yk/TVlE3lJ66b2w/uW363+h56aYWbRBJIqLxU4Y7Y7s=;
 b=CfGN2/icmDncPQ2KKx4sEmwiUDJL/o3KbatIQCVj3kKI8hhDCHT+00c1Keff7vD/pONKGIuW1cEoZX9klPQwixCDn8bTwUMECK/Tuome6Ajg06qGSluhX/O2KvQyXwuuVSf54F7aHbUrEXwv7N6C4SHtKF+S8uF6vwG1SDoBIE8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <7efacdde-0c3a-36e0-bfc7-ef30c14cbf13@opensynergy.com>
Date:   Mon, 1 Nov 2021 09:28:05 +0200
Subject: Re: [PATCH v7 1/2] iio: core: Introduce IIO_VAL_INT_64.
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>, linux-kernel@vger.kernel.org
Cc:     jbhayana@google.com, lars@metafoo.de, linux-iio@vger.kernel.org,
        Vasyl.Vavrychuk@opensynergy.com, andy.shevchenko@gmail.com
References: <20211024091627.28031-1-andriy.tryshnivskyy@opensynergy.com>
 <20211024091627.28031-2-andriy.tryshnivskyy@opensynergy.com>
 <20211024171015.3b6b46e5@jic23-huawei>
 <20912d4e-8417-73d6-a42f-ceaada6e3cf3@opensynergy.com>
 <20211030154759.63be7331@jic23-huawei>
From:   Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>
In-Reply-To: <20211030154759.63be7331@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR06CA0094.eurprd06.prod.outlook.com
 (2603:10a6:20b:465::7) To AM6PR04MB6359.eurprd04.prod.outlook.com
 (2603:10a6:20b:fc::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 00e5558d-1353-4003-0e44-08d99d09268f
X-MS-TrafficTypeDiagnostic: AM6PR04MB4712:
X-Microsoft-Antispam-PRVS: <AM6PR04MB4712E1B842DDB844A1D324C5E68A9@AM6PR04MB4712.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WrH6WxgUwIbwts9sWIRxELcEeErDh1YBfSyJysl8XFQJz9egH8cpdVsxT59JcOfdQn2ExcG+Z/kY70PVwmxycdgjSeDSy6+i7aTo+QZXphRXEGyQz78UVizRuAY7WwGqrNIGCFQIA362/aCAP/OeFgWB3ef3fEL0GRVyCc1JAOoIWr7rLn60LfpRCXeqPyKGk0Ty+3e3XDUaL0VSiZxYziB590nqqx4PqousCXaqTh/sFHmWpmq9wdZTrBIUlYSYUk3OMVvnfwuxdhRAt8NkEeliNVHWAQXBHXKLcOD+q6ubuTjvjZJv0ByIJgxwBGXd4to+E6+MGVPsWOtCMLQRuWvkY+y3e96S5xVmMsjwJ8rM3h9r1Ifx6212kya09g8P6q4gktHLfl5kgZ6HjOmmAqKo4NfVRdn3pLa9cXKzm0D01EDcFESO67Bc4i36ZpiSYL/p/xXI5FQsKY0o8VOozSxQ6hBxfRvjkwe2MvCdTECVq15dUxTFn4eRn56WfCuGxRpx3vk50G07PzREeOg9kQgCIsbERtbgmCxsZxH/fN9P3rQ17QVJPm2WfkE/CeOGRnc4xIAS5Krggm6HBACoh5II1v1guhEtlNHBA/sZlkS0YPHcdS0ib4DnoazLyArkETf5ZlOB4O8GXfqoKQh4UQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6359.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39830400003)(136003)(346002)(396003)(376002)(5660300002)(8676002)(4326008)(186003)(53546011)(66946007)(38100700002)(26005)(66556008)(66476007)(36756003)(31696002)(55236004)(31686004)(86362001)(8936002)(42186006)(316002)(508600001)(44832011)(2616005)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1FzUmxKdkljL1UzWHcvdGlQdHZ3MFNPbng2OVpXTnhldzNjT1BDajFmRG10?=
 =?utf-8?B?akNhTVZVSUx4djF3ek9XWkdHRVhibEpZT29XY25XZHJCOVpyUlRtVi9RK2di?=
 =?utf-8?B?bTRDMmozZG9WVC8xM29zUGtqemI0RWRLWEErckpSaW0yUW1BbUF0VStYaFk0?=
 =?utf-8?B?bDlZSnd0RUZLeDNBMUQ2dzI1Y2hrSkI5NVhON0ZhMURoeWpmdDRLWGlWc2R3?=
 =?utf-8?B?MjdrOXFZdmlSeXJ1M3RkeTRyY3VKNXZlT2NaZlpqMDJJMVlJeDVVaUF5emdx?=
 =?utf-8?B?aVdqZ3pPd0ZpY1Y2QXFLZDhhTDczNVJ5eTNiMkVtUEVVN3o0WVpoMGEwWEZ3?=
 =?utf-8?B?U3ZXQ0x2L1c1NlNEdG8zRmhTSmtlWEJxUzN0K1FyZUdIc1lhK3RRV25DQmo3?=
 =?utf-8?B?ZjVlODAxSnpMeWE3dWgyQ1Zqdi8zNzViQnluSGJ0VGJVK1FnSDlvalo5emhS?=
 =?utf-8?B?OE5KbU83dllTRmhGSUNKMHIwNEJDaUVqZEhJbWNZSzJRQTZMamVjbHdNcTVi?=
 =?utf-8?B?aWpCMm1CYURadmFNTFpmdFU4R2ZzOWlUcnVsZVJBSHlkMnVJTkErdjFCSy9Q?=
 =?utf-8?B?aEFvb01iQVE3R0xNbGNHeEFrUVRCcVRicjBGZkFITDhmd2t4bGQ4eDVOVDJV?=
 =?utf-8?B?aGtOQ2EyY0JJbXNNaWhRWjdQVlVORStWcUowMExPcExVSUY3dFdiWU1kdmY3?=
 =?utf-8?B?R1ZMTHlJN0tCMGkwVnUwdE1WZlRuR2ZIU0lwTW8xZlc0bjJOK01YcmZYUVZT?=
 =?utf-8?B?OGJTMjJGVTgyNjhibnhJd1kwWXZqZzNqREFwNG5IR1UyeVJSdDRBeHZ1c0xQ?=
 =?utf-8?B?ZStBNmZ0OTMrMDY4b3ROalMwS1lFVFFtYjVuRnVwaXBobTZQMDN5SU0wMnZH?=
 =?utf-8?B?V0w3bUNQNXdMNlpkSmxXTzVqYkhmZG9HdXYvOHZGNXptaTNYVE5rR2JkOW5i?=
 =?utf-8?B?M2dOViswc05wZjYyN1pscDZxWUtoR3JyU0FvSDhKT0NDUmx1WWpXdE1Oa0tr?=
 =?utf-8?B?SzVlaW5DS2x2SE9aNkg5R3kxd2lwOUl2L214a3ozNVcwNloyNEhPWXB6UURF?=
 =?utf-8?B?YW54amdvdUMvb3Q2SXdyWURIcmRRRzBaZjN2UHNZZWJxTzIyaEdYeEEvMWMr?=
 =?utf-8?B?cWZvSlpVZFZjbXVEWm9yaUFoU1FkQ2VGVEU3MkhOYzVNSDVvQ1ZCTVdUSmRD?=
 =?utf-8?B?ek9NdXRscmVZWmJVS0RTUUVkcDVORUtsQTZoeWNSY0JPQjE5cWdZNUEwKzZW?=
 =?utf-8?B?OTYxd1A1cDYyVEZzckk0QzlueXVkUWxXRFNGZitnbmdENXZ4cmx2QUk4TkU3?=
 =?utf-8?B?bUYwMHJDWE5RTHoxR0hWS0VBdGRvZFMxUEFHL1BBbFhWMFF1ZnhSNTRRWHZZ?=
 =?utf-8?B?RjBObURINzA2c1hKQU0wM2RkVUQwWUk1RTFnelJ0endYd1hKUVF6SjRxQnNh?=
 =?utf-8?B?d2Y2UGFkNFovOTVvN3hReTJuYjA1OTh6cFpJbG5PdUJwMWRmSlZJdndweCtw?=
 =?utf-8?B?WFFRRTUydTBDVDlhWEtQZ0wzRy9FNUo4VEg1QzRtSEcvMVZIUXhjdFBMVWZY?=
 =?utf-8?B?SEVlVktJYmhyd1lldUN0WUpVNGlZTGxRN2JHdWVrZnpIMzIzWW81RHpJR2U3?=
 =?utf-8?B?VFJDaERBSFMrQ29RNUE3M2FKRkJ0OWN3TkFteVUxWDFmdlMvY2x5ZnZtZlBm?=
 =?utf-8?B?dUE5UHZMbkFtL3U4Z0p1RTdpT3p5VENtenR1ZHRqNzg1eTFTd2huOTUxRTJO?=
 =?utf-8?B?akxOZkI0dTBNSFJ2NHF3ZjBvZU9MZVFVUFhXNnp2V0drZkpaazc4bzNnc1dR?=
 =?utf-8?B?azVobWIwSnZMaGdtakhXYy9iZS9ySHRrRTl1UnNJNzVDQUFUZ1AyL0diR0Rk?=
 =?utf-8?B?SUpjMHNNZGJhUklFZHdoRU5GOTRmSzJRejlyUk9rTzRsY3ZSSUJpTldWSENW?=
 =?utf-8?B?RlUwRzVMQTVrZ1JwRTZvSHNta3JGK1c1c2ZOMGNCMW1nbzFkcHhQZEp5RXFm?=
 =?utf-8?B?NmlKVVEvWDBtUXVsTnRiTTFEVjRJMFRwbStueG11dXQ5aWVSdE1oS2NYL0FY?=
 =?utf-8?B?bmhSM1h4a3FjcUR3K0lEL1J6MmtqVldZQ2pLWjkwdUZUZFVsd2VqLzgrd3Bn?=
 =?utf-8?B?MmhDTUN4RXpOSlhyUmF0cHBGT3F5eG1odm10WXpkdUpTa3E2NDV5VzhlRG1m?=
 =?utf-8?Q?Vbz+dsKBW6nZynSgIfkVHFY=3D?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00e5558d-1353-4003-0e44-08d99d09268f
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6359.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2021 07:28:08.1529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gTaLHFxqvtJny7iQsY8/rtl6lf7oFkXaO+bq6l0NFJTKmeJBOlQ25dVC9KIxjrJiiGW6JEAIJfMfjwMoVa5RmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4712
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


On 30.10.21 17:47, Jonathan Cameron wrote:
> CAUTION: This email originated from outside of the organization.
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
>
> On Sun, 24 Oct 2021 19:58:52 +0300
> Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com> wrote:
>
>> On 24.10.21 19:10, Jonathan Cameron wrote:
>>
>>> CAUTION: This email originated from outside of the organization.
>>> Do not click links or open attachments unless you recognize the sender and know the content is safe.
> Ah. One thing I forgot.  Value formatting is the only bit of IIO where
> we have self tests.
>
> Would you mind writing some test cases in
> drivers/iio/tests/iio-test-format.c ?
>
> I'll pick this up in the meantime but definitely want to make
> sure we don't forget the tests!
>
> Jonathan

Sure. I will add some tests.

Regards,
Andriy.


>
>>>
>>> On Sun, 24 Oct 2021 12:16:26 +0300
>>> Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com> wrote:
>>>
>>>> Introduce IIO_VAL_INT_64 to read 64-bit value for
>>>> channel attribute. Val is used as lower 32 bits.
>>>>
>>>> Signed-off-by: Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>
>>>> ---
>>>>    drivers/iio/industrialio-core.c | 3 +++
>>>>    include/linux/iio/types.h       | 1 +
>>>>    2 files changed, 4 insertions(+)
>>>>
>>>> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
>>>> index 6d2175eb7af2..49e42d04ea16 100644
>>>> --- a/drivers/iio/industrialio-core.c
>>>> +++ b/drivers/iio/industrialio-core.c
>>>> @@ -702,6 +702,9 @@ static ssize_t __iio_format_value(char *buf, size_t offset, unsigned int type,
>>>>         }
>>>>         case IIO_VAL_CHAR:
>>>>                 return sysfs_emit_at(buf, offset, "%c", (char)vals[0]);
>>>> +     case IIO_VAL_INT_64:
>>>> +             tmp2 = (s64)((((u64)vals[1]) << 32) | (u32)vals[0]);
>>>> +             return sysfs_emit_at(buf, offset, "%lld", tmp2);
>>>>         default:
>>>>                 return 0;
>>>>         }
>>>> diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
>>>> index 84b3f8175cc6..bb6578a5ee28 100644
>>>> --- a/include/linux/iio/types.h
>>>> +++ b/include/linux/iio/types.h
>>>> @@ -24,6 +24,7 @@ enum iio_event_info {
>>>>    #define IIO_VAL_INT_PLUS_NANO 3
>>>>    #define IIO_VAL_INT_PLUS_MICRO_DB 4
>>>>    #define IIO_VAL_INT_MULTIPLE 5
>>>> +#define IIO_VAL_INT_64 6 /* 64-bit data, val is lower 32 bits) */
>>> I'm guessing the closing bracket is left over of some editing?
>>>
>>> Otherwise fine and I can tidy that up whilst applying.
>> Yes, it's a typo. Please remove it while applying. Thanks!
>>
>>> Note that this is almost certainly too late for this cycle (we are
>>> about a week away from merge window subject to whatever Linus says
>>> for rc7 and new stuff needs some time to soak in next), but I'll
>>> plan to get it queued up early in the next one.
>>>
>> Noted. Thanks a lot!
>>
>>>>    #define IIO_VAL_FRACTIONAL 10
>>>>    #define IIO_VAL_FRACTIONAL_LOG2 11
>>>>    #define IIO_VAL_CHAR 12
>> Best regards,
>> Andriy.
>>
>>
>
