Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28E5C1886A8
	for <lists+linux-iio@lfdr.de>; Tue, 17 Mar 2020 14:59:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgCQN7N (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Mar 2020 09:59:13 -0400
Received: from mail-eopbgr00085.outbound.protection.outlook.com ([40.107.0.85]:14564
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726148AbgCQN7N (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 17 Mar 2020 09:59:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=topicbv.onmicrosoft.com; s=selector2-topicbv-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cy6xWJkWY1c3AdTpwpZZkq2Wckv4+FQ9NN4EtX8M3BQ=;
 b=caPW/yEOmpu9LPmnfyHsyLMgg/ApbOdJ0nuAOw5/OiC50ocuMgKJmjc+dgqaY432fZzLDr+ueEUfoBOmt1Rs6HIhDdrT3JqxQCx+J8gFLKTKgXqphr1C1693JLlAK6gbZ1dvW6brurJCQdReLcnnDOMBVZ2w5bItLCmsRPgqPdM=
Received: from AM6P192CA0034.EURP192.PROD.OUTLOOK.COM (2603:10a6:209:83::47)
 by DB8PR04MB7163.eurprd04.prod.outlook.com (2603:10a6:10:fe::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.14; Tue, 17 Mar
 2020 13:59:05 +0000
Received: from HE1EUR01FT053.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:209:83:cafe::62) by AM6P192CA0034.outlook.office365.com
 (2603:10a6:209:83::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.15 via Frontend
 Transport; Tue, 17 Mar 2020 13:59:05 +0000
Authentication-Results: spf=pass (sender IP is 13.81.10.179)
 smtp.mailfrom=topicproducts.com; pmeerw.net; dkim=fail (signature did not
 verify) header.d=topicbv.onmicrosoft.com;pmeerw.net; dmarc=none action=none
 header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topicproducts.com
 designates 13.81.10.179 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.81.10.179; helo=westeu13-emailsignatures-cloud.codetwo.com;
Received: from westeu13-emailsignatures-cloud.codetwo.com (13.81.10.179) by
 HE1EUR01FT053.mail.protection.outlook.com (10.152.1.73) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.14 via Frontend Transport; Tue, 17 Mar 2020 13:59:04 +0000
Received: from EUR03-DB5-obe.outbound.protection.outlook.com (104.47.10.57) by westeu13-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Tue, 17 Mar 2020 13:59:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Am9ygm9kQOrM4OnB5taLQ3hqkv97G0Axy0BRdOxnlR2XeGiG/Itd4QCC4Owh8tX5FSHyjIzfEO2ctceRPzCiV0YU25RPNar5hsgXvI2M6DFWbAHO9MzuwpqptC8A5GZbqUslhG03R9zTBH3H+S819HdNJuDVhRngmP9lySMy1l7qA7OFAqYyl3pHfYEfsQ5e3jNyUyUzN4ER5rXreQt3zePrj4t0LUmuoBVfSkY6ibAItWOKW3RFT6FRyZgJMlRxkqUYGymFphNUSIy7/AjQhYaHPOj2kxhCTF/KZDJwpD+yVGRCiQhmpoUoZ/NYSBR7sPJB5w6m6OAh2I4U5GMu2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6QjVnVZQ+tj0PQnok4tQjm9lVdeBCO7MX7heiFMIHoc=;
 b=LQmVqBgPxCCtSzbYVuFcEVT8IhCBNH20fMFBcdwnWFZY5hKy9XFeQ5GYFS53vA0+NomXp7+sxzdpPqyugGCXQrGiSE2QnEQwvrZyfjOeUdg0SGflnqVVkqXhVPmjJk3vbnHyRuPN76km2b5nb32GaCaBXC9/yy0G9evYwMayYdFR/jlRnDeW51Ok0wEhNzhrZ5po1MyKpGRaqU7uJDP9ZSWzFUwoHqz/CF50ryvDa0RA91h1AktHrvchyQnaC4zeqiCyZqKx4PNM9JG6BW8AGOF/7jscC8DFhCFrHcxv/QHcTBKfBD41/dkYpB0sSvKtbhzGfifID7IDAsLbHfXB2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topicproducts.com; dmarc=pass action=none header.from=topic.nl;
 dkim=pass header.d=topic.nl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=topicbv.onmicrosoft.com; s=selector2-topicbv-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6QjVnVZQ+tj0PQnok4tQjm9lVdeBCO7MX7heiFMIHoc=;
 b=zGtLIqD3dKSQsFO/iIIooEt4sdgrf6BEe2oeEzJ9gRCfhfHwnK1mDAbQtS2dCZcryXWqscvcGz5MIxeH01S29hsa/FewMcBvCX0MY9oS7PQtX1lo7uHSANH4CTKdyT9bAg6dFCr/QIdy6iwpBH5k8pdB8d7tpxnjVKkLSxX4oqo=
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=mike.looijmans@topicproducts.com; 
Received: from DB3PR0402MB3947.eurprd04.prod.outlook.com (52.134.67.147) by
 DB3PR0402MB3641.eurprd04.prod.outlook.com (52.134.69.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.22; Tue, 17 Mar 2020 13:58:56 +0000
Received: from DB3PR0402MB3947.eurprd04.prod.outlook.com
 ([fe80::380e:f722:2d0d:9c71]) by DB3PR0402MB3947.eurprd04.prod.outlook.com
 ([fe80::380e:f722:2d0d:9c71%6]) with mapi id 15.20.2814.021; Tue, 17 Mar 2020
 13:58:56 +0000
Subject: Re: [PATCH v2] iio: accel: Add support for the Bosch-Sensortec BMI088
To:     Lars-Peter Clausen <lars@metafoo.de>, jic23@kernel.org,
        linux-iio@vger.kernel.org
CC:     knaack.h@gmx.de, pmeerw@pmeerw.net
References: <20200315120238.18c10af0@archlinux>
 <20200313140415.20266-1-mike.looijmans@topic.nl>
 <20200316073208.19715-1-mike.looijmans@topic.nl>
 <46bec9b8-28ee-6fd3-f615-2b8db43626aa@metafoo.de>
From:   Mike Looijmans <mike.looijmans@topic.nl>
Organization: Topic
Message-ID: <001012ba-28ec-c2c5-ee57-3c9fd459e881@topic.nl>
Date:   Tue, 17 Mar 2020 14:58:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <46bec9b8-28ee-6fd3-f615-2b8db43626aa@metafoo.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM0PR02CA0059.eurprd02.prod.outlook.com
 (2603:10a6:208:d2::36) To DB3PR0402MB3947.eurprd04.prod.outlook.com
 (2603:10a6:8:7::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.130] (83.128.90.119) by AM0PR02CA0059.eurprd02.prod.outlook.com (2603:10a6:208:d2::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.16 via Frontend Transport; Tue, 17 Mar 2020 13:58:56 +0000
X-Originating-IP: [83.128.90.119]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e894569-5b4b-486a-b73a-08d7ca7b5a77
X-MS-TrafficTypeDiagnostic: DB3PR0402MB3641:|DB8PR04MB7163:
X-Microsoft-Antispam-PRVS: <DB8PR04MB71638FF91C79B5A33779AA9E96F60@DB8PR04MB7163.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;OLM:10000;
X-Forefront-PRVS: 0345CFD558
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(39840400004)(366004)(136003)(199004)(16526019)(42882007)(2616005)(36916002)(52116002)(956004)(44832011)(186003)(36756003)(31686004)(26005)(16576012)(5660300002)(316002)(2906002)(6486002)(81166006)(8936002)(81156014)(8676002)(4326008)(66476007)(508600001)(30864003)(66946007)(53546011)(31696002)(66556008);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3641;H:DB3PR0402MB3947.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: topicproducts.com does not
 designate permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 9DI37nFXWz/wTXiVTRLpccJKkqzWkSyok9uvvToW4VlJpwaR2g2/0q4UUAocOdZ/y2iq7plIVIyTixz0EVajcl4SVcaKYREvVc4WDhb6y6i+eH0AUMjd87dI0e21ffBzcXnPFKxw4F0CK6uSVqABpsNFHQN2CDdMc9uh7IUA3OjphCC36RwyIp01RiTQZqcS08kmzs57746ZXAxozZi1IbkfSspjUyZEIeTrvSBS+Ltl80bE18UzwZOnCZtsjFj7r0KMGFVxqx2b9jKS499k3HOUkZjbDPrD6lPRd6IfM3o2RrlgCRKnKKO1CDzq/1vZNCz8BV4DgCyTQjJvfALJyqAQrfK7uC6KFUmRtrC2k/2KvgHM3KEiKvpnKzYadcx8v/Sq/14BUO08WIlamcRElcg1JQeJ6iasNb26pk0+oW25FVrYq9gNrk6DKmYIIIQz
X-MS-Exchange-AntiSpam-MessageData: 8jqpUEjSNtdG2P2JBrpZ2qavSh0yj0Uykn52rXmz/5hDNpMILyCJVJIuByl5fOur44uibej9N3W93LqS8bqhp7qPq5GnIoxnyE6LphUMpErizUQY1fbQtEvO08mvRFGeNoxScYdD8PFBT8eRV7DOUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3641
X-CodeTwo-MessageID: 15b38788-39b5-4ea2-8979-c79d6ef5e23e.20200317135900@westeu13-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: HE1EUR01FT053.eop-EUR01.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:13.81.10.179;IPV:;CTRY:NL;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(346002)(136003)(39840400004)(376002)(199004)(46966005)(2616005)(53546011)(956004)(8936002)(2906002)(316002)(5660300002)(82310400001)(16526019)(6486002)(336012)(508600001)(186003)(30864003)(7596002)(7636002)(31686004)(42882007)(36756003)(16576012)(8676002)(26005)(246002)(356004)(70586007)(47076004)(36916002)(4326008)(70206006)(44832011)(31696002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR04MB7163;H:westeu13-emailsignatures-cloud.codetwo.com;FPR:;SPF:Pass;LANG:en;PTR:westeu13-emailsignatures-cloud.codetwo.com;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: e46bfb3b-4cac-4e11-6f10-08d7ca7b55a1
X-Forefront-PRVS: 0345CFD558
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t6FFfZdekcKTMqfib4sLbWC7UkLPyocfKCfygRKYalfhZk6z9BYY658RblCxajeLrd98K9TjpTygYj55KMIoQ/1JjFBAz75C/Jdhprjhjdeq1tp4lmdITGfnBVRy9mD+kU9kvE4ukiZeDoYOqbON8olUMKH7tp06eWzyluSZJsPDR67xQM0t7mPn2XGndS9kxr6TeYUniBRZqnUAuGCm/dMvlPO1i70ji9eTBSqL5FKQZo5XsMmgqjchLRLDaCdOhZG1L9lXwVLdHrQIvFkpjOLc5Yi3gBTItmj21WBb59cothWdjHYOOvZYHSaZ5oAvPNFnyftPhIQLP1O2vp7Ve8WzsUMpcfv7KdkN84v56RXny3gLjJjNczKzkhtvK35OG/3STLtrtHqYP3vx1Xe/qAwku48hZLqa4tJByyrYFlPo7uwWQUBPPyTPuU/aHYHYT4Q0PgIBBJ8TGrUJyw+iSmKRiuj34WfG1p4r7cGrMEJEP+TGLjpF/ErS9pEJ8RwAjHOZekklVOk3c6gDpVwNVg==
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2020 13:59:04.2188
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e894569-5b4b-486a-b73a-08d7ca7b5a77
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[13.81.10.179];Helo=[westeu13-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7163
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Thanks for the review, expect a v3 once I've had the cance to test it.

On 16-03-2020 15:54, Lars-Peter Clausen wrote:
> On 3/16/20 8:32 AM, Mike Looijmans wrote:
>> The BMI088 is a combined module with both accelerometer and gyroscope.
>> This adds the accelerometer driver support for the SPI interface.
>> The gyroscope part is already supported by the BMG160 driver.
> Looks very good, a few comments inline.
>> [...]
>> +static int bmi088_accel_get_temp(struct bmi088_accel_data *data, int=20
>> *val)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct device *dev =3D regmap_get_device(data->regma=
p);
>> +=C2=A0=C2=A0=C2=A0 int ret;
>> +=C2=A0=C2=A0=C2=A0 u8 value[2];
>> +=C2=A0=C2=A0=C2=A0 unsigned int temp;
>> +
>> +=C2=A0=C2=A0=C2=A0 mutex_lock(&data->mutex);
>> +
>> +=C2=A0=C2=A0=C2=A0 /* Read temp reg MSB */
>> +=C2=A0=C2=A0=C2=A0 ret =3D regmap_bulk_read(data->regmap, BMI088_ACCEL_=
REG_TEMP,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &value, sizeof(value));
>> +=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_err(dev, "Error reading =
BMI088_ACCEL_REG_TEMP\n");
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_unlock(&data->mutex);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> +=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 temp =3D (unsigned int)value[0] << 3;
>> +=C2=A0=C2=A0=C2=A0 temp |=3D (value[1] >> 5);
>> +
>> +=C2=A0=C2=A0=C2=A0 if (temp > 1023)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *val =3D temp - 2028;
>=20
> I would be highly surprised if this is not supposed to be 2048.
>=20
> If it is you can simplify the expression to be able to work without the=20
> conditional by using
>=20
> *val =3D sign_extend32(temp, 11);
>=20
> I believe it is 11, better double check.

Yeah, the datasheet makes a big fuzz about it, but it's just a signed=20
11-bit integer. See also my reply to Jonathan Cameron.


>=20
>> +=C2=A0=C2=A0=C2=A0 else
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *val =3D temp;
>> +
>> +=C2=A0=C2=A0=C2=A0 mutex_unlock(&data->mutex);
>> +
>> +=C2=A0=C2=A0=C2=A0 return IIO_VAL_INT;
>> +}
>> [...]
>> +static int bmi088_accel_read_raw(struct iio_dev *indio_dev,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_chan_spec const *chan,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 int *val, int *val2, long mask)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct bmi088_accel_data *data =3D iio_priv(indio_de=
v);
>> +=C2=A0=C2=A0=C2=A0 int ret;
>> +=C2=A0=C2=A0=C2=A0 unsigned int range;
>> +
>> +=C2=A0=C2=A0=C2=A0 switch (mask) {
>> +=C2=A0=C2=A0=C2=A0 case IIO_CHAN_INFO_RAW:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 switch (chan->type) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case IIO_TEMP:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retu=
rn bmi088_accel_get_temp(data, val);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case IIO_ACCEL:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (=
iio_buffer_enabled(indio_dev))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return -EBUSY;
>=20
> I think there is a race condition here. If the buffer is enabled after=20
> the check undefined behavior might occur. Jonathan already mentioned it=20
> in his review. Best is to use iio_device_{claim,release}_direct_mode().

Fixed in v3.


>=20
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =
=3D regmap_read(data->regmap,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 BMI088_ACCEL_REG_ACC_RANGE, &range);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (=
ret < 0)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return ret;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =
=3D bmi088_accel_get_axis(data, chan, val);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (=
ret < 0)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return ret;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *val=
 =3D (*val * 3 * 980 * (0x01 << range)) >> 15;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retu=
rn IIO_VAL_INT;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retu=
rn -EINVAL;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> [...]
>> +}
>> +
>> +static int bmi088_accel_write_raw(struct iio_dev *indio_dev,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_chan_spec const *chan,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int val, int val2, long mask)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct bmi088_accel_data *data =3D iio_priv(indio_de=
v);
>> +=C2=A0=C2=A0=C2=A0 int ret;
>> +
>> +=C2=A0=C2=A0=C2=A0 switch (mask) {
>> +=C2=A0=C2=A0=C2=A0 case IIO_CHAN_INFO_SAMP_FREQ:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_lock(&data->mutex);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D bmi088_accel_set_bw(=
data, val, val2);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_unlock(&data->mutex);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> +=C2=A0=C2=A0=C2=A0 default:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D -EINVAL;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 return ret;
>> +}
>> +
>> +static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("12.5 25 50 100 200 400 800=20
>> 1600");
>> +
>> +static struct attribute *bmi088_accel_attributes[] =3D {
>> +=C2=A0=C2=A0=C2=A0 &iio_const_attr_sampling_frequency_available.dev_att=
r.attr,
>> +=C2=A0=C2=A0=C2=A0 NULL,
>> +};
>> +
>> +static const struct attribute_group bmi088_accel_attrs_group =3D {
>> +=C2=A0=C2=A0=C2=A0 .attrs =3D bmi088_accel_attributes,
>> +};
>> +
>> +#define BMI088_ACCEL_CHANNEL(_axis, bits) {=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>> +=C2=A0=C2=A0=C2=A0 .type =3D IIO_ACCEL,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>> +=C2=A0=C2=A0=C2=A0 .modified =3D 1,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>> +=C2=A0=C2=A0=C2=A0 .channel2 =3D IIO_MOD_##_axis,=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 \
>> +=C2=A0=C2=A0=C2=A0 .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>> +=C2=A0=C2=A0=C2=A0 .info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCAL=
E) |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 BIT(IIO_CHAN_INFO_SAMP_FREQ),=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 \
>> +=C2=A0=C2=A0=C2=A0 .scan_index =3D AXIS_##_axis,=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 \
>> +=C2=A0=C2=A0=C2=A0 .scan_type =3D {=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .sign =3D 's',=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .realbits =3D (bits),=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .storagebits =3D 16,=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .shift =3D 16 - (bits),=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .endianness =3D IIO_LE,=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>> +=C2=A0=C2=A0=C2=A0 },=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>> +}
>> +
>> +#define BMI088_ACCEL_CHANNELS(bits) {=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 \
>> +=C2=A0=C2=A0=C2=A0 {=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .type =3D IIO_TEMP,=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .info_mask_separate =3D BIT(=
IIO_CHAN_INFO_RAW) |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(IIO_CHAN_INFO=
_SCALE) |=C2=A0=C2=A0=C2=A0 \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(IIO_CHAN_INFO=
_OFFSET),=C2=A0=C2=A0=C2=A0 \
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .scan_index =3D -1,=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>> +=C2=A0=C2=A0=C2=A0 },=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>> +=C2=A0=C2=A0=C2=A0 BMI088_ACCEL_CHANNEL(X, bits),=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 \
>> +=C2=A0=C2=A0=C2=A0 BMI088_ACCEL_CHANNEL(Y, bits),=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 \
>> +=C2=A0=C2=A0=C2=A0 BMI088_ACCEL_CHANNEL(Z, bits),=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 \
>> +=C2=A0=C2=A0=C2=A0 IIO_CHAN_SOFT_TIMESTAMP(3),=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 \
>> +}
>> +
>> +static const struct iio_chan_spec bmi088_accel_channels[] =3D
>> +=C2=A0=C2=A0=C2=A0 BMI088_ACCEL_CHANNELS(16);
>> +
>> +static const struct bmi088_accel_chip_info=20
>> bmi088_accel_chip_info_tbl[] =3D {
>> +=C2=A0=C2=A0=C2=A0 [0] =3D {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .name =3D "BMI088A",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .chip_id =3D 0x1E,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .channels =3D bmi088_accel_c=
hannels,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .num_channels =3D ARRAY_SIZE=
(bmi088_accel_channels),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .scale_table =3D { {9610, BM=
I088_ACCEL_RANGE_3G},
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 {19122, BMI088_ACCEL_RANGE_6G},
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 {38344, BMI088_ACCEL_RANGE_12G},
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 {76590, BMI088_ACCEL_RANGE_24G} },
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
>> +};
>> +
>> +static const struct iio_info bmi088_accel_info =3D {
>> +=C2=A0=C2=A0=C2=A0 .attrs=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D=
 &bmi088_accel_attrs_group,
>> +=C2=A0=C2=A0=C2=A0 .read_raw=C2=A0=C2=A0=C2=A0 =3D bmi088_accel_read_ra=
w,
>> +=C2=A0=C2=A0=C2=A0 .write_raw=C2=A0=C2=A0=C2=A0 =3D bmi088_accel_write_=
raw,
>> +};
>> +
>> +static const unsigned long bmi088_accel_scan_masks[] =3D {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 BIT(AXIS_X) | BIT(AXIS_Y) | BIT(AXIS_Z),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 0};
>> +
>> +
>> +
>> +#ifdef CONFIG_PM
>> +static int bmi088_accel_set_power_state(struct bmi088_accel_data *data,
>> +=C2=A0=C2=A0=C2=A0 bool on)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct device *dev =3D regmap_get_device(data->regma=
p);
>> +=C2=A0=C2=A0=C2=A0 int ret;
>> +
>> +=C2=A0=C2=A0=C2=A0 if (on) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D pm_runtime_get_sync(=
dev);
>> +=C2=A0=C2=A0=C2=A0 } else {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pm_runtime_mark_last_busy(de=
v);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D pm_runtime_put_autos=
uspend(dev);
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_err(dev, "Failed: %s(%d)=
\n", __func__, on);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (on)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pm_r=
untime_put_noidle(dev);
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 return 0;
>> +}
>> +#else
>> +static int bmi088_accel_set_power_state(struct bmi088_accel_data *data,
>> +=C2=A0=C2=A0=C2=A0 bool on)
>> +{
>> +=C2=A0=C2=A0=C2=A0 return 0;
>> +}
>> +#endif
>> +
>> +static int bmi088_accel_chip_init(struct bmi088_accel_data *data)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct device *dev =3D regmap_get_device(data->regma=
p);
>> +=C2=A0=C2=A0=C2=A0 int ret, i;
>> +=C2=A0=C2=A0=C2=A0 unsigned int val;
>> +
>> +=C2=A0=C2=A0=C2=A0 /* Do a dummy read (of chip ID), to enable SPI inter=
face */
>> +=C2=A0=C2=A0=C2=A0 regmap_read(data->regmap, BMI088_ACCEL_REG_CHIP_ID, =
&val);
>> +
>> +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Reset chip to get it in a known good state. =
A delay of 1ms after
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * reset is required according to the data shee=
t
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 regmap_write(data->regmap, BMI088_ACCEL_REG_RESET,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 BMI088_ACCEL_RESET_VAL);
>> +=C2=A0=C2=A0=C2=A0 usleep_range(1000, 2000);
>> +
>> +=C2=A0=C2=A0=C2=A0 /* Do a dummy read (of chip ID), to enable SPI inter=
face after=20
>> reset */
>> +=C2=A0=C2=A0=C2=A0 regmap_read(data->regmap, BMI088_ACCEL_REG_CHIP_ID, =
&val);
>> +
>> +=C2=A0=C2=A0=C2=A0 /* Read chip ID */
>> +=C2=A0=C2=A0=C2=A0 ret =3D regmap_read(data->regmap, BMI088_ACCEL_REG_C=
HIP_ID, &val);
>> +=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_err(dev, "Error: Reading=
 chip id\n");
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 /* Validate chip ID */
>> +=C2=A0=C2=A0=C2=A0 dev_dbg(dev, "Chip Id %x\n", val);
>> +=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < ARRAY_SIZE(bmi088_accel_chip_info_=
tbl); i++) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (bmi088_accel_chip_info_t=
bl[i].chip_id =3D=3D val) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data=
->chip_info =3D &bmi088_accel_chip_info_tbl[i];
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 brea=
k;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 if (!data->chip_info) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_err(dev, "Invalid chip %=
x\n", val);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENODEV;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 /* Set Active mode (and wait for 5ms) */
>> +=C2=A0=C2=A0=C2=A0 ret =3D bmi088_accel_set_mode(data, BMI088_ACCEL_MOD=
E_ACTIVE);
>> +=C2=A0=C2=A0=C2=A0 if (ret < 0)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> +
>> +=C2=A0=C2=A0=C2=A0 usleep_range(5000, 10000);
>> +
>> +=C2=A0=C2=A0=C2=A0 /* Enable accelerometer */
>> +=C2=A0=C2=A0=C2=A0 ret =3D bmi088_accel_enable(data, true);
>> +=C2=A0=C2=A0=C2=A0 if (ret < 0)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> +
>> +=C2=A0=C2=A0=C2=A0 /* Set Bandwidth */
>> +=C2=A0=C2=A0=C2=A0 ret =3D bmi088_accel_set_bw(data, BMI088_ACCEL_MODE_=
ODR_100,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BMI088_ACCEL_MODE_OSR_NORMAL=
);
>> +=C2=A0=C2=A0=C2=A0 if (ret < 0)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> +
>> +=C2=A0=C2=A0=C2=A0 /* Set Default Range */
>> +=C2=A0=C2=A0=C2=A0 ret =3D regmap_write(data->regmap, BMI088_ACCEL_REG_=
ACC_RANGE,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 BMI088_ACCEL_RANGE_6G);
>> +=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_err(dev, "Error writing =
ACC_RANGE\n");
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 return 0;
>> +}
>> +
>> +int bmi088_accel_core_probe(struct device *dev, struct regmap *regmap,
>> +=C2=A0=C2=A0=C2=A0 int irq, const char *name, bool block_supported)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct bmi088_accel_data *data;
>> +=C2=A0=C2=A0=C2=A0 struct iio_dev *indio_dev;
>> +=C2=A0=C2=A0=C2=A0 int ret;
>> +
>> +=C2=A0=C2=A0=C2=A0 indio_dev =3D devm_iio_device_alloc(dev, sizeof(*dat=
a));
>> +=C2=A0=C2=A0=C2=A0 if (!indio_dev)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -ENOMEM;
>> +
>> +=C2=A0=C2=A0=C2=A0 data =3D iio_priv(indio_dev);
>> +=C2=A0=C2=A0=C2=A0 dev_set_drvdata(dev, indio_dev);
>> +
>> +=C2=A0=C2=A0=C2=A0 data->regmap =3D regmap;
>> +
>> +=C2=A0=C2=A0=C2=A0 ret =3D bmi088_accel_chip_init(data);
>> +=C2=A0=C2=A0=C2=A0 if (ret < 0)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> +
>> +=C2=A0=C2=A0=C2=A0 mutex_init(&data->mutex);
>> +
>> +=C2=A0=C2=A0=C2=A0 indio_dev->dev.parent =3D dev;
>> +=C2=A0=C2=A0=C2=A0 indio_dev->channels =3D data->chip_info->channels;
>> +=C2=A0=C2=A0=C2=A0 indio_dev->num_channels =3D data->chip_info->num_cha=
nnels;
>> +=C2=A0=C2=A0=C2=A0 indio_dev->name =3D name ? name : data->chip_info->n=
ame;
> Considering that chip_info is chosen by the product ID register,=20
> regardless of what the compatible string was, maybe it is best to always=
=20
> use chip_info->name here.

Copied from other driver actually. I'd be glad to replace it and get rid=20
of the name parameter. I have no clue what purpose this serves.

>> +=C2=A0=C2=A0=C2=A0 indio_dev->available_scan_masks =3D bmi088_accel_sca=
n_masks;
>> +=C2=A0=C2=A0=C2=A0 indio_dev->modes =3D INDIO_DIRECT_MODE;
>> +=C2=A0=C2=A0=C2=A0 indio_dev->info =3D &bmi088_accel_info;
>>
>> diff --git a/drivers/iio/accel/bmi088-accel-spi.c=20
>> b/drivers/iio/accel/bmi088-accel-spi.c
>> new file mode 100644
>> index 000000000000..920e146f07d3
>> --- /dev/null
>> +++ b/drivers/iio/accel/bmi088-accel-spi.c
>> @@ -0,0 +1,100 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * 3-axis accelerometer driver supporting following Bosch-Sensortec=20
>> chips:
>> + *=C2=A0 - BMI088
>> + *
>> + * Copyright (c) 2018, Topic Embedded Products
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/slab.h>
>> +#include <linux/acpi.h>
>> +#include <linux/iio/iio.h>
>> +#include <linux/iio/sysfs.h>
>> +#include <linux/spi/spi.h>
>> +#include <linux/regmap.h>
>> +
>> +#include "bmi088-accel.h"
>> +
>> +int bmi088_regmap_spi_write(void *context, const void *data, size_t=20
>> count)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct spi_device *spi =3D context;
>> +=C2=A0=C2=A0=C2=A0 u8 buf[count];
>> +
>> +=C2=A0=C2=A0=C2=A0 memcpy(buf, data, count);
>> +
>> +=C2=A0=C2=A0=C2=A0 dev_dbg(&spi->dev, "Write val: %x to reg: %x\n", buf=
[1], buf[0]);
>> +
>> +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * The SPI register address (=3D full register =
address without bit 7)
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * and the write command (bit7 =3D RW =3D '0')
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 buf[0] &=3D ~0x80;
>> +
>> +=C2=A0=C2=A0=C2=A0 return spi_write(spi, buf, count);
>> +}
>> +
>> +int bmi088_regmap_spi_read(void *context, const void *reg,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 size_t reg_size, void *val, size_t val_size)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct spi_device *spi =3D context;
>> +=C2=A0=C2=A0=C2=A0 u8 addr[reg_size + 1];
> I believe there is an effort to eliminate variable length arrays that=20
> are placed on the stack from the kernel. reg_size should have a very=20
> small upper limit you should be able to get away with a statically sized=
=20
> array.
>> +
>> +=C2=A0=C2=A0=C2=A0 addr[0] =3D *(u8 *)reg;
>> +
>> +=C2=A0=C2=A0=C2=A0 dev_dbg(&spi->dev, "Read reg: %x\n", addr[0]);
>> +
>> +=C2=A0=C2=A0=C2=A0 addr[0] |=3D 0x80; /* bit7 =3D RW =3D '1' */
>> +
>> +=C2=A0=C2=A0=C2=A0 /* Do a write of 2 to mimic the dummy byte (see data=
sheet) */
>> +=C2=A0=C2=A0=C2=A0 return spi_write_then_read(spi, addr, sizeof(addr), =
val, val_size);
>> +}
> [...]
>=20
>=20


--=20
Mike Looijmans
