Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C208550441
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2019 10:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbfFXIJi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 24 Jun 2019 04:09:38 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:26084 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726481AbfFXIJi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 Jun 2019 04:09:38 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5O88OsK025039;
        Mon, 24 Jun 2019 04:09:18 -0400
Received: from nam05-by2-obe.outbound.protection.outlook.com (mail-by2nam05lp2058.outbound.protection.outlook.com [104.47.50.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 2t9h86cqsf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 24 Jun 2019 04:09:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XNYzvT/mGJb3/s5VvR0c7fd4Un94IaKTvvKGGRqzskY=;
 b=FfEQs9q7y5cWjTGa7TTKQmk0wc5c7sEh+n9tjNcRxt+WwnWJr/80XZf5bWE1F1jpoHh8IxA9vWnmyWCNh/RmFInlFKP9+Sr0REIHhlN8A/WMSbOkGvrX+uo/4aSTd0jKqTcshRyEL42bq02F8l1xdzT83NjSpEBi9bjfDBHecc0=
Received: from BY5PR03CA0015.namprd03.prod.outlook.com (2603:10b6:a03:1e0::25)
 by BN6PR03MB3122.namprd03.prod.outlook.com (2603:10b6:405:3c::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2008.16; Mon, 24 Jun
 2019 08:09:16 +0000
Received: from BL2NAM02FT014.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::209) by BY5PR03CA0015.outlook.office365.com
 (2603:10b6:a03:1e0::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1987.16 via Frontend
 Transport; Mon, 24 Jun 2019 08:09:15 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2NAM02FT014.mail.protection.outlook.com (10.152.76.154) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1987.11
 via Frontend Transport; Mon, 24 Jun 2019 08:09:15 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x5O89Fn1019154
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 24 Jun 2019 01:09:15 -0700
Received: from mircea-Latitude-E6540.ad.analog.com (10.48.65.115) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Mon, 24 Jun 2019 04:09:14 -0400
From:   Mircea Caprioru <mircea.caprioru@analog.com>
To:     <jic23@kernel.org>
CC:     <Michael.Hennerich@analog.com>, <stefan.popa@analog.com>,
        <lars@metafoo.de>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
        Mircea Caprioru <mircea.caprioru@analog.com>
Subject: [PATCH V3 2/5] iio: adc: ad7124: Add buffered input support
Date:   Mon, 24 Jun 2019 11:08:42 +0300
Message-ID: <20190624080845.18537-2-mircea.caprioru@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190624080845.18537-1-mircea.caprioru@analog.com>
References: <20190624080845.18537-1-mircea.caprioru@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(346002)(396003)(136003)(376002)(2980300002)(54534003)(189003)(199004)(48376002)(478600001)(7696005)(51416003)(50226002)(8676002)(6916009)(72206003)(54906003)(4326008)(316002)(36756003)(11346002)(8936002)(7636002)(106002)(47776003)(26005)(186003)(16586007)(77096007)(50466002)(86362001)(76176011)(107886003)(44832011)(1076003)(5660300002)(305945005)(2351001)(126002)(426003)(2616005)(336012)(476003)(486006)(446003)(70206006)(70586007)(2906002)(356004)(6666004)(246002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB3122;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15341d5d-a136-4c00-bb80-08d6f87b3fc1
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:BN6PR03MB3122;
X-MS-TrafficTypeDiagnostic: BN6PR03MB3122:
X-Microsoft-Antispam-PRVS: <BN6PR03MB31221677E2B6D9683775741981E00@BN6PR03MB3122.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-Forefront-PRVS: 007814487B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: zlts/OnNcd8PQlBAMPZQNWgXuQ69FhJlCORVLlgG9mMslCs/qP+R8oAb3SiMdMR/E/G7s49JXmOz0I5iJZDtKVlv8cZFNK0elUQ2tPpjRJ+enevjlKW3oLzpdvRCQh2jhyuOS9dy5847E8jg1LIUXE6W1r+nZ56R8X3EE+0zeEicItHyjMDsKT0otQdsV973J44ZI3DlI4XWwTNctxZ+I6HK8Rs3evxK9sjN+wtRA8K4EuxefeQJSyrIE2Kb0k8qS2/XfZuVBTUTfjP/++t4GF4zty4tCz1nEKs20OGrjppajT1wrTlmcctiEv3ZdASuPkXAZisV/m0anFIUBrZG2owsXsAfqHwZMnuiW5l00RJ/77SXOSK5qAPozDB/gWIdbF9t9qodpISrJXuM99JSGWsjylPKzTq0Q+YwieKQgR0=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2019 08:09:15.2829
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15341d5d-a136-4c00-bb80-08d6f87b3fc1
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB3122
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-24_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906240068
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch adds the option to enable the buffered mode for positive and
negative inputs. Each option can be enabled independently.

In buffered mode, the input channel feeds into a high impedance input stage
of the buffer amplifier. Therefore, the input can tolerate significant
source impedances and is tailored for direct connection to external
resistive type sensors such as strain gages or RTDs.

Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
---

Changelog v2:
- nothing changed here

Changelog v3:
- nothing changed here

 drivers/iio/adc/ad7124.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 810234db9c0d..ab52c5e9ecb1 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -61,6 +61,8 @@
 #define AD7124_CONFIG_REF_SEL(x)	FIELD_PREP(AD7124_CONFIG_REF_SEL_MSK, x)
 #define AD7124_CONFIG_PGA_MSK		GENMASK(2, 0)
 #define AD7124_CONFIG_PGA(x)		FIELD_PREP(AD7124_CONFIG_PGA_MSK, x)
+#define AD7124_CONFIG_IN_BUFF_MSK	GENMASK(7, 6)
+#define AD7124_CONFIG_IN_BUFF(x)	FIELD_PREP(AD7124_CONFIG_IN_BUFF_MSK, x)
 
 /* AD7124_FILTER_X */
 #define AD7124_FILTER_FS_MSK		GENMASK(10, 0)
@@ -108,6 +110,8 @@ struct ad7124_chip_info {
 struct ad7124_channel_config {
 	enum ad7124_ref_sel refsel;
 	bool bipolar;
+	bool buf_positive;
+	bool buf_negative;
 	unsigned int ain;
 	unsigned int vref_mv;
 	unsigned int pga_bits;
@@ -473,6 +477,11 @@ static int ad7124_of_parse_channel_config(struct iio_dev *indio_dev,
 		else
 			st->channel_config[channel].refsel = tmp;
 
+		st->channel_config[channel].buf_positive =
+			of_property_read_bool(child, "adi,buffered-positive");
+		st->channel_config[channel].buf_negative =
+			of_property_read_bool(child, "adi,buffered-negative");
+
 		*chan = ad7124_channel_template;
 		chan->address = channel;
 		chan->scan_index = channel;
@@ -492,7 +501,7 @@ static int ad7124_of_parse_channel_config(struct iio_dev *indio_dev,
 static int ad7124_setup(struct ad7124_state *st)
 {
 	unsigned int val, fclk, power_mode;
-	int i, ret;
+	int i, ret, tmp;
 
 	fclk = clk_get_rate(st->mclk);
 	if (!fclk)
@@ -525,8 +534,12 @@ static int ad7124_setup(struct ad7124_state *st)
 		if (ret < 0)
 			return ret;
 
+		tmp = (st->channel_config[i].buf_positive << 1)  +
+			st->channel_config[i].buf_negative;
+
 		val = AD7124_CONFIG_BIPOLAR(st->channel_config[i].bipolar) |
-		      AD7124_CONFIG_REF_SEL(st->channel_config[i].refsel);
+		      AD7124_CONFIG_REF_SEL(st->channel_config[i].refsel) |
+		      AD7124_CONFIG_IN_BUFF(tmp);
 		ret = ad_sd_write_reg(&st->sd, AD7124_CONFIG(i), 2, val);
 		if (ret < 0)
 			return ret;
-- 
2.17.1

