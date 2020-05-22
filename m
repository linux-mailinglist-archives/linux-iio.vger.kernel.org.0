Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1FA01DEB31
	for <lists+linux-iio@lfdr.de>; Fri, 22 May 2020 16:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731415AbgEVO7T (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 22 May 2020 10:59:19 -0400
Received: from mail-am6eur05on2067.outbound.protection.outlook.com ([40.107.22.67]:6078
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730870AbgEVO7S (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 22 May 2020 10:59:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VQwrnMMHJQUPrrIUxJ2TIaZXsLsgSjJpUTAWOMAslPRijyu11/I0tv2RpJxh6vw7oJ0iS9ZBcAqrR06YsqpxmSdVlKuGn8PmO3Qi+o3coetgtr+n1YizMPZGs7lXopwWPRCeAWC8Yh4bgxr0v3l7NL+xS5Wdg2cFoJdPLlKQ0Yf/t+leUJdJrQ2Rz6xom7DHLLdIPmUzIy7sFPOYB/6+u2+/yW3/WrYLhzBgBNsNIbhyEl1TI0mO9/tb1/XCRe8sUV/INxm2VTwsiVoV+lXoiHRMaKe4aeWhCja4s5Pp0Ztht0ONT00t8c6K6ZfUp415UeC+VuUYYinVU1GzMH1Skw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aPZ0XD2LsSrwCT0U2dGReWMLnUYhbxZJ0vfAMN91ov4=;
 b=H0JHuPh5dupFWOGAud4BHesRSmZ50rwkbpSS/mKnbrovhewNfWj4xVNQFcILRrr21pkpvAw/Adq6H42B3cFnqdcSPOa46gpgDtazLl6w2azUbo74JqDPeoItBGgy12rmuqn0m74g3tDtj9d2CXaGQCodyFZTYaKXdk5WZUCHywgXxn9z7JOPLsQs74lQct4yIU9hdygyuOY7GW45iQ5eEpoRzHO0nFhJdT5Yuz2qy/DQ4+0HU0GjuQ8KdgNv+Tbqhh3bT16RP3y3a88xpkD0NPwRIZ45+QPcR28tjDayd1L1UCEABtk+lPUT9Zvr39ITAaV657/fjb45TiJepxVvjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aPZ0XD2LsSrwCT0U2dGReWMLnUYhbxZJ0vfAMN91ov4=;
 b=S9LcB1nND8mNqw/o0at1t/DPc+cRNAIOEmCIcSfK4laWg4sf0qC7PRb7sP+ifiUwZ1j/G4SnIi0UxUuoa+W8hHLUvPqB6UNSI5JApzjT2c8+ttYvRJ5V78vxcZsh9P2RTuZe366l+RT0dV+9T0/SCQALLOVGgeiWbXi+w2sDCPY=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR0401MB2287.eurprd04.prod.outlook.com
 (2603:10a6:800:2e::19) by VI1PR0401MB2525.eurprd04.prod.outlook.com
 (2603:10a6:800:4f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25; Fri, 22 May
 2020 14:59:14 +0000
Received: from VI1PR0401MB2287.eurprd04.prod.outlook.com
 ([fe80::9d5c:685e:4b51:fa60]) by VI1PR0401MB2287.eurprd04.prod.outlook.com
 ([fe80::9d5c:685e:4b51:fa60%3]) with mapi id 15.20.3021.027; Fri, 22 May 2020
 14:59:14 +0000
Subject: Re: [PATCH v2 1/4] dt-bindings: iio: imu: bmi160: convert txt format
 to yaml
To:     Jonathan Albrieux <jonathan.albrieux@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
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
 <134f419f-de85-f14e-0331-49b8bb72625c@nxp.com>
 <20200522142633.GA21655@ict14-OptiPlex-980>
From:   Daniel Baluta <daniel.baluta@nxp.com>
Message-ID: <2cb64245-a3ec-b6c0-5f64-b2fdf6cd3689@nxp.com>
Date:   Fri, 22 May 2020 17:59:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <20200522142633.GA21655@ict14-OptiPlex-980>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR01CA0094.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::35) To VI1PR0401MB2287.eurprd04.prod.outlook.com
 (2603:10a6:800:2e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:2f08:5904:2000:15db:c74f:dbc5:65d3] (2a02:2f08:5904:2000:15db:c74f:dbc5:65d3) by AM0PR01CA0094.eurprd01.prod.exchangelabs.com (2603:10a6:208:10e::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.24 via Frontend Transport; Fri, 22 May 2020 14:59:13 +0000
X-Originating-IP: [2a02:2f08:5904:2000:15db:c74f:dbc5:65d3]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 33e064dc-59ae-4616-4cb3-08d7fe60b134
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2525:
X-Microsoft-Antispam-PRVS: <VI1PR0401MB252594F89AAD6D042101EF20F9B40@VI1PR0401MB2525.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 04111BAC64
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8KGDYIWJH//YDHsXnNdYJAmb6FqgZEIZdegqRkmBIMc7Mj5RS9OMTWGVeqhttB8lqZfHtmNi3Fhek0Aip6cb9g00FgpriKzZJXv5+tRrPQtG/nMshqqfInypGxoFxkmLzO+7itFwa9F27sq/Md5RfG8j+3n5htDdqDnRfR9KezummQi5orA44tvVk/pJ5BmdQ+E085VEPRERJYDD0DyWs1jrq9cC076ezHnztK8sV9Ddgup3PIwHL7bIbEJvuVP3ui9nDaYPjgufqtYk+45tIP4V2MCRwuU1ldV6oQuU4MrwduZ4hAqsUsZFu9H3o4n+QtmhZaqBSf8JJ7XgMV8Qr1PnPuC7AS4IRsfbBEzZbHohwCDnrnwI2XAYli3bIize0qHo8G21i6LumbTdZ3Wft3R9tTMXnPHbSO/KIuj3XrhGyidEf3EIgjMToUyhRTAiQgD8gHfLRQVhguQkRY0Wp3cFirtHUXDa5zsfiaWfuq+R+0HS5qFVQ85+KhIwsUqv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2287.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39860400002)(366004)(136003)(376002)(346002)(54906003)(316002)(478600001)(36756003)(8936002)(16526019)(53546011)(52116002)(8676002)(186003)(5660300002)(66946007)(66476007)(4326008)(6916009)(66556008)(7416002)(31696002)(6486002)(44832011)(31686004)(2906002)(86362001)(2616005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: UF+HvYh5234mdsbbuBuDZStBWgZVf5JgzWQEMzf7l/ZaivxNEI3iD7P3w0lh8v5KIlJJcY1hqMOozgX+DHchbGBFhCwNsjKJxmy0x5YIg3+Qgz4yyhUzii9/XdxQPFe3Z25OiWK94qXW/y8Gi2KxXnM08LFzCKymKOmyUHr0t4tLSe2HRPgCxDC+3i17G7YgIkvSt7+06EX9ttavIGC80jdf2HipfKrJcPViolw9dZZaOtYRCfUl0KLYG4OB5eZg731oDUo9cDdU+s+bi/AxKyh+tNiKw2fAhK3Si0pT7rrgoJf8Sgxxa9+vFksWtCTMyogAi8L/UIIZXujDs0NcdDvLG3rYKwUVAEQ956fDWkRyP7dThsJPvWTp2BCenikqF4pcqz3lFNWZ0ZwzBbk1XD6M1ojqEXlu8BBZa89b0gIOejOHVR+n6bg6cTblf9ouO21HKLj/W/amMZaPQ2aWQlpHWFPhM5m9MblmRqgWOemXy3sw4vJND1It7J1VFck/P0xtUVJ6tTntBid7tgBBIJccT1p1QE8kb4GfAZN945y1G3lkY9C3E7GnYXTTRwRD
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33e064dc-59ae-4616-4cb3-08d7fe60b134
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2020 14:59:14.1743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AvxYZ+6ebzUALnKu9CUfH2BPDQ1LoZbmxqQy38YWwzcy3xDiIad0kzwbnRSJncBeLKT/7lkCZS8onDPYFnCtiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2525
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


On 22.05.2020 17:26, Jonathan Albrieux wrote:
> On Fri, May 22, 2020 at 01:47:21PM +0300, Daniel Baluta wrote:
>>>>>>> +
>>>>>>> +maintainers:
>>>>>>> +  - can't find a mantainer, author is Daniel Baluta <daniel.baluta@intel.com>
>>>>>> Daniel is still active in the kernel, just not at Intel any more. +CC
>>>>> Oh ok thank you! Daniel are you still maintaining this driver?
>> I can do reviews if requested but I'm not actively maintaining this driver.
>> If anyone wants
>>
>> to take this over, will be more than happy.
>>
>>
>> Other than that we can add my gmail address: Daniel Baluta
>> <daniel.baluta@gmail.com>
>>
>>
>>
> Well if you'd like to review this patch I'd really appreciate :-)
> Forgive me for not having understood your answer regarding the maintainer
> field, can I add you to this binding as maintainer or are you saying to
> not add you? Thank you and sorry for the repeated question,
>
>

OK, so I think would be better not to add me as a maintainer because

this would set some expecation from people, and I most likely won't

have time to met them.


Can you instead add the linux-iio mailing list as a maintainer, not sure

if this is a common practice though.


