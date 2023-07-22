Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA0C75DEA0
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jul 2023 23:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjGVVjp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 22 Jul 2023 17:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjGVVjo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 22 Jul 2023 17:39:44 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2115.outbound.protection.outlook.com [40.107.22.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1A710D8;
        Sat, 22 Jul 2023 14:39:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WQER/emON5/RZ2cspjfh+BUa6DjnD3I+z0y7oDtyut1MFjKmaaKnluYPTNFoZn9Mta/yHLnmQcINuHWqbXa2h0TjeoccyataiVWcZrcNJos2muktiR+D7nEhThQs9D+yYuT7lAzYAnd2G3Xgsz6cfZ8L9FNmgUzaFqaZ6hGMOi37eEeV13jDoUaCAhZObwwGOgz03yX/BMTKo/cVj+5Ia34uKPpncywgSV4HNp9/7SEfNya4rCU4ysQIh2EuJBMeWENZYZ1W5yC9vVJdqBzdij2r/YTzpUr+rwDnfiz9GO7IGeVnkDA3qhrczTWYjsivAMRglZ+O8nfcmPim36o5QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NjGQRtSHUqQo2HVyb9CAb00vpmAcEC7ozSvZe9OuU3k=;
 b=SkdhbyQKcf9embbpkTwdEurEAoH8iM7DP1NV1WaypT1+Z75UkZ04fNFEG9QHr5Snr77ObOlB45UMgl78zKXyQydx3TLlZM3dmUN93+Wtekyq4nr6ATHvI58uoR+MA2sVtPkZw9ZhN8bo4kF50WobwsEGHDicLkNNSLS0wM2sw0sPJdVqsoqXAxzkK7HnlJfw6nR0KZtMdHXulXzd3FRJ8d9HJhHmst9SSsoGp0dLvx8n8j81F2il9OJghQbqn410ZW4CWFYqJHd8TkMU/xXNaWF6FuGPG+viXKkSfDSG5MIBcgILw4ZtZpIuRQb7nBki5X9DbrcPLyZvtzYeAlybug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NjGQRtSHUqQo2HVyb9CAb00vpmAcEC7ozSvZe9OuU3k=;
 b=RrmPNqWGAYwea2qbyexly2OkFFVJ1dKs1kBnvgnSwXn5a4BWJw54sK5ECqkrIwawSmsgigBPDEB5jSXZZ42smmdj1clL1L7HQTlblsnfhDEJJHWZZqfJIiq/E0pLWBCQlZ3rbhm/aoCfEs85UF+OiAXYlpjQh3aXJWHe/bMiukI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com (2603:10a6:208:ed::15)
 by PAVPR02MB9181.eurprd02.prod.outlook.com (2603:10a6:102:328::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.16; Sat, 22 Jul
 2023 21:39:40 +0000
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::2a6d:c845:6c5:2aad]) by AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::2a6d:c845:6c5:2aad%4]) with mapi id 15.20.6631.017; Sat, 22 Jul 2023
 21:39:40 +0000
Message-ID: <6e5a099e-57bb-7eb3-212b-494b5c30e4d7@axentia.se>
Date:   Sat, 22 Jul 2023 23:39:31 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2] iio: potentiometer: mcp4018: Use i2c_get_match_data()
Content-Language: sv-SE, en-US
To:     Biju Das <biju.das.jz@bp.renesas.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
References: <20230721071603.158114-1-biju.das.jz@bp.renesas.com>
From:   Peter Rosin <peda@axentia.se>
In-Reply-To: <20230721071603.158114-1-biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GVX0EPF000013DD.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1::a) To AM0PR02MB4436.eurprd02.prod.outlook.com
 (2603:10a6:208:ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR02MB4436:EE_|PAVPR02MB9181:EE_
X-MS-Office365-Filtering-Correlation-Id: 660bef2a-fa31-4380-ef9b-08db8afc2730
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aKgY3JCnP+r/3vMPx1VOT2uIMEfMhwg4zonb+lej/k4sIMRO3mfPWJffd8aB57NTI+9tagKJ1OKnbHnd5GxlEQzcJiY/QfngcLOGhadAUPd3Zj7U/1MAmn3fIP8qvHsrML83ug5567pt27f21sTqaW2/Bz9ZyIsHq2F9u0M+iSmr/yQaxKY2yAICOuT9MScwCoA+AqKLZiRkePZMHZ0TlUAS3bVbGbB1xqLdSxi7XKIbsBgElJ53dplYNyuOZconPM7862DRMO0VlvP16fJ/UJOJXBXW5CCqVtf+kNnTrMX4yTce77hVkDMHRvVtFeXMVhUlwYqYFJjIjf9tbAAhT0JZAixGYDhl6hFWgvBjtC/nW2Z6G+wKMZJCj4pOudeOdO2wFTOFxlOYLKhNZoGJVPQo8JiWtaHkw5KAklRBiGemeq+zTRlbc0peBdLbgb0MREsqAiXHQvnEpGWPfdgv9Xn7FwB8itGbVYGWKcxOCM0TUmmLdx0sf58oMzQbAjP09E75Pa42UyCxx8JrnRnyBMURE5SaXEzu/hQums8dmDYriNOqgPjPqsWJderjSuu3Lkuppwwgw9qY6FZh4ODkdbUWrz4LLpZFSQmjl4X+q1sj+7f1In+NR7tVlY5i4cuhLukugxbkm3dfCRvzZqObIA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB4436.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(346002)(39830400003)(366004)(376002)(451199021)(31686004)(6512007)(478600001)(316002)(6666004)(6486002)(36756003)(31696002)(66476007)(86362001)(110136005)(54906003)(41300700001)(66946007)(66556008)(4326008)(6506007)(2616005)(186003)(83380400001)(38100700002)(2906002)(8676002)(8936002)(5660300002)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFB3VkQwdGdlUTU1TVVPbHk2SC9tOVJoVHY4SU5uZzdXYlFaMEsxR2s0Q1VE?=
 =?utf-8?B?Nm1hNUJaYUJNYnZ3VGc0YW9JczhhUXR3dGZtQTJNYzV0eEdleExOSFhoZ0FP?=
 =?utf-8?B?dkt1WFpuV0lBSjk3Z3VldHNYWEI2OEh1ajRJd1Z0U0YvWkY0UVVkajk3QzRT?=
 =?utf-8?B?KzdiZkp1N1RVZ2JXWW4vMW5ncytmcUUzVzk4VlptMG51b0lEVTdtRXIyWi9q?=
 =?utf-8?B?SjkyTXlNVjk0ckdZREF4VnR5Zm1oaDI2Nm5qUUZSR3hPSlYwWVZqbk1wTnlE?=
 =?utf-8?B?TGJ2RVpPUDY5YnJuOXl5QWNOOFN2K0p0VGtpL2pFNS9LVEdicVUvRkxxNUlk?=
 =?utf-8?B?K0tsZnZnSXFmOU1HNC9GV3dvYjMyNXU3M3VBMUdNUXYzMEJOY2hQdVM5SWlE?=
 =?utf-8?B?TEd3L2dXQlBjY3ZXSno2SVIyWnQxMmJ5QVlRNDVKRXg4VThKeURIU2dLUE96?=
 =?utf-8?B?TXY1Yk9NUlAwZGRMd2hyWmIzQ3ozQWlGUlArQml4WVNsRUtxejFaZWVFSmpm?=
 =?utf-8?B?ZndCWDVMbGhTeG1iTW4vMnhPTzhKdkdCYTgxNGM3UlBaNEF1S3kvNzAwcEhM?=
 =?utf-8?B?WTN2UmdoVjU2RnhlMmpoMXFCUlBBVG5NcWJqWG5WZHNpR0laZXBJSjJoWjBG?=
 =?utf-8?B?MHJzSWMzcTI4VGp0ZzhkNlE5RHhNY0NBdEJ2bjdGL1ZXaFg3bklZSEVDYkVi?=
 =?utf-8?B?RzZFVHFWRUpzQzdmd0l4OVBsNDc0YjNKUFJKYi90S3ljcWhTb1NaaTBsRmZ0?=
 =?utf-8?B?YW45OWg1V1V5d0g4ZWhLTUxQd3Rkbzd3ZG4wVXd0TWF0b083emVDdUVRMVpH?=
 =?utf-8?B?c2w3RDEzK09scTJmWHhsYTZTVWRlRXVId1U2R01iNXZBRHR5d2RheEV4cE11?=
 =?utf-8?B?K3Uzb3VLNWZBQWx6MlRURnZLOU0zUTlQa0hnSlhQMGtlVXdVM2E3S0tKbjNk?=
 =?utf-8?B?WXZkL3Jwa3lGYnlyeGNjcE5KeExuQkFSMldrRGNnQ05KUVhTKzl4VG5zcHFD?=
 =?utf-8?B?SFdvdEg4ZUdZWFBvNHA5ZyswbHpVNkVFTG1nZ0JqVkhMUkFvdUd2bjhaclA4?=
 =?utf-8?B?Q1FZUGlQSnhVUDZKYmtCeW9qQkVkaW1WUHo2ZEVMWG5CdTN3N09GZTEzTWIv?=
 =?utf-8?B?NjBYV3FGelVaeGJrM1NPRTZJNENoaXdBY1FJUC83SVd4S3Y5aEdDV2UybTFT?=
 =?utf-8?B?UU9mWDE1SHhkTjdXRVZhTHY2a3R1bmVSYXRuT2J4U2RvazRITHNPZFdjMS96?=
 =?utf-8?B?U3ZQMnVJRUh0eFhPZm91N0VDT3BlRjJRaTRLSHJsQ28xZHJOaXkvc2dtWSts?=
 =?utf-8?B?SVRaNGZnTExPaVlkMWFGR2hWMlZkaGwxVU9kdmRCQ2NFeTZTOUdrcUxwMUZn?=
 =?utf-8?B?MHYreHduNVRPQ3dIVVF1MmRMOTkxM0E4V1BZRG4wcWEySDJkV3dGZXladnlV?=
 =?utf-8?B?VWJydWtrZm0vR0c3YVZKWkFZMklDeWdoRHk0ZU9mMXp4UmxucFNjRk43S21L?=
 =?utf-8?B?Yk5ENGsxU2RLT0xHbSs1SmU0dDFXNHZkR1dQSVVkR1NmMFRSSm5GckxxMUNr?=
 =?utf-8?B?QUpndFVqWWV4RUdCVGtheTBTRUl4enA4alcvZStCdE9wK0ZDT0tDTjdJaUM4?=
 =?utf-8?B?Z1FabHl0eEdRMWJhWHBEbnVjd1NhT2YzZjFkcE5GTzllSDhIbFJHMzU0a05m?=
 =?utf-8?B?Yk9GY3ZXbTM0MzVkMkFwN1duSTJsZHRobzVWM00rN1d4eFpCTEFiQlNDcVJX?=
 =?utf-8?B?Ukc1OUp4MDFBQlhuNTlMa3c5bXc4ckVzM3Jrc3N5OTVxNFkveW9oaXpnMHli?=
 =?utf-8?B?N2NzVDh6SnlXQmt2QXc5aytFSTIvZ3ZPZHZrMDdWVmZBb1c0SkozREQ5c0pF?=
 =?utf-8?B?QURRdHVyMzcvNmNGTjZSazVxS1ZGa3Q4a2FaeW1jTTczbkZkRzBXUnp3OWQ2?=
 =?utf-8?B?TFlTLytnTmVhemptSmcvMmVmTTFIdCtVYmxFSWVJcFJKcDFkWVIyZitIQUlj?=
 =?utf-8?B?UHIzMHIxeGV0UDd1UDROTHFicG9lWkpDRWFTZjRjeXdubmxEdkZNdGVVaFBp?=
 =?utf-8?B?UmVYazVtbHVycS96SXFtZTBDME1ONVNaQW90Z0d6NmlYTkszeUFJVE9oYXM3?=
 =?utf-8?Q?yPZvhfAn3ERookJqZG6d0JBta?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 660bef2a-fa31-4380-ef9b-08db8afc2730
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB4436.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2023 21:39:39.8396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wSTda74sokSJ3D4ixQez71okMct2Rut4pOzXgkGyh/YyKjmMcZNMMUJZQp1VeTas
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR02MB9181
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi!

2023-07-21 at 09:16, Biju Das wrote:
> Replace of_device_get_match_data() and i2c_match_id() by i2c_get_match
> _data() by making similar I2C and DT-based matching table.
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v1->v2:
>  * Added similar similar I2C and DT-based matching table.
>  * Fixed typo i2c_get_match_data(dev)->i2c_get_match_data(client).
>  * Dropped error check as all tables have data pointers.
> 
> Note:
>  This patch is only compile tested.
> ---
>  drivers/iio/potentiometer/mcp4018.c | 34 +++++++++++++++--------------
>  1 file changed, 18 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/iio/potentiometer/mcp4018.c b/drivers/iio/potentiometer/mcp4018.c
> index 89daecc90305..b064e86ecce8 100644
> --- a/drivers/iio/potentiometer/mcp4018.c
> +++ b/drivers/iio/potentiometer/mcp4018.c
> @@ -99,20 +99,24 @@ static const struct iio_info mcp4018_info = {
>  	.write_raw = mcp4018_write_raw,
>  };
>  
> +#define MCP4018_ID_TABLE(name, cfg) {				\
> +	name, .driver_data = (kernel_ulong_t)&mcp4018_cfg[cfg],	\
> +}

It is inconsistent to have a named field for .driver_data but not
for .name. Also, I dislike the cast and wonder if the trivial
simplification in probe() is really worth this churn when that
ugly cast is needed? The reason the two tables differ and do not
both have pointers already is precisely my dislike for that cast.

Anyway, something like this instead? Or _name instead of id?
Whatever...

#define MCP4018_ID_TABLE(id, cfg) {				\
	.name = id,						\
	.driver_data = (kernel_ulong_t)&mcp4018_cfg[cfg],	\
}

> +
>  static const struct i2c_device_id mcp4018_id[] = {
> -	{ "mcp4017-502", MCP4018_502 },
> -	{ "mcp4017-103", MCP4018_103 },
> -	{ "mcp4017-503", MCP4018_503 },
> -	{ "mcp4017-104", MCP4018_104 },
> -	{ "mcp4018-502", MCP4018_502 },
> -	{ "mcp4018-103", MCP4018_103 },
> -	{ "mcp4018-503", MCP4018_503 },
> -	{ "mcp4018-104", MCP4018_104 },
> -	{ "mcp4019-502", MCP4018_502 },
> -	{ "mcp4019-103", MCP4018_103 },
> -	{ "mcp4019-503", MCP4018_503 },
> -	{ "mcp4019-104", MCP4018_104 },
> -	{}
> +	MCP4018_ID_TABLE("mcp4017-502", MCP4018_502),
> +	MCP4018_ID_TABLE("mcp4017-103", MCP4018_103),
> +	MCP4018_ID_TABLE("mcp4017-503", MCP4018_503),
> +	MCP4018_ID_TABLE("mcp4017-104", MCP4018_104),
> +	MCP4018_ID_TABLE("mcp4018-502", MCP4018_502),
> +	MCP4018_ID_TABLE("mcp4018-103", MCP4018_103),
> +	MCP4018_ID_TABLE("mcp4018-503", MCP4018_503),
> +	MCP4018_ID_TABLE("mcp4018-104", MCP4018_104),
> +	MCP4018_ID_TABLE("mcp4019-502", MCP4018_502),
> +	MCP4018_ID_TABLE("mcp4019-103", MCP4018_103),
> +	MCP4018_ID_TABLE("mcp4019-503", MCP4018_503),
> +	MCP4018_ID_TABLE("mcp4019-104", MCP4018_104),
> +	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(i2c, mcp4018_id);
>  
> @@ -157,9 +161,7 @@ static int mcp4018_probe(struct i2c_client *client)
>  	i2c_set_clientdata(client, indio_dev);
>  	data->client = client;
>  
> -	data->cfg = device_get_match_data(dev);
> -	if (!data->cfg)
> -		data->cfg = &mcp4018_cfg[i2c_match_id(mcp4018_id, client)->driver_data];
> +	data->cfg = i2c_get_match_data(client);

NULL-check here? I know the original i2c_match_id call is not
checked for non-matches, but that feels like a simpler function
than i2c_get_match_data. And less prone to changes.

Same comments of course applies to the mcp4531 patch as well.

Cheers,
Peter

>  
>  	indio_dev->info = &mcp4018_info;
>  	indio_dev->channels = &mcp4018_channel;
