Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB6E51820F
	for <lists+linux-iio@lfdr.de>; Tue,  3 May 2022 12:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbiECKLm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 May 2022 06:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234244AbiECKJp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 3 May 2022 06:09:45 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70089.outbound.protection.outlook.com [40.107.7.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB5C30548
        for <linux-iio@vger.kernel.org>; Tue,  3 May 2022 03:06:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nPlCbZJE26NaaW8D7TMvQTzsSNq8ZeAUAo212CMcPTczX7o50mP8Si6igXkD0wdCWcrUOWo4cdILW2MbskiAzYoehhumzhhnl8MMA0gdv0lUpjdxnv9EQL6ImixPJYogv3yaHeHSjh9/lrYpJud+F3qyy6oi2nmNX0f4qfNTjbAiUjQmNlBYlffhK0cff4si5xSqvIQs7OXQNIxXSVxZsxZXG/EGAM1LbQBXTv2q1a8J+6pLHE75Zwfpb70P+i5l9kLCsDqrZzQWV/+Fav46TpNc6kIGeIf1LLAIw8CURsrm/i4X0Fe6uvMAx703m0ZPrXZ8MZv/hbE279jqAPGrPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3XBtSzl/hS4aF08YSJRCXJItuSopwwQtudQWCX89kbQ=;
 b=JH1fN9dJUW7/sfyoUar0fX5pIYzm+rA9XrVYqTnn2gVb12Yq3lg1YbFQqtlRnNconFEi+8Zqpt76wO7eyO8aXly5WxMwS+g7EFQDrbA/cxODTy+VwW31FgqScNgHm1o6Aqu5RMk+Og8tgx8XWCgs5RpUK6ZCXsvhpQki0PsKBBCbLZHkgwa09RC7GQ2GDNX8V18B2sIRR5+oA7kF2sBhyPpwSvSEkQpbTxYmjN7SSPmdaAiQZ9F1Dn/Ji26o2q18nnsH5YWc3d6IkUV8LMOaHR17PO9KFHUqxAp34oaB94JOgiVf/zo+VgpGXJQ0SIXrWYM/tuPrNBbae+vA+K1UWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3XBtSzl/hS4aF08YSJRCXJItuSopwwQtudQWCX89kbQ=;
 b=qQvpegdjrVdAxQ7BPZE13JaygYXmC4i5xCgmOT75PPRFyoVQZEaiTnmPK3xxajlD0psUeLYh2XNuqkbf63p7jpGHmQF7EuGax/awrf1dJ+vyN6JRK0VKdPyzzPxyGoH7fed1jFEymNIDi+SNdO69BgBbpC8mWk4X/MJ3PMtCNZ8f8fEoPFR7eDNQ4kzBOqplIkwhsPIyVrE9tF64GqKAkROaIin0pR9BXZHU5ZHoNiIMAobOlIJjWAQdq3u/GqWztckvJEPTLnNVR8q4g4Uv14oogMRkw3ijEGzjV6UZGAYaPsy5UnxBpC0ngEEo0KRd39SKda2ZYcp9fnZCsGIF+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from HE1PR0602MB3625.eurprd06.prod.outlook.com (2603:10a6:7:81::18)
 by VI1PR06MB6445.eurprd06.prod.outlook.com (2603:10a6:800:125::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14; Tue, 3 May
 2022 10:06:10 +0000
Received: from HE1PR0602MB3625.eurprd06.prod.outlook.com
 ([fe80::5872:9ec6:429c:9de7]) by HE1PR0602MB3625.eurprd06.prod.outlook.com
 ([fe80::5872:9ec6:429c:9de7%4]) with mapi id 15.20.5206.012; Tue, 3 May 2022
 10:06:10 +0000
Message-ID: <fe0b0767-3f43-9f93-be15-f891effe891e@vaisala.com>
Date:   Tue, 3 May 2022 13:06:05 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 08/92] iio: accel: sca3000: Fix alignment for DMA safety
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
        Alexandru Lazar <alazar@startmail.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Charles-Antoine Couret <charles-antoine.couret@essensium.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Cristian Pop <cristian.pop@analog.com>,
        David Lechner <david@lechnology.com>,
        Ivan Mikhaylov <i.mikhaylov@yadro.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        =?UTF-8?Q?M=c3=a5rten_Lindahl?= <martenli@axis.com>,
        Matt Ranostay <mranostay@gmail.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Michael Welling <mwelling@ieee.org>,
        Mugilraj Dhavachelvan <dmugil2000@gmail.com>,
        Navin Sankar Velliangiri <navin@linumiz.com>,
        =?UTF-8?Q?Nuno_S=c3=a1?= <nuno.sa@analog.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Phil Reid <preid@electromag.com.au>,
        Puranjay Mohan <puranjay12@gmail.com>,
        Ricardo Ribalda <ribalda@kernel.org>,
        Robert Jones <rjones@gateworks.com>,
        Rui Miguel Silva <rui.silva@linaro.org>,
        Sean Nyekjaer <sean.nyekjaer@prevas.dk>,
        Tomislav Denis <tomislav.denis@avl.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20220503085935.1533814-1-jic23@kernel.org>
 <20220503085935.1533814-9-jic23@kernel.org>
From:   Tomas Melin <tomas.melin@vaisala.com>
In-Reply-To: <20220503085935.1533814-9-jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: OL1P279CA0072.NORP279.PROD.OUTLOOK.COM
 (2603:10a6:e10:15::23) To HE1PR0602MB3625.eurprd06.prod.outlook.com
 (2603:10a6:7:81::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 17b80d3c-fb5f-4ef6-00d2-08da2cec8c18
X-MS-TrafficTypeDiagnostic: VI1PR06MB6445:EE_
X-Microsoft-Antispam-PRVS: <VI1PR06MB644568D770F5851947C56E6FFDC09@VI1PR06MB6445.eurprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EVxNazxNsmpLVQMBvyVVaXT8ZU/vrEoV0oaJyMQpPaq0bh6yDpZJhaFOo6TveObzvntNvnV7JxQAATc0Ue2P8eB7VqqXaAPfOp2kgFV1KUwuEViTpSnlHvaS3tqYl76JWUQmD8uXwKEn1fiHlZ0hBJDNiou1yVZPRAcVOVnG1SP1cX6eph6dOJiWOMFsAhRXjqBwx8hiXLHZf6AFvedu15B3xYZY7KO5NVh4MZWM/kSi+iA52yc8P3B80UEiaUPL75baMqx/hWrzzN7T/uHfyH4QV9S4VzUyVg4ZOczNZTRuADHbNxLWPvwBmaB/Z8mNeyxdK11X+kEvux5bu92OWpuN2IxHrLVe13rRYtuDO9MF2s6hhda6rEKLTuC7veYolDjWVDhUygUuwA0hsQIaDmhnd8SOHvM52+j++lWTStVJUkhgfNTWwZpvqmXZMSW21YyFUDNaguUHWqtiTV2wjEYiorkvAnHZLbYofNyoP3LzaAizVMEAU+R4U7qDwIcRGYCgZRywPA+ow1+DVX/TH1g3D5Ar0eIPqX8RAprjQSQRDt61hB+jtldnEBu98S3bvo7e35QGUnuATAhIH7BSFod921iJFqLK4A1lg0/eqRW599G9C41SwwlUsPWp4U/Qak+KPH5QdVlq1pCai+b9cIagqkJNd08nlNNG8niz7V7Xs+7R/jxxHc2liQM5j7g1Lz9TJgrD+Yxxxc2d71IkRDxTkfRb4NwM3GFkKIK4OOFr2g9diNBvmfvxUdf+kV8C
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0602MB3625.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7416002)(38100700002)(6506007)(6666004)(2906002)(54906003)(36756003)(31686004)(316002)(7406005)(4326008)(66556008)(66946007)(508600001)(66476007)(8676002)(8936002)(83380400001)(86362001)(2616005)(31696002)(44832011)(6486002)(6512007)(26005)(53546011)(186003)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEVyVUk3MVhaZkcyUXFXNkNWSFN4OHRHbDVXSERZOTdqOW1xMTRLZCtLeFZi?=
 =?utf-8?B?R1psUUc1eXNXWlUwbWNwQW8zSXUvQm9HbEpodGVOcERJOXJpUE8xMjVLdFlU?=
 =?utf-8?B?WU1UY1Ixb2dseXJ4dCtFQ1BQOGtYRnRoTzJHcENpZFQ4ZVNNVXVLWTdPT1Nt?=
 =?utf-8?B?cENXcEVJR2JncUZaSXhQUGRzTEhBY0NObjlOTGtIZ2Z0UHRmbTVYbWFsTGls?=
 =?utf-8?B?K3V0anVNWW1Ud1Q5eE43UW5kZjcwaHVoSUxkUUNRZDJIN3ZsSU9seGRsdmN2?=
 =?utf-8?B?d3VQQ2xoOXZxU3Yrb3RnZ3AzYzJHc2xiT2FEMVBTaUdoYnM1NEQweDcvaGkz?=
 =?utf-8?B?d1pTTGZyWTgxcHlFbTI5NzJOWEZoOEZNNFpMWEhTeXB1YmpzMS93dUltZjcz?=
 =?utf-8?B?M2RDeWNOOS9va2E3RjZIRTVYNE9xZDNhMTVwclhLcGhDVExWQjBvenZ2QzhO?=
 =?utf-8?B?bUtFMEgrbURlMmRERGE3ZW5hMlVJalZQZHFsT0JLcElvV1dOTi84M2VaUXkv?=
 =?utf-8?B?ZnBnNUVBWWlOU3RtN2R3WHZEazNudTJnMVB2RlcwcFpFTEt5Y1dRTW5ZR3Vh?=
 =?utf-8?B?UFlQTjNNMU8rdGpJUisxSUdjbHB2WUdaNnBWTVU3R3hGeGdkeUJlZTVUTTVH?=
 =?utf-8?B?TVRyK0UzVEJKZWUvc3V4bW91UnZ1NkRvUjFtMGMreDBlMWVzRDR2aUxyZXdp?=
 =?utf-8?B?cDVjMkVPS2ZoWk5seHg3YSs3R01TOXM2MTA2T3Qyb3AreWw5TGsxbnRKakdO?=
 =?utf-8?B?V3ZJQTZ3aFo1WlZJa2J6d0haREZXUzU4TFA3ZUNObUFRRm8vUlljN052cHdy?=
 =?utf-8?B?T0k4R01ZclVHREMyU2dCbG4wczFMOU1VZkwwZUZxOUdjYXpDaDVSWGhwSlhR?=
 =?utf-8?B?bXZDU1lQc1FTak5vQWhpQWlBOUpTcEtDTzRKdUVvZjhCa2lrTll2dXJKNkR5?=
 =?utf-8?B?NTZhL0V4RWlSN1kxSXdMaUMrK0JRdjZhYkNNUFlBdk44VnZoYW0rL3grc1VP?=
 =?utf-8?B?NkZmVVgwN2xJWTlIK2hraTZxYzF3cDZaQ2hob1lTdzdLNUxxSXJRNzhKOXlH?=
 =?utf-8?B?RHFSeHZpZHl0TGZmUWhFMnp3alJIRUtwa081b1kvQlA3U1V0Um1MbUFENVdN?=
 =?utf-8?B?b1hGUklXSEdsV3c0NkZQUjh2QzZRS1RLVENRWVdMS3ZQRHpkbU5GMGd1eU1I?=
 =?utf-8?B?NUFEZktzTWpqMXRZWER4WXlTT1ZCUGxwbG8wRkVBMlRadGxqQk5WdlBweTNy?=
 =?utf-8?B?SjFsUitQTXB3NGduZFl4ajd2MU1BSS9WNDkyRFgyRWZuc1RKVVpsSEFyU3BJ?=
 =?utf-8?B?MDNNWGNiRVlKYVZJTjdMVlJDVWgxbHk3U3RteGdtN2pmeUZaelhZQWJIUzZX?=
 =?utf-8?B?WDhzOHVuL3BBYjg2TGd5c2pobjlFbWR3cmZDM2RxMW5CY3dFeTA3eUNpbkFB?=
 =?utf-8?B?SE1lRnowRm1SWW1maHdSNElKWUVtaG9BblJmVGlNdFhOdnQzS0NHSGZycU9S?=
 =?utf-8?B?dnh0THdOZlJuNURScit5Nm9BVUdoMVltWDJWTCt6SjVVdVZodU9SNEd2Q25z?=
 =?utf-8?B?S3ByWG5PV2tieHJrNHh5OXlPMEw0T3JQZmd3M2VuOWFpeWZZblJGMGhPUHFY?=
 =?utf-8?B?UnkveVZaaS9DMDFYWnVrd0s0UXhGTTlONlN5c1FpUy9qVmFKRGhUeTdkYzFN?=
 =?utf-8?B?eWlCOFEwK09PZUpKc1RKWFdpVmJNRjdVNDd5Vms0b0F5WXhadEFXNFVVNFRu?=
 =?utf-8?B?c3V5NVd0U0VhMzBibXdVQmU2SmlrYjRYZlZ2WlVjd2JFaXQ5cmNTMkpDUlVo?=
 =?utf-8?B?RFAwUHVxVGhRRHBxSDFFQXc4blI5RitLLzk0dFR5WjZ1bC81RHRVWSswQ0Yz?=
 =?utf-8?B?dDFSc1dGZE1QRjdZMVVKRmFWLzlqNWJDenlPMVlNNXorK2k5L2dPTWxLK0k3?=
 =?utf-8?B?aUZNWUJBN0VlMkt1Q1ZDREVhbmZRdjRZbUcyY3JSa005ZEtzL0QrWnBXMWE2?=
 =?utf-8?B?ZDFtRUFXT0QwVWJWeWI3czdKS1k0S21LaGdFd3NHKysvQnROSkJCeEZhNDhh?=
 =?utf-8?B?d2hKeUVBM2MzZnd2NGFvY3c1OFVtNVJQdTNBZFdqdFJWNmxTSHZPWkErbXha?=
 =?utf-8?B?cnlCdXlvWXh4WjVzWlBmY1JwSHdncjdzSXVMMDJFb2hmVmlCVmkvS0lYR2M4?=
 =?utf-8?B?N3E4NGxUeUNHbFViSU9WR2pjM0ZCTC9QVHBlMzkxdFU5Zk1PYW5KTGVOemV5?=
 =?utf-8?B?RGZvTEMxVmNRR3g1Mit6UVZJRXB5QWMwZFpzZ2pReGhVbVlsakdXOEN4Z29B?=
 =?utf-8?B?VitsKytzb2h0cWlqVW4ybDJhTzRsbHNObTZFRW5lUkRTc0RaUVNSVk5PRGZY?=
 =?utf-8?Q?R2HFFDwVVwRnDLEs=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17b80d3c-fb5f-4ef6-00d2-08da2cec8c18
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0602MB3625.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 10:06:10.3133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CRHJ6Q7/kbXW7V4088rzTxNzTirbcHw3uRH3hGqB9TBE7LiL+ypALlxG4LlzPTCAReKK/ctd4AmK7HilE9JIGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR06MB6445
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

>[PATCH 08/92] iio: accel: sca3000: Fix alignment for DMA safety
Small typo in commit headline, should be sca3300, otherwise LGTM.


On 03/05/2022 11:58, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> ____cacheline_aligned is insufficient guarantee for non-coherent DMA.
> Switch to the updated IIO_ALIGN definition.
> 
> Fixes: 9cc9806e22178 ("iio: accel: Add driver for Murata SCA3300 accelerometer")
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Tomas Melin <tomas.melin@vaisala.com>

Reviewed-by: Tomas Melin <tomas.melin@vaisala.com>

Thanks,
Tomas


> ---
>  drivers/iio/accel/sca3300.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/sca3300.c b/drivers/iio/accel/sca3300.c
> index f7ef8ecfd34a..0e87746829a4 100644
> --- a/drivers/iio/accel/sca3300.c
> +++ b/drivers/iio/accel/sca3300.c
> @@ -115,7 +115,7 @@ struct sca3300_data {
>  		s16 channels[4];
>  		s64 ts __aligned(sizeof(s64));
>  	} scan;
> -	u8 txbuf[4] ____cacheline_aligned;
> +	u8 txbuf[4] __aligned(IIO_ALIGN);
>  	u8 rxbuf[4];
>  };
>  
