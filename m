Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 334A9EC098
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2019 10:36:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728948AbfKAJfc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 1 Nov 2019 05:35:32 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:58338 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728901AbfKAJfc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 1 Nov 2019 05:35:32 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA19XUxi003899;
        Fri, 1 Nov 2019 05:35:20 -0400
Received: from nam03-dm3-obe.outbound.protection.outlook.com (mail-dm3nam03lp2057.outbound.protection.outlook.com [104.47.41.57])
        by mx0a-00128a01.pphosted.com with ESMTP id 2vxwhjrw19-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 01 Nov 2019 05:35:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dn2UkTkbMCS9b1bCYm8ftpCjDpIjzW4scg5gE/0Z2wb92e3rzTGI4KiH5wbOvUdcIFGFA9e5jaDaAO1iKc8maof0DQ64p2QBEO6zI8RZG0TEYmEAGhlQjadO0riirhfrRZH1Lt57pRij9FDAn4IKqW2DYr9iccz+ZLo0GkEjp4u+/8oJlWQ7dRT/NeC9pJtjZ3QCx/qjD1wfk63Cz4TXN5T7YUvOdd/LFuouJanb3JDs6f8KXa7eJzuPtW3vSOgWajwG8C5rHcpgsi0nufDyKlfZW3k9nByZq7BacHD0EzTt0exCe16iAtn5Y46VgrTBWtTVwDJuX05ZfEWbfdr+tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uqAbtWyP1oqZstS4KcjRFQseXzYuanor1MeW60wBkRI=;
 b=hSvsfUu/3/WwbS0ZZ2WfXcl7vLbUvfx7ccUY4EQGUtRyVuTsvSgYNGyu8c0YX4fo6aYvDtzpgR4BmQXCv2vMKH90UsaNYlQl7q5J+E+9vnfZKAy6BwMjhjGE7WOQMxF5zlqbIKFO1/2a+t0ehekx+8zOhXf2vZJ2QHOImbfvhVBukWOkur3zqh1zArUz5pSq1nKkGCmPWYSTzTLeyq5ckMdWMzVU6dmKcMvfx0QVs8kBwi2ia/HCNihX+ui0MfDB2Xg/1bNcQnVdThFW2knTpU3gg0jLF8uQ5zxH1Vl//KcfUXRcGZw8hmQkEgwX51qbQ4TtxjtOHt+IH24FFrZxGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=metafoo.de smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uqAbtWyP1oqZstS4KcjRFQseXzYuanor1MeW60wBkRI=;
 b=OlUC9epEkDFX6h8RgVGWHzIuy0UAAtPlruQ9FXgBtH5i1zlceSt4/grquChkzKZ7mYXq+g/2FtIENeDfz3c87BUjuyOn2X2yoIE/GM6TJrupx6LQCtGB3JdxuRsuyoBwW0nDQ9lSzH1JRlRVVfvzzQhW29XEueLK3MQ3JoJ24D0=
Received: from CH2PR03CA0029.namprd03.prod.outlook.com (2603:10b6:610:59::39)
 by MWHPR03MB2543.namprd03.prod.outlook.com (2603:10b6:300:7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2387.20; Fri, 1 Nov
 2019 09:35:18 +0000
Received: from BL2NAM02FT049.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::209) by CH2PR03CA0029.outlook.office365.com
 (2603:10b6:610:59::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2408.20 via Frontend
 Transport; Fri, 1 Nov 2019 09:35:17 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BL2NAM02FT049.mail.protection.outlook.com (10.152.77.118) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2387.20
 via Frontend Transport; Fri, 1 Nov 2019 09:35:17 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id xA19Z9Qx025004
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 1 Nov 2019 02:35:09 -0700
Received: from saturn.ad.analog.com (10.48.65.117) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Fri, 1 Nov 2019 05:35:16 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <dragos.bogdan@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 03/10] iio: imu: adis16460: check ret val for non-zero vs less-than-zero
Date:   Fri, 1 Nov 2019 11:34:58 +0200
Message-ID: <20191101093505.9408-4-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191101093505.9408-1-alexandru.ardelean@analog.com>
References: <20191101093505.9408-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(346002)(39860400002)(189003)(199004)(86362001)(426003)(7696005)(476003)(446003)(51416003)(356004)(336012)(6666004)(5660300002)(126002)(4326008)(44832011)(2906002)(11346002)(50466002)(110136005)(486006)(186003)(70586007)(70206006)(54906003)(36756003)(106002)(8676002)(48376002)(47776003)(1076003)(2870700001)(246002)(26005)(478600001)(316002)(2616005)(76176011)(107886003)(305945005)(50226002)(8936002)(7636002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR03MB2543;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a8c9ba3-c9e8-41f7-ddb6-08d75eaece1a
X-MS-TrafficTypeDiagnostic: MWHPR03MB2543:
X-Microsoft-Antispam-PRVS: <MWHPR03MB25433CBDA079693D722D97ADF9620@MWHPR03MB2543.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 020877E0CB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 637tHRv6wg7BREuQOU/l3cBrDHyRxPw0OhzKeqME3wRC999WBOPKQnbQJK4ACUBEr8RN0IW+jRNXAGJlZf9f4AU7Uo/zPVD/HTMd+zZ8GsrLoiKbbAV9a2/MvDm6qVUwFVa/mE5ODA4f+8gzWHDVMnB6fPvVhlTUzdevBipAhgSEzVeLEN7FAFeI8YcMmxvBUH5ZXCmj3fXmTJHOPO9YnfOBiCJ0/TXbNLgL4O0uPVUK2SB7ELqUSd7c8N44OYSdgmHsqj3bZERDLjKyRr0KE8IxHtNptX/mmDR2CCk2oyPjSq8gAe72aWd1okVw9O1eXSjNpmofVkdhD422khsq9u5e8dMF6yJmYlIZuDg3rb6+0P5Z53Uif8mg5gGjDxqOMEm6Z31jAL5UxnXzfKNYl1Kv9B/ApGbGKtbm4ex8P7dg8V2XS9YJ+z+cr1XOIg9K
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2019 09:35:17.0981
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a8c9ba3-c9e8-41f7-ddb6-08d75eaece1a
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB2543
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-11-01_03:2019-10-30,2019-11-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=828 priorityscore=1501 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1911010095
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The ADIS library functions return zero on success, and negative values for
error. Positive values aren't returned, but we only care about the success
value (which is zero).

This change is mostly needed so that the compiler won't make any inferences
about some about values being potentially un-initialized. This only
triggers after making some functions inline, because the compiler can
better follow return paths.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/imu/adis16460.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/imu/adis16460.c b/drivers/iio/imu/adis16460.c
index 6aed9e84abbf..b55812521537 100644
--- a/drivers/iio/imu/adis16460.c
+++ b/drivers/iio/imu/adis16460.c
@@ -80,7 +80,7 @@ static int adis16460_show_serial_number(void *arg, u64 *val)
 
 	ret = adis_read_reg_16(&adis16460->adis, ADIS16460_REG_SERIAL_NUM,
 		&serial);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	*val = serial;
@@ -98,7 +98,7 @@ static int adis16460_show_product_id(void *arg, u64 *val)
 
 	ret = adis_read_reg_16(&adis16460->adis, ADIS16460_REG_PROD_ID,
 		&prod_id);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	*val = prod_id;
@@ -116,7 +116,7 @@ static int adis16460_show_flash_count(void *arg, u64 *val)
 
 	ret = adis_read_reg_32(&adis16460->adis, ADIS16460_REG_FLASH_CNT,
 		&flash_count);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	*val = flash_count;
@@ -176,7 +176,7 @@ static int adis16460_get_freq(struct iio_dev *indio_dev, int *val, int *val2)
 	unsigned int freq;
 
 	ret = adis_read_reg_16(&st->adis, ADIS16460_REG_DEC_RATE, &t);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	freq = 2048000 / (t + 1);
-- 
2.20.1

