Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4EAE6825DA
	for <lists+linux-iio@lfdr.de>; Tue, 31 Jan 2023 08:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjAaHt6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 31 Jan 2023 02:49:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjAaHtw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 31 Jan 2023 02:49:52 -0500
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BAAC2A140
        for <linux-iio@vger.kernel.org>; Mon, 30 Jan 2023 23:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1675151377;
  x=1706687377;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=x/eFx6mmvYArx1GxKxll84zMuSNFsgPUSJhK9iBF9HI=;
  b=dYJyOeSWO1NBExCGNTE+wnfNAbkg29WQ8CzOvLqpcz+ivwlns6K6BijP
   J/fEgum8OKaCeyBNlhNJ2Mt8cDfkn76V09DXByilJdKlKO03mgmKy+qMG
   JW3Q9JPAhNjlXXesELw9ewlWYJkJ1MHoG6HBoX5wnCPEwhu87wWBHW/DW
   aPZ4Gt+AXeE5TytkZEg1v93UA5erGshV+OVXRJwTdOG/nMKbv45OllNgW
   5dq72Thy2BTnmbxWvd+dPsHJr/xcFOuZnevg0OSg2tO+aRxOGM3UxXRMs
   pqYX2gE2kWY891A9BbUcLlv33Anw1FD3gXzmfJryov5YxSeMBzawQKK2x
   Q==;
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FLRo9jyCYmXFwP3dDH9eRBHds41XMXFY2y4GjSgt8P+NSANgoEGx9CEnYznuHp0ja5o56EwPl1r/jNVfSQvm+1BU3r09f0paDBiIO7VpFChOrJ+bKqcRewSVFPKUwu54yksaU67654zfdYC/IPczyfShTyXiTwh8Jld1Py7869hBcWXoDfYytEsDkN/4eodYAeKC+IUsZeTt2ZsgVQ2o6APzAj7jRWICax4S/xuBL6vEFnInABKAx5cKWeHw8l1HrQk2VsrXUjuSeUZpJHaLqyB5c7sjsndpuAXI58E2/MTvhzfNKaGRSPfAO7Lsv+RFUHpwjpDurIibhIUejhzCpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x/eFx6mmvYArx1GxKxll84zMuSNFsgPUSJhK9iBF9HI=;
 b=C378s6zxGSBrHg8NiPSmO9tXReBj+xL0cyK1YKMumkDt+whFJiH0mUEoBXoflvTbb9IZD8OZA6Yk8/Lt5JYntdvfZSZoxB4ge3HQcpwaH5ucgC+4RHm0/OJOAadzfZAfxlt5QE4FOShgOCCqqOazuyaTxETxh177hpwJBtxPat6NQqWEd2AeWliIy7DSeYX+EOAYESOO0cCAvGMkBwo7D6IC6sllq96kvr3X+ODmuFGhZlO+OuHJfMkgjVpPtUqaGgbSJY1L6bH+aNCKhH1HAIhxaw0WE6ES2jpm5Qt8VLOJmkpB8PwldMFdw+qOPbVJPDQEhiHSg7S2u0W8QAiHCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axis365.onmicrosoft.com; s=selector2-axis365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x/eFx6mmvYArx1GxKxll84zMuSNFsgPUSJhK9iBF9HI=;
 b=j2nz86IXlWhFMbvcHfa2ha4QWMZ4KtYzDDs83nDugV71ir869FDEzftQpwjCi23AatEihKXjsSD6xTRjEswyNWdEnQnXQteCGeJqJ6I8EOQeDashq2dD20YET0R0RYKgMiycXAEJ/IoZ/cQ6l/M5vmWJBIJptXFGyVHc/YH90tU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Message-ID: <f2265aec-a8aa-2607-8f2b-c6c5dabdc076@axis.com>
Date:   Tue, 31 Jan 2023 08:49:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] iio: light: vcnl4000: Fix WARN_ON on uninitialized lock
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <linux-iio@vger.kernel.org>, <kernel@axis.com>
References: <20230130093742.838577-1-marten.lindahl@axis.com>
 <20230130130418.000013ce@Huawei.com>
 <6a1d8766-2777-83d6-6d1f-ecb81da4b11a@axis.com>
 <20230130173029.00006995@huawei.com>
From:   =?UTF-8?Q?M=c3=a5rten_Lindahl?= <martenli@axis.com>
In-Reply-To: <20230130173029.00006995@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MM0P280CA0024.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::13) To AS8PR02MB9529.eurprd02.prod.outlook.com
 (2603:10a6:20b:5a5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB9529:EE_|VI1PR02MB6416:EE_
X-MS-Office365-Filtering-Correlation-Id: d16f0b26-d70d-44ef-30b1-08db035fa26a
X-LD-Processed: 78703d3c-b907-432f-b066-88f7af9ca3af,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8/khqT3khqKHT11B1OlC52Utb5aXwQnkHsp2Mmf1r2H5nxS2gSruopLRX1x09ZdM00f06Ok4cFnOR0lL8EqQx7ErL/H+IN5tOCw4Khh3s9c0qkLL+Rl/irsQEuOutCO3KMadrCB3njf9NJELw+ciTSWtzbS3rq46YW9kD1VM4HVnz9Jvi+bfVS8pYPy/M9P7oKzUDmnqNZ0noR0wQ3CFvPRof2f1gvSOM7E3cryudVY8rwghtXGmFsjZYDxIbteMArPXi5BHROl9RhYbTLijlTi1umMFEn257hF+Q0P1U8482AO0Hz1E3dSl/oPkXtGPZS5QpaQfO+sKcyAhDPYMPtRyuAppxr+aqnZS+rlMhqdCrRGzIXgumLOcd4suUziWgb7YVQl9yadL4PwQdO1dl9rQ0LBV4clDkXcxrdeP63LA5a/fzvvg+NNXyTsKCdDkXlrlTdcgK2OWHkgDeQUlZRHbM2p8BpzVo4txgiBMwKkIKg1yfWyR+xYWSO4i/tHuGCDIa1zWogvAkSFkblp/k+yfHK+xjFr9DDWpjQmF6vFurdoDiKp7BBJbBWPYsQ79i4Iwp0VWlxl2CysWCcQ/4u0G90iXVpvRSQh6H4KjTzxJVdYqlNUtMiJpPCYnMvKxsxr5skhx5COL62uXFAgVuZh9kQoaXsyzxRZtxIqlcI1+nhBM3CBTiMxaWEQ5bQ7vB24NbXh/34q+V3MViiuSCGp/6gDnqDQTAEvzN48jgFQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR02MB9529.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(39860400002)(366004)(376002)(346002)(451199018)(31686004)(83380400001)(66946007)(66556008)(66574015)(6916009)(66476007)(8676002)(2616005)(38100700002)(41300700001)(6506007)(53546011)(6512007)(186003)(26005)(107886003)(8936002)(4326008)(316002)(31696002)(6486002)(36756003)(2906002)(478600001)(54906003)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2hLdlovS2F5REdHcEVkTjZ1ZTFzZmlxSWpSeHptZUNrYzFCSlNnaVUvMmdR?=
 =?utf-8?B?S1M2akJyWjMyUy8zOFE1T3k5cW9UOHgzWHFaNjZsZk1tc2VwelhZZDNvVEdJ?=
 =?utf-8?B?eHpwNmd0TzVnaDlJL2c5NGpJMytxeXRPT0pGVlNWeEZTNUxKMVc3TlV1SllO?=
 =?utf-8?B?V1JWSnlUdjJWQU4zc2R5OFo1Mm5nMGZlQlhPWkVaNnFMRkxUTU5YN1pZUjRz?=
 =?utf-8?B?a3hYQS9nQU1LUW0wRmp2NHcrWnFiY1RVNDI5b0RDQkpybVpLRUUwa1B1SDBL?=
 =?utf-8?B?WkM5WUw3RUlaTldsaCtuWlNHbzZ2ZlZxaHk2aTVkODV6UGVweXgrU1BXLzMv?=
 =?utf-8?B?TTcvL0Jsb29NNDBkVkZLeTY5WklkYllhSVl5eFE4S1hxVWw2RG4vK3lZR2RR?=
 =?utf-8?B?Wll6clJLbktFYTVab3AwS09VUldtRXFzcE4yNkhpeHlEVGl0bEhnandZYTli?=
 =?utf-8?B?bW4yR3gyclExQVVwVUJ3Uno2Ym9UcWZlamI4dnBqVzZSMUdnSVhYYTF2VXJJ?=
 =?utf-8?B?cy8vZ1dQRmJHTWIwVHNrYUdLTC9zdmlIMzYyWTd5Nnk5QTVDcUs3V2xVdFR3?=
 =?utf-8?B?WU0xZTBQTUc2T21UNlZub1NDcXRWd3BiR3hiVVBjSmhsWkt4QjR0a1RYcnZF?=
 =?utf-8?B?OWhkWmtTRzFKSVI5aWdXVnJ4WFRRbzQvTmNwblhUL01qQWMrOTNSOTd1bVVL?=
 =?utf-8?B?bTM3cDdDMTRieEZaU25NL3d5aFB0eU80c1NyK1BWRmxMYXRCcHZKSStobFNu?=
 =?utf-8?B?Q1M3WitnWDJDUlUrVE9HRTA0Z2J6Yk44dkoxZ0tGdUF3VTNBa2NzQjVjUFdn?=
 =?utf-8?B?OWlYSm5adGJhZXY2ZDgzZ2VGYzF6RWJNRkxJOWVsV0lMRjdjd3VyWEFvV0RC?=
 =?utf-8?B?NlpOWDBlVXlFdlhSWm9iMlV0VWgyMFFUdmRlYm4rWGU2U1MyQ3JvU2RIQXN2?=
 =?utf-8?B?YkpyN0tnajhVRDNWTzJWTkl3SWl2dzdod2ZabFd0R1hQZ2hTNlhUUEI5ZEV5?=
 =?utf-8?B?eUdRcU9pc2ZCS2Y4ZkhwMTMvd3J0d0l4ZGlJejgydHpBOEgrQWhwSkl1WG0x?=
 =?utf-8?B?TmpuUUFOa2tyRGRLSEk0ckpoVEJpa0VvT1dzMTY1Zld6cVptYmJpa09iakV5?=
 =?utf-8?B?L3IzQlo1cDRlamgrcmtoTEtOQjRBQzNOS2hXekRaT2FFeCtzTFpxY0JaNUh1?=
 =?utf-8?B?UFJnajVUVkJNZmJHc3ZGSDFRNUsvV1ZWNjFuZm9BUXpGNVJPK1Awek1Ha29J?=
 =?utf-8?B?VndRaGVYRGkzaCs2Y1puSks4eDVZOGF3Um84QjhTbXp4dFJDL3djNkxjWnZ3?=
 =?utf-8?B?OER1OWt0NFd6MVowWVNkazJTbVdqUGhITmNub0ZmUlRSM2JPcWxTbzMxaW9G?=
 =?utf-8?B?U2x4REd4OG1FQjdZZm1sb3FWMDFSVnhkakRQUjVTRjVrWTZSY1FzVytNNnhC?=
 =?utf-8?B?WUUraDdWUlRFS051cFlHdWNvQS8rWTE2UlMwTVM2RkpTN3RSRjRIN0VaeEtt?=
 =?utf-8?B?TTBOYldSSTVQbWkxQkxONHozRlE4c3VHb28vQXhRS0ZFbTdncXpva2tWZ1VE?=
 =?utf-8?B?ZUcxNWQ3R1FLdkxSb0wzWFI2WWpBVEp0YktIbkJ2Q2JBVnN1QnFVMnNJaTNh?=
 =?utf-8?B?QXJCdUtWNnhTdldWVHEycHhuSWpoZHFNY2xsbU4yUzRHTkMvOURQS0g4dWJW?=
 =?utf-8?B?UmNMVnZvREw5alhVcS9KSWNHZjRIb21tNGxjZDBFTXdtSE5YRldTbWd4am1H?=
 =?utf-8?B?cmJCdTBaa29YTU9pa3V6SVQ1aVFrZnJuZDE0a00xUVA3WDY4Vmd5N0xjSStl?=
 =?utf-8?B?aFk2cDRub0djYzd2N01SRzl3NXIyZlc3RzNBVmIzeFloNkJRN3J5MnFtTjI2?=
 =?utf-8?B?Z1BtRURFRlFCZVNEVG53WHBYRWI2dlJRWU9MRlhtQTk4RjdVZ1ZkdVlFUG14?=
 =?utf-8?B?aERvS0xtSWtMK3RVc1NYbHNMUm1lOExaQ2V1TTNaM00zcTZINmRQYXdkYkhY?=
 =?utf-8?B?VXNKRnlWMmdiRVNneSticzE1QzRIQ0Q0VXhwZVdzSUc1ODBYMURvWVBjdGV3?=
 =?utf-8?B?TmR0NkNJWnhQRWRNS0k4LytUWS81ZzF0RG1tdk96U0tWS1dnSlNtaDNBdDAx?=
 =?utf-8?Q?i896L4lNpeE+XsgEYieK08mO+?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d16f0b26-d70d-44ef-30b1-08db035fa26a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB9529.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 07:49:08.5952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ri1UIDhz1OeFSUVTCrIVSYFFuWHgh3Ur1OvBaMleZtJASdaxYbNP/pKDluCycqeWmdmk/tpiLmoWlJFrpWWuoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB6416
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


On 1/30/23 18:30, Jonathan Cameron wrote:
> On Mon, 30 Jan 2023 15:10:40 +0100
> Mårten Lindahl <martenli@axis.com> wrote:
>
>> On 1/30/23 14:04, Jonathan Cameron wrote:
>>> On Mon, 30 Jan 2023 10:37:42 +0100
>>> Mårten Lindahl <marten.lindahl@axis.com> wrote:
>>>   
>>>> There are different init functions for the sensors in this driver in
>>>> which only one initialize the generic vcnl4000_lock. With commit
>>>> e21b5b1f2 ("iio: light: vcnl4000: Preserve conf bits when toggle power")
>>>> the vcnl4040 sensor started to depend on the lock, but it was missed to
>>>> initialize it in vcnl4040's init function. This has not been visible
>>>> until we run lockdep on it:
>>>>
>>>>     DEBUG_LOCKS_WARN_ON(lock->magic != lock)
>>>>     WARNING: CPU: 1 PID: 8800 at kernel/locking/mutex.c:575 __mutex_lock+0x4f8/0x890
>>>>     ...
>>>>     Call trace:
>>>>      __mutex_lock
>>>>      mutex_lock_nested
>>>>      vcnl4200_set_power_state
>>>>      vcnl4200_init
>>>>      vcnl4000_probe
>>>>      i2c_device_probe
>>>>      really_probe
>>>>      __driver_probe_device
>>>>      driver_probe_device
>>>>      __driver_attach
>>>>      bus_for_each_dev
>>>>      driver_attach
>>>>      bus_add_driver
>>>>      driver_register
>>>>      i2c_register_driver
>>>>      vcnl4000_driver_init
>>>>      do_one_initcall
>>>>      do_init_module
>>>>      load_module
>>>>      __do_sys_finit_module
>>>>      ...
>>>>
>>>> Fix this by adding mutex_init on the lock in the init function used for
>>>> vcnl4040.
>>>>
>>>> Fixes: e21b5b1f2 ("iio: light: vcnl4000: Preserve conf bits when toggle power")
>>>> Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
>>> Perhaps better to pull the lock out of the device specific setup?
>> Hi Jonathan!
>>
>> Ok, having a
>>
>> static DEFINE_MUTEX(vcnl4000_lock);
>>
> No. Definitely don't do that.  We need one per device instance.
>
> I just meant move the mutex_init() into the main probe function rather
> than the chip specific init that is called from there.

Ok, sorry for the missunderstanding. I''ll fix it.

Kind regards

Mårten

>
>> will make sure initializing it wont be forgotten for specific setups.
>>
>> I'll test it.
>>
>> Kind regards
>>
>> Mårten
>>
>>>   
>>>> ---
>>>>    drivers/iio/light/vcnl4000.c | 1 +
>>>>    1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
>>>> index cc1a2062e76d..a8a9fc3b1a02 100644
>>>> --- a/drivers/iio/light/vcnl4000.c
>>>> +++ b/drivers/iio/light/vcnl4000.c
>>>> @@ -316,6 +316,7 @@ static int vcnl4200_init(struct vcnl4000_data *data)
>>>>    	}
>>>>    	mutex_init(&data->vcnl4200_al.lock);
>>>>    	mutex_init(&data->vcnl4200_ps.lock);
>>>> +	mutex_init(&data->vcnl4000_lock);
>>>>    
>>>>    	ret = data->chip_spec->set_power_state(data, true);
>>>>    	if (ret < 0)
