Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90268DEED7
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2019 16:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728969AbfJUOIl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Oct 2019 10:08:41 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:25588 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728098AbfJUOIl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 Oct 2019 10:08:41 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9LE31Ed003914;
        Mon, 21 Oct 2019 10:06:23 -0400
Received: from nam01-bn3-obe.outbound.protection.outlook.com (mail-bn3nam01lp2050.outbound.protection.outlook.com [104.47.33.50])
        by mx0a-00128a01.pphosted.com with ESMTP id 2vqvb9kexr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 21 Oct 2019 10:06:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rd/OvAfn4rWjjNKzP1oEXvCRnZptc8/EVcrMIbL6otdjsWJ8YxOnMMhMxURi44h0nzXfC6Gs0mrWlIX3DsGS0J9W92NRmDNwkZSL6d/GHntSXLf5vctYfRf/LSImwgDMWSB8P0b2qUZteoVfQzi7YgJVpINEFt5HlmWE8jjo8FIB8J1OZB530dkRIYoNVS4BzSUf4rlmW1IsSb6cEtu7MC5aWix00Exchz2IfDwAygiCy6DMCyYey8ct1D25mQHnCd7Zebsmz4GJFrKXs8ki5OGY9OdCOe9pYWW6NsmueZxntRUTbZLJYv8FNyiMLpRayk3/vck/rXEktZx3+W2c2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PWXXnHubRB/EPPkt4jriIO5RDoEYpjxW5LUL53EoYE8=;
 b=K1ghiB2scrqTOus2DpzqU+Y9dyBKoAp2xzroCGMiHt4+rkMexhJlcHrpYEyqGl2jwDXkdRsaoUMeciYuscP7gS/VsG7EeKav++zBLw5bTqtAbJodJRvlbtokZxt/t/ll0V1OjsRhIiMCBSPwUj2QsO3KK+CHt5EDw9JL54Sxo6J5BLLDNiRCKkTqcRvCAce8db9zNmwvSlcEAO9ZCNmqcwcFVbRsHollenVO67oLDRY9JixFgySRDwIqMqzEik8XD8sIy1cxnDPUd8Uyjbsh/P6xCN+ORnFD4+iurIGtroeJ6jAHTN3FsE4rkvBevNRo1/3v5dGHKE9muv8UsFYBOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PWXXnHubRB/EPPkt4jriIO5RDoEYpjxW5LUL53EoYE8=;
 b=2rDhyAFLtEESiRVuvzkfoPSgt0U/MyRx2Gm6MyEyoL43u2vYfMobHiHYyRkKbD0QypxAZvpSv5q0WnNq6YZviUrelCFxijD4qPWTp8sHk4b34RRDW2HAmRYZje+x/oMeGAP4gQIWlpwjuehPMqkAI7St73I5OSsUK1CQRuN+Erc=
Received: from DM6PR03CA0037.namprd03.prod.outlook.com (2603:10b6:5:100::14)
 by DM6PR03MB4812.namprd03.prod.outlook.com (2603:10b6:5:186::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.19; Mon, 21 Oct
 2019 14:06:16 +0000
Received: from SN1NAM02FT044.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::208) by DM6PR03CA0037.outlook.office365.com
 (2603:10b6:5:100::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2367.20 via Frontend
 Transport; Mon, 21 Oct 2019 14:06:15 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 SN1NAM02FT044.mail.protection.outlook.com (10.152.72.173) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2367.14
 via Frontend Transport; Mon, 21 Oct 2019 14:06:15 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x9LE68aA013241
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 21 Oct 2019 07:06:08 -0700
Received: from ben-Latitude-E6540.ad.analog.com (10.48.65.163) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Mon, 21 Oct 2019 10:06:14 -0400
From:   Beniamin Bia <beniamin.bia@analog.com>
To:     <jic23@kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-iio@vger.kernel.org>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <paulmck@linux.ibm.com>,
        <mchehab+samsung@kernel.org>, <linus.walleij@linaro.org>,
        <nicolas.ferre@microchip.com>, <biabeniamin@outlook.com>,
        Paul Cercueil <paul.cercueil@analog.com>,
        Beniamin Bia <beniamin.bia@analog.com>
Subject: [PATCH 2/4] iio: adc: ad7091r5: Add scale and external VREF support
Date:   Mon, 21 Oct 2019 20:06:06 +0300
Message-ID: <20191021170608.26412-2-beniamin.bia@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191021170608.26412-1-beniamin.bia@analog.com>
References: <20191021170608.26412-1-beniamin.bia@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(346002)(396003)(136003)(376002)(199004)(189003)(8676002)(86362001)(2351001)(50226002)(246002)(6916009)(50466002)(48376002)(4326008)(47776003)(70206006)(70586007)(5660300002)(36756003)(1076003)(478600001)(8936002)(336012)(107886003)(7636002)(6666004)(486006)(186003)(305945005)(44832011)(14444005)(16586007)(316002)(7416002)(26005)(356004)(76176011)(2616005)(476003)(2906002)(426003)(7696005)(51416003)(11346002)(126002)(446003)(54906003)(106002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB4812;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e26f08d-0092-4e55-93dd-08d7562fd672
X-MS-TrafficTypeDiagnostic: DM6PR03MB4812:
X-Microsoft-Antispam-PRVS: <DM6PR03MB48129745FBD40AB9C438C023F0690@DM6PR03MB4812.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0197AFBD92
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0ZLB/zUBrH13PQNUAQObHUAWWTZyEkJhCI9p2gAmHAgaNCAHlbFxHGBuZ1G6lFoi498g8IH3HfLHEJ9+UeshFQAnNIgvwVAgNxzLcRPGpCKzKQUoYqDytcfFKs4dRnF/aw7Vzih0xf9HkskwZDs+YizHmFwrC95hCBG2xMo4hI1xvKWbH10qFvl4fe8U8A/BV+m7p9JkyS0oE/nFAOcMn28CDJw2PiCCMA4F4gaLKPufBisR6fLVxlsC+Wf9eVenSZs1Dxp58lFHE8pwnzsQjK+ROhRHsd2Ti5ODOWKU4K1rrv5afhlUlPDtkzyJATo26YSxKf4BvEIAiquwRwTHhcb9U4CdGbf+uYwxYxYLhyWwq1pDSYjf2fAyPb6DOQKlyjJn/0yAe6fuCEFxXIn6dIc8GRMdaj3ojKsBG81ZBwg=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2019 14:06:15.6208
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e26f08d-0092-4e55-93dd-08d7562fd672
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4812
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-21_04:2019-10-21,2019-10-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 suspectscore=1 mlxscore=0 phishscore=0 mlxlogscore=999
 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910210133
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Paul Cercueil <paul.cercueil@analog.com>

The scale can now be obtained with the "in_voltage_scale" file.
By default, the scale returned corresponds to the internal VREF of 2.5V.

It is possible to use an external VREF (through the REFIN/REFOUT pin of
the chip), by passing a regulator to the driver. The scale will then be
calculated according to the voltage reported by the regulator.

Signed-off-by: Paul Cercueil <paul.cercueil@analog.com>
Co-developed-by: Beniamin Bia <beniamin.bia@analog.com>
Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
---
 drivers/iio/adc/ad7091r-base.c | 42 +++++++++++++++++++++++++++++++++-
 drivers/iio/adc/ad7091r-base.h |  1 +
 drivers/iio/adc/ad7091r5.c     |  5 ++++
 3 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7091r-base.c b/drivers/iio/adc/ad7091r-base.c
index 140413329754..d416f0912531 100644
--- a/drivers/iio/adc/ad7091r-base.c
+++ b/drivers/iio/adc/ad7091r-base.c
@@ -14,6 +14,7 @@
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 
 #define AD7091R_REG_RESULT  0
 #define AD7091R_REG_CHANNEL 1
@@ -42,6 +43,7 @@ enum ad7091r_mode {
 struct ad7091r_state {
 	struct device *dev;
 	struct regmap *map;
+	struct regulator *reg;
 	const struct ad7091r_chip_info *chip_info;
 	enum ad7091r_mode mode;
 };
@@ -139,6 +141,21 @@ static int ad7091r_read_raw(struct iio_dev *iio_dev,
 		ret = IIO_VAL_INT;
 		break;
 
+	case IIO_CHAN_INFO_SCALE:
+		if (st->reg) {
+			ret = regulator_get_voltage(st->reg);
+			if (ret < 0)
+				goto unlock;
+
+			*val = ret / 1000;
+		} else {
+			*val = st->chip_info->vref_mV;
+		}
+
+		*val2 = chan->scan_type.realbits;
+		ret = IIO_VAL_FRACTIONAL_LOG2;
+		break;
+
 	default:
 		ret = -EINVAL;
 		break;
@@ -215,6 +232,18 @@ int ad7091r_probe(struct device *dev, const char *name,
 			return ret;
 	}
 
+	st->reg = devm_regulator_get_optional(dev, "vref");
+	if (IS_ERR(st->reg)) {
+		if (PTR_ERR(st->reg) == EPROBE_DEFER)
+			return -EPROBE_DEFER;
+
+		st->reg = NULL;
+	} else {
+		ret = regulator_enable(st->reg);
+		if (ret)
+			return ret;
+	}
+
 	/* Use command mode by default */
 	ret = ad7091r_set_mode(st, AD7091R_MODE_COMMAND);
 	if (ret < 0)
@@ -222,18 +251,29 @@ int ad7091r_probe(struct device *dev, const char *name,
 
 	ret = iio_device_register(iio_dev);
 	if (ret)
-		return ret;
+		goto err_disable_reg;
 
 	dev_dbg(dev, "Probed\n");
 	return 0;
+
+err_disable_reg:
+	if (st->reg)
+		regulator_disable(st->reg);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(ad7091r_probe);
 
 int ad7091r_remove(struct device *dev)
 {
 	struct iio_dev *iio_dev = dev_get_drvdata(dev);
+	struct ad7091r_state *st = iio_priv(iio_dev);
 
 	iio_device_unregister(iio_dev);
+
+	if (st->reg)
+		regulator_disable(st->reg);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(ad7091r_remove);
diff --git a/drivers/iio/adc/ad7091r-base.h b/drivers/iio/adc/ad7091r-base.h
index 7a29f86ea82b..cec4fb75fecc 100644
--- a/drivers/iio/adc/ad7091r-base.h
+++ b/drivers/iio/adc/ad7091r-base.h
@@ -18,6 +18,7 @@ struct ad7091r_state;
 struct ad7091r_chip_info {
 	unsigned int num_channels;
 	const struct iio_chan_spec *channels;
+	unsigned int vref_mV;
 };
 
 extern const struct regmap_config ad7091r_regmap_config;
diff --git a/drivers/iio/adc/ad7091r5.c b/drivers/iio/adc/ad7091r5.c
index 1ba838c58c31..65bcd8bb692a 100644
--- a/drivers/iio/adc/ad7091r5.c
+++ b/drivers/iio/adc/ad7091r5.c
@@ -35,10 +35,13 @@ static const struct iio_event_spec ad7091r5_events[] = {
 #define AD7091R_CHANNEL(idx, bits, ev, num_ev) { \
 	.type = IIO_VOLTAGE, \
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE), \
 	.indexed = 1, \
 	.channel = idx, \
 	.event_spec = ev, \
 	.num_event_specs = num_ev, \
+	.scan_type.storagebits = 16, \
+	.scan_type.realbits = bits, \
 }
 static const struct iio_chan_spec ad7091r5_channels_irq[] = {
 	AD7091R_CHANNEL(0, 12, ad7091r5_events, ARRAY_SIZE(ad7091r5_events)),
@@ -58,11 +61,13 @@ static const struct iio_chan_spec ad7091r5_channels_noirq[] = {
 static const struct ad7091r_chip_info ad7091r5_chip_info_irq = {
 	.channels = ad7091r5_channels_irq,
 	.num_channels = ARRAY_SIZE(ad7091r5_channels_irq),
+	.vref_mV = 2500,
 };
 
 static const struct ad7091r_chip_info ad7091r5_chip_info_noirq = {
 	.channels = ad7091r5_channels_noirq,
 	.num_channels = ARRAY_SIZE(ad7091r5_channels_noirq),
+	.vref_mV = 2500,
 };
 
 static int ad7091r5_i2c_probe(struct i2c_client *i2c,
-- 
2.17.1

