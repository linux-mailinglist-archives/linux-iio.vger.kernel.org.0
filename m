Return-Path: <linux-iio+bounces-24754-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 136D3BB96EE
	for <lists+linux-iio@lfdr.de>; Sun, 05 Oct 2025 15:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E9DD84E4204
	for <lists+linux-iio@lfdr.de>; Sun,  5 Oct 2025 13:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749BA299AAA;
	Sun,  5 Oct 2025 13:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="Dw8Naqmq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B8E28AB0B;
	Sun,  5 Oct 2025 13:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759669997; cv=none; b=kKE2RDULLWs85yx4OSl8JQ1/Bhuokd6asE3kvqTaJ6IU+Qe9NoOXR1W0CufgcplG7PWbTT5pNeNpCl2kQWvCWUX6/eZYfKVCWk4YnSK4dNDai1cFYEVUd2fyek3I2Ts4X91nP+sasx+GVlaGdWfYzz8g+dQiqyuVkvgLF2tp07I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759669997; c=relaxed/simple;
	bh=Hji0AFsKY2VMUvZORR8uShWfZuQyHGjgdcQlOTjd/X0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EX34Syf6m3ocV/dDCurNkebsy7RL07PXE9g1yEAjRCDo9zLw2TRo1aaKNFnO1XyjBHZKOASt0+XY9CscX5v4N3z+tuSvy5lp4QY8RkcGGzbE3t5gr5eAKUwhvwXmD9FCQdoqB3tPY6v28p/GAK1/STn9LE4+AG4kAHJBMv2N38c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=Dw8Naqmq; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from [10.212.0.13] (unknown [IPv6:2a02:2f0e:3e0c:5b00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 268DC173BF8;
	Sun, 05 Oct 2025 16:13:06 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1759669986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RZCd1LuoKLbW/Yf0spyzgrKJD68T+psOsCJqcg637YA=;
	b=Dw8NaqmqYjpvbQqFesznwq1jEcTiGtFEYM1AWwmuJ37SC7eA9ryvwIGKkrmB/i28O5cAn7
	xEOrGLgGYobKaVlBCbXPuFxqKjwoQSMHACjjChGA9cSyaeUXzHdNlxmlOuEORcpBojcLTx
	wkL+BL0+6l/tDhAbdWuDj+9I6iFqyVamBUeQWxAEncQzMtDw5PS7vP7C5P3cdmlfPIBLKA
	KmCTU4pQgxvTmXFgN2V8tDvQqDpXmrYOD3uewdrEivvaDJGZaUvP4+rO9nSXuJTJ+WJtbu
	n4bB/KwG5iKfULIBFG5sVutwSq+W/jWzbuVwuPAbeNHSt89RNDuGZx1C2VvVyQ==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Sun, 05 Oct 2025 16:12:25 +0300
Subject: [PATCH v4 16/19] iio: accel: bma220: add interrupt trigger
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251005-b4-bma220_improvements-v4-16-0f449ba31585@subdimension.ro>
References: <20251005-b4-bma220_improvements-v4-0-0f449ba31585@subdimension.ro>
In-Reply-To: <20251005-b4-bma220_improvements-v4-0-0f449ba31585@subdimension.ro>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3564;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=Hji0AFsKY2VMUvZORR8uShWfZuQyHGjgdcQlOTjd/X0=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFwTDlrQTBEQUFvQmRDc25wM
 k02U1dNQnl5WmlBR2ppYnRXMUNKTURKSmQzejMvVG9QcXJ6RW1vCmhlSFI0WGdTOE14THVaalQy
 azMzRklrQ013UUFBUW9BSFJZaEJCb2ltQncrRGJ4UXBFNmlkM1FySjZkak9rbGoKQlFKbzRtN1Z
 BQW9KRUhRcko2ZGpPa2xqU2lvUC8xVVoxYyttUUREM3prMENnODlkdi9kTEtDQmFBYWdCZm9QMQ
 pQd1NUeHk5akJXVUllVURlaVd6Y2RqNHpTSGtKL2dFa2dBMTF0MDh1M0RrYjlUaTlLUkhCVGF4S
 nlidkdQUWYzCkpocEJnYTlQM2JGbFM3d2U3ZDBVRFhYajREY2dGSldoZk95UkxXWE5iN2VQcmVY
 ek9lR0FaVklMU1BqRXc2MGEKZVI4OERsbkVDcmpTL2h4bGhsUkRYck5RdE1jclRFYWNkeWMrcHB
 iSzVrbHFaQVduYlpnVUFyaTBuc1ozRHIycgpNdGx0ODhBa3lVMmJtTSt4VDc5ckE1bkJ6M3ZHWT
 JiRTB4aEtybk9WSmVYVWp5Vkx4WVZwTmJsRStlcVZ1OThiCkVhM1RsS1ZaWTQvMmdnVTNvNzE5c
 ExURGx2NHMzRDUwRk45dTJWRVUwM1hFR2x6K0pobGd3VUhLR2J2N2dmcUkKblR5V0NNV3VpR2cx
 NU95YU8yWmpzakQ3V2Y2bHhWVFQrNGhPUytpUkJJZGx0aFQ4Nno2aHlYNVhuQXFsKzFYUgpOMDg
 vN1dsMjlhS3RmMXFYSzdRVEppM09qN0lSZHBSY1lVNGt4MzdLdjlmOTJmcEZqd3B3ZVg2RUZMMX
 BVUDJuCjdObXREMjBHcXFmU2xheXVrejladUtHQ2p5Mzl6cnpnZ0VGMXZWeHBwcndiNk9DNWNXS
 VBDemJuZFlKQkhzMnkKYnJnS1JlY0tSWjBvZTJvcWxQZG9YMUd1NUt3UW1pRUdwSXRWZ1Z1WVFn
 WVRGck9lcjVxL05BcElBSWVjalBFaApacnAxN3VtSDBpaVk1MUVMY1ZjbWxkMmVxQkFNb2cxOTR
 lSXFseFAydDFPVDRSRllSaFBFTTdEaUVvRjBsOWg0CmIxT09rbVQ5WUhRbkRBPT0KPVh5S3EKLS
 0tLS1FTkQgUEdQIE1FU1NBR0UtLS0tLQo=
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

Add interrupt trigger.

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
v1->v2 no change, just patch split
v2->v3 replace regmap_bulk_read with regmap_read (Jonathan)
 (I just realized BMA220_REG_IF0 is never used, even by future
 event patches)
v4 fix compilation err
---
 drivers/iio/accel/bma220_core.c | 58 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/drivers/iio/accel/bma220_core.c b/drivers/iio/accel/bma220_core.c
index a957751be40c63c25963283be813db97f73bf004..8f0cbd0aacb92a21afc57aaa350547d0c767d4b6 100644
--- a/drivers/iio/accel/bma220_core.c
+++ b/drivers/iio/accel/bma220_core.c
@@ -22,6 +22,7 @@
 #include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
+#include <linux/iio/trigger.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
 
@@ -123,6 +124,7 @@ struct bma220_data {
 	struct regmap *regmap;
 	struct mutex lock;
 	u8 range_idx;
+	struct iio_trigger *trig;
 	struct {
 		s8 chans[3];
 		/* Ensure timestamp is naturally aligned. */
@@ -191,6 +193,22 @@ const struct regmap_config bma220_i2c_regmap_config = {
 };
 EXPORT_SYMBOL_NS_GPL(bma220_i2c_regmap_config, "IIO_BOSCH_BMA220");
 
+static int bma220_data_rdy_trigger_set_state(struct iio_trigger *trig,
+					     bool state)
+{
+	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
+	struct bma220_data *data = iio_priv(indio_dev);
+
+	return regmap_update_bits(data->regmap, BMA220_REG_IE0,
+				  BMA220_INT_EN_DRDY_MSK,
+				  FIELD_PREP(BMA220_INT_EN_DRDY_MSK, state));
+}
+
+static const struct iio_trigger_ops bma220_trigger_ops = {
+	.set_trigger_state = &bma220_data_rdy_trigger_set_state,
+	.validate_device = &iio_trigger_validate_own_device,
+};
+
 static irqreturn_t bma220_trigger_handler(int irq, void *p)
 {
 	int ret;
@@ -413,6 +431,23 @@ static void bma220_deinit(void *data_ptr)
 			 ERR_PTR(ret));
 }
 
+static irqreturn_t bma220_irq_handler(int irq, void *private)
+{
+	struct iio_dev *indio_dev = private;
+	struct bma220_data *data = iio_priv(indio_dev);
+	int ret;
+	unsigned int bma220_reg_if1;
+
+	ret = regmap_read(data->regmap, BMA220_REG_IF1, &bma220_reg_if1);
+	if (ret)
+		return IRQ_NONE;
+
+	if (FIELD_GET(BMA220_IF_DRDY, bma220_reg_if1))
+		iio_trigger_poll_nested(data->trig);
+
+	return IRQ_HANDLED;
+}
+
 int bma220_common_probe(struct device *dev, struct regmap *regmap, int irq)
 {
 	int ret;
@@ -441,6 +476,29 @@ int bma220_common_probe(struct device *dev, struct regmap *regmap, int irq)
 	indio_dev->num_channels = ARRAY_SIZE(bma220_channels);
 	indio_dev->available_scan_masks = bma220_accel_scan_masks;
 
+	if (irq > 0) {
+		data->trig = devm_iio_trigger_alloc(dev, "%s-dev%d",
+						    indio_dev->name,
+						    iio_device_id(indio_dev));
+		if (!data->trig)
+			return -ENOMEM;
+
+		data->trig->ops = &bma220_trigger_ops;
+		iio_trigger_set_drvdata(data->trig, indio_dev);
+
+		ret = devm_iio_trigger_register(dev, data->trig);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "iio trigger register fail\n");
+		indio_dev->trig = iio_trigger_get(data->trig);
+		ret = devm_request_threaded_irq(dev, irq, NULL,
+						&bma220_irq_handler, IRQF_ONESHOT,
+						indio_dev->name, indio_dev);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "request irq %d failed\n", irq);
+	}
+
 	ret = devm_add_action_or_reset(dev, bma220_deinit, data);
 	if (ret)
 		return ret;

-- 
2.49.1


