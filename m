Return-Path: <linux-iio+bounces-14938-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6AAA2601F
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 17:32:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE7BB16750A
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 16:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC6720B7E0;
	Mon,  3 Feb 2025 16:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="idGHTcRQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4D720AF8E;
	Mon,  3 Feb 2025 16:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738600305; cv=none; b=tPycJOQQXF18fu0A8sVbWHze0K3dEyML0d6I1lUOIZ1gThybcvXR34gD9r+B5RRteuQPDeiFW208cktLKayehWS6TUTZC1pGW/W4woj7b8j95HheDSc5yw0tAnCg0OZn7O+0c5SFhK3bXImGmJ/EEKUsAjH7GXjdT37SY5xrMAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738600305; c=relaxed/simple;
	bh=pGb/zDE/OUDnW3AJ+/h1+wUKS5rddQcaYnC3FG1Jen0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vvx4hbsX9lGCKuUC+1gSI4fyJ+SQSo0d16yDsvVARlwPXtT3NV9BUlxUExxyQ3PG4sl9aw0NEXR4w4zKjp3XXMncJZHlU89Fdxhmqkq0uOVU2lNnulnQ1zRLsZmq9r/911+U7ffhhzToXq81EavWIO86qPambcAhvqNnJgcdoz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=idGHTcRQ; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 6E7D2A0E19;
	Mon,  3 Feb 2025 17:31:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=HK4s81J1k83QEgvXWPtd
	0kbv6ClLvjUueZlqzkVxOI8=; b=idGHTcRQINOpTLzJwksjtJJDi4dieWUuSG+v
	gcYcbDKv3TiaHEIYmC8rW+iFS3oCDIoFtIQVHBbySXMk0P3SoFYMs48c1Uj/uSYl
	EhqmTJ2pzfVLYzuY5flTsnmT8kXNTKlWYsjBmI1PrApj6FTlcy+Z+ywEc0i4qEIR
	6ydIRymdwJ/NBCEvAXb/gr6mrRUBoUIYzsOfnv7JB1eEt/9AWXa5D/VvVbHT03X+
	XgnIat6UDbOb5e7WRc1TfzJglnxk1EVvbFvqCrIOObME6yaawX473zbWHWvtb7aJ
	+nmKygQTiK9lwl/saAvKQUFb0jxnYN+GQgXnQiRDTXi5Kzv1cC4oorjKy/g9Ou44
	sysmA3h7PDW8iWC1npMiTL92dDSl3ELQQSvmWjOo4ZUciME/bUeWh5b8pqQ6C+LL
	yqGlrSHhNNTV1PFDIGYl+BiopL5XC6iqKnzpjH7sLiuZZFXl1AIIofdzuWKmqSjG
	tCQCJzhkKVLiiTELy0Dc8ZpdtyT9MIMx3EifRMvST/VNT1ZCTYT0/rVG/3EP95P4
	kFGsZw1RAxzAefT4tJgKDtYB4dSlbfbRysX343AP0oBoZz+9qwFtjxxiv3SO8+R3
	i6PTgG5SNEePWOrisksBSj9qceUxmy8Ma20F00okcxUax2Eee/x8FY4PXjArzMWV
	cfs0OF8=
From: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
To: <linux-arm-kernel@lists.infradead.org>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>, "Kamel
 Bouhara" <kamel.bouhara@bootlin.com>, William Breathitt Gray <wbg@kernel.org>
Subject: [PATCH v2 2/2] counter: microchip-tcb-capture: Add capture extensions for registers RA-RC
Date: Mon, 3 Feb 2025 17:29:53 +0100
Message-ID: <20250203162955.102559-2-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250203162955.102559-1-csokas.bence@prolan.hu>
References: <20250203162955.102559-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1738600299;VERSION=7984;MC=3773513757;ID=183986;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94852667064

TCB hardware is capable of capturing the timer value to registers RA and
RB. On top, it is capable of triggering on compare against a third
register, RC. Add these registers as extensions.

Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>
---
 drivers/counter/microchip-tcb-capture.c | 65 ++++++++++++++++++++++++-
 1 file changed, 64 insertions(+), 1 deletion(-)

diff --git a/drivers/counter/microchip-tcb-capture.c b/drivers/counter/microchip-tcb-capture.c
index 316755c7659a..a25b54493c7f 100644
--- a/drivers/counter/microchip-tcb-capture.c
+++ b/drivers/counter/microchip-tcb-capture.c
@@ -20,7 +20,8 @@
 				 ATMEL_TC_ETRGEDG_RISING | ATMEL_TC_LDBDIS | \
 				 ATMEL_TC_LDBSTOP)
 
-#define ATMEL_TC_DEF_IRQS	(ATMEL_TC_ETRGS | ATMEL_TC_COVFS)
+#define ATMEL_TC_DEF_IRQS	(ATMEL_TC_ETRGS | ATMEL_TC_COVFS | \
+				 ATMEL_TC_LDRAS | ATMEL_TC_LDRBS)
 
 #define ATMEL_TC_QDEN			BIT(8)
 #define ATMEL_TC_POSEN			BIT(9)
@@ -252,6 +253,62 @@ static int mchp_tc_count_read(struct counter_device *counter,
 	return 0;
 }
 
+static int mchp_tc_count_cap_read(struct counter_device *counter,
+				  struct counter_count *count, size_t idx, u64 *val)
+{
+	struct mchp_tc_data *const priv = counter_priv(counter);
+	u32 cnt;
+
+	switch (idx) {
+	case 0:
+		regmap_read(priv->regmap, ATMEL_TC_REG(priv->channel[0], RA), &cnt);
+		break;
+	case 1:
+		regmap_read(priv->regmap, ATMEL_TC_REG(priv->channel[0], RB), &cnt);
+		break;
+	case 2:
+		regmap_read(priv->regmap, ATMEL_TC_REG(priv->channel[0], RC), &cnt);
+		break;
+	default:
+		return -EINVAL;
+	}
+	*val = cnt;
+
+	return 0;
+}
+
+static int mchp_tc_count_cap_write(struct counter_device *counter,
+				   struct counter_count *count, size_t idx, u64 val)
+{
+	struct mchp_tc_data *const priv = counter_priv(counter);
+
+	if (val > U32_MAX)
+		return -ERANGE;
+
+	switch (idx) {
+	case 0:
+		regmap_write(priv->regmap, ATMEL_TC_REG(priv->channel[0], RA), val);
+		break;
+	case 1:
+		regmap_write(priv->regmap, ATMEL_TC_REG(priv->channel[0], RB), val);
+		break;
+	case 2:
+		regmap_write(priv->regmap, ATMEL_TC_REG(priv->channel[0], RC), val);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static DEFINE_COUNTER_ARRAY_CAPTURE(mchp_tc_cnt_cap_array, 3);
+
+static struct counter_comp mchp_tc_count_ext[] = {
+	COUNTER_COMP_ARRAY_CAPTURE(mchp_tc_count_cap_read, mchp_tc_count_cap_write,
+				   mchp_tc_cnt_cap_array),
+};
+
 static struct counter_count mchp_tc_counts[] = {
 	{
 		.id = 0,
@@ -260,6 +317,8 @@ static struct counter_count mchp_tc_counts[] = {
 		.num_functions = ARRAY_SIZE(mchp_tc_count_functions),
 		.synapses = mchp_tc_count_synapses,
 		.num_synapses = ARRAY_SIZE(mchp_tc_count_synapses),
+		.ext = mchp_tc_count_ext,
+		.num_ext = ARRAY_SIZE(mchp_tc_count_ext),
 	},
 };
 
@@ -314,6 +373,10 @@ static irqreturn_t mchp_tc_isr(int irq, void *dev_id)
 
 	if (sr & ATMEL_TC_ETRGS)
 		counter_push_event(counter, COUNTER_EVENT_CHANGE_OF_STATE, 0);
+	if (sr & ATMEL_TC_LDRAS)
+		counter_push_event(counter, COUNTER_EVENT_CAPTURE, 0);
+	if (sr & ATMEL_TC_LDRBS)
+		counter_push_event(counter, COUNTER_EVENT_CAPTURE, 1);
 	if (sr & ATMEL_TC_COVFS)
 		counter_push_event(counter, COUNTER_EVENT_OVERFLOW, 0);
 
-- 
2.48.1



