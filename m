Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C282F100091
	for <lists+linux-iio@lfdr.de>; Mon, 18 Nov 2019 09:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfKRIja (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 Nov 2019 03:39:30 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:11804 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726539AbfKRIj3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Nov 2019 03:39:29 -0500
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAI8bvQu010443;
        Mon, 18 Nov 2019 03:39:12 -0500
Received: from nam01-bn3-obe.outbound.protection.outlook.com (mail-bn3nam01lp2053.outbound.protection.outlook.com [104.47.33.53])
        by mx0b-00128a01.pphosted.com with ESMTP id 2waem7yagm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Nov 2019 03:39:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MblYsopDGVDeO8VJAAn88QjST6LiMJ+S8YsPlSvBjFF13fxTKq3gQayF6UPbWOSafgmpKHxubryzfB3VROE3gGZxNpmlv7SDzqarJ7XNwiZnlH15skX+7dXTCVyBUz9n+ufTk8fpR7Yk2MjMlsp4KUXBuQ527UJCpCDTfMm0mSJlgdRmLw+cLXD1cx3lXUCYeAFh8y3lnTmkJoA9lHbeMcSphCDGzmJRSGc1A4TpxiTYv22H+8ULQ9p3eXZBSwMV9ap6PJuXcKhCDBtf8f7e9QVuo/XWYREmHQMwa1VMgf5ZRTXlitXYF94gUEQINX9b/kwWF58zym4lgvzV+FWAGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rrbPUvZ3d4gJcAGfe5ml3BzB4H/9IYP2IwwtHF4DUYw=;
 b=EgGhctizaiO5oYno4WYJiv+oMxtevLjbyWtNLK9xYP2T4kDpsv0m23Vng/KJdG1/gf6BA/0sGKXUp0+hxoQw3AaKN7h3mWC+e/khlo07qkwJSYRehQmvJ6vVfCJS+pdIiAiitIslxPeaW2umSFNYgQ6ZQuiSGagZnvuv3lMlZBXqHrhNtgaI3WDZ5DGc30lNMtyDLAVq/CDUPSp7Owri5IZMjYG6B3UDK0MBUGwR1YjfDYU8zB1IieZhi6lhTPb/8yp3QhfLxGP4vukdPHOgQn6pPt1phJyuzHjGtEqBTsahpe4f2CLv6/FmNtwAnH7TfzszP9PsRZES7hbHX8zbFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=metafoo.de smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rrbPUvZ3d4gJcAGfe5ml3BzB4H/9IYP2IwwtHF4DUYw=;
 b=SdhMsyFpFOJ3ieuQVbe+U1yQOnZK0CnoZzyhVezRsBYUvEfqL2RPlb+xpPe1/tLqKrLZqIf4BkRxx7WGFaJEaBookUvzN1wc7dSi2GFAbCcoa7WkIUpTrQ/Y9Fx0fUxljw6CxVsqYm8PpAnV4oxJhtcJgyKyMD9zBZIor6xNydE=
Received: from DM6PR03CA0003.namprd03.prod.outlook.com (2603:10b6:5:40::16) by
 CO2PR03MB2231.namprd03.prod.outlook.com (2603:10b6:102:8::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.28; Mon, 18 Nov 2019 08:39:09 +0000
Received: from CY1NAM02FT007.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::207) by DM6PR03CA0003.outlook.office365.com
 (2603:10b6:5:40::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2451.23 via Frontend
 Transport; Mon, 18 Nov 2019 08:39:09 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 CY1NAM02FT007.mail.protection.outlook.com (10.152.75.5) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2451.23
 via Frontend Transport; Mon, 18 Nov 2019 08:39:08 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id xAI8cwRX012689
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 18 Nov 2019 00:38:58 -0800
Received: from mircea-Latitude-E6540.ad.analog.com (10.48.65.118) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Mon, 18 Nov 2019 03:39:06 -0500
From:   Mircea Caprioru <mircea.caprioru@analog.com>
To:     <jic23@kernel.org>
CC:     <Michael.Hennerich@analog.com>, <stefan.popa@analog.com>,
        <lars@metafoo.de>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        Mircea Caprioru <mircea.caprioru@analog.com>
Subject: [PATCH V2] iio: adc: ad7124: Enable internal reference
Date:   Mon, 18 Nov 2019 10:38:57 +0200
Message-ID: <20191118083857.1754-1-mircea.caprioru@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(376002)(136003)(346002)(54534003)(199004)(189003)(16586007)(316002)(51416003)(186003)(8936002)(5660300002)(486006)(107886003)(2616005)(126002)(6666004)(356004)(476003)(2906002)(44832011)(36756003)(50226002)(7696005)(54906003)(2351001)(305945005)(7636002)(26005)(4326008)(14444005)(6916009)(47776003)(478600001)(106002)(336012)(86362001)(48376002)(1076003)(8676002)(50466002)(246002)(426003)(70206006)(70586007);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR03MB2231;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cdb827e4-6504-4d49-67c7-08d76c02c720
X-MS-TrafficTypeDiagnostic: CO2PR03MB2231:
X-Microsoft-Antispam-PRVS: <CO2PR03MB2231F9ABA44760D2AA985A05814D0@CO2PR03MB2231.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:304;
X-Forefront-PRVS: 0225B0D5BC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w3MrmCgW+Q2bN8bvE81/mtBsIGh+I+03eOVJQMbM7zKvVUeZKHussdWH8qdCX4ZCtfF9+uTlQzjuQxV2nTMY0ks1ywJP3JTWlZZmbzXcJwCuhIpnt/M7Ws6WSB2lteKdoMyk6lBJ3aPfOGj3LQiFLd6a/tpns5wXp56TGULeOGMhr1FBcD8xnVlhLQTdgf3OzE1BL7kea/Ki8bo3KsDTkC0H7lfpgjEQb9B/7RC/hWK0g86abr44FQt6lmXPrnppTcJkSZtQZWN//U842E24//cUhmclKMW4FtTOQXKIXNKGKjr7QE171Qdm3HLD6kqugjLBnPjE2o5S73QORlAF+pEooikmBPMS55eQ0butd6GZfgFZkmUlbqJrXwKIC5l3Z2D1wzBBGH4XN1zAXVAqHGBXLotWH+FFstn74E9C5+71gi40CJHSoak9TLvsKKon
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2019 08:39:08.1297
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cdb827e4-6504-4d49-67c7-08d76c02c720
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR03MB2231
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-18_01:2019-11-15,2019-11-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=1
 mlxlogscore=843 clxscore=1015 mlxscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 bulkscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1911180078
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

When the internal reference was selected by a channel it was not enabled.
This patch fixes that and enables it.

Fixes: b3af341bbd96 ("iio: adc: Add ad7124 support")
Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
---

Changelog V2:
- add fixes tag in commit message

 drivers/iio/adc/ad7124.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index edc6f1cc90b2..3f03abf100b5 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -39,6 +39,8 @@
 #define AD7124_STATUS_POR_FLAG_MSK	BIT(4)
 
 /* AD7124_ADC_CONTROL */
+#define AD7124_ADC_CTRL_REF_EN_MSK	BIT(8)
+#define AD7124_ADC_CTRL_REF_EN(x)	FIELD_PREP(AD7124_ADC_CTRL_REF_EN_MSK, x)
 #define AD7124_ADC_CTRL_PWR_MSK	GENMASK(7, 6)
 #define AD7124_ADC_CTRL_PWR(x)		FIELD_PREP(AD7124_ADC_CTRL_PWR_MSK, x)
 #define AD7124_ADC_CTRL_MODE_MSK	GENMASK(5, 2)
@@ -424,7 +426,10 @@ static int ad7124_init_channel_vref(struct ad7124_state *st,
 		break;
 	case AD7124_INT_REF:
 		st->channel_config[channel_number].vref_mv = 2500;
-		break;
+		st->adc_control &= ~AD7124_ADC_CTRL_REF_EN_MSK;
+		st->adc_control |= AD7124_ADC_CTRL_REF_EN(1);
+		return ad_sd_write_reg(&st->sd, AD7124_ADC_CONTROL,
+				      2, st->adc_control);
 	default:
 		dev_err(&st->sd.spi->dev, "Invalid reference %d\n", refsel);
 		return -EINVAL;
-- 
2.17.1

