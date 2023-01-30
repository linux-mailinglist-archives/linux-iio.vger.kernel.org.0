Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40E0F68112E
	for <lists+linux-iio@lfdr.de>; Mon, 30 Jan 2023 15:11:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237190AbjA3OLB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Jan 2023 09:11:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237181AbjA3OK4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Jan 2023 09:10:56 -0500
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39E93BDA5
        for <linux-iio@vger.kernel.org>; Mon, 30 Jan 2023 06:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1675087846;
  x=1706623846;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hJ3EhnNTteH5xRwGNRvCGqTmG2qrVE77v5U3kdSH8Ws=;
  b=DaUUXwcZL0Ta/1AyE8B3asLR1A/PRblWVKZxmnT+gSViAFYA/X08PgKm
   1y8Ro1ykIiVOT/r7YEEeVucgkbEU8+OeYMCSa3x0l8IDoovhMoSJ6cKl+
   Xv2QalzdT16669lA+4R9lpoy1v/rKh8FnlT6VkHMWewcyyK9+XtaK/sSv
   Tl8IbBKyaKaHR7X6X6oAC4gQ5SfNUreAHpPVhn+HzQ1OYWD41OZjQfVy4
   aL/vIaOAB520Nolnv/DQsmWCVTbylbQ306Jo/jjB7o0tpRdEkAD+mdwSU
   e0WBMGM9JXkbLGvR6Hd0FHECGbMH9zW6GxO6P97c+vl96ndinyt/7+2mu
   g==;
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PRRBD67rtdGTyLJqVrOgAVBmxYmkwg3DJs94GXgBlHQFxrPHlqyZ6apYaiJgN94OUDU9n3Vv7r96SvK3Md21ldZ04q9TgckiyPK0+iwm2x2YwuR5J6tHpa4QmzGipvB89BvbID9NdrM7cD6Pd6HPxyyBbsX88MJ4O0zTA8WsU+tOAvWM8/sW9RJjc+JoxUCqOXt30QP6++lytnsx9hjKOrdkZRFOSW4Kt8QOAxiFHLzkNEAJAJG0JhXL1vKRQVY2W2vRe3h23GujJXhwqkHIElPj++8wQ+fuTNxFmE7XGl/owaiM6E4mupGF29x+TdWbOZC5F9c/iDTKXXE8+ihXbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hJ3EhnNTteH5xRwGNRvCGqTmG2qrVE77v5U3kdSH8Ws=;
 b=j12Yw7VSqrVVe5YrbEOshseKQ7s8h189K8K5esLNaZaASc2aG1VV7D7c0Ja4wdPpgvLxY36R2ZOWN3trqLofHGix2Nzx8FcysoR6bDZ7TIb/YcSTjBH6iIG4gZlo8xh9OyGo5ps172O5bMJAVezJ1xR3Cc5Ib3cw2xrh3dTFNt/EyLlpvXao3pFbfYYGip6aGYOFCOlqgxOZvdLUolB6fty5nB8g+d3qLTCeu6QX5aAMVQG+/xKQK+Dqbb5TqDRk0Aa9luLURPyt5cTGbtg/Gd6Ic3OW7KlJoBtd1je5f1cooqLHx5NsP/YF2R3tMrM3hLVLjyrC9t+noKkZU31Emg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axis365.onmicrosoft.com; s=selector2-axis365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hJ3EhnNTteH5xRwGNRvCGqTmG2qrVE77v5U3kdSH8Ws=;
 b=UZvbjvx9VKmC5mX94MNII2GGRxgu80l5s9kVcfAJor7yGv4GzbS+PUutLWeqM6BuhgSEpOobdE9c+Qz7CyXrQKbhasworShlKpmxRflRuh8Vi06RD0jevcD1dMiveV10BeOgniKCKvJ53TKy4iJuWg60UtQlFsojOW+zBUYE17E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Message-ID: <6a1d8766-2777-83d6-6d1f-ecb81da4b11a@axis.com>
Date:   Mon, 30 Jan 2023 15:10:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] iio: light: vcnl4000: Fix WARN_ON on uninitialized lock
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        =?UTF-8?Q?M=c3=a5rten_Lindahl?= <marten.lindahl@axis.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <linux-iio@vger.kernel.org>, <kernel@axis.com>
References: <20230130093742.838577-1-marten.lindahl@axis.com>
 <20230130130418.000013ce@Huawei.com>
From:   =?UTF-8?Q?M=c3=a5rten_Lindahl?= <martenli@axis.com>
In-Reply-To: <20230130130418.000013ce@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MM0P280CA0014.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::23) To AS8PR02MB9529.eurprd02.prod.outlook.com
 (2603:10a6:20b:5a5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB9529:EE_|AS1PR02MB8026:EE_
X-MS-Office365-Filtering-Correlation-Id: 745c13aa-ef37-4342-2d4e-08db02cbc5d0
X-LD-Processed: 78703d3c-b907-432f-b066-88f7af9ca3af,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XKn0ghhSNDfRe+QJRZztOV1MNSEBpgCMNetNq5G2nEWGlH4kT4srBaZom0i5avI/QEBZR/R1cMT3YyT+xeGq/eKLFZaONdymPARRhdeHVGCEmVcD3Uyvg/68uWccXwrrp1QuIEIto6Xfuf+iNn9S1LZjHPLXy4I+zGigKKhB/bPjhrDXei1tDZ2JoQNEkWjt+GpLwcZtBpyr75OBiprT0QjSraYS5YRxBlik3wGJc/dL5+fC6tgUoxn4uurBQ3e6PZkeFcBTiz1Yea65wcrtSbQVs3GyJSWnwk/ztgpCxWWZKOvgZHoRG41fGUCTGTeqmfEeBdtaVU3l8HCcKrFRQXfyChgzX1DrQcz2iLUJ/uBBM1HkEAZzJIw/DaYaqYTQ1CCvgWCcGijpTY0mh+geJA+bigEOsCMAwlm+/1OLxtiLDwI3G4OxePeH9QSF5ggFN23WP4dVBQCF4Vx3Ad6P64W2E8fOHrpBUq8E00tLh0aLVc88dTAoHwBAFFVs0loYMkNGqzB6OLZjpoVZktJhIgVJgs5fYKIFYd2bV48ijdpE1Mm4tkgUzdy9vEYRMekhuP8jPdIfajAjhobyST12+cM3KbSoxMp9bpmF5aqBclmQCIyvLmE2rNLLIlXZNXzPdc4xoAif8ka20aRAnRJkb1nQOpEfDlazjNia26m4zM/SZEwDj7EA41et7dXq5WLCuUWXhtAp08IueEbtJzZApPGR1X4PybAPF4FBG0cMmws=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR02MB9529.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(39860400002)(366004)(376002)(136003)(451199018)(6512007)(186003)(26005)(53546011)(107886003)(6506007)(83380400001)(31696002)(38100700002)(36756003)(2616005)(66574015)(31686004)(8936002)(41300700001)(2906002)(5660300002)(6486002)(478600001)(54906003)(6636002)(316002)(4326008)(66476007)(110136005)(66946007)(66556008)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UktjT0Z4blRlL0xlbE5DZ3l0SXJoNFFoSW81UTgxK0tZN0xqeElWeFAzK1Fl?=
 =?utf-8?B?azlxeCtwWkNNQ25icUtmcTZqMUk4cWNYekRVWmVFckNsUzNMWFl2VjFIMzdU?=
 =?utf-8?B?d1NlL1BDNUtaNVoyc2QrdkxyTVZiQk5KTlloRHUwTnhINU92RXVYK3BZUGx5?=
 =?utf-8?B?VWhud2QwaWFuZExpMGoxTlpmSlRGeVFYZUNPUWVMTlYzSHhyazZ1YWJ6QWtT?=
 =?utf-8?B?cDd3QnpTMmxtb3k5UjNqNnBNTWhoMDdFeG5XQzZBYTVPR3p4OEJGS05pTllp?=
 =?utf-8?B?NWVQa1NOVTFtZ1NqRFFKTkFLL0dPN2paTXIvYWZERUM4TXdxQW1QUkZVQ2Vn?=
 =?utf-8?B?REhZMU1IWmZHYUV4VEtnd2hET3orVDZjVHRIbjdwSEg1WW13Tk43dUVBWjlm?=
 =?utf-8?B?K0UvQ05ORU5KN2QxU0FWQUxUQSt6bUFxY3EzT0RNOS9qall0YVZHOFpwT2My?=
 =?utf-8?B?dCswR1BkRWQ1Q3REdmtTTFdyTDdhdGxpUnhMMjN3Q0l0TmExRGVaYzBtN1pW?=
 =?utf-8?B?ZmI2V0M5aVRseDA2cEFvNU5tUkZlYndHbnJ5WVJlV0x3QWhsaWFOcWRKVHpZ?=
 =?utf-8?B?RmV0TUtlMDdRYnYwOS92VHQ5elFORjZ1ZUhkck5VdWVPaW43ekxzcVA0Qmlx?=
 =?utf-8?B?NWZnOWtsd1hJY0p3c2JqOEFFNGNGN2lmUGNPYXAxL0tJVDRMMk04a2FDUEgw?=
 =?utf-8?B?NGpZbEZtYzkwSHpsRVlpa09VeHNBT2NLUk45NEpnQzdNSjduV2dGSFpIRWVU?=
 =?utf-8?B?Y0lKMmZtWnQxdGRyMGNUTkZZRDNXVm16dU0xMjYvRDd1OWFqWmpxd1NOS2tt?=
 =?utf-8?B?UnVhR2NVQy9QRkNiQWZZUmRibm5ZWFNmNDd6WkZna2pZckM2RVB1clAvYlJP?=
 =?utf-8?B?NEZ3MU5KazZjUExvV2ZHTEI2M2IrTmNSc2JxYkwxN21TdmhJL2xMRCtoTFZh?=
 =?utf-8?B?UzkzY0l0WUZKTXdmKzBWTG5SQ0h4T081TzVnbVlTK2dvN1dhVEluc3diQWVv?=
 =?utf-8?B?SENnOCtmSUVrQVpGMCtray9ZcmIyaGFkUlBIcG0zYVZ5bDFJK1VoK21Bcy9Z?=
 =?utf-8?B?ZHhpM0t3bUE3Ym5xT3pxZTR3YTNUTDNIeVowYkV6Z0FWdlFGOEs0MFg5bTZE?=
 =?utf-8?B?Y3BiTHlFWnQxWENLZzM4djBlTlVlZlJYajB6Zm0xUSs5anFOeWp0eDliWXZZ?=
 =?utf-8?B?Z3JvbVBTQ0JjYURQMFdrbTNmYmxkNW9QekFONmV6NCtibjBHaHRjVmV6RVRJ?=
 =?utf-8?B?SEZVMGFRalVTV0tlNnBEbEFrWHJxMHBtVTAyQmJoL3B2VEhGRXBOemtHalBB?=
 =?utf-8?B?dFNtYXNTbStDb1FpVGpQVFlkZ0lVWWliaWJ6OHduN0Rtdk5HbmpBK1JNNFVn?=
 =?utf-8?B?NlJ0OHpQcnRDUkhnM3QzZEtSK0oyMkx5V1dwNGJQRTRtdUlBZnhjUXB3cjVt?=
 =?utf-8?B?NWcwdG9TWHpOcXBpbFk3YWlKR2dYVnB3RVgyZ0U3Z0ViLzVyV2FrY1NmQ3BQ?=
 =?utf-8?B?NGxkWGhJcVVraUpJU2JSSGhweStoeWQ2WHozSXlKKzI1eTM2WmJ4Y1RVeEIw?=
 =?utf-8?B?WGJXVzZ5WnN6NlNlUTNZQWxqS2JoUTRIdklsNkJkU0dpSXVWQm9oYzhkY0l1?=
 =?utf-8?B?N2xiK2JBbFhIQm1FLzRNWSsxbTNaenVGajEzd1RXY1laVVJjTEtlSkkrT1RJ?=
 =?utf-8?B?Q3p3clpsK0tqRU93dHlNOVpTWmVPcHNwRXlDYzY0Z2g5NWRaNXJZSDZHaFNN?=
 =?utf-8?B?RXREa2V3bUtrSlVPUm1ZQ2RPNU1ZamVvRXZzN25VdVRLbU94NWh2RW1zNnlK?=
 =?utf-8?B?MzgyeCs5S3NGUVFwOVNvbnBJVG5YNGpYdTkwN0FyVmtZWExOQzA1dVB5MURI?=
 =?utf-8?B?bUxHMldEN29JTks2azZNKzQxVG4vRDAzYmoveEY2U2NXS3o1YW1zNVRRWXZ4?=
 =?utf-8?B?U2FSUG9OTVJ2cGloa2JIQUMrRWpVUWlxQXllN1NSY01zZjU2M1dGbXRpeUlO?=
 =?utf-8?B?QVgvbWdBSG01SG5kSytIZmVMRXdnV1FVOWZTTHdwZUo2RDF4MHF5VXFpdjlH?=
 =?utf-8?B?YkhDQ0tTS25BZEdpd2drVU5pS09sYTJnc3pxQTFkaUh6WUJra0ZNWVlPaDVF?=
 =?utf-8?Q?TzvEJPjV3QF8pVCckdpgJR8e1?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 745c13aa-ef37-4342-2d4e-08db02cbc5d0
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB9529.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 14:10:42.4521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WvZxDss0TnOlyDXjyjibkYKW5NBK9VaZpT86F6GsV8xj5cwvNr0VfMzjgRdZbgqyNXlGSqpDRbZP6Ve9s2qWdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR02MB8026
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


On 1/30/23 14:04, Jonathan Cameron wrote:
> On Mon, 30 Jan 2023 10:37:42 +0100
> Mårten Lindahl <marten.lindahl@axis.com> wrote:
>
>> There are different init functions for the sensors in this driver in
>> which only one initialize the generic vcnl4000_lock. With commit
>> e21b5b1f2 ("iio: light: vcnl4000: Preserve conf bits when toggle power")
>> the vcnl4040 sensor started to depend on the lock, but it was missed to
>> initialize it in vcnl4040's init function. This has not been visible
>> until we run lockdep on it:
>>
>>    DEBUG_LOCKS_WARN_ON(lock->magic != lock)
>>    WARNING: CPU: 1 PID: 8800 at kernel/locking/mutex.c:575 __mutex_lock+0x4f8/0x890
>>    ...
>>    Call trace:
>>     __mutex_lock
>>     mutex_lock_nested
>>     vcnl4200_set_power_state
>>     vcnl4200_init
>>     vcnl4000_probe
>>     i2c_device_probe
>>     really_probe
>>     __driver_probe_device
>>     driver_probe_device
>>     __driver_attach
>>     bus_for_each_dev
>>     driver_attach
>>     bus_add_driver
>>     driver_register
>>     i2c_register_driver
>>     vcnl4000_driver_init
>>     do_one_initcall
>>     do_init_module
>>     load_module
>>     __do_sys_finit_module
>>     ...
>>
>> Fix this by adding mutex_init on the lock in the init function used for
>> vcnl4040.
>>
>> Fixes: e21b5b1f2 ("iio: light: vcnl4000: Preserve conf bits when toggle power")
>> Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
> Perhaps better to pull the lock out of the device specific setup?

Hi Jonathan!

Ok, having a

static DEFINE_MUTEX(vcnl4000_lock);

will make sure initializing it wont be forgotten for specific setups.

I'll test it.

Kind regards

Mårten

>
>> ---
>>   drivers/iio/light/vcnl4000.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
>> index cc1a2062e76d..a8a9fc3b1a02 100644
>> --- a/drivers/iio/light/vcnl4000.c
>> +++ b/drivers/iio/light/vcnl4000.c
>> @@ -316,6 +316,7 @@ static int vcnl4200_init(struct vcnl4000_data *data)
>>   	}
>>   	mutex_init(&data->vcnl4200_al.lock);
>>   	mutex_init(&data->vcnl4200_ps.lock);
>> +	mutex_init(&data->vcnl4000_lock);
>>   
>>   	ret = data->chip_spec->set_power_state(data, true);
>>   	if (ret < 0)
