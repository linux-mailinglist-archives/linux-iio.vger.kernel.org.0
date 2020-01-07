Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0E3B132478
	for <lists+linux-iio@lfdr.de>; Tue,  7 Jan 2020 12:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbgAGLGx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 7 Jan 2020 06:06:53 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:64394 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727211AbgAGLGw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 7 Jan 2020 06:06:52 -0500
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 007B4wcX029230;
        Tue, 7 Jan 2020 06:06:48 -0500
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by mx0b-00128a01.pphosted.com with ESMTP id 2xawstxar6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Jan 2020 06:06:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VhDJ0Dwq2CRqxi6MIFmdAMNzHAktvzQfIK81E3Q6f5/8G835iRMw6rSx1i4MLWB2yuLx2SgNrtShq8LhysWy3J8RRLr2ZmX0whc9UG00lV+kQz5fpM9jfnw0NGJG2ppe51PBaUKUs+6UO9Y2E6oFkjOnKHEBjaMhqAbEj2I5Q5Zos0aqEGcn8srp/t0tvmVKzkpow00Cy01nyI2FU7VQ1/DkItu779mKGIqPZo+TthQAX9fUfIGslVkQoK30fiuQH4scSSpPjCVN8jSz+aX3M9iTD9RZPycSx7g7uRcuuR4m5MsIYYaUfOXQqaLVB9eeGtn5EPHBKc3kIJpJ0yZGnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bQ9x2nLIjMw8wZCGOxlq1XhXj32QTMh9mYRs46Y+JSM=;
 b=kx86/Nv+prlRXKRb8Uxo3P7BppE+ZXF3u0SVLJZxfMj4VOZihvPydSDvn/bWAertUAA7/EnF2Opj8ipexdLHoghmQxq0L68QMyW93JeMKhO3eMEutyhjqMjR2EVV6XQ/iy0xGCvZ6SyZe/apuV3F0AHrJIiE3+ipCSpRVNgy2AhGeMI2dOwhxteuo8Fpypbc/Xe5OO3Go5Dp+qCyjFZEk7DO4Q/33U1bbC6wGMjj9AREd8LX2Bv/7oPqbghg8zGxTRueO5m8aiM+vjHD4mwzk3bykcG2/7mTqeUhw57QH6k/ZrM/TEwqgEfvuGja9t0HWV9XrRlsRPYPF0/3asCEtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bQ9x2nLIjMw8wZCGOxlq1XhXj32QTMh9mYRs46Y+JSM=;
 b=Fr3XPQJBR1f6dRVpYdqN/lxt+qL/3O8nSGkGwKFLPn9HpPgUliK0nxBjVTp19xX0Af5zs864tpr8cas4TnaCxEjHvjg2ujY53H7bJEA0FNytOW5fSJFm4EDsgLPw8yl4ALB0NNs7cB8zxmmDU4A6Jn8jrrPqDL0Vj/U5vLQeFyo=
Received: from DM3PR03CA0004.namprd03.prod.outlook.com (2603:10b6:0:50::14) by
 BN6PR03MB3027.namprd03.prod.outlook.com (2603:10b6:404:117::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.8; Tue, 7 Jan 2020 11:06:47 +0000
Received: from CY1NAM02FT012.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::201) by DM3PR03CA0004.outlook.office365.com
 (2603:10b6:0:50::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.11 via Frontend
 Transport; Tue, 7 Jan 2020 11:06:46 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 CY1NAM02FT012.mail.protection.outlook.com (10.152.75.158) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2602.11
 via Frontend Transport; Tue, 7 Jan 2020 11:06:46 +0000
Received: from SCSQMBX10.ad.analog.com (scsqmbx10.ad.analog.com [10.77.17.5])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id 007B6jWd013651
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 7 Jan 2020 03:06:45 -0800
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Tue, 7 Jan 2020
 03:06:44 -0800
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 7 Jan 2020 06:06:44 -0500
Received: from tachici-Precision-5530.ad.analog.com ([10.48.65.175])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 007B6fku003893;
        Tue, 7 Jan 2020 06:06:41 -0500
From:   Alexandru Tachici <alexandru.tachici@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Tachici <alexandru.tachici@analog.com>
Subject: [PATCH V2] iio: ad_sigma_delta: Add custom irq flags
Date:   Tue, 7 Jan 2020 13:06:36 +0200
Message-ID: <20200107110636.28834-1-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200106105747.8244-1-alexandru.tachici@analog.com>
References: <20200106105747.8244-1-alexandru.tachici@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(136003)(39860400002)(189003)(199004)(54534003)(478600001)(54906003)(5660300002)(110136005)(86362001)(2906002)(44832011)(36756003)(4326008)(70586007)(107886003)(70206006)(316002)(426003)(246002)(7696005)(2616005)(1076003)(336012)(356004)(6666004)(7636002)(8676002)(8936002)(186003)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB3027;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9b2e64b8-f2ec-49e4-233f-08d79361afc2
X-MS-TrafficTypeDiagnostic: BN6PR03MB3027:
X-Microsoft-Antispam-PRVS: <BN6PR03MB3027E7A901CF39DE70400D2D903F0@BN6PR03MB3027.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 027578BB13
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pP+XjftGmGXcvQBfgfktt7Xo7beUTSyA57FlpGWOki220DOppp7yYBZO7tLPvWZbuinAhoH4PvNKIIoDrU3wHxDSurPQhr4ARTa5JrgsS0bA3lSc30KR+WZeGE1b8+NStZ/aPZWwzCcGQx8YfWja+dII8m/J9LqoCKqH0sRFQqMklDYA90sZBnGZa6qicqBhpTJ83DHD8qFs+e6e9te61wzf0OcBcbqDVkEJvGNjDx5Dcht4gWpYlgKLZ6UYfU8F9Cj+3niX1efl10k6VJUtJC6ZwanNTG8Bsl903VfqzU6gHSqbUnJWJXPNB0ywXMqOxIZCshhs2nkkXKlApfv2kxUhzinlNYEGRjBel5T9htYi1MbPk+9SGaVzpCpV+eQ3g3KK3Mvm5rDN51ju75Er0N9l1FbxqB3yt312qDZpZD2XqwF89gW9HBMvu902+cRfMmaUbSkdDJbWbzDziU7dgzYzmti5cWNY9BWiBJAtun1yA68cxLTQSt9h78N4dO4Z
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2020 11:06:46.4730
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b2e64b8-f2ec-49e4-233f-08d79361afc2
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB3027
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2020-01-07_02:2020-01-06,2020-01-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 impostorscore=0 clxscore=1015 suspectscore=0 spamscore=0 mlxscore=0
 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001070090
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The data-sheet of AD7124, from the Sigma-Delta ADC family,
recommends that the falling edge of the DOUT line should be used for
an interrupt.

The ad_sigma_delta implementation hardcodes the irq trigger type
to low, assuming that all Sigma-Delta ADCs have the same interrupt-type.
This causes unwanted behaviour. If DOUT line is already low, the
interrupt will fire once, when enabled and the irq handler will send a
read request to the device. At this time the device has not yet finished
the previous conversion and will give a bad reading.

This patch allows drivers using the ad_sigma_delta layer to set the
irq trigger type to the one specified in the corresponding data-sheet.

Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
---
Changelog V1-V2:
 - added a V2 tag

 drivers/iio/adc/ad_sigma_delta.c       | 9 ++++++++-
 include/linux/iio/adc/ad_sigma_delta.h | 2 ++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index d10bd0c97233..0007df8d50fb 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -454,7 +454,7 @@ static int ad_sd_probe_trigger(struct iio_dev *indio_dev)
 
 	ret = request_irq(sigma_delta->spi->irq,
 			  ad_sd_data_rdy_trig_poll,
-			  IRQF_TRIGGER_LOW,
+			  sigma_delta->irq_flags,
 			  indio_dev->name,
 			  sigma_delta);
 	if (ret)
@@ -540,8 +540,15 @@ EXPORT_SYMBOL_GPL(ad_sd_cleanup_buffer_and_trigger);
 int ad_sd_init(struct ad_sigma_delta *sigma_delta, struct iio_dev *indio_dev,
 	struct spi_device *spi, const struct ad_sigma_delta_info *info)
 {
+	unsigned long set_trigger_flags;
+
 	sigma_delta->spi = spi;
 	sigma_delta->info = info;
+
+	set_trigger_flags = sigma_delta->irq_flags & IRQF_TRIGGER_MASK;
+	if (set_trigger_flags == IRQF_TRIGGER_NONE)
+		sigma_delta->irq_flags |= IRQF_TRIGGER_LOW;
+
 	iio_device_set_drvdata(indio_dev, sigma_delta);
 
 	return 0;
diff --git a/include/linux/iio/adc/ad_sigma_delta.h b/include/linux/iio/adc/ad_sigma_delta.h
index 5ba430cc9a87..94a91731c8e8 100644
--- a/include/linux/iio/adc/ad_sigma_delta.h
+++ b/include/linux/iio/adc/ad_sigma_delta.h
@@ -53,6 +53,7 @@ struct ad_sigma_delta_info {
  * struct ad_sigma_delta - Sigma Delta device struct
  * @spi: The spi device associated with the Sigma Delta device.
  * @trig: The IIO trigger associated with the Sigma Delta device.
+ * @irq_flags: flags for the interrupt used by the triggered buffer
  *
  * Most of the fields are private to the sigma delta library code and should not
  * be accessed by individual drivers.
@@ -60,6 +61,7 @@ struct ad_sigma_delta_info {
 struct ad_sigma_delta {
 	struct spi_device	*spi;
 	struct iio_trigger	*trig;
+	unsigned long		irq_flags;
 
 /* private: */
 	struct completion	completion;
-- 
2.20.1

