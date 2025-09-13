Return-Path: <linux-iio+bounces-24082-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DD9B5620F
	for <lists+linux-iio@lfdr.de>; Sat, 13 Sep 2025 17:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6647BA01B1E
	for <lists+linux-iio@lfdr.de>; Sat, 13 Sep 2025 15:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954E72FB617;
	Sat, 13 Sep 2025 15:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="1v5hP1yI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2E82F60C7;
	Sat, 13 Sep 2025 15:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757778022; cv=none; b=lMjHaah4aQvcB3K25NJzO9o9EmuTO6yxr7Uo64IpgVbfqGeXrl4/Sfbr5R2D8V7286DkfnO1fzTBaT84kp/ipPdR75OC0e2gUHCL3EDBQJYK8NOM6xPTfQ4Hpc0EfosrB9IJ5c2lMc7Xp43mFh9yFRjOFnUNDinBh0qoHL2wOrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757778022; c=relaxed/simple;
	bh=SLbPXSub9o7RKO3pIHOCOkFToiXG7BesztU/FaK8/Oo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Nt+lu5/2Eg8C++Fg1zFPUajr3VgWg7z0kyT50o2HHes9ygUKns+OCTtFGL4NJ32V8ypjVB8+vByiyMJFPmB3zxyhaTCe79RO+HOaPGZ4K86d6A8WqvX3v7NsGyR5Fpwi4hbHYwKDECfD1DIvN2LoMLhtpxmh4477olAw1HuENLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=1v5hP1yI; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from [10.212.0.13] (unknown [IPv6:2a02:2f0e:3e0c:5b00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id DF2F6173BF7;
	Sat, 13 Sep 2025 18:40:10 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1757778011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lU0M9WUiPXDVh8EE8CDawLl3i6MJ3WuJWVLfPMwx+ns=;
	b=1v5hP1yI0MIUVF0L1jyYyMmf+jmvJhz3ujuuJYO29uZwslIjLE1tAzx7kNWZgrF0CGno7K
	SUQn89M1w+Ox7DUTwx6/nJ/BinIMZ5UgAmVnfaHOMUm460FGhBGMZEsN+8T9Pej0OsE0Oc
	QQv1sOkVxGpKrg5C0UnkN1TNql0b/0y2chA6bPZ6hwG0YN1THqY8XkpBrvR8VJk20blygi
	w0ZJvl8b4RlY+dnEbbxGK4wdUwwMqinxHb/tIvVVELb2VDdOEVPJlIGFAsNNKtyfs4WQwc
	/CWgJgulqlkOjBFEZKZd6x8Fj6Ja6dNtLImKlU48Vpv2eDNEPyF9014k8W209g==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Sat, 13 Sep 2025 18:39:36 +0300
Subject: [PATCH v3 15/18] iio: accel: bma220: add interrupt trigger
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250913-b4-bma220_improvements-v3-15-0b97279b4e45@subdimension.ro>
References: <20250913-b4-bma220_improvements-v3-0-0b97279b4e45@subdimension.ro>
In-Reply-To: <20250913-b4-bma220_improvements-v3-0-0b97279b4e45@subdimension.ro>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3628;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=SLbPXSub9o7RKO3pIHOCOkFToiXG7BesztU/FaK8/Oo=;
 b=owEBbQKS/ZANAwAIAc8mmZmETn8wAcsmYgBoxZBSeUf7bw7FcfRIE5/oU3JSdc0+NJXVtkMZg
 HRrNXwNJqGJAjMEAAEIAB0WIQTYCn/BdhUZNew+X6nPJpmZhE5/MAUCaMWQUgAKCRDPJpmZhE5/
 MBzHEADNOYlJVWGtFEVa+e1A6vnuEfUpkjZC7rSRXvBn1RCRlLkQ5Vb1+aDkczzZxu3TpLVaVtA
 BbFgxGm4SL+E60KNUMGJqHIe/fpED6OrZlSLn3CdbIAvIBEcCLL/Yl7cXR/O9OKH6ORwcfWhRte
 HthlBCaRM47QZujyLEuIQ2/wK+qeAgxUYa59/T9XwtG/4TKj61ZK3YxVFTtFmcOmahOROxUaDUO
 A9yAD1wd0ZwNuq0bOWoXb/iq9dJEN5Dzp8X6+RtB5kq/EmihBIHLLQBWoNFhMqiVJdOiG1UX08o
 YDV0+Gr8wJbUM6srpQJ3v5qHrmPNgShseU8CIwKwf6ONxhMSf5s7CrAUaGyIeTYae0GMSA/4a80
 fTKWvIytks6ZLhYdBlMlbmu/mvZD5ZM1vCqBGkzUurUJyjrVgsRsTXoYjWhAWzifiqcYzX69A51
 4fV3Cv2nHhfoK9vAuRdBdl1uLRuwmHbJzf2mppB1FNmFhZ7jvhbGwr/pEXOHs8k2DgvJ2HcdfOs
 PCj7APti+HwNAeyx5V1VORkvNWsqpuAWO92jlzCRY0ZPHxq9Yj0J2whebE+y+N7K2SULDfI9Ape
 3c8aHfYhlRoqpmbcb0+kow001uo6Wi0qm+0f/G4P0Tlec8JbfkWtPMwy84ocyoK7z00ihEk9iD8
 e5ICT+KJkyuwfXg==
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

Add interrupt trigger.

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
v1->v2 no change, just patch split
v2->v3 replace regmap_bulk_read with regmap_read (Jonathan)
 (I just realized BMA220_REG_IF0 is never used, even by future event
patches)
---
 drivers/iio/accel/bma220_core.c | 61 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/drivers/iio/accel/bma220_core.c b/drivers/iio/accel/bma220_core.c
index 425a8b981e141aa496351f29df0597c989aa4a0a..6297882bcf1b955291a2d8747984648bc6ee8512 100644
--- a/drivers/iio/accel/bma220_core.c
+++ b/drivers/iio/accel/bma220_core.c
@@ -23,6 +23,7 @@
 #include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
+#include <linux/iio/trigger.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
 
@@ -125,6 +126,7 @@ struct bma220_data {
 	struct regmap *regmap;
 	struct mutex lock;
 	u8 range_idx;
+	struct iio_trigger *trig;
 	struct {
 		s8 chans[3];
 		/* Ensure timestamp is naturally aligned. */
@@ -193,6 +195,23 @@ const struct regmap_config bma220_i2c_regmap_config = {
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
@@ -417,6 +436,24 @@ static void bma220_deinit(void *data_ptr)
 			 ERR_PTR(ret));
 }
 
+static irqreturn_t bma220_irq_handler(int irq, void *private)
+{
+	struct iio_dev *indio_dev = private;
+	struct bma220_data *data = iio_priv(indio_dev);
+	int rv;
+	unsigned int bma220_reg_if1;
+
+	guard(mutex)(&data->lock);
+	rv = regmap_read(data->regmap, BMA220_REG_IF1, &bma220_reg_if1);
+	if (rv)
+		return IRQ_NONE;
+
+	if (FIELD_GET(BMA220_IF_DRDY, bma220_reg_if1)) {
+		iio_trigger_poll_nested(data->trig);
+
+	return IRQ_HANDLED;
+}
+
 int bma220_common_probe(struct device *dev, struct regmap *regmap, int irq)
 {
 	int ret;
@@ -446,6 +483,30 @@ int bma220_common_probe(struct device *dev, struct regmap *regmap, int irq)
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


