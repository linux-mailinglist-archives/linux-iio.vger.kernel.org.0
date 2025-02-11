Return-Path: <linux-iio+bounces-15349-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63AD1A30FA0
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2025 16:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8979C7A413C
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2025 15:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA535253329;
	Tue, 11 Feb 2025 15:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="FPFj6iAr"
X-Original-To: linux-iio@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8D425332B;
	Tue, 11 Feb 2025 15:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739287305; cv=none; b=Wksh+IU0dXthbTuZkuEr8tAUhl13II2MsjQrXO+EMnndVuIuIo7D2r679Y7cmU3zfKrgfOn7jmyBDRgHaYTJqTqQw6Sae+8kSDY41R3N7X95HQN/dkN1J0InpN7Gym9dFruK4lgpJ1v3LkhnKdZSqsM8YRV0LYNGEZPU2AgGG8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739287305; c=relaxed/simple;
	bh=DXlJ2gD3TVkjoDWGgoF+1jJVOlRv3qrm/nlLABCC77s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M/HEySssutvo7wD9FBdhiN0bs8obKI1qVZb9Gbffwl/dLpYyMLTUQxrI+7IQGfdsstuKbWROjLwRN1fesjquOA/Cu+xmXZYL5qkZ/s3o1ZGgtwN3f+hGgKOzZSt0VJWJHqUrsYHYqaa2+4TJHdmCChE3IOvwMso3EKnFqFU/qqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=FPFj6iAr; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 45F36A0ABF;
	Tue, 11 Feb 2025 16:21:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=lnd07H6K+00qVcWwkSgQ
	RGOualEQLbdZn+x//xQ7Mmg=; b=FPFj6iAr5CU+JBBscEX1n0uy+yx+lEAonj+v
	2zw2W4hL5lJtZ2nravuyVwLZGoBLRpDMGt/zbnYBX0zKu+nZctQrcfMuEE05zY6x
	Hvn/lIg5OgenPiqx1d5+4tdM5LFbd0trQCXHHlhlyK5MQbdakaTMlqjEoezv4vPe
	iT60+rzfj7hYDfNO1CHxcT5TnbKF/HYFC9lcydls3JDIvFSAzQgi1/lgIh/MVP2O
	TEbUsbq9dLybLyfRXmhENSeZFdMEK1kBf4j90uvXWJdahefi7EBk7AeBvV0vqxrk
	Ut208byCxGEjByjJvQ62OMq1vHWbG7eaLsc8l1yKxjvSz2BM6y5n6JneYBJxnyoG
	T+vv4HPTO7SJz6TF6hMPByr0CVoBsZdSvgGc9iWZ8m/XvDeqzDdhVZk/vavhY0h5
	X42icnZJuUU5Y66TwuBa/ouFxtibV3uxoOAl16K0RuRS8B/oRWACGp5GdbOyiUVp
	Bez3bCP00I2NgAupoDo9U9C5eY2/HmaHVFqxeNpzeW2Tcc6KmwwDBUfcl71oGG7o
	sN7nxuTGha0oaCz5m/WIZ0/X1tbjjcX8z7CDl6d9izqhNkFJ748Tt1NSeFo229vE
	lkVC3E2IkC1Ph5OnLh69/4wP+RsgH3X1CVc3Q6U1bXWfzCiap9JSiDTI7bnor2+B
	SopXbyI=
From: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
To: <linux-arm-kernel@lists.infradead.org>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>,
	<Dharma.B@microchip.com>, Kamel Bouhara <kamel.bouhara@bootlin.com>, "William
 Breathitt Gray" <wbg@kernel.org>
Subject: [PATCH v4 2/2] counter: microchip-tcb-capture: Add capture extensions for registers RA-RC
Date: Tue, 11 Feb 2025 16:19:15 +0100
Message-ID: <20250211151914.313585-7-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250211151914.313585-3-csokas.bence@prolan.hu>
References: <20250211151914.313585-3-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1739287300;VERSION=7985;MC=3490347217;ID=762887;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29ACD94852617160

TCB hardware is capable of capturing the timer value to registers RA and
RB. On top, it is capable of triggering on compare against a third
register, RC. Add these registers as extensions.

Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>
---

Notes:
    Changes in v2:
    * Add IRQs
    Changes in v3:
    * Move IRQs to previous patch
    Changes in v4:
    * Return the status of the regmap_*() operations
    * Add names for the extension numbers

 drivers/counter/microchip-tcb-capture.c       | 62 +++++++++++++++++++
 .../linux/counter/microchip-tcb-capture.h     |  9 +++
 2 files changed, 71 insertions(+)

diff --git a/drivers/counter/microchip-tcb-capture.c b/drivers/counter/microchip-tcb-capture.c
index cc12c2e2113a..369f69aaf14f 100644
--- a/drivers/counter/microchip-tcb-capture.c
+++ b/drivers/counter/microchip-tcb-capture.c
@@ -254,6 +254,66 @@ static int mchp_tc_count_read(struct counter_device *counter,
 	return 0;
 }
 
+static int mchp_tc_count_cap_read(struct counter_device *counter,
+				  struct counter_count *count, size_t idx, u64 *val)
+{
+	struct mchp_tc_data *const priv = counter_priv(counter);
+	u32 cnt;
+	int ret;
+
+	switch (idx) {
+	case COUNTER_MCHP_EXCAP_RA:
+		ret = regmap_read(priv->regmap, ATMEL_TC_REG(priv->channel[0], RA), &cnt);
+		break;
+	case COUNTER_MCHP_EXCAP_RB:
+		ret = regmap_read(priv->regmap, ATMEL_TC_REG(priv->channel[0], RB), &cnt);
+		break;
+	case COUNTER_MCHP_EXCAP_RC:
+		ret = regmap_read(priv->regmap, ATMEL_TC_REG(priv->channel[0], RC), &cnt);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (!ret)
+		*val = cnt;
+
+	return ret;
+}
+
+static int mchp_tc_count_cap_write(struct counter_device *counter,
+				   struct counter_count *count, size_t idx, u64 val)
+{
+	struct mchp_tc_data *const priv = counter_priv(counter);
+	int ret;
+
+	if (val > U32_MAX)
+		return -ERANGE;
+
+	switch (idx) {
+	case COUNTER_MCHP_EXCAP_RA:
+		ret = regmap_write(priv->regmap, ATMEL_TC_REG(priv->channel[0], RA), val);
+		break;
+	case COUNTER_MCHP_EXCAP_RB:
+		ret = regmap_write(priv->regmap, ATMEL_TC_REG(priv->channel[0], RB), val);
+		break;
+	case COUNTER_MCHP_EXCAP_RC:
+		ret = regmap_write(priv->regmap, ATMEL_TC_REG(priv->channel[0], RC), val);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return ret;
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
@@ -262,6 +322,8 @@ static struct counter_count mchp_tc_counts[] = {
 		.num_functions = ARRAY_SIZE(mchp_tc_count_functions),
 		.synapses = mchp_tc_count_synapses,
 		.num_synapses = ARRAY_SIZE(mchp_tc_count_synapses),
+		.ext = mchp_tc_count_ext,
+		.num_ext = ARRAY_SIZE(mchp_tc_count_ext),
 	},
 };
 
diff --git a/include/uapi/linux/counter/microchip-tcb-capture.h b/include/uapi/linux/counter/microchip-tcb-capture.h
index b91d8954f06e..0bef1c9d1535 100644
--- a/include/uapi/linux/counter/microchip-tcb-capture.h
+++ b/include/uapi/linux/counter/microchip-tcb-capture.h
@@ -12,6 +12,9 @@
  * Count 0
  * \__  Synapse 0 -- Signal 0 (Channel A, i.e. TIOA)
  * \__  Synapse 1 -- Signal 1 (Channel B, i.e. TIOB)
+ * \__  Extension capture0    (RA register)
+ * \__  Extension capture1    (RB register)
+ * \__  Extension capture2    (RC register)
  * 
  * It also supports the following events:
  *
@@ -30,6 +33,12 @@ enum counter_mchp_signals {
 	COUNTER_MCHP_SIG_TIOB,
 };
 
+enum counter_mchp_capture_extensions {
+	COUNTER_MCHP_EXCAP_RA,
+	COUNTER_MCHP_EXCAP_RB,
+	COUNTER_MCHP_EXCAP_RC,
+};
+
 enum counter_mchp_event_channels {
 	COUNTER_MCHP_EVCHN_CV = 0,
 	COUNTER_MCHP_EVCHN_RA = 0,
-- 
2.48.1



