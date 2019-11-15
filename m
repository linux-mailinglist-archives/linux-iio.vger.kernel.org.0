Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AED1FDD62
	for <lists+linux-iio@lfdr.de>; Fri, 15 Nov 2019 13:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbfKOMX3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 Nov 2019 07:23:29 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:32240 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727196AbfKOMX3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 15 Nov 2019 07:23:29 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAFCDFlr007120;
        Fri, 15 Nov 2019 07:23:04 -0500
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2056.outbound.protection.outlook.com [104.47.46.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 2w7prk1ck8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Nov 2019 07:23:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bghK16PQamV4EGVlQfqI3fjzHpZ2RzxHVv/tHdeNOORhLyZuD2XxDeisH0H7bE7hLYpD82LUvT99LbwHKfV1VRNIp0FuMXzuvkMctvW+vprZNbEMhkhwRDbNCCqbCT7HEt6I1kzUmGeIBljDIDFreSOKOchfG+JGm7H8I3Z4koxhPHgSLU88vJskN24feAXrgApiAmsIAn8nyxvnEU4AvKx1p8G+CrNSe4b7itZH/yocYL7Jle0pE1tmEMwAiAdO04jXlO/9UGqlbNDz8scpVsnDAHgPeXt/o11NQ+rBhgv341qY2KXJ+NoM9JJb9OZ77w1iZuaUIfhKhN1Efp6kvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zEPglxLieZ+vDewBgrbInN/TnVk9fwKe0KUdinEaTok=;
 b=eAhE+B1IyCC9iB29MsehlpTLoeOOTRHC+L84tIkG9dg6YebOs3Jnj9Z5Qi7wQgVZgerB1bV3qbo5+81X6RsXHBJGtVtaHvYXJYS78AT5op/LU6Ry9ep+7CKUaLpT7YUzdmIjhbImXgwZsbLG4lH5tSbiI4oiXU9q9RXZ1wKEtAL7Hky1P7HE1HLITc3Qa4oFRVF0EOgRjbjq87CL1Or8um7xZY6F/ahyhlX7AvjwxCndhI44fO3pfIslAF0Y+rnotXhsn+S/1zLq2UP+knQeG6fLUOyq3sQ2O73G9QmrdmQidYUClR1QLTIPvxRhyJvVXBd9xQuP86jj3danFcg8Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zEPglxLieZ+vDewBgrbInN/TnVk9fwKe0KUdinEaTok=;
 b=VUiY8YZIHRjApkso/uXvdjBji276QeH0CQ35K/Yb4IXWMv7IKbnilHhvcGefU1cN06GDa0eYmo2eEWdCMKExACMXBTYV3HdRfgR0UDlJ1P4LVEKwMpo8PGQlPgwIrP5BKdkPkCwchhPlkke2+kPa7QmmjHD0lhiB4btrU+Rygk8=
Received: from CY1PR03CA0015.namprd03.prod.outlook.com (2603:10b6:600::25) by
 BY5PR03MB5348.namprd03.prod.outlook.com (2603:10b6:a03:21b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.26; Fri, 15 Nov
 2019 12:23:02 +0000
Received: from CY1NAM02FT039.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::204) by CY1PR03CA0015.outlook.office365.com
 (2603:10b6:600::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2451.23 via Frontend
 Transport; Fri, 15 Nov 2019 12:23:02 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 CY1NAM02FT039.mail.protection.outlook.com (10.152.75.140) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2451.23
 via Frontend Transport; Fri, 15 Nov 2019 12:23:01 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id xAFCN1oB031778
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 15 Nov 2019 04:23:01 -0800
Received: from ben-Latitude-E6540.ad.analog.com (10.48.65.231) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Fri, 15 Nov 2019 07:23:00 -0500
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
Subject: [PATCH v4 2/4] iio: adc: ad7091r5: Add scale and external VREF support
Date:   Fri, 15 Nov 2019 14:23:14 +0200
Message-ID: <20191115122316.20893-2-beniamin.bia@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191115122316.20893-1-beniamin.bia@analog.com>
References: <20191115122316.20893-1-beniamin.bia@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(396003)(136003)(199004)(189003)(1076003)(7636002)(7416002)(36756003)(6666004)(356004)(47776003)(305945005)(2351001)(246002)(426003)(4326008)(107886003)(486006)(86362001)(44832011)(126002)(476003)(50226002)(2616005)(446003)(11346002)(8676002)(8936002)(7696005)(51416003)(76176011)(478600001)(50466002)(336012)(26005)(106002)(6916009)(316002)(16586007)(5660300002)(54906003)(14444005)(70586007)(2906002)(70206006)(186003)(48376002);DIR:OUT;SFP:1101;SCL:1;SRVR:BY5PR03MB5348;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 579591b9-1761-4859-60bd-08d769c68f06
X-MS-TrafficTypeDiagnostic: BY5PR03MB5348:
X-Microsoft-Antispam-PRVS: <BY5PR03MB53487EC057266253AC9664E8F0700@BY5PR03MB5348.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 02229A4115
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UABvsUCBiAaK7/kN48Av67aivzVoS0JlK5der7adKrdibyzhxd7pq+au1W5uezjCKq2fy0FZ/M5AhZ4xLIjxNPZsZ/E6gLpDJG70GWNgDCtNaGZ9awyGozqncrEQVAZiLk3QlGkBIVwTScQLtL7lnjzrzSP01sym8btkqvyXQxSAHb+1ZnZXIlwebApFZlhIJImEWbkQBkSPmWitmcihH/vAtrIfLLCSrNPVGwTHr1axfDkj6sbeONil3S6TyFDQ5XxdDb0mDhTk+dWFA7hVlR5la/XP1msy4f0nVrv9dEH6bCIoSthHyaMYnC7Kbhbz/7ABQU81QAp0jg4eApL7IKp3wlH3bajREkHoxojx1UNiiKiVPk5SGKq/VXrnpQFxjiJr0kRrHGkbQB4F67Y5U5g1W6MZiOBdhC5E56ySNzifCwpPEOjHAeUlPpTATncP
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2019 12:23:01.8704
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 579591b9-1761-4859-60bd-08d769c68f06
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5348
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-15_03:2019-11-15,2019-11-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 mlxlogscore=999 suspectscore=1 clxscore=1015 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911150116
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
Changes in v4:
-reg renamed to vref
-add ad7091r_remove only on successful reg enable

 drivers/iio/adc/ad7091r-base.c | 39 ++++++++++++++++++++++++++++++++++
 drivers/iio/adc/ad7091r-base.h |  1 +
 drivers/iio/adc/ad7091r5.c     |  5 +++++
 3 files changed, 45 insertions(+)

diff --git a/drivers/iio/adc/ad7091r-base.c b/drivers/iio/adc/ad7091r-base.c
index 854de7c654c2..6e2b6d3f2aa9 100644
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
@@ -216,6 +240,21 @@ int ad7091r_probe(struct device *dev, const char *name,
 			return ret;
 	}
 
+	st->vref = devm_regulator_get_optional(dev, "vref");
+	if (IS_ERR(st->vref)) {
+		if (PTR_ERR(st->vref) == EPROBE_DEFER)
+			return -EPROBE_DEFER;
+
+		st->vref = NULL;
+	} else {
+		ret = regulator_enable(st->vref);
+		if (ret)
+			return ret;
+		ret = devm_add_action_or_reset(dev, ad7091r_remove, st);
+		if (ret)
+			return ret;
+		}
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

