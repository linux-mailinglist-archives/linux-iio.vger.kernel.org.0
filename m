Return-Path: <linux-iio+bounces-23416-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D92B2B3C6A8
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 02:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 728B63AA49C
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 00:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0EF1D5170;
	Sat, 30 Aug 2025 00:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="OY1RrfKK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672D21E00A0;
	Sat, 30 Aug 2025 00:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756514690; cv=none; b=QLkvW/TPntw78JRrqyQy6q9QEZJqOtwARLwaFxdP95gq6VIUmKK+Ibup7obKOYPk426DAkpkaios4SRd+6278CKtzEqoRVub/ahw+G0BT/GxoC+IZB0WinfIb4nRiDn5JDOVGVlzAkO+wjvO+cI6oZ97Wtn7K/Yky47Kd/BFRHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756514690; c=relaxed/simple;
	bh=F6YHQWe3pqkozUhDOhuMRjC/KGhestyclV19bxYcjkM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sM9lK+0N1FkoS8aoGq49XIR2DYmlxqSzIO4qIF0m5/adiWN9+4VlkunnzkLi5Wm1IdUDh+hht89XFn0Z0ohRYfM9wae9XSZ3P5EEKZ2iqAcXIcsEdN99rPmdMEkiTXJJftrYZBr/DPF+3VP4e9O+L4Q2RQC27q6vbdIiJinbN0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=OY1RrfKK; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57U0htNW026870;
	Fri, 29 Aug 2025 20:44:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=j4T+H
	avfse5awEVw7I/+KSX4rxkVdMHxygU4lG9Hr90=; b=OY1RrfKKCHF/iIp3B7wig
	W6ce5OkQ9qZ7NhTjnr758vk1OcyiIB7omNiZsYQ4fVVTTdPApmmTJjhwyi2iYS7Z
	qslsOIiDmMbvy9sAMBRhzOoT53wc0ZhVmOG1PuVhMrwoYD4WZ4erFhkKmW9hhdJN
	FswpJUVK18/5wBno7S3XMA8PWxX50Pz+JCutG/PWv5YDqxk1SG/tJ5je/kjLJV3x
	2PrDhITTp4zZvIKgxx2otsqbajR8Hy6nd1vqlg5xHY0vbUGDnDd6BUCc82gJJoiA
	UYSqKWWkfN/dxhlXvnagRWYFEhYtHrV5Yh3dl3xgKMEP4r2gyg5xdVphnohvHzl5
	Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 48sqatajht-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Aug 2025 20:44:43 -0400 (EDT)
Received: from m0167088.ppops.net (m0167088.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57U0eOux006372;
	Fri, 29 Aug 2025 20:44:43 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 48sqatajhq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Aug 2025 20:44:43 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 57U0ifY1018926
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 29 Aug 2025 20:44:42 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 29 Aug
 2025 20:44:41 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 29 Aug 2025 20:44:41 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 57U0iLiV005001;
	Fri, 29 Aug 2025 20:44:23 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-spi@vger.kernel.org>
CC: <jic23@kernel.org>, <Michael.Hennerich@analog.com>, <nuno.sa@analog.com>,
        <eblanc@baylibre.com>, <dlechner@baylibre.com>, <andy@kernel.org>,
        <corbet@lwn.net>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <broonie@kernel.org>,
        <Jonathan.Cameron@huawei.com>, <andriy.shevchenko@linux.intel.com>,
        <ahaslam@baylibre.com>, <sergiu.cuciurean@analog.com>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH 11/15] iio: adc: ad4030: Add clock mode option parse and setup
Date: Fri, 29 Aug 2025 21:44:20 -0300
Message-ID: <344c3797fe8e5aa9177ef8c0633d1eedd32563fa.1756511030.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1756511030.git.marcelo.schmitt@analog.com>
References: <cover.1756511030.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI3MDAwMCBTYWx0ZWRfX4hcOl0TM0zv8
 AawoDhUcbcychDdQbKI/HLN7+hhUo2WvR9Dzkbz/Z9krSsIo+HN2lAjmRgPpRq/XSQGdJicdD6e
 9NhzZt37GFO5knx+zuHEn5je49kQcsk2Sn0Br7GIMWO846m5/CjI0V7znF3lkP7+81BgAnAavad
 YpTs9yS42yUYX/Id5NC80ksdE2GH19Lns8MjI/AlQGVOaLnMFMneX3S5wpXJE7LwG9DibrF/bmM
 DWM90FNRKs3Tr5F3NUJh2tioNvT8nsRRb2CWpC9PMb52P87LBunMyiGileyYaj83KExbq+yvTch
 Abg9tS0hPIqx6l7YeIE2f6AiF13IpUvQrFhpqxoaVwCExZCy3QKBmEy3ecOw79z+EGTD8N/AkQz
 tFTU/AaB
X-Authority-Analysis: v=2.4 cv=Z4bsHGRA c=1 sm=1 tr=0 ts=68b2497b cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=2OwXVqhp2XgA:10 a=gAnH3GRIAAAA:8 a=0e_ScE69okfbZy3JQKoA:9
 a=br55WurUj89AL1qEz8Q6:22
X-Proofpoint-ORIG-GUID: ys8wXQ8ewLA7r7NYpIwNqMeiayf3Jnxe
X-Proofpoint-GUID: jVtSYUAKnugMVcPC3RXe52GuTnOVxJG6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-29_07,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 malwarescore=0 bulkscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508270000

AD4030 series of ADCs support three different options for the clock that
frames data output. Since each clock option implies a different hardware
setup, the clock mode to use is specified in firmware. Read the designated
clock option from firmware and configure the device to work accordingly.

Co-developed-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 drivers/iio/adc/ad4030.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
index e6c1c9be1632..a5931056936a 100644
--- a/drivers/iio/adc/ad4030.c
+++ b/drivers/iio/adc/ad4030.c
@@ -74,6 +74,7 @@
 	(AD4030_REG_GAIN_X0_MSB + (AD4030_REG_GAIN_BYTES_NB * (ch)))
 #define AD4030_REG_MODES			0x20
 #define     AD4030_REG_MODES_MASK_OUT_DATA_MODE	GENMASK(2, 0)
+#define     AD4030_REG_MODES_MASK_CLOCK_MODE	GENMASK(5, 4)
 #define     AD4030_REG_MODES_MASK_LANE_MODE	GENMASK(7, 6)
 #define AD4030_REG_OSCILATOR			0x21
 #define AD4030_REG_IO				0x22
@@ -127,6 +128,12 @@ enum ad4030_out_mode {
 	AD4030_OUT_DATA_MD_32_PATTERN,
 };
 
+enum ad4030_clock_mode {
+	AD4030_SPI_CLOCK_MODE,
+	AD4030_ECHO_CLOCK_MODE,
+	AD4030_CLOCK_HOST_MODE,
+};
+
 enum ad4030_lane_mode {
 	AD4030_LANE_MD_1_PER_CH,
 	AD4030_LANE_MD_2_PER_CH,
@@ -167,6 +174,7 @@ struct ad4030_state {
 	unsigned int avg_log2;
 	enum ad4030_out_mode mode;
 	enum ad4030_lane_mode lane_mode;
+	enum ad4030_clock_mode clock_mode;
 	/* offload sampling spi message */
 	struct spi_transfer offload_xfer;
 	struct spi_message offload_msg;
@@ -263,6 +271,12 @@ static const int ad4030_rx_bus_width[] = {
 	1, 2, 4, 8,
 };
 
+static const char * const ad4030_clock_mode_str[] = {
+	[AD4030_SPI_CLOCK_MODE] = "spi",
+	[AD4030_ECHO_CLOCK_MODE] = "echo",
+	[AD4030_CLOCK_HOST_MODE] = "host",
+};
+
 static const int ad4030_average_modes[] = {
 	1, 2, 4, 8, 16, 32, 64, 128,
 	256, 512, 1024, 2048, 4096, 8192, 16384, 32768,
@@ -1249,6 +1263,14 @@ static int ad4030_config(struct ad4030_state *st)
 
 	reg_modes = FIELD_PREP(AD4030_REG_MODES_MASK_LANE_MODE, st->lane_mode);
 
+	/* Optional data clock mode */
+	ret = device_property_match_property_string(dev, "adi,clock-mode",
+						    ad4030_clock_mode_str,
+						    ARRAY_SIZE(ad4030_clock_mode_str));
+	/* Default to SPI clock mode. */
+	reg_modes |= FIELD_PREP(AD4030_REG_MODES_MASK_CLOCK_MODE,
+				ret >= 0 ? ret : AD4030_SPI_CLOCK_MODE);
+
 	ret = regmap_write(st->regmap, AD4030_REG_MODES, reg_modes);
 	if (ret)
 		return ret;
-- 
2.39.2


