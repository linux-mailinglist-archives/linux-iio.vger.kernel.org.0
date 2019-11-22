Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7763E10733A
	for <lists+linux-iio@lfdr.de>; Fri, 22 Nov 2019 14:30:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbfKVNaO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 22 Nov 2019 08:30:14 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:27354 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727979AbfKVNaN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 22 Nov 2019 08:30:13 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAMDNNBq006193;
        Fri, 22 Nov 2019 08:30:10 -0500
Received: from nam01-bn3-obe.outbound.protection.outlook.com (mail-bn3nam01lp2051.outbound.protection.outlook.com [104.47.33.51])
        by mx0a-00128a01.pphosted.com with ESMTP id 2wabu7myuw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Nov 2019 08:30:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jDWgMwB+oGSZY7IPytx9PF6tkTHvL/WP6325CeLY6Qf/g8fIg2rBtwwyge3r7xaTRvQBlsZlbV0t4CJJQzVH87cUIOH8L6vMxnD4nQwAmyZxmiz0pfyPmCKQr/VxINUgQyoqfWm2tP6B9h+R71RF8LMZxi/1su7njzEUur5XUOinERwWBJjoDY+YZMWYTWkgWLWawXPYmTH8scz1J1HYhiRhj/M57CbnBsg93LW9jE2v+xHe3z+oJxyY4b7E0WpRlEUPjz+zzm7J7FiV9cqCmuvl/TZjnxiK7bxWvXtlTU6ABavXDn5XiitMRG5AmrzgCPyTzXxIChq/VEWHg2Rrvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8P0+RjkKlMW9BfDD6Q2eeTDJBPzvDvKaWOYU9WijBYY=;
 b=Vs7aU9JiGvRegWJF+Ep2ZFwSS6u+TXRrsD+qnuiUFODTVxVZ9DMmi7/tt7UNp5jK1llbMHJTYnI40/0mVld69A6pvjLxQ6Rdv5wSC4m7IYZKI2/z3EApGjBjzjFKaEwFQtmmPYi9f0xBtKjp3TlaqixTbjRNKKAaBy1xg+Eu7sUOAhZiR0eBMfKgQIiqFOTzXI9uqyhPOAtzgrvBT1yvaSwinc6FsuODjPBH9X4ybXaVYy7Vi6/05UsPJH6XnZNtGiQHd6w98yGzCs7D+rd+StcjcKcuXjWEnHpAdEY2hUvSA/NIWBWT28r54reEdBr1je+rI1diIbaAb7i/R57BYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8P0+RjkKlMW9BfDD6Q2eeTDJBPzvDvKaWOYU9WijBYY=;
 b=jVKky8/xD7g9ec+yDE8tXLsF8M5tC+2CgG+koQ7MFiGf9nJplTrVa62A/CYL5UkdFDmEYlzASSzPTKsSMeXZXt4we271x1TMhy66ge0yPemH+A8qoOgKFC4NdSNLh6QGs7fPr4d9Go9oZ9jKsZg40W/ltx8LyNhm4a5KSqsLZE4=
Received: from BN8PR03CA0004.namprd03.prod.outlook.com (2603:10b6:408:94::17)
 by MN2PR03MB5086.namprd03.prod.outlook.com (2603:10b6:208:1a5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.17; Fri, 22 Nov
 2019 13:30:08 +0000
Received: from SN1NAM02FT050.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::204) by BN8PR03CA0004.outlook.office365.com
 (2603:10b6:408:94::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.18 via Frontend
 Transport; Fri, 22 Nov 2019 13:30:08 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 SN1NAM02FT050.mail.protection.outlook.com (10.152.72.128) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2474.17
 via Frontend Transport; Fri, 22 Nov 2019 13:30:08 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id xAMDTwo2015881
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 22 Nov 2019 05:29:58 -0800
Received: from saturn.ad.analog.com (10.48.65.119) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Fri, 22 Nov 2019 08:30:07 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <nuno.sa@analog.com>,
        <Michael.Hennerich@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 10/11] iio: imu: adis16480: use state lock for filter freq set
Date:   Fri, 22 Nov 2019 15:24:20 +0200
Message-ID: <20191122132421.5500-11-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122132421.5500-1-alexandru.ardelean@analog.com>
References: <20191122132421.5500-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(396003)(136003)(346002)(39860400002)(189003)(199004)(76176011)(50226002)(70206006)(14444005)(336012)(6666004)(356004)(8676002)(8936002)(426003)(54906003)(110136005)(305945005)(7636002)(246002)(86362001)(7696005)(48376002)(51416003)(316002)(47776003)(186003)(36756003)(106002)(478600001)(50466002)(2616005)(1076003)(2870700001)(2906002)(5660300002)(107886003)(4326008)(11346002)(446003)(44832011)(70586007)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR03MB5086;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d028f9a-c58e-4dc6-3c85-08d76f5017ac
X-MS-TrafficTypeDiagnostic: MN2PR03MB5086:
X-Microsoft-Antispam-PRVS: <MN2PR03MB5086C565EA6CD63D60206343F9490@MN2PR03MB5086.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1284;
X-Forefront-PRVS: 02296943FF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bQkk30QY8OXtMhKMZ7SunzeOiR+A/68mpXBI3Is6T+9D+e8qe3YOE9f6IbK5n0SCw0BUfZbMxNAPW2z2svMMI1q8SRcjzZda9saAWIxNEBps1zU8rljOiHD+LXVc9Op8jshFFYQuE40Sk7nlwhtcJgxFGKClUgbtFxJhiih+wIpDwP0B55BVuHNS5KvoO42S4kMq1OKt/E1UzUYNxOhatXyqqw3z+hQj2I70wZbHEd0RjTNjcPdCd5X7fM26NuAS674qw0K3ZQkpfLodqbhTfgdwsVFHhVL3jWmTUO5Z8ghMmbjxBbhnBS8Df7bQsAIoiGfdzoDuRfybYmMNowZYo2rRbscHet5EknYo5U92APokYrSuHiTCO3eYMRN/0fFStRHjQxIlDCAjuldUEpSvZI4kQAKk+djE98Nm3UWdiO1VOkhz+oGuU3HK0CjqOmcp
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2019 13:30:08.0364
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d028f9a-c58e-4dc6-3c85-08d76f5017ac
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5086
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-22_02:2019-11-21,2019-11-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 spamscore=0 adultscore=0 clxscore=1015 mlxlogscore=999
 bulkscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911220119
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

It's the only operation that does 2 operations (a read & a write), so the
unlocked functions can be used under a single state lock.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/imu/adis16480.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
index e943039c3f98..f73094e8d35d 100644
--- a/drivers/iio/imu/adis16480.c
+++ b/drivers/iio/imu/adis16480.c
@@ -555,6 +555,7 @@ static int adis16480_set_filter_freq(struct iio_dev *indio_dev,
 	const struct iio_chan_spec *chan, unsigned int freq)
 {
 	struct adis16480 *st = iio_priv(indio_dev);
+	struct mutex *slock = &st->adis.state_lock;
 	unsigned int enable_mask, offset, reg;
 	unsigned int diff, best_diff;
 	unsigned int i, best_freq;
@@ -565,9 +566,11 @@ static int adis16480_set_filter_freq(struct iio_dev *indio_dev,
 	offset = ad16480_filter_data[chan->scan_index][1];
 	enable_mask = BIT(offset + 2);
 
-	ret = adis_read_reg_16(&st->adis, reg, &val);
+	mutex_lock(slock);
+
+	ret = __adis_read_reg_16(&st->adis, reg, &val);
 	if (ret)
-		return ret;
+		goto out_unlock;
 
 	if (freq == 0) {
 		val &= ~enable_mask;
@@ -589,7 +592,11 @@ static int adis16480_set_filter_freq(struct iio_dev *indio_dev,
 		val |= enable_mask;
 	}
 
-	return adis_write_reg_16(&st->adis, reg, val);
+	ret = __adis_write_reg_16(&st->adis, reg, val);
+out_unlock:
+	mutex_unlock(slock);
+
+	return ret;
 }
 
 static int adis16480_read_raw(struct iio_dev *indio_dev,
-- 
2.20.1

