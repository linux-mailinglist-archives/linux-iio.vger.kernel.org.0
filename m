Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2641F169E
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jun 2020 12:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbgFHKYv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Jun 2020 06:24:51 -0400
Received: from mx0b-00328301.pphosted.com ([148.163.141.47]:56636 "EHLO
        mx0b-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726202AbgFHKYu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Jun 2020 06:24:50 -0400
Received: from pps.filterd (m0156136.ppops.net [127.0.0.1])
        by mx0b-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 058AOESg007061;
        Mon, 8 Jun 2020 03:24:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt1;
 bh=l1KZW7q0f7orx2wMbNvOLlRsQ/g/yqKM/f9x1L3lusU=;
 b=X2n87L7XtgzXqTaPAMUJJrr1n2zmHDjzthO+YgfnxEGwcmhGDxEq4N938kCQfe/AStqp
 EAM7i2/4dDWzuGhWqE8vhYiPdaZb9aCtF+BNVz+R3khOgICgXwvojKd6YmA4SCPzjHKt
 ymgmKw2g9j5xM9YCVoXkCgSyybR7E3bTz0iL7nV/D/ran10uYhUwGMhb4ySJpTbtFJO8
 7R67miR3aFf0c8DBGx6s1Pde1TxtH4pkM+za/39kBJfFtIHZLrG7z7Ngjyd/r6bCso0t
 itz8ZgPAzYYi6T0AuR6BCXZVjcCSmi/foBb791BPuPdkzAO1Z4Pu7v6gJ8F2mPGEVwXL NQ== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by mx0b-00328301.pphosted.com with ESMTP id 31g8cf0nur-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Jun 2020 03:24:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QAYVyAewCmYP1t8kEep6Y5H3ITRuVwzNSnqHjVZn2HOxzMXrQJLdzedzMMDucA8YfwVkEcHRMmBtufNtfhmFnrXGlNqzcjG6qnooLgdoYXNrNuProKIj75Z5a6i1SVME96VwOiZaF52gk8G0UZC7Jxg4AdLZGFdz9vzRuzgGHVnFwsNXMZ36R2dtx4GL2mamK+yD975Cx5GW8Pav3QbO93roNVw4eim46OS0qAP7k8Ub+HUi6S8VOzD3cVxOiq2Wm0YlM4pKWDzb0wBItPrWX1bkLcN2Hk/ka1/+6xKZ2z0z/qjsRkQ0K/gT7v8UwGIaGuhxRexidcnnevaa3W9f/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l1KZW7q0f7orx2wMbNvOLlRsQ/g/yqKM/f9x1L3lusU=;
 b=bfsIwU8IMXRYf3wsjOst9nDf/ghtG+Q1EawI2q0DDJWaNzxe957dXaZOmduy5Hf4x+vHKqU6oj5gArrRYxf06s8MHOVEgtu0UUFh53ADtSr7d2lPF5WlfA+ubKgIzbpxq9hAir242qCP0Pb9nSxvWn2No3wv98uQZN5RY3oxj9BMyoM/qJsx9CSilRbgJqR3tsLeER5H/CKwKAipmh3dvvLDis62dVxdHGdBR9wZ1NTzDcmG4YcI56nBsF/OKXKUEBnn86stl4yoHg4f9oshZXtebpLZqwd50dNwBklUWBIrJWXHizn6rcc6WjY8Rbz6RUbw9XxtOi1XSwSxKDtdzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l1KZW7q0f7orx2wMbNvOLlRsQ/g/yqKM/f9x1L3lusU=;
 b=Kw/RUT7aPaqDZVXEC4Yka8AveWz9LlDa4uOZonCE93y1uO1oL26mb/Bdsbq01DYmQMo3DicSh1G8z3glDQw2eZN93kFmF3VkozdwaiN03lrdevhA545n6ooDhWyASWG3lUR5czkfvhmt9/u5nHfct96GiG1VIvYqEfhv6Ftlv/E=
Received: from MN2PR12MB4422.namprd12.prod.outlook.com (2603:10b6:208:265::9)
 by MN2PR12MB3552.namprd12.prod.outlook.com (2603:10b6:208:ab::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.20; Mon, 8 Jun
 2020 10:24:11 +0000
Received: from MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::8940:8e95:6996:cc0]) by MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::8940:8e95:6996:cc0%8]) with mapi id 15.20.3066.023; Mon, 8 Jun 2020
 10:24:11 +0000
From:   Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 20/32] iio:imu:inv_mpu6050 Fix dma and ts alignment and
 data leak issues.
Thread-Topic: [PATCH 20/32] iio:imu:inv_mpu6050 Fix dma and ts alignment and
 data leak issues.
Thread-Index: AQHWPOQ+OsnFwGUmykKD1AQaRZOyO6jOg1ih
Date:   Mon, 8 Jun 2020 10:24:11 +0000
Message-ID: <MN2PR12MB44220F9CE7BDF5ACA3DEF4A4C4850@MN2PR12MB4422.namprd12.prod.outlook.com>
References: <20200607155408.958437-1-jic23@kernel.org>,<20200607155408.958437-21-jic23@kernel.org>
In-Reply-To: <20200607155408.958437-21-jic23@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=invensense.com;
x-originating-ip: [91.174.78.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a5c54471-1890-4001-aac2-08d80b961632
x-ms-traffictypediagnostic: MN2PR12MB3552:
x-microsoft-antispam-prvs: <MN2PR12MB35529F21382F2E7960DE63B1C4850@MN2PR12MB3552.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 042857DBB5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5wc7+p/8l/6a2VihIqP2xCc9UBEnaFjnY63ATJ7QtNc4LOdTZ4X0z7r35UbyxSNWbcw/zUCGFV3Oeo9D6KsJiUnbpvdURpktGi1ZtvBzd/zn1/drDfwfUXuyxDXDOGEzZYmBNqXa/MBH8t9QObwr2T7hW+wKhRfZkkWLlIjHUtHrsi1WpBzRkBuHVMMe2jJ491LmwZzp+ubF81F6IdQNr5/C60h/+jG6g6Svg4xF/tX2OduGWbLxr1gJ/zj6yDS8ojZLldZoAv9cfFWrmUTu4O8vOgHSum0Za+Wq/W/xPtx9uEpV5Ii7ZGlH7OA8xg6zReRh0oHdb8IgBgQI+xA3ew==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4422.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(376002)(136003)(39850400004)(366004)(396003)(110136005)(5660300002)(54906003)(2906002)(52536014)(478600001)(8936002)(86362001)(186003)(4326008)(71200400001)(26005)(8676002)(6506007)(7696005)(83380400001)(66446008)(9686003)(64756008)(66946007)(55016002)(66556008)(33656002)(53546011)(316002)(91956017)(66476007)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: yiqe/foWQG3yH0r8z6JgXbWH3IuPXsRItzSZj2SRQxEYTt7GXokJOl/HlhvlTE1opn5wWjqdxwVqwXGox66LcycNAPjh3aWtvyUOW3C4pYRsKE5SHMeVVUKlIX/t3LjmdcKFbRIba3Ld4CbMG21kk4p1smzgQ4MpU8izOBDe9k9WEcFARMLyArV19NIXecDivxNx8F+4cDwfYX7jEf9a4By5l8gJTD9GVkPMwrzNqZH7Ncz05vYd2NvZlWV+f2cjLSUSsDz1IsgZvKzQIP6MQXRQQ/OGK5d7zk0p9s6AuXQRQYxEMhVU9jyXufAXHdO1wO9d5DKaFoBqR/ZC9cN30UdhbZMBAxrR6SXCr+6rBq5iHKMLff1vffr4sEt6TzozdrtpDTdhfKiDjW1nlV3er0AYHXw5ZwT8pVcntcmCKWO4Qujzkg+ZcB+ftYRwGRj++lrnhnnQO0pct0iK9VGkbjmcaIeekDN4ctLYW112vno=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5c54471-1890-4001-aac2-08d80b961632
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2020 10:24:11.6442
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gsNh7tUUsGfyfPEhayfkpzupVpvd7hcqhoA5BzKEIYiU79X9YPwpJXymSlQWnsd3G7r1AmaiF+moz2ksrlXQQ7mzKSR/nmVSIgDQHZXxIqo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3552
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-08_07:2020-06-08,2020-06-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 impostorscore=0 mlxscore=0 bulkscore=0 phishscore=0 clxscore=1011
 malwarescore=0 priorityscore=1501 cotscore=-2147483648 mlxlogscore=999
 lowpriorityscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006080080
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,=0A=
=0A=
as stated before, I think this is a good opportunity to fix FIFO data readi=
ng by replacing regmap_bulk_read by regmap_noinc_read.=0A=
Otherwise it could also be done in another patch.=0A=
=0A=
Except that everything is perfect for me.=0A=
=0A=
Thanks,=0A=
JB=0A=
=0A=
Reviewed-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>=0A=
=0A=
From: Jonathan Cameron <jic23@kernel.org>=0A=
Sent: Sunday, June 7, 2020 17:53=0A=
To: linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>=0A=
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>; Jonathan Cameron <=
Jonathan.Cameron@huawei.com>; Lars-Peter Clausen <lars@metafoo.de>; Jean-Ba=
ptiste Maneyrol <JManeyrol@invensense.com>=0A=
Subject: [PATCH 20/32] iio:imu:inv_mpu6050 Fix dma and ts alignment and dat=
a leak issues. =0A=
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
=A0drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c | 12 ++++++------=0A=
=A02 files changed, 11 insertions(+), 9 deletions(-)=0A=
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
index 9511e4715e2c..554c16592d47 100644=0A=
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
@@ -160,11 +158,12 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 * read fifo_count register to know how many byt=
es are inside the FIFO=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 * right now=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 */=0A=
-=A0=A0=A0=A0=A0=A0 result =3D regmap_bulk_read(st->map, st->reg->fifo_coun=
t_h, data,=0A=
+=A0=A0=A0=A0=A0=A0 result =3D regmap_bulk_read(st->map, st->reg->fifo_coun=
t_h,=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 st->data,=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 INV_MPU6050_FIFO_COUNT_BYTE);=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 if (result)=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto end_session;=0A=
-=A0=A0=A0=A0=A0=A0 fifo_count =3D get_unaligned_be16(&data[0]);=0A=
+=A0=A0=A0=A0=A0=A0 fifo_count =3D be16_to_cpup((__be16 *)&st->data[0]);=0A=
=A0=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 /*=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 * Handle fifo overflow by resetting fifo.=0A=
@@ -182,7 +181,7 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)=0A=
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
@@ -191,7 +190,8 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 co=
ntinue;=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 timestamp =3D inv_mpu6050_=
get_timestamp(st);=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 iio_push_to_buffers_with_timest=
amp(indio_dev, data, timestamp);=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 iio_push_to_buffers_with_timest=
amp(indio_dev, st->data,=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 timestamp);=0A=
=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
=A0=0A=
=A0end_session:=0A=
-- =0A=
2.26.2=0A=
