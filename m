Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8DD33D421C
	for <lists+linux-iio@lfdr.de>; Fri, 23 Jul 2021 23:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbhGWUjm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 23 Jul 2021 16:39:42 -0400
Received: from mail-eopbgr70090.outbound.protection.outlook.com ([40.107.7.90]:18823
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229461AbhGWUjl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 23 Jul 2021 16:39:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CN27ebv62IstsDC0IrOL/NeS+LrBMZk7UldyEotbsqKCZ7JziXo8mHS5cj7tSXOTmRI+t00IKEaZbxI67LtS668vr6vv0evv6WZu8wCDo3DCI8biFlZUX7GdmDBQ5NFZMelMJk+ePqHrd5EetZ9bv1TeA26IkxIpNkMht2PI851E99UEy06J1qCE5ygTMnwTJtb/J7J+Ca01Lhh2tt1sUPqKSZTbCLwvzupkHHd9HGsMUXOojQ3jF51EhVGtxZhchYOpFtevXGN0X3GapBnUiQCo6RrFrmpvS4kTUO3BRCadQzUdFjf8Hb/keR1e2zPl1ZKeNZEQHJBxKe4KlOdRCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n8ClSkO8qXTyBWSaOQQYAiDTkgZVSOYb03f/AhacXvU=;
 b=kulnzUaAzxIo8lr7hfqj9IyS7o2RAYxI60pep3pkax4Pa3qDaZzG/8b0V4kD8pAtqxIv27pYesRr/eiLMHiJZVFnKK0ymi7W+D7nGlAn/aQvOR6rTudxMtv8wcn8+YSCFEatNkgxhbqv4wEX1jhM7o+6ryEvg4XoSqQLnjkqfryRt9L/h6EnCCmfm1yIPuXn5qrR9ajhZ4rz6saDiexvhKb6z4x6zuk/Mb4EtvAx1liBmadRv6z+278Elq5kOxVeGNU2iOMDoM1NjXsfygnZpXRNTRMYGgpDTzdeM/gX0Z4bR8P1NPzSNo9BhqAzngWA6a41Z1KDvudhBVG6EUyTRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n8ClSkO8qXTyBWSaOQQYAiDTkgZVSOYb03f/AhacXvU=;
 b=SSHTTPjiMW7qWjVPqW7k3LY4HYqtXwSfhvtgATQuv1SMA7MChgmcML7mlf1Y/saPWCFMoYIQNXHeaT9ut7BQX2godebkz/lHJ1Sec9vSWoSYKlT6WKYykh2VqoPcAtFCvnlqfF4BbW4ZPKj6i+TrO2y3/fWYpeUE7YtOmHwU0Ss=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB9PR02MB6747.eurprd02.prod.outlook.com (2603:10a6:10:1fb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.24; Fri, 23 Jul
 2021 21:20:11 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::14ca:a41:2218:3578]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::14ca:a41:2218:3578%6]) with mapi id 15.20.4352.029; Fri, 23 Jul 2021
 21:20:11 +0000
Subject: Re: [PATCH v6 09/13] iio: afe: rescale: fix precision on fractional
 log scale
To:     Liam Beguin <liambeguin@gmail.com>, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
References: <20210721030613.3105327-1-liambeguin@gmail.com>
 <20210721030613.3105327-10-liambeguin@gmail.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <d2dea8ea-5a31-0428-4eac-4e4315d07a42@axentia.se>
Date:   Fri, 23 Jul 2021 23:20:09 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210721030613.3105327-10-liambeguin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM7PR04CA0030.eurprd04.prod.outlook.com
 (2603:10a6:20b:110::40) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.13.3] (85.229.94.233) by AM7PR04CA0030.eurprd04.prod.outlook.com (2603:10a6:20b:110::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26 via Frontend Transport; Fri, 23 Jul 2021 21:20:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 56a52689-66b3-4849-fae9-08d94e1fa77f
X-MS-TrafficTypeDiagnostic: DB9PR02MB6747:
X-Microsoft-Antispam-PRVS: <DB9PR02MB6747ECE6953286768738E70ABCE59@DB9PR02MB6747.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nMGtNk4lLHQo0guxfb100WVRm73I/r/xc+fee+jRdY/ftFuzHvkzhlBoKpUknzxW+sj335kVu60Ot5i/VDI9MOrVykOkaB3KAGm2UjMajcMxjL4doJ0GtIryh/i97uVg/85ONz2b4L8FKSUnRMX9dw2Knl6O2AKWvnspR7lrCSDbH+OoMuxCLNZGd3oSq+LNDM8Uiwhtc0ahlr+pJybUy5wJmDGa/LawlAememYgzhmSqkSPV+8AXRpl1Zv+ulQSy2PiA/6r13AvP2KFRS2Kwea/3TZYXiXKorShhY30r3D8tg6AwZjL5FEORiA9N7qI6gHgoj+ygqE5sFUugNJ5oln2g+L06EW2FHKvGX2aZsURlIc0XAHu8FgEyNF0LWmBzBU3jeIMEPrYCaJ5mOx5/GK1RQli/DJmnPFY2ROcQBaUVJkQASRO/HMP306z8Yc1V3lmA6AjBCdqnKMHCX7po7t6+lj3fuDOkMUVnD2NlxpDDn77aAsMC6O6Cw7Z7ZU3KO9yR4q8hoHJUfiks4s34LR75x+f22YksMqbhk4jOZmEOCAhLxgqsEepaLGvtcf6m16H4odZORLlO9IycJ13zSUV5sLoWfsQJEO2YYGxVZG32BpP2wRZ2QbGVN66bXWK+tIjyksSHzS8JkoIYDmqzFmUYj7ddwrAa7+eLbOULfdtVIFEXWzcVy0uJ/Pi0O/3k7SgsDsHAccy0mLbGKWsykToSYl9yb7u35QyD2PO/xo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(39830400003)(366004)(376002)(136003)(396003)(346002)(478600001)(956004)(83380400001)(16576012)(5660300002)(316002)(36756003)(2906002)(31686004)(53546011)(36916002)(8936002)(2616005)(4326008)(86362001)(8676002)(66476007)(66556008)(31696002)(66946007)(186003)(6486002)(26005)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHZJd2xrb3ByUjBITS80NncxYXpNUzd2ZmNsU1J0M0hVVjV2Wi9ROWRpZ1p5?=
 =?utf-8?B?N1NYLzlLVEdneUMzS0tyQ3Z3MElyN0N4Y0N5d2tzRkMzOUs5ZjlTWmo1ZCti?=
 =?utf-8?B?bnJJZDFmb2hQL0FjS0JoY0xoMW9iUEJ0amQvcmh3aEJpWDZXUVk0cGlmNmk1?=
 =?utf-8?B?eUpzV3ZNYVdDZ3RtTlUrWnk1amlJRko2MnlhYm0vb0tYTUpCeWlubVQ4WDRV?=
 =?utf-8?B?K01IdHNLcmR6cEh1VjZSTUlyTmtTcjdGT3NPMC9OM1IzUjdVUVdkL1VzVC9E?=
 =?utf-8?B?NGU5c01yV0Y3MkJrblc4Rk5zUzJtQ3JBUzVFMnV4UDVYaXA3dGZMc3BJOEtG?=
 =?utf-8?B?ZFRUOUxwK1RYS1pmZ1BJd1A0SDVKalZKL3BkSGNaYWxOTmlrelhlU3IyL01a?=
 =?utf-8?B?OVIzM3F2QmgzWEErejFVeElxd2dOV1llS3FSdnBUcExOY28xOHNFcW9MSG1m?=
 =?utf-8?B?bHNydytldHNLd3ZPMlhFWjl3VysxOEI4Nzl6VlIxcGlGM21qcEV6cTVtK1Nl?=
 =?utf-8?B?ZlM1TG9Xak16SUY5bHgvTWdOWFY3QklOYXE0M0wzNFpaSisrSmY2VE1sSkV4?=
 =?utf-8?B?MHhBMmt1VG1wSm1JSnYrbnVvL2dSU25ZU3BzYlZWSEFybjE5YzA0K2VRRFU3?=
 =?utf-8?B?VGlGME1wai94L0VhU2lTanFpQ0JvNkxPYWx5azQxenFqd0pUOTlKSWF5N3I2?=
 =?utf-8?B?VHl5WWRsaFNQeEdVV3l0VHJRRG95RzJhVmtZOTY5T3R2L3IyZmFkVDlFaGdF?=
 =?utf-8?B?WE5LbjNKYjgwYkNRZTRLNm10VExPdXNoRVYzbTFITW9PSHNsT1IvM0Iwck4w?=
 =?utf-8?B?SFpRT1VWendaSVVFRTVCTUdTTnRVQnlCb1pOc21nWDVBbE5WWXdSYzlvZVF0?=
 =?utf-8?B?cmtIQ0l3UWVTSkJEanVIZ20vR3NFejVJVFBxVlpsYTdNVkdlOHN3SlAra2RQ?=
 =?utf-8?B?U0NQWE82QWVsYkdNa0YzcnJXSHppbVMyU01BL3VpUVZFNXhDbWhXZzhKL3VB?=
 =?utf-8?B?Zi8rVzVRV20wSVI5V0JmTXI5NldlWmI1Z3djalNzTzNZMjdWeGhlaHdXYmly?=
 =?utf-8?B?RWRSRGtKczJpRVhVRU1KdE1xVTc2YWlGcy9Fckc2WEZXdGRvQ2ZPU0pualdQ?=
 =?utf-8?B?U1JPMkt2bEZaVU5RS3VDZ3ZwYXpxWmJuNnpmWWVja3lMNW02Rk11QUt2Y0FS?=
 =?utf-8?B?WTN1NkNYY2lDNHM5NkFQTXFIOEFrSnJVVnB6NWNTbVpFblRlNmkyUXROb1l6?=
 =?utf-8?B?WFR3MHhSUjdEUU82WWRCY1FLUlh3T1ZNVjBwQXdEK2cweWlxWkRMRE5tanFX?=
 =?utf-8?B?RGhacmxKNXlENy9NSDJMSTl4YWxpeE1mSXV3dmowSjNrUTFvbmdneDBKRi9k?=
 =?utf-8?B?b05sRnppbDFIKy9DdSt3bEdFVlhuUHNoOHMyMExjcjcyVW54YXJESmtOb2JG?=
 =?utf-8?B?T0ZOdTZrM2t2Z1d1ZnZNSWJKU2VaNzVJY0piRHpteGs5NXRmMEg0d2xiUEdC?=
 =?utf-8?B?MjJqeVlSdktMN0dZUGdsdnBiN0ZtbkoyTDlWdm9oNVRGellwQlRINDBZUlFS?=
 =?utf-8?B?bXlFakY0NXJMN3BES0tCaEtQL010SG9UZlFMZ2R4STlrbmp4WCtSQ1dpS0FJ?=
 =?utf-8?B?M3BnQmtmdzJPOHBMQ1JIdXpRRnE1QVR5TVloMkY3ZUMrUjhSRVZsTFM3c2M0?=
 =?utf-8?B?Rk4vTk5lTTNWb1BZN2FvY1I3UDNQdXN0Sm9LUHlhb1dUdDhFMFVrY0VzVUh5?=
 =?utf-8?Q?1gadBMbXsy1nTyQTXMBcBPQQM0YQzeqByPGKLe5?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 56a52689-66b3-4849-fae9-08d94e1fa77f
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2021 21:20:11.2240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YQHPdXdKYrVbQRqB7fLZkyMWD2ae6seUYJwzsjhUA/Tkl2QkXjy0/yfrmxd6pt2w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB6747
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 2021-07-21 05:06, Liam Beguin wrote:
> From: Liam Beguin <lvb@xiphos.com>
> 
> The IIO_VAL_FRACTIONAL_LOG2 scale type doesn't return the expected
> scale. Update the case so that the rescaler returns a fractional type
> and a more precise scale.
> 
> Signed-off-by: Liam Beguin <lvb@xiphos.com>
> ---
>  drivers/iio/afe/iio-rescale.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
> index 35fa3b4e53e0..47cd4a6d9aca 100644
> --- a/drivers/iio/afe/iio-rescale.c
> +++ b/drivers/iio/afe/iio-rescale.c
> @@ -44,12 +44,9 @@ int rescale_process_scale(struct rescale *rescale, int scale_type,
>  		*val2 = rescale->denominator;
>  		return IIO_VAL_FRACTIONAL;
>  	case IIO_VAL_FRACTIONAL_LOG2:
> -		tmp = *val * 1000000000LL;
> -		do_div(tmp, rescale->denominator);
> -		tmp *= rescale->numerator;
> -		do_div(tmp, 1000000000LL);
> -		*val = tmp;
> -		return scale_type;
> +		*val = rescale->numerator * *val;
> +		*val2 = rescale->denominator * (1 << *val2);
> +		return IIO_VAL_FRACTIONAL;

Hi!

I do not think this is an uncontested improvement. You have broken the case
where *val2 is "large" before the scale factor is applied.

Cheers,
Peter

>  	case IIO_VAL_INT_PLUS_NANO:
>  		tmp = ((s64)*val * 1000000000LL + *val2) * rescale->numerator;
>  		tmp = div_s64(tmp, rescale->denominator);
> 
