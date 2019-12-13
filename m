Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9419111E7A5
	for <lists+linux-iio@lfdr.de>; Fri, 13 Dec 2019 17:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbfLMQF3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 Dec 2019 11:05:29 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:29502 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728049AbfLMQF3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Dec 2019 11:05:29 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBDG1utl014245;
        Fri, 13 Dec 2019 11:03:27 -0500
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by mx0a-00128a01.pphosted.com with ESMTP id 2wrb1sjs2r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Dec 2019 11:03:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h9aQmVltKksytEdoGKmebwnWppJQ1wfxU/Ed0KPVEYwXZw+tUX1RZDCLJ3aKMwl41zCVw6tPdldE0N4dx2J7+Z3BmlhYBYqCwaj5F9og8hHVoo1IkzJHGW8RKhqGWXPY+LkAOqgtLPuk1VG256uWN/q6UrvJpQUhf8yKeFzrKMiRA8ga0MIWAH1ser8oHxqLN7vN6a8ab5InlVMLPncpJVDMTHI3Yc90RGd5huZaTDPKnBJ/diJjqfg023JnkwgGMnW4H+URNW/2IFWjleLGNvmXMWOR/6Ua7oyRt5xYQWD/NwzrRe5+dRkKfXK4G1jhE5DF2m60cOkNHx3oWlqIog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tSnkO8VGUrXZgXstlcMZuI3jng77fljerhwtjVpBzNU=;
 b=jGjM71VeQUyRrGRA5JGktKY9fKm7cr0JLoJ7EExyELwOesiCvAeWOuYwQU254ZliqBd8/lEkZJVWPr/a5xpURVsPkJS+OfL0Y9cP+gEQybLDB2mvi5Gpr7oNBSo4HkUtkUS8JIlIkQ2900+aSl/1B968UMMpBhdcRXpXACiqTT0a9//YWPT7d0QpzTqp8x2+FYK9vBpmAquSlsmZrT6Rf5BDRdMC+88upsDHrsygC3JWB2UgUUONivTRtgKCXaPBPvzyXbzI6ycTlfcODd4DDuY+Cx7YSEIH2sMjIBBnVtJIdXTyuUTXyvYkRNoSu2/c5IjwdXftrvZ4tcl7aIu5LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tSnkO8VGUrXZgXstlcMZuI3jng77fljerhwtjVpBzNU=;
 b=4g2BQpzuYYOwQLHVc4BhMbS4eyy4cBUbscsgDAEmk70hvtinC8MPH89juTSNERlMNUaEnBWimARm2UvlOw7HFxoc8iz0UnPLGvxkznk8Rzq5qMAsIDEauIkjy3e5aUXMukRS+zwGs0R9Z/uYTZ8M3VGl7DP2EAoTye3mXNvtxGo=
Received: from CH2PR03CA0006.namprd03.prod.outlook.com (2603:10b6:610:59::16)
 by CO2PR03MB2360.namprd03.prod.outlook.com (2603:10b6:102:16::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.17; Fri, 13 Dec
 2019 16:03:25 +0000
Received: from SN1NAM02FT024.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::203) by CH2PR03CA0006.outlook.office365.com
 (2603:10b6:610:59::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.17 via Frontend
 Transport; Fri, 13 Dec 2019 16:03:25 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 SN1NAM02FT024.mail.protection.outlook.com (10.152.72.127) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2538.14
 via Frontend Transport; Fri, 13 Dec 2019 16:03:24 +0000
Received: from ASHBMBX8.ad.analog.com (ashbmbx8.ad.analog.com [10.64.17.5])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id xBDG3N3r005489
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Fri, 13 Dec 2019 08:03:23 -0800
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Fri, 13 Dec
 2019 11:03:23 -0500
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Fri, 13 Dec 2019 11:03:23 -0500
Received: from saturn.ad.analog.com ([10.48.65.121])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id xBDG3JMM015048;
        Fri, 13 Dec 2019 11:03:21 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Subject: [PATCH 3/5] iio: imu: adis16480: construct adis data on probe vs static on driver
Date:   Fri, 13 Dec 2019 18:03:10 +0200
Message-ID: <20191213160312.1834-3-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191213160312.1834-1-alexandru.ardelean@analog.com>
References: <20191213160312.1834-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(136003)(376002)(189003)(199004)(107886003)(7696005)(246002)(5660300002)(2906002)(26005)(8936002)(316002)(86362001)(7636002)(54906003)(6666004)(8676002)(2616005)(44832011)(478600001)(336012)(186003)(426003)(70206006)(110136005)(1076003)(4326008)(36756003)(356004)(70586007);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR03MB2360;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca4dff51-522f-43d1-9b1d-08d77fe5fba0
X-MS-TrafficTypeDiagnostic: CO2PR03MB2360:
X-Microsoft-Antispam-PRVS: <CO2PR03MB23603ABC1E38743300D5E0A7F9540@CO2PR03MB2360.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:608;
X-Forefront-PRVS: 0250B840C1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jed4MoUNuxPQ6bl+8/5KnDUnPHddwuike7Mjbzuc8jmay3hyQIq98Vi+tRNz6FSrsmLKI92jDW2WyZ7/23bFLHEltPPMGjFfklZZ4ScpH7gMr1YEnSckM/v3B9ZXRvbl0OC3QcTgosVF3K6TByqAoGASPwsu+BSFqBIYRhlHmw0Y4SkCfZ4Je+t1z+a7hxskI2M0Q70cwoOfqUdMSkbHx5odBiHVsYo7rlPnhxB+aBUnrx19wTpwPnxV4fwJhO5qz60PB0MczwHJAhxsKoAB0pDlKr835MdgRo/bCuVi3+I8SrBgsTjXtrLmzfKux2MB+PlA7P2qLWUwUEuaNfFvDsORmZHJXbz1RwA1z0ha1gMhg/J12ngfQrzHYvneeclur17lYB03D+EwzdZHMuSvczocpN+6FFcZLkn61jJDLMs65maG3/OQiA88i66RHs1H
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2019 16:03:24.0938
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca4dff51-522f-43d1-9b1d-08d77fe5fba0
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR03MB2360
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-13_05:2019-12-13,2019-12-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501
 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912130130
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This change is done in preparation of adding an `struct adis_timeout` type.
Some ADIS drivers support multiple drivers, with various combinations of
timeouts. Creating static tables for each driver is possible, but that also
creates quite a lot of duplication.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/imu/adis16480.c | 61 ++++++++++++++++++++++---------------
 1 file changed, 37 insertions(+), 24 deletions(-)

diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
index f73094e8d35d..1edfed83d480 100644
--- a/drivers/iio/imu/adis16480.c
+++ b/drivers/iio/imu/adis16480.c
@@ -1022,29 +1022,6 @@ static const char * const adis16480_status_error_msgs[] = {
 	[ADIS16480_DIAG_STAT_BARO_FAIL] = "Barometer self-test failure",
 };
 
-static const struct adis_data adis16480_data = {
-	.diag_stat_reg = ADIS16480_REG_DIAG_STS,
-	.glob_cmd_reg = ADIS16480_REG_GLOB_CMD,
-	.has_paging = true,
-
-	.read_delay = 5,
-	.write_delay = 5,
-
-	.status_error_msgs = adis16480_status_error_msgs,
-	.status_error_mask = BIT(ADIS16480_DIAG_STAT_XGYRO_FAIL) |
-		BIT(ADIS16480_DIAG_STAT_YGYRO_FAIL) |
-		BIT(ADIS16480_DIAG_STAT_ZGYRO_FAIL) |
-		BIT(ADIS16480_DIAG_STAT_XACCL_FAIL) |
-		BIT(ADIS16480_DIAG_STAT_YACCL_FAIL) |
-		BIT(ADIS16480_DIAG_STAT_ZACCL_FAIL) |
-		BIT(ADIS16480_DIAG_STAT_XMAGN_FAIL) |
-		BIT(ADIS16480_DIAG_STAT_YMAGN_FAIL) |
-		BIT(ADIS16480_DIAG_STAT_ZMAGN_FAIL) |
-		BIT(ADIS16480_DIAG_STAT_BARO_FAIL),
-
-	.enable_irq = adis16480_enable_irq,
-};
-
 static int adis16480_config_irq_pin(struct device_node *of_node,
 				    struct adis16480 *st)
 {
@@ -1195,9 +1172,41 @@ static int adis16480_get_ext_clocks(struct adis16480 *st)
 	return 0;
 }
 
+static struct adis_data *adis16480_adis_data_alloc(struct adis16480 *st,
+						   struct device *dev)
+{
+	struct adis_data *data;
+
+	data = devm_kzalloc(dev, sizeof(struct adis_data), GFP_KERNEL);
+	if (!data)
+		return ERR_PTR(-ENOMEM);
+
+	data->glob_cmd_reg = ADIS16480_REG_GLOB_CMD;
+	data->diag_stat_reg = ADIS16480_REG_DIAG_STS;
+	data->has_paging = true;
+	data->self_test_mask = BIT(1);
+	data->read_delay = 5;
+	data->write_delay = 5;
+	data->status_error_msgs = adis16480_status_error_msgs;
+	data->status_error_mask = BIT(ADIS16480_DIAG_STAT_XGYRO_FAIL) |
+				BIT(ADIS16480_DIAG_STAT_YGYRO_FAIL) |
+				BIT(ADIS16480_DIAG_STAT_ZGYRO_FAIL) |
+				BIT(ADIS16480_DIAG_STAT_XACCL_FAIL) |
+				BIT(ADIS16480_DIAG_STAT_YACCL_FAIL) |
+				BIT(ADIS16480_DIAG_STAT_ZACCL_FAIL) |
+				BIT(ADIS16480_DIAG_STAT_XMAGN_FAIL) |
+				BIT(ADIS16480_DIAG_STAT_YMAGN_FAIL) |
+				BIT(ADIS16480_DIAG_STAT_ZMAGN_FAIL) |
+				BIT(ADIS16480_DIAG_STAT_BARO_FAIL);
+	data->enable_irq = adis16480_enable_irq;
+
+	return data;
+}
+
 static int adis16480_probe(struct spi_device *spi)
 {
 	const struct spi_device_id *id = spi_get_device_id(spi);
+	const struct adis_data *adis16480_data;
 	struct iio_dev *indio_dev;
 	struct adis16480 *st;
 	int ret;
@@ -1218,7 +1227,11 @@ static int adis16480_probe(struct spi_device *spi)
 	indio_dev->info = &adis16480_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	ret = adis_init(&st->adis, indio_dev, spi, &adis16480_data);
+	adis16480_data = adis16480_adis_data_alloc(st, &spi->dev);
+	if (IS_ERR(adis16480_data))
+		return PTR_ERR(adis16480_data);
+
+	ret = adis_init(&st->adis, indio_dev, spi, adis16480_data);
 	if (ret)
 		return ret;
 
-- 
2.20.1

