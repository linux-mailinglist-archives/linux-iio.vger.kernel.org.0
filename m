Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41D1C1263AF
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2019 14:37:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbfLSNh2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 19 Dec 2019 08:37:28 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:41682 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726695AbfLSNh2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 19 Dec 2019 08:37:28 -0500
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBJDRAwr024888;
        Thu, 19 Dec 2019 08:37:07 -0500
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by mx0b-00128a01.pphosted.com with ESMTP id 2wxf1n043k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Dec 2019 08:37:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZiLi0C+WMEx9pNhthDzd6fAAPcp4j5EcSf9u4o2SxfaRQ56GPkgpw+oFBx/dBklOHhw194Rm02Jbv235bsXF2N+6bzu/hvlg/iKY31aX1PcoRgXszHZo1CQsSb7uCzAZs97wDXGySFebFTCPO9RUv72ZFNTKZ4q3+KoY+YuoURk1LRIu313ujnQy2TmjVypo/6OH5ByxEbbAHNy3EgYV0LO24pMAeXPNgcHlRioiXM3KLKg+w9trW2POe9uBkVZWCru2bxl5JqcLCyb125qqzuo1NOl9+BC7YeRGUL2KVWPkUn+JnQJ6FvvTK8cucTrRfv5J/t/5GLPZyu4F8wjiAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0/eivhwkMtCY9Uek1H+CTTN22sVCFWb9qMrJk92j3/Y=;
 b=XyCToRoW7x2pRZDPV8pBPAC9UHTnse0sA7yLrIxCbx2wIDLdTcl77zj0I9ClO9qoo1w1V504g+XSsDDYmLVAqUYcslvHAB4J7LHDlYRUISXm210U7dPl4nTr03GpLxSUh6TbTgKnTzXJSxRS7paSUvl3VW2y7rka8XqZW6sxj3IliQSdSxjvQDSX7f4nJPLzH8wes99csLvoULyYX23GpW5khD/tFNywYPybT85uBt3LT8B7ExwhhuLc+E/w7n5tge1HDCWMFgoH5tGTvdDfYizOFqZUZ52hkYrGNm5Slgl5FsfPqXuDjHh8KEWMAJi+Kf4vPwtjlv5FDPeEuRQ0Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0/eivhwkMtCY9Uek1H+CTTN22sVCFWb9qMrJk92j3/Y=;
 b=NXGebf+boR6i5m1DQPvJCgVE/b9OxNpQ8QrMA8mxH0rvaLw8IqIh1P79chQfg3okv4iNWe3XkkX8k/UrTYxBYbaQfBdFQOPlua8F66JJm8ukAL2HzMDrUkBrcCQkJEJra+KiOPEwvn9Yz0HYaXcZgx1h08VwfQIqYVWJniE/GgA=
Received: from SN6PR2101CA0029.namprd21.prod.outlook.com
 (2603:10b6:805:106::39) by BN8PR03MB4818.namprd03.prod.outlook.com
 (2603:10b6:408:6a::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.14; Thu, 19 Dec
 2019 13:37:05 +0000
Received: from SN1NAM02FT061.eop-nam02.prod.protection.outlook.com
 (2603:10b6:805:106:cafe::d2) by SN6PR2101CA0029.outlook.office365.com
 (2603:10b6:805:106::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2581.2 via Frontend
 Transport; Thu, 19 Dec 2019 13:37:05 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 SN1NAM02FT061.mail.protection.outlook.com (10.152.72.196) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2538.14
 via Frontend Transport; Thu, 19 Dec 2019 13:37:04 +0000
Received: from SCSQMBX10.ad.analog.com (scsqmbx10.ad.analog.com [10.77.17.5])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id xBJDb2G1012860
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 19 Dec 2019 05:37:03 -0800
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Thu, 19 Dec
 2019 05:37:00 -0800
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 19 Dec 2019 08:37:00 -0500
Received: from ben-Latitude-E6540.ad.analog.com ([10.48.65.231])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id xBJDal8e000582;
        Thu, 19 Dec 2019 08:36:56 -0500
From:   Beniamin Bia <beniamin.bia@analog.com>
To:     <jic23@kernel.org>
CC:     <knaack.h@gmx.de>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Michael.Hennerich@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <biabeniamin@outlook.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Beniamin Bia <beniamin.bia@analog.com>
Subject: [PATCH 2/3] iio: frequency: adf4371: Introduce channel child nodes
Date:   Thu, 19 Dec 2019 15:37:54 +0200
Message-ID: <20191219133755.26109-2-beniamin.bia@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191219133755.26109-1-beniamin.bia@analog.com>
References: <20191219133755.26109-1-beniamin.bia@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(396003)(39860400002)(189003)(199004)(8936002)(186003)(2616005)(4326008)(426003)(7696005)(26005)(8676002)(356004)(6916009)(54906003)(70206006)(2906002)(36756003)(70586007)(5660300002)(7636002)(478600001)(107886003)(86362001)(44832011)(246002)(336012)(316002)(1076003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN8PR03MB4818;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40df0c69-bf90-4ece-265f-08d784888919
X-MS-TrafficTypeDiagnostic: BN8PR03MB4818:
X-Microsoft-Antispam-PRVS: <BN8PR03MB481854082BEFF19F21E48D53F0520@BN8PR03MB4818.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0256C18696
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RP6D742haRzSuNkx6VTPZwjwJS9sFwzFgg/Qqthm80zdaU1+JqSCBjsA6Vk7e0Tg8mTdPowLVGQB2vPLd3FC3jrmTGhroD9Ga/nB8+r+wJMug4d1oUdlOrfzZIi1ZWAGSyIF9QNPg9TsUsT5Eruw9CaqYw09kqLF/z0r6Fu8ErgpXWFAVwavz/MwPeDgGVJCRnFFwyKB/rW9KqjjOu17Z8FuczAD+FD5aiAVRc3aHAc1z99uQMPHETRfTL6QGT4sVyS8c2lfktSg7WXEKzYlKSjwMG5WvQeWMOKgTms/E8HZQDBPWwV/OASprT0gzJcsTTY341i6f5zJst5OR4U49+28z7OyEPZefBQjTCndeUvR8GuCQx+CQInpmCZ95yOL7NYl9yrkohB0A2J75Jm/DeSuSq7NNdK/iwY2gfbufeByDG4KUMVKqgtJ4295uYGe
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2019 13:37:04.5599
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40df0c69-bf90-4ece-265f-08d784888919
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR03MB4818
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-19_01:2019-12-17,2019-12-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 suspectscore=1 impostorscore=0 malwarescore=0 mlxlogscore=999
 clxscore=1015 mlxscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912190117
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Stefan Popa <stefan.popa@analog.com>

The ADF4371/ADF4372 devices support individual configurations for the
output channels. Each child node represents a channel for which
"power-up-frequency" and "output-enable" optional properties are currently
supported.

If the "power-up-frequency" is specified for a channel, the driver checks
if the value provided is in sync with the frequencies set on the other
channels. This limitation is due to the fact that all the channel
frequencies are derived from the VCO fundamental frequency.

If the "output-enable" property is specified, then the channel will be
enabled, otherwise, the driver will initialize the defaults (RF8x will
be the only enabled channel).

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
---
 drivers/iio/frequency/adf4371.c | 79 ++++++++++++++++++++++++++++++++-
 1 file changed, 77 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/frequency/adf4371.c b/drivers/iio/frequency/adf4371.c
index 7d77ebdbea82..e2a599b912e5 100644
--- a/drivers/iio/frequency/adf4371.c
+++ b/drivers/iio/frequency/adf4371.c
@@ -154,10 +154,16 @@ struct adf4371_chip_info {
 	const struct iio_chan_spec *channels;
 };
 
+struct adf4371_channel_config {
+	bool enable;
+	unsigned long long freq;
+};
+
 struct adf4371_state {
 	struct spi_device *spi;
 	struct regmap *regmap;
 	struct clk *clkin;
+	struct adf4371_channel_config channel_cfg[4];
 	/*
 	 * Lock for accessing device registers. Some operations require
 	 * multiple consecutive R/W operations, during which the device
@@ -175,6 +181,7 @@ struct adf4371_state {
 	unsigned int mod2;
 	unsigned int rf_div_sel;
 	unsigned int ref_div_factor;
+	bool mute_till_lock_en;
 	u8 buf[10] ____cacheline_aligned;
 };
 
@@ -480,6 +487,36 @@ static const struct iio_info adf4371_info = {
 	.debugfs_reg_access = &adf4371_reg_access,
 };
 
+static int adf4371_channel_config(struct adf4371_state *st)
+{
+	unsigned long long rate;
+	int i, ret;
+
+	for (i = 0; i < st->chip_info->num_channels; i++) {
+		if (st->channel_cfg[i].freq == 0)
+			continue;
+
+		rate = adf4371_pll_fract_n_get_rate(st, i);
+		if (rate == 0) {
+			ret = adf4371_set_freq(st, st->channel_cfg[i].freq, i);
+			if (ret < 0)
+				return ret;
+		} else if (rate != st->channel_cfg[i].freq) {
+			dev_err(&st->spi->dev,
+				"Clock rate for chanel %d is not in sync\n", i);
+			return -EINVAL;
+		}
+		/* Powerup channel if the property was specified in the dt */
+		if (st->channel_cfg[i].enable) {
+			ret = adf4371_channel_power_down(st, i, false);
+			if (ret < 0)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+
 static int adf4371_setup(struct adf4371_state *st)
 {
 	unsigned int synth_timeout = 2, timeout = 1, vco_alc_timeout = 1;
@@ -497,7 +534,7 @@ static int adf4371_setup(struct adf4371_state *st)
 		return ret;
 
 	/* Mute to Lock Detect */
-	if (device_property_read_bool(&st->spi->dev, "adi,mute-till-lock-en")) {
+	if (st->mute_till_lock_en) {
 		ret = regmap_update_bits(st->regmap, ADF4371_REG(0x25),
 					 ADF4371_MUTE_LD_MSK,
 					 ADF4371_MUTE_LD(1));
@@ -545,7 +582,11 @@ static int adf4371_setup(struct adf4371_state *st)
 	st->buf[3] = synth_timeout;
 	st->buf[4] = ADF4371_VCO_ALC_TOUT(vco_alc_timeout);
 
-	return regmap_bulk_write(st->regmap, ADF4371_REG(0x30), st->buf, 5);
+	ret = regmap_bulk_write(st->regmap, ADF4371_REG(0x30), st->buf, 5);
+	if (ret < 0)
+		return 0;
+
+	return adf4371_channel_config(st);
 }
 
 static void adf4371_clk_disable(void *data)
@@ -555,6 +596,36 @@ static void adf4371_clk_disable(void *data)
 	clk_disable_unprepare(st->clkin);
 }
 
+static int adf4371_parse_dt(struct adf4371_state *st)
+{
+	unsigned char num_channels;
+	unsigned int channel;
+	struct fwnode_handle *child;
+	int ret;
+
+	if (device_property_read_bool(&st->spi->dev, "adi,mute-till-lock-en"))
+		st->mute_till_lock_en = true;
+
+	num_channels = device_get_child_node_count(&st->spi->dev);
+	if (num_channels > st->chip_info->num_channels)
+		return -EINVAL;
+
+	device_for_each_child_node(&st->spi->dev, child) {
+		ret = fwnode_property_read_u32(child, "reg", &channel);
+		if (ret)
+			return ret;
+
+		ret = fwnode_property_present(child, "adi,output-enable");
+		st->channel_cfg[channel].enable = ret;
+
+		fwnode_property_read_u64(child,
+					 "adi,power-up-frequency",
+					 &st->channel_cfg[channel].freq);
+	}
+
+	return 0;
+}
+
 static int adf4371_probe(struct spi_device *spi)
 {
 	const struct spi_device_id *id = spi_get_device_id(spi);
@@ -602,6 +673,10 @@ static int adf4371_probe(struct spi_device *spi)
 
 	st->clkin_freq = clk_get_rate(st->clkin);
 
+	ret = adf4371_parse_dt(st);
+	if (ret < 0)
+		return ret;
+
 	ret = adf4371_setup(st);
 	if (ret < 0) {
 		dev_err(&spi->dev, "ADF4371 setup failed\n");
-- 
2.17.1

