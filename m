Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 887597926A0
	for <lists+linux-iio@lfdr.de>; Tue,  5 Sep 2023 18:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjIEQRx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 5 Sep 2023 12:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354446AbjIELoy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 5 Sep 2023 07:44:54 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2063.outbound.protection.outlook.com [40.107.104.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE341AD
        for <linux-iio@vger.kernel.org>; Tue,  5 Sep 2023 04:44:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hCgxa/PEcneEAXyJnNsq4zPk1Eijji9ZxoxSajDyrSe2HG7j+Q+71lrJBKMCfXuy3lkd4FRP3YlJqkmVNAIlmb+wqp4yKBrZxW0iy5UtThImWoeuWzKe9L9i3jdPbYAc5NNKheDqcMDAAIHZF/cjMeIaW3x8ln7D4+Vjhp+iSB8fMX9XQMKasioZFHwSAMk497nu0KuYG9NLOjgO65NgKK6d/w/7D6Vmc26/CZnUxDCXplsac0wwAA++DdLaeS406I82J1clBRjCH6qz48QEzvuhUqy5GQIVrB3vZ6zPleOYN6NmZVTTjI6qtfnB3nIQLhY0vdkvPJMgux6yFJUBFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FDQkp6JYeQOIhA3ObK5LdJ0StsNGRLyRTXqzAzojJYQ=;
 b=jIqLJYBYmxrHyEpNypyYXKUGJl6o1VbBIBLHkxIQ6VJO1Gbgggs8YwdDYMZ9cZl62vNP1Bz4NqrNjxJTaYexWHuqs5EVarHTFk9pO5iSVk6+EiY04vL2zcbcejbvFZeByzI+/zOU42c+8V8pqysTvEBntjF3v6DyJ5kfuoQ0dZC10aUfvWvBW77xze8jGxOwhyjC5p+GN3YFVjyZlf751CtkNDY/CmAoX8EDbYmiAXJpq7L66mwhY+CV+sXyojUg3VQxJeXo53wmXSd20Wt1m54Ybxdk98ww8ESzkZJHVV20hBh4r4OzVpH5ogKpKfj9HcFIozXQe+vGtvLAePkWgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FDQkp6JYeQOIhA3ObK5LdJ0StsNGRLyRTXqzAzojJYQ=;
 b=RIvgsfYjbCpJL7G5CAtqZ5PMShQPhVXZszJK3rckdEO0bEQXIZDE4ETEB9d2pCR2e9eugSp7JHMY8efiCmwnKR3VEoJfJqIwxyevCVxdCYQFpHHBbEJUfTlHq8fzFYLHdddJ3991scYdTQo5vZHW5gb7i6a2wqjVm4z9Q/2p49yLecytalfj3GjlhpWpbctzOOi4nP1mT8lYTejy9+UktoKB2EQtJivg62mQagL3IURssaMGQ1RtSXKC9uCZwoO3cki60CViNdTNEpOWlncNan/oN6uk2vWXW/jVZZlLPWge9lLwl7UrMt8Ey30LKTltJor9vhrh6FibtzSzbkwKKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from HE1PR0602MB3625.eurprd06.prod.outlook.com (2603:10a6:7:81::18)
 by VE1PR06MB6957.eurprd06.prod.outlook.com (2603:10a6:800:1aa::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 11:44:47 +0000
Received: from HE1PR0602MB3625.eurprd06.prod.outlook.com
 ([fe80::cec4:e994:fbc6:5f07]) by HE1PR0602MB3625.eurprd06.prod.outlook.com
 ([fe80::cec4:e994:fbc6:5f07%6]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 11:44:47 +0000
Message-ID: <2bf0b48f-9ab3-c626-05b8-a17b4c7338e4@vaisala.com>
Date:   Tue, 5 Sep 2023 14:44:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] iio: adc: ti-ads1015: support deferred probe
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, jic23@kernel.org, lars@metafoo.de,
        u.kleine-koenig@pengutronix.de
References: <20230904101533.455896-1-tomas.melin@vaisala.com>
 <ZPW+MXuBSYEE1GfF@smile.fi.intel.com>
 <e12f3459-7025-89a1-704b-209391cb8f55@vaisala.com>
 <ZPcG0fzoMU5OMave@smile.fi.intel.com>
From:   Tomas Melin <tomas.melin@vaisala.com>
In-Reply-To: <ZPcG0fzoMU5OMave@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GVX0EPF0000ED88.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:3:0:14) To HE1PR0602MB3625.eurprd06.prod.outlook.com
 (2603:10a6:7:81::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0602MB3625:EE_|VE1PR06MB6957:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c6e036f-6a5b-49b7-928c-08dbae058138
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Brl+zShM5rRlPIjrOu8q7sJXrNTzvY/JIIVvYAvdm6EhEp5D6yCN5Ho07hf8KxzCG+2Mz56S2gHBqV6sLn64YfPPOT9z0K/wNn5MsHtriX94Al+HH+sGeND4fHIsjAQ6xr244Cz88VFPPsKLuSmhOFN8bn8UpxweDOI7r+cgyVxB15DoaUqqlz3qEpcH3quKukscwXWgR5HU5Dv/5l0gjZnLreGm1dJmaD/jPFH7Z97XkY0ud5vw6VZA4jyKaT2wKxY2C8UEOZZOu4fj/eF7ZbvFVjHzHLzo9IipGzqBFVWs40xpUMaDhX1DwdGNwMGV4rtWk1wnOcayEXAk7DYtxX/VUoFlUQKj6JtDfbVxG382htlzUKzgzqggaquY4KnHwDkwZ+m3RHrkSo9QJx1cIc5i2611E1bfNIpQgPe+vPpSRXh7Ydi3itXgp4zAlmtE/y8t1lB11Amr9oE0fiurbjaYGrUYGeRjlplvELrzPfPbmeqc3NOOd0c7kPwhbSYxXorJVx2FB3vD9/A/p/z/dpby93xAQBz1/niSm1Q+xqv0bPpwkzvWDKHVIABSCcoN71YpxETknSxxqBDhCYObdKEWfY7hE6OAiHVH642U3XRsHt5zNHgiCccY282BSDHYpg5ER9jyfNzKVvrEX4uK5A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0602MB3625.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39850400004)(346002)(376002)(136003)(451199024)(1800799009)(186009)(8676002)(66556008)(66476007)(316002)(6486002)(6916009)(4326008)(2616005)(66946007)(8936002)(53546011)(6506007)(41300700001)(6512007)(44832011)(26005)(5660300002)(6666004)(478600001)(31686004)(2906002)(83380400001)(86362001)(31696002)(558084003)(36756003)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MTFVYUNLMVYxbFRhTkdSd3VPQTR0L051SmptblNUdnc5VWVSMzh1bFJ1THlw?=
 =?utf-8?B?MjR2QUwwRWN3ZVhVUElNL2w4ZHlRVlpxL1ZCTjYwWFQ5MGovMTRyTE40S3dP?=
 =?utf-8?B?ZnEwd2ROZVIrd01hOFdpNEJtbFdCckxoQ1VkVkE0b1NEYXZIYTY0VkVDcC9w?=
 =?utf-8?B?S1MyNUs0YVMxSXVCZ0JHWHhId2xibmJja3N5R2RxQSswTzd1UFhkK3hHQVc3?=
 =?utf-8?B?Q2xDNStnM2pPQVpsSUNIS1RUS2hmcllXbFhvQWVVK1BzeC9FSytzZUIyVVJF?=
 =?utf-8?B?L0gySTRadWZYME5VcU5iMkZhV3NRUTNYQTNZQmhYS0FzYWZ6bnN4ZVFGZnYx?=
 =?utf-8?B?WXNnZDVjNmE1ZmViMEhYVFovOW03VXRjUHFQM3pzYllyRkdRUUJUT1BjMndK?=
 =?utf-8?B?d3JJZnFIc25na1VkQlo5RVd2SmNjbGhya1VtWHZ3T2hVaHZZbU1kVXRGZUZm?=
 =?utf-8?B?eHpCeDlONVA2UmQvYkdhRUxpaU5BeGlvZHJiSU8wSkFsZU5PZVlTaVc3eU1x?=
 =?utf-8?B?TzlCZkZOR2NlTmgwYnpPcUtIZ3UzVkU4ZUZuUHdyamxqNlBhQ3d1azRlU2FX?=
 =?utf-8?B?aElIZnZjZHBzNElURlg4bE5EQXVOYnROKzRXTTRxcVpONXNlSkE0V3NQN3gr?=
 =?utf-8?B?b2JPQzFIbnNlQUZ2dVNIRkJFdjJDQzFiT1RnTXlPdjRVanBEQVJrcXhqeFd6?=
 =?utf-8?B?Y0lPbnJpblN2VzZiTlpxcHlOUHhhdW5BMko3ZWptMndNaUhTZlpOU0RjbHRn?=
 =?utf-8?B?Y2pYRElUNVFzUFNtOGdESE1HWkJiK29yQ2RyOWdGM296SWRieFYxaUlMRTlr?=
 =?utf-8?B?NmlKUHZXRitpUkJJai9RRXQ4L3dFcGJMekJzTzVuNEd0VGN1ejNNSHNkNDNz?=
 =?utf-8?B?QTVPaW4xUW9HMnFRdy9xZ0JlQVFhZHlWRWEwK3F5M2d2aXJUbXNTaXIzZEZo?=
 =?utf-8?B?Z003Z1pKSi8wdEtxSm9WczR2OFpONGlsWlAxU2kvdk9KelZwN2ZoRFJ5RjRu?=
 =?utf-8?B?OGJyb1VRYkx2VWhjRjJFdUM3OWFzTFBDR2h5ZW9kWXRBZGZqVEJuOUFVOE9M?=
 =?utf-8?B?YXBpc2hwaHNSalNROE5DZHN5bndZNkJoTXRoSjY0WEhRek9RLzJPY0hRcjBO?=
 =?utf-8?B?a2tPanlKSTV2Z0Y3Znk2OTd4UExLd25ZUno1VDZLRFBaQmNwL2pINCtJbXpp?=
 =?utf-8?B?c09YTzVqM2pTZWV2V1lTTFV2eWhHaGhCaVlXTXNMZ09leHZWTk5PTGpkTmcw?=
 =?utf-8?B?aXFpNmxJSE5qa21vSzVkU1E1WFp0TkJWTDN3WnNISm1IN21JQlBhenFRWUFX?=
 =?utf-8?B?NXROeHJJUVJTWFhBOFhqOSs5bFhPZTVCWGRFaml4WThod3ZpcDJObnVtWjZG?=
 =?utf-8?B?RHdkVk1OazQ4M0pCMjVKSi9zVU00eWVQT2tNWTRMeW95R3lwMSthV2RhUmFE?=
 =?utf-8?B?bk5qQzNIeG5zc2ZxV09PeU94eUNHZ2djR0c4RHF5WUtwaHhSZ09IY3cwV2cr?=
 =?utf-8?B?V2ozSW51b0dEcG5uVmFnUVVjaGN6S3dDNktETW50WHhXRXlrN1V1cmJvK2do?=
 =?utf-8?B?TXRKc2dhZURDNFlleU1xMXJqZTJTdFFLTk9seUUwYUpnVUMvUHJtTEphMlI3?=
 =?utf-8?B?M1JzNWJLeUFabzFQNFNDUkM4WG5QK2JXdU85Ymt3SlVUMWF3S1ppb3dzK2Vj?=
 =?utf-8?B?cXY2dndLTStPQWhJbGdJOFJueTgwOHVrNGUzYTNNRk1mNnd4dEo3SjRpN1A5?=
 =?utf-8?B?aFZQQUw4Yjh3cGQ0S3lxdGpld3NUME94anAvckN2SUw3K3BtNm5oZUFrNlI1?=
 =?utf-8?B?emltckJ1bitKU2dseGlaeTVKZlIzeVlHVGNnaWEwZVVoOVpxcG9JZ29sMXFy?=
 =?utf-8?B?aXRncHJyTmovOEI4dENSSXR3Q1lzU2RNVUxMN0w5aHpYT0RKcndoeUgwQkdI?=
 =?utf-8?B?T3d5YWx5VFFNUHpnU1A5Q0piVHE2SEE3WTNiZnlPaWN3blY0NUlhSWh5WndE?=
 =?utf-8?B?ei9jN0xaZzNrU0gxVlViWWlJYUhmS0g3TnZDZ2VyY0VUVU9pcDJJamRpcGgv?=
 =?utf-8?B?ZFBnZVVVczVEVkZwK1RnTWZjTzRHNklaeC8vWEY2YzF4cmRPcDM1SnlZZTZm?=
 =?utf-8?B?ak5HczEyaEQwVjk1eXZrbENkcm1ZaTkva1Z6OTdIRUMrZTlBSDJocjB0VXhF?=
 =?utf-8?B?OEE9PQ==?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c6e036f-6a5b-49b7-928c-08dbae058138
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0602MB3625.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 11:44:47.1435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mwnKzSPRfXs9YkGPfp1xv3Z8ufi3HjZYHfrofWZmCLcLbmn6/YqXCcqRaOXHySLnDTAgBpv6CD/sKrEMzOZBcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR06MB6957
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


On 05/09/2023 13:45, Andy Shevchenko wrote:
> 
> As Jonathan said, please try to elaborate better what the real word issue is,
> how it can be reproduced, etc.
> 
Thanks for mentioning, for some reason the message from Jonathan had
been filtered out, found it now.

thanks,
Tomas
