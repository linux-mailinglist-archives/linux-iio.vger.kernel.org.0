Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D499C2FCB69
	for <lists+linux-iio@lfdr.de>; Wed, 20 Jan 2021 08:24:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbhATHW3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 20 Jan 2021 02:22:29 -0500
Received: from mail-vi1eur05on2077.outbound.protection.outlook.com ([40.107.21.77]:46720
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725827AbhATHWY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 20 Jan 2021 02:22:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=topicbv.onmicrosoft.com; s=selector2-topicbv-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ErGRAIYyYsJGgfzFerQAVuVz8rDCgRpPKXqrZBiTiv0=;
 b=nc+EzFAO7gnVJ94qbakT2CSF9B96P4EJnqEexEjftbjZS8QhSHNOMjElR24LocD8zu0jN7te520CTJ9J7nSPRbcWbFF59aciOBlbURxHbjOKx+FJ9R1agH5tZSLpFzP7hNNbU8l6gUCY/y45pko0YPBL1HLAqG6/IvQr41LoHmg=
Received: from AM6P193CA0092.EURP193.PROD.OUTLOOK.COM (2603:10a6:209:88::33)
 by PA4PR04MB7965.eurprd04.prod.outlook.com (2603:10a6:102:c9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Wed, 20 Jan
 2021 07:21:33 +0000
Received: from HE1EUR01FT008.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:209:88:cafe::79) by AM6P193CA0092.outlook.office365.com
 (2603:10a6:209:88::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12 via Frontend
 Transport; Wed, 20 Jan 2021 07:21:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.68.112.65)
 smtp.mailfrom=topicproducts.com; vger.kernel.org; dkim=none (message not
 signed) header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topicproducts.com
 designates 40.68.112.65 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.68.112.65; helo=westeu12-emailsignatures-cloud.codetwo.com;
Received: from westeu12-emailsignatures-cloud.codetwo.com (40.68.112.65) by
 HE1EUR01FT008.mail.protection.outlook.com (10.152.1.250) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.11 via Frontend Transport; Wed, 20 Jan 2021 07:21:32 +0000
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (104.47.6.50) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Wed, 20 Jan 2021 07:21:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FweQWXWQtwvtbuTAsJ4ga833EH3zqtAC1jBVS1UrQmGenTGdZxYAQunqbiMZTcOKFqlfafke482PNapv8k9GPLQxoxCraYn0SAMM2Z+Iinw0HzZshxJrvQfhzotEFASy/Y3bRS0BFnwNjBwLQ/3Uc321eSMVfIL6qytUnyFKrmrf1UrDDeC9dK4KMsl3bOOleSgVh+keBIuy0T6cohlePx0A9qTD7iGwe5JQ1GDQ7hPb7zgQ1DwyjglqYnQTiTcZIr+2V+zbtxuBVSzfiavOM942CVrAnkuN/SrFEBOTV3WN8THh8Q2c2o71gQFMaBf7rHwpdTc3eL+OlUCgPZEXoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aVBPPhi9DhC7pJBfdBd4dMxELqvPSx4dWFBxMKP6tYA=;
 b=oMQrkZv5a9lFwJIWaIJteksIbp2FxTqkK/Kykmwfr6zdD8NgseTg/OUx1U5V2PnjbXoU6LLJAS4MmEjRfzoxvDtH0CoGD3+ls1+xhMqP5x8W/GguzWZlL30Zra8PJc+/mrqXSB0p4nxszwMkFoW6vLDkHEtIk9GN120/7Tz33EE6lL4KFAGTfHgj0Inefam3W/Wdpd7rq61RLY6sVDv9NaxcxHcWU6u+5N+jLDvETxVfc5uvlJLVrCaGg6sFvFDhhL+jfLLo93+OiR8nof7YJ3nGvPqLGW/68PIorzihbb/kmf/M7F7Q6xhLzxvuf9I9aEJwn8x+nR6DUrtKx8SQLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topicproducts.com; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
Authentication-Results-Original: vger.kernel.org; dkim=none (message not
 signed) header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=topic.nl;
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com (2603:10a6:10:10f::26)
 by DB8PR04MB5834.eurprd04.prod.outlook.com (2603:10a6:10:af::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.11; Wed, 20 Jan
 2021 07:21:29 +0000
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::792a:b2ef:ed50:a1a2]) by DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::792a:b2ef:ed50:a1a2%4]) with mapi id 15.20.3763.014; Wed, 20 Jan 2021
 07:21:29 +0000
Subject: Re: [PATCH v6 1/2] dt-bindings: iio: accel: Add bmi088 accelerometer
 bindings
To:     Rob Herring <robh@kernel.org>
CC:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210119124622.9490-1-mike.looijmans@topic.nl>
 <20210120013118.GA2990828@robh.at.kernel.org>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.06120990-9bfb-4196-a6ce-19c5b16aae9a@emailsignatures365.codetwo.com>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.0d2bd5fa-15cc-4b27-b94e-83614f9e5b38.70d7c9ca-f015-4fc4-8136-1c0364cd5511@emailsignatures365.codetwo.com>
From:   Mike Looijmans <mike.looijmans@topic.nl>
Organization: Topic
Message-ID: <9afb0a06-f3ec-5886-5654-b09eeff66825@topic.nl>
Date:   Wed, 20 Jan 2021 08:21:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210120013118.GA2990828@robh.at.kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Originating-IP: [83.128.90.119]
X-ClientProxiedBy: AM4PR07CA0024.eurprd07.prod.outlook.com
 (2603:10a6:205:1::37) To DB8PR04MB6523.eurprd04.prod.outlook.com
 (2603:10a6:10:10f::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.130] (83.128.90.119) by AM4PR07CA0024.eurprd07.prod.outlook.com (2603:10a6:205:1::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.6 via Frontend Transport; Wed, 20 Jan 2021 07:21:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 590ac6e6-71dd-4a5c-ccdf-08d8bd14038a
X-MS-TrafficTypeDiagnostic: DB8PR04MB5834:|PA4PR04MB7965:
X-Microsoft-Antispam-PRVS: <PA4PR04MB79658EF573314D10F125620496A20@PA4PR04MB7965.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:597;OLM:660;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: SW9naaWB2gDmf+395Dq+Exx3WAUsjsPiuBNX50GR8ZIkcOMMomqVhIY+d2tUKRrUeZpiwLD5uRHw81JM4SSqz1e4Zmxl8BI2UwCGs52gVbZzZZ1IRnMUwiUdLoD4DEkKAjvGRxcrRitDWDDOemAricT/3aj+qlboZ/V+QT/2iQCUG+p/xvNwrG5iBPVDDsz384+ZiHB5YIEA/r7iMZ6Y9jrQ+y50bxplov/qZ5RPo+oJeu7R4etMLxoj+Rn5y0iuGUkT07mOu+syOHtuO/T68t0ApT2AWsxfDL/zOk+SXehdIHFfzvl+PU/rV5WZ7z3mUcq6NCl3uIeIkE4vj7mLlyP5MJaZMxxhG8gghjSUUlr7P3kCos7PUnK8/HCbrbLLDidgDDR67xAiRKDP0nlAGyyt2Ca2Wxos+BvDggVSyiuY4F8evQJGZduuwMyjipQRgPhGtQv/fnTEd3xUpzd/ev/X4OxtIu7OaZmB0G4YAp+fMtNY4AcBuhMLGYFOE03EQY+zgEJuErymTsWl26k/rpJJQL38L4EP4131UacHPLtL2Yyayf3zqbeGCptggNFf9lwCd6i1Zxl+C+x0klZ3Lq5eXgEIZ3AJNiWwm+uFg3w02o80RssvYiqW/DdHX1ekVo0KaSvpI16mc2XWUhqjZKzD3NhpMSXQQngpv/nbUmoIbMH/n71VvsfZFhD8h5/x
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6523.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(346002)(366004)(136003)(39830400003)(316002)(6916009)(26005)(16526019)(186003)(83170400001)(66946007)(52116002)(16576012)(66476007)(4326008)(54906003)(83380400001)(2616005)(44832011)(6486002)(8936002)(956004)(53546011)(42882007)(36916002)(31696002)(66556008)(478600001)(2906002)(36756003)(5660300002)(8676002)(966005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bTE0ZWVNZ0ZRU0pIVWFwSU5hamNkOGU4dFNhRjMvNmJaWEE1b2Mvc3pLSEs2?=
 =?utf-8?B?dkN1SWFNVUpvT3k0STU5SVBpMER4Ky9XNWJEaTl5Y0tBV1ROSERLLzhkaGtm?=
 =?utf-8?B?M05sVTRZdWdPbWY1ZXduUjM5MDRpL2Jhc0ZDRU1mZEFVU1YvZ2FzVkVmZlNw?=
 =?utf-8?B?VTVocUExR3EyRWE4YzllWm9xeisrdVB0QVBsVWU2M3BmaTVYNThkMDh4dElS?=
 =?utf-8?B?ZzZDMmx6Mzg5WVFmK2tYaG16WVlPbmQyVzJ1Wm1MVWloYytQZElzUGRJRlZX?=
 =?utf-8?B?dDhFK0EzQ1hBaWd3SzFKM1JwQWpWeWFQeEd5azNUZVZ5YVJIZWRIamVkRmpS?=
 =?utf-8?B?VVhMR2Y4YUlWOW5RV1lpWU8yR3JhZnBFbEZPUzNBbkNUQlR5R25ZQVZaRlo3?=
 =?utf-8?B?eTBLMTc2Q0JQblZXN3hsM1JiZjNsS3RObVBuQ2NtVDlHVm5MV3IrSEE0bUtB?=
 =?utf-8?B?R1h3d2RuMENRMFVqTWlYL2l2a2V3NmdKdTJrZ1h1enpFWHpVZHk1U294OCt1?=
 =?utf-8?B?RUI0cUtnZG5ZODNjWmZrUElmWEJGUGtyMnNFUkF3QlY4b2E4ejBEQUZraUpV?=
 =?utf-8?B?VGtaQk1WV21QNzN3ZUMrVG04YytSSEVHQ2lGREx1ZTQ2VUplbXN2YXB6S3BV?=
 =?utf-8?B?ZXFDajB3cTFuS0Q3MllWbXlJYVc5eVU2UWxYZVJuMWtwTHVYU2VhWFVlUmNj?=
 =?utf-8?B?eGZMRjJrQTFVY0RrK2pNUFpISnNha3BiRnhhbkRiajVVSG9DSnJKNEwza2xC?=
 =?utf-8?B?emdpSElRYkFieDE4V3VvVEN4LzdMb3lHMzB6ZnQ1bEU4VXNKWndUS09kUjNh?=
 =?utf-8?B?ZUpMZHBCcERacHlLbEpFUDBGckdmelVSa29YNFNTb1ZSeC9vQ2d5a0tNSk9K?=
 =?utf-8?B?M0REQXdndncyOVMxL0tLWDBNOWw3c1lQTkcvd2NjVUlveW5WbDlodFJWcjRK?=
 =?utf-8?B?UGdSMmZJUEdiYitBVVlRZjhZUkxjK2duckFjWUsxcXhKbUVVaVYrWmpUTTRz?=
 =?utf-8?B?V2FTVjRkMVY0RnFNN3pQMy9pTXdEQ3I5dElHcGJpaFZZdW9DdG8wVDV6ekRV?=
 =?utf-8?B?QW8zWUZ2anF0cDM2ODlkQVpCOWUxWHU4d1BqdWZhTVZvazNhcUtNY1lKWXJa?=
 =?utf-8?B?VG04QW83RkJaY0xPSHlQMWExSlZHNDJ4TG5iMFpBUzVoWmtxRXQxZHdsTFQz?=
 =?utf-8?B?elZOU3VrbjBSVEhmQ1VuejJlQkpKbVpDbVdSSDhDN1F2d3JQdEZtbDFXSmcv?=
 =?utf-8?B?b3NLdGttOXI2bVdRSVZmcThVR2dtby9mTldYeUZoM3BZcksrUnRQTzcyb24z?=
 =?utf-8?Q?myTy/bx9Zr6JGJ+Y7d4HZ6lr0BE4T3cFC3?=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5834
X-CodeTwo-MessageID: 3ffeb23a-34ea-4add-a059-5c0b8deac3da.20210120072131@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: HE1EUR01FT008.eop-EUR01.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: ca846230-48c4-408a-c97e-08d8bd14018a
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rrfmMFyRtViGgQ8htwcwrEjAu8k6N01AhC44OuxDEPAmY88rDjQeaCSuY1C15SC0B9TcAvTVeDSPMNrDsG9QrgiGbJiOsyuK2+ReAJqsVEvZTzTogTklMCzvxBdndPaoKRfWXlcef7zZ3ha8EjxuCcYS1R83zKqY63jccwemWsSZxRDplZv2bShtSiXHnqze2lv5EdUrhz5kZI6DkEmvEnwwAZOh2ZDkrESWXUOB5//rfxqRcAVOtD0D/VfGAZXZ6cJFHbTV/xuILSZCedKttjdc9bGS6Wdg60YQINJDvh9twlj83IEOhBzEVgo3Dk+eBjZqOwfG2iQIq2v7dVsnhR1FIbcE3LjJuwGNjWX4sqfq64UVnktjEwbjlP28v14T7H57OQ7WvwFaZl5rxhYPoTHeKcRFvIk5SNyBptMFXYQ0q5lUVlAabeB+LPYuv3DHxkbZT79DN7SsBrDGJReHTuJ4M+/RdnOLacOdbkPbuMgDGztEOaE4n+8zoTSSbMHnCuHHXrAw85G3fzGnF/SxeuliDVIOgbtTf78xB/gDBpEHOXhirehP77u5nOCMdI58
X-Forefront-Antispam-Report: CIP:40.68.112.65;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(346002)(39830400003)(396003)(136003)(376002)(46966006)(70206006)(956004)(83170400001)(36756003)(8936002)(2906002)(44832011)(15974865002)(82310400003)(186003)(5660300002)(16576012)(6916009)(478600001)(47076005)(7636003)(356005)(336012)(31696002)(8676002)(966005)(31686004)(26005)(53546011)(16526019)(54906003)(7596003)(316002)(42882007)(4326008)(2616005)(6486002)(70586007)(83380400001)(36916002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2021 07:21:32.7089
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 590ac6e6-71dd-4a5c-ccdf-08d8bd14038a
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[40.68.112.65];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR01FT008.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7965
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Wow, fast response, thanks.

Updated my dtschema, fixed the match name as requested and v7 is ready=20
to go. I'm awaiting feedback from the iio people so I can send a new=20
patch set.

M.


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
On 20-01-2021 02:31, Rob Herring wrote:
> On Tue, Jan 19, 2021 at 01:46:21PM +0100, Mike Looijmans wrote:
>> This adds the device-tree bindings for the Bosch Sensortec BMI088 IMU,
>> the accelerometer part.
>>
>> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
>>
>> ---
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
>>   .../bindings/iio/accel/bosch,bmi088.yaml      | 55 +++++++++++++++++++
>>   1 file changed, 55 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/iio/accel/bosch,b=
mi088.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/iio/accel/bosch,bmi088.ya=
ml b/Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml
>> new file mode 100644
>> index 000000000000..459b9969fd12
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml
>> @@ -0,0 +1,55 @@
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
>> +      - bosch,bmi088_accel
> bosch,bmi088-accel
>
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
>> +      The first interrupt listed must be the one connected to the INT1 =
pin, the
>> +      second must be the one connected to the INT2 pin.
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>> +    spi {
>> +      #address-cells =3D <1>;
>> +      #size-cells =3D <0>;
>> +      bmi088_accel@1 {
>> +        compatible =3D "bosch,bmi088_accel";
>> +        reg =3D <1>;
>> +        spi-max-frequency =3D <10000000>;
>> +        interrupt-parent =3D <&gpio6>;
>> +        interrupts =3D <19 IRQ_TYPE_LEVEL_LOW>;
>> +      };
>> +    };
>> +...
>> --=20
>> 2.17.1
>>

--=20
Mike Looijmans

