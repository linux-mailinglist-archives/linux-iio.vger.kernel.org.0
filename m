Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5CCB441BFB
	for <lists+linux-iio@lfdr.de>; Mon,  1 Nov 2021 14:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbhKAN5S (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 1 Nov 2021 09:57:18 -0400
Received: from mail-eopbgr70094.outbound.protection.outlook.com ([40.107.7.94]:18083
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231366AbhKAN5S (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 1 Nov 2021 09:57:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EWaaLkV0ifssK8a9Pl1wUPteZLIK/hxjG3AHIVELlCjYn9KYcNHu+kBdH7tc9MJTukz00T5iiTdWxqf00QFYkCHSayCit/F3CUwlxxkIp0/+vUvr6KwDYhLN8uZae5FcYDGE+Hnaap9fy/RIRxbRekkTURFA22dP6twY5EPvSTZxKTYIkTWrZI/A9MCUGgvwpvTrH3pZWnvujP/FpqspiloPD8W5/GdITIOGX9M596K8TTwtVifwTx8+NVV1opziruuAUclxlA6vtxMKixthBWqi+NrYGK5DLnxmCw6hlhjdZmXyFBQ95VIaR0/8GDI7fNKS0G0D9DRlkUY+0lPr2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pGvKhIVTXvKILjxoYciukpVL3RrTXcxBz2msenCHhkI=;
 b=KVBDiLGis5+NsO3gR9zy9nqUcoiXzEUAfXChMzAS9wCDYYg33or+djp8PZbmmWQrRuYQ+PNqhYWZWeda9pEru6hY5aR0e1KnyjKF27JhqJQzBTwfCAij3Stu0q+vBK/9nJqiY65jIgWIVTcS0UV0p5FkDrzPcIdO+2lZKQKM0n+OM801QucuFe5/R05OD6AUTo/xY+x7M1wZ7VmJtnAqF4HxlwYWPoVfQJkY98kjRltbvZ2JXjjTujPl6uz4iE7fHkbCV6j8btOu7XVoCgkzmbkzmG8QKTY8QOo+RGLkO3XWDZh4hd0Fmg0HK0CneSMSHNYP6I7VMcxsISYxKPhRAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pGvKhIVTXvKILjxoYciukpVL3RrTXcxBz2msenCHhkI=;
 b=cqMStia09u9eSIVJIVueOm4aXP0z2wznmc9Ch7rEHXJ1eel+f6O86isRXc7uDXcJS61z5h/NE7kss88lcZThqbcLHtugk4pC2QxalSYEbTsafKsSGnixdkwZn/Jic/Pz9RX/E4zJo9mEoGWsidquNgH7M1wAnddr0451zAs/5X4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <4b53b3da-38b5-5c22-60bc-9f0731d6550c@opensynergy.com>
Date:   Mon, 1 Nov 2021 15:54:37 +0200
Subject: Re: [PATCH v7 1/2] iio: core: Introduce IIO_VAL_INT_64.
Content-Language: en-US
From:   Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>
To:     Jonathan Cameron <jic23@kernel.org>, linux-kernel@vger.kernel.org
Cc:     jbhayana@google.com, lars@metafoo.de, linux-iio@vger.kernel.org,
        Vasyl.Vavrychuk@opensynergy.com, andy.shevchenko@gmail.com
References: <20211024091627.28031-1-andriy.tryshnivskyy@opensynergy.com>
 <20211024091627.28031-2-andriy.tryshnivskyy@opensynergy.com>
 <20211024171015.3b6b46e5@jic23-huawei>
 <20912d4e-8417-73d6-a42f-ceaada6e3cf3@opensynergy.com>
 <20211030154759.63be7331@jic23-huawei>
 <7efacdde-0c3a-36e0-bfc7-ef30c14cbf13@opensynergy.com>
In-Reply-To: <7efacdde-0c3a-36e0-bfc7-ef30c14cbf13@opensynergy.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR06CA0408.eurprd06.prod.outlook.com
 (2603:10a6:20b:461::31) To AM6PR04MB6359.eurprd04.prod.outlook.com
 (2603:10a6:20b:fc::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 659ef256-f332-4e57-6686-08d99d3f25df
X-MS-TrafficTypeDiagnostic: AM6PR04MB4822:
X-Microsoft-Antispam-PRVS: <AM6PR04MB4822E8BE426CEA00FF7B5056E68A9@AM6PR04MB4822.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: brLpcqjJnr/NFnX4x3xM4QtRo3A60pttiYlHd7niM6a8y51+7ch51bxz+x6+IZ5ZoE3BvUzjgX63g3aoGdid1O5blKUP9R3JXbIwKt98nPGy4+lJQWUb+N5wtErdJgC80KEVp1Q9+r0/Mwv9AkKcQampAIVHFFqk+8ACZ/o0/vhoqbvw7RssbQtR39++WyRb+D1hrElDpF+Mvai+FH9guU62bZAQ9y8O6mIQxat8uYaKXudQ2xOlI3DvtyEJLyxjqt5J4SkYqCRY+ydzrYc2rPj0GMzeJvC+q9OTBlgzP11LGMGbivjyzYqObIq34tpleOQ//ltcO9ILIIOuRfhEE5MShkCnvPbW091pLMqmXBrcRWmuP0BzkkdOq/KxPhWt7b5L8mMiRxE9toHBZXD7Ei2EM6moY8ZluFg8BQNEgaUmSX0j47YKHTl/RilvvVFctqXBoI5hfVv5yk0Jn7XUWTpDU3gOKb89EvvVmRBvYmBalOqcX5l4+76IX0mDDWqsPx+iqUR7+rPun+vU2dDWnlH1cibaOmqHoWu10ieUgkHgF2e+33MEqbR2iNjoLCNGXauE7hf4qqUaxXltNki1AjmRrREpAzaAsRNnuUYia3ri0gEhNX0PkTWeDGTkBIs6rduK/P7eKXKSeJeVEuK/lg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6359.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(346002)(39840400004)(136003)(396003)(44832011)(8936002)(8676002)(508600001)(4326008)(5660300002)(26005)(53546011)(55236004)(186003)(36756003)(2616005)(31686004)(66946007)(31696002)(66476007)(316002)(66556008)(42186006)(38100700002)(2906002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGVZa3FjUVkxWDc0RDBLa1E0a1B3bDAzWjlwOU85S3BpOVVQd1Z1V0NuVXJC?=
 =?utf-8?B?YzZuRHJRdnVPakpkOEdKTGlnQzlGMlVOMHlZRmFLZmkyK0I1SmhTcVA1Z0x2?=
 =?utf-8?B?cWRXLzdrRWk4cDVydGhMWEpnQldFRTMwVEhsL3Q1bVVHMXkzWTF1WVcyV2k4?=
 =?utf-8?B?V3NqREhWeThYVDlYOXVVMUczd25NY1NSZ2pGUXErZWlkUWxLU1p5eThSVmdt?=
 =?utf-8?B?QnpNcHJzODZMOW1UUjFlVlRJMXJyTUd0Nko3NUpCUUxsZ2RDbkJXV1RkN1Rv?=
 =?utf-8?B?TncvTVduR0J2TjB0eXJMeEdwUDNYMFlmMW9jdGZ5SjdibTFzTlVQYVh3cHhP?=
 =?utf-8?B?b2oweDZTQnlUOVdxQlJ3SXJPZHkvejR0NUE0bG5ZSTQrVENvRHZMZXJxdU1t?=
 =?utf-8?B?QjdwcEtmdThSZU5Jb0lOcVdzSnJ3YjhlQUVDYk43aHpqeC9MaUZmamQ0cWY1?=
 =?utf-8?B?MlBpakFNV2JNQzFVNmwwNU4ySG1USm40cEdHQnpWWGJaR05zVjBycFBlc29P?=
 =?utf-8?B?OThaODY3VG5IMTgrVVRJVW8rR3JZOVluK1V2R01tRFhONFNWbUtBK1JqdkdX?=
 =?utf-8?B?WDFFTE1Ra3Y5bUFBN2hsNWR3YWI2dHg3dTRFWVNkUW11THo5QSt4bWY3ZXg1?=
 =?utf-8?B?Z0lRbi95c0t5eHZLNjJEZ0VGVXVraUlDRGFDbHh4WkNNckJEQTVTVmRTR0Ra?=
 =?utf-8?B?WWhkaUVNMzAwY0hadFVIQ3hQTlFzTGdYWktpTTNrVGFjcEtuU0x4RzNxd1ZU?=
 =?utf-8?B?cG5PaUlEVTNtcFoyTVYwRE9YcERPa2VHUDRnTHhsbTZxOFpJckQwVCtRVnlM?=
 =?utf-8?B?WjA4THJ3Vkp4SHliVyt6WEF3NDVIaUcwMnpqT0JpN0dPdEdraktLeXRta2dp?=
 =?utf-8?B?WHk4cGZvVzFqeVBxdlQ4QWVTV1VlTkJTd0E0WTZXL0hCN1FBSndmbFgzZE5V?=
 =?utf-8?B?ditCV3FlR1ZGOU5KU0FKaHcxQ3EyUGNrZGxLSHFiSEI2bm1IdmR3L2FhS0pz?=
 =?utf-8?B?TFhkeXBSTlVQVTFUOGFEY0ptWWZjQXFOV2lvR21OZ2ZwWnE5bVNwa3VSRENM?=
 =?utf-8?B?cFFtUm5IMXhyOU9XNjNEMWhVdStvN3Q5Tkt3Q2pHY2h5MWxFbkRFaUhjUTVG?=
 =?utf-8?B?Y2ZXNG9IUVVMTGJySjROOFhKNjhuVy95VjcvdTI5dzZVYis1aDV1WDNZK3Rm?=
 =?utf-8?B?SThla0t3NU1OSjl1YjhtZHppc0F4MHYxUjRNMDhVZ2h2a2I2UHhNWnR2dk9u?=
 =?utf-8?B?a3dMOU0xTW5uK1pHZWxxc08zYWpEckcrenRKdHNVdUlRQVcvUzIwUmY3dHVw?=
 =?utf-8?B?R0MwblUyMkp2YWliVVhHc1MzNXAvamNYUG1aaWxCcURoeG1YM2NtcG1BRG83?=
 =?utf-8?B?TkFYMWNwU2VkaXRSQVY5Tlh6Uzh2OTc4bTIyb1pYcm5yZ1ltQXJkNzJJLzBF?=
 =?utf-8?B?ZXowaUZlOEk2SXU3bWNKOXJtQVZTWFNKZnorZTI4ZTJJTlBiMWJlYSsva1JZ?=
 =?utf-8?B?MmNHSlloQzFGcmxvSHkzQlhtQWVRa0RyNEhTMU9YQlV5N2xoTzVIMElQNzJr?=
 =?utf-8?B?eTNpZS92d1pXUzUwaVRxR3NWdzFsT1lKUklYNXdGNlg1TzVockJ6OGU1cWZJ?=
 =?utf-8?B?MkIvUXJyeTVJU3ZrVEYzTGtMeSthZzBXZG0xa3M2OXJNbThuZFU3Ujl4VTh6?=
 =?utf-8?B?ajB4Um93YTBZZlh5bmNQOUVSZzgyak9jekpieUVidkpHSnEyd1MxZitKWm5D?=
 =?utf-8?B?Y3hkYVBNNDBxUWs0SEtsUCtqdlF3VHdGdVJwSlJIR3ZsdmN4L0xBWjkzdGdt?=
 =?utf-8?B?dzkvZ09nTGd1bmhpK0Q1ZjFXQXF6R2ZzSmxkemo3d2l3UEtYeDVUYzNrTzgw?=
 =?utf-8?B?TzY0M1FDeG1EZldaRkZxSVptem9kQVpWTjZ0dGV3RndKQlpaaUZzQTExVEJL?=
 =?utf-8?B?N05wekxOdjE0bUc5S3Y0OVViZ3JzeHJqTlIxcWs5TVZLY2F2N2VaUkk5LzVF?=
 =?utf-8?B?QUFlSVZ3V0d2cHZRanlTUGtKN0lXVGlCeVQ1Qm5xVk0yeWVOcWpqbzNSN2hM?=
 =?utf-8?B?dStTdlk4b1M5WjFVTmlwdG9nM2N5S1BtY29MNjUrSlJpMDZVN3dqdjlwVEtM?=
 =?utf-8?B?bkNkTG8wZE1tdmtzZFVPQmV5cjBDRVJQejF2bnpDNlptM3JhMWdXRlNBalht?=
 =?utf-8?Q?8L3yfwLLZo8IIsoydQ+3Bgo=3D?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 659ef256-f332-4e57-6686-08d99d3f25df
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6359.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2021 13:54:40.1009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OJRt7FiQr2A1aLZbAVgvH4OxBoF3s5kq6VraGT4hvkr2fbCykDXt8wUkoVGmziHtgSvxHnNjLCCsM2lf8pxVKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4822
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

 From 6e6a3661785584c6cc88370f78578810e67cb0e5 Mon Sep 17 00:00:00 2001
From: Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>
Date: Mon, 1 Nov 2021 15:44:31 +0200
Subject: [PATCH] iio: test: Add test for IIO_VAL_INT_64.

Signed-off-by: Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>
---
  drivers/iio/test/iio-test-format.c | 51 ++++++++++++++++++++++++++++++
  1 file changed, 51 insertions(+)

diff --git a/drivers/iio/test/iio-test-format.c 
b/drivers/iio/test/iio-test-format.c
index f1e951eddb43..f07945c2cf28 100644
--- a/drivers/iio/test/iio-test-format.c
+++ b/drivers/iio/test/iio-test-format.c
@@ -182,12 +182,63 @@ static void 
iio_test_iio_format_value_multiple(struct kunit *test)
      IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "1 -2 3 -4 5 \n");
  }

+static void iio_test_iio_format_value_integer_64(struct kunit *test)
+{
+    char *buf = kunit_kmalloc(test, PAGE_SIZE, GFP_KERNEL);
+    s64 value;
+    int values[2];
+    int ret;
+
+    value = 24;
+    values[0] = lower_32_bits(value);
+    values[1] = upper_32_bits(value);
+    ret = iio_format_value(buf, IIO_VAL_INT_64, 2, values);
+    IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "24\n");
+
+    value = -24;
+    values[0] = lower_32_bits(value);
+    values[1] = upper_32_bits(value);
+    ret = iio_format_value(buf, IIO_VAL_INT_64, 2, values);
+    IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-24\n");
+
+    value = 0;
+    values[0] = lower_32_bits(value);
+    values[1] = upper_32_bits(value);
+    ret = iio_format_value(buf, IIO_VAL_INT_64, 2, values);
+    IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "0\n");
+
+    value = 4294967295;
+    values[0] = lower_32_bits(value);
+    values[1] = upper_32_bits(value);
+    ret = iio_format_value(buf, IIO_VAL_INT_64, 2, values);
+    IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "4294967295\n");
+
+    value = -4294967295;
+    values[0] = lower_32_bits(value);
+    values[1] = upper_32_bits(value);
+    ret = iio_format_value(buf, IIO_VAL_INT_64, 2, values);
+    IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-4294967295\n");
+
+    value = LLONG_MAX;
+    values[0] = lower_32_bits(value);
+    values[1] = upper_32_bits(value);
+    ret = iio_format_value(buf, IIO_VAL_INT_64, 2, values);
+    IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "9223372036854775807\n");
+
+    value = LLONG_MIN;
+    values[0] = lower_32_bits(value);
+    values[1] = upper_32_bits(value);
+    ret = iio_format_value(buf, IIO_VAL_INT_64, 2, values);
+    IIO_TEST_FORMAT_EXPECT_EQ(test, buf, ret, "-9223372036854775808\n");
+}
+
  static struct kunit_case iio_format_test_cases[] = {
          KUNIT_CASE(iio_test_iio_format_value_integer),
          KUNIT_CASE(iio_test_iio_format_value_fixedpoint),
          KUNIT_CASE(iio_test_iio_format_value_fractional),
          KUNIT_CASE(iio_test_iio_format_value_fractional_log2),
          KUNIT_CASE(iio_test_iio_format_value_multiple),
+        KUNIT_CASE(iio_test_iio_format_value_integer_64),
          {}
  };

-- 
2.17.1




On 01.11.21 09:28, Andriy Tryshnivskyy wrote:
>
> On 30.10.21 17:47, Jonathan Cameron wrote:
>> CAUTION: This email originated from outside of the organization.
>> Do not click links or open attachments unless you recognize the 
>> sender and know the content is safe.
>>
>>
>> On Sun, 24 Oct 2021 19:58:52 +0300
>> Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com> wrote:
>>
>>> On 24.10.21 19:10, Jonathan Cameron wrote:
>>>
>>>> CAUTION: This email originated from outside of the organization.
>>>> Do not click links or open attachments unless you recognize the 
>>>> sender and know the content is safe.
>> Ah. One thing I forgot.  Value formatting is the only bit of IIO where
>> we have self tests.
>>
>> Would you mind writing some test cases in
>> drivers/iio/tests/iio-test-format.c ?
>>
>> I'll pick this up in the meantime but definitely want to make
>> sure we don't forget the tests!
>>
>> Jonathan
>
> Sure. I will add some tests.
>
> Regards,
> Andriy.
>
>
>>
>>>>
>>>> On Sun, 24 Oct 2021 12:16:26 +0300
>>>> Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com> wrote:
>>>>
>>>>> Introduce IIO_VAL_INT_64 to read 64-bit value for
>>>>> channel attribute. Val is used as lower 32 bits.
>>>>>
>>>>> Signed-off-by: Andriy Tryshnivskyy 
>>>>> <andriy.tryshnivskyy@opensynergy.com>
>>>>> ---
>>>>>    drivers/iio/industrialio-core.c | 3 +++
>>>>>    include/linux/iio/types.h       | 1 +
>>>>>    2 files changed, 4 insertions(+)
>>>>>
>>>>> diff --git a/drivers/iio/industrialio-core.c 
>>>>> b/drivers/iio/industrialio-core.c
>>>>> index 6d2175eb7af2..49e42d04ea16 100644
>>>>> --- a/drivers/iio/industrialio-core.c
>>>>> +++ b/drivers/iio/industrialio-core.c
>>>>> @@ -702,6 +702,9 @@ static ssize_t __iio_format_value(char *buf, 
>>>>> size_t offset, unsigned int type,
>>>>>         }
>>>>>         case IIO_VAL_CHAR:
>>>>>                 return sysfs_emit_at(buf, offset, "%c", 
>>>>> (char)vals[0]);
>>>>> +     case IIO_VAL_INT_64:
>>>>> +             tmp2 = (s64)((((u64)vals[1]) << 32) | (u32)vals[0]);
>>>>> +             return sysfs_emit_at(buf, offset, "%lld", tmp2);
>>>>>         default:
>>>>>                 return 0;
>>>>>         }
>>>>> diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
>>>>> index 84b3f8175cc6..bb6578a5ee28 100644
>>>>> --- a/include/linux/iio/types.h
>>>>> +++ b/include/linux/iio/types.h
>>>>> @@ -24,6 +24,7 @@ enum iio_event_info {
>>>>>    #define IIO_VAL_INT_PLUS_NANO 3
>>>>>    #define IIO_VAL_INT_PLUS_MICRO_DB 4
>>>>>    #define IIO_VAL_INT_MULTIPLE 5
>>>>> +#define IIO_VAL_INT_64 6 /* 64-bit data, val is lower 32 bits) */
>>>> I'm guessing the closing bracket is left over of some editing?
>>>>
>>>> Otherwise fine and I can tidy that up whilst applying.
>>> Yes, it's a typo. Please remove it while applying. Thanks!
>>>
>>>> Note that this is almost certainly too late for this cycle (we are
>>>> about a week away from merge window subject to whatever Linus says
>>>> for rc7 and new stuff needs some time to soak in next), but I'll
>>>> plan to get it queued up early in the next one.
>>>>
>>> Noted. Thanks a lot!
>>>
>>>>>    #define IIO_VAL_FRACTIONAL 10
>>>>>    #define IIO_VAL_FRACTIONAL_LOG2 11
>>>>>    #define IIO_VAL_CHAR 12
>>> Best regards,
>>> Andriy.
>>>
>>>
>>
