Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 064B04460D6
	for <lists+linux-iio@lfdr.de>; Fri,  5 Nov 2021 09:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232777AbhKEIsK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 5 Nov 2021 04:48:10 -0400
Received: from mail-db8eur05on2137.outbound.protection.outlook.com ([40.107.20.137]:41377
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232785AbhKEIsJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 5 Nov 2021 04:48:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=khZObMfvCOku7kiXXn00EY12UcmGLXaYnXpU+s2AlzQA74uOHGXeRZQPU7qaQPxQrFJcss6rlag9CC7YkJTgrgZpG2Iq4CTJCXmDfjNl616wBO+IvCbXE72Tpy38f5xcMGAMbOT4siQR9otygPmhp14QPdnG1xtxK8kIry4uWJsjfFinyYdvjr7g4/rQ1U6p4+ej6OLQVXeGueEEGPslb+sxKna9b7I7UBpGtDJsXElDW4PZvMuxSR8XAON6nhtKotMdBYIG9AUn8af/eK3H6yMcI/ZIH4Mr1PzdkPplHXSGhYdhZL5bJQer/IuDNcZ1+F/ip7M+D3xSI7RY09BbjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+MGJGHY3tRYSYKBTRpBBUO7vvANLhZaZTT6cFTYNNoQ=;
 b=KIl4ObNz0DYJtIOEN/Iz+VicB2feZqBapiVc8TnHOT4HRXZxTNGTD4WXhx3ujvyt1COvL8j1rU7kqYvIeDstfty27y1AuwVnQt93JNUhNqYyiW91ylPir0ErdaUaBlwwgGUN7Czy8L4DFK5F+BkYHnxJ1BDM0NhzeQdxnZORk+SqCEyMPpghbDQt3yq6eUbFdt9KbuicYed7JkkXaHOtV/nodHGn3Wui61BeR6mIxmXSYwKb/L5IDiodOad/zdCZaPgoSGam7XVfwP/HbN/YOPRh71TIxVTQvfE8N0k2zNrrF+ezEMJQj/N5+rYYn8ZpiVcJubJBgpJbeEuYeX28Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+MGJGHY3tRYSYKBTRpBBUO7vvANLhZaZTT6cFTYNNoQ=;
 b=nb/4834v9fFTOu19uMxNc48V9n1BvlY97/HM8soZ9g+EX/hwuMbZ4B6PIaYNHcR0fyRdPUc5gXfVnpBInokUB0Kz7RoFcFIjpzOosJhtZeOYwjwR6IFVjWpS4s1eMEjcW3lbFUye68s0y3zsl/ox4415zveo/2CXK39Jb2DrhsU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <6d909cca-46a9-3f40-5d4d-97ef2fbe33e9@opensynergy.com>
Date:   Fri, 5 Nov 2021 10:45:26 +0200
Subject: Re: [PATCH v7 3/3] iio: test: Add test for IIO_VAL_INT_64.
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Vasyl.Vavrychuk@opensynergy.com, jbhayana@google.com,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAHp75Vd7Wwka37w-6QTXT9vv13bPiygKryBhQTnyvtTpCNU9qw@mail.gmail.com>
 <20211102073300.13376-1-andriy.tryshnivskyy@opensynergy.com>
 <CAHp75VfafpEBccivDRC2AVVJbZL2Kdq2KeR0yf_nwTtDTxvDkg@mail.gmail.com>
From:   Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>
In-Reply-To: <CAHp75VfafpEBccivDRC2AVVJbZL2Kdq2KeR0yf_nwTtDTxvDkg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM5PR1001CA0061.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:206:15::38) To AM6PR04MB6359.eurprd04.prod.outlook.com
 (2603:10a6:20b:fc::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe47da52-030b-4190-39e8-08d9a0389e32
X-MS-TrafficTypeDiagnostic: AM6PR04MB6375:
X-Microsoft-Antispam-PRVS: <AM6PR04MB637513D72B94CC83DE6F1867E68E9@AM6PR04MB6375.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GJkmShjh+uI/hBzMSxayMgXWtAYsxwNjkwS4O9Y5/TKjCstMmN/OqEmxI2py+1l85lJr0xFsbiaZt1vi8vWdQphdetlEd5jdWReWA3pahhgB4O+ffRc0PNJHQIwInFNh7ZcyP9zcGUbUPhx+BshQH+zv9c2n6n2Lp7lLQJBq+oCIMqL++2IFHDU4KttbZzHoE+mmG8MaqfFor3uCVnWYYZ6h6TEHiK60rPVdtjlWW5OEN0fhjmubJXu/wtoKDAs4/l1hnD6vzeAsWG1M1YSczI3j+yhyUC4ou1xhPRPAiCuU2hRBuZPU3L/MPQXmiYrfQT4KUr2zcRjBqsr51LI3gnTYpujaTKnDRQ2jR3/deeslrHnN5XnrY3U7LgNBtAGf/9bojE5/6RPkaWL8wzmnLD41SQXpblugmjB51u6yRFWIbS+PbBhCu5lJrOBKzUnztew2ekHW79i+JsW9CbYVAG+lBp8/qJsseRzux37YbwRp8sZPIWSG6z9HDh3neVRM3uL5ioYbNEl0fXkWO0mf9nYGl8OPPKSDBxUKp5YTB7v4rKlTwiUKlsW6WZyDdLOHjm8Cpl2H8UVmByRafOVjRNPFBspvKPRd8XPUPG2xpjErZhDFzUttDaDlc0sELwyZ4I5gaOLPGAEuvgRTBjiXDw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6359.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39830400003)(366004)(346002)(136003)(376002)(66476007)(66946007)(53546011)(55236004)(508600001)(66556008)(38100700002)(83380400001)(42186006)(54906003)(4326008)(316002)(86362001)(2616005)(31686004)(5660300002)(31696002)(2906002)(44832011)(36756003)(6916009)(8936002)(8676002)(26005)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXYyMmY2SlNaZGdBMGxHbVozaUJwdGJnS3NaMlRnNGdsZCtrRi8vbXo1SWxn?=
 =?utf-8?B?YmQ0bDczWCszckQ5aWd3VGZ2R242dHE0Uk1yc2IvV3hXNEN6RVp3QTBqUkk0?=
 =?utf-8?B?N1V2cXNPUkJKc1ZzelpFV3NZWjJnN29CK3MrRHFnUmdmSTVMK0RKS3I2OXRq?=
 =?utf-8?B?VjJOZUJnVVlsa04rNkJkQXdTdkpCNlFPZmM1U3UyMCtUTmgxb0M1SWdBSmdQ?=
 =?utf-8?B?TytBb0VMQlU3eWxnRkNzS3JnNmhIeTQxajk4ZVhheHZwaHdBTVhQZ3phbXpq?=
 =?utf-8?B?bXdUQWFlYlFqZEtYOGdNSjJsWHVpNzBCMEtXb1FHRHErNHFRWUM2R0VFTWJi?=
 =?utf-8?B?Mnl3b0VPbktJS3RZd2piSVZVbnVkcWlaajJHMHVxMFlidGdZUHZqdXc4MWpW?=
 =?utf-8?B?bnI2b0Z0Z0hTNGNMbEVrSkNqOWkyU2I3a0VpbVZrazIyUTFFZmIxb0EyZjU3?=
 =?utf-8?B?S2xjd20xem5qUnNsRjFOQmFSakFzSTY0WVdzUjlkc0E4WDcrWklKYVB1Sk5n?=
 =?utf-8?B?WkZVZHZ0SklpazlnYnJ1S0d3WUdEa0sxYWt0YnhnWDh5dTVBeERuMUZkcS9W?=
 =?utf-8?B?dTZZdXJkTU1NblYxZ2ppWmNtRk83V1BtWUJWZUoveDIxMVN0RmZLL0NPSzY4?=
 =?utf-8?B?bzdCZUx2SXJHNEVCbEVxdGhQTi9VQ1UydWcvNHZhREVjdWZoa0lNbXp5RjU3?=
 =?utf-8?B?L3hETWpzZXdOVTdyRndkMExOR3pmOEpHNmprMFZkWFpaS2U0QzNpNUJ0Wjdq?=
 =?utf-8?B?S1pTRVN3UjZodkhlNTVKVkNtZTI4c2ZOeTBWQnFBS1N1V2EvSGJhWEJjampF?=
 =?utf-8?B?MlJOcDBoS0VKTjJEdkVBUkhtWTQySytUSlRUeVE4eXhTV2pTYi9CQkpVcDNx?=
 =?utf-8?B?a0FDMmt0b2ZZOFJYaENlbXdQN05hVkp3bFFsRTBOWnVvT2JrWDBOVTlkZXFs?=
 =?utf-8?B?QzJCalNvREFBUjJ1cjh1TkJDQ3hFQlBna2FsNWgybVd4TEVmQjVxNGNGMm1K?=
 =?utf-8?B?RlpkelUwOUppNkpic1hKUlZnZUFYcGhRUDlqMHpSZWltTzZCV2VPSHNZTWF5?=
 =?utf-8?B?VE01Nm5NZmRja3VCeU5uMXBCaDlPUDN0ckZOeFFCOGtHVGlmd0dSZzIzVUhv?=
 =?utf-8?B?eHJ3eTdkNVYzZkxrVzBFd2RuL0tLMG82dm9mUzBJSDFQeDNYOXRNZTlHcmJC?=
 =?utf-8?B?SHFQWVZ0VStqYjBLdEVxNmpHWU1EcTlyUjNUdnZNYS9nYXVJQlgxSUE0SlRJ?=
 =?utf-8?B?OXhvZ0FYY2d1Z1RKRjdRUjRyeGVHcHU2ZHYxOFBnMG5JajdYd09GSVpkZTJM?=
 =?utf-8?B?UVhXL0FFMDRxRmxiY0ZjNU5QZEFZMkF2M3ZsM1lDQmJ1cUo3OThmUTljL0ZS?=
 =?utf-8?B?SXNsaGc3aXhXL2hFM0J0eVZHU2JkY1FRVEs3N3VxdWhCZDQxMlJIUnB6akZM?=
 =?utf-8?B?Ni9tRG45VGJ6VDBPOU53Ym9ueGVJYkdJZ0owS0JSeDVqQ2YvdnJIdStuanBD?=
 =?utf-8?B?alRjeHNZYm5FRS95UHQvQTZ0bUNDMU42SUJ4K2U4QWJCYmRUSjE2aVRXeTMx?=
 =?utf-8?B?YXJ6MVdSWUs3eWFKRGt6QUMzbVVpSEU2anZ5VG1OM3B0eEV3WGw4SE1rTzRv?=
 =?utf-8?B?ME5WYmFIbTBEdkhITVdWcWRFdTVERzhLL2MwTWJpNE5lcm1wc2F5c0QvOTVh?=
 =?utf-8?B?U0xJUlJ2VVZvTUIzdlREb2o3VTRVTzRhYTQrWnBjOHBkOHhOZjZoZGkrelpu?=
 =?utf-8?B?WGVzRUFZVGdSclJKcE9YeiszalhiWnV3UnpuK2ZldDk4anpLOXJGREo3b3A2?=
 =?utf-8?B?bDBuMEhVV2FIRnVuV2lJK29YcTZYbjFsSms4ekc4eS9LbWtsRGgzQWNPTXZy?=
 =?utf-8?B?VFBJVjlXM2JmYllhZFllVFBaT0VCcjVpT3ZCUEY5OFF0MWIwS0xSWlQwNktP?=
 =?utf-8?B?Zm9UWFc5VFBWV1JvUi9pUmY3cnZiUGtoNGpyM1Fpa0ZZTlBmRmZLMnRZNHZq?=
 =?utf-8?B?ZW1UQ0VsZ2JZWFVnZFlJVWo1akdYQnI5bEQrRG1KMzNEOWMrQ0VhVmV2T3FN?=
 =?utf-8?B?QTk3NjZ4OWpCVkw2aWRnQ0J2R3IzNXMxajl5VHF4SDI0S25XdEREeW1rM3FL?=
 =?utf-8?B?VW90RERCa3E1Uk1ZZzE5QWNORnRPK3dXUkdOV3pQOEU4c2lmaDVRWEFuVHZ6?=
 =?utf-8?Q?vf/bO7+lkCdmYl3hUQsz0a8=3D?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe47da52-030b-4190-39e8-08d9a0389e32
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6359.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2021 08:45:28.3209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 03IOXrbsBH/1B8uQPC5RFqHxDsEh+bYgog6GOAnwDhZxDY7HPIwSV0/rk+Flosc3QxU8JvU040YYSbF8foaeRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6375
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 02.11.21 10:11, Andy Shevchenko wrote:

> CAUTION: This email originated from outside of the organization.
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
>
> On Tue, Nov 2, 2021 at 9:33 AM Andriy Tryshnivskyy
> <andriy.tryshnivskyy@opensynergy.com> wrote:
> Now it's good with format, but you have missed the commit message.

Actually commit massage contains a header only (no body message), but I can add body message too.
Thanks!

>
>> Signed-off-by: Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>
> ...
>
>> +static void iio_test_iio_format_value_integer_64(struct kunit *test)
>> +{
>> +       char *buf = kunit_kmalloc(test, PAGE_SIZE, GFP_KERNEL);
> Shouldn't this be checked against NULL?

Good question. Truly speaking I've made new test similar to other. And no other tests has a check for NULL.

>> +       s64 value;
>> +       int values[2];
>> +       int ret;
> Reversed xmas tree ordering?

I will correct it. Thanks!

>> +       value = 24;
>> +       values[0] = lower_32_bits(value);
>> +       values[1] = upper_32_bits(value);
>> +       ret = iio_format_value(buf, IIO_VAL_INT_64, 2, values);
> ARRAY_SIZE()?

Will use ARRAY_SIZE(). Thanks!

>> +       IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "24\n");
>> +
>> +       value = -24;
>> +       values[0] = lower_32_bits(value);
>> +       values[1] = upper_32_bits(value);
>> +       ret = iio_format_value(buf, IIO_VAL_INT_64, 2, values);
>> +       IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-24\n");
>> +
>> +       value = 0;
>> +       values[0] = lower_32_bits(value);
>> +       values[1] = upper_32_bits(value);
>> +       ret = iio_format_value(buf, IIO_VAL_INT_64, 2, values);
>> +       IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "0\n");
>> +
>> +       value = 4294967295;
> Is this UINT_MAX?

Yes. It's UINT_MAX. I will use a constant. Thanks!

>> +       values[0] = lower_32_bits(value);
>> +       values[1] = upper_32_bits(value);
>> +       ret = iio_format_value(buf, IIO_VAL_INT_64, 2, values);
>> +       IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "4294967295\n");
>> +       value = -4294967295;
> Is this -UINT_MAX?

Yes. It's -UINT_MAX. I will use a constant. Thanks!

>> +       values[0] = lower_32_bits(value);
>> +       values[1] = upper_32_bits(value);
>> +       ret = iio_format_value(buf, IIO_VAL_INT_64, 2, values);
>> +       IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-4294967295\n");
>> +
>> +       value = LLONG_MAX;
>> +       values[0] = lower_32_bits(value);
>> +       values[1] = upper_32_bits(value);
>> +       ret = iio_format_value(buf, IIO_VAL_INT_64, 2, values);
>> +       IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "9223372036854775807\n");
>> +
>> +       value = LLONG_MIN;
>> +       values[0] = lower_32_bits(value);
>> +       values[1] = upper_32_bits(value);
>> +       ret = iio_format_value(buf, IIO_VAL_INT_64, 2, values);
>> +       IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-9223372036854775808\n");
>> +}
> --
> With Best Regards,
> Andy Shevchenko
>
Thank you for review!


Regards,
Andriy.


