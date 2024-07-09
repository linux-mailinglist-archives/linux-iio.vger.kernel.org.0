Return-Path: <linux-iio+bounces-7467-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B18092B642
	for <lists+linux-iio@lfdr.de>; Tue,  9 Jul 2024 13:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 892B21C21AE9
	for <lists+linux-iio@lfdr.de>; Tue,  9 Jul 2024 11:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4442F1586FE;
	Tue,  9 Jul 2024 11:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="1y2Ox4Np"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB45158203
	for <linux-iio@vger.kernel.org>; Tue,  9 Jul 2024 11:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720523498; cv=none; b=RVWeXYAK6L6oxkNf/LJrreol99eFOBCyCDNqwS7UvPLMmCDlgWMFTgrcV6UCrSYvt6nPNCAF8JfHyZYQxNzVd8EgsL5kRCmis4S3sN/Caa564ZChH2xnpZTHYCPZdSnpmt+kGsnY+NHa4QFcN73JAtCgeK8kpPQxTsvRwfMKHMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720523498; c=relaxed/simple;
	bh=UOKb5xsRk8GE+oZEu4a3bggb6Yvr5WNWj548FnXuzOY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Vye5apgQ08fYQhUyUTZSxLW1ODPSzVPT/kM5OOXztu4qLQbGYUg8bEeiXFia0Chy7jhGi0gMT3ojtuxqu30gtERDAV8vnNEfvZX208RbtaNOKo4mGZYUYVZY6vvqF/Lpu0fk3beddP4WrdRDxo1spwgRJt+SFiDpFKoEZiOUDdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=1y2Ox4Np; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4697DaI9029871;
	Tue, 9 Jul 2024 07:11:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=ZSskR
	zocRRzOQrCPVXJMpeyC/vEfaGAZrNh3InMNjZk=; b=1y2Ox4NprcBUjH24N8fJK
	T6guLR8wRLiU3EY5PMd7pXsO3QMeDPEZ9URtTTwD4W95TGFKlAHuIPxNNl9W9bB6
	4h+JEzNtRR0paxt7yGnbFySjeQhIipmYJIspTkPrpUm3xPtNikUc/pGsxiNfRAoU
	ve25mEFDpWr1/T8axZuk6nPHiQHbxa4EyORYlmqfqHI/1r6dr2EcSXKpRE6/JX2s
	mbW/At3kS//PrHTJT0HZVqenPoLn9i+vShoYU0q6KbC+dIScfUBOANIah+8nJks7
	ImH4nEFBSK+S9eAU0I93g3qUpvMFxrfHCr+57KCUfnxG2/fb0HBrV6JrCx1K4leP
	w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 408fy44107-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 07:11:07 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 469BB60I055143
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 9 Jul 2024 07:11:06 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Tue, 9 Jul 2024
 07:11:05 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 9 Jul 2024 07:11:05 -0400
Received: from [127.0.0.1] ([10.44.3.56])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 469BAlgq032387;
	Tue, 9 Jul 2024 07:11:00 -0400
From: Nuno Sa <nuno.sa@analog.com>
Date: Tue, 9 Jul 2024 13:14:34 +0200
Subject: [PATCH 7/9] iio: adc: adi-axi-adc: implement backend debugfs
 interface
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240709-dev-iio-backend-add-debugfs-v1-7-fb4b8f2373c7@analog.com>
References: <20240709-dev-iio-backend-add-debugfs-v1-0-fb4b8f2373c7@analog.com>
In-Reply-To: <20240709-dev-iio-backend-add-debugfs-v1-0-fb4b8f2373c7@analog.com>
To: <linux-iio@vger.kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Olivier
 Moysan <olivier.moysan@foss.st.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720523682; l=2893;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=UOKb5xsRk8GE+oZEu4a3bggb6Yvr5WNWj548FnXuzOY=;
 b=As+SZJIv2jTZcEh22RSobgvSEjVbhA6EhkJCjrTmPoltXIDSkLBm7Z+PPJb7Fx/JIeRd76Pbp
 C0/fkI6FI5tAIMZAgpA2bI/nDhstUeHontGSPfhjH4ubGv4BvuDJFDs
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: QChZsbagO_3YA-P96kTAIJoW7ER-Nd62
X-Proofpoint-ORIG-GUID: QChZsbagO_3YA-P96kTAIJoW7ER-Nd62
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_02,2024-07-08_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 suspectscore=0 adultscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 clxscore=1015 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407090077

Implement debugfs options to read/write registers and print the channel
status into a buffer (so we may know better the cause for errors) .

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/adc/adi-axi-adc.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index 12e0e6350a38..7cba347cf8eb 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -61,6 +61,10 @@
 
 #define ADI_AXI_ADC_REG_CHAN_STATUS(c)		(0x0404 + (c) * 0x40)
 #define   ADI_AXI_ADC_CHAN_STAT_PN_MASK		GENMASK(2, 1)
+/* out of sync */
+#define   ADI_AXI_ADC_CHAN_STAT_PN_OOS		BIT(1)
+/* spurious out of sync */
+#define   ADI_AXI_ADC_CHAN_STAT_PN_ERR		BIT(2)
 
 #define ADI_AXI_ADC_REG_CHAN_CTRL_3(c)		(0x0418 + (c) * 0x40)
 #define   ADI_AXI_ADC_CHAN_PN_SEL_MASK		GENMASK(19, 16)
@@ -246,6 +250,30 @@ static int axi_adc_chan_status(struct iio_backend *back, unsigned int chan,
 	return 0;
 }
 
+static int axi_adc_debugfs_print_chan_status(struct iio_backend *back,
+					     unsigned int chan, char *buf,
+					     size_t len)
+{
+	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
+	u32 val;
+	int ret;
+
+	ret = axi_adc_read_chan_status(st, chan, &val);
+	if (ret)
+		return ret;
+
+	/*
+	 * PN_ERR is cleared in case out of sync is set. Hence, no point in
+	 * checking both bits.
+	 */
+	if (val & ADI_AXI_ADC_CHAN_STAT_PN_OOS)
+		return scnprintf(buf, len, "CH%u: Out of Sync.\n", chan);
+	if (val & ADI_AXI_ADC_CHAN_STAT_PN_ERR)
+		return scnprintf(buf, len, "CH%u: Spurious Out of Sync.\n", chan);
+
+	return scnprintf(buf, len, "CH%u: OK.\n", chan);
+}
+
 static int axi_adc_chan_enable(struct iio_backend *back, unsigned int chan)
 {
 	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
@@ -280,6 +308,17 @@ static void axi_adc_free_buffer(struct iio_backend *back,
 	iio_dmaengine_buffer_free(buffer);
 }
 
+static int axi_adc_reg_access(struct iio_backend *back, unsigned int reg,
+			      unsigned int writeval, unsigned int *readval)
+{
+	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
+
+	if (readval)
+		return regmap_read(st->regmap, reg, readval);
+
+	return regmap_write(st->regmap, reg, writeval);
+}
+
 static const struct regmap_config axi_adc_regmap_config = {
 	.val_bits = 32,
 	.reg_bits = 32,
@@ -298,6 +337,8 @@ static const struct iio_backend_ops adi_axi_adc_generic = {
 	.iodelay_set = axi_adc_iodelays_set,
 	.test_pattern_set = axi_adc_test_pattern_set,
 	.chan_status = axi_adc_chan_status,
+	.debugfs_reg_access = iio_backend_debugfs_ptr(axi_adc_reg_access),
+	.debugfs_print_chan_status = iio_backend_debugfs_ptr(axi_adc_debugfs_print_chan_status),
 };
 
 static int adi_axi_adc_probe(struct platform_device *pdev)

-- 
2.45.2


