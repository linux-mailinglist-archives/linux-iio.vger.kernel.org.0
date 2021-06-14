Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6B4D3A5D83
	for <lists+linux-iio@lfdr.de>; Mon, 14 Jun 2021 09:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232424AbhFNHRs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Jun 2021 03:17:48 -0400
Received: from mail-eopbgr40053.outbound.protection.outlook.com ([40.107.4.53]:12401
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232096AbhFNHRr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 14 Jun 2021 03:17:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QG1fVmbHrG0iYkmHEesgR45TLAB8IGbX0JKCaqTMmBYE0t8JuOntO2vyOLI3WnribuAnUNQ42qi7lPsST+isB+Cfr2CRIRvRwwWdcbGbA44BwGejfJceS1Ktu+YhxvW88sF/V3550vbNvl2EYnlHhRvWA3RrRY5pSs7aFdjQ3Rk0XmaV62juWhcR6mXCDhiqP/xS3NGLsroUBbSs2c4j4kh9y2Rfgo/yLgnyA71AMXBpll7EB6RuR7YCxc/5fevugMh1S9dQG28aolg1sFemSZWq0mGUmK/WnViq4Qil3ySZpiDs0eZFPtwqcV26aK42GeYgPzeAkrkQVApk3SK4ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+5nmVqc7dUYtLhtIrnPXorutZaNazR5MtRVnR6Fe8c0=;
 b=foo2V/EU3x4MJ5qC776llh9z47kALb/3e3bnWiSVI67Cbh56uFdp3HRj+jB/FOMpSsLNGwVGPPxXklSomlmS/1BUcknjcD8r6pD5Gv9TjutUrsVy6IrKnfXNMP+8GQy8L14GoCKm6pTSTswM/PKbkbZZX/o/OpkjdhrDdtx3QJ1ZULXgOm1zPQiKvTKOaj2MJbxvl0yMXUd61qmKXqwli6RS/GqBo8/v47F4h2kpIsPulDXtHY8z21RUDxgODgaUkHWqr5qQKkVelQlZKKiuq8g8CDI1Px52Q7+ArNS/wQJ9aAXms6iPg0W1lbCEO9+8ysPQNDNxKstTtXrnyCjU3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+5nmVqc7dUYtLhtIrnPXorutZaNazR5MtRVnR6Fe8c0=;
 b=GpAUFiglIwmTDYk68am/u/xa+e8IERQyEk2oJbB/1SthS7wBF/c0+apZXI7ijZB7Q5yoEgeOw91Jv+Fpp/XxDcd8I7L4gnOU32q3lcdGdHwfXNC4L7AESStv41PdhXIxOgI5V2qR+rKxKNTRi0mtoM8cBOUFwMr8Ij7uHm0pnghwcI5Vh51jodeC8FvGQlDUCMma0jwOYyZgk4dKfXWwWBPM+rANIu85VVm4yXOmLF+DFK5Q8xLOaAWNDjAYoecFolcqymbK2mjmZk7lEaeXTv+CWCVbj32QKa7bMEnEuuUg1nd0kR5vbd5H2cO8V9aikR+6ZJbRA8AQBycBGCQjeg==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=vaisala.com;
Received: from VI1PR0602MB3568.eurprd06.prod.outlook.com
 (2603:10a6:803:10::31) by VI1PR06MB5775.eurprd06.prod.outlook.com
 (2603:10a6:803:99::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.24; Mon, 14 Jun
 2021 07:15:42 +0000
Received: from VI1PR0602MB3568.eurprd06.prod.outlook.com
 ([fe80::4ca5:d9e1:61cc:8113]) by VI1PR0602MB3568.eurprd06.prod.outlook.com
 ([fe80::4ca5:d9e1:61cc:8113%5]) with mapi id 15.20.4219.025; Mon, 14 Jun 2021
 07:15:42 +0000
Subject: Re: [PATCH 11/12] iio:accel:murata/vti drivers: Include cleanups for
 the sca**** parts.
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20210611171355.202903-1-jic23@kernel.org>
 <20210611171355.202903-12-jic23@kernel.org>
From:   Tomas Melin <tomas.melin@vaisala.com>
Message-ID: <68073eb8-8137-82a2-013d-690552963842@vaisala.com>
Date:   Mon, 14 Jun 2021 10:15:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <20210611171355.202903-12-jic23@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [85.156.166.106]
X-ClientProxiedBy: HE1PR07CA0030.eurprd07.prod.outlook.com
 (2603:10a6:7:66::16) To VI1PR0602MB3568.eurprd06.prod.outlook.com
 (2603:10a6:803:10::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.242.146] (85.156.166.106) by HE1PR07CA0030.eurprd07.prod.outlook.com (2603:10a6:7:66::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.9 via Frontend Transport; Mon, 14 Jun 2021 07:15:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b8fdd865-266b-42d3-7e60-08d92f04389b
X-MS-TrafficTypeDiagnostic: VI1PR06MB5775:
X-Microsoft-Antispam-PRVS: <VI1PR06MB57759BA1808D5CC3F9B58DF7FD319@VI1PR06MB5775.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cQDF+oW1oJewzTux7yqHIlDqA5qT6xwd/uBYdX2qbkhHcKajeet/XrpXIjm6d6eSpaXPSHn3xKPnDJQXoOj3x3hKCV57ScZrvse51HLiw4zA4psSnFUwhUYOVtpOiObqH5BoDdF8+4juYM+WL6AInvHme+pe1JndUpvWnbBhhVveY5PddYK2wg/OCo3SvlbJM7efFLV1br9/oEcwwGkGdm4eVDcJP6J0rsvMa0g8zq4f+LVrYpVd+c1LbZtG5L3YHxhacW7IMMfYsjMO9YnxxTUXDZIlB/koxOnzv1qIkVZ0CKgPbUEMJkMOfmRMoyifJIxoOZ+IFxeK09L6XsVwuGaVCMNkP0ZyJ9pElBD6PQAZY2OsEhr8BCpp8XMmx0korjcjusnXIzWw9cYldDyuI631p6Nxtbad0VmanWCby91/NeTUtNk92SlHGE/RbdLGJ3dBIb1SAs7SxhkzrSxv+ROSuWgrldSXDDwCP87/vK59NXMCkNr0bktfKIjcIA09BYDcohyNJzJGtfH9n5aJfuA2Cjdaq++op2kMKKcHmuHEmFgg3o+FiTRxwcmbC7L1X5GldG5sWoOfZt/yvrmEiXYPFiKYVUA2yw33n0jD/k20gVyCK0g8CyK/e2eAUonqxrXmMOojFF3h6oPXdN8TM3+tLh5zNsu2Mm1GMrTZd3Q2SMLR8w4ym2j4F4lv8v1hezrBfTJSkgYL2c0JB/w6HxIiX3vW7e+gCZkuLugKxBw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0602MB3568.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(346002)(396003)(366004)(376002)(136003)(53546011)(956004)(2616005)(66476007)(31696002)(4326008)(2906002)(44832011)(478600001)(66556008)(66946007)(52116002)(16576012)(8936002)(38350700002)(36756003)(31686004)(83380400001)(86362001)(186003)(16526019)(8676002)(6486002)(38100700002)(316002)(5660300002)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0p4SURPUHg2bjJTc0pydHpXNHkrTFZ5c0VMRm4yRVZqZHhsVksxOUZKeVdw?=
 =?utf-8?B?dVRlU3loT25hMFRveGxnRUp2aXczeXNGQytuQXEyLzhtS0s1YlhqZkVhUjg4?=
 =?utf-8?B?cjRMU1l2UXJsMDdtR2dSdldBU0MyNXIxNzlqMlNIUFVzRHFVU3plM1FQZjVY?=
 =?utf-8?B?TW9qanBiVllrNmg3cit6TXhab0RRL3hVZ0FyejhuaTBOU2FEZW8xVldHSkp4?=
 =?utf-8?B?cnhIL21UTUFvWGREc2owYXQ1bk1SaWtDblJiZEQ0d0RJU0dTeEdPSXR5TXVK?=
 =?utf-8?B?SExRZ3JPT0N6QUxhQkhqRHVXTmVLd3IxRmtwcGowb1JHRnFxTjlLNk91QVlH?=
 =?utf-8?B?a3A1TUhqL0JBNGlzUlFaR1p3WUxnRUdRNXEwMWM3azIvUWMvMERMVzB6SlUx?=
 =?utf-8?B?U3dPWmphc2lkdWhXVEtBWHpEYW8wblI5Q1BqOHo5WGJQUC9PazExaVVJTkpQ?=
 =?utf-8?B?enhOS3lYVzd2TXQwNElqeEdHM1JoRldsNFY2dnRMS1FlRE0rdkoyS2VJVGx4?=
 =?utf-8?B?U24yU3B1dGV3ZGs5L0pyc1FqcEpsbFFRdEFnTVdLcTBlMEgzZWNWVEx6R1R5?=
 =?utf-8?B?Kzk2ODdrT2hGdG1LYlI0RWNhdnVkZjZMQnl4Z3lVK2J5dFlXSWdCTHVKY2Jt?=
 =?utf-8?B?MEs3U3FyYkJvaUR6NWZiUHByY2hUMGpKNk5kYU50L3N3SXBFS3oxNzZnS1A0?=
 =?utf-8?B?UW0rY2RvN2dqR0dhU2tqQXdkNjVDeUVrK2tRbTFpNFN6SHdoRjBNV09qNlg2?=
 =?utf-8?B?c2hiZ0wyQmFlRElIKzJMMHYzejhWd3lhSTBBdHE2NlpyNmJvVEtaS2dCaHl1?=
 =?utf-8?B?VjlHZnp0bDFaTHByYXFOR2UrUTIxSzdCc3dqbW45TEcrNlZtc2VkWmNOTXdy?=
 =?utf-8?B?UzVFN0g3THIvWm1KUzNsbVZnOFdJRDNXSS9yTVhUamE0RFZ0SXFadE5Tc3dI?=
 =?utf-8?B?MEFvTVBTaTQ0ZkZqWWlod3lLSU9NQ2xXUTJRMS82bFRIdnFtYlhDQVJDMlZL?=
 =?utf-8?B?K2dPQXgxM003b3dPM1FtTmdUeUVBNHhjQ3BydUFOR3BoSEIzSnM2MzJCT0di?=
 =?utf-8?B?em5wNlRpYkVoYjBsV3FBaTdIZVFQUXd5SW5lNWE0empPS1VheFlqY2V5WDZ6?=
 =?utf-8?B?NUlXeUhRS2VXSytPc0JxMFNiV2E2OXR4UlVPVVE1N3NFaWZqbi83OFJ6M253?=
 =?utf-8?B?b0hSN0w4czBITDh3R0hyOUUyYUFJblAvekNYSEQwVU9uanB4M21oOEczR2hQ?=
 =?utf-8?B?VFRVYkM1OU40Vm9ZaEcrMVhCN0V6eTNXQmJjMDBrVmZRK2wyWlY0dHRGRWk4?=
 =?utf-8?B?TG1HUTdlSmQwOU10enFES0ZxNVA3MnpyNTdPam1lYTJOZFk2S2xNRHRLV2hS?=
 =?utf-8?B?bGNYckYvc3p4RUNZMlZ3QjVSSmtLUkpZVU5LbmFaSVZ4R2EyUm16N01LWVhF?=
 =?utf-8?B?Z3cwSjJXRmMvU3Y5SVExMmhEaEdZMDhrKzV4ZG5LUU56RWI3NkxseFc1QVox?=
 =?utf-8?B?NkVRZ0hhekphN09CMkUxNHNkRklJUWo4N2gwZS9mZk53czBpODdRUGJtajFP?=
 =?utf-8?B?QXl1SC9SRnI1VG0zaHNBM1d6V3g3QXdYMDdZNlZOcStDbFhYLzNSZStvbC9K?=
 =?utf-8?B?UkQveHVBY2phcmdoZkszRHQ2eCtOdHZWU1FqRUFFUTZneU4xWDFoSHBqaXJK?=
 =?utf-8?B?Z2ZCdnh1NFE4NUx6YmNOejZhSmtPZ3FKeXdHUjZaWmdxNkhpYU53UzhES1VP?=
 =?utf-8?Q?Zm26gZOtYuW273M2b5q0c7A2LEbJT2O2KT5xp75?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8fdd865-266b-42d3-7e60-08d92f04389b
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0602MB3568.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2021 07:15:42.6784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I3K+5ZRGvX537HmiqvbK8oC71SoJ/UWN8H4ZU8509VQS4+jHytqBDJGJde3pN2D6igTaYTmfqxxL5qLXL3h5bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR06MB5775
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


On 6/11/21 8:13 PM, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Based on consideration of the output of include-what-you-use.
> Some unused includes dropped and some that are directly used in the
> files added.
>
> There are no hard rules for when we should rely on includes being
> there as part of including another header and when we should do them
> directly.  This is part of an attempt to be more consistent on that
> in IIO.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Tomas Melin <tomas.melin@vaisala.com>
> ---
>   drivers/iio/accel/sca3000.c | 5 ++---
>   drivers/iio/accel/sca3300.c | 3 ++-
>   2 files changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Tomas Melin <tomas.melin@vaisala.com>


>
> diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
> index cb753a43533c..9f4bbf23834f 100644
> --- a/drivers/iio/accel/sca3000.c
> +++ b/drivers/iio/accel/sca3000.c
> @@ -8,14 +8,13 @@
>    */
>   
>   #include <linux/interrupt.h>
> -#include <linux/fs.h>
>   #include <linux/device.h>
> -#include <linux/slab.h>
>   #include <linux/kernel.h>
>   #include <linux/spi/spi.h>
>   #include <linux/sysfs.h>
>   #include <linux/module.h>
> -#include <linux/uaccess.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/mutex.h>
>   #include <linux/iio/iio.h>
>   #include <linux/iio/sysfs.h>
>   #include <linux/iio/events.h>
> diff --git a/drivers/iio/accel/sca3300.c b/drivers/iio/accel/sca3300.c
> index f7ef8ecfd34a..2042d8baf7b8 100644
> --- a/drivers/iio/accel/sca3300.c
> +++ b/drivers/iio/accel/sca3300.c
> @@ -10,13 +10,14 @@
>   #include <linux/delay.h>
>   #include <linux/kernel.h>
>   #include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/mutex.h>
>   #include <linux/spi/spi.h>
>   
>   #include <asm/unaligned.h>
>   
>   #include <linux/iio/buffer.h>
>   #include <linux/iio/iio.h>
> -#include <linux/iio/sysfs.h>
>   #include <linux/iio/trigger_consumer.h>
>   #include <linux/iio/triggered_buffer.h>
>   
