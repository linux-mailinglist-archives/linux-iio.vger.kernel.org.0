Return-Path: <linux-iio+bounces-16368-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61570A4E588
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 17:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7398B17DCFE
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 16:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC2D283CBF;
	Tue,  4 Mar 2025 15:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="TfQlwImW"
X-Original-To: linux-iio@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AAAB283C92;
	Tue,  4 Mar 2025 15:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741103551; cv=none; b=aPUVVAxmD4Uvm/qYoBEWZC688l41ANCjEfNMFD6z2FhRcCV5wceejAWbyezc6SyBH/CfRiGND8z0TiL5drLMs5ScdX0xegTs+zItmxazgdnT3e1OUn6mP3QL5JYPlQ8IpGMkYYi6hJ19djr5ibsLvyiXmneAQRs2CCZ56g9Lh6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741103551; c=relaxed/simple;
	bh=iRWDcUtRmxfRKcGy3wuAz3smpd9AKV7GoZAwArM4x/Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o+oyzo2K4du5wXgEysqqdJ4+mNumfmc5d3ZMXQV53BoT+OlVVAyjgOgQDgOTIi3BE1V1EGIE9RCtXKO6fv+lLsSbFcAZ1YORcS9G/ACnL2eKQefFHknnBYkexhHL+8KW6TaGysyLzyP0oEGv8fHUKWZb4+dswxZCXmLKR7gZ6IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=TfQlwImW; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 0B499A06C2;
	Tue,  4 Mar 2025 16:52:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=WmIWZfNW61AlqLDV5lti
	3V+Y+HfZggvgwmSk+uB30ww=; b=TfQlwImWIiuaBo5goUiawgvODWdiEZys0s/J
	UP7u+kDMExYT1dg29p5kwD9L7QYXSI/DYZnoUTj9zwDgQpvX9DQnowO2poArfGWn
	YG+ivLwHug0ceL13BWlOT58HgxueSstrCd7/qcup8ibCsi2jDh43EY83udMSOhA0
	lXffaBb4OGxFFxiKgdL3r1t/NNPjAYP8SVU43B6sO1inVHbqM2FyBXu1gURb2Xql
	ZzbZrLWwlT5MzRTTvP53EsEiOvtXGhhFaFDX1IE/Hpx48yeVUkQp9XAR1dAxx//X
	DZ+n0G4Y8+vobgyjhdkaBtT5B9DcSUn2HprQ0oGhJooCqnXLyh7gr50jr344Ww2P
	9DnMaydN6w5ajIVeRHzjkBrzP925/mL9wV7UyKjtnoiDOcqYEYBV11WUHPwFo+A8
	oYHCUSa+24U6qat3eWF4mSy6I5c5SMPdX8sGSHmGnsxoemv6zajz0fjJRPIvADNT
	tJ3/DV15ufes0h63eh23rirBMy2rNtUkyMY8ULX8wlden+COSXzdWsSmIO/zrssU
	nu6Sts9MhWS4SzxOUupp6grwrgE5QLl9lqAMxN1iGNj47bZIl/1YAWB8o3AsdnR0
	h6ztpfXpn7ospQR0DBcGhqjBftji8dRV/orAEJ/4Z7s0YBWKnqwamuEzBb9aX4q6
	T0bPt6s=
From: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
To: <linux-arm-kernel@lists.infradead.org>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>, "Kamel
 Bouhara" <kamel.bouhara@bootlin.com>, William Breathitt Gray <wbg@kernel.org>
Subject: [PATCH v7 2/2] counter: microchip-tcb-capture: Add capture extensions for registers RA/RB
Date: Tue, 4 Mar 2025 16:51:52 +0100
Message-ID: <20250304155156.374150-3-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250304155156.374150-1-csokas.bence@prolan.hu>
References: <20250304155156.374150-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1741103546;VERSION=7985;MC=2493638075;ID=1544448;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94852637264

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
    Changes in v7:
    * Change enums to #define's in UAPI header
    * Return early on error in `mchp_tc_count_cap_read()`

 drivers/counter/microchip-tcb-capture.c       | 58 +++++++++++++++++++
 .../linux/counter/microchip-tcb-capture.h     |  6 ++
 2 files changed, 64 insertions(+)

diff --git a/drivers/counter/microchip-tcb-capture.c b/drivers/counter/microchip-tcb-capture.c
index cc12c2e2113a..52493f7e8b57 100644
--- a/drivers/counter/microchip-tcb-capture.c
+++ b/drivers/counter/microchip-tcb-capture.c
@@ -254,6 +254,62 @@ static int mchp_tc_count_read(struct counter_device *counter,
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
@@ -262,6 +318,8 @@ static struct counter_count mchp_tc_counts[] = {
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



