Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5A166E49D
	for <lists+linux-iio@lfdr.de>; Tue, 17 Jan 2023 18:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234897AbjAQRPh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Jan 2023 12:15:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234994AbjAQRPG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Jan 2023 12:15:06 -0500
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E256A4901B
        for <linux-iio@vger.kernel.org>; Tue, 17 Jan 2023 09:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1673975650;
  x=1705511650;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ECDBgDu2CslZxnppm8fP7gEWvqoXg9NaMqnU0o6Xdto=;
  b=RGkwOjIldTdwoCYG2Oc7qa8a4nzcR7WcyEyTkttrw/1NiB4ZknEYtWnE
   B8notVMjscnwgiTmzHo82QqC4AFX/72OKNh78VGvntIf/cNonBuuwxXMG
   oPih+RiEFK4jq6wLDR6D9gZKYk5+IuBe9tayX/uOSbWegHAbPdPUP4Fxz
   xH1gvkcpqmvWHWjQy9m1euZyVYAmVq7PA4v3TIMuVJjFlQb9w5RnRxJjA
   0T1F3p+CnDWULbwFwDt7r6aIhvkDfXuehmkRsAHVJPJPRcDS9lseMEeK4
   e7A4jelFZcyFMdFLc2BwoR2HEcnzPfv0Xu5aL0WmwU/HagZYvb1SZ3i6b
   Q==;
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Knv5X+XhsHZy9YwrLnLkb764p8Y5j+E1BJmKh0o4tSatX3QfWaJhDZMJNjVSg0AUV+WYt1OshIVjlZ3hxofD31QPQBqLAiFCxgWy+pVAeOw1K2nAvAftAhVxNIc1LZkBheZ39yLBDYItrhx9ym4lG9O2yk7ccFUjjG9lVYW95l5QzcqWBRWr4Z5IdWynVcXtz4hA2UrQYL75Xw2hlsPuOPCLES15KSzDGTFeLZT86N3XeaeAm62F+dgjJyfuvwaQY5Dj26Ds5YyrGRD2gxxykteViHwRXp+tr1tOAogyjfXGy0OYGQNYHBcKsA4no5LqKbbcuzEx96/CYuLflwNiCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ECDBgDu2CslZxnppm8fP7gEWvqoXg9NaMqnU0o6Xdto=;
 b=JJX2DF+NhaxrdYyNftGEIIz6cGtC9dDjknyhm/5XqLWZwoj+2Zey9VJMNxHTeNcHI4mxQbzXWduJTy557he/FRUzV6p77FFlkcI//0H+fF4BHPYBwjldSsA8jINd7TRu8eIAs2X6ivZxEGDiGn2gPGkim8nhRZ6IpOJdKCvhUr6iDvNbZzbaUWLAIeVc/XYkBWd2CDRYGlbRcs8VaJ1eEA+mpMA9u1HshHQVKdYslURvAPRAVlHMcOLrzKMqlSD92RiElGrEzszvd9Yji83/A1UWIXfTW0QP2Cggkp0yvyXGNMGHNCL2zIQXGtP/x+D0JnYKeocjdWCA7gnvWsPBLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axis365.onmicrosoft.com; s=selector2-axis365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ECDBgDu2CslZxnppm8fP7gEWvqoXg9NaMqnU0o6Xdto=;
 b=eqZpFOUuePaUxMGeNfreN9Af0uNKpO9n06FebpIjvgO6okrDCbBJuLU1FwuGkwQRsUHI/s2oEoXK/ntMYEseD9zIbCNr1hrtbm9REFD2k+Zc5+vlwZEeGZ8Px5TWwnDwxfRmCKxvaW1KFYUMWYX5HbZCcS63I91mlczQ3MvtGmI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Message-ID: <f1306e9f-5e72-a85d-ce0d-00e636ae7f70@axis.com>
Date:   Tue, 17 Jan 2023 18:14:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v4 3/3] iio: light: vcnl4000: Add interrupt support for
 vcnl4040
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?Q?M=c3=a5rten_Lindahl?= <marten.lindahl@axis.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        <linux-iio@vger.kernel.org>, <kernel@axis.com>
References: <20230117152435.3510319-1-marten.lindahl@axis.com>
 <20230117152435.3510319-4-marten.lindahl@axis.com>
 <Y8bFvovmqKCO6fVC@smile.fi.intel.com> <Y8bF8oeBWGbs7zE4@smile.fi.intel.com>
From:   Marten Lindahl <martenli@axis.com>
In-Reply-To: <Y8bF8oeBWGbs7zE4@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV3P280CA0052.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:9::6)
 To AS8PR02MB9529.eurprd02.prod.outlook.com (2603:10a6:20b:5a5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB9529:EE_|AM9PR02MB6803:EE_
X-MS-Office365-Filtering-Correlation-Id: 4baa976e-5476-41d7-eb55-08daf8ae3ce7
X-LD-Processed: 78703d3c-b907-432f-b066-88f7af9ca3af,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NJJV4OXFp7deOCXElFfIBCompybKhXJXarFZf0x179mEW7NpXL4xjTxAZhRoWh7/S4vYm9Ix+ibTwXHLk5cTsWw8qe8wBTSf5KdWUAb/JmFHP2aahXDn1O/71uBqoMg6x92qaBfV9tbnjTjtdD3edynKWGoEuFSeO+1tsyw0TDivjLPvR/unkjAZMwGuVRASTV8nSG6pSsYAkkNjTMbC91t1FUTaGweo5RAjXQlTfoc5TZj8Dql9A9dBjKMZLzwmfgA/ehta7OIMn/Or+8FbMEVnxR2ddr075ufyEZnqS6haX0LfNEojbLXf/0wdADozFoyhjxgBN9N1zS/6rTWgmhsv447QCpEbP9D8rNsMG1oECOWY5+dGGCSRZ3bvdsnmUEBXIrmwvmCZoLaOgg9dW57pzJi8D5VvhIqpxvlP4XEdhIz/jxXthsKty9mCF9qA1ZK/g3nUMK6UuMRGCHETiwjoodYPAsJ7p2p3V/YH8frUMzMKkL24hC/aQnympxetrefpP220SSo5O47TRyun7yIQJzOdyHCj1ynacrErV7p2uh9ioRRdCcmYvVmONfCQerJCozGf9F9FResst2z15BtkKIsetXiCl58VE3O9Y/gHtvOMJHNIbypPJd+Aas19v+llKASwou33aeB0whID/TrLfHViQEejfkaFRxc2hlJGXcvvkQNa+ix9VZRoJKGbezq+WKjt/Ya5R5oVFbSzLihQpavfeXUXCdHrtf9maXU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR02MB9529.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(346002)(136003)(39860400002)(366004)(451199015)(6486002)(478600001)(110136005)(36756003)(6636002)(316002)(54906003)(83380400001)(31696002)(38100700002)(107886003)(66574015)(53546011)(6506007)(6512007)(2906002)(186003)(6666004)(5660300002)(66476007)(2616005)(4326008)(66946007)(8676002)(31686004)(66556008)(8936002)(4744005)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnNGMWNVeTBSMVptUmk2MUxjbVV0T0RPMVFiR3Q5QTdVR2RSZ2xSZTFtM25m?=
 =?utf-8?B?bUxFOW5kY0gyUVlQazI1VUJIOENVVHArUnZXR2VIeXZFYjd3em9KenZrTGlD?=
 =?utf-8?B?ejhDWkZ3YmNqbXBlRUJqZ09VWlcvamQ3dGpMRXpYYzFDR2JxaHMwRDlGTWZa?=
 =?utf-8?B?eW1Jd1lzUzNDODVmZm9TZjkvRkV2MFJubjVYb0dGQnBWcXZjTmtkZGxQS1Er?=
 =?utf-8?B?SmgzYThMM0MrSnRySytOQUU5b2MzbUpZVDM2QkV0NFFOeXJMa3RzUjlyR0l3?=
 =?utf-8?B?MXUrRHAzZ2krcmFsQ2RHREFRb1djYUY2dm5sRkIzeHN2WUo2dDhQZVFNSDJE?=
 =?utf-8?B?S2ppb1FJcFZWZm9pWDhkMGJhbC93R2RTVDVyWUJYZUlvbytzaTI5UDBwY2Zo?=
 =?utf-8?B?WDVPeHE2NHRsdEJPSWM4MXovMytCRmVQSWlyY1E2OWMrRjdtWXlqeStWNS9T?=
 =?utf-8?B?NCtKdXNOcFVNOCswbDh0Q0N0eU1ZL2Q3WWFKNE82Q3dZdUJwVlRuRXBEUXFr?=
 =?utf-8?B?T0RzZlZKak1iUmtSZjZKREE5RTZGU0U2QU5CT0pFakFFaVhXV01xSElvTkFB?=
 =?utf-8?B?WjlpNCt2TkIzaGt4bnRvRWFtbEtzWnJPZ1VvNlVwazhZaFNWa3RqazRUMjJJ?=
 =?utf-8?B?aWhLeWFyUTVubnBoVkFjQkc1ajFYSGUvN0pKeksyVlFWRDlwYS9UU0wxZGc1?=
 =?utf-8?B?dFowMEJNZzBQaTgrRTBpSnBUeXJzZ0JxYlNTT2hxbDZFUDBJdDZlU2JjRUpl?=
 =?utf-8?B?dEMvcDdqUElPVEdnZmZ0UjRxSEJsUzQrVnlZWnhQNlM3RW1RbVJpbGpZbXpH?=
 =?utf-8?B?U2VEdGdEeDFYL0VqNkgzWUhLcE4rMG8vaDZFUnA1bHpGNlUxZTBpM1k2SmVX?=
 =?utf-8?B?RWdHMUdkK1c0Wm5WbktkTW81aDdrc2E2RnZ3d29QQlFUbkh6NDBTMWU1dnJD?=
 =?utf-8?B?VXRGcnVTT3ZYTDJRQ2hMMi9ld0hQaVMzRHVCcjQ3dmU2bXFrQURXS3pXandL?=
 =?utf-8?B?ODRBKy9rMXpqOWN0cUdUVGhadE1Qc21sdXRuQWlYSnA0VXkxRGdRTituU0ty?=
 =?utf-8?B?ZDZiMXBBbytpaUtPMTNDWmFXbnM5ZGxsaGVLZUdITEIxdlJ3WGJHUTRHUlRq?=
 =?utf-8?B?TlZBRUZnY1hUQjMvL1BqaHZISzRRcmpaT1VvQnpneWtvU2NWWEkrdCt1YVVM?=
 =?utf-8?B?cXNkaW9JSStNNk8rTDhxWnk0WEhLUnoyRHZEVFU4QThjTWdPb1J2SjBuTTZ5?=
 =?utf-8?B?dG5GUElBUGZpQXhESTF4VDc5YlVzUnNvRjZCZnFUVFdITysvdkEveXQ3V1NB?=
 =?utf-8?B?VitUTFdsdXpzTllsc1BsMEtUd1QvT2tlTnlyQTBOdExkYk55K1doNWxLNjN0?=
 =?utf-8?B?SGE2ZEhiS09iTi84bm1ISC84TE13Qk5tYXp6Y2tIVUVpbHhSbnk4NDdpZmNv?=
 =?utf-8?B?bEVaNXlvL0F5aWVGY1VQMCt4TTZ1UlkyYUxLRjhhYUwwVjV5QTRQMXpsSmZD?=
 =?utf-8?B?cDBOQ2d5QVhDalBpUDVjUlQvTWZWK3NpUDNsMHY3R3RqaGt4bW44T3ZuWjRV?=
 =?utf-8?B?Qjd4RVVtaFJrcTNQdHh5b0ZlVitzL2xOMFNnVHBySVZ3Vkk2eFJCQm42OTlo?=
 =?utf-8?B?WlZPVWdxTmJzMHZjOHVNODJZVVBCWThSWFVmVUtObzRLRlZPeWdxNjZTeXBD?=
 =?utf-8?B?OFpmY05LTXpZTGJwNU1XQkgwSVF1Z0ViL2x1c0gzYUh6NFc2SVVSRzRjY2NB?=
 =?utf-8?B?eXNIN2J5QjNJRURIZmpLZnNCenNZZVo5aHdZUGhMUE8wczNCaEJPN2VxVEo0?=
 =?utf-8?B?d2YwZnozODZHbmZ1bVlNYnNpU0QyMS9naCt5eGsxdDUzTDFiVmhOa3ZYTnlx?=
 =?utf-8?B?UUdzSXcybkExaklYWHM5NFVqYXA4OVp0VU5JWFpsTHA3eUNMcFpLWENaeVY5?=
 =?utf-8?B?M3RxRi9PTnFiNElVVnNySjc5eUdZZkVSbFFTNzYyN3lQdGU0N0cwaCtxWXhr?=
 =?utf-8?B?ZkJ2WitwbHkvK1RDbHpTbmszaWZZUExmQ0ZnSXBaQnBDZUhBc0FnSDExOEIw?=
 =?utf-8?B?bTlKek05cEZwaTl3b2dVeVAwNTFLNkNEODdDMUFaK1E5ODVwbmVMMi8rclY4?=
 =?utf-8?B?L0lGN1BIaVFIR2lPOFl5VTk3d1ljalIvYnVqQU85ZXhMUG4xbUg1ck5yRXps?=
 =?utf-8?Q?rthP9UoLiuYYpfl6fSJK45gnywS82h5RooD9KYPhqD5I?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4baa976e-5476-41d7-eb55-08daf8ae3ce7
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB9529.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 17:14:05.7270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zC9lLS83sWLacj1FZvWKxjOethG11gqiIRPczGvbwqdf/D0zuj0A/3dv9NtujK3uqZkFflBvhncNhIDc+bNcxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR02MB6803
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


On 1/17/23 16:59, Andy Shevchenko wrote:
> On Tue, Jan 17, 2023 at 05:58:54PM +0200, Andy Shevchenko wrote:
>> On Tue, Jan 17, 2023 at 04:24:35PM +0100, Mårten Lindahl wrote:
> ...
>
>>> +	val = ret;
>>> +
>>> +	if (dir == IIO_EV_DIR_RISING)
>>> +		val = state ? (val | VCNL4040_PS_IF_AWAY) :
>>> +		    (val & ~VCNL4040_PS_IF_AWAY);
>>> +	else
>>> +		val = state ? (val | VCNL4040_PS_IF_CLOSE) :
>>> +		    (val & ~VCNL4040_PS_IF_CLOSE);
>>
>> Wouldn't be better
>>
>> 	uXX val, mask;
>>
>>
>> 	if (dir == IIO_EV_DIR_RISING)
>> 		mask = VCNL4040_PS_IF_AWAY;
>> 	else
>> 		mask = VCNL4040_PS_IF_CLOSE;
>>
>> 	val = state ? (val | mask) : (val & ~mask);
> Of course I meant
>
> 	val = state ? (ret | mask) : (ret & ~mask);
>
>> ?

Sure. There are several ways to do this, but your suggestion may be more 
clear. I'll fix it. Thanks!

Kind regards

Mårten

