Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F268450FC67
	for <lists+linux-iio@lfdr.de>; Tue, 26 Apr 2022 14:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239509AbiDZMEE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 26 Apr 2022 08:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235227AbiDZMED (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 26 Apr 2022 08:04:03 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140139.outbound.protection.outlook.com [40.107.14.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C2E663BF3
        for <linux-iio@vger.kernel.org>; Tue, 26 Apr 2022 05:00:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lWBJh3undbCxkKB6iBvp0YU8Pywg8thdQVvcGTXX9x8ESC+iiv2qgHdUACfVpfSDI3xsM6OkjvrB9YYvLoLbv6xcz8SDP9B8YvnR/NcpRJCa9H+nYm5MMGHJr6jLMjHFBkTRackK/Jhy0b35rv5WFOI7n95VUpkEX95Z6RXLhMaSWYpx9/C/97tvSsVNVs3DwrjOt+xplRFE7XbS0F+CZFZL4AA1JI6nSKjP0JDXpl7tA4zvlVFTwPwxNh9kIAI9t8sqK1KVimWs2c2dxitFMh3jYtc4AD0cIsXWvIURN3VhjH/XipAyn3uFCyJGr0PoCwyJqre31sbnhnQc62TRZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=brNBvFpFcTEHhDnlS14vC1tfuZ3FuQklrgZDvz9MHoc=;
 b=hwxsEkYGygMmVztTl5BLkc/503Pk2y/Hx4d2KrsgM08Wqflr0J8ldwvy75vf9dCWo6QExEEi06OAG7iQ9rPWhKNkmJWyrwqWm6EZP6RSZR7lNVAamvKRNW0IQkfbAD0QoruoEiqC9gwcPQhCe+lgRvN5k8TG7+ZP2/e2S+TdWB46BlY9EiMC6/ylIg/reBVi9HRm5SqIINwbUx/P8UMf7fERBFdh+aS1j3swxUqrNzW8OaRvUs4D3o+V+Hm39b4FmgmtXFHo3vPiNEdS7qToRBI5VOHBxAeSFk/6sFBii63KF/8CHIAkzSHJPWEcZHz2H9s/jnkVDOu1PbDGJP7PQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=brNBvFpFcTEHhDnlS14vC1tfuZ3FuQklrgZDvz9MHoc=;
 b=OzB0eYTPRzA9UY1dwWs2uYxyOkJn9cBGX2XZjdju5LpBv3SXYgvp0CqTpmpB9C4+W2y/13BlNF9K1TuQh8Z5TTyZEvbDvUxMSIlCpzuxvFsGBPN7Xm+LAEcwVbc6qHcKgZg5gRq8KLH7rw6UNcJjzBUEiARouwOco6wWaMNNeiM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com (2603:10a6:208:ed::15)
 by VI1PR02MB4416.eurprd02.prod.outlook.com (2603:10a6:803:b2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Tue, 26 Apr
 2022 12:00:51 +0000
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::d038:3d5c:e37f:4423]) by AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::d038:3d5c:e37f:4423%5]) with mapi id 15.20.5186.020; Tue, 26 Apr 2022
 12:00:51 +0000
Message-ID: <a684c794-3f28-7ce5-92fe-0aed3ae52d91@axentia.se>
Date:   Tue, 26 Apr 2022 14:00:49 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: en-US
In-Reply-To: <20220418192907.763933-2-jic23@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Jonathan.Cameron@huawei.com, lars@metafoo.de,
        linux-iio@vger.kernel.org, michael.hennerich@analog.com,
        vincent.whitchurch@axis.com
From:   Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH 01/17] iio: core: Increase precision of
 IIO_VAL_FRACTIONAL_LOG2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0120.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:8::26) To AM0PR02MB4436.eurprd02.prod.outlook.com
 (2603:10a6:208:ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2cb48e04-6197-4329-0689-08da277c688b
X-MS-TrafficTypeDiagnostic: VI1PR02MB4416:EE_
X-Microsoft-Antispam-PRVS: <VI1PR02MB44162F4C26452B47A7120948BCFB9@VI1PR02MB4416.eurprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i47Ehxjt7SrCsgAnVXJ6B+hDg5P8XbUV2O9L0mDIFtDjsuUrFkYba4rnSXTDWYBAhi3zqnT6TAj5Cx7bPV2ma9QwKRU4JAHKW39ohwEVlUL0nhQqGiM3XRZYoWgiTSTKWEzigNolAT2C2/eDHpxNe4vusnq2VCg6G9F1bBf52+d17EL+frLpiF6jZomm3v88lKWwF8vBffy/+cJZBuictMms1oMIKEOjg4uA/NztAEfg4GZNnupC3I9lplXF0f3LAzVcyOyFOodpHDfmA8v7g0B9N4JUgdlkvIhRZY6WE79YFk3e1sE8velFMazuf67wFaganKaEamKjtyR+Vs9ipYkgXjZa55HJBcMS/nbVmW6k7v1lLk9CC3J1MW1ybW2mAWloHTyUefTuEbCd9QxKxB+v6jvgfkwRnRgmlrYnXvrCotD/wIcvIxzxIf1jnRp9mt+FQAiRKde3c2nLmUXlmuVylEbexnn8QWDiDyVwrPqeoNgkh4wS2rE0uLDULx6eE/VmWY2InYlOLKnazRpg14tuqKB0byCle9Z5AF+pZOo/5QLqYdJIk9jv2esdsWFCdFCSP5oDKlyJVjcIkrQvWpE+li2VT0g4aq/O8ki87qL0pLWj+fGfNLMbey+QpiwjvFNNish8jOo5d/3G4icD8wNYJK5Q3Id6QyRbhRVifAJ77JbT5nka8A3zIY5sanDlAiGIRvvNNAexy3HA3AEO6jgO7KDBeNrEBOdKjc2fYL0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB4436.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(346002)(396003)(376002)(366004)(136003)(39840400004)(31696002)(186003)(2616005)(6916009)(86362001)(66476007)(66946007)(66556008)(8936002)(4326008)(8676002)(5660300002)(83380400001)(316002)(36756003)(31686004)(508600001)(6486002)(6506007)(26005)(2906002)(38100700002)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L05PRWFmR3BJb3JVM1JaNHNmVm9xajRMZU9DeHNzMlQxL2djKzNBdmM2Z1c4?=
 =?utf-8?B?MHhKQ1ZxeERrUjB2aHl4Qm45djZGNHlIakRzTTFQc3NvOSs4bWJBVUFQdS9u?=
 =?utf-8?B?WGRqZUNwMHJ3c1lZRFJ1K0FVa3FHRXl4aVcwY2N3dHl5U3p2bks0WjBuazNV?=
 =?utf-8?B?cHovQ3MwMytRR0kvZTV1UUxaMm5ydmpSd2FubG1tbUJhQ2VTcDJhRG92VElN?=
 =?utf-8?B?VHlNc29SMjdFY2o2NlN5UTR1dUYxYmt3dlFTR21xU2IzODFYSVE3dm9Zb3FB?=
 =?utf-8?B?N0U1Mmp4NjY3M3pEcTJMZjRtZllTMDE5QllMcnhkTzl1TE90bFg3ZkZLNjNp?=
 =?utf-8?B?dXp1TzJoV3NDa3lxa2c0cG44b2tUMng2SDlIdzk5TldTMDZ4S2p6MDRpL2hN?=
 =?utf-8?B?emdLMllORElCZ055V1RTS1huemdIMkUvVHV1WW1oNnpCR1RycDRtZzlOZjhU?=
 =?utf-8?B?Q2dMMkRqRVJEWklpNDdseWpEMmZTZ2dCNkN5N3ArMDU4TlFteVV3eDJxV1Ns?=
 =?utf-8?B?d2JGaHc2SzZ3cW52OGFLZU9Cdnl2UWcxalRKQnRUNHlJQ2d6cHJKTzgrNDZO?=
 =?utf-8?B?SDdVTndjN21qK3N6cmNKWEcyWFIyaVdLNW5jV01BSzVBN0F1dnpKQmszUm43?=
 =?utf-8?B?WUFBbFpmSFFDR3dCbFp5TGQvZ0RCQ3BjcllhVEVleHhzdFI2OTV5MUpyYzZi?=
 =?utf-8?B?TkFCM1BxSTdrM1JUbUcrTUN3dzltb0VSOGRnTFk0cTZKMVdRdkFqck1YRFRZ?=
 =?utf-8?B?emNFdjI0ZWhRS3hQd280dG4xUjEvRkRXZ2RVZWF4ODRoSVNacHNCZWlWWk1s?=
 =?utf-8?B?R3dTWWZlK055Y0JFMGRnNVg1Y2JocEk1d3ZMQUhGN2Z4R2ZpNGpYQldJNEJO?=
 =?utf-8?B?YzBvV3RHSXdyZkRselpJaHVwL2VVV0N2WXozZnZienVQelBsMlUwY3FiSnl0?=
 =?utf-8?B?TUtQK1lsOEgzMmVyRXBsbG9VeTJXeEhyY1NDYlFCRW1vQUZmZmt5bjZXd2ZW?=
 =?utf-8?B?Ui9FY3lidi9hblllcWdkMTlWcUdja1J5c1B3MWxPZGtmU2xwcmZrNGJOU3Y0?=
 =?utf-8?B?WXRmVjhQanJOQmY4WkprcTJIZUlzaGpuYUI3blBIOEg4SEs2UGVaZ2p0SUdE?=
 =?utf-8?B?cU1nbzhrTzcyMGY5RVVHK003aTl3ZFQvYS9mV2RuUVpPK3kxalRvVG1ndzM5?=
 =?utf-8?B?OENHbFM2QzQzbENzYzV3aE84bDI4RFlubWRTcEk2OUFlVmxLVTYrbU5kNXAv?=
 =?utf-8?B?OFZVSUpwYk9sRG9LaWw4Q0JJWU4yU3FpU3NGc2R4Q25hQXN3QitRSkNNOTRM?=
 =?utf-8?B?M3lySWFxV0M1U2tHdVFCMC9hclNEblMvUEp0SFYrekxsVk5wRDNYd2dQOG15?=
 =?utf-8?B?RTZZQ1lhUlBzYkw4djRCNDI2bmNJL1kzRG1rSWJKYjNlRGlLeEUwTTZ4KzhZ?=
 =?utf-8?B?L2FhaGVYUzNBKzRIUXYycFZYRGRSV3NWcEFpN3VLY25HYXk2djg2UmQ0TWp3?=
 =?utf-8?B?K1dFb21VSGdHVTVHZTFRVHVCYTYrTWJlYnNtbWRSQkE5dXRRL2QzSnh4OFNl?=
 =?utf-8?B?Zkdzc0pUMDdHY05rS1VTRDdXRk8rTzU0MDZCNkhNMm9KS0xJYlZzZStiWWFV?=
 =?utf-8?B?OWxrSnk1Mk9RcVhkVU9MNzNJL2dvUlM0Skl2ZkM0QXVzWWhZdEhveW1RcFJ4?=
 =?utf-8?B?YTRLaVdaZE14TVZHS1c3VW9GMGtwV0luZjg0NkYrMGNQbFpMcGh5c2VTYkNt?=
 =?utf-8?B?eTh4TzBPN0hGMVpTU2J3Sk0xdG1BZzJueDgzcjNlLzI5TkVrcUFZWE1zU3hi?=
 =?utf-8?B?Z3V5N3U5NHA4T1ZkLzZWZFNmV2srTnNiVTJiVjU0RWsyMm9vTzRiK3grMEZr?=
 =?utf-8?B?M1liQWVDb0RrVmt2TnlQRjdkSGErNFRRZTNrbTNBNVZxUFBCOUhjRk5RR2xJ?=
 =?utf-8?B?NU9nZko2RUE4WjJhNUZmd0ZTQWlzZGFQbVVKay93WlVmdjVJeVNIYXNjS1hI?=
 =?utf-8?B?My9OZm9nYUU1cEdXZENyNWVuN3VnMWkrUml0cnp1ckpDemZXdmR5RHd4U3dL?=
 =?utf-8?B?NlZYcER4cTdyeUFacEpXcGo2andSNENIcmkzQlZUckhLc1BmRGx4aUFrNENk?=
 =?utf-8?B?YUsrbEI4c0xBUFd6bVZpcklzRmtMRFZXTjVrRFBtZFdPOE5ERzZ2WVk5U1hN?=
 =?utf-8?B?R3ZwSG9ERHV6c3NBUW50aDJEN1krNVhBQ0RYZmZDenN5d0ZQZ3pmMHV5cTR6?=
 =?utf-8?B?VDE3V3hpQ0YwUDJZVHVLWXNucXVFRGorVGx4dk5ITktZdTZrRHR2RzdVOVRH?=
 =?utf-8?B?VVErM0lQd1RhQmNoRGJmQzhiYm8wYjZ5L1dPNURXcGNMSm1ncG94QT09?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cb48e04-6197-4329-0689-08da277c688b
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB4436.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 12:00:51.0809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hy5dKTKrFZULZPb0PTKSWtQ8Rx4RMGlE5BIbWvcWJOI0vkV8U45hCmOGcbOVa4+W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB4416
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi!

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> With some high resolution sensors such as the ad7746 the
> build up of error when multiplying the _raw and _scale
> values together can be significant.  Reduce this affect by
> providing additional resolution in both calculation and
> formatting of result.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/iio/industrialio-core.c | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 2f48e9a97274..d831835770da 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -683,14 +683,21 @@ static ssize_t __iio_format_value(char *buf, size_t offset, unsigned int type,
>  		else
>  			return sysfs_emit_at(buf, offset, "%d.%09u", tmp0,
>  					     abs(tmp1));
> -	case IIO_VAL_FRACTIONAL_LOG2:
> -		tmp2 = shift_right((s64)vals[0] * 1000000000LL, vals[1]);
> -		tmp0 = (int)div_s64_rem(tmp2, 1000000000LL, &tmp1);
> -		if (tmp0 == 0 && tmp2 < 0)
> -			return sysfs_emit_at(buf, offset, "-0.%09u", abs(tmp1));
> -		else
> -			return sysfs_emit_at(buf, offset, "%d.%09u", tmp0,
> -					     abs(tmp1));
> +	case IIO_VAL_FRACTIONAL_LOG2: {
> +		u64 t1, t2;
> +		int integer;
> +		bool neg = vals[0] < 0;
> +
> +		t1 = shift_right((u64)abs(vals[0]) * 1000000000000ULL, vals[1]);

While the multiplication is safe if val[0] is 24 bits or less, I
wonder if that's OK for *all* the existing stuff? I would have guessed
that something somewhere needs more bits than that? Did you consider the
rescaler? And if everything currently really does fit in 24 bits, do we
really want to make it difficult to add something beyond 24 bits later
on?

Cheers,
Peter

> +		integer = (int)div64_u64_rem(t1, 1000000000000ULL, &t2);
> +		if (integer == 0 && neg)
> +			return sysfs_emit_at(buf, offset, "-0.%012llu", abs(t2));
> +		if (neg)
> +			integer *= -1;
> +		return sysfs_emit_at(buf, offset, "%d.%012llu", integer,
> +				     abs(t2));
> +		}
> +	}
>  	case IIO_VAL_INT_MULTIPLE:
>  	{
>  		int i;
> -- 
> 2.35.3
> 

