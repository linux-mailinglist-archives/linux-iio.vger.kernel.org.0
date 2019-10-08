Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB753CFC1E
	for <lists+linux-iio@lfdr.de>; Tue,  8 Oct 2019 16:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbfJHOPo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 8 Oct 2019 10:15:44 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:55216 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725908AbfJHOPn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 8 Oct 2019 10:15:43 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x98E7qGB000888;
        Tue, 8 Oct 2019 10:15:34 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-00128a01.pphosted.com with ESMTP id 2vemxauuph-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Oct 2019 10:15:34 -0400
Received: from m0167091.ppops.net (m0167091.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id x98EFXql007781;
        Tue, 8 Oct 2019 10:15:33 -0400
Received: from nam01-sn1-obe.outbound.protection.outlook.com (mail-sn1nam01lp2058.outbound.protection.outlook.com [104.47.32.58])
        by mx0b-00128a01.pphosted.com with ESMTP id 2vemxauupf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Oct 2019 10:15:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X27PJhLg2x/TvBLLUMSpg/H/kYskrk+zKJcwu/Q6YHgXR/zYGs9W9rcKM9e8ZnnihyifBijGcjRPAjqD7xhZUvfA3tU6ms8IyHqGK8Tjm7zW1xw9XEeHmT4ULEQ7kghjgbbkjr6VkAJZbGp2vPDEYcvyEiE0lmH9mNvovikHqd8nUcZ5jFL+wtOT6iV9psiCpYJMJe8Bfx2G5+9j/KLf0vLyW03GpC1GA+7hndOVhRNAT1GwSssQkQ+vcYxbMCzcbSL4t6cNTcI8lzpVILwAp25XZq0SmY0zhRrEsGrN0nADQNKoFagX+0CwLYlVfklYcbxKWFatU+4rAQ+XVtVYVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D+j5W4aa8ZIxg6wjrGXoqy1EmUhAiU0qfekwmLejwrE=;
 b=J+1rxG88t9zp7CoSxe6+N/PNKoHqFR4bo8qAy42EKTbhJPbUXsiCGirOETwIdTiPzcfw3QYLXzd1vCTs4TROwa71zH7nm/wislOI0/+oL2ITsENQvW+dVuH/Ng1T43Z6lMgkh62oVvpQLrWFojbdryK4+Ho7Vp/sgCS9Ib0T/TWi2ELlDm2IPxtTUCLlY9hiQD/cA5gr/DkA/XisaNVBUOo34QAlCQHdgWYh/zhmvSnjpaZoum8QNHxZLJoilskQ2fvHk/2Bv6s2r/fion/NGTO2mdNY3n89WUwb6sAIxwvPB4pQ11EGCA4bLpjsmRyM+flZOoYPeFgCWl8Cthv6vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D+j5W4aa8ZIxg6wjrGXoqy1EmUhAiU0qfekwmLejwrE=;
 b=SEXPW8vgPGarB+X7mnrwfZFMGEzyPzIyca7PoE0NxeErUL8ISE51AsXkhAjxF3rift3JzEcmJCl9e0VxK6ztsKGcL5WmPUtG6fmp+2IhEGCokql/alGrX41Ve1EL0+HvdZ4WhL2y+vrhooDJPeWu5J79pb32arriRlGIq75EV04=
Received: from BL0PR03CA0004.namprd03.prod.outlook.com (2603:10b6:208:2d::17)
 by DM6PR03MB5323.namprd03.prod.outlook.com (2603:10b6:5:24b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2327.23; Tue, 8 Oct
 2019 14:15:32 +0000
Received: from SN1NAM02FT062.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::208) by BL0PR03CA0004.outlook.office365.com
 (2603:10b6:208:2d::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2327.25 via Frontend
 Transport; Tue, 8 Oct 2019 14:15:32 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 SN1NAM02FT062.mail.protection.outlook.com (10.152.72.208) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2284.25
 via Frontend Transport; Tue, 8 Oct 2019 14:15:31 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x98EFUXh013974
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 8 Oct 2019 07:15:31 -0700
Received: from saturn.ad.analog.com (10.48.65.130) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Tue, 8 Oct 2019 10:15:30 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <jonathan.cameron@huawei.com>,
        <dan.carpenter@oracle.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2] iio: imu: adis16480: make sure provided frequency is positive
Date:   Tue, 8 Oct 2019 17:15:37 +0300
Message-ID: <20191008141537.31512-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(136003)(376002)(396003)(39860400002)(189003)(199004)(54534003)(126002)(8936002)(476003)(186003)(486006)(4326008)(50466002)(336012)(70206006)(70586007)(26005)(14444005)(246002)(8676002)(48376002)(106002)(54906003)(110136005)(107886003)(44832011)(50226002)(2616005)(478600001)(426003)(36756003)(316002)(7636002)(7696005)(305945005)(5660300002)(86362001)(47776003)(2870700001)(356004)(51416003)(1076003)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB5323;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 639f39a1-0b39-4d63-b724-08d74bf9fa9a
X-MS-TrafficTypeDiagnostic: DM6PR03MB5323:
X-Microsoft-Antispam-PRVS: <DM6PR03MB532332E4C202889C616EBCAAF99A0@DM6PR03MB5323.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 01842C458A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mEF5UEMNixw3cdfz68yYFokPcpP2NVeeus2nA0Qc0JXSKMzEo5iwryB+uS7TLwyJ8UGrN7MLV6EK/GeLH7NgoDCkcYr9BlavD1gLVrJMEQ5KS6IID/LHafxEqgBjhTmC3OtrBqODR6HgIwUvRrTRsFdpoUGGY6QPmXVnrINnMJ5F/Bwd4gEcFu0jGf9lfudiZtEUFxVxBPjiU0x5KGOFqNmJm1Ee1udlX8yQm0EdoWKseavo+LpFG2qqXpKh7TaIjR7WaLmi4S9whSIJ25Z8OEFj7AToxQ+eOHSkcYs+JEIEofsF8MH7FZOjJBTXes7dOa6KO5W41/9sncZbwith9GXK6w+gQdgvVCsFewWDPdRq264w7x6DMQxPoRrdYJ6a0Dvi+Ke5xNvfEhFhbp8q+FReCfrz2CSt6AO1ECj8MsI=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2019 14:15:31.8296
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 639f39a1-0b39-4d63-b724-08d74bf9fa9a
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5323
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-08_05:2019-10-08,2019-10-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 bulkscore=0 phishscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910080132
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

It could happen that either `val` or `val2` [provided from userspace] is
negative. In that case the computed frequency could get a weird value.

Fix this by checking that neither of the 2 variables is negative, and check
that the computed result is not-zero.

Fixes: e4f959390178 ("iio: imu: adis16480 switch sampling frequency attr to core support")
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---

Changelog v1 -> v2:
* also check that val & val2 are not negative (in addition to checking if
 't' is zero

 drivers/iio/imu/adis16480.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
index 01dae50e985b..0bec1fea823d 100644
--- a/drivers/iio/imu/adis16480.c
+++ b/drivers/iio/imu/adis16480.c
@@ -317,8 +317,11 @@ static int adis16480_set_freq(struct iio_dev *indio_dev, int val, int val2)
 	struct adis16480 *st = iio_priv(indio_dev);
 	unsigned int t, reg;
 
+	if (val < 0 || val2 < 0)
+		return -EINVAL;
+
 	t =  val * 1000 + val2 / 1000;
-	if (t <= 0)
+	if (t == 0)
 		return -EINVAL;
 
 	/*
-- 
2.20.1

