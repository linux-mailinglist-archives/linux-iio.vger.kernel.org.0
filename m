Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03C3C11AE89
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2019 15:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbfLKO6B (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 11 Dec 2019 09:58:01 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:24318 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727457AbfLKO6B (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 11 Dec 2019 09:58:01 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBBEviDO008476;
        Wed, 11 Dec 2019 09:57:46 -0500
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2058.outbound.protection.outlook.com [104.47.36.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 2wrb1scn1f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Dec 2019 09:57:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V5YTlmdO7YA/73EpXKgthhfbEc+PwX4UefnwNF0yAaVS7y+y2jP0HCIJVQaqlvBgLOaNEFasGKTqSrFuDxfqkOf6Zpw97T90RcTzGrPaC5ulkogONPw7+/85mBr6DmwtH/sMUJ1QbSWK6UBEXx8AIoqz7JQ/rZqJW6J/awgrwfOq5dfeAiksA6ld/fNoNwM3sBNrW7fMP4Xi+l8mr7Z6MXJBf29lT2C9DLDn1MRKHnLsml2wTDtG6wf9JnPu7kJU1gsAtq3BgaWMmoO8ERcQJBo/k3fweLweAYHjK8W9z/3XRZeqB3GYMbN24DYuPTGSd6aglIoN+uN+KPqbZXqq5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p4qWQrKzfPKEKASiO+kwAxVOYqAJGTaJ43nPOC/jL8k=;
 b=liiC13Jffio7EbZeMqndqONV3TG53rmVGJR3QE9v5nx5+skLgb11WNT4roTDnZrF8yGrEbTTCKGPeLaH+CrE3YJ0gDye7y6uYCinek5iusWwosdWMsGBhFMLrNXPhnLz6dKC0pEQRqJBswyaIIjt7ezl0oYAzGR0rjjfaaL1/jaqDnGQ4f8wX3gCijcs6r//I6KKcDhw0JamJji+Wm3LB41OJxhcgq3GsrBuunMmeuoNidWwIj5x+zQ7MvEEP17Osl6UDTCx/dCl1F0m90oPNrHDkvpvquJzf8Vu7Rs9Oc7xAm0f5VPX4a8r2mmOcSQcx3iB3tI0mzIqGlJ09siMng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p4qWQrKzfPKEKASiO+kwAxVOYqAJGTaJ43nPOC/jL8k=;
 b=Wdqol48EihDcG/LSkzlVeS7EVrIjuKpB6TRY844iqIjLxb1NvPnatTZvS1eRtmvTs5lc98BvXuZY2JaW8MdYniPg8HaP4gwiUkRB0lpsk+0DrmiHboj+6ipm7EH3iwejN07+fIdqwMWrOXuCU1liGIH3+sS7ySPauyQehrGOLuw=
Received: from BY5PR03CA0029.namprd03.prod.outlook.com (2603:10b6:a03:1e0::39)
 by BN6PR03MB3363.namprd03.prod.outlook.com (2603:10b6:405:42::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.15; Wed, 11 Dec
 2019 14:57:44 +0000
Received: from CY1NAM02FT008.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::206) by BY5PR03CA0029.outlook.office365.com
 (2603:10b6:a03:1e0::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.15 via Frontend
 Transport; Wed, 11 Dec 2019 14:57:44 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 CY1NAM02FT008.mail.protection.outlook.com (10.152.75.59) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2538.14
 via Frontend Transport; Wed, 11 Dec 2019 14:57:43 +0000
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id xBBEvguA012871
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Wed, 11 Dec 2019 06:57:42 -0800
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Wed, 11 Dec
 2019 09:57:42 -0500
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Wed, 11 Dec 2019 09:57:42 -0500
Received: from saturn.ad.analog.com ([10.48.65.121])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id xBBEvdpK011262;
        Wed, 11 Dec 2019 09:57:40 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] iio: core: use debugfs_remove_recursive() on IIO unload
Date:   Wed, 11 Dec 2019 16:59:03 +0200
Message-ID: <20191211145903.22395-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(39860400002)(346002)(199004)(189003)(4326008)(8676002)(2906002)(44832011)(8936002)(7636002)(36756003)(246002)(107886003)(26005)(186003)(70206006)(5660300002)(1076003)(70586007)(4744005)(356004)(316002)(478600001)(6666004)(86362001)(54906003)(110136005)(7696005)(2616005)(336012)(426003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB3363;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa0b3284-faa6-4769-5dd1-08d77e4a79f8
X-MS-TrafficTypeDiagnostic: BN6PR03MB3363:
X-Microsoft-Antispam-PRVS: <BN6PR03MB33637EF3FCEF35AE2A07E1C8F95A0@BN6PR03MB3363.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 024847EE92
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ps0/bBfXg0bxJ1/slOdxCYmt0d0lTNVkYwn1m2ktEpWhuCOvrJY2WkyVFICSxoSd1nQOahXTST6np4zJiciZz54ayblxulc/++C/YLZMzv0wzpM+gWKO5quJleX75/p1nUUiCBWWwEw9ke6YcZwt+VYgwWX4Vfgd4W261QX7WLxretudVE1fSfUCjdV+wUcTU94Hve/rYJI2n83tqEtPjMOL9/3SGq4BbQxX+BbMp5b6N25iQL1OlK9MpZfRAoIpJBZl+0Bf0KL791bShcVNkIHQQcdEMi+3/bFV2g/7rVNdl/yfBSYHiW/IHDLE9yVxXbXFCP1O3j6y+TDVfIzNrTt7PAxgOwmWchfZYESP1a7tf4V+P/oI3o/t3M490v0p5QHQLUx6JsRKuBYtLrIjXZN4SZEyDNaSzjDY8RzeUPjJl5iv6/1FO60ZlLdHnf8x
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2019 14:57:43.3863
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa0b3284-faa6-4769-5dd1-08d77e4a79f8
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB3363
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-11_04:2019-12-11,2019-12-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501
 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912110127
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Lars-Peter Clausen <lars@metafoo.de>

The debugfs dir may have multiple files/dirs attached to it. Use
debugfs_remove_recursive() to clean it up when the IIO module unloads.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---

Note: note sure if this needs a Fixes tag. It's been in here for ages now,
      so it may not be a big issue.

 drivers/iio/industrialio-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 9a3579943574..dab67cb69fe6 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -292,7 +292,7 @@ static void __exit iio_exit(void)
 	if (iio_devt)
 		unregister_chrdev_region(iio_devt, IIO_DEV_MAX);
 	bus_unregister(&iio_bus_type);
-	debugfs_remove(iio_debugfs_dentry);
+	debugfs_remove_recursive(iio_debugfs_dentry);
 }
 
 #if defined(CONFIG_DEBUG_FS)
-- 
2.20.1

