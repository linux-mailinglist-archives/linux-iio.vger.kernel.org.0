Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5041F432F26
	for <lists+linux-iio@lfdr.de>; Tue, 19 Oct 2021 09:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbhJSHT1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Oct 2021 03:19:27 -0400
Received: from mail-am6eur05on2110.outbound.protection.outlook.com ([40.107.22.110]:42464
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229584AbhJSHT0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 19 Oct 2021 03:19:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ek5+3kdQ/WPVaSxMgw9EV2oF+a2eKWWITVG8T8xMDmQevVa3fUpwdKZXlrbTshxXIXZBgGKpBBD4mFaOHk/Ley8m7gmFYV/ETfzUgEdbLb1CBPECAyV9hk2r4n1e70IeVGqWs3iKlp/md7JrdHWoJrVhPZB8dnHbc+4woUIHt2XvDd66a7lupESVgfURUVkxoKQTBiIj4mwt3C778onQyRVS0Bsz12xfBo9W3fyeGPih6j0dr0ZX8DXEVZ+Eq7DY2WVull07yZP4MOX5PLZkpL0d211TYYodMdKZcM0EeG0uWlGdHRnYilGmywtY6cmPGID9nIxS3n4JumB3yGFdCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mfZ6JPBVnrHzza0zhIaGqcV4yKltTAMM+5iKTZaM75c=;
 b=FIV9eqP8ZdM1BwKTRjuufK6LZyWrFdP2p58eOz7tszlnJxFJRAEOiOtvleItggBr8gQXE2TxpJn9iDF1oBIOEsIAj4OdCMRc5gmdwbEz6d+ihc/N9bCmkbD6+MJfRIn/enrpfi9qiremU10AU3GHuyF+F67u/p7PN/QKZWERRbsdwKXNIx6s2JLSt+r/g/P0yQzEIEN9UbmFk4OMRqpDm38R62f0e0IrOEAeCDnRCtbTHGTXYPQo8FTTJGsbL3VxIhVBb8JUH0wfB0YzqBqx8U7bXCqPo/3BVlWb3p2dXJfztipYGXiQitNIMhXR+QpOCk0q1YE3ZVQV1OwOKim0Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mfZ6JPBVnrHzza0zhIaGqcV4yKltTAMM+5iKTZaM75c=;
 b=ioHQCVfAk3fF2i+XjxwIO6sE7F8xofCrv6zaPJx6heQXYrrY+0rcD3DTdWctaam1c2vMoCpfqZD1xgrz+tUO86DIqhZE/upF3MBp/oXch79jUcQzu4TAWa2yZvn+pIjCYuuwWdfonnLzZ3VHVkZAiKezGLNLVBqTgcQc1ZJu7w0=
Authentication-Results: axis.com; dkim=none (message not signed)
 header.d=none;axis.com; dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB7PR02MB4218.eurprd02.prod.outlook.com (2603:10a6:10:43::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Tue, 19 Oct
 2021 07:17:11 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::35c9:1008:f5af:55a]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::35c9:1008:f5af:55a%4]) with mapi id 15.20.4608.018; Tue, 19 Oct 2021
 07:17:10 +0000
Message-ID: <f8282455-9d8c-31ad-f722-6a59c6d97d20@axentia.se>
Date:   Tue, 19 Oct 2021 09:17:07 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] mux: fix kernel doc prototype
Content-Language: en-US
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>, jic23@kernel.org
Cc:     kernel@axis.com, linux-iio@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org
References: <20211019064521.18113-1-vincent.whitchurch@axis.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
In-Reply-To: <20211019064521.18113-1-vincent.whitchurch@axis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR0402CA0037.eurprd04.prod.outlook.com
 (2603:10a6:7:7c::26) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
Received: from [192.168.13.3] (185.178.140.238) by HE1PR0402CA0037.eurprd04.prod.outlook.com (2603:10a6:7:7c::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17 via Frontend Transport; Tue, 19 Oct 2021 07:17:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72636d24-cfe5-4b1c-d122-08d992d07750
X-MS-TrafficTypeDiagnostic: DB7PR02MB4218:
X-Microsoft-Antispam-PRVS: <DB7PR02MB4218ED87F9F3F55CB3E83641BCBD9@DB7PR02MB4218.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hS2HRpF0CV/2pJqQf/yh3c3y1yAQQXHAqRgF//u6KtcUNTKbHgDKbo5nL3qPyxVIj91iP36dSteToP6OYM1F/JAlx/Cq5M/XoswY3G0kHfuc4xHON2j+99VvPgqn2FrHdvJExKyhn1ogscE0KotIKMfIyBPt4PzENkEntcvN4sYyVIHu5NKneiXxqC3YVgZkBvSCtVGKpv/XoSM/Ckwj7dAjT1oamPx9Jyp0FO+C0juB/78lUTzg3oZa7NtCHtkRki55yMv7euy0Sc/3FNolUwgwFkU40Q3cdoDV/cQ0ZfHODeV0D3pN0I6cDMQv492VdEGs2XqFT3b/BbNG+mX3uCHBejYwO2b/GqGgiJ+sm3Dw5pGaWEKgRqtqOQo5AG5J2J3o/J8O5GAzXJdV9Wx7U2Xyz+0p0G3vT2T0eqmN7OQwHP88yq6JxvIQoGIHZ80f0pybgNUiBT9Sp9++dZxj1lEOpF+/r3uBCk10hMq7jwYkZ0W1Is8ZDf74hL/m1mSr1J5i2sU6iQlgj9C+5dYtYDLQSCRfC/ZGn0LCcviEy/zwWGHVpqjVjRLwz38QpxvLj68t9KNo+9fXWrqHwT1NdJ+ljslWEAoNZ0tH9ad5klFCLqm+x6QfGdFIcNw+Mu6UdMbFtTpHTSmg/ALbzqygAD2yM0vI0n17PK7aeEHio+tTdonBJFFPBrPNFVl7r909HV1t9B3xhwjLxbJkmY3z5yzi6SeR+OeoAIcT/ii5K5U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(39840400004)(346002)(396003)(376002)(4326008)(66476007)(66556008)(36916002)(26005)(53546011)(31686004)(86362001)(83380400001)(2906002)(316002)(16576012)(186003)(66946007)(4001150100001)(4744005)(8676002)(508600001)(31696002)(6486002)(5660300002)(956004)(2616005)(8936002)(36756003)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXZaV3p3eXhaSVBuYUovMGQyaHhhTTM3OXcrOTNSZXpZV0JTK2hxOFc1WmE2?=
 =?utf-8?B?U2JjdlVwaHBSNmZvM2tWU2hoZm82WmdNUXFXcGd3Z2E3UE45OVJKWGNCMm1Q?=
 =?utf-8?B?RnllNlkxaTlYR0R0WVQxTDQrS3FoWjBXcVdXd24xKzg3c3VYb0VmVmZQMGdr?=
 =?utf-8?B?ZzhKUy9sSzJUaGdzQzZ2VVBMOUpseHVkZGcrYWJmL01sTUk1SzlpdjIxQ2RQ?=
 =?utf-8?B?NkdOaER4cG0wWVlFU1lYRmNaUklWNDlHWXU2VXp0VzMxMXd6SVBVamRBRTho?=
 =?utf-8?B?K0VwV3NhY3RoVTBsUUZhOGRIVFJld2xTSGZvK3c0VGZyZjRhdXVNOU5ObFpP?=
 =?utf-8?B?Z3NMUjIvZlRKSHlYSkpyZW9ocEVReDBiWEt6RXFtRzRHbFFGWkVJTHI2RHNj?=
 =?utf-8?B?dFVjR2h3amp3TElERjRSM3crRkV0U3RMN0l1MmtpOFFWTlkrOTFsaHdGNjF3?=
 =?utf-8?B?L3FPeFl0TTBmK3ZzWVZlU3lUYk1xNDVBVkNhYSt4UHRYSzlmTGJBdURudU0x?=
 =?utf-8?B?ZWtPWUo5bzliSkFONEZFb0pqbzBuM1FYT0ZSbm9xUnFsOTVRaGF6bEpEaEVB?=
 =?utf-8?B?enp1eTd2aWg2M1M0MDVScFlJMG5qaE14ZnZ2aU1CZzVBQUtKeHRSdmlkdExk?=
 =?utf-8?B?VERKVnlpM01vREpIQjFPRHlQcWVrMHVIUXZQb2tGWjRKejNtTVFCMWVYbUdx?=
 =?utf-8?B?dFMwbUoydG1DWHhxRk1TVnl1WnB4TzVDdkVFWnNEOHRiM05rbi9BZkF0T3Rq?=
 =?utf-8?B?bWk3UTJtN01xVlNzSkgxZlphSEcvTzEzQzh3SUg0NzdHeE40aGsrVHhTVld3?=
 =?utf-8?B?aS9nbElud0lXNXNINnBsSnNxVTl0WC9yejdWMm1kNXVXYi9EUDZxSHJIS1Jy?=
 =?utf-8?B?YzRuWExqR3dhZnRMQUR0dnVyckNYUVlxMWtlZ2xqRXhFMnZCQ0c4R3h0OTJC?=
 =?utf-8?B?MUZ1N3VCRlhkekdabGdkWld6SjM1UHRYeCtrWmZhNE9EbEZCSDRoNWYvWWt4?=
 =?utf-8?B?cWRwb1BHQVdyQXpPL1pNWkpDM0pWcy9STGY2ZlVnQ2JTWldjMEsrVkgxaEt4?=
 =?utf-8?B?M3NkbmsyQkpIZ2d1bEZER0JnRUZqS2NGTTgyY2VvVHQ1QWJtOXlDazM0Nk9o?=
 =?utf-8?B?RDhRYmpQUzZTanZ0N011UjQybWt5alF2L2F5WS9LUmFWNlFvclhWM2lZSnZQ?=
 =?utf-8?B?cjdHTGpwZFU1SmZMb0YrSjhEbVoxVUFleklhZW1ZbVV4eTA5clFxdFNSalFR?=
 =?utf-8?B?cU5SN3B0SjNaM3VLazRIVWZPOGgxWWRuT0RJbHN6WEVXNlF3dElpajFTZkJp?=
 =?utf-8?B?T29HenExM2syWG5nOW5PeEVHVWdwSjZHTFpVQ2dreEZUUGdyMTNxM2ZGR3pV?=
 =?utf-8?B?NE9CZFZqYUlEdUFHUWtiNEg2djBlWUJETzJsZWlvZ2tYTk1DUmVVdHYyY1k1?=
 =?utf-8?B?eDY4clIzRTZqdENsOTRqOHhKMEoySjBnei9QUWhhZHd1bVVwa09rZWdEOEpm?=
 =?utf-8?B?d0VNVGNnMU9jV1p6d3dtNnJ6UUtzVnljeG8wTy9JQmlKUXh0QzNueENoZUJz?=
 =?utf-8?B?elZYNy9tUlpwOGNjc3BJdlhna0Q4TjlTY1p4V1VZQVZDTFU3aEZjVDF6dVQw?=
 =?utf-8?B?djZRT1FSa1gzdzhsWHJFSzJFMUpWQ0t1WXRWYllBV2lTRVpsU0ZkNHA2RGFn?=
 =?utf-8?B?RmxMWVRwNHduYmRZTzhIOUlRRXpvekE2KzRLNjljc3NyZGYzeUVqNGY5cTJS?=
 =?utf-8?Q?236/s1ecfMVoAGQUXMs4+ySFNJWD2ARCYxPaaWZ?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 72636d24-cfe5-4b1c-d122-08d992d07750
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2021 07:17:10.4682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QxVsp4Lp2A4unCaaaV2d6GbYLP8bo1XYJSMnrFhHMNMRgFwOFGvlsPwFzwC7m//Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR02MB4218
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 2021-10-19 08:45, Vincent Whitchurch wrote:
> Fix this warning from scripts/kernel-doc:
> 
>  drivers/mux/core.c:391: warning: expecting prototype for
>  mux_control_try_select(). Prototype was for
>  mux_control_try_select_delay() instead
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>

Obviously. Or, just squash it if that's still an option?

In case it's easier to just pile it on top:

Acked-by: Peter Rosin <peda@axentia.se>

Cheers,
Peter
