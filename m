Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41B773C9C19
	for <lists+linux-iio@lfdr.de>; Thu, 15 Jul 2021 11:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239062AbhGOJva (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 15 Jul 2021 05:51:30 -0400
Received: from mail-eopbgr40090.outbound.protection.outlook.com ([40.107.4.90]:28172
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231177AbhGOJva (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 15 Jul 2021 05:51:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D7eGxNX8FcOg9XUWSSAf/WZPMjsPA/bX4z9ch4Xvw0VVzjUpY2PO8SAh/zNnqXYJGav9YKoLkXF4eWokl1MNxAHRwVRT2vyKfmH41ueRCN+/pi/qmd17mQlv5o8qASdSGd9DSlfjcElO4mEz3mO5kJoGgMMj/UvxzrOIn4GybtWujqQY9BjRncff0XpGCcNVvtW7yN5bpGx23GHqhhO7gsikOnklktoWvC1VJ0ISO3bo5FdyWfwwMg5Qf80kqoILz5BBPFaIH8PD2ZkT2JFrsSWlSdfH2LPnchLU6Q66XdfORUm3sH2fpoD7nd8IjdxBg+M+BZ0s3ZzYRSlnGq31KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M08VAaeCzczv81MV++q3tpTXvayzGimmYoAdps76PvI=;
 b=D/ZblZj+8NDJXjt8gz5RwEY2A9BZFTNulGbjQgCILYVf2VWaAKkr7UEcvQknqwoXJcGYKNgRijFBkHegT9TLBYC3oU2AbKkTvbIl+pFwaweP1Jp8CxoqdUnMQYTtPiWuonvUYBFVzWhsUA32VdGhfeonuaxtRAD3/Y1Cbq67TKsh2D3TVcPvpy2Y+qquYxLzmL5ZF/0QHWZg/2kxIQV/OfyrMVWUdSIAcHqExmUXQscgWdEDn4dmCVh47IXJkPyGlLWsIH/BCwrLopAQ5X2dRru5350LoBV9ntVa1EDOUlYNtLwCkpAQYCTqVDleNhB/+XzIpOziW75YU/Pc++cIqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M08VAaeCzczv81MV++q3tpTXvayzGimmYoAdps76PvI=;
 b=hk/MHXSmbm+h8iS0E5tCl2LxQJgQGHGTvRCMdxGUJGdYSDoNdSOxbvJ8kRJv/zmOavD+AtR19XgO6JDPm2+TYU+sRhKZpSkI+JDLq/nhaBlk4ZBravRpNjYudhRJdvbZWC4y0BfHf0LJS0orA/DMOQY7nsLzT8V7p4FpiAUutN8=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB7PR02MB4219.eurprd02.prod.outlook.com (2603:10a6:10:47::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23; Thu, 15 Jul
 2021 09:48:35 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::14ca:a41:2218:3578]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::14ca:a41:2218:3578%6]) with mapi id 15.20.4308.026; Thu, 15 Jul 2021
 09:48:35 +0000
Subject: Re: [PATCH v5 05/10] iio: afe: rescale: add INT_PLUS_{MICRO,NANO}
 support
To:     Liam Beguin <liambeguin@gmail.com>, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
References: <20210715031215.1534938-1-liambeguin@gmail.com>
 <20210715031215.1534938-6-liambeguin@gmail.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <8417f698-eef2-3311-625a-1ceb17d3e5b2@axentia.se>
Date:   Thu, 15 Jul 2021 11:48:31 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210715031215.1534938-6-liambeguin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR05CA0180.eurprd05.prod.outlook.com
 (2603:10a6:3:f8::28) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.13.3] (85.229.94.233) by HE1PR05CA0180.eurprd05.prod.outlook.com (2603:10a6:3:f8::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Thu, 15 Jul 2021 09:48:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5b13584-6e77-4e10-07c9-08d94775b664
X-MS-TrafficTypeDiagnostic: DB7PR02MB4219:
X-Microsoft-Antispam-PRVS: <DB7PR02MB4219D3D33AEC5E2E44487C23BC129@DB7PR02MB4219.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +dx1MsDVis7XvFRkZuAqTemvv5wksX9IykBmLYZTRxA9KQ9oxziO5RFuqyD6W3VKua/oQgn8MYGnM7c+w8akM6v2eqLRolxrvDSt8GEfbCkIaGXGM5rVGwT+n+mvethaCGq0S7FUlwzvmWpmLJBFjEC1/jJWHzJbuVCa1G1oPIO6p/HMa1Fdp/sHrox3ltDIyeElghc//o2DFBlUhkeWc5EY/YNVC1u/tWFxsPXBh/CFCQI8s+k+pEEgOTtjwY7GFbM2RqPazkIaPITUXNRVUn9qBDEkKtGnz4jAcAbKQLTfvmAKKzacLKvt3pcZFQiVaw0tQD3OFbKcKou7bSKkgQpYd6/PQPVIkuzEIRyYNCO5bMCntL4eqpzF9ysJHh4BKR4Ot6Ek8yI7e0YSYh7lU6FdjlS905jENjQm9LSjIk0xZTVIHwRSHQmoBBdZkwr1QbC9l1on5klb0lQcQe1+hp82Uj86HABu3/8OyqcKLF4rwBTn86B9egXk75xTGnSTfPq3ZqoIc0TiGUIQOjoL1YGFd/2rKroz9vSPW2EdpJp6qnQFEDilsVO9+EZtTU+8jgvkeSYMMOxoqe/tGVJORQrfX3Hpzodlu2o7W3gw7SgZX2DQF+kfIOHi8nZuqUhkd7Q9ffx5eG4W70pK9jtvm236eP9MXON5U9ZE0QqouVKumt8qj2twssc+5iYBvcEMgd57nncYBF1Q+moT89ZVijVJzfwcVprBBe3DZWwXv28=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39830400003)(396003)(346002)(366004)(136003)(86362001)(6486002)(53546011)(38100700002)(26005)(186003)(2906002)(478600001)(36756003)(31686004)(5660300002)(956004)(8676002)(16576012)(2616005)(316002)(6666004)(36916002)(66946007)(66556008)(66476007)(4326008)(8936002)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajBNaUN3cytYWHFnSWt0OHRaaFpJM1FzSG0vdGFKN3dBUUFrNE9wbllRQTRi?=
 =?utf-8?B?TFMydVg5TXFkT3p2b2lqK3VqVUR2NVp1aVVHL0VIN1BzanZ6aldHNDE1ZkRS?=
 =?utf-8?B?U1hIRWxkbFVVWHN5MS9kdzh0L1dVNFIzWk41Qm56K29FbVQvTGd3UHh1a0ZI?=
 =?utf-8?B?a2JnRWhMY216WXRsU2oyOWl3RmVvZ2o4eThNUGVBd3lkcTNxbndMeStJTGhL?=
 =?utf-8?B?bW5HRlE4aUxDcHZieDhkWDRTL1FlaTExakpiTW5ZcVg1QkM3QUtEN0xkQitR?=
 =?utf-8?B?cmpMOHd5TVhzdWlLNk5lbEJuUnl1a1BCUlNsMTdQMVhLZFA4UWFkeU42eUdr?=
 =?utf-8?B?eEp0ZFJBcUVrYlBTUFIrYmRheEJoMWtEamhXN3RMd0pMZEpibFBVc1pQako0?=
 =?utf-8?B?WlUyS2VPZ2xrR0NkT1YxR24zdHI3MVpsVDdVSTNCQ3VlTjRNd3crMC9PazFO?=
 =?utf-8?B?alNDeFRNV01CTW5LUDNuMHdVNEVLZk5rSkdVYjlpSXdvTjBOS1doVU1nVTht?=
 =?utf-8?B?V21mQlRyYzJPcm13RmVqM29XZ1BlYmQxM28wYnVtN0ZwQWo0c0FobEJXZ3FJ?=
 =?utf-8?B?RnRhVHVlbUcxNW80alc0OGUyUHc4clpiQ0ErUXR1QUQya2ZiSWhsNXhHSndB?=
 =?utf-8?B?VlR3OHVFaGhKNGpJaHFNNzc4MWZrQUZidnJLamthb21jNlhLTmw4YW5hWUFz?=
 =?utf-8?B?VHJsTkJ0QkZmVlRDSDJ0V1BVWHpaWFdkM2pxWmtZcFZCNHcyYjZWQjJ0ODlw?=
 =?utf-8?B?Sjk5VnhVdzBQU2U5alNiQktnM2J5NzZGemhoVytOSjNTZTZnTk8xOStCblVN?=
 =?utf-8?B?UGJ2emtYNDRhaHFneEVvS1JKVi9Ja3lvTlZPeXJUM0xGc3J1dGZUTGNDaW9V?=
 =?utf-8?B?YWQyQTVOa2k3d0Q4ZE90OExxYmdJSEpEVGdRbFpzMkV4cHFFd2Z1SjdRYVVD?=
 =?utf-8?B?Wm8zSWNTT1ladWl1ck9wUDlqa3BRREQzU3BVZVBrdnFJaXNPYlRlcmdlSnhR?=
 =?utf-8?B?N3V1bEF5UGJrWk92aStMYk5PSGNLVVRKclkrMDNJeTdrcTNTNnJqT0xWaHNW?=
 =?utf-8?B?NmUyWjBmYkZZTjY0OVRZOTRrZENKUlFEWngveDBIWG1Oa2MxOEJSOExUanV4?=
 =?utf-8?B?WkVHaG9SVGVwclNLQS9lUjZadFhTelhha0RDc1ZicWoxUEJXdm85VytZUVEz?=
 =?utf-8?B?WVM0MjcwaXFJZlJNckdzQzNNZUVWajhlZ1ViK2VuNFZ4U1cyTFVsWHhlOGZV?=
 =?utf-8?B?anM5OHpJRmZHMHVWV2NhNERsL0ZvN1JFNVk0WWhXaXlhM3ZWU3pFZG1mam1O?=
 =?utf-8?B?Rlg2UkZpUjRCdVYxQTRocnBiVWREdy8wV0FOc3QvOFg5R1JqcDNaMmxtaU15?=
 =?utf-8?B?b0UzUXlmOUpQeFI1Tm9zYkF3UnZsYkt6NTRoK0cyWXZTMnpYWGl6WUtqbStz?=
 =?utf-8?B?ZldHNHdnaTY4OE84UHhWTklWUVF3Q0NxaFUvdzlXNnVDYk95ZDFwNWpWRjA0?=
 =?utf-8?B?RG91Nkd5ZHhNc0dBUXFkYThaaStPWGFVUXRUYjBrOXpUeFg2UzBmUjVNWDVR?=
 =?utf-8?B?SFdEaWpXbHFuaG1MTzdkNEZSU1U1VWpMY3g4RnkrdjErdEVBSUpta3lHTy9w?=
 =?utf-8?B?WFl3UGFYQStOM3FaMzg4MElxbW5XRW5wNE1kNUY2ZlRhMTJDbTNsU1RuZGQx?=
 =?utf-8?B?a0ZnalFEOTg0cW1leWNQaTFBOGJ0aVJWNXFXVlk0T2pWM0RMVllyN2g5VjBr?=
 =?utf-8?Q?51P4AiMA6O80lyUS1WxJa1UhXXxb7LLInWUzpWF?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: d5b13584-6e77-4e10-07c9-08d94775b664
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 09:48:34.9308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a0e33rraajZMAhyIHncWTwdW15ng5jncEXNAWgMWYUMmOCOSF6IZVYwvEqB1q6KD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR02MB4219
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


On 2021-07-15 05:12, Liam Beguin wrote:
> From: Liam Beguin <lvb@xiphos.com>
> 
> Some ADCs use IIO_VAL_INT_PLUS_{NANO,MICRO} scale types.
> Add support for these to allow using the iio-rescaler with them.
> 
> Signed-off-by: Liam Beguin <lvb@xiphos.com>
> ---
>  drivers/iio/afe/iio-rescale.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
> index 4c3cfd4d5181..a2b220b5ba86 100644
> --- a/drivers/iio/afe/iio-rescale.c
> +++ b/drivers/iio/afe/iio-rescale.c
> @@ -92,7 +92,22 @@ static int rescale_read_raw(struct iio_dev *indio_dev,
>  			do_div(tmp, 1000000000LL);
>  			*val = tmp;
>  			return ret;
> +		case IIO_VAL_INT_PLUS_NANO:
> +			tmp = ((s64)*val * 1000000000LL + *val2) * rescale->numerator;
> +			do_div(tmp, rescale->denominator);
> +
> +			*val = div_s64(tmp, 1000000000LL);
> +			*val2 = tmp - *val * 1000000000LL;
> +			return ret;

This is too simplistic and prone to overflow. We need something like this
(untested)

	tmp = (s64)*val * rescale->numerator;
	rem = do_div(tmp, rescale->denominator);
	*val = tmp;
	tmp = ((s64)rem * 1000000000LL + (s64)*val2) * rescale->numerator;
	do_div(tmp, rescale->denominator);
	*val2 = tmp;

Still not very safe with numerator and denominator both "large", but much
better. And then we need normalizing the fraction part after the above, of
course.

And, of course, I'm not sure what *val == -1 and *val2 == 500000000 really
means. Is that -1.5 or -0.5? The above may very well need adjusting for
negative values...

Cheers,
Peter

> +		case IIO_VAL_INT_PLUS_MICRO:
> +			tmp = ((s64)*val * 1000000LL + *val2) * rescale->numerator;
> +			do_div(tmp, rescale->denominator);
> +
> +			*val = div_s64(tmp, 1000000LL);
> +			*val2 = tmp - *val * 1000000LL;
> +			return ret;
>  		default:
> +			dev_err(&indio_dev->dev, "unsupported type %d\n", ret);
>  			return -EOPNOTSUPP;
>  		}
>  	default:
> 
