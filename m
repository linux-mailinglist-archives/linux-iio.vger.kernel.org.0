Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 860D8414BE1
	for <lists+linux-iio@lfdr.de>; Wed, 22 Sep 2021 16:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbhIVOaN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Sep 2021 10:30:13 -0400
Received: from mail-db8eur05on2104.outbound.protection.outlook.com ([40.107.20.104]:22016
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232243AbhIVOaM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 22 Sep 2021 10:30:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jkyk7NwHaoJQlMwMXpOJPLf83dVcuq0D5m3E6bSKvnFz6UQ1SUe9qvO3CrqXOMDqWyJo0dSY/Ma66CThTOgRxfCViFPsvDs7QqXqFQBagQ452QtNUdX7t4tWPESvZU2e/Xc8RXef1pf4thyTvxyyl9b4YPbxI/ZJQuptGT2j6PhsuTI6Lys5Mem2GchBeeU66XTfhS1OFaJQCxsk3if9hmhk5NiFv7xbYIa2EHVAE60gdt5q1zjJwjmpdoH54dmMO3hsgMeuKz0lpbz28HeghROHNFvi8qx2Qvio0aPcWs/Bbf5u8w85eJUXuV098Be8NApgG6ZFZWoTFEH0i8k9Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=VdD7t406GRL/2V7WQweewtQykwczdjo/EDkOOi9/bR0=;
 b=MfOztG1Srw9oesfzcxdqoC3mRxbMcEeFs3iRPG1ttSLe36oQdFoK/PDRSnm5fzoobLo0CkLMwDpl/P05VqUPO8AFMXSheJ21V/ldoa5qpVBZDGTxO0TltYr0aiXlVEOvNjmIZ1Se8Qjhm4fNjkmkgbVqwyZDw5f/BxDZM5ovVZ7m6aHksTpMFC78RNpk4V06Ugo4XpaefAPG5CDtyp26/5+Um1ktz1Bxvmquwz58B9I45JWd6UhgLBexHDPAeWAJDcc1xFfXQb4SfgHiG5JfdlhEqAIXQDzg5lQvNEkhV2Sk3IE7cUvK7j7Nbs3dHoYug0IVd6AaA88Rg44T5FIS7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VdD7t406GRL/2V7WQweewtQykwczdjo/EDkOOi9/bR0=;
 b=bPBqzB8OB67C9LG2T6ZAwjAuK9pPXISQJ12bm0w653uvGzt+1h1SyAgWDlPtB2zkL8t4xlMTl6S1kQVOf6ljihH2fx0rVSvye319ud4KrsaDqXQbtT06zBKloI9Co1tSs83j/0puQdU/U/ThZbjMzHee2OoJDifjd/dJgX9wWwo=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB9PR02MB7307.eurprd02.prod.outlook.com (2603:10a6:10:243::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Wed, 22 Sep
 2021 14:28:39 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::35c9:1008:f5af:55a]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::35c9:1008:f5af:55a%4]) with mapi id 15.20.4523.018; Wed, 22 Sep 2021
 14:28:38 +0000
Subject: Re: Reading ADC that comes from a multiplexer
To:     Fabio Estevam <festevam@gmail.com>
Cc:     linux-iio@vger.kernel.org
References: <CAOMZO5Cwdn_-to8G+RvVUbG+UkYM7+budUsvWVLeY7PutoO2Mw@mail.gmail.com>
 <74f1974b-ac08-96f1-887e-99580a2bf212@axentia.se>
 <CAOMZO5Bhs3qLwgqGYHO7Oswr1qvarkzmNFyWQi3-_geZTj3BVA@mail.gmail.com>
 <CAOMZO5A0a20_+JHmCMYXLuZYCE04GDTqt0x_GXtVxA5Q4MSAog@mail.gmail.com>
 <73d0ede5-8a35-7e3e-e685-235f39ea28e7@axentia.se>
 <CAOMZO5Ds8hUc1=Jv6YHgNUnvGH0JWB1yX0sMccoUVcZ6tyyTKw@mail.gmail.com>
 <CAOMZO5DtNkfqFAhFtzA4x+W5eEes_pHNGouX35tNL+8hfpq02g@mail.gmail.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <ee5d8cf0-591f-7296-28a8-d78159f5d6a2@axentia.se>
Date:   Wed, 22 Sep 2021 16:28:36 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <CAOMZO5DtNkfqFAhFtzA4x+W5eEes_pHNGouX35tNL+8hfpq02g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: sv-SE
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR0202CA0007.eurprd02.prod.outlook.com
 (2603:10a6:3:8c::17) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.13.3] (185.178.140.238) by HE1PR0202CA0007.eurprd02.prod.outlook.com (2603:10a6:3:8c::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15 via Frontend Transport; Wed, 22 Sep 2021 14:28:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3de0ed57-0339-43b8-1040-08d97dd544ec
X-MS-TrafficTypeDiagnostic: DB9PR02MB7307:
X-Microsoft-Antispam-PRVS: <DB9PR02MB730777BD836EEFD975D572CABCA29@DB9PR02MB7307.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jiS3aU7c68w8rVG+a0jFd29T6/mXtk6cOT/REqYxJcYohMFhLpnsBiY5NLadCE2UYLlg9FNy7TNDWlBQPcBwvbQJr2zqnj3ee6pP3tQ4lOGR+LBghI7Hv9zQ2G+puCElQuMYNl20fNrT6OkBtVHPpk07BnlXXQ/ruvFfDPF231tXDsVm0TzA5O05lPUKyamR2FhpVmG1ChGrW7hMaMj/10OR3ipaKGq8O0mXoZL1xept5WxPptF9kW9x44YZvMoNggzoFgK459jLBDJSwzrInIQVuhUpmML9izbxla6IcZc+ShoCg9wS4zbT2cJJmRp+hoZ4zAHpNQD2a5Ls4dya7479NC7jmFoHxKtNHLKJLduwCIEoreqTyChI4M7JHhxrDb8c9N0jppbTqaxYKHpznrLEbwdyJ5D9FRPG7Emt0FO+Sr7sh6AQJKTZ0oY/CxHsX4v+GNNFZt74UuOVwP+oc/xt4lAynJIcbzeHtZinKX5kMJK3H5DEgLwNca+G5GnQwDAtR6KYHwgbWbtazsHxGtLP5Ea3qV8gVwHj3gilZI0HRROi3uPfHgj6CA5mCltd8IWID3MjQagt4RLcVQh6coJK1ywyDMC//YcxBIpMRPN7Aj4dxPjraQ2qmwoqxzy22lTlRGWvAmCAOgPKpEjKmn4tUpCIz0Izi4B+wURmSWB8s1otbR9YnqqNtOfF1GWuXu4yO3DDVc66h28KfJumbH2MR+g0BQIW1rgs1mVgV+0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(39840400004)(396003)(136003)(366004)(8676002)(6486002)(4744005)(186003)(2616005)(956004)(26005)(36916002)(6916009)(5660300002)(83380400001)(31696002)(16576012)(31686004)(2906002)(8936002)(508600001)(4326008)(66946007)(38100700002)(36756003)(316002)(53546011)(86362001)(66476007)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QU84UGNqZmE3SWk4Sk02U1EzRGtpZVdCbFVpaTQxVlNkc2VnNFowR0d3T21y?=
 =?utf-8?B?ZHBYcEFiNjg0cEtWWUV2c0g0eCtSUWx1NXVMVVEvb1NXSHFJZXdLWE90Wm5L?=
 =?utf-8?B?VXBXdVRhUjhac3lrQ0lYbVdZbzdqcDJOMDRsd2tPcHlIaFpGMFdDMHBPWElB?=
 =?utf-8?B?eUdkL1Y0QlVjUWkwTmgwLzRCWlQxdCs5Mmxnd202Szl3blU5ZmVUSE5DNERD?=
 =?utf-8?B?TXBabDlOU3ZwQVIydlg5YjRBWHozZ1JsK09tcmFMeE82TmhnR3RyNWdGcVR4?=
 =?utf-8?B?YXltaVpoQTBGc1AraHpvQUNEZm42WXAxbTQxbmFaeWJvc2Z3Snk5Wi9zSTJ3?=
 =?utf-8?B?ZGlvWUM5anFYWEh5c2plVmNtQ2swWXBOK2E3TnQrZ0NxUjFjcEZETnNQdWJv?=
 =?utf-8?B?UXFtRUVvbTdiU3ZlZmtVWTd2bW82QjhoOVByanF1WDE5aTJSdFVjSFJXaURN?=
 =?utf-8?B?a0h4MWtDa281dDVLZHgza3JaSXcvaHltSTMvZ0REc3VCMzJNcUFNVFl0N0d6?=
 =?utf-8?B?MjlWRDl5aWEzSEJ5dFlvR0V2MmFLZXBjaXQyVHg2V3Mvcys0RG15bTZmeFZs?=
 =?utf-8?B?UG9TMmRqOW9VYURzaUJDZUFRbWlQOWxqb0wyMjhuY28vTTU0dDR3YWltVm11?=
 =?utf-8?B?UUFoVGtISDkyaEVNUFhwc2VENWttUHdZenJPZnBlTnpST0paR1VoSGFoKzJp?=
 =?utf-8?B?L0puQzNnUWpyZ051VS9pVkRpR2NwaW5YWW1VejlJclV3ZkZ5UW9MRFZYaDZI?=
 =?utf-8?B?d25IeDE4NGdJMnJRVzR1dHR2YW9XbnlVMUZvTHhyZE5wOHBvYmgxQW1maURs?=
 =?utf-8?B?cDdNVFJBcGZEZ3hhdmE3N1Z0dFd2R2lrbkhoNGN0ZEpmZkRrc3Y4ekErNGZC?=
 =?utf-8?B?bzNDZVBGejBQYnRORVFXNVM3d2cvQnQ0aHg5bkU0ejJPUW5WRTZuaUo1YzNk?=
 =?utf-8?B?eE1uOXJnQlhJZ2xqcFBrV3RFWTNqZllybUNHN2JlcDl2Tlh4c1IyeWFDTTRZ?=
 =?utf-8?B?OHVkOTZZTlNyQmFTRnBxcjNtSWJVc1JnVURpMG9HeHA1N3dPY28zMDVnSVZu?=
 =?utf-8?B?bnB1YjAwRVVtZHZTbWRtbEZURDJ4UU9COGdQMFBDNzJGaWhzOVlrQ1o1L1NH?=
 =?utf-8?B?WXFBNmtsNG4wZUZCQzNvR2syMnJ4R0k3UVBXTkhsZkttZkVWdUtHdWxTUUVv?=
 =?utf-8?B?cEtHcUxLKzB3RUpibm9yWlBxbG1hajQyK1BZcHRzWTNFVzZKdklseHRJUTFl?=
 =?utf-8?B?SXJ3YWtCVGZpeTZxVnNxb1dVMTlXeDJKd2t4Y1o3NTh4K05mYlppMFdQUk9X?=
 =?utf-8?B?c2NsalVmQnRqYjE5ZTJQaWlES0w1SU1mS0FBQm4ydk5kZGhaSnRCUFBqTStO?=
 =?utf-8?B?U29rTjMxQmZGU1pJU085TytmRkx1N1g1czV6ZlVEcXdJTXU0WkNQaFdqbTJz?=
 =?utf-8?B?ZWFsbCtEYW5QZU1ueW5FV2VMQVVEVmxWcEF2ZUZLcThiajdENzREMnZRREdp?=
 =?utf-8?B?aDBWYnJoME01L0ZZa0d6ZEN5d2IyMDJaM0pZSGpKZXpDMnpVcUVGSjE1QmFJ?=
 =?utf-8?B?aDZjY0U4REF1Z2pCRml3TXRjdjdSdytYbEtLWXZKUHNIMmRRL0REOXBCQ2c4?=
 =?utf-8?B?anJ5SUpvR3BUSmZ4cTBqWEgzeWU5TGVsQ0ZsMFlNYnRJS05PaldIMFJqM1Z3?=
 =?utf-8?B?Yk14OTRrbWJVaDF5Y21pSldJVkp1Ym5HUHhBOHdDZHoyYnlyUzRxL05ZR0Vw?=
 =?utf-8?Q?qEZ+s6yVUHmTw2oye49XfMigO2Xm97CLCYedP/i?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 3de0ed57-0339-43b8-1040-08d97dd544ec
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2021 14:28:38.8352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VqtfrFUS7xR3uTaQwm9omIIPJgWcFuv7c8xn2DEPDpnCP+oyb+pEr3yALiq0Cih0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB7307
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 2021-09-22 16:20, Fabio Estevam wrote:
> Hi Peter,
> 
> On Wed, Sep 22, 2021 at 10:41 AM Fabio Estevam <festevam@gmail.com> wrote:
> 
>> but still the parent channel cannot be found.
>>
>> So I don't have the DT properly describing the ADC to the mux relationship yet.
> 
> It works fine now :-)
> 
> The trick was to change it like this:
> 
> -               stmpe_adc {
> +               adc0: stmpe_adc {
>                         compatible = "st,stmpe-adc";
>                         /* forbid to use ADC channels 3-0 (touch) */
>                         st,norequest-mask = <0x0F>;
> +                       #io-channel-cells = <1>;
>                 };
>         };
> 
> Thanks a lot!
> 

Nice!

While I don't completely understand that iio-device node in the beaglebone
dts that didn't work for you, it looks like it's just a renumbering thing?
However, your version only remapped 4 channels, and in that case your new
iio-device only had those, i.e. 0-3. But the iio-mux was looking for the
missing channel 4. Maybe that was why that variant didn't work?

So, yeah, copying the exynos4412-p4note was simpler.

Cheers,
Peter

