Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F61DB374A
	for <lists+linux-iio@lfdr.de>; Mon, 16 Sep 2019 11:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729477AbfIPJmC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Sep 2019 05:42:02 -0400
Received: from mx0a-00328301.pphosted.com ([148.163.145.46]:40440 "EHLO
        mx0a-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728525AbfIPJmB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Sep 2019 05:42:01 -0400
Received: from pps.filterd (m0156134.ppops.net [127.0.0.1])
        by mx0a-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8G9eoiR021660;
        Mon, 16 Sep 2019 02:42:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt1;
 bh=prb8IZ9lwHU14PLNCdQOHRz5berl0XmIoPzwvMU+hfI=;
 b=yasBWSaohTHrQqYL7FokfkWQILzQjSf5h9MijNLkwXe22QLFIKDOd+SvG8OgHlVm7Tb4
 KhIJGar8iCXgynCHOdI2DaxsEYsgFLbkv4Yah6uCgkWHuQwqJMKMVGtxE/TbgryXgQIN
 6Iq2Xftxo9zm9yZeWhnbkQxx3DkQXj5vYVwKZ3GsArA6DO08Cni/eazXQAsrk4i5csyo
 jHSXxpB9J4iXxt2EZPpndoUQ9KIq91n5EeGp84SEyXz+f3wIzak1M5iMw+pwfBUNd7uJ
 8B+OFhmbh0h9yM3bo2/6sQCrwlo+tFQ+HulFi0E1Lg9wzPA9cYI2FRwvcvITLeZuhW+f fw== 
Received: from nam01-by2-obe.outbound.protection.outlook.com (mail-by2nam01lp2058.outbound.protection.outlook.com [104.47.34.58])
        by mx0a-00328301.pphosted.com with ESMTP id 2v0upprng7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 16 Sep 2019 02:42:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oGa/WxHjJ5VX7YV5/rm2uhnBU0T2e1dico2dZr7sYqFIiHGpSOzvZwZCFRJbHZBELq4ew0m3FFftxOwOChOgesifUy411i2tb7ZrL1ZTGz5G50LNIWYwLDSIDDGDqsR5JvKhMWXVBKT8Ef97HbKuk402AU6B/CQrv97tDcU9tLIxRIvQ2mjDJZqiCIKJshJQJQoEOFGIqFnDGwrPnscko/7GWrI6lS7XLQ3JryU+DokjG8WF9syfL7qcIZ88cSGo/MkzjaiC+1Ic/lsaB+8/fZcCATzVguaR1CdHfn/oSV8SHKg9ZzYMaJ9AA7knxDer7c5r3kUixouhOm1VNF/kpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=prb8IZ9lwHU14PLNCdQOHRz5berl0XmIoPzwvMU+hfI=;
 b=RC0AwAXrD0mn+grSgw1SEyUmQ6duAL7SYJi0Eq5sR9UK+65L9i4b+ffITx7xZgDf8TB0MWPQhwXCWwJS4pSGfW7DwglchBKVakeYtwJLdOUYO9ktuKUBhHFXoqO5lq7xCvq2Ns/cT/l2bmQUvTw6wYCND4PS1s7ILazS/oKv/g6eMOILZT4z0B0pUegog9uwOlXC9Ck2emblxouKXwPbw8xXS8T68oOI4rI7CfDstZB0JuoAyAa06RxNJ4LCtkO4C9H96e2ej3B2g953LTl4nZmgl1YuWoEVusIfnZc2hFY5uxi0A7QaAAaD+NF9xIdY533QYO0PjfGjmt0dlPOXQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=prb8IZ9lwHU14PLNCdQOHRz5berl0XmIoPzwvMU+hfI=;
 b=WoszeIKjPXm6eGwJnPiJyMqDLkJQCaHe6jr0IEAQI1wJO2B/IHCMDTd/6Bd+INGw8eJo3mjtbQpqY/EccTwgTFZIo0IogZX2Olz/ou3CQX6ilsr01Kr0TOAj8jySIywyzkNwJT1veMKf4hZmIAO7ph4oXXQyRdfiCHrP9bmoRvM=
Received: from BYAPR12MB3366.namprd12.prod.outlook.com (20.178.55.207) by
 BYAPR12MB2632.namprd12.prod.outlook.com (20.176.255.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.15; Mon, 16 Sep 2019 09:41:59 +0000
Received: from BYAPR12MB3366.namprd12.prod.outlook.com
 ([fe80::1c84:7948:a3:34fa]) by BYAPR12MB3366.namprd12.prod.outlook.com
 ([fe80::1c84:7948:a3:34fa%3]) with mapi id 15.20.2263.023; Mon, 16 Sep 2019
 09:41:59 +0000
From:   Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To:     "jic23@kernel.org" <jic23@kernel.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
Subject: [PATCH v3 1/7] iio: imu: inv_mpu6050: disable i2c mux for MPU925x
Thread-Topic: [PATCH v3 1/7] iio: imu: inv_mpu6050: disable i2c mux for
 MPU925x
Thread-Index: AQHVbHL8yT5/CVGTJkaR7dexbgZYLQ==
Date:   Mon, 16 Sep 2019 09:41:58 +0000
Message-ID: <20190916094128.30122-2-jmaneyrol@invensense.com>
References: <20190916094128.30122-1-jmaneyrol@invensense.com>
In-Reply-To: <20190916094128.30122-1-jmaneyrol@invensense.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR02CA0050.namprd02.prod.outlook.com
 (2603:10b6:a03:54::27) To BYAPR12MB3366.namprd12.prod.outlook.com
 (2603:10b6:a03:a9::15)
x-originating-ip: [77.157.193.39]
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a311a47e-c83c-4269-bd6c-08d73a8a1e4c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR12MB2632;
x-ms-traffictypediagnostic: BYAPR12MB2632:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB26329A7A5F358ED2E1ECDF08C48C0@BYAPR12MB2632.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0162ACCC24
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(39850400004)(346002)(366004)(136003)(189003)(199004)(81166006)(99286004)(3846002)(5660300002)(66066001)(2616005)(54906003)(5640700003)(316002)(6916009)(36756003)(71200400001)(6512007)(11346002)(446003)(102836004)(26005)(6486002)(6506007)(2501003)(71190400001)(386003)(2906002)(6436002)(1076003)(305945005)(4326008)(53936002)(7736002)(186003)(6116002)(81156014)(8676002)(52116002)(107886003)(66476007)(25786009)(66446008)(76176011)(2351001)(66946007)(66556008)(8936002)(64756008)(50226002)(80792005)(256004)(14444005)(14454004)(476003)(486006)(86362001)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB2632;H:BYAPR12MB3366.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FJN2t6VJvDKSj1oQcwklUYx/vbMIMJN4ZLkowt6VKXQnt6tIT/rFBLyaeGs4OQ8KuGirKf5NiRBxifLAE53F7wQXGp/HeijDA4yB1DCzIYGhsYXPr28VjEgCdPA/gPzg7sZps40KhbnzLr9RbUSSYUfLRAJCpuRx0/74dT0bSfj4QANV/g3whAm/8qj9usuoPTDT9TleO3Vjp+jGcAaZad/Fs6yTkZcLQPi9M2HSlOEnThdG4TeusAYIVWIXzRapA2MSufjFujM/ktghOeYyEHE7TD7u9A6GtxV7v9PiFSFKgfXqKFfWq8NfQkzIfgEx0pagrpSz3BkDMzBHo7XKSffp72bImZgXRtn8SxDGahZOmRl2wq5n8FIt3UtYID0t/YE7a26W0BN5zTNGJrJU4sSKNalaKEydlLnzHxMql5U=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a311a47e-c83c-4269-bd6c-08d73a8a1e4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2019 09:41:58.8785
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3a4BODbL5vvcw8j+aUcqy/b/oSoP63ML++oG1/ohEpUO800wxp3pfRQU7pQmvK463FoTiUPcoaFrhOw4IxSK9TLQYkT1C0kfTTwO+3tibHE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2632
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-16_05:2019-09-11,2019-09-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=965
 priorityscore=1501 malwarescore=0 spamscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 impostorscore=0 mlxscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1908290000
 definitions=main-1909160102
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

