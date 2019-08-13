Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0018F8B1BE
	for <lists+linux-iio@lfdr.de>; Tue, 13 Aug 2019 09:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbfHMH4W (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 13 Aug 2019 03:56:22 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:37750 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728037AbfHMH4P (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 13 Aug 2019 03:56:15 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7D7r1JU016086;
        Tue, 13 Aug 2019 03:55:52 -0400
Received: from nam05-by2-obe.outbound.protection.outlook.com (mail-by2nam05lp2058.outbound.protection.outlook.com [104.47.50.58])
        by mx0b-00128a01.pphosted.com with ESMTP id 2u9qpays6u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 13 Aug 2019 03:55:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FfYZ515rYwcNFwmg8CENhva5P4tHH8hU4k0P1eHVbwKbslHSJvU6L53FB5L+nXxpMSzzO00D5xOC8tUwiE+1D05z7L0htlIuvBWbEEYhae3jzEEiLeBPlW/sK7qtYuXaWOIT1dTlRBVflv6eCCAgjSJNzz341kX2++xUT54ovnQZ1uMe04tYPqxamHkyqjkqe2KB5Urp3MMcmgjAiVXSyCNZFJT8MHukiYQ7MvU5F7MqR2HluE8R0QHm3d4oPBEU/6Qxp33eVL/JBoXqfoLjoMDJdd4rr910jTKCtBPaBUip/082tS1rfNnB0WqA8E0E2P9hoVg4u4+J+GwJ5kcxwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zy5R3FkK2+E/66ao83zPCsbLM/5pSJD48hIFeWNZ31w=;
 b=jzEXa9/jflVtmhXJg6tYLgfLC/0B7mPns5giXpv1xlfERFOCXXBbPj4B03brwzEabh8W8sEoY9/DRNnTFGJgYYaf/6OTSAN7p8X16Qk3mDXZO0fgqwtGnsOWmDmh6r+aVKCmZhSgtzhf8cza83BrLo1PmOqDJDptelMvqA2JZPSN9EhIGtlUH7Rvnv4EGv51k6UHmRKWsI9V44q736w4vpwddpHFf7j5FANOAi747+otax67xLUYa2M1xW4Zutu3zXk0YvYuywZldXmMqo3IcaaoWqXioE4Fm2iTpS/V0j2Lc5RPNUF8ph8cWz2k5h48779JjZ5Zbx2CyzkD9Nh0iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.55) smtp.rcpttodomain=metafoo.de smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zy5R3FkK2+E/66ao83zPCsbLM/5pSJD48hIFeWNZ31w=;
 b=tGjLn0Eax7zvuk/lqxh5etAkvktfmCk20pDPFw4OoR///RpizkL/1n6Im2x0ER0OopOvemlzu7cUt95/JFiB9WKKKrxeLEvtNsk7mDP4/PEz5vkCOlJBm4zqItroLY7e970aDte4laZLm0jHqYl2X17ZTLpFC8CExScWxbhgHPc=
Received: from BYAPR03CA0011.namprd03.prod.outlook.com (2603:10b6:a02:a8::24)
 by DM5PR03MB2633.namprd03.prod.outlook.com (2603:10b6:3:47::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2157.15; Tue, 13 Aug
 2019 07:55:49 +0000
Received: from BL2NAM02FT061.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::206) by BYAPR03CA0011.outlook.office365.com
 (2603:10b6:a02:a8::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2157.15 via Frontend
 Transport; Tue, 13 Aug 2019 07:55:49 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BL2NAM02FT061.mail.protection.outlook.com (10.152.77.7) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2157.15
 via Frontend Transport; Tue, 13 Aug 2019 07:55:48 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id x7D7tjmD015992
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 13 Aug 2019 00:55:45 -0700
Received: from mircea-Latitude-E6540.ad.analog.com (10.48.65.115) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Tue, 13 Aug 2019 03:55:48 -0400
From:   Mircea Caprioru <mircea.caprioru@analog.com>
To:     <jic23@kernel.org>
CC:     <Michael.Hennerich@analog.com>, <stefan.popa@analog.com>,
        <lars@metafoo.de>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
        Mircea Caprioru <mircea.caprioru@analog.com>
Subject: [PATCH V2 1/4] staging: iio: adc: ad7192: Add low_pass_3db_filter_frequency
Date:   Tue, 13 Aug 2019 10:55:41 +0300
Message-ID: <20190813075544.9122-1-mircea.caprioru@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(136003)(396003)(2980300002)(199004)(189003)(54534003)(2351001)(106002)(8676002)(246002)(6916009)(316002)(47776003)(4326008)(476003)(186003)(48376002)(2616005)(16586007)(7636002)(1076003)(26005)(305945005)(7696005)(86362001)(54906003)(51416003)(44832011)(478600001)(70586007)(36756003)(70206006)(14444005)(2906002)(336012)(426003)(126002)(5660300002)(50466002)(50226002)(107886003)(6666004)(356004)(8936002)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR03MB2633;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9e5343a-d080-43a7-2708-08d71fc3a7d2
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:DM5PR03MB2633;
X-MS-TrafficTypeDiagnostic: DM5PR03MB2633:
X-Microsoft-Antispam-PRVS: <DM5PR03MB2633A2418B31A0598FED3B0C81D20@DM5PR03MB2633.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 01283822F8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: vDRaFI1s/41Fe8fDW8ZUIjp+qIvlsFrZlzU3KCAKJBBp5/OMXrzCEPZVKpf91bWLoyxN9yB/6EXNBm02lLJO83jXqGENkYsT8UWJeuQIsDDUa0fls/foRVCphp05UOmre30EbAK4I2IS/vC4Ra96djxzf32f1vnC8/n5bBrRCF/Brh+ci3Pi1JwyDpK7oXR8IolAUifQGrGC3YVCBW1aNdzEQSQf0rZAwaXMAvRwXgABT2oSD+bzfoqKJMMoZEBYd+GdrhHLvAXzPuK8R09ModRWCeGgx7J49wzf8L+s4uTGGr5Fp/wzsTKvbFz+pCBFMcyT8/+lazu2G1A+Ip2jnet585cHY18oAWQJJKIr1lsjnsWTrC/Vp5hvWpZDFw1rAooTy9sc17MN93pOlVWA5H8njNZGiUgeFmnFtSJ5waI=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2019 07:55:48.9895
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9e5343a-d080-43a7-2708-08d71fc3a7d2
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB2633
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-13_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908130087
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

By adding this option we are able to remove the sync3 field and dt binding.
When setting the required cutoff frequency we also determine the ADC
configuration for chop and sync filter.

Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
---
Changelog V2:
- no changes here

 drivers/staging/iio/adc/ad7192.c | 148 +++++++++++++++++++++++++++----
 1 file changed, 132 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index 81ea2639c67c..d58ce08f3693 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -143,6 +143,10 @@
 #define AD7192_EXT_FREQ_MHZ_MAX	5120000
 #define AD7192_INT_FREQ_MHZ	4915200
 
+#define AD7192_NO_SYNC_FILTER	1
+#define AD7192_SYNC3_FILTER	3
+#define AD7192_SYNC4_FILTER	4
+
 /* NOTE:
  * The AD7190/2/5 features a dual use data out ready DOUT/RDY output.
  * In order to avoid contentions on the SPI bus, it's therefore necessary
@@ -250,7 +254,7 @@ static int ad7192_of_clock_select(struct ad7192_state *st)
 static int ad7192_setup(struct ad7192_state *st, struct device_node *np)
 {
 	struct iio_dev *indio_dev = spi_get_drvdata(st->sd.spi);
-	bool rej60_en, sinc3_en, refin2_en, chop_en;
+	bool rej60_en, refin2_en;
 	bool buf_en, bipolar, burnout_curr_en;
 	unsigned long long scale_uv;
 	int i, ret, id;
@@ -282,24 +286,12 @@ static int ad7192_setup(struct ad7192_state *st, struct device_node *np)
 	if (rej60_en)
 		st->mode |= AD7192_MODE_REJ60;
 
-	sinc3_en = of_property_read_bool(np, "adi,sinc3-filter-enable");
-	if (sinc3_en)
-		st->mode |= AD7192_MODE_SINC3;
-
 	refin2_en = of_property_read_bool(np, "adi,refin2-pins-enable");
 	if (refin2_en && st->devid != ID_AD7195)
 		st->conf |= AD7192_CONF_REFSEL;
 
-	chop_en = of_property_read_bool(np, "adi,chop-enable");
-	if (chop_en) {
-		st->conf |= AD7192_CONF_CHOP;
-		if (sinc3_en)
-			st->f_order = 3; /* SINC 3rd order */
-		else
-			st->f_order = 4; /* SINC 4th order */
-	} else {
-		st->f_order = 1;
-	}
+	st->conf &= ~AD7192_CONF_CHOP;
+	st->f_order = AD7192_NO_SYNC_FILTER;
 
 	buf_en = of_property_read_bool(np, "adi,buffer-enable");
 	if (buf_en)
@@ -311,7 +303,7 @@ static int ad7192_setup(struct ad7192_state *st, struct device_node *np)
 
 	burnout_curr_en = of_property_read_bool(np,
 						"adi,burnout-currents-enable");
-	if (burnout_curr_en && buf_en && !chop_en) {
+	if (burnout_curr_en && buf_en) {
 		st->conf |= AD7192_CONF_BURN;
 	} else if (burnout_curr_en) {
 		dev_warn(&st->sd.spi->dev,
@@ -409,6 +401,49 @@ static ssize_t ad7192_set(struct device *dev,
 	return ret ? ret : len;
 }
 
+static void ad7192_get_available_filter_freq(struct ad7192_state *st,
+						    int *freq)
+{
+	unsigned int fadc;
+
+	/* Formulas for filter at page 25 of the datasheet */
+	fadc = DIV_ROUND_CLOSEST(st->fclk,
+				 AD7192_SYNC4_FILTER * AD7192_MODE_RATE(st->mode));
+	freq[0] = DIV_ROUND_CLOSEST(fadc * 240, 1024);
+
+	fadc = DIV_ROUND_CLOSEST(st->fclk,
+				 AD7192_SYNC3_FILTER * AD7192_MODE_RATE(st->mode));
+	freq[1] = DIV_ROUND_CLOSEST(fadc * 240, 1024);
+
+	fadc = DIV_ROUND_CLOSEST(st->fclk, AD7192_MODE_RATE(st->mode));
+	freq[2] = DIV_ROUND_CLOSEST(fadc * 230, 1024);
+	freq[3] = DIV_ROUND_CLOSEST(fadc * 272, 1024);
+}
+
+static int ad7192_show_filter_avail(struct device *dev,
+				    struct device_attribute *attr,
+				    char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct ad7192_state *st = iio_priv(indio_dev);
+	unsigned int freq_avail[4], i;
+	size_t len = 0;
+
+	ad7192_get_available_filter_freq(st, freq_avail);
+
+	for (i = 0; i < ARRAY_SIZE(freq_avail); i++)
+		len += scnprintf(buf + len, PAGE_SIZE - len,
+				 "%d.%d ", freq_avail[i] / 1000,
+				 freq_avail[i] % 1000);
+
+	buf[len - 1] = '\n';
+
+	return len;
+}
+
+static IIO_DEVICE_ATTR(filter_low_pass_3db_frequency_available,
+		       0444, ad7192_show_filter_avail, NULL, 0);
+
 static IIO_DEVICE_ATTR(bridge_switch_en, 0644,
 		       ad7192_show_bridge_switch, ad7192_set,
 		       AD7192_REG_GPOCON);
@@ -418,6 +453,7 @@ static IIO_DEVICE_ATTR(ac_excitation_en, 0644,
 		       AD7192_REG_MODE);
 
 static struct attribute *ad7192_attributes[] = {
+	&iio_dev_attr_filter_low_pass_3db_frequency_available.dev_attr.attr,
 	&iio_dev_attr_bridge_switch_en.dev_attr.attr,
 	&iio_dev_attr_ac_excitation_en.dev_attr.attr,
 	NULL
@@ -428,6 +464,7 @@ static const struct attribute_group ad7192_attribute_group = {
 };
 
 static struct attribute *ad7195_attributes[] = {
+	&iio_dev_attr_filter_low_pass_3db_frequency_available.dev_attr.attr,
 	&iio_dev_attr_bridge_switch_en.dev_attr.attr,
 	NULL
 };
@@ -441,6 +478,74 @@ static unsigned int ad7192_get_temp_scale(bool unipolar)
 	return unipolar ? 2815 * 2 : 2815;
 }
 
+static int ad7192_set_3db_filter_freq(struct ad7192_state *st,
+				      int val, int val2)
+{
+	int freq_avail[4], i, ret, idx, freq;
+	unsigned int diff_new, diff_old;
+
+	diff_old = U32_MAX;
+	freq = val * 1000 + val2;
+
+	ad7192_get_available_filter_freq(st, freq_avail);
+
+	for (i = 0; i < ARRAY_SIZE(freq_avail); i++) {
+		diff_new = abs(freq - freq_avail[i]);
+		if (diff_new < diff_old) {
+			diff_old = diff_new;
+			idx = i;
+		}
+	}
+
+	switch (idx) {
+	case 0:
+		st->f_order = AD7192_SYNC4_FILTER;
+		st->mode &= ~AD7192_MODE_SINC3;
+
+		st->conf |= AD7192_CONF_CHOP;
+		break;
+	case 1:
+		st->f_order = AD7192_SYNC3_FILTER;
+		st->mode |= AD7192_MODE_SINC3;
+
+		st->conf |= AD7192_CONF_CHOP;
+		break;
+	case 2:
+		st->f_order = AD7192_NO_SYNC_FILTER;
+		st->mode &= ~AD7192_MODE_SINC3;
+
+		st->conf &= ~AD7192_CONF_CHOP;
+		break;
+	case 3:
+		st->f_order = AD7192_NO_SYNC_FILTER;
+		st->mode |= AD7192_MODE_SINC3;
+
+		st->conf &= ~AD7192_CONF_CHOP;
+		break;
+	}
+
+	ret = ad_sd_write_reg(&st->sd, AD7192_REG_MODE, 3, st->mode);
+	if (ret < 0)
+		return ret;
+
+	return ad_sd_write_reg(&st->sd, AD7192_REG_CONF, 3, st->conf);
+}
+
+static int ad7192_get_3db_filter_freq(struct ad7192_state *st)
+{
+	unsigned int fadc;
+
+	fadc = DIV_ROUND_CLOSEST(st->fclk,
+				 st->f_order * AD7192_MODE_RATE(st->mode));
+
+	if (st->conf & AD7192_CONF_CHOP)
+		return DIV_ROUND_CLOSEST(fadc * 240, 1024);
+	if (st->mode & AD7192_MODE_SINC3)
+		return DIV_ROUND_CLOSEST(fadc * 272, 1024);
+	else
+		return DIV_ROUND_CLOSEST(fadc * 230, 1024);
+}
+
 static int ad7192_read_raw(struct iio_dev *indio_dev,
 			   struct iio_chan_spec const *chan,
 			   int *val,
@@ -481,6 +586,10 @@ static int ad7192_read_raw(struct iio_dev *indio_dev,
 		*val = st->fclk /
 			(st->f_order * 1024 * AD7192_MODE_RATE(st->mode));
 		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+		*val = ad7192_get_3db_filter_freq(st);
+		*val2 = 1000;
+		return IIO_VAL_FRACTIONAL;
 	}
 
 	return -EINVAL;
@@ -535,6 +644,9 @@ static int ad7192_write_raw(struct iio_dev *indio_dev,
 		st->mode |= AD7192_MODE_RATE(div);
 		ad_sd_write_reg(&st->sd, AD7192_REG_MODE, 3, st->mode);
 		break;
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+		ret = ad7192_set_3db_filter_freq(st, val, val2 / 1000);
+		break;
 	default:
 		ret = -EINVAL;
 	}
@@ -553,6 +665,8 @@ static int ad7192_write_raw_get_fmt(struct iio_dev *indio_dev,
 		return IIO_VAL_INT_PLUS_NANO;
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+		return IIO_VAL_INT_PLUS_MICRO;
 	default:
 		return -EINVAL;
 	}
@@ -653,6 +767,8 @@ static int ad7192_channels_config(struct iio_dev *indio_dev)
 
 	for (i = 0; i < indio_dev->num_channels; i++) {
 		*chan = channels[i];
+		chan->info_mask_shared_by_all |=
+			BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY);
 		if (chan->type != IIO_TEMP)
 			chan->info_mask_shared_by_type_available |=
 				BIT(IIO_CHAN_INFO_SCALE);
-- 
2.17.1

