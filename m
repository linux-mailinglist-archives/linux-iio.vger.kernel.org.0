Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39AC6426D2D
	for <lists+linux-iio@lfdr.de>; Fri,  8 Oct 2021 17:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237929AbhJHPDj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 8 Oct 2021 11:03:39 -0400
Received: from mail-am6eur05on2095.outbound.protection.outlook.com ([40.107.22.95]:53425
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242765AbhJHPDh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 8 Oct 2021 11:03:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I6XyM+9Gz8l0F0xDrmjeq0CxNJKqxaJD7Bsg7SzrhKMedKbJkT/sYse5b6ZCGdiYEzVQhtoc97ddr9VRQwqdPkg/i7bso3w51GuUCs7kce8QgkTadENQuzOSU1Tj9JaVkPe+Z6sTloP/94Z5Ap2P2FBxpNgU7Lch+c0KKxV+bxqJEd6cVxBDEp07Oa5sb1q1sGEy5aJWiIjUUr1hVV3Bt4NPGPcwicw1mNdcNWwRc/MJCduYke3TZKl2gPjSaMyeQMiMFJ1nWspTXQz5/T0XC2gg9NcXfOB/NyCkgeTrZmuXvL771c+XHGrbOCEzIon7kM4B5IIS29nBYVjCKKTRVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZQ1Zj5m/l8r1QvnmXsxvyzGxbUGMpftQQqn/rNKwkrM=;
 b=iMCVG8ff/6R2b/1OzqkkqQwwxFw5299usT2Mz3fTUalWEzRDUTbfMlzRO2XEIqvTKbewVbok4lgoP1XXyu9qSwWFnjFPoIfOxEsaeTys+oOBNWAwEsTeN1Z5JPzTRCpL+FhbCpjtSZHEbpq5Y7CriYU/m6L8tosCBcEXL9qBg6S9Lz/lYBttrpjZZkbR0ePQh4UV6KTtT0KMFRosvdo5DCtNs4rwUkKdDp5cCuEhdL7KDeH1LZ7Rs4KMnGzinycoDPsx8JZwWfu09fLRMZVi9sKeEvrv/llHDj7Eb0Aao25dK9mXMOjIqP4kny0dky04S+6OpKNQBb+6Mxh/qfebRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQ1Zj5m/l8r1QvnmXsxvyzGxbUGMpftQQqn/rNKwkrM=;
 b=fXlyEh5lZsuFS6ahxqqDcu8aIyRaFH3vk9xapZZ/yZmV0Yo3GW5o8+OlXnqFVd4G+hBw8WOQ3z8CK/sGDRrXPqS0D+j0z0PQMwV5WQNuALeUhZBGjtSQLbDdn8eynYvN4aTdYKhOh7JNIOsN1Jh3f4NMA31vJj62GBRTD86xEng=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=opensynergy.com;
Message-ID: <81b122b0-8679-f6be-d193-537e95670cd0@opensynergy.com>
Date:   Fri, 8 Oct 2021 18:01:37 +0300
Subject: Re: [PATCH v4 0/1] iio/scmi: Add reading "raw" attribute.
Content-Language: en-US
To:     jbhayana@google.com, jic23@kernel.org
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vasyl.Vavrychuk@opensynergy.com
References: <20211008135842.21896-1-andriy.tryshnivskyy@opensynergy.com>
From:   Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>
In-Reply-To: <20211008135842.21896-1-andriy.tryshnivskyy@opensynergy.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR06CA0123.eurprd06.prod.outlook.com
 (2603:10a6:20b:467::14) To AM6PR04MB6359.eurprd04.prod.outlook.com
 (2603:10a6:20b:fc::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd195536-9f67-4919-5b80-08d98a6c87f1
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3846:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR0402MB3846E7C8EF81F1B6F7E87A9BE6B29@AM6PR0402MB3846.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: utJ+7bumTJYNpAAZXoCxtuQ/USX57CFkF5SZcE37qOyEgc3aOmEyjIbR2GHSD1RbYRgVGc3SXXdl8Bj3gR1m3DGnYx4o/U/LsOznWhSRQ4NnD0tnHLYaWlsHYITiTbYdVI9HnL8Hj7LMfMtXAfWuOI6vKfsklRykVVlkrMXI1Q8rOcIIksKbN3KqJtKho60rk1n5LqdZS2hbnjtCYVJ7mVhM2KCk/a3Dy8CQh7rquOn4qDFiMvXBEoWWDEcim8oxninrJsU/IUgZpeUMCQ1RJjXs85egA2h73ipXKg5yVKtrrrRA1/7OLLiP/sbbAluOqbdcZwUObQjmQdSsX1awZzGpCZbGl9Oeo1i+69ksCFYtcpanX4VPKe4CFX/X1YmSKQyHrEyl+eAKdl1/+ha0chWwI0BSpd6fOhJKb+7qgh28fS9W6HOJ0t55kLVpoWrSzdDQJasdolknK1N/jddgC8ggHcdXcRP82r+XBPfAdiYdB2XNQCGVeZRMz/ndw3J1X+UYRGiAquCDI4xdz7QppAJ9R6bpAYEi78VlweM9TIgf8/Ba1EfyAUFHYFDeonzbyFGk2EgBK7RAtGfZABxJRqHSA8Ia2k/RZFrFd5XjUxzLZEslXZx5R6yHWtey1B0OOFMAk8iwkcAT6Z36dp3ctw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6359.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(396003)(39840400004)(346002)(376002)(4326008)(31686004)(42186006)(38100700002)(4744005)(8676002)(83380400001)(316002)(8936002)(31696002)(86362001)(2616005)(26005)(36756003)(44832011)(66556008)(66946007)(66476007)(2906002)(5660300002)(186003)(53546011)(107886003)(508600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEIrQ2k0OFZrMGVFbDRDUHlzYTdvcFA3TTJqMDVSMkpTeWUvS3pkM05vUGRj?=
 =?utf-8?B?alR1QXdaZTJPZUlPTnFNNlQ5ekdHdlA5YXpDVzJuSCtLaEZVNStUdStuRVlm?=
 =?utf-8?B?S1NMc0hTWlR3aFpOdlludjFGQ0x5TlVPRUJJUFBQa2lrRUsyWHJxMXJTN3V0?=
 =?utf-8?B?R3VKOHBDZlN2UzhZaVMzVVBVRGhaWXpTN1h1THl2QVdiOG9hS1UzVjA1SUxL?=
 =?utf-8?B?WjFGM1Bic0c2ZCtrcFh1OUtDYlFRRDluNGxEc0RjSmFSNzFtTkVWc1I4eEdQ?=
 =?utf-8?B?dlZNcU1ONlVUTVdWZjcya3Q0RUpDSmMvelBZZ1k0aXlCUEZsdFRqc1IwZHR5?=
 =?utf-8?B?N2RsaGpsajc5UnlVQWptU2wvdWpXS3dJZDNqUUxCOVJNbjVyd1lwaEVJZ0lh?=
 =?utf-8?B?STFYT0hEeDk2WmVteEY0VEZGNXJya1YrNFMyMnA5TVRtMmdMOWkrV1NEdlp0?=
 =?utf-8?B?SWFPL255UzJyQjZta2t2a0hsbnFrT3NLVXBKaWNQM3h1TW9qOVA4ZVN6eVRB?=
 =?utf-8?B?b3dLOHNLNzhaNlZHT2drUkhXdUpWdjF3R3pJVU5qK0VXVHpXN1NOTWtXS2Zi?=
 =?utf-8?B?Mnk1VFcwSENndlpMVTJ2UGdKdXhxY2wxUkh0VTlKTVd5VjExbERvMHNsRTha?=
 =?utf-8?B?cXNUNFl3emxYL2UrMCtwQ05La0sxaTJ0WmFBUnVCNTV5ZDZUbGc2RWk4TkxY?=
 =?utf-8?B?Q01IQityYXFZNzJYM1B1NE5IbE54N0JreUtlMUxPOEZGSWZBMWdtK2JmbndB?=
 =?utf-8?B?d3RyZ2VNSUFTQ0orSFZwRC84dUpINnN3VDc1V2ttSytPRzRybHpDdjVUbmVR?=
 =?utf-8?B?T0d6TTNHT2ZUSWNSYjhLMXhVQXBacW9iQmplNG11cUpIaTBoa1MzNndDcmE3?=
 =?utf-8?B?YmpuNnFpanV3dXk2Z1BoTHlQbzhXYlYvWWN4K1I1WnFvOTNEemNFbXdOR3dD?=
 =?utf-8?B?bzRYREQveDdyUFhqRzM0cG8wOFBzV21Bb0VLczdranMxSERZeTYyWWRNRS9D?=
 =?utf-8?B?cTBUZzJPeExXb2t4dzZSMnhubVg1dEQzcWh0OGFDTjNKSzBsNlNGUGd0NFBa?=
 =?utf-8?B?aWFjYkw2blEzbisvSVN1bkRvOGlGMm1yR1pzMU12Y2NFT01ZcUU2SFZFSlJk?=
 =?utf-8?B?U0N5aWt2bE4xeUlnbkVFdUo5UzcyL1FkRE5GeGtDcnRPN3p5NmwrVTM1eUV5?=
 =?utf-8?B?Y05xS2wzNXQyaU9ZbWVyOFdXWURBR3k5OTRnVUdJcjRaTFJuN2FJMGk4UWMx?=
 =?utf-8?B?eXpMU0EzcTZOeFoyUE9nZlRHNFpqb0lsSXlqMUVSaUVBNVI5OHVQNGU4b1Jt?=
 =?utf-8?B?ZFViVFZMMkllc0Q1SWtlTHlDTnR2TmZHV3dRWW9wNTdHdHlpdklYNlA0MVRs?=
 =?utf-8?B?a013RFYxS0ozV2pKdU9rZ1RTdGxueUJhZzNJY2F4Y1o4UkpWSUJsaUFhL0Nr?=
 =?utf-8?B?QjVDeFBDdmh3L0dWYmt4V1kwRXVyZ0hEUmlaUTdOd2xySktKVVMyQVdLUEZj?=
 =?utf-8?B?U3ZwMldBcXRqUkZKYWVWaEVUWFNtVWZDVTFRdVZRbUp5d0FLdE5PaWczMW1I?=
 =?utf-8?B?RlJ3LzZ4RkNLcFRKcWl4Y05MS1ZBcitscVZ1alRyR2lHWkRUUVRYUDh5ZWNN?=
 =?utf-8?B?b2tFQkdobWs1QVY3MlAxVXMyMnZ6UUg3RTA2TXhKVzZxY0pjL0tIZndrR0M4?=
 =?utf-8?B?VHl1b0RHY0NJMHEvaUcrNVEySUNwcC85bFR6QU5kcVhieVIrbkRVTERZV09Z?=
 =?utf-8?Q?okvaN8wCjrWq4QKm/Z/1kMBskOI3oxMtN1R6Y+t?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd195536-9f67-4919-5b80-08d98a6c87f1
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6359.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2021 15:01:39.2817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v3pj1o4X+winZYwuDneMJhHuGJm6ckw+0q7mORl2BCq+4R05okW6thDJLnrtaB3lUkGfBkcBxb2ATBneDyfSmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3846
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi All,

Please do not review this patch version, since iio_device_release_direct_mode is missing in error path.

Thanks,
Andriy.

On 08.10.21 16:58, Andriy Tryshnivskyy wrote:

> This patch implements reading "raw" attribute.
>
> The patch is based on v5.14.
>
> Comparing to the previous version it has:
> * do not use scmi_iio_get_raw() for reading raw attribute due to 32bit
>    return value limitation (actually I reverted the previous v3)
> * introduce scmi_iio_read_raw to scmi_iio_ext_info[] which can return 64 bit
>    value
> * enabling/disabling and reading raw attribute is done in direct mode
>
> Any comments are very welcome.
>
> Thanks,
> Andriy.
>
> Andriy Tryshnivskyy (1):
>    iio/scmi: Add reading "raw" attribute.
>
>   drivers/iio/common/scmi_sensors/scmi_iio.c | 66 ++++++++++++++++++++++
>   1 file changed, 66 insertions(+)
>
>
> base-commit: 7d2a07b769330c34b4deabeed939325c77a7ec2f
