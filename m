Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCE84B0D53
	for <lists+linux-iio@lfdr.de>; Thu, 12 Sep 2019 12:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731232AbfILK6c (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 12 Sep 2019 06:58:32 -0400
Received: from mx0b-00328301.pphosted.com ([148.163.141.47]:14126 "EHLO
        mx0b-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730680AbfILK6c (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 12 Sep 2019 06:58:32 -0400
Received: from pps.filterd (m0156136.ppops.net [127.0.0.1])
        by mx0b-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8CAtDu6012941;
        Thu, 12 Sep 2019 03:58:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pfpt1; bh=prb8IZ9lwHU14PLNCdQOHRz5berl0XmIoPzwvMU+hfI=;
 b=shami1dKNDR+NeMOGSTH6ygPa++SgG6MWvJDmg+DBiL1LGRhaErgRyDhnwHV+r497Yrk
 lpT5muUpGXZiZ20S2xb6en3742fD9Icqcwpgn7GyaHKICw7dMjx0Q9zharsbQhBa7eCg
 WOJZgMxHzhF9Nb3fVuYcBwFEW1s2SyZRRoC6goK9ZEJJgvfe4sUIeXdL1EMun9sOD4Ez
 N24l0JDZy0jFgVH/TEzbwmFSaDN4o0S7t58tzUQO1aYbeQ2TkB+nKS0/6o3CqQyeG3K9
 85LENgf80wRozxgZRqflw1ZZD88WbsFS8BWpqJMiihCVlES3D6nYkJkdZJVJG7oJm8pi UQ== 
Received: from nam05-by2-obe.outbound.protection.outlook.com (mail-by2nam05lp2059.outbound.protection.outlook.com [104.47.50.59])
        by mx0b-00328301.pphosted.com with ESMTP id 2uv8gn2s9m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Sep 2019 03:58:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TRHo04e4FSrj/e+OyFs9YvGb6JpYyW0ZoYJHznrG9pbP7HTLs4fgvUVGpqBy3MV/mKGtyWM73jq46f/6/tfGYFEIFPVjaoSGmtvC5YRkECNaJqGWyvpITtkynN4anF19HfP0LYSyNsf9fy2fqrtp7GMMZNBjWgPjDEeX5enaGEXB1vBityn/3BSZXbZDX+H9O3NQAqGsgjsoHPI8QmGbmShyJ180Gd0WDkoh+FIuyXiMqry6fpUVtgJsKUrT7857dEhzRKlweriIammEY8+AgHax+KwZpkp08rPGBkS/7HRbHUjpiEVfDgAlXUJY21paoUG9D9z7ukomPBGN6FqCrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=prb8IZ9lwHU14PLNCdQOHRz5berl0XmIoPzwvMU+hfI=;
 b=ZxE0T//ICrZSF9xGVJy5ypi69AEwwew7gkgUc/O4tsyj1zlQo0qI8sF/bI3xUiYEQVMUWKOdrBeQOvcEUzx91hYXVdbZHA0eEjQvJ9kANYaPNDmCIRPJjvJIEa2c4v5qgAM/M2/tvnleW5aL/UbiLyi5K6J7yuuQ/8LuQO+MiRvDaugE3ZdIiYOAgTsYv4a5mq37VJ/i1j6cG+iZ0l9AfavIV8B9AlDyz0UDGptB07kD+xoWwxp+E8xgGCq+ioUXY5yA4uObm+QtfdJdsK9ngqcJoOSTQXtquxvU4HDE3wxQV4H+mssIVdv8yal8IGZyTVDLH3pYnFzHDGRTQ2cqdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=prb8IZ9lwHU14PLNCdQOHRz5berl0XmIoPzwvMU+hfI=;
 b=Zc/QYOcrgfCfFqeYKprsEVLKTd2ayFhkJDz0rW/SMb3MXG4r7Jiez27Zzq8DTrrXxDGyetNw/HbJyvLoUN4UhozI9aj8xVoZB6If0U5nmVjvsriVkug9TH2Cl8Xt2ySLNJ6cxJ89Lg8AYGZduikMPpYKn3TQTnRZ9okC3moqIBQ=
Received: from MN2PR12MB3373.namprd12.prod.outlook.com (20.178.242.33) by
 MN2PR12MB2973.namprd12.prod.outlook.com (20.178.243.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.15; Thu, 12 Sep 2019 10:58:25 +0000
Received: from MN2PR12MB3373.namprd12.prod.outlook.com
 ([fe80::256d:7ef4:1570:a166]) by MN2PR12MB3373.namprd12.prod.outlook.com
 ([fe80::256d:7ef4:1570:a166%5]) with mapi id 15.20.2241.018; Thu, 12 Sep 2019
 10:58:24 +0000
From:   Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To:     "jic23@kernel.org" <jic23@kernel.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
Subject: [PATCH v2 1/7] iio: imu: inv_mpu6050: disable i2c mux for MPU925x
Thread-Topic: [PATCH v2 1/7] iio: imu: inv_mpu6050: disable i2c mux for
 MPU925x
Thread-Index: AQHVaVj/37OHFQUMKUGuprUbhwJ5jw==
Date:   Thu, 12 Sep 2019 10:58:24 +0000
Message-ID: <20190912105804.15650-1-jmaneyrol@invensense.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P265CA0448.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::28) To MN2PR12MB3373.namprd12.prod.outlook.com
 (2603:10b6:208:c8::33)
x-originating-ip: [77.157.193.39]
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 550ac9ef-60d7-407f-99f4-08d737702222
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR12MB2973;
x-ms-traffictypediagnostic: MN2PR12MB2973:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB2973C6A0C32B092FC78CBFD3C4B00@MN2PR12MB2973.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01583E185C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(366004)(396003)(39840400004)(199004)(189003)(81166006)(80792005)(86362001)(386003)(102836004)(6436002)(50226002)(26005)(4326008)(14444005)(256004)(6506007)(186003)(2501003)(99286004)(53936002)(66446008)(64756008)(1076003)(54906003)(66476007)(66556008)(5660300002)(486006)(14454004)(52116002)(66946007)(476003)(2616005)(316002)(36756003)(2351001)(71190400001)(2906002)(478600001)(305945005)(107886003)(6512007)(25786009)(7736002)(81156014)(8676002)(5640700003)(71200400001)(66066001)(6486002)(6916009)(6116002)(3846002)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB2973;H:MN2PR12MB3373.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FfWEDC7UV7Ay3vrXArnwKldqPg9WjF7CrAAvg2aoR4b4mSUQ2ZsL8bRiQNIVVEFuOaIDLWB7lbTJfUpRf39cG3yx4nNt4PEL/jgBde3M9YhZ7yeeXyYbuGbSqoXuK3B+C85v6zVkpcz3h0XF6WBnWuFSYZLqSUm3axKNd5lj4mb9hftq2VLlQoGP10F4F+Fk3yRYgTPDdGOyUY0TnJLvVkWM0KwMYnscCqEuxElBkp9gQ21Jn99kbVtnpst1eOmCh3X2ddQUTxd2Po7BfIhjVRpwgM/DyvuyJyK1Jnn0q925XgFFgrzUsBhVKFSyOp4KXGLYTPf5ka2lZO3WSvTHadMSPcuqWBhi3hwnJtmv3KjDPiN0t+Cd3Gf3fcQON1emQ8xtRlaZZN5H+Dge6hK2YJtjZJasgvu27d0YC5uAKGg=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 550ac9ef-60d7-407f-99f4-08d737702222
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2019 10:58:24.8230
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6YS05PqXgO8wGZpMNewCapXrbBgPyOADHPA88b1yjpBeobNnaunHDRU6qI9ppkMDK/WBDGzJS0M755SdUxDU+KsC9rX2Zda+b7Pl0DzIYHY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2973
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-12_05:2019-09-11,2019-09-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 mlxlogscore=944 phishscore=0 bulkscore=0 impostorscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1906280000
 definitions=main-1909120116
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Disable i2c mux for supported 9xxx chips. This is a
pre-requesite for controling 9xxx magnetometer using the
i2c master of the chip.

Check in device-tree that there is no i2c-gate device declared
for ensuring backward compatibility with existing setups.

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c |  7 +--
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c  | 60 +++++++++++++++++++---
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  |  2 +
 3 files changed, 58 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/i=
nv_mpu6050/inv_mpu_core.c
index b17f060b52fc..7b2e4d81bbba 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -1156,9 +1156,6 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq=
, const char *name,
 		return result;
 	}
=20
-	if (inv_mpu_bus_setup)
-		inv_mpu_bus_setup(indio_dev);
-
 	dev_set_drvdata(dev, indio_dev);
 	indio_dev->dev.parent =3D dev;
 	/* name will be NULL when enumerated via ACPI */
@@ -1167,6 +1164,10 @@ int inv_mpu_core_probe(struct regmap *regmap, int ir=
q, const char *name,
 	else
 		indio_dev->name =3D dev_name(dev);
=20
+	/* requires parent device set in indio_dev */
+	if (inv_mpu_bus_setup)
+		inv_mpu_bus_setup(indio_dev);
+
 	if (chip_type =3D=3D INV_ICM20602) {
 		indio_dev->channels =3D inv_icm20602_channels;
 		indio_dev->num_channels =3D ARRAY_SIZE(inv_icm20602_channels);
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c b/drivers/iio/imu/in=
v_mpu6050/inv_mpu_i2c.c
index 4b8b5a87398c..389cc8505e0e 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
@@ -68,6 +68,56 @@ static const char *inv_mpu_match_acpi_device(struct devi=
ce *dev,
 	return dev_name(dev);
 }
=20
+static bool inv_mpu_i2c_aux_bus(struct device *dev)
+{
+	struct inv_mpu6050_state *st =3D iio_priv(dev_get_drvdata(dev));
+
+	switch (st->chip_type) {
+	case INV_ICM20608:
+	case INV_ICM20602:
+		/* no i2c auxiliary bus on the chip */
+		return false;
+	case INV_MPU9250:
+	case INV_MPU9255:
+		if (st->magn_disabled)
+			return true;
+		else
+			return false;
+	default:
+		return true;
+	}
+}
+
+/*
+ * MPU9xxx magnetometer support requires to disable i2c auxiliary bus supp=
ort.
+ * To ensure backward compatibility with existing setups, do not disable
+ * i2c auxiliary bus if it used.
+ * Check for i2c-gate node in devicetree and set magnetometer disabled.
+ * Only MPU6500 is supported by ACPI, no need to check.
+ */
+static int inv_mpu_magn_disable(struct iio_dev *indio_dev)
+{
+	struct inv_mpu6050_state *st =3D iio_priv(indio_dev);
+	struct device *dev =3D indio_dev->dev.parent;
+	struct device_node *mux_node;
+
+	switch (st->chip_type) {
+	case INV_MPU9250:
+	case INV_MPU9255:
+		mux_node =3D of_get_child_by_name(dev->of_node, "i2c-gate");
+		if (mux_node !=3D NULL) {
+			st->magn_disabled =3D true;
+			dev_warn(dev, "disable internal use of magnetometer\n");
+		}
+		of_node_put(mux_node);
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
 /**
  *  inv_mpu_probe() - probe function.
  *  @client:          i2c client.
@@ -112,17 +162,12 @@ static int inv_mpu_probe(struct i2c_client *client,
 	}
=20
 	result =3D inv_mpu_core_probe(regmap, client->irq, name,
-				    NULL, chip_type);
+				    inv_mpu_magn_disable, chip_type);
 	if (result < 0)
 		return result;
=20
 	st =3D iio_priv(dev_get_drvdata(&client->dev));
-	switch (st->chip_type) {
-	case INV_ICM20608:
-	case INV_ICM20602:
-		/* no i2c auxiliary bus on the chip */
-		break;
-	default:
+	if (inv_mpu_i2c_aux_bus(&client->dev)) {
 		/* declare i2c auxiliary bus */
 		st->muxc =3D i2c_mux_alloc(client->adapter, &client->dev,
 					 1, 0, I2C_MUX_LOCKED | I2C_MUX_GATE,
@@ -137,7 +182,6 @@ static int inv_mpu_probe(struct i2c_client *client,
 		result =3D inv_mpu_acpi_create_mux_client(client);
 		if (result)
 			goto out_del_mux;
-		break;
 	}
=20
 	return 0;
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/in=
v_mpu6050/inv_mpu_iio.h
index db1c6904388b..cbbb2fb8949a 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
@@ -125,6 +125,7 @@ struct inv_mpu6050_hw {
  *  @it_timestamp:	timestamp from previous interrupt.
  *  @data_timestamp:	timestamp for next data sample.
  *  @vddio_supply	voltage regulator for the chip.
+ *  @magn_disabled:     magnetometer disabled for backward compatibility r=
eason.
  */
 struct inv_mpu6050_state {
 	struct mutex lock;
@@ -146,6 +147,7 @@ struct inv_mpu6050_state {
 	s64 it_timestamp;
 	s64 data_timestamp;
 	struct regulator *vddio_supply;
+	bool magn_disabled;
 };
=20
 /*register and associated bit definition*/
--=20
2.17.1

