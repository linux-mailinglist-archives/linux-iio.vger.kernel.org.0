Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4644A154249
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2020 11:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbgBFKqE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 6 Feb 2020 05:46:04 -0500
Received: from mx0b-00328301.pphosted.com ([148.163.141.47]:11984 "EHLO
        mx0b-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726365AbgBFKqD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 6 Feb 2020 05:46:03 -0500
X-Greylist: delayed 826 seconds by postgrey-1.27 at vger.kernel.org; Thu, 06 Feb 2020 05:46:01 EST
Received: from pps.filterd (m0156136.ppops.net [127.0.0.1])
        by mx0b-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 016AWAJ5004840;
        Thu, 6 Feb 2020 02:32:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=pfpt1; bh=tjxnrRPjQ+A7GFLcsxMiyglUVkEQEcTyrM/9R+a8q0Q=;
 b=IpS8NpDcgIxUXYrzDlZVM+JDQgvec+YeytMSsHoiIq190VwCi12dft9uQ04DXupKOIL6
 1QCQ5V9Hq0GyBYC3kHvV/4PvTAcBT6OcOGV5sLluQYneY0rzBcDgLxl18cZizMI4XcJD
 HuGxknK4sxX//1GdUs8jkjY/7qB0lTwcTeQOOxWKWgqlr6WBScwgLm+pX2kleZ20Uf8l
 GaywlyMiKSPskWS9EychW0c3hwLDGe5bOHKUvBmrSb3QjHSwkX7SKCZOY4HJf/u4dNTN
 yW9F8yMb0GCr6VeinqkfpQk/OfIVWjdg9/hs+XLOXpscsmi7A9l7WKlwjnwIyPAeKwxl uA== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by mx0b-00328301.pphosted.com with ESMTP id 2y0e4sg2cj-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Feb 2020 02:32:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nFUoi9lxeJi5sjYvLW40GQfQiZUJSDRJH894r0y14VIcMarZDKlZ5b84rSX+G/5Vs+K4BhUrf6zakNIY7gjSVHSXvBk0SoEHeAiZuj+I+WWQl7mfKlWMA9M8thvfzYCDnQaA4JAi+/c4CZIKfIgDN9djcFBPeu1K2aNJLC3/a71UylQlobfxx40pZTBs++w3OUG3IcvpouYgco1oRbmA9psLZkrps1LTuH1Cqb+SkmcpHy+IjIkgzrdFkzTr4Tew/0kYMrbtEe3+vXKs/JZPV6HRrYzJk7Frgyj/SgTZK/PQ2Qcy5AppVS140azdQUDdks+gegBEIEqDlNLHpCj6TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tjxnrRPjQ+A7GFLcsxMiyglUVkEQEcTyrM/9R+a8q0Q=;
 b=Sbfhymel8bbtiYsAOdR7myuJ3GLFuhqhjVuiXjjbaW0/MWrplJL/FR1S7N9fhjFpRJf3yACO56Q6/X7xhk3e4dIk26fnB9kle46IKjeRXeIKKvXV+l0ODpyKrIUPzX8KvyRbJ0NfN8MwPwXtn2KTj4j231tiMQcWpY81vdPdfCjN5/5Oz0wKY/QoRW3weexAJefKIxvYm8dh6l07wmfyMJQ+GbNROrgf59eSjzRG4uCr/aQVJk3Ih1N9yPa85kJMz2F+fNZrfmnPkMeVjlOHpVXQvGqjLjsqeHroIO/9DxaSH7CVMDZ2MLDCE8vhkJEEg/+UwwK6KpmeCJykk84uDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tjxnrRPjQ+A7GFLcsxMiyglUVkEQEcTyrM/9R+a8q0Q=;
 b=kzl9nomjA3+kbzKX5e/dMioOiTHMrOm8nPLEyPgqciznU4/hTpY3zPU3dqZ/F/guEJAqxtsymMUatIvCpB0Z7uyFmAHI9miafFhFqsxMfoNwsxwzKCHCTqN5BewmyO+Ts+Jmr/KquuXNPxfbQx3xhi/OgoHiiHXQVL0Zn9KQR+g=
Received: from CH2PR12MB4181.namprd12.prod.outlook.com (20.180.6.144) by
 CH2PR12MB4085.namprd12.prod.outlook.com (20.180.16.201) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Thu, 6 Feb 2020 10:32:09 +0000
Received: from CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::c057:8a13:530a:4340]) by CH2PR12MB4181.namprd12.prod.outlook.com
 ([fe80::c057:8a13:530a:4340%5]) with mapi id 15.20.2707.023; Thu, 6 Feb 2020
 10:32:09 +0000
From:   Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH v2 1/6] iio: imu: inv_mpu6050: cleanup of/acpi support
Date:   Thu,  6 Feb 2020 11:31:00 +0100
Message-Id: <20200206103105.23666-2-jmaneyrol@invensense.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200206103105.23666-1-jmaneyrol@invensense.com>
References: <20200206103105.23666-1-jmaneyrol@invensense.com>
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0334.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a4::34) To CH2PR12MB4181.namprd12.prod.outlook.com
 (2603:10b6:610:a8::16)
MIME-Version: 1.0
Received: from frgnb-12nlpn2.invcorp.invensense.com (77.157.193.39) by LO2P265CA0334.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:a4::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.21 via Frontend Transport; Thu, 6 Feb 2020 10:32:07 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [77.157.193.39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d91429e7-1ecb-47b7-629c-08d7aaefd1ad
X-MS-TrafficTypeDiagnostic: CH2PR12MB4085:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB40852C27E2BDBFE722D95CF1C41D0@CH2PR12MB4085.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0305463112
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(39850400004)(396003)(366004)(136003)(376002)(199004)(189003)(478600001)(2616005)(956004)(86362001)(2906002)(26005)(5660300002)(186003)(16526019)(107886003)(6666004)(6486002)(1076003)(81156014)(8676002)(81166006)(4326008)(8936002)(36756003)(54906003)(52116002)(66476007)(316002)(66946007)(66556008)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR12MB4085;H:CH2PR12MB4181.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: invensense.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JQYBeoOj5kFM7H9/IeIg2ELCuu2//0k1F07yJMHVohAE0iyruuouPPH4rYo+9/vG0aN6WO4FcvEmJe+06YoEStpRwYVhTipefcqaKri6QJ/Q/CHLOHL61s23OZPxzZRmv6NNVth1H+AvxYjJYzSh7RfB2jPdfdHhsORYoLIkTnQLfW49D9rs+NsZ00g9qMmw722UcUCumcW50NwOtFb7ktaO+qVO5aod6vgWJj6BCYnLEhdP7YcHg5757ZjONrCUh9N5BvvfbqSHGyAPGdrP3OdUJOHmayGUGKUu678yprNw9TYo8zmR1G2HfEM62k6hhhvuqhhQEpyyZDvafg6p9NGZv5b/3DpZKPD8hFSIA4XmKuGTK7GohReX4Vr7Kcq/kbHlJzBT2MIQRJKdbA8AYWP1BW6Sx1fOiU8A3wN/j8ZPZLYbfGyk89iTnL/FCYrg
X-MS-Exchange-AntiSpam-MessageData: 6w1zWi8RKMJreeffSUAfZ0NgvCeLm/AzcgQYOifRAZLunnPO8wrsgrRH7viO7OStFO4la/9FzcqrHvlxdrl/1LWNofeb0TIk+PKuANzU1lRFKEUgcon2ANk41MjkxA+uHd9nB7l2BF0nNuVjjQ4NAg==
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d91429e7-1ecb-47b7-629c-08d7aaefd1ad
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2020 10:32:08.9952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rTz+9yBRdp1vZnErg4ZJ60XtNo0bevytF+5+dBNPMqKCcQ9aXYPGxftMGGTlhTfNNPgmOuOokqzMf+57bDNQdQAXSo4nK2UZCWtbeikTLSw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4085
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-06_01:2020-02-06,2020-02-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 phishscore=0 spamscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002060081
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Use device_get_match_data for using of and acpi tables.
In spi support add missing mpu6515 and of match table.
Reorganize Kconfig to display chips grouped by generations.

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 drivers/iio/imu/inv_mpu6050/Kconfig       |  8 ++---
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c | 26 +++-----------
 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c | 44 +++++++++++++++++++++--
 3 files changed, 50 insertions(+), 28 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/Kconfig b/drivers/iio/imu/inv_mpu6050/Kconfig
index 017bc0fcc365..003134734646 100644
--- a/drivers/iio/imu/inv_mpu6050/Kconfig
+++ b/drivers/iio/imu/inv_mpu6050/Kconfig
@@ -15,8 +15,8 @@ config INV_MPU6050_I2C
 	select INV_MPU6050_IIO
 	select REGMAP_I2C
 	help
-	  This driver supports the Invensense MPU6050/6500/6515,
-	  MPU9150/9250/9255 and ICM20608/20602 motion tracking devices
+	  This driver supports the Invensense MPU6050/9150,
+	  MPU6500/6515/9250/9255, ICM20608 and ICM20602 motion tracking devices
 	  over I2C.
 	  This driver can be built as a module. The module will be called
 	  inv-mpu6050-i2c.
@@ -27,8 +27,8 @@ config INV_MPU6050_SPI
 	select INV_MPU6050_IIO
 	select REGMAP_SPI
 	help
-	  This driver supports the Invensense MPU6000/6500/6515,
-	  MPU9250/9255 and ICM20608/20602 motion tracking devices
+	  This driver supports the Invensense MPU6000,
+	  MPU6500/6515/9250/9255, ICM20608 and ICM20602 motion tracking devices
 	  over SPI.
 	  This driver can be built as a module. The module will be called
 	  inv-mpu6050-spi.
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
index f47a28b4be23..49e9aa777ba4 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
@@ -10,6 +10,7 @@
 #include <linux/iio/iio.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
+#include <linux/property.h>
 #include "inv_mpu_iio.h"
 
 static const struct regmap_config inv_mpu_regmap_config = {
@@ -54,20 +55,6 @@ static int inv_mpu6050_deselect_bypass(struct i2c_mux_core *muxc, u32 chan_id)
 	return 0;
 }
 
-static const char *inv_mpu_match_acpi_device(struct device *dev,
-					     enum inv_devices *chip_id)
-{
-	const struct acpi_device_id *id;
-
-	id = acpi_match_device(dev->driver->acpi_match_table, dev);
-	if (!id)
-		return NULL;
-
-	*chip_id = (int)id->driver_data;
-
-	return dev_name(dev);
-}
-
 static bool inv_mpu_i2c_aux_bus(struct device *dev)
 {
 	struct inv_mpu6050_state *st = iio_priv(dev_get_drvdata(dev));
@@ -130,6 +117,7 @@ static int inv_mpu_magn_disable(struct iio_dev *indio_dev)
 static int inv_mpu_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
+	const void *match;
 	struct inv_mpu6050_state *st;
 	int result;
 	enum inv_devices chip_type;
@@ -140,18 +128,14 @@ static int inv_mpu_probe(struct i2c_client *client,
 				     I2C_FUNC_SMBUS_I2C_BLOCK))
 		return -EOPNOTSUPP;
 
-	if (client->dev.of_node) {
-		chip_type = (enum inv_devices)
-			of_device_get_match_data(&client->dev);
+	match = device_get_match_data(&client->dev);
+	if (match) {
+		chip_type = (enum inv_devices)match;
 		name = client->name;
 	} else if (id) {
 		chip_type = (enum inv_devices)
 			id->driver_data;
 		name = id->name;
-	} else if (ACPI_HANDLE(&client->dev)) {
-		name = inv_mpu_match_acpi_device(&client->dev, &chip_type);
-		if (!name)
-			return -ENODEV;
 	} else {
 		return -ENOSYS;
 	}
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
index ec102d5a5c77..834bfa8e8684 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
@@ -4,6 +4,8 @@
 */
 #include <linux/module.h>
 #include <linux/acpi.h>
+#include <linux/of.h>
+#include <linux/property.h>
 #include <linux/spi/spi.h>
 #include <linux/regmap.h>
 #include <linux/iio/iio.h>
@@ -41,17 +43,18 @@ static int inv_mpu_i2c_disable(struct iio_dev *indio_dev)
 
 static int inv_mpu_probe(struct spi_device *spi)
 {
+	const void *match;
 	struct regmap *regmap;
 	const struct spi_device_id *spi_id;
-	const struct acpi_device_id *acpi_id;
 	const char *name = NULL;
 	enum inv_devices chip_type;
 
 	if ((spi_id = spi_get_device_id(spi))) {
 		chip_type = (enum inv_devices)spi_id->driver_data;
 		name = spi_id->name;
-	} else if ((acpi_id = acpi_match_device(spi->dev.driver->acpi_match_table, &spi->dev))) {
-		chip_type = (enum inv_devices)acpi_id->driver_data;
+	} else if ((match = device_get_match_data(&spi->dev))) {
+		chip_type = (enum inv_devices)match;
+		name = dev_name(&spi->dev);
 	} else {
 		return -ENODEV;
 	}
@@ -74,6 +77,7 @@ static int inv_mpu_probe(struct spi_device *spi)
 static const struct spi_device_id inv_mpu_id[] = {
 	{"mpu6000", INV_MPU6000},
 	{"mpu6500", INV_MPU6500},
+	{"mpu6515", INV_MPU6515},
 	{"mpu9250", INV_MPU9250},
 	{"mpu9255", INV_MPU9255},
 	{"icm20608", INV_ICM20608},
@@ -83,6 +87,39 @@ static const struct spi_device_id inv_mpu_id[] = {
 
 MODULE_DEVICE_TABLE(spi, inv_mpu_id);
 
+static const struct of_device_id inv_of_match[] = {
+	{
+		.compatible = "invensense,mpu6000",
+		.data = (void *)INV_MPU6000
+	},
+	{
+		.compatible = "invensense,mpu6500",
+		.data = (void *)INV_MPU6500
+	},
+	{
+		.compatible = "invensense,mpu6515",
+		.data = (void *)INV_MPU6515
+	},
+	{
+		.compatible = "invensense,mpu9250",
+		.data = (void *)INV_MPU9250
+	},
+	{
+		.compatible = "invensense,mpu9255",
+		.data = (void *)INV_MPU9255
+	},
+	{
+		.compatible = "invensense,icm20608",
+		.data = (void *)INV_ICM20608
+	},
+	{
+		.compatible = "invensense,icm20602",
+		.data = (void *)INV_ICM20602
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, inv_of_match);
+
 static const struct acpi_device_id inv_acpi_match[] = {
 	{"INVN6000", INV_MPU6000},
 	{ },
@@ -93,6 +130,7 @@ static struct spi_driver inv_mpu_driver = {
 	.probe		=	inv_mpu_probe,
 	.id_table	=	inv_mpu_id,
 	.driver = {
+		.of_match_table = inv_of_match,
 		.acpi_match_table = ACPI_PTR(inv_acpi_match),
 		.name	=	"inv-mpu6000-spi",
 		.pm     =       &inv_mpu_pmops,
-- 
2.17.1

