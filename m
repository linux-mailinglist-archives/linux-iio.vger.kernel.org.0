Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40591302297
	for <lists+linux-iio@lfdr.de>; Mon, 25 Jan 2021 08:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbhAYHz6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 25 Jan 2021 02:55:58 -0500
Received: from mail-am6eur05on2080.outbound.protection.outlook.com ([40.107.22.80]:26081
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727168AbhAYHzG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 25 Jan 2021 02:55:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=topicbv.onmicrosoft.com; s=selector2-topicbv-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KXdXwd8XelYUneh99oPMLB1/gUceM+m56Spnq9CEznE=;
 b=HlkBGnIr/lNfEcuNkBwYhrxv/WJi6XArCmPbZ1GqfHhRWxGtlBSbJ1WPAFtq9+gchKHFdQYA/1SCdF+6cEmYjS+a1d9MBcy55//PFYRScFzcgVCjm42fcIFN1elxNWU+HvpTbQh3wNnvlqbPii+J7XjQU9V3gXSkg7cJdvn5AiQ=
Received: from AM5PR0201CA0012.eurprd02.prod.outlook.com
 (2603:10a6:203:3d::22) by DB8PR04MB6731.eurprd04.prod.outlook.com
 (2603:10a6:10:104::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11; Mon, 25 Jan
 2021 07:53:40 +0000
Received: from HE1EUR01FT058.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:203:3d:cafe::2e) by AM5PR0201CA0012.outlook.office365.com
 (2603:10a6:203:3d::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11 via Frontend
 Transport; Mon, 25 Jan 2021 07:53:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.68.112.65)
 smtp.mailfrom=topicproducts.com; vger.kernel.org; dkim=none (message not
 signed) header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topicproducts.com
 designates 40.68.112.65 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.68.112.65; helo=westeu12-emailsignatures-cloud.codetwo.com;
Received: from westeu12-emailsignatures-cloud.codetwo.com (40.68.112.65) by
 HE1EUR01FT058.mail.protection.outlook.com (10.152.0.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.11 via Frontend Transport; Mon, 25 Jan 2021 07:53:40 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (104.47.14.59) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Mon, 25 Jan 2021 07:53:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hz2z1L4zUZK+IPlUvzFYxB6OLacdu7vUiiovEVo6ACmysw9ABIrbdPfdI3eTYtBjGQ2x6gqcnTYnFP2vOtmP7VMPzeRDv/6Cb3Jn7lyuKgbFU/7oWbCdP3ZDIVf8Fuzd3yWxeNkl8Yp4clxbAUBWabXiOJN590RBmx6aVefjVnww5/7xLqV+5rZLz+sPJF2oMNk9tZWbPnwX+ThdXVAZnsk+NDVOxR0dFdpBEEFyW6/blTE9e4ZmTmogPb3eh7abjD7d/Dl07CcJHmeFZpqpcx7UWZbYyUXAXeU/nJQIdW3v2BIlQDvmvrSV+erIiW741Y5Cz36BR8cSrQi/uct2wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aipw3lreJVgY37FXzefh9P4XJxUOOxgWfpmLMgYTyS0=;
 b=jXam4Zz5+Bo8OiDSrzAfnJ2d4MCizuci2wdB8S+eIcYbCHDS+cBf9HfTiEoEXDxZ0Ii2gIrfEmzDmHx8jtYA224EDWQx8d8pHXelG5WFWKE/m+DMhkGctkDmzdn80KbMTO/Czn1mXZVNutEAUPs/69lXbgZoeRVSO3y2ELSk+hlBtXJysys2LBx+PEqkQ0QdbToO3gTAAsIw4Nv4zk+38lO2ttGi4gy5td5ltxRVVV2l/URZDdNBDn7du06UlFyD6gMFooup8vwECXvSWv5mcTN14i3dXxzw/IHOUXOrfTWPPJQiqXfzXhmlH9UY8nW62O9DUaNTjHGH2LLEALGnjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topicproducts.com; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
Authentication-Results-Original: vger.kernel.org; dkim=none (message not
 signed) header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=topic.nl;
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com (2603:10a6:10:10f::26)
 by DB7PR04MB4249.eurprd04.prod.outlook.com (2603:10a6:5:19::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.16; Mon, 25 Jan
 2021 07:53:35 +0000
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::792a:b2ef:ed50:a1a2]) by DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::792a:b2ef:ed50:a1a2%4]) with mapi id 15.20.3784.017; Mon, 25 Jan 2021
 07:53:34 +0000
Subject: Re: [PATCH v7 1/2] dt-bindings: iio: accel: Add bmi088 accelerometer
 bindings
To:     Jonathan Cameron <jic23@kernel.org>
CC:     linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210121155700.9267-1-mike.looijmans@topic.nl>
 <20210123153826.0368bf61@archlinux>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.31062d28-ea32-4cba-9e19-a7434c115d8e@emailsignatures365.codetwo.com>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.0d2bd5fa-15cc-4b27-b94e-83614f9e5b38.19976ff0-2a49-43f4-afd2-1dfd0965f697@emailsignatures365.codetwo.com>
From:   Mike Looijmans <mike.looijmans@topic.nl>
Organization: Topic
Message-ID: <f5de24be-57d8-afa0-3361-1f9f11b118f8@topic.nl>
Date:   Mon, 25 Jan 2021 08:53:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210123153826.0368bf61@archlinux>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Originating-IP: [83.128.90.119]
X-ClientProxiedBy: AM3PR07CA0063.eurprd07.prod.outlook.com
 (2603:10a6:207:4::21) To DB8PR04MB6523.eurprd04.prod.outlook.com
 (2603:10a6:10:10f::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.130] (83.128.90.119) by AM3PR07CA0063.eurprd07.prod.outlook.com (2603:10a6:207:4::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.7 via Frontend Transport; Mon, 25 Jan 2021 07:53:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 287b4879-2e84-4e7a-3c47-08d8c1065481
X-MS-TrafficTypeDiagnostic: DB7PR04MB4249:|DB8PR04MB6731:
X-Microsoft-Antispam-PRVS: <DB8PR04MB6731F6DAADF0342022229D8096BD0@DB8PR04MB6731.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: TUEjABX7CzyVdC4Swjn4ivq8c2Hpvh3tGK6RaMbna9+VJZunzKqcob5ODapTv9vEmUrlfbNXLu8Rp4JQInl6a83LX1SGxxum3SHO8nT3ccCxIta5nrxFJb5GsPWSAVJfH9kttJqKQg7MRRySNE3xX7YMlRz4PjZU4kWA0ahwJJi8wH9c02ANFXdyXwaIDxyTGBtzIXWSwLI+62ZiJeQdFV3LGLxIXcDB4WBe7dDi9GuustUYYbahTqo4hTDglb4SfjPKrrgug90lG3TFLGQmTysDUDnK+6/S0krnZSYt7BxPsStE/6hYsQk9PG7EE8ZKy6iIpU/24tb+zHnrU5PHzo8hqfWHeLytqBRuajoOPeed7Tnm4+IBD9WITrncXQf5Q/gWD2HuToj0Ky/NBSlHlM1/f1f4rLODDSxy1A7b2+flV76zGFH31ECQSR0y64PmoZ9VvaSbDHWdtdprclLUMkp9c1QRXHi3m83WCjb6hk7/dfB0L8bEA+6xdBkmcJfd1gFNoXry8A1GkHKV6GtxW2SA4hH0vsIZPNCZ7GTemZ6eflnduOV/kDIv3UYag/6vKkvmQGbA7w8rgJqWyxDtunKxSV0kYk+GOJy7CogVLIR5o6JL8+JvJffH97xvyPXAQhaOyjpauxU8ImUe20aCU1GGBlj2yRhrTGRl+qcfNS8LaJMnJyJO9/FjEmkogk4G
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6523.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39830400003)(376002)(366004)(396003)(346002)(2906002)(83170400001)(66556008)(16576012)(44832011)(36756003)(316002)(31696002)(52116002)(8676002)(31686004)(478600001)(4326008)(66476007)(36916002)(956004)(8936002)(53546011)(42882007)(54906003)(5660300002)(966005)(83380400001)(2616005)(6916009)(26005)(16526019)(6486002)(186003)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TlgxQndyOW5RWnp4QTYwSVFHcm5lalE4Mzdkd1BYTEEvQ2lGQ3dKQ3lFOWtu?=
 =?utf-8?B?WDF1dGRXWmUzdFF2LzNKRW43U1FOSDlkaWVTaFhTVHRxbktyaW9UL214RVBD?=
 =?utf-8?B?aisvQjVWajZ5UWVhWTJyWXlyTzZCSSt0dmZsUCtiZURSQmhhbkQ4QXd0U3NX?=
 =?utf-8?B?YmdMSE96azBzaDN4dHV5L1hYTUFyRmczbUtJWGFuQWZWM09URHcrYmllci8x?=
 =?utf-8?B?T0RJV25ZTHQwaEo4c0tEM0Urck4wck4yalR3ZEJibkRZV3lIMUZGZ3dUaVZM?=
 =?utf-8?B?c21IRzQzeklqbXgyVmdVNmNqSHRSelorT1RVam5raENJQkhzbHBTcHNWeFNY?=
 =?utf-8?B?Tm1hR2ZwWlJFUlFQeDZIZ3VWUjlQNWZVT0t5dkd2NUJ4OHJRV0sxS2tJcWg5?=
 =?utf-8?B?WUQrL3B0NzRCK2d2STVCdkFqRW1Xc1FjeXQyRzRjVGZ3ZEg4aWFHWjlPd2Fw?=
 =?utf-8?B?SEhhT2xPWHVZSXl4clZHcTVRdHBhMFQwbEVSZXRrOUpCUENLOFFsVjc3UDFx?=
 =?utf-8?B?cW9hSHdFcFBzeldSQUJVamx6eU9jcFUvd0YrdFlxM1plQml0dzlmQWxsdXVu?=
 =?utf-8?B?aXNQdmdUajgvRFdmS1gwc01iMVNQYk44NytVTTdUR25wZllhVVFjYWdzeVlQ?=
 =?utf-8?B?Ly92VUlrZ0JjMFN0ZGJ4bktLRWdHVmNPQ0JUOXJ4Ukl6NEFKQ09Oc3RZWktm?=
 =?utf-8?B?Q0dDbnRRM0JuakZOK2xEMGk4Tk5kTi8xUEp0ZGNFbGRwSFhaL3h2eVdLaHJK?=
 =?utf-8?B?emNtV0htM2I1UkFMbGpFdmoxbDBybVhRNEdXRU0vVDBPd2N1bGMwdnNmWmYz?=
 =?utf-8?B?SlhvaGFwdy8reU53NmZYb2psd21OdE9lZUVWSGxLZDZQbkJiRVJ5ZGZoUUwv?=
 =?utf-8?B?YjkxVGNrUzdtTUZXUFNCL1FHaFlCQnlnZmphNmR6dW14dVMrM3JJNmNqM3Vp?=
 =?utf-8?B?WTBQQ2FUZkhvT1oyYXk0dU1mdTNQWVEyNDJYeDB3SFVPVXJsV3lVY3BLNThx?=
 =?utf-8?B?N1kwVERCMHdGN1J6ZDhZRzZQWDVVblgvRW5vRzlJZXpTaW1RTnlUdDlReGIv?=
 =?utf-8?B?NzMzSWpWeU85N3EwczNqbDJjUTlPcWZIcW9rQnZLZEJ6WmhkdmhualJDQmhV?=
 =?utf-8?B?WVJOQ2t6aGd3Y0lLNVVKSjEzT3kxekZwaytZUUJOMVhqZXNoUGFpOHc5QkhP?=
 =?utf-8?B?cmxNZGJzNnVicVFVVUFUOFk0MFFIcDhtU1VqeS9ubmpGNUM0aWZsUFoxeHRJ?=
 =?utf-8?B?MkQ1R1BPZ2Yxb3p2aTBwZ3B5NTh1amFtdFUydGwvOG9QN2xKZDU0RHFEVTAz?=
 =?utf-8?Q?yF8qIU52ft9hbMiwPr+0XYptI+rmW0oyqT?=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4249
X-CodeTwo-MessageID: 3d71826d-d95d-4f19-916d-0481a67d792d.20210125075338@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: HE1EUR01FT058.eop-EUR01.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 45df2851-0905-49c2-25e2-08d8c10650f6
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OTYsqGaqyTOzexvgHJhCFLdpW1Ap2MeCGcyoASYT6nZzEzbtP4j8GV1c4CX10vwlFr707rCoNChlgUYElPXwT+VRylv5Wg6N7S1BE3N4GiT3wLmU8nZ6KmamOXKtkf1EB/jcg90XfMAoBbgDk/Zq44ZUusJsvFCE0v1KpuO2A+g+2NG8LLf1pMJ34+5dP/DH8CMoCLTKV+lWz7DGafnao4OqvSZ2dffjGqwRYc0xnbzKdcJXy791foT8pvPfhmyhJ/Lf7QLAPzodk+g+n0UMO5+sElN04jXCfOKfIP5skrqWTVFRjbuHYIh21VOp60Cn+MCSwf2TgqBIOoygnC0Uh5KbLGuZJLIxqVaKehDnMMGQSbLojq2NgpyBMNMJ06ZykNX19sm/D2ByerxryUkGO+U6LQaIMmBYCgnuakPiYhAESWVGhrbTxBVOY4kkp5uvegCodPMFQby1NdhRCN4+geebbS1EUKQIrEUjRIrKUkt1smHoXlUy4E67f9wrrGQSsNjoLvQ1Wp3ecJ13k4lV8c7x2fPo9YtxHXdIUTtYPpFin+sqJdiIcEHcorWNB5UV
X-Forefront-Antispam-Report: CIP:40.68.112.65;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(396003)(376002)(136003)(39830400003)(346002)(46966006)(31686004)(956004)(54906003)(356005)(31696002)(83170400001)(44832011)(7596003)(16526019)(7636003)(478600001)(186003)(82310400003)(26005)(16576012)(4326008)(36916002)(83380400001)(966005)(53546011)(316002)(2616005)(36756003)(47076005)(6916009)(15974865002)(336012)(6486002)(5660300002)(42882007)(8676002)(70586007)(70206006)(2906002)(8936002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2021 07:53:40.2436
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 287b4879-2e84-4e7a-3c47-08d8c1065481
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[40.68.112.65];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR01FT058.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6731
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
On 23-01-2021 16:38, Jonathan Cameron wrote:
> On Thu, 21 Jan 2021 16:56:58 +0100
> Mike Looijmans <mike.looijmans@topic.nl> wrote:
>
>> This adds the device-tree bindings for the Bosch Sensortec BMI088 IMU,
>> the accelerometer part.
>>
>> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> Just the issue the build bot found.  Otherwise looks good to me.
>
> Jonathan
>
>> ---
>>
>> Changes in v7:
>> Add additionalProperties
>> Change bmi088_accel to bmi088-accel
>> Add interrupt-names and adjust description
>>
>> Changes in v6:
>> I't been almost a year since the last commit, sorry...
>> Fixed the yaml errors
>> Add interrupt, vdd and vddio properties
>>
>> Changes in v5:
>> submit together with driver code as patch series
>>
>> Changes in v2:
>> convert to yaml format
>>
>>   .../bindings/iio/accel/bosch,bmi088.yaml      | 66 +++++++++++++++++++
>>   1 file changed, 66 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/iio/accel/bosch,b=
mi088.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/iio/accel/bosch,bmi088.ya=
ml b/Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml
>> new file mode 100644
>> index 000000000000..db5dbaf80fa2
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml
>> @@ -0,0 +1,66 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/iio/accel/bosch,bmi088.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Bosch BMI088 IMU accelerometer part
>> +
>> +maintainers:
>> +  - Mike Looijmans <mike.looijmans@topic.nl>
>> +
>> +description: |
>> +  Acceleration part of the IMU sensor with an SPI interface
>> +  Specifications about the sensor can be found at:
>> +    https://www.bosch-sensortec.com/media/boschsensortec/downloads/data=
sheets/bst-bmi088-ds001.pdf
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - bosch,bmi088-accel
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  vdd-supply: true
>> +
>> +  vddio-supply: true
>> +
>> +  interrupts:
>> +    minItems: 1
>> +    maxItems: 2
>> +    description: |
>> +      Type should be either IRQ_TYPE_LEVEL_HIGH or IRQ_TYPE_LEVEL_LOW.
>> +      Two configurable interrupt lines exist.
>> +
>> +  interrupt-names:
>> +    description: Specify which interrupt line is in use.
>> +    items:
>> +      enum:
>> +        - INT1
>> +        - INT2
>> +    minItems: 1
>> +    maxItems: 2
> As per Rob's build bot you need.
>
> spi-max-frequency: true
>
> If that's all that comes up and Rob is happy with this I can fix that up =
whilst
> applying.  Please try to run the checks suggested in Rob's build bot mess=
age
> before submitting binding patches though.

There'll be a v8 it seems, so I've already added it. Seems that I need=20
to upgrade those definition files every day...

>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>> +    spi {
>> +      #address-cells =3D <1>;
>> +      #size-cells =3D <0>;
>> +      bmi088-accel@1 {
>> +        compatible =3D "bosch,bmi088-accel";
>> +        reg =3D <1>;
>> +        spi-max-frequency =3D <10000000>;
>> +        interrupt-parent =3D <&gpio6>;
>> +        interrupts =3D <19 IRQ_TYPE_LEVEL_LOW>;
>> +        interrupt-names =3D "INT2";
>> +      };
>> +    };
>> +...


--=20
Mike Looijmans

