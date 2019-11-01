Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F19BEC099
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2019 10:36:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728981AbfKAJfi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 1 Nov 2019 05:35:38 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:62556 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729017AbfKAJfh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 1 Nov 2019 05:35:37 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA19Xbxx012665;
        Fri, 1 Nov 2019 05:35:25 -0400
Received: from nam01-sn1-obe.outbound.protection.outlook.com (mail-sn1nam01lp2057.outbound.protection.outlook.com [104.47.32.57])
        by mx0a-00128a01.pphosted.com with ESMTP id 2vxwhg8u98-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Nov 2019 05:35:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N9W5NgVX43t1FeOUckuDnydDGS7cDiEaP4g3NO/Wo7PfGYOV9KD87qbRTzHWuCYaGW2qoKeYito9pKVJHromY1M0gRP0kOkDtmMooJ05SXPn1YrExsFpmBTdnGe3xjya9ov0XANrcO8vJfRNa1FHGoTdr9ibq0qOlWIlGjO77K2VKupMlYzm/WK4mIYx17RVFLI5wFK+zUoBjy1jAyHt+YnEC8h+EFtnI2UaJ6YGdK3zR5E20xtAdV44tssVK1yclFWWJLA730FcJJojNQg/GKBXSwjaFzczwXNyi+v8kSIG/FLL9VNOAaQCawnQ3VGVwgqi6WqCsmWTv8D255PZ/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lp+e5kDIj+xDqBrgO7a1Ln65A10nooRUSq0Uclc5CKI=;
 b=Ms/smMefkhUJ8SVbwRjzGTnSqDmSp46siSd6YyaaBu/I+OEgu68HREyH+3A2JDzKpjnjH+b2qo0H4TxONPmS9BKPZIDX9mbvRGdBwes+CXa3TnB5rx23lJE6B8fxk5KgFojPMPuVxSiTT7BQxx2IFWECNpPpNnLVjvISeoagcCaUqjLdHgEKUn90ZF+ZTmBUzUK8EDP0dAYwibrzVHTA9LjJUCGZSM2Qny/nQxuK2nQwIXU1PLfIeKXbee7GVl9mlUVJ6j9r8alDh+iygUewtii3wvRhWnxQpNZXhATEK5Jhu8eFbb7GHqas+lBF0nW6Jgg07rV0bhsERvSFFZGfzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=metafoo.de smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lp+e5kDIj+xDqBrgO7a1Ln65A10nooRUSq0Uclc5CKI=;
 b=2dixdCO4km3cUYXb6HfzpSkrEeJul+zWk5tcto1XUVfyLv7maR99J4mc8Q8DaHmwYfQm9boyfeuW7LPqtKUZBVL6Wax0FzYvy2Y6Zbs2E7VZ5Y3CGk85LWnBpKAc3yC2r6VyQVjq7+PmuP4LGNmDCSu/P5OEI9JRl3fsbT8q4bU=
Received: from CY4PR03CA0002.namprd03.prod.outlook.com (2603:10b6:903:33::12)
 by BY5PR03MB5062.namprd03.prod.outlook.com (2603:10b6:a03:1eb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2387.23; Fri, 1 Nov
 2019 09:35:24 +0000
Received: from BL2NAM02FT004.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::204) by CY4PR03CA0002.outlook.office365.com
 (2603:10b6:903:33::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2408.17 via Frontend
 Transport; Fri, 1 Nov 2019 09:35:23 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BL2NAM02FT004.mail.protection.outlook.com (10.152.76.168) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2387.20
 via Frontend Transport; Fri, 1 Nov 2019 09:35:22 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id xA19ZFW6025065
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 1 Nov 2019 02:35:15 -0700
Received: from saturn.ad.analog.com (10.48.65.117) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Fri, 1 Nov 2019 05:35:21 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <dragos.bogdan@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 06/10] iio: imu: adis16480: fix indentation of return statement
Date:   Fri, 1 Nov 2019 11:35:01 +0200
Message-ID: <20191101093505.9408-7-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191101093505.9408-1-alexandru.ardelean@analog.com>
References: <20191101093505.9408-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(979002)(39860400002)(396003)(346002)(136003)(376002)(189003)(199004)(36756003)(186003)(48376002)(106002)(51416003)(486006)(44832011)(4326008)(426003)(476003)(126002)(2616005)(446003)(8936002)(50226002)(26005)(76176011)(7696005)(478600001)(107886003)(336012)(11346002)(6666004)(54906003)(356004)(50466002)(86362001)(110136005)(2906002)(5660300002)(14444005)(246002)(4744005)(70586007)(8676002)(316002)(305945005)(70206006)(7636002)(1076003)(47776003)(2870700001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY5PR03MB5062;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 236ba2c5-4455-4136-cbec-08d75eaed186
X-MS-TrafficTypeDiagnostic: BY5PR03MB5062:
X-Microsoft-Antispam-PRVS: <BY5PR03MB50622B4FAA8B62A5DCB7A258F9620@BY5PR03MB5062.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-Forefront-PRVS: 020877E0CB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ClKcIbrX8+cJKiLkbQ9U6EdCOxvLSXCYq57GAcnOkMJTgvUj6bBlx966TM8UNnXrJU4Mui3XX6G11pC615j0ebiQmnt0bSHPShHk0A7WIeYsLVy+H3f5NwMWHh/ZMp6IsMNDxZFBpEOSsRTV8dxbwBQtHsgOYA96Cw40YQuFwe498mkHCd0Uac7cD2xFT3B/YswWr/ub4Rwn9giwXTJH13uFtOyIQvK24skSVi12ubU3ahTQpDthg8H2wDQ7F/vqyUGscxfsG8YEi/ccwdRUHrRL64+gWnMijEQi+Thzchi0bLDpyyqrgGMyGaJvvBj/Ar8T2ZUilm3j9RwjNlwTO3KQQD8oCR4pYPh5rvtEtqqKFfk+YjmCi9yIa2WpNle39FkmUN1BxSnFC3aJSqq4lwIB5ApXZ68w/jFVX0pYSHPjNHFkFVuKhpdSllVm77jf
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2019 09:35:22.8396
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 236ba2c5-4455-4136-cbec-08d75eaed186
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5062
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-11-01_03:2019-10-30,2019-11-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 spamscore=0 impostorscore=0 bulkscore=0 phishscore=0 mlxlogscore=999
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1911010095
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This is just a minor indentation/alignment fix for the default case of a
switch statement.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/imu/adis16480.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
index 86801f3c5f0d..d199d3d3c4bd 100644
--- a/drivers/iio/imu/adis16480.c
+++ b/drivers/iio/imu/adis16480.c
@@ -459,7 +459,7 @@ static int adis16480_get_calibbias(struct iio_dev *indio_dev,
 		*bias = sign_extend32(val32, 31);
 		break;
 	default:
-			ret = -EINVAL;
+		ret = -EINVAL;
 	}
 
 	if (ret)
-- 
2.20.1

