Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6136B10733C
	for <lists+linux-iio@lfdr.de>; Fri, 22 Nov 2019 14:30:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbfKVNad (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 22 Nov 2019 08:30:33 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:62814 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727545AbfKVNaJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 22 Nov 2019 08:30:09 -0500
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAMDN8Ou011422;
        Fri, 22 Nov 2019 08:30:05 -0500
Received: from nam01-bn3-obe.outbound.protection.outlook.com (mail-bn3nam01lp2057.outbound.protection.outlook.com [104.47.33.57])
        by mx0b-00128a01.pphosted.com with ESMTP id 2wbg0jtqya-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Nov 2019 08:30:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LGQpsaByIeLXPddc4endnvKi/EDsnWfIECAv8dKHprG/2RqQFIlLwYNZlVwqPeY4dz0AS3cQznwTbalMrMKAUZIa6DcksRfJDAZ1y77D9p81jfL92n4cfTzztqn/1SaQ7KCWOk/52TMh3WmSagiPnsbNUUGrCELctXsO3iZZt7OVOn42OnzUrfAA2Mu9+PSK3O38/MzGAzNGHZQkVW5NJxT36mVKovCTZ9wUTgBDLIO0S+M3o8hI6Ddo3Jv+Nf0nd3FkdL2vv5p/XkNwqUJmW1KjTdOjjH6if6iZyWHBRC3/jZIZA0bs44URdeqMa091IxXg6h/YAExBfruzkREnvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OQjqjPR4d0w8LHNi0M5yY78MFQNo5hgrkH1PvSNU1cs=;
 b=D7nQXwhhP7X6Vy9uyzDcsxvJbf3uptZhLSg0tNpwDu9fnOxJDyRwyUpxq0UCXH9zVvzo4TJri+o8mbVChRskmvI2J0Ofh3WavWEJRhV8FPVJjOHDa70V+eGGBumcLDQkGtIIaoWnz62sZLEiZadrwzwSqnQ5SzZaDi/zfyA7D6NqaPyW3KedTTKMxhq8tKdixrbuQmplOIMwzNMNrF7pgenuX03Qhz562YQZajJ2rcmtdynloxCiVszd3kmPZoxvHBf/9akWS7UQ/8IdxX+H9FZnaUQ6piajoCHOfVpD0dKRq6cZy1e6b7EiuVnDkR1EjygVcVPFZWrFv7z7fLmhDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OQjqjPR4d0w8LHNi0M5yY78MFQNo5hgrkH1PvSNU1cs=;
 b=VxutJUUoIohvcVKhI4oG9G8bOfbKZ0p4IAuv29uqv7qewfp2SWF5ckWN9sb5iyPW6itzD1GCnRPOnb1jtRiartMXdMNqWRyFNEjjI1SRF/MK/xOZQYHPUmG910G4Z8qQjoLHlMr4P5geWekVgxoy7ymT9AveL1pu8IbFj3gJqyw=
Received: from DM6PR03CA0033.namprd03.prod.outlook.com (2603:10b6:5:40::46) by
 DM5PR03MB3307.namprd03.prod.outlook.com (2603:10b6:4:43::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.30; Fri, 22 Nov 2019 13:30:03 +0000
Received: from BL2NAM02FT060.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::206) by DM6PR03CA0033.outlook.office365.com
 (2603:10b6:5:40::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.17 via Frontend
 Transport; Fri, 22 Nov 2019 13:29:57 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BL2NAM02FT060.mail.protection.outlook.com (10.152.76.124) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2474.17
 via Frontend Transport; Fri, 22 Nov 2019 13:29:57 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id xAMDTmIo015781
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 22 Nov 2019 05:29:48 -0800
Received: from saturn.ad.analog.com (10.48.65.119) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Fri, 22 Nov 2019 08:29:56 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <nuno.sa@analog.com>,
        <Michael.Hennerich@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 04/11] iio: imu: adis: create an unlocked version of adis_check_status()
Date:   Fri, 22 Nov 2019 15:24:14 +0200
Message-ID: <20191122132421.5500-5-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122132421.5500-1-alexandru.ardelean@analog.com>
References: <20191122132421.5500-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(136003)(39860400002)(199004)(189003)(51416003)(86362001)(54906003)(110136005)(47776003)(8936002)(1076003)(5660300002)(14444005)(356004)(6666004)(50226002)(70206006)(76176011)(107886003)(316002)(186003)(2870700001)(426003)(48376002)(8676002)(446003)(7636002)(11346002)(4326008)(336012)(26005)(106002)(50466002)(478600001)(36756003)(305945005)(246002)(70586007)(2616005)(7696005)(2906002)(44832011);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR03MB3307;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c5837a0-81dd-4c92-0c0d-08d76f501175
X-MS-TrafficTypeDiagnostic: DM5PR03MB3307:
X-Microsoft-Antispam-PRVS: <DM5PR03MB33075EF266DF556239695C74F9490@DM5PR03MB3307.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 02296943FF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tSJSUKnDIjzpWEA8abKpj1Zsn/9gcqpoIFupeUYpXYzzvOieI2VZUdIa1om09G11g51ODG9gLivGm5b/0ayXKD1guAUDTGmMef1cmXi3WUzHmJ6+qUXOfkobZ7hJWIrOaGj29B4eEUnLlXbuH6AmfLn5X5bpcNcTp0iw/BDK2/80CxY7Hmr8NTy1Yd3ERc4Dia/avNVL6SItKER2Bh1Zt4H/295/2+TcD8CFm82WSjfSKSvL+m+St0d7+62cXiffJ9btgKk5X7CXDXocNGoItjk2BhUNSbA/sUvx5cxKDfwZpevMapS16iUME/kCNAjwW/atzIZguD9tN+mPiviUWjwotOWjuHz0ZAG7sSkL0TQnQG5ritisb2V2HXuxZgYLpYi33zDe53fOgNEPW5Cu/MTNmG2WRr5x3695xtuOXbBLB33IkNBV/DPto5u86win
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2019 13:29:57.6754
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c5837a0-81dd-4c92-0c0d-08d76f501175
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB3307
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-22_02:2019-11-21,2019-11-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 mlxscore=0 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1911220119
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This one also gets re-used in certain operations, so it makes sense to
have an unlocked version of this to group it with other
reads/writes/operations to have a single lock for the whole state change.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/imu/adis.c       |  8 ++++----
 include/linux/iio/imu/adis.h | 13 ++++++++++++-
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
index 5cf7a15be6ee..b63d6e6f5415 100644
--- a/drivers/iio/imu/adis.c
+++ b/drivers/iio/imu/adis.c
@@ -277,18 +277,18 @@ int adis_enable_irq(struct adis *adis, bool enable)
 EXPORT_SYMBOL(adis_enable_irq);
 
 /**
- * adis_check_status() - Check the device for error conditions
+ * __adis_check_status() - Check the device for error conditions (unlocked)
  * @adis: The adis device
  *
  * Returns 0 on success, a negative error code otherwise
  */
-int adis_check_status(struct adis *adis)
+int __adis_check_status(struct adis *adis)
 {
 	uint16_t status;
 	int ret;
 	int i;
 
-	ret = adis_read_reg_16(adis, adis->data->diag_stat_reg, &status);
+	ret = __adis_read_reg_16(adis, adis->data->diag_stat_reg, &status);
 	if (ret)
 		return ret;
 
@@ -306,7 +306,7 @@ int adis_check_status(struct adis *adis)
 
 	return -EIO;
 }
-EXPORT_SYMBOL_GPL(adis_check_status);
+EXPORT_SYMBOL_GPL(__adis_check_status);
 
 /**
  * adis_reset() - Reset the device
diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
index 38ebe41092e1..db759957e1c1 100644
--- a/include/linux/iio/imu/adis.h
+++ b/include/linux/iio/imu/adis.h
@@ -267,7 +267,18 @@ static inline int adis_read_reg_32(struct adis *adis, unsigned int reg,
 }
 
 int adis_enable_irq(struct adis *adis, bool enable);
-int adis_check_status(struct adis *adis);
+int __adis_check_status(struct adis *adis);
+
+static inline int adis_check_status(struct adis *adis)
+{
+	int ret;
+
+	mutex_lock(&adis->state_lock);
+	ret = __adis_check_status(adis);
+	mutex_unlock(&adis->state_lock);
+
+	return ret;
+}
 
 int adis_initial_startup(struct adis *adis);
 
-- 
2.20.1

