Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A153619672F
	for <lists+linux-iio@lfdr.de>; Sat, 28 Mar 2020 16:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbgC1P4s (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Mar 2020 11:56:48 -0400
Received: from mail-eopbgr80087.outbound.protection.outlook.com ([40.107.8.87]:17634
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726518AbgC1P4s (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 28 Mar 2020 11:56:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=topicbv.onmicrosoft.com; s=selector2-topicbv-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aY6ahVDIRQGmtjRU1hd7ERdLQCtQz7mrtNeJj0Btobc=;
 b=VD4QbuI6D2WcxwvoKc7Pab2fZiDskAyrOpwBT34v2KIo5XdnE1zyTyxw8XKkt2RO6LwDObPwlKubvO/+Oq6U0RmrvxkU2c+MQWQ29Xr2lXf6a4QpD7Jjee/tEWErqdbIX42vJ5FG+hdnEGXPSfoD9Bd8PWKwbHFV34Er/WvgpJQ=
Received: from AM5PR0402CA0014.eurprd04.prod.outlook.com
 (2603:10a6:203:90::24) by AM6PR0402MB3415.eurprd04.prod.outlook.com
 (2603:10a6:209:d::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.18; Sat, 28 Mar
 2020 15:56:39 +0000
Received: from HE1EUR01FT047.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:203:90:cafe::a0) by AM5PR0402CA0014.outlook.office365.com
 (2603:10a6:203:90::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20 via Frontend
 Transport; Sat, 28 Mar 2020 15:56:39 +0000
Authentication-Results: spf=pass (sender IP is 13.81.10.179)
 smtp.mailfrom=topicproducts.com; arm.com; dkim=fail (signature did not
 verify) header.d=topicbv.onmicrosoft.com;arm.com; dmarc=none action=none
 header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topicproducts.com
 designates 13.81.10.179 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.81.10.179; helo=westeu13-emailsignatures-cloud.codetwo.com;
Received: from westeu13-emailsignatures-cloud.codetwo.com (13.81.10.179) by
 HE1EUR01FT047.mail.protection.outlook.com (10.152.1.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.17 via Frontend Transport; Sat, 28 Mar 2020 15:56:38 +0000
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (104.47.8.51) by westeu13-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Sat, 28 Mar 2020 15:56:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cU/2ESMXc23Hvx5kyDhw8upqnPLXlJKrk/7O6dEiYsHL4lPfW/NRi9JDNbjcacN7SP7M1+WfFuXuU7mmy58Aki0GkyuJhK+2DvqCqU6GmvGkktHM76HcDYMBI5bKy/d9zh8ZV+S+zX6xh71K5S9JgTFaDIZd4lV3SEIQcyOZ9vlT1xd8zRGyWcwIDKx4gfmNOjw7qPH67DLuYSpVIZqdj2nS4AzeXhVpQolUOIcClLUE5zJQHfCqwuMJk2sDCYQ0DzVDvm+R7ZdAGLWwvXXVjNKoxiptcUiA4RjyS8rXpOZOqFcJ4Kft7l1a215NnZ/uIxfsmPPqMKr4/cJgETymSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aY6ahVDIRQGmtjRU1hd7ERdLQCtQz7mrtNeJj0Btobc=;
 b=hVQT21u+r+tzASbPWP3G7nfXZLh7RG44dMaTrx7wMzo44kRpCgV7DkhcAX0muMffHu+FVpeCnRThlCsjIjeedQ6XiwgxfhW5Zp9BDv+U7vcNE2iHwvTwNG+XJk6Wqh0ECHGXnb3MUiZDis+tzC+i5bSqSFds1YJAFN/q2dF7UU8uMGZsm19fek7bK8pNTX8YAbuSnTJQTsb/V0uT7oVisrLomExIybGRlTBSxjeXkKCAwbFU1EFPQW2yKBOG1e3wZSHG2vsajiaCsMGYQPwaICXtHOBylM0xVxoCjmfwdKGDajv7ao0XadsAhOy9PrUQr/NIJct3/Fz8L1Ah8mktug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topicproducts.com; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=topicbv.onmicrosoft.com; s=selector2-topicbv-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aY6ahVDIRQGmtjRU1hd7ERdLQCtQz7mrtNeJj0Btobc=;
 b=rkOfyeDKoDH/WdR8Wi4TxgdoUdv7MOU40ZfMVI+Ugy78IWKF9Z78PI975DJwhZxycur5TJevT3RhzoLvbO69YoGOG6wW3QlrZJkY+zyumtIjQQugWy3rPGRAPwYpdTOGP0HRnAc+EpeEEGk2U4xdJW6F3NMBesZc14VROlTk8D4=
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=mike.looijmans@topicproducts.com; 
Received: from DB3PR0402MB3947.eurprd04.prod.outlook.com (52.134.67.147) by
 DB3PR0402MB3820.eurprd04.prod.outlook.com (52.134.65.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.18; Sat, 28 Mar 2020 15:56:34 +0000
Received: from DB3PR0402MB3947.eurprd04.prod.outlook.com
 ([fe80::380e:f722:2d0d:9c71]) by DB3PR0402MB3947.eurprd04.prod.outlook.com
 ([fe80::380e:f722:2d0d:9c71%6]) with mapi id 15.20.2856.019; Sat, 28 Mar 2020
 15:56:33 +0000
Subject: Re: [PATCH v2] dt-bindings: iio: accel: Add bmi088 accelerometer
 bindings
To:     Jonathan Cameron <jic23@kernel.org>
CC:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com
References: <20200323095551.23500-1-mike.looijmans@topic.nl>
 <20200328151928.12f5517e@archlinux>
From:   Mike Looijmans <mike.looijmans@topic.nl>
Organization: Topic
Message-ID: <7215fe03-988b-518b-ddbd-6152c07259f5@topic.nl>
Date:   Sat, 28 Mar 2020 16:56:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200328151928.12f5517e@archlinux>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM3PR07CA0059.eurprd07.prod.outlook.com
 (2603:10a6:207:4::17) To DB3PR0402MB3947.eurprd04.prod.outlook.com
 (2603:10a6:8:7::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.130] (83.128.90.119) by AM3PR07CA0059.eurprd07.prod.outlook.com (2603:10a6:207:4::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.9 via Frontend Transport; Sat, 28 Mar 2020 15:56:33 +0000
X-Originating-IP: [83.128.90.119]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd03b5ec-b026-4d1e-6275-08d7d33099da
X-MS-TrafficTypeDiagnostic: DB3PR0402MB3820:|AM6PR0402MB3415:
X-Microsoft-Antispam-PRVS: <AM6PR0402MB3415F23E6637C0F95251E5D296CD0@AM6PR0402MB3415.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;OLM:8273;
X-Forefront-PRVS: 03569407CC
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0402MB3947.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(396003)(376002)(39830400003)(346002)(136003)(366004)(31696002)(2906002)(81156014)(42882007)(81166006)(8676002)(31686004)(66946007)(5660300002)(66556008)(36916002)(66476007)(8936002)(52116002)(44832011)(2616005)(956004)(316002)(6486002)(186003)(53546011)(6916009)(16526019)(26005)(36756003)(508600001)(16576012)(966005)(4326008);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: topicproducts.com does not
 designate permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: RFyCJpj0KwIuJI5LwV8IBpysDqM8asc+OWmEqoHiG9DbqvQ0/G6hw9uwy1V1eLKbdkvO+DshCgY1B3zNpryra1eXzcgC8GvN5be05QTJZavKpWX8QgjM1IWJDE3s7/PR3LuAPd9qvJNkvVeSXEJT2N5TAiGEUaiT2D6Uj5Gp4uGdD5q52Y1UE5j59yDAPG7/Jn9A1sHx9Cd9JUsNnFxWxft6ikaFaY39LjWFvTmNQ1BM9sk94CVcUtA8py1bMluZaGhcRwl8BCGsL66cauZJUxokbc/Lg3d9br3Ekc2RyciF5xNWHThzuvp8ZIVkd7afB23uBYtrQaHb0WZu0Gsd6X2rFAXoxwGelxXZ0rfi7gLR+6fah1u5eaEgIP95De4gFZ8V8h+WiQYvi2vCFkhyvzz2y2OQuP/Fm7HGim//PLMQD6E6GM7YMEq4UrBAVPbVTw0ulvzV5HDDecyFfvp7Yy3cdFkxdHfqHsn937ztFu6hGTj6+JES8qYye4w13Hi+y1c0JB5aFYiyqfUBsS3WYQ==
X-MS-Exchange-AntiSpam-MessageData: gShpX05w4tF9TKxaw9/daBlN+UiTOAn4vkzhvR79THZd+zv7fVz3OwZ+XnZfB764IsElwFqubqcL21cYL/Uyf5xlXF47Lm1tDGmkCcMrcm6d+KvU/wKLzT/FsB4o547ITB911RIwBglliQTs5oaL7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3820
X-CodeTwo-MessageID: a31156c5-bf95-4176-aee7-93c2129092ad.20200328155636@westeu13-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: HE1EUR01FT047.eop-EUR01.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:13.81.10.179;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu13-emailsignatures-cloud.codetwo.com;PTR:westeu13-emailsignatures-cloud.codetwo.com;CAT:NONE;SFTY:;SFS:(10009020)(136003)(376002)(346002)(396003)(39830400003)(46966005)(7636002)(966005)(44832011)(246002)(2616005)(956004)(53546011)(31696002)(8676002)(508600001)(6916009)(7596002)(8936002)(6486002)(356004)(42882007)(5660300002)(336012)(36916002)(16526019)(186003)(31686004)(26005)(70206006)(82310400001)(316002)(70586007)(2906002)(47076004)(4326008)(16576012)(36756003);DIR:OUT;SFP:1101;
X-MS-Office365-Filtering-Correlation-Id-Prvs: c8cf5a23-6035-4ddf-7438-08d7d33096a2
X-Forefront-PRVS: 03569407CC
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J/Pgh76tTZyuSiE2G8bjhMG7rsQSV8qxq5tQmRVs3prDyaRRHj70+YrUV+xMAHwI7POqBhaSeZe89gmc6mZS4UwLF1V2Ig4uPLnRp7kBkDzfpGAYfVPreiFIBV9YPq4C0SzklgEfdYwTB7GdY1OJLOaD10CgDfwhsttV4hPM6CtM3sefllddo1HAdQw27B2zScNDn9mqzHL+oXdz/ZtK82lcDDW2NmlX/qo24c/R3fxuPNd/YJe+eRHJFkp1rBR76/TXXKuN26RYKaZQanud8HTy5Wmt17WeZERgMeP0oMGU/dP1pJ16qjrFyjaRq2uAjWNJs6vHGJ05mI0IWTMziN2/af5QTjMLFbmKKtCgzdhl9xOZLn4LgzwKb3GHaBgBR8coJAmKxD2186w9IhwPzUNetFu1ayH+3Y6LSgTQSyrtN60trODdHxd8iITqKQJv4WxofXUNvfQ+bzXZZRq2npnfvFRHsGlWb99L2tCXODwVpLTPyx7R/9oMWqNmR/6rnWKUME3GyjTGrUiyil1SvmzDuH93QFDaLvMLEX07cDzzQeEElartHeP2SwwhcP5ajevvI5/gMSr5iWk1vSy+CQ==
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2020 15:56:38.6802
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd03b5ec-b026-4d1e-6275-08d7d33099da
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[13.81.10.179];Helo=[westeu13-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3415
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Interleaved comments below.

I'll send a v6 bundle with the updated bindings.

On 28-03-2020 16:19, Jonathan Cameron wrote:
> On Mon, 23 Mar 2020 10:55:51 +0100
> Mike Looijmans <mike.looijmans@topic.nl> wrote:
> 
>> This adds the device-tree bindings for the Bosch Sensortec BMI088 IMU,
>> the accelerometer part.
>>
>> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> Hi Mike
> 
> The binding should look to be as complete as possible, independent on what
> we are actually using in the driver.
> 
> A quick glance at the datasheet shows me this device has 2 interrupt lines
> dedicated to the accelerometer and 2 power supplies, vddio and vdd.
> 
> Interrupt lines for flexible parts like this are fiddly to do, so take
> a look at how we do this in other drivers.  Hmm. the interrupt line to set
> a tag is 'interesting'.  I'd ignore that for now...

Guess for the interrupts we can just suffice to say that MaxItems=2 and 
it's up to the driver to make sense of things. Power supplies are clear.


> 
>> ---
>> v2: convert to yaml format
>>
>>   .../bindings/iio/accel/bosch,bmi088.yaml      | 38 +++++++++++++++++++
>>   1 file changed, 38 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml b/Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml
>> new file mode 100644
>> index 000000000000..715f79c3b2a9
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml
>> @@ -0,0 +1,38 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/iio/accel/bosch,bma400.yaml#
> 
> Should reflect the compatible so include the accel part.

Oops, copy/paste error...

> 
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Bosch BMI088 IMU accelerometer part
>> +
>> +maintainers:
>> +  - Mike Looijmans <mike.looijmans@topic.nl>
>> +
>> +description: |
>> +  Acceleration part of the IMU sensor with an SPI interface
>> +
>> +  Specifications about the sensor can be found at:
>> +    https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bmi088-ds001.pdf
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - bosch,bmi088_accel
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +examples:
>> +  - |
>> +  spi {
>> +    bmi088_accel@1 {
>> +      compatible = "bosch,bmi088_accel";
>> +      reg = <1>;
>> +      spi-max-frequency = <10000000>;
>> +    };
>> +  };
> 


-- 
Mike Looijmans
