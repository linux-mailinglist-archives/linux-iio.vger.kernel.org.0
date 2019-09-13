Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3F97B19D4
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2019 10:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387631AbfIMIqZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 Sep 2019 04:46:25 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:17972 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387611AbfIMIqY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Sep 2019 04:46:24 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8D8gcTd001861;
        Fri, 13 Sep 2019 04:46:17 -0400
Received: from nam01-sn1-obe.outbound.protection.outlook.com (mail-sn1nam01lp2050.outbound.protection.outlook.com [104.47.32.50])
        by mx0a-00128a01.pphosted.com with ESMTP id 2uytdfsa7t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 13 Sep 2019 04:46:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xcc57aZMs89FHXJWvyCAOPbpUJHOCqgdeqoCvpK4C/n2JNJkVkusYJKwPGXZBmyV0UPxdBTVWbsJTvXheV138gygY4CeOV3dJQuBdz9e0FoJ2WoXmM23nEMA6bT0gN4GmAjzdDSiMZ8+GTAM1+hD7YK9KdGX1xafp/hJ/DDGgQJl0HyIkRiSkbHprv6wDkLkvLh/GReimJZjON7Lyrco8Cl7AKcyA+LTXcq+DHYAnWcBwTayOGQzHNYV4oLFZhJdJ6wMpUy1fs+m+wDqlb6pXiD+5ndD5+6YjOi0nh4ucn6H0QDRQGkl1ZXwXsly4H0XbWRMSDC5JflpHWmEzGbM6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ESeHHXBfFrG988glXvaIvhiPmUc6BnNdkc+lsz3piTo=;
 b=me79giXRLGKdjIUC2SafIMABt4ASFQu7J1Bx2UDk1N3BHNWUXoJKQaxf+cUHvKfwXrmsKxS7W7goCJmN0Lk/YY1G2DaTtidWGYD+OCL42mkFZ2N1esUxIxVQuOFtfPfNNaLDejyyagXC3hrZFXsS9tmf4g8qP/cfgiRNzOxbJPmZojc4GM2MTLJH/TITf/QYs9wCw+HdnOB1/u8q7MWUsqIunGO+A5jU/zG70uLjcHE3ZUYIJJUa+rNBU5XYBoTWq7JeeM9FgG6Ipy9EB0KGn3/ixQAcqfDrcpvDmVi9st9kjaVei0f7ucg/8NYSAbRO2KFauONhh9/DCWtjG+yHCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ESeHHXBfFrG988glXvaIvhiPmUc6BnNdkc+lsz3piTo=;
 b=KL3QjYWuhzB2b7fr/uoS5UWddVrDZFnPzqxZIv/WM7rU85W0z3nwx+yR1gJmhJHBCWx41yk10Nt1qcKUrtgLK6UVV+JaGBYuMnBmumjOSXZE9qXMoPk3xNcSFN/0ZdwPvneNVzQp9mTKsZMiJCW45F4phx2e2vM7sPIhlg6DCDQ=
Received: from BN6PR03CA0062.namprd03.prod.outlook.com (2603:10b6:404:4c::24)
 by SN6PR03MB3806.namprd03.prod.outlook.com (2603:10b6:805:6a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2220.20; Fri, 13 Sep
 2019 08:46:15 +0000
Received: from SN1NAM02FT048.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::209) by BN6PR03CA0062.outlook.office365.com
 (2603:10b6:404:4c::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2263.17 via Frontend
 Transport; Fri, 13 Sep 2019 08:46:15 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 SN1NAM02FT048.mail.protection.outlook.com (10.152.72.202) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2241.14
 via Frontend Transport; Fri, 13 Sep 2019 08:46:15 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x8D8kAVv030611
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 13 Sep 2019 01:46:10 -0700
Received: from saturn.ad.analog.com (10.48.65.123) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Fri, 13 Sep 2019 04:46:14 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-spi@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bcm-kernel-feedback-list@broadcom.com>
CC:     <jic23@kernel.org>, <broonie@kernel.org>, <f.fainelli@gmail.com>,
        <linus.walleij@linaro.org>, <orsonzhai@gmail.com>,
        <baolin.wang@linaro.org>, <zhang.lyra@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [RFC PATCH 02/15] spi: introduce spi_delay struct as "value + unit" & spi_delay_exec()
Date:   Fri, 13 Sep 2019 14:45:37 +0300
Message-ID: <20190913114550.956-3-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190913114550.956-1-alexandru.ardelean@analog.com>
References: <20190913114550.956-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(396003)(136003)(376002)(39860400002)(199004)(189003)(2201001)(426003)(7696005)(51416003)(14444005)(316002)(110136005)(76176011)(54906003)(2906002)(8936002)(50226002)(70586007)(70206006)(44832011)(486006)(36756003)(2870700001)(7416002)(86362001)(26005)(336012)(106002)(186003)(305945005)(11346002)(2616005)(107886003)(446003)(47776003)(1076003)(478600001)(126002)(356004)(246002)(8676002)(6666004)(48376002)(50466002)(5660300002)(4326008)(7636002)(476003)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR03MB3806;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 714ced24-9e3c-4869-8f80-08d73826d68a
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(4709080)(1401327)(4618075)(2017052603328);SRVR:SN6PR03MB3806;
X-MS-TrafficTypeDiagnostic: SN6PR03MB3806:
X-Microsoft-Antispam-PRVS: <SN6PR03MB3806356536174FDE59F94053F9B30@SN6PR03MB3806.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0159AC2B97
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 6l1XnoKGWXWzCRMQEDiQUrubWL+RBbwWA2jZj9vXXHZJ18ROjphPn6ez7YmTvsTwddYY5FQ18eeMwPRAtGq+utZIroj+GPoWRXUVFX8aVh7QJuOCIBQMB7jAUl1uuiKarbna3+325l5qHQt57FFxTFW7R6QqeqvmNtYEYBTZCCH1rxaRKskSV7vN5gZCYOvAmtnREDuWVWjyJl5ohxqn+AKVS1hLpJNpOjggT2pJ5UaSIUrEYUVEILv/Rh9wRMAuDa/MyjrKfkECdevNcq4N9kYWDILYZ/CmE1+xPJ3oCyhhobxNtKrqJc17NELoVNY/+L58PX2KA3vQjxyxS0moT4QLVOOmUnL/stNLu49L/Y0acpjKiy7IB70EMjhJaIWld68XnoWyriJ/3WvmIJjuJZzBDIdZtG5pQu0X3zirCAY=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2019 08:46:15.4301
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 714ced24-9e3c-4869-8f80-08d73826d68a
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3806
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-13_05:2019-09-11,2019-09-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 spamscore=0 adultscore=0 mlxscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909130083
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

