Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B01B24460EF
	for <lists+linux-iio@lfdr.de>; Fri,  5 Nov 2021 09:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbhKEI5r (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 5 Nov 2021 04:57:47 -0400
Received: from mail-eopbgr40090.outbound.protection.outlook.com ([40.107.4.90]:4733
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229601AbhKEI5r (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 5 Nov 2021 04:57:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GqugoGutIl3eyBaFNKZqPIeRooJGQpK0XjWdQu0WDygARfnFxj/0tLyzhTiR+jOqNDQaYaCXfcdnyIRdSoeg6fBMclHJ7oMvuM7HmG2bYir+As6DfOXb/nPHvSG/MJEebSfDBg3j1PnNPMvmy+p+W7UHmVSmy/hAFlrDc/IlKuVEUt8GPb95opvrjUsq9tGwxN3XgWHdq8ue9/eH9LdhnlKck/W8JMY1HQF004uJhwL5GLePkM/TvtRJ10IcQs/ZhueG4N89gDD/8EQkbhK2saP6rVEb7nhhy6m2X4HqTmhQUP0alZnL492Z/rhLayRU1G7dBWJJD8Xec4ccQWiPBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iMzZrkFsIcY9gxOGiosRgC6NBkmbP6o6n0FxwMH+g9g=;
 b=JC6cTIUfNk3qmwphC/XDwmztqhZrfcu45MwLcIztpWwMuhhDMkOS3VFEyenHkQ87I6sVV1uOlIiaWIaux/ffjQXDo/yr151mlezq8yWPvivYLlHFndQ+iJrjrhOcDCcID68FiffBDWgDVZqzFkaXXhIMD97BtO9OusXt1LZQe3QwhQIVzniv70TD0hFaN0M9Ct4Rnf1NlB3L2L2W0iewmLreZe384nWKZ/PCuAasLewmY8Cv1yHDEeZAkNaSneDux49lC9cr/ib5I2tl28i/pa0SmrijQgb0dPdNuCFeVz3BTcebN/90VHZVWabtt3pNvvqhs+/mQjyF1LYr8b6osQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iMzZrkFsIcY9gxOGiosRgC6NBkmbP6o6n0FxwMH+g9g=;
 b=NgZa3LtgD7AYTkICX7h2cA4UUyAeDu/BSvUNwmnHn8VK95l1+vUUYLbsDfJ9Z/ww23iNCNP1Qx4hSdwP0yejDLabcGAgYAV53CHu+DVyMT2DdbhzAaD1k5zdC+koUkYKDxffeQosyIynrQIwth9fN8g6MNNlXpbsMpXLooUmPAE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <a3665295-6415-0c0b-f53d-87f658150991@opensynergy.com>
Date:   Fri, 5 Nov 2021 10:55:02 +0200
Subject: Re: [PATCH v7 3/3] iio: test: Add test for IIO_VAL_INT_64.
Content-Language: en-US
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Vasyl.Vavrychuk@opensynergy.com, jbhayana@google.com,
        Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAHp75Vd7Wwka37w-6QTXT9vv13bPiygKryBhQTnyvtTpCNU9qw@mail.gmail.com>
 <20211102073300.13376-1-andriy.tryshnivskyy@opensynergy.com>
 <CAHp75VfafpEBccivDRC2AVVJbZL2Kdq2KeR0yf_nwTtDTxvDkg@mail.gmail.com>
 <6d909cca-46a9-3f40-5d4d-97ef2fbe33e9@opensynergy.com>
 <0c449b88-a6fb-76ca-5c13-807f7728f1da@metafoo.de>
From:   Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>
In-Reply-To: <0c449b88-a6fb-76ca-5c13-807f7728f1da@metafoo.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6P194CA0066.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:209:84::43) To AM6PR04MB6359.eurprd04.prod.outlook.com
 (2603:10a6:20b:fc::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 487cf7b8-afdb-4aec-820f-08d9a039f556
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3733:
X-Microsoft-Antispam-PRVS: <AM6PR0402MB37335D43CE016D6394586264E68E9@AM6PR0402MB3733.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1186;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2V6W/CAXVDg7U+VejlNjSKHh00qqlQ7WBx39k+o7y2ueMsWbW2CpXZFqtAQposkYk9e1wG1Fu5oB7JwiMFRHXbnUXxk9oj6H0N+BgO0UkwjsRWRqH6kZs+YSr070qI7pKM2d2jJoONXPY99yj6kad5P1vHVbEoPVU9WgFN2Yj2Sb8XiwzpPGQJfEqp/lvG08NUfcAXsUlry/jwFBG0jtLdB5e3lM3hBnEoR049TCfp0RcawVX2+MpB+6S77jizX1ClP6vC/a9t8GdJNU/45HXGdVzDu7c3/0QwAfcQYjGhkuA3uUQYOVuq8N+lz19smkadsHWSjXJioOQ3jBXSm2TvmgjKuQUS9mobv7gYEgruSz9eCR8L7ay9QccTrMc5Ze8bVrsyS8m0NXPBexd7Wf8YFEcBjPZ6oMsk5JoyMDdvTeuiJKY4+PCugCmm0H/SsmFDDDDbmMkN+h1xItWnbchFuHg0bwokEbs8TbOZ8VDC9NH/BFpjfrZQtV0s6IrNtjBuC2oq96LqW1BLjX2OVgOLUvuK9vXYpU+XSfJUJZ6mR34CHPwtvbeWVAchgOl4MAvLb9lNRp6kD7i2aXMKI0RHnfPK0+MQVDKOQlSk6iDagZW6QJYjQXrJSMulrFoE7wIB6TKa9eNAKLmsM7kGpVEw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6359.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(39840400004)(366004)(136003)(376002)(186003)(2906002)(31696002)(316002)(83380400001)(26005)(8676002)(86362001)(110136005)(42186006)(54906003)(4326008)(66476007)(66946007)(8936002)(66556008)(38100700002)(36756003)(53546011)(31686004)(508600001)(5660300002)(55236004)(44832011)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFAwaVBRM1N6MVZlL2c3NFdnNWNBRXpQVUdQckZrU1ZyZGF3Y1ZOWnpvZFkr?=
 =?utf-8?B?Nm5HdEREZmU3b1hIL243RTJaYmF4TmE1VVZhdFFpUFZsREo5cS9rTVZobncw?=
 =?utf-8?B?dXRidisrTXhxaktKNDdvZ1VQOUFrYWtqancralZyaDhDR3JiaE5MT3dIN2Nh?=
 =?utf-8?B?cG1iMDN3ZVZFeUM4Y3JHRk13ZkFReCtFWHJsMS9oc1pSRTEyMHFzMm9qdkF0?=
 =?utf-8?B?UkFNRjZnWE5sd1FQWFcvRUlwRzNXb0pzNytYcW14clV0Nk0vRW9xSWlsTGVp?=
 =?utf-8?B?WnZkL1BUR1JzZ08vVGF5ZmttRUZ1RVQvUXVaQlhVYk5zWlBkSkJrcHlBdjBm?=
 =?utf-8?B?TTZUNm5LNVRvV3dSdVJackVBQzBEcmgxbW14Qm1UMWdrb2JmWWtMcERRR29z?=
 =?utf-8?B?MWtDd2o0VDhUWG1FYlVDc0Uva2dTT011bnJNNHNpYzUwMU16OXpaNVhnRThO?=
 =?utf-8?B?WnNlaVdiUVpZZTZvMTFOZWF2c0NRSFdRTXVJYmNQZjJQc1FPWExDaVBJc1E0?=
 =?utf-8?B?QU5WNGp6ZE9pbVlaM2ZmUkh0TTZmUDUvSzNnRzloWXhydnQ1RlZMazlzSmVT?=
 =?utf-8?B?aFo0MDVUWFlkbHFrOTYrSXhtOUVMcFYzLzRNa055bWR0eVR1WTdERExpVk1o?=
 =?utf-8?B?ME5ESVhCYlJNMG5CWVU2Mkx0Y1RKd21nOGN6SEw2Q1NzUHg5cXA3U0g1T3o4?=
 =?utf-8?B?bmF0ZnZrSnQxdXNtS3lnNmExV1dUVDVETzRWWWFRVGlJRGtRRVZkNjNmUENG?=
 =?utf-8?B?bElRb1RNaWs0OEQwK01CVXowdkk3azMwWnNoTjFpeStJZCtXdHFlNkE5ci9I?=
 =?utf-8?B?RFRtcEZlUkY0RWdLMExvaFlCd1dWTEsxa09JMXg0dHpPVUdrWUVJQU92WEFj?=
 =?utf-8?B?eEVTQ3FvVjlxMjVuaWdIL3NSaXpOZVQwUmc2SnVBS05iTVZQL3A2SDFRbzdh?=
 =?utf-8?B?MnRPSkRKTkwzcFBkeG9HZ0VlUzl4bVZNRFRPTkUvR054VERlT1lrRHExbmc1?=
 =?utf-8?B?QXcvQlA1SjFmbWZpVUQ1OFplZnE1Uzl2WTlrWVBhY1pFV1hreFdQTnhDWVBL?=
 =?utf-8?B?eE1EdnUvOW9MUHFEeEpNRDZQLzBjbStYYXdCVFdCdC90NTZ5N0N5MFVGdU9B?=
 =?utf-8?B?cHRPQk1LaDBDYXEwRm8wMVhra2swOVRPYjJnWEkxSk1XbVpsSW83Wmw4Smdz?=
 =?utf-8?B?eFY2bFEwSXFuYkx3V1IxRWdRK0djOVV3aTRFZlpEVDd2ZitXMGpYdVVtWUpz?=
 =?utf-8?B?YVNydzZ5QU1jdnBqRnNoV1V1ZVoxc0paYVpSYStjck1lN1dBZUU2aTRSVjRF?=
 =?utf-8?B?SHZqMlhobWp1WHFkeVZDWGl6MUlvZXdNeE9MQ0tsZlUzbjRTbVJnSlFuUDlI?=
 =?utf-8?B?NGRwVlljSHBmT2ViYmRXM2doTlFmREo5Y3F3bHJHVHNzeDR6R0dxV0R5cjVR?=
 =?utf-8?B?WStCU09ISUZTTDV4aUc5cFFMQmR0TkNWa1NxTkNEVlF0SzNLSUdWS1NaUlJP?=
 =?utf-8?B?UlJVdWpNODMzQUtsbXZ2bW5QeHA5NEE4NzVqZ1dsUnVOYkkxOWJtclJmUDhv?=
 =?utf-8?B?NWNBRTB3Q1hvVEFlUFpoMkZyajdmbXhGeHlNMGtSYjQrTDA5ZDNrdXlSYlJB?=
 =?utf-8?B?OU5nOG9WdTViN1k5czZOTG1kN1R2SjIxZkNpK29HVXErb1NsWnhkWER0Z2Yw?=
 =?utf-8?B?akpMczhBQUhGQ0FSdCtKc2pGRElsVU4zQnJkRTh5VlgwMTF1bHh0dHBvcW9o?=
 =?utf-8?B?cElXcS9ZUWhIMlhjNmZLUi9CZlFFTTVPcWlyK2tUOUpTM1NMTE81dkNkSHZI?=
 =?utf-8?B?OEdvRHk5a0xDZTZuOWdIUVVzYXJIM0dhbTNEK0xDTUp6czdFYS91Qlp5UVBX?=
 =?utf-8?B?aGFEdU91SXZ4ZXVrMHpCMzR4NmxZdWh3R29xTUZiZ0tRQTF3TFR5YnFMQ3BF?=
 =?utf-8?B?dFJPK2NQTi9OdFhHM04zYUFNZVVYUWlqQXVDZDdDNVVNTVlEZ2R1UDJiQ2Ns?=
 =?utf-8?B?cnhOdVFrY0krWGhBeUFwc0d2dU16MUFHZkZDWTBIcEtDM1BFU2RXOEFGb0VK?=
 =?utf-8?B?aFR3aUxsVFZVeFJodDcvd3Eydkd2UHRVVjRFQUhRVHEzWGV5enJEKzFLLzBY?=
 =?utf-8?B?bFlRQktOVVl6bndkM1ZhdzlXQnZoanBKYVlCTTZ4SVZkdmYxZEdwMGRLRVF1?=
 =?utf-8?Q?FhUjCBPduAb0rwIgbdJRNmQ=3D?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 487cf7b8-afdb-4aec-820f-08d9a039f556
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6359.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2021 08:55:04.0262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iHHkoqz/wAfaAgCCAvHAVWT3iGw0I8P+xqumwvINMPiyqxliPnvkkswMRsSV2/NsHRdsqadJ5jXhu7O9FaE76g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3733
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


On 05.11.21 10:50, Lars-Peter Clausen wrote:
> CAUTION: This email originated from outside of the organization.
> Do not click links or open attachments unless you recognize the sender 
> and know the content is safe.
>
>
> On 11/5/21 9:45 AM, Andriy Tryshnivskyy wrote:
>> On 02.11.21 10:11, Andy Shevchenko wrote:
>>
>>> CAUTION: This email originated from outside of the organization.
>>> Do not click links or open attachments unless you recognize the
>>> sender and know the content is safe.
>>>
>>>
>>> On Tue, Nov 2, 2021 at 9:33 AM Andriy Tryshnivskyy
>>> <andriy.tryshnivskyy@opensynergy.com> wrote:
>>> Now it's good with format, but you have missed the commit message.
>>
>> Actually commit massage contains a header only (no body message), but
>> I can add body message too.
>> Thanks!
>>
>>>
>>>> Signed-off-by: Andriy Tryshnivskyy
>>>> <andriy.tryshnivskyy@opensynergy.com>
>>> ...
>>>
>>>> +static void iio_test_iio_format_value_integer_64(struct kunit *test)
>>>> +{
>>>> +       char *buf = kunit_kmalloc(test, PAGE_SIZE, GFP_KERNEL);
>>> Shouldn't this be checked against NULL?
>>
>> Good question. Truly speaking I've made new test similar to other. And
>> no other tests has a check for NULL.
>>
> The other tests not having it is my fault. There should be a
> KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf) under the allocation.
>
Understood. Then If you wouldn't mind I will add assert to other tests too.
