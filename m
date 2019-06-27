Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5820E5834D
	for <lists+linux-iio@lfdr.de>; Thu, 27 Jun 2019 15:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbfF0NTa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 27 Jun 2019 09:19:30 -0400
Received: from mx0b-00328301.pphosted.com ([148.163.141.47]:49904 "EHLO
        mx0b-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726059AbfF0NTa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 27 Jun 2019 09:19:30 -0400
X-Greylist: delayed 642 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Jun 2019 09:19:29 EDT
Received: from pps.filterd (m0156136.ppops.net [127.0.0.1])
        by mx0b-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x5RD4wTZ030706;
        Thu, 27 Jun 2019 06:08:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt1;
 bh=UX9epgXNZXkP1B5c0zZWJjXWZesi4xmNKUf1SR8jbiM=;
 b=a+FlzDLs3/8xSa1eUevSg1pvARJFisTWOwEteDg0dTl+k8fJP3l3a1a5yQPwgNwd8RzE
 OuFOsi5iXmQnjiioT5FHivk0qGIT7UrsBLHUOWehAUaB1oSrc35+EAGfajp6iXdabssF
 iXMOcjp1uuZtV3dWMub67/jsZ89TsBCVdg+Nxv/l+J53ggzBVc1zwO2TnH3DUEh0Qbm/
 nmojUUHJnfIS0MWaFjpx6Rw/7swd2kxq546pe914HNR3HZdPmxz2WqiwHb01dLWoHT8a
 6bkceLqzCyOkYrOZ66Z7x3cHbhl8LTqC9Jo4t+A5UX3g1e7gLbeqosPEXNfjarEGHIlV 5w== 
Received: from nam05-co1-obe.outbound.protection.outlook.com (mail-co1nam05lp2059.outbound.protection.outlook.com [104.47.48.59])
        by mx0b-00328301.pphosted.com with ESMTP id 2tcaturf11-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jun 2019 06:08:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector1-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UX9epgXNZXkP1B5c0zZWJjXWZesi4xmNKUf1SR8jbiM=;
 b=ISJNze10cCGMB+mlChtsGEW3Kr0LgjW8CTGqvS0kqOAF2Qy+s0D8xpYgYvfAKWXfpnFelsIfziiPLBHUBmO1ZFe5EohIPmPqdQc4ZxqWA5bKSeg6drNMHGEf0NfX7ZOH22H8Y+uWZq3+izk8BPgzecZerdBPLFgl+mSnN0h8HRE=
Received: from MN2PR12MB3373.namprd12.prod.outlook.com (20.178.242.33) by
 MN2PR12MB2957.namprd12.prod.outlook.com (20.179.82.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Thu, 27 Jun 2019 13:08:40 +0000
Received: from MN2PR12MB3373.namprd12.prod.outlook.com
 ([fe80::f5e0:d455:c8e0:4c13]) by MN2PR12MB3373.namprd12.prod.outlook.com
 ([fe80::f5e0:d455:c8e0:4c13%5]) with mapi id 15.20.2008.017; Thu, 27 Jun 2019
 13:08:40 +0000
From:   Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To:     Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: imu: mpu6050: add available scan masks
Thread-Topic: [PATCH] iio: imu: mpu6050: add available scan masks
Thread-Index: AQHVKp0iTnMyK6ou20uFDeztak7OlaauV74AgAEjrJE=
Date:   Thu, 27 Jun 2019 13:08:39 +0000
Message-ID: <MN2PR12MB3373FC5335BFD33AC06CAA04C4FD0@MN2PR12MB3373.namprd12.prod.outlook.com>
References: <20190624145651.24320-1-jmaneyrol@invensense.com>,<20190626203644.43a100c3@archlinux>
In-Reply-To: <20190626203644.43a100c3@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [77.157.193.39]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6f40ee83-bd14-410b-5c8b-08d6fb0092d9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR12MB2957;
x-ms-traffictypediagnostic: MN2PR12MB2957:
x-microsoft-antispam-prvs: <MN2PR12MB29579BD42FA88E7B73DD7624C4FD0@MN2PR12MB2957.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 008184426E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(39850400004)(136003)(366004)(189003)(199004)(8676002)(4326008)(229853002)(6916009)(25786009)(76176011)(6116002)(3846002)(99286004)(80792005)(316002)(7696005)(53936002)(5660300002)(66946007)(66446008)(305945005)(55016002)(6436002)(73956011)(52536014)(81166006)(81156014)(9686003)(2906002)(91956017)(76116006)(8936002)(74316002)(66476007)(64756008)(66556008)(7736002)(72206003)(14454004)(66066001)(86362001)(6246003)(53546011)(102836004)(6506007)(186003)(26005)(33656002)(256004)(5024004)(478600001)(11346002)(68736007)(476003)(446003)(486006)(71190400001)(71200400001)(131093003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB2957;H:MN2PR12MB3373.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ai2Hgmxkxk0padeW1UZejdYcX6DYdjxTWISgsu7jeq65PKmVPzmJAMLdj/p/vN29Jt1ZTrBh8zj6A8r4EcNlbPcwwp2l1ntfBhfaGUVH+zvuXE3paDPixIeNp9gbmDjZpbY7NDnhmXfjXM397763pcYNnyFOBdqD7cT9u/J1fWMW86zarORZeboKiadB2IerPlZ62awfg2eLAVGZdN8jgLiFTt6rVHxmfwZP//wyotP8ElrSMZ1Jp8jA1qwsnLAKDS3VdunmELAAQqKlPYjwEfMVsAb4QDeFVbvHrQFAFEU5AqVTOQapmxXVooKCPyMQJCGsFXr2bJFCsY2sX4aTX3PY6/7oQLJxV7HY0P3Vq9LzF3LWYHfz95SjYz7Z8jSjLrbPvtxe/xTWxJec0AZG+omtfz0pLFua+DTfF/CpsPk=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f40ee83-bd14-410b-5c8b-08d6fb0092d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2019 13:08:39.9325
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JManeyrol@invensense.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2957
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-06-27_07:2019-06-25,2019-06-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 clxscore=1011 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1904300001 definitions=main-1906270153
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,=0A=
=0A=
this is indeed a fix. Without it you cannot have a single axis buffer confi=
guration working, or a buffer without temp for icm20602.=0A=
Since 3-axis configuration is always used, it was not spotted before. The m=
ain issue is for icm20602 where it is making gyro only configuration a mess=
, mixing temp and gyro data together.=0A=
=0A=
I am sending a new patch more readable (using the scan defines rather than =
a constant for the masks) and add a fixes tag referring to the icm20602 fif=
o support.=0A=
=0A=
Best regards,=0A=
JB=0A=
=0A=
From: linux-iio-owner@vger.kernel.org <linux-iio-owner@vger.kernel.org> on =
behalf of Jonathan Cameron <jic23@jic23.retrosnub.co.uk>=0A=
=0A=
Sent: Wednesday, June 26, 2019 21:36=0A=
=0A=
To: Jean-Baptiste Maneyrol=0A=
=0A=
Cc: linux-iio@vger.kernel.org=0A=
=0A=
Subject: Re: [PATCH] iio: imu: mpu6050: add available scan masks=0A=
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
On Mon, 24 Jun 2019 14:57:24 +0000=0A=
=0A=
Jean-Baptiste Maneyrol <JManeyrol@invensense.com> wrote:=0A=
=0A=
=0A=
=0A=
> Only allow 3-axis gyro and/or 3-axis accel.=0A=
=0A=
> For icm20602, temp data is mandatory for all conf.=0A=
=0A=
> =0A=
=0A=
> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>=0A=
=0A=
Hi Jean-Baptiste,=0A=
=0A=
=0A=
=0A=
Is this policy or a hardware requirement, and hence a fix for=0A=
=0A=
the driver?=A0 If it's a fix, please make that clearer and add=0A=
=0A=
a fixes tag.=0A=
=0A=
=0A=
=0A=
Thanks,=0A=
=0A=
=0A=
=0A=
Jonathan=0A=
=0A=
=0A=
=0A=
> ---=0A=
=0A=
>=A0 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 16 ++++++++++++++++=0A=
=0A=
>=A0 1 file changed, 16 insertions(+)=0A=
=0A=
> =0A=
=0A=
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu=
/inv_mpu6050/inv_mpu_core.c=0A=
=0A=
> index 385f14a4d5a7..bfd6d093e54d 100644=0A=
=0A=
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c=0A=
=0A=
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c=0A=
=0A=
> @@ -851,6 +851,13 @@ static const struct iio_chan_spec inv_mpu_channels[]=
 =3D {=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 INV_MPU6050_CHAN(IIO_ACCEL, IIO_MOD_Z, INV_MPU6050_S=
CAN_ACCL_Z),=0A=
=0A=
>=A0 };=0A=
=0A=
>=A0 =0A=
=0A=
> +static const unsigned long inv_mpu_scan_masks[] =3D {=0A=
=0A=
> +=A0=A0=A0=A0 0x07,=A0=A0 /* 3-axis accel */=0A=
=0A=
> +=A0=A0=A0=A0 0x38,=A0=A0 /* 3-axis gyro */=0A=
=0A=
> +=A0=A0=A0=A0 0x3F,=A0=A0 /* 6-axis accel + gyro */=0A=
=0A=
> +=A0=A0=A0=A0 0,=0A=
=0A=
> +};=0A=
=0A=
> +=0A=
=0A=
>=A0 static const struct iio_chan_spec inv_icm20602_channels[] =3D {=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 IIO_CHAN_SOFT_TIMESTAMP(INV_ICM20602_SCAN_TIMESTAMP)=
,=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 {=0A=
=0A=
> @@ -877,6 +884,13 @@ static const struct iio_chan_spec inv_icm20602_chann=
els[] =3D {=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 INV_MPU6050_CHAN(IIO_ACCEL, IIO_MOD_Z, INV_ICM20602_=
SCAN_ACCL_Z),=0A=
=0A=
>=A0 };=0A=
=0A=
>=A0 =0A=
=0A=
> +static const unsigned long inv_icm20602_scan_masks[] =3D {=0A=
=0A=
> +=A0=A0=A0=A0 0x0F,=A0=A0 /* 3-axis accel + temp (mandatory) */=0A=
=0A=
> +=A0=A0=A0=A0 0x78,=A0=A0 /* 3-axis gyro + temp (mandatory) */=0A=
=0A=
> +=A0=A0=A0=A0 0x7F,=A0=A0 /* 6-axis accel + gyro + temp (mandatory) */=0A=
=0A=
> +=A0=A0=A0=A0 0,=0A=
=0A=
> +};=0A=
=0A=
> +=0A=
=0A=
>=A0 /*=0A=
=0A=
>=A0=A0 * The user can choose any frequency between INV_MPU6050_MIN_FIFO_RA=
TE and=0A=
=0A=
>=A0=A0 * INV_MPU6050_MAX_FIFO_RATE, but only these frequencies are matched=
 by the=0A=
=0A=
> @@ -1136,9 +1150,11 @@ int inv_mpu_core_probe(struct regmap *regmap, int =
irq, const char *name,=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 if (chip_type =3D=3D INV_ICM20602) {=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 indio_dev->channels =3D inv_=
icm20602_channels;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 indio_dev->num_channels =3D =
ARRAY_SIZE(inv_icm20602_channels);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 indio_dev->available_scan_masks =3D=
 inv_icm20602_scan_masks;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 } else {=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 indio_dev->channels =3D inv_=
mpu_channels;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 indio_dev->num_channels =3D =
ARRAY_SIZE(inv_mpu_channels);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 indio_dev->available_scan_masks =3D=
 inv_mpu_scan_masks;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 }=0A=
=0A=
>=A0 =0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 indio_dev->info =3D &mpu_info;=0A=
=0A=
=0A=
=0A=
