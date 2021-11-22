Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5087458787
	for <lists+linux-iio@lfdr.de>; Mon, 22 Nov 2021 01:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbhKVA45 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 21 Nov 2021 19:56:57 -0500
Received: from mail-eopbgr80105.outbound.protection.outlook.com ([40.107.8.105]:48929
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229884AbhKVA45 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 21 Nov 2021 19:56:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kXdAVHEsSXAmWmvz5qi2+W2I+gsrAqC8WxT2e7RaGso/wqMOtU176NuvmfwmMplJPZYKXtYB3T2mVFKlK9Xrtj8ZD+jkzas1G4cTF//vqt7v8vKktmetj6SN6MNKohRZur9gkIjrAe0nIr1SCn3Xcg7It9BMvgcYXApAstb8pct25AyF7DEuyZLQDdMrrucJI+kLn0LRG6/UEre22b8tqoWzpaUAyrGhTUtGL0N6BjZ5NS15oTW+XToq7siCLDfsDc2nnia6zc4YIkWMnTzyV3KYwusPe1Zd+b8w9IFc5St37xWolT3om4IwHRLwWFR5QGvxghw+kJBcwAduKsPvfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=va6qwlXEjmgyr3maiqaaZOQFi2xlZo8kIJTZFr4PmwQ=;
 b=KD0MxNLgNjo3GBw0olwB/FX6r0wxOH2eL6oa3NyT0lDM4gDNVFYUaFQsJlEW6Ak7LyHZ0dEvUS5/84hpxBj0zw2VI5Wzyt53FXaL6zGFbxnFYpzNQ8xgDKKwWfu3mOnE/VCFzx7TmeZNRYesiPqrNw+6e/l4vassx/vFSRU2F+tISFIFN8BodD/BUPw5E0kXuFsGxKB8sjpJmWv97SkDofKvR8NRgRiTAkT0lHn3jDoWZrwJHg7sNa0wTIcuvxIOdJNHFYbcRTybYp3TAUYwIKzzUyh35xsF4E5saYyCmtvCX9gWId0K0VywHUIf7g27I+3uvibGArqGH/QiP511Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=va6qwlXEjmgyr3maiqaaZOQFi2xlZo8kIJTZFr4PmwQ=;
 b=ZabvuH+EHcA0S7TrBC2TjUjhnbpdHhlfCf6X+fFDw4Gj/QWfKxyXdtOPbrKv6sAXBEv5MQFrBjAvIqjfFlyDwTrZHLqRhcPup+RhRgJhX2z5osVvSVDAjwZz6P9YH2mT174N2w7LHMj25wzgFZIrEPxBM/dLm98C+kXX3Znhpu8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB3PR0202MB3403.eurprd02.prod.outlook.com (2603:10a6:8:e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Mon, 22 Nov
 2021 00:53:47 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::7519:c72c:98b1:a39]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::7519:c72c:98b1:a39%4]) with mapi id 15.20.4713.024; Mon, 22 Nov 2021
 00:53:46 +0000
Message-ID: <156bc2fa-6754-2350-4a12-ff25b23ae8a2@axentia.se>
Date:   Mon, 22 Nov 2021 01:53:44 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v9 00/14] iio: afe: add temperature rescaling support
Content-Language: en-US
To:     Liam Beguin <liambeguin@gmail.com>, jic23@kernel.org,
        lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
References: <20211115034334.1713050-1-liambeguin@gmail.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
In-Reply-To: <20211115034334.1713050-1-liambeguin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0046.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:9::17) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
Received: from [192.168.13.3] (185.178.140.238) by GV3P280CA0046.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:9::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend Transport; Mon, 22 Nov 2021 00:53:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40314aa6-08ab-4ef0-2707-08d9ad528a24
X-MS-TrafficTypeDiagnostic: DB3PR0202MB3403:
X-Microsoft-Antispam-PRVS: <DB3PR0202MB34032C6294EE34CE43D2E984BC9F9@DB3PR0202MB3403.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /BceWaA6YucUXrG+fUgPGCxxKPJiRZYCHyWJA0zpj+vrBv1qNAYyz9bBTuoCPBI7l+y1itQJjNcayUqfdTF1WDD4+8PRBItike/AcBc3vItrDt2pBzumh1x6CaE1fTUw55EvDuT5rQMwdiEB4hTpOUg6jfTUZ5P201UirquWTAMNNZWfjbmOHtxWDgQFR1ubVkoGBp7BULoAOFGvCenOEa36VDz/rMEKqhRzmEErCD9vK4T8bH2FA84vnmdVjpyUaxLivQLs3ekrzWPwgVaT3DHYmv7PnzppkDyxCBNOZU40LVS+pYQr6kF/HeIVRr1BNJ4JW8wLVyC4m1pXZMErDmE8JHacSoK25jX8djlNlBg5s0uOw5dckYvfKDz2kP8VGayanRPJeTlOL0GYvW0rUjSh8obUKa0WEp5GjrUgRepQncvjvlJmCSvzZ6vAn0d4SuX3YvD306Wyeft3f5MCM9OvlD0CAI8orKxYw6/AaYbhG7WWc6D6fK7h9Gcj/xrIHB4TKi9F9RDmrOKVbq+aQlnnuiOnVs40KMJ0Rxo7Jwp7MaLvpwydKYNU4uiqpF5nYtE3bw+pdM3P46O8+UgSh5hw/po/UDVVcM33Pw0UcP8J6y9IxjAIkH9B54Y+ePoRtqUfMJR9cOWIkQMi/qMW19BvTFtblIE9aMYvtriiP9tgaiJTEXUlDgzEwemj0mKkzORA6Ch8IES7cxrf6qw19He3A48RDBbhO8v0U22jKEM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(366004)(39830400003)(376002)(346002)(8676002)(316002)(4326008)(66476007)(38100700002)(83380400001)(186003)(26005)(956004)(16576012)(66946007)(2616005)(66556008)(5660300002)(8936002)(4001150100001)(36916002)(2906002)(86362001)(31696002)(31686004)(508600001)(53546011)(36756003)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0ZVZ2hOdVJMT1draDVNSmRIa3kwVzNGUjhwRUg2dG9hRFJkOTF4ODNYaW1i?=
 =?utf-8?B?QVpVYjhqNjZOWGlmem5zeDRSUUhtTFc4MmZoaVRlUjQvRkk4NnJwRWpVT0VT?=
 =?utf-8?B?OHNkb0dYeWNKUTQ0N1FqWGxrdFJuTWJ1VkFKakN4RkdVMC8xTmZDeUdGYzZy?=
 =?utf-8?B?ZWEwUUZYd0UvNWdBK3ZMbnRKVmlFaGdma0E3YlNLSDlEdTZQdHc4dWwrNUM4?=
 =?utf-8?B?NUNaMXhGc3V5T3QwVXNFeEFxVzFPN3A1NmJSd25DL29IeG01eVBMQzNpaFdO?=
 =?utf-8?B?RU42cXpQTkExMzBENFJ5ODQxK0FFSUFYb0RMNTN1WTR4c01NSVVKY2lZL1Bu?=
 =?utf-8?B?anBNdGluVWx4V2JkSHIvVnNSTXZHVFRkVExQMTVLYzFMU21RRzZJM1ZmV1E2?=
 =?utf-8?B?ZnM5TmhoOExzK3BjS0VDV0tEWEJqQVVydXlENU5uRnc2V1RQaDFVaEg5Qy93?=
 =?utf-8?B?N1ozU3JhakRienN1N0JKdXEyVGprS3VLbzVjOStoZjYyN1VwelQ4blF0bGIw?=
 =?utf-8?B?R2VwZVNJT3czZGM5WDIzYUlzWHdFVkl6NWdidytNakl2WmtjV2EwKzc1VE5N?=
 =?utf-8?B?cEZUNU45UnBjR2JUUWM5Y3NDb3p1ZXhIMXFwVlU5akVwK0ZJa2h6S0FLdFp4?=
 =?utf-8?B?UTZwMG1MbFVDbFZBN3ZEMk02ekNTdmZmb3huSEY5akRvc0NvR01FZTJzRHpq?=
 =?utf-8?B?SCsrVUJjMGFFZ2ZWcEc3dE5hR1g4U3EvOFJWMlBiVDR0ZHlrNDNkOVFwTmQw?=
 =?utf-8?B?aDVuY0QyMjQ3bGIxVHJBMmdZQTFpWXhpT29lMDRvcEtQOXQzOVhmYUt4eSs4?=
 =?utf-8?B?YnBlaFZLQnpEdEs1dldFbk1rdFFXNzR3OFFJbHZqcy91dDRDSFQ5cXpLVUZs?=
 =?utf-8?B?YytYVm10OTd2bkcyS1puekw0UFBlUkZVcUpBZzRIdElGY0hNdTBnWnNiYzk3?=
 =?utf-8?B?eEFXKzFoQ3Rqa0k2b1pEVmJsSUhjNWNIMWJ1d1d1bGZRMFlPb0ppcS9scEg5?=
 =?utf-8?B?VEhxa0VLU0FZOFZ2L1d5dkd1TitkN0h6UUFMcitVbmdpanJ5QXl5Y1pDREE4?=
 =?utf-8?B?N1EwMGQ4RkZiRXVJUmYxbHlBN2dDREZFQlBVNC9VNHZ0TERRQ0xYcUxRdWM1?=
 =?utf-8?B?V0kveTFqZ2h5M2hLUWtJVytjUkQrb01WMHNmV0d3YXNoTG1lK0VndkxBdEJt?=
 =?utf-8?B?YU5OOWpkU29HQmYvUFlrTnZuLyt3NmlFdC90N28vVnR3QVhVYXNYc21Mb2d1?=
 =?utf-8?B?WTlaT1dqWVFMMVdtZEJaZXEyUXkvWEE4bXlLMzdGc25lWmRhV2xPaXJIdkhh?=
 =?utf-8?B?Z0VTQ1UwNHZwajV6cFFPcHJvWTY1c09jZmNDSW53eE9XSy9DQXA1YTAzMXRh?=
 =?utf-8?B?M1JKbHg1eEdORUgzVW54UGJWaVZpMG0yVkhMeGJqNEl4cUxITExVM0RTekRW?=
 =?utf-8?B?cFh2M2c3R0Ftd3pycW5RbFlNUTJOSkZpYldVZDdCSm5vemNMRmsxUjZDeUxk?=
 =?utf-8?B?cmVaenZlV0hEY0V4ZWtBWGQxc1JQVlQ0UENGSllmZEZ0dmhBMEg2clYvSXow?=
 =?utf-8?B?Z0U5TkVoRWM2UXlGLzN2ZkVycVY1UUNEZjhZR0RiME0rRkZIZERzbXR4KytB?=
 =?utf-8?B?THpHRjNQNnJKRXRiVXpybEZuWVRqd05ucW5Sb01kUGRzVFJIQ0NrUC9VcmpF?=
 =?utf-8?B?M0pLKzdkWkpYdG5zWGhudU1QSEJqYm9tcjVRVGlRZ2tWYTZmckI5T1d3WHdT?=
 =?utf-8?B?Q3J0eHN0akw4MUFuU0tEMGY5Rk9rTkYweVl2VC9ML093WUhHRUNWSENqbTRH?=
 =?utf-8?B?ellOempwVnFSajJHSnNjUjhXUHpRU0lYN2piUGZoTDRBZ0RJdzBPVnplTEZT?=
 =?utf-8?B?cnJyK1VZMVFQSmF4V3loQ3orSnBHbGNCTE5STFV0eXJxM2ovSGdZbEhQTGJK?=
 =?utf-8?B?clBzS25DaXQzMHBSWS9POWE2NHFiMFBPTUZMd3YxTTlrK1lXTXJLRHBGblI3?=
 =?utf-8?B?SS8xWDZFckw0MHpRQjdNNXVpdldMaGdxb3RrekJ3VEhGa20wWlM4T2N3MGxX?=
 =?utf-8?B?aVVvZmRxbjlhcitaenlhRmd4NWVISUF3bG1rUkhkR3NqR1BaYTB2QW9neHox?=
 =?utf-8?Q?PtuM=3D?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 40314aa6-08ab-4ef0-2707-08d9ad528a24
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2021 00:53:46.8323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6bvZZFnLdKLcxUQsOStrSU6JZV/0gVtP97+FY60xaY/90JTj/N46fM3eBUdeZxzo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0202MB3403
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Liam!

On 2021-11-15 04:43, Liam Beguin wrote:
> Hi Jonathan, Peter,
> 
> Apologies for not getting back to you sooner. I got caught up on other
> work and wasn't able to dedicate time to this earlier. Hopefully, this
> time around, I'll be able to get this to the finish line :-)
> 
> I left out IIO_VAL_INT overflows for now, so that I can focus on getting
> the rest of these changes pulled in, but I don't mind adding a patch for
> that later on.
> 
> This series focuses on adding temperature rescaling support to the IIO
> Analog Front End (AFE) driver.
> 
> The first few patches address minor bugs in IIO inkernel functions, and
> prepare the AFE driver for the additional features.
> 
> The main changes to the AFE driver include an initial Kunit test suite,
> support for IIO_VAL_INT_PLUS_{NANO,MICRO} scales, and support for RTDs
> and temperature transducer sensors.
> 
> Thanks for your time,

And thanks for yours!

> Liam
> 
> Changes since v8:
> - reword comment
> - fix erroneous 64-bit division
> - optimize and use 32-bit divisions when values are know to not overflow
> - keep IIO_VAL_FRACTIONAL scale when possible, if not default to fixed
>   point

This is not what is going on. Patch 9/14 will convert all fractional
scales to fixed point. But I would really like if you in the "reduce
risk of integer overflow" patch (8/14) would hold true to the above
and keep the fractional scale when possible and only fall back to
the less precise fractional-log case if any of the multiplications
needed for an exact fractional scale causes overflow.

The v8 discussion concluded that this was a valid approach, right?

I know you also said that the core exposes the scale with nano
precision in sysfs anyway, but that is not true for in-kernel
consumers. They have an easier time reading the "real" scale value
compared to going via the string representation of fixed point
returned from iio_format_value. At least the rescaler itself does so,
which means that chaining rescalers might suffer needless accuracy
degradation.

So, please add the overflow fallback thingy right away, it would make
me feel much better.

> - add test cases
> - use nano precision in test cases
> - simplify offset calculation in rtd_props()
> 
> Changes since v7:
> - drop gcd() logic in rescale_process_scale()
> - use div_s64() instead of do_div() for signed 64-bit divisions
> - combine IIO_VAL_FRACTIONAL and IIO_VAL_FRACTIONAL_LOG2 scale cases
> - switch to INT_PLUS_NANO when accuracy is lost with FRACTIONAL scales
> - rework test logic to allow for small relative error
> - rename test variables to align error output messages
> 
> Changes since v6:
> - rework IIO_VAL_INT_PLUS_{NANO,MICRO} based on Peter's suggestion
> - combine IIO_VAL_INT_PLUS_{NANO,MICRO} cases
> - add test cases for negative IIO_VAL_INT_PLUS_{NANO,MICRO} corner cases
> - force use of positive integers with gcd()
> - reduce risk of integer overflow in IIO_VAL_FRACTIONAL_LOG2
> - fix duplicate symbol build error
> - apply Reviewed-by
> 
> Changes since v5:
> - add include/linux/iio/afe/rescale.h
> - expose functions use to process scale and offset
> - add basic iio-rescale kunit test cases
> - fix integer overflow case
> - improve precision for IIO_VAL_FRACTIONAL_LOG2
> 
> Changes since v4:
> - only use gcd() when necessary in overflow mitigation
> - fix INT_PLUS_{MICRO,NANO} support
> - apply Reviewed-by
> - fix temperature-transducer bindings
> 
> Changes since v3:
> - drop unnecessary fallthrough statements
> - drop redundant local variables in some calculations
> - fix s64 divisions on 32bit platforms by using do_div
> - add comment describing iio-rescaler offset calculation
> - drop unnecessary MAINTAINERS entry
> 
> Changes since v2:
> - don't break implicit offset truncations
> - make a best effort to get a valid value for fractional types
> - drop return value change in iio_convert_raw_to_processed_unlocked()
> - don't rely on processed value for offset calculation
> - add INT_PLUS_{MICRO,NANO} support in iio-rescale
> - revert generic implementation in favor of temperature-sense-rtd and
>   temperature-transducer
> - add separate section to MAINTAINERS file
> 
> Changes since v1:
> - rebase on latest iio `testing` branch
> - also apply consumer scale on integer channel scale types
> - don't break implicit truncation in processed channel offset
>   calculation
> - drop temperature AFE flavors in favor of a simpler generic
>   implementation
> 
> Liam Beguin (14):
>   iio: inkern: apply consumer scale on IIO_VAL_INT cases
>   iio: inkern: apply consumer scale when no channel scale is available
>   iio: inkern: make a best effort on offset calculation
>   iio: afe: rescale: expose scale processing function
>   iio: afe: rescale: add INT_PLUS_{MICRO,NANO} support
>   iio: afe: rescale: add offset support
>   iio: afe: rescale: use s64 for temporary scale calculations
>   iio: afe: rescale: reduce risk of integer overflow
>   iio: afe: rescale: fix accuracy for small fractional scales

Can you please swap the order of these two patches? (i.e. "reduce
risk..." and "fix accuracy...")

Basically, I think the accuracy of the IIO_VAL_FRACTIONAL_LOG2
case should be improved before the IIO_VAL_FRACTIONAL case is
joined with it. I.e. swap the order of 8/14 and 9/14 (or almost,
you need to also move the addition of the
scale_type == IIO_VAL_FRACTIONAL condition to the other patch in
order for it to make sense).

That's all I'm finding. But then again, I don't know what to do
about the 0day report on 10/14. It does say that it's a W=1
build, maybe we need not worry about it?

Cheers,
Peter

>   iio: test: add basic tests for the iio-rescale driver
>   iio: afe: rescale: add RTD temperature sensor support
>   iio: afe: rescale: add temperature transducers
>   dt-bindings: iio: afe: add bindings for temperature-sense-rtd
>   dt-bindings: iio: afe: add bindings for temperature transducers

