Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9022226386D
	for <lists+linux-iio@lfdr.de>; Wed,  9 Sep 2020 23:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbgIIVZN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Sep 2020 17:25:13 -0400
Received: from mail-eopbgr80133.outbound.protection.outlook.com ([40.107.8.133]:12291
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726426AbgIIVZM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 9 Sep 2020 17:25:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mYJINJm9JeGe/8CIIKhNZA2gdUSbBrQ3STgPED9ufR09NGJcHEQ5pPPoDwm9Bxp+tUzis57WzSG1kpDrup9OSkGXb+fUD80T47QA3TcYJ3jOed/bIDfgFzWJgFaMyoW/A88AVCfUgnm4xkuF98cOMC39o0ufMz2viAJu8yg9jyh0QcywBZDj+vyVGhNMD+I3GNLInNAhbPDPdO3+sNHOJjMqeXinyO9TWY0IZT8j00QL3AxfJCcY+QDoYwsdsMs+nKPky924ripg9mle0boPwtLAiw4WTV5OVLFMX9us3VHjIt/jPcfzaJEj+fIxL9dVI1cEUlzywGIx7tmMe9oyNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IZJMthgBh6Yecurakzkp2jUbjUb9gyP3xSZyjASBDjg=;
 b=FCx5tUk0LD0dQqREfYPadkjwEs7myKAMSDsIzCsp/baZymE+VaakeL1nhSb8q3HFJdilRfT30TaSJ47Fdk66oaUffJFbnlxijYFaSAU6Mj5j7fKNx/mDC61Q9bamSJqXGSFD0X+4cDOqZFWWHm/29PlCZbb6sqIV7iH53bNtnYpcMD1LC5O+bbSwebB07aAUkuiZQIyxJAReu0MDz7QG25SaVNb8lHPj4QBN7T+PFHSXfbWBccoJYtsDNK0CBRbGcNYROFsUleUNhi9zw2zkS6PyE9ztmiX2WW+RxF7MRemHbNsGZbM192FWdZObqKvVnexxs2PYrI2P8Dp7c60+dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IZJMthgBh6Yecurakzkp2jUbjUb9gyP3xSZyjASBDjg=;
 b=G3TaQOvzX9XSAA0EhcoDvyYIvYOcY2QYWumsF/z6CS/1m2XMQyGZ1yyGMZNi4B0mG655mUxZbK5FHt9s+OKN8U0uDo8QcX412r2rPcbliK8niozjmz7L5i0UfVAb3b3/8XpJIL5f4lz3UNdYQ9vy3+jjQzsgaSTnbQKidn30oZs=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB8PR02MB5385.eurprd02.prod.outlook.com (2603:10a6:10:38::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Wed, 9 Sep
 2020 21:25:07 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::3890:7b1:97a6:1e47]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::3890:7b1:97a6:1e47%7]) with mapi id 15.20.3348.019; Wed, 9 Sep 2020
 21:25:07 +0000
Subject: Re: [PATCH v3 08/18] iio: adc: stm32: Simplify with dev_err_probe()
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        linux-iio@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        linux-amlogic@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>
References: <20200829064726.26268-1-krzk@kernel.org>
 <20200829064726.26268-8-krzk@kernel.org> <20200909193600.41970d8c@archlinux>
 <CAJKOXPeo8SXWaRmiFG6z+t9jcnaSMRpvRPm2X22Rf6rtEeKVew@mail.gmail.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <a37c69f2-1f16-2680-2716-0c1b77748d55@axentia.se>
Date:   Wed, 9 Sep 2020 23:25:02 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <CAJKOXPeo8SXWaRmiFG6z+t9jcnaSMRpvRPm2X22Rf6rtEeKVew@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: sv-SE
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR0902CA0001.eurprd09.prod.outlook.com
 (2603:10a6:3:e5::11) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.13.3] (85.226.217.78) by HE1PR0902CA0001.eurprd09.prod.outlook.com (2603:10a6:3:e5::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend Transport; Wed, 9 Sep 2020 21:25:05 +0000
X-Originating-IP: [85.226.217.78]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b1b02ebc-f8d3-42fe-951a-08d85506d2f4
X-MS-TrafficTypeDiagnostic: DB8PR02MB5385:
X-Microsoft-Antispam-PRVS: <DB8PR02MB53852F1647983B76BE708E92BC260@DB8PR02MB5385.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:651;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8yzyeAC5Z+f+C2LwKdb9uS719Gj8+o8StzD2+0DJxOLT8s/HrK+ICpmazEK8Af1sFMIKoSa4aCF7f0LoH+E1K802zIN6lIW81Ozgu/nbu8sHpbYQyGat/Ot8qRzTQfYugcrU0tbufFCteZA05Jx7Ihbim2QwKrhKdtp/XtftrlADaLfu+PFdG2GZwTB9GT+LlkM0WNTvgwjTbN6tUq86AdtPp9922Gbs4fw9oVYxG5pBnrLs0DC9qFlf1cv23zQfpNHr/WjA7JXTrf1NOxDSSGrgE4k1sGXRo8yzZm/Du6wwpqAAaUKSkAmND1ROc1ssOZpbMt316xXYOQIt9a7t3E6QcjlGGvYRvbIyXgAvPwzVJ21cESFBEx4Y8B6e5LJAzp9HIAaR+jDt3m/AwcVj9oUszcuUuZ74ZM59wEOxJRStJwAoK8yUJ3b9eMgr/U1T+1MEfg+z2U5FY1+EfwMPGw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39830400003)(396003)(346002)(366004)(376002)(31686004)(31696002)(86362001)(8676002)(36916002)(36756003)(186003)(16526019)(5660300002)(52116002)(26005)(83380400001)(7416002)(2906002)(4326008)(478600001)(54906003)(66476007)(66946007)(16576012)(66556008)(6666004)(316002)(956004)(53546011)(8936002)(966005)(110136005)(6486002)(2616005)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 4rqQZgxKS96+5ceqLyJEiDZ77uW93T31XCKqg3GvUGekpZJZsZeDyU5li7gHNw9/6IVfKxv65Dh2BFmipX7NwxIBLRvk241/a/s8mJSmwcDljJ537Nc032D/Fc7VxCh/TDky/1HOOzbkBVv28fTsIYzMPCjJBSvoBsti5nTfcvxuN4bSsNevU11wrN5F9vCdNR9zE0DAsBRRZv5Klehh9v1zFBydWymHb9t5jwThF5wHMncl8kzQLS1PQoXKl4Sres9gL/X/ild5dIEFKiUHCD3C8LQxw3Pcwj6P/4cVvVzho60wAryfBCHCOXMxwH/UTT9NJdXi1SrZ5w3Q59tcu2+WoJBFWKLi3+OBTIwBwRNkLlL8/M3VgTmWTvUWgdLzaToodCXedu3Kw8qG3bB1CQbuIR/3QXefMgh/Hv5zP1xccrhlh4/KqJXZ39LkRlsQZi5lMYU0s70RKAEA55LVHiEtSrDxsB1whdl6QQTBJPhMDmkXTTljIiNLV8A7s8KVnahy8SAd9yr6lkZtbqLhYGrpvYlXBSFyDtYVZoLsyqG2W9riSzK+OKB9kxRq3OKHjImfIfxG9332zmA8Y+XJ1qNwOKEZx7wEAwIAwuNdTkEksfRKf4Indcmni61lc+Qw8fegKakA870CdLZo/aLhUw==
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: b1b02ebc-f8d3-42fe-951a-08d85506d2f4
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2020 21:25:07.3242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dky/bLufZI+BLqypO9/PQpkyhhE+C+CFCHYu/bRaBtVKF47a3tu2W5CHiKgoHsti
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR02MB5385
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi!

On 2020-09-09 21:57, Krzysztof Kozlowski wrote:
> On Wed, 9 Sep 2020 at 20:36, Jonathan Cameron <jic23@kernel.org> wrote:
>>
>> On Sat, 29 Aug 2020 08:47:16 +0200
>> Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>
>>> Common pattern of handling deferred probe can be simplified with
>>> dev_err_probe().  Less code and also it prints the error value.
>>>
>>> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>>> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>>>
>> I don't have the thread to hand, but this tripped a warning next
>> and the patch was dropped as a result. See below.
> 
> Thanks for letting me know. If you mean the warning caused by:
> https://lore.kernel.org/lkml/20200909073716.GA560912@kroah.com/
> then the driver-core patch was dropped, not the iio one:
> https://lore.kernel.org/linux-next/20200909074130.GB561485@kroah.com/T/#t
> 
> So we are good here :)

No, we are definitely not good. See below. That means "See below", and
not "Please take a guess at what is being talking about".

> Best regards,
> Krzysztof
> 
>> Jonathan
>>> ---
>>>
>>> Changes since v2:
>>> 1. Wrap dev_err_probe() lines at 80 character
>>>
>>> Changes since v1:
>>> 1. Convert to devm_clk_get_optional
>>> 2. Update also stm32-dfsdm-core and stm32-dac-core.
>>> 3. Wrap around 100 characters (accepted by checkpatch).
>>> ---
>>>  drivers/iio/adc/stm32-adc-core.c   | 75 ++++++++++--------------------
>>>  drivers/iio/adc/stm32-adc.c        | 10 ++--
>>>  drivers/iio/adc/stm32-dfsdm-adc.c  | 10 ++--
>>>  drivers/iio/adc/stm32-dfsdm-core.c |  9 ++--
>>>  drivers/iio/dac/stm32-dac-core.c   |  5 +-
>>>  5 files changed, 35 insertions(+), 74 deletions(-)
>>>
>>> diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
>>> index 0e2068ec068b..3f27b4817a42 100644
>>> --- a/drivers/iio/adc/stm32-adc-core.c
>>> +++ b/drivers/iio/adc/stm32-adc-core.c
>>> @@ -582,11 +582,9 @@ static int stm32_adc_core_switches_probe(struct device *dev,
>>>       priv->syscfg = syscon_regmap_lookup_by_phandle(np, "st,syscfg");
>>>       if (IS_ERR(priv->syscfg)) {
>>>               ret = PTR_ERR(priv->syscfg);
>>> -             if (ret != -ENODEV) {
>>> -                     if (ret != -EPROBE_DEFER)
>>> -                             dev_err(dev, "Can't probe syscfg: %d\n", ret);
>>> -                     return ret;
>>> -             }
>>> +             if (ret != -ENODEV)
>>> +                     return dev_err_probe(dev, ret, "Can't probe syscfg\n");
>>> +
>>>               priv->syscfg = NULL;
>>>       }
>>>
>>> @@ -596,12 +594,9 @@ static int stm32_adc_core_switches_probe(struct device *dev,
>>>               priv->booster = devm_regulator_get_optional(dev, "booster");
>>>               if (IS_ERR(priv->booster)) {
>>>                       ret = PTR_ERR(priv->booster);
>>> -                     if (ret != -ENODEV) {
>>> -                             if (ret != -EPROBE_DEFER)
>>> -                                     dev_err(dev, "can't get booster %d\n",
>>> -                                             ret);
>>> -                             return ret;
>>> -                     }
>>> +                     if (ret != -ENODEV)
>>> +                             dev_err_probe(dev, ret, "can't get booster\n");
>>
>> This tripped a warning and got the patch dropped because we no longer
>> return on error.

As Jonathan already said, we no longer return in this hunk. I.e., you have
clobbered the error path.

Cheers,
Peter
