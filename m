Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9767CB7587
	for <lists+linux-iio@lfdr.de>; Thu, 19 Sep 2019 10:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731092AbfISI5b (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 19 Sep 2019 04:57:31 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:5826 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730938AbfISI5b (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 19 Sep 2019 04:57:31 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8J8m6lX012683
        for <linux-iio@vger.kernel.org>; Thu, 19 Sep 2019 04:57:29 -0400
Received: from nam05-by2-obe.outbound.protection.outlook.com (mail-by2nam05lp2059.outbound.protection.outlook.com [104.47.50.59])
        by mx0b-00128a01.pphosted.com with ESMTP id 2v3vb29rr2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-iio@vger.kernel.org>; Thu, 19 Sep 2019 04:57:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EjtA7yKdReqrWbeXX8kUn3t9ocMVSY9MYLIRCoDPiUp7kITEb7YjD80BwsjjH/OpgSYKgQ+GEj/B/h2YixrLn7oi61JQgzIeCI3oQy8ybS8yQbd9V5wGQRhlirigu+nRHCaPR2VVKnI8WbkCJVMLioyHkoWvLu0pdVs47+2m3y0cM5F2GdyLk/8kMF9odUj/vCoAyKa1DXShLOxXT1YlvoLqHyJP2HZldiQ9zFfhCzaX/8+yu8Va5fYPFod9mbppmhDqUJ5B2SVPM8zc1J+PB1i4bjnGRFf5vkIinaz2aHd2f5/tTmRIKbPQszsq1Nh1QtLi1++12s1jtPwOGco6Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QHAcJJrgQuyZXJ7jGD46P6LThI61dBbiXkIakgY8AvQ=;
 b=k/NsJtBIkhPR9Yb5YV9i/yFOnZPyy07Iq02KMC+h8wnzDn58Od0ogg0zfNxtHQpom5zlJ4eJNzJA37JFiNGjzZ++PS41ZhUMagAQEHT8O8OhI22g+FEWCW0fweQu2ev7+qYmeQFVFDmGULJOi5IWjWFiRmojElu89Z2Zf8aj8o0U9pm8T4QQ2Bh3Hyw7adVaJTDmZaK5iIogNUpAQh3ICFNydOoQ+WBtQCVL2PH5WCVQxahOS0MaXCy3ujfa217m9onny5OKYE1cJNuUkJfoa3a6kPsZMRMDc/d02IaJLddvfls9F1SFvo0N4ZaYXqH18V0sPJQpDTCbAEaXmk+FSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QHAcJJrgQuyZXJ7jGD46P6LThI61dBbiXkIakgY8AvQ=;
 b=xQLUtxaU4l3t6dXahFnNXuURs0eeQJ7FZD68LH5A2N24RibmTUpItilnL6cwNdhxQU5tp4sHQifngZeUNhB9zWajPQCfJeBguvwPCtYdbvchAIKZ7xafi6LFynunrt/lr8nuCEWddKXEkKWQHOijVxgslIkGTK0lsvZmkOoBUJk=
Received: from MWHPR03CA0018.namprd03.prod.outlook.com (2603:10b6:300:117::28)
 by MWHPR03MB3408.namprd03.prod.outlook.com (2603:10b6:301:3e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2241.18; Thu, 19 Sep
 2019 08:57:27 +0000
Received: from BL2NAM02FT043.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::207) by MWHPR03CA0018.outlook.office365.com
 (2603:10b6:300:117::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.20 via Frontend
 Transport; Thu, 19 Sep 2019 08:57:26 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2NAM02FT043.mail.protection.outlook.com (10.152.77.95) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2284.20
 via Frontend Transport; Thu, 19 Sep 2019 08:57:26 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x8J8vQp9005263
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK)
        for <linux-iio@vger.kernel.org>; Thu, 19 Sep 2019 01:57:26 -0700
Received: from saturn.ad.analog.com (10.48.65.123) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Thu, 19 Sep 2019 04:57:25 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] iio: gyro: adis16260: remove indio_dev mlock
Date:   Thu, 19 Sep 2019 14:57:16 +0300
Message-ID: <20190919115716.25909-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(136003)(39860400002)(189003)(199004)(5660300002)(305945005)(6916009)(246002)(478600001)(50466002)(50226002)(48376002)(486006)(1076003)(2870700001)(6666004)(7636002)(356004)(70586007)(336012)(2906002)(70206006)(106002)(2351001)(2616005)(51416003)(476003)(426003)(8676002)(8936002)(4326008)(7696005)(107886003)(126002)(14444005)(86362001)(26005)(44832011)(47776003)(36756003)(186003)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR03MB3408;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 472d5561-a1ef-481c-b5fa-08d73cdf64fd
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(4709080)(1401327)(4618075)(2017052603328);SRVR:MWHPR03MB3408;
X-MS-TrafficTypeDiagnostic: MWHPR03MB3408:
X-Microsoft-Antispam-PRVS: <MWHPR03MB340899691CB921EEDA3F1748F9890@MWHPR03MB3408.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 016572D96D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: fFlo9xHkAhYa9J12BZ2ZGXfnXuHO9mWYW8JB/cUM6ctQXYKGayV/Wts7RpuUZ0/UXKioLwHH8F5FCTSsCs6ceTevgGzrlLr5VrXi+JwkFCIa8PIq21URRAmxviKZL4ZTYRS/bW3X3yAqRLDc+5lzxmSxDUBrYtUEnwAws/uJWt/C+bQw2U2m91uMd25XInti76imzHjQaCoWKbdP0OOzduCW1/78aNWImy/Xoxhj+EY1ZT3LTd1gzKHVvU4pjSpnzWhbH/JH2JI+/7CO+uNIGD33SBJfBA/RW5zK7hlx9l9xPM4r+tJ4vplXrmXKPX5HTy4Wk5RAICnC5egFbAcU1BKU+5zs2sCEOBVmGAicy/ATCQyd+VtJ1oQxbjFE3+38DXyKAPxYoLiKUmvWDiktzd0yP8ihQKg7tQwy4JUtXWA=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2019 08:57:26.5566
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 472d5561-a1ef-481c-b5fa-08d73cdf64fd
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB3408
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-19_03:2019-09-18,2019-09-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 phishscore=0 adultscore=0 bulkscore=0 clxscore=1015
 mlxscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
 mlxlogscore=820 suspectscore=1 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1908290000 definitions=main-1909190085
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The internal lock that is by the ADIS library should be sufficient to keep
state consistent. There is no need for an extra lock.

This patch removes it.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/gyro/adis16260.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iio/gyro/adis16260.c b/drivers/iio/gyro/adis16260.c
index 207a0ce13439..0fa93d02062a 100644
--- a/drivers/iio/gyro/adis16260.c
+++ b/drivers/iio/gyro/adis16260.c
@@ -293,7 +293,6 @@ static int adis16260_write_raw(struct iio_dev *indio_dev,
 		addr = adis16260_addresses[chan->scan_index][1];
 		return adis_write_reg_16(adis, addr, val);
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		mutex_lock(&indio_dev->mlock);
 		if (spi_get_device_id(adis->spi)->driver_data)
 			t = 256 / val;
 		else
@@ -310,7 +309,6 @@ static int adis16260_write_raw(struct iio_dev *indio_dev,
 			adis->spi->max_speed_hz = ADIS16260_SPI_FAST;
 		ret = adis_write_reg_8(adis, ADIS16260_SMPL_PRD, t);
 
-		mutex_unlock(&indio_dev->mlock);
 		return ret;
 	}
 	return -EINVAL;
-- 
2.20.1

