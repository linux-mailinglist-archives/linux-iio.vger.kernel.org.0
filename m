Return-Path: <linux-iio+bounces-24470-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D10BA51B1
	for <lists+linux-iio@lfdr.de>; Fri, 26 Sep 2025 22:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80E5B742B00
	for <lists+linux-iio@lfdr.de>; Fri, 26 Sep 2025 20:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538BF30DD34;
	Fri, 26 Sep 2025 20:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ixN7YqDD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817C5242D69;
	Fri, 26 Sep 2025 20:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758919269; cv=none; b=bA2lZIRYnWko9h2gPRYwQxe4PG22hXqHDO8BcD8AZhlkB0q1KYqRNgwbffnRGGb5jD2OfYLUfRpG/hah6hZeoCqsOPOWG2Na6c+V2VloEiLVA/E84gzUOyJv1NY/zOStbeIh4C63Ee+idec/VnRw7eUBaUP1+XpM1Us7rvYYX9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758919269; c=relaxed/simple;
	bh=ngOgUrg0JQ06uMwwncbzStfMUQbtR9ABqywEuaRSjbU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fyp36UGJV/ctURgRXUB02iUHss8oVh0DFH8AzMyXnClDLuFq2VY0QAAMrtYq8SJ7vwEP44pCIzjcExppr3auE8E381Pqg3sI0eUn8AXLDdqzvfTsma/fML03J5qvd2GKfHEyIAvEFWdKEDQajr6a2qUod3fjv3DvZTQHXtJH91o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ixN7YqDD; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58QFsBXk019533;
	Fri, 26 Sep 2025 16:41:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=lSkIF
	VkNtykxI3nonVvFdnrQoUDFSIFXS2VvDGIhePU=; b=ixN7YqDD9it0+oPjvAxM9
	7amhXpszsYbNQHrveZj/CEzDmjV7QV48XTz6sQhtPYLVRQINUPy+N4JGA9tmuIfS
	xkirf9E1vsk7n79pkEDBJzIPEC6C7ACNfIx68pDe0PBQeUrKaFEjKlZcyiopSMz2
	H5bhS8JtALUnCLMByELBU9QRfejcDE0EHA8+RSdeDz5v1+Z8i8EoOMwhefkYG7ju
	GQre9WyAhJgEw0EIDWt+iPub3xLb3gE8XkffBn4BBevKlMZI9K/qNOL8/0FOG49T
	aZO3ZNmq1jU3av+/OCfmC2vnkRBBCXgwLYQGH7l+WbfhHzwyPJ1ydHr2YbSf8SZz
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 49db1ef95f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Sep 2025 16:41:03 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 58QKf16b006508
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 26 Sep 2025 16:41:01 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 26 Sep 2025 16:41:01 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 26 Sep 2025 16:41:01 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 26 Sep 2025 16:41:01 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 58QKdgU8010326;
	Fri, 26 Sep 2025 16:39:45 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <michael.hennerich@analog.com>, <nuno.sa@analog.com>,
        <eblanc@baylibre.com>, <dlechner@baylibre.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <corbet@lwn.net>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v3 4/8] iio: adc: ad4030: Reduce register access transfer speed
Date: Fri, 26 Sep 2025 17:39:42 -0300
Message-ID: <fd505d37aceaafd6b20626bfd3f25c47db1fb004.1758916484.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1758916484.git.marcelo.schmitt@analog.com>
References: <cover.1758916484.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: 1KaCeSInF2bEWwbYomYpfSqMDk0-yvhq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3MSBTYWx0ZWRfX/34G1mqcvmx2
 0v+hTa+hxDaBAvNbbDtHnNNCWHx9b/l2TgcZaERFqQk8laxunkBPk+PBaaf40yey+H+ntnxp+X2
 dviPoTBkOYXvCwr40Mr1HyLOkXGD3ZnasVPeq4n5VMKRv8wpHljCxRfDALS68iiKzcdcoyz/oSE
 5IBdT/nlr8fC9QX6eBhj+l0ht1NSGtj8X4eUdCBO1nZa+XFkeArG43xL7DIs8vgVKB/x0m8XaRU
 oe61NIKUmLYSwZQQNJ7/lC6fw017c4rKnkLfT2gLfyn+xSuKKYD7QwtR9NIzuTcyrUrShwlHrJg
 BJKQR/LaZFXmOdb9/uIsABgp/P43XDMM/gojdM6544g7i+Mnmm0ik0+94wfh0TGrDW4GH7CEUpZ
 EB94nLrlhq8iRuMI5osB4HyC+qgYwg==
X-Authority-Analysis: v=2.4 cv=YaGwJgRf c=1 sm=1 tr=0 ts=68d6fa5f cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=yJojWOMRYYMA:10 a=gAnH3GRIAAAA:8 a=w8QUdvN6d-jZGtNpdFEA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: 1KaCeSInF2bEWwbYomYpfSqMDk0-yvhq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_07,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0 priorityscore=1501
 spamscore=0 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250171

Configuration register accesses are not considered a critical path in terms
of time to complete. Even though register access transfers can run at high
speeds, nanosecond completion times are not required as device
configuration is usually done step by step from user space. Also, high
frequency transfers hinder debug with external tools since they require
faster clocked equipment. Reduce register access transfer speed.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 drivers/iio/adc/ad4030.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
index 1bc2f9a22470..7f0dbb8a3b07 100644
--- a/drivers/iio/adc/ad4030.c
+++ b/drivers/iio/adc/ad4030.c
@@ -102,7 +102,7 @@
 #define AD4030_VREF_MAX_UV		(5000 * MILLI)
 #define AD4030_VIO_THRESHOLD_UV		(1400 * MILLI)
 #define AD4030_SPI_MAX_XFER_LEN		8
-#define AD4030_SPI_MAX_REG_XFER_SPEED	(80 * MEGA)
+#define AD4030_SPI_REG_XFER_SPEED	(10 * MEGA)
 #define AD4030_TCNVH_NS			10
 #define AD4030_TCNVL_NS			20
 #define AD4030_TCYC_NS			500
@@ -245,7 +245,7 @@ static int ad4030_enter_config_mode(struct ad4030_state *st)
 	struct spi_transfer xfer = {
 		.tx_buf = st->tx_data,
 		.len = 1,
-		.speed_hz = AD4030_SPI_MAX_REG_XFER_SPEED,
+		.speed_hz = AD4030_SPI_REG_XFER_SPEED,
 	};
 
 	return spi_sync_transfer(st->spi, &xfer, 1);
@@ -260,7 +260,7 @@ static int ad4030_exit_config_mode(struct ad4030_state *st)
 	struct spi_transfer xfer = {
 		.tx_buf = st->tx_data,
 		.len = 3,
-		.speed_hz = AD4030_SPI_MAX_REG_XFER_SPEED,
+		.speed_hz = AD4030_SPI_REG_XFER_SPEED,
 	};
 
 	return spi_sync_transfer(st->spi, &xfer, 1);
@@ -275,7 +275,7 @@ static int ad4030_spi_read(void *context, const void *reg, size_t reg_size,
 		.tx_buf = st->tx_data,
 		.rx_buf = st->rx_data.raw,
 		.len = reg_size + val_size,
-		.speed_hz = AD4030_SPI_MAX_REG_XFER_SPEED,
+		.speed_hz = AD4030_SPI_REG_XFER_SPEED,
 	};
 
 	if (xfer.len > sizeof(st->tx_data) ||
@@ -309,7 +309,7 @@ static int ad4030_spi_write(void *context, const void *data, size_t count)
 	struct spi_transfer xfer = {
 		.tx_buf = st->tx_data,
 		.len = count,
-		.speed_hz = AD4030_SPI_MAX_REG_XFER_SPEED,
+		.speed_hz = AD4030_SPI_REG_XFER_SPEED,
 	};
 
 	if (count > sizeof(st->tx_data))
-- 
2.39.2


