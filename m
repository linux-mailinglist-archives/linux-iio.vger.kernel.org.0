Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED2A21E4DA1
	for <lists+linux-iio@lfdr.de>; Wed, 27 May 2020 20:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728893AbgE0S6L (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 27 May 2020 14:58:11 -0400
Received: from mx0b-00328301.pphosted.com ([148.163.141.47]:9114 "EHLO
        mx0b-00328301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387420AbgE0S57 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 27 May 2020 14:57:59 -0400
Received: from pps.filterd (m0156136.ppops.net [127.0.0.1])
        by mx0b-00328301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04RIqS4D003313;
        Wed, 27 May 2020 11:57:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=invensense.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=pfpt1; bh=SIB7JC9u4mEnLMiXMC4Yz59zoNLCEkQROUp8Ky5nYBY=;
 b=HfeSv++Fv7LlvXqx4ziLcAfDgps7MEiRBHEfv/Dk8S95eSISztyMF6jEOwxnCGemn/Go
 1TyNyhyNOgiRcemZrZUA2Rk5Mhs/aB77bzYPkFCoyV3SPfj4hqu74XqmXKQ/jtBL9XHf
 FeC41A7uTRO3kUZu7QxQrEmpt+iIZ61Jgh6p3X/ubP2BooUgGB0wW713r8WJUSz1Ge0L
 rSEJf822/dFABVoN3QPezBjZhEc5pd6YYSfQ1SrlXNP1ebIxNgq5cfwRpLjpVwixGzwF
 D4H5WLDLBG2S4+M5oGUPh5DwDfct81h6OmEWw/Q/Fi476Fa3pIOPY+gxKedokSea3ox6 vA== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
        by mx0b-00328301.pphosted.com with ESMTP id 3185ap9ewt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 May 2020 11:57:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jZWkFQhzeDtCO3VHo9W367pHF4caPP8ksy2KjoaQ/4eQumVHMN2+HzbW0iMuOZbaQGE+lRZI+vKht3UJZIm3nJk1HhbdkRrbZqw69iab+AC4/99vSSBeaCk7SS6tOoe3mtv3NG364h2ScodWli/cx7aofvWglz/9rpIvg0TpiNPUMWs6zcfTkkK0ASAPmcbbslnIIClhCA/0XLFeOb5t5oPLo87TeUvxyeDHTp4d3TmgmzRLbeGwgBDCGsbVpfsMecFfaofTgJudkXrQrqu9km8TCXTWlDdGiKsW1Fi941nfYbnIghL4z+UBkVyP1K5x95B4b8aQiJ1AfznNdFBW7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SIB7JC9u4mEnLMiXMC4Yz59zoNLCEkQROUp8Ky5nYBY=;
 b=eruBliPbnkD3CneIX697cJpd93b1/bLSQipoLvnHQKZz92n+4WbWYoQrMcDZ2z+FOd2bgp/vQ75zz+N0ybxg0SGN/2xTonIZlnF8W+9TQyVxzQQ12dk2RJ6ouDF0WpEiyF0N0EW5mYqp5LXqiHGlMrQlPh5luxTuYqXHGjuY/EGkZ9ekqjuPGt7qLrS2+maa44GpezYOpy0A2QAdAs1vBYcDKh6N9ww/VfNqvDxhP3wsC9lkvXaCnMDx40XrZmIB6/EeSklzAXhWEaAzeNdyaWqdY/Sb57s21JYiBTWpm34TWxatUv6MTvIh7R+WeXsBAc+vR011wWQFI2fKmiOmag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=invensense.com; dmarc=pass action=none
 header.from=invensense.com; dkim=pass header.d=invensense.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=invensense.onmicrosoft.com; s=selector2-invensense-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SIB7JC9u4mEnLMiXMC4Yz59zoNLCEkQROUp8Ky5nYBY=;
 b=e7dtDkFe86M0+4zhTYFsQA+fzZ5NnteZ//TPfsCqO6vrdIGquOOkFbWmewhdSMGir7xvVQ8Py6U2AqSaTk6E+/L6dQ9cU3Sltzjjhxq9QN9rg2YLfKdL2yTnHZpK44D3/2EZGIlS+15LRNQcbT3DkPxV8m1Vy6r+Q0H14ZNbmvc=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=invensense.com;
Received: from MN2PR12MB4422.namprd12.prod.outlook.com (2603:10b6:208:265::9)
 by MN2PR12MB3151.namprd12.prod.outlook.com (2603:10b6:208:d1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Wed, 27 May
 2020 18:57:53 +0000
Received: from MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::8940:8e95:6996:cc0]) by MN2PR12MB4422.namprd12.prod.outlook.com
 ([fe80::8940:8e95:6996:cc0%8]) with mapi id 15.20.3045.018; Wed, 27 May 2020
 18:57:53 +0000
From:   Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
To:     jic23@kernel.org, robh+dt@kernel.org, robh@kernel.org,
        mchehab+huawei@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: [PATCH v2 08/12] iio: imu: inv_icm42600: add device interrupt
Date:   Wed, 27 May 2020 20:57:07 +0200
Message-Id: <20200527185711.21331-9-jmaneyrol@invensense.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200527185711.21331-1-jmaneyrol@invensense.com>
References: <20200527185711.21331-1-jmaneyrol@invensense.com>
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0168.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::36) To MN2PR12MB4422.namprd12.prod.outlook.com
 (2603:10b6:208:265::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from frgnb-buildozer.invcorp.invensense.com (77.157.193.39) by LO2P265CA0168.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:9::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.26 via Frontend Transport; Wed, 27 May 2020 18:57:51 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [77.157.193.39]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ebbfd029-baa5-4692-0bd8-08d8026fdbfb
X-MS-TrafficTypeDiagnostic: MN2PR12MB3151:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3151DF22FC8FF81DD89E9A8FC4B10@MN2PR12MB3151.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 04163EF38A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4PbvMqNyYphMNjQxB/7uWNUr8wrv6n4RJkhFHnXvJii9gm0OeJAIdzI9yy+pVssCL6yVhMHVTTkG9xWCfAMHi0r7irWq3v/JdvvzS8g9dpdqVhJOvy54mFThDtXn9EuihmBu/ci13ewwWlyl6kjZLCy6zZGvloWTcYl948o07a+lMwQXS0jwJeue6gs2wCzFlbLql7GFmBiSRGced2dTgwSd4jRgDBe7WYDKx+70hn8LfaJvvhlwgmAo9Nvlo7hmeAfsBbO5oWC7SX8WACHdTgxqPEB4sKJSixYpS6yXOUOIozoZtVTI8/TmgtUkKRrXMkWneBzrKZ+ztUO8sHgZjw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4422.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(39850400004)(346002)(366004)(396003)(376002)(16526019)(478600001)(107886003)(8676002)(5660300002)(186003)(8936002)(316002)(6666004)(6486002)(1076003)(7696005)(66946007)(26005)(2616005)(956004)(2906002)(86362001)(36756003)(52116002)(4326008)(66556008)(83380400001)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: xM0IHsXa+ESFhGh1tm/mwL76hVNkGrzduREhMgO6EZhhOohUiNLYzqG/Euezx+/FbsQlldmAfTY6VnwrOM2tkTFTYzDF+xj9CX+Cu35m93iS/8B7lcEbHjLq7pozSELYeUkjDMQquCLiw2B0hDZDOjcVWKE+W0JY0MZxwNxd2vknDh3YgUEZBcfGOh7I0+ft6eDbPPNVkwhpldMpq3qNlcTGbpeezGdjvWIX7iakBq0IeqMGGm+X/xTFk9pRx7fUOWraPFwGTA0hTkoP4pxPGUSuOssMdIl0vXvj6vqsPExmEd8Mlwyj4dgzkegZHwuyD31cswZno93v5FDChQrFV3t1YFh+Mm80+Mw8A1JAgjyCzo3W8m2smk+ako0IGYh1nCvnj6EGNl+kqjT7KnTbR85FVQBAiZ9mz/UTIHNT6H95cHfogRit3C1QN2w8FXRrgRnTumvTi37zqwGGEksLCXPVTHeW32T+4iquPDAH6Cg=
X-OriginatorOrg: invensense.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebbfd029-baa5-4692-0bd8-08d8026fdbfb
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2020 18:57:53.0199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 462b3b3b-e42b-47ea-801a-f1581aac892d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EhiFCvXL2Hx4aIEHIHDYQrpnJX0sWfqTcodSVqHB7Dr4dgtFE15v0qK69wMPNZdtd2Lg2mPwr0SHUn57/8/FaZ389XbTdOfselpcqRUYS9Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3151
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-27_03:2020-05-27,2020-05-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 cotscore=-2147483648
 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0 phishscore=0
 mlxscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999 clxscore=1015
 spamscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005270144
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add INT1 interrupt support. Support interrupt edge and level,
active high or low. Push-pull or open-drain configurations.

Interrupt will be used to read data from the FIFO.

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 drivers/iio/imu/inv_icm42600/inv_icm42600.h   |  2 +-
 .../iio/imu/inv_icm42600/inv_icm42600_core.c  | 96 ++++++++++++++++++-
 .../iio/imu/inv_icm42600/inv_icm42600_i2c.c   |  3 +-
 .../iio/imu/inv_icm42600/inv_icm42600_spi.c   |  3 +-
 4 files changed, 100 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
index c534acae0308..43749f56426c 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600.h
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
@@ -372,7 +372,7 @@ int inv_icm42600_set_temp_conf(struct inv_icm42600_state *st, bool enable,
 int inv_icm42600_debugfs_reg(struct iio_dev *indio_dev, unsigned int reg,
 			     unsigned int writeval, unsigned int *readval);
 
-int inv_icm42600_core_probe(struct regmap *regmap, int chip,
+int inv_icm42600_core_probe(struct regmap *regmap, int chip, int irq,
 			    inv_icm42600_bus_setup bus_setup);
 
 int inv_icm42600_gyro_init(struct inv_icm42600_state *st);
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
index e7f7835aca9b..246c1eb52231 100644
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
 
@@ -409,6 +412,79 @@ static int inv_icm42600_setup(struct inv_icm42600_state *st,
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
+	switch (irq_type) {
+	case IRQF_TRIGGER_LOW:
+	case IRQF_TRIGGER_HIGH:
+		val |= INV_ICM42600_INT_CONFIG_INT1_LATCHED;
+		break;
+	default:
+		break;
+	}
+	if (!open_drain)
+		val |= INV_ICM42600_INT_CONFIG_INT1_PUSH_PULL;
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
@@ -453,11 +529,14 @@ static void inv_icm42600_disable_pm(void *_data)
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
@@ -465,6 +544,17 @@ int inv_icm42600_core_probe(struct regmap *regmap, int chip,
 		return -ENODEV;
 	}
 
+	/* get irq properties, set trigger falling by default */
+	irq_desc = irq_get_irq_data(irq);
+	if (!irq_desc) {
+		dev_err(dev, "could not find IRQ %d\n", irq);
+		return -EINVAL;
+	}
+	irq_type = irqd_get_trigger_type(irq_desc);
+	if (!irq_type)
+		irq_type = IRQF_TRIGGER_FALLING;
+	open_drain = device_property_read_bool(dev, "drive-open-drain");
+
 	st = devm_kzalloc(dev, sizeof(*st), GFP_KERNEL);
 	if (!st)
 		return -ENOMEM;
@@ -518,6 +608,10 @@ int inv_icm42600_core_probe(struct regmap *regmap, int chip,
 	if (ret)
 		return ret;
 
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

