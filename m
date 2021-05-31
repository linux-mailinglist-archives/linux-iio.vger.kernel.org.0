Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83E7A3955C7
	for <lists+linux-iio@lfdr.de>; Mon, 31 May 2021 09:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbhEaHLc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 31 May 2021 03:11:32 -0400
Received: from mail-eopbgr80115.outbound.protection.outlook.com ([40.107.8.115]:36489
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230070AbhEaHL3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 31 May 2021 03:11:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DL/fUX5BYhwXAHMlHAUlJZTttwQ+7c480npp0CeQJBcgY+BEz+cXoYkvLks03TLbESLVStDfRO5jAGHNFd00SKKeJQ10Vf7P0IfT2CFnvd4GLi1SxA261zTofg2AXy4YGEYXwBYF8OC2iG8WFIpjlZ+5NBdAFerL5Od/8+fwjjenhZMOBH0QyHwDpoNNuJSu5uIKttacNbwVRTvG7j6NNmQy2pmu+kOlGmeTY28jset8m+qo8nlGKkFxpBItp3a/M4x2Ubrd99mD/TTxcaxyhR5hd1QPYmzKIYwi2c0fD1DWufqfZwike7ntyromXOnt8WXcIBgyTKxijS7vmdVqKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ts48+qMqODVn6fwSrkdb8gR7YCE8yWea0y783V3fUWc=;
 b=Kr/MczDjDxuj8zjc0qil2BH60Bs1iNyue2C7MfYjHDMqnHqra8Q9pzt8lx5JGNuyUjBCJMUn73dxDQk6RfklqiJfllbH61tgntdBY+dgHvbc68CxsGgP1GlXI2gfZHvatjMJHwtF+VGXHwb90TgVmPsF7n+hj3vJDgVmVACYvXhU2y0qCqAeY3qacbNdusE2BJ8w0vG9ingvR6g5GaDcBFmGTuhyzRkvKAeFkQSXRhfdkkCqEffj1Kv5Xbw5hFEE94FbQsKdNrOxFEik7mX+V9BZip5h7Oc0+b+RUtIbF0jBWZw+Lw/EVw4dCDrjC3X7FTnZzMvJPLUJgL/q46CJ3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ts48+qMqODVn6fwSrkdb8gR7YCE8yWea0y783V3fUWc=;
 b=nt0tbaYIK+/7xSghi93X0x9c5x7k4xwls0kTrPNHJ6QprV5i9ujUi5T4pxwwe/CNi9N0TtaQeS6KMafhMx1Shj75qbSYT/IeokFwm+eA72IJUx8b8qci8oC2zNOALPN2Cr1yZSqs6oBy6Zv9GgrSP/ScxTPsIvpL9BWxrJvaQkk=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DBAPR02MB6421.eurprd02.prod.outlook.com (2603:10a6:10:195::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Mon, 31 May
 2021 07:09:47 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::d47d:ca8c:4fe6:3908]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::d47d:ca8c:4fe6:3908%3]) with mapi id 15.20.4173.030; Mon, 31 May 2021
 07:09:47 +0000
Subject: Re: [PATCH v1 3/9] iio: afe: rescale: use core to get processed value
To:     Liam Beguin <liambeguin@gmail.com>, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
References: <20210530005917.20953-1-liambeguin@gmail.com>
 <20210530005917.20953-4-liambeguin@gmail.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <fb9bde38-6980-4241-6efe-fbad36dd8a2e@axentia.se>
Date:   Mon, 31 May 2021 09:09:44 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
In-Reply-To: <20210530005917.20953-4-liambeguin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: sv-SE
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.229.94.233]
X-ClientProxiedBy: HE1P189CA0030.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::43)
 To DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.13.3] (85.229.94.233) by HE1P189CA0030.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::43) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Mon, 31 May 2021 07:09:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd2741f7-c44e-46b2-8b99-08d9240312d8
X-MS-TrafficTypeDiagnostic: DBAPR02MB6421:
X-Microsoft-Antispam-PRVS: <DBAPR02MB6421D573ACE190057A140508BC3F9@DBAPR02MB6421.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0L6HjMfKUKy5/ObBbJX3/hcFcUBrEjx1U26F6kbCyFwkqK6u5RtbOF6J0Ow6DQCfAhAfyPIRTLSlIHDrM9lVgUBq2eqZLF/wZiDZuyNiKiAgnLII69rKIjXznvPgFhJrfhFGAc9hm1mSwKdnil0IlxVI9dVH7XTwoOH5vzNB2mAe8ud/jEgHCw1TwWWK3GvmUpSxdHful8ZT7QCd3FyPOnm2Y1pYfmtm0MDHcfSi5OLmVsQHvBJsYpDRmRamwRgy7NEjurQb0waJkrElCa9jJkZj0GaR5/JM+NUl81taGZFtbohK3bL4+eZUehUms1+hZY84DtFRo1ZJ+kDGDmC4jbksfh6TY7pD/3UjOhZwVsNMxl4/DsaJNmKxIjPB1Q7Vv/VAdHVZAFkw9T4p4Ojd79kBdkcCrnDYkws41dwGn/+gvhmEVFTVb8N2dYotVEkwmim+pP9WGhR1NkhfIk5Wn1S+XObHtOpUlUMU7gQ6JCxRmlrMWmItI7yKTSAr0OPh8DVKjYNrcTDh/SDvT4xslciw+RRzJ5kZ+2Q0LeL4oPIO3riLJtlNPUEhpmCIqbmxtXGV/kMSVkGCU2d5bYvNzy43KakEsFlmFX67k6FJ0oEEBnApzIGOQPdp7AW4EBcWphip9JdmXi3pDCnTWi4yiaowL+GRDje+JQb1WKlxBZcgZOHs43BKPCxHfFInLBkXCa1acOOMDgwNuHQWFZkoIcOdi9NKTHc6x6CppGtZvCqE1fRcZEZvj4gBEbc7LkcpwQlSjaTsi30iedI4i/tq3Z1dFjxeJMTJ8b4Y83eANMo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39830400003)(346002)(396003)(376002)(366004)(6486002)(956004)(2616005)(31686004)(36916002)(26005)(5660300002)(53546011)(36756003)(4744005)(478600001)(66946007)(66476007)(31696002)(38100700002)(966005)(66556008)(4326008)(8676002)(2906002)(86362001)(83380400001)(186003)(316002)(16526019)(16576012)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cElCeUM2QkRlT2Jlb1VlWW9JZXRicklwamE4UytrTXdEY2VTYmd5NXlvdFNR?=
 =?utf-8?B?K3pOYUsreTVMcEhENVJWOUpHNUUvcGRZUHAvMFlLeE1aMWtxWGwrSkdpMFBh?=
 =?utf-8?B?VFN3UDdKdVJOQmlYSEhEdStyb2FWcEgxQmE0TTk4ZCtac2syQWFZOFBUWGxI?=
 =?utf-8?B?Yi8yRzRHbzNaT1VQMmZ3cjBPY3A2aFFlcW1qbGNyaXdwcmhoMm1vSG5Sd1dH?=
 =?utf-8?B?dWVDMHcxdTNGYmZNUzdhQVl4WTcwRHZZUUd2aklBbjFxUUpNUnZFNW51cG1X?=
 =?utf-8?B?YzFzdzFiNlMvQjZNV3FTUEZ2OVVCQUZCQ3hEREYxY2ZRTzZuVWNwamJpMW1z?=
 =?utf-8?B?dzRVa2MrQzgybUxyeWhINmZQQUptbjhVYzR5OER0cHlsejhMRXd0c1ZZcXJI?=
 =?utf-8?B?QXREMnFrZFYxUUxtRDFQZ1A5MXlwR0s3MlNiajIreDVWZ2lWV1R4Q2xPTXkz?=
 =?utf-8?B?aitlMzNDS1hJMkRlU0U0TmlkemRVMmxJYW9EODRvS2tCeXhtZTBOQndWNjA5?=
 =?utf-8?B?YmVRTDhFTmdCQ0k2YWU0T0JEZGR5a2lwZitFa0VWcHVzcTdrYmZzSzJSR2pW?=
 =?utf-8?B?UlNucjZUMkIzZTBTeVcya3B6QUxsdGxRWE5JZmhSM2k1Z1dLakZLVnNqM0pk?=
 =?utf-8?B?U1hJYTZvM25IQXdUNjQ3S0JMREd6blFFQVB4cUx0OVJUYVJJN1JDcDlDSEow?=
 =?utf-8?B?UjEvamdjR3BEemp4dFk4RzhiK1ZtdGVUaGNWM004eGo2dHl6VU5mQWZJYzQ1?=
 =?utf-8?B?cjc3RDNBMnBidUR5ZTVwQk9YdjJvQlFuYjVNNVdWeWpRVjU3ZUNuNnFIeWlu?=
 =?utf-8?B?WFVnbnpaZ2F5R0lxM0w4aThmdnpQREoxYUt1ak5MR1dsaHBGdG12VWJSZU54?=
 =?utf-8?B?YlB6U0FrK2RzYWUrcGRTZXROWXRrWlFmQ0pDVVE1cmtBWlRaZWExYUwrUlFC?=
 =?utf-8?B?WDNhSmRyelZNMFpZQWVuVklGK0NPTlZ2am95Nng3UkJzN0ZwRll4TnRmekdy?=
 =?utf-8?B?eVlPSFdyQUFhQ1UyRlB3eGVEQk1Zckh2S1J0ejlyYzdBeHdOa0JPTWZGUVZG?=
 =?utf-8?B?NmVBK0M2QmFNb09ydUJLa1JyRVhKdnJ3cVlSbGJ5a1pLaC9xYnZJVEJzVkY3?=
 =?utf-8?B?ODNkNi92SHkyZFN4WHlRQXUwY2JmSFFZMjFmYkFIeW1XNXdwckNoQ2wvTWs1?=
 =?utf-8?B?c3BRZlFEc3BuSUV2eWxjZnN5N0FrY2VWczRHTFF5OEQyTTVaWEdPZUM2Q0xJ?=
 =?utf-8?B?MEl5Slljb3NuV3d3MlhSNTN6WjJNcjlZaDRvRnRLd0ZDdG53VTZDWE5qcnJo?=
 =?utf-8?Q?tzred5Ior8?=
X-MS-Exchange-AntiSpam-MessageData-1: DBs/EcQjEtMzG6ROQS41ezkSaVC1LCfDedZR+R63VHFQm28loSiBg/5EqnRw3UY0DzM8O1ICMtgbXE+zaYjzHBGr6kbwr1HwHZS1ZBiDkW7yZO+310O5BYWIJYTs9B4yHTxepPLKiM9E6+QqFBlIsB5ukolLbXzMdbmbQruYgKksy2qc/00a1nEI1D6m9FeWBYN6SsY+J7D3urZT8k5qZmLCQuX3Sf7ooVYPzxhLdkeTc8adhb9SiGCcuN7BucUyZj3XJpywpHjUVXFUAzF1Leeyqir5znb0846a0A5xJXap3kpacl8x65X+HxuxuX2g729RJTfTjj9x79Mbo2RlJH5h
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: dd2741f7-c44e-46b2-8b99-08d9240312d8
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2021 07:09:47.2147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UFFUdknF6A6MhyHhLDVWNKGRZ6Ug59BQjlAlbcmvJWDTYjXJeQP36TVA0HhySc25
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR02MB6421
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi!

Thanks for the patches. However, things have recently changed under your feet.
Can you please adjust to

https://patchwork.kernel.org/project/linux-iio/list/?series=484153
https://lore.kernel.org/linux-iio/20210518190201.26657c49@jic23-huawei/T/#m0de421cc9f6bc10bfa2622d65be750aaced3810c

and resend?

On 2021-05-30 02:59, Liam Beguin wrote:
> From: Liam Beguin <lvb@xiphos.com>
> 
> Make use of the IIO core to compute the source channel's processed
> value. This reduces duplication and will facilitate the addition of
> offsets in the iio-rescale driver.

Cheers,
Peter
