Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD72866D32A
	for <lists+linux-iio@lfdr.de>; Tue, 17 Jan 2023 00:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234697AbjAPXci (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Jan 2023 18:32:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbjAPXcU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Jan 2023 18:32:20 -0500
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7FAA34C10
        for <linux-iio@vger.kernel.org>; Mon, 16 Jan 2023 15:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1673911353;
  x=1705447353;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=r0mM3lchB5MZr6pxVUUt9h/BchW1EdIoYh2XH/WKZoI=;
  b=U09poZhy6ypPePNQmtOJzRj4A7WlOqurf1y5buLMCWiysL/oJabjCTKF
   Tr8p2cJf8sCJt9Cx69iRLgAvGYyvmY+33Evlxl/Q1wn95KXucqBubYV2M
   r7zNIL3lHIB3dRnpGpOJVTzI/YVZ5uyLdUpgCZUP+EZ7FQdI3c4SAHlgH
   CBtHjpVYKd82fjytFoPYuxuanMfINc0yGVg+OTJsBNFv+WhmyLHtu2/tR
   GQ/Zp7R3KW0+h/SH1uIJ20Dj81tq9IsOAim/O3tMgkPmS3p2wJj1wFXXR
   Z8xBmPkhaUAm8Z202C7dgWkO38NGOwlimqUTS4SfBb9dmmrVFCa/2clAA
   w==;
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HBufNbsurswwtZNuZFzxzoSAj6cCbrZECb/g9iaxI7SAfhNCB0+QTostcoRDWfT6OPkek+nyNn2E5uvrIFxBoY0YvdLCUW5dEGSkGAmaZcqTSCHGkK4yUEtB0SLHmjIUDt3xxz/E3E3JCPirYeWrAuBKtQBe2Bt49QETn4veMDaXmumr2qKV0PlzkO82Ye3sS0Zfu5RHG5kOERrxVsNj0GAobyJOek/IaYmMJOQOFCizbg6SZcqk7fpNI3C1Wr9yVzfO0AtSydgvUieY3hDquL10e2vB9EfjM9bAzDT1GsDloUXu8r2Oy/+URloTwpe48LdD3zjNdXdylV4xgsMHlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r0mM3lchB5MZr6pxVUUt9h/BchW1EdIoYh2XH/WKZoI=;
 b=iyPhFiJaxrsnyU77/QkUxUd/jF+eYNX2SE9KG/njX55yxZbWPQN05Wq7YuYaAWPoSO62Bzo6Zx76bfziXTz5OeiGAMWoNuEZFyyRZBL7m/lAhHhSfQL5IJXFaH95Z1QszjDC0f2nFCSyKZTfDz0280SxLirwiOJ0PWPpYxVugTFkmY9Thtc3JL0Zn0RPU3u4kWqFMxH9UOgGzNDkIIpLgDGX0d1f3F+n39SC5eYqulNGO6sNDQ3i9QKGqJg5Km2AE7V8/SRTDTCLffRIvcPi17ke/vTTElcY5nXHEOCgEyi1mWX1hbdFsRW0+6SwGlxD1qvpGlybCJ1OAfcJqaZZIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axis365.onmicrosoft.com; s=selector2-axis365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r0mM3lchB5MZr6pxVUUt9h/BchW1EdIoYh2XH/WKZoI=;
 b=enDXZU+6vn1N2OOvin7/h4LgloL/lwOTVx9FcgzjLJOksxU7sO77xLvFkD2jcj59tW+fdVIoH7EuGwCY0W5xQuS0Vm+IEyyCzogS9/p/wvic/xFPhZUXa6TRIJJgsKtISWQ0H84+ZDhj7ZiKh1Cc55JrcaYgFRoqjQlmDTFCMbw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Message-ID: <8d74659d-8df6-a6ac-4f28-6c7819c971a8@axis.com>
Date:   Tue, 17 Jan 2023 00:22:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3 3/3] iio: light: vcnl4000: Add interrupt support for
 vcnl4040
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>,
        <andriy.shechenko@saunalahti.fi>
CC:     =?UTF-8?Q?M=c3=a5rten_Lindahl?= <marten.lindahl@axis.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        <linux-iio@vger.kernel.org>, <kernel@axis.com>
References: <20230110134323.543123-1-marten.lindahl@axis.com>
 <20230110134323.543123-4-marten.lindahl@axis.com>
 <Y8Q5+9WogoIeFMmX@surfacebook> <20230116173240.67045474@jic23-huawei>
From:   Marten Lindahl <martenli@axis.com>
In-Reply-To: <20230116173240.67045474@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV3P280CA0092.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:8::10) To AS8PR02MB9529.eurprd02.prod.outlook.com
 (2603:10a6:20b:5a5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB9529:EE_|AM7PR02MB6356:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d0cfcbb-eec7-4fde-dd95-08daf81888f1
X-LD-Processed: 78703d3c-b907-432f-b066-88f7af9ca3af,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d9LpltA+iZBycuIBfk18s1NLTbxpGZKXZ0xAwrl5hy94zGNgr5Nbms4vSzm5RFRUQW6ktVHzZJQYnUc1q8TsqecC3Ywphi+ikhp93/rgH4c0RFWRUygpEGrrl8/SZfj1kQh/T2b78cIiJuz8xmhedkjN2kwoFZj4o9X8XmpPR5rBybvmkbYhBhvuB5OfazaLIMW4lYA1lkodcxWzckCfE8oVlRfU6suVPAU+62bQcCxbi9NMKTglbQQjIh/ZNYmecRaeQoJW8zJLK3jC8X1yMcgznvivPq+4ZHCoT+8Ynf5JcKrohKgDoc32Ojgdgvssbu15i7YNYMCuUi9CTiZFXA/7MoMMvePNxWy9edCehFoE4LGGOt21zjPJyLGPPiNJbTtxP/eDf8/g1QlTmEYIc8KQgmj1AW0gecsR+560nGkv7OjQ2wuC268w1Jtj9yRuR5Bd3bbjxuXhPIBhHVGjMWNMvsB8JlZuf7g84BJYyYyzekT17q0FcLZyjt+XCXsVrB4LWzmTVDSDEjuZsqja05oWYmPkhaIDWacYrcXn5iwtLwvMkI6+eCyD606m4kCaz+1VGrvgmqJwlkwq7z4t9KKATTq1S3cMwogsGCmUV2QDMyLnXAQ6EfFZo24efMY7V5vOtz4bxidd3QWjI5Y07C3CW0SqTt7HwX3rFHIug9No8J1QiDcgfrEpILoQQuGv8tmFoLPKDijynjLnRGzDCgyAhC30FvfVfVrwstURi8E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR02MB9529.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(366004)(39850400004)(346002)(396003)(451199015)(54906003)(2616005)(4326008)(8676002)(66476007)(6512007)(66556008)(186003)(31686004)(66946007)(478600001)(316002)(41300700001)(8936002)(5660300002)(4744005)(6666004)(83380400001)(107886003)(2906002)(53546011)(6506007)(38100700002)(31696002)(6486002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWtiMEtOUDM4V3N0Uzh5Y082OHRQL25XeTRTVEFRc2Q3MjZYSXJIVUZIUER2?=
 =?utf-8?B?VGovM1QxeEw3SVZWQitHZitXTktnd25VOFFoVmpSU3FmRjlrV1dYd3FOMVFK?=
 =?utf-8?B?WnVZUmxMRGlRVDdERWNURGJjdWN3OHdlcXRTN2dObVpqYlI5U1VEdGcvS0tT?=
 =?utf-8?B?c3dqTm1XS1Y2eWoyVFBQVElCYWNKOGhBM1h2aUMzZVoveTV4eGxjeVFiNm1q?=
 =?utf-8?B?MDQwbzhud1crRlUrb0hhWGd1bnNaRWJnSUNwTEN5S0c4OWl4bTBUTWlEMjhE?=
 =?utf-8?B?bHAzYVNFTXpZc2pkYjJhZWdNbmNHd1prMDZZd3JQOWNVYmc4UzR6aEltd1pR?=
 =?utf-8?B?SXhwd2RZZGhkRktmNW1sT1BRSFdaUjlPcTV4LzBZSndBRzdYSUhpeDMyWGxx?=
 =?utf-8?B?VFNNRWZ4dHRTZENUS1JWUW9lUWJ5ZUpmQW40UG0yd24yQ3U0SXR4a0g5N1Zp?=
 =?utf-8?B?R056MjFjWTFpQUNUL0FGY1FsVmxKTGlUVWFLM0YzNkU2eEZma29vdFlpL2t2?=
 =?utf-8?B?QnZnNW5lZk93N0ROQlg3TkFDOXFOTXFEWVdvZWswMUt5RVZKdG95NXFOMXYr?=
 =?utf-8?B?TTd2TFBuK0hDM1lWTzR0R0UxdFcwMU15SW9WM1RQa2pxUU5VSjhWTnNTSkE2?=
 =?utf-8?B?Uis2UHhGbk9SdHpMM3VadXhQOWNUQ0Y5MnRONUJHbjBSelpEZE54bFcyZ2V5?=
 =?utf-8?B?V3ltWEtGOUpDK1VDc21tU2ROc1Z1bVMvbEg3NVZwdWFNMHlRSDV4UWIySUIy?=
 =?utf-8?B?czE0cG1PdzFpMzA3WGFqNFlOOFlSTlNoZk13ZGZMN3JrbDJBd2tkSm5ORlNx?=
 =?utf-8?B?cE9TR0dWSm1lbU1HR2JOSmpyVStDMjNnYVVVVUdSalJUUHZkVWtwT0gybHdE?=
 =?utf-8?B?azdmMWt0U05nUDhFOWFIUmh0QVJDck91NzNybmJLRFpmNjRRZXNveUZ5TDJw?=
 =?utf-8?B?RTJFQ2U2WFVNalpXK0lIUmZBTGJXKzlOZHZZRXdBU2tlWlVUYmllQVczRFBk?=
 =?utf-8?B?WGVnUGtNU1lBM2dLSS9QN1h1M3dadW5aTWx5cjNKbVpNSDNmR0FZSFlHV29U?=
 =?utf-8?B?Y3N4bE1QU1ZyMWFvelVlZHd4cGVEN3ZYNFBjaGtxYm1KaGw0Ym85Zk1CaFhU?=
 =?utf-8?B?VW1CT0dCNlFmTE1SOTdsU2ZReU4yVmhZY2ZzQi90eUpWNm9FdW16ZWxCd3NF?=
 =?utf-8?B?V01FVngrWTloNEFCcW1WclYvMVJCa0g3ZGM4cUJzamVDVWUzeExsalhzY2VI?=
 =?utf-8?B?eWpOM3FNdUhtTGZaMFk3UG5rSDNoMXdQVnFBcXlVNmQ1NnByZ29PV3VFMDZz?=
 =?utf-8?B?OG5QRXdwR3FrbHJpajQxaEVtMGtHZk1rYWRoQXNhaDNNV0t1MTQxQjVma2lz?=
 =?utf-8?B?VzFtZGI4elB5S0pQb2ZpK1FRd0ozRkVPMjZiVFROWXNMbmRYM0xJVFQ1ajVr?=
 =?utf-8?B?SDIvT0NtblYrd2FtdG1mTUd3cnpxV2lLNkNOemFSekM0ZkxhQkUybWFZMUV6?=
 =?utf-8?B?M2VPOVdPTkJ6SEt3ZFRFV0UrMDgxL0pPaDFkaVhYLzIyQk1yZVp1VWpIR0Nj?=
 =?utf-8?B?NVNRNGx6c2loOERSVHNOM08vSFhVaW5xL2w0Q0JibkErRVZBT0hlbW0vRE82?=
 =?utf-8?B?a3BwNDAvaGhYQjVBaCtWaFNIWDZvalovbE5CSEE3ZDhQK0lJazRIVUVLQytB?=
 =?utf-8?B?L3RScEV2M1ZxUnk0Q3UvQ0tpUzZaR3NoRVB0V3VFS2lsK2FKcDNyZTVIekJ4?=
 =?utf-8?B?aFNRcnJTVGk4cWtXUHRSMmhlcEIzVzU0bU42OWg4NWlmbWx6aytyekZGQUdy?=
 =?utf-8?B?M0NDRFZYU1p0a2Urek5PbXIzRStscU4vUEl4L2hrL09wM25KaVcyOWhhMFZm?=
 =?utf-8?B?N0tXUlA4NHlhdnEvMlZEY0tLMVBqTVY4dEhidTNLME94dG1EY1NtSFl0cThM?=
 =?utf-8?B?aWdybGkxOUNVOVE3RGhBQnZOdDFLQUJYQ0dTMTgrY0kvY3pUR29YbGJGMjhp?=
 =?utf-8?B?aHdHVXVZQWFLUDdWcnJTdVBaK09sVjBDME1sZGI3aWNLSXF5R0dCcVNhbkVr?=
 =?utf-8?B?bktHb3ptQU8wWitjMWVnQysrKzFVTCtOei9LQys2bkYrWDI3SGlycnU4UzM2?=
 =?utf-8?B?Z1g0dE1mT3ZCVHRMb0xIYmxhVmVZKytIZlB0UG84czRMRUFiZmxsM3diUXgz?=
 =?utf-8?Q?V9iMfN3os1kkNK7ysvkXPnyrsHNaX3wlRIHwikElP5/Y?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d0cfcbb-eec7-4fde-dd95-08daf81888f1
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB9529.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2023 23:22:28.8208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jI7aP6wFao212WDBxvWlMBCx5MHAjRtynXYRc6Zh7/rCKqK2NuXQ5/Sa0IePk6Q9R4H5ohRQTjpgPc9tJJcXfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR02MB6356
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


On 1/16/23 18:32, Jonathan Cameron wrote:
> On Sun, 15 Jan 2023 19:38:03 +0200
> andriy.shechenko@saunalahti.fi wrote:
>
>> Tue, Jan 10, 2023 at 02:43:23PM +0100, Mårten Lindahl kirjoitti:
>>> Add support to configure proximity sensor interrupts and threshold
>>> limits for vcnl4040. If an interrupt is detected an event will be
>>> pushed to the event interface.
>> ...
>>
>>> +	ret = i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF1);
>>> +	if (ret < 0)
>>> +		goto out;
>>> +
>>> +	val = (u16)ret;
>> Why do you need casting?
>>
> Looks like these need a little more time.
> Dropped from my tree for now.
>
> Jonathan

Hi Jonathan!

No problem. I'll send v4 shortly. Thanks!

Kind regards

Mårten

