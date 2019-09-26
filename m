Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D440BF055
	for <lists+linux-iio@lfdr.de>; Thu, 26 Sep 2019 12:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfIZKxA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 26 Sep 2019 06:53:00 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:26050 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726616AbfIZKxA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 26 Sep 2019 06:53:00 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8QAqKSU030417;
        Thu, 26 Sep 2019 06:52:52 -0400
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2050.outbound.protection.outlook.com [104.47.46.50])
        by mx0b-00128a01.pphosted.com with ESMTP id 2v6hku7cd6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Sep 2019 06:52:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GRtO6w60aNbFp3TT9ehI0QDcdriSii7OmoP7pbB90WIlynXJcU1SveHrodbsyW9PiCTgNVe0/32mLMZFcHERskClkMyjaCpE/oJ7yH/PSimhbFieXcpDD77btdnprbrXf2dhQ63vVaRPfWjNUG+9CkzONhQ6wv+TYqipBYcxWqi76kYjyAI3bJdt8u72jYHP/YxA4QD+NFU+Jfz+RntU2wcly5QZyd8fjmddAQLNbkLq39TF582J1AQxMoFg2Fttn6a7WNv5WbqL3IYWesKboafN5aFx/VNdz8edms5jaMhim7xx5Oyhz4lrHkxSO4qxd/2mtDxIeYYEk8BNqrsbTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ImRrYAaX+dFz2bnSYmZEgeSfh2qEMepCcdCui+I1eOk=;
 b=hH5+lkbwBGJNhMZKkEnQMF5cgoSSSpK7kFR+0kupEjRgU/1p8TMSRdHNHWpUQM7AtWAYReFOETA4o4LvbRwLjiXplGlDSSTM1gQqmLP2oVwpZF5RUIpgsTm5tedcMkRItYUCci7oISXm5QcSxVkz60Uat/8IWaX1zyWxE6Y6jSyZhnJsRkf7asu0RbB76vJ3aIgtwABz1oy4wbZpl8AKn8nJ6iS38uPyqqufWWI+IOw3GjKF6o8EvyQjt9URgCTy6cF/V7gpfZXdQQAHWPqprC7UUgsbc+UUMVlPN+MADSqk4B5qc5AVcoK5glDbP+Vg+prrVxGr890jZxnv6p4QXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ImRrYAaX+dFz2bnSYmZEgeSfh2qEMepCcdCui+I1eOk=;
 b=l4SqQqdXCc2sLHZdU54mNU3ApjHQwCwuYuJUdjReLzcUaHEANc28A2m32bjXc5kCq8sPNW7u/jBJqgGoMkcd5ESvDSuzkGF3i8emHNuKVfyNgiAR1EvPuJ8ptY6XalG0Ai5qTirc0ESWgYfv6+Dr94Vr64YxBzLXBamW8ks07SA=
Received: from BN6PR03CA0110.namprd03.prod.outlook.com (2603:10b6:404:10::24)
 by CH2PR03MB5206.namprd03.prod.outlook.com (2603:10b6:610:a3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2305.15; Thu, 26 Sep
 2019 10:52:50 +0000
Received: from BL2NAM02FT053.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::207) by BN6PR03CA0110.outlook.office365.com
 (2603:10b6:404:10::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2305.15 via Frontend
 Transport; Thu, 26 Sep 2019 10:52:49 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BL2NAM02FT053.mail.protection.outlook.com (10.152.76.225) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2284.25
 via Frontend Transport; Thu, 26 Sep 2019 10:52:49 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x8QAqnuF014980
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 26 Sep 2019 03:52:49 -0700
Received: from saturn.ad.analog.com (10.48.65.123) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Thu, 26 Sep 2019 06:52:48 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <bcm-kernel-feedback-list@broadcom.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-tegra@vger.kernel.org>
CC:     <jic23@kernel.org>, <broonie@kernel.org>, <f.fainelli@gmail.com>,
        <linus.walleij@linaro.org>, <orsonzhai@gmail.com>,
        <baolin.wang@linaro.org>, <zhang.lyra@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v4 15/19] spi: implement SW control for CS times
Date:   Thu, 26 Sep 2019 13:51:43 +0300
Message-ID: <20190926105147.7839-16-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190926105147.7839-1-alexandru.ardelean@analog.com>
References: <20190926105147.7839-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(396003)(376002)(39860400002)(346002)(199004)(189003)(1076003)(48376002)(486006)(14444005)(2870700001)(476003)(426003)(107886003)(126002)(11346002)(446003)(2616005)(2906002)(336012)(186003)(2201001)(7416002)(110136005)(70206006)(246002)(70586007)(316002)(5660300002)(356004)(6666004)(44832011)(50466002)(76176011)(26005)(47776003)(106002)(54906003)(86362001)(8676002)(305945005)(478600001)(8936002)(4326008)(36756003)(51416003)(7696005)(50226002)(7636002)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5206;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef1151ee-04fd-4914-63fd-08d7426fac5f
X-MS-TrafficTypeDiagnostic: CH2PR03MB5206:
X-Microsoft-Antispam-PRVS: <CH2PR03MB52064D60B3FD11B6C6306EA4F9860@CH2PR03MB5206.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0172F0EF77
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NauOqDgkbibQYnjg0zeKUOHxhe/3K5kIpt49QHuAZ/KEb/XHmNQH68VcyzEgvK5ROYjXo0LooNGqrlpSmfoIHdzNqnXQU7n1uYHCNsmkrJHt2ZHCUezllJsngUYRCgl6wWBTjhZb3Ni6/0b4fY63h6jvZocsHWWEh0Owuln0jLj5q5bWfubI1QZxyPYgGiJl3XG2jkbZSQN1wO72m8hGalrDfSpwAHp5V4XXJ0Ox+5ppmsvR2Qz42+Ci7EEJfMgoiw98k5BSCRGCkxer5bweV0d3OD/xoHk7MXr0PYK5PVU+Zoonn93UKIOd69SlrjmEsIN5MsOWGDkwB0ktin4oaOdsoU9HRgHlUkjkKp6vgEoyFu34QDzWnferhw5BHYnCEfalIgR0nBLd7WmfMjhyWTGifaM+AAq7JGTGzjI7VcY=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2019 10:52:49.6289
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef1151ee-04fd-4914-63fd-08d7426fac5f
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5206
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-09-26_05:2019-09-25,2019-09-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 clxscore=1015
 adultscore=0 spamscore=0 mlxlogscore=999 mlxscore=0 impostorscore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909260103
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This change implements CS control for setup, hold & inactive delays.

The `cs_setup` delay is completely new, and can help with cases where
asserting the CS, also brings the device out of power-sleep, where there
needs to be a longer (than usual), before transferring data.

The `cs_hold` time can overlap with the `delay` (or `delay_usecs`) from an
SPI transfer. The main difference is that `cs_hold` implies that CS will be
de-asserted.

The `cs_inactive` delay does not have a clear use-case yet. It has been
implemented mostly because the `spi_set_cs_timing()` function implements
it. To some degree, this could overlap or replace `cs_change_delay`, but
this will require more consideration/investigation in the future.

All these delays have been added to the `spi_controller` struct, as they
would typically be configured by calling `spi_set_cs_timing()` after an
`spi_setup()` call.

Software-mode for CS control, implies that the `set_cs_timing()` hook has
not been provided for the `spi_controller` object.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/spi/spi.c       | 45 ++++++++++++++++++++++++++++++++++++++++-
 include/linux/spi/spi.h |  5 +++++
 2 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 122af2264bfe..61ef286f954a 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -775,6 +775,15 @@ int spi_register_board_info(struct spi_board_info const *info, unsigned n)
 
 static void spi_set_cs(struct spi_device *spi, bool enable)
 {
+	bool enable1 = enable;
+
+	if (!spi->controller->set_cs_timing) {
+		if (enable1)
+			spi_delay_exec(&spi->controller->cs_setup, NULL);
+		else
+			spi_delay_exec(&spi->controller->cs_hold, NULL);
+	}
+
 	if (spi->mode & SPI_CS_HIGH)
 		enable = !enable;
 
@@ -800,6 +809,11 @@ static void spi_set_cs(struct spi_device *spi, bool enable)
 	} else if (spi->controller->set_cs) {
 		spi->controller->set_cs(spi, !enable);
 	}
+
+	if (!spi->controller->set_cs_timing) {
+		if (!enable1)
+			spi_delay_exec(&spi->controller->cs_inactive, NULL);
+	}
 }
 
 #ifdef CONFIG_HAS_DMA
@@ -3156,10 +3170,39 @@ EXPORT_SYMBOL_GPL(spi_setup);
 int spi_set_cs_timing(struct spi_device *spi, struct spi_delay *setup,
 		      struct spi_delay *hold, struct spi_delay *inactive)
 {
+	size_t len;
+
 	if (spi->controller->set_cs_timing)
 		return spi->controller->set_cs_timing(spi, setup, hold,
 						      inactive);
-	return -ENOTSUPP;
+
+	if ((setup && setup->unit == SPI_DELAY_UNIT_SCK) ||
+	    (hold && hold->unit == SPI_DELAY_UNIT_SCK) ||
+	    (inactive && inactive->unit == SPI_DELAY_UNIT_SCK)) {
+		dev_err(&spi->dev,
+			"Clock-cycle delays for CS not supported in SW mode\n");
+		return -ENOTSUPP;
+	}
+
+	len = sizeof(struct spi_delay);
+
+	/* copy delays to controller */
+	if (setup)
+		memcpy(&spi->controller->cs_setup, setup, len);
+	else
+		memset(&spi->controller->cs_setup, 0, len);
+
+	if (hold)
+		memcpy(&spi->controller->cs_hold, hold, len);
+	else
+		memset(&spi->controller->cs_hold, 0, len);
+
+	if (inactive)
+		memcpy(&spi->controller->cs_inactive, inactive, len);
+	else
+		memset(&spi->controller->cs_inactive, 0, len);
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(spi_set_cs_timing);
 
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 592e50aae998..66031c8d0093 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -602,6 +602,11 @@ struct spi_controller {
 	/* Optimized handlers for SPI memory-like operations. */
 	const struct spi_controller_mem_ops *mem_ops;
 
+	/* CS delays */
+	struct spi_delay	cs_setup;
+	struct spi_delay	cs_hold;
+	struct spi_delay	cs_inactive;
+
 	/* gpio chip select */
 	int			*cs_gpios;
 	struct gpio_desc	**cs_gpiods;
-- 
2.20.1

