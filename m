Return-Path: <linux-iio+bounces-15031-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE8CA288AC
	for <lists+linux-iio@lfdr.de>; Wed,  5 Feb 2025 12:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 590CC188361C
	for <lists+linux-iio@lfdr.de>; Wed,  5 Feb 2025 11:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090BC22E41D;
	Wed,  5 Feb 2025 10:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="OM7D9kN/"
X-Original-To: linux-iio@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B97B22CBF3;
	Wed,  5 Feb 2025 10:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738752607; cv=none; b=T4mKCubgLra5ZPqwnJg1k85+1Zucg4bmeeT8QV/pafPuRY37oC9jwm+DPTZWLq77Ynatn0iDPnysJy9nWvv3cx9gPrt6snrQ4gfay/JEwc505617xf85/qQwzWYOUBbg26fARJYZbgk2agqwIgkios9e6u2N7Yq56WlXukNhHzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738752607; c=relaxed/simple;
	bh=in+9r1+ZwwgpczNqt0GEjPoTTCLm/g7wMs5PxZLd5GY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uivMh33So5qRpgi9gGo4D2zleTryb+IafqIvuuFfKq+Q0JyXtaIgHj3JM4CendwcvZm91j98ysogQcyMAGzQyxN6qwFESy7QonW8dCL6eCEl6tcjdDAsW4kzFfc5isEHIOtXlL2CSPHNgPfmibELip81IUzb3JkY5qLuQYQpj0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=OM7D9kN/; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id A2A45A0530;
	Wed,  5 Feb 2025 11:50:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=SDare0wXthcUSCxt8tJM
	hXyNRKnHO97BD3ndLeOmDBI=; b=OM7D9kN/qdhvVKfFyRJIY7EmIiYKzs5biVhP
	SYV12ZKf8A4UtWWnswMGsznVS+CQBPHxIRhewTGcXK8mhHG6OXTKX1/kvkVk+XQc
	mX5aZd2TQGnB5YFahlKb5/hUevWts/95fdAim5TAiQVHurym71JkR0bE8WvIkWjE
	0NUIiBZECxHwT6iCbeXeDb1aMmwY5au9rfSZTHfe6JO5jN0AfZuOpWVL/f1E+71o
	656E7X4y06qx9PexxX4e1xR1rjP5q42VM0I+hYMHjuWXb4neA9+QhwL1VDDGLmVF
	CQkB1aewiXM39KNJyrT250wC7DAln3HGhklq7fwbA1ZdDNNg68byIqtDKTxy1kAL
	iRTQs/nWds0fATuIJVHJxSepyhSQgrUf/ZnXX1WUoJ/ALNa+hpz+t7TN+Etiiz4/
	pAHKQiBG8bvTCkCYbvxbdO3q2p4n5MVRpp3q2yRE4n9cdfg36dEGYieizSgmsoTd
	hG4hV4XPM1LajeRt4rX5hKfT+Jhigek/NbBofCSkQN9pwNHsm0hEnlJo8B3rkajh
	MUI+Z4EgwDyOQX1rdQHuaPJkkvNvYvdqFQrKnKyMv2A9E1Uj+OiJ4uJq6fPIbXlW
	WU3WK5PUa5b5zep4GitPl6jF7sfLcNSz8NwxX0jgXxbYScYtcekYwt381Wn3BY54
	yPyfLmI=
From: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
To: <linux-arm-kernel@lists.infradead.org>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>, "Kamel
 Bouhara" <kamel.bouhara@bootlin.com>, William Breathitt Gray <wbg@kernel.org>
Subject: [PATCH v3 2/2] counter: microchip-tcb-capture: Add capture extensions for registers RA-RC
Date: Wed, 5 Feb 2025 11:49:54 +0100
Message-ID: <20250205104957.95236-3-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205104957.95236-1-csokas.bence@prolan.hu>
References: <20250205104957.95236-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1738752602;VERSION=7985;MC=3452472733;ID=233959;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29ACD94852667264

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

 drivers/counter/microchip-tcb-capture.c | 58 +++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/drivers/counter/microchip-tcb-capture.c b/drivers/counter/microchip-tcb-capture.c
index fef4bb69b486..1445ac512c52 100644
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
@@ -261,6 +317,8 @@ static struct counter_count mchp_tc_counts[] = {
 		.num_functions = ARRAY_SIZE(mchp_tc_count_functions),
 		.synapses = mchp_tc_count_synapses,
 		.num_synapses = ARRAY_SIZE(mchp_tc_count_synapses),
+		.ext = mchp_tc_count_ext,
+		.num_ext = ARRAY_SIZE(mchp_tc_count_ext),
 	},
 };
 
-- 
2.48.1



