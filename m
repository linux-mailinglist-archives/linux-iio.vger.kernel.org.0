Return-Path: <linux-iio+bounces-16131-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09007A48224
	for <lists+linux-iio@lfdr.de>; Thu, 27 Feb 2025 15:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55D7C17E8C9
	for <lists+linux-iio@lfdr.de>; Thu, 27 Feb 2025 14:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1503A14A4E7;
	Thu, 27 Feb 2025 14:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="NXs/Siaj"
X-Original-To: linux-iio@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DFA239561;
	Thu, 27 Feb 2025 14:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740667265; cv=none; b=XGbRpUSEk8tpqEa93bCD3Zc1Eif9uKmeVFs2trpMsNORnkNXBtPws0MPiDHpZwNE24EnsixI5aiYc5z/+EHOAHZlGHsROj4ufUC+/GD5nfje5Srv6migzwKx7emBDGfGn1HcOh8/XANAEUvyoctCFq9tjaRZdIbUtsWTx08A+IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740667265; c=relaxed/simple;
	bh=N3lTEQDrw6c7LygGNJXaKT7D763HBGcbhJBy/5sCNdU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U0D4pyAez2E+v8GIIZA1DQk5oHCu5otojb5EGpXDlcrbw6LW2F2wOCZ1eN4kUIueYx3hRZfEHSCPQ66Wi1c9RBvQQIkoNG1qeK0ilVSyQLlkwnOAwaubUR6uGT9rfg2fM3no5LX70vmeak/8B0ZfvTpsC3gMg4WWuMMXYmU5ghM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=NXs/Siaj; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id B910CA02D7;
	Thu, 27 Feb 2025 15:41:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=RgGNxrUr8LJkEzv7yIWY
	EgpM/6tPuhZMATjWdJfm/zw=; b=NXs/Siajzan1KhEv6oKWql6dKV5jRSIIaMJc
	qEkz6blskcKq/6QfeXZgj8sePbd/sN+hlrgRasMgcBJu071PqzNojDDv8c3DCiZe
	qgq2d5fxsdMSXD6kwsvzhp0LVB4xQnhFjwv46WX7byeY6uSOQ9ns3TZtS+Qx7LSi
	0xBTPKReuSfI9DqkDPvGHhXN+d/w55MjZKNuIK/6UQR/I5EMkvH1Z7ULybrHZdEC
	kGMTIiFpZFm64PDojncyh4yYqibJaq+FWQyt0FBJDuodqq/LHgc3A/GBhfsWvK6T
	zogrPu5QZhvkxq2gK79Yvb6Z4Zld5qYJQdyv9gNdo1Ez8acSve2Evih8CkjCDLyw
	Kh0tt/IUwEw3cjh75bcPeX1xqki7T2Hka5ZW6Y7I7Ph9reJWQI4NUhf9BHg54Cxq
	Mchg/47qe/JE2shmX8hOYN/s4eOVvl7MKUmSbEiIYF2R/+Kl+lj6dqMK8mE/6wzD
	nS+2ReFSgAIA4/tLTN8hdooTj4CHKb2JCxo9ncN0FHhkYahEfskEh6xdyoDZ6A1a
	vfyJmti7pk8bOfrtPwckSaSXQF6zyu57PozQyPEC69Z+4sTE09FbIxfhIw2n4Tqf
	vCN4crg/RNOU7LrLm4Zsz1GCG+Y5HIcjHD5SzvpjiXeKIeVmU9ZNGTYHtXXfPWiM
	y9u2+j0=
From: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
To: <linux-arm-kernel@lists.infradead.org>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>, "Kamel
 Bouhara" <kamel.bouhara@bootlin.com>, William Breathitt Gray <wbg@kernel.org>
Subject: [PATCH v6 3/3] counter: microchip-tcb-capture: Add capture extensions for registers RA/RB
Date: Thu, 27 Feb 2025 15:40:20 +0100
Message-ID: <20250227144023.64530-4-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227144023.64530-1-csokas.bence@prolan.hu>
References: <20250227144023.64530-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1740667261;VERSION=7985;MC=2016132060;ID=1459478;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94852637760

TCB hardware is capable of capturing the timer value to registers RA and
RB. Add these registers as capture extensions.

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

 drivers/counter/microchip-tcb-capture.c       | 56 +++++++++++++++++++
 .../linux/counter/microchip-tcb-capture.h     |  9 +++
 2 files changed, 65 insertions(+)

diff --git a/drivers/counter/microchip-tcb-capture.c b/drivers/counter/microchip-tcb-capture.c
index cc12c2e2113a..4ba5e29138e7 100644
--- a/drivers/counter/microchip-tcb-capture.c
+++ b/drivers/counter/microchip-tcb-capture.c
@@ -254,6 +254,60 @@ static int mchp_tc_count_read(struct counter_device *counter,
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
@@ -262,6 +316,8 @@ static struct counter_count mchp_tc_counts[] = {
 		.num_functions = ARRAY_SIZE(mchp_tc_count_functions),
 		.synapses = mchp_tc_count_synapses,
 		.num_synapses = ARRAY_SIZE(mchp_tc_count_synapses),
+		.ext = mchp_tc_count_ext,
+		.num_ext = ARRAY_SIZE(mchp_tc_count_ext),
 	},
 };
 
diff --git a/include/uapi/linux/counter/microchip-tcb-capture.h b/include/uapi/linux/counter/microchip-tcb-capture.h
index ee72f1463594..5c015fafe42c 100644
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



