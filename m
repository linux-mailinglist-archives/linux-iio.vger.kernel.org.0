Return-Path: <linux-iio+bounces-15464-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A46CEA32E5C
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 19:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3741A188B55E
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 18:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35099261383;
	Wed, 12 Feb 2025 18:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="CgKINxgb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A55F25E469;
	Wed, 12 Feb 2025 18:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739384254; cv=none; b=HCV/GSY3s5xsyIWlYcEwPIRTwJQVoppeyAinN4CdrCHVLkLsZrUIjP0yvwMUQuUKeomEi0WH2UvhpqjyBPw9Shi6YbECWCqqqS4jUOg1u21u5q1L00DEBct2o6xnKvwVISVIgkd3+hcN65Sy8gGd6T1HuLNO/NRcf9MltbGb7xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739384254; c=relaxed/simple;
	bh=kUmKJv0GfNQrUl8osnUZZXl3POk0VWPIq/3jyKqc1IY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZgMykdBtqjoq2siAb6Qk8FGcAV2udDKM7Gl22v/zyJHMeaCdgQuE/bkvZrzrWHhrWBM8euVDzRmjuSE9C7MXXxaqgZWV8xVPM8h4uNneOLXPIvcu9xgflLaJrIz4u+M3n0kpPKSBuP1/Iz6KKSR+urAwUWR83cPSC0HJQb81FrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=CgKINxgb; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51CFHXK1023492;
	Wed, 12 Feb 2025 13:17:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=jO2Le
	GGEao7dGw1KHFZvHlnUzSOYYyv7pKbkUXxLTas=; b=CgKINxgbow4NGCosdmAz0
	f8EquMmuNc6nLk0SwVtsouSWL5P/mJq44V5LyrKhwQ24J+mTLDG/LjbCgJncjanN
	Y3D9MJsXHx21Lj9m/Ts0y9sIUeSRbzlyWRehdJj9bWU90S79N0R62d54xQKj67qU
	1Tv3eapmt/SuZqNhOgDAm8NLEMrG9C3FNzY3NQHJx5NTQMyseT4R5wIPjAE66Kt8
	6Nf/nJtQQgqxn71AoqymbJZgp99vdDXPVH9O7kQfMCf/kXwMOXFXNghY/KRB5V5A
	9s44OiTsKQXjs1iNodRAOvltFFHcgPXCAEg9MuAYZK5UCGAEhZ7837vtnGjrxRCP
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 44rnspk2p5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Feb 2025 13:17:19 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 51CIHHUj046467
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 12 Feb 2025 13:17:17 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Wed, 12 Feb
 2025 13:17:17 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 12 Feb 2025 13:17:17 -0500
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 51CIH41o017470;
	Wed, 12 Feb 2025 13:17:06 -0500
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <marcelo.schmitt@analog.com>,
        <jic23@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <jonath4nns@gmail.com>,
        <marcelo.schmitt1@gmail.com>, <dlechner@baylibre.com>
Subject: [PATCH RESEND v3 07/17] iio: adc: ad7768-1: remove unnecessary locking
Date: Wed, 12 Feb 2025 15:17:02 -0300
Message-ID: <f866c5e181e9e77f4179c44a857cebd60dce32d2.1739368121.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1739368121.git.Jonathan.Santos@analog.com>
References: <cover.1739368121.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=RZxqC0tv c=1 sm=1 tr=0 ts=67ace5af cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=T2h4t0Lz3GQA:10 a=gAnH3GRIAAAA:8 a=YKUZDo64jDh34TQBkAoA:9 a=HOKUp-T_m03RWEGt0Vq5:22 a=oVHKYsEdi7-vN-J5QA_j:22
X-Proofpoint-GUID: rOrUSvq2YS-OtapF5VFlJS0PA6TbDK40
X-Proofpoint-ORIG-GUID: rOrUSvq2YS-OtapF5VFlJS0PA6TbDK40
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-12_05,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 adultscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 mlxlogscore=999 lowpriorityscore=0 phishscore=0 clxscore=1015 spamscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502120132

The current locking is only preventing a triggered buffer Transfer and a
debugfs register access from happening at the same time. If a register
access happens during a buffered read, the action is doomed to fail anyway,
since we need to write a magic value to exit continuous read mode.

Remove locking from the trigger handler and use
iio_device_claim_direct_mode() instead in the register access function.

Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
v3 Changes:
* Also removed the mutex_init and lock variable.

v2 Changes:
* New patch in v2. It replaces the guard(mutex) patch. 
---
 drivers/iio/adc/ad7768-1.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index 2e2d50ccb744..f5509a0a36ab 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -154,7 +154,6 @@ static const struct iio_chan_spec ad7768_channels[] = {
 struct ad7768_state {
 	struct spi_device *spi;
 	struct regulator *vref;
-	struct mutex lock;
 	struct clk *mclk;
 	unsigned int mclk_freq;
 	unsigned int samp_freq;
@@ -256,18 +255,21 @@ static int ad7768_reg_access(struct iio_dev *indio_dev,
 	struct ad7768_state *st = iio_priv(indio_dev);
 	int ret;
 
-	mutex_lock(&st->lock);
+	ret = iio_device_claim_direct_mode(indio_dev);
+	if (ret)
+		return ret;
+
 	if (readval) {
 		ret = ad7768_spi_reg_read(st, reg, 1);
 		if (ret < 0)
-			goto err_unlock;
+			goto err_release;
 		*readval = ret;
 		ret = 0;
 	} else {
 		ret = ad7768_spi_reg_write(st, reg, writeval);
 	}
-err_unlock:
-	mutex_unlock(&st->lock);
+err_release:
+	iio_device_release_direct_mode(indio_dev);
 
 	return ret;
 }
@@ -471,18 +473,15 @@ static irqreturn_t ad7768_trigger_handler(int irq, void *p)
 	struct ad7768_state *st = iio_priv(indio_dev);
 	int ret;
 
-	mutex_lock(&st->lock);
-
 	ret = spi_read(st->spi, &st->data.scan.chan, 3);
 	if (ret < 0)
-		goto err_unlock;
+		goto out;
 
 	iio_push_to_buffers_with_timestamp(indio_dev, &st->data.scan,
 					   iio_get_time_ns(indio_dev));
 
-err_unlock:
+out:
 	iio_trigger_notify_done(indio_dev->trig);
-	mutex_unlock(&st->lock);
 
 	return IRQ_HANDLED;
 }
@@ -611,8 +610,6 @@ static int ad7768_probe(struct spi_device *spi)
 
 	st->mclk_freq = clk_get_rate(st->mclk);
 
-	mutex_init(&st->lock);
-
 	indio_dev->channels = ad7768_channels;
 	indio_dev->num_channels = ARRAY_SIZE(ad7768_channels);
 	indio_dev->name = spi_get_device_id(spi)->name;
-- 
2.34.1


