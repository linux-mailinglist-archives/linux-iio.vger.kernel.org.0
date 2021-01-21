Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A52E12FE559
	for <lists+linux-iio@lfdr.de>; Thu, 21 Jan 2021 09:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbhAUItY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 21 Jan 2021 03:49:24 -0500
Received: from mail-eopbgr130074.outbound.protection.outlook.com ([40.107.13.74]:37445
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728071AbhAUIrc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 21 Jan 2021 03:47:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=topicbv.onmicrosoft.com; s=selector2-topicbv-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NgzXLsVuacyyED96pJN68cpm8jlw29WFOk5T4mWS3aQ=;
 b=EbmxCAIYCf5WB1QXMMrShFx0ZjxjWXlNlWQ2NWolU1Cslm4gQtt0YHDxECRA7nHzaStZ6V/GR4K/s3sN64vnaRma6C/4EGTDKCrn/MgGTtvqV9IjAsam2tVL1t6ImbyMcMjE2O0Au0LM9KrpPQPieyW/4vpih45ot4J/U374yPQ=
Received: from AM6PR04CA0031.eurprd04.prod.outlook.com (2603:10a6:20b:92::44)
 by AM0PR04MB7185.eurprd04.prod.outlook.com (2603:10a6:208:19d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Thu, 21 Jan
 2021 08:46:27 +0000
Received: from HE1EUR01FT005.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:92:cafe::50) by AM6PR04CA0031.outlook.office365.com
 (2603:10a6:20b:92::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.13 via Frontend
 Transport; Thu, 21 Jan 2021 08:46:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.68.112.65)
 smtp.mailfrom=topicproducts.com; vger.kernel.org; dkim=none (message not
 signed) header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topicproducts.com
 designates 40.68.112.65 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.68.112.65; helo=westeu12-emailsignatures-cloud.codetwo.com;
Received: from westeu12-emailsignatures-cloud.codetwo.com (40.68.112.65) by
 HE1EUR01FT005.mail.protection.outlook.com (10.152.1.229) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.11 via Frontend Transport; Thu, 21 Jan 2021 08:46:26 +0000
Received: from EUR03-DB5-obe.outbound.protection.outlook.com (104.47.10.51) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Thu, 21 Jan 2021 08:46:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hTBaX63hWY/zazzfYX6I5eagcaU+qaFPsUzxKUbXAxCoKVZnsiGXu5DdXhGwYisVw8KNzukpJSaCAF/fbWa+9eB4NfUbkpKXFTXZFt2yXZ0mnfOGAMjnBfnzLPXmCUGwWonRhJxxlTgw8QWTZ/mC92eHgQP3SqfnsA3tU1jiWQcbcJii+CaSvGZPBOSvcXwGtQAdVfdXaoPiU5n9Z+pvS5SrtyIACnUpK0E93y4Q3qBg0QoCOHmj/Agq/XTTbwHTDLxKneajxAK/frq8Yxpr6BJ1OfauQ3XHYLAJd2654nGGA4yJU/z5Z6Zq1Xi6ckff2bTopzJuPzfXPplUaOPLXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HRzCkwaYUve3kVtX7ojvLjvMbo/zZOMSkcBAspItBNM=;
 b=b5FMxCPqoTPUrMGu9vcg6nfwh0pBd+qiGRpX4fSOVHFXR6Sh7nUX+r3qawsKCyrqbnrxlYPy7sVu2ViuwsMQx8JdOtUWKs0632ewoCoc5TzfXiLx20PscKcXfobiKKf7SYCTECnAVv24oVswRFbMQYjdZLl/wafFBh418ATf7dZei5IJQDyzYEr3Vmfq6524RmvGLa0MM9PAY52Ww3Cy8D87aw/z7YtBxEGVXTRfilJrIqnuw+Ml7OiF5SRD+/nxGBuJcEEBe2fb/mmiaRUM66w9YjgSBBwryZiQ0mPU1BKPr1M7C8plmcNqTBrs+MkpG2+Bdz3tR3aNIMkKCbnLwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topicproducts.com; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
Authentication-Results-Original: vger.kernel.org; dkim=none (message not
 signed) header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=topic.nl;
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com (2603:10a6:10:10f::26)
 by DB8PR04MB6924.eurprd04.prod.outlook.com (2603:10a6:10:11e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11; Thu, 21 Jan
 2021 08:46:21 +0000
Received: from DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::792a:b2ef:ed50:a1a2]) by DB8PR04MB6523.eurprd04.prod.outlook.com
 ([fe80::792a:b2ef:ed50:a1a2%4]) with mapi id 15.20.3763.014; Thu, 21 Jan 2021
 08:46:21 +0000
Subject: Re: [PATCH v6 1/2] dt-bindings: iio: accel: Add bmi088 accelerometer
 bindings
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210119124622.9490-1-mike.looijmans@topic.nl>
 <20210120185052.000064df@Huawei.com>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.c9179140-7138-467c-85e9-419e68c95bd4@emailsignatures365.codetwo.com>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.0d2bd5fa-15cc-4b27-b94e-83614f9e5b38.02f2b6e0-f94c-4e13-b820-c0a2b10c9a96@emailsignatures365.codetwo.com>
From:   Mike Looijmans <mike.looijmans@topic.nl>
Organization: TOPIC
Message-ID: <6a9dd87d-06f4-3a9b-ce03-08df15d6c2f6@topic.nl>
Date:   Thu, 21 Jan 2021 09:46:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <20210120185052.000064df@Huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [81.173.50.109]
X-ClientProxiedBy: AM4PR0302CA0004.eurprd03.prod.outlook.com
 (2603:10a6:205:2::17) To DB8PR04MB6523.eurprd04.prod.outlook.com
 (2603:10a6:10:10f::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.80.121] (81.173.50.109) by AM4PR0302CA0004.eurprd03.prod.outlook.com (2603:10a6:205:2::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11 via Frontend Transport; Thu, 21 Jan 2021 08:46:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a26c370-3adc-4ea2-a98b-08d8bde90a14
X-MS-TrafficTypeDiagnostic: DB8PR04MB6924:|AM0PR04MB7185:
X-Microsoft-Antispam-PRVS: <AM0PR04MB7185F74F26FB83E907FE38D496A10@AM0PR04MB7185.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: j2Y1er9n/+udNWN5nH4165HVXlfIDQFVZpxmx3odTPtjGUPz2qDYVPlch9wkf8CwqZ03PdmfSuWhqBl+6HF6HaolvJRpAMBmtpr8LFT1+HCm/KDEMLhmQZmmID5b/No8tSMmZrM2CkKI4osYxPIBsOEYO/WnuESyE9Y2QzEjAZmG2+7AYEz/zu0Rx7i/x+YazJzN3PzLpNn11LqtGRgr1FsL/eoYrMINbV7ozzpByzVIK/SIyvC8Yi1zrpo7V00TZ443VQFg0njUNvZfFPtvpRb6LjAJV0b2XnOCDaN4pl3HWgejADw5bgHIUF3OHIMz/AtolewupOG35Vy+TA8mnxhjB738NA3jEgTmA0DUJLa/gDBqlX4GmNNGDxUaQOvt5T38m2khtGQupssZaw3sNZev41Rx1X1SnbolWqZywpwFkCpgjnxrb+UZqyhxeoJWtNPYTO8RWO6x/ntBLXqLnMoQHoHgwxD5GPB3m2fwd+CGuNWYrlOFG5c9zzZRKgE9qi7hrHI/AJnFksMca74FpEDWgpL38Po4upkW7gL+S5Q=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6523.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(136003)(346002)(396003)(39830400003)(83380400001)(186003)(966005)(83170400001)(2616005)(16576012)(31696002)(16526019)(8936002)(956004)(44832011)(36756003)(6916009)(66946007)(8676002)(5660300002)(42882007)(52116002)(6486002)(36916002)(2906002)(478600001)(54906003)(66476007)(66556008)(26005)(316002)(31686004)(53546011)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TUZmQ1Y0R0NUdmpqZHFsakRvOVY1MDFGQUxGRjFCNUJSYm94dGZkZUtVaVhl?=
 =?utf-8?B?RDF5dmlla2NtQzNnOWQ1L2FIbERwVkVySnMvTVBtNWdTT1dWL0tTY1FCZUR5?=
 =?utf-8?B?YkF5ZitRL1dZdnZGVXFqc2xyRjdLN2RTa0FMbEVZc1l2QkF1Tk1ROVdVYlF2?=
 =?utf-8?B?R2gxUzZ4TCtrdjFPWVB1S29CSWh6ZEZ0U0hzNldqMjNrMnVUdG9rODREOXRW?=
 =?utf-8?B?ZEpPUTJSUk8wSEorazhTOHlxRmhJMDltc3ppblZ1NWVPU3lLZjBVN2lqSXBy?=
 =?utf-8?B?dk1EYlF0Umt1UnJySG9IZFJVTzBOV2YwekJNTnZ4M0pONnJ0WFp1NldJcWlZ?=
 =?utf-8?B?cFRBRXptcExWWGQvcHFHWitBQkMvd3lIRkFjWm5xSnZxNnloRU9FWS9oU0h4?=
 =?utf-8?B?eWYxQ1MyU1NhOUJnbmt1MkJsbGxOUGh3K29kb3lST0ZjNklBTzVCamRodlE2?=
 =?utf-8?B?TkplSDMveG4yeWZxb205SFJSZ0JkZlJQcmh5Z3ZSWTNXV2d6SVI1ZmQ3MjY3?=
 =?utf-8?B?ajBHQTBCQnF5UUpVdDdPVUxmem5oaWoyOEhUbWxtc0JEUVNOTkh0QkRNd3Ru?=
 =?utf-8?B?dUdGTkpxRWFDRHdZd3ZqL0M2TVdZSkwrV1hOTThDUU1YZlUwdGV6em02MU1w?=
 =?utf-8?B?NnpMYVJZTUJrNHpYTHlrSCtMd0VSZlZjRDdDamNSRkh3WVJyMjFkdjBLNlpX?=
 =?utf-8?B?TmlXYzZvVENKcHZDaE9oOWJxa3pETzNuTEZIR0NhOWRiVDhqbUdwREdRdFVQ?=
 =?utf-8?B?SGxmeUd3TmExZkxNd0hPWTBCVEVUMlNyYW9KQ2QyZ2xDd3BEd2dJWWxZUzZT?=
 =?utf-8?B?bDFKQXd3bUdFN094dmZXelIrRWc1MkdCVDJOcERzR1E1Ui9STERNVXU2MDAy?=
 =?utf-8?B?UTFaVVVpRGtPa0tSenhjeWxuNkxvcDJPRnBRZ1pKN2c1dlhPWFlMTmVSR2FH?=
 =?utf-8?B?MXR2WEJUNFh3U3lFMk9Eby9BY1FJSUxPd2I2ZE5OTXVEYjJGOHdFWTdhTjhn?=
 =?utf-8?B?MEZ5ZGhYNStwY3VKakUvRTRWZjlDcGdGWGJxbnN2SjZwUjhjdzUvclFSUFU0?=
 =?utf-8?B?RFlLaXhyTDJkY1pINkpKejZxSTJwNzczRXlTYmJHR3Y5UEI5bXRVcFU2WDIz?=
 =?utf-8?B?czVib1BEdkxXS1Q0eUdoYjNUMlBmZHA4cDR2VVd4a1pGQThhdEM3ZWY1ZkEw?=
 =?utf-8?B?UE9sRi9RYnhmanB1RlFjenZZM2VpQ0FnYlBKR013Ym5XSXVVRGtoQ0dUN0Uz?=
 =?utf-8?B?OGdnbXFqVDJnd0NjWGJCNjBlamNOaE1DZ0ZWYVdabnBrZ0VueFNpa3VnYW94?=
 =?utf-8?Q?1/DZ3essTqWxR4uO7xz6fHZoiTxCZUflrx?=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6924
X-CodeTwo-MessageID: 647fefc3-856f-4b71-8794-1b6c33976720.20210121084624@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: HE1EUR01FT005.eop-EUR01.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 0861686e-da4e-4857-267f-08d8bde906b3
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SHLB8adyA/S34SxJXeS4w4B7HmN7vvehmjFPyXEd8V6h7T2XUT4+5Y43NzX2LQIZWBZTVPrNuLAt88TGuC1DPFyne91KR1feB1W0Jw2qDx0rQ0oGop3UxTMgdiACzkhpaRVmSO0l5KEXZW/ktWpQ41w+xPtFZmF/ZYS572bxPXftznzQBqE4agle45SbE+Mpnoka0xmX1ECFIxS+CXbLZs7tLKsSSCocKmCVkY5hxKRDqkZeHLpUPXck91fEFRintmf+l3Th5yQUVRfju+0BzIW+LbVMFxNQw4AQpcyHto/mPSioMZkcc/ZBb4cFUL0+QbirH/Iv9jV5FwOD1l9bkXRA+w3RONQZDTv43KqU0eVKqXnr6hxqf7uRUpiT0rxb+esXa0vupqXTeifyIOUL8ihMZpTnbgXbwSaoAbqDU8SJfLvH9PWTMOiYNP8rJ/GtXvYr7b6Z4TujtZpTOVQMUD+RIkj1tUlznguPbdc2LL1gAecE5Hl5KoG2ukduhdvwnRwIOh4iRryKTaYxEH3AgpfLfjw5MFJhs0nZ0zxC/Ica2uSZpZK8HZ55m0T4pv+p
X-Forefront-Antispam-Report: CIP:40.68.112.65;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(136003)(376002)(396003)(39830400003)(346002)(46966006)(47076005)(31696002)(316002)(356005)(53546011)(36756003)(82310400003)(186003)(8676002)(54906003)(4326008)(6916009)(70586007)(26005)(36916002)(70206006)(16526019)(6486002)(15974865002)(16576012)(83380400001)(336012)(7596003)(966005)(478600001)(7636003)(5660300002)(83170400001)(2616005)(44832011)(42882007)(2906002)(8936002)(31686004)(956004)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2021 08:46:26.4752
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a26c370-3adc-4ea2-a98b-08d8bde90a14
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[40.68.112.65];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource: HE1EUR01FT005.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7185
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Comments inlined below.


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
On 20-01-2021 19:50, Jonathan Cameron wrote:
> On Tue, 19 Jan 2021 13:46:21 +0100
> Mike Looijmans <mike.looijmans@topic.nl> wrote:
>=20
>> This adds the device-tree bindings for the Bosch Sensortec BMI088 IMU,
>> the accelerometer part.
>>
>> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
>>
>> ---
>>
>> Changes in v6:
>> I't been almost a year since the last commit, sorry...
> No problem. Happens to us all sometimes!
>=20
> One thing inline below.
>=20
> Thanks,
>=20
> Jonathan
>=20
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
>=20
> What if the board only has the INT2 pin connected?
> That's looks to be a valid hardware configuration.
>=20
> I'd suggest using interrupt-names to cover this.

Yeah makes sense. The pins have the same functionality, so either one will =
do.

>=20
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
>=20

