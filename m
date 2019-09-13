Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D056B19E8
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2019 10:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387763AbfIMIqr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 Sep 2019 04:46:47 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:32548 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387750AbfIMIqq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Sep 2019 04:46:46 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8D8gdff001882;
        Fri, 13 Sep 2019 04:46:41 -0400
Received: from nam05-dm3-obe.outbound.protection.outlook.com (mail-dm3nam05lp2059.outbound.protection.outlook.com [104.47.49.59])
        by mx0a-00128a01.pphosted.com with ESMTP id 2uytdfsa8b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Sep 2019 04:46:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kz00pCfBzxIKRhh+yvxtVr9DnveytKqdDDJ1pshj6u9PoipFPnigQJrcsj9rFhVjoF2+Cat6Q4TGspdn1dsDC1/yvNfDv7Vy4f+oQnt1janMaPdejKXsQdgfthLqBijpedBGhRmWQJemOPMEv/U4gvvLCUCCu2pWdpLRe7tn+8Qf3LokRDtlCntTTVw7oalIoVeG576h8yfhuWdoAzQRY8KD1V5k6/CRUAfwhaODEDCnx55uvXVS40RPXa2h09Dlew606iTfwABICV/IfPa6XJUIVtz1mPUNVDHWJPMUAAq6pWOjUXWf/MpdV5Qf/Yq3CBzs0R464LqVnrjHEha+uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JAzmWXSpswo0ycbRrXhqzNN7339/xyAx7A2OJPftb4I=;
 b=EZD9CqlFMH2V8Mo4uSaNeK5yyiQFbNbay/DR20nQOU8kRjJOA4WnvV7falUlltQgrCjjIa5A8rrPsUgyk1qaGFwrX5lPcy5xP+C8wwuArKMZWeBTRF7HDS5hCRSglyjUew7M48corHBnKV70bIM5pC+HWHwGEYgMhQjRTKB+hKp+rhm899Dv5ff5zBfUW4EyWHU3alRxdYBaJGJGQYQvJ0n/lDnbkG9OA1c06XurobET6mfLNo+JzT0mbNoHZtu5taOo28L8v2uMR///9t7gz+PI+QOGy5D2bE+WISRu7OzXdUzq9MuYjj5bcxJJoR0oMAExIWhXwEtY2thkorKVSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JAzmWXSpswo0ycbRrXhqzNN7339/xyAx7A2OJPftb4I=;
 b=ohR6I03uTzCoOdKQ2ggFWR3EQ2+e42A/Um1IDTiKvjgLKjUl8gH1VCgFj1Cu+SW2Wv2Ub7JmJ5qZRe6mM6ivncDvT0mAcY5kFBTBPF2zxtLTTjLE04w8x0vYDPYQa4+lFNkHxelsohFbjgT0zEH9MEByz0FH+0L/2mz5JEJ6cr0=
Received: from DM6PR03CA0036.namprd03.prod.outlook.com (2603:10b6:5:40::49) by
 BN7PR03MB3907.namprd03.prod.outlook.com (2603:10b6:408:2d::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.15; Fri, 13 Sep 2019 08:46:39 +0000
Received: from SN1NAM02FT060.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::200) by DM6PR03CA0036.outlook.office365.com
 (2603:10b6:5:40::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2157.17 via Frontend
 Transport; Fri, 13 Sep 2019 08:46:39 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 SN1NAM02FT060.mail.protection.outlook.com (10.152.72.192) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2263.17
 via Frontend Transport; Fri, 13 Sep 2019 08:46:39 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x8D8kYFQ030721
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 13 Sep 2019 01:46:34 -0700
Received: from saturn.ad.analog.com (10.48.65.123) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Fri, 13 Sep 2019 04:46:38 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-spi@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bcm-kernel-feedback-list@broadcom.com>
CC:     <jic23@kernel.org>, <broonie@kernel.org>, <f.fainelli@gmail.com>,
        <linus.walleij@linaro.org>, <orsonzhai@gmail.com>,
        <baolin.wang@linaro.org>, <zhang.lyra@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [RFC PATCH 11/15] spi: tegra114: use `spi_transfer_delay` helper
Date:   Fri, 13 Sep 2019 14:45:46 +0300
Message-ID: <20190913114550.956-12-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190913114550.956-1-alexandru.ardelean@analog.com>
References: <20190913114550.956-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(346002)(39860400002)(136003)(376002)(189003)(199004)(4326008)(305945005)(5660300002)(47776003)(2201001)(7636002)(106002)(48376002)(356004)(7416002)(70586007)(26005)(486006)(70206006)(6666004)(44832011)(478600001)(54906003)(2616005)(2906002)(316002)(476003)(126002)(36756003)(336012)(2870700001)(50466002)(186003)(110136005)(8936002)(11346002)(86362001)(246002)(50226002)(1076003)(8676002)(51416003)(7696005)(107886003)(426003)(446003)(76176011)(81973001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR03MB3907;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c6f280a6-e6a3-4f1a-24ce-08d73826e4d5
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(4709080)(1401327)(4618075)(2017052603328);SRVR:BN7PR03MB3907;
X-MS-TrafficTypeDiagnostic: BN7PR03MB3907:
X-Microsoft-Antispam-PRVS: <BN7PR03MB39077398254CA47854ED51EFF9B30@BN7PR03MB3907.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:751;
X-Forefront-PRVS: 0159AC2B97
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: egxlt7syyxLSegU9uS2TtOR/KUiMy5fQW+9sK7JXvAvEPZLdgOCzUpMefTCVE/Pz5CBXRw1iaMAh7+acYIfDsdmws5y9xXo8vNM1Os7sZ8mruTcqba/ZmIU2edzUl0m8M/WmtSaI3t+MUdAw0XR0UTkv8xze2J3QiOZn691T1LajExNsrkdJ02w7Na371mOGrTgXI6T0vmRZBrSAG9bO4XteQ+tUFtIAffvbDVi7GIU4/peDAYdcvWhBqylw2wJS9UkEbNt5XfQjkN2ovDjdfwZxLO0jwcnbNcZx3V+gY433S5cEuEwynYpd+7BFNj4hKRUfIx+5G7WECuSjTr06YrtGutbw3QoImbx6HVppXQDhoXp5RptvUly4T6G72rRQALe/d+R4QJzADuQimXoi0s/8Ke7n2p4l19EhC+sMcVU=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2019 08:46:39.4042
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6f280a6-e6a3-4f1a-24ce-08d73826e4d5
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR03MB3907
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

The tegra114 driver has a weird/separate `tegra_spi_transfer_delay()`
function that does 2 delays: one mdelay() and one udelay().

This was introduced via commit f4fade12d506e14867a2b0a5e2f7aaf227297d8b
("spi/tegra114: Correct support for cs_change").

There doesn't seem to be a mention in that commit message to suggest a
specific need/use-case for having the 2 delay calls.
For the most part, udelay() should be sufficient.

This change replaces it with the new `spi_transfer_delay()`, which should
do the same thing.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/spi/spi-tegra114.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index 39374c2edcf3..5ac2ceb234fc 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -984,17 +984,6 @@ static int tegra_spi_setup(struct spi_device *spi)
 	return 0;
 }
 
-static void tegra_spi_transfer_delay(int delay)
-{
-	if (!delay)
-		return;
-
-	if (delay >= 1000)
-		mdelay(delay / 1000);
-
-	udelay(delay % 1000);
-}
-
 static void tegra_spi_transfer_end(struct spi_device *spi)
 {
 	struct tegra_spi_data *tspi = spi_master_get_devdata(spi->master);
@@ -1098,7 +1087,7 @@ static int tegra_spi_transfer_one_message(struct spi_master *master,
 complete_xfer:
 		if (ret < 0 || skip) {
 			tegra_spi_transfer_end(spi);
-			tegra_spi_transfer_delay(xfer->delay_usecs);
+			spi_transfer_delay(xfer);
 			goto exit;
 		} else if (list_is_last(&xfer->transfer_list,
 					&msg->transfers)) {
@@ -1106,11 +1095,11 @@ static int tegra_spi_transfer_one_message(struct spi_master *master,
 				tspi->cs_control = spi;
 			else {
 				tegra_spi_transfer_end(spi);
-				tegra_spi_transfer_delay(xfer->delay_usecs);
+				spi_transfer_delay(xfer);
 			}
 		} else if (xfer->cs_change) {
 			tegra_spi_transfer_end(spi);
-			tegra_spi_transfer_delay(xfer->delay_usecs);
+			spi_transfer_delay(xfer);
 		}
 
 	}
-- 
2.20.1

