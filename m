Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A56316810B4
	for <lists+linux-iio@lfdr.de>; Mon, 30 Jan 2023 15:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237074AbjA3OFx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Jan 2023 09:05:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237070AbjA3OFw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Jan 2023 09:05:52 -0500
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88453193F2
        for <linux-iio@vger.kernel.org>; Mon, 30 Jan 2023 06:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1675087552;
  x=1706623552;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jBynt5zXalIoRKS3HsnFUR6GfyzgM83oEmg6eyQAYXQ=;
  b=O51GeFRby0mQKcZQDvSBDQ9SkfMpmVXRS+PNgeWh4aaiT/0/iqBTDbYz
   L+pA8ibHwJ1LYY96+jJ1ck0tThf2mLPTv9BO5P8GgdrvwlOQz5YaDhJUu
   2QtoifgDSuGWwOOqvalwPW2mskdQetc1EJOac0je1nRIOrZRFuzWb1Rb9
   24+McNXIK/Wi/3eLXyy4kFEWfWlJaEfPeYM0Kd7IU/t8DOs4BI2msmxfW
   gag03Rc+gADgmnQFQmlkvCY6ecyJb/Z9zTFJtiwJa6Cme0JukGS4pknnb
   aerQQJZTKqUB04KU7gBh69zuva3ydDTTo5YkEkUYQNfrVfG7rJ7HBmnpA
   A==;
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lGNWf9hdbs8cbAZ5V9ADMFauV3T/OB+LpWYyVgtfDCA1OkFtTcfnYZpp6NlzQvc2JQ9LoCDMRaeXLYB6JjkKQ0OJbwJc+6/U8ndhDMvlmXl+GEu+FRQS9z9BEKQFcrFqtokTolANPpU4myR22v7jW5rKBpClAMQSRM4nJy9R9ysKydyl/PWBNkhaB4yVct3xAKUAFlxVQVuCjOqO0xdtz+KzlZ/JBQ8ZHLSMJQTLVmfv2NOBCLtPHs08f65+8k3fg5ktPTlTzPcb/2T0I0hf/Qmgp9Wyz98Vq5eZMMIk28R/tG2zKXFSF4LK3op6ZJnp8EHYI7xuB5xe9kswo48S6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jBynt5zXalIoRKS3HsnFUR6GfyzgM83oEmg6eyQAYXQ=;
 b=BSh8ciXsOP5eOyA7UsaUA8e0oBaKbuvp0JRP6Ux1zQdY7d/CqX2ke7Qhju+2z29eleCKPGC5DyzumbaWBbPfnaOXaSDtTkHFen06DzV4Y3Tl7280te9bW2euLDqz05IatCnELnYhn5J1KZXnjvNULO8Pn+5khlh9P1IDFRQukT/ON+4XchlRc5or10nmeiHbyHMvX/wCM99LoeAbWtRsHoHZ3fenxspYzHMNVTZgyyU5CIZ3gchPMjPGZjIeGnp10o1Ztd/CCpyHGx6Cw1NdAgE4YpWnFjsPWUGjTi5dJJKnXkowDVFvrltmQYjy+tm6kp+KYy4VMEk5wo7/jaGdxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axis365.onmicrosoft.com; s=selector2-axis365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jBynt5zXalIoRKS3HsnFUR6GfyzgM83oEmg6eyQAYXQ=;
 b=yP9OB6g3Wghqiya9/GWGpCzV27xjxKKitg0YCyo+BzFlWO1ydnRyq9ykScF5Aq+r5nUzWa6ejDEzgUV2iMA/ichRA/RsqBFO01G/jxYwugWfTU/uklyFDHWt9erDYYXrxO/b1mebKHqVT5C57W2ZrBvWT+rIofFA/k4t+uxo920=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Message-ID: <05a9ba89-19a7-de70-f3f3-7b0d8b0157a9@axis.com>
Date:   Mon, 30 Jan 2023 15:05:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] iio: light: vcnl4000: Fix WARN_ON on uninitialized lock
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?Q?M=c3=a5rten_Lindahl?= <marten.lindahl@axis.com>
CC:     <linux-iio@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        <kernel@axis.com>, Jonathan Cameron <jic23@kernel.org>
References: <20230130093742.838577-1-marten.lindahl@axis.com>
 <Y9e6cGDYxkrTtQtC@smile.fi.intel.com> <Y9e6w3bUmNKDSdej@smile.fi.intel.com>
From:   =?UTF-8?Q?M=c3=a5rten_Lindahl?= <martenli@axis.com>
In-Reply-To: <Y9e6w3bUmNKDSdej@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MM0P280CA0023.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:a::9)
 To AS8PR02MB9529.eurprd02.prod.outlook.com (2603:10a6:20b:5a5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB9529:EE_|DBAPR02MB6456:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f99bf48-3115-47d9-2d28-08db02cb1655
X-LD-Processed: 78703d3c-b907-432f-b066-88f7af9ca3af,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qfOA8TwfNH+aV2vAGVRUyYWsFL6TwPHWyVhqUiRCccHDhhzAoZO1l1qTawCvMfgBCyBr/bmZ1i7ydvkvWo1CkxtrACcH3hj4nB/B40xFukcEZRl5qny6WVxhQRZ9sRg/ybvZ5RZB/cmnNIYWCAhWGmsyNp0cDnS7gaDC140P6tlFA1amupoeC5rwyp93uTk5I2ycwpYHn6XlEZXCz/Gcsjlpm19rWzwOGKOCB2Qy/Ty0TWvH3sBT/QRvwco81TgWCAMj+JNIiE8YU45aQkVF9uGRHwU/xna+XrlriDpB3lpTqqxDotYeL9XFkYF4LuLbuj7a6U4c21zNd8B7m3BhHdT0VeBxxuYyfJxD4MK5QjRAO26XUPBFoTyg5UdNRKVnAKq4GxCDvTFuElQBQ7tSI6G9FjFUA/S8I3s+tzh129ddXrklbFyCaKZtXTO2o0PWoS+/RbzUU9BmlDF+xTF8HnAc88mcm0qbAglBKVPRI4Evo+kpccS4Q+k6FQbu8q7Hg4xjlw4PiTCEQhfObdv3aM8mU2AWW0Pb1OocExAkbwy4gAYBF46YCY3JNoRfaGEEqhnwuz/NQ1kHSq095X/6v+ZvtZI9/+Ku4kX5isa2iDw8ZM6hM+zJ1HSXD9QfWDzOLfGZrKpHUyv5vWnC6m6BIrEzTpZwXxd5O3nuo71qXw5gRUvR1t8l+Gj147w8FWxgwWUeU5m/7pv6m0oWugT9rqkbaILEhxPT7gJuZt/Nvn+nJMnzrKs9K5KtlD0ilqIDPJ9XfyegGpogMN4a43dWiA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR02MB9529.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(396003)(376002)(136003)(39850400004)(346002)(451199018)(31696002)(38100700002)(478600001)(36756003)(2906002)(6636002)(54906003)(110136005)(6486002)(966005)(41300700001)(26005)(8936002)(5660300002)(66946007)(316002)(8676002)(4326008)(4744005)(66556008)(66476007)(6512007)(186003)(6506007)(53546011)(2616005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHo5UGxPVTN3RDU1MWJqbGNaengrN0RDd2dVT3ZnRnJSZUFjMzMwWGdNT3Vu?=
 =?utf-8?B?dGRiQ0lvVUc2Wk9rUFVTSkFYbHVuT1hXcEFNQWkvaGM0VkJmWXlFYm9MbVQx?=
 =?utf-8?B?bE5MQmhBS1VWb20zaVY2bjQ3UHR3cFp2clVoc2hBdjd6MlRhczVmNXhGelFa?=
 =?utf-8?B?cm1odGV3UXprYTBxUDlzZFJDODFRZjRXd0NXOThzZFZBMVRLTmhmOVRRbC9v?=
 =?utf-8?B?ZmxTcFN1NC96SUcyV1NSR1dVV1k4TTFoMHVDMVBraTlYMU5lK1FHcUYxZ2pv?=
 =?utf-8?B?M25FOWlDMjYxcTRjbU9ZZXRqQTBPWWo2RHpSOVBiWmREY3BHYTJnSU9BOVdX?=
 =?utf-8?B?Mzgra3NHeFJ6eC84eU55OGh5TVgxemRna2JoZTVyL3I4NG54QThuNDloUXF2?=
 =?utf-8?B?Sm9XWmtLakJwRHJwbDZ1UXBuLzhINEtYVU5md0YyUDQ0NGlWSUF3dTlzSmh5?=
 =?utf-8?B?WUZiK0FxVkVuRFIzczUxb1dsNmp6bmR0NlhxYlJPZnNuMmNJSjJSdFBUdElz?=
 =?utf-8?B?bGhWcU40QS90NE42amR2OVJKVE5jSE1JSEw0enlmRDdjdUQ0SFMzL2MySFhz?=
 =?utf-8?B?aWZRSk8xN3VIQno3S0pIYmtuUlQyYzA1R2VuTGh4QVNtRk92QUx0YnVyOEIw?=
 =?utf-8?B?NHRqa3RScGJXSGVTb1Zib0o4UUJpT2dVcDU4NDNjZkg1ekRFOEU3Yk1qclJl?=
 =?utf-8?B?NHM5T1JGMDhVYkdnMm9rN25QRnVXMnVMQ1YybE54OURyYjFDK2xCV1NxQmIy?=
 =?utf-8?B?TERKbDc5UVFxOUNPdWY4RXhLSFVYY2lRNWxHLzJFVDdzeFRDM0E0U3V2OHdS?=
 =?utf-8?B?cUhGdkxlSytLWEZRLzNyRlRzeW9zU3BGQ2p6K2lYVE9SejlsSkRzbjlNN3py?=
 =?utf-8?B?aFBDMWE1OHdTaFM2QXZMcW1uUzFoKzVSK1VCVVJRYkh2ZFZwUHQrUjhNNDNH?=
 =?utf-8?B?MWJvNHYyNVNKV3JuQnVPVTJPUTdmbGFkLzJqRkUwa0dKNlBlWHFaY0M1V3do?=
 =?utf-8?B?VkxNNjFXUXkxUVI5djdwSXZKOU9sVSsrb2huVDNPTnBXaEVLK1dOaHViQkRE?=
 =?utf-8?B?YTRUaGZybnVoWUp0ek9XUHpnb3cwcU5XUnAvVWg4R2hmZWpWUTVDNGdHNktF?=
 =?utf-8?B?SmFsMGpDQnMxd2RRMXZmdUZQREliaGhkNi81WkY5Wlg3b0pQYmdMb0dnNWNu?=
 =?utf-8?B?YTM1eC9PSUlnQWx1blF6ZlNZTm00VHlVRnNONnIyZGVZRnRWRTNUUzlROE9k?=
 =?utf-8?B?RGdwR1ROQkRGbTRGb1UrbHhobXpQZUNYNDFpanByTHZzWjRodmVKb2VHaE1k?=
 =?utf-8?B?ZDBMSW9uNjR6dlN1dFNBR1hDaGJPRFhmM2VyQmsxWG8xWlpZV003Nmx2TmZl?=
 =?utf-8?B?K1d6YnhyaWN5dVR3QS8wSVYrcnlTT3l1ZzBzR3NDTU1pWFZ2OTg4aXQ4eUg3?=
 =?utf-8?B?aEM1SUhFNllDZWV5Y2hHTlNYMnpoUXJyakMxdDZyNDJoZnI2WGVRTEtaaTJD?=
 =?utf-8?B?MzZpRHdScDFMM0RNT0djTXR6ajRUZlhjMzR2ait0amN5RTBTUm1nWFZyVm1I?=
 =?utf-8?B?NEpMV2dhSis0RmJTSlZVUTFjYjFnWTVCYjFMQkFzaUE1Q0JLY0YrYWVTTlZN?=
 =?utf-8?B?cE9vdjVFRjBOYVdnRGdTMDU0dDZRSkRkSjFFektoMTM2LzN5VUFqclQyTllV?=
 =?utf-8?B?Q2RaeWdFN3NHR2lhTFlyRnpVSWRjK3lqVFZqcVZRK3duajU5bVg0U29ta3lN?=
 =?utf-8?B?amhkOVh0NUhROXJCNU9ZMmZyOVc1YWtUbnlORk1JTVNZVUhkUkdlaVpVTXZT?=
 =?utf-8?B?KzhRVW5MZDgvM25sZ0FBTnE2VjVwRFVHR1ZXZFQxdy9ldWFDa3FrNCtwMEQ4?=
 =?utf-8?B?aHZaZE93UlhpdkpKT1drWUd1aXlZeWJIOXY4WDdIY2NPS2VhbVdJZlhkVHMr?=
 =?utf-8?B?U2RhR0djOTVJUEh3aVlVN09peldkVDN1dHl5a0w4TTlOTE5WTDlxT3prWFdV?=
 =?utf-8?B?K3UycTZxaVNQbGYvQ0k3MmFqS25aVnI3K2RvREtCM25uc0J5SXI3UnZta3JU?=
 =?utf-8?B?eGxIN1M2VmxRRURrV2JhMzM4TGNtTUpITGpWZmp2OCtVQzVqZEZmYkVVRFBt?=
 =?utf-8?Q?3k6cSI8yZ3zl6NzQ7DTGegttH?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f99bf48-3115-47d9-2d28-08db02cb1655
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB9529.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 14:05:48.0761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LExyJgFY9LHHEyvQ69R34Ru35TWoHjNgJs1kGQG7G8dJx0C836ov+Y/R9kro3oidn6L6KL5NyNAlXhDclACHzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR02MB6456
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


On 1/30/23 13:40, Andy Shevchenko wrote:
> On Mon, Jan 30, 2023 at 02:39:12PM +0200, Andy Shevchenko wrote:
>> On Mon, Jan 30, 2023 at 10:37:42AM +0100, Mårten Lindahl wrote:
> ...
>
>>> Fixes: e21b5b1f2 ("iio: light: vcnl4000: Preserve conf bits when toggle power")
> Actually one more, please provide a proper Fixes tag.
>
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes
>
> It's explained there.
>
Hi Andy! Sorry, I'll fix those.

Kind regards

Mårten

