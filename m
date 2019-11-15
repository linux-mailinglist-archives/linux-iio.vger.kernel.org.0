Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3A00FDF7A
	for <lists+linux-iio@lfdr.de>; Fri, 15 Nov 2019 14:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbfKON50 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 Nov 2019 08:57:26 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:41654 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727417AbfKON50 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 15 Nov 2019 08:57:26 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAFDm0xO000401;
        Fri, 15 Nov 2019 08:56:58 -0500
Received: from nam01-bn3-obe.outbound.protection.outlook.com (mail-bn3nam01lp2051.outbound.protection.outlook.com [104.47.33.51])
        by mx0a-00128a01.pphosted.com with ESMTP id 2w7prk1k8r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Nov 2019 08:56:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ku/VeAjIWWBMFLj2FukU1O/NpjBRSwN9d7DB7+NT3CWtQc+oSFYm3wgxuvSMCw7wbWdajZGxO1ecDXggps9TNLEo1K9F/YVZPOIeDVmoVVW+GYcicjJmSq38mByc/KCLMOuhmX9goiqsJ0AJFQHqU0AW3uZowQtEBgf4GpKlCZxboizd5tAcpScPb9UK558Votf/zi3lxDHgBndvVNk7BVQbgnMvnq2fkxR6QLBY8sj2UNxHfikQoaUDgvXe/QAEjIhcZ+adEeci/So02Z3zxgJX8IS892ceKTDKfMPWDDxy2rKE9BX3joUgEtizbQiSMgOE4rUbnJxFmztv/GDKFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d+rQS7dnye0s1FzYn4rQvwNFg7kcB959BXD/vqi0hoc=;
 b=kZN6flqh3X+2naN1yFAfXBwVKeTAVyZyI+mGC5QzCkBcDapDwNYyJz3YnY1IekDlniS6ts4WIi2TpV8msarCnoEyjZFImDSWGHSAuBjQ981bvJM+kdTxDxh0ode2THGKS/w/xBX/iRt2XzaCI3Bq1Ud4cv/tZCUs6krl5ae914fvzx+VPZ/7wu+1eGQM4DAbQC45c5l/JV1Nndl2FppYNgLO8rXjwFfdw5NU9sKZzSYjnE016ItheclSJUjrtDtEOnUETKiyz91OfzC8bpVyvfVEBB4Agwv/v6eQKZIMzRKEolXN6yLglsafbSWz35QqHs7gNiY0zIzEJ8mRctgr3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d+rQS7dnye0s1FzYn4rQvwNFg7kcB959BXD/vqi0hoc=;
 b=iQIwGcRoWPkzMDL78FfgvJDgaDrlTy5jrAAbyNKa9YRKaWQ68JGTpP89S6W/HIp48c0TjS7X+EOZ7Vwhu/20V8NYhRkbYEnxOo81mkMh77/YQBxLAA9Txq1oTQ5GRmpAC7710SN+P0Et2JPN+MRZtDCbhDX33mYdkZrsOPTxqUY=
Received: from BN6PR03CA0092.namprd03.prod.outlook.com (2603:10b6:405:6f::30)
 by CO2PR03MB2197.namprd03.prod.outlook.com (2603:10b6:102:12::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.29; Fri, 15 Nov
 2019 13:56:56 +0000
Received: from SN1NAM02FT043.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::201) by BN6PR03CA0092.outlook.office365.com
 (2603:10b6:405:6f::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.22 via Frontend
 Transport; Fri, 15 Nov 2019 13:56:56 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 SN1NAM02FT043.mail.protection.outlook.com (10.152.72.184) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2451.23
 via Frontend Transport; Fri, 15 Nov 2019 13:56:56 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id xAFDulUA003076
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 15 Nov 2019 05:56:47 -0800
Received: from ben-Latitude-E6540.ad.analog.com (10.48.65.231) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Fri, 15 Nov 2019 08:56:55 -0500
From:   Beniamin Bia <beniamin.bia@analog.com>
To:     <jic23@kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <pmeerw@pmeerw.net>, <gregkh@linuxfoundation.org>,
        <linux-iio@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        <linux-kernel@vger.kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <biabeniamin@outlook.com>,
        <knaack.h@gmx.de>, <robh+dt@kernel.org>,
        Paul Cercueil <paul.cercueil@analog.com>,
        Beniamin Bia <beniamin.bia@analog.com>
Subject: [PATCH v5 2/4] iio: adc: ad7091r5: Add scale and external VREF support
Date:   Fri, 15 Nov 2019 15:57:21 +0200
Message-ID: <20191115135723.12219-2-beniamin.bia@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191115135723.12219-1-beniamin.bia@analog.com>
References: <20191115135723.12219-1-beniamin.bia@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(39860400002)(396003)(136003)(376002)(189003)(199004)(7416002)(5660300002)(7636002)(305945005)(26005)(8676002)(478600001)(1076003)(106002)(2906002)(186003)(70586007)(70206006)(8936002)(246002)(2351001)(50226002)(50466002)(51416003)(14444005)(36756003)(76176011)(48376002)(7696005)(426003)(336012)(107886003)(6916009)(54906003)(47776003)(316002)(2616005)(476003)(446003)(44832011)(486006)(4326008)(86362001)(356004)(126002)(11346002)(16586007)(6666004);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR03MB2197;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cca9f709-6320-490a-ef73-08d769d3ad35
X-MS-TrafficTypeDiagnostic: CO2PR03MB2197:
X-Microsoft-Antispam-PRVS: <CO2PR03MB2197C04C13ED086948F36E7DF0700@CO2PR03MB2197.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 02229A4115
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m1FEAImiamyZkP+F9W/EDOkvBLcr/8NZ0QkP6JKbDf+F0q/yyB5XkihFVMHjm9+W6i8BMQonLXY3Xo514jrDa8o8BQVAs5uj3RQZSEssDzEIJBiUa7iah84umaexHDXgpVy7HJfDYg1OHT6b6Im/mLlr6f/8V5m0/58wDSUfWMxLp/8PnDrsiICfLo89Ki2JoaE1y9bU/d62i0qTtcN4lYs/v8qc/gBaulrk7PbNSv2IEK/RB51/tFkJXXcSPAq+qlfy52okFU/MbcKGOZsWqRfKp7ZPvjJ7AG5Y7UaTg0++0INg1gAi17qu0GEKpDJt3i1dufvaE7VBzOjGNgRDPLpbRNFSpk5YgeVz4/rNdkiPNDln6tAa25YzAi9PU+Zsl29HPoQl3/fKVO9xEVXJdwrsXuNwD++l7wrGu/yTZD7OorNZXrw7JQjxfPkgGwsc
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2019 13:56:56.0022
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cca9f709-6320-490a-ef73-08d769d3ad35
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR03MB2197
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-15_04:2019-11-15,2019-11-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 mlxlogscore=999 suspectscore=1 clxscore=1015 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911150126
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
Changes in v5:
-check if error is -eprobe instead of eprobe
-one bracket aligned

 drivers/iio/adc/ad7091r-base.c | 38 ++++++++++++++++++++++++++++++++++
 drivers/iio/adc/ad7091r-base.h |  1 +
 drivers/iio/adc/ad7091r5.c     |  5 +++++
 3 files changed, 44 insertions(+)

diff --git a/drivers/iio/adc/ad7091r-base.c b/drivers/iio/adc/ad7091r-base.c
index 854de7c654c2..58fcf1ff8c76 100644
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
+	struct regulator *vref;
 	const struct ad7091r_chip_info *chip_info;
 	enum ad7091r_mode mode;
 	struct mutex lock; /*lock to prevent concurent reads */
@@ -141,6 +143,21 @@ static int ad7091r_read_raw(struct iio_dev *iio_dev,
 		ret = IIO_VAL_INT;
 		break;
 
+	case IIO_CHAN_INFO_SCALE:
+		if (st->vref) {
+			ret = regulator_get_voltage(st->vref);
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
@@ -183,6 +200,13 @@ static irqreturn_t ad7091r_event_handler(int irq, void *private)
 	return IRQ_HANDLED;
 }
 
+static void ad7091r_remove(void *data)
+{
+	struct ad7091r_state *st = data;
+
+	regulator_disable(st->vref);
+}
+
 int ad7091r_probe(struct device *dev, const char *name,
 		const struct ad7091r_chip_info *chip_info,
 		struct regmap *map, int irq)
@@ -216,6 +240,20 @@ int ad7091r_probe(struct device *dev, const char *name,
 			return ret;
 	}
 
+	st->vref = devm_regulator_get_optional(dev, "vref");
+	if (IS_ERR(st->vref)) {
+		if (PTR_ERR(st->reg) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+		st->vref = NULL;
+	} else {
+		ret = regulator_enable(st->vref);
+		if (ret)
+			return ret;
+		ret = devm_add_action_or_reset(dev, ad7091r_remove, st);
+		if (ret)
+			return ret;
+	}
+
 	/* Use command mode by default to convert only desired channels*/
 	ret = ad7091r_set_mode(st, AD7091R_MODE_COMMAND);
 	if (ret)
diff --git a/drivers/iio/adc/ad7091r-base.h b/drivers/iio/adc/ad7091r-base.h
index b0b4fe01a681..509748aef9b1 100644
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
index 30ff0108a6ed..9665679c3ea6 100644
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
@@ -57,11 +60,13 @@ static const struct iio_chan_spec ad7091r5_channels_noirq[] = {
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

