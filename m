Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A59F3875EB
	for <lists+linux-iio@lfdr.de>; Tue, 18 May 2021 12:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243070AbhERKBe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 18 May 2021 06:01:34 -0400
Received: from mail-am6eur05on2097.outbound.protection.outlook.com ([40.107.22.97]:7354
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242636AbhERKBd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 18 May 2021 06:01:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B/t/SCbhPF0myR9OG2/srJOUAo7NDHxOlWD5k7HfDLgIT4a0CvCnMMvi4kyGl6Edj9Dpng6xWdOWsXXdDXSuiEvfjKQU8oBcf7B0Xfnhv6oLm4ClXBgvF3BxPb9HE0PQdYnEHujxIMQKllnJPlg0bf4byPK22bxLYpKHxi+uj4EDqKjNvNudpB2mMqdzycmVxfPooDVX3G36MOsKsRxJzIbaty0eIfr5WPiLRINiHStAq0mGSN/00TUY8/LlafrXZKHTkOo1wXfTO2Oihpas/BOEBMquXRGPfMvhLVdAA7MaHP6reR8dt26v0yL1Fgo1Z1RKvTO/Ldw03bIdyOFy4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jzR6jgMh7KbsKE5rzudqHwkJ4ctsNZ9J5MSlrWYOBG4=;
 b=O4gVm+mY4MDB2qU+/9hakMnqxQ5OKNwvT/RNyhbNzeOtT8mkmipD2nsNuipR8bzYvKgGpC8hT33SnSKqsGQHQKNjePeNZtImUQDvIsVJkiU70SOlvvQSMDi7YZ+reG3JVbRlotXvfMHCFTD9ra9YVrxn/17tzfQSA7C0ov3hPXIkFFygi/C3dT+2gPp2yjENlLbDnKEGZlS0cPcEaK6b/JgOCkt0BinfEBGaImvgZ/31u+c62RpI4c5tDQepvYWrTK4PdDhKc6meXk1DuH4ErfVhGudCs54OU1ZzgH7viIXmiF0VhJGVvfL0wIYc31gHsg3WgWjYnFWvJr9UTbI1OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jzR6jgMh7KbsKE5rzudqHwkJ4ctsNZ9J5MSlrWYOBG4=;
 b=eWzVzGUjw0UD9QDpvggyUGDJhtHOadsilIkrU8gMcmS6zn3ar/fxM8CvwEn1QfvJUJ9U74xfKY4gG1V9TgHPIIS2vv3jOHtbXWAMI6oPK8AOWdP4IalzJej2sTnA/EdtkPRQF6ii6Tg7si49jT4q4CZzOw6Ie9TsmDOr2zWNnH8=
Authentication-Results: pmeerw.net; dkim=none (message not signed)
 header.d=none;pmeerw.net; dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB6PR0201MB2248.eurprd02.prod.outlook.com (2603:10a6:4:32::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Tue, 18 May
 2021 10:00:13 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::d47d:ca8c:4fe6:3908]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::d47d:ca8c:4fe6:3908%3]) with mapi id 15.20.4129.032; Tue, 18 May 2021
 10:00:13 +0000
Subject: Re: [PATCH v3] iio: afe: iio-rescale: Support processed channels
To:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <20210518092741.403080-1-linus.walleij@linaro.org>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <b98b4f4f-31e2-7289-99c3-71f5b15305f8@axentia.se>
Date:   Tue, 18 May 2021 12:00:10 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
In-Reply-To: <20210518092741.403080-1-linus.walleij@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: sv-SE
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.229.94.233]
X-ClientProxiedBy: AM6P194CA0092.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:209:8f::33) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.13.3] (85.229.94.233) by AM6P194CA0092.EURP194.PROD.OUTLOOK.COM (2603:10a6:209:8f::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Tue, 18 May 2021 10:00:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a714daee-f1db-44ad-11ad-08d919e3ba91
X-MS-TrafficTypeDiagnostic: DB6PR0201MB2248:
X-Microsoft-Antispam-PRVS: <DB6PR0201MB22488D68305537D71406CF4ABC2C9@DB6PR0201MB2248.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3agZ5+ssxX15KAjJRwq9el106rylq00h1d+SEOxEKI7iP+4KDYfBFgJUlWrPEWhhoGxYu+YXB4Mzp2R0EQgeWe49dbvaBNMQEodJBvcyt16z2adGMhPW4cxh6O/STMnLi0Psp17GrhyFClMDvheJ3Wy0mFH1OqEIzC9ZXX4MmMsQQO/vBMhEh3eMJX1EZJQLU6hKqj174cq/qMCpc84UXfbPv098MZPDDiGWqSnnKasZLaKatRY51ysuKjsr4S+pVnkjQTojEon8/uQAbn7Uf40gN8HXe+vbxdjuc9tqRLOtJ8tUh1CVXZlF1a42N58bVCI6Qula0B2grmcLH2ME/3sOZ43X8scyv2xVRosOH/P+BZpcCCvVr8MGHCCFHl0AUruoUC/6i7119yuDGnCH1LpAOn7Z9JthN7SCKui2w8YQsV9BDs98hFOJ9iWBLH6odnSEmGOoiomluqbE6nN5iVq5Qq4BWjg/qG4VYxyUyBCcrZcPCvNdzsnNTz65FkawsOJ8RuaxWRUtEPAwOtJBiXb3TMR594R0s6xD77UOnHVAgJG6ZUbO8HOBoIydd31tjlg7IxahzTdi/Q92J2/L2dn5vblwNyOc0g1wyNv7G/kCDVWQucxGNXTHzEzbbBa1P3G/dA430lq6x6JOiaAJALwAB+V+L+QlhMD9d3RBWDx1mAoBt7LNJBW5p9AIviEE1nLjbsNj/M9x6OGI3BwcwYyxw0OWJAu8qog2XLLJHAf/p6g/uBBv2hJbzLd039OSzsxSKQOHtnRfbggT7xYJr+LzhB56lZ4TH5C6bm8svxk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(396003)(136003)(39830400003)(366004)(53546011)(36916002)(16576012)(316002)(54906003)(5660300002)(26005)(2906002)(31686004)(66556008)(4326008)(956004)(38100700002)(110136005)(2616005)(966005)(8936002)(478600001)(66946007)(86362001)(6486002)(4744005)(31696002)(36756003)(8676002)(66476007)(186003)(16526019)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWhqcVM5MkNjTGhjWktjZHBhaWJFSVIrdG01Q2UxS0xIREIyZWVacXJ6N3NF?=
 =?utf-8?B?WUMvOUZQdG82YmplcEdocjlncUltK2pSZEt6YW9TSDNyVlR3Mzl5eFlYTkxr?=
 =?utf-8?B?Si9Wc2I1VVJvd3JmV2llRjhYVzgwQkNSMHJINkl4dUdFcWZ0K2g0REt3K2dL?=
 =?utf-8?B?U1Fqa1lCcGNhcXBuVUk0bXJ6eGl6Z0tYNjVsYXVsUHlEeEQ1eG45Nlc1bEhD?=
 =?utf-8?B?cmZjWkdySGFpZmY0KytBc2k2Q2s0TkNxK1pHcm9MNXhPVmkyeHNJVUVEbzhr?=
 =?utf-8?B?dGx5N2ZKVkhxVEVzekI5VER0OUFpR1JHaStxaTdyYlh5elVadVFua2h6bGxk?=
 =?utf-8?B?akdnMjR6UjQ3b0wvQkxUZ3hkZmNnYTg4aVdJanlSUkwyMURabTRWbVFkeFF6?=
 =?utf-8?B?Z0RPZFF3NUxKMHNuT3RkNlhzWG5xNzcyWmNtSGJpUFZIMHFoU3pXZ0xvd3o5?=
 =?utf-8?B?NG11UmJYd1NDN0ZMcGZmZ2hHMm5KSzZPTDdQYWV3OHdqaUNUdDNYSVpLVlpE?=
 =?utf-8?B?UW9kbmpiSEw5L3R3S1I1UE9TVit5cTZJVWl4NG9ubGFBcDdTbU1kS0RuVzFs?=
 =?utf-8?B?a0ZZOWVQVmlyTVJxQ1NYc3FoeEZVZlpRTmpKMjZ6M1ROOGdoaHhLdkMydWZs?=
 =?utf-8?B?MVpwOEVoSmFDTE9ubDJWaEtNSHFlaU9IclNYRjc3ZUp2c1dTREdJMnUxdmxL?=
 =?utf-8?B?SStSV3BHdHQ4TTRicUdKY0sxSjJEWVJZSWsyaHlIKzlwTXh3eUNPdDhCU2pH?=
 =?utf-8?B?cEM5UjU3MnkvdU90UDhVYWd5RnM5ampOdmFQd2hJVUhsNzBJa25Gc0FmTm9u?=
 =?utf-8?B?NHh0TGJOS2NUUUtzSThaUC9PVWx2WFJ5aGFiOS84dzdMTldsSGs1dXE4eVR0?=
 =?utf-8?B?L29hek96RTRGUnZQaGE1bExpR0c3TzdzdVhKb1BheFFvZHo3eVBKc3RCVUlu?=
 =?utf-8?B?YlhpZEFoYUpUb0wrcVJWTGRXWnZzQ3VtN0pqSnlyV01lWXBuMXV6K3dNY1hj?=
 =?utf-8?B?aDgyNGF3WFNyYXVLMlNSbysrZGVqQWZXRGhJSzNYOTJseEhpRGdoUnFZZWJx?=
 =?utf-8?B?SzZ6dkhPeGFBclUzcE5ZSkZVK2tiZzRRK210Z2NZWXJ4UDR3Q3J6dUszdG9U?=
 =?utf-8?B?Vm43dUlZb0c2bFJJamYwR3BTNmNrTmhJbmpvaGkrL0lZZW94SU1HbkR6TGNk?=
 =?utf-8?B?QmhTT3pUUFo2TzdMaVhQOUdlVUtTL2p4K3FVZXlLSWdvanB0T0hqV3U0MVRo?=
 =?utf-8?B?TUJlWjBROTFtS0VYYmRkbmxwaHdzdXB4V3RLRlk5d1lCQ1N0UGhXdXljMmYv?=
 =?utf-8?B?b1RXZVlhRDdXVStQNTZmVWp3TEN2SEMrMzF5YWpZUlpsSDU2N3UxN0g0VEZa?=
 =?utf-8?B?cnlFVGQzTHJiLzZsSWM1WlB1WCtBT3pDSEYyQW5vT1pQU2ZKcG5VTTFPeTR3?=
 =?utf-8?B?NEdOTERzNFhYV1F0Mk11Y3ZkNVo5ekljaGl5NUEzT3loQVlIMEg1a3dLQTVn?=
 =?utf-8?B?WUdGVmNpY2FzSWcwVkRFT01KckVWcUZ2Z3laTGxwQ2YxV2xvTnBSNGlRZ1lv?=
 =?utf-8?B?c1YvWktQak5JZlZkTU03dk15NTFUL1hnWU0vRXZRenpjT29GTUl6emVTUXFT?=
 =?utf-8?B?akdzamFrMFNVVytQRURJVVZXZkhWUFQ1S0dwT1pneGE1QkdvYVQvaDZkNFZZ?=
 =?utf-8?B?Z05DbkhKY1pLdUZ2RVphaXhUM3NxeDU3NW9FT2N5TnF5a2tIdnZyaVFtS0dE?=
 =?utf-8?Q?dhjCCchIteinaLNo7cbYVvuRfv9IJQ6nOmn/cRk?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: a714daee-f1db-44ad-11ad-08d919e3ba91
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2021 10:00:13.0644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jgLEpHZkfq1rPj/cPtUdI4loDBBnrGqs/mhkPsAmWKyHjd9SzrHPLwJk9ZiZEql3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0201MB2248
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi!

Thanks, this looks nice!

On 2021-05-18 11:27, Linus Walleij wrote:
> It happens that an ADC will only provide raw or processed
> voltage conversion channels. (adc/ab8500-gpadc.c).
> On the Samsung GT-I9070 this is used for a light sensor
> and current sense amplifier so we need to think of something.
> 
> The idea is to allow processed channels and scale them
> with 1/1 and then the rescaler can modify the result
> on top.
> 
> Link: https://lore.kernel.org/linux-iio/20201101232211.1194304-1-linus.walleij@linaro.org/
> Cc: Peter Rosin <peda@axentia.se>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Peter Rosin <peda@axentia.se>

Cheers,
Peter
