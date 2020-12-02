Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E851F2CBE52
	for <lists+linux-iio@lfdr.de>; Wed,  2 Dec 2020 14:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbgLBNaW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Dec 2020 08:30:22 -0500
Received: from mx0b-00328301.pphosted.com ([148.163.141.47]:21042 "EHLO
        mx0b-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725920AbgLBNaV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Dec 2020 08:30:21 -0500
X-Greylist: delayed 474 seconds by postgrey-1.27 at vger.kernel.org; Wed, 02 Dec 2020 08:30:18 EST
Received: from pps.filterd (m0156136.ppops.net [127.0.0.1])
        by mx0b-00328301.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0B2DIYV3031844;
        Wed, 2 Dec 2020 05:21:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt1;
 bh=UsiulU/c5j9mtwCPVOHchGvvAzWE7d77VxGbSx2x0+E=;
 b=Vp9n4faPtj8Ds/RkZTUW8QucuLOCl7YQUqn0CEnShTvjlbQQYQTVdY36AdjL3ZpElQDk
 91BiENNLvCfRmjc18BcOFLCXrZHUgvoCNpA5k4r7OgY+Vtaw93kPYZbm0QhlA+NEfp+6
 rMT7NKWCAbHHnZ69FvpPpUuidVH4xOmEhiPGfQpW93SvYvfoXstNe1rmx1Zn1ISQhlLy
 JIqZLPQ371TTFxmt3Owo2qhL61SekpV7D7vXT3XP2YoupOEHpDc01xWHvMDmAeemoQU2
 OtHxSYqyp7EwRn9/W9+p5ySKVeTvliN3srwjLevh/rd1n3vQoIomx35rO5AVD/U/yJGB TA== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by mx0b-00328301.pphosted.com with ESMTP id 355cdhru9f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Dec 2020 05:21:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PyvBwhMf8EYSkR98K6FXj6PPco9vhi1+9ojsa6KIz9Wl5ZH0Je9PNPm/qyDFWlQeuMmRyd6am90lQBqDktKpC4yK94uIvi0RlowwkDp/LRumm2eHgwAW5iZsP5SSU2SCv/1CBE30H2EwcMpxYSQCJCzVoYxu4dOjDEnqRpTKkKUERyMwl5p7qOQBcExFVtDSCmw1ld4+3DuJFLkDbMP0UaGZnLKugYpIsgVLEHw7S4OqnWWFpx3WP1H3bWzwMdtzbqzUr5q914ThyhtDKoWfw6ZxCpzldtwnIivGDyUht5ukjJIba0P9F00fG2bDoIRbi6Ps25kPSkIqLurK4FkYDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UsiulU/c5j9mtwCPVOHchGvvAzWE7d77VxGbSx2x0+E=;
 b=VcJcEstQlkoskp6Rrl36KhH8u53SiCs48aWZ63MfddoQjR9BnuOGWjE7pNkWgc/rawaFJ6gZIgVxB2M6nhQ8Z3HuEBMB/gMgCj3WjkvYGE6GA6k4jdRfDVpfUvqI218AiZRzMITzhB6RtyIfVjhZ1amD1v6g/fVsdvz7qSRHMOPoXtOgtut3rGL0gcxUDGiQAVLK7cLJZqAJ0TKBA8AMQGVORB+dGEtUtwfU2s+DqCvGCWdW8PFEtgFWPFvICnBu4DldByOwa4js//orRYpwvOLUIU5mwH2+d/IBe/vhzYwIgxQy59fhBOfbfo/3bPse2IK28G8NHSCMYm+hIqJxuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UsiulU/c5j9mtwCPVOHchGvvAzWE7d77VxGbSx2x0+E=;
 b=GcFPVrz3zcdEJf3Mjs5oqTl1YqSYtcyz0t2DnqKvmyOQi6M16/vdqaZTjhUjqkozgVUf7yV+yZwNcrouNHmy4cohsYzIqBKSD50GtrQhbDi8mwP4c/PDA8SUV1aJNwvuEGJonEkwS+dPWd+ojh/1kfgZINkjpLJJ3ThR3HwU4LI=
Received: from BL0PR12MB5011.namprd12.prod.outlook.com (2603:10b6:208:1c9::17)
 by MN2PR12MB4064.namprd12.prod.outlook.com (2603:10b6:208:1d3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Wed, 2 Dec
 2020 13:21:25 +0000
Received: from BL0PR12MB5011.namprd12.prod.outlook.com
 ([fe80::79bf:5f72:1126:57f7]) by BL0PR12MB5011.namprd12.prod.outlook.com
 ([fe80::79bf:5f72:1126:57f7%5]) with mapi id 15.20.3632.018; Wed, 2 Dec 2020
 13:21:25 +0000
From:   Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To:     Stephan Gerhold <stephan@gerhold.net>,
        Jonathan Cameron <jic23@kernel.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] iio: imu: inv_mpu6050: Add support for MPU-6880
Thread-Topic: [PATCH v2 2/2] iio: imu: inv_mpu6050: Add support for MPU-6880
Thread-Index: AQHWyJiR/1CZD25XU0+pU7o37SuLm6njyrTr
Date:   Wed, 2 Dec 2020 13:21:25 +0000
Message-ID: <BL0PR12MB5011E7EE3AE0FA2D6BC75592C4F30@BL0PR12MB5011.namprd12.prod.outlook.com>
References: <20201202104656.5119-1-stephan@gerhold.net>,<20201202104656.5119-2-stephan@gerhold.net>
In-Reply-To: <20201202104656.5119-2-stephan@gerhold.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gerhold.net; dkim=none (message not signed)
 header.d=none;gerhold.net; dmarc=none action=none header.from=invensense.com;
x-originating-ip: [2a01:e0a:393:a700:6076:fcf1:88ca:fb96]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a878a1e7-628b-4e49-42b1-08d896c52b96
x-ms-traffictypediagnostic: MN2PR12MB4064:
x-microsoft-antispam-prvs: <MN2PR12MB4064D38C5FFA4C1EB87C1768C4F30@MN2PR12MB4064.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 82xUDpYul1SNSYcb/pyaI0TnMwknuxWTKFfdK/9wCJEqdDJ6DSLRgGBxEYD0CpRwufu1Hs+O25NV7GGGPhXsel9ZMKYiWpfmfBCqv/Y5058qcmLctjfgnBtAgO1GmAUIsqDZZpgg5ViClfKw707lFnoFXMDtrgJshESiuTvhU/up/5I5dD7Ht8c4zB3ApNIsDHhZtuhQQUxEHUTaQ5zDlC1UfMTFHY+4p57TNmHOfOShBTichHsZ3NHAYa4Zc9t2NJhvD34K5y1u+Hv2f2L+C5D3MM/ACva+1VXM5kHMJZBuptwfj+BrVtVchNATNtGx
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5011.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(376002)(366004)(39850400004)(136003)(55016002)(66946007)(91956017)(9686003)(64756008)(66556008)(66446008)(86362001)(71200400001)(6506007)(5660300002)(53546011)(52536014)(33656002)(2906002)(76116006)(316002)(66476007)(8936002)(186003)(83380400001)(4326008)(54906003)(7696005)(478600001)(8676002)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?KwaNKRCU0gt5EBENqbCcE9ApgTx5LM3MC8M4W/yxVRQ0P7oWWVOl7fdI8B?=
 =?iso-8859-1?Q?1YeXRHv7osMD8D2qbpJRD5wvtVl7+V1hBXrfNQvd6A73HIQ4XGNDTdXHZZ?=
 =?iso-8859-1?Q?Zwn4NExcaFKUjFoO8j+7XYnHz2TwVO02XePoiQNd/D550QnjupkbCP2dfE?=
 =?iso-8859-1?Q?B9h34xXkBDouPTlz36NCkoF1m/XGQ6Rj0s4GXzRMAbu1w/GuLfYeuhUI7B?=
 =?iso-8859-1?Q?NiF7AFJiUtrGwQfxkR1EqXZRdz2oCci4X5r+n3nDZ2KHiNrTjJBWFi/Jb7?=
 =?iso-8859-1?Q?rpuN0AW4ZTn9HXlOx3bshbMnEkjEVEPoTzC/mAuDjAeoewToIatQqedbfN?=
 =?iso-8859-1?Q?p0/bFa04lPoKhd7TMzRwFQcqxezsdUWEmfwrkw8oLG0H+/qfKukCgcg5Vh?=
 =?iso-8859-1?Q?JO+CYdjckOriMNw665i8ofclG4I2G8ZOF+dEmWxwkJpZhy9zW6jlIZUWw5?=
 =?iso-8859-1?Q?Sz50iOJKxKJ0y/OndHS+nwck+hgSL3YFHLAMaJEUHv/QuhXTQhKKfyKWSE?=
 =?iso-8859-1?Q?lF/aLPkzG2pFcaAyn2JL1099+PKsgKIIIWqcPRa/oTgoHy9zduh9j3rjhc?=
 =?iso-8859-1?Q?m8BTTJaI4GRBG9NU8Xj28OGXXrcOQy5mDsLdY9/aqF4iYFoGkI++6r1N9d?=
 =?iso-8859-1?Q?hdOfw6UbqC8tempGID27lbgf/D8tbe6i5Dy8yb4W4gFulh2HAEoTiZ2kJv?=
 =?iso-8859-1?Q?sHWOJBLIuw1Fb1ivXuUsZw9pBWHVCK0LQTPwzCUAGtA+OQWRXXPLe9Q3Fe?=
 =?iso-8859-1?Q?WNhv91ePz4/G35iNfMYybXgEmfcvAzw+Y+aUSjDWVIRleH80PhUvNQTUcD?=
 =?iso-8859-1?Q?eNAEyO9J2Xz+YW3eHoNVIH4IZXeuR9ADtBWBECVlHbDA17H2HMDv6Evje2?=
 =?iso-8859-1?Q?w0VcayNCt1iKiHi8q7RQHwe9NWXdO6HaZnwXomcuhbvWGfpVqQKp9oliCt?=
 =?iso-8859-1?Q?5992FdF/tqQriq3SiZqSN8K8d2QWEo0btgeXchBHGTEwCbR1zJslU1wzC6?=
 =?iso-8859-1?Q?CUfosYtkiKnJfX7uTptMrzjOa1izKTa8FzaSwEQvn88ZyEIc8i4y1cAvu2?=
 =?iso-8859-1?Q?tfgg+ucfPIS4AjjoJgCHGP0=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5011.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a878a1e7-628b-4e49-42b1-08d896c52b96
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2020 13:21:25.5741
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c18fKPl+xmTlG3iBOnXPw0JX/2+hJ7s33cVAr5ZzBz9zlGQ1aDVhnrsM3B7+TviJg+0mpTxqOBCOMzLmiCGmRC6dvuTuB4pS02OThN5XrIY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4064
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-02_06:2020-11-30,2020-12-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 suspectscore=0 spamscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 phishscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012020080
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Perfect, thanks.=0A=
=0A=
Acked-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>=0A=
=0A=
=0A=
From: Stephan Gerhold <stephan@gerhold.net>=0A=
Sent: Wednesday, December 2, 2020 11:46=0A=
To: Jonathan Cameron <jic23@kernel.org>=0A=
Cc: Lars-Peter Clausen <lars@metafoo.de>; Peter Meerwald-Stadler <pmeerw@pm=
eerw.net>; Rob Herring <robh+dt@kernel.org>; linux-iio@vger.kernel.org <lin=
ux-iio@vger.kernel.org>; devicetree@vger.kernel.org <devicetree@vger.kernel=
.org>; Jean-Baptiste Maneyrol <JManeyrol@invensense.com>; Stephan Gerhold <=
stephan@gerhold.net>=0A=
Subject: [PATCH v2 2/2] iio: imu: inv_mpu6050: Add support for MPU-6880 =0A=
=A0=0A=
=A0CAUTION: This email originated from outside of the organization. Please =
make sure the sender is who they say they are and do not click links or ope=
n attachments unless you recognize the sender and know the content is safe.=
=0A=
=0A=
MPU-6880 seems to be very similar to MPU-6500 and it works=0A=
fine with some minor additions for the mpu6050 driver.=0A=
=0A=
Add the necessary defines for it and make it use the same registers=0A=
as MPU-6500 but with a FIFO size of 4096.=0A=
=0A=
Cc: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>=0A=
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>=0A=
---=0A=
I tested this on a Xiaomi Redmi 2 (or Wingtech WT88047).=0A=
=0A=
Changes in v2:=0A=
=A0 - Mention support for MPU-6880 in Kconfig=0A=
---=0A=
=A0drivers/iio/imu/inv_mpu6050/Kconfig=A0=A0=A0=A0=A0=A0=A0 | 8 ++++----=0A=
=A0drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 9 +++++++++=0A=
=A0drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c=A0 | 5 +++++=0A=
=A0drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h=A0 | 2 ++=0A=
=A0drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c=A0 | 5 +++++=0A=
=A05 files changed, 25 insertions(+), 4 deletions(-)=0A=
=0A=
diff --git a/drivers/iio/imu/inv_mpu6050/Kconfig b/drivers/iio/imu/inv_mpu6=
050/Kconfig=0A=
index 7137ea6f25db..9c625517173a 100644=0A=
--- a/drivers/iio/imu/inv_mpu6050/Kconfig=0A=
+++ b/drivers/iio/imu/inv_mpu6050/Kconfig=0A=
@@ -16,8 +16,8 @@ config INV_MPU6050_I2C=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 select REGMAP_I2C=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 help=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 This driver supports the Invensense MPU6050/=
9150,=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0 MPU6500/6515/9250/9255, ICM20608/20609/20689, ICM=
20602/ICM20690 and=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0 IAM20680 motion tracking devices over I2C.=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0 MPU6500/6515/6880/9250/9255, ICM20608/20609/20689=
, ICM20602/ICM20690=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0 and IAM20680 motion tracking devices over I2C.=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 This driver can be built as a module. The mo=
dule will be called=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 inv-mpu6050-i2c.=0A=
=A0=0A=
@@ -28,7 +28,7 @@ config INV_MPU6050_SPI=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 select REGMAP_SPI=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 help=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 This driver supports the Invensense MPU6000,=
=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0 MPU6500/6515/9250/9255, ICM20608/20609/20689, ICM=
20602/ICM20690 and=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0 IAM20680 motion tracking devices over SPI.=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0 MPU6500/6515/6880/9250/9255, ICM20608/20609/20689=
, ICM20602/ICM20690=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0 and IAM20680 motion tracking devices over SPI.=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 This driver can be built as a module. The mo=
dule will be called=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 inv-mpu6050-spi.=0A=
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/i=
nv_mpu6050/inv_mpu_core.c=0A=
index 18a1898e3e34..453c51c79655 100644=0A=
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c=0A=
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c=0A=
@@ -160,6 +160,14 @@ static const struct inv_mpu6050_hw hw_info[] =3D {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .fifo_size =3D 512,=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .temp =3D {INV_MPU6500_TEM=
P_OFFSET, INV_MPU6500_TEMP_SCALE},=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 },=0A=
+=A0=A0=A0=A0=A0=A0 {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .whoami =3D INV_MPU6880_WHOAMI_=
VALUE,=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .name =3D "MPU6880",=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .reg =3D &reg_set_6500,=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .config =3D &chip_config_6500,=
=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .fifo_size =3D 4096,=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .temp =3D {INV_MPU6500_TEMP_OFF=
SET, INV_MPU6500_TEMP_SCALE},=0A=
+=A0=A0=A0=A0=A0=A0 },=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .whoami =3D INV_MPU6000_WH=
OAMI_VALUE,=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .name =3D "MPU6000",=0A=
@@ -1323,6 +1331,7 @@ static int inv_check_and_setup_chip(struct inv_mpu605=
0_state *st)=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 case INV_MPU6000:=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 case INV_MPU6500:=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 case INV_MPU6515:=0A=
+=A0=A0=A0=A0=A0=A0 case INV_MPU6880:=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 case INV_MPU9250:=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 case INV_MPU9255:=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* reset signal path (requ=
ired for spi connection) */=0A=
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c b/drivers/iio/imu/in=
v_mpu6050/inv_mpu_i2c.c=0A=
index 28cfae1e61cf..95f16951c8f4 100644=0A=
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c=0A=
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c=0A=
@@ -177,6 +177,7 @@ static const struct i2c_device_id inv_mpu_id[] =3D {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 {"mpu6050", INV_MPU6050},=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 {"mpu6500", INV_MPU6500},=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 {"mpu6515", INV_MPU6515},=0A=
+=A0=A0=A0=A0=A0=A0 {"mpu6880", INV_MPU6880},=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 {"mpu9150", INV_MPU9150},=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 {"mpu9250", INV_MPU9250},=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 {"mpu9255", INV_MPU9255},=0A=
@@ -204,6 +205,10 @@ static const struct of_device_id inv_of_match[] =3D {=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .compatible =3D "invensens=
e,mpu6515",=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .data =3D (void *)INV_MPU6=
515=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 },=0A=
+=A0=A0=A0=A0=A0=A0 {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .compatible =3D "invensense,mpu=
6880",=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .data =3D (void *)INV_MPU6880=
=0A=
+=A0=A0=A0=A0=A0=A0 },=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .compatible =3D "invensens=
e,mpu9150",=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .data =3D (void *)INV_MPU9=
150=0A=
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/in=
v_mpu6050/inv_mpu_iio.h=0A=
index eb522b38acf3..58188dc0dd13 100644=0A=
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h=0A=
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h=0A=
@@ -70,6 +70,7 @@ enum inv_devices {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 INV_MPU6050,=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 INV_MPU6500,=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 INV_MPU6515,=0A=
+=A0=A0=A0=A0=A0=A0 INV_MPU6880,=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 INV_MPU6000,=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 INV_MPU9150,=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 INV_MPU9250,=0A=
@@ -373,6 +374,7 @@ struct inv_mpu6050_state {=0A=
=A0#define INV_MPU6000_WHOAMI_VALUE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 0x68=0A=
=A0#define INV_MPU6050_WHOAMI_VALUE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 0x68=0A=
=A0#define INV_MPU6500_WHOAMI_VALUE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 0x70=0A=
+#define INV_MPU6880_WHOAMI_VALUE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 0x78=0A=
=A0#define INV_MPU9150_WHOAMI_VALUE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 0x68=0A=
=A0#define INV_MPU9250_WHOAMI_VALUE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 0x71=0A=
=A0#define INV_MPU9255_WHOAMI_VALUE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 0x73=0A=
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c b/drivers/iio/imu/in=
v_mpu6050/inv_mpu_spi.c=0A=
index 6f968ce687e1..b056f3fe2561 100644=0A=
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c=0A=
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c=0A=
@@ -70,6 +70,7 @@ static const struct spi_device_id inv_mpu_id[] =3D {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 {"mpu6000", INV_MPU6000},=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 {"mpu6500", INV_MPU6500},=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 {"mpu6515", INV_MPU6515},=0A=
+=A0=A0=A0=A0=A0=A0 {"mpu6880", INV_MPU6880},=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 {"mpu9250", INV_MPU9250},=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 {"mpu9255", INV_MPU9255},=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 {"icm20608", INV_ICM20608},=0A=
@@ -96,6 +97,10 @@ static const struct of_device_id inv_of_match[] =3D {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .compatible =3D "invensens=
e,mpu6515",=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .data =3D (void *)INV_MPU6=
515=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 },=0A=
+=A0=A0=A0=A0=A0=A0 {=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .compatible =3D "invensense,mpu=
6880",=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .data =3D (void *)INV_MPU6880=
=0A=
+=A0=A0=A0=A0=A0=A0 },=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .compatible =3D "invensens=
e,mpu9250",=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .data =3D (void *)INV_MPU9=
250=0A=
-- =0A=
2.29.2=0A=
