Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39A35B3530
	for <lists+linux-iio@lfdr.de>; Mon, 16 Sep 2019 09:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730464AbfIPHKh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Sep 2019 03:10:37 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:31532 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730442AbfIPHKg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Sep 2019 03:10:36 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8G77rTx016418;
        Mon, 16 Sep 2019 03:10:35 -0400
Received: from nam03-by2-obe.outbound.protection.outlook.com (mail-by2nam03lp2058.outbound.protection.outlook.com [104.47.42.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 2v0w47jsqt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Sep 2019 03:10:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n/WqhpnIFsZ4NzI9kInAeB5SiaaXeJ/YsCvdWJbsiBdnVYtkaHXeESd5h9z8lrW9garb5O2+Fr9Y4L7zKbV3PzLSgIfGeZmzBuHns+s1sZR6fso9ulbZsVElBXQFYQBK/lfbGsGYo0K4aaybHKCo6EJ7kISMhRQjcSy/K+DUTtapbqhE1mYsPZ/ycOzSJcOqSuchzzRRUs2Xd9iZPbM92YSfi8dye5tUgQkZpbMoiU1YjUYCCd+zqsxj+Z8955fTcDY2oIwO9nCeH0dVw+cRyKkZYPK/1EAU1qmJHfmqrXWicVSQ6cl/bFjHR99+7caDKAKfLJ01rtieOKZDKI265Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xaM1SxqT2GWMH5PNNJdquphJwaB2Lq4IgSpM3l/5FJI=;
 b=jtfAtDxiFV/9IkoZUxCJLi8HHWB0+QdCw66+5k3yVWWO/0aZC4Nfal9C3j4kBv73zlYDkqHkLQoQbc4Ll9rqrjQHe+k3lK+/nct4IHevgUQOg3U6k0w26PtODTzwujgzYMf0mXcJheLH9O+b53cm/7b38ulkQJ8j3SjTdGFijn0yneckL3jowgm65f3puVSjjCaY5F53rM4ino2+JmYMAjoWmA0mPHe2pp0LNwly6Fro/ZaU/dZqDPMo0kAupxlkFYDVBdh1SLCk7iH3cwoX9cNYLbpILl2OHTn8JNFG9yo7/gpkziX79H3JeIZTAZeQgxGxP8/WGM7h8tsvlO1CcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xaM1SxqT2GWMH5PNNJdquphJwaB2Lq4IgSpM3l/5FJI=;
 b=IW5Kgtm+f9x3axQuikIbm9IraxLKFEZSz6/BNZO4DMKJRNieSxETX/7wI0Pmue4e3LgPADWTXg10UfHxaBAycpflYPZ3yD7IG9eesWiwu0TG6CFZVhMqbzVzskgLE5njkpRfIYo589aRdaNDbwp0gr98JJ9YqAtQHuAQphgHyF8=
Received: from MWHPR03CA0029.namprd03.prod.outlook.com (2603:10b6:301:3b::18)
 by MN2PR03MB4733.namprd03.prod.outlook.com (2603:10b6:208:106::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2263.15; Mon, 16 Sep
 2019 07:10:33 +0000
Received: from BL2NAM02FT028.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::204) by MWHPR03CA0029.outlook.office365.com
 (2603:10b6:301:3b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2263.15 via Frontend
 Transport; Mon, 16 Sep 2019 07:10:33 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BL2NAM02FT028.mail.protection.outlook.com (10.152.77.165) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2263.17
 via Frontend Transport; Mon, 16 Sep 2019 07:10:33 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x8G7ASeQ016135
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 16 Sep 2019 00:10:28 -0700
Received: from saturn.ad.analog.com (10.48.65.123) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Mon, 16 Sep 2019 03:10:32 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <broonie@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v3 3/3] spi: make `cs_change_delay` the first user of the `spi_delay` logic
Date:   Mon, 16 Sep 2019 10:10:24 +0300
Message-ID: <20190916071024.21447-4-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190916071024.21447-1-alexandru.ardelean@analog.com>
References: <20190916071024.21447-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(39860400002)(396003)(136003)(189003)(199004)(86362001)(426003)(26005)(246002)(186003)(48376002)(316002)(47776003)(2870700001)(305945005)(5660300002)(54906003)(110136005)(2906002)(106002)(51416003)(7696005)(36756003)(76176011)(50226002)(107886003)(4326008)(486006)(11346002)(126002)(44832011)(476003)(2616005)(7636002)(8936002)(6666004)(356004)(446003)(478600001)(1076003)(70206006)(14444005)(70586007)(50466002)(8676002)(2201001)(336012)(81973001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR03MB4733;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0020b6fc-e89e-4413-823d-08d73a74f71b
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(4709080)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328);SRVR:MN2PR03MB4733;
X-MS-TrafficTypeDiagnostic: MN2PR03MB4733:
X-Microsoft-Antispam-PRVS: <MN2PR03MB47330E7DB6F7EA919F34ECC5F98C0@MN2PR03MB4733.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 0162ACCC24
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: OujM9dNsT/stJcuALV6tHpdaN9Ax0tIQ9ypahZnzuPLnxb5rvlZXC0YEmf7dKeHvT+cj9I/s0Yq8jAatb83r16m7R6HYvfwN0R1CPiUTJTbH6YZ/9JSBo9QY8k1fP30GJStBkjaE7EFFqqQlcfIlx8rAAXdcuOv4ff6diu7d89ClnCy1h8VUZBAOlXQ+3JdnyK3UKCfdo8KKcOfq5V1qFf3coRfm6V2jDseqSsR9Gqx8L6nAlzYFPVnNdkkMzR17uZACR3IrkO/uM2obNd2/o9fHgxFI+U6QcH6S3xnGg3t2jyJpL9W0fnGOebNAONoiAOhfjl7aGKsNltE74GB8nxe9iDU2omoL3YhrkUPqNmbes0uKfls7oBPK6X2R3PVctq0kJs21Sb/VYdvFmqfit3nVADpobsipsQiGWdR9QNw=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2019 07:10:33.2186
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0020b6fc-e89e-4413-823d-08d73a74f71b
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB4733
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-16_04:2019-09-11,2019-09-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 mlxscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909160077
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Since the logic for `spi_delay` struct + `spi_delay_exec()` has been copied
from the `cs_change_delay` logic, it's natural to make this delay, the
first user.

The `cs_change_delay` logic requires that the default remain 10 uS, in case
it is unspecified/unconfigured. So, there is some special handling needed
to do that.

The ADIS library is one of the few users of the new `cs_change_delay`
parameter for an spi_transfer.

The introduction of the `spi_delay` struct, requires that the users of of
`cs_change_delay` get an update. This change also updates the ADIS library.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/imu/adis.c  | 24 ++++++++++++------------
 drivers/spi/spi.c       | 28 +++++++---------------------
 include/linux/spi/spi.h |  4 +---
 3 files changed, 20 insertions(+), 36 deletions(-)

diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
index 1631c255deab..2cd2cc2316c6 100644
--- a/drivers/iio/imu/adis.c
+++ b/drivers/iio/imu/adis.c
@@ -39,24 +39,24 @@ int adis_write_reg(struct adis *adis, unsigned int reg,
 			.len = 2,
 			.cs_change = 1,
 			.delay_usecs = adis->data->write_delay,
-			.cs_change_delay = adis->data->cs_change_delay,
-			.cs_change_delay_unit = SPI_DELAY_UNIT_USECS,
+			.cs_change_delay.value = adis->data->cs_change_delay,
+			.cs_change_delay.unit = SPI_DELAY_UNIT_USECS,
 		}, {
 			.tx_buf = adis->tx + 2,
 			.bits_per_word = 8,
 			.len = 2,
 			.cs_change = 1,
 			.delay_usecs = adis->data->write_delay,
-			.cs_change_delay = adis->data->cs_change_delay,
-			.cs_change_delay_unit = SPI_DELAY_UNIT_USECS,
+			.cs_change_delay.value = adis->data->cs_change_delay,
+			.cs_change_delay.unit = SPI_DELAY_UNIT_USECS,
 		}, {
 			.tx_buf = adis->tx + 4,
 			.bits_per_word = 8,
 			.len = 2,
 			.cs_change = 1,
 			.delay_usecs = adis->data->write_delay,
-			.cs_change_delay = adis->data->cs_change_delay,
-			.cs_change_delay_unit = SPI_DELAY_UNIT_USECS,
+			.cs_change_delay.value = adis->data->cs_change_delay,
+			.cs_change_delay.unit = SPI_DELAY_UNIT_USECS,
 		}, {
 			.tx_buf = adis->tx + 6,
 			.bits_per_word = 8,
@@ -139,16 +139,16 @@ int adis_read_reg(struct adis *adis, unsigned int reg,
 			.len = 2,
 			.cs_change = 1,
 			.delay_usecs = adis->data->write_delay,
-			.cs_change_delay = adis->data->cs_change_delay,
-			.cs_change_delay_unit = SPI_DELAY_UNIT_USECS,
+			.cs_change_delay.value = adis->data->cs_change_delay,
+			.cs_change_delay.unit = SPI_DELAY_UNIT_USECS,
 		}, {
 			.tx_buf = adis->tx + 2,
 			.bits_per_word = 8,
 			.len = 2,
 			.cs_change = 1,
 			.delay_usecs = adis->data->read_delay,
-			.cs_change_delay = adis->data->cs_change_delay,
-			.cs_change_delay_unit = SPI_DELAY_UNIT_USECS,
+			.cs_change_delay.value = adis->data->cs_change_delay,
+			.cs_change_delay.unit = SPI_DELAY_UNIT_USECS,
 		}, {
 			.tx_buf = adis->tx + 4,
 			.rx_buf = adis->rx,
@@ -156,8 +156,8 @@ int adis_read_reg(struct adis *adis, unsigned int reg,
 			.len = 2,
 			.cs_change = 1,
 			.delay_usecs = adis->data->read_delay,
-			.cs_change_delay = adis->data->cs_change_delay,
-			.cs_change_delay_unit = SPI_DELAY_UNIT_USECS,
+			.cs_change_delay.value = adis->data->cs_change_delay,
+			.cs_change_delay.unit = SPI_DELAY_UNIT_USECS,
 		}, {
 			.rx_buf = adis->rx + 2,
 			.bits_per_word = 8,
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 1883de8ffa82..d0bf0ffca042 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1160,9 +1160,9 @@ EXPORT_SYMBOL_GPL(spi_delay_exec);
 static void _spi_transfer_cs_change_delay(struct spi_message *msg,
 					  struct spi_transfer *xfer)
 {
-	u32 delay = xfer->cs_change_delay;
-	u32 unit = xfer->cs_change_delay_unit;
-	u32 hz;
+	u32 delay = xfer->cs_change_delay.value;
+	u32 unit = xfer->cs_change_delay.unit;
+	int ret;
 
 	/* return early on "fast" mode - for everything but USECS */
 	if (!delay) {
@@ -1171,27 +1171,13 @@ static void _spi_transfer_cs_change_delay(struct spi_message *msg,
 		return;
 	}
 
-	switch (unit) {
-	case SPI_DELAY_UNIT_USECS:
-		delay *= 1000;
-		break;
-	case SPI_DELAY_UNIT_NSECS: /* nothing to do here */
-		break;
-	case SPI_DELAY_UNIT_SCK:
-		/* if there is no effective speed know, then approximate
-		 * by underestimating with half the requested hz
-		 */
-		hz = xfer->effective_speed_hz ?: xfer->speed_hz / 2;
-		delay *= DIV_ROUND_UP(1000000000, hz);
-		break;
-	default:
+	ret = spi_delay_exec(&xfer->cs_change_delay, xfer);
+	if (ret) {
 		dev_err_once(&msg->spi->dev,
 			     "Use of unsupported delay unit %i, using default of 10us\n",
-			     xfer->cs_change_delay_unit);
-		delay = 10000;
+			     unit);
+		_spi_transfer_delay_ns(10000);
 	}
-	/* now sleep for the requested amount of time */
-	_spi_transfer_delay_ns(delay);
 }
 
 /*
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index c18cfa7cda35..9ded3f44d58e 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -754,7 +754,6 @@ extern void spi_res_release(struct spi_controller *ctlr,
  * @cs_change: affects chipselect after this transfer completes
  * @cs_change_delay: delay between cs deassert and assert when
  *      @cs_change is set and @spi_transfer is not the last in @spi_message
- * @cs_change_delay_unit: unit of cs_change_delay
  * @delay_usecs: microseconds to delay after this transfer before
  *	(optionally) changing the chipselect status, then starting
  *	the next transfer or completing this @spi_message.
@@ -847,8 +846,7 @@ struct spi_transfer {
 	u8		bits_per_word;
 	u8		word_delay_usecs;
 	u16		delay_usecs;
-	u16		cs_change_delay;
-	u8		cs_change_delay_unit;
+	struct spi_delay	cs_change_delay;
 	u32		speed_hz;
 	u16		word_delay;
 
-- 
2.20.1

