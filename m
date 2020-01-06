Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 015B8130FA4
	for <lists+linux-iio@lfdr.de>; Mon,  6 Jan 2020 10:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbgAFJj1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 Jan 2020 04:39:27 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:27372 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726050AbgAFJj0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 6 Jan 2020 04:39:26 -0500
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0069YmlQ023162;
        Mon, 6 Jan 2020 04:39:23 -0500
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by mx0b-00128a01.pphosted.com with ESMTP id 2xawstu5nw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Jan 2020 04:39:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O2Dxfapy6i2ZIe7P0fJwuo/+2uyl8bkiVpx+cIDpFgJWe27uMJHN2h3ZHyfY689sQ+CvEDn7Pc+4cm755UVor/C73wd7K0oDashD0lqmZ3uVM5TfOZH3q8wbcg6sTAW2KKqzv2hyWYUVGbgh3nJrVHYbGDyl/uGRwaR90BgLh3UkGWZYo2xBcNcWiY9+BUSOzdvYqjU5Iha9ms6qj0KUzc71WZc4uoKPx7DC30jrt/677+KkYr5ehTrlFulJ5lgtF70X19pj7jZsYiffMVNeAFGOHDHGYgJdi6DG9Kjzb6jXyjBYpO75F3fmLwz9x5hsKZ4WxnVBsX7xOgt8hiNtSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qDwAZJVj/bpel8Nw2Kt2dOdoAzNX76v48/YMGeZ7VoE=;
 b=J2miTAiy+dzj7RKipKrnX7jJGPu5ldLs2SU6/STdGQn92F2pKboiYV3QLubDWLKvH3sG/H2wuZOD4ZYKGzVl9Tv8DNPkPKr5TkGr1DVtMpB/ZJy2XLqscXEZ4yg/MqsVuof8/H6cUItwydVb+7W6MsBKFn2lv1Kw9BdKZr94g9Jzq4U/rZznow8W2aXcoYKmm00Nj2IXsOJDt0oDR6PTxl6KVZivLlmgV4EedWTptNwPjcodpSHiee6j40JAK2B8v9vbv73BYVHao6ZIzlU+5IBJj87rK97yfp8DLmNHnWVyl/4I/36QfP45srmgLOcwJMDl+AoW8uMdkNvrJS8J1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qDwAZJVj/bpel8Nw2Kt2dOdoAzNX76v48/YMGeZ7VoE=;
 b=nOvBEzVNsflSOXvBiUXKW9hIOMekubHPHkujvjpKX5jJTn86ARHf/qmQJhvEkK//4p2oCqigzGFhcImxmBQFGrL8jYsZKI0Y6R1KfKz8ZgVU37EBWgWh1ItVh833iOZvZ3svNU8/10nrA/dLhJe+aViuXw5ymu8c7Ufk0NlqUBM=
Received: from BY5PR03CA0014.namprd03.prod.outlook.com (2603:10b6:a03:1e0::24)
 by DM5PR03MB2524.namprd03.prod.outlook.com (2603:10b6:3:74::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.12; Mon, 6 Jan
 2020 09:39:21 +0000
Received: from CY1NAM02FT004.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::208) by BY5PR03CA0014.outlook.office365.com
 (2603:10b6:a03:1e0::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.11 via Frontend
 Transport; Mon, 6 Jan 2020 09:39:21 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 CY1NAM02FT004.mail.protection.outlook.com (10.152.74.112) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2602.11
 via Frontend Transport; Mon, 6 Jan 2020 09:39:21 +0000
Received: from ASHBMBX8.ad.analog.com (ashbmbx8.ad.analog.com [10.64.17.5])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id 0069dKvF002023
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Mon, 6 Jan 2020 01:39:20 -0800
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Mon, 6 Jan 2020
 04:39:19 -0500
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Mon, 6 Jan 2020 04:39:19 -0500
Received: from tachici-Precision-5530.ad.analog.com ([10.48.65.175])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 0069dGOm015123;
        Mon, 6 Jan 2020 04:39:17 -0500
From:   Alexandru Tachici <alexandru.tachici@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Tachici <alexandru.tachici@analog.com>
Subject: [PATCH] iio: ad_sigma_delta: Add custom irq flags
Date:   Mon, 6 Jan 2020 11:38:52 +0200
Message-ID: <20200106093852.29702-1-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(396003)(39860400002)(376002)(346002)(189003)(199004)(2616005)(426003)(70206006)(70586007)(5660300002)(7696005)(186003)(4326008)(8936002)(8676002)(478600001)(107886003)(336012)(6666004)(246002)(86362001)(1076003)(44832011)(2906002)(110136005)(36756003)(54906003)(356004)(316002)(26005)(7636002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR03MB2524;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 30328a42-b63e-4c1e-cdaa-08d7928c4ed4
X-MS-TrafficTypeDiagnostic: DM5PR03MB2524:
X-Microsoft-Antispam-PRVS: <DM5PR03MB2524D849A892702004A1BE86903C0@DM5PR03MB2524.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0274272F87
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +f2H0k7L+Um0L+oeH/Kw7ENJHBsErwBaRBq8chmh5rJqxRNT+0t08z6tVv07f8L1JWP7ZqryDggs2JuqucFaKa7m9VIwYu5cb91URuQaPzcSCj8FZmpPIwpjB+1m6nO3HZZV/7U+tVzZ4Kf2Vgni+IPSJ5HHrv1WYBQqHpmfhKTcsrX1I3cYohQ289ggOzjXUDWLXzHOj2EgjSllwL5un04E0yPx5PrJ+DRGkl2mY72P/TmhYrUImncOqdR68YVIRqJ5fn0tpyaZTJZha1JtJwN30i0LbXVwK9//2rbpgcWEknoaOmKlO/owFu2hYysuxbBoSSDy92rS9+5uDZ/rGuIYme3JdnaFYrylgHIc35EmQiAJNLOAKGw6aWWPo/mKD82JLv4bidZosL3uYj26nkSi7XTHO5oTcDImfk3A88QcVk/hztfWIdVzpQpxl9T9
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2020 09:39:21.0564
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30328a42-b63e-4c1e-cdaa-08d7928c4ed4
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB2524
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2020-01-06_02:2020-01-06,2020-01-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 impostorscore=0 clxscore=1015 suspectscore=0 spamscore=0 mlxscore=0
 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001060088
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
 drivers/iio/adc/ad_sigma_delta.c       | 11 ++++++++++-
 include/linux/iio/adc/ad_sigma_delta.h |  5 +++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index 8ba90486c787..ef8c356b11ee 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -500,7 +500,7 @@ static int ad_sd_probe_trigger(struct iio_dev *indio_dev)
 
 	ret = request_irq(sigma_delta->spi->irq,
 			  ad_sd_data_rdy_trig_poll,
-			  IRQF_TRIGGER_LOW,
+			  sigma_delta->irq_flags,
 			  indio_dev->name,
 			  sigma_delta);
 	if (ret)
@@ -586,8 +586,17 @@ EXPORT_SYMBOL_GPL(ad_sd_cleanup_buffer_and_trigger);
 int ad_sd_init(struct ad_sigma_delta *sigma_delta, struct iio_dev *indio_dev,
 	struct spi_device *spi, const struct ad_sigma_delta_info *info)
 {
+	unsigned long set_trigger_flags;
+
 	sigma_delta->spi = spi;
 	sigma_delta->info = info;
+	sigma_delta->num_slots = 1;
+	sigma_delta->active_slots = 1;
+
+	set_trigger_flags = sigma_delta->irq_flags & IRQF_TRIGGER_MASK;
+	if (set_trigger_flags == IRQF_TRIGGER_NONE)
+		sigma_delta->irq_flags |= IRQF_TRIGGER_LOW;
+
 	iio_device_set_drvdata(indio_dev, sigma_delta);
 
 	return 0;
diff --git a/include/linux/iio/adc/ad_sigma_delta.h b/include/linux/iio/adc/ad_sigma_delta.h
index 8a4e25a7080c..0d3fa1e16f5e 100644
--- a/include/linux/iio/adc/ad_sigma_delta.h
+++ b/include/linux/iio/adc/ad_sigma_delta.h
@@ -55,6 +55,8 @@ struct ad_sigma_delta_info {
  * struct ad_sigma_delta - Sigma Delta device struct
  * @spi: The spi device associated with the Sigma Delta device.
  * @trig: The IIO trigger associated with the Sigma Delta device.
+ * @num_slots: Number of sequencer slots
+ * @irq_flags: flags for the interrupt used by the triggered buffer
  *
  * Most of the fields are private to the sigma delta library code and should not
  * be accessed by individual drivers.
@@ -63,6 +65,9 @@ struct ad_sigma_delta {
 	struct spi_device	*spi;
 	struct iio_trigger	*trig;
 
+	unsigned int		num_slots;
+	unsigned long		irq_flags;
+
 /* private: */
 	struct completion	completion;
 	bool			irq_dis;
-- 
2.20.1

