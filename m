Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C80D23C278C
	for <lists+linux-iio@lfdr.de>; Fri,  9 Jul 2021 18:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbhGIQcE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 9 Jul 2021 12:32:04 -0400
Received: from mail-db8eur05on2111.outbound.protection.outlook.com ([40.107.20.111]:50657
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229499AbhGIQcE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 9 Jul 2021 12:32:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AFnHC+yI6x8NPs8af/Z4rncatKZcUrTUd6V1MlhMeIMrvmkJBdWNy4/X5i/nl4/yOwSXCmmbH1cr/+hB+3jKTrOq9M6cf/ouespnM4z+XJb1wPWZMBNDO7Qegi1Bb/AvKAn2mbyWrt7pBbBe79M9c2xhyqzBuxUJ/vQk/VdgGMzJi3BohLZfbuxkHD1PJxvO3t8wEhN0M7JYjnrt9rebfwT2q1R8502Rr85TNC8nAiyAfaCIUXbcQoxEzE/jC0eSOkF+spRHYszudNgfJTrye6q6q5nMPsDO98WKsKX7irpLcjjGtk5sl8hE6EpumJ97l/KrQ6y+ZzYmLbFzQJB5/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ejALi1zsewUDtHuma1NuX/spxNrbNsw4vrH5Yrl8HBI=;
 b=L9ctXWXX70TmuxI91bvvq8YU48UGd3mVyAHkQF/6Jnj9kOT820Y4U7PynfO7SZE99KD9FM+yLTXyrIZA46asiCMRhoKIEMpCjhtleoyI5UG1QsT4VSjw1fqmSLqAFI2b/jtRpScx5TG5pSECWZ3/E1WjnRGKgCai2U0yfVAdHw310Ma22VfvZ3qAROHugbHDCzUnVHewvI6Qke4BDUvEqi0ofhbYEBlp+oe6kmdBDDSV7soaqbMAMDuHSCZW9N+pWm7E7VVwMjD9Hi5APAb6fge7ZyTRhbSFush1JeLPYV4j/CU5Zmw/Tv9YULYw7BhrAsmalAATUHN4bIwgnUsV7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ejALi1zsewUDtHuma1NuX/spxNrbNsw4vrH5Yrl8HBI=;
 b=JBN8+EHbk+ZFdk0XZG6dQUTS1IHZX6qauIfU61+0eJO5AJccVNhQBq8oBWQIzA3X1PSTO6XS5SCTe/358PsLGCZi9dWbxLgvaMdC/QV2BfakaVy9XqO7B7CT64M5JkCqfZc+IjBdf3O6P//t//+GcpOdavPIk4rlS2KomWtV30U=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB9PR02MB6571.eurprd02.prod.outlook.com (2603:10a6:10:210::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19; Fri, 9 Jul
 2021 16:29:18 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::14ca:a41:2218:3578]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::14ca:a41:2218:3578%6]) with mapi id 15.20.4287.023; Fri, 9 Jul 2021
 16:29:18 +0000
Subject: Re: [PATCH v4 05/10] iio: afe: rescale: add INT_PLUS_{MICRO,NANO}
 support
To:     Liam Beguin <liambeguin@gmail.com>, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
References: <20210706160942.3181474-1-liambeguin@gmail.com>
 <20210706160942.3181474-6-liambeguin@gmail.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <4be51a74-9913-291a-9dac-422ac23da3ea@axentia.se>
Date:   Fri, 9 Jul 2021 18:29:15 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210706160942.3181474-6-liambeguin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR09CA0056.eurprd09.prod.outlook.com
 (2603:10a6:7:3c::24) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.13.3] (85.229.94.233) by HE1PR09CA0056.eurprd09.prod.outlook.com (2603:10a6:7:3c::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19 via Frontend Transport; Fri, 9 Jul 2021 16:29:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd6abad5-5ed5-454e-240d-08d942f6b33d
X-MS-TrafficTypeDiagnostic: DB9PR02MB6571:
X-Microsoft-Antispam-PRVS: <DB9PR02MB6571F5C1042C69BC3C70DDD0BC189@DB9PR02MB6571.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sw2Rf6aDccxYT1a7/kC9BrNIrbdD+eE8CPeduz3ZYl9G1yuFJQi3jvJXEYGVY10lVQJ8fHrvm8Cq/nhAUqHA63VV6niVsxgxZO6+uv5iofD/aD8xtRdMEaduwxSNiBs1K8tEDnJPqUjVZkxt3ryq2mVbtMYHFZ42tEVZIt3nBSW/UWuMornNojkWJRTuvIcjgdHbjDUc9r1sUMjGpWRzaj3iUqvEjE/zKB7M/mxJDdGlvhGa9UGM8yx5VmNT54JExabDZH+hMR3yo+fe3R8ga33N0U66sKNAfr9xHtKHtppb9XApJllhMqOnHvKgyCfqe8vBdD43BBryoCywgDuw1jExHPnQDX9wyPLjXODWqtungh44uAW8dEYAKk3X9Iv4xA3d9CiBoIjOjllT9MkO1ZVqBM/ZqXeEP6GmapfYU8vDvWAIEcepv/rUdqGUni8s/w5vr6R1FRuAiJjBPjyvForlvbzlP8aB6r6mK/5OEXzY7X+eG/NiY13vNfjPsMjH1r1/550IjsPnPQ0RcQKuIoGTNhKN9B9+aKbNJMtgqKxFDgyK5RzAlMWYYi0dz5gaXHvva/4g+LvoqyzqWnQJDwk608j9kqELfvuf0AuFvtxQaEhJUk3Btg8e/fQHbfE1HwoShs52avQFtreRrcv/8Mub5llzxJ/L7MjsTsYBkls6z0MOGgf1Nwwvr1gJFi4y6SDqSnC/mvoKmu0IdP/mxqWpR5LvkeaL2upBIZ5Vq3g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(396003)(366004)(136003)(39830400003)(2616005)(53546011)(8936002)(956004)(31696002)(186003)(5660300002)(8676002)(4326008)(86362001)(36916002)(38100700002)(478600001)(316002)(16576012)(66476007)(66556008)(66946007)(6486002)(31686004)(26005)(36756003)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVhRaVI2Z2w2eWpKV1dZRnlTYVF1WXFXS21ZOXU1R3FUbUxvbU96R2JmY1h5?=
 =?utf-8?B?U3NRQ01xN0pmQmNxcHNJenptamFSM1VoVFlqYWJ3a2dIQlp4RFB6N3BaQUlS?=
 =?utf-8?B?REZtYTNEN0FyQ1BQcncxejNzek1MK01aYkxpaENBVjhIMG5xUElRSVlZNUt1?=
 =?utf-8?B?eEdDcmFuQkZYSmFTUEg4TUtEclB3T1lRdmZ3S0xNdlVsbTNGcjdLYW5iNWFD?=
 =?utf-8?B?RkVDeXRwMCtYVTF2a3JveHBpYTFHcXFuNzA3RFYzWFVLWm1UTkl2UkJMS2NO?=
 =?utf-8?B?NUJNZG40UGJROXBnOGx6OGh1aUFTQms2S0hJNzVYcXFJYnFXclpVOXBMd2M3?=
 =?utf-8?B?dDlETytRYWRZWGhlN3lmR3o1MmRaNThRMEtnUjRtekNKQ3hsSUo4MHhpM2RH?=
 =?utf-8?B?SGxTcTJhbjFZQndsWCtINHd1WHFGbUNJdHJ0ZUJCd1ZBc3NKNWl4M0w1cCtP?=
 =?utf-8?B?bGFDSFJ6R1U1V1R0MHFmNHZSM1BGUzgxOUlmbGR4YWRZT0x5MzNNYjUyb2hX?=
 =?utf-8?B?bkpwcWw2dXlCOXRWZFJOOUZyTU5mQnFFWG1uMlVWVGNtb1FEaXRCN0hyTVpv?=
 =?utf-8?B?cFhLVERqbDhsMVgvdzEyV2JjeVVRY0JVbk9YSWNWYjZScDRoSEJRQlJZY0Rq?=
 =?utf-8?B?NUdWSVpxS1VIcy9NaWZpUDM0aE9LblYrMm9qNzlpUUMxZnB5emxBSFh2ZkZq?=
 =?utf-8?B?c0poeXkwT0hnTjk1V1FFYndSREFOdnc2S0xYSFRGOUc0aGZRTFN6cWQyaU81?=
 =?utf-8?B?cjljNDhnVmZYbU5tdnZleVJXWWJpdjVFL1Erd1pvemJzL3BwM2x2TFljdDN1?=
 =?utf-8?B?ejJFUUQ5S1VZTVYvWWdCRk0zdlVmZWRLa2FQbjlwTHZzWDhVZytlcUYwdEkz?=
 =?utf-8?B?NVBocUJ4aS85bzhPSGxyZGRsUVRjUjh4VTVoSlF3K0VrSzE3R2lRTmJiWXlL?=
 =?utf-8?B?cXc2enVDZGsrRzR5RjFzS2thNzV4bGlHS3JORUVPeDgyOUpGV0p2NGwwZkFH?=
 =?utf-8?B?aWpZZ3dFcStmOHZXRXNYV2hkQTZiVDQwTUltZkJUd0pTT3A2QkVFVHhrVkRO?=
 =?utf-8?B?eFJ4d1FuOG45L2M2MHBDRlRrZG1CTkZUWi9keEFXUC94VFBGWkx3SUl5Nldj?=
 =?utf-8?B?RXBRNXZIU0IvTUN0bzQveWFxOWdUTDlJTWV1cWY0WXZock5PTmtjU29PMk9m?=
 =?utf-8?B?ditCZEY0WDFyTnE4UFNnV1FzcDJFTE8vK1R4d2I4MGdHbmRXNDFJaEJTdGww?=
 =?utf-8?B?b1o1dEJpSXpLdEhoSy91MjFlK3N1cW9YK0k4Z01vMnNwclV3R2tqakp4cHpI?=
 =?utf-8?B?cDlHMGpYYzZpMHFJN09nV2hhc0QxVE14R1F5QkJQd2RSVEpTRmU1V1NxcmMr?=
 =?utf-8?B?bzY0SVhwdWo1Z210cWhwczdvUmUxNVk3UjVQNkpycVM0bTd1SmRYQ2xRZnJv?=
 =?utf-8?B?dk5aa013TnFmK29iQ0pMcTM5dzJaUndZTkQxWlR1MTBXb01mMXdWMXE4Q2Vj?=
 =?utf-8?B?U29EM0JzbFZ6K0xnd3RWbTJpYzYwTCtMRVBCbWNHeENZTXlLSEdncHlCOEw5?=
 =?utf-8?B?enl4R1AvdFhHVXVPOGJvajh5Q3VJVGJ6OXVaV0liRE14d2wwYWJxQjBFZFV5?=
 =?utf-8?B?SlJJa2RCL2hKT09LMUw2SGJPcGJyakxJMWZmQ3VpRVQwYkxTTHVCdHZ3SUds?=
 =?utf-8?B?MkFROFZ4WlhGTXVUckkwMGFLTUhNL0wweEh6aVE2M0JqMnRBc2hjaXIxSStj?=
 =?utf-8?Q?/Sn0u/VyUu++OexMDkAnOZZiQHIB9qo92uUZCKj?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: cd6abad5-5ed5-454e-240d-08d942f6b33d
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2021 16:29:18.7101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3tKxWXzj9dFr1K3zDSWjjlGafoVmeHm4Q2pnUK8N0EXOjEb59L1aQagcB6Yc0vxi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB6571
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 2021-07-06 18:09, Liam Beguin wrote:
> From: Liam Beguin <lvb@xiphos.com>
> 
> Add IIO_VAL_INT_PLUS_{NANO,MICRO} scaling support.
> Scale the integer part and the decimal parts individually and keep the
> original scaling type.
> 
> Signed-off-by: Liam Beguin <lvb@xiphos.com>
> ---
>  drivers/iio/afe/iio-rescale.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
> index ba3bdcc69b16..1d0e24145d87 100644
> --- a/drivers/iio/afe/iio-rescale.c
> +++ b/drivers/iio/afe/iio-rescale.c
> @@ -89,7 +89,15 @@ static int rescale_read_raw(struct iio_dev *indio_dev,
>  			do_div(tmp, 1000000000LL);
>  			*val = tmp;
>  			return ret;
> +		case IIO_VAL_INT_PLUS_NANO:
> +		case IIO_VAL_INT_PLUS_MICRO:
> +			tmp = (s64)*val * rescale->numerator;
> +			*val = div_s64(tmp, rescale->denominator);
> +			tmp = (s64)*val2 * rescale->numerator;
> +			*val2 = div_s64(tmp, rescale->denominator);

Hi!

You are losing precision, and you are not mormalising after the calculation.
I think it's better to not even attempt this given that the results can be
really poor.

Cheers,
Peter

> +			return ret;
>  		default:
> +			dev_err(&indio_dev->dev, "unsupported type %d\n", ret);
>  			return -EOPNOTSUPP;
>  		}
>  	default:
> 
