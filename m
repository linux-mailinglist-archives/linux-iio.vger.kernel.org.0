Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25764395F83
	for <lists+linux-iio@lfdr.de>; Mon, 31 May 2021 16:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233011AbhEaOMM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 31 May 2021 10:12:12 -0400
Received: from mail-eopbgr60091.outbound.protection.outlook.com ([40.107.6.91]:53302
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232729AbhEaOKJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 31 May 2021 10:10:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LIBKrzfXmRmI8e8ptqr0qKHI9ptHl8q2cpbsdGb7gxZDwcKDeKYJAJ/FvV2nRGWehZbzz4KFbjl+8F+2lMo16svdqrQBuDBwd5Bg8I2HNwanaQiSkoJmHdGkJJP/SNCQQr2YY8wuPXzdlJd0vftqEdaUTKMCgowfUgIik/FTajKvNMDqAc2cpMFf5IPlXO/vy8S/NTDo+muzL1X6mIxUL3l4u5Oemy/mi/mu3kGmeihzZ6IiQDzg4ri0ttSchK/nutxSVjEdYQOgMgWr0/EgsduXLqkZQzVMJBXZ2nVLbdca/Uh8yrwnIdehL9f7Z0F1NXIGMpYca1hr36EnOHNfWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UYdtj5W7IM8TmX8J4Gri0Av/1UHfKuV7xBLQ39TEa5c=;
 b=adMdjcRg+SwmXRhkTOI1nsl1QXSgajBC7X4NHyLXu9j6vMsjPAltqEEHNSvLQVXt+7mk7l696VM3eKjh6Fbgn9PX4FbGv7F/G3IscW0vLzZ14HJZergdIv28qvY+X4r8qW4J4IqPrf07r5ThBqe9qnqQnUD0vWBKcCW036d9QTcZYBwu9x++EhhO/zBtZ2ZfdcWjoI1LQgwU2SAig2Yb54NFSG+Wft1LoDRQWA61P4nVsmjwRV0fY+IgHP1VjAWy9p38GllBATGWlFuc9CdcabQQzGHj9RGB5Gg3zFq0Pud4MTn+n3tbj+jdXohF/bSXRltwWis2R36HhCmo49jlRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UYdtj5W7IM8TmX8J4Gri0Av/1UHfKuV7xBLQ39TEa5c=;
 b=Arl/UDY7AbREYqzOYYJEa16zm6Yem8atMBwD8LdYzxnPKeKTboOJ0QxV8/VGnDUIAFdjryOkWwjVxUmlxFpU86bYDJDhsxqOiI+P/AR/U8OATFdREOPdMYl5oc4dO7G0GEmQkavVbKjt7VamsOSROR8LIvZIJG2bH3Kg+PuVUh8=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB6PR02MB3062.eurprd02.prod.outlook.com (2603:10a6:6:24::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Mon, 31 May
 2021 14:08:25 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::d47d:ca8c:4fe6:3908]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::d47d:ca8c:4fe6:3908%3]) with mapi id 15.20.4173.030; Mon, 31 May 2021
 14:08:25 +0000
Subject: Re: [PATCH v1 4/9] iio: afe: rescale: add offset support
To:     Liam Beguin <liambeguin@gmail.com>, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
References: <20210530005917.20953-1-liambeguin@gmail.com>
 <20210530005917.20953-5-liambeguin@gmail.com>
 <0769aaae-8925-d943-e57d-c787d560a8dc@axentia.se>
 <CBRGZCQWCG6S.676W3VCPMMUH@shaak>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <01f8d320-05ae-1178-151a-d0d11a23bb55@axentia.se>
Date:   Mon, 31 May 2021 16:08:23 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
In-Reply-To: <CBRGZCQWCG6S.676W3VCPMMUH@shaak>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.229.94.233]
X-ClientProxiedBy: AS8PR04CA0071.eurprd04.prod.outlook.com
 (2603:10a6:20b:313::16) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.13.3] (85.229.94.233) by AS8PR04CA0071.eurprd04.prod.outlook.com (2603:10a6:20b:313::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Mon, 31 May 2021 14:08:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 35603eeb-f1aa-4551-587e-08d9243d8e88
X-MS-TrafficTypeDiagnostic: DB6PR02MB3062:
X-Microsoft-Antispam-PRVS: <DB6PR02MB306268ADAA504C89D4DF6B59BC3F9@DB6PR02MB3062.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QaO3M/oyeUCWSQDlMgEPWLLXu5dhlGMVhjJxGNtgDLmnaDKUe4uiMZ5b2pnekuN6GU6AgysE+NtXgih4eoCa9ouBA/BMd6M8GAZehTb7zPL2EqJt/i6ZH+y49n7VPIko7EXHGWHVTVX2+K5BcHU1ObG/suu+9OolNsAbbmA5N4MIs/vdff8+DrxZqNpgM+ThF4OJK7LLnrn4s70B617WIuBIrzTAWoTaDUisOSqJbldgFjZdVPa3P+BFQbVtT8aAEQHvDCHKkMzjCvoLvEWKszOARjdXagK5LvNtOY26lXLANP74MoXAFcLjYuSDuizSarEf3lLAsT9g0ymPeT2FJOuvu3XXlTxiX7eiDxHNcPIJDSaIsAPYjUQDacJbgQUkZSDShSMWxsBPpx4DRIjVXU5iJ+/02stdH69OUhh8/A4CBGNZQkncgrk7jMFLfNkOAV6kXJsj7/UfAnlpY/eKgVyTYBDRfLgshyQLjJF59EA++rOr72YBPLDOUzQvjxLDdY130fvIq+6tGLg6jS9husEROgPkMk1a5JH7G7iiIMfTAmqyzMEqZ/69mkQ6lC4Q+lUfTKWULzQB2RhDxwyzKvejgQ8+W/0fidgShVToYK9FNs0Cq8tUt4Gx4z5merRErw7NJRefj9u7E7ib7ZkWNGRpFe7imKdSoISmokscrEuOEJAaFrBiTYxi/mqNBUHp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(39830400003)(396003)(346002)(376002)(6486002)(26005)(316002)(2616005)(4326008)(31686004)(5660300002)(36756003)(956004)(31696002)(53546011)(16526019)(66556008)(186003)(16576012)(38100700002)(86362001)(478600001)(36916002)(8676002)(8936002)(66946007)(2906002)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUc3UjZaWnRZV0JIZ3p5Vzg2djhMQXlLclNEOXZKU21xMk54NXRxYmZjNzhj?=
 =?utf-8?B?L2QrVnU4TVprTVlVRWVxajVQUEJ0TEgyNHE4ck5yb3EwODRCNjZTTDl0WitG?=
 =?utf-8?B?VVVTN0gwSUpXcmFtaTFDR3V5eTFoR0VOQnNKQXVNSzRSd0Y0Uzh5SzJRYzE1?=
 =?utf-8?B?SklaV3lDOUFsU2JESFAzdG52bFlnWDI4a2Juam51NXUxRi9vOHlNWFdiT1Ns?=
 =?utf-8?B?Y1RVcEFDT0VUQWxSWFRFYldlK3N3L3dmc2djLzZmY05NOHJJbGJSUEJaNzNw?=
 =?utf-8?B?cDVYZkpmb1kxOSt1R1hiTzQzM1FacHVZRnAxQ1dBTVhQYjFMcG9sK0dEeXpr?=
 =?utf-8?B?UlJrTi80Vll6eVd5WU9aS1ZvMEM1eFlyUlZOeGJJY1BybzFvWmxpTGhaaldR?=
 =?utf-8?B?NnQrdVlqWHdjZUlyQ3cydzVNMXllbTBGNGUvNm4xd1VFZjBjenRjanpGOXpl?=
 =?utf-8?B?VzlaclYzYlRJS1F2Q2x1TEp3dnhjOG8rd0hDakJyS0VweEUxeHpqS1pyKzM1?=
 =?utf-8?B?WnNvcElFRnlJcnJpd0FNcDZ3dlkrRmVSc3J1N2MxV2szQnBZbEo3NFk3WDY1?=
 =?utf-8?B?ZkxVZS9uSnRYeGNqZEZDeEx4TFZjdE5sWmFib0lrSWw3SnlBTGMycGFsZXNZ?=
 =?utf-8?B?ZVpZUDd2QXZuQlRlZFJOSU4rZHRYaEU5N1NOODQ2U1VYTVFkVzJwam1IYUhL?=
 =?utf-8?B?TnJjUi9hL2xYVlpUVnFYYlZaQ05YQ3AxdnRuN2Z5Z2VHZEhVdElJUmlIMnZY?=
 =?utf-8?B?RnozdThQbGhBY3lESDVPY0owRnhGU3BTLzBLcU1EeWs1TmpSajJGMjlSSS9U?=
 =?utf-8?B?S1ZScEVNY3ZVM2ZCZUJsVEs4MW1kVy92d042eGVDV0JPV1pkZUtRa3lCTjZw?=
 =?utf-8?B?djg3QnIzSFVsTG1HRW1obHVnaDArRlplOFRYUU1ad3RvOGViV3pVdXhYRTg3?=
 =?utf-8?B?K3Bra3JmVDNTbUdnS1AvV2JKcVJsamQ5SkwxN21BN0VnRU9UU3JSd1RyVjNQ?=
 =?utf-8?B?Z0hHWXZEQW9Cb3NBZkJraGg0MWNrT0lIZmd3MnQ1RFRLUEhZd1EvemcrVWFZ?=
 =?utf-8?B?aFBMaSs5KzFDM0hXUVhJVUZtRG1iNXR4cE1qT0pZbU9HT1laK1dtdnZUNWhC?=
 =?utf-8?B?UzJGOFBrRWwzenR0QXlMcnhqd0ZqbEJaQ3Z0Rm1sL0xhRks5aG9xQ1dXM25U?=
 =?utf-8?B?ODhxM2NiNVlxNld2clN4cS9JNmxXanVvWFdud2NpbEI1dHQrYlVIVTlJdnpa?=
 =?utf-8?B?Vk9CNjBDcnlKY3BzT21pa3VRU0VjcU9aZWhVRU0ybExLU0pQcWlvL1R1dzQ3?=
 =?utf-8?Q?BCMPb7rBss?=
X-MS-Exchange-AntiSpam-MessageData-1: +i3R4+iNNDwkwCxZF9N/7tBBVxeycyk5Xy189k7KIVgSp+kQMXgVq1iOc8C4kV8XuZ94bS1NDK2ORrtIteIX1+6S884zVSGEKEAb6OT/i1MbaXLDwSiRkyApFl2/far7fyB9aBvnTEO5QtS+kP/0SOSSiKHSNYjFr90rMHpVwZc1lOXRNPxb5KSi9/Le9IGg3Kzt9nwZUOqK049ue61ISp0rshvv68KllaGRthE0CrET2ZcljhpDVNNsoMM8mKTtJXk/z/Xit9TDzbwz437iqAND/AFsVwy2nk+buIxKRaC2duPnTikQftJhXsqlySn6VBd9Y/nkTrRbnCWk1fRxSZeW
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 35603eeb-f1aa-4551-587e-08d9243d8e88
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2021 14:08:25.3730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tDIQvzrtFPP9DbS/nrVamZCowjmyg9EhhztCoXplKZ352pIuslmnH//RuUu+FVos
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR02MB3062
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 2021-05-31 15:36, Liam Beguin wrote:
> Hi Peter,
> 
> On Mon May 31, 2021 at 4:52 AM EDT, Peter Rosin wrote:
>> Hi!
>>
>> Thanks for the patch!
>>
>> On 2021-05-30 02:59, Liam Beguin wrote:
>>> From: Liam Beguin <lvb@xiphos.com>
>>>
>>> This is a preparatory change required for the addition of temperature
>>> sensing front ends.
>>
>> I think this is too simplistic. I think that if the upstream iio-dev has
>> an offset, it should be dealt with (i.e. be rescaled). The rescale
>> driver
>> cannot ignore such an upstream offset and then throw in some other
>> unrelated offset of its own. That would be thoroughly confusing.
> 
> I'm not sure I fully understand. The upstream offset should be dealt
> with when calling iio_read_channel_processed().  That was my main
> motivation behind using the IIO core to get a processed value.

You can rescale a channel with an offset, but without using processed
values. I.e. the upstream channel provides raw values, a scale and an
offset. The current rescale code ignores the upstream offset. I did not
need that when I created the driver, and at a glace it felt "difficult".
So I punted.

But if the rescaler is going to start to handle offsets of any kind, it
will get very confusing if the upstream offset is ignored. The proper
way to do that is not something I have thought deeply about, and I
don't know what the proper behavior is. For a processed channel, the
offset is baked into the value that is scaled. Maybe the sane thing
is to do that for a non-processed channel as well? But that gets a bit
ugly, as it is counter to the simplicity, beauty and efficiency of the
rescaler driver. In the non-processed case the driver is just adjusting
the scale value. But since we are talking about proportional
relationships, it should be possible to rescale a non-processed
channel with an offset by just adjusting the offset in some way related
to the rescale factor. Doing it with integer math is the "difficult"
part...

Cheers,
Peter
