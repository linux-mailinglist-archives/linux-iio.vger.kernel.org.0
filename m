Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB3532CFEC
	for <lists+linux-iio@lfdr.de>; Thu,  4 Mar 2021 10:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237812AbhCDJn1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 4 Mar 2021 04:43:27 -0500
Received: from mx0b-00328301.pphosted.com ([148.163.141.47]:24048 "EHLO
        mx0b-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237807AbhCDJnI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 4 Mar 2021 04:43:08 -0500
X-Greylist: delayed 1734 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Mar 2021 04:43:08 EST
Received: from pps.filterd (m0156136.ppops.net [127.0.0.1])
        by mx0b-00328301.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12493AYZ018629;
        Thu, 4 Mar 2021 01:12:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt1;
 bh=zsskD8QqAHzOk9AhZukzaeLe954vG/HNeBtBm36YL9Q=;
 b=fiDm7hdi326R/LXwEu53iSgVOT9cnDc5hxPl+XWetM/rn/LVEREocz+jWOJKXP1PdxnH
 rpqFXu836hIAY98a3StGvJiEFTCvmBUlt2IY7iexCHdn4xBbez5oYGesLKdgRuJ0Or+d
 SUkA7MeRWvyBPsjlFdOdFZ7BdcTm7cUxsaEz6ZN7gqJyiX/asfZdAftngrRKyTaoRe91
 pnMLr9rPvFBmqauwufQApTx6qu6wtFHMtv3wWz36PHbSi+zunxEqnVwAdssI9I2N5pH8
 ZbD9+B9NCeVYcYMTqNVo7ReM4hgxqsaQNvLaLn4NhMAdiBPeFO619euWXD2g/t7qC1l0 yg== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by mx0b-00328301.pphosted.com with ESMTP id 3721d4rx4h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Mar 2021 01:12:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bIt9Z28y68lmTc05ReJBrHYZpD+WVsF1piTc7XiivZMz3NXQhjUFiddBFNwKORr4/iRq1PUnR9DJQcUco7OCQB3hnQfjub/FVFlEYM6U9v6I81yVy0qkfmojkEEoKhU/h7dDZX2NcIRubwZXtsZgqP/11d4rjtUhWjLGjTcsyJafp/ig43xOEYboVw8NBejjJl37JeUCji3aWUMlZfCEY5juzis8t6WhgplhaLr0IudcGxsgaDdPXKtRaK3GeGZ6fogJAFQ06FOtEYtYO0nXpDQ8HxfM/KibHN9BzdG6BuS972A95COWjtZBSxJN78uMjqv0n0e+ejZshs0M5y2aXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zsskD8QqAHzOk9AhZukzaeLe954vG/HNeBtBm36YL9Q=;
 b=c3yZiWuUdMose6YNKp43mYFyM2nVHcJ/J6Q2zVy97TIk6ngy5nuuLtxGi5/Imy8egGvdd2L7W3c8EHYy/zHd9bu1A+Rb1Hp3tgHMGt3dTP6VBVcgqZhSLTdVv5wcGrt32VtaTle0TPnO//dBSYY5P24N1pg31CNSAXj3fOWJZpE6MAWE7aV6unUOZxuwAKPqPLIdR2F39RfxBBwNkz1/x02+82hIe+Npkjx9pKw5qJj0R6HGHbM6wcWgTuc9kv1DCqA5llfhpnH2NKRAEvs+FPPZsLa5xBKXUBeNyxkuEa9PVSe+k3xIkNeHlavyHrMEwhB26GX2yjSma3SXnCfYdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zsskD8QqAHzOk9AhZukzaeLe954vG/HNeBtBm36YL9Q=;
 b=WWylNTC5VeMdoJlo8BgDdwAmcCYtE9rtkkcPfrf6DqxXvzHLES5VQTyFg3MvCP7k/BVke303H/djm0KEqBnHsq0sNP7sLai1A5P3jogA/l6LY1QxzMXeAZFVxTjtvAq4VKKj+PElUeixqzP5MMMhxDb5VCV18FeVVXyuvSQYpVc=
Received: from BL0PR12MB5011.namprd12.prod.outlook.com (2603:10b6:208:1c9::17)
 by MN2PR12MB4063.namprd12.prod.outlook.com (2603:10b6:208:1dc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Thu, 4 Mar
 2021 09:12:47 +0000
Received: from BL0PR12MB5011.namprd12.prod.outlook.com
 ([fe80::c15a:6633:c47d:eea9]) by BL0PR12MB5011.namprd12.prod.outlook.com
 ([fe80::c15a:6633:c47d:eea9%8]) with mapi id 15.20.3890.028; Thu, 4 Mar 2021
 09:12:47 +0000
From:   Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To:     Philippe De Muyter <phdm@macq.eu>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: invensense mpu9250 ak8963 and devicetree
Thread-Topic: invensense mpu9250 ak8963 and devicetree
Thread-Index: AQHXEI3j2JzeTFPnA0iWWrSRCS5fRKpzig3C
Date:   Thu, 4 Mar 2021 09:12:47 +0000
Message-ID: <BL0PR12MB50118E81AC1B92F530C4A7B0C4979@BL0PR12MB5011.namprd12.prod.outlook.com>
References: <20210303153145.GA30260@frolo.macqel>
In-Reply-To: <20210303153145.GA30260@frolo.macqel>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: macq.eu; dkim=none (message not signed)
 header.d=none;macq.eu; dmarc=none action=none header.from=invensense.com;
x-originating-ip: [91.174.78.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 01c31c54-04f8-4798-569e-08d8deedadc2
x-ms-traffictypediagnostic: MN2PR12MB4063:
x-microsoft-antispam-prvs: <MN2PR12MB4063EED2A470C8223C867523C4979@MN2PR12MB4063.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mfgn6TwVF51CuPjr3cH7s6U/sEw2vIBEv+QXWy6PibD7wkIur1SAIgRc4SS7ZEHqORF4TUqQ3HwCkvvHNEPnI9gd0jRMLIDkrx4MlGbxdQJ8S24iBbd5D+BzFjtM8ravpznZRiarNPL3oLRuN1tx/+evt2OTjBriuXC0hNwrFm1Yj14Oj0WawBKKrTydlRv4cXRMuPFNVLBiJTOs/A+5ONBcz2qpSgSO9tMm8tbbuK+16+4vDjH20LBRzkh/gnkE4HkqEquxpK43XgdOSkL6Q4HZrieEMhnOz4JjwiYirpx92GBqPlXsVsf39zDU+HsyybramjJ/7F0XObwcB2ib2XOJcIEXNL43oRXeguXxGmIq4+x6Wkb258txXoh5RajMBbO3IJU4Wp4pcx2G4m0eiTytZRtrJIcWYWbxhwGmId/HFZuRIa/TBRvj0z8B6rD5n+uQ82Pm3DernWyZHNaJSxY4Lvyy6RpsEgHhCTUzNtDe0QvVclUNRXGj5OT8FXAiwmFNeT3AOAMdVZtS7+Mh0w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5011.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(396003)(346002)(39850400004)(136003)(7696005)(316002)(6506007)(26005)(53546011)(55016002)(86362001)(91956017)(83380400001)(76116006)(478600001)(186003)(52536014)(2906002)(5660300002)(71200400001)(8676002)(9686003)(64756008)(66476007)(8936002)(66556008)(66946007)(33656002)(66446008)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?GT8o0NH0cf4lRcOvgmTW9EP1IQrmIKgV/k+a5QtFpDL573jOlbymloNdlg?=
 =?iso-8859-1?Q?tXy4KICQYRGDfn4/x9kY+Wpl7KTiG0aiOisz+1fYk1lzYLJw+NNQm708+6?=
 =?iso-8859-1?Q?TzAaDhWujaalhM1M3Xnh9G/Ns+OA9UMjc15uKbUsVUjI8xM7x6P1r1z36e?=
 =?iso-8859-1?Q?DdqPMxLjuhxRpKJ2ChsvGTGyjVTh+hX1PcgpWSzZVY5vQdveOn9XQ4Xj6n?=
 =?iso-8859-1?Q?B2mlMgYdQg37KI2tIVzQ09LQwcW2QzRp4I4flAbJYZzbFv04Fy2hn/JhwI?=
 =?iso-8859-1?Q?2MbuOGvCMN2ikPTqXyfKqOxY60K1VqgITBdCJxXXfhcdO1v0BkpGxrXwYf?=
 =?iso-8859-1?Q?yd/7FeNlJzFUT0UWPX1tx1U/SeFjwjPOqphSek4OWVO5CXaCa5HId3zPXU?=
 =?iso-8859-1?Q?mD6rHyzyhq2DcrMzCP4hn2PvVUd2V8HQUgXoIxkvwyj9DP00y39mChQ7Dg?=
 =?iso-8859-1?Q?n8s8krlLDJ8jmRB3BA5v/beJQDW6JDEbE/CcJvIeGz/r5YnZMqLhISCeLs?=
 =?iso-8859-1?Q?KvZn3kBE+DVL69V+9TpJUBGj50HHD4+5CwcEd/yf+L54s+Tfv1xinMMZb6?=
 =?iso-8859-1?Q?9ikc5PiDs3KU3oa5TlhRL2AMEx7JVItx3meGYVm+4xGSIEWsvUV5B2jpI+?=
 =?iso-8859-1?Q?ywfN4eICXGdrs3jpf/Mgwux8jvadd5lFWx6f0eu/xaS8bm9cZZm2MxO5jt?=
 =?iso-8859-1?Q?QhqamvrdYcA3gYx9DJl/j8OTw9piJJIClDUMe3rNHnc94H2fU6ERVQSMfb?=
 =?iso-8859-1?Q?qd8RaNJeKkaW7k0uRn+Uxpg1fii85ZIk2JVmBw27L69LeLXVi5+cUMN/aZ?=
 =?iso-8859-1?Q?KCP2MG52RsXoPu4Lkh7aLSQFvVN5zEa8fP8oegzoqvVrOO3I44lFtIxdeK?=
 =?iso-8859-1?Q?b4Rf10xy/CftOq/tXKaUvIcNPl+HuDumB+xU+wiMh0CzE0fe1y90IYixcm?=
 =?iso-8859-1?Q?gnDtexrUekt/TiS+sgnoV4sYv44IhT+S13KbiEu1UI0ru03J9dZmW8Z4uy?=
 =?iso-8859-1?Q?fAw3bEoDptxlZjv90/DwsYIYk2obvXPYe8GrY4kTBUO9VklEOR6A6O+od4?=
 =?iso-8859-1?Q?R657ZQtmwVgCyb+3f/aZkAZanbozIMnjCdd2Y3TeA3jahKHhOf0yyUw0rW?=
 =?iso-8859-1?Q?F/fuZ0WXMnxkGv/y6pIcl7SMzkgR7mw3AuVxFxiZRu6VmetnXTeXiO+hAm?=
 =?iso-8859-1?Q?pPaYouE+RCD+SdGMkZx5N+D+GuMdJbJbq64Wm6caKchlFXXL6IurVHITsO?=
 =?iso-8859-1?Q?vuuSszvlTNOdSbAl5BiopR3vbesCDriHh3zJObQBQuIM7yZEFQHHuNrmgy?=
 =?iso-8859-1?Q?1UsH0QEiCdi0kW+eg1Ml40ue9eqtrFyVwYHxgnKQCiMtUTg=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5011.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01c31c54-04f8-4798-569e-08d8deedadc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2021 09:12:47.6008
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9Z7TTRxICHRRnzWj9BuR1pW2BduYcqeEisEU7ICv5BDpOPG5/KtAmFAJioh2b2W3CrhFvx7cdKhf1gTq9iv9KoehuFRV23olZVt6ngHsHkI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4063
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-04_03:2021-03-03,2021-03-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 mlxscore=0 malwarescore=0 spamscore=0
 phishscore=0 suspectscore=0 adultscore=0 clxscore=1011 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103040040
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello Philippe,=0A=
=0A=
I would recommend letting mpu9250 chip drives the magnetometer instead of u=
sing the ak8963 driver.=0A=
=0A=
This is simpler to use and guarantees a good synchronization between all se=
nsors and no possible latency coming from kernel scheduling when polling th=
e magnetometer. And it enables the use of spi bus for connecting the device=
.=0A=
=0A=
You just need to define mpu9250 dts without an i2c-gate, and delete all def=
inition of ak8963 chip.=0A=
=0A=
Best regards,=0A=
JB=0A=
=0A=
=0A=
From: Philippe De Muyter <phdm@macq.eu>=0A=
Sent: Wednesday, March 3, 2021 16:31=0A=
To: linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>=0A=
Subject: invensense mpu9250 ak8963 and devicetree =0A=
=A0=0A=
=A0CAUTION: This email originated from outside of the organization. Please =
make sure the sender is who they say they are and do not click links or ope=
n attachments unless you recognize the sender and know the content is safe.=
=0A=
=0A=
Hello,=0A=
=0A=
I am trying to use a mpu9250 imu, but I have trouble with the ak8963 part.=
=0A=
=0A=
Currently, ak8975_probe fails in this code :=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0 /* Fetch the regulators */=0A=
=A0=A0=A0=A0=A0=A0=A0 data->vdd =3D devm_regulator_get(&client->dev, "vdd")=
;=0A=
=A0=A0=A0=A0=A0=A0=A0 if (IS_ERR(data->vdd))=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return PTR_ERR(data->vdd);=0A=
=A0=A0=A0=A0=A0=A0=A0 data->vid =3D devm_regulator_get(&client->dev, "vid")=
;=0A=
=A0=A0=A0=A0=A0=A0=A0 if (IS_ERR(data->vid))=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return PTR_ERR(data->vid);=0A=
=0A=
but Documentation/devicetree/bindings/iio/magnetometer/asahi-kasei,ak8975.y=
aml=0A=
says :=0A=
=0A=
=A0 vdd-supply:=0A=
=A0=A0=A0 description: |=0A=
=A0=A0=A0=A0=A0 an optional regulator that needs to be on to provide VDD po=
wer to=0A=
=A0=A0=A0=A0=A0 the sensor.=0A=
=0A=
I have no vdd or vdd-supply property in my ak8963 description.=0A=
=0A=
Is that unrelated ?=0A=
=0A=
What should I write in my dts file for this ak8963 embedded in a mpu9250 ?=
=0A=
=0A=
Thanks in advance=0A=
=0A=
Philippe=0A=
=0A=
-- =0A=
Philippe De Muyter +32 2 6101532 Macq SA rue de l'Aeronef 2 B-1140 Bruxelle=
s=
