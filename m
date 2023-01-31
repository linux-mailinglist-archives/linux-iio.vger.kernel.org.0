Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7D6682DDE
	for <lists+linux-iio@lfdr.de>; Tue, 31 Jan 2023 14:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbjAaN2C (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 31 Jan 2023 08:28:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232043AbjAaN2B (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 31 Jan 2023 08:28:01 -0500
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C2CEC152
        for <linux-iio@vger.kernel.org>; Tue, 31 Jan 2023 05:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1675171678;
  x=1706707678;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bNu4G1iqYwxUkELxKENOvKjO12I2WOIUIms5kBeDkjY=;
  b=W/YtfREIN7rPtD0wEoh/SCzNVhK8Kholb4A1dDWAM7oBOhIWH5bNwJl/
   LByJuwZ+KQ3ZmdNvIS1e2IJk5DB/4/CnRRUODQAYvi3qSeBeyOsqjiCDD
   SO9BHKoGgaiFZzmZLBX5qByoO6oJkwfbdPz+tTTCOTTDA/U+sMGLp/eym
   zXP9HROUN/nw9whwJP3+SqmhI49L66u4oy89JaZ4+yLDCRgK+qj03z62y
   oQ851O7THPlDmXCQ6I4CVNlJxlCls/pMW/lcnASdL6eZouJjb2RTcJU0Z
   DCDagj20Wv0hNimCgN5w99BwH5AK7ROlhr18cEB61N46ior7QwtOnjlyA
   w==;
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QFGGarJQLSWVBVqqDCVp2lpXSqH8fJXjV2m46p9iowEEXBZfQ+G39uaJBPJSdy6B28+godrqgZczs1k5FpjgqK2m5lwacTB3djkU/GVUrmTWp+ttCisBL2a0uP34FHWqShJHUm9EdxJmpSIIuL0tQpYPWqmMh3wldi1S2LQ5xHkBlYTGcIemYcLkMf2k1ELaXm313I9JxNbc1HAXYpj1ggsbuh/lbMjjIC+bwlpg6tcx1QTst3kzt0//eXP32bCsEODhuWx5RojHVjvjW1HXPVW1q3IBF/C0xg0eAwFIAzvEakFAPng2u8Sj7jptxdCDWiR4G/yvRsXmxA+Bm51ULw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bNu4G1iqYwxUkELxKENOvKjO12I2WOIUIms5kBeDkjY=;
 b=IHg1Cq1RGnXPzL3iVrfyCLRw4Mz9bACXzSGziRoD5KUlwto/Frg8nvqHuu1PXzZgx+G2LtXjkDVzP8JNF8iPdhGbvKZ8uz+/mdQst5LBsZ9Rqj7xzL12kaznPc6ypx5n65vV2nX9QjAhRnWexMhzr7+JTGOjl9b/yErMBsAyEEt81cj95YrJGJWh6ltVyIu+T3/MlnH3Xs/L7Pj1xFl2NP83bJC5p3v7rt8RXLlvBqzA678BlpigScM/Tr1/cCbA+66+AOztb12l2sFp4985d86DFuNbb8Pve6R/8m85zmNoOaZZAFOEoCmdT/Xz+YNUSKks5ZyIw+BRUNv2qLVSOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axis365.onmicrosoft.com; s=selector2-axis365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bNu4G1iqYwxUkELxKENOvKjO12I2WOIUIms5kBeDkjY=;
 b=QXe4z/IAe7o/jN1UBqQIFWcWtEA8jblgtEOJV1m1tehlUMJ3P4KOqnnDJRuUFApcJF6wZul5KrHjBZwOUyMH3bDrsDSWxr1T7TigsBs+tIuDaIlO26aW+RVNj/4nZ/5nD+qDbT6Byogwk703zEki3YrLM+ZPzVdsF9yFbsTGAik=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Message-ID: <67f7888c-5d5b-4c63-42d3-cf2b15602478@axis.com>
Date:   Tue, 31 Jan 2023 14:27:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2] iio: light: vcnl4000: Fix WARN_ON on uninitialized
 lock
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?Q?M=c3=a5rten_Lindahl?= <marten.lindahl@axis.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        <linux-iio@vger.kernel.org>, <kernel@axis.com>
References: <20230131102951.2012021-1-marten.lindahl@axis.com>
 <Y9kKsv7OJ1KoImjJ@smile.fi.intel.com>
From:   =?UTF-8?Q?M=c3=a5rten_Lindahl?= <martenli@axis.com>
In-Reply-To: <Y9kKsv7OJ1KoImjJ@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MM0P280CA0017.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:a::6)
 To PAVPR02MB9523.eurprd02.prod.outlook.com (2603:10a6:102:303::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAVPR02MB9523:EE_|DB3PR0202MB9304:EE_
X-MS-Office365-Filtering-Correlation-Id: db025906-8036-4eec-731a-08db038ef4df
X-LD-Processed: 78703d3c-b907-432f-b066-88f7af9ca3af,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q7loD66J1pMcGyW7HtczqEug8XBn60pmXfQzctyxFOLriZQYQkInvY35OCZThpA4mxOYx0U5zLdczMV0y8nfVV+0E9w6TA1ppawFiiH2YDmwbdLphfh3JhpJ0n2bGs54DIZnFL9UmloQKRC5HGQOol+biUB7JS26zy034YfEaa9agvcxw6iLoRsy9yLNQU86yrzo2PmzwtdIegVHNi6KjS9391aSqdhq+3q5wwPgNC42KhagRn3X6Iyi/9cKf0DcgdEJqpbOgDej9rlidXfcxoWIbKeapn+D1ZKxHMmPk3xDiDx7+TBUoqCi1nJWCWbPnSY4QIZCTO00Rm1tWOuffkxPvuyItuzRlP8JPwSiu0B+gNPcQKK5P76o9qVG0cq0VCzyqBpJTEDNjiXmBpNMC5xtaFAPEzLV3iVsUF/lHf8qLV/dKpQ3u+o8JTtxbRuLlBEoNjszs5sUPH65TQgL0tkDc+KmTZz7b28YYG/AnI9PZArMwOhef0iaGshG3DGt9QWXds1mkCbZ0aafJtD+q912ZT6aSGHTyxTduYSlKVuohVGceXGec2tmvupcm7e5BVAYiVcSvrO+6jR4yXHOclV7+qTPchwrsP/R+oWqpaVok093OweGBBOV6/oX7ZwG4R27j9XRrrInBZEDC4B2GnJrbZpI5EZSxd3N/WqfgFlDw/sFFggJ7eSHot+yjKNvTAv/UTe4q8IROz5IAc4yCvpltfpunU6aVgwWonNHmR0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAVPR02MB9523.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(39850400004)(136003)(396003)(366004)(451199018)(31686004)(8936002)(66556008)(6486002)(2616005)(66946007)(66476007)(186003)(53546011)(6512007)(41300700001)(5660300002)(26005)(36756003)(31696002)(83380400001)(4326008)(6636002)(54906003)(8676002)(110136005)(316002)(66899018)(2906002)(107886003)(6506007)(478600001)(38100700002)(66574015)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bERId3pORkl5QkdFOTFFSEt4WjVycTBzdXoxMzN2TmJSTWh4T01oWGN0RUlz?=
 =?utf-8?B?Tm9kMEUrNFVyZDg4Z0ZwUmtiQThHcUF5bS9rblZVc2V3V1Q3bEUxOFY3UVQ5?=
 =?utf-8?B?aHJNR3ZzTDJqb0hVRkpPdjcrVGwrZXJlWGhReXpNQ3kzTzlBSjJZcXc3SHdW?=
 =?utf-8?B?UDQ3K29LbG5xblY5amttUVExMGZHeGd4QnBoenVCeUFtMDhmb2JCSURFdEJ4?=
 =?utf-8?B?ZjVOZnd6UlNsd2JUZEtzaWJFMkFISU16TkxZU2xadE93S0ZVc0Y2bHNIa0l5?=
 =?utf-8?B?SXRPZXNvTE4vb2d6c1AxR2l2N2R2RHlqNnU1NlhjU0VzOWpKZjhlVXRrdi9O?=
 =?utf-8?B?dGQwbFBKeFBadDJsclQzaFBJV0RYT3FLWnZrRHo0OExUcENNOEdOaEdGbFl6?=
 =?utf-8?B?Sy8zVHZCT01WRWxkT2tRVlZUQy9sWEJYNS9wbzBudGNoUTNyL1E0WFozV1hx?=
 =?utf-8?B?eVVpbDVFV2RPeHFZWTd2aGhCSWRkeHZsL0VvVllneTRFM1JGbk1HL0JrYzlQ?=
 =?utf-8?B?c1UxOTdrTVNNaXpMOGNzMk4ya1lkWTF1ZTEvKzhKdEhXY2g2amd2T3ZGQ0VJ?=
 =?utf-8?B?TngzY012bHc5U2dKTThtNGdHUFJkQmlqdDNaRGRTVjVNVlpZeVFnZEpXbGhV?=
 =?utf-8?B?WnN5VFN0RCtsM0pKZUVsN1o5OVNVRW1rclBma042eSttYUlkMGdtR25ZajNC?=
 =?utf-8?B?dW1WWjJub0Zvdi9GZTJwbzdIUXZadVZkWHZNWmNLWXRSQk1XMDEyMEErejY3?=
 =?utf-8?B?WXlzaGZ3SC9ITUhpZkd6VkN1NlFTeksxQzJhRHF2bTV3OUtYWDZuaVVqU3NE?=
 =?utf-8?B?R0QrQm1XaklWQ3JxV0F4WUhhd09QdHJFN3N4U1N4b3d2d3d0NlFUdTkyS00v?=
 =?utf-8?B?dkc4UTNDaHBnelYvT0RVV1o5Zlh2OWgvUXM0L3BhdHlRTGp1RVZOVHU0QndO?=
 =?utf-8?B?OHFmQU16eVJ6QW1wY3p0b0lqTU1sY1hkSmt3ekF5YkRGRkFkUmFDM0RrMTBM?=
 =?utf-8?B?a3BVUE1oVDdMZWp3UFpYQ1hvallzeFFPdlRjU293RE1pbEFqUndpWGVXV0xz?=
 =?utf-8?B?WnczN2N1T2FWUFo2RFFOME5SQUE4NEhVNjN6eWRvN3FJdjhjRElVOFlySHhP?=
 =?utf-8?B?VWdHQ0RsdVhDajVyMWlmY0RURmd3WElFYVhrRGNzOE5VY1pCamlaTlg4bUpD?=
 =?utf-8?B?L2Y3T1lJRGVpakhGWXl0aXhDL2tCQU8vcmFqS0dZSmtDY1hobHpHcFZJU2Fi?=
 =?utf-8?B?aXpManhSV1ZrM1AxTnQxdHVLTlc4OTIyaFRGMDhVbDJ1S2t0cCs0Vm52NER0?=
 =?utf-8?B?V25uVjdEQm9sNjRGWWZ0Mm5yRGxVOGNTV0NsSTAxNTA0eW9VSFY5aTdqVTRT?=
 =?utf-8?B?Mm1zYzIxQlBWVmhNazhZelVRRXBSWnBsTEVQSXhQYnlFN1Y4UlQ4YmZacFNl?=
 =?utf-8?B?WDFLeExHcFI0UFpJRFhTNlNkSitLcWVDMTh5K08rSW9GbXVvVWd4RWlEYWtG?=
 =?utf-8?B?WWk4UDc0Z2IraUF3Z0hHemhyOHFEck9ZZTdEMW45K3gwOXpOZUtVWWxQbnlJ?=
 =?utf-8?B?WFpJM2dIRDE0TlFBVUNIUTk3OHZhRE9iRmZnenI1NU9XSzVBTEhLVkJ4aG9M?=
 =?utf-8?B?YnpZTTlCVmZSR1ViUktWMzZlNFIrVFhxNTJIMnpmWWtGQ1FQNVhaMW5sS0JI?=
 =?utf-8?B?TlRyRVZiRGV0dGZIM0JHWjUvVTU3VlFqNmRSS1pOTnliTjdtaThpK1NTNldw?=
 =?utf-8?B?ZUZ0YUZZY1lXaUZKNk1Na3BlT3VUTVhuUXhEYzlWUDdtZnZTRzViRlpMSXY2?=
 =?utf-8?B?WlhiRHF4R1BDSVI0RE93cjdYam94UnR0MmFLRjRxZm9DVVlsNXhhZXMya0hi?=
 =?utf-8?B?VGdtb05reDFvekJrU2FwTlR2cTZvUmFuOVB1Tm5TakhmVFhEZmxmcnIxT0o3?=
 =?utf-8?B?czdibmU2Qk1rcFVBVGhQM3pvSXY3Ry80N3hrMVhtSWxROVBGcDRWVzRvZEJq?=
 =?utf-8?B?VTBxNVhkdFFSQ3NHcFArN1pjZFd4NDJ6Sk5udWJqa2xoWXk2WGxrSzNKcVVO?=
 =?utf-8?B?RFhYNGphd1JFWkFOcTlqNFdrdTN2SjlJc0lCOWNDMXhVTFZBWEpqRjA0Rkly?=
 =?utf-8?Q?7WBtSeMrvFkLmkfGd4puhdJXy?=
X-MS-Exchange-CrossTenant-Network-Message-Id: db025906-8036-4eec-731a-08db038ef4df
X-MS-Exchange-CrossTenant-AuthSource: PAVPR02MB9523.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 13:27:53.2831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Ig0V+9+h0JiATa65yB9P8GgSXrJNUugeZqoPSHtgtymNSOxSTxP80EOSMxTmX2G+6PGAad+9ISi+k8tOH+3pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0202MB9304
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


On 1/31/23 13:33, Andy Shevchenko wrote:
> On Tue, Jan 31, 2023 at 11:29:51AM +0100, Mårten Lindahl wrote:
>> There are different init functions for the sensors in this driver in
>> which only one initialize the generic vcnl4000_lock. With commit
> initializes ?
>
>> e21b5b1f2669 ("iio: light: vcnl4000: Preserve conf bits when toggle power")
>> the vcnl4040 sensor started to depend on the lock, but it was missed to
>> initialize it in vcnl4040's init function. This has not been visible
>> until we run lockdep on it:
>>
>>    DEBUG_LOCKS_WARN_ON(lock->magic != lock)
>>    at kernel/locking/mutex.c:575 __mutex_lock+0x4f8/0x890
>>    Call trace:
>>    __mutex_lock
>>    mutex_lock_nested
>>    vcnl4200_set_power_state
>>    vcnl4200_init
>>    vcnl4000_probe
>>    i2c_device_probe
>>    really_probe
>>    __driver_probe_device
>>    driver_probe_device
>>    __driver_attach
>>    bus_for_each_dev
>>    driver_attach
>>    bus_add_driver
>>    driver_register
>>    i2c_register_driver
>>    vcnl4000_driver_init
> E.g. the following can be cut without losing significance of the data
> (see below as well).
>
>>    do_one_initcall
>>    do_init_module
>>    load_module
>>    __do_sys_finit_module
>> Fix this by initializing the lock in the probe function instead of doing
>> it in the chip specific init functions.
>>
>> Fixes: e21b5b1f2669 ("iio: light: vcnl4000: Preserve conf bits when toggle power")
>> Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
>> ---
>>
>> v2:
>>   - Trimmed backtrace in commit message
> Not enough, please try harder. The ideal is to have ~3-5 lines of traceback.

Hi Andy, Maybe I get it right soon ;). Could it perhaps be stripped like 
this?

Call trace:
__mutex_lock
mutex_lock_nested
vcnl4200_set_power_state
vcnl4200_init
vcnl4000_probe
i2c_device_probe


Kind regards

Mårten

>
>>   - Have 12 digit sha-1 id in Fixes tag
>>   - Make the lock initialization in probe instead of in _init function
> ...
>
>>   	data->client = client;
>>   	data->id = id->driver_data;
>>   	data->chip_spec = &vcnl4000_chip_spec_cfg[data->id];
> + Blank line.
>
>> +	mutex_init(&data->vcnl4000_lock);
>>   
>>   	ret = data->chip_spec->init(data);
>>   	if (ret < 0)
