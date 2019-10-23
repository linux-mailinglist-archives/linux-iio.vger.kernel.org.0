Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C458BE1424
	for <lists+linux-iio@lfdr.de>; Wed, 23 Oct 2019 10:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732361AbfJWI0x (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 23 Oct 2019 04:26:53 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:40062 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727574AbfJWI0x (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 23 Oct 2019 04:26:53 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9N8MxPv029131;
        Wed, 23 Oct 2019 04:26:50 -0400
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2051.outbound.protection.outlook.com [104.47.37.51])
        by mx0b-00128a01.pphosted.com with ESMTP id 2vt9t21hrs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Oct 2019 04:26:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L7q7jrilikLxUQvgkifhVvtvrlwvSQ5kyGU1+s+CNRpN0kR2wzs4bcK7OtT0JUdVCSgtcENqoqqDhrJ13aXDPmOv/OG24B0Z6sXRNmimfv+KkXCGdHs0SKk9kvsRXf0i3qYkY7vlRpAumXTS5ajx3GyN3ZxTSKUk9e25Q1evUkaY4KBhgxPU7Zijjh82sgz0BgRuzMwP3ylv2WCTC33rxphG9REAG0g4BcmEqP6M4jqQbeNgIkvqcwyT4K2++uiYepMxi/o3z4aZroEqL8OIzaZnPcNfIzcVPEpbBERF3K9UNtD/CtuaxrkSFLhZPxjAcf/KkpT8A0t422PbnTEO/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zic5/NIo81qQGHwCDs5FOCVbB/OBxV+6dWSx5pDhZRY=;
 b=NA5OqC3c0GZ7/1D8VOvD8QK4xV4vg9BgOa43TyrQP+YKWVCw1eWBV+AUPHL0dneCfLzycelT6cFJyzHSgBmGDJeL+nT/EvjD6FD+32fWyhF/gDhmhzBaUTCjz7SxChxmAwEY1pAGISmrNEvHhMCp8xcGdLoetY8m6droCocbcXtrJC97ZA8xbel5fYFL8Wxpj8we5QsgYeHEO5UB2hV+hofrfiddxTyR5v1gr+GdZEtPU4C8wisE2vgvprzfG3iT8Vk2xVCerf7iZeNJHEosjRVTCBOVnnDPLl2gQkIvqvVYyUcWzTwVJfi/wrB4lFR2n+o3aByq9MdJMsJAZbBQkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zic5/NIo81qQGHwCDs5FOCVbB/OBxV+6dWSx5pDhZRY=;
 b=9RGXWQ4T4VCbwPU1mYr9T+Yke/o5S/qaT54vDZ86ZkN+hXK7DGO98eLS2xhMGWxcE3FoP6CbnADPQE4iePjgNpbHaJoAieJcfQcX7bb2JUe5JAfz4XJ1WSChdp3q9fpPWLvj0V5QiuEhugCOrElob5kVwJ7AyBhUMV5E1QnuWt0=
Received: from MWHPR03CA0007.namprd03.prod.outlook.com (2603:10b6:300:117::17)
 by DM5PR03MB3274.namprd03.prod.outlook.com (2603:10b6:4:40::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2367.20; Wed, 23 Oct
 2019 08:26:48 +0000
Received: from BL2NAM02FT032.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::209) by MWHPR03CA0007.outlook.office365.com
 (2603:10b6:300:117::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2387.20 via Frontend
 Transport; Wed, 23 Oct 2019 08:26:48 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BL2NAM02FT032.mail.protection.outlook.com (10.152.77.169) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2367.14
 via Frontend Transport; Wed, 23 Oct 2019 08:26:48 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x9N8QfEk012565
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 23 Oct 2019 01:26:41 -0700
Received: from saturn.ad.analog.com (10.48.65.116) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Wed, 23 Oct 2019 04:26:47 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] iio: hdc100x: fix iio_triggered_buffer_{predisable,postenable} positions
Date:   Wed, 23 Oct 2019 11:27:14 +0300
Message-ID: <20191023082714.18681-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(376002)(39860400002)(346002)(396003)(189003)(199004)(107886003)(126002)(8676002)(336012)(36756003)(186003)(26005)(70586007)(70206006)(4326008)(106002)(50466002)(50226002)(316002)(305945005)(246002)(5660300002)(426003)(7636002)(110136005)(476003)(54906003)(86362001)(8936002)(48376002)(51416003)(7696005)(2616005)(47776003)(6666004)(356004)(2870700001)(486006)(2906002)(44832011)(14444005)(478600001)(5024004)(1076003)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR03MB3274;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5b18cbb-e8c5-4dbf-55e1-08d75792bf70
X-MS-TrafficTypeDiagnostic: DM5PR03MB3274:
X-Microsoft-Antispam-PRVS: <DM5PR03MB3274D46F3A4E97A38A27AB1FF96B0@DM5PR03MB3274.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 019919A9E4
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BIZfUiSvyrFWnfsLloqDohdhJ8iM9qObHgPGRvHfC4QpAjmCoyCO/Xs2samxcGEi801IGQh3Tx1lmgpg7OiL2dHI5kyLQe1wjoVBXVcGsXvI4PaoKgRpM6R/0MTVXr1qmHvgcK92wHL56fYmKGe3Tc378P7xVyuehmY3Qrk2QE/hUGLPA+68G8Byl/tVmUQ9wqwCMN4+MumiAODTdLrvt8yTnsUCfOZMhORAzSzaVjeyW5gfX7y5fQ1GWc+t5FOtcmT7V09tazivLk050txKKr0gMIhrx61PzRDaeftDTNhsBhjqLpwUuCmZuOeMpd5mEa2a2/2T82/qoqK1GnmTdxkKTVBZfIg5W8+K24yaBkRJRqMRouWGJE53wDpU4F5fLYJeaxyPXp1qWB4NpESMIl86S+2SA/mgOLvEOWYETtltQVn01SiJgJw2yH8WW++U
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2019 08:26:48.4236
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5b18cbb-e8c5-4dbf-55e1-08d75792bf70
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB3274
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-23_02:2019-10-22,2019-10-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 clxscore=1015 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910230083
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The iio_triggered_buffer_postenable() hook should be called first to
attach the poll function and the iio_triggered_buffer_predisable() hook
should be called last in the predisable hook.

This change updates the driver to attach/detach the poll func in the
correct order.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/humidity/hdc100x.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/humidity/hdc100x.c b/drivers/iio/humidity/hdc100x.c
index bfe1cdb16846..963ff043eecf 100644
--- a/drivers/iio/humidity/hdc100x.c
+++ b/drivers/iio/humidity/hdc100x.c
@@ -278,31 +278,34 @@ static int hdc100x_buffer_postenable(struct iio_dev *indio_dev)
 	struct hdc100x_data *data = iio_priv(indio_dev);
 	int ret;
 
+	ret = iio_triggered_buffer_postenable(indio_dev);
+	if (ret)
+		return ret;
+
 	/* Buffer is enabled. First set ACQ Mode, then attach poll func */
 	mutex_lock(&data->lock);
 	ret = hdc100x_update_config(data, HDC100X_REG_CONFIG_ACQ_MODE,
 				    HDC100X_REG_CONFIG_ACQ_MODE);
 	mutex_unlock(&data->lock);
 	if (ret)
-		return ret;
+		iio_triggered_buffer_predisable(indio_dev);
 
-	return iio_triggered_buffer_postenable(indio_dev);
+	return ret;
 }
 
 static int hdc100x_buffer_predisable(struct iio_dev *indio_dev)
 {
 	struct hdc100x_data *data = iio_priv(indio_dev);
-	int ret;
-
-	/* First detach poll func, then reset ACQ mode. OK to disable buffer */
-	ret = iio_triggered_buffer_predisable(indio_dev);
-	if (ret)
-		return ret;
+	int ret, ret2;
 
 	mutex_lock(&data->lock);
 	ret = hdc100x_update_config(data, HDC100X_REG_CONFIG_ACQ_MODE, 0);
 	mutex_unlock(&data->lock);
 
+	ret2 = iio_triggered_buffer_predisable(indio_dev);
+	if (ret == 0)
+		ret = ret2;
+
 	return ret;
 }
 
-- 
2.20.1

