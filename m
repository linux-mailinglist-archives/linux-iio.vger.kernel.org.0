Return-Path: <linux-iio+bounces-14732-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1871A23082
	for <lists+linux-iio@lfdr.de>; Thu, 30 Jan 2025 15:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59BCA167AAF
	for <lists+linux-iio@lfdr.de>; Thu, 30 Jan 2025 14:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1A01E8840;
	Thu, 30 Jan 2025 14:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="U0wkuDXZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B1D1BB6BC;
	Thu, 30 Jan 2025 14:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738247910; cv=none; b=ISZHORS1Ko5CL4hCJSaQQNvW/eWirMnWRtLoz1DjKMJG56mrMoGudh9FPJHi33vWFyd4D2Er4c8sgm8LgsXJQNaNTTOTkMRx/vwXgaan2r3CFI4NlU88G13vBFn14OORiePzIM2Vl3eN/0EnmSfs4SzYrNih4KQhEJ0iAbO1kZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738247910; c=relaxed/simple;
	bh=JV7b0o3v1+xzAtErM1HhLNkNgRvCoFydIlxgoByPDWY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JDbc+evO8/IYvfRgTFhtIzzlfkEIek9Jr+2fwD2Zlj3n7y4P6wY/GvNFUPzQKxkOgnvX2oFDYslQdMjuvxAKhviYP6/L9A8sdNNvu3wfT/oDdS5098md1E/j9m3ytB50iREoPoWWjgiz8Jwou0HDIorLIwtqphb/GI2ck0leUvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=U0wkuDXZ; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 66B9DA0A58;
	Thu, 30 Jan 2025 15:38:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=4shPxN5Zjg8CWO7oqCIY3l3k+e0q+fmoz+kF6bIkmVM=; b=
	U0wkuDXZ+YCja8dGH6AgFVUuhRRiTGpVsVSgrioEsLNMSaRslidLO77DUIz95Fvg
	LJqArNXFUbe+iqINh8q6JwEVMFrbOKWxKw44i2iTbQs9JUeeYOsrqCco1iG+EOpm
	0CuZ8fY1Pecu6VbX9mz5AOWSavH3W+T6aISUqYv78/JLihcKJ/bTGdz05ICqv6Fb
	HCp1EtU3wq3IUQftnD+Nc2A/2Md0pa/FWr5Q/+cSIgPlFs/3bhasMhH6bPK8O88Z
	Q52FtabKvw4/JcHIQrM9D+vDBRBzHePWb3p4nP3U5JKOh/mV+HFVRZPcGCJwRpMt
	MfwkhHmjgNyDz3PPj9UX1rr7n49koEDj1oIJ2Gf3d0vdC9gKWG/Ke+gKFCqyW8a6
	rKxqZfc5udt8/BGNEYdAMDOxyGD3toCnHmDq3HOsAn3kYuEg+EdqFbiAvor0WSPl
	XhpoaUb34qBhfc6Lgvg8Xc/B+Ayz6y9G2xZwxx7IKJph43piKHeJVIU7W4tsyHD+
	5GE4BgXNDusoNpGH410FCvwDk+BSqd6q2yXmpOrSTSLdDD97KtRKNBa2HH6fK8NY
	a325R2RuPYzDpYeuGeBbzOFVnZS3FLLq5vZTDx3HwFDvfF2QQaBReBfkSfSpP63L
	8jdxXRNOIIcMxyc97HbxaUnhlTCZ/45i8IaN7ES2yxM=
From: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
To: <linux-arm-kernel@lists.infradead.org>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>, "Kamel
 Bouhara" <kamel.bouhara@bootlin.com>, William Breathitt Gray <wbg@kernel.org>
Subject: [PATCH] counter: microchip-tcb-capture: Add capture extensions for registers RA-RC
Date: Thu, 30 Jan 2025 15:38:16 +0100
Message-ID: <20250130143817.41625-1-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1738247904;VERSION=7984;MC=3846925481;ID=123382;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94852667464

TCB hardware is capable of capturing the timer value to registers RA and
RB. On top, it is capable of triggering on compare against a third
register, RC. Add these registers as extensions.

Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>
---
 drivers/counter/microchip-tcb-capture.c | 58 +++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/drivers/counter/microchip-tcb-capture.c b/drivers/counter/microchip-tcb-capture.c
index 2f096a5b973d..524b9edfaa5f 100644
--- a/drivers/counter/microchip-tcb-capture.c
+++ b/drivers/counter/microchip-tcb-capture.c
@@ -247,6 +247,62 @@ static int mchp_tc_count_read(struct counter_device *counter,
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
@@ -255,6 +311,8 @@ static struct counter_count mchp_tc_counts[] = {
 		.num_functions = ARRAY_SIZE(mchp_tc_count_functions),
 		.synapses = mchp_tc_count_synapses,
 		.num_synapses = ARRAY_SIZE(mchp_tc_count_synapses),
+		.ext = mchp_tc_count_ext,
+		.num_ext = ARRAY_SIZE(mchp_tc_count_ext),
 	},
 };
 
-- 
2.48.1



