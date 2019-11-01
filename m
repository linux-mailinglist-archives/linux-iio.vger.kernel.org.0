Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5DECEC0A2
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2019 10:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbfKAJf4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 1 Nov 2019 05:35:56 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:65500 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729121AbfKAJfq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 1 Nov 2019 05:35:46 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA19XOcH026879;
        Fri, 1 Nov 2019 05:35:34 -0400
Received: from nam03-dm3-obe.outbound.protection.outlook.com (mail-dm3nam03lp2057.outbound.protection.outlook.com [104.47.41.57])
        by mx0b-00128a01.pphosted.com with ESMTP id 2vxwgwh8x8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 01 Nov 2019 05:35:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RK1MYycEewj6hEsfN1BfA8wh73uXtfvma7Fuhp1ajqVLBQRl3RRXfzV4cwegNFiPXQVdTp1Sn7+NdgQRrpWHMYGqUb9zYoQqOjZh5H6no62gdx8Fs6AW+NmWaxqEIGCjbVEdfEDc7cHSyQ+hmZuNqtvceCTVVzuvooRcwMevVqhGm/BUK9lTF6s5TvgqVCNtLRjMVm0EnbtPFIzQu6w8uuuC+RVfMMulwKVrom3RmUcyRgpe2GlwdO/r2Ps3dEqEYZC7rb41w+L1no87lHxYmbjimWyNQm69pL0og/BqmIAaAkYoMLe3o3w/g9o9KIA15eyO5OX/fzaBXnjD/OR6Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mNVqn/wOghXwSVSvCsoW0WLZEJQ+8rG4X/dJV39Dcj0=;
 b=LoHgZbOgK4rEM4h1zHSjB6yNdbMTx6Mg/PKh6rtMMoCeaHYgHvv/70Buz9jTG824L0rUNcqz1QrKlJOpHrSrqjDk1syxz80Yd5z18KZMCSbFbxF5ETMWJCHbC2Pp+D1VSjB9BDu0Af8IXHePbvmv7nEDnqIYy+OI/zJocrV1F0tlKhjhvFI7XtgguQ4u/rkVGUS3knIAffJfdSm9+nu4XlR3IpaoPzNXiLgSfXY95nsqNTnFIyEc1gCY5cj5/gG27Dz5+k4TqTbajMQAbNL8SlCoO00K6lu7qC+mZL930n5aCtQEeBPmu7SPeOARSx6WvuJ+yR8cx6Hb8ZqCR8d94g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=metafoo.de smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mNVqn/wOghXwSVSvCsoW0WLZEJQ+8rG4X/dJV39Dcj0=;
 b=RQBZgM2f8rPFwYyUgGz1nQ00aJvSFhD2QFUUgL+onTogVkIn+LPv5H2zF+iy0FhtncK2k6QY0wOZop3bq057/e4xlGkrtmlc4EoQL3rGsvQgkaNohHpB/jDJ0EblC+lPDNHgyUcRTDLNolxRoAO0qcTtlUAkhHAfmXSBtRn7gJQ=
Received: from DM6PR03CA0048.namprd03.prod.outlook.com (2603:10b6:5:100::25)
 by SN6PR03MB3646.namprd03.prod.outlook.com (2603:10b6:805:42::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2387.23; Fri, 1 Nov
 2019 09:35:31 +0000
Received: from CY1NAM02FT064.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::207) by DM6PR03CA0048.outlook.office365.com
 (2603:10b6:5:100::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2408.20 via Frontend
 Transport; Fri, 1 Nov 2019 09:35:31 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 CY1NAM02FT064.mail.protection.outlook.com (10.152.74.64) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2387.20
 via Frontend Transport; Fri, 1 Nov 2019 09:35:31 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id xA19ZNc9025109
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 1 Nov 2019 02:35:23 -0700
Received: from saturn.ad.analog.com (10.48.65.117) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Fri, 1 Nov 2019 05:35:29 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <dragos.bogdan@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 10/10] iio: imu: adis: assign value only if return code zero in read funcs
Date:   Fri, 1 Nov 2019 11:35:05 +0200
Message-ID: <20191101093505.9408-11-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191101093505.9408-1-alexandru.ardelean@analog.com>
References: <20191101093505.9408-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(376002)(346002)(199004)(189003)(50226002)(186003)(356004)(6666004)(316002)(2870700001)(26005)(7696005)(4326008)(106002)(2906002)(36756003)(5660300002)(107886003)(54906003)(76176011)(48376002)(51416003)(110136005)(70586007)(44832011)(446003)(476003)(50466002)(7636002)(336012)(1076003)(70206006)(47776003)(426003)(86362001)(8676002)(2616005)(486006)(478600001)(8936002)(246002)(126002)(305945005)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR03MB3646;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5a09f80-5e48-4fd7-2552-08d75eaed685
X-MS-TrafficTypeDiagnostic: SN6PR03MB3646:
X-Microsoft-Antispam-PRVS: <SN6PR03MB36467BA4ED2ECF9E222300A3F9620@SN6PR03MB3646.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 020877E0CB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h6UmQ/FyOjyVO77P2DzpBUmQRD/P/tfD4WwCk8ASEWMuSLgM3+gezoNCKZJNKibAlnMLh0Vkur/2mM3m/tvSG3HvFYTmaJn0LcgvFOSSSV1BttoWGigZpX6YHCPzdzPHjGx5OiuwT5o3BBR/860AKNssiMVJA0Z/wCIGgQpjINqSY0Ifqr0mF0oOhOy3ij0eLL+z/doB4ji0JrJ7jGuXD++lVnVTuNw5ZuImIywyqowEP06kZr65f/aULWcHeBfM7ISPT6cSaLnBg+OQL2p57rpIm+CuZx2wbAR/s2pisHfR6BfnuDpvHJ4EK4w49S2/Ln1irBiiHhKa6wg8MjLKR0kQMuFteGjiDfY+g5TIyJgfDAgFjXWvvgEbPJ6Z0WI9Zdqkb+cKaPKRRYN+oguOTlMq8lqxPUFooCN99Bhyk4olawxX+LJJHXLiCv/r9cmM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2019 09:35:31.1384
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5a09f80-5e48-4fd7-2552-08d75eaed685
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3646
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-11-01_03:2019-10-30,2019-11-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=928
 lowpriorityscore=0 bulkscore=0 mlxscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1911010095
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The inline read functions in the ADIS library don't check the return value
of the `adis_read_reg()` function and assign the value of `tmp` regardless.

Fix this by checking if return value is zero and only then assigning the
value of `tmp`.

Fixes: 57a1228a06b7a ("iio:imu:adis: Add support for 32bit registers")
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 include/linux/iio/imu/adis.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
index 4c53815bb729..92aae14593bf 100644
--- a/include/linux/iio/imu/adis.h
+++ b/include/linux/iio/imu/adis.h
@@ -129,7 +129,8 @@ static inline int adis_read_reg_16(struct adis *adis, unsigned int reg,
 	int ret;
 
 	ret = adis_read_reg(adis, reg, &tmp, 2);
-	*val = tmp;
+	if (ret == 0)
+		*val = tmp;
 
 	return ret;
 }
@@ -147,7 +148,8 @@ static inline int adis_read_reg_32(struct adis *adis, unsigned int reg,
 	int ret;
 
 	ret = adis_read_reg(adis, reg, &tmp, 4);
-	*val = tmp;
+	if (ret == 0)
+		*val = tmp;
 
 	return ret;
 }
-- 
2.20.1

