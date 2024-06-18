Return-Path: <linux-iio+bounces-6483-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D7990D2C6
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 15:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76D172843B1
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 13:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AAD114B94E;
	Tue, 18 Jun 2024 13:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ZFGZLg0B"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0D9149E1D
	for <linux-iio@vger.kernel.org>; Tue, 18 Jun 2024 13:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718717333; cv=none; b=QWeFpOdqpr97CH8UGHYF/iRDHbN+uQT7zH5+uj98cmPCUMNkc+3SRc3s+8kCLigq68KpiXsL5S3AcG+iBBhxChs0Ja355FTLPsrMdppB/r5Mn9jJ8KVlXjpZ4alkM3FAb8wAFDHGHqcCGBe0dD0souTF7gTwar28m7nk0kpWsXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718717333; c=relaxed/simple;
	bh=Czkii9LBMSqlF69xDNYcriYmBbaH0KxA3jRBoU9qajg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=I3gMcrH2pxVFpIJ2Yba5+O26x75YQTIiFtp7y4SDmM0h9IGWxM1r6P4JQgWfpD40zrrZKUHEsN+rkMMCNgS3fbZ6kihuYiikPAg7LdJuxI+grrw3gdKKzCdwbYLT3WCdXOUO05S1TpHx0bx2CcOXek0rCYBG9CXOUJJM7FCcFGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ZFGZLg0B; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45I9MBLF007179;
	Tue, 18 Jun 2024 09:28:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=ilubp
	26yzCXXE/sKuqOcK1X5GJ+YEE3iWs1v3ab6ARQ=; b=ZFGZLg0BH7L7MmHiagpCl
	1wpqj7NJZzCfyl8pZUS6W3T3JT2kQ7K6SuOByJOxe+aDU/hm2vRgoXBMyLr54WER
	a2tv7TbP1SCftxBRNwtpyZeOlE7rUuY2NOObg9t7sydKjq2jWqmzUt71X8BxhosH
	Zzc9l3B1VJvj1RN1Jsjzb2i72muRHR4RwfRL1XQMIXcBTuxrgTkLplnENExDcMt1
	BgMonqz/1dfx+LhcoBIzR+J+hemB9qKIyPlC7syUbDryaT5F8QK5+KFwdG51iMVf
	cXykOYuhFwmWA7L7fUCkTLE+UXNrfr68qcNIA7JyZDqHaa9IyBhkwx/JVDAmbjEo
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3ys4t33by8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 09:28:40 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 45IDSc9u062021
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 18 Jun 2024 09:28:38 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Tue, 18 Jun
 2024 09:28:38 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 18 Jun 2024 09:28:38 -0400
Received: from [127.0.0.1] ([10.44.3.56])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 45IDSLWS025769;
	Tue, 18 Jun 2024 09:28:32 -0400
From: Nuno Sa <nuno.sa@analog.com>
Date: Tue, 18 Jun 2024 15:32:11 +0200
Subject: [PATCH 8/9] iio: imu: adis16475: make use of the new lock helpers
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240618-dev-iio-adis-cleanup-v1-8-bd93ce7845c7@analog.com>
References: <20240618-dev-iio-adis-cleanup-v1-0-bd93ce7845c7@analog.com>
In-Reply-To: <20240618-dev-iio-adis-cleanup-v1-0-bd93ce7845c7@analog.com>
To: <linux-iio@vger.kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718717531; l=4293;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=Czkii9LBMSqlF69xDNYcriYmBbaH0KxA3jRBoU9qajg=;
 b=nLkShTQD0eeNtvalwdTMv5ecUi0xYOC6HyvQgo2cE03Z+YInDpbtGT4aD7GsODlYmvu5fx95h
 DmK+4+q93hvAH61H79eRTxtChI/LRAG2gNoj2eU3H4hj8EMPbd/LrDc
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: mWdd-GsrhY1S3dMS1m3KIa4Lh2OwkQ9l
X-Proofpoint-ORIG-GUID: mWdd-GsrhY1S3dMS1m3KIa4Lh2OwkQ9l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_02,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 malwarescore=0 adultscore=0 suspectscore=0 mlxlogscore=809 spamscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406180100

Use the new auto cleanup based locks so error paths are simpler.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/imu/adis16475.c | 43 ++++++++++++++-----------------------------
 1 file changed, 14 insertions(+), 29 deletions(-)

diff --git a/drivers/iio/imu/adis16475.c b/drivers/iio/imu/adis16475.c
index cf73c6f46c79..78ceebf5023c 100644
--- a/drivers/iio/imu/adis16475.c
+++ b/drivers/iio/imu/adis16475.c
@@ -302,30 +302,25 @@ static int adis16475_get_freq(struct adis16475 *st, u32 *freq)
 	u16 dec;
 	u32 sample_rate = st->clk_freq;
 
-	adis_dev_lock(&st->adis);
+	adis_dev_auto_lock(&st->adis);
 
 	if (st->sync_mode == ADIS16475_SYNC_SCALED) {
 		u16 sync_scale;
 
 		ret = __adis_read_reg_16(&st->adis, ADIS16475_REG_UP_SCALE, &sync_scale);
 		if (ret)
-			goto error;
+			return ret;
 
 		sample_rate = st->clk_freq * sync_scale;
 	}
 
 	ret = __adis_read_reg_16(&st->adis, ADIS16475_REG_DEC_RATE, &dec);
 	if (ret)
-		goto error;
-
-	adis_dev_unlock(&st->adis);
+		return ret;
 
 	*freq = DIV_ROUND_CLOSEST(sample_rate, dec + 1);
 
 	return 0;
-error:
-	adis_dev_unlock(&st->adis);
-	return ret;
 }
 
 static int adis16475_set_freq(struct adis16475 *st, const u32 freq)
@@ -340,7 +335,7 @@ static int adis16475_set_freq(struct adis16475 *st, const u32 freq)
 	if (!freq)
 		return -EINVAL;
 
-	adis_dev_lock(&st->adis);
+	adis_dev_auto_lock(&st->adis);
 	/*
 	 * When using sync scaled mode, the input clock needs to be scaled so that we have
 	 * an IMU sample rate between (optimally) int_clk - 100 and int_clk + 100.
@@ -385,7 +380,7 @@ static int adis16475_set_freq(struct adis16475 *st, const u32 freq)
 		sync_scale = scaled_rate / st->clk_freq;
 		ret = __adis_write_reg_16(&st->adis, ADIS16475_REG_UP_SCALE, sync_scale);
 		if (ret)
-			goto error;
+			return ret;
 
 		sample_rate = scaled_rate;
 	}
@@ -400,7 +395,7 @@ static int adis16475_set_freq(struct adis16475 *st, const u32 freq)
 
 	ret = __adis_write_reg_16(&st->adis, ADIS16475_REG_DEC_RATE, dec);
 	if (ret)
-		goto error;
+		return ret;
 
 	adis_dev_unlock(&st->adis);
 	/*
@@ -410,9 +405,6 @@ static int adis16475_set_freq(struct adis16475 *st, const u32 freq)
 	assign_bit(ADIS16475_LSB_DEC_MASK, &st->lsb_flag, dec);
 
 	return 0;
-error:
-	adis_dev_unlock(&st->adis);
-	return ret;
 }
 
 /* The values are approximated. */
@@ -541,19 +533,15 @@ static int adis16475_buffer_postdisable(struct iio_dev *indio_dev)
 	struct adis *adis = &st->adis;
 	int ret;
 
-	adis_dev_lock(&st->adis);
+	adis_dev_auto_lock(&st->adis);
 
 	ret = __adis_update_bits(adis, ADIS16475_REG_FIFO_CTRL,
 				 ADIS16575_FIFO_EN_MASK, (u16)ADIS16575_FIFO_EN(0));
 	if (ret)
-		goto unlock;
+		return ret;
 
-	ret = __adis_write_reg_16(adis, ADIS16475_REG_GLOB_CMD,
-				  ADIS16575_FIFO_FLUSH_CMD);
-
-unlock:
-	adis_dev_unlock(&st->adis);
-	return ret;
+	return __adis_write_reg_16(adis, ADIS16475_REG_GLOB_CMD,
+				   ADIS16575_FIFO_FLUSH_CMD);
 }
 
 static const struct iio_buffer_setup_ops adis16475_buffer_ops = {
@@ -567,20 +555,18 @@ static int adis16475_set_watermark(struct iio_dev *indio_dev, unsigned int val)
 	int ret;
 	u16 wm_lvl;
 
-	adis_dev_lock(&st->adis);
+	adis_dev_auto_lock(&st->adis);
 
 	val = min_t(unsigned int, val, ADIS16575_MAX_FIFO_WM);
 
 	wm_lvl = ADIS16575_WM_LVL(val - 1);
 	ret = __adis_update_bits(&st->adis, ADIS16475_REG_FIFO_CTRL, ADIS16575_WM_LVL_MASK, wm_lvl);
 	if (ret)
-		goto unlock;
+		return ret;
 
 	st->fifo_watermark = val;
 
-unlock:
-	adis_dev_unlock(&st->adis);
-	return ret;
+	return 0;
 }
 
 static const u32 adis16475_calib_regs[] = {
@@ -1745,7 +1731,7 @@ static irqreturn_t adis16475_trigger_handler_with_fifo(int irq, void *p)
 	int ret;
 	u16 fifo_cnt, i;
 
-	adis_dev_lock(&st->adis);
+	adis_dev_auto_lock(&st->adis);
 
 	ret = __adis_read_reg_16(adis, ADIS16575_REG_FIFO_CNT, &fifo_cnt);
 	if (ret)
@@ -1781,7 +1767,6 @@ static irqreturn_t adis16475_trigger_handler_with_fifo(int irq, void *p)
 	 * reading data from registers will impact the FIFO reading.
 	 */
 	adis16475_burst32_check(st);
-	adis_dev_unlock(&st->adis);
 	iio_trigger_notify_done(indio_dev->trig);
 
 	return IRQ_HANDLED;

-- 
2.45.2


