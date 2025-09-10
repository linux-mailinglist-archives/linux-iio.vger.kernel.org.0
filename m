Return-Path: <linux-iio+bounces-23923-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C2AB51060
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 10:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C26C37BC61A
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 07:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64EB3112C4;
	Wed, 10 Sep 2025 07:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="afQ10EKL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5817B30F935;
	Wed, 10 Sep 2025 07:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757491095; cv=none; b=RuEJz0gmRpl2tWWrIejdp1Q83nxUlkV6R4nI3e4VNHXAFDxgu207vRrJWrhzTh99aIxHj1td7DbTloVcA74do73kWTXMntGvfgUK1dc0BEiYX6VQg3KMHqs7Pj4C42qd9rF+rUtPS+67rMhpZos6OqG/S4PPVrmdUVqve2S6R/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757491095; c=relaxed/simple;
	bh=XWzHd7nlDw82TjC+TEc4SoFNh/CzczQGkWthXmS4GRA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AbPRh1Xfkz3yjbqg1/wJWru/SDRvuXEZJmP8W4gnfe6fXYOVhkNu/NKgjo1r56oXUV5C2ohSoCQXRX+G+j/VPIvDnil017xEaMW6gArmpTAVqaJ4WJAH8LMiJ9rOWEnPfqTgwIzgjZKwaUXdduaSS6y6UdejmesYd0suWfDNnMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=afQ10EKL; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from [10.212.0.13] (unknown [IPv6:2a02:2f0e:3503:4a00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 387F4173BF3;
	Wed, 10 Sep 2025 10:58:06 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1757491086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n+xOIVvEek2iwN6DRKMJ3IrqnIPefm0SKjzAvT3YQtI=;
	b=afQ10EKLIrbQoXdGP8eJwIEwt4ADAufVpgE4yhXEvnjkDg/6KlXq1H3Bk0HXCxRIT7SKyf
	7Ccov/4O65vpuDWiTu8StsDnFct37rwbIH7zQjALKoGHlimEcnsQnlYgtrWDKQkK63iu7r
	3OkM34bhma1Su/C7Wy5SNu5nrothBN8HMDbqunzFL58cIOmeWKmCHCdrOsnr6X1SJCy4Ni
	YuLWPRJrF8XVdpY75OarkNkJaae4dSeJZ9nKG5wNz+he5SHrRrteuX784YBB7B4cM+8Q+s
	RW+LE1yN/KoztTho4d5MhFKktX72OV1XTRBWSTNKMMJKt7NNgbHy08EkjtonWA==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Wed, 10 Sep 2025 10:57:16 +0300
Subject: [PATCH v2 11/14] iio: accel: bma220: add interrupt trigger
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-bma220_improvements-v2-11-e23f4f2b9745@subdimension.ro>
References: <20250910-bma220_improvements-v2-0-e23f4f2b9745@subdimension.ro>
In-Reply-To: <20250910-bma220_improvements-v2-0-e23f4f2b9745@subdimension.ro>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Petre Rodan <petre.rodan@subdimension.ro>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3509;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=XWzHd7nlDw82TjC+TEc4SoFNh/CzczQGkWthXmS4GRA=;
 b=owEBbQKS/ZANAwAIAc8mmZmETn8wAcsmYgBowS+HY6SKQtDFmzn3zP0STv+SpmHSSxoregIUb
 d780z93iFqJAjMEAAEIAB0WIQTYCn/BdhUZNew+X6nPJpmZhE5/MAUCaMEvhwAKCRDPJpmZhE5/
 MN8fEADX6Mt7G9EqaFrdavXIo494ADbqyT8e86hdrHs0v/vURULncZIZr4HdQZ34EQcvrLh/+6g
 cC76rlCjmSGyyGmAasJgyfPc9zFfBa8wHx4WQNlQj7Vg5vj2gZ2SzIVdUrPfr2UGf0v+xP1ycmQ
 vdiI/5nVs9SdEDgRqOqz9Ho++0dddzDaluo6rigpkyTWKtguPMRWLlQ2atoNclXSmzX5uVgXchF
 D8e1iV8x9S7qXU+aBoqg7Y158GPhPBa1H9CdRZ1BuhLs9k1NUAvsnxgEPi/PaKccxrJCGRbrUKR
 KSmIiKKt1qR88dnmofWx7dejfn3IDC1EQyUYwGaf92cisj31a/IUyJTY/QwJjfAjcy4T0A4PAt/
 gZdgIpuGAAFvveYF8daxHe7TJA/vK7MQWT+IOfI4UHRgAmbtJbUAnRQtBpJU42s6aCibJ5LQXk+
 oDLV0nMRpvGOGVkioRPe3Yps0MgWezs+AQIh4H44ks56i5hjWpdzlHsrXnnf3TS7S7O9d2dQ2Uz
 Vgs5njuUxGURPClMtDpUEWNPzZhA+1lb43Bc7+SuZ11HhLhjXwc0G5qcmkJ6dKk9keV6s2Qa1Hp
 ypdEpAhfu7crH92FJwEUuhfgCXFxA78wHFUD+HXTKXXrAowmhh5vmgGvQ8vvmO5rr/Us7y/8H5a
 i2flgDGn275kW1A==
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

Add interrupt trigger.

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
no change, just patch split
---
 drivers/iio/accel/bma220_core.c | 62 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/drivers/iio/accel/bma220_core.c b/drivers/iio/accel/bma220_core.c
index b619f5a0bf713b4d386a5d4fc1d919e144798f02..69bfd7f9f2b35e67835c6e1e41e02258e6741e7b 100644
--- a/drivers/iio/accel/bma220_core.c
+++ b/drivers/iio/accel/bma220_core.c
@@ -23,6 +23,7 @@
 #include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
+#include <linux/iio/trigger.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
 
@@ -126,6 +127,7 @@ struct bma220_data {
 	struct regmap *regmap;
 	struct mutex lock;
 	u8 range_idx;
+	struct iio_trigger *trig;
 	struct {
 		s8 chans[3];
 		/* Ensure timestamp is naturally aligned. */
@@ -194,6 +196,23 @@ const struct regmap_config bma220_i2c_regmap_config = {
 };
 EXPORT_SYMBOL_NS_GPL(bma220_i2c_regmap_config, "IIO_BOSCH_BMA220");
 
+static int bma220_data_rdy_trigger_set_state(struct iio_trigger *trig,
+					     bool state)
+{
+	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
+	struct bma220_data *data = iio_priv(indio_dev);
+
+	guard(mutex)(&data->lock);
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
@@ -418,6 +437,25 @@ static void bma220_deinit(void *data_ptr)
 			 ERR_PTR(ret));
 }
 
+static irqreturn_t bma220_irq_handler(int irq, void *private)
+{
+	struct iio_dev *indio_dev = private;
+	struct bma220_data *data = iio_priv(indio_dev);
+	int rv;
+	u8 bma220_reg_if[2];
+
+	guard(mutex)(&data->lock);
+	rv = regmap_bulk_read(data->regmap, BMA220_REG_IF0, bma220_reg_if,
+			      sizeof(bma220_reg_if));
+	if (rv)
+		return IRQ_NONE;
+
+	if (FIELD_GET(BMA220_IF_DRDY, bma220_reg_if[1]))
+		iio_trigger_poll_nested(data->trig);
+
+	return IRQ_HANDLED;
+}
+
 int bma220_common_probe(struct device *dev, struct regmap *regmap, int irq)
 {
 	int ret;
@@ -447,6 +485,30 @@ int bma220_common_probe(struct device *dev, struct regmap *regmap, int irq)
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
+						&bma220_irq_handler,
+						IRQF_TRIGGER_RISING | IRQF_ONESHOT,
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


