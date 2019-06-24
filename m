Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D84951A62
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2019 20:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbfFXSVB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 24 Jun 2019 14:21:01 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:34984 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726934AbfFXSVB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 Jun 2019 14:21:01 -0400
X-Greylist: delayed 11321 seconds by postgrey-1.27 at vger.kernel.org; Mon, 24 Jun 2019 14:20:59 EDT
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5OEwF7S011278;
        Mon, 24 Jun 2019 11:12:18 -0400
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2053.outbound.protection.outlook.com [104.47.46.53])
        by mx0b-00128a01.pphosted.com with ESMTP id 2t9e37ecnr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Jun 2019 11:12:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zqps4Mjpvk7USh+X6xxZbZcJ0Zair5LEZipihcqs1Bs=;
 b=ZfVQbXfGZe3OAknF2rWIMCiqxQC+1B77xt9AjUJtljVF1JDtitNaR+q9H3dDXxzDxE53UgDtseVU3r32ieJ/e2QSJ5n1F4HxuGL9P4pVCF4VMwFNOdnQnzEEq1te4mKcSvRAoZbB/USnlwFFVvzmrQRv9XR1zD0Fj4eH8pBr7wQ=
Received: from CY4PR03CA0100.namprd03.prod.outlook.com (2603:10b6:910:4d::41)
 by DM5PR03MB3129.namprd03.prod.outlook.com (2603:10b6:4:3c::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2008.16; Mon, 24 Jun
 2019 15:12:16 +0000
Received: from BL2NAM02FT038.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::201) by CY4PR03CA0100.outlook.office365.com
 (2603:10b6:910:4d::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2008.13 via Frontend
 Transport; Mon, 24 Jun 2019 15:12:16 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BL2NAM02FT038.mail.protection.outlook.com (10.152.77.25) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1987.11
 via Frontend Transport; Mon, 24 Jun 2019 15:12:16 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id x5OFCFmH010372
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 24 Jun 2019 08:12:15 -0700
Received: from linux.ad.analog.com (10.32.226.41) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.408.0; Mon, 24 Jun 2019
 11:12:15 -0400
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>
CC:     <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <stefan.popa@analog.com>
Subject: [PATCH 2/4] iio: frequency: adf4371: Add support for ADF4372 PLL
Date:   Mon, 24 Jun 2019 18:12:12 +0300
Message-ID: <1561389132-26182-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(136003)(346002)(376002)(396003)(2980300002)(199004)(189003)(2351001)(70586007)(7636002)(305945005)(5660300002)(70206006)(47776003)(8936002)(6916009)(7696005)(478600001)(51416003)(50226002)(6306002)(6666004)(356004)(186003)(48376002)(966005)(72206003)(2906002)(50466002)(14444005)(316002)(26005)(106002)(54906003)(8676002)(336012)(77096007)(16586007)(126002)(476003)(2616005)(44832011)(246002)(36756003)(426003)(486006)(4326008)(107886003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR03MB3129;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4305754e-c133-40a7-fdf3-08d6f8b6581e
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(4709080)(1401327)(2017052603328);SRVR:DM5PR03MB3129;
X-MS-TrafficTypeDiagnostic: DM5PR03MB3129:
X-MS-Exchange-PUrlCount: 1
X-Microsoft-Antispam-PRVS: <DM5PR03MB312956149E539DD3265D69BA9DE00@DM5PR03MB3129.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 007814487B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: 2lmfN9AcqrP5v22mZbWyYGfJuQ5ta091Ak+lGrEV13pk9Nu55Vt0/fKAHfFb4czqXOI42/E4Drjb9vS2XSGycYFt/5HRALOR1gkBJhdiu/k9BortkSHpOipMfdwdItrEyCH5asnKxviHkgHGKWFJEzKaTOcOcXQAmJQHUi47v6vugl7fm8SVovTPVtssDOuzCJZf6XFlOicJ320ErTa1sIVAKOo9y9d5zCIUTaG8s9QhxvS39AtoAvPiIFAhdopk2RTTKQKezCzEhn35fTT4NV3VKuD9XK6qyUVcUUF+yZ0pHlSb4pVVFmhuCAZVb4GlLvifwI7H/1/AN/z5iF9GkKlFpDFg9aVobzZiwxqsAXWtxyrKI7bOJPIswz0lLtvrAXOTGBz/OpLM1JZjHlmoCk6uV1WdX0SpNn8q+Df+VLk=
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2019 15:12:16.4415
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4305754e-c133-40a7-fdf3-08d6f8b6581e
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB3129
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-24_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906240122
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The ADF4372 is part of the same family with ADF4371, the main difference
is that it has only 3 channels instead of 4, as the frequency quadrupler
is missing. As a result, the ADF4372 allows frequencies from 62.5 MHz to
16 GHz to be generated.

Datasheet:
Link: https://www.analog.com/media/en/technical-documentation/data-sheets/adf4372.pdf

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
 drivers/iio/frequency/Kconfig   |  6 +++---
 drivers/iio/frequency/adf4371.c | 31 ++++++++++++++++++++++++++++---
 2 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/frequency/Kconfig b/drivers/iio/frequency/Kconfig
index e4a921f..353914b 100644
--- a/drivers/iio/frequency/Kconfig
+++ b/drivers/iio/frequency/Kconfig
@@ -39,12 +39,12 @@ config ADF4350
 	  module will be called adf4350.
 
 config ADF4371
-	tristate "Analog Devices ADF4371 Wideband Synthesizer"
+	tristate "Analog Devices ADF4371/ADF4372 Wideband Synthesizers"
 	depends on SPI
 	select REGMAP_SPI
 	help
-	  Say yes here to build support for Analog Devices  ADF4371
-	  Wideband Synthesizer. The driver provides direct access via sysfs.
+	  Say yes here to build support for Analog Devices ADF4371 and ADF4372
+	  Wideband Synthesizers. The driver provides direct access via sysfs.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called adf4371.
diff --git a/drivers/iio/frequency/adf4371.c b/drivers/iio/frequency/adf4371.c
index d8c414b..f874219 100644
--- a/drivers/iio/frequency/adf4371.c
+++ b/drivers/iio/frequency/adf4371.c
@@ -87,6 +87,11 @@ enum {
 	ADF4371_CH_RF32
 };
 
+enum adf4371_variant {
+	ADF4371,
+	ADF4372
+};
+
 struct adf4371_pwrdown {
 	unsigned int reg;
 	unsigned int bit;
@@ -140,6 +145,11 @@ static const struct regmap_config adf4371_regmap_config = {
 	.read_flag_mask = BIT(7),
 };
 
+struct adf4371_chip_info {
+	unsigned int num_channels;
+	const struct iio_chan_spec *channels;
+};
+
 struct adf4371_state {
 	struct spi_device *spi;
 	struct regmap *regmap;
@@ -152,6 +162,7 @@ struct adf4371_state {
 	 * writes.
 	 */
 	struct mutex lock;
+	const struct adf4371_chip_info *chip_info;
 	unsigned long clkin_freq;
 	unsigned long fpfd;
 	unsigned int integer;
@@ -429,6 +440,17 @@ static const struct iio_chan_spec adf4371_chan[] = {
 	ADF4371_CHANNEL(ADF4371_CH_RF32),
 };
 
+static const struct adf4371_chip_info adf4371_chip_info[] = {
+	[ADF4371] = {
+		.channels = adf4371_chan,
+		.num_channels = 4,
+	},
+	[ADF4372] = {
+		.channels = adf4371_chan,
+		.num_channels = 3,
+	}
+};
+
 static int adf4371_reg_access(struct iio_dev *indio_dev,
 			      unsigned int reg,
 			      unsigned int writeval,
@@ -537,12 +559,13 @@ static int adf4371_probe(struct spi_device *spi)
 	st->regmap = regmap;
 	mutex_init(&st->lock);
 
+	st->chip_info = &adf4371_chip_info[id->driver_data];
 	indio_dev->dev.parent = &spi->dev;
 	indio_dev->name = id->name;
 	indio_dev->info = &adf4371_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-	indio_dev->channels = adf4371_chan;
-	indio_dev->num_channels = ARRAY_SIZE(adf4371_chan);
+	indio_dev->channels = st->chip_info->channels;
+	indio_dev->num_channels = st->chip_info->num_channels;
 
 	st->clkin = devm_clk_get(&spi->dev, "clkin");
 	if (IS_ERR(st->clkin))
@@ -568,13 +591,15 @@ static int adf4371_probe(struct spi_device *spi)
 }
 
 static const struct spi_device_id adf4371_id_table[] = {
-	{ "adf4371", 0 },
+	{ "adf4371", ADF4371 },
+	{ "adf4372", ADF4372 },
 	{}
 };
 MODULE_DEVICE_TABLE(spi, adf4371_id_table);
 
 static const struct of_device_id adf4371_of_match[] = {
 	{ .compatible = "adi,adf4371" },
+	{ .compatible = "adi,adf4372" },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, adf4371_of_match);
-- 
2.7.4

