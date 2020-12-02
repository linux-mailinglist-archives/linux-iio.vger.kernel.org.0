Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B19DF2CBB2D
	for <lists+linux-iio@lfdr.de>; Wed,  2 Dec 2020 12:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbgLBLBY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Dec 2020 06:01:24 -0500
Received: from mx0a-00328301.pphosted.com ([148.163.145.46]:10404 "EHLO
        mx0a-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726658AbgLBLBX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Dec 2020 06:01:23 -0500
X-Greylist: delayed 1924 seconds by postgrey-1.27 at vger.kernel.org; Wed, 02 Dec 2020 06:01:21 EST
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0B2AS2MA029954;
        Wed, 2 Dec 2020 02:28:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt1;
 bh=UlkKXh22Mua8C2AnazWpAvLvLQYEWgB10AZTvt5L/Nw=;
 b=e7m7clXe4tFkwN+41yORIo9cXI6MA4zKI/iBQUMRfxAcscgciwVmqhD2UQfIrirKnNA1
 8ou4qtGbv63aOPkh4IbMz2N1pTXbpf7/AaoO/qdibzoryp1GAtv6iqrzkOO0K+2S3DVO
 juLoxRY27sUTPDt3BStscp9z7qfrq1C9DIt+DpHtU239Ta1FbA4vuik2yTxMxTeXl43r
 MXrxipabz9SZ/Both6NUOaR80yYLE4Qorm6AvGy+EHgANo0e9CcuyFFn/18rrlqNs+3Q
 verCHb51xPjARDdLY3D0S7nnNs2jGg3uebKoY7nFXVCqDv0GFORAmMh135P6KrDRXCZP 1w== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by mx0a-00328301.pphosted.com with ESMTP id 355cap8tfy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Dec 2020 02:28:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mpWMT7DfgDM3ws1CEVBY4et4uq0c9nfov/mDvrc5d1JbpVGzaL7/WfVwBuft1L8W2BcQktrz94BaIZtqjw/zQUiU0tn8aPUqKkACabJtkmxmb/YJAR5pKW3VZctISZLClZOCykZ/Pj4BeDaiU9sf5S4Tj4HzfdNeQ/5FqD4A4lnxsgvfffQgBcmY59/Zuz6o6oai9pdJPDr2gq5lBp5+8QigIZqM/DGm/LYQtLwZ5qibVDtOf9kSqF3iijKuHCwHvwRTFMK+BV+aEosj/f3jONqln/BqsEvalCTjZtd8emZUkvvpaTNvHjZfcD5yNTKZP8Vf4BMCQ1KZ+MxevXtJZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UlkKXh22Mua8C2AnazWpAvLvLQYEWgB10AZTvt5L/Nw=;
 b=g/kduyWfroK4yBhb+zE4wyzSHuTWqzIeQhfC9zgo0VE3CJLHILqhGpMFan8Dc2Vja2yhqzD3l1s4H7Vk5qM79vVH2LD/6IawTHkVCtxINxQLKdJqZkPbzchMJVWolFY7hhy4cCeTjiMkIwGiDqACfdMEZD22jEXIwja1prFzZoCkp6fT/weGtQrxAZF2IUiGHi/bf2EuM209qQ6JycGgwayiEUqFDS/xBEBTycaJ7sfZU7hsgxNVcRPgJbgboY0Yy4U0SMTP77baXQYtYiAf77X+ccY69bgTrV2XDnkpmm5Rds2dNzkvhkeB+Ok7OGJZFwHk8eziEJa0Xy66bSt7Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UlkKXh22Mua8C2AnazWpAvLvLQYEWgB10AZTvt5L/Nw=;
 b=fZPdAEmNJWqyJkzVX/h/zj1M0Z7VJgirf54bTNwzwPV3zFCl3JURYrB2KhJxyUm5WzcwGctS8C3APNhM9h8BVLiCDDiCG8IMhVXtAFRl82ZNK57p/hAiMASdXwAO3Q+VwgHPxV7dUEX0NCauU5/+5iih0TRyjlIiLSaPezsA7ac=
Received: from BL0PR12MB5011.namprd12.prod.outlook.com (2603:10b6:208:1c9::17)
 by MN2PR12MB4422.namprd12.prod.outlook.com (2603:10b6:208:265::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.22; Wed, 2 Dec
 2020 10:28:12 +0000
Received: from BL0PR12MB5011.namprd12.prod.outlook.com
 ([fe80::79bf:5f72:1126:57f7]) by BL0PR12MB5011.namprd12.prod.outlook.com
 ([fe80::79bf:5f72:1126:57f7%5]) with mapi id 15.20.3632.018; Wed, 2 Dec 2020
 10:28:12 +0000
From:   Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To:     Stephan Gerhold <stephan@gerhold.net>,
        Jonathan Cameron <jic23@kernel.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: imu: inv_mpu6050: Add support for MPU-6880
Thread-Topic: [PATCH 2/2] iio: imu: inv_mpu6050: Add support for MPU-6880
Thread-Index: AQHWyJQX3Xe4k+6dVk2kZZG6mWgT06njmKR0
Date:   Wed, 2 Dec 2020 10:28:12 +0000
Message-ID: <BL0PR12MB5011BDAEB3374151F522B7F2C4F30@BL0PR12MB5011.namprd12.prod.outlook.com>
References: <20201202101355.87112-1-stephan@gerhold.net>,<20201202101355.87112-2-stephan@gerhold.net>
In-Reply-To: <20201202101355.87112-2-stephan@gerhold.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gerhold.net; dkim=none (message not signed)
 header.d=none;gerhold.net; dmarc=none action=none header.from=invensense.com;
x-originating-ip: [2a01:e0a:393:a700:6076:fcf1:88ca:fb96]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3975c02e-9920-4203-09c5-08d896acf893
x-ms-traffictypediagnostic: MN2PR12MB4422:
x-microsoft-antispam-prvs: <MN2PR12MB442239E8FA0EA6D15C5F1A2DC4F30@MN2PR12MB4422.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SfCBh9aULtPIsZNAmWCE0NmbnHlgBxfYP6pXaEWE8LZ6VqytZRil8PsnAqtZVXs2TUgfgpVy2Ni2JQb3WYnaXVmLE5x+VCdU7t1QgwMO7+lsQ7ycvtVfEv5CIw1ogOo+4ORHwMK6MzEGlvTIoKqE99wD3YIB/+HM9tqKNrcgMjJ20O3Hoynviv0UxTzYQ1LsgH+5FyFMQoxMRiu4jfo/4mO/8AEDvdHZwd00xVebEWAgESMPzyK3QLd8kdS6pAUCprwiMg7RW1L2T825V9qHHbBPY73zyFIfK38bQceAwPA6W/NZNP00LHyivpldYEmu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5011.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39850400004)(376002)(136003)(396003)(346002)(86362001)(110136005)(6506007)(9686003)(66446008)(33656002)(71200400001)(55016002)(478600001)(54906003)(7696005)(52536014)(8676002)(2906002)(5660300002)(186003)(8936002)(4326008)(83380400001)(76116006)(91956017)(66476007)(64756008)(66946007)(316002)(66556008)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?W7lspSY25CLr+5z/z2kNKNKmi1nB/H/UjO9YjciHs6ge8Jmg3TT78PBjsy?=
 =?iso-8859-1?Q?jLG2Z8Du3KsWzHabdHxhGEWILXVn53baoOIPPezG88UoxujVvkRqRx4GDE?=
 =?iso-8859-1?Q?0Yd8t/2G4HZjEpf4c2fezvA8GoOr9o3EcWHjWWx0/uUvIZXWClQNoeZ2ID?=
 =?iso-8859-1?Q?iIHn6XfwDEy1oyu5rLZTneDqhNnj5FLXpKjTGcl8GkxQGNtAzGARfSdeX7?=
 =?iso-8859-1?Q?kQxBBFbZWACbS9MjJNmR8A35JZ4r+PQWR2hSAfHww89n4sMeEVcdlHrz8O?=
 =?iso-8859-1?Q?I54ZDKK+pOqf4D4ngeuvEAlezzC6j5DnPC51MxkPbOu9HF7uq8RXL08Crr?=
 =?iso-8859-1?Q?17Qbp0IQaq5X5U4bu9RaQsn+bTsWm2HuFs2T9SDRef8fSOaqS1Z9A5JdSx?=
 =?iso-8859-1?Q?SoPZkhZYcK0RFx0BYQAn255yBPC5VypRrD4T7YSAWQkNRduFsFqHoevfpO?=
 =?iso-8859-1?Q?pJDVR7Bf666xGrjTeWjYgHqDCNteRGvXsIytjnYvluzO2suLF5lgp9I33f?=
 =?iso-8859-1?Q?Qcfra0yD3Ns6TViYjBAHkIgWBPARLDXVb/QHCW2SCp1pofDENOJFSnQW2d?=
 =?iso-8859-1?Q?G4a2sCAf6cybG8rF19Bib9VelcPElcioom+W6zy1FDLQmyA8QY7UBEKpzu?=
 =?iso-8859-1?Q?kjvS9iIM/0buyZvCx0Lj9bzj/jW8SEF7BiLXbfquT8YfXEYz/LAkmLXcN2?=
 =?iso-8859-1?Q?ELxbCUBdY9eS4Z452GV7BR2M/d79EVzjluwZ+rUtxkoWOY1YG5sb75gkDE?=
 =?iso-8859-1?Q?BjNcWhldlN6+YzA+kn31xR5FTVq6jPyylDHyNi8BrDYyK6yR4SMwH+fQNK?=
 =?iso-8859-1?Q?r74XidEw0hf8qiYoxA3uV6AYBsxBP2gW6qaUlx5Wf8YVVMRHzV4OHbqKJi?=
 =?iso-8859-1?Q?JGzvVBgLrWsvxEUebDF/FEpYzV5bSmn+oonJJstSwCSIByW+RJ8iGlZKzr?=
 =?iso-8859-1?Q?S+OuOTJC6nEg6g4R6GGCw19qhvuSDFV0rnyXNPBvX+UtDOzNt4RkZT1vIG?=
 =?iso-8859-1?Q?0VzXMLQ/DDEpo2dAhMkejtDSNImwCzXcFLlzmW69bTq0VTGWtL3DE2WHix?=
 =?iso-8859-1?Q?9Com838aYQaScJuYIU0zFqw=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5011.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3975c02e-9920-4203-09c5-08d896acf893
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2020 10:28:12.0906
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zxAIajUF5vPbWzS4jOPxkNltBzAyJj1x0KasTBPLbPtvECPKLsGIyA+RAdcOYFxREfcVEp44pRMd3PBMIXHouBtxuWb/XcF64iMGFv8IuiY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4422
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-02_04:2020-11-30,2020-12-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 mlxscore=0 clxscore=1011 priorityscore=1501 malwarescore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 suspectscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012020061
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello Stephan,=0A=
=0A=
MPU-6880 is similar to MPU-6500. It should share the same registers map as =
far as I know.=0A=
=0A=
Seems good to me. Please also update Kconfig to add MPU6880 in the list for=
 I2C and for SPI.=0A=
=0A=
Thanks for the patch,=0A=
JB=0A=
=0A=
From: Stephan Gerhold <stephan@gerhold.net>=0A=
Sent: Wednesday, December 2, 2020 11:13=0A=
To: Jonathan Cameron <jic23@kernel.org>=0A=
Cc: Lars-Peter Clausen <lars@metafoo.de>; Peter Meerwald-Stadler <pmeerw@pm=
eerw.net>; Rob Herring <robh+dt@kernel.org>; linux-iio@vger.kernel.org <lin=
ux-iio@vger.kernel.org>; devicetree@vger.kernel.org <devicetree@vger.kernel=
.org>; Jean-Baptiste Maneyrol <JManeyrol@invensense.com>; Stephan Gerhold <=
stephan@gerhold.net>=0A=
Subject: [PATCH 2/2] iio: imu: inv_mpu6050: Add support for MPU-6880 =0A=
=A0=0A=
=A0CAUTION: This email originated from outside of the organization. Please =
make sure the sender is who they say they are and do not click links or ope=
n attachments unless you recognize the sender and know the content is safe.=
=0A=
=0A=
MPU-6880 seems to be very similar to MPU-6500 / MPU-6050 and it works=0A=
fine with some minor additions for the mpu6050 driver.=0A=
=0A=
Add the necessary defines for it and make it use the same registers as=0A=
MPU-6500 but with a FIFO size of 4096.=0A=
=0A=
Cc: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>=0A=
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>=0A=
---=0A=
I tested this on a Xiaomi Redmi 2 (or Wingtech WT88047).=0A=
=0A=
Unfortunately I was not able to find a proper register description=0A=
for MPU-6880. :( It seems to work fine with both 6050 or 6500 registers=0A=
but I guess that it is more similar to MPU-6500. Not sure though.=0A=
=0A=
I'm mainly unsure about=0A=
=A0=A0=A0=A0=A0=A0=A0 .accl_offset=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D INV=
_MPU6500_REG_ACCEL_OFFSET,=0A=
vs=0A=
=A0=A0=A0=A0=A0=A0=A0 .accl_offset=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D INV=
_MPU6050_REG_ACCEL_OFFSET,=0A=
=0A=
Both registers read some funny values but I cannot say which one=0A=
is more appropriate...=0A=
=0A=
Perhaps Jean-Baptiste can shed some light on this? :)=0A=
---=0A=
=A0drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 9 +++++++++=0A=
=A0drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c=A0 | 5 +++++=0A=
=A0drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h=A0 | 2 ++=0A=
=A0drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c=A0 | 5 +++++=0A=
=A04 files changed, 21 insertions(+)=0A=
=0A=
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
