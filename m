Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25571B1A45
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2019 10:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387758AbfIMI4H (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 Sep 2019 04:56:07 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:12902 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387615AbfIMI4H (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Sep 2019 04:56:07 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8D8qtmL003288;
        Fri, 13 Sep 2019 04:56:04 -0400
Received: from nam05-dm3-obe.outbound.protection.outlook.com (mail-dm3nam05lp2058.outbound.protection.outlook.com [104.47.49.58])
        by mx0b-00128a01.pphosted.com with ESMTP id 2uytcwh9kr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Sep 2019 04:56:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fX/MVgk7J6xWsH15MqMNkx+iCXhBnk2OvuH1k+mdoQL6k/D6njyAKROMYDc5jV+7MtKHAmU8RYBJRpilrlvx4/k9HBjE1/V5hluyYcfPRHKCEJI4BmcZkRmvw6FEFAQiWVHJFxBFtG7mAUfuOkNISswX1RcZpE9zTlm1RL07CLvYjR9rM8OHGlLnbE/6RLQnggp0pw4AJ/mrJ577XTJmnaPnSK4bnC7F+mNEod+QwQ0y6wIAherzEfJ9vRzwPKjmnnNvSyq16atnG+mO1zYBzevr53QK3Num+h2qcwexDvoLyBQDA+uu6VIx3wNnZTthtELzz8TXFMSEHh3AqhLvUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ESeHHXBfFrG988glXvaIvhiPmUc6BnNdkc+lsz3piTo=;
 b=kD/PNz1e3SCceFtCA376oYHiV5yJjM+WH61znI/92YCYnd9Mujr8Wf3qAvpLpBb10NgSVUMxC/ZM7ToXbnfHUkeYl7xg+q19aaDOxuNTENFDmYlkFfEAp8rWijIMcRIMghbf8bzxNgQPNAaIUQuse7iRP68hHMoaTx9j3vvifqREEs5B7zMSe8iA3uMRGy0sJy9iOnfyE1uWKDdPwUaDoC4zXIKkgM79+nwIOtiKFzRWXo5rT/LsogrHNSAJqzedfjzf2HebxPI3nG6jAPp684CmKN/nUDS98Sn5aF6AxRMdrXQu2SfUNJsj1u6Y81tbVPRYR6nWYi1gWPYzj0Pzww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ESeHHXBfFrG988glXvaIvhiPmUc6BnNdkc+lsz3piTo=;
 b=ZzpI4IqEnhd6cVBN2RDQlwz5vDC9rUzLqU37WUNI3sUyIzFg/Vp7EUMA4t+Uc5kLQm1ePCWlHsj1NDIpDucV1Rz+JLkZcgmXB9UCnZ75rRnJPlf1w9z4SXQaVJ+t6luuBp3JhTPg1yxMTASHrYu8uJ+0BV8XGNxBMUPF1arkojI=
Received: from MWHPR03CA0060.namprd03.prod.outlook.com (2603:10b6:301:3b::49)
 by BYAPR03MB4856.namprd03.prod.outlook.com (2603:10b6:a03:138::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2263.13; Fri, 13 Sep
 2019 08:56:01 +0000
Received: from CY1NAM02FT035.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::205) by MWHPR03CA0060.outlook.office365.com
 (2603:10b6:301:3b::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2263.17 via Frontend
 Transport; Fri, 13 Sep 2019 08:56:01 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 CY1NAM02FT035.mail.protection.outlook.com (10.152.75.186) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2263.17
 via Frontend Transport; Fri, 13 Sep 2019 08:56:01 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x8D8ttQG000407
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 13 Sep 2019 01:55:56 -0700
Received: from saturn.ad.analog.com (10.48.65.123) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Fri, 13 Sep 2019 04:56:00 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <broonie@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 2/4] spi: introduce spi_delay struct as "value + unit" &  spi_delay_exec()
Date:   Fri, 13 Sep 2019 14:55:47 +0300
Message-ID: <20190913115549.3823-3-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190913115549.3823-1-alexandru.ardelean@analog.com>
References: <20190913115549.3823-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(346002)(376002)(39860400002)(189003)(199004)(8676002)(2906002)(50466002)(6666004)(356004)(14444005)(5660300002)(106002)(47776003)(50226002)(2870700001)(107886003)(2201001)(36756003)(8936002)(48376002)(86362001)(478600001)(486006)(316002)(186003)(126002)(26005)(44832011)(336012)(11346002)(476003)(76176011)(305945005)(70206006)(446003)(7636002)(70586007)(2616005)(426003)(7696005)(110136005)(54906003)(4326008)(246002)(51416003)(1076003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB4856;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b624ec9-e465-4e28-436f-08d7382833d3
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(4709080)(1401327)(4618075)(2017052603328);SRVR:BYAPR03MB4856;
X-MS-TrafficTypeDiagnostic: BYAPR03MB4856:
X-Microsoft-Antispam-PRVS: <BYAPR03MB48562274EF901AC6959DA96FF9B30@BYAPR03MB4856.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0159AC2B97
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 5XZYe7t6MXOao0NzsCJbe+gqVKCrJL4JkXvG4yHZ09usUM12iZw7qLpoZf7eYzLpWncNHd5qVqBzaZe5pfgfUgGhHDNuVNzvrkUww4hKPc3kkjWIBev692SlfaMYU9D67EodLlyBF/unEFM2/+KETY2w8halNNjT7v7YCqTXpQGhla0K8Vr86yQkj38e8SrzYFrZ7Y/9gqGizNMVze3zhm3BpkuRkWu0I85lWpc9kRCIfy5AnyEEudXnr0czSA3sOzCywiFx4HS3K5xfb/01Q9IGaN8L5wLY46mD8e8OuicC0oA84XmunxpxbN25VmNupyBP3BHlDHJwUDq9UpX/KlI4VApSVkPH0fqmE0JHFQejjaZxYr1l/pF7IQXUJ9OTa9gmPpZQenMBdHvYjZoMDARUsUbJASkYzMyuCR19y5E=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2019 08:56:01.4294
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b624ec9-e465-4e28-436f-08d7382833d3
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4856
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-13_05:2019-09-11,2019-09-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 malwarescore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 phishscore=0 impostorscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909130085
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

There are plenty of delays that have been introduced in SPI core. Most of
them are in micro-seconds, some need to be in nano-seconds, and some in
clock-cycles.

For some of these delays (related to transfers & CS timing) it may make
sense to have a `spi_delay` struct that abstracts these a bit.

The important element of these delays [for unification] seems to be the
`unit` of the delay.
It looks like micro-seconds is good enough for most people, but every-once
in a while, some delays seem to require other units of measurement.

This change adds the `spi_delay` struct & a `spi_delay_exec()` function
that processes a `spi_delay` object/struct to execute the delay.
It's a copy of the `cs_change_delay` mechanism, but without the default
for 10 uS.

The clock-cycle delay unit is a bit special, as it needs to be bound to an
`spi_transfer` object to execute.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/spi/spi.c       | 51 +++++++++++++++++++++++++++++++++++++++++
 include/linux/spi/spi.h | 18 ++++++++++++---
 2 files changed, 66 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index c90e02e6d62f..1883de8ffa82 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1106,6 +1106,57 @@ static void _spi_transfer_delay_ns(u32 ns)
 	}
 }
 
+static int _spi_delay_to_ns(struct spi_delay *_delay, struct spi_transfer *xfer)
+{
+	u32 delay = _delay->value;
+	u32 unit = _delay->unit;
+	u32 hz;
+
+	if (!delay)
+		return 0;
+
+	switch (unit) {
+	case SPI_DELAY_UNIT_USECS:
+		delay *= 1000;
+		break;
+	case SPI_DELAY_UNIT_NSECS: /* nothing to do here */
+		break;
+	case SPI_DELAY_UNIT_SCK:
+		/* clock cycles need to be obtained from spi_transfer */
+		if (!xfer)
+			return -EINVAL;
+		/* if there is no effective speed know, then approximate
+		 * by underestimating with half the requested hz
+		 */
+		hz = xfer->effective_speed_hz ?: xfer->speed_hz / 2;
+		if (!hz)
+			return -EINVAL;
+		delay *= DIV_ROUND_UP(1000000000, hz);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return delay;
+}
+
+int spi_delay_exec(struct spi_delay *_delay, struct spi_transfer *xfer)
+{
+	int delay;
+
+	if (!_delay)
+		return -EINVAL;
+
+	delay = _spi_delay_to_ns(_delay, xfer);
+	if (delay < 0)
+		return delay;
+
+	_spi_transfer_delay_ns(delay);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(spi_delay_exec);
+
 static void _spi_transfer_cs_change_delay(struct spi_message *msg,
 					  struct spi_transfer *xfer)
 {
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index af4f265d0f67..c18cfa7cda35 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -89,6 +89,21 @@ void spi_statistics_add_transfer_stats(struct spi_statistics *stats,
 #define SPI_STATISTICS_INCREMENT_FIELD(stats, field)	\
 	SPI_STATISTICS_ADD_TO_FIELD(stats, field, 1)
 
+/**
+ * struct spi_delay - SPI delay information
+ * @value: Value for the delay
+ * @unit: Unit for the delay
+ */
+struct spi_delay {
+#define SPI_DELAY_UNIT_USECS	0
+#define SPI_DELAY_UNIT_NSECS	1
+#define SPI_DELAY_UNIT_SCK	2
+	u16	value;
+	u8	unit;
+};
+
+extern int spi_delay_exec(struct spi_delay *_delay, struct spi_transfer *xfer);
+
 /**
  * struct spi_device - Controller side proxy for an SPI slave device
  * @dev: Driver model representation of the device.
@@ -834,9 +849,6 @@ struct spi_transfer {
 	u16		delay_usecs;
 	u16		cs_change_delay;
 	u8		cs_change_delay_unit;
-#define SPI_DELAY_UNIT_USECS	0
-#define SPI_DELAY_UNIT_NSECS	1
-#define SPI_DELAY_UNIT_SCK	2
 	u32		speed_hz;
 	u16		word_delay;
 
-- 
2.20.1

