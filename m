Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C04A66E46E
	for <lists+linux-iio@lfdr.de>; Tue, 17 Jan 2023 18:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbjAQRHn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Jan 2023 12:07:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233880AbjAQRHk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Jan 2023 12:07:40 -0500
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA296442CB
        for <linux-iio@vger.kernel.org>; Tue, 17 Jan 2023 09:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1673975259;
  x=1705511259;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=U6rO+8PqfalhAtnMHbxX12eYOQMoU5in63sQLqX+msM=;
  b=B8bSIXEnBbrtyL2249Sqx2G/n4VI0N0Op4oa/b5RcyFQndbgbv1b/i7V
   JglckCtZf2TlWQWhkjqUttW59dglb5zr2cgMtJxDE+b85doyURLNmDmqk
   Xrh/0PISvrfRqA/uU0q9SO7rWDhB1F+QxSUCPpz2npj4qnLc5NG9zGKtZ
   N1vw5IH5WNBOJLLQnBB0HG9MApud0gQAKruPEznLN7/nrdPIqHR2gTxt2
   KScZrMaTsyQ+8NdBFfViG7yOio6fFzlxfZfiKW+ilA3cAdIRlQiHjmg8F
   djbYfYQJ6FvxhuHD225SY0Ic1o8hwYra8RuJeILWuP6mEQPHe5Vw8PO/H
   Q==;
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g1K+KCPiqEuWNJ9XsoXOdDh2sORYUI6/J3Weur1Wd69gAfl7rKtIEXBsnhIlarc1gMgDdM4JGMdCS9tLxsPJCNj6j5x0j55VErE7Plwb1m6lEj3nPibTgk3gOxYWpbAkMcKEJ6IVYjUHwAM30VcQJ1CTc453cvP9hXXYrJ4Iv+eN9EBuPdWYjwelseeOIZIYGFyLWR0cYicz3TZPxTz1101QUQrcD7cl1Fr+utroPmiY+mS7MFk5ymUoKw4RTqx+91irnjxSh7FYuQ93UeqonZe1j/9WzsmoTFOibhrv4nN1bHTUPWw09OcGfSCI03lv2PYM/eM0nD/9pgu5zYEOEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U6rO+8PqfalhAtnMHbxX12eYOQMoU5in63sQLqX+msM=;
 b=mxbaLiE8Ey7FToHoUu3pKckM3Bg6QjR7wQSujAucifOAtQ7Ov2xf/OzBPWxsThm7sFbREFvHuct+TguJNtxp4+IWKghPfp9DSstFjH1L/Y7YmfjRENpYR/hTkWKwuoA1DuaDHT7YdVgU7bFoJhfzKqolQOzMouWBGCX3UzuKS7iDTPHHzXsnNs4ASyilqZ0gi9LcICTi2W0D2VtX+aypTDZOzf6TaD6QRQufiVklfv4bKZ9W8rI28GZSPxtZ8L4LMThLF+Fl0FT7cdY8qQ1Aw85WawwDEJej97PeJvk7cdJURbqlQRehCB3qef5Gn6f7zZCjcXpTu3T12cekY3zPRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axis365.onmicrosoft.com; s=selector2-axis365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U6rO+8PqfalhAtnMHbxX12eYOQMoU5in63sQLqX+msM=;
 b=KIZQGdHRoYiLKYuuy4/mAjhruoZIWoNyTzRU1nzVGrTx2uYEFm7vAbh2af3IBOwKC1kZRlkJftQJBLgpwX/MeaSVIy7yKohvQ9oGtR7AHVY1fg7Fg0X5t76mGJLQfChoCqMhAgejUnU/VovqgBESqw/zDWonJxHSTS7GFpv31Y0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Message-ID: <1a4c8717-8b79-c102-6c2e-01233e0e8eb4@axis.com>
Date:   Tue, 17 Jan 2023 18:07:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v4 1/3] iio: light: vcnl4000: Prepare for more generic
 setup
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?Q?M=c3=a5rten_Lindahl?= <marten.lindahl@axis.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        <linux-iio@vger.kernel.org>, <kernel@axis.com>
References: <20230117152435.3510319-1-marten.lindahl@axis.com>
 <20230117152435.3510319-2-marten.lindahl@axis.com>
 <Y8bEGIj1JAjyaEg6@smile.fi.intel.com>
From:   Marten Lindahl <martenli@axis.com>
In-Reply-To: <Y8bEGIj1JAjyaEg6@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV3P280CA0007.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:b::10) To AS8PR02MB9529.eurprd02.prod.outlook.com
 (2603:10a6:20b:5a5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB9529:EE_|VI1PR02MB6335:EE_
X-MS-Office365-Filtering-Correlation-Id: 9236ad7a-9028-46ec-fd57-08daf8ad53c5
X-LD-Processed: 78703d3c-b907-432f-b066-88f7af9ca3af,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JFaoSkDrof2RXexJjQyUCdFSkKLrElJpPv9BNx+AYBsHzO37oRa93XPhrzaU06ufF1F0hkW2g9P3BJUcotRZeLhl5kho6/FWHhskcm6XJReyP4sVs7qpLFRuMCoSsV/UQWMAxmo6XL2Wo3RhQ9jmom9/vU3j5bR5naT7pPEyb4ovPvyf2uWimrMe5d6SH2dwhzHGVMJcdhMqkTu+V6kZEEd2q9glacOYA4jXoUnjKorzj2V84lMMGMarjPTMijhQs9YYDivz0VovbAYDjGA0QPzz9xJQ+RqEth3vGzr5lgw2DoIjxSULV3GxTOmEOQ2AyFtXxKS9Bq8ubsDE1ZornfprHmkg2xcZdE3A1tS0qRiTsFIIvrSBOu3vnTtx94HvgXVQMSnt2/eomG/m4yjLlKbpzjlTIhW9WTDfelOeD9daE9fbPCKZiQo341AmBHbtIOP7LO+Dpbjd4DBMP2Qb5ZtsuINoqrg0goEyCBZbl5ltiK/9PqbDS6V63iVv16KGEkVOrfdE5wHRwsiFE3sx5gKGu5YiOoUKT4z+jqBK3HkMGm9uOAggGjFXPXGLz3r0U5lxYIujl3uUutYgn9hnunOHBo4oWeEeFB17pwzqJKTp/1RrMuvFr5coc6Yyu5q3H79dDOenGMzkIbmF1LoGojpmqtCvyX+1fZ3/vmI3ejR6QFio5PAl3xdjU6d+8rYnST+1uyN6hcm+RaZnf6kf18SVXLK2BorXITGpKbtExEmg/gQceOePpLVPIcvGXqh+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR02MB9529.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(396003)(346002)(39850400004)(136003)(451199015)(83380400001)(38100700002)(31696002)(8676002)(4326008)(8936002)(4744005)(2906002)(66946007)(5660300002)(66556008)(66476007)(6486002)(66574015)(41300700001)(107886003)(6506007)(2616005)(186003)(53546011)(6512007)(6666004)(54906003)(110136005)(6636002)(316002)(478600001)(31686004)(36756003)(41533002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjlKTzFMeFR1Y3lWZTBNUStpK0JwR3hGNDl2eUdwY3hkKzRDajJZemwxNzBz?=
 =?utf-8?B?RGtGZ0NmQ3RicFU4VnAxdFN0SFJDWXZIeFEwQkEvaHlOWEQ0YkJzbU9kZW1E?=
 =?utf-8?B?MGxYYXArZ3g5SzZNOFNJcFJFWDJreEY3MytaejdjQ29GZm5COXFvL3JLVjRK?=
 =?utf-8?B?L3hLQ1JGUEltWkZxMC8wSHV1UVg0TzZ0T3k2ZVR4RXBrZ2d2QW9EVEs2OHRq?=
 =?utf-8?B?L1QzNlpMVDM2ZnIveDlMUjVhcTUxYmppK3RjUFEzQVprWlFyODI1OXNaMkRT?=
 =?utf-8?B?VHZYTUlSQWJzVmZjY25kcG9EZm55UFlzV2FLellZV0Q2U0E0cnBESVIyRUR0?=
 =?utf-8?B?bWVzbmpGQXFNUm90MWIrL1MrYkFrdC9BU3M1LzlOOStqZTA4bjFaUFV6Z2VV?=
 =?utf-8?B?SHdVenRMQmsrSnIxY0VZSlZtZ0ZBYkJ2UWw1Nng4a0dud1hzSDM3aTBuR2x2?=
 =?utf-8?B?a0pkNnI2MVZxT0xQQ0lTT2p5aWpmRzRXVVhOZERwc29ZM0VPQmpKQTIwTWNY?=
 =?utf-8?B?ZUdDVFRDazJoQzhnbWFLeFNYTnVaT0JrSDhLU0hOeE45R2RsUmxyL29MWVQw?=
 =?utf-8?B?VUJpYlh5YWk5eDZGYUU1dHZWTUg5TW9nRkYxVFR6UGQyQ0s3dGRWZkcxM1Rm?=
 =?utf-8?B?YnU4Q2tkT2dKbzJpYnAvR3pnYVFKUnhSTlljb0djUTYvOTJUVEs3cGJwc3ds?=
 =?utf-8?B?OTFkYVl0RUdMMmFPRDBuM0ZTUHJnTkZhRHltTGxRWE1vWDlkMENrM0V0S0FG?=
 =?utf-8?B?aSt3eGVPZXYzVzlHcUJKT0pId2NyQS9UZ2tSMm5JWmt0RExRdXVkb1JhWHl3?=
 =?utf-8?B?TlF6WlpNTTdDVUwwUGI4SU9XaTJZL21GSjZpMHJDSXE5YW45V1NXZHBsWnNk?=
 =?utf-8?B?bllCNDdRNDhYSkM0NlNTT05FOUxzL0VvbjcxUGpYRXlFZjViNGJVa2o1VXU0?=
 =?utf-8?B?RVV3Q2hLZldvQWdCU2l3QWFKdXlxYTRPbUN2eHZZRi9SM0FIUTFPYS9BT0lH?=
 =?utf-8?B?b0ExclVic01NbEplQVVwOEpSMm1KVS9LOXAycCtmZ2FVQ05peGluSk9HTkZq?=
 =?utf-8?B?K2VOMGE4TTA1Wkd0cUhjUnREbDd4bEJoaDN1d2E3clVCSWRjblB3a3ZsT09i?=
 =?utf-8?B?a3llbDZJSFBza2dBRHNoZlIvREY5Y25IY21jcGRVVHFvdjN3VUNoUitIUUhz?=
 =?utf-8?B?U1Z2cGlOSUh0cys3WFhBaDZpK1Nxa2xzZERFVFJuQytvd0hWZHZWbWttMkdI?=
 =?utf-8?B?WTZpYi9uZjhiR1gzbDZZdDZZTHJrbndJVUc3ejlxdnVYL3pGYm1jYXZENi8r?=
 =?utf-8?B?b2hGa29rU0svWmVSZjlkVGZDNDc3ZnRhd2trVWh6QlJwWkFHUktaRjNGTjM5?=
 =?utf-8?B?ZSs1alBNRlpuOHRCeDlKS3dwZEdYTEpOc2dNcmhhdnpYL0UyMXNjSUJvMGhx?=
 =?utf-8?B?WDB5WTlIWUQ2NHBoQmNYaXZmWDJMKzR2OEs3dVliTFBJcEFNZXlqWnZtc1o1?=
 =?utf-8?B?Q0drcXJWSVNXZjYrdENQY3VKeTFKZm5CMnRNa1ltMkNKNERLWWF0bkorV1Ja?=
 =?utf-8?B?cWNjMUNoaVdNeXF2ZVNBTjFRZ05yQ0tRYzNOM0hTYzcyM1Q4UjJyclFYMUdq?=
 =?utf-8?B?OHJIeWVMQ1YwS1V2K0VZTC9la3NVNjBValB5VUFoc2gyRkxWOWN5eW1wdWVY?=
 =?utf-8?B?QU9XanUwNFBXVWlkdS9HaFl4d3FQWnFzeG1SWHpOUk0ycTdpa0V3aEJRMWdH?=
 =?utf-8?B?d1UyeXRFeTR4ZVNCd3lrZkl4bXdHMVVsZ1M1L0FPTDhhUVQzc0tzNVdZT2w3?=
 =?utf-8?B?VjQvOWp0YzNGekMxQmt2L0pVbjlTdUMycnphdUN1T2FTZXd2cGxUTzl5MXV6?=
 =?utf-8?B?M0NGMDA3TnF5WWJESFBZdHFHQUY5ZVVZYzZBcFliR08wWlpHeW4zZE5nc0pa?=
 =?utf-8?B?emEzejJhMFhPWjRaVjBpNHNlSmpFQnBienBQUUV4WGExM2ptcXpCZ0liY21N?=
 =?utf-8?B?b0VJMUlDL2FuOHVFbCtML2FGSjZGY2g3OGRmc241RTdoUSs1VnNSSmQyOUpX?=
 =?utf-8?B?eTJnemhKeTErNk5Pd2YxMXh0aFVLWUJwZzRuWWhkZWpHaGFkRk5BSTJMZ0hU?=
 =?utf-8?B?dkNqRWhycnVyNG5XZ2RIcVZuUnpIa043VVBBVUZDTzJRaUN4MWdXYkFEanZX?=
 =?utf-8?Q?szpWwn1nTZPKUXlFJZVKaTj9buQ6DjbwgPhr8b2Uhhx2?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9236ad7a-9028-46ec-fd57-08daf8ad53c5
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB9529.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 17:07:34.6267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VUnON1aOd8qH8WdQGokXqA54ky+h/qTJ6ZsrZ0C3q9CaG05GuWbll4ERixu1PvkjO85XS4TUxPj7UFeMFWM+0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB6335
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


On 1/17/23 16:51, Andy Shevchenko wrote:
> On Tue, Jan 17, 2023 at 04:24:33PM +0100, Mårten Lindahl wrote:
>> In order to allow the chip_spec array reference the function pointers
>> for interrupts, the code for these functions need to be moved above the
>> chip_spec array.
>>
>> This is a prestep to support a more generic setup of interrupts.
> ...
>
>> +	u16 buffer[8] __aligned(8) = {0}; /* 1x16-bit + naturally aligned ts */
> I understand that this just a code move without a single change, but
> I have to ask. Don't we use the specific struct layout for this?
>
> Also, 0 is redundant.
>
> P.S. Maybe considered as a followup change(s).
>
Hi Andy! I see your point. But yes, as it's not directly part of my 
change I'd prefer to handle it separately from this patch series.

Kind regards

Mårten


