Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A87BBADCEF
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2019 18:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387912AbfIIQSw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Sep 2019 12:18:52 -0400
Received: from mx0a-00328301.pphosted.com ([148.163.145.46]:46598 "EHLO
        mx0a-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725268AbfIIQSv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 9 Sep 2019 12:18:51 -0400
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x89GGcX4029022;
        Mon, 9 Sep 2019 09:18:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt1;
 bh=jG49KPSB3nikHNmxtGprKnpo9lc/l7deVKZbr+xy7W0=;
 b=C3jz4m3UOhmeiNoj2aQoNCjXGJ3CpJh5/rvfxjpTb623FsFvNeDbe10vmAW5ahjo93eH
 7vac5ao54gSLHYhEZsvsXFNjBWxlwqYBHl76Mn2uAUnl/vJuG87Exr8VTbUZtlevFQ8M
 5tzlfJQOkptU+HaTJqbe9qNkWiE9xsp/INuICi0+sJFJfiT+U+BYJLcT4iVVi8MVGzen
 TXdVCT9DyAf4+S+FbnGI8HSYf3VUVwFF3Udd3bYHUXFuAMUHqqjzDhscIw/6suxEeu6U
 GWPuuWidXiYrmuDDKx17vnfSoDxVsOV1uPk7RYSC6jkL+7Gji623pkGUwRSwl7kllAnt vw== 
Received: from nam05-co1-obe.outbound.protection.outlook.com (mail-co1nam05lp2055.outbound.protection.outlook.com [104.47.48.55])
        by mx0a-00328301.pphosted.com with ESMTP id 2uwrvdg166-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Sep 2019 09:18:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gluDeDodjZUIZbJeWwwvG543n5jYpxkAFb0Yt3/X4fiYlt4fTcsMaMzJ3tNguDUlTXrqLn/rYRNoZTkInbJmEa5otDVxJ4CNemNbgoyizvEmk18z+n8XTiw9Y/aqhLr7gkAxZRn5dZy1n/P7CxmVFxyeegXvqq5+AWmw4QW/Gp1X6MdBnb/BKGsujCrdv5KgrXARjUGRLBh6LSStOIzqkJ9q9gA0NxE5wZQgQmWVpn/OxhEvEJtrBzaZ5EJ64M81X9lhbIYc3ykq5k7e85rYvj7l57E1ayd+PZfy6nRfIDfPeph/nqe1CHByX6ja374b6W+TK1Xgii4DTMHQDNSLdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jG49KPSB3nikHNmxtGprKnpo9lc/l7deVKZbr+xy7W0=;
 b=AVpCXzlM3PDJs6xJ+rqyrKEtkUnxCz97VwDBUHvrIAdq5m2UvPX2nleZQbFu7sGPUZXac+tWF1sXkHGe7NCqM6T80OIxuK9h3qiocfxJ0tmFm31igQYuIKVmKKmOtaaU7j+3lv4fJivCY3dIizIu0XT2xGGIbuqNYxohCaMr/PfQ+DKN2rU2P4/NoWfa+1IGP1x5BPf8Nb1xybqYeBjkh3aRhX7GxOqz5IgzXkDL+DS/zDu5kLbaiC9ZmeaVNkxbq/3dZQVWgJwNq8QtsREVxgZzTGJkM3GdRjmrGAfrcXuoV/2qbP2ErXaP/hahvJfzueoM0I49FNLzPbtgbLHOAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jG49KPSB3nikHNmxtGprKnpo9lc/l7deVKZbr+xy7W0=;
 b=TTmEfpSO1jyiaeHerqLMyrXgxSZmqJurjijAfmLiURkkELQzz/s5yaJhHtIgt/t89nxESJYQRWEM1RsCddznd8QSLMwZs71KdzmetFTV29fk5PlqvhwO3r68aioFhtlC1C3W/JyP4diRxthG8BKa9zUBBnzFAa72BPqryJDmMew=
Received: from MN2PR12MB3373.namprd12.prod.outlook.com (20.178.242.33) by
 MN2PR12MB3405.namprd12.prod.outlook.com (20.178.242.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.15; Mon, 9 Sep 2019 16:18:42 +0000
Received: from MN2PR12MB3373.namprd12.prod.outlook.com
 ([fe80::256d:7ef4:1570:a166]) by MN2PR12MB3373.namprd12.prod.outlook.com
 ([fe80::256d:7ef4:1570:a166%5]) with mapi id 15.20.2241.018; Mon, 9 Sep 2019
 16:18:42 +0000
From:   Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 7/8] iio: imu: inv_mpu6050: add magnetometer support
 inside mpu driver
Thread-Topic: [PATCH 7/8] iio: imu: inv_mpu6050: add magnetometer support
 inside mpu driver
Thread-Index: AQHVXn0MYpJzl4x+WUecu/G2bHQLj6chvn8AgAHYNQ0=
Date:   Mon, 9 Sep 2019 16:18:42 +0000
Message-ID: <MN2PR12MB3373FED95C2F2CC6F9795634C4B70@MN2PR12MB3373.namprd12.prod.outlook.com>
References: <20190829151801.13014-1-jmaneyrol@invensense.com>
        <20190829151801.13014-8-jmaneyrol@invensense.com>,<20190908130542.523c363b@archlinux>
In-Reply-To: <20190908130542.523c363b@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [77.157.193.39]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 67a736db-0525-49a6-ace3-08d7354161ba
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR12MB3405;
x-ms-traffictypediagnostic: MN2PR12MB3405:
x-microsoft-antispam-prvs: <MN2PR12MB34055E459BAD4287A1D41BC3C4B70@MN2PR12MB3405.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01559F388D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(136003)(39850400004)(396003)(346002)(199004)(51914003)(189003)(8676002)(5660300002)(81156014)(316002)(6436002)(6916009)(8936002)(74316002)(7736002)(76116006)(6116002)(3846002)(66446008)(66946007)(7696005)(71200400001)(486006)(25786009)(66066001)(229853002)(30864003)(66476007)(71190400001)(256004)(5024004)(14444005)(476003)(446003)(11346002)(52536014)(80792005)(4326008)(186003)(26005)(478600001)(33656002)(53946003)(91956017)(66556008)(64756008)(53546011)(6506007)(99286004)(305945005)(9686003)(55016002)(14454004)(2906002)(86362001)(81166006)(102836004)(6246003)(53936002)(76176011)(579004);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB3405;H:MN2PR12MB3373.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ScL/rrodYwcT0srvTdCMnG0gh05OGTcrykQG4k/Ix/1zBOm+euOyPuSoNn/pyo1uehxlnyIF80W4+2JWdekOcm6PG6wad2Mlmtp8ovfLlJ6/Wm9Wjxe0r8pvqSBXcxo+7jQk83kV9/RhPwW/NK1lI4t+32y6yxILhAprOR95Rsd+nMrnhaqjfHOQncUbjU+QBwt1gxwha/6neGuyt9Ny4noMKNKdFERFHLfHOwKS9mW/gVxbmUfPIwOSq1zvTAx/1gqCPpM5QiJU/chGnSYg+34RE8st3NwagazM3FcwvqjE8BIj3Kq21tSwz2Dw/JO4F6m/qsZnc4jmW6gq4qx7iC07o7hkVqHkcXUXaUSHwZI9OsDIuuTEdc95+sHq0TcwaEUOs1eRWETaxxbpDsT3HSO4ZpeD42K55fxIhLWsWv0=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67a736db-0525-49a6-ace3-08d7354161ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2019 16:18:42.3505
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6xKjp+6aoby/JkD/w9Q2wDCN5o+wh8vx/vzxo4MKKgfj9nWllFJ41l6MLd6tXLHvlMY/DRLR92ip5nSU4SfzloJTPPQfxf6wh1M7+TAqA4U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3405
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-09_07:2019-09-09,2019-09-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 mlxlogscore=999 malwarescore=0
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1909090164
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,=0A=
=0A=
I think this one is effectively a little overdoing it. The idea is to add i=
n the future support of other 9-axis chips=0A=
=0A=
But let's try to be simple first. I will merge the inv_mpu9250_magn and inv=
_mpu_magn together in the v2 series.=0A=
=0A=
Thanks for the feedback.=0A=
JB=0A=
=0A=
=0A=
From: Jonathan Cameron <jic23@kernel.org>=0A=
=0A=
Sent: Sunday, September 8, 2019 14:05=0A=
=0A=
To: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>=0A=
=0A=
Cc: linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>=0A=
=0A=
Subject: Re: [PATCH 7/8] iio: imu: inv_mpu6050: add magnetometer support in=
side mpu driver=0A=
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
On Thu, 29 Aug 2019 15:18:45 +0000=0A=
=0A=
Jean-Baptiste Maneyrol <JManeyrol@invensense.com> wrote:=0A=
=0A=
=0A=
=0A=
> Add inv_mpu_magn layer to manage several chip specific=0A=
=0A=
> implementations and be noop when Kconfig option is not set.=0A=
=0A=
> =0A=
=0A=
> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>=0A=
=0A=
=0A=
=0A=
A few minor bits inline.=0A=
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
>=A0 drivers/iio/imu/inv_mpu6050/Makefile=A0=A0=A0=A0=A0=A0 |=A0=A0 3 +-=0A=
=0A=
>=A0 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 140 ++++++++++++++++++++-=
=0A=
=0A=
>=A0 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h=A0 |=A0=A0 2 +=0A=
=0A=
>=A0 drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c | 120 ++++++++++++++++++=0A=
=0A=
>=A0 drivers/iio/imu/inv_mpu6050/inv_mpu_magn.h | 107 ++++++++++++++++=0A=
=0A=
>=A0 5 files changed, 368 insertions(+), 4 deletions(-)=0A=
=0A=
>=A0 create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c=0A=
=0A=
>=A0 create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_magn.h=0A=
=0A=
> =0A=
=0A=
> diff --git a/drivers/iio/imu/inv_mpu6050/Makefile b/drivers/iio/imu/inv_m=
pu6050/Makefile=0A=
=0A=
> index fee41415ebdb..6f5baac29f81 100644=0A=
=0A=
> --- a/drivers/iio/imu/inv_mpu6050/Makefile=0A=
=0A=
> +++ b/drivers/iio/imu/inv_mpu6050/Makefile=0A=
=0A=
> @@ -5,7 +5,8 @@=0A=
=0A=
>=A0 =0A=
=0A=
>=A0 obj-$(CONFIG_INV_MPU6050_IIO) +=3D inv-mpu6050.o=0A=
=0A=
>=A0 inv-mpu6050-y :=3D inv_mpu_core.o inv_mpu_ring.o inv_mpu_trigger.o=0A=
=0A=
> -inv-mpu6050-$(CONFIG_INV_MPU6050_MAGN) +=3D inv_mpu_aux.o inv_mpu9250_ma=
gn.o=0A=
=0A=
> +inv-mpu6050-$(CONFIG_INV_MPU6050_MAGN) +=3D inv_mpu_aux.o inv_mpu_magn.o=
 \=0A=
=0A=
> +=A0=A0=A0=A0 inv_mpu9250_magn.o=0A=
=0A=
>=A0 =0A=
=0A=
>=A0 obj-$(CONFIG_INV_MPU6050_I2C) +=3D inv-mpu6050-i2c.o=0A=
=0A=
>=A0 inv-mpu6050-i2c-y :=3D inv_mpu_i2c.o inv_mpu_acpi.o=0A=
=0A=
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu=
/inv_mpu6050/inv_mpu_core.c=0A=
=0A=
> index b17f060b52fc..d08cec6a8a7a 100644=0A=
=0A=
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c=0A=
=0A=
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c=0A=
=0A=
> @@ -16,7 +16,9 @@=0A=
=0A=
>=A0 #include <linux/acpi.h>=0A=
=0A=
>=A0 #include <linux/platform_device.h>=0A=
=0A=
>=A0 #include <linux/regulator/consumer.h>=0A=
=0A=
> +=0A=
=0A=
>=A0 #include "inv_mpu_iio.h"=0A=
=0A=
> +#include "inv_mpu_magn.h"=0A=
=0A=
>=A0 =0A=
=0A=
>=A0 /*=0A=
=0A=
>=A0=A0 * this is the gyro scale translated from dynamic range plus/minus=
=0A=
=0A=
> @@ -332,6 +334,11 @@ static int inv_mpu6050_init_config(struct iio_dev *i=
ndio_dev)=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0 */=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 st->chip_period =3D NSEC_PER_MSEC;=0A=
=0A=
>=A0 =0A=
=0A=
> +=A0=A0=A0=A0 /* magn chip init, noop if not present in the chip */=0A=
=0A=
> +=A0=A0=A0=A0 result =3D inv_mpu_magn_probe(st);=0A=
=0A=
> +=A0=A0=A0=A0 if (result)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto error_power_off;=0A=
=0A=
> +=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 return inv_mpu6050_set_power_itg(st, false);=0A=
=0A=
>=A0 =0A=
=0A=
>=A0 error_power_off:=0A=
=0A=
> @@ -411,6 +418,9 @@ static int inv_mpu6050_read_channel_data(struct iio_d=
ev *indio_dev,=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D inv_mpu6050_sensor_s=
how(st, st->reg->temperature,=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 IIO_MOD_X, =
val);=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
=0A=
> +=A0=A0=A0=A0 case IIO_MAGN:=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D inv_mpu_magn_read(st, chan-=
>channel2, val);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 default:=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D -EINVAL;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
=0A=
> @@ -469,6 +479,8 @@ inv_mpu6050_read_raw(struct iio_dev *indio_dev,=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 *val2 =3D INV_MPU6050_TEMP_SCALE;=0A=
=0A=
>=A0 =0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 retu=
rn IIO_VAL_INT_PLUS_MICRO;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 case IIO_MAGN:=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return inv_=
mpu_magn_get_scale(st, chan, val, val2);=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 default:=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 retu=
rn -EINVAL;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
=0A=
> @@ -710,6 +722,11 @@ inv_mpu6050_fifo_rate_store(struct device *dev, stru=
ct device_attribute *attr,=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 if (result)=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto fifo_rate_fail_power_of=
f;=0A=
=0A=
>=A0 =0A=
=0A=
> +=A0=A0=A0=A0 /* update rate for magn, noop if not present in chip */=0A=
=0A=
> +=A0=A0=A0=A0 result =3D inv_mpu_magn_set_rate(st, fifo_rate);=0A=
=0A=
> +=A0=A0=A0=A0 if (result)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto fifo_rate_fail_power_off;=0A=
=0A=
> +=0A=
=0A=
>=A0 fifo_rate_fail_power_off:=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 result |=3D inv_mpu6050_set_power_itg(st, false);=0A=
=0A=
>=A0 fifo_rate_fail_unlock:=0A=
=0A=
> @@ -795,8 +812,13 @@ inv_get_mount_matrix(const struct iio_dev *indio_dev=
,=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 const struct =
iio_chan_spec *chan)=0A=
=0A=
>=A0 {=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 struct inv_mpu6050_state *data =3D iio_priv(indio_de=
v);=0A=
=0A=
> +=A0=A0=A0=A0 const struct iio_mount_matrix *matrix =3D &data->orientatio=
n;=0A=
=0A=
>=A0 =0A=
=0A=
> -=A0=A0=A0=A0 return &data->orientation;=0A=
=0A=
> +#ifdef CONFIG_INV_MPU6050_MAGN=0A=
=0A=
> +=A0=A0=A0=A0 if (chan->type =3D=3D IIO_MAGN)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 matrix =3D &data->magn_orient;=0A=
=0A=
> +#endif=0A=
=0A=
> +=A0=A0=A0=A0 return matrix;=0A=
=0A=
>=A0 }=0A=
=0A=
>=A0 =0A=
=0A=
>=A0 static const struct iio_chan_spec_ext_info inv_ext_info[] =3D {=0A=
=0A=
> @@ -864,6 +886,102 @@ static const unsigned long inv_mpu_scan_masks[] =3D=
 {=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 0,=0A=
=0A=
>=A0 };=0A=
=0A=
>=A0 =0A=
=0A=
> +#ifdef CONFIG_INV_MPU6050_MAGN=0A=
=0A=
> +=0A=
=0A=
> +#define INV_MPU9X50_MAGN_CHAN(_chan2, _bits, _index)=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
=0A=
> +=A0=A0=A0=A0 {=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .type =3D IIO_MAGN,=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .modified =3D 1,=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .channel2 =3D _chan2,=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 \=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .info_mask_separate =3D BIT(IIO_CHA=
N_INFO_SCALE) |=A0=A0=A0=A0=A0=A0=A0 \=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 BIT(IIO_CHAN_INFO_RAW),=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 \=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .scan_index =3D _index,=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 \=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .scan_type =3D {=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .sign =3D '=
s',=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .realbits =
=3D _bits,=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .storagebit=
s =3D 16,=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 \=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .shift =3D =
0,=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .endianness=
 =3D IIO_BE,=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 \=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 },=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .ext_info =3D inv_ext_info,=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 \=0A=
=0A=
> +=A0=A0=A0=A0 }=0A=
=0A=
> +=0A=
=0A=
> +static const struct iio_chan_spec inv_mpu9250_channels[] =3D {=0A=
=0A=
> +=A0=A0=A0=A0 IIO_CHAN_SOFT_TIMESTAMP(INV_MPU9X50_SCAN_TIMESTAMP),=0A=
=0A=
> +=A0=A0=A0=A0 /*=0A=
=0A=
> +=A0=A0=A0=A0=A0 * Note that temperature should only be via polled readin=
g only,=0A=
=0A=
> +=A0=A0=A0=A0=A0 * not the final scan elements output.=0A=
=0A=
> +=A0=A0=A0=A0=A0 */=0A=
=0A=
> +=A0=A0=A0=A0 {=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .type =3D IIO_TEMP,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .info_mask_separate =3D BIT(IIO_CHA=
N_INFO_RAW)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 | BIT(IIO_CHAN_INFO_OFFSET)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 | BIT(IIO_CHAN_INFO_SCALE),=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .scan_index =3D -1,=0A=
=0A=
> +=A0=A0=A0=A0 },=0A=
=0A=
> +=A0=A0=A0=A0 INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_X, INV_MPU9X50_SCAN_=
GYRO_X),=0A=
=0A=
> +=A0=A0=A0=A0 INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_Y, INV_MPU9X50_SCAN_=
GYRO_Y),=0A=
=0A=
> +=A0=A0=A0=A0 INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_Z, INV_MPU9X50_SCAN_=
GYRO_Z),=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 INV_MPU6050_CHAN(IIO_ACCEL, IIO_MOD_X, INV_MPU9X50_SCAN_ACC=
L_X),=0A=
=0A=
> +=A0=A0=A0=A0 INV_MPU6050_CHAN(IIO_ACCEL, IIO_MOD_Y, INV_MPU9X50_SCAN_ACC=
L_Y),=0A=
=0A=
> +=A0=A0=A0=A0 INV_MPU6050_CHAN(IIO_ACCEL, IIO_MOD_Z, INV_MPU9X50_SCAN_ACC=
L_Z),=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 /* Magnetometer resolution is 16 bits */=0A=
=0A=
> +=A0=A0=A0=A0 INV_MPU9X50_MAGN_CHAN(IIO_MOD_X, 16, INV_MPU9X50_SCAN_MAGN_=
X),=0A=
=0A=
> +=A0=A0=A0=A0 INV_MPU9X50_MAGN_CHAN(IIO_MOD_Y, 16, INV_MPU9X50_SCAN_MAGN_=
Y),=0A=
=0A=
> +=A0=A0=A0=A0 INV_MPU9X50_MAGN_CHAN(IIO_MOD_Z, 16, INV_MPU9X50_SCAN_MAGN_=
Z),=0A=
=0A=
> +};=0A=
=0A=
> +=0A=
=0A=
> +static const unsigned long inv_mpu9x50_scan_masks[] =3D {=0A=
=0A=
> +=A0=A0=A0=A0 /* 3-axis accel */=0A=
=0A=
> +=A0=A0=A0=A0 BIT(INV_MPU9X50_SCAN_ACCL_X)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU9X50_SCAN_ACCL_Y)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU9X50_SCAN_ACCL_Z),=0A=
=0A=
> +=A0=A0=A0=A0 /* 3-axis gyro */=0A=
=0A=
> +=A0=A0=A0=A0 BIT(INV_MPU9X50_SCAN_GYRO_X)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU9X50_SCAN_GYRO_Y)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU9X50_SCAN_GYRO_Z),=0A=
=0A=
> +=A0=A0=A0=A0 /* 3-axis magn */=0A=
=0A=
> +=A0=A0=A0=A0 BIT(INV_MPU9X50_SCAN_MAGN_X)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU9X50_SCAN_MAGN_Y)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU9X50_SCAN_MAGN_Z),=0A=
=0A=
> +=A0=A0=A0=A0 /* 6-axis accel + gyro */=0A=
=0A=
> +=A0=A0=A0=A0 BIT(INV_MPU9X50_SCAN_ACCL_X)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU9X50_SCAN_ACCL_Y)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU9X50_SCAN_ACCL_Z)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU9X50_SCAN_GYRO_X)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU9X50_SCAN_GYRO_Y)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU9X50_SCAN_GYRO_Z),=0A=
=0A=
> +=A0=A0=A0=A0 /* 6-axis accel + magn */=0A=
=0A=
> +=A0=A0=A0=A0 BIT(INV_MPU9X50_SCAN_ACCL_X)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU9X50_SCAN_ACCL_Y)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU9X50_SCAN_ACCL_Z)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU9X50_SCAN_MAGN_X)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU9X50_SCAN_MAGN_Y)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU9X50_SCAN_MAGN_Z),=0A=
=0A=
> +=A0=A0=A0=A0 /* 6-axis gyro + magn */=0A=
=0A=
> +=A0=A0=A0=A0 BIT(INV_MPU9X50_SCAN_GYRO_X)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU9X50_SCAN_GYRO_Y)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU9X50_SCAN_GYRO_Z)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU9X50_SCAN_MAGN_X)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU9X50_SCAN_MAGN_Y)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU9X50_SCAN_MAGN_Z),=0A=
=0A=
> +=A0=A0=A0=A0 /* 9-axis accel + gyro + magn */=0A=
=0A=
> +=A0=A0=A0=A0 BIT(INV_MPU9X50_SCAN_ACCL_X)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU9X50_SCAN_ACCL_Y)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU9X50_SCAN_ACCL_Z)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU9X50_SCAN_GYRO_X)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU9X50_SCAN_GYRO_Y)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU9X50_SCAN_GYRO_Z)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU9X50_SCAN_MAGN_X)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU9X50_SCAN_MAGN_Y)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | BIT(INV_MPU9X50_SCAN_MAGN_Z),=0A=
=0A=
> +=A0=A0=A0=A0 0,=0A=
=0A=
> +};=0A=
=0A=
> +=0A=
=0A=
> +#endif=0A=
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
> @@ -1145,6 +1263,11 @@ int inv_mpu_core_probe(struct regmap *regmap, int =
irq, const char *name,=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return result;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 }=0A=
=0A=
>=A0 =0A=
=0A=
> +=A0=A0=A0=A0 /* fill magnetometer orientation */=0A=
=0A=
> +=A0=A0=A0=A0 result =3D inv_mpu_magn_set_orient(st);=0A=
=0A=
> +=A0=A0=A0=A0 if (result)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return result;=0A=
=0A=
> +=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 /* power is turned on inside check chip type*/=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 result =3D inv_check_and_setup_chip(st);=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 if (result)=0A=
=0A=
> @@ -1167,14 +1290,25 @@ int inv_mpu_core_probe(struct regmap *regmap, int=
 irq, const char *name,=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 else=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 indio_dev->name =3D dev_name=
(dev);=0A=
=0A=
>=A0 =0A=
=0A=
> -=A0=A0=A0=A0 if (chip_type =3D=3D INV_ICM20602) {=0A=
=0A=
> +=A0=A0=A0=A0 switch (chip_type) {=0A=
=0A=
> +#ifdef CONFIG_INV_MPU6050_MAGN=0A=
=0A=
> +=A0=A0=A0=A0 case INV_MPU9250:=0A=
=0A=
> +=A0=A0=A0=A0 case INV_MPU9255:=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 indio_dev->channels =3D inv_mpu9250=
_channels;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 indio_dev->num_channels =3D ARRAY_S=
IZE(inv_mpu9250_channels);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 indio_dev->available_scan_masks =3D=
 inv_mpu9x50_scan_masks;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
=0A=
> +#endif=0A=
=0A=
> +=A0=A0=A0=A0 case INV_ICM20602:=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 indio_dev->channels =3D inv_=
icm20602_channels;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 indio_dev->num_channels =3D =
ARRAY_SIZE(inv_icm20602_channels);=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 indio_dev->available_scan_ma=
sks =3D inv_icm20602_scan_masks;=0A=
=0A=
> -=A0=A0=A0=A0 } else {=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
=0A=
> +=A0=A0=A0=A0 default:=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 indio_dev->channels =3D inv_=
mpu_channels;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 indio_dev->num_channels =3D =
ARRAY_SIZE(inv_mpu_channels);=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 indio_dev->available_scan_ma=
sks =3D inv_mpu_scan_masks;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 }=0A=
=0A=
>=A0 =0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 indio_dev->info =3D &mpu_info;=0A=
=0A=
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/=
inv_mpu6050/inv_mpu_iio.h=0A=
=0A=
> index 5b462672bbcb..cfc11cb0a36c 100644=0A=
=0A=
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h=0A=
=0A=
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h=0A=
=0A=
> @@ -130,6 +130,7 @@ struct inv_mpu6050_hw {=0A=
=0A=
>=A0=A0 *=A0 @data_timestamp: timestamp for next data sample.=0A=
=0A=
>=A0=A0 *=A0 @vddio_supply=A0=A0=A0 voltage regulator for the chip.=0A=
=0A=
>=A0=A0 *=A0 @magn_raw_to_gauss:=A0=A0=A0=A0=A0 coefficient to convert mag =
raw value to Gauss.=0A=
=0A=
> + *=A0 @magn_orient:=A0=A0=A0 magnetometer sensor chip orientation if ava=
ilable.=0A=
=0A=
>=A0=A0 */=0A=
=0A=
>=A0 struct inv_mpu6050_state {=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 struct mutex lock;=0A=
=0A=
> @@ -153,6 +154,7 @@ struct inv_mpu6050_state {=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 struct regulator *vddio_supply;=0A=
=0A=
>=A0 #ifdef CONFIG_INV_MPU6050_MAGN=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 s32 magn_raw_to_gauss[3];=0A=
=0A=
> +=A0=A0=A0=A0 struct iio_mount_matrix magn_orient;=0A=
=0A=
>=A0 #endif=0A=
=0A=
>=A0 };=0A=
=0A=
>=A0 =0A=
=0A=
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c b/drivers/iio/imu=
/inv_mpu6050/inv_mpu_magn.c=0A=
=0A=
> new file mode 100644=0A=
=0A=
> index 000000000000..2bb40dae0429=0A=
=0A=
> --- /dev/null=0A=
=0A=
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c=0A=
=0A=
> @@ -0,0 +1,120 @@=0A=
=0A=
> +// SPDX-License-Identifier: GPL-2.0=0A=
=0A=
> +/*=0A=
=0A=
> + * Copyright (C) 2019 TDK-InvenSense, Inc.=0A=
=0A=
> + */=0A=
=0A=
> +=0A=
=0A=
> +#include <linux/kernel.h>=0A=
=0A=
> +#include <linux/device.h>=0A=
=0A=
> +#include <linux/string.h>=0A=
=0A=
> +=0A=
=0A=
> +#include "inv_mpu_iio.h"=0A=
=0A=
> +#include "inv_mpu_aux.h"=0A=
=0A=
> +#include "inv_mpu9250_magn.h"=0A=
=0A=
> +=0A=
=0A=
> +int inv_mpu_magn_probe(struct inv_mpu6050_state *st)=0A=
=0A=
> +{=0A=
=0A=
> +=A0=A0=A0=A0 int ret;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 /* probe and init mag chip */=0A=
=0A=
> +=A0=A0=A0=A0 switch (st->chip_type) {=0A=
=0A=
> +=A0=A0=A0=A0 case INV_MPU9250:=0A=
=0A=
> +=A0=A0=A0=A0 case INV_MPU9255:=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* configure i2c master aux port */=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D inv_mpu_aux_init(st);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return inv_mpu9250_magn_probe(st);=
=0A=
=0A=
> +=A0=A0=A0=A0 default:=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
=0A=
> +=A0=A0=A0=A0 }=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 return 0;=0A=
=0A=
> +}=0A=
=0A=
> +=0A=
=0A=
> +int inv_mpu_magn_set_rate(const struct inv_mpu6050_state *st, int fifo_r=
ate)=0A=
=0A=
> +{=0A=
=0A=
> +=A0=A0=A0=A0 int max_freq;=0A=
=0A=
> +=A0=A0=A0=A0 uint8_t d;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 switch (st->chip_type) {=0A=
=0A=
> +=A0=A0=A0=A0 case INV_MPU9250:=0A=
=0A=
> +=A0=A0=A0=A0 case INV_MPU9255:=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 max_freq =3D INV_MPU9250_MAGN_FREQ_=
HZ_MAX;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
=0A=
> +=A0=A0=A0=A0 default:=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return 0;=0A=
=0A=
> +=A0=A0=A0=A0 }=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 /*=0A=
=0A=
> +=A0=A0=A0=A0=A0 * update i2c master delay to limit mag sampling to max f=
requency=0A=
=0A=
> +=A0=A0=A0=A0=A0 * compute fifo_rate divider d: rate =3D fifo_rate / (d +=
 1)=0A=
=0A=
> +=A0=A0=A0=A0=A0 */=0A=
=0A=
> +=A0=A0=A0=A0 if (fifo_rate > max_freq)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 d =3D fifo_rate / max_freq - 1;=0A=
=0A=
> +=A0=A0=A0=A0 else=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 d =3D 0;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 return regmap_write(st->map, INV_MPU6050_REG_I2C_SLV4_CTRL,=
 d);=0A=
=0A=
> +}=0A=
=0A=
> +=0A=
=0A=
> +int inv_mpu_magn_set_orient(struct inv_mpu6050_state *st)=0A=
=0A=
> +{=0A=
=0A=
> +=A0=A0=A0=A0 const char *orient;=0A=
=0A=
> +=A0=A0=A0=A0 char *str;=0A=
=0A=
> +=A0=A0=A0=A0 int i;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 /* fill magnetometer orientation */=0A=
=0A=
> +=A0=A0=A0=A0 switch (st->chip_type) {=0A=
=0A=
> +=A0=A0=A0=A0 case INV_MPU9250:=0A=
=0A=
> +=A0=A0=A0=A0 case INV_MPU9255:=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* x <- y */=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->magn_orient.rotation[0] =3D st-=
>orientation.rotation[3];=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->magn_orient.rotation[1] =3D st-=
>orientation.rotation[4];=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->magn_orient.rotation[2] =3D st-=
>orientation.rotation[5];=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* y <- x */=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->magn_orient.rotation[3] =3D st-=
>orientation.rotation[0];=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->magn_orient.rotation[4] =3D st-=
>orientation.rotation[1];=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->magn_orient.rotation[5] =3D st-=
>orientation.rotation[2];=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* z <- -z */=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 for (i =3D 0; i < 3; ++i) {=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 orient =3D =
st->orientation.rotation[6 + i];=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* use leng=
th + 2 for adding minus sign if needed */=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 str =3D dev=
m_kzalloc(regmap_get_device(st->map),=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 strlen(orient) + 2, GFP_KERNE=
L);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (str =3D=
=3D NULL)=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 return -ENOMEM;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (strcmp(=
orient, "0") =3D=3D 0) {=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 strcpy(str, orient);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 } else if (=
orient[0] =3D=3D '-') {=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 strcpy(str, &orient[1]);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 } else {=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 str[0] =3D '-';=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 strcpy(&str[1], orient);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->magn_or=
ient.rotation[6 + i] =3D str;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
=0A=
> +=A0=A0=A0=A0 default:=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->magn_orient =3D st->orientation=
;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
=0A=
> +=A0=A0=A0=A0 }=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 return 0;=0A=
=0A=
> +}=0A=
=0A=
> +=0A=
=0A=
> +int inv_mpu_magn_read(const struct inv_mpu6050_state *st, int axis, int =
*val)=0A=
=0A=
> +{=0A=
=0A=
> +=A0=A0=A0=A0 int ret;=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 switch (st->chip_type) {=0A=
=0A=
> +=A0=A0=A0=A0 case INV_MPU9250:=0A=
=0A=
> +=A0=A0=A0=A0 case INV_MPU9255:=0A=
=0A=
=0A=
=0A=
This is a bit paranoid given we can't get anywhere near here if it isn't on=
e of=0A=
=0A=
these devices.=A0 I suppose you might have other magn containing devices to=
 be=0A=
=0A=
supported in the near future?=0A=
=0A=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D inv_mpu9250_magn_read(st, a=
xis, val);=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
=0A=
> +=A0=A0=A0=A0 default:=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D -ENODEV;=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;=0A=
=0A=
> +=A0=A0=A0=A0 }=0A=
=0A=
> +=0A=
=0A=
> +=A0=A0=A0=A0 return ret;=0A=
=0A=
> +}=0A=
=0A=
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.h b/drivers/iio/imu=
/inv_mpu6050/inv_mpu_magn.h=0A=
=0A=
> new file mode 100644=0A=
=0A=
> index 000000000000..efa2ec1b3b2f=0A=
=0A=
> --- /dev/null=0A=
=0A=
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.h=0A=
=0A=
> @@ -0,0 +1,107 @@=0A=
=0A=
> +/* SPDX-License-Identifier: GPL-2.0 */=0A=
=0A=
> +/*=0A=
=0A=
> + * Copyright (C) 2019 TDK-InvenSense, Inc.=0A=
=0A=
> + */=0A=
=0A=
> +=0A=
=0A=
> +#ifndef INV_MPU_MAGN_H_=0A=
=0A=
> +#define INV_MPU_MAGN_H_=0A=
=0A=
> +=0A=
=0A=
> +#include <linux/kernel.h>=0A=
=0A=
> +=0A=
=0A=
> +#include "inv_mpu_iio.h"=0A=
=0A=
> +=0A=
=0A=
> +#ifdef CONFIG_INV_MPU6050_MAGN=0A=
=0A=
> +=0A=
=0A=
> +/**=0A=
=0A=
> + * inv_mpu_magn_probe() - probe and setup magnetometer chip=0A=
=0A=
> + * @st: driver internal state=0A=
=0A=
> + *=0A=
=0A=
> + * Returns 0 on success, a negative error code otherwise=0A=
=0A=
> + *=0A=
=0A=
> + * It is probing the chip and setting up all needed i2c transfers.=0A=
=0A=
> + * Noop if there is no magnetometer in the chip.=0A=
=0A=
> + */=0A=
=0A=
=0A=
=0A=
Comments generally next to implementations rather than definitions...=0A=
=0A=
We got this wrong a fair bit in early IIO but let us move forward=0A=
=0A=
correctly!=0A=
=0A=
=0A=
=0A=
> +int inv_mpu_magn_probe(struct inv_mpu6050_state *st);=0A=
=0A=
> +=0A=
=0A=
> +/**=0A=
=0A=
> + * inv_mpu_magn_get_scale() - get magnetometer scale value=0A=
=0A=
> + * @st: driver internal state=0A=
=0A=
> + *=0A=
=0A=
> + * Returns IIO data format.=0A=
=0A=
> + */=0A=
=0A=
> +static inline int inv_mpu_magn_get_scale(const struct inv_mpu6050_state =
*st,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 const struct iio_chan_spec *chan,=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int *val, int *val2)=0A=
=0A=
> +{=0A=
=0A=
> +=A0=A0=A0=A0 *val =3D 0;=0A=
=0A=
> +=A0=A0=A0=A0 *val2 =3D st->magn_raw_to_gauss[chan->address];=0A=
=0A=
> +=A0=A0=A0=A0 return IIO_VAL_INT_PLUS_MICRO;=0A=
=0A=
> +}=0A=
=0A=
> +=0A=
=0A=
> +/**=0A=
=0A=
> + * inv_mpu_magn_set_rate() - set magnetometer sampling rate=0A=
=0A=
> + * @st: driver internal state=0A=
=0A=
> + * @fifo_rate: mpu set fifo rate=0A=
=0A=
> + *=0A=
=0A=
> + * Returns 0 on success, a negative error code otherwise=0A=
=0A=
> + *=0A=
=0A=
> + * Limit sampling frequency to the maximum value supported by the=0A=
=0A=
> + * magnetometer chip. Resulting in duplicated data for higher frequencie=
s.=0A=
=0A=
> + * Noop if there is no magnetometer in the chip.=0A=
=0A=
> + */=0A=
=0A=
> +int inv_mpu_magn_set_rate(const struct inv_mpu6050_state *st, int fifo_r=
ate);=0A=
=0A=
> +=0A=
=0A=
> +/**=0A=
=0A=
> + * inv_mpu_magn_set_orient() - fill magnetometer mounting matrix=0A=
=0A=
> + * @st: driver internal state=0A=
=0A=
> + *=0A=
=0A=
> + * Returns 0 on success, a negative error code otherwise=0A=
=0A=
> + *=0A=
=0A=
> + * Fill magnetometer mounting matrix using the provided chip matrix.=0A=
=0A=
> + */=0A=
=0A=
> +int inv_mpu_magn_set_orient(struct inv_mpu6050_state *st);=0A=
=0A=
> +=0A=
=0A=
> +/**=0A=
=0A=
> + * inv_mpu_magn_read() - read magnetometer data=0A=
=0A=
> + * @st: driver internal state=0A=
=0A=
> + * @axis: IIO modifier axis value=0A=
=0A=
> + * @val: store corresponding axis value=0A=
=0A=
> + *=0A=
=0A=
> + * Returns 0 on success, a negative error code otherwise=0A=
=0A=
> + */=0A=
=0A=
> +int inv_mpu_magn_read(const struct inv_mpu6050_state *st, int axis, int =
*val);=0A=
=0A=
> +=0A=
=0A=
> +#else=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* CONFIG_INV_MPU6050=
_MAGN */=0A=
=0A=
> +=0A=
=0A=
> +static inline int inv_mpu_magn_probe(struct inv_mpu6050_state *st)=0A=
=0A=
> +{=0A=
=0A=
> +=A0=A0=A0=A0 return 0;=0A=
=0A=
> +}=0A=
=0A=
> +=0A=
=0A=
> +static inline int inv_mpu_magn_get_scale(const struct inv_mpu6050_state =
*st,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 const struct iio_chan_spec *chan,=
=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int *val, int *val2)=0A=
=0A=
> +{=0A=
=0A=
> +=A0=A0=A0=A0 return -EINVAL;=0A=
=0A=
> +}=0A=
=0A=
> +=0A=
=0A=
> +static inline int inv_mpu_magn_set_rate(const struct inv_mpu6050_state *=
st,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int fifo_rate)=0A=
=0A=
> +{=0A=
=0A=
> +=A0=A0=A0=A0 return 0;=0A=
=0A=
> +}=0A=
=0A=
> +=0A=
=0A=
> +static inline int inv_mpu_magn_set_orient(struct inv_mpu6050_state *st)=
=0A=
=0A=
> +{=0A=
=0A=
> +=A0=A0=A0=A0 return 0;=0A=
=0A=
> +}=0A=
=0A=
> +=0A=
=0A=
> +static inline int inv_mpu_magn_read(const struct inv_mpu6050_state *st, =
int axis,=0A=
=0A=
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 int *val)=0A=
=0A=
> +{=0A=
=0A=
> +=A0=A0=A0=A0 return 0;=0A=
=0A=
> +}=0A=
=0A=
> +=0A=
=0A=
> +#endif=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* CONFIG_INV_MPU6050_M=
AGN */=0A=
=0A=
> +=0A=
=0A=
> +#endif=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* INV_MPU_MAGN_H_ */=
=0A=
=0A=
=0A=
=0A=
