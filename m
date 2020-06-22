Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4BF203B19
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jun 2020 17:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729746AbgFVPiR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 22 Jun 2020 11:38:17 -0400
Received: from mx0b-00328301.pphosted.com ([148.163.141.47]:45900 "EHLO
        mx0b-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729705AbgFVPiP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 22 Jun 2020 11:38:15 -0400
Received: from pps.filterd (m0156136.ppops.net [127.0.0.1])
        by mx0b-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05MFWDw6004965;
        Mon, 22 Jun 2020 08:38:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=pfpt1; bh=Ac9eFAx/Ik/+xmRjOSD3b/jAUbqE30hJuuy6dHCep44=;
 b=F5XJcxyGcmhowe5lA+hrhMiYGeA7MesDgMxAlgO58DGfgJLOeuflEYkFgXsQKMC7HruH
 9KYnqXW2R5+EbgB3bB9ZXNOC0FA9jPAknMbyTYbmcnLusAscBvQX6SiXXybsYHrLoOH8
 GqM72wxHipsFmEagta3pQhDXVG+GQZVspcvE9LZuSP1IldUbAA0q9xaTMXgPHb3FaZaT
 4IeCVJN+fL179BhCRg8CGSnPT43LlflFAIacK4SGvzToP5O5w7t9vfx/ogzbkFFSz7pM
 dByApfje5FsIZPLfmPRifkXUKEPczQUxEkwHLs0Cl1bc2uLAhbp31ST3POvOcdEcTrT7 Lg== 
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2056.outbound.protection.outlook.com [104.47.44.56])
        by mx0b-00328301.pphosted.com with ESMTP id 31sedp0ukp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Jun 2020 08:38:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G0uON07tI78TqIBb5y0YVD5nHdtv6fnwIABeJaDt/YgJyDVTUBR449hdDcPYBJIRTHIR7c9Eptt4lfI8dr7bf5y/Tck3cRSjK9fYB/UuuQC47tX0ENDm3ebuEGjOQgznNBAy41pZYjgbQk2y/QrN5uswfkS4rLjDu2zw8+923iK9EsBFMrd9mF5qMxHvkPjtSKkQWSj+tE+lZKFn8lbIOFfJeq2x4x9vcsCqmM5dy9ENAPMvVXepiqUYmkh2jheELFpyHZqcnKTAJhPUtDsC9AFauuAB+8l/t74HHqcL7duec95ujvlW6OJBsP80h0sTFYiLw7kYYxijbCCRCbVOfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ac9eFAx/Ik/+xmRjOSD3b/jAUbqE30hJuuy6dHCep44=;
 b=R3aPp8WnnE04hi1/TE675zmP/mD/AGA53ZPskhlFjW6EqCCEpSgj562jOIjUKe8+eMuQ1svKf/dhHmpQUe9UG5XoQRuD7AjLcz32BQlX5da2n1BqbwXLNq0BiO2czNQhcMthuo1rJbQH5Bd/viNEP98VLLJsKrW30bDLi11U/EHxVrW8VOiIQSgd0NOs85MME4NJl3gRFKxRvPu0yWm2OHu/pnXlay+EnpAJsAmXqcdu4vKDQtd9sHA9dYwdRIrjlIw9x5ckqbHdWU4bdAD59yY4I/PG34z9m1eYaz9SxFZzBQHzQkMcUubx1/jjGBdQDgcOhL4Kyw/CwlaY645bmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ac9eFAx/Ik/+xmRjOSD3b/jAUbqE30hJuuy6dHCep44=;
 b=dsFlVUkmIoDJ+u0VUT1YicF80OjlBlqAL89iENGDYKI4M5arALnz57u1aUSnLxKbeleyKxYfDaEO+0KIlmfCChcSeNEAun3ZmaKt0FC/VoqwsNM9Nwi5cDeuwVAo+WcK7tN6XbAarkTR3JPiMX16GJc0HROgXMN0G/Emu0VHJpI=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=invensense.com;
Received: from MN2PR12MB4422.namprd12.prod.outlook.com (2603:10b6:208:265::9)
 by MN2PR12MB4501.namprd12.prod.outlook.com (2603:10b6:208:269::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Mon, 22 Jun
 2020 15:38:09 +0000
Received: from MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::8940:8e95:6996:cc0]) by MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::8940:8e95:6996:cc0%7]) with mapi id 15.20.3109.027; Mon, 22 Jun 2020
 15:38:09 +0000
From:   Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To:     jic23@kernel.org, robh+dt@kernel.org, robh@kernel.org,
        mchehab+huawei@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH v4 09/13] iio: imu: inv_icm42600: add device interrupt
Date:   Mon, 22 Jun 2020 17:37:25 +0200
Message-Id: <20200622153729.12702-10-jmaneyrol@invensense.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200622153729.12702-1-jmaneyrol@invensense.com>
References: <20200622153729.12702-1-jmaneyrol@invensense.com>
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0054.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::18) To MN2PR12MB4422.namprd12.prod.outlook.com
 (2603:10b6:208:265::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from frgnb-buildozer.invcorp.invensense.com (77.157.193.39) by LO2P265CA0054.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:60::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21 via Frontend Transport; Mon, 22 Jun 2020 15:38:07 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [77.157.193.39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12f004a1-32e7-413c-e56c-08d816c243c6
X-MS-TrafficTypeDiagnostic: MN2PR12MB4501:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB45014A51A342028BBC0CC88EC4970@MN2PR12MB4501.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 0442E569BC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UD/5XdHUzKtwyZw4mJ2PeL5qN7ANHWEBApk5VfJYSXBDqCZoUhPeZHfzz21VM94oQlpLImriTlhUOZrujB5eSmUq1tOP8S0SgscNRAlzV6HaTRN0ZG1FdvMWz8TweH/pRiN101yJ1giRga9au19ZesZAalK5VNAweZXtkGzi9gPcOXJjCNpJyiBYxtTlRxGs0ZnEysa/OgLxqnCHDyIp2f1u7++/NUJwGKNMXMaxBLR0ix3cPxTgjSwdVFbPJ1Nlwy4d8a5DGeAac4Kcyc4Z6iut8MK+0OtjiroB57A8k608N2yo9P7+mebs9lB9AR49OXwx7EBtFyAtuvPW3mJg+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4422.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(376002)(39850400004)(136003)(366004)(396003)(4326008)(66946007)(7696005)(52116002)(8676002)(66476007)(66556008)(956004)(2616005)(1076003)(83380400001)(107886003)(86362001)(36756003)(478600001)(6486002)(6666004)(26005)(316002)(8936002)(16526019)(5660300002)(2906002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: JIe+w8duWVtepRQShBbV6pmz9E8hdpE5bQKU48MJFapr7TqwDpy2T3eVqXr3U4IohdYgGXFWZCPFFt96/EnK2nBQ3z8cLf2+gzfvyVDZUcoIg4UXcDhiVmQIFgp4rBy+dSVCvKgjoYsc7OEuEiOn59Wy9E2U69bQL3L6au8cT6GfshXtdIDyXoEQkCdoS0lJRaeHjninPvWupndzQHua7U5fM8FGt9pf5hqn/mHwWjXgGpHJsYoR4bzdzNdBrlZjMb37FbrZU2g33ujWcxlX8Z+Jwjp5n6+QEF1YPVq/3NnT1UCV6kOU5673W6e55cJ+bi0qv3PofL4lGUgQQPS0iEdSc3B9VIWMnVNllJmUXjQM1laUVBoDZX2mL40x4SJ3P3UUdm5j+SmKQNxQO0Hfluuby7XC8XeOFfKvr2qYXeboiy8Yvvap424M+odSHPq7aZ5mdJtzJZeU93wqiROntA9dmi31RRG2lj4t9okxkYc=
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12f004a1-32e7-413c-e56c-08d816c243c6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2020 15:38:09.1232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Kv2szDFGS6+mXiYUgZkhLPozhCaf6P3Eah8Q4TPcNIG4Ku+y7BXcCtplBesL/Pu1zRAKDFMqQJaJ5Ga+3qJ45b3cHNTx2+l1ySsJeQhYsk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4501
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-22_09:2020-06-22,2020-06-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 adultscore=0 mlxlogscore=999 spamscore=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 cotscore=-2147483648
 malwarescore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006220116
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

