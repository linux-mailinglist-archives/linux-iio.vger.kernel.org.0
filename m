Return-Path: <linux-iio+bounces-16469-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD167A54C7C
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 14:45:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84F60171843
	for <lists+linux-iio@lfdr.de>; Thu,  6 Mar 2025 13:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363FB20F08E;
	Thu,  6 Mar 2025 13:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="O+F9Cfm/"
X-Original-To: linux-iio@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EBE20D4F8;
	Thu,  6 Mar 2025 13:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741268697; cv=none; b=RTP0eVyZjISogQxi4ONjystLq1jZO0jwmz/jQHb5brIp3GILM/cq55emloCHraAqcdHuwAVR79PAezOH9NxqTp8rs0zE+m+lqXq5UEXoAobzW6mEhRE0PKcXHfRYzqLKAwQxct26/RREaljZMFpS72Nmxe1ObYv9xQso2wR1K6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741268697; c=relaxed/simple;
	bh=F9dgCsWr6DIuBgV9G3ANFkV3xMeg0+o2L+9mN4tw5hk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QbaQHztdpqoFWB5dX12Sf4He1KaPj/TR+wDBszQkxVeKOTzkLDrUoFjHCdbbPBpRsldB2AQ0FbxGo1WHPw0ShqDh2di9lO819ygWCYMc8WLT71dJjXyTcXF83hjkpLesHLdV7X2K+MazCBKNduM4gbf5AkHMQrsXge4s+iMRbpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=O+F9Cfm/; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id B74E3A0C5E;
	Thu,  6 Mar 2025 14:44:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=eNQAhRGX/wh34NPimgYM
	cgnXW/agDCzGruasLJVYJVs=; b=O+F9Cfm/viKK3zcMxZNg+2mYzecMbzAGFR21
	E3wb/NULHc7hwYf2jpgbKjs6iwbHIlMKIILKUo/wpuWoaVCdCd9GGzwT2sAk5Iew
	4VkrGRdjYHuN0lM95Li2PDAnYu09Cay/JFfNFs9yXxDG8h4/3SDgzsTKhAmuf4U4
	/WPhyZEP7HED0O2GrJ8mdZXB0Vfu5uuTsZsRb8GH9CmUCcB7ULSZ4IdarsOL5FNo
	tAMBd3ClQ/sQBWBzDx1WFbG6S8gM5+uRxWqiAKqVzz3LSMRlOeZEyVef25SgryL2
	BztuEDEiISIBM+2k/9B03oHi2rynoP/59WQffyjSfOXzTOVOvKVQ/pszptVdMbvu
	JZGhG1sCb8V4e1+dG4fG0eAXWXp4aHXG7LcsMdo6tia597MH+86QTTXYTSLArM8R
	LAYOHGBcQTZN0yKU/fpeFviKdIqzq+MUXQgTl5DVd/IUaFMqOKGNjlsI5VAUaNbV
	ZKuhhvzC1CNUjGyHnrnqfZ61MuRnsT8HEa6Z502im+WYQixhXWQOZGsU0CXQ/afQ
	fuIMLnNAPOT9cjhHvx3ZKybhT2o3F6EhwzKfr4w8GdM5XQDx1feKHt9COgZIGMU2
	SIl+9FGG3KPvB8bTWE/w5e2hSPHervFXsYVQCCh/n4cnTaCB/7n/Pmg3Wc5rX8RX
	LDHu3K0=
From: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
To: <linux-arm-kernel@lists.infradead.org>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>, "William
 Breathitt Gray" <wbg@kernel.org>, Kamel Bouhara <kamel.bouhara@bootlin.com>
Subject: [PATCH v8 2/2] counter: microchip-tcb-capture: Add capture extensions for registers RA/RB
Date: Thu, 6 Mar 2025 14:44:37 +0100
Message-ID: <20250306134441.582819-3-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250306134441.582819-1-csokas.bence@prolan.hu>
References: <20250306134441.582819-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1741268685;VERSION=7985;MC=3713256715;ID=1566298;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94852637C6A

TCB hardware is capable of capturing the timer value to registers RA and
RB. Add these registers as capture extensions.

Acked-by: William Breathitt Gray <wbg@kernel.org>
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
    Changes in v6:
    * Remove RC, as it is not a capture register
    Changes in v7:
    * Change enums to #define's in UAPI header
    * Return early on error in `mchp_tc_count_cap_read()`
    Changes in v8:
    * Collect William's tag

 drivers/counter/microchip-tcb-capture.c       | 58 +++++++++++++++++++
 .../linux/counter/microchip-tcb-capture.h     |  6 ++
 2 files changed, 64 insertions(+)

diff --git a/drivers/counter/microchip-tcb-capture.c b/drivers/counter/microchip-tcb-capture.c
index 16707099bd69..aeaee6e0245e 100644
--- a/drivers/counter/microchip-tcb-capture.c
+++ b/drivers/counter/microchip-tcb-capture.c
@@ -253,6 +253,62 @@ static int mchp_tc_count_read(struct counter_device *counter,
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
+	default:
+		return -EINVAL;
+	}
+
+	if (ret < 0)
+		return ret;
+
+	*val = cnt;
+
+	return 0;
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
+	default:
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+static DEFINE_COUNTER_ARRAY_CAPTURE(mchp_tc_cnt_cap_array, 2);
+
+static struct counter_comp mchp_tc_count_ext[] = {
+	COUNTER_COMP_ARRAY_CAPTURE(mchp_tc_count_cap_read, mchp_tc_count_cap_write,
+				   mchp_tc_cnt_cap_array),
+};
+
 static struct counter_count mchp_tc_counts[] = {
 	{
 		.id = 0,
@@ -261,6 +317,8 @@ static struct counter_count mchp_tc_counts[] = {
 		.num_functions = ARRAY_SIZE(mchp_tc_count_functions),
 		.synapses = mchp_tc_count_synapses,
 		.num_synapses = ARRAY_SIZE(mchp_tc_count_synapses),
+		.ext = mchp_tc_count_ext,
+		.num_ext = ARRAY_SIZE(mchp_tc_count_ext),
 	},
 };
 
diff --git a/include/uapi/linux/counter/microchip-tcb-capture.h b/include/uapi/linux/counter/microchip-tcb-capture.h
index f3ef315fe9f6..136e2faa7730 100644
--- a/include/uapi/linux/counter/microchip-tcb-capture.h
+++ b/include/uapi/linux/counter/microchip-tcb-capture.h
@@ -12,6 +12,8 @@
  * Count 0
  * \__  Synapse 0 -- Signal 0 (Channel A, i.e. TIOA)
  * \__  Synapse 1 -- Signal 1 (Channel B, i.e. TIOB)
+ * \__  Extension capture0    (RA register)
+ * \__  Extension capture1    (RB register)
  *
  * It also supports the following events:
  *
@@ -25,6 +27,10 @@
  * - RC compare triggered
  */
 
+/* Capture extensions */
+#define COUNTER_MCHP_EXCAP_RA 0
+#define COUNTER_MCHP_EXCAP_RB 1
+
 /* Event channels */
 #define COUNTER_MCHP_EVCHN_CV 0
 #define COUNTER_MCHP_EVCHN_RA 0
-- 
2.48.1



