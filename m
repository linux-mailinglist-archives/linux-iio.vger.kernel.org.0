Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 292DBF321E
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2019 16:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388989AbfKGPJG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 7 Nov 2019 10:09:06 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:20974 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729813AbfKGPJF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 7 Nov 2019 10:09:05 -0500
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA7F3dwA020943;
        Thu, 7 Nov 2019 10:07:53 -0500
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2059.outbound.protection.outlook.com [104.47.45.59])
        by mx0b-00128a01.pphosted.com with ESMTP id 2w41vktgfh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Nov 2019 10:07:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MJta/SUxO/rrJjyPa5OQ5kI9JlO+5LXcRWBupq4FzcWnnvzE9qBxrgVw8dKR2Kb7FCzxM/TRA/0TRc9fyxv1Dp/rT2Q0Q+uVuziT4BfDZZjSktJfnTkltlnG/tpne7xuhGfwaksT3uWD6eTUGN+1EBFy2aFfO2lNmy/dGsk8D80VW9bcg4jfdhVwkf3TP+hCL/DsqJFIM+B/SdGIY0DVs7EabFjuYL6OaSYA1rCAod73CsesI85SyknAKvy900LnuxNAAC3ydlQblqcw0HSjNXdWIxyWe7X7MXI2rniLJkbX+3rMGIdfeqpe1nGkZ2HohHSUaFB0k23VlLv3U2851Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mYKHFTAPDGM3XCt4ceCUrlcwslqM9rW/4cUfJ8m/8Wo=;
 b=F8z8HuZPNvSLFPqIxf/IV9tjKl//ckxAPYsrNz48jfZoAwxxEYWwWqvn/3llWdaAU8tD2Xs6i6PiF3s+ffkkXW1O5B3U4Jt/Bj94OJp6R7B92HV7wTnz41tcdgbeLS7PdHn6QlkaHmKnSbenPUGOOWFohaCPM4AqMHUDY7nDrAESZ/MDqSp0uniS5Xq/53rp3GWfz508bcb4j6HNDkW3FNzdSr3prlpPxRelWjmrOLS/OvDO2PqZNOq6CG5sTjtKJsBdLB9r2qxxe2g9U5jcPNg9tGvWBxlcVy3v6etwS9tS5iIRAXUeZvGiCVisVj99tx7OIh0uJzd93U17iLrTtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=driverdev.osuosl.org
 smtp.mailfrom=analog.com; dmarc=bestguesspass action=none
 header.from=analog.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mYKHFTAPDGM3XCt4ceCUrlcwslqM9rW/4cUfJ8m/8Wo=;
 b=aJkqR/q1WCVv9BKYvaahDt+TQ6SklOiKHpy1ZBZCnR0l1j1ZmUPyaX+dI+iNSanR9wZNXH15gyNwYkD/2ZDZYpmTbz8a2U1HAuNZm/5DVaHrQmfOVGyxmGuT4PRsfQcIOuYvca3r6l+xIJsqLE5KRc3POkCkK/2zStg/niN7iKY=
Received: from DM6PR03CA0041.namprd03.prod.outlook.com (2603:10b6:5:100::18)
 by CH2PR03MB5269.namprd03.prod.outlook.com (2603:10b6:610:90::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.20; Thu, 7 Nov
 2019 15:07:50 +0000
Received: from CY1NAM02FT019.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::200) by DM6PR03CA0041.outlook.office365.com
 (2603:10b6:5:100::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.20 via Frontend
 Transport; Thu, 7 Nov 2019 15:07:50 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 CY1NAM02FT019.mail.protection.outlook.com (10.152.75.177) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2430.20
 via Frontend Transport; Thu, 7 Nov 2019 15:07:50 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id xA7F7n0p024234
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 7 Nov 2019 07:07:49 -0800
Received: from ben-Latitude-E6540.ad.analog.com (10.48.65.231) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Thu, 7 Nov 2019 10:07:48 -0500
From:   Beniamin Bia <beniamin.bia@analog.com>
To:     <jic23@kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <pmeerw@pmeerw.net>, <gregkh@linuxfoundation.org>,
        <linux-iio@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        <linux-kernel@vger.kernel.org>, <mark.rutland@arm.com>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <paulmck@linux.ibm.com>, <mchehab+samsung@kernel.org>,
        <linus.walleij@linaro.org>, <nicolas.ferre@microchip.com>,
        <biabeniamin@outlook.com>,
        Paul Cercueil <paul.cercueil@analog.com>,
        Beniamin Bia <beniamin.bia@analog.com>
Subject: [PATCH v3 2/4] iio: adc: ad7091r5: Add scale and external VREF support
Date:   Thu, 7 Nov 2019 17:07:57 +0200
Message-ID: <20191107150759.5937-2-beniamin.bia@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191107150759.5937-1-beniamin.bia@analog.com>
References: <20191107150759.5937-1-beniamin.bia@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(346002)(396003)(376002)(39860400002)(189003)(199004)(476003)(70206006)(70586007)(5660300002)(356004)(54906003)(6666004)(106002)(14444005)(316002)(16586007)(6916009)(7416002)(36756003)(7636002)(478600001)(2906002)(305945005)(26005)(47776003)(107886003)(50466002)(86362001)(2351001)(246002)(8936002)(48376002)(336012)(1076003)(51416003)(426003)(76176011)(7696005)(446003)(4326008)(44832011)(126002)(11346002)(2616005)(8676002)(186003)(486006)(50226002);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5269;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 909e788c-1c44-48db-c9c9-08d7639441a8
X-MS-TrafficTypeDiagnostic: CH2PR03MB5269:
X-Microsoft-Antispam-PRVS: <CH2PR03MB526908DA55C8707207619CA9F0780@CH2PR03MB5269.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0214EB3F68
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8WgAjIq+ZUv5UAO623YlRqotuUGQi4ga94WzxI6uC1zsLTd5fOIKRRdPP3nMHyoOrp8GXnCH2v39ilmk+Zv4kNO7obeeiDMDxV8c1Cozi2cAqQo0K+/THo/KEuaqeVanslqDNGSyw6uzeQkrP3jBn93MPSL5V02ikWLtyQdMAS81bXOYhJNA3chzKlcAvIVX8Y53bcGfCffNaWeLgtPv0B0hLdp5cLgbyp+gSrTuTLJZ/FMerJbbjoq4GuOMYn3Rgz+c1owr/zuGaWtZpxw3zMZm+yrNIX/eY7DdXCKNxSG+mWiLXfkkUFJDz8BYPjVCdWQHUoG4ZVf3fxdO4injYnQ5E0YWAHHRhVz9HVBA0wc+Cd+HJoAh+UzDR8kPSe0zpTv9wdN6jF/tTeqnB765H+f+sPj+tppUOtNj2rjtEaGFycgfkBaw2Hbiwax50XVy
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2019 15:07:50.2646
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 909e788c-1c44-48db-c9c9-08d7639441a8
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5269
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-07_05:2019-11-07,2019-11-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 impostorscore=0 phishscore=0 suspectscore=1
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911070145
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
Changes in v3:
-type cast from void* in remove function removed
-error checking for devm_add_action_or_reset

 drivers/iio/adc/ad7091r-base.c | 41 ++++++++++++++++++++++++++++++++++
 drivers/iio/adc/ad7091r-base.h |  1 +
 drivers/iio/adc/ad7091r5.c     |  5 +++++
 3 files changed, 47 insertions(+)

diff --git a/drivers/iio/adc/ad7091r-base.c b/drivers/iio/adc/ad7091r-base.c
index 2ebc40dfd927..abb0d9c2ea9c 100644
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
@@ -142,6 +144,21 @@ static int ad7091r_read_raw(struct iio_dev *iio_dev,
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
@@ -184,6 +201,14 @@ static irqreturn_t ad7091r_event_handler(int irq, void *private)
 	return IRQ_HANDLED;
 }
 
+static void ad7091r_remove(void *data)
+{
+	struct ad7091r_state *st = data;
+
+	if (st->reg)
+		regulator_disable(st->reg);
+}
+
 int ad7091r_probe(struct device *dev, const char *name,
 		const struct ad7091r_chip_info *chip_info,
 		struct regmap *map, int irq)
@@ -217,6 +242,22 @@ int ad7091r_probe(struct device *dev, const char *name,
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
+	ret = devm_add_action_or_reset(dev, ad7091r_remove, st);
+	if (ret)
+		return ret;
+
 	/* Use command mode by default to convert only desired channels*/
 	ret = ad7091r_set_mode(st, AD7091R_MODE_COMMAND);
 	if (ret)
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
index f7b3326032e8..73d18ddfd2c9 100644
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

