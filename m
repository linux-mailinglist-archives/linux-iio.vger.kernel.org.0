Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 789041DE4CB
	for <lists+linux-iio@lfdr.de>; Fri, 22 May 2020 12:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729578AbgEVKrb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 22 May 2020 06:47:31 -0400
Received: from mail-eopbgr00070.outbound.protection.outlook.com ([40.107.0.70]:19683
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728606AbgEVKr2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 22 May 2020 06:47:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LvAKsiQ9vOQdx0VhJhSCyxBLxc+rq2bdcslgsKz6hZdUP2V4HqBGsjeAEc1NoJ/rUY6ABlNPlV+n0N5DVDYaHkYlku0DOED/gUV04+6wSZxk4VaQ7jWwzetcMw/tnWxOXnPU9rfcAvWV0huZBosSbVceMmZC64Xpcu7Gx8lb33Kt/tKE5ZegEiMOvwn1F5tNnPUliUOc0ShGG7ei86ch7iJea1YQHqKawqx0LLAp2OXGWhl/0Q/W6FLET3HJ+JG1W6aP9A+6HL/e4kiaPmUd3xt9ipHwTNFWTWOHeqXYUjN1YmsYOC9dBug10RKwWiMIDZnMI4U/dsAWapc+lhAIPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nIKrIR79H5jTjF4DN3LV3BWnpl7fleXw1z9+2+KWFKM=;
 b=RGVP1bY+sG6MTwj5gfrqV6++yMxvSbNaR9lzRNM1pzEXCzIbxrbKpINQgDJQCk9uF0xAbzFzWdj7uMrmbok6x/zLA3M9p2VNd+yC/Dv9PW6suEmwpYyHiKbGQDmuZXJcEydZzAxp1TT4BMc4UAwLMIEZMAVY1KtO8tPcTYZA1eCDli8B7b1X8k+QtvMTwVqEqcyO2vGCHlnbwzhLd0oTf4/6KRk0RlvwD+/YsxaAB8jtnEFAelSnz5x7Vd9iPch1CLAtWLwzXsBZSyz9SoIgQLEeJNhJQJcFxH2GyBYUP9rKwfo+MPqPx5qN8j9ECqVnXRO//ORJEjX0eJDJzc1MDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nIKrIR79H5jTjF4DN3LV3BWnpl7fleXw1z9+2+KWFKM=;
 b=S2JJ5/8YeXgTxZBSvHmYlt70w3vDW9xVyjs+ad1PTSQO8+BZfp4YaJRFI90e+3S7thJm8MRSYzA5sBBHgBHRojImOk2i7zFJSRgaiJ50IYdaOOypCFZNfbKfNOQONAUHN/yzX8bYE8ysqTJgnQQ+fLLJKQ6WHOSvMx1GXgUGgG0=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR0401MB2287.eurprd04.prod.outlook.com
 (2603:10a6:800:2e::19) by VI1PR0401MB2446.eurprd04.prod.outlook.com
 (2603:10a6:800:4e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.27; Fri, 22 May
 2020 10:47:24 +0000
Received: from VI1PR0401MB2287.eurprd04.prod.outlook.com
 ([fe80::9d5c:685e:4b51:fa60]) by VI1PR0401MB2287.eurprd04.prod.outlook.com
 ([fe80::9d5c:685e:4b51:fa60%3]) with mapi id 15.20.3021.027; Fri, 22 May 2020
 10:47:24 +0000
Subject: Re: [PATCH v2 1/4] dt-bindings: iio: imu: bmi160: convert txt format
 to yaml
To:     Jonathan Albrieux <jonathan.albrieux@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        linux-kernel@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>
References: <20200519075111.6356-1-jonathan.albrieux@gmail.com>
 <20200519075111.6356-2-jonathan.albrieux@gmail.com>
 <20200519184933.00003f00@Huawei.com>
 <20200520072423.GF3361@ict14-OptiPlex-980>
 <20200521192736.4818f17b@archlinux>
 <20200522082208.GB19742@ict14-OptiPlex-980>
From:   Daniel Baluta <daniel.baluta@nxp.com>
Message-ID: <134f419f-de85-f14e-0331-49b8bb72625c@nxp.com>
Date:   Fri, 22 May 2020 13:47:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <20200522082208.GB19742@ict14-OptiPlex-980>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM4P190CA0008.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:200:56::18) To VI1PR0401MB2287.eurprd04.prod.outlook.com
 (2603:10a6:800:2e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:2f08:5709:2500:15db:c74f:dbc5:65d3] (2a02:2f08:5709:2500:15db:c74f:dbc5:65d3) by AM4P190CA0008.EURP190.PROD.OUTLOOK.COM (2603:10a6:200:56::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27 via Frontend Transport; Fri, 22 May 2020 10:47:23 +0000
X-Originating-IP: [2a02:2f08:5709:2500:15db:c74f:dbc5:65d3]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 98668fdc-7e0f-4ec4-7804-08d7fe3d8306
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2446:
X-Microsoft-Antispam-PRVS: <VI1PR0401MB2446428C3771F09A4AE28103F9B40@VI1PR0401MB2446.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 04111BAC64
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UYpiL7L05BuvpEufSdXSZWoaCA3RsAcvS2BmJN2fgWMUSJh1ObjHkcPc4fnfcvhCf3sEJY+EDdF9Ux0hAoTo4MDsDSgSCNV0VF9a6bW9GfaeVTJRe8iClNvXTy8IrJzY3QM10IRMomvB4rxM+Sex70AoYugaOKeQPqCEBH+oAoi3XiQOs1ElVgeFiZANkvkKhaYc5Yxb7qE7myQRrkAKQ0hvjHS02naB53N4ThJdarUhCj3m3NNyp1Xa+GsWM5VIISUGH58d3iO++ueFG4jZ2tMjbtpscYJGxXuRNZXQ63A7ndyHOFGyYMNeduBLK2zcZOY8mP/mAF741Xy76RwmlZo8nIlJ1Hh4bRdz2nvk92qDLOT4lA5Ooia7o2b8udCV59lkmu6pWyTZ8OHdCsafMk09rJ04SpQ2d4tjLYD8yxLfq813nITYXhue7fThqrGfUp3ST3n6Jwbe1F/iDDQ6X30LO3XWaO0lu3iYSr5sZPkYEd4JXCFuFrkBiCPy16BX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2287.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(39860400002)(136003)(396003)(376002)(346002)(4326008)(8936002)(8676002)(52116002)(2906002)(31696002)(66946007)(7416002)(66556008)(31686004)(16526019)(44832011)(186003)(2616005)(66476007)(86362001)(5660300002)(4744005)(478600001)(54906003)(6486002)(36756003)(110136005)(316002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: GlOR20nv9afpXeUopI/ZJG+RgwfIpUNcB71f5Hrr0wDMbWzs9Nem/Vl2CqPTOD1Wppr/xhZBLZKp16gYAInrsFEvxpakMzrfNzkp4AC7JjNW/xtsJG0zFeA6w2BhcsF5UqpDoDP+x0ESdIR4UWlUoDs2dNJgwQpsBUyFySApg8ShQq9YLgmojrjawBykGyNPXL+5pBEit75L8nOVh2nibvO6qnabsdM7aVAVcx3fVuQkJVnajxN0mxk7rVxSpV6jov3BOP6pvkXCMciC4+AwMI6rFUHd/h6xWClUWGFS9kw2m2oAN2GIFLI3zhl4E7Kp9UylV4Xk656LRnADPGErCPDDG2Vw4w0aaNpRqTyFodnYMgq7/67XmwyD2Faij+mWV1SVY+N25LleaBne9DhDhBwW7+kKGpOmau4UOnK5XWjUmEO4qgsnT6d9n+BZOcqj90zZ9Z7mq7WWeUVe+fPla3ESK/ZilTHiPR4Gdy9xM5MD83pLZYGdijK4dFJsFCBzuSNtIwIuVVa01FDm1Z864+fIqmrmNZFNd+leIE+dS6G0pKapzHDjLOcL0BWyfYLt
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98668fdc-7e0f-4ec4-7804-08d7fe3d8306
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2020 10:47:24.3802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y2o3QLcmCHFATW7wFw0bkXQenJ7tEZkuiqaFnfQXRzenOEr6ia7gcQ0StvOYV3lTfocHLVsyYGykLRzARD33/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2446
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


>>>>> +
>>>>> +maintainers:
>>>>> +  - can't find a mantainer, author is Daniel Baluta <daniel.baluta@intel.com>
>>>> Daniel is still active in the kernel, just not at Intel any more. +CC
>>>>    
>>> Oh ok thank you! Daniel are you still maintaining this driver?

I can do reviews if requested but I'm not actively maintaining this 
driver. If anyone wants

to take this over, will be more than happy.


Other than that we can add my gmail address: Daniel Baluta 
<daniel.baluta@gmail.com>



