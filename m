Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6211F20FD
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jun 2020 22:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbgFHUp0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Jun 2020 16:45:26 -0400
Received: from mx0b-00328301.pphosted.com ([148.163.141.47]:18864 "EHLO
        mx0b-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726824AbgFHUoL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Jun 2020 16:44:11 -0400
Received: from pps.filterd (m0156136.ppops.net [127.0.0.1])
        by mx0b-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 058Kcorg019143;
        Mon, 8 Jun 2020 13:44:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=pfpt1; bh=Ac9eFAx/Ik/+xmRjOSD3b/jAUbqE30hJuuy6dHCep44=;
 b=pw09PK2A/+HJtg9yE4koc5j7uk44AST04SEMM7mBH+WBbECxIZNDsuXtasB+NvHiAXwE
 bdrK/rxvj3EK2+qNdpNx7QebWZ7lC+7vHNIRWhPoMYJMiPpvUsNMWBSarGO0g/RqBAnp
 2K+qtMj6QUNHHPibU9YyBDaUrkpJtBabrHV7vbS35bOQPS/5Tu4f8g68YGZ6cc1ITMK9
 fnmLwKRCSeZVdN+D0uLmQ4PBunxaZhixK4BYjQZC9jk2TEq+MslA7GisrueG2m7wfu22
 AwLlCS9TplKEhdWNZg9Jy7ZmWUnm4CLf30A9Ka/C0QVD9Gue4W+96MTO0s3ek9hs92LD 7g== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by mx0b-00328301.pphosted.com with ESMTP id 31g8cf0xvm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Jun 2020 13:44:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NvFI6r6WcxsuRG9+xnqTU/pqieYc8JXtTOJrveF7G6LjK7ipEetO/dyLLGvDVqhxJ540/KPlM1CuNMoBuPeU3ovZE5rqwe01UNOaX7x4jji4+yaCaiQ0osM2Hrykta8/KqqBogC9NveL3MJ93/oqNTt/9rok2Wpzjljltrj4n5I03nh+I27j1LbZ7wTTR6d/G18Cm3CW+Z+uZe7/TrPcoQdE/9f4SHGxvag+RghcnlCHP5QYulpjiI6TKBzJXx4LAnk+5jlMURRkUObujJvlK/8WVnOUgjhDLCQ06/I2txLYHWnay11uKVtrGI0KGkv03k4kDPVg68h16TVJdVWv9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ac9eFAx/Ik/+xmRjOSD3b/jAUbqE30hJuuy6dHCep44=;
 b=kWMWzlLXIUEQyAFbdxty89pEd0Vnla6y0s3fKsXY2m/Xr4SZgAp6mWV3ICe+iKwEfAvp23OYmttWOkao/YP69RJuQBOeI9Vfnw+6LArxxUrJrvFoDNOgiSa/U1cdDTIJi7Z6hu+pbssY10ovJpKWpeSAhhjimV2jxhHIVHnboS1JFru2FCQSIuAPpWtxkU14ktP+bMOV0xRFhoragqNQZymz/Me6NbvGbytWCXnEnngncvI3lf3s7hckS+bclqMu9nzi/E1U/Fbgg0ae+8bD46l6nguxjNjvBFq2b2M/IzBglaxodhyOkq402XvWram3NbmJilqaXXdWysUf0GQA2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ac9eFAx/Ik/+xmRjOSD3b/jAUbqE30hJuuy6dHCep44=;
 b=aAXmVZ5YI2RRfztx9kYzXYNI7vrQYMF9pJPXxtEp3+CFyLs4sWlVN9sW5sXcjElsr8j6KrcPYM2eoaJj/1OJZWK3AbAYj5bY4f9Lw/RIAXKUf4CySnZSwYkcvt29XQV9KvuHh+gmcay1lqTXMxgW+4ijnDaBxUB5sGqFq7nus1c=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=invensense.com;
Received: from MN2PR12MB4422.namprd12.prod.outlook.com (2603:10b6:208:265::9)
 by MN2PR12MB3951.namprd12.prod.outlook.com (2603:10b6:208:16b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.20; Mon, 8 Jun
 2020 20:44:04 +0000
Received: from MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::8940:8e95:6996:cc0]) by MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::8940:8e95:6996:cc0%8]) with mapi id 15.20.3066.023; Mon, 8 Jun 2020
 20:44:04 +0000
From:   Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To:     jic23@kernel.org, robh+dt@kernel.org, robh@kernel.org,
        mchehab+huawei@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH v3 09/13] iio: imu: inv_icm42600: add device interrupt
Date:   Mon,  8 Jun 2020 22:42:46 +0200
Message-Id: <20200608204250.3291-10-jmaneyrol@invensense.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200608204250.3291-1-jmaneyrol@invensense.com>
References: <20200608204250.3291-1-jmaneyrol@invensense.com>
Content-Type: text/plain
X-ClientProxiedBy: LNXP265CA0079.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:76::19) To MN2PR12MB4422.namprd12.prod.outlook.com
 (2603:10b6:208:265::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from frgnb-buildozer.invcorp.invensense.com (77.157.193.39) by LNXP265CA0079.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:76::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend Transport; Mon, 8 Jun 2020 20:44:02 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [77.157.193.39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b6618b8-8e60-4a98-a209-08d80becae56
X-MS-TrafficTypeDiagnostic: MN2PR12MB3951:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3951C271F74634895A3F6F72C4850@MN2PR12MB3951.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 042857DBB5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: njkgihyVIXrqxoqguSL9Fp6mLFNEv2xeSfGSC5y15l68MWIlbze9+M902p3U28EdPdD0RQ1XF98iBkRsqpBsFBPGUuc+g9DOggaKfgN5OcmgZqLcqV0y78NO7iL8bYd9WDa9Vlwem84rb+oX6UF7A4xyYbV8zEesxr4srW5vP/774gLaGytdR8JmVbudCgHh9PBa4499j1BxC4l9ZaDUpqpnHKuwHH5ta35VtqHSIqgTgVbo1T8IqAh0HU9/P3wXrfu9e/v8K7tyel1XYa42fqoI/cCqkXgZS164hFmB/qsMd+Ct3Kplyc1jLswkygXoevrTDi+kybBN2sEpGPlPNw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4422.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39850400004)(376002)(346002)(396003)(136003)(366004)(66556008)(66476007)(66946007)(6666004)(36756003)(86362001)(5660300002)(1076003)(6486002)(4326008)(956004)(2616005)(8936002)(2906002)(107886003)(8676002)(7696005)(16526019)(186003)(478600001)(52116002)(26005)(316002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: R3TDz52yjdx4njLv+Kub3NXy9xGVZFvrEq4ERzxa6hKRypZ/f6LCpFcAnhTjxKeF3ghjrUCq4GBEyTKDKfD8x4ZqeOnXP6cQalP4bOVszXbkC7PWK7sr8vaJ5HSlwDJi32RJk9Bez0eAQYGW2DbeXfL+qPAwwihM0GDkI5cqC3YRZHVsYKkeGlQ+Uiz5r2fup8l/7SYc0oAazAWUR/qWXYI+I8BAZgnOuvNUms7/5MUu19UVKwwBdnFw550RONwaePUCYLJdw7icAb6FKVoQqW0lh1sr3gytl3EfxRQ/O2MH+UbeIu0oymIblVOAgw/mafr2dhns+Af+uB7A0NhbZb303pnup4hdsHW1AXN27YPKUWacwF9+rW0g2b9mwwHeBgOr7lA715UMPHPE25teVc3vVySobfCumVC+B1obPzpO0swhh03H9TCKGRLSqpbCcM/Mrk1FN/bmyQ7r3hfL4yRGrft4Kidm2zqMmNg1r0o=
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b6618b8-8e60-4a98-a209-08d80becae56
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2020 20:44:04.0046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JlAPpCS8IYrq5NbBFbjo3yLHyiHV05UhFG2bJhhFaGuOLn66ObybZ7XGbI0M42CEGTxMNh2Fwh2DXh4ZB4QgtM4hW/kaIcBLS2AX3EuowCY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3951
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-08_18:2020-06-08,2020-06-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 impostorscore=0 mlxscore=0 bulkscore=0 phishscore=0 clxscore=1015
 malwarescore=0 priorityscore=1501 cotscore=-2147483648 mlxlogscore=999
 lowpriorityscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006080144
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add INT1 interrupt support. Support interrupt edge and level,
active high or low. Push-pull or open-drain configurations.

Interrupt will be used to read data from the FIFO.

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 drivers/iio/imu/inv_icm42600/inv_icm42600.h   |   2 +-
 .../iio/imu/inv_icm42600/inv_icm42600_core.c  | 101 +++++++++++++++++-
 .../iio/imu/inv_icm42600/inv_icm42600_i2c.c   |   3 +-
 .../iio/imu/inv_icm42600/inv_icm42600_spi.c   |   3 +-
 4 files changed, 105 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
index 3b190461a2b6..148894c888cc 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600.h
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
@@ -372,7 +372,7 @@ int inv_icm42600_set_temp_conf(struct inv_icm42600_state *st, bool enable,
 int inv_icm42600_debugfs_reg(struct iio_dev *indio_dev, unsigned int reg,
 			     unsigned int writeval, unsigned int *readval);
 
-int inv_icm42600_core_probe(struct regmap *regmap, int chip,
+int inv_icm42600_core_probe(struct regmap *regmap, int chip, int irq,
 			    inv_icm42600_bus_setup bus_setup);
 
 struct iio_dev *inv_icm42600_gyro_init(struct inv_icm42600_state *st);
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
index a35ff21f50bb..95b2a6d91e5b 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -9,8 +9,11 @@
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/mutex.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
 #include <linux/regulator/consumer.h>
 #include <linux/pm_runtime.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/iio/iio.h>
 
@@ -408,6 +411,82 @@ static int inv_icm42600_setup(struct inv_icm42600_state *st,
 	return inv_icm42600_set_conf(st, hw->conf);
 }
 
+static irqreturn_t inv_icm42600_irq_handler(int irq, void *_data)
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
+
+	/* FIFO full */
+	if (status & INV_ICM42600_INT_STATUS_FIFO_FULL)
+		dev_warn(dev, "FIFO full data lost!\n");
+
+out_unlock:
+	mutex_unlock(&st->lock);
+	return IRQ_HANDLED;
+}
+
+/**
+ * inv_icm42600_irq_init() - initialize int pin and interrupt handler
+ * @st:		driver internal state
+ * @irq:	irq number
+ * @irq_type:	irq trigger type
+ * @open_drain:	true if irq is open drain, false for push-pull
+ *
+ * Returns 0 on success, a negative error code otherwise.
+ */
+static int inv_icm42600_irq_init(struct inv_icm42600_state *st, int irq,
+				 int irq_type, bool open_drain)
+{
+	struct device *dev = regmap_get_device(st->map);
+	unsigned int val;
+	int ret;
+
+	/* configure INT1 interrupt: default is active low on edge */
+	switch (irq_type) {
+	case IRQF_TRIGGER_RISING:
+	case IRQF_TRIGGER_HIGH:
+		val = INV_ICM42600_INT_CONFIG_INT1_ACTIVE_HIGH;
+		break;
+	default:
+		val = INV_ICM42600_INT_CONFIG_INT1_ACTIVE_LOW;
+		break;
+	}
+
+	switch (irq_type) {
+	case IRQF_TRIGGER_LOW:
+	case IRQF_TRIGGER_HIGH:
+		val |= INV_ICM42600_INT_CONFIG_INT1_LATCHED;
+		break;
+	default:
+		break;
+	}
+
+	if (!open_drain)
+		val |= INV_ICM42600_INT_CONFIG_INT1_PUSH_PULL;
+
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
+	return devm_request_threaded_irq(dev, irq, NULL,
+					 inv_icm42600_irq_handler, irq_type,
+					 "inv_icm42600", st);
+}
+
 static int inv_icm42600_enable_regulator_vddio(struct inv_icm42600_state *st)
 {
 	int ret;
@@ -452,11 +531,14 @@ static void inv_icm42600_disable_pm(void *_data)
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
+	bool open_drain;
 	int ret;
 
 	if (chip < 0 || chip >= INV_CHIP_NB) {
@@ -464,6 +546,19 @@ int inv_icm42600_core_probe(struct regmap *regmap, int chip,
 		return -ENODEV;
 	}
 
+	/* get irq properties, set trigger falling by default */
+	irq_desc = irq_get_irq_data(irq);
+	if (!irq_desc) {
+		dev_err(dev, "could not find IRQ %d\n", irq);
+		return -EINVAL;
+	}
+
+	irq_type = irqd_get_trigger_type(irq_desc);
+	if (!irq_type)
+		irq_type = IRQF_TRIGGER_FALLING;
+
+	open_drain = device_property_read_bool(dev, "drive-open-drain");
+
 	st = devm_kzalloc(dev, sizeof(*st), GFP_KERNEL);
 	if (!st)
 		return -ENOMEM;
@@ -517,6 +612,10 @@ int inv_icm42600_core_probe(struct regmap *regmap, int chip,
 	if (IS_ERR(st->indio_accel))
 		return PTR_ERR(st->indio_accel);
 
+	ret = inv_icm42600_irq_init(st, irq, irq_type, open_drain);
+	if (ret)
+		return ret;
+
 	/* setup runtime power management */
 	ret = pm_runtime_set_active(dev);
 	if (ret)
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
index 4789cead23b3..85b1934cec60 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
@@ -64,7 +64,8 @@ static int inv_icm42600_probe(struct i2c_client *client)
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
 
-	return inv_icm42600_core_probe(regmap, chip, inv_icm42600_i2c_bus_setup);
+	return inv_icm42600_core_probe(regmap, chip, client->irq,
+				       inv_icm42600_i2c_bus_setup);
 }
 
 static const struct of_device_id inv_icm42600_of_matches[] = {
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
index a9c5e2fdbe2a..323789697a08 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
@@ -63,7 +63,8 @@ static int inv_icm42600_probe(struct spi_device *spi)
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
 
-	return inv_icm42600_core_probe(regmap, chip, inv_icm42600_spi_bus_setup);
+	return inv_icm42600_core_probe(regmap, chip, spi->irq,
+				       inv_icm42600_spi_bus_setup);
 }
 
 static const struct of_device_id inv_icm42600_of_matches[] = {
-- 
2.17.1

