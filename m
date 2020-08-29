Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8097A256A66
	for <lists+linux-iio@lfdr.de>; Sat, 29 Aug 2020 23:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbgH2V3D (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 29 Aug 2020 17:29:03 -0400
Received: from mail-eopbgr50098.outbound.protection.outlook.com ([40.107.5.98]:39494
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726748AbgH2V3C (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 29 Aug 2020 17:29:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hn0aXS6p5/sv8XYWO4SK+vWqCuFU4f9n6XTsnU6J7J12KgNJy2B0Dm3RbYsjngp19t7LDyPKz/yCdC3NqTDPNnJaSGQOzq/iu7bN2IHe297ZgPKIRXq/N9kMBVIc2Mwg0IztjXj1qj3CpRVIKOTvRdTD5cv8Ht8Bfcld8EEUcSZLf1Vd1OBjFMCatmjD7OotJ6udkFb+6KIw4J9w9WHNokK+wBfZbro62aE/KBVfNYlcbaYArl+fqF7okC/uhj7cnv7WLqkOL1J6FWwyXaJiME8xT1AkgAdJ5DsAXNSTlbr7/9BUssgTPOACLh8Fho/Zv5J5bdHJW8m8h+qJ8am6eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7RZoAzDQdquTdeHeVMma+3cJQO8C4HEFMBoQIPKYFgI=;
 b=cQ1y3P42ED4bDPbztj2AH/w7CnJH4iEeZgZr3fJx3D+3BPoVz5izbmwh/kD6MmOD7k//i9ugOC74zKkrTOi2j/w67olngN29WN8qaKLIEVwDv4uy2lMZ7aNMVW7RaUatYpeYtZsnlrmJtKtx94oyrlrwIr/ZryDDG3UycGDeu4VT4esjMP96zEaGh0DB6JZvSwXjGLeZB1QgYhfR1uUGH4AyKOkZsQAzhoXWYEbbsijek5WvC/SMO3LOv353SoCxHTUHC1W7q8Tm/UMVyi0f8uA7PMK3a+PBANYnO9y4TbeTk4U1tpqN1dA3nlN5d5fX8TQkX3avzAn5DdosyuvJKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7RZoAzDQdquTdeHeVMma+3cJQO8C4HEFMBoQIPKYFgI=;
 b=P70HSCw4ui+GsqTkVaoTqVClwaII2tvuRt6eb22U4LlVnQTqUlst8qce9dH8bynUq/G5MOqGRGOBgDOB3GXMLWVEy2kVDrgSQSfz73Qog21Ml4jV0e9qV0mHSVplWWtULERL3sNqywkyAIHZLf3qfpoCUW9c42BUp+BPz1DNcxM=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DBAPR02MB6294.eurprd02.prod.outlook.com (2603:10a6:10:197::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.21; Sat, 29 Aug
 2020 21:28:59 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::3890:7b1:97a6:1e47]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::3890:7b1:97a6:1e47%7]) with mapi id 15.20.3326.023; Sat, 29 Aug 2020
 21:28:59 +0000
Subject: Re: [PATCH v3 09/18] iio: afe: iio-rescale: Simplify with
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
 <20200829064726.26268-9-krzk@kernel.org>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <3b9214d2-1c06-3d9c-b4da-893dbc85cd56@axentia.se>
Date:   Sat, 29 Aug 2020 23:28:55 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <20200829064726.26268-9-krzk@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: sv-SE
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR07CA0001.eurprd07.prod.outlook.com
 (2603:10a6:7:67::11) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.13.3] (85.226.217.78) by HE1PR07CA0001.eurprd07.prod.outlook.com (2603:10a6:7:67::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.6 via Frontend Transport; Sat, 29 Aug 2020 21:28:57 +0000
X-Originating-IP: [85.226.217.78]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd37290d-4a9f-44bb-84d5-08d84c628aa3
X-MS-TrafficTypeDiagnostic: DBAPR02MB6294:
X-Microsoft-Antispam-PRVS: <DBAPR02MB629401AF5E54FB8CE7C9D896BC530@DBAPR02MB6294.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1148;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J3Ht6JkO7zUDOMv2+5TfFLhIatkKfCdIDjsR9rfL+2nHE4eFD4A21cPyS8t8UjqC6w6k9k2PUsKOT/rSLJhTPNI1TEsibe2V797tVikiDLeklb0sMYhmss3oh22cTM8QTK0Gg841kd5TgkCUGEkLEcw+5EBSA/njbOhrJMLZOIPg/gG3ELPSx7xBlhfO5dNeV5CHR23JafBLqlTixZNO2F7chwJeOhxFZMzO4e+vDv9I6K6k2UjpCynrhZ0MH6sdyEt+5uP52b55mgc5JCzhm8TvpcqW+rkHoTGed2XXuNz4yhAtkuheMRoJPB6LBzs9FrJH5T6tm1neqyZBvuM3ahFiR1fVjHDQtBH1cO2DC23QEDr3YflOwjgZJ1XHs9Elggw+pwHwRh8XActBiZDzgg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(396003)(346002)(136003)(39830400003)(7416002)(83380400001)(86362001)(16576012)(316002)(110136005)(6486002)(956004)(36756003)(478600001)(31696002)(2616005)(4744005)(4326008)(16526019)(186003)(8676002)(26005)(66946007)(8936002)(36916002)(5660300002)(52116002)(53546011)(2906002)(31686004)(66556008)(66476007)(921003)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: XNS3crkVOA8muSpk2IbRG8qINiOQCEL0DyJaO4+gMKnaaYhzCxXeBMfbW7KhVw/Lhk3wJdbnFcxNsPsB+zNHrpAdppK07UBkZoalvR8CKejsYJQPwsrgCGIvlZtjEJWDVyyNEtlAwOhI2ixSszGJol1ypPnun9sNbwFURzWeeu53djNTXNkHjY6igBRUs1VX18md0s/AXHJkpOHKFsQlRAtNi4IeyJYdyCqIo2QOVP73VAPOdkldhEMKi3Cu/3HGv+TbV7zPWGOouUj9WtbfRhfA9fFCZ5JbZ1/GwRPHvLrz3w6w1vdLmBKSVsgsbNRoz2KFxD73A7Ia1TmlNGbGab8V7C+aA05BQiZAerl2kDp2ObEzZ6qbm6ZbW7VT7utUkK2AAo7vKQCMV6g7xz3bg5lfWdgDk2moEZfUglmdj+ehwDPqpF4c+Qf7qxWxWC4E3FSouciHcqY9ENDQM8AIiQVPbq9az5uusdfDM6wqLGH+xhkCGClyCvtJYucNbuz01EfcIpWwPGMLzm1allKaqJ7CZtDzIuquoK8oEYSfuY4TUeRhMvsS/P4x+DimmbVDJ+Y1ZD1AObzfYmZF7VJiFQ0PLs2diCYh2wi4rylj7AwHEuaZClx/5tBgqABo0CuRGjVycsWXR5GzxHaYjlsz+w==
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: dd37290d-4a9f-44bb-84d5-08d84c628aa3
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2020 21:28:59.1881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZE+sjYQ5XOWf02K5+EXHX+vBJ2YZ4CMzAYI4AKeCW7ypjkzrUkPQ7SMuzvxptfzZ
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

