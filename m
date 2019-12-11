Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5C211B5D9
	for <lists+linux-iio@lfdr.de>; Wed, 11 Dec 2019 16:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731100AbfLKP4a (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 11 Dec 2019 10:56:30 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:5730 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731770AbfLKPPZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 11 Dec 2019 10:15:25 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBBF8rHi012039;
        Wed, 11 Dec 2019 10:15:22 -0500
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2051.outbound.protection.outlook.com [104.47.44.51])
        by mx0a-00128a01.pphosted.com with ESMTP id 2wraq3mry1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Dec 2019 10:15:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jzdSgRMdxrPOWG3wdBtEiJPmUrFN2OpPTVNO7RUsFP+Cx24nW0+1uA1ht1iEF7iCtuAeETjsQLvW6/5zg2gmJoefT2rDU6obfKwBWWQWDpCob+B87EVVaw6ENOzsq8IwB9Ml3XWQ1tXbbj9YvbfY+ttAJ7hSwnbIrRdcHdTk10qcPxVz7WCAtO4WqQ6ZmOc5FCBIpdCPKjjqrEpMD35MgpFm9TY0Eo5X2I4yQuKXLUsSkEQfjflC0mt5gMC/CTzazcK6zZDHC+9lNvydiBdTF2rSS3tB0XaxNbjh8GoeVuqQ3SXWR84mdAX0qdjbGrctybhJjSgizt4Pitoc2GN/WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2PrsMZEXI4PpiwET8BdVm7Qg5vr+H1mJJ+nrlZKxl7c=;
 b=KPzWurw7nR3efMCPGFWiCg0J+gr7JKkNTQ7SLMSwkg8LuhXbAWeUlYgOttrcGkXGvXgmoLt8v8TLrtzvPwyGlbvJANXkSdkY8sbqou6KTGI0KmI9ujRkhrVLXBg7NggmI8huT3I7n4NvyfZZoQF+2Ga7DShgjMuNbKuUIL1GnsZFA94ggNfouNGA1vRdy9SkhgPu6mVFN0BLu/492p6JnrtPYz0cyVssTYKH6Qvf3nxvLKSiyAKbz1eyIjDJ7fPhEPkYZfXsA1Qez4Nfzq2CG42xCP36za1NdZsCpZTJAUvSW87qIsuf2TMgWtjLZJwmRib0MjUcpGt4IZOeqxYZ0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2PrsMZEXI4PpiwET8BdVm7Qg5vr+H1mJJ+nrlZKxl7c=;
 b=UiyYdZ94jjjEdFcPavuGveZZcpNS4zSGU6QGl+dGULrH5tqwWvSKqn5aLk1CctzuDGyfJR9U+QSshKlFkw/ZMxk9IzaaDdmu5ezN5Lca4CKjOSovLrjJpjk5yt7JkJx1omfGbVPSfIt0S4XXVpXNh2AIH0R0mJwLpI4o5NkMEN4=
Received: from BN3PR03CA0064.namprd03.prod.outlook.com
 (2a01:111:e400:7a4d::24) by DM6PR03MB3883.namprd03.prod.outlook.com
 (2603:10b6:5:4f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.18; Wed, 11 Dec
 2019 15:15:21 +0000
Received: from BL2NAM02FT033.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::205) by BN3PR03CA0064.outlook.office365.com
 (2a01:111:e400:7a4d::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2516.14 via Frontend
 Transport; Wed, 11 Dec 2019 15:15:21 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BL2NAM02FT033.mail.protection.outlook.com (10.152.77.163) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2538.14
 via Frontend Transport; Wed, 11 Dec 2019 15:15:20 +0000
Received: from SCSQMBX10.ad.analog.com (scsqmbx10.ad.analog.com [10.77.17.5])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id xBBFFK17021129
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Wed, 11 Dec 2019 07:15:20 -0800
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQMBX10.ad.analog.com (10.77.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 11 Dec 2019 07:15:20 -0800
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Wed, 11 Dec 2019 07:15:20 -0800
Received: from saturn.ad.analog.com ([10.48.65.121])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id xBBFFIJo012456;
        Wed, 11 Dec 2019 10:15:18 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] iio: core: print error message on debugfs register failure
Date:   Wed, 11 Dec 2019 17:16:36 +0200
Message-ID: <20191211151636.13547-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(396003)(39860400002)(346002)(376002)(189003)(199004)(110136005)(70206006)(26005)(8676002)(36756003)(70586007)(54906003)(7696005)(86362001)(7636002)(316002)(44832011)(186003)(246002)(8936002)(478600001)(5660300002)(336012)(356004)(6666004)(2616005)(4326008)(107886003)(1076003)(426003)(2906002)(15650500001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB3883;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f43d9cbf-8450-4352-8525-08d77e4ceff9
X-MS-TrafficTypeDiagnostic: DM6PR03MB3883:
X-Microsoft-Antispam-PRVS: <DM6PR03MB388346BAB2ACF2A7FDE8F522F95A0@DM6PR03MB3883.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-Forefront-PRVS: 024847EE92
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5N0SRVA+KGdfyilcS1zkT/sKrJKseHMj1lDldqun6M4YO3ZgPGN7oCO5lM6ypMYOtisTTVrwb7LnD2lZF04WRRrNWa9ibqIA3kMeH628XcQCbVMFRW5d2S++4y+OygcqQXeO9etJ2djKIjUWMkGaVtTTVWp0QUamQzUIOCy/LW74GCUQ07vQ5glYJl/vyTD53noFFl3WaK/hTRt0z/f6QcQ0/v7nu/vBS48MYYSWT6hMYfS1wLqs43ne1H3TpqMXIWH/v+5shlbXFCxC8b4jCEDFvd25XRWmq5nW/fYX5IsgYnslm3h7PmhmuYF+tZKjzWarARBHKotSnDe6pg7sTx1tTMP8yXlU1ZRNoUbZglEGnyx7WPj/SnRAUdeyDzmZoFNn+llNFZPT2TS4LK58wFZaVD2g9kFbRWu0VIhYiXPpnKWu+gg9jtbQz9ITGIXC
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2019 15:15:20.4205
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f43d9cbf-8450-4352-8525-08d77e4ceff9
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB3883
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-11_04:2019-12-11,2019-12-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 phishscore=0
 impostorscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912110129
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Michael Hennerich <michael.hennerich@analog.com>

If there's a failure when registering a debugfs entry for a device, don't
silently ignore the failure. Instead, print an error message and an error
code signaling the failure.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/industrialio-core.c | 34 +++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index dab67cb69fe6..662dabf8b08c 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -364,23 +364,45 @@ static const struct file_operations iio_debugfs_reg_fops = {
 static void iio_device_unregister_debugfs(struct iio_dev *indio_dev)
 {
 	debugfs_remove_recursive(indio_dev->debugfs_dentry);
+	indio_dev->debugfs_dentry = NULL;
 }
 
 static void iio_device_register_debugfs(struct iio_dev *indio_dev)
 {
+	struct dentry *d;
+	int ret;
+
 	if (indio_dev->info->debugfs_reg_access == NULL)
 		return;
 
 	if (!iio_debugfs_dentry)
 		return;
 
-	indio_dev->debugfs_dentry =
-		debugfs_create_dir(dev_name(&indio_dev->dev),
-				   iio_debugfs_dentry);
+	d = debugfs_create_dir(dev_name(&indio_dev->dev), iio_debugfs_dentry);
+	if (IS_ERR_OR_NULL(d))
+		goto error;
+
+	indio_dev->debugfs_dentry = d;
+
+	d = debugfs_create_file("direct_reg_access", 0644,
+				indio_dev->debugfs_dentry, indio_dev,
+				&iio_debugfs_reg_fops);
+
+	if (IS_ERR_OR_NULL(d))
+		goto error;
 
-	debugfs_create_file("direct_reg_access", 0644,
-			    indio_dev->debugfs_dentry, indio_dev,
-			    &iio_debugfs_reg_fops);
+	return;
+
+error:
+	if (IS_ERR(d))
+		ret = PTR_ERR(d);
+	else
+		ret = -EFAULT;
+
+	dev_err(indio_dev->dev.parent,
+		"Error when trying to register debugfs: %d\n", ret);
+
+	iio_device_unregister_debugfs(indio_dev);
 }
 #else
 static void iio_device_register_debugfs(struct iio_dev *indio_dev)
-- 
2.20.1

