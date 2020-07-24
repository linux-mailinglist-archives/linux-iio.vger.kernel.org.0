Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE22822C0A1
	for <lists+linux-iio@lfdr.de>; Fri, 24 Jul 2020 10:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgGXI1r (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 24 Jul 2020 04:27:47 -0400
Received: from mx0a-00328301.pphosted.com ([148.163.145.46]:23542 "EHLO
        mx0a-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726573AbgGXI1q (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 24 Jul 2020 04:27:46 -0400
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06O8QFrf030360;
        Fri, 24 Jul 2020 01:27:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt1;
 bh=CsZyksr+z1vgzpedvSCAw3X1hQzgPQ9hxNb9IZPyAgk=;
 b=vr0mE8N9Od0PXfrmQjcW6VrtPgdfZcbZDkQCPKTVlEp5gwChzLvXsohutkYqCQHcU3eP
 WUEDW41LlTCtFti98JZu+I+wnOS82phGEfFabkWOVQtGJPntf2XN2+2rTrt+34CfGJso
 TY/PDxDqSqqLy/RJi1QrMjw5lL9QwtIfSBi6u9AwBN7EvyNVv+yJXUrokM6GaQS7GRG5
 E6PUjlVNhxDdL394WPUu34LgNQf3+BxURoBPWNKDq/T/wMX5YyQcHg7ctnJ+B22LFNpK
 KxPhbAFJquvrtPm2+7WnhDOLe9Q0KWieusni/KmdRo6zYhsKLcnrJzBaXkNPa2ZK4mWH YA== 
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2058.outbound.protection.outlook.com [104.47.45.58])
        by mx0a-00328301.pphosted.com with ESMTP id 32bvjnat0n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Jul 2020 01:27:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UZxnq4bD5YnzU4h6qVZhve826fYLpK9/3uT5BEdEXnyChnMxfmLDptFo9PqH6q1T01HlRUuwLKYbmdksO/DXPoualxtyVgdfTGxrpYm9Wst3xGUTJ8VIHbj47djs57o0+zp8Dw2Ip99IM+cPXTim3skiGdpcrTbe9nwr1JwulwqytpblX2oQiFDR0MRNTVLmNbYI/SEvZSnwOYnik1+tjqy5S6nuJj+VvmhdqiaF33Pg9Rbmny+0tkvZwYrODlfXmy3OmQpGON8lgY5UzQ4yLmYveFkK9qNsBPAHgVwxDZ3t0Nkkx0aKlsyUXL0kt5LvM4lQu+vz9gpVDkcriowMRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CsZyksr+z1vgzpedvSCAw3X1hQzgPQ9hxNb9IZPyAgk=;
 b=JmJjN7bJKiCAif4C7FLFATRDhVC7wJNkLST53Re44NzdqMQhdPwhmNu2KvEc/Vx0f3HsY6dGKe7joeUN1fbUNOIsBBouvJi1EDg5Jl+F65J1KqSt4tgYlzkIcAM6szj0U9ZdDkhe4/2YX05/rvQ6cn5hCU7leCZ37QeELeM6qCdE1MbGAK0Yia13cuRwt0I+1oZU2WwLUKuquT1JjgK1OWVs2QEXTpGcXl6PUnczHZIjFqFb1/+JkrbB91R6pcEbgNYtC63Tg3Z9+G8QoIhczMrxv0tnvlLnhTm/0XrBv2F3rnUW0dzke3ih7G0TSHf9Q/p/b713OVGbPgtRXx6+LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CsZyksr+z1vgzpedvSCAw3X1hQzgPQ9hxNb9IZPyAgk=;
 b=O87rtG4pJcGGj2fyutscoNoALN7eAzgz8OqRxs+5eNXytwYVXqv+sV6o8Hzux3J4oaNpiBzTyjv5aDP4yusNmdQw+S3gzb70BHJ/5QDkhW4ntHRzMZryU+09xQ4v3Uv037sEfwOCbzrLIXQEW0Lv5MYrdADy44r3sV3dC3itWZE=
Received: from MN2PR12MB4390.namprd12.prod.outlook.com (2603:10b6:208:26e::21)
 by BL0PR12MB2547.namprd12.prod.outlook.com (2603:10b6:207:3e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Fri, 24 Jul
 2020 08:27:13 +0000
Received: from MN2PR12MB4390.namprd12.prod.outlook.com
 ([fe80::2c88:e0b6:478:a6e8]) by MN2PR12MB4390.namprd12.prod.outlook.com
 ([fe80::2c88:e0b6:478:a6e8%5]) with mapi id 15.20.3216.022; Fri, 24 Jul 2020
 08:27:13 +0000
From:   Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v3 17/27] iio:imu:inv_mpu6050 Fix dma and ts alignment and
 data leak issues.
Thread-Topic: [PATCH v3 17/27] iio:imu:inv_mpu6050 Fix dma and ts alignment
 and data leak issues.
Thread-Index: AQHWYEBDGGHmgUyieEqTKe0soLBjvKkWZ3Ry
Date:   Fri, 24 Jul 2020 08:27:13 +0000
Message-ID: <MN2PR12MB4390D02D8798C05C3376991DC4770@MN2PR12MB4390.namprd12.prod.outlook.com>
References: <20200722155103.979802-1-jic23@kernel.org>,<20200722155103.979802-18-jic23@kernel.org>
In-Reply-To: <20200722155103.979802-18-jic23@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=invensense.com;
x-originating-ip: [2a01:e0a:2dd:a010:19ad:9472:dcb6:2bcc]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d4969cf5-cb21-42a2-8cee-08d82fab5dfc
x-ms-traffictypediagnostic: BL0PR12MB2547:
x-microsoft-antispam-prvs: <BL0PR12MB254748F6CE61B0575186271EC4770@BL0PR12MB2547.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PWNTXRy/ZHD8j3YmXeBbnU+XAjuUkF0Dpphk3MpMR7ydCMggUoKd2RcdhlNamFl9FtCrvsAeuCCshc/yuPM3pP412pSHIjSnQ3Pf5eZ5CgN79iGFluNmCy/t2r283UK21aHIo0ab1zvF99fSEw/bF6qP3RoJvA2kWjT5CobCx3ywFeR1GLjtj60pxr9647emvnrQSf8TiG2lcQpRhVyCeJbN79CEffiKoRpvfHOcIxcekEC7mCA3dbKzkXlYtFwPYyUMHN+8nWEFHeAx9qBK/p7bbVtbpNvoRG3phgB4PjsnrvUA97QKKOtDhaSdSlKah1VYom/SX/Aj+7tCGiuhTQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4390.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(136003)(396003)(39850400004)(346002)(376002)(66556008)(66476007)(64756008)(5660300002)(66446008)(66946007)(478600001)(83380400001)(76116006)(86362001)(71200400001)(7696005)(91956017)(9686003)(55016002)(52536014)(110136005)(8676002)(186003)(8936002)(316002)(2906002)(53546011)(6506007)(33656002)(54906003)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 0YObwebjAyQQmGaXoMm01rQ4z0yxo5Iz68jAbGhBzaP/6rkzpFVAWj4/XYrczYO+OFUA77MMFZIdwsapkfJFnlG1mDm7aUcGwVGpdZZxKuju7wXE/05AQZlgUQzu+jemyFhiQRhQDg6to0SdND+2ekUQSITgQdHOr0Y48wBGNadjtZA3R3/rJqcNGHuRkKrQvoPqZGpEiE3ytnZAfjz8VfRTf+ns9Nh82OiB7GFHiGVxAmwfDiZs1qWuQ7w9WESR+EyoTrUptOSODMbkrH7j+Y585kpH8+iilDuA8CYQ9EfKBYzIuDjHDWFpV5IKgNi6JUue7zogBXixMa3JEc+ljVeE7J9ccYg3oBuZtHSn+8NyEu+YZeg2eni7vemyq96HttdzGU0Hp5h0kp0tae5PLzXPOzKrfrXhspJKicv4bUH0W1a30C7ukCa8CmnqX2z9P84MSBklkFG/cbivJiFMpXJ7XenANNi9dcBs8NhHZwE9GYjQv+DsyQ5UsfthncuPw/Ak28n6db+ERX/C9CPT1CW984RrmN32atQ3OnzcZyM=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4390.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4969cf5-cb21-42a2-8cee-08d82fab5dfc
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2020 08:27:13.3758
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hgGtmM+5zEWv2j1aFsG6jQ5ZtMlPZPpWqvUEb05dmnxkU4S+KaqJWj6B9AhTrE9iD96SRNpHyKuzNuTBPpqA8Qg5cR7vr053eEJ3a30KFDo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2547
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-24_02:2020-07-24,2020-07-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 clxscore=1011 impostorscore=0 mlxscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 malwarescore=0 adultscore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007240062
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,=0A=
=0A=
looks perfect for me.=0A=
=0A=
Thanks for the fix,=0A=
JB=0A=
=0A=
Reviewed-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>=0A=
=0A=
=0A=
From: linux-iio-owner@vger.kernel.org <linux-iio-owner@vger.kernel.org> on =
behalf of Jonathan Cameron <jic23@kernel.org>=0A=
Sent: Wednesday, July 22, 2020 17:50=0A=
To: linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>=0A=
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>; Lars-Peter Clausen <lars@m=
etafoo.de>; Peter Meerwald <pmeerw@pmeerw.net>; Jonathan Cameron <Jonathan.=
Cameron@huawei.com>; Jean-Baptiste Maneyrol <JManeyrol@invensense.com>=0A=
Subject: [PATCH v3 17/27] iio:imu:inv_mpu6050 Fix dma and ts alignment and =
data leak issues. =0A=
=A0=0A=
=A0CAUTION: This email originated from outside of the organization. Please =
make sure the sender is who they say they are and do not click links or ope=
n attachments unless you recognize the sender and know the content is safe.=
=0A=
=0A=
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>=0A=
=0A=
This case is a bit different to the rest of the series.=A0 The driver=0A=
was doing a regmap_bulk_read into a buffer that wasn't dma safe=0A=
as it was on the stack with no guarantee of it being in a cacheline=0A=
on it's own.=A0=A0 Fixing that also dealt with the data leak and=0A=
alignment issues that Lars-Peter pointed out.=0A=
=0A=
Also removed some unaligned handling as we are now aligned.=0A=
=0A=
Fixes tag is for the dma safe buffer issue. Potentially we would=0A=
need to backport timestamp alignment futher but that is a totally=0A=
different patch.=0A=
=0A=
Fixes: fd64df16f40e ("iio: imu: inv_mpu6050: Add SPI support for MPU6000")=
=0A=
Reported-by: Lars-Peter Clausen <lars@metafoo.de>=0A=
Cc: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>=0A=
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>=0A=
---=0A=
=A0drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h=A0 |=A0 8 +++++---=0A=
=A0drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c | 12 +++++-------=0A=
=A02 files changed, 10 insertions(+), 10 deletions(-)=0A=
=0A=
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/in=
v_mpu6050/inv_mpu_iio.h=0A=
index cd38b3fccc7b..e4df2d51b689 100644=0A=
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h=0A=
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h=0A=
@@ -122,6 +122,9 @@ struct inv_mpu6050_chip_config {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 u8 user_ctrl;=0A=
=A0};=0A=
=A0=0A=
+/* 6 + 6 + 2 + 7 (for MPU9x50) =3D 21 round up to 24 and plus 8 */=0A=
+#define INV_MPU6050_OUTPUT_DATA_SIZE=A0=A0=A0=A0=A0=A0=A0=A0 32=0A=
+=0A=
=A0/**=0A=
=A0 *=A0 struct inv_mpu6050_hw - Other important hardware information.=0A=
=A0 *=A0 @whoami:=A0=A0 Self identification byte from WHO_AM_I register=0A=
@@ -165,6 +168,7 @@ struct inv_mpu6050_hw {=0A=
=A0 *=A0 @magn_raw_to_gauss:=A0=A0=A0=A0=A0=A0=A0 coefficient to convert ma=
g raw value to Gauss.=0A=
=A0 *=A0 @magn_orient:=A0=A0=A0=A0=A0=A0 magnetometer sensor chip orientati=
on if available.=0A=
=A0 *=A0 @suspended_sensors:=A0=A0=A0=A0=A0=A0=A0 sensors mask of sensors t=
urned off for suspend=0A=
+ *=A0 @data:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dma safe buffer used for =
bulk reads.=0A=
=A0 */=0A=
=A0struct inv_mpu6050_state {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 struct mutex lock;=0A=
@@ -190,6 +194,7 @@ struct inv_mpu6050_state {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 s32 magn_raw_to_gauss[3];=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 struct iio_mount_matrix magn_orient;=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 unsigned int suspended_sensors;=0A=
+=A0=A0=A0=A0=A0=A0 u8 data[INV_MPU6050_OUTPUT_DATA_SIZE] ____cacheline_ali=
gned;=0A=
=A0};=0A=
=A0=0A=
=A0/*register and associated bit definition*/=0A=
@@ -334,9 +339,6 @@ struct inv_mpu6050_state {=0A=
=A0#define INV_ICM20608_TEMP_OFFSET=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 817=
0=0A=
=A0#define INV_ICM20608_TEMP_SCALE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 3=
059976=0A=
=A0=0A=
-/* 6 + 6 + 2 + 7 (for MPU9x50) =3D 21 round up to 24 and plus 8 */=0A=
-#define INV_MPU6050_OUTPUT_DATA_SIZE=A0=A0=A0=A0=A0=A0=A0=A0 32=0A=
-=0A=
=A0#define INV_MPU6050_REG_INT_PIN_CFG=A0=A0=A0=A0 0x37=0A=
=A0#define INV_MPU6050_ACTIVE_HIGH=A0=A0=A0=A0=A0=A0=A0=A0 0x00=0A=
=A0#define INV_MPU6050_ACTIVE_LOW=A0=A0=A0=A0=A0=A0=A0=A0=A0 0x80=0A=
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/i=
nv_mpu6050/inv_mpu_ring.c=0A=
index b533fa2dad0a..d8e6b88ddffc 100644=0A=
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c=0A=
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c=0A=
@@ -13,7 +13,6 @@=0A=
=A0#include <linux/interrupt.h>=0A=
=A0#include <linux/poll.h>=0A=
=A0#include <linux/math64.h>=0A=
-#include <asm/unaligned.h>=0A=
=A0#include "inv_mpu_iio.h"=0A=
=A0=0A=
=A0/**=0A=
@@ -121,7 +120,6 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 struct inv_mpu6050_state *st =3D iio_priv(indio_de=
v);=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 size_t bytes_per_datum;=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 int result;=0A=
-=A0=A0=A0=A0=A0=A0 u8 data[INV_MPU6050_OUTPUT_DATA_SIZE];=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 u16 fifo_count;=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 s64 timestamp;=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 int int_status;=0A=
@@ -160,11 +158,11 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 * read fifo_count register to know how many byt=
es are inside the FIFO=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 * right now=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 */=0A=
-=A0=A0=A0=A0=A0=A0 result =3D regmap_bulk_read(st->map, st->reg->fifo_coun=
t_h, data,=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 INV_MPU6050_FIFO_COUNT_BYTE);=0A=
+=A0=A0=A0=A0=A0=A0 result =3D regmap_bulk_read(st->map, st->reg->fifo_coun=
t_h,=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 st->data, INV_MPU6050_FIFO_COUNT_BYTE);=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 if (result)=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto end_session;=0A=
-=A0=A0=A0=A0=A0=A0 fifo_count =3D get_unaligned_be16(&data[0]);=0A=
+=A0=A0=A0=A0=A0=A0 fifo_count =3D be16_to_cpup((__be16 *)&st->data[0]);=0A=
=A0=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 /*=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 * Handle fifo overflow by resetting fifo.=0A=
@@ -182,7 +180,7 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 inv_mpu6050_update_period(st, pf->timestamp, nb);=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 for (i =3D 0; i < nb; ++i) {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 result =3D regmap_bulk_rea=
d(st->map, st->reg->fifo_r_w,=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 data, bytes_per_datum);=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->data, bytes_per_datum)=
;=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (result)=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 go=
to flush_fifo;=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* skip first samples if n=
eeded */=0A=
@@ -191,7 +189,7 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 co=
ntinue;=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 timestamp =3D inv_mpu6050_=
get_timestamp(st);=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 iio_push_to_buffers_with_timest=
amp(indio_dev, data, timestamp);=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 iio_push_to_buffers_with_timest=
amp(indio_dev, st->data, timestamp);=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
=A0=0A=
=A0end_session:=0A=
-- =0A=
2.27.0=0A=
