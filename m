Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 971FB8994C
	for <lists+linux-iio@lfdr.de>; Mon, 12 Aug 2019 11:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbfHLJEP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 12 Aug 2019 05:04:15 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:31354 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727203AbfHLJEO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 12 Aug 2019 05:04:14 -0400
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7C92eMD031554;
        Mon, 12 Aug 2019 05:03:51 -0400
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2051.outbound.protection.outlook.com [104.47.37.51])
        by mx0b-00128a01.pphosted.com with ESMTP id 2u9qpaw540-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Aug 2019 05:03:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Irz0B6gNAGN5k/xRqbRq9uDCO9v2MVLV9ayulLpHKZOMjbZFQ+wURj1wYijocnss7RqBbSQlRaTzgdDszjCpSRoERLk6w74CVwKG/eBvvEXCPZ5CktVzjWJunIjKSIyvxn2gGHUnUAl1m4N95tT2JxYDo7NMcr0LMU5meiOdj8B57g9+H+IHvyDWqnvMRlNkscaIIWh6AdNp+JaRd57pPS/TEFo1ftbHzecrVZBPppokJVwY/uwkxECdGuAKMJ/nhzNZkOIWfLlDXE3NVhOoFts2nu1O7N2Vd1VgwRgfHjd3E1yiSO1K99rarQosVRaojMR4mDgVcTMRIAGEmCe9bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D4LSSh6Zadbu+M0+08buDoWdyP7tr0Sd7jneGkJMzko=;
 b=WAZrCyObS+XUj1Ppo11/A4++lf5tJOoBUubz+ajBhL7Xy9PT+EcmLZmNKVyYEdKOJatDX7KZLQo7jLWqmJhQtOcM0YowP7P+mWhMubxhGBendBsYBivhJfOqj7fb/keAwyUddH8+4yMb5ZIS8K41AS0C0NPVpGzlEAmjwymKE+AfVoFMsTSNo9xCDtF0X5Dcq+Mf95lK9V4coki1OGGyDV2crJYXWLxY2srzBHepcdJJhG2e2qCFKSJdh6Gaym55xmqyUYGpECC/1Xw9/6toL4OQJOm5AWto9TQjuiYERRiEVOSgmInk3+3Qej4+5jtY/EiQI4kBYtefLxy72JC5CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=metafoo.de smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D4LSSh6Zadbu+M0+08buDoWdyP7tr0Sd7jneGkJMzko=;
 b=aFR/JpaY05+o6RYejWGl4x/WBZ7alSb1fyUtUrNDlhk/rr/ASHCHeKHO2vdovCHHZEqChSdzmZET/jrM3M5E79cWEm5+2ljovd/5xEMmxAVdFJ8vQ+R+XtrOMQo78/ZnyDlvJTtS10YUSVO5D0O668VYB3kZMw2D8hTg6zhKRnc=
Received: from CH2PR03CA0023.namprd03.prod.outlook.com (2603:10b6:610:59::33)
 by BY2PR0301MB0648.namprd03.prod.outlook.com (2a01:111:e400:2c7a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2157.21; Mon, 12 Aug
 2019 09:03:48 +0000
Received: from CY1NAM02FT033.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::200) by CH2PR03CA0023.outlook.office365.com
 (2603:10b6:610:59::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2157.14 via Frontend
 Transport; Mon, 12 Aug 2019 09:03:48 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 CY1NAM02FT033.mail.protection.outlook.com (10.152.75.179) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2157.15
 via Frontend Transport; Mon, 12 Aug 2019 09:03:47 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x7C93kJf008997
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 12 Aug 2019 02:03:46 -0700
Received: from mircea-Latitude-E6540.ad.analog.com (10.48.65.115) by
 NWD2HUBCAS7.ad.analog.com (10.64.69.107) with Microsoft SMTP Server id
 14.3.408.0; Mon, 12 Aug 2019 05:03:46 -0400
From:   Mircea Caprioru <mircea.caprioru@analog.com>
To:     <jic23@kernel.org>
CC:     <Michael.Hennerich@analog.com>, <stefan.popa@analog.com>,
        <lars@metafoo.de>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
        Mircea Caprioru <mircea.caprioru@analog.com>
Subject: [PATCH 1/4] staging: iio: adc: ad7192: Add low_pass_3db_filter_frequency
Date:   Mon, 12 Aug 2019 12:03:38 +0300
Message-ID: <20190812090341.27183-1-mircea.caprioru@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(396003)(136003)(2980300002)(199004)(189003)(14444005)(2351001)(50466002)(246002)(36756003)(8676002)(336012)(50226002)(47776003)(107886003)(2906002)(4326008)(8936002)(5660300002)(2616005)(70206006)(54906003)(1076003)(476003)(70586007)(16586007)(486006)(126002)(106002)(316002)(7636002)(86362001)(305945005)(26005)(51416003)(7696005)(48376002)(426003)(44832011)(478600001)(186003)(6666004)(356004)(6916009);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR0301MB0648;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fde8d36d-ef30-4c60-c771-08d71f03fcbb
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:BY2PR0301MB0648;
X-MS-TrafficTypeDiagnostic: BY2PR0301MB0648:
X-Microsoft-Antispam-PRVS: <BY2PR0301MB06481FC69F4D1A20F3270B8B81D30@BY2PR0301MB0648.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 012792EC17
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: bLeS5MdhRBw8ZC0cIc0Yc3cGPi2x4BYYT+EnxPjoYk7xTCypJGCKkfD2tZZ+Fd5iaJhIHHpr5TPmxRrbG7qL9RIMMy9+3SN7fRjqyDAvoVX609NGL14/2UZ9I0OLz+Az/s+ur3dnLTps8Y4VvesLKO76ud09KAn3RLSK94CPxS5JIDEr6ShDl/2QhHGytbpFd4p14haGL2G1AdigtvB/8d+T8NRTl3I1VDeJWF9c5s/T7BoEeyW+zKgtCEn25aRVsNq5U7qWH1pmqhNXUO3pKqCOuFWJ+Do31ggUYCTt2Dc0xmlRVr2HKp2paXRyQaZoaOqjielOTIN6qc4LVsQoxRlW2mjIB+IMBKV1xsTvFsdL4FgXF8ah9QlTMW0cDFAIoByw71BtqSMcE9Ypfan4Zc/fEpvBXd880rdTl0P2JTk=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2019 09:03:47.6973
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fde8d36d-ef30-4c60-c771-08d71f03fcbb
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR0301MB0648
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-12_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908120102
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

By adding this option we are able to remove the sync3 field and dt binding.
When setting the required cutoff frequency we also determine the ADC
configuration for chop and sync filter.

Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
---
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

