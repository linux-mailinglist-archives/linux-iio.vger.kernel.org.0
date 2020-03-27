Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5E961958A3
	for <lists+linux-iio@lfdr.de>; Fri, 27 Mar 2020 15:09:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgC0OIw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 27 Mar 2020 10:08:52 -0400
Received: from mx0b-00328301.pphosted.com ([148.163.141.47]:4960 "EHLO
        mx0b-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726333AbgC0OIv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 27 Mar 2020 10:08:51 -0400
Received: from pps.filterd (m0156136.ppops.net [127.0.0.1])
        by mx0b-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02RE76vJ004158;
        Fri, 27 Mar 2020 07:08:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt1;
 bh=NT77/H0R5SEmcfy7z21uiTVvu6RyQ34FLnuuC/YieRQ=;
 b=HFHbSJM6Rpygu7LMLKodBMF8PIdp+Olo742LDFamNEYoTY+mCuDfi8WPKJ74uaiOgpY0
 tF7rRfrs47LEX1bkV8FALbV5fS+Np/wv0D7eg+fPH/uqWelMI4VYJM9wxDIjXyH2yg5+
 SjouQlbOnYgW+bCPxTC+NU6bJNfNmLPM/Bo4MHR25gJ3jpQDxefOnfS2+eNTtJCTtjbU
 tWEJ3fE2ghdP+NDTmmQPWgnurmzTOAEMBqTgHGjxJ3Mqd01C1Ybybwezefq28efAkQjP
 O02vsl6OrzikCwF/LqQAZwbZEgnK9RXwoelGuYVsFt98mcxV0wpL3NmdryTy+fwEl06l dA== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by mx0b-00328301.pphosted.com with ESMTP id 300bux0y15-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Mar 2020 07:08:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EiGc9GUgB6lN6+eO+wGXnHtU5XRiC2Ptq+7rftVVXMHnfvI6Zgg2+ZC08OYQpM8yEdimPLcF+jJZLATRCIxBJSS6dDCpVD5R27cIOs/0O2pS/h0GYj9k6C9vPudbqpSa5JyEuyuhGt15zIKEOw99Sk6MgKSrBLCJHcwpYzVng1bXnQ1lQbDituQDCA5QQzIt6NldwhqjFq/Xa4znymVLZHmMiYAqkEE66KDtJ7z4PDNeIS334i/84FwB2bGPlg55Qm27vozWajdZyPLUMo2jDgxze+15KsPp+3LOSQgAYWfVcU03cVD/pexXjz+zge5lhJSiZdBlUoVJSnxRlyHN9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NT77/H0R5SEmcfy7z21uiTVvu6RyQ34FLnuuC/YieRQ=;
 b=QKm0+aGg+XOPUCzeXd0Dc3IYEkoHlPiuQNV3910fOOTwG9EzLVS+rZSxeZ57lOo6ZO6IZpuZX1jrje3lkt00a5ltxwF1TffjE6Res6XmyyVfhBQabT3I8cLdy7obb5hZ35JF5dwvl/juP7GGjYrLIfFOV9urDXHJyxG25rvSD4xvv7qAvkVa42yMDKttuZ0KKcoa3EvVvmUAuNZryKvWVW5joAQszsI1wmzOrGl7h/Uiljv7mks0B3aSdFi77UTZQgZ8VgAXnghpaOHxnb6YbuG/WZzrZdVxbXBF3+qQ0HZY0g0RfRscyMndPju+E79cszS6bFJ2ncVOl1+SDfhtkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NT77/H0R5SEmcfy7z21uiTVvu6RyQ34FLnuuC/YieRQ=;
 b=aj2IrNVWrnM1e6o2PUwNxexuRs2556qy18mQuFwCKrTbOPt155j8B8Kq/HfoePNVK7VIDrzauOTCjr6uHalMW9YMekb9UHo1ROZ2o9y6ar8OW5i+B+0lhd8bQQ5hhfxvgTRL7eRX8hmA+wmnJ0pLfuRmwP8qS4/vqWIFVGf677I=
Received: from MN2PR12MB4422.namprd12.prod.outlook.com (2603:10b6:208:265::9)
 by MN2PR12MB2893.namprd12.prod.outlook.com (2603:10b6:208:107::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.18; Fri, 27 Mar
 2020 14:08:26 +0000
Received: from MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::7471:da8b:8ca1:6af0]) by MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::7471:da8b:8ca1:6af0%4]) with mapi id 15.20.2835.025; Fri, 27 Mar 2020
 14:08:26 +0000
From:   Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To:     Rohit Sarkar <rohitsarkar5398@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iio: imu: inv_mpu6050: add debugfs register r/w
 interface
Thread-Topic: [PATCH v2] iio: imu: inv_mpu6050: add debugfs register r/w
 interface
Thread-Index: AQHWBDkX3Uqc77Vu2kucOeOFR1s1N6hceZjj
Date:   Fri, 27 Mar 2020 14:08:26 +0000
Message-ID: <MN2PR12MB4422513DF12A699F3B2C06D2C4CC0@MN2PR12MB4422.namprd12.prod.outlook.com>
References: <5e7dfb41.1c69fb81.cc4bb.042f@mx.google.com>
In-Reply-To: <5e7dfb41.1c69fb81.cc4bb.042f@mx.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [91.174.78.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: db5c8b0c-0310-4a71-debc-08d7d25851b1
x-ms-traffictypediagnostic: MN2PR12MB2893:
x-microsoft-antispam-prvs: <MN2PR12MB289367C4F828A62C212E0DA8C4CC0@MN2PR12MB2893.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0355F3A3AE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(39850400004)(346002)(376002)(366004)(110136005)(8676002)(54906003)(186003)(52536014)(76116006)(91956017)(4326008)(5660300002)(71200400001)(8936002)(26005)(81156014)(33656002)(6506007)(66946007)(53546011)(316002)(478600001)(81166006)(86362001)(66476007)(66446008)(9686003)(64756008)(55016002)(7696005)(2906002)(66556008);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB2893;H:MN2PR12MB4422.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
received-spf: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DlIUrY/72j/lNcqfhX+5Aduhqpd9KnhxGrzvPlQD3IUJArVlDtsU/9GKNA7i7SfOMieCBz975WZbdgRPuopQ1IZLEvdnAbuHtWIC1ZlOAObwgNuHkhtYbWlCegNRT8M/IDEAYQgXHEnwADydKprR22Bo6gcjrKuhPNllwxZwFGWbDCPjm4VAu43DVOZDRebHk6RX5BIQNXL2pUWKJ75EIv4y2Z31S8o4QLSmnAnSAMDtbuUIALUFCrr2OQp5HuN8nZhqgBmO9XN4+Er7P+6dS9nA4HWpRG9LFIkU4jvS5wSR8iYr+SoideNScOKasTArtqjEFEv+/CUD4m6S9y8DKKCKmIUZspFaeQ7TvX4AXSlqUsEWaoa6UXXikqip+eToaVD/KoS02NEe3qnMXNHtPscqeVTV7sZDLaQxT5iMsKHOF8olYi12T82LTQ6uzBup
x-ms-exchange-antispam-messagedata: LEwjEQlu1agd64MX6HlDjjYrW0+sw9u2YauuBjgf9Pqm7HzQdx7YVVy5nRtmVVS6YltwvgqcH+OBuXt84nJXYWXOJpcthsLXC5TCGaz2Wu/IBxGAwwG5aoCpigpqCDzsDuaZylRO/q096JSOzcFL7g==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db5c8b0c-0310-4a71-debc-08d7d25851b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2020 14:08:26.2485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bQG+Gs6UijHOgJkxdlTnYKXRcasBZDqEhGHckz6NL+6ou8oU2egxE4NQgKTTfEjMYjl8jT0jG7puV0kVlVktQsZW1sVvrMkyVZ3s4zAT52c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2893
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-27_05:2020-03-27,2020-03-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 clxscore=1011 mlxlogscore=999 bulkscore=0 adultscore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003270130
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello,=0A=
=0A=
thanks, it's OK for me.=0A=
=0A=
Acked-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>=0A=
=0A=
Best regards,=0A=
JB=0A=
=0A=
=0A=
=0A=
From: Rohit Sarkar <rohitsarkar5398@gmail.com>=0A=
=0A=
Sent: Friday, March 27, 2020 14:10=0A=
=0A=
To: linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>=0A=
=0A=
Cc: Jonathan Cameron <jic23@kernel.org>; Hartmut Knaack <knaack.h@gmx.de>; =
Lars-Peter Clausen <lars@metafoo.de>; Peter Meerwald-Stadler <pmeerw@pmeerw=
.net>; Jean-Baptiste Maneyrol <JManeyrol@invensense.com>; Linus Walleij <li=
nus.walleij@linaro.org>;=0A=
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>; linux-iio@vger.kernel=
.org <linux-iio@vger.kernel.org>; linux-kernel@vger.kernel.org <linux-kerne=
l@vger.kernel.org>=0A=
=0A=
Subject: [PATCH v2] iio: imu: inv_mpu6050: add debugfs register r/w interfa=
ce=0A=
=0A=
=A0=0A=
=0A=
=0A=
=A0CAUTION: This email originated from outside of the organization. Please =
make sure the sender is who they say they are and do not click links or ope=
n attachments unless you recognize the sender and know the content is safe.=
=0A=
=0A=
=0A=
=0A=
The debugfs interface provides direct access to read and write device=0A=
=0A=
registers if debugfs is enabled.=0A=
=0A=
=0A=
=0A=
Signed-off-by: Rohit Sarkar <rohitsarkar5398@gmail.com>=0A=
=0A=
---=0A=
=0A=
Changelog v1->v2=0A=
=0A=
* grab a lock to protect driver state=0A=
=0A=
* add a comma at the end of structure member initialisation=0A=
=0A=
=0A=
=0A=
=A0drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 19 +++++++++++++++++++=0A=
=0A=
=A01 file changed, 19 insertions(+)=0A=
=0A=
=0A=
=0A=
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/i=
nv_mpu6050/inv_mpu_core.c=0A=
=0A=
index 7cb9ff3d3e94..381a3fb09858 100644=0A=
=0A=
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c=0A=
=0A=
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c=0A=
=0A=
@@ -1248,12 +1248,31 @@ static const struct attribute_group inv_attribute_g=
roup =3D {=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 .attrs =3D inv_attributes=0A=
=0A=
=A0};=0A=
=0A=
=A0=0A=
=0A=
+static int inv_mpu6050_reg_access(struct iio_dev *indio_dev,=0A=
=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 unsigned int reg,=0A=
=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 unsigned int writeval,=0A=
=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 unsigned int *readval)=0A=
=0A=
+{=0A=
=0A=
+=A0=A0=A0=A0=A0=A0 struct inv_mpu6050_state *st =3D iio_priv(indio_dev);=
=0A=
=0A=
+=A0=A0=A0=A0=A0=A0 int ret =3D 0;=0A=
=0A=
+=0A=
=0A=
+=A0=A0=A0=A0=A0=A0 mutex_lock(&st->lock);=0A=
=0A=
+=A0=A0=A0=A0=A0=A0 if (readval)=0A=
=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D regmap_read(st->map, re=
g, readval);=0A=
=0A=
+=A0=A0=A0=A0=A0=A0 else=0A=
=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D regmap_write(st->map, r=
eg, writeval);=0A=
=0A=
+=A0=A0=A0=A0=A0=A0 mutex_unlock(&st->lock);=0A=
=0A=
+=0A=
=0A=
+=A0=A0=A0=A0=A0=A0 return ret;=0A=
=0A=
+}=0A=
=0A=
+=0A=
=0A=
=A0static const struct iio_info mpu_info =3D {=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 .read_raw =3D &inv_mpu6050_read_raw,=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 .write_raw =3D &inv_mpu6050_write_raw,=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 .write_raw_get_fmt =3D &inv_write_raw_get_fmt,=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 .attrs =3D &inv_attribute_group,=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 .validate_trigger =3D inv_mpu6050_validate_trigger=
,=0A=
=0A=
+=A0=A0=A0=A0=A0=A0 .debugfs_reg_access =3D &inv_mpu6050_reg_access,=0A=
=0A=
=A0};=0A=
=0A=
=A0=0A=
=0A=
=A0/**=0A=
=0A=
-- =0A=
=0A=
2.23.0.385.gbc12974a89=0A=
=0A=
=0A=
=0A=
