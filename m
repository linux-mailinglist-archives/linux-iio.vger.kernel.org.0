Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C27AEFC287
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2019 10:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbfKNJY6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 14 Nov 2019 04:24:58 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:4508 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726000AbfKNJY6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 14 Nov 2019 04:24:58 -0500
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAE9D6Ll021810;
        Thu, 14 Nov 2019 04:24:42 -0500
Received: from nam05-co1-obe.outbound.protection.outlook.com (mail-co1nam05lp2059.outbound.protection.outlook.com [104.47.48.59])
        by mx0b-00128a01.pphosted.com with ESMTP id 2w7pr6p2r7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Nov 2019 04:24:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UgsTuBuuIABYjso1zPWOgf0ahwRftxkB+A3Xkyas91yrt0VYi0qAsczarFXhKE0DADhbNyANxtyGJ12g/g4EZNMvCGfBrr5ilGMox6I6DNkyvp0D5HtwVQuBbhxpcSUQWx4NfYL0G0bjDDWjicdPnMosk+ozDVY6WZ3YY9S2sRThEZ95Zw+i7m/d5+eSvwUqKg95T64Nwg8sEqyr/+l5/BNmPuXd1nuly+kt8APp6T9TdPjLOLSf0HyiJUoKyJ63rXkSJ+OSRnhhJX6G2745luuuCn1hqL/NtJFggVOLTw0JuKTEOiGhSjYdTe1eUbcZUnduLngrZG3WQk9TdNNv/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jog2xaRT5G0BUc0nVr50QPsWLs570j4XoNScteKxPro=;
 b=WxrdSogM+Y7f9IW2nZNQiz3rPULYFpujvWkGuKqri5mi5/A/kT/oaxDwN5QjMknoPR8eYGTUNx7iic+25vcCE7IwXioXSpCI3ThhwO1es4Dz+5wRxck/WB2Ei6/B4E6bVkDGGPp97aIsnA3SJIFq/szX0Ey54I4IeA17phFKj5ILBS+uIoqUETVJgUER1u/l45aDmggF8QNuwqwAwsCYUCECheCBlRKxgewVAbEO9ETyuQ2ReT0ZL7gYGmaI4YJ7KcYJwW3zMQQLBEAbY4PEqpZP3fiLNLsCz8OBgrREPXejxPwzziaeAoopyDkQn0HVKqeLz48LdaJ3wIFF8F7N+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=metafoo.de smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jog2xaRT5G0BUc0nVr50QPsWLs570j4XoNScteKxPro=;
 b=KEDpqlKvJiIGC7Yd8NHBhSCdmPzGctEdgeaW7LNbP7cahZ0qhKpsI1m2YqqtZAyJ94Jaw8Ha23OCd1PAL/ehGVzKUbFOK95zFmiiePAIrZ3UJb01FVf7pwu0kXi5xLoGOr7X7t/cffKSxUncGp1Up4AMYXOX16yUFtlZySEc6mA=
Received: from BN6PR03CA0109.namprd03.prod.outlook.com (2603:10b6:404:10::23)
 by MN2PR03MB4877.namprd03.prod.outlook.com (2603:10b6:208:aa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.25; Thu, 14 Nov
 2019 09:24:40 +0000
Received: from SN1NAM02FT020.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::207) by BN6PR03CA0109.outlook.office365.com
 (2603:10b6:404:10::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.23 via Frontend
 Transport; Thu, 14 Nov 2019 09:24:40 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 SN1NAM02FT020.mail.protection.outlook.com (10.152.72.139) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2451.23
 via Frontend Transport; Thu, 14 Nov 2019 09:24:39 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id xAE9OUrE019064
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 14 Nov 2019 01:24:30 -0800
Received: from mircea-Latitude-E6540.ad.analog.com (10.48.65.116) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Thu, 14 Nov 2019 04:24:38 -0500
From:   Mircea Caprioru <mircea.caprioru@analog.com>
To:     <jic23@kernel.org>
CC:     <Michael.Hennerich@analog.com>, <stefan.popa@analog.com>,
        <lars@metafoo.de>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        Mircea Caprioru <mircea.caprioru@analog.com>
Subject: [PATCH] iio: adc: ad7124: Enable internal reference
Date:   Thu, 14 Nov 2019 11:24:26 +0200
Message-ID: <20191114092426.21631-1-mircea.caprioru@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(136003)(39860400002)(189003)(199004)(50226002)(16586007)(54906003)(305945005)(7636002)(14444005)(106002)(5660300002)(4326008)(2351001)(478600001)(316002)(6916009)(70586007)(47776003)(1076003)(70206006)(51416003)(7696005)(86362001)(2906002)(486006)(426003)(126002)(476003)(26005)(2616005)(246002)(44832011)(186003)(48376002)(8676002)(36756003)(107886003)(336012)(50466002)(356004)(8936002)(6666004);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR03MB4877;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a8e9dec8-a03a-4e07-5f8a-08d768e479b8
X-MS-TrafficTypeDiagnostic: MN2PR03MB4877:
X-Microsoft-Antispam-PRVS: <MN2PR03MB487721904832D6965664765681710@MN2PR03MB4877.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:989;
X-Forefront-PRVS: 02213C82F8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B0rxkOc8JfaXvy+Z8EXpHRgiLDChimMGdZyuIjPHfkWToaggqHNcXGRjrupkkIfDaeB/l8YcoU05XL/vpw8/2GZYR8vo6L+EhiDznadC9iphqG2ttm5DwN6IZMUGjaj43UEOjGshncAca2wgJlKnuLXRvtfRCiP6dGsP96EFZXDwo/DOJKfBzZD14phtfxISg8qYy5h/tvGOS4hNL26pE6mlcnNLyuTt4iULpOvvAqOoNeMYGgXUnKKNbEMSFR+bSFn+pndy171e2hAGMVU15SWGh/rgl7HE17gRe8D5vfSYgPnKA5JS56TqIZF7/4/xgap71CrNc1xh1fInmZmEqxvZIc5RjtMkoj+vQZ8NGpNf2yqQgeeqbBMR+xJ9760MHP1U7Oj3clqkcq7BZMpz2rxxucQjvXzEkCDGffoVUt6xd8aw/4yuKNTtbdkzjnAB
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2019 09:24:39.8981
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8e9dec8-a03a-4e07-5f8a-08d768e479b8
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB4877
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-14_01:2019-11-13,2019-11-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 priorityscore=1501 suspectscore=1 phishscore=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=807 malwarescore=0 adultscore=0
 impostorscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-1911140086
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

When the internal reference was selected by a channel it was not enabled.
This patch fixes that and enables it.

Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
---
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

