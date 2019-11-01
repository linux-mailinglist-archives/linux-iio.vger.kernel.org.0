Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2B9EC0A1
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2019 10:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729205AbfKAJf4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 1 Nov 2019 05:35:56 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:63116 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729074AbfKAJfn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 1 Nov 2019 05:35:43 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA19YdbW027913;
        Fri, 1 Nov 2019 05:35:31 -0400
Received: from nam05-dm3-obe.outbound.protection.outlook.com (mail-dm3nam05lp2055.outbound.protection.outlook.com [104.47.49.55])
        by mx0b-00128a01.pphosted.com with ESMTP id 2vxwgwh8x6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 01 Nov 2019 05:35:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kEUv508WoVmq9vA7vGRAjBTTPpQblcdKpYHBdoB0tbHQkxEX3GmUhIjuEvMvXG8XngOQxJ7xnvcZugNSnULdzLIMbR7GSdY72VvuAuA0ez+lQxD9LQCExs/Wt0yWqzEsVN2q+coiqBA+jNRxKC6OhWEi4g+7VEPubsCeOiwEEo4Me++spkYcV72vD2EBstEzazV3EYgYfljCghrgPMnFphVAwRB9B3tCK8I7E6KPr+Ru/1pYvHENecriIljuuRj3OfjUmIN1cw4nJgv/0MNXNAPURTYECiYjjgSrxu4LORy3hS9MypCZEIlMlAcD61ZdRKJomDnqeADJuRTZUp9OHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tb7UZOr139aoTeDFSnbx1h6lLPxo8UuX3qcWC9LfMzE=;
 b=YUMX1KqgLtiWzM/4Q+oKCyiJy7hKWbvQEpnFGeLwubhIo5710cOHydskZaA6u2CL7+BGwY1oKBzBKT2CRK2ccvOcY1j69c+YpbETKxbwQZiNNJaZW7G/y1+rfuaCRpbQEDZkdiu2yD7AYdAOSIKzGoM10cItjFEM6clArhgDGcavxTlPc9AXvn+Gr3KAYTL9Y06FLNVzq9KnDoWOdctrIJm3X6j8jzTC1Qyh+P/QBg6XouE0bwBiEYuc1L2LBF4f5kCLK5jXBFMrXeuJoYkzR+64A5T7Elnn9Yw/u7QP95LOBch/q2KCPsk5nMGrtdFJRS9gceWbUQzb32bTFdFffQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=metafoo.de smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tb7UZOr139aoTeDFSnbx1h6lLPxo8UuX3qcWC9LfMzE=;
 b=KpZ2pVCOGdc9w+4HWmO/nGk2jfrS2KGbACVA6TO/0hfrHniEnHT/DAl/d1Bu9il8/O0ob6H94vzitF6oWTp5yS8eZ7DJWkHcH0hBor9aWE0QvUooGWe4VjT+0PjuHBalMCUggE1uxWofBp/skFNXvK3kcb9jNlBOQwTOI3Q3LwY=
Received: from CY4PR03CA0013.namprd03.prod.outlook.com (2603:10b6:903:33::23)
 by CY4PR03MB2534.namprd03.prod.outlook.com (2603:10b6:903:39::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2408.17; Fri, 1 Nov
 2019 09:35:29 +0000
Received: from CY1NAM02FT027.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::206) by CY4PR03CA0013.outlook.office365.com
 (2603:10b6:903:33::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2408.20 via Frontend
 Transport; Fri, 1 Nov 2019 09:35:29 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 CY1NAM02FT027.mail.protection.outlook.com (10.152.75.159) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2387.20
 via Frontend Transport; Fri, 1 Nov 2019 09:35:29 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id xA19ZLDs025106
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 1 Nov 2019 02:35:21 -0700
Received: from saturn.ad.analog.com (10.48.65.117) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Fri, 1 Nov 2019 05:35:27 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <dragos.bogdan@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 09/10] iio: imu: adis: assign read val in debugfs hook only if op successful
Date:   Fri, 1 Nov 2019 11:35:04 +0200
Message-ID: <20191101093505.9408-10-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191101093505.9408-1-alexandru.ardelean@analog.com>
References: <20191101093505.9408-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(396003)(136003)(189003)(199004)(2906002)(51416003)(476003)(446003)(50466002)(44832011)(2616005)(426003)(126002)(2870700001)(48376002)(11346002)(246002)(356004)(106002)(50226002)(6666004)(8936002)(486006)(1076003)(47776003)(7696005)(316002)(4326008)(336012)(36756003)(8676002)(76176011)(86362001)(70206006)(305945005)(14444005)(186003)(7636002)(70586007)(107886003)(5660300002)(4744005)(54906003)(478600001)(110136005)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR03MB2534;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5bb042c9-b3ae-43d9-708f-08d75eaed550
X-MS-TrafficTypeDiagnostic: CY4PR03MB2534:
X-Microsoft-Antispam-PRVS: <CY4PR03MB2534A1D24D7D92A5174E4C3CF9620@CY4PR03MB2534.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 020877E0CB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pIIdAczUE7w/vRewBnabEjHetvGue8DPtV4dN89Drwu9njoroLYyAOGuRUU2cUeIuHBaoBjddO6s1DomIhdVdkduv68Rz/0UKjBw0kVe4p3hV026QBwmZFNCFPEi5nROWn+pmVv63NpP01hbXPlE6J/rr+/3E6EklpMHCtOZ3LVhd7KZgqwIfMIEX5T0bCC1RQncpxe9RFrCGw1zJh8f/i0KQFEAbZcGPAGNOyQODH9jkBXChluqixM6WJSCRjYnROEJELFOFuZwTU9GroC67XbA3HhZ/T+Wc+rv8LH0SmYiQrmO97Zzzk0we9DDw4CU3yqxPoG5UZo46SEuGiYwJMVbAoxisVGS5xKERbHNPj7qhXentXIN+cZyCXER+jm/GloEC9qZVVWOiQo78ytxxNnq/QzsdeuQGjEqR41VpoHi8FC5rAH1krNAmCNsLiYO
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2019 09:35:29.1162
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bb042c9-b3ae-43d9-708f-08d75eaed550
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2534
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-11-01_03:2019-10-30,2019-11-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 bulkscore=0 mlxscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1911010095
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This was also caught by the `-Wmaybe-uninitialized` warning, which
(ironically as-is) it makes quite a lot of sense to do for this.

Fixes: 78026a6fde8f7 ("iio:imu:adis: Add debugfs register access support")
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/imu/adis.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
index dc2f9e061d98..85de565a4e80 100644
--- a/drivers/iio/imu/adis.c
+++ b/drivers/iio/imu/adis.c
@@ -229,7 +229,8 @@ int adis_debugfs_reg_access(struct iio_dev *indio_dev,
 		int ret;
 
 		ret = adis_read_reg_16(adis, reg, &val16);
-		*readval = val16;
+		if (ret == 0)
+			*readval = val16;
 
 		return ret;
 	} else {
-- 
2.20.1

