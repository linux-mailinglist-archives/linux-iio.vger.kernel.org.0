Return-Path: <linux-iio+bounces-23418-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D39D1B3C6AE
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 02:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4973D3B877E
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 00:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD4D1E5711;
	Sat, 30 Aug 2025 00:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="F0BzY5zG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20852C859;
	Sat, 30 Aug 2025 00:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756514734; cv=none; b=ZQr7wGnUejl8FQLMohAzFHj3vWbCyj9khY+ZSJCw+5sTk/CxaHjpnXo3HoCHrs7NsE1jRQwnXXhO595y2+GnZn4SRPD9zf46bNAbIBQ0lcPsdUWS2N40Tl85zdFeh+cPQgx9YEp2/tnXsfnSLNgTQACuCHW55+d0Li93HUi8FqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756514734; c=relaxed/simple;
	bh=6MkpniJzSYxBEm2AnxlatOq2NEkK1vgWKN/7t41SCwA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OmJY5goYidR+HAIssWLm+g2UK9UMEYbj1LhIGcVHPi4FecfES3sHJfoAICEBcga72DTcMIM4xl+BzEiw0dUT5emT7Gdb3WaIUALWtdcul1h6/1sVgpZS2pc4m2tPBjtQDWbeWJeYJcjnoXXu1y8DFfB4wVHHy9fHsXW5A78yQfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=F0BzY5zG; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57U0DHRQ021582;
	Fri, 29 Aug 2025 20:45:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=oiHUP
	l+fb6diF3fo7NkabY3vBL6coMyZByWE8YGufj0=; b=F0BzY5zGCjP6c6GBteYCZ
	0r54c3K/h3oU0A4gZQFyg79w/N7zeSkbq7+tVUrVhqY8qaxjoNeQIZTn04Sr+YsV
	rKJ+W84dZ2H7cQvehCihqqFH1/bNV1VHczhygWzdBXvHaiZWJAuTQSFsXhVqZfXV
	PQHclnxT/GntGlSY+p23NZL00oJyXQ7hxjY2BFL1UZHMQBuaOYZH9a/RX4J3Gg4t
	x4uKHtmzomwicDjFF3bbAZE6HYDCTU06cIzqWfXAOifQmtsSPA+ShfsxgpCCbr+g
	Twoje61MTnjeW9Dtxol6142gfqfdmRcRixEEO5/Yq5h84huQ+0nRW9MTooBgmuS9
	A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 48rmagch6s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Aug 2025 20:45:28 -0400 (EDT)
Received: from m0167089.ppops.net (m0167089.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57U0jRhs009638;
	Fri, 29 Aug 2025 20:45:27 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 48rmagch6q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Aug 2025 20:45:27 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 57U0jQGk018959
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 29 Aug 2025 20:45:26 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 29 Aug
 2025 20:45:26 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 29 Aug 2025 20:45:26 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 57U0j9au005052;
	Fri, 29 Aug 2025 20:45:12 -0400
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
Subject: [PATCH 13/15] iio: adc: ad4030: Enable dual data rate
Date: Fri, 29 Aug 2025 21:45:09 -0300
Message-ID: <47b2cf01555c31126bc2133526317c7829cb59ab.1756511030.git.marcelo.schmitt@analog.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI1MDA3NSBTYWx0ZWRfX1/vWJNhqEG7Q
 vFS8uAu+vr78+OaFqxZaxOjT9l74oWmjwz3DDTeV8E3nrM3pDBxr2vQuoHE2Zeq/0bktqsEsfrF
 gjaj5cZKO7msQEXdrfx1D5GUz1jDZMbVQJ/2/FgFAgq/UL1eOhN212PNFhUajeB0At5tcSlAgQA
 AKlqi5GVoNFQdwGLAxSKHjj1GyuZZISp+kJPNufGELXQj+oTzCdcjSHP6zwcIzSEFTYdA6w6ALo
 n9JHy93R2hhDlVtimS0SirGlHnr94opi03Qqb9iu6ogsY7/CUTxh+n8ff7+XND9CCpWAGysjP6K
 Dvp7qlFyEC3oWXDQBR3sH5KaugUI3LNdwkx+Z7oFWIjRBaQl++OFSk3sCW3Hjgp0GBFndSoA0Gt
 MV18Wyqo
X-Proofpoint-ORIG-GUID: EnVLUJs7FU8Ck_Xn4EnB-vna-sChTrif
X-Proofpoint-GUID: UpKjy0qQra72shPHPtH9nj56Ce_Zq6ds
X-Authority-Analysis: v=2.4 cv=AoXu3P9P c=1 sm=1 tr=0 ts=68b249a8 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=2OwXVqhp2XgA:10 a=gAnH3GRIAAAA:8 a=T0tPgOHDDdUk5YL2XZwA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-29_07,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 adultscore=0 bulkscore=0 phishscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508250075

Set AD4030 series device to do two data bit transitions per clock cycle per
active lane when specified by firmware. The dual data rate (DDR) feature is
available only for host clock mode and echo clock mode.

Co-developed-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 drivers/iio/adc/ad4030.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
index a5931056936a..37ba00097efe 100644
--- a/drivers/iio/adc/ad4030.c
+++ b/drivers/iio/adc/ad4030.c
@@ -74,6 +74,7 @@
 	(AD4030_REG_GAIN_X0_MSB + (AD4030_REG_GAIN_BYTES_NB * (ch)))
 #define AD4030_REG_MODES			0x20
 #define     AD4030_REG_MODES_MASK_OUT_DATA_MODE	GENMASK(2, 0)
+#define     AD4030_REG_MODES_MASK_DDR_MODE	BIT(3)
 #define     AD4030_REG_MODES_MASK_CLOCK_MODE	GENMASK(5, 4)
 #define     AD4030_REG_MODES_MASK_LANE_MODE	GENMASK(7, 6)
 #define AD4030_REG_OSCILATOR			0x21
@@ -175,6 +176,7 @@ struct ad4030_state {
 	enum ad4030_out_mode mode;
 	enum ad4030_lane_mode lane_mode;
 	enum ad4030_clock_mode clock_mode;
+	bool ddr;
 	/* offload sampling spi message */
 	struct spi_transfer offload_xfer;
 	struct spi_message offload_msg;
@@ -1218,6 +1220,9 @@ static void ad4030_prepare_offload_msg(struct ad4030_state *st)
 	else
 		offload_bpw  = data_width / (1 << st->lane_mode);
 
+	if (st->ddr)
+		offload_bpw  /= 2;
+
 	st->offload_xfer.speed_hz = AD4030_SPI_MAX_REG_XFER_SPEED;
 	st->offload_xfer.bits_per_word = offload_bpw;
 	st->offload_xfer.len = roundup_pow_of_two(BITS_TO_BYTES(offload_bpw));
@@ -1271,6 +1276,12 @@ static int ad4030_config(struct ad4030_state *st)
 	reg_modes |= FIELD_PREP(AD4030_REG_MODES_MASK_CLOCK_MODE,
 				ret >= 0 ? ret : AD4030_SPI_CLOCK_MODE);
 
+	/* DDR is only valid for echo clock and host clock modes */
+	if (ret == AD4030_ECHO_CLOCK_MODE || ret == AD4030_CLOCK_HOST_MODE) {
+		st->ddr = device_property_read_bool(dev, "adi,dual-data-rate");
+		reg_modes |= FIELD_PREP(AD4030_REG_MODES_MASK_DDR_MODE, st->ddr);
+	}
+
 	ret = regmap_write(st->regmap, AD4030_REG_MODES, reg_modes);
 	if (ret)
 		return ret;
-- 
2.39.2


