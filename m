Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9B3D4E809
	for <lists+linux-iio@lfdr.de>; Fri, 21 Jun 2019 14:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfFUMcR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 21 Jun 2019 08:32:17 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:35588 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726852AbfFUMcR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 21 Jun 2019 08:32:17 -0400
X-Greylist: delayed 1056 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 Jun 2019 08:32:15 EDT
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5LCE90w017753;
        Fri, 21 Jun 2019 08:14:20 -0400
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2058.outbound.protection.outlook.com [104.47.45.58])
        by mx0b-00128a01.pphosted.com with ESMTP id 2t89773a3c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jun 2019 08:14:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FyYOHwacnFb0bb2EWuh1M1zyDXwWyxWNmbSJHKUuIBs=;
 b=L6PFeSyQNGsqm3VB4vMwKAIfZhG8/5T5ZgKmQJd2ap9N1/z7+iSdKXpHuw/kNu+YJ9MDV4AbafXLJT0e1e1xRlSiuDToYfH6zY+JChbMeYpDkdTsvWQPvvXN5pSpPy4QGpxOxqo3OR+5hBoNqq26q+GLXPLv8SR90cg9KCWBHDI=
Received: from BN6PR03CA0014.namprd03.prod.outlook.com (2603:10b6:404:23::24)
 by BY2PR03MB554.namprd03.prod.outlook.com (2a01:111:e400:2c38::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1987.15; Fri, 21 Jun
 2019 12:14:16 +0000
Received: from CY1NAM02FT054.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::205) by BN6PR03CA0014.outlook.office365.com
 (2603:10b6:404:23::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1987.13 via Frontend
 Transport; Fri, 21 Jun 2019 12:14:15 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 CY1NAM02FT054.mail.protection.outlook.com (10.152.74.100) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1987.11
 via Frontend Transport; Fri, 21 Jun 2019 12:14:14 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x5LCED3H023536
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 21 Jun 2019 05:14:13 -0700
Received: from mircea-Latitude-E6540.ad.analog.com (10.48.65.115) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Fri, 21 Jun 2019 08:14:13 -0400
From:   Mircea Caprioru <mircea.caprioru@analog.com>
To:     <jic23@kernel.org>
CC:     <Michael.Hennerich@analog.com>, <stefan.popa@analog.com>,
        <lars@metafoo.de>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
        Mircea Caprioru <mircea.caprioru@analog.com>
Subject: [PATCH V2 2/4] iio: adc: ad7124: Add buffered input support
Date:   Fri, 21 Jun 2019 15:13:42 +0300
Message-ID: <20190621121344.24917-2-mircea.caprioru@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190621121344.24917-1-mircea.caprioru@analog.com>
References: <20190621121344.24917-1-mircea.caprioru@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(396003)(376002)(346002)(39860400002)(2980300002)(54534003)(199004)(189003)(126002)(54906003)(486006)(336012)(446003)(16586007)(476003)(48376002)(8676002)(426003)(11346002)(2616005)(316002)(50466002)(6916009)(8936002)(246002)(106002)(86362001)(107886003)(50226002)(26005)(76176011)(5660300002)(51416003)(44832011)(7696005)(36756003)(305945005)(2906002)(70206006)(70586007)(47776003)(77096007)(1076003)(478600001)(7636002)(4326008)(186003)(356004)(6666004)(72206003)(2351001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR03MB554;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72820f01-48ac-49f8-0c81-08d6f641fa34
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:BY2PR03MB554;
X-MS-TrafficTypeDiagnostic: BY2PR03MB554:
X-Microsoft-Antispam-PRVS: <BY2PR03MB554F7EE4C61E203D267AF3981E70@BY2PR03MB554.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-Forefront-PRVS: 0075CB064E
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: OuiIKIW9fk9juKBNCjvB1FCHulOE9qsEUusfy8CeqoNTYTt2t5Eu1o3EAdJubBEdRUgxkPkabaLpFMltomoenfXnlpMAu0SdM0WzzXIMhEfEpU7eRz5ixvRN7g6yfPOtXDRvyhC/UN7EYjAF/MLqi17i51aiJWB5KInu4rG0ZoTo4blLmleujXMsl3kmauIgiKozCOf37zkBfycP09++RPO8qNLunYg0F1SxacvLJSyKIbQPFLc51lsk7GYVFthTewdzUmCZueZTXA6A+SDbpsr5QIJTEHZbkb3Ock7TsyCVZ8Yu4PifcVVhcEwUfWtRHbYK6AxmNuQLkyz3F3bE3HrxJzImITggbzvYBBGff0+U826Ul0d+3Ct85cq18FyZ5hduScQkQ4TriLiTxqorE0XBgcRyXPAUeck71B8iJpE=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2019 12:14:14.4902
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72820f01-48ac-49f8-0c81-08d6f641fa34
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR03MB554
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-21_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906210104
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

