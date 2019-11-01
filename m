Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 730B7EC09D
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2019 10:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729085AbfKAJfn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 1 Nov 2019 05:35:43 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:64478 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729017AbfKAJfk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 1 Nov 2019 05:35:40 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA19XUH6003902;
        Fri, 1 Nov 2019 05:35:28 -0400
Received: from nam01-bn3-obe.outbound.protection.outlook.com (mail-bn3nam01lp2054.outbound.protection.outlook.com [104.47.33.54])
        by mx0a-00128a01.pphosted.com with ESMTP id 2vxwhjrw1a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Nov 2019 05:35:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RUZzslhYVj6yXtz9+F/7VKSgw1ZUDitufuPpGs/vIzFug8TLKlNz/25Wv9Y3XHng3cM6jDg8VoA+sIhthmHE0/TzgBqdT/9l43kHpA1AzX9FCePxDCvNCcBk1VRRADoMbP1OZC5ZOPzqnD/95Eb4lC0vSYNsUbVuLsSlDsMqqHI+59rh5PSU2LK1k1wsq5UhxOkoDO62ZRGsJ7hdG+NENr751+ldLP04BULqbr3GdW/Hti+wxIoY6mzkb/KgQosIyTrwBcnaeC/8pETwqpHP9FscCAWdezzXLrFRTVQaQQMKPgczHgCvw/8+jqbViCyQ/zhkxbvKx3rpD1zlGjDcIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iutoMGZBZJr043uZlhisldR32lkJFHY26oYznxwowBA=;
 b=VG8oqZoXF/ayBSqh6y9kDdN2KQmzXUtjGuNiY65Zf/6PW8cXFOYCwtHOvYyIEs1cxAStSsFsib971gi4A9pvOniwdF0Rd3MjIsU5PgQqptXggIbyDA7ifBV2NNs5sgcKxB7hfSL7m9o7zeWW4iy9HFXhYUpX2fxBxt2eUqeGL5Q8i7xqh1EaDAbQAKEUUNJnBrANaZSkmPdRwgrU1kg81aFm+4BHbfs6BUfQRbyjG5uSN7SYtaf8J77yfkdVFHPOQBdsP9tu8C7zC5A2XkIKqhUFjcFZg+yP4QY2LyapXx7gY9HmFwNXooA3HJfzVyU3EnB2BmKgR9LJPDN/PfveZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=metafoo.de smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iutoMGZBZJr043uZlhisldR32lkJFHY26oYznxwowBA=;
 b=P2MUnBRBiUa0Y/4WyacpOQJH+dKbxKwMdPCPmsnqHHwPvyyFIWymah1POGHir8GyILxjguhKrsVmE5/lykpVMigu+w6jiKIPtLZEsJJw+m76FuLB1Z8xCDW7Chlm0NlHlosWGpHref4NcxuNKeXBDbcvDbjGtEvJiV6Q29kd+RM=
Received: from CY4PR03CA0092.namprd03.prod.outlook.com (2603:10b6:910:4d::33)
 by MWHPR03MB3101.namprd03.prod.outlook.com (2603:10b6:301:3c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2387.24; Fri, 1 Nov
 2019 09:35:26 +0000
Received: from BL2NAM02FT044.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::206) by CY4PR03CA0092.outlook.office365.com
 (2603:10b6:910:4d::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2408.21 via Frontend
 Transport; Fri, 1 Nov 2019 09:35:25 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BL2NAM02FT044.mail.protection.outlook.com (10.152.77.35) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2387.20
 via Frontend Transport; Fri, 1 Nov 2019 09:35:24 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id xA19ZHIM025084
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 1 Nov 2019 02:35:17 -0700
Received: from saturn.ad.analog.com (10.48.65.117) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Fri, 1 Nov 2019 05:35:23 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <dragos.bogdan@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 07/10] iio: imu: adis16480: prefer `unsigned int` over `unsigned`
Date:   Fri, 1 Nov 2019 11:35:02 +0200
Message-ID: <20191101093505.9408-8-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191101093505.9408-1-alexandru.ardelean@analog.com>
References: <20191101093505.9408-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(136003)(346002)(376002)(396003)(189003)(199004)(86362001)(4326008)(54906003)(4744005)(47776003)(5660300002)(316002)(356004)(6666004)(14444005)(8936002)(26005)(50226002)(2906002)(478600001)(246002)(50466002)(70586007)(336012)(76176011)(51416003)(44832011)(305945005)(7636002)(70206006)(48376002)(106002)(107886003)(1076003)(36756003)(476003)(2870700001)(486006)(446003)(126002)(2616005)(110136005)(11346002)(426003)(7696005)(186003)(8676002)(81973001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR03MB3101;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5fc5e79e-322c-46d6-bcd8-08d75eaed2b6
X-MS-TrafficTypeDiagnostic: MWHPR03MB3101:
X-Microsoft-Antispam-PRVS: <MWHPR03MB310199397D222B52DB8A689BF9620@MWHPR03MB3101.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-Forefront-PRVS: 020877E0CB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i/JV8M5uGIfCaK9pTPk8c0+eFK9TMwNYqS33Re1aShqZB2lP9H6A7/cFH5ycxTiZCqyKaDT7vf8JEdULaCuSO27Klx68+98ysmYgsv+HWw017BOW9VNwH+BlejnKb2kobOqnOmcZBSaBorF6SltkxOoNx4rjCXap37cnOAOQTO3cPU2dKhfrxdHUO8AIr3ktUqtH3/ia4O0B9yZLxl8uaQCp//5jTYnCycxcam8rbWbYNf3rn17qqveBgE+jRm9YUMvuvggKXqZw41M/O8JPskGA1GnTB39WZM8tYc0NkH8FmIsDRDCMNU37cMUm9rB/L3Olke0rYk9v+Y3ig3QYt/WXOCy5zXHDZIh5i3ooVviViFdA0/DTIugKyHnP4Fej1XjISfgwLaLFkTAu50rQeW8S8W7MFdEwT/bab4SsqigEf6HDzDvB8n8WcnKRYKkB
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2019 09:35:24.8305
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fc5e79e-322c-46d6-bcd8-08d75eaed2b6
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB3101
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-11-01_03:2019-10-30,2019-11-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=923 priorityscore=1501 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1911010095
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This is a typical checkpatch warning. The change just renames the type of
the `freq` var to `unsigned int`.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/imu/adis16480.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
index d199d3d3c4bd..b9e2695bcfad 100644
--- a/drivers/iio/imu/adis16480.c
+++ b/drivers/iio/imu/adis16480.c
@@ -350,7 +350,7 @@ static int adis16480_get_freq(struct iio_dev *indio_dev, int *val, int *val2)
 	struct adis16480 *st = iio_priv(indio_dev);
 	uint16_t t;
 	int ret;
-	unsigned freq;
+	unsigned int freq;
 	unsigned int reg;
 
 	if (st->clk_mode == ADIS16480_CLK_PPS)
-- 
2.20.1

