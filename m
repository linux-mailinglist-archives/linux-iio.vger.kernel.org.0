Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E154AED7F
	for <lists+linux-iio@lfdr.de>; Tue, 10 Sep 2019 16:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727925AbfIJOoT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 10 Sep 2019 10:44:19 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:16522 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725935AbfIJOoT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 10 Sep 2019 10:44:19 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8AEhacq014269;
        Tue, 10 Sep 2019 10:43:48 -0400
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2059.outbound.protection.outlook.com [104.47.37.59])
        by mx0a-00128a01.pphosted.com with ESMTP id 2uv9f6ahtv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Sep 2019 10:43:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KFMg5Y6fwsGvkVrVLIKV+rJJCGn9J9ZmI19fgryFuTXMT7DnL69FzZqC1pptsJ+uYGpNbFn+w8yI24fieUwkhAYyDbRQYuyFtQc5eiAIXDOYfC4jCdVyZnExW6tDh3VyIyZuAqV0LX8GUBaq0rCCHboVmecVs+YSbo/XoJpzJsdtyMQYW+WAl61F0tDfg+aBHTbdtZGqA8zQPlza323ajKaZ2LsW/K1S4za+Rm28QairPbhypgOQkXnD91YkR9XOhXFjxUjyI9x00vh6MtlTsiFXAaXSY7t6yAEKdrR/0gQSKuc7eSRSfHw/1e4vYbrwTZupX/91uLPRAnVyBym4MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=POajf/KlRCSSRHjI0CEDVfbADDg05/wbdDPcrno9tt8=;
 b=YZqldz6hh5kfCeBb4gZuP5H+OCf+Yfpr8LZaZqj2KBYk7s+c0ZENaXM+D2Dpf8vbaTtyNLQg9GWN/dDP1kkvW0bJCCuZ2or10VcCLyBmPUSBBjip0csVnkguIqTgEQWpDU+OXMdyUPtHNBtsENJHrr3EN/LdUg0V4QwxXxId6G31nZW8tei5LncI/AhEkwZQzFHK99SvvOSYM3YRgSGULsULbrIKK/0yOT4pRg2SKP9c/mVfRY8BoYsiJWtJFMjyVvd+07mMJj0+gRdu8UWxXCyG7b+9XvckAJ2R7Ybo9qWl7OwzLTbdBeiDR1qbEMi1TOQEMcjOyCPb/6EtyG3tGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=gmx.de smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=POajf/KlRCSSRHjI0CEDVfbADDg05/wbdDPcrno9tt8=;
 b=8Tiu8Mx61Hv7ZQElX5fe+n/qnS3TRbGGRa4fUM8YjDixaZwcMP8sJ4VpRr82qb5ck7PJQ3jh5D9gWjWuzbmOIOs8uGJ6YIdqwOyvjJNDZHnRen5R5yHXAS0wBvBcSVtFuHJB3qyTuHxAz1g8MZL2sgJiwUoKSnernap3CIDjVog=
Received: from BN6PR03CA0076.namprd03.prod.outlook.com (2603:10b6:405:6f::14)
 by CH2PR03MB5189.namprd03.prod.outlook.com (2603:10b6:610:a1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2241.13; Tue, 10 Sep
 2019 14:43:46 +0000
Received: from CY1NAM02FT031.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::207) by BN6PR03CA0076.outlook.office365.com
 (2603:10b6:405:6f::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2241.15 via Frontend
 Transport; Tue, 10 Sep 2019 14:43:46 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 CY1NAM02FT031.mail.protection.outlook.com (10.152.75.180) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2241.14
 via Frontend Transport; Tue, 10 Sep 2019 14:43:46 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x8AEhidD030172
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 10 Sep 2019 07:43:44 -0700
Received: from linux.ad.analog.com (10.32.226.41) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.408.0; Tue, 10 Sep 2019
 10:43:44 -0400
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>
CC:     <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <stefan.popa@analog.com>
Subject: [PATCH v2 1/3] iio: accel: adxl372: Fix/remove limitation for FIFO samples
Date:   Tue, 10 Sep 2019 17:43:32 +0300
Message-ID: <1568126612-13134-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(136003)(39860400002)(2980300002)(189003)(199004)(36756003)(48376002)(50466002)(44832011)(47776003)(8676002)(356004)(6666004)(336012)(7696005)(486006)(50226002)(426003)(478600001)(70206006)(106002)(70586007)(8936002)(4326008)(5660300002)(186003)(476003)(2616005)(107886003)(126002)(305945005)(26005)(7636002)(51416003)(2906002)(246002)(2351001)(54906003)(316002)(16586007)(6916009);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5189;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 816862ab-9db1-4c7c-52c2-08d735fd490a
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(4709080)(1401327)(4618075)(2017052603328);SRVR:CH2PR03MB5189;
X-MS-TrafficTypeDiagnostic: CH2PR03MB5189:
X-Microsoft-Antispam-PRVS: <CH2PR03MB5189B9C12FDCA92193F056DF9DB60@CH2PR03MB5189.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 01565FED4C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: vOzVsSaeQ++k3q0Ity8flje/Yif1i3Iux/GWhVm1zA1q/7mJfv0iHJXj4z5hxYuPNAH0pLXzMnAodO0b1A+qt53ptdean2NitSwWhelTWz5qf9nYJ+gq+fLfa9+gLo+d9EIh8CGCR+2hzmOiA3jMtUgs4O3QDDCeIJy1yBry2LKNYQ9U7jM/2JJ0SUSKadSgfHye8wrSTUeFDnWGSg/HpRH7P8uGacFzBzz28YNAdVMtba57Qmb98h4dba6pikvWPUkLAZi/WfxpSoqcWKtRVynksyE7CBftHplaHPGEO6REY0g6Jlw0qjyYoPPD3G+rQ478dHVELW2M4rdijVDgV0RkFawyOAs8u/Aj+vcE0ETk8KrJ5TJ0vQ9FJbhbQR6Bxo4HENXWvmvNIGAbYZnFz83qEP1eiAA0MUX9WDuQBlQ=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2019 14:43:46.0303
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 816862ab-9db1-4c7c-52c2-08d735fd490a
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5189
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-10_10:2019-09-10,2019-09-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=1 spamscore=0 adultscore=0 phishscore=0 mlxscore=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 mlxlogscore=801 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1906280000 definitions=main-1909100142
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Currently, the driver sets the FIFO_SAMPLES register with the number of
sample sets (maximum of 170 for 3 axis data, 256 for 2-axis and 512 for
single axis). However, the FIFO_SAMPLES register should store the number
of samples, regardless of how the FIFO format is configured.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
Changes in v2:
	- st->watermark needs to store the number of sample sets, 
	  the total number of samples is computed in
	  adxl372_configure_fifo() func.

 drivers/iio/accel/adxl372.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
index 055227cb..7de5e1b 100644
--- a/drivers/iio/accel/adxl372.c
+++ b/drivers/iio/accel/adxl372.c
@@ -474,12 +474,17 @@ static int adxl372_configure_fifo(struct adxl372_state *st)
 	if (ret < 0)
 		return ret;
 
-	fifo_samples = st->watermark & 0xFF;
+	/*
+	 * watermak stores the number of sets; we need to write the FIFO
+	 * registers with the number of samples
+	 */
+	fifo_samples = (st->watermark * st->fifo_set_size);
 	fifo_ctl = ADXL372_FIFO_CTL_FORMAT_MODE(st->fifo_format) |
 		   ADXL372_FIFO_CTL_MODE_MODE(st->fifo_mode) |
-		   ADXL372_FIFO_CTL_SAMPLES_MODE(st->watermark);
+		   ADXL372_FIFO_CTL_SAMPLES_MODE(fifo_samples);
 
-	ret = regmap_write(st->regmap, ADXL372_FIFO_SAMPLES, fifo_samples);
+	ret = regmap_write(st->regmap,
+			   ADXL372_FIFO_SAMPLES, fifo_samples & 0xFF);
 	if (ret < 0)
 		return ret;
 
-- 
2.7.4

