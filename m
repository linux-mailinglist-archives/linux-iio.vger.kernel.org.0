Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0738E57A5D7
	for <lists+linux-iio@lfdr.de>; Tue, 19 Jul 2022 19:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239012AbiGSRyP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Jul 2022 13:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239234AbiGSRyP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Jul 2022 13:54:15 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60107.outbound.protection.outlook.com [40.107.6.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3900F5A8BB
        for <linux-iio@vger.kernel.org>; Tue, 19 Jul 2022 10:54:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OpIFgGargnFxQkr53mHLzgVcK6z+ldSSFRE8UKqKas89VDnJmhsRWuZ7t6rrldp1ZTtPg5eX9jbJRqvDv5hUszfVQEXD/r/Ngg0qKNCp4RMmVYFo8PpwrfVC+C5CdnJiD0P4zc5dxZVBg4HGta8Jv649R2bVytEeOUuiBivWf3nl01COq3GPGopJBdVbTBnXYvprAU6vs2TULMGiv34/did4YjiiWVKWcrx1EV2FWj/MMG411SnQ4xYd+2XtGiJGRIwyYx10Mc/3vUjz2rNneyDsq/Hvwfwcd+fqVxN2djD1IlMzmGSjEoV9X0ZCaulBNekxePLgyjDd2LwyR/ar6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SHzhf3amplaG7fyg5d8xeInZ5lE9sq4OR/PIdzovBZs=;
 b=ddFRjTLTsISySBH6FePPcgbVfbksHRRfpWhn01ZsobVdWcqF7VnOmLr/fq6gb1Yc8QXRqOtYyM4Uj2QeFAhoApEwhEHel/W0kg2c1uxvXITV+aiB3cN7hXH/gmLhybf9iWiCqwQ4vjE3Vd43C3o+n02esnQz8wkbX5P4pDIUgM6CsNzV1SWtMgCenoE5Xb7Y0m8egKrfs/g716643TSE52fOkAY6/bUiOdK9HfytBka8gemrtROQ+hhAsveFV0yFFl2E5iN4qNzuDhn86hnYx7Y36mGVF2LSWnOpvATTeTTwWQS6c8dM4ZbfBm0MQN7M18R7IRCa+14WgpVsNNHCZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SHzhf3amplaG7fyg5d8xeInZ5lE9sq4OR/PIdzovBZs=;
 b=ZyAMscqnPz9VkJro68Yive3YPV20xzklh9r3Sn3th19JSTyeBZMJNiUcEKN2u3jACjPEaoxB1jrv1r803z0uOSaDv5mDZePTWOW5CdDEwRN1KCzZ2yTPdTWfhL2FrFtHjhYninfUQyZIPPpNwjHCLKNZtUhRfRoRSY0zr158/8I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com (2603:10a6:208:ed::15)
 by HE1PR0201MB2441.eurprd02.prod.outlook.com (2603:10a6:3:82::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Tue, 19 Jul
 2022 17:54:06 +0000
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::11f2:df70:b231:2b45]) by AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::11f2:df70:b231:2b45%4]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 17:54:06 +0000
Message-ID: <c7994aeb-8b22-625c-a468-c74ca60943ab@axentia.se>
Date:   Tue, 19 Jul 2022 19:54:18 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC] iio: multiplexer: Copy scan_type details from parent to
 child
Content-Language: en-US
To:     Chris Morgan <macromorgan@hotmail.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Chris Morgan <macroalpha82@gmail.com>,
        linux-iio@vger.kernel.org, lars@metafoo.de
References: <20220718184312.11840-1-macroalpha82@gmail.com>
 <20220719095116.3dc46f3a@jic23-huawei>
 <f845f910-fb46-e38e-b4e2-709ae4da006b@axentia.se>
 <20220719151901.000020cf@Huawei.com>
 <SN6PR06MB534291E524FB941356E32D9BA58F9@SN6PR06MB5342.namprd06.prod.outlook.com>
From:   Peter Rosin <peda@axentia.se>
In-Reply-To: <SN6PR06MB534291E524FB941356E32D9BA58F9@SN6PR06MB5342.namprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0028.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:b::8)
 To AM0PR02MB4436.eurprd02.prod.outlook.com (2603:10a6:208:ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 02723ac2-a7b3-4383-618f-08da69afaccc
X-MS-TrafficTypeDiagnostic: HE1PR0201MB2441:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MG/zbYCV+TsMIbX08CmVCdVRzCQJpX7P+4T5ZJI9F8bm4Y0F61ybPz6CWbKN5Lg1GIBSei8Omf7lgcHcvg6bvX7//doha/hU/NGW+4xt2BJkE9GZuWXIScE1zZMgkl0cXtcVS2FwBpGbp6N0aMZfYqU4T7rgSlC7tzCSNp11/9QoisF6js1PiYdWTND2j27ZnR/m98k8HZGUyxG8xAAk2w3PKArpJAX4AVHi2UsdsLYJ2wr54oZ6FJ/PI0qrxNtqWUInLJ/1HYEmeAjjA9p3W6vYCK84w9ecwl32+5wWVPwkqkYyBKOqNTJ1QrxLEb1zueh1JqRegnl4kwXpHIso913swy9F0A+2225eu+KKaytwRPnT10cCJANLDqoAxC1EYVin8U6SFTIsyQiY9H2RgzlfsOkeDRvpSucKHA8k65m/ral3R/O0F/vsOnwDt7NTwSNu/XrK3hbOILeupOwq+0XSI42beB+DmXhRvTmQwpaEUnYQ4ekSbdYOuNs1FkqTitCkfolJhhwIt+1dH62ciHr6P+HE+3LxF7wiUgosB2GmmFbmksqJdMPzr7pdIobcXsjv2PN2L6ZJ+MujPFmr4P9VJwNivSFV+pSlTqmzivInYP3oR8GAxO4wbO+7wcUp+WXu/VwgZpObGZo3uRdBfDl+shRlTtN/BgPF50PgctxXnKgB2oTgeQJ4//hlefiI4Dp3IIyYs95P+BvtVXVbJ+7ZnD3mYmVZgp4fELHG0mAAs6yuC2t5ecDA4PtbHsCr9930VeoDie9upL9zinCj19I6DcHzxZPeJUwdtVcwBWfKmyIKasTjRyDGOE8WZPPqa9ib+9B5wJF/L8FjERdU47cg5o5z7VbgFUJ9XzvhfYU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB4436.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(396003)(39830400003)(366004)(136003)(346002)(966005)(6486002)(478600001)(6666004)(6506007)(41300700001)(45080400002)(54906003)(36756003)(31686004)(31696002)(316002)(83380400001)(86362001)(26005)(6512007)(2616005)(2906002)(110136005)(5660300002)(66946007)(8936002)(66476007)(66556008)(8676002)(4326008)(186003)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3Rnb1hBTm91aGR4bjAvdWlMRngyS253OXpadWNXcCtrNDVVZ3BqWUM0WHVF?=
 =?utf-8?B?MzZhYmxwNlUyakhwMWQvWkJrYnZvdVN6dm9CT3FzM1ZRN2kwdjdTeno5UFY0?=
 =?utf-8?B?b1Ivc29VczlwdGpEeE1BNzZRcGhIelM3MVYxNHFmUnRYekRMU1dTQkNFSCtW?=
 =?utf-8?B?bFNramFLUmNHMS9HVnhKZjIwZVZXT0IrU2FBbi9CamdqYlNWV2pqa1BOb2U1?=
 =?utf-8?B?c0V4enhzSm1kUjd0VTlWaEhVWDFqWFpaeTk1S3FzVDBBVFROOFJrQ2pOM1Bk?=
 =?utf-8?B?OXQ2QWZTTVB6eEdLOU1CdkRXUjZVNHZndmVnZWJ1dm9EQ1Q0cUVhazFsdmpt?=
 =?utf-8?B?UDhTMDVKTzR6Z1FkS0Vqb1NXdUlOSFlLejgzY1J6M3BUZWZkY1FkYVBTemg2?=
 =?utf-8?B?ZlNiVlljYkg2Smw2eGlOcDBUeXFnbTduc2xFbjRJd2pFN280V2F6NUVKeTBR?=
 =?utf-8?B?SmRTYmFTTVJ1d21PK0tjY0JNZjR3MFBrejQ5MmwxNkQ0TEpzVlBTT2ZuMFZL?=
 =?utf-8?B?alVuVnlFc0dQa2U0aUlIQkExQWNuSm1Rc2o3d2cvaVE1NTZ6bjdEVmx1ZFQ3?=
 =?utf-8?B?cU9KOXEzQTEvNXFNRzZpQzh1WkdLanBob1NxK2M3OG5MR01uSGdIejRVakFx?=
 =?utf-8?B?cFNHNVBjMW9oajZ4OXJOZUZhcnZlY2w0TVlqTmNVMU1XdmRKcmJNSHU3d1Fz?=
 =?utf-8?B?YXk0QitJNmhoU3RRejZTWWNQME9wN3A3dU1QclBtNzUwRDJUMUNFaERXdmc2?=
 =?utf-8?B?cGcxOUI0aWk2RGd2YzkvNjZQSG1URjNUcXRBTlgzVzEwdEtBZ21KWU9LdkU1?=
 =?utf-8?B?aGpkK2hqekE0TjZhMi9vY0RsN1RzK3VOczFRTmU4OTVYeXV1TlhGMGViL1pR?=
 =?utf-8?B?TVlpK0tINFpJSU5Iakd4S09qeDYzcnMzMnV3bG9rQ24xc0tUYWRlOHJMWGk2?=
 =?utf-8?B?dUJKdW1Ka05tMWIwUFIweHFFeWZZK0ZWS3hiYWt1Y1dsUTVray9IT0dOZ3lI?=
 =?utf-8?B?YVp0RzdUT2d2S1dNTzZWL2t2a0ZYb0pvbGIyRnJkbGN0SkhaTmUxRGErMlVY?=
 =?utf-8?B?QkYrblJ1VVJDREJmbCtCMS9zeVNXZzZmSTM0Zitaek1pY2IxbjJhcU53dEto?=
 =?utf-8?B?UVFJa0hZR2hCc1dlTTNYZXRVd3Q2NmRndnBiaEs2eVFoLzAxaTdRSFpMcm81?=
 =?utf-8?B?QnZOM2hVaWNhaGp4bDBZbVIzUFMvSDRWbDNnY3BHNDZqN3I0S1RSNEYrQVp0?=
 =?utf-8?B?MnptTXk5WGViZDY4RnA4Wkl5VEk3cjhVVlhScG5Kd1d2ZmZpSkNoQlpqNkFw?=
 =?utf-8?B?ZUZkdlVYa2tFbHphWXBVQU1Kc0d6dUxTY1plbmhOQ0FPWVFGQVRNTG1aekJl?=
 =?utf-8?B?Y1JYbmdIWWk5TGFnZkY5WjNzcjFiWHNyb1JnMXhKeGwxQ0Z3KzV0QmxZcUx4?=
 =?utf-8?B?T01TeVRKSEpUSTc5S0VWbDlEZkowN3lsRUJOdmdad2NQS0hSMkMzU2dQWEFt?=
 =?utf-8?B?ZnRwUmVodWYrVHdmaGEyTlpJeVE0bzMrNkpJK1RJbHpwckl2MGFCaTd3a3Fw?=
 =?utf-8?B?MzhUbkxjY085aFBoVzU0LzNpeE04ZjdSYWhNRFQ2a1BQVGloV3hFMFZQaG52?=
 =?utf-8?B?OVRzdjhFRnVCWGs5UmNPQ01GSFFXTkdYckg0RHI2bVJHbFBZOVBGQ2RHNTg4?=
 =?utf-8?B?N2s4cE5QcXE0bEM0TjNIdzMzYmFFL0VwREVneU9vTjA4b3d5NlFrc1FCakQ2?=
 =?utf-8?B?MVp4bnBZMjl1alhNVkMxN3hOdVFETERyTUlpWHFhNExtbDU0OEpzT0NEb1hQ?=
 =?utf-8?B?TU43ZTlaR3VZYTdYamFQL0UyaXhWWGRKL0hUZFlCUVBId1V3ck5XbGh1RnVs?=
 =?utf-8?B?UFZ4Y1NGUjNCWUNYMzJDb3NYWVQxZU1rWUVycXQvRXZmaUFjZFI4enVJRVBN?=
 =?utf-8?B?VkF5clZSV0IwbXdacmc5SFFTeHZINTJIZng3SDRnT2ZZU21TbitOZ1dWd1ZS?=
 =?utf-8?B?QXBGUXdodjRwVHRtN0hQdU5lcXlNam1mRFM5Szc0cUJ5OURMc3h5NDlyOFdy?=
 =?utf-8?B?eWtaaDNUeWZHcGk3WFJlbzh3TW45NGFMT2dFbE56ODJpeXpSWlFHejQ2ZEtZ?=
 =?utf-8?Q?jfttDEnVcp+MufP5N2UJqwOXD?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 02723ac2-a7b3-4383-618f-08da69afaccc
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB4436.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 17:54:06.7177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8qJABlRRUuuYA2cYzK7M483iMR3glmVdZc76a6mdHII8Z0HduU5bVCAutOtG/vIH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0201MB2441
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



2022-07-19 at 16:44, Chris Morgan wrote:
> On Tue, Jul 19, 2022 at 03:19:01PM +0100, Jonathan Cameron wrote:
>> On Tue, 19 Jul 2022 15:27:24 +0200
>> Peter Rosin <peda@axentia.se> wrote:
>>
>>> Hi!
>>>
>>> 2022-07-19 at 10:51, Jonathan Cameron wrote:
>>>> On Mon, 18 Jul 2022 13:43:12 -0500
>>>> Chris Morgan <macroalpha82@gmail.com> wrote:
>>>>   
>>>>> From: Chris Morgan <macromorgan@hotmail.com>
>>>>>
>>>>> Copy the scan_type details from the parent iio channel to the child.
>>>>> The scan_type is otherwise empty and things like the storagebits are
>>>>> zero (which causes a problem for the adc-joystick driver which
>>>>> validates the storagebits when used through a mux). I'm submitting this
>>>>> as an RFC because I'm not sure if this is the correct way to handle
>>>>> this scenario (a driver that checks the storagebits used with the iio
>>>>> multiplexer).
>>>>>
>>>>> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>  
>>>> Seems sensible to me. Though Peter is expert on this one.  
>>>
>>> I really doubt that it is this simple. I'm no expert on buffered channels,
>>> but after a quick look it certainly looks like adc-joystick requires
>>> buffered channels. And iio-multiplexer does not support that at all. I
>>> think it could be supported, but in that case the only obvious support
>>> would be to support buffered channels one at a time, and the way I
>>> read adc-joystick it expects to get one sample for each axes in one
>>> go (i.e. the way "normal" ADCs deliver multiple parallel samples). See
>>> e.g. the call to iio_channel_get_all_cb in adc-joystick, which dives
>>> right into the buffered iio department.
>>>
>>> So, the stuff in scan_type (along with scan_index, which is highly
>>> related) is only relevant for buffered channels, and iio_multiplexer is
>>> currently limited by its
>>>
>>> 	indio_dev->modes = INDIO_DIRECT_MODE;
>>>
>>> which is ... not buffered. :-(
>>>
>>> The simplest way forward is probably to lift the requirement of buffered
>>> channels from adc-joystick, but that might be a hard sell as that driver
>>> would then probably be a lot bigger and more complex.
>>>
>>
>> Got it in one ;)

I guess I'm old and can therefore allow myself to blather :-)

>> There is a recent series from Chris adding polled support to adc_joystick (not yet merged)
>> https://nam12.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fall%2F20220705190354.69263-1-macromorgan%40hotmail.com%2F&amp;data=05%7C01%7C%7Cfc07a056f5ae40ecc37908da6991a298%7C84df9e7fe9f640afb435aaaaaaaaaaaa%7C1%7C0%7C637938371469723267%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=tAT8scZvG9Z8OVSgwdxog%2Bz55dzQC2TFddDa%2BQEX6e4%3D&amp;reserved=0
>> That just reads the channels one at a time via same interfaces used for
>> sysfs reads so would work with the iio-mux I think.
>>
>> Jonathan
> 
> Right, correct that these two "work" together. Honestly the main thing
> is that the adc-joystick driver checks for the storagebits, and that's
> failing for me in this case when I use a mux. I added a one-liner to
> the multiplexer code which added the parent information and that fixed
> it. It's also possible that I could change the adc-joystick driver to
> either not look for the storagebits or to change it to only look when
> not doing polling mode. I just assumed that a missing scan_type was
> an issue, so I added it and marked the patch as RFC because I wasn't
> sure. If you want me to relax the adc-joystick check instead for polled
> devices, I can.

Ah, ok, there's been new development. Nice!

As I said, I'm by no means a iio-buffer expert. On the contrary, I'm a
total noob. So, be sure to take the following with a good pinch of salt,
but I think that the adc-joystick driver in a mode that does not use
iio-buffers should not then have artificial requirement on the buffer
layout (scan_type). Don't forget the salt... :-)

> Note that the adc-joystick driver does work perfectly fine with a mux,
> I'm in the very early stages of upstreaming some devices which use it
> in such a manner (the Anbernic RG353, Anbernic RG503, Odroid Go Super
> are example devices that use the adc-joystick with a mux downstream).

Cool!

Cheers,
Peter
