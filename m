Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 876E11263AC
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2019 14:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbfLSNhZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 19 Dec 2019 08:37:25 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:24354 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726695AbfLSNhZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 19 Dec 2019 08:37:25 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBJDRESu019117;
        Thu, 19 Dec 2019 08:36:59 -0500
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
        by mx0a-00128a01.pphosted.com with ESMTP id 2wvwhf4bfb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Dec 2019 08:36:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j1vWEK+EOTgW21KOAp71o8lTexYbh4PaFVb0tcqU6auN1cynItlMQiK8LHBXKRFxMYrPAB2SOURYn4Za5ejm1jjeDQDXsRNnYrOBTa0u7JLgMpBN0pYUBaNuhhYWYWQZ3Z/jLd2xjS6t2qglpFx0LAdEeCNXGMg4mu+wEx9Zpn8n0Xhqo1lL/kwpm/MnX1l4sPYnwIsWTwX32TRe/jJKBLtnwMLRM6UXHY8koe+UjgZYH3Io6ZfoBRWQzgu5GjURPDTGBQWBmIKmPv1AeAxB0YJts4IIvJj0Hk6USxCU4jXCsNZJE3YqEbMoSsCW7VH/j0rGOq7lC/5ovMSO5E7Kyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KS09WvRTzal4mK563IQ3LUdLp5Km03GEMlxRtTpVRYE=;
 b=iQB+osqWRS5L9/y2BIWkKa/ipChvTC/ej8s/mDW62++42xnCo4Q1WUvI67kGMlPducjX+gqMnqq1JA4u7zpnPiS0chcZUeap/x+C6lbgp4eHTpk65tw8XLg7eOydq+66EeNdHnVASg7JAu2FhtkPFrJIcUHCLjeUAzZdb0Cvcw+HXFj8PFIZ+2ZLJcc0nB12nBC+OxKIGX+cUBf3Vok/yA2M8AZADwvk+2xapHGGWi6Q5s4xjZkHXeS3SWXAevN8Guz2dkhEo417tMG9rgeb8Mqwg2VjqRLuy1vd44o0mkg0QI7M/1h+YdStnLKNU6ybvdBuZJ/zukFqkORaGRfGlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KS09WvRTzal4mK563IQ3LUdLp5Km03GEMlxRtTpVRYE=;
 b=h5g0Rq8V+vVh9tCoSa4wsM2CWT7/+3GbDoRK7rCW1T+8xAE/X1xj/CMgGBa5DzmUU9cPvXakg++eXo5MwZPxjGT7E5ie2BWwtVYI2CRZueWrytVrEf8wrUa/aX2VkorQo9ss9WA/dQNasNfT5ND3AFernqtQeWSKD60yD4/0kOk=
Received: from DM5PR2001CA0008.namprd20.prod.outlook.com (2603:10b6:4:16::18)
 by BN3PR03MB2243.namprd03.prod.outlook.com (2a01:111:e400:c5f0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.14; Thu, 19 Dec
 2019 13:36:57 +0000
Received: from CY1NAM02FT054.eop-nam02.prod.protection.outlook.com
 (2603:10b6:4:16:cafe::79) by DM5PR2001CA0008.outlook.office365.com
 (2603:10b6:4:16::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.14 via Frontend
 Transport; Thu, 19 Dec 2019 13:36:57 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 CY1NAM02FT054.mail.protection.outlook.com (10.152.74.100) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2559.14
 via Frontend Transport; Thu, 19 Dec 2019 13:36:56 +0000
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id xBJDasGP012792
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 19 Dec 2019 05:36:55 -0800
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Thu, 19 Dec
 2019 05:36:53 -0800
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 19 Dec 2019 05:36:52 -0800
Received: from ben-Latitude-E6540.ad.analog.com ([10.48.65.231])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id xBJDal8d000582;
        Thu, 19 Dec 2019 08:36:48 -0500
From:   Beniamin Bia <beniamin.bia@analog.com>
To:     <jic23@kernel.org>
CC:     <knaack.h@gmx.de>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Michael.Hennerich@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <biabeniamin@outlook.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Beniamin Bia <beniamin.bia@analog.com>
Subject: [PATCH 1/3] iio: frequency: adf4371: Create a power down/up function
Date:   Thu, 19 Dec 2019 15:37:53 +0200
Message-ID: <20191219133755.26109-1-beniamin.bia@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(396003)(39860400002)(199004)(189003)(2906002)(5660300002)(7696005)(356004)(6666004)(4326008)(186003)(44832011)(70206006)(316002)(107886003)(1076003)(336012)(26005)(36756003)(426003)(6916009)(7636002)(2616005)(8936002)(86362001)(8676002)(246002)(478600001)(70586007)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN3PR03MB2243;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d125a391-7fa3-44ba-ceda-08d784888478
X-MS-TrafficTypeDiagnostic: BN3PR03MB2243:
X-Microsoft-Antispam-PRVS: <BN3PR03MB2243760440D7F726405CB778F0520@BN3PR03MB2243.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 0256C18696
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GVx5dEyhPYT9lYR+GL+WtGDIdHJYh2k2GTVSPGu1YfJYfDjz7kCoFgVc/kh21cfvMfsRrLSLEA6bQBpiPLqRNj34DzVfA1QlySvOrrhS+coYOSUGumPt0RDA7+rU62hPV9I6ph26eB26KpTAkeR9ZbFgGlJVjp+Tj93vYyBTXRqWN1SXf3+D4fniUjPR55Qn/Ll1taFa0pvX1cnD0kQgeqXFpvV+YCh9lMiJCSI3J2N1YHR3IobksevRCV/TiypLQJOc4VJ/0Ex+yqfXYXf/Yls470XLvx07jy+XPeyo2j7Td5c3cBGDOeugIvf790txg2hmF6sR6brvNwj9ExFsHR/wTsgvLtUVcq2MAYQg3YXhUo/Z+O4IHLxeut7Jnnn5HfVFfunwyYruMgFVjY4uYFmXqDT8hjWnc09nDYti5mX32WiwLSv4O4hcnbcfvwed
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2019 13:36:56.7001
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d125a391-7fa3-44ba-ceda-08d784888478
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR03MB2243
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-19_01:2019-12-17,2019-12-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 suspectscore=1 phishscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 spamscore=0 mlxscore=0
 priorityscore=1501 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-1912190117
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Stefan Popa <stefan.popa@analog.com>

This patch creates a helper function which powers down/up the PLL output
channels. Currently, this function is called only once, but it will be
needed in future patches to support multiple features.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
---
 drivers/iio/frequency/adf4371.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/frequency/adf4371.c b/drivers/iio/frequency/adf4371.c
index ff82863cbf42..7d77ebdbea82 100644
--- a/drivers/iio/frequency/adf4371.c
+++ b/drivers/iio/frequency/adf4371.c
@@ -321,6 +321,24 @@ static int adf4371_set_freq(struct adf4371_state *st, unsigned long long freq,
 	return regmap_write(st->regmap, ADF4371_REG(0x10), st->integer & 0xFF);
 }
 
+static int adf4371_channel_power_down(struct adf4371_state *st,
+				      unsigned int channel, bool power_down)
+{
+	unsigned int bit, readval, reg;
+	int ret;
+
+	reg = adf4371_pwrdown_ch[channel].reg;
+	bit = adf4371_pwrdown_ch[channel].bit;
+	ret = regmap_read(st->regmap, reg, &readval);
+	if (ret < 0)
+		return ret;
+
+	readval &= ~BIT(bit);
+	readval |= (!power_down << bit);
+
+	return regmap_write(st->regmap, reg, readval);
+}
+
 static ssize_t adf4371_read(struct iio_dev *indio_dev,
 			    uintptr_t private,
 			    const struct iio_chan_spec *chan,
@@ -372,7 +390,6 @@ static ssize_t adf4371_write(struct iio_dev *indio_dev,
 	struct adf4371_state *st = iio_priv(indio_dev);
 	unsigned long long freq;
 	bool power_down;
-	unsigned int bit, readval, reg;
 	int ret;
 
 	mutex_lock(&st->lock);
@@ -389,16 +406,7 @@ static ssize_t adf4371_write(struct iio_dev *indio_dev,
 		if (ret)
 			break;
 
-		reg = adf4371_pwrdown_ch[chan->channel].reg;
-		bit = adf4371_pwrdown_ch[chan->channel].bit;
-		ret = regmap_read(st->regmap, reg, &readval);
-		if (ret < 0)
-			break;
-
-		readval &= ~BIT(bit);
-		readval |= (!power_down << bit);
-
-		ret = regmap_write(st->regmap, reg, readval);
+		ret = adf4371_channel_power_down(st, chan->channel, power_down);
 		break;
 	default:
 		ret = -EINVAL;
-- 
2.17.1

