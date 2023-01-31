Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97215682E33
	for <lists+linux-iio@lfdr.de>; Tue, 31 Jan 2023 14:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbjAaNm0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 31 Jan 2023 08:42:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232287AbjAaNmX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 31 Jan 2023 08:42:23 -0500
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7659B4FCD6
        for <linux-iio@vger.kernel.org>; Tue, 31 Jan 2023 05:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1675172542;
  x=1706708542;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ATrpQvDIP9wynV3qVXugSDYU5bCORFnZwEelC7Rl0bo=;
  b=IWbgkSzS4AXD8H5Byn1cNbVIwXgoKtL1AK/6dXlgTJAxZ52JyBw9KJpF
   GQVrdOxX2VEeF2LzI4xYTEtC89gyDddXNE/z3mRCFE9IlSh7x8rrVjCYd
   pwlD0+tOo6HQ4+n6auifU3yev4+91dzaCJ4QJrpfZN7qO/Fsataikk0x/
   jluwlfCJ7P3y49fW1NfOwZdoqZYM9gynIiB1v+ewf2Qy8i+Rteos3GWj2
   BUllVJfAvhztWogFWwFQlmnv3tSjvxntSI7c78mHo/xZMwM8ZeYbwswa/
   8cIt9i/2MeyrzpqNAgZZGyJfC0GYmoXXL+B+xxD+/lzxIHvuFpraRNo9F
   A==;
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fb0GGp8eItmCbOKgzJP6n9g1cRjVRXM8uMYbaW8/SIRup6BqXn70dR1DaROett5ib1vMpiWsTl+GPaQGW44eRynFYHVnRtCPicAUSjMNitaE8BSMzfd/ghYwB+x8FXH21ewzyPajIIIb0LEcHKodoA8nLB4AK7rRgonkLO/R8bt2/zFJf1aOVeYCjkpHfG0dwEKKI4qdwZmFs8ij0lZSoKL+3eH4jxl+Y9Cx7u+VDdYOIs0VXWgZBTNOrPdBC5zx52LMI6B6JIcPO8UDzOiNPsIJVoFRRvYxJBqVpdneLMTDLWbRGd6npNN1KgGr8en4uItkS/I7liDHcbJTcvfE6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ATrpQvDIP9wynV3qVXugSDYU5bCORFnZwEelC7Rl0bo=;
 b=mdyaHWq2gZPkMUem4Aky/6rvimK8RKSaXpv2KwlafPPxhVAWTCKlN/2NeIMdX5XaYy/W2ymMBw7gzCrCrEs8puE6pyR6rnT1RyNopO71J23i0JFBC3u+q3LukbqgMFYdnepZLcjMMl4N11Q3yBLopZWBdYqxnsAzGmafSgR/NpG2YlF6bTnnqGhrzVa8i4EsmRMVnk3+tPoXux1whqDoxWLIVodBOCkgkI1yO9cLT5iLFqmNmZukIGI+SNQrs7IW6SmW+EbWO+7nOdodPfd8I8V/gWnGV1UBvhz9IqDe8hZb6TOaKqm5i5i6Ip8ZnHKC5oATOmWY+RekyJnW8qdLNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axis365.onmicrosoft.com; s=selector2-axis365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ATrpQvDIP9wynV3qVXugSDYU5bCORFnZwEelC7Rl0bo=;
 b=mQIxGreFXMk1CW+7XB4KRWKpjwKdCmZqVQkJ3YX6lWAZbO1+n4Pw1bCmeiYuwnbp4LR1AZbWjOLc58HaEelvgwbOA/zWq+HdBzGid2shVNZyxRNLUPLc+WUdZEE1IgYTLIj0HLT3Rc05Enbk2usxDVVt2+sDJUgxJG+TapN6SOI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Message-ID: <fa7ec659-2bbf-7614-7231-75eaaf52b1f2@axis.com>
Date:   Tue, 31 Jan 2023 14:42:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2] iio: light: vcnl4000: Fix WARN_ON on uninitialized
 lock
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        <linux-iio@vger.kernel.org>, <kernel@axis.com>
References: <20230131102951.2012021-1-marten.lindahl@axis.com>
 <Y9kKsv7OJ1KoImjJ@smile.fi.intel.com>
 <67f7888c-5d5b-4c63-42d3-cf2b15602478@axis.com>
 <Y9kZt0Me9xPp3MaZ@smile.fi.intel.com>
From:   =?UTF-8?Q?M=c3=a5rten_Lindahl?= <martenli@axis.com>
In-Reply-To: <Y9kZt0Me9xPp3MaZ@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MM0P280CA0001.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::10) To PAVPR02MB9523.eurprd02.prod.outlook.com
 (2603:10a6:102:303::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAVPR02MB9523:EE_|DBAPR02MB6136:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c2b215a-686a-436a-0d24-08db0390f841
X-LD-Processed: 78703d3c-b907-432f-b066-88f7af9ca3af,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TxITyW/DMpgATyOGAF8sT9SskS+TLsNLZz2ssYV1g5wIslpAqs770t/hscddR4LPGbrtOXNFe3Ll6sMU5XUwYykBM84Chl1gU9dRJ5wYBUIxN6HCZcALigCNAM32g0rRmzorFu0fLEXBShqmQvoUB3dL2P49IN8cn+Cq2SZ5WojPG21d7vXm5LLZ2cKShpLX6PbhJxk4j+YjTylng9JfTO2aOt82FvjFFrA3Ew/WfwFdbpIU9V9wh5gyD4JlTbhsBNJEm9xGM+CL/01hl1JH+zBUoDY0LT5irD1yiyPIG76GsrVEuyOeVcAj0knjZUNEMHIXdUXY4KMcLzar6x1gdr42fsId516Tt13ItBP5AJyIV8jEgSpY4qWu4Z+EEf0KofP6clIe9UvCB2F5efCZYkFi8aOOP5FtGBKkcrG9V1kLx5N5ShdbvlFg7pTdxUXNkhwTrp3YfqK77uhImxuI2KoWxieENX/BXG7+Zn8g51hSAu4S5SRpeSEERrDW+z4k/ebCiAv7b+JxjEFLkBzaX9Fs3pyaI5YSBXkvG2E8h9wKL4qKaAUi00QHt9+dQsNTZ7L7t2ihEkDATt/bxolSxEHeVqripZGYCVCteiQnKn1ebvFsbCNVoEvzmSZ3Vw5AdVcEY0EoUx7EnkQLODuyNZKNohiZeou+ESoHZCiTDwZUp5fKflgMloDmjo/XMtrXXXX5tdXFGJjPiy1dGpyaVRHG+2lKc5s9P/zJD+yq8ks=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAVPR02MB9523.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(366004)(39850400004)(376002)(346002)(451199018)(6512007)(8936002)(478600001)(66556008)(53546011)(66946007)(8676002)(66476007)(6916009)(4326008)(6506007)(31696002)(54906003)(6486002)(316002)(36756003)(41300700001)(107886003)(26005)(38100700002)(186003)(83380400001)(66899018)(66574015)(31686004)(2906002)(2616005)(4744005)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q05SQUhleDYrR3ZkYVpuV3Aza0pSc2RtQTNkaVNKS2ZEaW9tcFVLOFFpVFJM?=
 =?utf-8?B?RFM3ZUxwYXovUXEreUJUNmFIc1pmeW9oanBqSGNWMXFWeGRjbUJFSmlvV1JZ?=
 =?utf-8?B?cE1wOW94VmVoY2Vtc1FZa0RsSHFXUklHYkNUU2MxekpwUGpJRGtGZjFBWm56?=
 =?utf-8?B?K0dUdUFlQjVHdmQ4c2RkNEdDRDlHV0dqMWxIb205bjg0SVBEd1NBZnEvNVZn?=
 =?utf-8?B?ZlBNM2tpUzNsZ2V2Y0x5cDh1ejhkdHBjbnF6Y0hTR1haUnpYYWxUeGQ4WDRB?=
 =?utf-8?B?WDlUMGlReUJoaWdXc3JhTUpmelJMRWROQVRDNURvek9rQmM0OXJGSW1Feks2?=
 =?utf-8?B?RFgyaDhheTdJZHRXSXIwdjMyMmVrYkpKY2JsUjVIUHU2NmFxNlBSajIyWWRM?=
 =?utf-8?B?SXR4NEJpMzgra3F5VEwydHZudWhOSXpCSUxPbkJuMVMvNDVFRkp4eTRETE9m?=
 =?utf-8?B?UGFMMWFBdFAxc1M5U2J0UVVpdHVUTlRnTkhZZDdpdkVrZ0lybWdJUG1hTGVD?=
 =?utf-8?B?VUpRcDdhVzNJczFzSUVQWnp2d29jL0lvQjFIUVV3eTFzc0xTR3N3VEFVc1A2?=
 =?utf-8?B?dWtqLy9aRTFteG5rTkE2R0txQStOVkx3ZU0ycFlERk5jaytBNmJiVHhRZUlh?=
 =?utf-8?B?MGt2NXNIaHNwQ3c1VGc4VWtHKzcxTWM4VDI0NVpsanlac2V4Ui94R3I2cW1a?=
 =?utf-8?B?SWl5cXRNNFY3NGM1QUxtNzhDai9RSGtDMUhYMHlWd2lmRnVjRDVPcWdHSllk?=
 =?utf-8?B?S0tRRDJBRHptWm9paS82dTZRNG50OEZxYkg3UWlIZGZnZnE3aS9oWk9wVUtv?=
 =?utf-8?B?b3Qxdmc0dTZWeUttTFFHRGR0QjVqTW15T0lRbHdyQjdNdkoraGdMYlJJNEpS?=
 =?utf-8?B?V0dhSWNyNFIyZGdzdjg0VXVqVFJUNEhFdXo2cDkxc2ZsV1djV2FCLy9JUkl4?=
 =?utf-8?B?UnJ4UG1Bb2xJTFRqUWtIVlM4SlV4aVFOVDlqL3JkMHAxemVIazl6ZFdDZHdI?=
 =?utf-8?B?MjRsMkkxZTJDK0xpbnZDc0tic05BcXFBR1pQK295ZnNZTE4zbDBHakJJMzdJ?=
 =?utf-8?B?ZUpjWFQzbFhmR3N5d1diN01RREthcUlQQ2VQR1YzTS9YL0tEajlaYVZLLzVS?=
 =?utf-8?B?NzE1ZGxpb2VadHEzUnh0aFpaSEpRSzBJRmMwb2g1d2RIUWRMd1oxQmo4Zndz?=
 =?utf-8?B?WjFlcTdsbkpMY1B2b2NNdmtoaVdrbklxaEZuL05VYXFzaUx4K0lDdWRhR3lo?=
 =?utf-8?B?Z3BNRlpnU1B1VlZ4ZFo5VDBEVTQzbkhKS0ZMdWVPSGNLWlJLR0tQc3B5R2JN?=
 =?utf-8?B?V2Vob0piSEhzTGxUMDVWRWRLc3p0RXl1cXl5UVRLZFgvSkp5V1dMdUVhb2VM?=
 =?utf-8?B?QXpyMzlBT2lEOVd5MTYzcmh6WGV5MU13WVR4WTdMd2U3YXJ1clpkdGpGMlF0?=
 =?utf-8?B?UUpvUU12NStSWGlscytDTW50ZGlBS0xMdnBjb2UyMFV6YlF0WVFjNS8vL24v?=
 =?utf-8?B?UHllMWZURDYzOUdPQ3RCZi9vOEd3RHl3b1ZCcGVjQ0FmWkNNUExLdDlCVlFn?=
 =?utf-8?B?OTFDYUhJYjlmS2pYWndCQlR2MnN0R2xkRlRub1oxVHF2VFpDVmF2SjY4RnRM?=
 =?utf-8?B?UUtDY3JQc1hRcFBlWjR0QWRVRnBkZTJ0V1ZJQ09INU1Dekw0bHhkNzQyQWlr?=
 =?utf-8?B?UmNwaCtxV3I4MUl2Ui9hanFId2RCTnh1TjV1dUd4RUxHWXhjT3RiRzB5Rkhi?=
 =?utf-8?B?Z2RjNWd2bDdmbkszZVdXbHFObXFFTGpmNGgrWGg2QkgyWlJ1dXA3dUZtNzMz?=
 =?utf-8?B?OUczckJvOEJGWWZ6VFdyWVlOcDBQT094ZVJpWjNPNi9qQTJYUFhYQkVZa2NN?=
 =?utf-8?B?SDc3bjVOYnhFL2ZDWlgwNXBYZW4ybnRBSnlRcXFyREdjcitqUHMwNVZ6aVpm?=
 =?utf-8?B?MmpLZ3VTWldqelpqUjJobWlpbWVvU1dLN2F4MkhzblhuRS9UQjljT3B6NVlG?=
 =?utf-8?B?Wndibkg4ZElucG1zdFlqQVNEdmg0UmxLRkdnQVg1dXdsY3lMRUZOSXNOakFI?=
 =?utf-8?B?N1V6VXZ4bWhXWjFZQ1RFS0E2VXBqRklPR3BsNmk0bldNeUVPY0tEWnZud3ZW?=
 =?utf-8?Q?CLhgw4mPdXYZ3ZD4ns6ssx9vP?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c2b215a-686a-436a-0d24-08db0390f841
X-MS-Exchange-CrossTenant-AuthSource: PAVPR02MB9523.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 13:42:17.9337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EtlsxHROV7/S5xr9k0aOOZC1BOxmjAVz6XV6MuAu3dyaW/nuR9zKv1zeLnQp0thkNMxDjxynmvjw3mzg0d7Q+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR02MB6136
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 1/31/23 14:37, Andy Shevchenko wrote:
> On Tue, Jan 31, 2023 at 02:27:51PM +0100, Mårten Lindahl wrote:
>> On 1/31/23 13:33, Andy Shevchenko wrote:
>>> On Tue, Jan 31, 2023 at 11:29:51AM +0100, Mårten Lindahl wrote:
> ...
>
>>>>    - Trimmed backtrace in commit message
>>> Not enough, please try harder. The ideal is to have ~3-5 lines of traceback.
>> Hi Andy, Maybe I get it right soon ;). Could it perhaps be stripped like
>> this?
> Lockdep warning is important.
>
> Assuming you left the warning still in place, almost there.
>
>> Call trace:
>> __mutex_lock
>> mutex_lock_nested
>> vcnl4200_set_power_state
>> vcnl4200_init
>> vcnl4000_probe
> Can be cut out:
Ok, I'll have it like this then:

   DEBUG_LOCKS_WARN_ON(lock->magic != lock)
   at kernel/locking/mutex.c:575 __mutex_lock+0x4f8/0x890
   Call trace:
   __mutex_lock
   mutex_lock_nested
   vcnl4200_set_power_state
   vcnl4200_init
   vcnl4000_probe

Kind regards

Mårten

>
>> i2c_device_probe
