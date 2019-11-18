Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1852A1003AD
	for <lists+linux-iio@lfdr.de>; Mon, 18 Nov 2019 12:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbfKRLUO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 Nov 2019 06:20:14 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:34170 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726518AbfKRLUO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Nov 2019 06:20:14 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAIBIHC4003081;
        Mon, 18 Nov 2019 06:19:55 -0500
Received: from nam05-dm3-obe.outbound.protection.outlook.com (mail-dm3nam05lp2058.outbound.protection.outlook.com [104.47.49.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 2wabu77328-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Nov 2019 06:19:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BZhxJ70C2zeeoQ6dez21YjWxrKPAkdR1umifp+mG1CEW9ebDFYMSXVjnHGt4UhRWKKt5Q1euGbzJcqOOkT6nqWkMT9aY4K66UByw4LXKdI9Dk7lPAyQminS5Ds4SVkw9cpLoJL/fj6XftoRmOuSySN/85AmSZGe3oNqLCqkfWMoHZgnAtanE8rmrR+D/ivAmWn9b5wEA7hXUxjA0iSNLWZPrSgdNd7fWH4GsFMSQGjmhR8kYex+idRzt9IOb92FmXgVn4RqYVKBqsV0kmZBI/Jiw6LjEaWUKlr79uWMtGietmmUD0wRYgpFfdhUIwCP4OSQL/a/XhZS+cgcGP1C4ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NpAsQP42R4QbkrMtfEdrFUVfFXyoEQSJFIYpMYpVfrI=;
 b=jfwxSD8jdkAm5xQFrgTt4BKMVzUy2zSW6zvZCHQfZ2kQbEiobE+ruUfVNR/ftVlvkEl3CFVpvyAa3TTM+aB0ARYxaB+1RC7grch01xvGlnva+bhb6yC6br3UJ8i6x5yMLl6oCgcGF6fqEpV7ggjkmi/4l31az5JQBCdalydA2MeLo1XT/r4djO2ENJWe/OaPKqXSyXdCw/IDLjGSw1KTu4vRBH7A1rPleFtTndf2XjeLc1ZcWLNxXWMTIKJsiXnQbCd9qdTnnsDlZISKZzT9peKq0yq9/0iR4CwAEz524bf7M4M5TtJxwpxPr9QNKeaHybXj2rsWSJcXFigizEiclA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=metafoo.de smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NpAsQP42R4QbkrMtfEdrFUVfFXyoEQSJFIYpMYpVfrI=;
 b=62hyIgPEkOP8va2jPkFBkvmfr4i9NF3dV6jQotOXnYuavIc7rTdzwUs7Kh5BunvHS0MZfYWOsyWFqmdp/eWNYptiblPfa66uzTra+1Ks9KeLTlFpqBvWqI70LcMJSsc4420oM0XYxJHNsiZK+Lr+ClL0P04MZAsEPEsMpXKnVlE=
Received: from DM3PR03CA0022.namprd03.prod.outlook.com (2603:10b6:0:50::32) by
 DM6PR03MB5129.namprd03.prod.outlook.com (2603:10b6:5:1eb::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Mon, 18 Nov 2019 11:19:53 +0000
Received: from SN1NAM02FT031.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::202) by DM3PR03CA0022.outlook.office365.com
 (2603:10b6:0:50::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2451.22 via Frontend
 Transport; Mon, 18 Nov 2019 11:19:52 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 SN1NAM02FT031.mail.protection.outlook.com (10.152.72.116) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2451.23
 via Frontend Transport; Mon, 18 Nov 2019 11:19:52 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id xAIBJpaR014315
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 18 Nov 2019 03:19:51 -0800
Received: from mircea-Latitude-E6540.ad.analog.com (10.48.65.118) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Mon, 18 Nov 2019 06:19:51 -0500
From:   Mircea Caprioru <mircea.caprioru@analog.com>
To:     <jic23@kernel.org>
CC:     <Michael.Hennerich@analog.com>, <stefan.popa@analog.com>,
        <lars@metafoo.de>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        Mircea Caprioru <mircea.caprioru@analog.com>
Subject: [PATCH V3] iio: adc: ad7124: Fix enabling of internal reference
Date:   Mon, 18 Nov 2019 13:19:48 +0200
Message-ID: <20191118111948.7414-1-mircea.caprioru@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(136003)(39860400002)(199004)(189003)(54534003)(336012)(426003)(2906002)(1076003)(44832011)(478600001)(14444005)(486006)(126002)(4326008)(316002)(16586007)(54906003)(6916009)(107886003)(476003)(106002)(86362001)(48376002)(36756003)(356004)(50466002)(8936002)(70586007)(2351001)(6666004)(26005)(246002)(2616005)(7696005)(186003)(47776003)(8676002)(7636002)(50226002)(70206006)(5660300002)(51416003)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB5129;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 34456e84-52fa-4848-a925-08d76c193b8f
X-MS-TrafficTypeDiagnostic: DM6PR03MB5129:
X-Microsoft-Antispam-PRVS: <DM6PR03MB51298AA1A6FA200E3F97E0BD814D0@DM6PR03MB5129.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 0225B0D5BC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Uvz/9P0IU8pGSmpd2ZFFU6w0RzogkEC4zaVKDDnAFcD/PW+EZIeQhnsNefbVI1YMDgf+VUJsXtdbNwRQgxucUR5yRGbXoRASNuVtoOy8q2GUsXWGcGxIdiNvaFYiJTIWI2AZnD9l2y61zvprtAZ8W7eGhuFQWaFM2BKrGT+fEE9WB8BjUTjXEHgF48KyDDZOq8StK3EqLgcSw1gGrMR8MO9mjB01YXmdd3q3RLJbjhbxq8DHRJxkL+nAaxDJDYAmJXsSf3tgI4SeayyhhMA74aGaMnc8Php7LbotP9F6ld/VkQtSPsFdreNaULBvt6tiu2Wgd+gLtYsJtI2CuVHSVAlwspKZCtVrSP7+r0cCwFFkW4b3YLIo5I827KLmdoGVo6a4lMEsJWsouiuAXoiyafV1ugDvzsaxe4ODFWkXn2jsAVHryD+7y9oKAzMKpPp3
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2019 11:19:52.4316
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34456e84-52fa-4848-a925-08d76c193b8f
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5129
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-18_02:2019-11-15,2019-11-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 spamscore=0 adultscore=0 clxscore=1015 mlxlogscore=848
 bulkscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=1 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911180103
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

When the internal reference was selected by a channel it was not enabled.
This patch fixes that and enables it.

Fixes: b3af341bbd96 ("iio: adc: Add ad7124 support")
Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
---

Changelog v3:
- mark this as a fix in the patch title

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

