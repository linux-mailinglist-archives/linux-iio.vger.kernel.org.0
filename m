Return-Path: <linux-iio+bounces-8147-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC74945F65
	for <lists+linux-iio@lfdr.de>; Fri,  2 Aug 2024 16:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BBBF1F2346A
	for <lists+linux-iio@lfdr.de>; Fri,  2 Aug 2024 14:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A75200121;
	Fri,  2 Aug 2024 14:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="INrLVJcl"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE3B200111
	for <linux-iio@vger.kernel.org>; Fri,  2 Aug 2024 14:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722608832; cv=none; b=h9ykZ1gDXtSm9/oGSrt0i/4Z21NAlFOREQd35JwmY1oQbmMHfkXXQXFF9jZwRAxg/JI8T4xD4rUujkfTB887TEHQ/5Pl3+9ahUHjOFvCrdjdqJ3pzIl2JxN/PKlBLSyhuv5lunRDp0fQ9SBHZN0D0I4qScMj2QuMZOr1HnU+aIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722608832; c=relaxed/simple;
	bh=J8ok26nfkL9lYlAtY5uSvNCwyF8TLIbcO37TZrbLh8A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nA85wTVMQxDVtHbaW1Utd+Ki6oElrfFe+k0QGKtzSLClBsDzqTRnhbYS2Z+Us3IQnYtD5VW2sa8/l0xdOaw8W1PklpJGlFOJgPV4Th5lTYoEQsjwYzRr1PXrS43LTlhIjXAxmdu0oxTvA6RRzDE/0UQq6clucV4vYlJJvEVYrig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=INrLVJcl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D171BC4AF16;
	Fri,  2 Aug 2024 14:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722608831;
	bh=J8ok26nfkL9lYlAtY5uSvNCwyF8TLIbcO37TZrbLh8A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=INrLVJclT1vI1EnUyDWOGiuLXUIOePJ98eVsvL7IMefVe2KPyjmrTKROKPOac5smD
	 xDZhCUBshz93R1rtsapN3z3WeeKdH93dkhcidKtcjpEfcbiQm3s1Dss3GRez56E2SV
	 fxAiBtzAgEwEy5DbaStY+mjly6uAOKtpfaWhLGLDXYK1VI3bbDaKodXcDegQlNjki5
	 TfXeGZ03dl9FJolH7gjpbTZ0AKYxhQ5LMsJjnJoi6PKdfksbklHcwzCC5X3Bwf4Gx8
	 a5z6m7CP6rHz0H5fG/OmtEa4kfgxPR5H1FinN23iHsxgRgE2ptX7kP73xgVV0IJhog
	 pTytsCzuT+8Gw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D6EC52D71;
	Fri,  2 Aug 2024 14:27:11 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 02 Aug 2024 16:27:04 +0200
Subject: [PATCH v2 6/8] iio: adc: adi-axi-adc: implement backend debugfs
 interface
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240802-dev-iio-backend-add-debugfs-v2-6-4cb62852f0d0@analog.com>
References: <20240802-dev-iio-backend-add-debugfs-v2-0-4cb62852f0d0@analog.com>
In-Reply-To: <20240802-dev-iio-backend-add-debugfs-v2-0-4cb62852f0d0@analog.com>
To: linux-iio@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, 
 Dragos Bogdan <dragos.bogdan@analog.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722608829; l=2891;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=XHFm/DrRZn5PNuj0meI9AmjVqgEfxuUnbOTCPnlHqLs=;
 b=BOLMKKfjm8oM8fatrNj8iUyr9NjiaeMc6d7lU09nR+41/JNP95EMVIG1/9J/U6IZ/QOUGqO6b
 lrTT4nuHeOFAQezk82NJ32AOiQ9ZMXnxWvja8WCbQJ5p/Ln+XBdhFvG
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sa <nuno.sa@analog.com>

Implement debugfs options to read/write registers and print the channel
status into a buffer (so we may know better the cause for errors) .

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/adc/adi-axi-adc.c | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index 442a87024e1a..5c8c87eb36d1 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -61,6 +61,10 @@
 
 #define ADI_AXI_ADC_REG_CHAN_STATUS(c)		(0x0404 + (c) * 0x40)
 #define   ADI_AXI_ADC_CHAN_STAT_PN_MASK		GENMASK(2, 1)
+/* out of sync */
+#define   ADI_AXI_ADC_CHAN_STAT_PN_OOS		BIT(1)
+/* spurious out of sync */
+#define   ADI_AXI_ADC_CHAN_STAT_PN_ERR		BIT(2)
 
 #define ADI_AXI_ADC_REG_CHAN_CTRL_3(c)		(0x0418 + (c) * 0x40)
 #define   ADI_AXI_ADC_CHAN_PN_SEL_MASK		GENMASK(19, 16)
@@ -246,6 +250,30 @@ static int axi_adc_chan_status(struct iio_backend *back, unsigned int chan,
 	return 0;
 }
 
+static int axi_adc_debugfs_print_chan_status(struct iio_backend *back,
+					     unsigned int chan, char *buf,
+					     size_t len)
+{
+	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
+	u32 val;
+	int ret;
+
+	ret = axi_adc_read_chan_status(st, chan, &val);
+	if (ret)
+		return ret;
+
+	/*
+	 * PN_ERR is cleared in case out of sync is set. Hence, no point in
+	 * checking both bits.
+	 */
+	if (val & ADI_AXI_ADC_CHAN_STAT_PN_OOS)
+		return scnprintf(buf, len, "CH%u: Out of Sync.\n", chan);
+	if (val & ADI_AXI_ADC_CHAN_STAT_PN_ERR)
+		return scnprintf(buf, len, "CH%u: Spurious Out of Sync.\n", chan);
+
+	return scnprintf(buf, len, "CH%u: OK.\n", chan);
+}
+
 static int axi_adc_chan_enable(struct iio_backend *back, unsigned int chan)
 {
 	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
@@ -280,6 +308,17 @@ static void axi_adc_free_buffer(struct iio_backend *back,
 	iio_dmaengine_buffer_free(buffer);
 }
 
+static int axi_adc_reg_access(struct iio_backend *back, unsigned int reg,
+			      unsigned int writeval, unsigned int *readval)
+{
+	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
+
+	if (readval)
+		return regmap_read(st->regmap, reg, readval);
+
+	return regmap_write(st->regmap, reg, writeval);
+}
+
 static const struct regmap_config axi_adc_regmap_config = {
 	.val_bits = 32,
 	.reg_bits = 32,
@@ -298,6 +337,8 @@ static const struct iio_backend_ops adi_axi_adc_ops = {
 	.iodelay_set = axi_adc_iodelays_set,
 	.test_pattern_set = axi_adc_test_pattern_set,
 	.chan_status = axi_adc_chan_status,
+	.debugfs_reg_access = iio_backend_debugfs_ptr(axi_adc_reg_access),
+	.debugfs_print_chan_status = iio_backend_debugfs_ptr(axi_adc_debugfs_print_chan_status),
 };
 
 static const struct iio_backend_info adi_axi_adc_generic = {

-- 
2.45.2



