Return-Path: <linux-iio+bounces-5175-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E406F8CC1DF
	for <lists+linux-iio@lfdr.de>; Wed, 22 May 2024 15:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5990F1F23961
	for <lists+linux-iio@lfdr.de>; Wed, 22 May 2024 13:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135DC13DBAC;
	Wed, 22 May 2024 13:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K7eWdGAp"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BD613D62E
	for <linux-iio@vger.kernel.org>; Wed, 22 May 2024 13:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716383698; cv=none; b=U/f1gSeHBcELStbkyvE51hSLEwsBacnoKvnmRK0ZgWOejuMCAIxFSwdJl1SJuS5gDTYqw8Tgy1JkCJ9qGXCgX6OOJmuP1QxEQG0rH4Lm1lAANB4b8nSGpCisjWhqxWidLJ+ac7VHDl0SIzzHCHs33K6OHTZLWDk7v3yUK7Uj7Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716383698; c=relaxed/simple;
	bh=CTdvz4G+bEo6XNDazusBSD/2OSSMRpTSqK+KRTwrFTw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=EiupAgAEREXSM+RARr7pnXfoMCuAt6DEzxicVCZn6dD6D9lBMVH1tO9PVeriPki3fOXYAaJnW+XVAz4cEFkYdfTyqvfvHWAa1VAwnyH398PJDOGfYL/seI9xteHAX/iYrcyCoSyTErkxnxNglaHw5cBOJfFqSa3kzkN30QYEMOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K7eWdGAp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4AF2AC2BD11;
	Wed, 22 May 2024 13:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716383698;
	bh=CTdvz4G+bEo6XNDazusBSD/2OSSMRpTSqK+KRTwrFTw=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=K7eWdGApq8nSVsX8Tx8cmw1+fw+H7t/K58WxPexnKQAEx4LR8lLb0DyiQUg3zW7QI
	 7c9OdLQLLIuXah3g2NYsaZXfSmLa8twUy10QxG1W0oLK27f5wLaVx/0w/2rBCSUTdd
	 VDHkgVKHdds8yZVGmcM2aFXwMTyq8uhc8kYSqLiynALmWxAG0xxl2GlHXKSVNl2BSV
	 /ADi1P4hDElXg0aIcSINo8rI7TMNj09VyauSAz0VpZmWVzp39Q7GWRI16+Rh80N2SY
	 7yTu7dldKqgqISyv09iTbxQfEspUVIB7edecGdz+fgu9y7pTJ/qP7KiMNxBtrRVceH
	 AGDIz5H6Qa2Yg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40484C25B7A;
	Wed, 22 May 2024 13:14:58 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Wed, 22 May 2024 15:14:56 +0200
Subject: [PATCH v2] iio: adc: adi-axi-adc: make sure DRP is locked on
 enable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240522-dev-axi-adc-drp-v2-1-b63c9790a48a@analog.com>
X-B4-Tracking: v=1; b=H4sIAM/vTWYC/3WNQQ6CMBBFr0Jm7Zi2SgVX3sOwGOkAkyglrWkwp
 He3snf5XvLf3yByEI5wrTYInCSKnwuYQwX9RPPIKK4wGGXOqlYWHSekVZBcjy4sSGwfrnUnY/U
 FymoJPMi6F+9d4Uni24fPfpD0z/5vJY0aG2epqe3QqpZvNNPTj8fev6DLOX8BDamKaa8AAAA=
To: linux-iio@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716383697; l=2681;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=Pe6bUQm9SfdBpBcwS0s69lmSgXMkhkpPj+U4DdXlRyo=;
 b=x08YBcrQtzf5svic0QHBtYDSVIIhildhtQd1/7v6ETofv4QJ7tJoMn8cka5yC0siSm6WRNlZ2
 ZzOZaqYRnN9Ck7eXaT3PzHoBL6JZd18UmxzMoz6CvXEWZZeUsNtHcYf
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sa <nuno.sa@analog.com>

When enabling the core, make sure DRP (Dynamic Reconfiguration Port)
is locked. Most of the designs don't really use it but we still get the
lock bit set. So let's do it all the time so the code is generic.

While at it add proper mutex guards as we should not be able to disable
the core in the middle of enabling it. Also reduce the timeout time to 1
microsecond as it seems to be enough and goes in line with what we have
on the similar DAC core (adi-axi-dac).

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
Changes in v2:
- Fixed typo in commit message;
- Renamed the AXI_ADC_DRP_STATUS -> ADI_AXI_ADC_REG_DRP_STATUS and
  AXI_ADC_DRP_LOCKED -> ADI_AXI_ADC_DRP_LOCKED fro consistency.
- Link to v1: https://lore.kernel.org/r/20240506-dev-axi-adc-drp-v1-1-8d6a856f909e@analog.com
---
 drivers/iio/adc/adi-axi-adc.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index 0cf0d81358fd5..d54567cf40c64 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -42,6 +42,9 @@
 #define ADI_AXI_ADC_REG_CTRL			0x0044
 #define    ADI_AXI_ADC_CTRL_DDR_EDGESEL_MASK	BIT(1)
 
+#define ADI_AXI_ADC_REG_DRP_STATUS			0x0074
+#define   ADI_AXI_ADC_DRP_LOCKED			BIT(17)
+
 /* ADC Channel controls */
 
 #define ADI_AXI_REG_CHAN_CTRL(c)		(0x0400 + (c) * 0x40)
@@ -83,14 +86,26 @@ struct adi_axi_adc_state {
 static int axi_adc_enable(struct iio_backend *back)
 {
 	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
+	unsigned int __val;
 	int ret;
 
+	guard(mutex)(&st->lock);
 	ret = regmap_set_bits(st->regmap, ADI_AXI_REG_RSTN,
 			      ADI_AXI_REG_RSTN_MMCM_RSTN);
 	if (ret)
 		return ret;
 
-	fsleep(10000);
+	/*
+	 * Make sure the DRP (Dynamic Reconfiguration Port) is locked. Not all
+	 * designs really use it but if they don't we still get the lock bit
+	 * set. So let's do it all the time so the code is generic.
+	 */
+	ret = regmap_read_poll_timeout(st->regmap, ADI_AXI_ADC_REG_DRP_STATUS,
+				       __val, __val & ADI_AXI_ADC_DRP_LOCKED,
+				       100, 1000);
+	if (ret)
+		return ret;
+
 	return regmap_set_bits(st->regmap, ADI_AXI_REG_RSTN,
 			       ADI_AXI_REG_RSTN_RSTN | ADI_AXI_REG_RSTN_MMCM_RSTN);
 }
@@ -99,6 +114,7 @@ static void axi_adc_disable(struct iio_backend *back)
 {
 	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
 
+	guard(mutex)(&st->lock);
 	regmap_write(st->regmap, ADI_AXI_REG_RSTN, 0);
 }
 

---
base-commit: 5e3c5871138da700796587aa5f096d39135f9d36
change-id: 20240506-dev-axi-adc-drp-ae6bd9d32617
--

Thanks!
- Nuno Sá



