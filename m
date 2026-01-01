Return-Path: <linux-iio+bounces-27461-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 293DDCED27E
	for <lists+linux-iio@lfdr.de>; Thu, 01 Jan 2026 17:18:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8511A3013559
	for <lists+linux-iio@lfdr.de>; Thu,  1 Jan 2026 16:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869802EFD9B;
	Thu,  1 Jan 2026 16:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NPJnlGiu"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392502ED853;
	Thu,  1 Jan 2026 16:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767284293; cv=none; b=Y9Cvg3Glm8RrDDf6kZZNHETLIFDJBH39308G9yFljvzAFgHaHJL29nEWw8rIJgp3B/vW35Syp/rmoIJ0SHGoxLg584f46Lv2lR/WKRhx0IiTUmSjBVDnkalBeOdzJAAufS5acxiXSyfpXJJ4+YSaX80W3Z2inMMdGVjZzSdqXKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767284293; c=relaxed/simple;
	bh=kgeuZ/y8NZNVHt7bXiE/Wp4IIMdUUDkagYV0xkmQi5Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ga4AsaMyN5oFURvSEKtyW+nfszXn4I4bdLq+ddeicA6sIB7RNazcXbnkVP2lXJrM/yO74QU37bwmST1jTl9wqHvSqxp14abLaQhU+d0kfkz7X1OXa9HziJjiCZg1buCzzdh7YhSppVexp4fA9gbMPxkjbffnzA235FtQiGcao0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NPJnlGiu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 84D35C4AF0B;
	Thu,  1 Jan 2026 16:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767284292;
	bh=kgeuZ/y8NZNVHt7bXiE/Wp4IIMdUUDkagYV0xkmQi5Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=NPJnlGiu9AW5J5fqgMeoYNIkgUvEYo7v5PapdLn130ng/tavFe9A2VIRdtdzV6EOf
	 3tio2kebLCbnjFZzgATn1i0FnufekRpOrywXu1tvpNtkEYL/MxtoX9KZA8Xg9up/SF
	 PalNJf29F++b4iIOeI38c01WWOIJPx3oqNmO2kYfMn4vqkSmPPqnATCy6wSxQef2Co
	 5LzsHHrODt7r7f3t+ET95DdNUEK0G7Gv1eXiz/3+N8uLTmHJtreXkqLOFOgbTYN9r3
	 UbCYP4YaXrHsMyyJVSzQLPqUlt3Z1K222LgqHBnB2cPKBL0haw7J+7En5KvC9RvLrq
	 stHOM4Ta4Z75g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AEC6EED621;
	Thu,  1 Jan 2026 16:18:12 +0000 (UTC)
From: Shrikant Raskar via B4 Relay <devnull+raskar.shree97.gmail.com@kernel.org>
Date: Thu, 01 Jan 2026 21:47:41 +0530
Subject: [PATCH v4 4/4] iio: proximity: rfd77402: Add interrupt handling
 support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260101-b4-rfd77402_irq-v4-4-42cd54359e9f@gmail.com>
References: <20260101-b4-rfd77402_irq-v4-0-42cd54359e9f@gmail.com>
In-Reply-To: <20260101-b4-rfd77402_irq-v4-0-42cd54359e9f@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: raskar.shree97@gmail.com, skhan@linuxfoundation.org, 
 david.hunter.linux@gmail.com, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767284290; l=7074;
 i=raskar.shree97@gmail.com; s=20260101; h=from:subject:message-id;
 bh=RKV4qe8g75WaYJMPnvpOFnWfihHaP50YTCl+fCPC7AA=;
 b=KixV0F0nd1ERUhIPUqvcYXxmksFaaITYzw7d14OL2jve9voC01kzH9qbybHbZ05DQQ8USWpte
 nkkB6lQWPzjAVT+TbjmlIrm+6sR/Waqp6lO/nGo6ybrFTfgm/iTK1OJ
X-Developer-Key: i=raskar.shree97@gmail.com; a=ed25519;
 pk=4m2wXDvY0vlXefvRRzawNcNAif88Cy4XvbLkU6iMG/Y=
X-Endpoint-Received: by B4 Relay for raskar.shree97@gmail.com/20260101 with
 auth_id=589
X-Original-From: Shrikant Raskar <raskar.shree97@gmail.com>
Reply-To: raskar.shree97@gmail.com

From: Shrikant Raskar <raskar.shree97@gmail.com>

Add interrupt handling support to enable event-driven data acquisition
instead of continuous polling. This improves responsiveness, reduces
CPU overhead, and supports low-power operation by allowing the system
to remain idle until an interrupt occurs.

Signed-off-by: Shrikant Raskar <raskar.shree97@gmail.com>
---
 drivers/iio/proximity/rfd77402.c | 136 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 120 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/proximity/rfd77402.c b/drivers/iio/proximity/rfd77402.c
index 496c1412ebf8..8cddf509f9c6 100644
--- a/drivers/iio/proximity/rfd77402.c
+++ b/drivers/iio/proximity/rfd77402.c
@@ -6,13 +6,14 @@
  *
  * 7-bit I2C slave address 0x4c
  *
- * TODO: interrupt
  * https://media.digikey.com/pdf/Data%20Sheets/RF%20Digital%20PDFs/RFD77402.pdf
  */
 
 #include <linux/module.h>
 #include <linux/i2c.h>
 #include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/completion.h>
 #include <linux/iopoll.h>
 
 #include <linux/iio/iio.h>
@@ -20,6 +21,8 @@
 #define RFD77402_DRV_NAME "rfd77402"
 
 #define RFD77402_ICSR		0x00 /* Interrupt Control Status Register */
+#define RFD77402_ICSR_CLR_CFG   BIT(0)
+#define RFD77402_ICSR_CLR_TYPE  BIT(1)
 #define RFD77402_ICSR_INT_MODE	BIT(2)
 #define RFD77402_ICSR_INT_POL	BIT(3)
 #define RFD77402_ICSR_RESULT	BIT(4)
@@ -27,6 +30,12 @@
 #define RFD77402_ICSR_H2M_MSG	BIT(6)
 #define RFD77402_ICSR_RESET	BIT(7)
 
+#define RFD77402_IER		0x02
+#define RFD77402_IER_RESULT	BIT(0)
+#define RFD77402_IER_M2H_MSG	BIT(1)
+#define RFD77402_IER_H2M_MSG	BIT(2)
+#define RFD77402_IER_RESET	BIT(3)
+
 #define RFD77402_CMD_R		0x04
 #define RFD77402_CMD_SINGLE	0x01
 #define RFD77402_CMD_STANDBY	0x10
@@ -77,10 +86,18 @@ static const struct {
 	{RFD77402_HFCFG_3,	0x45d4},
 };
 
+/**
+ * struct rfd77402_data - device-specific data for the RFD77402 sensor
+ * @client: I2C client handle
+ * @lock: mutex to serialize sensor reads
+ * @completion: completion used for interrupt-driven measurements
+ * @irq_en: indicates whether interrupt mode is enabled
+ */
 struct rfd77402_data {
 	struct i2c_client *client;
-	/* Serialize reads from the sensor */
 	struct mutex lock;
+	struct completion completion;
+	bool irq_en;
 };
 
 static const struct iio_chan_spec rfd77402_channels[] = {
@@ -91,6 +108,39 @@ static const struct iio_chan_spec rfd77402_channels[] = {
 	},
 };
 
+static irqreturn_t rfd77402_interrupt_handler(int irq, void *pdata)
+{
+	struct rfd77402_data *data = pdata;
+	int ret;
+
+	if (!data || !data->client)
+		return IRQ_NONE;
+
+	ret = i2c_smbus_read_byte_data(data->client, RFD77402_ICSR);
+	if (ret < 0)
+		return IRQ_NONE;
+
+	/* Check if the interrupt is from our device */
+	if (!(ret & RFD77402_ICSR_RESULT))
+		return IRQ_NONE;
+
+	/* Signal completion of measurement */
+	complete(&data->completion);
+	return IRQ_HANDLED;
+}
+
+static int rfd77402_wait_for_irq(struct rfd77402_data *data)
+{
+	int ret;
+	/* As per datasheet, single measurement flow takes 100ms */
+	ret = wait_for_completion_timeout(&data->completion,
+					  msecs_to_jiffies(100));
+	if (ret == 0)
+		return -ETIMEDOUT;
+
+	return 0;
+}
+
 static int rfd77402_set_state(struct i2c_client *client, u8 state, u16 check)
 {
 	int ret;
@@ -111,8 +161,9 @@ static int rfd77402_set_state(struct i2c_client *client, u8 state, u16 check)
 	return 0;
 }
 
-static int rfd77402_measure(struct i2c_client *client)
+static int rfd77402_measure(struct rfd77402_data *data)
 {
+	struct i2c_client *client = data->client;
 	int ret;
 
 	ret = rfd77402_set_state(client, RFD77402_CMD_MCPU_ON,
@@ -126,13 +177,19 @@ static int rfd77402_measure(struct i2c_client *client)
 	if (ret < 0)
 		goto err;
 
-	/* Poll ICSR until RESULT bit is set */
-	ret = read_poll_timeout(i2c_smbus_read_byte_data, ret,
-				ret & RFD77402_ICSR_RESULT,
-				10000,    /* sleep: 10ms */
-				100000,   /* timeout: 100ms */
-				false,
-				client, RFD77402_ICSR);
+	if (data->irq_en) {
+		/* Re-initialize completion and wait for interrupt */
+		reinit_completion(&data->completion);
+		ret = rfd77402_wait_for_irq(data);
+	} else {
+		/* Poll ICSR until RESULT bit is set */
+		ret = read_poll_timeout(i2c_smbus_read_byte_data, ret,
+					ret & RFD77402_ICSR_RESULT,
+					10000,      /* sleep 10ms */
+					100000,     /* timeout 100ms */
+					false,
+					client, RFD77402_ICSR);
+	}
 	if (ret < 0)
 		goto err;
 
@@ -164,7 +221,7 @@ static int rfd77402_read_raw(struct iio_dev *indio_dev,
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
 		mutex_lock(&data->lock);
-		ret = rfd77402_measure(data->client);
+		ret = rfd77402_measure(data);
 		mutex_unlock(&data->lock);
 		if (ret < 0)
 			return ret;
@@ -184,8 +241,21 @@ static const struct iio_info rfd77402_info = {
 	.read_raw = rfd77402_read_raw,
 };
 
+static int rfd77402_config_irq(struct i2c_client *client, u8 csr, u8 ier)
+{
+	int ret;
+
+	ret = i2c_smbus_write_byte_data(client, RFD77402_ICSR, csr);
+	if (ret)
+		return ret;
+
+	return i2c_smbus_write_byte_data(client, RFD77402_IER, ier);
+}
+
 static int rfd77402_init(struct i2c_client *client)
 {
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+	struct rfd77402_data *data = iio_priv(indio_dev);
 	int ret, i;
 
 	ret = rfd77402_set_state(client, RFD77402_CMD_STANDBY,
@@ -193,10 +263,24 @@ static int rfd77402_init(struct i2c_client *client)
 	if (ret < 0)
 		return ret;
 
-	/* configure INT pad as push-pull, active low */
-	ret = i2c_smbus_write_byte_data(client, RFD77402_ICSR,
-					RFD77402_ICSR_INT_MODE);
-	if (ret < 0)
+	if (data->irq_en) {
+		/* Enable interrupt mode:
+		 * - Configure ICSR for auto-clear on read and
+		 *   push-pull output
+		 * - Enable "result ready" interrupt in IER
+		 */
+		ret = rfd77402_config_irq(client,
+					  RFD77402_ICSR_CLR_CFG |
+					  RFD77402_ICSR_INT_MODE,
+					  RFD77402_IER_RESULT);
+	} else {
+		/* Disable all interrupts:
+		 * - Clear ICSR configuration
+		 * - Disable all interrupts in IER
+		 */
+		ret = rfd77402_config_irq(client, 0, 0);
+	}
+	if (ret)
 		return ret;
 
 	/* I2C configuration */
@@ -271,7 +355,27 @@ static int rfd77402_probe(struct i2c_client *client)
 
 	data = iio_priv(indio_dev);
 	data->client = client;
-	mutex_init(&data->lock);
+	ret = devm_mutex_init(&client->dev, &data->lock);
+	if (ret)
+		return ret;
+
+	init_completion(&data->completion);
+	i2c_set_clientdata(client, indio_dev);
+
+	data->irq_en = false;
+	if (client->irq > 0) {
+		ret = devm_request_threaded_irq(&client->dev, client->irq,
+						NULL, rfd77402_interrupt_handler,
+						IRQF_ONESHOT,
+						"rfd77402", data);
+		if (ret)
+			return ret;
+
+		data->irq_en = true;
+		dev_dbg(&client->dev, "Using interrupt mode\n");
+	} else {
+		dev_dbg(&client->dev, "Using polling mode\n");
+	}
 
 	indio_dev->info = &rfd77402_info;
 	indio_dev->channels = rfd77402_channels;

-- 
2.43.0



