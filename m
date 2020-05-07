Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A50C91C9081
	for <lists+linux-iio@lfdr.de>; Thu,  7 May 2020 16:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbgEGOnx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 7 May 2020 10:43:53 -0400
Received: from mx0b-00328301.pphosted.com ([148.163.141.47]:42036 "EHLO
        mx0b-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727772AbgEGOn2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 7 May 2020 10:43:28 -0400
Received: from pps.filterd (m0156136.ppops.net [127.0.0.1])
        by mx0b-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 047EeBqA009573;
        Thu, 7 May 2020 07:43:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=pfpt1; bh=ih1YAq1tAzzkOsqsEijrLmTMFDUFg046Zw65ZJPQDcA=;
 b=L8BCBt/HD5Yi1d2OQEWJVhDSXJvSbYAFpXcDzL2J/PUcuLsEgCXujBRdgAZ43UOd6sDS
 nwrM1CxLHjfZ0FzSovZqpjwduloZdk/x8Ohep4l+X5Xn3O5J8CG0Ip45qjnDmZlHrP8B
 FI2sv2pGsEiaQqL9N9WRpkGtYCep5iUVUj6xzIcV8+EvhaJLBH/w29YgeJsRfuEvvWGC
 KBHFXnU+NBHJ0y8TqNIVZ1FnaBztLTD/6c9oapLXGKos0e1xrLSkjlumKmWQ1gpSROMR
 h3TWQ2xILJc8ZEcQ6T9gm+C+LaT6FaPbZsr+epwui9ntQEu+cexwyv4jL5bUqIdJIy/X NA== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by mx0b-00328301.pphosted.com with ESMTP id 30s4tnatwt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 May 2020 07:43:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TFg60S44u7LiMyLEFD33o1GrLIgfoWh3s9WuhOv/YFKWAVK/F/77J2a08+yrgP3wQFqu4kQlvW1s+hW0felAboLu071zWaZ5kcsR5mK95pGh/6vHuOwp8mBRDvkVCOoo4xPbUg9ytjvJ2jJQX8VdFSSZte6YobNMJNJYiB3egcuQELpAd8VV/UCbnq7BUDVdOZ5D+Dhc59boIL6iK5WlqkThR+/x4+Yt79l8kDzrwxOtICkyuTL4iQKm1cjSdOBPp3D0adjDIZU0KZR6gcZy8ywIgC3xEK3DuY1+2ANPCQCEDvQ3KsU9tAOtRb6cgtgspVhSlvX5gugV3vA/0B1Iyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ih1YAq1tAzzkOsqsEijrLmTMFDUFg046Zw65ZJPQDcA=;
 b=XPPHI7mTboz6FwTY7rhkE17iclkakNa7sLARLaJRTiuhIDHn6xSBiUruCi9MxvUHSawEOpGRxSz2I6U3eWkEwK48cnF3Dcbfhw9SSqzEDHGmIrrV8DPefNtSPx8AjDqL4+sVSUGjvxCnGuZTMMoKqd1eWdNufxR68d/dYJL6cHBixfBFPwKjeA1ulSpw445Xv9yKNdgt/glXhDWoh5QvcyFW3UPpKPYYhzme3WGIsmyOvLcJfn1fXsvrF5/OQhI6NeKBOfKubQ2dvA2XoGbKVEbszxzxGSgvH2HOQNrFRyfI9TpYF/vPaQ2wWR2Cu7s/T4wTiwncsvRrudzVqbfOeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ih1YAq1tAzzkOsqsEijrLmTMFDUFg046Zw65ZJPQDcA=;
 b=LOqqPwc8yPOwmt/v1ogCKh6TgfYot3MZ26UO/eXw0AV7trKKomP/Fqpgy8noo+zS+11kaD2a9lz0soys3kgURiFcWrSLEtBFAbvWxSGzlUSrhXQDi4PeNJqbUpPFmHYlohH5hqLKAaKnfPDU/GF4F28hi3vypDx2thSxLCBGRs4=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=invensense.com;
Received: from MN2PR12MB4422.namprd12.prod.outlook.com (2603:10b6:208:265::9)
 by MN2PR12MB4501.namprd12.prod.outlook.com (2603:10b6:208:269::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.27; Thu, 7 May
 2020 14:43:21 +0000
Received: from MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::7471:da8b:8ca1:6af0]) by MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::7471:da8b:8ca1:6af0%4]) with mapi id 15.20.2979.028; Thu, 7 May 2020
 14:43:21 +0000
From:   Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To:     jic23@kernel.org, robh+dt@kernel.org, robh@kernel.org,
        mchehab+huawei@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH 08/12] iio: imu: inv_icm42600: add device interrupt trigger
Date:   Thu,  7 May 2020 16:42:18 +0200
Message-Id: <20200507144222.20989-9-jmaneyrol@invensense.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200507144222.20989-1-jmaneyrol@invensense.com>
References: <20200507144222.20989-1-jmaneyrol@invensense.com>
Content-Type: text/plain
X-ClientProxiedBy: LNXP265CA0048.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::36) To MN2PR12MB4422.namprd12.prod.outlook.com
 (2603:10b6:208:265::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from frgnb-buildozer.invcorp.invensense.com (77.157.193.39) by LNXP265CA0048.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:5c::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26 via Frontend Transport; Thu, 7 May 2020 14:43:20 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [77.157.193.39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f005aa3b-a0ca-4e9d-46c4-08d7f294fd49
X-MS-TrafficTypeDiagnostic: MN2PR12MB4501:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4501B1D59F455F1F964F2622C4A50@MN2PR12MB4501.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1002;
X-Forefront-PRVS: 03965EFC76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HyIiqtPdqg5VLOw2UAm9MoEkgH7uH9FfNpvxzKW62wnuwCR77XgeIi9/+zMN4Y/05QHKQlGCrrAJfo3ehwGJtfTvvlM1Ashx46rNUKwfZ+WdLT3o4kPkzyLTSVegGi89gK9l3wFQyXOTzgtl3i2LJo1FSE/JhBUuhT9LRB0PdJSejLYjgAMNioT6R1fwj0Z4wtizhHnepSPFkRfjpsMJL59XxUnSWyAjq3EtbtWHcLXqXlLPWBogN/b3Frv3+vxIwpqHKJKtLeWxjpqDOYCVGdqY9tyv2j/RrEu/Jv31LqiTEADMd3Ep1fCHkSDDmFW9zfoDZ03AN52ByAbzoKG5mN5hzTmXcHxPXjtFlg8HA7e+4ZRNBVX4c7N+srV6506IVeWrQydG4MNaRgsktbRZmh52kTW4WLmATIg2bgOC0czPOJZAdJukrQHtcPcdc8P6uFsJFOuAujjjjew5YqysLA84DH3JVhfGXcTBidYBlCiMPDSXeoDYaGepQCN3TiW7eSvTWCRi7+qq1dx8HDt2gg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4422.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(376002)(136003)(396003)(39850400004)(366004)(33430700001)(30864003)(107886003)(4326008)(8676002)(6486002)(2906002)(316002)(5660300002)(8936002)(1076003)(26005)(7696005)(33440700001)(66946007)(956004)(66476007)(52116002)(2616005)(86362001)(186003)(83320400001)(83280400001)(83310400001)(83290400001)(16526019)(478600001)(36756003)(66556008)(83300400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: pQ2MFB/iJMRP0dyD9fA9JvFXk6r/oO2gC+c7pIMypu6yrWRzvCQY4x3daL5znfrEiS6J284i9DzJmf96dFZ3Txj/VFc1+3XCJp1adLs2eI4sTvSewXqNfpyNssEFxfhyAjw44L61gsyyjdKjhr0fYMi//rhGFKywcEsuGQfaxprys+gb+9sFP94pRpgiOjFmG/b0Ry2lj06i5F2GvWqPg5PsIn8vLHMF8RNcbPPcbCm9FjCjCvgV8nxOmWfhDgfsTugnHRhLYYrlo4DG2RVXYxAPWmRqX6VGRcEq+AqjyxhZ244YBY+XVO7aiLmJynEscNr3xhQ9W+ND8O0nAR+k0fQsZD5ad/FQI25XjeJGgXMYcbAQXBJNitgETBjhqUSaBx9I7omVTl4EfeAdJYVGNjGMQ+MbUAEIm7eLXBvVMECMfwRck8GbpLYGVq8iIbq8U0R//K9mDCvU6Ef120V5o5DPBaS/97D8OHubf10Ykp7mcdyL+ciMbtlWrifdZtTA/SlWHLsan+tCen514vZlJPxlLkCDQAh77jM7U1dP3enS6mzdym++RJBoh1jAvfA7vmjgaWmi/bXHgEHaAV8tD+OjNNaJ5LuEPDIWfslZsR7+yaL+Z7vf73FX477lT5euYCOWKnqrOMZ6GZwRqju+w4jUT28dTQ/G9MH2c3oUrbbGcipuO8fJRaGbGWqAToztyuxYQPrRbw6PemT1zGiMtsu3MuotzaQKabrvftHeBE+ibZgA2mygYjvJVrGrHSYRCqhen0hIbMqhJ3RKgnLMUtf3T5Kr3oZ7xyHfo4WhtSU=
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f005aa3b-a0ca-4e9d-46c4-08d7f294fd49
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2020 14:43:21.8945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ta1NYNfFrDoQAUUrOVOhssculqqBJctyfefdTkmXZcmcWoMQjY1Q/qQlSB9LDOGeVjqjEixYQvkp7fyYZsWG2/+YebKSUEwE92VANtp2W5o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4501
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-07_09:2020-05-07,2020-05-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 priorityscore=1501 spamscore=0 mlxlogscore=999 impostorscore=0
 suspectscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005070118
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add INT1 interrupt support and use it as an iio trigger.
Support interrupt edge and level, active high or low.
Push-pull configuration only.

Trigger enables FIFO and will be useful with buffer support.

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 drivers/iio/imu/inv_icm42600/Kconfig          |   1 +
 drivers/iio/imu/inv_icm42600/Makefile         |   1 +
 drivers/iio/imu/inv_icm42600/inv_icm42600.h   |   8 +-
 .../iio/imu/inv_icm42600/inv_icm42600_core.c  |  19 +-
 .../iio/imu/inv_icm42600/inv_icm42600_i2c.c   |   2 +-
 .../iio/imu/inv_icm42600/inv_icm42600_spi.c   |   2 +-
 .../imu/inv_icm42600/inv_icm42600_trigger.c   | 177 ++++++++++++++++++
 7 files changed, 206 insertions(+), 4 deletions(-)
 create mode 100644 drivers/iio/imu/inv_icm42600/inv_icm42600_trigger.c

diff --git a/drivers/iio/imu/inv_icm42600/Kconfig b/drivers/iio/imu/inv_icm42600/Kconfig
index 22390a72f0a3..7b3eaeb2aa4a 100644
--- a/drivers/iio/imu/inv_icm42600/Kconfig
+++ b/drivers/iio/imu/inv_icm42600/Kconfig
@@ -2,6 +2,7 @@
 
 config INV_ICM42600
 	tristate
+	select IIO_TRIGGER
 
 config INV_ICM42600_I2C
 	tristate "InvenSense ICM-426xx I2C driver"
diff --git a/drivers/iio/imu/inv_icm42600/Makefile b/drivers/iio/imu/inv_icm42600/Makefile
index 48965824f00c..e1f2aacbe888 100644
--- a/drivers/iio/imu/inv_icm42600/Makefile
+++ b/drivers/iio/imu/inv_icm42600/Makefile
@@ -5,6 +5,7 @@ inv-icm42600-y += inv_icm42600_core.o
 inv-icm42600-y += inv_icm42600_gyro.o
 inv-icm42600-y += inv_icm42600_accel.o
 inv-icm42600-y += inv_icm42600_temp.o
+inv-icm42600-y += inv_icm42600_trigger.o
 
 obj-$(CONFIG_INV_ICM42600_I2C) += inv-icm42600-i2c.o
 inv-icm42600-i2c-y += inv_icm42600_i2c.o
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
index bc963b3d1800..175c1f67faee 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600.h
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
@@ -13,6 +13,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/pm.h>
 #include <linux/iio/iio.h>
+#include <linux/iio/trigger.h>
 
 enum inv_icm42600_chip {
 	INV_CHIP_ICM42600,
@@ -122,6 +123,7 @@ struct inv_icm42600_suspended {
  *  @suspended:		suspended sensors configuration.
  *  @indio_gyro:	gyroscope IIO device.
  *  @indio_accel:	accelerometer IIO device.
+ *  @trigger:		device internal interrupt trigger
  */
 struct inv_icm42600_state {
 	struct mutex lock;
@@ -135,6 +137,7 @@ struct inv_icm42600_state {
 	struct inv_icm42600_suspended suspended;
 	struct iio_dev *indio_gyro;
 	struct iio_dev *indio_accel;
+	struct iio_trigger *trigger;
 };
 
 /* Virtual register addresses: @bank on MSB (4 upper bits), @address on LSB */
@@ -370,11 +373,14 @@ int inv_icm42600_set_temp_conf(struct inv_icm42600_state *st, bool enable,
 int inv_icm42600_debugfs_reg(struct iio_dev *indio_dev, unsigned int reg,
 			     unsigned int writeval, unsigned int *readval);
 
-int inv_icm42600_core_probe(struct regmap *regmap, int chip,
+int inv_icm42600_core_probe(struct regmap *regmap, int chip, int irq,
 			    inv_icm42600_bus_setup bus_setup);
 
 int inv_icm42600_gyro_init(struct inv_icm42600_state *st);
 
 int inv_icm42600_accel_init(struct inv_icm42600_state *st);
 
+int inv_icm42600_trigger_init(struct inv_icm42600_state *st, int irq,
+			      int irq_type);
+
 #endif
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
index 4e33f263d3ea..1102c54396e3 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -447,11 +447,13 @@ static void inv_icm42600_disable_pm(void *_data)
 	pm_runtime_disable(dev);
 }
 
-int inv_icm42600_core_probe(struct regmap *regmap, int chip,
+int inv_icm42600_core_probe(struct regmap *regmap, int chip, int irq,
 			    inv_icm42600_bus_setup bus_setup)
 {
 	struct device *dev = regmap_get_device(regmap);
 	struct inv_icm42600_state *st;
+	struct irq_data *irq_desc;
+	int irq_type;
 	int ret;
 
 	BUILD_BUG_ON(ARRAY_SIZE(inv_icm42600_hw) != INV_CHIP_NB);
@@ -460,6 +462,16 @@ int inv_icm42600_core_probe(struct regmap *regmap, int chip,
 		return -ENODEV;
 	}
 
+	/* get irq data, set trigger falling by default */
+	irq_desc = irq_get_irq_data(irq);
+	if (!irq_desc) {
+		dev_err(dev, "could not find IRQ %d\n", irq);
+		return -EINVAL;
+	}
+	irq_type = irqd_get_trigger_type(irq_desc);
+	if (!irq_type)
+		irq_type = IRQF_TRIGGER_FALLING;
+
 	st = devm_kzalloc(dev, sizeof(*st), GFP_KERNEL);
 	if (!st)
 		return -ENOMEM;
@@ -503,6 +515,11 @@ int inv_icm42600_core_probe(struct regmap *regmap, int chip,
 	if (ret)
 		return ret;
 
+	/* setup interrupt trigger */
+	ret = inv_icm42600_trigger_init(st, irq, irq_type);
+	if (ret)
+		return ret;
+
 	/* create and init gyroscope iio device */
 	ret = inv_icm42600_gyro_init(st);
 	if (ret)
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
index b61f993beacf..b1478ece43f6 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
@@ -70,7 +70,7 @@ static int inv_icm42600_probe(struct i2c_client *client,
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
 
-	return inv_icm42600_core_probe(regmap, chip,
+	return inv_icm42600_core_probe(regmap, chip, client->irq,
 				       inv_icm42600_i2c_bus_setup);
 }
 
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
index 835ced68a3a3..ec784f9e3c2c 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
@@ -70,7 +70,7 @@ static int inv_icm42600_probe(struct spi_device *spi)
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
 
-	return inv_icm42600_core_probe(regmap, chip,
+	return inv_icm42600_core_probe(regmap, chip, spi->irq,
 				       inv_icm42600_spi_bus_setup);
 }
 
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_trigger.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_trigger.c
new file mode 100644
index 000000000000..7a5e76305f0b
--- /dev/null
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_trigger.c
@@ -0,0 +1,177 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2020 Invensense, Inc.
+ */
+
+#include <linux/device.h>
+#include <linux/mutex.h>
+#include <linux/interrupt.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/trigger_consumer.h>
+
+#include "inv_icm42600.h"
+
+static irqreturn_t inv_icm42600_trigger_timestamp(int irq, void *_data)
+{
+	struct inv_icm42600_state *st = _data;
+
+	if (st->indio_gyro)
+		iio_pollfunc_store_time(irq, st->indio_gyro->pollfunc);
+	if (st->indio_accel)
+		iio_pollfunc_store_time(irq, st->indio_accel->pollfunc);
+
+	return IRQ_WAKE_THREAD;
+}
+
+static irqreturn_t inv_icm42600_trigger_int_handler(int irq, void *_data)
+{
+	struct inv_icm42600_state *st = _data;
+	struct device *dev = regmap_get_device(st->map);
+	unsigned int status;
+	int ret;
+
+	mutex_lock(&st->lock);
+
+	ret = regmap_read(st->map, INV_ICM42600_REG_INT_STATUS, &status);
+	if (ret)
+		goto out_unlock;
+	dev_dbg(dev, "int_status = %#02x\n", status);
+
+	/* FIFO full */
+	if (status & INV_ICM42600_INT_STATUS_FIFO_FULL)
+		dev_warn(dev, "FIFO full data lost!\n");
+
+	/* FIFO threshold reached */
+	if (status & INV_ICM42600_INT_STATUS_FIFO_THS)
+		iio_trigger_poll_chained(st->trigger);
+
+out_unlock:
+	mutex_unlock(&st->lock);
+	return IRQ_HANDLED;
+}
+
+static int inv_icm42600_trigger_set_state(struct iio_trigger *trig, bool state)
+{
+	struct inv_icm42600_state *st = iio_trigger_get_drvdata(trig);
+	unsigned int val;
+	uint16_t dummy;
+	int ret;
+
+	mutex_lock(&st->lock);
+
+	/*
+	 * IIO buffers preenable and postdisable are managing power on/off.
+	 * update_scan_mode is setting data FIFO enabled.
+	 */
+	if (state) {
+		/* set FIFO threshold interrupt */
+		val = INV_ICM42600_INT_SOURCE0_FIFO_THS_INT1_EN;
+		ret = regmap_update_bits(st->map, INV_ICM42600_REG_INT_SOURCE0,
+					 val, val);
+		if (ret)
+			goto out_unlock;
+		/* flush FIFO data */
+		ret = regmap_write(st->map, INV_ICM42600_REG_SIGNAL_PATH_RESET,
+				   INV_ICM42600_SIGNAL_PATH_RESET_FIFO_FLUSH);
+		if (ret)
+			goto out_unlock;
+		/* set FIFO in streaming mode */
+		ret = regmap_write(st->map, INV_ICM42600_REG_FIFO_CONFIG,
+				   INV_ICM42600_FIFO_CONFIG_STREAM);
+		if (ret)
+			goto out_unlock;
+		/* workaround: dummy read of FIFO count */
+		ret = regmap_bulk_read(st->map, INV_ICM42600_REG_FIFO_COUNT,
+				       &dummy, sizeof(dummy));
+	} else {
+		/* set FIFO in bypass mode */
+		ret = regmap_write(st->map, INV_ICM42600_REG_FIFO_CONFIG,
+				   INV_ICM42600_FIFO_CONFIG_BYPASS);
+		if (ret)
+			goto out_unlock;
+		/* flush FIFO data */
+		ret = regmap_write(st->map, INV_ICM42600_REG_SIGNAL_PATH_RESET,
+				   INV_ICM42600_SIGNAL_PATH_RESET_FIFO_FLUSH);
+		if (ret)
+			goto out_unlock;
+		/* disable FIFO threshold interrupt */
+		val = INV_ICM42600_INT_SOURCE0_FIFO_THS_INT1_EN;
+		ret = regmap_update_bits(st->map, INV_ICM42600_REG_INT_SOURCE0,
+					 val, 0);
+	}
+
+out_unlock:
+	mutex_unlock(&st->lock);
+	return ret;
+}
+
+static int inv_icm42600_trigger_validate(struct iio_trigger *trig,
+					 struct iio_dev *indio_dev)
+{
+	struct inv_icm42600_state *st = iio_trigger_get_drvdata(trig);
+
+	if (iio_device_get_drvdata(indio_dev) != st)
+		return -ENODEV;
+
+	return 0;
+}
+
+static const struct iio_trigger_ops inv_icm42600_trigger_ops = {
+	.set_trigger_state = &inv_icm42600_trigger_set_state,
+	.validate_device = &inv_icm42600_trigger_validate,
+};
+
+int inv_icm42600_trigger_init(struct inv_icm42600_state *st, int irq,
+			      int irq_type)
+{
+	struct device *dev = regmap_get_device(st->map);
+	unsigned int val;
+	int ret;
+
+	st->trigger = devm_iio_trigger_alloc(dev, "%s-dev", st->name);
+	if (!st->trigger)
+		return -ENOMEM;
+
+	st->trigger->dev.parent = dev;
+	st->trigger->ops = &inv_icm42600_trigger_ops;
+	iio_trigger_set_drvdata(st->trigger, st);
+
+	/* configure INT1 with correct mode */
+	/* falling or both-edge */
+	if (irq_type & IRQF_TRIGGER_FALLING) {
+		val = INV_ICM42600_INT_CONFIG_INT1_ACTIVE_LOW;
+	} else if (irq_type == IRQF_TRIGGER_RISING) {
+		val = INV_ICM42600_INT_CONFIG_INT1_ACTIVE_HIGH;
+	} else if (irq_type == IRQF_TRIGGER_LOW) {
+		val = INV_ICM42600_INT_CONFIG_INT1_ACTIVE_LOW |
+				INV_ICM42600_INT_CONFIG_INT1_LATCHED;
+	} else if (irq_type == IRQF_TRIGGER_HIGH) {
+		val = INV_ICM42600_INT_CONFIG_INT1_ACTIVE_LOW |
+				INV_ICM42600_INT_CONFIG_INT1_LATCHED;
+	} else {
+		dev_err(dev, "invalid interrupt type %#x\n", irq_type);
+		return -EINVAL;
+	}
+	val |= INV_ICM42600_INT_CONFIG_INT1_PUSH_PULL;
+	ret = regmap_write(st->map, INV_ICM42600_REG_INT_CONFIG, val);
+	if (ret)
+		return ret;
+
+	/* Deassert async reset for proper INT pin operation (cf datasheet) */
+	ret = regmap_update_bits(st->map, INV_ICM42600_REG_INT_CONFIG1,
+				 INV_ICM42600_INT_CONFIG1_ASYNC_RESET, 0);
+	if (ret)
+		return ret;
+
+	ret = devm_request_threaded_irq(dev, irq,
+					inv_icm42600_trigger_timestamp,
+					inv_icm42600_trigger_int_handler,
+					irq_type, "inv_icm42600", st);
+	if (ret)
+		return ret;
+
+	return devm_iio_trigger_register(dev, st->trigger);
+}
-- 
2.17.1

