Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6C102557DC
	for <lists+linux-iio@lfdr.de>; Fri, 28 Aug 2020 11:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728897AbgH1Jjw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 28 Aug 2020 05:39:52 -0400
Received: from mail-eopbgr10105.outbound.protection.outlook.com ([40.107.1.105]:2368
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728269AbgH1Jjt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 28 Aug 2020 05:39:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MEaV92KHjN5yuKl4RjM/dswCWNPDZwuFL2W5X9HBh3Ms91yF2XnKO/GR5wwhkQtynDQV8iseqbMBRGteX+k9yOJedNrb5gW8G0K7yhDfF6wUccUQ8d6XhjaNHW/dZSz8AprgAAcDEbxNCDJqcL9sCqsrYwue+DuaB7aAsEIGbc7wsO+4HmCYu7igOdQpdSIEybvD2wKFZBrW1nGOcdaOanQVwEIVE60z0Gfzewvn/a3cEmiHDQUVvg9OkL1gB33QyOYmLRB7b61EvQlOAUwOGsoVuiStmw1cETjac0j5Wrq1YBW2vduOgOHs1sLjjxffmGi2LXGvS1MR4bYQ4r0lRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pNgeA2ygkB/NFwS1rD3/V4S7tcBDFLK9CZXQYPu4Eqo=;
 b=LOicFhA6dwnj+K2FPwnbYQV8K/N1vAZji9BFH6MIH6bYvyOrifYnOhQG5Gt7HRrIJW4Dc0ciMCAHxbv3dHjpxkkxRZdFgOQ4WxJVmm7iJtjBd4Y6UaXPE/nHFrGbAB9ynrb4zduc60v2JnnaRTpHRszN/uqkkLNX7sN3T/5UB2JiChLqhZ+hawLImAONTmkd+UDGwYUcZXQO8oq+Fp2QUtm3L5rGG1030ayc12nX6cJcUSmLPndI8JA1ibm0BJzAQcWK8+iqHQDf+TEhLikXrAMJeN0qXS7W1HaQVNRNpe4Fu3bj3SeZ9Imy6rDwgtqCyFPvS7L5OZP6zsXRHy2ULg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pNgeA2ygkB/NFwS1rD3/V4S7tcBDFLK9CZXQYPu4Eqo=;
 b=RohzMIHl6Ooq0yhxgnyZQFwS/r4BZJmkDRbJUqCB/dsnF7qPGdoeVdtiJ0OaT/UcjCsCx4Tl88stn/182nO6nZJaOC/W61HgVe2jf9asaVmzZnLMCe+hCir0+wuNRWdqtf/9K2/Hw3xFdK1m9NWYipgDkXkrOLm2sELJQdGWudw=
Authentication-Results: st-md-mailman.stormreply.com; dkim=none (message not
 signed) header.d=none;st-md-mailman.stormreply.com; dmarc=none action=none
 header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB8PR02MB5963.eurprd02.prod.outlook.com (2603:10a6:10:fa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.21; Fri, 28 Aug
 2020 09:39:45 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::3890:7b1:97a6:1e47]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::3890:7b1:97a6:1e47%7]) with mapi id 15.20.3326.021; Fri, 28 Aug 2020
 09:39:45 +0000
Subject: Re: [PATCH v2 09/18] iio: afe: iio-rescale: Simplify with
 dev_err_probe()
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Kukjin Kim <kgene@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Beniamin Bia <beniamin.bia@analog.com>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
References: <20200827192642.1725-1-krzk@kernel.org>
 <20200827192642.1725-9-krzk@kernel.org>
 <f4a5777e-fe85-9f3f-4818-f7539f223adc@axentia.se>
 <CAHp75VdWDtoGxm3uxxeXveZQ3Y_ofShdYPSXHL0Vxsz5d0miuQ@mail.gmail.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <93b39762-aff0-32a6-a8a8-a60ebf1d284a@axentia.se>
Date:   Fri, 28 Aug 2020 11:39:38 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <CAHp75VdWDtoGxm3uxxeXveZQ3Y_ofShdYPSXHL0Vxsz5d0miuQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: sv-SE
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR0402CA0005.eurprd04.prod.outlook.com
 (2603:10a6:3:d0::15) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.13.3] (85.226.217.78) by HE1PR0402CA0005.eurprd04.prod.outlook.com (2603:10a6:3:d0::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend Transport; Fri, 28 Aug 2020 09:39:40 +0000
X-Originating-IP: [85.226.217.78]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 248a8e5a-17b4-4d90-784c-08d84b364c3b
X-MS-TrafficTypeDiagnostic: DB8PR02MB5963:
X-Microsoft-Antispam-PRVS: <DB8PR02MB59636197135E2BD387152F00BC520@DB8PR02MB5963.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CuCjycBQFDwqXbTnRem5udbTjZ9HzQsdkzsvgBmY0s2DRNCq9hG9AJjTci3Qe8zmwxtpOOHncZlR8h2Lk6WzYNd7rml8Cc6iL3ZORoL2sXolR6th1iv/Mn2ElD/7r3IiKcdPel9rPeBqFcbo3piH3nDSO4TJvcfUtcbmijj084sf6o2L5tYHddaW67Fxu9QSu4Twde5MiTyS0IV40yw2y3MNw/Zl2BPmnndo7Si09ezjNY91EGM0j9YQc0O5ULQCTStNhi0lem3p7CyJT/rI0+UmK293rvV4NfjhAe1WS84XHjVb+ZHW6VZr6aZuUHOJSB2QA4YmBb7tWZGg4Ug2GBcbmIjXcZ1qrD3VZqUp84Xwsda3LGPGTd10FW8KKKke
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39840400004)(136003)(396003)(376002)(366004)(186003)(53546011)(26005)(86362001)(66946007)(36756003)(16526019)(36916002)(66476007)(52116002)(54906003)(8936002)(31686004)(6486002)(2906002)(7416002)(316002)(66556008)(5660300002)(8676002)(956004)(478600001)(31696002)(2616005)(6916009)(16576012)(4326008)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: XB3aVgaRAss/NUpdGyrOcPwuFMj4Tff47dq4Yu4Txh++r2/wiDrvr3vhe8+8IdjT+uyd5yuAIhdsFLkU4VXfj3jVpi9Nk8pKLdxPCWWsSD1HN2WyQ/O570T91ee9EKrtw8UIYIyhfpKZq1nx7aCq+34DEW+dUlD5fTZXgzTncU/plcb8ZEtBvLoPZaDDac+awg3MeXJFDDf3P+UO84ONpp0qT7peVZWGDsDdpHlHEJWFQDSe8GgJP60IcbbpwYgDuSGbg8DV6dp2cxDMG9Ex5X7H2m3SuheS5DLVnLB8lbml4djM0jf5vVybilUiQxMZQkF7APF0HwPEy0zUB88OxmGo55UbnXyt6s7gkQEHuC/NKhKBzj5L+NBqITL5Nfe7bWDvO3KD3e6+FCn2CmHU7sZSABiPX01PgOqEZPcqeUbL0oVY+FaPhen5R9qbEsLxiNZrQ4BNOkgkGii4a8PLt610MQlFHxoUyEt/pPOFMMzVWtzad60wAD1CgWbBU68sN/7zKcP/OAVLNarWLtqDU6abMEpTiJmnvbyhvY4ClnZxfc9fS9A8heQW6NDxiDnzDolztUnl1NI4B/LnsklPBvf86V0M46cTCUV0G7gM/IJ1F1akM/6DkYoI4vVP2ftYO7cYvbSrQ3VjQjdur3p3WQ==
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 248a8e5a-17b4-4d90-784c-08d84b364c3b
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2020 09:39:45.4856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BgSG85hfiiKr6IkaWXTbNvT4HVPIDLBYzDbFCIte5QzFJBixVAHaaO5vpLbEmHt5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR02MB5963
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 2020-08-28 10:25, Andy Shevchenko wrote:
> On Fri, Aug 28, 2020 at 12:46 AM Peter Rosin <peda@axentia.se> wrote:
>> On 2020-08-27 21:26, Krzysztof Kozlowski wrote:
> 
> ...
> 
>> I'm not a huge fan of adding *one* odd line breaking the 80 column
>> recommendation to any file. I like to be able to fit multiple
>> windows side by side in a meaningful way. Also, I don't like having
>> a shitload of emptiness on my screen, which is what happens when some
>> lines are longer and you want to see it all. I strongly believe that
>> the 80 column rule/recommendation is still as valid as it ever was.
>> It's just hard to read longish lines; there's a reason newspapers
>> columns are quite narrow...
> 
> Why not to introduce 66 (or so, like TeX recommends)? Or even less?

Because 80 is what happens to what is recommended in coding style?

> I consider any comparison to news or natural language text is silly.
> Programming language is different in many aspects, including helpful
> scripts and utilities to browse the source code.

So, by all means, scratch that part. You still have a problem getting
around the coding style recommendation.

Cheers,
Peter
