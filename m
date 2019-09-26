Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6185BF05D
	for <lists+linux-iio@lfdr.de>; Thu, 26 Sep 2019 12:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfIZKxF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 26 Sep 2019 06:53:05 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:2494 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726616AbfIZKxD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 26 Sep 2019 06:53:03 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8QAqQVI030649;
        Thu, 26 Sep 2019 06:52:58 -0400
Received: from nam05-dm3-obe.outbound.protection.outlook.com (mail-dm3nam05lp2050.outbound.protection.outlook.com [104.47.49.50])
        by mx0a-00128a01.pphosted.com with ESMTP id 2v6hjwy81d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 26 Sep 2019 06:52:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vc8wJnKFPXus7ru8slLpkicgVv3DnDF//aPeWAVbB/WAWbISB9TMiinZLdfwbqTMas+dJe+mzTrgXbLogXDC0nFv0bur+Zlh3mFh16aFPhEoWbK/IRrQvqP1aLPazFH4Y6oShShMdU3XwGFYuxXGvodhNMujQOZ7+p5Rdet5o7NFVpvyO9YUvPVl1V3g73GiDYxwsKPJOtRAR6LzB04Nv7Bdhntg7taBxyhhq9soJUY4iumgXqKVroB4J2vLKHZjDUv402JJOJSsDLBvCVXNeokIbGEMTmclm+6Ja0Mu9snnGM9BF5cbqyHKwYL8PFo8B39nMR/7KMbhAdDtGN4R3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gaq6GJvrfAbArqIKMG6ZTPuXJwHsd+6DYuWvpf67NJ0=;
 b=XqjS5SC3bWy37iPXayunkvGaV/ahWd5nL43Ug3U8Q2IAKbgSp1aOPXRhnVkTaYweDo9LqqAwdriwiDIG4zrroFU7jv3zXTx1tqQFovPngy6ZR4zvXqRxywhU/qUcGRjDqK1ROe33mPkzBz/g7jA823fS0ongxkD6Vcl4MQ7Tr2qR/6tGXvuviPvw3NhTUNJQCNslCtfrobgxuF94kS+OaKwYKBaut/9V8LtPJP2Z3G2Yx/J4kbpg+LpRBk2ML4b0oM/K9hSFBx3PVVHVPXFLcA8EY7ZSJ9DI3b2pXrrT8XW6jTi0JcMW/jnZknvYpQUGNz/E1fkjE31KlFMSgG3rVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gaq6GJvrfAbArqIKMG6ZTPuXJwHsd+6DYuWvpf67NJ0=;
 b=8A1QXtNgvs9PPTcCp2JWej2TDlEu/c7Cw6JKY5OxFO6fVwFV5Gi791fwK4K4m4hR9QMrf/vm3JW0uNO99UiBT9QPpE79A3wBfSBlnO4M9nWV4QMzLe4j7y0poRDellFke1Z4Pgx18PoOCA8CONdnLq0w7aigaFP2S4ExVQIE/XI=
Received: from DM6PR03CA0001.namprd03.prod.outlook.com (2603:10b6:5:40::14) by
 CY1PR03MB2186.namprd03.prod.outlook.com (2a01:111:e400:c61a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.25; Thu, 26 Sep
 2019 10:52:55 +0000
Received: from BL2NAM02FT062.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::203) by DM6PR03CA0001.outlook.office365.com
 (2603:10b6:5:40::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2157.15 via Frontend
 Transport; Thu, 26 Sep 2019 10:52:55 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BL2NAM02FT062.mail.protection.outlook.com (10.152.77.57) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2284.25
 via Frontend Transport; Thu, 26 Sep 2019 10:52:55 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x8QAqsj4015019
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 26 Sep 2019 03:52:54 -0700
Received: from saturn.ad.analog.com (10.48.65.123) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Thu, 26 Sep 2019 06:52:54 -0400
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
Subject: [PATCH v4 17/19] spi: spi-falcon: extend warning to `delay` as well
Date:   Thu, 26 Sep 2019 13:51:45 +0300
Message-ID: <20190926105147.7839-18-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190926105147.7839-1-alexandru.ardelean@analog.com>
References: <20190926105147.7839-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(136003)(39860400002)(199004)(189003)(186003)(305945005)(1076003)(4326008)(356004)(6666004)(50466002)(2616005)(48376002)(476003)(5660300002)(7416002)(50226002)(7636002)(14444005)(76176011)(486006)(70586007)(246002)(44832011)(336012)(107886003)(36756003)(54906003)(51416003)(110136005)(47776003)(8676002)(2201001)(70206006)(86362001)(446003)(2906002)(2870700001)(11346002)(426003)(8936002)(126002)(26005)(7696005)(4744005)(106002)(478600001)(316002)(81973001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR03MB2186;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d6a6781-a876-4aef-3236-08d7426fafb5
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(4709080)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328);SRVR:CY1PR03MB2186;
X-MS-TrafficTypeDiagnostic: CY1PR03MB2186:
X-Microsoft-Antispam-PRVS: <CY1PR03MB21863485BA2C1BCAB3F4B500F9860@CY1PR03MB2186.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 0172F0EF77
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: E9nvNEsDhwSVt2ElO3T1lc5nRRqzW14bUeiCw4RJETlcYyj7C5BDjI4qPlX4CQwcY7ai3BMG68KIL7fikyhGy1Y4FuhIQG9GIC8Jqks+hbOu6kOzEzVcEyRQQ4c2Z68V5dmBgqG1kosMnqGuzsxnyHU0EM2YL4yWC0F8PkRanZuLjKC7Jgn05yYoUe5fxqOpMVsqQh38mciwd2rdfMFa2IuLCmML09km3zAbQzhdnVM9ea9xfLoKRuWDcl42TQSsdnQ3HU28RVSUTQ+/o1QsVMBG3uZNufHWnRXkxs5MZGtU0IPFgk1YAMn32S7K/VVxp5DY+F03Gdydom0904Oclkl0sYa6lWfN2MwyH+Ot2RjE14+l/Wjlg1zXsNireaP9883qiPg7al6cqFXP3qAXquxg9UTfsbEVgyLDFDt2yeA=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2019 10:52:55.2334
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d6a6781-a876-4aef-3236-08d7426fafb5
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR03MB2186
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-09-26_05:2019-09-25,2019-09-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 mlxlogscore=864 mlxscore=0 adultscore=0 spamscore=0
 malwarescore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1908290000 definitions=main-1909260103
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The WARN_ON macro prints a warning in syslog if `delay_usecs` is non-zero.
However, with the new intermediate `delay`, the warning should also be
printed.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/spi/spi-falcon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-falcon.c b/drivers/spi/spi-falcon.c
index 00f46c816a56..d3336a63f462 100644
--- a/drivers/spi/spi-falcon.c
+++ b/drivers/spi/spi-falcon.c
@@ -377,7 +377,7 @@ static int falcon_sflash_xfer_one(struct spi_master *master,
 
 		m->actual_length += t->len;
 
-		WARN_ON(t->delay_usecs || t->cs_change);
+		WARN_ON(t->delay_usecs || t->delay.value || t->cs_change);
 		spi_flags = 0;
 	}
 
-- 
2.20.1

