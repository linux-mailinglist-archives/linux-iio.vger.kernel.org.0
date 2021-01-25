Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4703022A7
	for <lists+linux-iio@lfdr.de>; Mon, 25 Jan 2021 09:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbhAYIGJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 25 Jan 2021 03:06:09 -0500
Received: from mail-eopbgr50083.outbound.protection.outlook.com ([40.107.5.83]:34580
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727311AbhAYIBV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 25 Jan 2021 03:01:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=topicbv.onmicrosoft.com; s=selector2-topicbv-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MEpNoEl0fPFTqlXdN0yOOvS9GSh/SOutISzx3X57I5U=;
 b=IoGS6LGfy0h70dKt7mBBR76jd/htAKvM+/f/a4OSMihKc/WzdOo/YY0C2HugYJK55oV2NvssPI2y6o7QvsJt6QPWNXogVxS1XpVp62Ej+tr+b7WjE0SNNLONk8M9CkC9exx2sSXU+WwCfds/gazuYOEr0F4uZsZE9Z+UILUOIm8=
Received: from AM5PR0601CA0028.eurprd06.prod.outlook.com
 (2603:10a6:203:68::14) by HE1PR0402MB3499.eurprd04.prod.outlook.com
 (2603:10a6:7:7f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Mon, 25 Jan
 2021 07:59:49 +0000
Received: from VE1EUR01FT056.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:203:68:cafe::3e) by AM5PR0601CA0028.outlook.office365.com
 (2603:10a6:203:68::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12 via Frontend
 Transport; Mon, 25 Jan 2021 07:59:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.68.112.65)
 smtp.mailfrom=topicproducts.com; vger.kernel.org; dkim=none (message not
 signed) header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topicproducts.com
 designates 40.68.112.65 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.68.112.65; helo=westeu12-emailsignatures-cloud.codetwo.com;
Received: from westeu12-emailsignatures-cloud.codetwo.com (40.68.112.65) by
 VE1EUR01FT056.mail.protection.outlook.com (10.152.3.115) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.11 via Frontend Transport; Mon, 25 Jan 2021 07:59:48 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (104.47.17.175) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Mon, 25 Jan 2021 07:59:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dFOSP8sE7XGiJTSQ4hwfvg+Jkc7vDjYzGnocgnSAj+CfkiVkGHjFAuPxkMOD8zXMkGtcdBa+FKPQrP5tNj63RONtavYomqwBYcEFBNRw3TBCvselBBF3nFrigHBECucMv2ovBl2u0YwEvFgGsxNCH0E3+CRKG4DeYBNQ2mQpF8TplnJeHeiwTpDPkSqBh7DJ4Hw7Ub9FW7VkwtA8OeZM8793W8weYINvkCruPA4sfP9eWGDxOVZsATVNS4+8rZ4wvCQxFL7OUsnwYAS6iVdGGkGSbpOI+AQuGeS0TeLTJq1BlA4ppBee1v84VmN1MWoS0/3hbst79XXtgPxSY/qG/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZB/EUfiSBKf+H5eYOWLyhijZpFJrVbxoSUSIVYkcv4c=;
 b=fu8tucty5i2S5sr8Q09dVOCN5kH57kacBACmgE488191ak6iRV/p7qheKjqBEW/DOeMKXNPeQ8jtmIV48L9V16uB0d5tP5g5m90BF7sVcteYs9hqTnQlhOUEWezRhrfYEV2WETQocr8xug0lY24x9+rrvbodxMGobum1E1sAMcrPXD2eR0SSmm4N6rpsC28UHRc1BZoiJ7d0mmyHn1jRRhgLe1nozqel9QI/gcix1ItnMZR353MOB3LpywyLoCUmRoM33ZV0qRjmNLO8aIKCw8ReTc08lRoODDWkD7PRmvrausRy/HCqMf8r07GaLHs0+UeGkV2zsRRtQlpUo24BMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topicproducts.com; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
Authentication-Results-Original: vger.kernel.org; dkim=none (message not
 signed) header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=topic.nl;
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com (2603:10a6:10:10f::26)
 by DBBPR04MB7708.eurprd04.prod.outlook.com (2603:10a6:10:20d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.13; Mon, 25 Jan
 2021 07:59:44 +0000
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::792a:b2ef:ed50:a1a2]) by DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::792a:b2ef:ed50:a1a2%4]) with mapi id 15.20.3784.017; Mon, 25 Jan 2021
 07:59:44 +0000
Subject: Re: [PATCH v6 2/2] iio: accel: Add support for the Bosch-Sensortec
 BMI088
To:     Jonathan Cameron <jic23@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     linux-iio <linux-iio@vger.kernel.org>,
        Dan Robertson <dan@dlrobertson.com>,
        =?UTF-8?B?R2HDq3RhbiBBbmRyw6k=?= <rvlander@gaetanandre.eu>,
        Jonathan Bakker <xc-racer2@live.ca>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210119124622.9490-1-mike.looijmans@topic.nl>
 <20210119124622.9490-2-mike.looijmans@topic.nl>
 <CACRpkdbFgskpPUoVK7bU1EyChEvD4e9WHhvcUJh4e1UUO2WFdA@mail.gmail.com>
 <20210123153511.1802a15a@archlinux>
 <CACRpkdZTJbAFK0j8U84pyW6za-SGJqGWnvertj8sXxc8Ou8VeA@mail.gmail.com>
 <20210124132344.7181bd06@archlinux>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.e23f1b65-3084-4bd7-abd5-c186f8c4c35c@emailsignatures365.codetwo.com>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.0d2bd5fa-15cc-4b27-b94e-83614f9e5b38.4d211e5c-af1f-4f0a-9714-ec208ef9be8d@emailsignatures365.codetwo.com>
From:   Mike Looijmans <mike.looijmans@topic.nl>
Organization: Topic
Message-ID: <5fcf1954-f257-79d2-970b-de188fca4613@topic.nl>
Date:   Mon, 25 Jan 2021 08:59:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210124132344.7181bd06@archlinux>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Originating-IP: [83.128.90.119]
X-ClientProxiedBy: AM9P191CA0012.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21c::17) To DB8PR04MB6523.eurprd04.prod.outlook.com
 (2603:10a6:10:10f::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.130] (83.128.90.119) by AM9P191CA0012.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:21c::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.14 via Frontend Transport; Mon, 25 Jan 2021 07:59:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: adaef805-f10a-4bc7-6db5-08d8c1072fed
X-MS-TrafficTypeDiagnostic: DBBPR04MB7708:|HE1PR0402MB3499:
X-Microsoft-Antispam-PRVS: <HE1PR0402MB3499FB01BEFB8CE0D7E30B9996BD0@HE1PR0402MB3499.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: cVRf8gVoSA9vjBXR6OWRJ8ZRRfUhR+A4Ooj2kIQeBGFnx3KIlyEww/TJNSedDyD6GpoJvSpMZaIzV4mOm8Bn73mDHBpaB5a7twlY5wqzI5tBs72ndyoRJQkH/Z29nlVj6FBAHnbTFqJn9eRmWeOCf4DuAlTKx7uZv/4vQr0wNI/9CpEqW4EZPP1vNMXtzJs3LXKgwcSlFt/UI1Ww8eABwNghvR0eYGQo/Ze01rNO7EEMRktXoMc+tPz2KEbo2Z9cpLkjm3ocB4adTV/ufGknj2dxK7eY1ml5mcaHH6JN7QZzgIr+2QOpvPoGtxVWTbml3dr7cRHKr1gOEFVIwBvTbOimQADY8sAZYgdAOTRxk78sMu2UD/jQVdIcmrNKQetdMqT78rz1zd0WTE/l6rGxe79PtNlUFaWsUqiWWLOQRAlM7z9XOB0brcLmFz1XEbds76ZdHNCZr4ZJCJ1BUJigc9U8y6sztW5hPV1zGpMZChug/QPdgwq2rLqa+6GdbszDEb+bHhPGcPlDrxBon/VycmbQdqojN2aFGoi0Ka22136VEqSe6ct2stLCsgz/VQF5T3+qXzn+OS+4ywp6ORgKnYrXkGbyTzTMCstjNliNRXo=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6523.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(136003)(396003)(39830400003)(366004)(26005)(53546011)(66946007)(316002)(83380400001)(4326008)(5660300002)(66556008)(110136005)(478600001)(8936002)(31686004)(83170400001)(2616005)(956004)(8676002)(54906003)(36916002)(52116002)(186003)(6486002)(2906002)(31696002)(44832011)(16576012)(66476007)(36756003)(16526019)(42882007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?K2pHa0hvMzlRZmtZQjhZNm4ySVNla1NOTmFiUWhHdjlYWnl2TkJMa3dUTXNj?=
 =?utf-8?B?RGUwTXZHakhvbk1NYWMyR0tjWlpLekowdTFtN1MvN3ZSbFQrRVRzS2RMVkhw?=
 =?utf-8?B?ZVZKVFZ3MFluZitHaTlHZ1NyU0EwVFNjM09QT3dRdmg3aWYrN1QzV0g1eUN1?=
 =?utf-8?B?bkZLSWc0aFpCVDd4YUpaVEQ0d25CZ1phSWl4Tk5jZU15Yy84Qmt3NkF6V1d5?=
 =?utf-8?B?S1A2aFBGeUhHb1ZtN01qaThGU25GTzk0MkNHbXVqR2E3MjB1TlRHcUxHS25S?=
 =?utf-8?B?cjkzNW9PQzZDZ0pUYnNleG0xUzNhZW96UGNGaXV1L3BFbzRWdlk5dG5jSkIr?=
 =?utf-8?B?aWdWOTZnd2d1OXhqdGVmOEpiUW9vSDFSdjZxYzNlVFZCM2IxUnJocU1vdGNl?=
 =?utf-8?B?WFNLczNGbXBvam5EelkvVHZpYmVmamFHV09LTnpPVjkrak9VVWdmclJkNmty?=
 =?utf-8?B?SXgyZHpJZlBqc293THJMakoxOVZBY3czMWo0cDlvbDdPSGt0RWt6Z1BEbm5E?=
 =?utf-8?B?c09INGZ2Q2lVbHd5ck91bmQxT3BlYTg4K1JKU0wwY2pQd1ljY25oZkNuUnBu?=
 =?utf-8?B?WEViZWFleG1UUll4TlJ6VlNoK1IrY0lEcm50QkZRYUxnZXh1N0NTamdQQXRn?=
 =?utf-8?B?N29NcStDZ2dXc0dBRmgybDdITEttVytoNE5NU1Aza0JHdGFoMWpoRitOL2tO?=
 =?utf-8?B?ZHJ0U2FZazlFWkFHVzd3b25hWHM1djZpQm93THJ6eFpGZFpvWmxrL01MQVdv?=
 =?utf-8?B?UTZhSklnclowV3h2aWVUaHlWSENzTzROanlIdTJjS2pCaXZJSmdqUWhyWTRh?=
 =?utf-8?B?b2pSQ2xlUkYxbWs0Ym5nTC91VkdXMkNXUk90YjByQWg5a1VJL1pyN2pJY29P?=
 =?utf-8?B?citFSlJUZWRYSTJUblNmdG10dm5ZMUVwT2ZMdmZURzZUN2tEYTM5cDA3Wkxi?=
 =?utf-8?B?cGU2TWdScWZwZlUzOVpXNnJTQTBzbzNuejZ6MjBYUXRBRmo2aDhxUGovWGE3?=
 =?utf-8?B?ZEVvNFFQd0pZWnQrcnZXY3NtL1pJYlVHd2xVbjJBSXRzbG1STUtHVVFuUEFo?=
 =?utf-8?B?YlNwVlhqQ1FUcGZYR1dReVl2V1hIV3JIdFFwTW5ENC9NUERYbFAydDJvWWJl?=
 =?utf-8?B?NE9GM3Z6aUdGMEltTEQ2RDdRK01QOUhoQUVxOVduV2FUeG1POGNDSE5tUjR5?=
 =?utf-8?B?d25jQ0JYTS9lcTVFeFpTeTVGSWs3emFpamFYQ2NoWCtCVmk0RTZXQWJWWDIz?=
 =?utf-8?B?cWpUUlduUU9JKytJSEN4L2dEMWwyZjdpcEhWc2Nhc3NzeGd3OU5yRTA0c3FW?=
 =?utf-8?Q?Zt7eZfsu/VC3g7j6n7N5Zg0+DXdw+dVtgO?=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7708
X-CodeTwo-MessageID: 1995e7e9-5703-4723-98d3-0621aed0a50d.20210125075946@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR01FT056.eop-EUR01.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: efab7817-f1c0-4a44-258f-08d8c1072d19
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zwS3TF7EvJYP8/iKaqjhQJu7/+OBBhmYv0Ou+OuTYiUq3Z31qeK8gfZ7zjMvJ/IpoeUMEXt1ZopBrQoALeM5yfw8Am2cbA4MTtu7/sLxXwAw9sJtpW8bNRO9ORe+jVd52IdfBzHvGzJBO1e6LZMWDwglfPJj6ORGq+HfzNm0suvs4U4vSt8dH7PEAbeANDqUL/MDrIMrjIjvi8D01TxVnPe2yA4pXrzg9ppL2mRqfCIvMdsNQrV9R9TrP4u/TXu4wIhCqlt0uNvH56ctvwUBUtHTLpoH9r66RPcsCdH7D25sQ5rtVdkHM1dLHdYc7InyToyiVJC+lFN7Me6MQPmVFu46Odha6p52gURA5vlctnoxIbKRVHg+581k4L8ndjMsW8IG/1lHLYPN4yuu9Vr2hrILR5J6oiBxvBQsMw75DqOvYcS1ZidTP9ZYjAZtV9XzzP/8P42V4XMORQz2FGNop9ahrPaxVq9fzqaYlTvTyVFLgOww8tA2WkO8EFFtqK6x2qduSBp9i8zzeAyxVtoNBIaurROK9KAN+nF2ZtpCD7nh4vuPz2TDNsIgepr7E9T6
X-Forefront-Antispam-Report: CIP:40.68.112.65;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(376002)(39830400003)(136003)(346002)(396003)(316002)(82310400003)(32650700002)(6486002)(7596003)(26005)(15974865002)(5660300002)(4326008)(2616005)(42882007)(83380400001)(356005)(44832011)(31686004)(36916002)(16576012)(956004)(110136005)(478600001)(186003)(336012)(16526019)(54906003)(7636003)(31696002)(8936002)(2906002)(70206006)(70586007)(53546011)(8676002)(36756003)(83170400001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2021 07:59:48.2997
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: adaef805-f10a-4bc7-6db5-08d8c1072fed
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[40.68.112.65];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR01FT056.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB3499
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

See below


Met vriendelijke groet / kind regards,=0A=
=0A=
Mike Looijmans=0A=
System Expert=0A=
=0A=
=0A=
TOPIC Embedded Products B.V.=0A=
Materiaalweg 4, 5681 RJ Best=0A=
The Netherlands=0A=
=0A=
T: +31 (0) 499 33 69 69=0A=
E: mike.looijmans@topicproducts.com=0A=
W: www.topicproducts.com=0A=
=0A=
Please consider the environment before printing this e-mail=0A=
On 24-01-2021 14:23, Jonathan Cameron wrote:
> On Sun, 24 Jan 2021 00:21:13 +0100
> Linus Walleij <linus.walleij@linaro.org> wrote:
>
>> On Sat, Jan 23, 2021 at 4:35 PM Jonathan Cameron <jic23@kernel.org> wrot=
e:
>>> [Me]
>>>> Next, I think it is better to let suspend/resume, i.e. system PM
>>>> reuse runtime PM since you're implementing that. This is why
>>>> we invented PM runtime force resume and force suspend.
>>> Here the driver is turning more off for full suspend than in the
>>> runtime path.  If that results in significant extra delay then
>>> it's not appropriate to have that in the runtime suspend path.
>> I see the point.
>>
>> The resume path calls bmi088_accel_enable() which incurs
>> a 5ms delay.
>>
>> The runtime resume path incurs a 1 ms delay.
>>
>> The runtime autosuspend kicks in after 2 ms.

It's set to 2 seconds as I understand it. This to support reading a=20
single value every second or so.

>>
>>> Maybe the simplification of not doing the deeper power saving
>>> mode is worth the extra power cost or extra delay, but
>>> I'm not yet convinced.
>> I would personally set the autosuspend to ~20ms and just use
>> one path and take a hit of 5 ms whenever we go down between
>> measures if it is a system that is for human interaction, but for
>> control systems this more complex set-up may be better for
>> response latencies.
>>
>> The current approach may be better tuned to perfection and
>> we are all perfectionists :D
>>
>> I'm just worrying a little about bugs and maintainability.
> Fully understood.  Though for things like this I like to leave
> it at the discretion of the driver author as fairly safe they
> are a user of the device.
>
> May well make sense to go with the longer times as you
> suggest though!  Over to you Mike :)

I've been digging in the datasheet and it's really unclear how you're=20
supposed to control the two power registers.

I think it's best to just put both control values into on/off state at=20
the same time. I also prefer the simplicity of Linus' suggestion. I'll=20
do some testing to see if the device behaves properly.

--=20
Mike Looijmans

