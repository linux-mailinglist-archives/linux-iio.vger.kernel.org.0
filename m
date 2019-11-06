Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08298F1FAA
	for <lists+linux-iio@lfdr.de>; Wed,  6 Nov 2019 21:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbfKFUWy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 6 Nov 2019 15:22:54 -0500
Received: from mx0b-00328301.pphosted.com ([148.163.141.47]:11930 "EHLO
        mx0b-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727516AbfKFUWy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 6 Nov 2019 15:22:54 -0500
X-Greylist: delayed 1614 seconds by postgrey-1.27 at vger.kernel.org; Wed, 06 Nov 2019 15:22:52 EST
Received: from pps.filterd (m0156136.ppops.net [127.0.0.1])
        by mx0b-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA6JrxX5006136;
        Wed, 6 Nov 2019 11:55:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt1;
 bh=h/XVLe6Pux7d560heSphWvQ1SFAw9ZSaUZLDRFsU0xM=;
 b=ghs0zsuTMvrrMIlswLuPWH2mXyFdjAxIls2JUe1w0jjcYPiRDNCKFdIY2RkufKmWnoH/
 9CwhgPeaEVRQLom40BMFyXty9z7hmg/AjXVzyiFkLbF2ryz9zMofqhqUl2vKC6NN2ilp
 y5x5Vi9dRFOQ8S+sqB/mSBQWeYlvdw+931QiglR3WnAKrwL9pAg8DotUOjFqyV5YA5eF
 nhzx+SQVOaT4a3VU5DFI1tfCzm5IUeghSCOlvN/y1DZOpWiLxE/DyFJSC0Beep0zfGpJ
 hM74xjOt+XJvc/ZlOjC9NLetCoj3bdVVAnqwTNy2vkrCnqXSJ9dVoP5ITXQ/i938l0Oh Qg== 
Received: from nam01-bn3-obe.outbound.protection.outlook.com (mail-bn3nam01lp2056.outbound.protection.outlook.com [104.47.33.56])
        by mx0b-00328301.pphosted.com with ESMTP id 2w41vm037p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Nov 2019 11:55:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NvgiY2LumdrcYMwEAo8+dq69t4YOflBzrNQFx2fx+C6k+n1aPdEhrftRRHwanQy4iDsWTzp2Go7H9Z/rIJOgB5S75bJmvs+Om4O89VLrEvSdZ6P9ae4r9HLqqu7euczX5ajUnCe3XcoGIKr82xkhf2umdr+gay7MoG2ZvwN2zG39s0FVTEgaqlekSFiVESK5l6H0uUeWNpo5us/X1fclHZDl6/6HQnOYadF4FuJSiSdq8tFg8HcYSVpZXaiseF1ZRtiL2TZuNdUjYCQgfUtet9mD/mOdjy778QFGKQTfsh1xDz2w8MRjLGLIKGT2k/ew4q6746bdZum1/MJxolYVnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h/XVLe6Pux7d560heSphWvQ1SFAw9ZSaUZLDRFsU0xM=;
 b=WmtdQFC04LiO2TfcWrtDeVFwRbUt3XDXRDWcC/jqzqOuppfSNNw1A4/78ngzuYWULkzo284YRTkAvtm1m5VuCf2yYeTXbnvB1jjhxZf3YrcWQUtUx/53C1zBHjA318abX8/IPx5A3F8axx63qI31dlL9fnlTt1yL1jLHmta4dE1MpIBmsfrr0h7XlTTb+KLW5/GFXhXLZ+S6h8Hmw6gGgTCLvu9NoJtFT7AHugANx5M0nC/CfDJ2W6qvsMNu+pbBvKbR+t4kbcRZ02PiEcKxWDkOsoPi89mzSYI9Gsr597mLAnHrXsPhyb2A2gGVi8eDFlgCrxy2FHUyhqt9mm6KWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h/XVLe6Pux7d560heSphWvQ1SFAw9ZSaUZLDRFsU0xM=;
 b=VggZzERFMopaYW5PCxfRMI+CghbXwP7qi15kUMgMkL6XTs2Sa+PTiGDEh0PuEbnPzwLhwDRRro38dwDI8E38ZKqrPyxpmsSEKymwRS0Pr/lnQ3rxw+XvJPTBilxUQhsKN9BgksWSxGGDoThGGvCtz+fMpLWj8Gw3NKAf20kX18w=
Received: from MN2PR12MB3373.namprd12.prod.outlook.com (20.178.242.33) by
 MN2PR12MB3567.namprd12.prod.outlook.com (20.178.242.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Wed, 6 Nov 2019 19:55:21 +0000
Received: from MN2PR12MB3373.namprd12.prod.outlook.com
 ([fe80::95a9:35cd:3e40:8ed3]) by MN2PR12MB3373.namprd12.prod.outlook.com
 ([fe80::95a9:35cd:3e40:8ed3%3]) with mapi id 15.20.2408.024; Wed, 6 Nov 2019
 19:55:20 +0000
From:   Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To:     Stephan Gerhold <stephan@gerhold.net>,
        Jonathan Cameron <jic23@kernel.org>
CC:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Brian Masney <masneyb@onstation.org>,
        Jonathan Marek <jonathan@marek.ca>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: imu: mpu6050: Add support for vdd-supply
 regulator
Thread-Topic: [PATCH 2/2] iio: imu: mpu6050: Add support for vdd-supply
 regulator
Thread-Index: AQHVlNFPtLyzEyio0k+Y+ApC2k58Gqd+jQak
Date:   Wed, 6 Nov 2019 19:55:20 +0000
Message-ID: <MN2PR12MB3373CA676226F02BE0C804A8C4790@MN2PR12MB3373.namprd12.prod.outlook.com>
References: <20191106183536.123070-1-stephan@gerhold.net>,<20191106183536.123070-2-stephan@gerhold.net>
In-Reply-To: <20191106183536.123070-2-stephan@gerhold.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2a01:e0a:393:a700:a447:16b0:e2ea:2b59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3984ae18-a301-4115-a75b-08d762f3415c
x-ms-traffictypediagnostic: MN2PR12MB3567:
x-microsoft-antispam-prvs: <MN2PR12MB3567A55115D9BDDE6DE6B9D8C4790@MN2PR12MB3567.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 02135EB356
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(346002)(39850400004)(376002)(366004)(199004)(189003)(64756008)(7736002)(229853002)(99286004)(305945005)(4326008)(71200400001)(186003)(2906002)(6116002)(74316002)(33656002)(11346002)(476003)(66476007)(9686003)(66946007)(66556008)(52536014)(486006)(5660300002)(46003)(256004)(5024004)(7416002)(14444005)(6436002)(14454004)(6246003)(25786009)(80792005)(86362001)(66446008)(8676002)(71190400001)(446003)(53546011)(316002)(55016002)(102836004)(81166006)(6506007)(7696005)(110136005)(76176011)(81156014)(76116006)(478600001)(8936002)(54906003)(91956017);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3567;H:MN2PR12MB3373.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0C6hOwJLrlICidJJu/gR/a3Egn05xq8FhJhIW0TaVliNgifnu5RPn+k27ZmmaWnMoZ5aMTIC9IndYOyUrnBbZfmQdmCYGq97lBIYcW6MCKejsSHDpKmK7Jsrtgw0KR6TJf764s7k3NlcbzBMGuHXsdP9PJkRs3yYHReCPPTJS8gDxdV18S7IAx2jrrN6aWkKI43gT+qcbP4H4M7kUcuODlz0g5s31xmMSPGQ23TFIIgufHY4Yz8Wn99Wp6vVxWtVZDp9kUD8bcXwNDHZNTBIjBrZB7ldp+z1LNvV0Uv4rSmBY3/Mq/D+zcm7i6heWFRTWei82VYkR+6k/cCWptlo/IZHj09WLGAjSBozF8d2rooK41Mf3hJazKM4WAi4/65MrDuhh2LkIWd4wO1R6DT4kxBFq0A05pvmKveDhLrq82OszQw2qlQr1KNWIOsNM60q
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3984ae18-a301-4115-a75b-08d762f3415c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2019 19:55:20.8001
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1Ld49viUTJAT2A56qUF7jlxzTqsyT39CJMdPPMvDXAZvGikw7sTWBJEEI1biUkqRkLqYQoU7GepsBNnhGAGR60IP0st4JCIQb4iNxCjV4mA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3567
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-06_07:2019-11-06,2019-11-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0
 adultscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1011 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911060194
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello Stephan,=0A=
=0A=
nice patch but I have an important concern.=0A=
=0A=
We are calling the core_enable/disable_regulator functions when going into =
suspend and resume. With your changes, we are going to power down the chip =
when going into suspend and then power it up again. This way we will loose =
all already set configuration, like FSR, sampling rate, init values, ... Th=
e chip will not be able to work correctly anymore after a suspend-resume cy=
cle.=0A=
=0A=
You need to change the resume/suspend handlers to only disable/enable the v=
ddio regulator, not the vdd one.=0A=
=0A=
Thanks.=0A=
=0A=
Best regards,=0A=
JB=0A=
=0A=
From: Stephan Gerhold <stephan@gerhold.net>=0A=
=0A=
Sent: Wednesday, November 6, 2019 19:35=0A=
=0A=
To: Jonathan Cameron <jic23@kernel.org>=0A=
=0A=
Cc: Hartmut Knaack <knaack.h@gmx.de>; Lars-Peter Clausen <lars@metafoo.de>;=
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>; Rob Herring <robh+dt@kernel.or=
g>; Mark Rutland <mark.rutland@arm.com>; Linus Walleij <linus.walleij@linar=
o.org>; Brian Masney <masneyb@onstation.org>;=0A=
 Jonathan Marek <jonathan@marek.ca>; Jean-Baptiste Maneyrol <JManeyrol@inve=
nsense.com>; linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>; devicet=
ree@vger.kernel.org <devicetree@vger.kernel.org>; linux-kernel@vger.kernel.=
org <linux-kernel@vger.kernel.org>;=0A=
 Stephan Gerhold <stephan@gerhold.net>=0A=
=0A=
Subject: [PATCH 2/2] iio: imu: mpu6050: Add support for vdd-supply regulato=
r=0A=
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
MPU6050 has two power supply pins: VDD and VLOGIC, but the mpu6050=0A=
=0A=
only supports enabling one of them at the moment. In some cases,=0A=
=0A=
they may need to be enabled separately.=0A=
=0A=
=0A=
=0A=
Add an additional "vdd-supply", but keep the code simple by making=0A=
=0A=
the driver use the regulator bulk API. This actually allows further=0A=
=0A=
simplifying the code since regulator_bulk_* already logs the errors=0A=
=0A=
for us.=0A=
=0A=
=0A=
=0A=
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>=0A=
=0A=
---=0A=
=0A=
=A0drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 30 +++++++---------------=
=0A=
=0A=
=A0drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h=A0 |=A0 5 ++--=0A=
=0A=
=A02 files changed, 12 insertions(+), 23 deletions(-)=0A=
=0A=
=0A=
=0A=
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/i=
nv_mpu6050/inv_mpu_core.c=0A=
=0A=
index 354030e9bed5..8e50dbcd730b 100644=0A=
=0A=
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c=0A=
=0A=
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c=0A=
=0A=
@@ -1144,11 +1144,8 @@ static int inv_mpu_core_enable_regulator(struct inv_=
mpu6050_state *st)=0A=
=0A=
=A0{=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 int result;=0A=
=0A=
=A0=0A=
=0A=
-=A0=A0=A0=A0=A0=A0 result =3D regulator_enable(st->vddio_supply);=0A=
=0A=
-=A0=A0=A0=A0=A0=A0 if (result) {=0A=
=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_err(regmap_get_device(st->m=
ap),=0A=
=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "Failed=
 to enable regulator: %d\n", result);=0A=
=0A=
-=A0=A0=A0=A0=A0=A0 } else {=0A=
=0A=
+=A0=A0=A0=A0=A0=A0 result =3D regulator_bulk_enable(ARRAY_SIZE(st->supplie=
s), st->supplies);=0A=
=0A=
+=A0=A0=A0=A0=A0=A0 if (result =3D=3D 0) {=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* Give the device a littl=
e bit of time to start up. */=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 usleep_range(35000, 70000)=
;=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
=0A=
@@ -1158,14 +1155,7 @@ static int inv_mpu_core_enable_regulator(struct inv_=
mpu6050_state *st)=0A=
=0A=
=A0=0A=
=0A=
=A0static int inv_mpu_core_disable_regulator(struct inv_mpu6050_state *st)=
=0A=
=0A=
=A0{=0A=
=0A=
-=A0=A0=A0=A0=A0=A0 int result;=0A=
=0A=
-=0A=
=0A=
-=A0=A0=A0=A0=A0=A0 result =3D regulator_disable(st->vddio_supply);=0A=
=0A=
-=A0=A0=A0=A0=A0=A0 if (result)=0A=
=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_err(regmap_get_device(st->m=
ap),=0A=
=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "Failed=
 to disable regulator: %d\n", result);=0A=
=0A=
-=0A=
=0A=
-=A0=A0=A0=A0=A0=A0 return result;=0A=
=0A=
+=A0=A0=A0=A0=A0=A0 return regulator_bulk_disable(ARRAY_SIZE(st->supplies),=
 st->supplies);=0A=
=0A=
=A0}=0A=
=0A=
=A0=0A=
=0A=
=A0static void inv_mpu_core_disable_regulator_action(void *_data)=0A=
=0A=
@@ -1239,14 +1229,12 @@ int inv_mpu_core_probe(struct regmap *regmap, int i=
rq, const char *name,=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
=0A=
=A0=0A=
=0A=
-=A0=A0=A0=A0=A0=A0 st->vddio_supply =3D devm_regulator_get(dev, "vddio");=
=0A=
=0A=
-=A0=A0=A0=A0=A0=A0 if (IS_ERR(st->vddio_supply)) {=0A=
=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (PTR_ERR(st->vddio_supply) !=
=3D -EPROBE_DEFER)=0A=
=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_err=
(dev, "Failed to get vddio regulator %d\n",=0A=
=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 (int)PTR_ERR(st->vddio_supply));=0A=
=0A=
-=0A=
=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return PTR_ERR(st->vddio_supply=
);=0A=
=0A=
-=A0=A0=A0=A0=A0=A0 }=0A=
=0A=
+=A0=A0=A0=A0=A0=A0 st->supplies[0].supply =3D "vdd";=0A=
=0A=
+=A0=A0=A0=A0=A0=A0 st->supplies[1].supply =3D "vddio";=0A=
=0A=
+=A0=A0=A0=A0=A0=A0 result =3D devm_regulator_bulk_get(dev, ARRAY_SIZE(st->=
supplies),=0A=
=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->supplies);=0A=
=0A=
+=A0=A0=A0=A0=A0=A0 if (result)=0A=
=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return result;=0A=
=0A=
=A0=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 result =3D inv_mpu_core_enable_regulator(st);=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 if (result)=0A=
=0A=
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/in=
v_mpu6050/inv_mpu_iio.h=0A=
=0A=
index 52fcf45050a5..96cbd7f2b4b3 100644=0A=
=0A=
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h=0A=
=0A=
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h=0A=
=0A=
@@ -12,6 +12,7 @@=0A=
=0A=
=A0#include <linux/iio/iio.h>=0A=
=0A=
=A0#include <linux/iio/buffer.h>=0A=
=0A=
=A0#include <linux/regmap.h>=0A=
=0A=
+#include <linux/regulator/consumer.h>=0A=
=0A=
=A0#include <linux/iio/sysfs.h>=0A=
=0A=
=A0#include <linux/iio/kfifo_buf.h>=0A=
=0A=
=A0#include <linux/iio/trigger.h>=0A=
=0A=
@@ -130,7 +131,7 @@ struct inv_mpu6050_hw {=0A=
=0A=
=A0 *=A0 @chip_period:=A0=A0=A0=A0=A0 chip internal period estimation (~1kH=
z).=0A=
=0A=
=A0 *=A0 @it_timestamp:=A0=A0=A0=A0 timestamp from previous interrupt.=0A=
=0A=
=A0 *=A0 @data_timestamp:=A0=A0 timestamp for next data sample.=0A=
=0A=
- *=A0 @vddio_supply=A0=A0=A0=A0=A0 voltage regulator for the chip.=0A=
=0A=
+ *=A0 @supplies:=A0=A0=A0=A0=A0=A0=A0=A0 voltage regulators for the chip.=
=0A=
=0A=
=A0 *=A0 @magn_disabled:=A0=A0=A0=A0 magnetometer disabled for backward com=
patibility reason.=0A=
=0A=
=A0 *=A0 @magn_raw_to_gauss:=A0=A0=A0=A0=A0=A0=A0 coefficient to convert ma=
g raw value to Gauss.=0A=
=0A=
=A0 *=A0 @magn_orient:=A0=A0=A0=A0=A0=A0 magnetometer sensor chip orientati=
on if available.=0A=
=0A=
@@ -154,7 +155,7 @@ struct inv_mpu6050_state {=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 s64 chip_period;=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 s64 it_timestamp;=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 s64 data_timestamp;=0A=
=0A=
-=A0=A0=A0=A0=A0=A0 struct regulator *vddio_supply;=0A=
=0A=
+=A0=A0=A0=A0=A0=A0 struct regulator_bulk_data supplies[2];=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 bool magn_disabled;=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 s32 magn_raw_to_gauss[3];=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 struct iio_mount_matrix magn_orient;=0A=
=0A=
-- =0A=
=0A=
2.23.0=0A=
=0A=
=0A=
=0A=
