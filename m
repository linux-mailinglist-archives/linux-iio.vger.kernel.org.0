Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9390252821
	for <lists+linux-iio@lfdr.de>; Wed, 26 Aug 2020 09:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgHZHEO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 26 Aug 2020 03:04:14 -0400
Received: from mail-eopbgr50110.outbound.protection.outlook.com ([40.107.5.110]:65195
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726751AbgHZHEM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 26 Aug 2020 03:04:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K26D+is/YdbWnb1Pi7vtsmBdmjlaTbumKYuJjbhg3unxopX6RxwcacfkH1mICI6W4X3R5cdqYOL502yYqzzNroqKriGEeC5gM3hmR27LGHaB86dUwr7Boipy2Qh0YnvPtTwdtzwR7nsZRqLrfP6mLETOf6AtxDIF9SvLN3o1zeQkhqCXyCM67szUfx+q+O9WMxhAhoFN1dcPKzxdF2XSVTleLw2C04+D9szslk7ekh9BhiXaw+naQNE6NzH7IxUjEo2pY2FAMlOFX2dw4oMh6Xmso5aPY72Pnp4CFth5HBZYk6NYHaxDCcL468m5PYktB0etqKH/IdWqgRUKor176A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2MFGdBTVaSxo/0snqsSPGuQHI5k6d6ekW5sdAyUe+ZM=;
 b=EMMGUANTPIYriGi11hgDswn/ClNSLLTSHi8MPCQmViyMPwcRLdCZZIUUROFD8e5nPqZJ7y6PWRxhMbldGZMhl+zUjsjpf1oFvhFXN8D1nMKlaMBfi/p+3M47bTBPyJk57fTQJy/MBQQkwHIMWPylheMHY/VoFbpEu9ZQ7PKbypkrFAO71soHP8YlstN1uQupF1t50rR1LKgTf0L/TRbPYEU9lhadgAZvrApVNzJN4vs4Y++lPmsrzmK+qTvVAQrO8X59N6njCI/CwMQgyT/7dOLXxHBf7TPZzJmgXBqNq+uNVOsGD3CIygi3zEUSEgpbxmu7lKNldwOFd+Y6exEPYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2MFGdBTVaSxo/0snqsSPGuQHI5k6d6ekW5sdAyUe+ZM=;
 b=Z9haUe+k0481/oTlMmFdTv7RBpFEScnEtLr5ggE6/llGAT4aDRlLKU8qRtO4fdR6EfuGcK18/ki6ZEXZJotwrkz9ImeHj1jRrhT4mRiiTaBMlqqMc9mj1uOBwoyjhQMxFR4Mmdtmj6TXDFDoN3noe/UhfJIJwULcjkviSX8QJo8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=axentia.se;
Received: from VE1PR02MB5487.eurprd02.prod.outlook.com (2603:10a6:803:115::17)
 by VI1PR02MB5358.eurprd02.prod.outlook.com (2603:10a6:803:92::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Wed, 26 Aug
 2020 07:04:10 +0000
Received: from VE1PR02MB5487.eurprd02.prod.outlook.com
 ([fe80::808c:ab48:64b2:ecf0]) by VE1PR02MB5487.eurprd02.prod.outlook.com
 ([fe80::808c:ab48:64b2:ecf0%3]) with mapi id 15.20.3326.019; Wed, 26 Aug 2020
 07:04:10 +0000
Subject: Re: [PATCH] iio: dpot-dac: fix code comment in dpot_dac_read_raw()
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200826000844.GA16807@embeddedor>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <3fb79fa8-e86b-111b-a4a7-5da767d40b52@axentia.se>
Date:   Wed, 26 Aug 2020 09:04:05 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <20200826000844.GA16807@embeddedor>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR05CA0207.eurprd05.prod.outlook.com
 (2603:10a6:3:f9::31) To VE1PR02MB5487.eurprd02.prod.outlook.com
 (2603:10a6:803:115::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.13.3] (85.226.217.78) by HE1PR05CA0207.eurprd05.prod.outlook.com (2603:10a6:3:f9::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend Transport; Wed, 26 Aug 2020 07:04:09 +0000
X-Originating-IP: [85.226.217.78]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a24b5f59-8530-4cdb-ec68-08d8498e3b06
X-MS-TrafficTypeDiagnostic: VI1PR02MB5358:
X-Microsoft-Antispam-PRVS: <VI1PR02MB53582411C60E2E8423E99703BC540@VI1PR02MB5358.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FHFDPaNbFRZJ3QqohMXisMMq/4DWnFlD6IgxtRVsGPoQluYfFF6EZDHQyi3293mlGLIn4Kjeb8ethAWOO37pQDWq8x535KbtAdHHP18nTcw20Pu6qUoAxrcQgRoZX4KHrvNfAYxFHPFYLOaSGv5IwsNwNagdT1XWoYE9CvhsTcoStVsmyXtVjewep4ujJORr4PgdsYvOkx5QtxBcNM04d8vUoADyKDmpgee7D2/qmLgGDdm9KCG9GZRCAYMSJYls6/ThTYbiJu+e38SCOXPFELCuHinNwIsQPva7AyjEyxCzxi9gf4pV/StXNu6iprYfNA0kZ8m1Qgq08XSi+IvTbO8g7N2+l5rGfiC7PMU1C26gkcFLn2Ho5HRhfGEOxyaV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR02MB5487.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(39830400003)(346002)(396003)(376002)(2616005)(110136005)(66556008)(31696002)(52116002)(66946007)(4744005)(16576012)(4326008)(31686004)(478600001)(86362001)(6486002)(36916002)(8936002)(6666004)(186003)(8676002)(53546011)(956004)(5660300002)(66476007)(26005)(36756003)(2906002)(16526019)(316002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: fpr38LN0ccT5IhFwYU1JWqI1c1SyPt7L/y97d9Sf2YZvcrIgBSt1WAf3ozsYxfdXefz9lawKrVcqS2BWe5IjKegHK3S1rIF7NgNyNRPfZ3r1NtrEfZbpY6riEtyek9s6ZE4m70JuLU7RmeyO7Pr1esJs60NxE46MgcVNQAKSC61vUljX3UeU+WRs9kqJqmUfwHInpgjtk52/hbmvvBPJ9mcTHxYAFiJCi5+BDxb8ISwhwsKnbgrjjKr0rS0+TTdCRw2+ylFqLB61jx3KMKIIAYrnYQvGrqnKUVAvKdqCa4rD/mO+dNaECX9h1IUMjF58x1EXk0pOhsgwQiIS3Le/61z9sa9bWY8Ih+9pDaCMcAYYAWnQELWMxX+Hxem2XxiLSkwvjokFpNYSVjNDSptasUPTPCl1NaDqtL2xEioyuJvRp2TFT+snQQTL57HV+MpmYV7LZ4aIWQLAK1f3GMqxr27WNA0HpRBM6QrNorAxd9OFgrSwsWHM8LUvyS6gpQSZzDYHJmjYlI4hiUdxBITIqoS1Fb01KE2VmhzS3YseuReLPv0FtAJy45rUK0HZpWSgJBxRKSF7aSa/ddwpptDO9amM+m5NawUlLeZtFU3KiOS4+CJSHmIQg0u4Fhan+4akaiwuowCdrWI2czBokE8yWA==
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: a24b5f59-8530-4cdb-ec68-08d8498e3b06
X-MS-Exchange-CrossTenant-AuthSource: VE1PR02MB5487.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2020 07:04:10.0696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iJ24Kg+aCEWDTnxS9uVUN6KTeFcVyhD8iKXH/f8UxoNZ4qP/SRMcfbWK+HNtdvYD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB5358
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi!

On 2020-08-26 02:08, Gustavo A. R. Silva wrote:
> After the replacement of the /* fall through */ comment with the
> fallthrough pseudo-keyword macro, the natural reading of a code
> comment was broken.
> 
> Fix the natural reading of such a comment and make it intelligible.
> 
> Reported-by: Peter Rosin <peda@axentia.se>
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Excellent, thanks for the quick turnaround!

And just to be explicit, this fix is for 5.9.

Acked-by: Peter Rosin <peda@axentia.se>

Cheers,
Peter
