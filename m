Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F35A107334
	for <lists+linux-iio@lfdr.de>; Fri, 22 Nov 2019 14:30:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbfKVNaY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 22 Nov 2019 08:30:24 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:29444 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727996AbfKVNaP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 22 Nov 2019 08:30:15 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAMDNNBr006193;
        Fri, 22 Nov 2019 08:30:12 -0500
Received: from nam03-co1-obe.outbound.protection.outlook.com (mail-co1nam03lp2050.outbound.protection.outlook.com [104.47.40.50])
        by mx0a-00128a01.pphosted.com with ESMTP id 2wabu7myv1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Nov 2019 08:30:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=feV3gNnBcWnwiVDLlWyMDdMm9QfPeuFNLMQRsnx516APWwGhZOa0HrDhxN0TFMjUa/Gm3coPmqxCPLZ3p1UREaAVMm7t6Cg5xjbhcfGMmfGFz95yysI+4g1W8FAwXPWQLocU/Buw/yMxwhrNcOldfv2lsfE4YdiN3KEQv+oaNVrC7EFVZ6TPO/BuJHvX4TTLuSIRRl1SIQpvD0ZLjDRMnRpC0nIULCTH9Js2qBomKZ14nvpOG3R7oA52bKjgn9B8iN0OYIrMadwTRmpqisc98CQIyBtk+OzOuSyXPL2o3kFCL7K0JacWT5A+agzGy/EbIHDb1hmcJXp/RYwWax837Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0PCqNvzzTcjNYlMXXQWsEp3LXprfpuS5/yf3qlm7B7Q=;
 b=azcC4r/KwnXEKNvO6o7813CkZ/avvVGMwNRynh84ommRxmsLP8UX108Mci2Q6hsFrx/wXbH1rMH57vdZIMp1hQa71GuwzY31TwAmagFUUf26hf8N0lJi3Y0PCFcyB6kDp+f6+dIKF8pU3wOpglpHW+mEPjSgI6d6qjmaC3NcGBm6RVIxhjlO3joz9O0IhsClN+udIVPOqXWQ8o/6cY+zlPzkTUqKI/SLaqEZbTB55/4L3hgu+pOlfNd4GdNlF5UZD0vGtFvBWX+h/JFXluyq/2tRopexRwsf/AzjRkgv2Fp+KxO/g8gjRyRYFr1PfdJeRG0RUymt5rTdbuXRgPbDmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0PCqNvzzTcjNYlMXXQWsEp3LXprfpuS5/yf3qlm7B7Q=;
 b=KOdEIXFTSTgdkDZI9wsvHPpAy2Mn+CbMv1ELCIfoomFlkG7DlrSgIiuxS55F++XYg04byFUb9asNQlEs8V1cQonpDJYqmOj9874uaNLXY8di0DmoAebKnJwoOX4QZwUHh2QATFGRN8cmOFXDjknTcgPiW0HNCRPBU5ugCg51QHo=
Received: from DM3PR03CA0023.namprd03.prod.outlook.com (2603:10b6:0:50::33) by
 BN7PR03MB3745.namprd03.prod.outlook.com (2603:10b6:408:23::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17; Fri, 22 Nov 2019 13:30:10 +0000
Received: from SN1NAM02FT044.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::207) by DM3PR03CA0023.outlook.office365.com
 (2603:10b6:0:50::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.17 via Frontend
 Transport; Fri, 22 Nov 2019 13:30:10 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 SN1NAM02FT044.mail.protection.outlook.com (10.152.72.173) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2474.17
 via Frontend Transport; Fri, 22 Nov 2019 13:30:09 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id xAMDU0Bv015887
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 22 Nov 2019 05:30:00 -0800
Received: from saturn.ad.analog.com (10.48.65.119) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Fri, 22 Nov 2019 08:30:08 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <nuno.sa@analog.com>,
        <Michael.Hennerich@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 11/11] iio: gyro: adis16260: replace mlock with ADIS lib's state_lock
Date:   Fri, 22 Nov 2019 15:24:21 +0200
Message-ID: <20191122132421.5500-12-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122132421.5500-1-alexandru.ardelean@analog.com>
References: <20191122132421.5500-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(136003)(376002)(189003)(199004)(5660300002)(36756003)(4326008)(107886003)(478600001)(1076003)(76176011)(51416003)(7696005)(14444005)(6666004)(356004)(48376002)(50466002)(47776003)(8676002)(70586007)(54906003)(70206006)(2906002)(316002)(86362001)(106002)(110136005)(426003)(50226002)(44832011)(8936002)(336012)(26005)(2616005)(186003)(446003)(11346002)(246002)(305945005)(7636002)(2870700001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR03MB3745;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03af1020-a9ed-4a43-6e14-08d76f5018b8
X-MS-TrafficTypeDiagnostic: BN7PR03MB3745:
X-Microsoft-Antispam-PRVS: <BN7PR03MB3745A264396D6BE6DF5EC8CDF9490@BN7PR03MB3745.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 02296943FF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6JpYkjbvpE5nIRm/pDnxNMgnre/hY9HCweDRXhX4IovzrVkUul+BPmFhAYgetTpXcSzAs3GC98kbNQfLnS+v3/0heHTBwGqwMFzAzV+vUdSdrUwCX+fqCsNnHB8vlLCFIz9K6A+figUy0DlYqkHdgLJUyn7bJoJ4PEZuyd3ehQwFLE3vM0ltX97uHzEQzVosk0Mh9tcE6CWEwACTUf95biptU1+lM5UqNjYC/Xzc7mI3P/gxFJR3J93Xnl4gxeazg+iRDGSIyimCqs2ArIkdENvVGIjyoXMS2CO4edVuqTDD4rAWyc0TPs165ky2JudqwF6oYoP8sO4iOK13nIsAd8DeQpNXwR6Rdu5FzSr8OSuJk2fdJf4YZB0HBxgb/ZiB1Rk/5bUcCqr3bTsSX2cWlsWoEHRSj/CgvV6glHId7NLy9ZRjI772F1Z0rifM7Yij
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2019 13:30:09.7930
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03af1020-a9ed-4a43-6e14-08d76f5018b8
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR03MB3745
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-22_02:2019-11-21,2019-11-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 spamscore=0 adultscore=0 clxscore=1015 mlxlogscore=993
 bulkscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911220119
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This change uses the ADIS library's state_lock to protect the state of the
`max_speed_hz` change that is done during the set of the sampling
frequency.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/gyro/adis16260.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/gyro/adis16260.c b/drivers/iio/gyro/adis16260.c
index 207a0ce13439..726a0aa321a8 100644
--- a/drivers/iio/gyro/adis16260.c
+++ b/drivers/iio/gyro/adis16260.c
@@ -293,7 +293,7 @@ static int adis16260_write_raw(struct iio_dev *indio_dev,
 		addr = adis16260_addresses[chan->scan_index][1];
 		return adis_write_reg_16(adis, addr, val);
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		mutex_lock(&indio_dev->mlock);
+		mutex_lock(&adis->state_lock);
 		if (spi_get_device_id(adis->spi)->driver_data)
 			t = 256 / val;
 		else
@@ -308,9 +308,9 @@ static int adis16260_write_raw(struct iio_dev *indio_dev,
 			adis->spi->max_speed_hz = ADIS16260_SPI_SLOW;
 		else
 			adis->spi->max_speed_hz = ADIS16260_SPI_FAST;
-		ret = adis_write_reg_8(adis, ADIS16260_SMPL_PRD, t);
+		ret = __adis_write_reg_8(adis, ADIS16260_SMPL_PRD, t);
 
-		mutex_unlock(&indio_dev->mlock);
+		mutex_unlock(&adis->state_lock);
 		return ret;
 	}
 	return -EINVAL;
-- 
2.20.1

