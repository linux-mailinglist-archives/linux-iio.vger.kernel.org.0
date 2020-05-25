Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60EEB1E1477
	for <lists+linux-iio@lfdr.de>; Mon, 25 May 2020 20:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389839AbgEYSpH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 25 May 2020 14:45:07 -0400
Received: from mx0b-00328301.pphosted.com ([148.163.141.47]:34672 "EHLO
        mx0b-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389656AbgEYSpG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 25 May 2020 14:45:06 -0400
Received: from pps.filterd (m0156136.ppops.net [127.0.0.1])
        by mx0b-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04PIdUQx009604;
        Mon, 25 May 2020 11:44:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt1;
 bh=LAVxGacmCVf9EkSNFRFDP9mR+R3RIbankl28u8qzaO8=;
 b=USTQVX+PJf3sfPzFd6E6+IJIhW5vmjusIcBul7+MFgl9mq4pHY6psft4hQ/ejnyKfE3X
 WlBEwrIkn4l0MX2/4mn7JazDgjERUTMfYnT/7r3uWyuxzXyGbxiA3zJ7lVTCjtT6yp5T
 qB98qSltw6plf0XlP0RBLO7kuDMFQXK1l9H3JGPct4QbYhZiKVXvlw4QCgZt+7EhwCDY
 kKkrnEZNGjmdCoYTMYSWXmvaRDnAAamCLlFkFfl6lYHPDLEUVPWc1tWFvgFcoo8AXdl7
 taXONdv4y/anLtWmqkw11y+hONOs3mbPDBZFk9ZhWOgPWCf30T+G187minfuuvnrzQja YQ== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by mx0b-00328301.pphosted.com with ESMTP id 3185ap8bjr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 May 2020 11:44:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G3JNFiZdhWMD64cjPSA4MC8z/zmf5B+NJPJXChgVAnJXsqqU4Kuq8eubX6xPKp9rnqKdF49kVSstJ8xfGLLzQRXv7BudFCWwo/jJWq1Tnvae0+QNb6j3jvByBs+4xsQ6xsaFzHvESwS1JqC3TZkUT2Ma8/rTurF0EZsqVmU79w/Sp7+yzEhWIL/N0XtzSe5ELPevQwB6M7b6lU8T1O8wtB5j5R1h7kkLGmXuo97PRwl4bSJeA4DfgcGd47OX9wD8vi9aZQoT0RhUsfwuHkZt29Y10JeTbUGQTZxSKttqRwA3447edibjrpk9zZQQ5hNdrbU5MhkyGxDrtwWpw3ZEyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LAVxGacmCVf9EkSNFRFDP9mR+R3RIbankl28u8qzaO8=;
 b=KcA3UnL550fyIYN8Lbo5yr7ltb14b5droMF1WHbjKdZc43s2cbTBP79tOODsY/4odLDgwXtRvHFvhzce6S62oc49aB9MzPM4jrkLbVZJKk9Gk8UCsyPa+JdpRFzkb/MxRRgTnFFNvlC5ZDLqryZ5wbe57BuTGs7F6A/vmGOa/FMk8m2vivHjxZ1iXBF8PQGF3b/aw0CZQypVWZSj5hMD9D3oM3R11vEKkYfqTv9HQLe1IthAIJNlE89yud0CeYUBXkDVeUYHdeC2OWfJklZgo9XWCrEhBtVnqIN9dxv4TiFu9QqdlWdYKTasnZt81w2aL6sylz8iyjjQPmXhp3DvSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LAVxGacmCVf9EkSNFRFDP9mR+R3RIbankl28u8qzaO8=;
 b=gBrVk/eBkhf+5NKBgXaGrtnSMYE73WYKMgAKk2m+BWVDk0Ek5DmKD5TcuwesDNNwnQgOh5Nctk6xbB4rL+Ze2WiUGhPAvHou8Wh+6vaj4CEumkOZ/wZ6AJpyOTFmEm0YIiXG/S3XhdeLE6ep9a6Jw3sOsr5L/bYBr2hTg8Z1fZ0=
Received: from MN2PR12MB4422.namprd12.prod.outlook.com (2603:10b6:208:265::9)
 by MN2PR12MB4504.namprd12.prod.outlook.com (2603:10b6:208:24f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.24; Mon, 25 May
 2020 18:44:41 +0000
Received: from MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::8940:8e95:6996:cc0]) by MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::8940:8e95:6996:cc0%8]) with mapi id 15.20.3021.029; Mon, 25 May 2020
 18:44:41 +0000
From:   Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 13/25] iio:imu:inv_mpu6050 Fix dma and ts alignment and
 data leak issues.
Thread-Topic: [PATCH 13/25] iio:imu:inv_mpu6050 Fix dma and ts alignment and
 data leak issues.
Thread-Index: AQHWMrc7akm4nG7y5EeSi56TjUhoUai5IR7V
Date:   Mon, 25 May 2020 18:44:41 +0000
Message-ID: <MN2PR12MB44223FFD85B9FBEADEA8368BC4B30@MN2PR12MB4422.namprd12.prod.outlook.com>
References: <20200525170628.503283-1-jic23@kernel.org>,<20200525170628.503283-14-jic23@kernel.org>
In-Reply-To: <20200525170628.503283-14-jic23@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=invensense.com;
x-originating-ip: [91.174.78.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e96d2e4e-5815-4087-79f2-08d800dbafb9
x-ms-traffictypediagnostic: MN2PR12MB4504:
x-microsoft-antispam-prvs: <MN2PR12MB45042010FAD418BBA3A0A6F3C4B30@MN2PR12MB4504.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0414DF926F
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2pv3pwv4/8ZB+ILFvWbFW0VCVuLmqwUOU6KwKnakaxdHbzUFx0d6DWemF1aUFS3ndLJl44BKAXUel/r6eNgrFTdHJpXrRgrfHvT43rfjztt+wPjpOn/EyKkueGPPoLarnIw8zfCJBSOGqTrGuMFg/hHi1TgAz3Ac0vWJa3Fu+K/J1bqFsM6Oy74XeSpCaCZQv6IzY40u/oy2k1o4i+NamgbuyJFg1lU62zm1NUbueQFIkVb7e9bsXxuS92zsB0I3dnhv5eaDGX7CalC5ibaQxnqgxr95gyYeRwlKw5HNcw1/ZdJnQR70Ue1Y5LALbpqn3hOPvJ6tT35Jo11uefLKyQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4422.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(396003)(376002)(136003)(39850400004)(346002)(9686003)(55016002)(4326008)(6506007)(316002)(2906002)(7696005)(54906003)(186003)(26005)(8676002)(110136005)(5660300002)(33656002)(71200400001)(53546011)(8936002)(86362001)(52536014)(76116006)(91956017)(66946007)(66476007)(64756008)(66556008)(66446008)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: CbyQKKwYojAV4OhBA/7rpd3Ruka1D9Z6F+NZOfRXwkq+AhXYvlWlZ12Zt4g86Ap8MKQ3tcf50A3h/B0hS4Pl2nlGefRhqbrjsQFSwyx0hD/vKWR/HNp34VZa7XEBcBD37beViG1/wieJFwoZLOIb7u+dgFZsKchptKe9YLNvnY4Gx/T2oaMugS2jiJ7NUGQkOhryTHLd4/EPAg/KvesYw6Dmbd2A8RwvqozBE5E4HpJxEx60m2QnnVuCQN8X5qRVYbDG/cFSyXeukKtYzSHSODAjsJmwkZzmLTKU0GY9t1Ka0NEqz+KCoDjJ6FTeQM75EyGhqy30fDDtutG9hMV4jaTXcGcD3vHAYnQtOuW+Eq4ZjumlGEIQOqQ3WtIBGCIQuvnLfxSyfriV0BVf+8At0n6/ezH8QYZCFEXRd2Q44I+wYMHuKW4D0kLQ4RPemmyIh9vQV7LTHVnsVxm+DwQjDWHUYoY6+RZjv2bxjQV4/qI=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e96d2e4e-5815-4087-79f2-08d800dbafb9
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2020 18:44:41.7845
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OWrAEMr0NsxQnixFJ7yGhv1Nn1P8bTbkIC3k18ZEhHFCjx0cNuHbOeYYv6WAmaBLndtVj+JYfVoYGwY1gil3C2kANEKnXuH+zTYTbND+5WE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4504
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-25_10:2020-05-25,2020-05-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 cotscore=-2147483648
 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0 phishscore=0
 mlxscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999 clxscore=1015
 spamscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005250148
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,=0A=
=0A=
the driver is also doing other regmap_bulk_read and regmap_bulk_write for g=
etting sensor data from registers and for setting hardware offsets.=0A=
But there are numerous IIO drivers supporting SPI that are doing the same (=
IMU ST driver for example).=0A=
=0A=
Are you sure this is really required? It seems to just call standard SPI tr=
ansfers behind (I don't know if DMA can be implicitly call there). This is =
very inconvenient to deal with if there is no easy way to read/write multip=
le registers on the stack.=0A=
=0A=
Another thing I have in mind, the read for the FIFO should be replaced by a=
 regmap_noinc_read, since this is a virtual register reading the FIFO, not =
the register map.=0A=
=0A=
Thanks,=0A=
JB=0A=
=0A=
From: Jonathan Cameron <jic23@kernel.org>=0A=
Sent: Monday, May 25, 2020 19:06=0A=
To: linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>=0A=
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>; Lars-Peter Clausen <lar=
s@metafoo.de>; Jean-Baptiste Maneyrol <JManeyrol@invensense.com>=0A=
Subject: [PATCH 13/25] iio:imu:inv_mpu6050 Fix dma and ts alignment and dat=
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
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>=0A=
Cc: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>=0A=
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
