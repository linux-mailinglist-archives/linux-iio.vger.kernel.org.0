Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 638DDE141D
	for <lists+linux-iio@lfdr.de>; Wed, 23 Oct 2019 10:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389913AbfJWIZe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 23 Oct 2019 04:25:34 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:59030 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727574AbfJWIZe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 23 Oct 2019 04:25:34 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9N8MukP020880;
        Wed, 23 Oct 2019 04:25:04 -0400
Received: from nam01-sn1-obe.outbound.protection.outlook.com (mail-sn1nam01lp2058.outbound.protection.outlook.com [104.47.32.58])
        by mx0b-00128a01.pphosted.com with ESMTP id 2vt9t5shuu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Oct 2019 04:25:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iB/hBKX9+oy16Fxrg6kkVeScTvJkTw1FE+v0Nz75e4aQ9gbvaQQhHIyhpNV3Q/ttgSh/xth+XOdU1doj6Wsn3Gb3rXMuaPLRCg2hUVQ1F7yj4LyG+4k47q8W+uSniR4fiPIjA6ttg2zDrVehJHLF4xqohdN45nfxUyLKXOg21oxijpn+2joYH0CS0gKQ5UwXo0L2tAJVLG7qGHS4SVVL/v//POChM10IO0hm3TTRz1M9o4vzIv2C/TaD7TG5isGwmlfFQGeoL7O0sB53J8z9UDdqPuBeqEX5V/LZxRHe3oiuE0JzSbmM5RD0l4WMCD2mk4qw6ICcE5a+8k8LyJwhDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YryXgmMF7Et2pKEPYdw5ueu47oSmn94ihj836DrvTG4=;
 b=lLwRPP9xmpD7ODrrphCBFKXO8qleavqRr25D+XjQdNx9ogcCQZTWVo7+76abN4dLfWb3Xw7ZU1vwWGFeegzMcYkw3ZK90esFnOyzPDjGgAvXTDiwlWp/Ht1RfckHiLIlpwR8cgB1jgEB7z0QPVwxallDaX09MjcpGAiJWKqbGcLjUVvSdmQW9OkemudXXUneC5GZ9cUeecNGSytKNLMkdTForuNCyC60LkKRYTaJIvl3Kc7GmxMH9JQSN5iqNBk8A1gE4zAHsXPbQLJceQfhuFsXWdZHZmpF2JbwPtZqfq+zMb+1FMHB4+FNrnmgEaWoFJuQnKYKwGaTF85NJfXcYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=microchip.com smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YryXgmMF7Et2pKEPYdw5ueu47oSmn94ihj836DrvTG4=;
 b=Br2ZDNSwlf8ufeb+Q+IG81vnqHoyg9GTyVsuWtzrgI3ky9OTM+dlUPafBFn2MXaVUhqkLonp9imRotXYDX0iE/v5qvGd9VjrRVha6DkGNhNgd9uEXoOlPydrTzvt7zoIyCZltsViCo6nLHEV8J1IubPh0HxZbpqsrcDIguoTv8Q=
Received: from BYAPR03CA0003.namprd03.prod.outlook.com (2603:10b6:a02:a8::16)
 by MWHPR03MB3101.namprd03.prod.outlook.com (2603:10b6:301:3c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.28; Wed, 23 Oct
 2019 08:25:00 +0000
Received: from BL2NAM02FT004.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::206) by BYAPR03CA0003.outlook.office365.com
 (2603:10b6:a02:a8::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2387.22 via Frontend
 Transport; Wed, 23 Oct 2019 08:25:00 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BL2NAM02FT004.mail.protection.outlook.com (10.152.76.168) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2367.14
 via Frontend Transport; Wed, 23 Oct 2019 08:25:00 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x9N8OoQA012195
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 23 Oct 2019 01:24:51 -0700
Received: from saturn.ad.analog.com (10.48.65.116) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Wed, 23 Oct 2019 04:24:57 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <ludovic.desroches@microchip.com>, <jic23@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <knaack.h@gmx.de>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] iio: at91-sama5d2_adc: fix iio_triggered_buffer_{predisable,postenable} positions
Date:   Wed, 23 Oct 2019 11:25:08 +0300
Message-ID: <20191023082508.17583-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(136003)(376002)(346002)(199004)(189003)(336012)(478600001)(486006)(2616005)(26005)(5024004)(14444005)(44832011)(5660300002)(476003)(186003)(426003)(4326008)(126002)(7696005)(6666004)(7416002)(356004)(107886003)(51416003)(316002)(305945005)(7636002)(47776003)(54906003)(106002)(86362001)(70586007)(48376002)(110136005)(2201001)(36756003)(8676002)(2870700001)(8936002)(50226002)(50466002)(1076003)(2906002)(246002)(70206006)(142933001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR03MB3101;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fdfbc7cd-6c7a-47eb-7a12-08d757927f11
X-MS-TrafficTypeDiagnostic: MWHPR03MB3101:
X-Microsoft-Antispam-PRVS: <MWHPR03MB31015E7D62E5D78911F2DE14F96B0@MWHPR03MB3101.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 019919A9E4
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u/ONxHq0E8SBU9eD+sPYE+xoUPiXMSGGvulwHo5Ro3V8pJQ8aGJ8ifV+TLesTVohY9q9/bvF6aExNjwHmM/SW3T3c+Zyf6qJEriwJzgk3DPLYXB2WIiJty4j+i6pSa6W0ACxHKEpvWwt+rF8wSoNxI4egvR7nE1+q4OdJqvrqvgI470IM5XAUDRg32FHLdS2C8VIZpQTRnRAOeG8meH4xMe+sl5ZhWQwyev0/gQcU8nHe/jzDbWD3FMxKzofudmvJsHP2BZTOfjnA5/iupptKDf4UrbDtCTabcGA3IL5SWg09SjF7pBUBEVHRdhiRlK85X8bIskc/WZQxbLAWL6aJkHVLzWdApERL2CT09yN7c/LGR/NsTYg30Nj4XIjvIKyVAf8mhhHAfpz67PF9m3Fk36KCKfgqhQpSdeWDLGD1mM=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2019 08:25:00.4347
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fdfbc7cd-6c7a-47eb-7a12-08d757927f11
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB3101
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-23_02:2019-10-22,2019-10-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 spamscore=0 suspectscore=0 clxscore=1011 impostorscore=0 mlxscore=0
 phishscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910230083
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The iio_triggered_buffer_{predisable,postenable} functions attach/detach
poll functions.

The iio_triggered_buffer_postenable() should be called first to attach the
poll function, and then the driver can init the data to be triggered.

Similarly, iio_triggered_buffer_predisable() should be called last to first
disable the data (to be triggered) and then the poll function should be
detached.

For this driver, the predisable & postenable hooks are also need to take
into consideration the touchscreen, so the hooks need to be put in places
that avoid the code for that cares about it.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/adc/at91-sama5d2_adc.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index e1850f3d5cf3..ac3e5c4c9840 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -889,20 +889,24 @@ static int at91_adc_buffer_postenable(struct iio_dev *indio_dev)
 	if (!(indio_dev->currentmode & INDIO_ALL_TRIGGERED_MODES))
 		return -EINVAL;
 
+	ret = iio_triggered_buffer_postenable(indio_dev);
+	if (ret)
+		return ret;
+
 	/* we continue with the triggered buffer */
 	ret = at91_adc_dma_start(indio_dev);
 	if (ret) {
 		dev_err(&indio_dev->dev, "buffer postenable failed\n");
+		iio_triggered_buffer_predisable(indio_dev);
 		return ret;
 	}
 
-	return iio_triggered_buffer_postenable(indio_dev);
+	return 0;
 }
 
 static int at91_adc_buffer_predisable(struct iio_dev *indio_dev)
 {
 	struct at91_adc_state *st = iio_priv(indio_dev);
-	int ret;
 	u8 bit;
 
 	/* check if we are disabling triggered buffer or the touchscreen */
@@ -916,13 +920,8 @@ static int at91_adc_buffer_predisable(struct iio_dev *indio_dev)
 	if (!(indio_dev->currentmode & INDIO_ALL_TRIGGERED_MODES))
 		return -EINVAL;
 
-	/* continue with the triggered buffer */
-	ret = iio_triggered_buffer_predisable(indio_dev);
-	if (ret < 0)
-		dev_err(&indio_dev->dev, "buffer predisable failed\n");
-
 	if (!st->dma_st.dma_chan)
-		return ret;
+		goto out;
 
 	/* if we are using DMA we must clear registers and end DMA */
 	dmaengine_terminate_sync(st->dma_st.dma_chan);
@@ -949,7 +948,9 @@ static int at91_adc_buffer_predisable(struct iio_dev *indio_dev)
 
 	/* read overflow register to clear possible overflow status */
 	at91_adc_readl(st, AT91_SAMA5D2_OVER);
-	return ret;
+
+out:
+	return iio_triggered_buffer_predisable(indio_dev);
 }
 
 static const struct iio_buffer_setup_ops at91_buffer_setup_ops = {
-- 
2.20.1

