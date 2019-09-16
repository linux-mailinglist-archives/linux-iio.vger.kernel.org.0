Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4B2B3532
	for <lists+linux-iio@lfdr.de>; Mon, 16 Sep 2019 09:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730442AbfIPHKj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Sep 2019 03:10:39 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:18184 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730480AbfIPHKi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Sep 2019 03:10:38 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8G78bJj003274;
        Mon, 16 Sep 2019 03:10:33 -0400
Received: from nam03-by2-obe.outbound.protection.outlook.com (mail-by2nam03lp2052.outbound.protection.outlook.com [104.47.42.52])
        by mx0b-00128a01.pphosted.com with ESMTP id 2v0sy93f3f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Sep 2019 03:10:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MRT4/brWybreJ+QFUUDIuUFybAYTIncx0gDxceAzoeOHsWN/C6KKVc1MEEI/gAiTFQEcJcacLMM5oWClMdcab/U6cbnvShz3lGY+mZcabpIEUzitsnlajuNS7SfDHNIMs1kJsVQ3VjHsH6zpKQWqSF261ry1by2eeBOsP2O4AG+I46buYzIYdgx8Zvs4ZMPidcREL1Mk0Ps9NOyayrEneakwnSMPK96nmFfrTUGOyoYhKgmibEbZGpbT3N8i7gl2lvLVv+BfGF/4/+VU37jayg1VZaOcMlCL0gZGs4RriwGrWWzJhjWe3sHTy9/ygmdSSwGK4FXcZ9gZlXgED02sQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ESeHHXBfFrG988glXvaIvhiPmUc6BnNdkc+lsz3piTo=;
 b=JJ57e2jUCd1+6F6ernLeR+UTDTaM8NzAZgS89Z+bK6Qigs8FCRe337HfHZgPICDGwMsjtMvniJFVsoC5zNED7BkaMw01pvm5pkxeTms5WkFr783mhewhxVyfXXJ6w9rnF3npCQ6dxET6LE17ARJA864TiAKeulncXdGF8l+f+SqVhdME+ObaTG7t5DFs45DNPzysGv7w2w4ZSC7wPetr14Fvz94TkMtjI0IGbUdog1zxY+7MOAWn32TRkpUpaWqEMMS3q+xkr6zTnLJIOmhgtOM8yxpSQ9VUtqT/Z173Ilw+dzl0hSOcVClkcdP4kygJqsIZTfo26MsOjLQ7jtjDmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ESeHHXBfFrG988glXvaIvhiPmUc6BnNdkc+lsz3piTo=;
 b=zJIBugjtoEtSuzovi30f/4gucIUVmzj1RHgtr4cS19Zx0OH+EwCOTAvcwVbv307t73tbB9bLsQQYtWCsrL/t1NgOz2oieWyBLHBmopKKtjlttHpDOSVYmJ88CqXLhvuvxrvxnMvlRCeqACzhwWWSMsp9+cdoUay0YAk/Fo4BW3Q=
Received: from MWHPR03CA0001.namprd03.prod.outlook.com (2603:10b6:300:117::11)
 by MWHPR03MB2575.namprd03.prod.outlook.com (2603:10b6:300:45::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2263.17; Mon, 16 Sep
 2019 07:10:32 +0000
Received: from BL2NAM02FT038.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::200) by MWHPR03CA0001.outlook.office365.com
 (2603:10b6:300:117::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2263.15 via Frontend
 Transport; Mon, 16 Sep 2019 07:10:31 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BL2NAM02FT038.mail.protection.outlook.com (10.152.77.25) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2263.17
 via Frontend Transport; Mon, 16 Sep 2019 07:10:31 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x8G7AQvZ016120
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 16 Sep 2019 00:10:26 -0700
Received: from saturn.ad.analog.com (10.48.65.123) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Mon, 16 Sep 2019 03:10:31 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <broonie@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v3 2/3] spi: introduce spi_delay struct as "value + unit" &  spi_delay_exec()
Date:   Mon, 16 Sep 2019 10:10:23 +0300
Message-ID: <20190916071024.21447-3-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190916071024.21447-1-alexandru.ardelean@analog.com>
References: <20190916071024.21447-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(39860400002)(396003)(199004)(189003)(2616005)(107886003)(478600001)(246002)(50466002)(106002)(426003)(186003)(36756003)(2201001)(110136005)(486006)(44832011)(26005)(48376002)(316002)(7636002)(54906003)(305945005)(446003)(47776003)(50226002)(7696005)(356004)(2906002)(70586007)(70206006)(476003)(51416003)(8676002)(5660300002)(2870700001)(126002)(336012)(76176011)(14444005)(6666004)(86362001)(1076003)(4326008)(11346002)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR03MB2575;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 007c9fdb-0def-4145-c188-08d73a74f61e
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(4709080)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328);SRVR:MWHPR03MB2575;
X-MS-TrafficTypeDiagnostic: MWHPR03MB2575:
X-Microsoft-Antispam-PRVS: <MWHPR03MB2575EB1BD994A3E398ECA983F98C0@MWHPR03MB2575.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0162ACCC24
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: cJ3ZfMhwlRk9gX6zUcX2rPod4tvASTFPgxz+UN+WYJw+I8ubwzu5ETVxgE55/iqfGtJlHsWrzYZlAAqASGplGiKr/0mySKAWrxjF6x3aj0GqqeSZ2uWIoyiK+yhB6PPZxLsR2baMfy1kWMXcPbK2y4MNAnf+EztG3I/Es3i6k+kNQ3iDSWIiXhiRKCP7cPgROahC5Oh8Dor1aMmE8alr0DdU0BjCWC9ia1i1ZALbbHqDztMfVV9Ud83QP9l2ZJyZWuur/Or18J2cg2PVJ/F3u2ep4ETD7qHgohzkw09rJpSxRkkkd4OTCIDILYc0NIBfcABMR7csMYElUOePN7ydQf+7z6joUiKXCESLgknsmopN3F4Wrx1XC6eqb+PiHS2DSe00IaU+ON03mvsV2LnFj8VC+TmHDJ8RQUuBk9FkrP8=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2019 07:10:31.5622
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 007c9fdb-0def-4145-c188-08d73a74f61e
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB2575
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-16_04:2019-09-11,2019-09-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 spamscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909160077
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

