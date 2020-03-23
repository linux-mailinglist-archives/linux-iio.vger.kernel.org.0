Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C910418F23B
	for <lists+linux-iio@lfdr.de>; Mon, 23 Mar 2020 10:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbgCWJ4y (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Mar 2020 05:56:54 -0400
Received: from mail-eopbgr10042.outbound.protection.outlook.com ([40.107.1.42]:36398
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727761AbgCWJ4x (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 23 Mar 2020 05:56:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=topicbv.onmicrosoft.com; s=selector2-topicbv-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GTEXr5ihoKR+FB8MpLDXhQgCKuCWoobr17dkdbOSkt0=;
 b=i5k1sv4/Os2f17yfuqBNFWcd8CDJ40Tb1HbzYWnrSeN1OVcL/QH7i/HRc2fXvK7UikXeL0GIj3jVrx+MTdSH8PLkxDA1ReAFjj24OnBf2qT0R5nTv15MZVlxvGuFmzqiRBLNzXKV8HHTwdR3QAou7SO8K3HWv9pNvpwP07J2eSk=
Received: from AM5PR0402CA0011.eurprd04.prod.outlook.com
 (2603:10a6:203:90::21) by AM0PR0402MB3746.eurprd04.prod.outlook.com
 (2603:10a6:208:e::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.22; Mon, 23 Mar
 2020 09:56:48 +0000
Received: from HE1EUR01FT031.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:203:90:cafe::aa) by AM5PR0402CA0011.outlook.office365.com
 (2603:10a6:203:90::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.19 via Frontend
 Transport; Mon, 23 Mar 2020 09:56:48 +0000
Authentication-Results: spf=pass (sender IP is 13.81.10.179)
 smtp.mailfrom=topicproducts.com; arm.com; dkim=fail (signature did not
 verify) header.d=topicbv.onmicrosoft.com;arm.com; dmarc=none action=none
 header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topicproducts.com
 designates 13.81.10.179 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.81.10.179; helo=westeu13-emailsignatures-cloud.codetwo.com;
Received: from westeu13-emailsignatures-cloud.codetwo.com (13.81.10.179) by
 HE1EUR01FT031.mail.protection.outlook.com (10.152.0.177) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.14 via Frontend Transport; Mon, 23 Mar 2020 09:56:47 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (104.47.13.51) by westeu13-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Mon, 23 Mar 2020 09:56:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IUFajBeOBWiPVua/k9yjzocUa1j0Of/4WBIne4bP3FdScb6oA4EE6yh7QwVrZ2x5+NUD79BTD/e4TP2vyRb2cySOTpSZ7A+oF77syijsWT3EjFTJkyT7qQyO599T9qLilz+dtFdnse5aNMu39D+ABWg25xxsgvpfYaDJcBSi7RqIRONF+gW0hkg24Z+SF2Yy26h20kI415/j592fp7L5waX199viWhWTlx70pihKlRXWforW073+VRKhRCDVJTGxdkyN+pEqawMW+3Y74i+88I/tKuqLVX+Cb9o2DL6vdw0X9mdHP+Wiwns/PUyI4y05Nh9cfp4Pl6dalgHWRh3/Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GTEXr5ihoKR+FB8MpLDXhQgCKuCWoobr17dkdbOSkt0=;
 b=baudYcU6Sa85M74/aAbXrsmWLAY/gvdNMYOoyAIomVdSijDdoRCDxhCwzWIHTif54QdGyLV3oTqjDMJOcrDXGvqcH9eT8D7wx9YvSR1qohg8hUfKXOlLAmMR0XNtfnPpWMQ3ZPZ50qJGEdKb2M7hneb+tsSI2B+5xI3t4bhqkNQBi8/jv5FRuywu2/C4bqhmxNrVZtO81iOYuX+KWVR4GK6F/BN4DdQ1ahkX8aYyyEHuDOPrU7p+TNXY69wBmPzbsLDE/vjgxP9s1dulcEf5baaCGnuaSKInO8vGazR+ELtct1EFKyXtzH+IdBL3W51V6AmsKAc3jvJY46mwEAejuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topicproducts.com; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=topicbv.onmicrosoft.com; s=selector2-topicbv-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GTEXr5ihoKR+FB8MpLDXhQgCKuCWoobr17dkdbOSkt0=;
 b=FKpWf0VIQ8M2inUd3Pxpuk8YCKScaqhWE7STGztkoxH5S49mC58l7pYLXkIDl1jPqJq3C12wipiZ0B7cbLd8w0Pq8OEUgeURIrNoyhXPIJF4f/nAiqRU1lEkbJ/29U/eoVlEqe4s27bsvPR7MmyOqXjg72zomzHSupFrkb7Ysvg=
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=mike.looijmans@topicproducts.com; 
Received: from DB3PR0402MB3947.eurprd04.prod.outlook.com (52.134.67.147) by
 DB3PR0402MB3769.eurprd04.prod.outlook.com (52.134.71.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.22; Mon, 23 Mar 2020 09:56:42 +0000
Received: from DB3PR0402MB3947.eurprd04.prod.outlook.com
 ([fe80::380e:f722:2d0d:9c71]) by DB3PR0402MB3947.eurprd04.prod.outlook.com
 ([fe80::380e:f722:2d0d:9c71%6]) with mapi id 15.20.2835.021; Mon, 23 Mar 2020
 09:56:42 +0000
Subject: Re: [PATCH] dt-bindings: iio: accel: Add bmi088 accelerometer
 bindings
To:     Jonathan Cameron <jic23@kernel.org>
CC:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com
References: <20200316065218.4103-1-mike.looijmans@topic.nl>
 <20200322173704.5cc497c1@archlinux>
From:   Mike Looijmans <mike.looijmans@topic.nl>
Organization: Topic
Message-ID: <d9105fb7-fe0b-d432-fb12-d595c364f83b@topic.nl>
Date:   Mon, 23 Mar 2020 10:56:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200322173704.5cc497c1@archlinux>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR04CA0004.eurprd04.prod.outlook.com
 (2603:10a6:208:122::17) To DB3PR0402MB3947.eurprd04.prod.outlook.com
 (2603:10a6:8:7::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.130] (83.128.90.119) by AM0PR04CA0004.eurprd04.prod.outlook.com (2603:10a6:208:122::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18 via Frontend Transport; Mon, 23 Mar 2020 09:56:42 +0000
X-Originating-IP: [83.128.90.119]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3711d50c-3028-453c-49e5-08d7cf10805a
X-MS-TrafficTypeDiagnostic: DB3PR0402MB3769:|AM0PR0402MB3746:
X-Microsoft-Antispam-PRVS: <AM0PR0402MB37462CC59907990E59FF3C6F96F00@AM0PR0402MB3746.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;OLM:7691;
X-Forefront-PRVS: 0351D213B3
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(39830400003)(396003)(136003)(366004)(346002)(376002)(199004)(2906002)(956004)(53546011)(5660300002)(316002)(4326008)(2616005)(44832011)(36756003)(16576012)(31696002)(508600001)(81156014)(36916002)(81166006)(6916009)(42882007)(6486002)(52116002)(31686004)(26005)(8676002)(8936002)(16526019)(66556008)(66946007)(66476007)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3769;H:DB3PR0402MB3947.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: topicproducts.com does not
 designate permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: LDhzRkpRod/aukZl/FS0hSxvG1I/+ui8d3s7mtFcEJ+dGzSB0IaTLQgQ22gfj7nBZSupmcIrgf5Np8UadkI4WYL2ARhU8e36eXy9Q3j8gtpGsLSNtr/fgP1xdl/paA4Vf6+N2plTiHAsINjW5V77bdj8tJgR6JydLFnM9oWxUYoUPiMzZ+qqh6SyV8KhotP+gDwlhu2LCWHMhUAZPL8aLZQ9x4TjMsHRohQCrHWkv5ys9XFzJT/fwVB3/otXle41HHPD4gsHUqPNYSr6fEI8aNqNdmVvIrw2HUtJprwVuhUUXqZomXw6a4P8Q9M8BOG/bSeAKjGHMQjsPz4OGdyXs9hX2xAYXEH/mY7hpXYj+ZLVCL0JpbTnMBaKRNEMifKAl8yqI/rYl0IdvK83BdQN4UeNL+A7vkE6B9C1eL8KoKKVulB+SYv8tm8jVkxD7aaW4+0+jhoU7eL+iO3Wz1DMkim66SdZxONhDurEHnEF8vzOz2Vy/6Ekdei6S9Ft26+aNmUhyi7pfNazmOxY3aZZeQ==
X-MS-Exchange-AntiSpam-MessageData: FqVtpD1B5z7uCHnmibmIw1KahKoiSy0EdyRNDrVFHIsA9IFSHjt/VUzx8uQnq/BU8hKunfXovfHgGItOT24mqNZn39ogAIFikugsTRUKBYM9vPjHO/nAplUf+/Bz3Hak64yXFuF3Lp5V9lJTkeuVgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3769
X-CodeTwo-MessageID: 0748f135-05df-498f-a256-d77e0c7afd67.20200323095644@westeu13-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: HE1EUR01FT031.eop-EUR01.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:13.81.10.179;IPV:;CTRY:NL;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(39840400004)(396003)(199004)(46966005)(2616005)(53546011)(956004)(186003)(26005)(16526019)(336012)(70586007)(356004)(70206006)(6486002)(42882007)(7636002)(246002)(7596002)(44832011)(36756003)(508600001)(2906002)(36916002)(8936002)(5660300002)(82310400001)(31686004)(31696002)(316002)(8676002)(6916009)(16576012)(47076004)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR0402MB3746;H:westeu13-emailsignatures-cloud.codetwo.com;FPR:;SPF:Pass;LANG:en;PTR:westeu13-emailsignatures-cloud.codetwo.com;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 5447c0dc-cc13-4ef6-f8c8-08d7cf107d41
X-Forefront-PRVS: 0351D213B3
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lmRbrCB5m51XiPj+9t1wciX/RJQj4OZAXRr4c47mARPnvR+t6Y5HZGoYN9pt0GZBl/2VXyw+IKYfKQjUaw1g3o6X7+aixJECev3F9rleogXmI6U5S3fk5ffgqC5f4USFur5HKjoAQ5Qxg8PDiHQBwMhr1ZxzQqZEa7JBS4fWeXCoxDE8jTrPiB0EELJYqyIjtJelLRJl7SMVC23ppdn6tITjypTw+jO+5wYpeLvDFN43032Uk/Z9eTjh2LdaJZ7NuGBHnibAyfF2tXa79HGLs7I4mKBFFZ/uOz32YYXp+xW9wNfGxExbyqsq673ZJIT7vpsvn6wMp5u7D7+mhhCFHvIa9BszE2lhysEqTtLT+Eg+HpIjC9fPm8Tj5XOIZB+8FwCf6CmNA5Ubrn52v1SdGpeye6DUsQsZJZwbR3qMqNYEoBWTdpsx1wGBmy2pG3IxgrehHFA9A4Qh4MX/LwdnwWEmUSsuejtDtAHC4Ne+zNq1JaigtIMg+ELjtRLSEVJX1Z1SKZfMsr3dIdwZjRxTbIZyLdPt5b15ObUywWezAyIVDa99Qx8/pXu1ef4gzCHvTKQP2JXIph1XPJ7Ry0v+ww==
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2020 09:56:47.3572
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3711d50c-3028-453c-49e5-08d7cf10805a
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[13.81.10.179];Helo=[westeu13-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3746
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 22-03-2020 18:37, Jonathan Cameron wrote:
> On Mon, 16 Mar 2020 07:52:18 +0100
> Mike Looijmans <mike.looijmans@topic.nl> wrote:
> 
>> This adds the device-tree bindings for the Bosch Sensortec BMI088 IMU,
>> the accelerometer part.
>>
>> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
>> ---
>>   .../devicetree/bindings/iio/accel/bmi088.txt  | 23 +++++++++++++++++++
> 
> Sorry.  All new DT bindings need to be in yaml format.
> 
> Please put this in the same series as the driver.

sooy, I noticed this too late, patches are underway in separate mails 
now. Hope that isn't a blocking issue?

> 
> Thanks,
> 
> Jonathan
> 
>>   1 file changed, 23 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/iio/accel/bmi088.txt
>>
>> diff --git a/Documentation/devicetree/bindings/iio/accel/bmi088.txt b/Documentation/devicetree/bindings/iio/accel/bmi088.txt
>> new file mode 100644
>> index 000000000000..691a47726dbc
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/accel/bmi088.txt
>> @@ -0,0 +1,23 @@
>> +* Bosch BMI088 IMU combining accelerometer and gyroscope
>> +
>> +https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bmi088-ds001.pdf
>> +
>> +Required properties:
>> +
>> +  - compatible : should be "bosch,bmi088_accel"
>> +  - reg : the I2C address of the sensor or the SPI chip select number
>> +
>> +Optional properties:
>> +
>> +  - interrupts : interrupt mapping for GPIO IRQ, it should be configured with
>> +		 IRQ_TYPE_EDGE_RISING
>> +
>> +Example:
>> +
>> +bmi088_accel@1 {
>> +	compatible = "bosch,bmi088_accel";
>> +	reg = <1>;
>> +	spi-max-frequency = <10000000>;
>> +	interrupt-parent = <&gpio>;
>> +	interrupts = <90 IRQ_TYPE_EDGE_RISING>;
>> +};
> 


-- 
Mike Looijmans
