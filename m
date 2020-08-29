Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDB06256A69
	for <lists+linux-iio@lfdr.de>; Sat, 29 Aug 2020 23:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbgH2V3i (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 29 Aug 2020 17:29:38 -0400
Received: from mail-eopbgr50103.outbound.protection.outlook.com ([40.107.5.103]:37504
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726748AbgH2V3a (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 29 Aug 2020 17:29:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QAj5DXdg/DrYZLMP0D6Ru1jV5pAVJWLv3+BbC3P5tEuHHiGlsUH6XzsH9Z6I0iRQLrcUuuVAjO88joJXDgU2tl6lgaIFKiztx4QO1GXoBlYKvJBW5wny1wPi2zJvrmsMC39/Qq8pPj3eYnfwf64RrEbrYPSXkvlkmzVlbMnkIeMb7DaJbUm7J4C4LcnmtFVqnnPO/HJqBO09Syvc4/iTscAK6vu4cUPGBGIV/G1e6HiPVq9JzxJ4An7POrN1tvmpTF8PXjkSc+GrDT9AHe2iNtXJosQmp89yXtaa40fPdbcsXizYKXxEjXuTY9nV/J3roL8Q3nn2dBHwtl3k3xynRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Oi1J4wd3y5TlCF6TlMOYxE9LsQWiMmri7Rg7agcDIQ=;
 b=iBVbvD7OovgfjF6vUWGUrbktH5EYA97Lp3+Cj9387ORbhBRzjBVs9y59+ZiTt5Yyao+iv3BoHsYeWPtAjIMkUrjpkDyZpT38skEjl9PJU96nPFA0CEgjGIDZCbOPmmvirVVgLn/X1DOXOU5fRwmeONIqEAhm+gX496Tr+I3qstlCHJbV5KQ6gh3LR9vh+biE62zEYAj/0CkDlP+7uzzn7uE+5rlwufVy2cuguJ5OiFNdyDCHid+zmQ+aVCbGx6idYLwZRojdP94K+kUucJ/0Lnwd1++JmPNk+xM8f3Gb8VOvNtmRLzURMov0Jm4xxURgBs5/izGkkk1Mo0A0TvjnaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Oi1J4wd3y5TlCF6TlMOYxE9LsQWiMmri7Rg7agcDIQ=;
 b=bTRSmGdTjjNG7Zg9NLGRBGJ5JcBzu26YG7hmD5h8/Q/upR52T7L633GPF8vCmQP7OUSUQGbbookZ7v4L7eLyzN24dSc7b64/+e8Rv4EW2XJchBxejZJu+2jAJKE7kPw+5/8IE0Iq8p6b60eismvBcw9Hug+Xq6PPhwsQSqk0HeM=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DBAPR02MB6294.eurprd02.prod.outlook.com (2603:10a6:10:197::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.21; Sat, 29 Aug
 2020 21:29:28 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::3890:7b1:97a6:1e47]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::3890:7b1:97a6:1e47%7]) with mapi id 15.20.3326.023; Sat, 29 Aug 2020
 21:29:28 +0000
Subject: Re: [PATCH v3 12/18] iio: dac: dpot-dac: Simplify with
 dev_err_probe()
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>
References: <20200829064726.26268-1-krzk@kernel.org>
 <20200829064726.26268-12-krzk@kernel.org>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <38dcea8f-87d8-d949-4cc2-356eecf93ffa@axentia.se>
Date:   Sat, 29 Aug 2020 23:29:24 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <20200829064726.26268-12-krzk@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: sv-SE
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR07CA0044.eurprd07.prod.outlook.com
 (2603:10a6:7:66::30) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.13.3] (85.226.217.78) by HE1PR07CA0044.eurprd07.prod.outlook.com (2603:10a6:7:66::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.5 via Frontend Transport; Sat, 29 Aug 2020 21:29:26 +0000
X-Originating-IP: [85.226.217.78]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 06ffa3ac-13aa-4ac1-9c0b-08d84c629bea
X-MS-TrafficTypeDiagnostic: DBAPR02MB6294:
X-Microsoft-Antispam-PRVS: <DBAPR02MB629406D74D62FB01F3E4060DBC530@DBAPR02MB6294.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1148;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pTEknyWSc8FFg7fjVHjgHtXaTZqPAeyrSDc6dCp+bJtvzqJyCHltGLXl+3XH3joCxIOKQG4ETWhAfAXjBfzabwihC1fT4GDhiCQ+3FlzVJOnCzdqTHnHSwiYFrfyCgWmzpXZlV8K1yoO4d04MdpV/nNVCd7EZQdQbteIprQ09iFS5YicewALNlqGLocaNzVyF5bbZdenh5cr8LHdoqic5GFZRAYB9ftnntdchSgH3LdzTVuxrsm/N0TIodPYdMnmq9v5ctjQyc5zDsumgl0I84zicNEOrY30XPUlOTdse1tnkiMMqpx/zt0RgARwrixGSgJC2Z/4m04t2EcRp6lG2lL5aiCo2h3+wZlJcoiooYOwf5OJZKQDNx463pfTGFBlg+Il3UUB3jlk4IpIgkKiMg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(396003)(346002)(136003)(39830400003)(7416002)(83380400001)(86362001)(16576012)(316002)(110136005)(6486002)(956004)(36756003)(478600001)(31696002)(2616005)(4744005)(4326008)(16526019)(186003)(8676002)(26005)(66946007)(8936002)(36916002)(5660300002)(52116002)(53546011)(2906002)(31686004)(66556008)(66476007)(921003)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: TigebiPTHFZDYiL8/SCUrsCKZ/QknnprkffdsQOwF6d1U60OamKEJOHduCktKrpbCojkhzGiTsLIHz4DEAv6a3Z9d8OPFMW9zrDYIiGwSXddLezWEm1ySkMhcxT/0zOJUXyeXvWyqmnUo/83PUZe2eINwK3mwh2Xu4x0euaLH3I04MhIFsgiq4K6YGTQ9hoQWF2DJjnhAL2BWCQsif7vLRy49gnqw/j+X2MOUYyq9fgyhj7++PmjNqco3rlvGK+xSkMWO+qz/Jw0KEi96OG/YfggSxvOXFze41ndMuDu9py9aBmafzROscPhzcKTAbf1wVnJ2s1uRzLh89oUTx4t0NN3iA6/GphVRMiE5Bc9xgANvkWV2TNOSK8TJlAocoVTWdd9M622dHWj1tGPvwKO6MkDCLqMlZeFrCRu5wXm8YUfnuK3ulAjF0dD03bSnSIx98JE9WpX2gpYmA0LcbLyNY+fEFGIgw894A/T6GVcLiKq1KHWQCgNdr5/20rRE8BDVEKfIqRLc8EwuUchtqma2b9KNLGJ2joteTFBKXTf1hbwZUn92We0FrGgtxttk6yyiL15AZ/74sh9hv4BKgOKA3Wt6K58bIl3wAM8ZxEzCAzRq6i24V98DCWDmYPcCsEad+vKdXfQq6YvrQhvtfENVQ==
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 06ffa3ac-13aa-4ac1-9c0b-08d84c629bea
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2020 21:29:28.1453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fsuwepUVnpSDZVGEHwXjkppZOlb0/qVW2sms6ZFZQBO4iSqrB+JqEhZ39XXhQitN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR02MB6294
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 2020-08-29 08:47, Krzysztof Kozlowski wrote:
> Common pattern of handling deferred probe can be simplified with
> dev_err_probe().  Less code and also it prints the error value.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Acked-by: Peter Rosin <peda@axentia.se>

Cheers,
Peter

