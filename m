Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C19C253105
	for <lists+linux-iio@lfdr.de>; Wed, 26 Aug 2020 16:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbgHZOQb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 26 Aug 2020 10:16:31 -0400
Received: from mail-vi1eur05on2113.outbound.protection.outlook.com ([40.107.21.113]:52832
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727879AbgHZOQa (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 26 Aug 2020 10:16:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N6NfjQWtOEukdGgRVfYx4U0puUVBov3N49sToLSIHX/U7vXHyTkh9S3o9LLuaEPuMisbVjzXGhLwsMLsQoEEqZ17ty/+SGjwKsXRd7bbBasgNaoBAUOD433mmjLiM/huBoOH/J6WPe0cP9rOXFFez0kz+1VNQz4kHnV7Kl58cOpzdWQL/MYHPJAuhYaEpbOsRaTKRmsYAVfbQ9VQrA4vPOY0/vz0R2+jVr1Fwwy2BkoCGFmqbFacFwyoEY3ojPSwnrK/YKj0lHwtkiu+F1rLiN+1xZ2er5E4JYRP43X7dQbKbStHaLOUyMhljGndQhF4fhOuA6Es7/WqF2ayVzTz9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ar2MpUvbq4BMKiEiQJablWhCZb6iT6rCmOiZuZeLwLY=;
 b=hWwbH7iwxTVJo7rwvLxBni4we4FiFjJUm2xD2eKMeOrIY+g+5iTnedrkhHglPXml8y23g7NLxtw08RbyPvXttrnocip0KUti06YQOaDDaalN7zt5Er0L4lFX45NOkp5ir0L4DkLWPlYRWbsKm0pGX6FpDZT33riIckFGlo4qICUd+Qga0PpBHb/qi4B5o1OWkfIoVoZpKtot93DliJv9qxOzNtdKbc0ql6YEvxRgHc84lZmCV9MAi2O3EhN4PUu0Bv8yXX59iM/ASLMfRrUyeK6AvnkEGmUhuwMI0FJcJwS5X/gbcO4WI/tbiYxz7hkHtlqC6WBrD8CxwiQCW1mqbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ar2MpUvbq4BMKiEiQJablWhCZb6iT6rCmOiZuZeLwLY=;
 b=OHt6JFqFZTQA3fxXeqdqTgWe53IgeMt7mhYQ1twDKxTs89fmnVrVO5wd2ONR6xialXL/ye0BZmVyLIDmCU2iMiEJRMGggBIL4YYXTcN1X+CIMSb2bqz4nDHxW0qZ5p/kQCJzXgf4AnOCZGpEnf/ee/l8uVqkwh7KKHevEgZUkgU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB7PR02MB4476.eurprd02.prod.outlook.com (2603:10a6:10:2f::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Wed, 26 Aug
 2020 14:16:26 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::3890:7b1:97a6:1e47]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::3890:7b1:97a6:1e47%7]) with mapi id 15.20.3305.032; Wed, 26 Aug 2020
 14:16:26 +0000
Subject: Re: [PATCH] iio: dpot-dac: fix code comment in dpot_dac_read_raw()
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200826000844.GA16807@embeddedor>
 <3fb79fa8-e86b-111b-a4a7-5da767d40b52@axentia.se>
 <3528f053-70d8-bd12-8683-3c1ed0b4d6e7@embeddedor.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <13e9b0cf-9fae-5dcf-d0ac-4beaf18295d0@axentia.se>
Date:   Wed, 26 Aug 2020 16:16:23 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <3528f053-70d8-bd12-8683-3c1ed0b4d6e7@embeddedor.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1P189CA0021.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::34)
 To DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.13.3] (85.226.217.78) by HE1P189CA0021.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend Transport; Wed, 26 Aug 2020 14:16:25 +0000
X-Originating-IP: [85.226.217.78]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 68da1dad-7057-40f5-196e-08d849ca9e70
X-MS-TrafficTypeDiagnostic: DB7PR02MB4476:
X-Microsoft-Antispam-PRVS: <DB7PR02MB4476EA7F2E37BFE1ECE95F4CBC540@DB7PR02MB4476.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +Dg0K4oj+QnSid8x7Z4L1qahqoMn6WOfVdADv92jyAiSTwMAByiKoVesdJsDe0w5s6axLwGxsZ1/HSwdB6VB1wYxpb6iiaTB9kTPNWruycaj3+VIWxtVf+NVXFc5XfiKKJfvBsbyOU7Zc+9lD9jRp8m6CV5E7rs503c0oeR59hPZR1w4H3wMjBCUCPoucv1YammeHpYjS2VUUakupDFcxGU2cvPgEudnKN+cNvjrcseYoOaPUJRC+pjLTF9uQxlpwenkRzad5SCy3C2L2qTW079aucrDO4jMnutBORkpkwLPLBnZPwyzox6QIgR3h0DO58cea3MUaHLg+nreOPYb/DNWsry0R1314nsycAj7vjv97V/NHnLX8n4Z7g7j/rmd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(346002)(39830400003)(396003)(136003)(16526019)(956004)(2616005)(186003)(36916002)(26005)(2906002)(6486002)(16576012)(31696002)(86362001)(52116002)(110136005)(83380400001)(4326008)(36756003)(8676002)(316002)(4744005)(53546011)(31686004)(5660300002)(8936002)(66946007)(66476007)(66556008)(478600001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: BZdzBkdeNfTdMu26JxT0xq4Xqomm2Aslh5hL3dtLgoyLIKJEfZkOg3qqSNtc2w2dsS670tRk8aSVGxtj1fbYIWO7aSEQnfkKUAzrOdKQ5HKPKsI3I6vl34gHgd30L2I+Npgl8dKyqm/FmuiEDnXVtdhqy2MLMNARcA486/2VgiXqILaMplQZ3aq06oRynIPStWn9RxpaIKSXwlI5ZTKJH6Isskpi1Zs8SOHtj9l89GhGsKY2MRHmRzcor3o0BAQYKFMH7Qk4nFW72S8s1J0EDSSIroCkdcvZgp2uWQVvYga0160nGNpHP2+64Sx06OIzCkuAKHJ6KMwr7SBg38Plu0t+nin+FH1/ucsqnyZZIwkfqm3gUroSaHA5WaS7twDXg0HLBOdp2ulKria7K+0pPE8Cio7Gv7NVlnhcnyeM2wlkJNA99M688ZgvGGIu15+4IBytVopm9cX5L+XsK+x/aJ1wOxA2e616BW1iOoXO4Jq5viq3y0xGUsoZohcsITpAJFiQ6/vHUdLH6pX0rxPQH4ePAOn2LNTeruXXW7M4SwhnN8uRLlGeSi0uhtAtfjBoKnXjAAEqp1y2OkD5wY2GEnnCQ7vMtBajBHE3ARttQG4tz3/VpsKxOvHfj0EXdB1HW/LJ0YODCbEf6UZZHqc62A==
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 68da1dad-7057-40f5-196e-08d849ca9e70
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2020 14:16:26.4732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MEzYfru1cEOS/rBdXXXWNUETsDpJbT7pwIGcKs8i1KTgf/6O/0pH0ZNKl3b0wG95
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR02MB4476
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 2020-08-26 16:17, Gustavo A. R. Silva wrote:
>> And just to be explicit, this fix is for 5.9.
>>
>> Acked-by: Peter Rosin <peda@axentia.se>
>>
> 
> If you don't mind I can add this to my tree for 5.9-rc4
> and send it directly to Linus.

Fine by me, Jonathan might think differently but I can't find a reason why.
Just about nothing is happening in that file and the risk for conflicts is
negligible.

Cheers,
Peter
