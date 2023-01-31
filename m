Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40201682E06
	for <lists+linux-iio@lfdr.de>; Tue, 31 Jan 2023 14:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232270AbjAaNdx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 31 Jan 2023 08:33:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232240AbjAaNdt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 31 Jan 2023 08:33:49 -0500
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DAA446715
        for <linux-iio@vger.kernel.org>; Tue, 31 Jan 2023 05:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1675172023;
  x=1706708023;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nzR/m7oR0ji3qyD9fptYQHCy5q2rr1bUiNi3x3sdHR4=;
  b=SjRohRqmy8K60bfFn2nsNZNYXXihW/yQ4XEY43cUToB2+bgdwaW5ujua
   rjTMYDLwMdeQr1vLPT8dPisf3VXY0bloyE/bKK6IG055Jy/HxoOzsGatF
   kIrE2nUuolQCcQvc+Fs8bV3GB9bqSXqYjR+7100tdE3+Ww4VL6dIqzvAb
   2IUldamkzTCTUtsbPZZVg8u58eUiP4dsxGaJSAy3IgRJHt8gTyzr+wHOT
   iZ2RNmNrHFA9iTAf4tEBjXaNmKLDDnMRwKihOq0Hmt4WMOVyyW95hbAY0
   N5+GWHkO61kdZ7qA36sSxakdpghAH0g5IpFo1HtQcqu9iNmtJG9JJxD5P
   A==;
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XJit6gj8WFrvbuCE4k61bwLfzlCELvj9Tt+PrVKEtsV0iPQ/vJ7n0uXnXa6ze/Zb7Thdp2OiVQuEpwVTwCBjZveWVtYeoMqAkgjIOZYU7FJaj7UFthiR7o0EqhPLcvlewxhPrAtoyhCKW1zImQabxRBhgtmuPMNOx2xFxDtd+1dw3iNQCZty93g2pjowHnlDCk+n4pw8mC2AA42V//VqciGkzYq5WeqTk1Zo3cxuwaSvqMUd9T5bdh09nb85jp9wWsRG1M8EEqM0zGz7wH4Uq6d/RwjKqDaMYEHN4rua/v6EzrLXbZd3kwFEOVPpGVGYKNzkeKJ1eQ/NThAl9Di4MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nzR/m7oR0ji3qyD9fptYQHCy5q2rr1bUiNi3x3sdHR4=;
 b=ZJ/5YdjBjF040fkg/FSQIW/t8albLlJC9wiRnLK/xbSwTwBXdGydodE7Zecwpbp+aCepLVy2TpmCPfXmT+xKedg6xGuEcTqhnVgoelbTo3ePcAP0ZfeOrFjwhae1Ylxg6V6OcGDJZA+WRdsJ6AAahiYU2Nq3zh7Sme/O8G49m/9lXXZdyh7Anh9oy8ZUQlI2v7RjpFWwcciCKYcQRhQLcwaF0i4ZtIM4KuwWuIn4BENmrSYs58TZCOXfBdQZv5KDS2EnVu6k8NWJWR/Npay4J2ZWM3DORlZb4VJ8K7ppYd/EpOFkuc1UvjydGtDnT4NTwqMNezETgHwAOR2HrEodIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axis365.onmicrosoft.com; s=selector2-axis365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nzR/m7oR0ji3qyD9fptYQHCy5q2rr1bUiNi3x3sdHR4=;
 b=pNOjjDTIoeV2xaCnVjP0Zz/tbmW+FoHZljj1tmKGnQHFEDWO2uHxKrtGuWl5X9o9DGhZXdLVC9+CXu0D9UfgEogq182XBuNma5zgIkcdMAgcuCtVeQnxbqMVNktfxVHhCKMpPd6B7BY9VVk3ahwBPLyBHREAJFHzBsFZ5PU9V0E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Message-ID: <d1ab0530-ef51-988b-f8b3-c69f6d3abb8e@axis.com>
Date:   Tue, 31 Jan 2023 14:33:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2] iio: light: vcnl4000: Fix WARN_ON on uninitialized
 lock
Content-Language: en-US
To:     Cai Huoqing <cai.huoqing@linux.dev>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <linux-iio@vger.kernel.org>, <kernel@axis.com>
References: <20230131102951.2012021-1-marten.lindahl@axis.com>
 <Y9kNuPlRBVCnCHFb@chq-MS-7D45>
From:   =?UTF-8?Q?M=c3=a5rten_Lindahl?= <martenli@axis.com>
In-Reply-To: <Y9kNuPlRBVCnCHFb@chq-MS-7D45>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MM0P280CA0025.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::16) To PAVPR02MB9523.eurprd02.prod.outlook.com
 (2603:10a6:102:303::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAVPR02MB9523:EE_|PAXPR02MB7261:EE_
X-MS-Office365-Filtering-Correlation-Id: e4fce921-3649-4b2d-3d08-08db038fc3aa
X-LD-Processed: 78703d3c-b907-432f-b066-88f7af9ca3af,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nYFQauCxhmcxvD5TrEKk0sLIKEzCYNmyKFETQ5Wbb3ODYByqvEiJOb1+HihQ9fu6hR8Un6yWrwux0UfuwCyRmLqRjg/sJVbRAUpOMBLvQ2Vt3A6lkN+OwxfmU34qmlAQUbeR6asYLtYYUPkfKDC0sIo0p+ZKJQ972o/yRgIi5CCrXU7h0e+KNvtLcwDMZOm3w48F/1CLZ5QCDStR48HnlCW4Hw/8n7w63mFH2YI3A9aPt9iknQzyr1Vg0eir6PmV6PKnw7uN2eugBh5IeBLbOHwzVEG2huEWJaW5b7mQ/ot3UbXhKFY9Bpa7sWrakk6fSt4iHu+pv/EXPEy7MCN+JcqD3yrkpZhS8Dbtv42o29exavXqaW8VhC8MFtbjfJxYV9LHHsppRZ7d74cCVS3dYv4f43IwxqP6fgo8c9lwmY5mfUwUHi3tFSMTL8f4nzSdlrJmPM3Yqam8eVQIoXapgRwgz5pw0JdtvL8LVU7iQI+mMRsK4G68GQd64TA0Ch44YgvP9dkQUcUxOoKxgbPNQABb38ftZSFpBUpcNFqi1GHj/qJCkaNtjra7EmyXMq+pIw0EaCvPaaxruf7F3IxezZZfHJ6hSDEk1d4XBT7aMxOJgA+DGTrIuF61aJkRhEGjOlmpAMLNXjBiND4q8h8CNQMgOQkBvKJGedyzK5sk1D5pgBp3/G1Qi6E4+8m+x/OaBKYZYlWbYBjH/5xs6ZJpvan/UaTn8N/6FjBOzYeSwig=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAVPR02MB9523.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(366004)(376002)(396003)(39860400002)(451199018)(31686004)(83380400001)(66946007)(6916009)(66556008)(66574015)(66476007)(8676002)(2616005)(38100700002)(41300700001)(53546011)(6512007)(186003)(26005)(6506007)(107886003)(8936002)(316002)(31696002)(4326008)(6486002)(36756003)(478600001)(5660300002)(54906003)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkVQejdJU3M3ZG5ra28wWTNTU0dtSE10OEwxOU91UXhEb1UweWNtKzRmYXZh?=
 =?utf-8?B?bkhzLzdBNkdTN2Q1blhraUZqZGk1dmc0cG9aRlBNSXZ1Mlc5cjd5RVU3ZGd4?=
 =?utf-8?B?ZzN2OUs4bHh1S2tYaVFaOXB0L253anlWNkd0WkdlcVdLZXRkR0RsUll6WjVP?=
 =?utf-8?B?SDBkL3lkaGVwVUdkSC9ndmZWRGkrQ3UvSzFGdE11aVM0NjRRd3hvZnNZTVh1?=
 =?utf-8?B?TFRYUUlyT1lmMU9IWjFUUmFEa3pyenZrQVEvY0grdDQzcmlTN0d0TFA0d0tB?=
 =?utf-8?B?bUZ5MWVUeTE4Zm4vWTdsYm5LSUs4MDRyRU0rRWxUcE0vempicmFUSjN6ZG80?=
 =?utf-8?B?NHhyTGh2dWNjcnhMN25jcWR6Z3dtUnlIRjl1Zks3RjBmc1hOeHhDWFRzUTlo?=
 =?utf-8?B?YlRXVVM4WHJlWDZkOWI3UFBwVDRXTEFxdXFzKzlvR0NEa2xjdmZLWVQxTTFo?=
 =?utf-8?B?YklxK0swdWNZSERDWU5MNmdaZ1BpdzBjankrNkdSb3dwU1VMeWpVK1ozS2R6?=
 =?utf-8?B?RTBNazQwS2Q1Q1BiLzJTK0N0ak5NL3A0Q21FR2NDeTdQb3NzNkN1bDJDdncv?=
 =?utf-8?B?T1ZCdEptdTI0MGhZL2VVL0dmVGFZZlM5WE9OUjZZZ2tGd0JGUnZGZ1pibHZ0?=
 =?utf-8?B?Y1RvY0ZxcWtvdlUrTC90aWhIUVJGZkFqNmw2TVJpMi95S3htaU1SbTdXd1V0?=
 =?utf-8?B?RnFPcDEyR3pEMEVXNzUvUmlGbFhvUGg5NVFVWjAvRXBEVk9hbGZVOWtDZVVF?=
 =?utf-8?B?VStLeUpOWU5GNEQ2U051WitSSVNGSFJnRXN3MEFnSzRrZHoydVA0alRrNEp0?=
 =?utf-8?B?UEtNNW1UNHlBd3Q5QlhpZGUzV2tZQmlSUlc5NVl0SERXczUyUkpXVFRrS2lI?=
 =?utf-8?B?M2FXdzd6Zi9UQzNTbDZuSWFybWlIUGhldk80MURBVC9OT2hsWlh1cEVYVVJG?=
 =?utf-8?B?eEpib2tUVEwya2dPQTJFOUI0M0JKaXFLbVhNN0xvS0dxS293WVBKdUNxK1BX?=
 =?utf-8?B?cExCcHRiRERnbVFEWVlXM0s4R1FRVVhwRnpicU83MmN1clc4eEZWL1padGs3?=
 =?utf-8?B?TlY4bzlERUxMWnZKRlVnaDhqbEJGRm13Y0twcitLRks5aFJnUWNWakdnNnVP?=
 =?utf-8?B?cSszejFSS29TMDFCQm5zdlE1MXFxQ2p1YXpwZTRkTmt4b1FLSmFvVW5xNHk4?=
 =?utf-8?B?L3BiNlVsbDAxV09PbWxSWmtnSGN1bnY1ZEFiUHdxLzlsdERiRFFGOHJPN3JF?=
 =?utf-8?B?OWdBS3E3OVZmTEtFR2FHSExsMnZWTmErbFlSa3F3c0pPTnZ3eklTd1BmUU9G?=
 =?utf-8?B?VFh4bldRZ3ovRFlCQnNNb3BuOGdGdUYwRDVDdE1CQlkwcVV0bUYyVWVTSzJv?=
 =?utf-8?B?RVNOVDB3VmhYZFRLYnovQ3RsQW1nSEVlMTIyTmgyVXdlLzBQenRleTRXdUhp?=
 =?utf-8?B?dnB3d2ZQVFM0bVl6THNSV1F1Z205WFRNNklIL2Vja0dERTVsaFRUK0tRWVcx?=
 =?utf-8?B?SjhpaWxyQkI5WjJydnpNeHppdzJrL3Y5eDgvaThhV1V1a1NJNmRQSDRZODhy?=
 =?utf-8?B?OVo0MERmb0haUjhtQkxtZU9tZ2hxa1RPUnM0eTJydDJVVURlazkrdXh3M3Vt?=
 =?utf-8?B?MTNwZHBxYXo2QkdCWWlIb3FLamtnT2Y2UzRFNWUyNFlUSkJDRktPcmVhalZB?=
 =?utf-8?B?ekFWdVI1WkFyQkdHYUNGOFRGOXZXbHNKUTVGSGNWeW4vSkZaTG1tTCtqd2Nt?=
 =?utf-8?B?WFpuUkhjTUpXb1k1THNDYi9xRzRVb3RUVFJUdDJtNFhHaXVuSVZObXVoc29z?=
 =?utf-8?B?NGF0VGFxNGZ3bVk2L3paWFNDa1B1Sm90STA3QmVlZ0Flb3d1YkVJZnBhV016?=
 =?utf-8?B?YmdyZnVSSmZibGRESXJwUE9Yb0FLaW1tOFgzTTNUV3IycGFyUXhEd0hFYlJE?=
 =?utf-8?B?Wjl2YWkyR2pLUEpmTlpRQzN5S05IelhrUk44VDFqZmZCVFpMekgxQy9IVFlh?=
 =?utf-8?B?eWJhTHR4cVBMQ1g1ejZNSU93SkV5VTZZTE1mNmx6bkh3anFGdXRpM05ZaHNh?=
 =?utf-8?B?ckl1T3N2dTZleVlLME9WcHpxeDJIT3pyVjZNS0tLVkJIdWorZVBiM1hJNTUr?=
 =?utf-8?Q?ERx9C2lL6WULGU+ZnR6ccNAwf?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e4fce921-3649-4b2d-3d08-08db038fc3aa
X-MS-Exchange-CrossTenant-AuthSource: PAVPR02MB9523.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 13:33:40.1914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DjaboUPoQ0gbKyjhD6VBR36czujDIDLloV8xKSZLzDJTEqarPAD2vOGoDPFLQs9VPkQiBB9V0j4fCGFQtXsgTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR02MB7261
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


On 1/31/23 13:46, Cai Huoqing wrote:
> On 31 1月 23 11:29:51, Mårten Lindahl wrote:
>> There are different init functions for the sensors in this driver in
>> which only one initialize the generic vcnl4000_lock. With commit
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
>>    do_one_initcall
>>    do_init_module
>>    load_module
>>    __do_sys_finit_module
>>
>> Fix this by initializing the lock in the probe function instead of doing
>> it in the chip specific init functions.
>>
>> Fixes: e21b5b1f2669 ("iio: light: vcnl4000: Preserve conf bits when toggle power")
>> Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
>> ---
>>
>> v2:
>>   - Trimmed backtrace in commit message
>>   - Have 12 digit sha-1 id in Fixes tag
>>   - Make the lock initialization in probe instead of in _init function
>>
>>   drivers/iio/light/vcnl4000.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
>> index b5d398228289..caa2fff9f486 100644
>> --- a/drivers/iio/light/vcnl4000.c
>> +++ b/drivers/iio/light/vcnl4000.c
>> @@ -208,7 +208,6 @@ static int vcnl4000_init(struct vcnl4000_data *data)
>>   
>>   	data->rev = ret & 0xf;
>>   	data->al_scale = 250000;
>> -	mutex_init(&data->vcnl4000_lock);
>>   
>>   	return data->chip_spec->set_power_state(data, true);
>>   };
>> @@ -1366,6 +1365,7 @@ static int vcnl4000_probe(struct i2c_client *client,
>>   	data->client = client;
>>   	data->id = id->driver_data;
>>   	data->chip_spec = &vcnl4000_chip_spec_cfg[data->id];
>> +	mutex_init(&data->vcnl4000_lock);
>>   
>>   	ret = data->chip_spec->init(data);
>>   	if (ret < 0)
> Why not add mutex_init(&data->vcnl4000_lock) in vcnl4200_init.
> like this
>
> @@ -330,6 +330,7 @@ static int vcnl4200_init(struct vcnl4000_data *data)
>          }
>          mutex_init(&data->vcnl4200_al.lock);
>          mutex_init(&data->vcnl4200_ps.lock);
> +       mutex_init(&data->vcnl4000_lock);
>
>          ret = data->chip_spec->set_power_state(data, true);
>          if (ret < 0)
>
> Perfer adding mutex_init to vcnl4200_init.

Hi Cai!

This is what I did in v1, but I got a suggestion to move it to the probe 
instead.

Having it in probe takes one mutex_init. Otherwise it needs to be in two 
places (both init functions).

Kind regards

Mårten

>> -- 
>> 2.30.2
>>
