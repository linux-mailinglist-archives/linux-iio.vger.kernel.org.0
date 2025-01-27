Return-Path: <linux-iio+bounces-14625-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB131A1D938
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jan 2025 16:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0C6F3A5787
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jan 2025 15:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146281422A8;
	Mon, 27 Jan 2025 15:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="mUpCRrCr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515C6144D21;
	Mon, 27 Jan 2025 15:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737990843; cv=none; b=s+uXD2bVnXpiEW+oGANqR2vbVIXr42JS9K363VPmIBcVfvBi7qFfSC74K0tPerKvDhdGKlHqfEAzgK6Du6ix1WMai3NB/rrUqpn35PEIeWQ2+aZGisI3avAXHDJWkDN9nNJmHVeDmFsKQzVLK07OCQZXTdH6++abLya09iu/xzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737990843; c=relaxed/simple;
	bh=3KaqFbvh1FjJO9vbWRtTiajahCpvwtQGq4q+IKNqy2I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CXMYNMdNK6aZRQw+nFMXrUhUhT/E16W/QBRw12WwPq1WzNutIbBxdMmlCrRg49yjeIjt2P8eqRuSTUGcTwx4PpyKUW+Ag4m0xAX3Kec7aS3k3X6Mjgf5ekQ8acuBTWTQrmH2dAKvgWd+3CqnrUmbOTsZ9Yk44ooE/CDKquDl0/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=mUpCRrCr; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50RDWB9K005682;
	Mon, 27 Jan 2025 10:13:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=87qL/
	W5QI+Xnnwy53tZpeFaLQ+wco1XvOi9iRrJoCxE=; b=mUpCRrCrB7fUhARThCpO5
	ml6U4t+ow+AVkX8xi6a39GDTEdq3qLiMC1enAAcrtiz940JY11pfHx2na94o5WrI
	HMtJ4xsycWpnIe6NLWCfNiVxAaLodfbqNhdvJkBWE59pMcweqDyJB+g94pZeQIS+
	dMCEnjrs0i9LhWD3rF3Vl81zC+nBbGAXTu/MYbQrTvIS/GZT1ZrEwf8RyI4uJrib
	8Lk2FjHZeBSMQnrI6jQMtwPU+eswd+w3OAuMbFCRk39qcWV7DHyqUjnxOL0H1WUr
	l1z4N9ZK6DpTP/CmmVjeyP+Vn3jX5c6Y5QHknEchrKY3i2DRB2wE3zsErsSWuyW3
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 44eb44gdme-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jan 2025 10:13:48 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 50RFDkBZ011073
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 27 Jan 2025 10:13:46 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 27 Jan
 2025 10:13:46 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 27 Jan 2025 10:13:46 -0500
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 50RFDZ2Y008448;
	Mon, 27 Jan 2025 10:13:37 -0500
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Sergiu Cuciurean <sergiu.cuciurean@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <marcelo.schmitt@analog.com>,
        <jic23@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <jonath4nns@gmail.com>,
        <marcelo.schmitt1@gmail.com>,
        Jonathan Santos <Jonathan.Santos@analog.com>
Subject: [PATCH v2 11/16] iio: adc: ad7768-1: Add VCM output support
Date: Mon, 27 Jan 2025 12:13:32 -0300
Message-ID: <e8d7d5d718dc377787e2d3f1bacf2217e50726a4.1737985435.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1737985435.git.Jonathan.Santos@analog.com>
References: <cover.1737985435.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: RsJgKsMBqDhQ6m_Xx55YtIUljbZmSLIW
X-Proofpoint-GUID: RsJgKsMBqDhQ6m_Xx55YtIUljbZmSLIW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-27_07,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 malwarescore=0 lowpriorityscore=0 mlxlogscore=999 phishscore=0
 adultscore=0 suspectscore=0 clxscore=1015 mlxscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501270121

From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>

The VCM output voltage can be used as a common-mode voltage within the
amplifier preconditioning circuits external to the AD7768-1.

This change allows the user to configure VCM output trough a devicetree
attribute.

Co-developed-by: Jonathan Santos <Jonathan.Santos@analog.com>
Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
---
v2 Changes:
* VCM output support is now defined by a devicetree property, instead of 
  and IIO attribute.
---
 drivers/iio/adc/ad7768-1.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index 8487b9a06609..c540583808c2 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -24,6 +24,8 @@
 #include <linux/iio/triggered_buffer.h>
 #include <linux/iio/trigger_consumer.h>
 
+#include <dt-bindings/iio/adc/adi,ad7768-1.h>
+
 /* AD7768 registers definition */
 #define AD7768_REG_CHIP_TYPE		0x3
 #define AD7768_REG_PROD_ID_L		0x4
@@ -347,6 +349,11 @@ static int ad7768_set_freq(struct ad7768_state *st,
 	return 0;
 }
 
+static int ad7768_set_vcm_output(struct ad7768_state *st, unsigned int mode)
+{
+	return regmap_write(st->regmap, AD7768_REG_ANALOG2, mode);
+}
+
 static ssize_t ad7768_sampling_freq_avail(struct device *dev,
 					  struct device_attribute *attr,
 					  char *buf)
@@ -628,6 +635,7 @@ static int ad7768_probe(struct spi_device *spi)
 {
 	struct ad7768_state *st;
 	struct iio_dev *indio_dev;
+	u32 val;
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
@@ -688,6 +696,18 @@ static int ad7768_probe(struct spi_device *spi)
 	indio_dev->info = &ad7768_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
+	ret = device_property_read_u32(&spi->dev, "adi,vcm-output", &val);
+	if (!ret) {
+		if (val > AD7768_VCM_OUTPUT_OFF) {
+			dev_err(&spi->dev, "Invalid VCM output value\n");
+			return -EINVAL;
+		}
+
+		ret = ad7768_set_vcm_output(st, val);
+		if (ret)
+			return ret;
+	}
+
 	ret = ad7768_setup(st);
 	if (ret < 0) {
 		dev_err(&spi->dev, "AD7768 setup failed\n");
-- 
2.34.1


