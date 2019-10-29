Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84A15E8989
	for <lists+linux-iio@lfdr.de>; Tue, 29 Oct 2019 14:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388464AbfJ2NbY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 29 Oct 2019 09:31:24 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:17438 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731885AbfJ2NbY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 29 Oct 2019 09:31:24 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9TDRgEM031831;
        Tue, 29 Oct 2019 09:30:53 -0400
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2056.outbound.protection.outlook.com [104.47.45.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 2vvg08fc32-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Oct 2019 09:30:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IJx+2WgpaH0aIIdcHrBDHu3QFsNbFTLrlHmFcgW9iHNe372MLU0Mr0mEmIKWJiLVH9abMmeuQZqO3G/ml4FVu/LU1i88Ers0efjAqRGTrzRt5GA1m10w9VQ77oQXmK4Bc1exxdKatidm6H0J9r2sEcH73J26u0AIAVjiLe3gpD+3wGRZSiIxbSXT2jf6PG+u1JuGV6WO8Zqba/7dIM2fkFv0GNF1xB4BNzjpKVgtRJU0DptWgukBjD/UYDSIKgSxQDVASHhR0fiA33UC2jR1kK6Mncw4GLIwSCqx+hkrVh5A2QtL4TUlPVCp72hDsv9BItL8yi7PCcR+Ds7c92yrhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FsSFjA0MLFz86vtGu3357yz5IPgO30pMB33y0+rmsMs=;
 b=CNqF/GvN+CBtryNwTagaSDKgYr9bOv32kNfQMevh5BYA9SHk4euFpvd7fqaZdIWmfg/zVENoWeQ/ZdpVF46eLMyj0bpgEV5KIH2Uw1xgip3tjigBcspHIQsqFj1MOsLXUQGEg3zpDwSxeFDwB+RRU0T+O0SXeKv5jrjjR+BW5YoXcIxcQSHGYBtMdxlNAuZI3GnbiB0rEqedBEt7fbDGCRsmyRDJaEO+GIeCUbTnJML/sGGP077P+PJ1DzW7U693Mwm+Klwf2uvEZ4ULyn342pctuzNT+r67Lrb64hxT5xJL5IiFd7hRd8oL6NmHMQs6aQ2/y+GNENWW3J3sria+4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FsSFjA0MLFz86vtGu3357yz5IPgO30pMB33y0+rmsMs=;
 b=0VNWBzOQf9UfvfutBe/jimd3lpJFIzRici1+4c6iQBN2IkZ0QfBv6BYKv+n6jqMD1Tgpjzru88BpkHznf3mC9CCdwXArcpvjZauqZmJuj91k/GVrnadbiUzDsieE5a5AIkcip58A9k7FR6CxzN0MI5Nu0H4Y4xWx+iMADZSBKxI=
Received: from CY1PR03CA0007.namprd03.prod.outlook.com (2603:10b6:600::17) by
 CY1PR03MB2267.namprd03.prod.outlook.com (2a01:111:e400:c612::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2387.24; Tue, 29 Oct
 2019 13:30:50 +0000
Received: from CY1NAM02FT039.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::206) by CY1PR03CA0007.outlook.office365.com
 (2603:10b6:600::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2387.23 via Frontend
 Transport; Tue, 29 Oct 2019 13:30:50 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 CY1NAM02FT039.mail.protection.outlook.com (10.152.75.140) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2387.20
 via Frontend Transport; Tue, 29 Oct 2019 13:30:50 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x9TDUnsU018919
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 29 Oct 2019 06:30:49 -0700
Received: from ben-Latitude-E6540.ad.analog.com (10.48.65.163) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Tue, 29 Oct 2019 09:30:49 -0400
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
Subject: [PATCH v2 2/4] iio: adc: ad7091r5: Add scale and external VREF support
Date:   Tue, 29 Oct 2019 18:29:26 +0200
Message-ID: <20191029162928.9720-2-beniamin.bia@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191029162928.9720-1-beniamin.bia@analog.com>
References: <20191029162928.9720-1-beniamin.bia@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(376002)(346002)(189003)(199004)(486006)(76176011)(4326008)(106002)(5660300002)(126002)(476003)(11346002)(47776003)(2616005)(51416003)(7696005)(70206006)(446003)(6916009)(8936002)(44832011)(478600001)(8676002)(70586007)(246002)(86362001)(36756003)(7636002)(50226002)(16586007)(305945005)(7416002)(316002)(336012)(426003)(107886003)(2351001)(186003)(2906002)(356004)(26005)(14444005)(50466002)(54906003)(48376002)(1076003)(6666004);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR03MB2267;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c46eaabc-bca9-4d43-3cd4-08d75c7436e2
X-MS-TrafficTypeDiagnostic: CY1PR03MB2267:
X-Microsoft-Antispam-PRVS: <CY1PR03MB22672B7EF9DC2F3BA95E905AF0610@CY1PR03MB2267.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0205EDCD76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XP4lwy2Yax27DDTR4hTveCmm+s3ygTwwh1biIaX4TLDwI/emiWMhWMsKmQ614Ds+9HjHYiZ2iwfzQLZcwKTQTGk3uKuXSk/qhznd++S0S4swhnLkuz3QJOifdVsH5VTh7DnRKbuzNsObucQRu8d2H7mZtsMiHE53BEyvO4zUad0aaWocHwRrefEO9U0zcXLnzKKPllwO4bro2Vu8/48oU2uSxIR2wznAuqcWo6iqV70ql5oUS3G29SMlhwRhGoYhvOVBGwVTiQTxOfYWnXeS4nyhRJamQupqywV/nkYp8gJQ+B7B+ywqdfbVEa0vL8/AidZ1kSY5FqvsMurfLzJk91dIrHfB+HkMHqoINtnQW1UXqt4aARqd3aXI5kTikaN3ahtxs+T9YGiU8zZ+Hy3H2WaUr4ukjYJOIk/zwOly+hf3TAmB0mTAqyPCOG3d2B1b
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2019 13:30:50.1481
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c46eaabc-bca9-4d43-3cd4-08d75c7436e2
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR03MB2267
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-29_04:2019-10-28,2019-10-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=1 mlxlogscore=999
 impostorscore=0 bulkscore=0 mlxscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910290132
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
Changes in v2:
-device remove function replaced by devm_add_action_or_reset
 drivers/iio/adc/ad7091r-base.c | 41 ++++++++++++++++++++++++++++++++++
 drivers/iio/adc/ad7091r-base.h |  1 +
 drivers/iio/adc/ad7091r5.c     |  5 +++++
 3 files changed, 47 insertions(+)

diff --git a/drivers/iio/adc/ad7091r-base.c b/drivers/iio/adc/ad7091r-base.c
index c2500f614d54..fda1112e7376 100644
--- a/drivers/iio/adc/ad7091r-base.c
+++ b/drivers/iio/adc/ad7091r-base.c
@@ -11,6 +11,7 @@
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 
 #include "ad7091r-base.h"
 
@@ -42,6 +43,7 @@ enum ad7091r_mode {
 struct ad7091r_state {
 	struct device *dev;
 	struct regmap *map;
+	struct regulator *reg;
 	const struct ad7091r_chip_info *chip_info;
 	enum ad7091r_mode mode;
 	struct mutex lock;
@@ -145,6 +147,21 @@ static int ad7091r_read_raw(struct iio_dev *iio_dev,
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
@@ -187,6 +204,16 @@ static irqreturn_t ad7091r_event_handler(int irq, void *private)
 	return IRQ_HANDLED;
 }
 
+void ad7091r_remove(void *data)
+{
+	struct ad7091r_state *st;
+
+	st = (struct ad7091r_state *)data;
+
+	if (st->reg)
+		regulator_disable(st->reg);
+}
+
 int ad7091r_probe(struct device *dev, const char *name,
 		const struct ad7091r_chip_info *chip_info,
 		struct regmap *map, int irq)
@@ -220,6 +247,20 @@ int ad7091r_probe(struct device *dev, const char *name,
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
+	devm_add_action_or_reset(dev, ad7091r_remove, st);
+
 	/* Use command mode by default to convert only desired channels*/
 	ret = ad7091r_set_mode(st, AD7091R_MODE_COMMAND);
 	if (ret < 0)
diff --git a/drivers/iio/adc/ad7091r-base.h b/drivers/iio/adc/ad7091r-base.h
index 5f1147735953..76b76968d071 100644
--- a/drivers/iio/adc/ad7091r-base.h
+++ b/drivers/iio/adc/ad7091r-base.h
@@ -14,6 +14,7 @@ struct ad7091r_state;
 struct ad7091r_chip_info {
 	unsigned int num_channels;
 	const struct iio_chan_spec *channels;
+	unsigned int vref_mV;
 };
 
 extern const struct regmap_config ad7091r_regmap_config;
diff --git a/drivers/iio/adc/ad7091r5.c b/drivers/iio/adc/ad7091r5.c
index 2c44dd02ba1a..7ee4a781cc01 100644
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

