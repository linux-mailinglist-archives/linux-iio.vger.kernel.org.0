Return-Path: <linux-iio+bounces-27815-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 98903D232B3
	for <lists+linux-iio@lfdr.de>; Thu, 15 Jan 2026 09:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1186030B7F80
	for <lists+linux-iio@lfdr.de>; Thu, 15 Jan 2026 08:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7C1335067;
	Thu, 15 Jan 2026 08:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EFOSpwvU"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF4E334698;
	Thu, 15 Jan 2026 08:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768465695; cv=none; b=rRmMe/qVMz+g3xa4bJZnxGzJaTEkOFrPCnyaNg0Or5Nsz5Da7fVGbdfTUjreLfLfUvWdEwLVoNzi0nleVzQ4KFWhJnatHpSxoTxMV5SriCq4lwTmyjHLcatC+6wRWplxovbhXutWScpN+htU/9+FkIrl0ntNh/jaxrYO7XOdTAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768465695; c=relaxed/simple;
	bh=qcVt3Bv5jfMgQ/y4iZfPhQtIVMFB8I5f+l/a4BsqWCY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bg7nPqPKRbrsRCCqN4cAhu6VSIkJPD3324OPqe5vjr3tF/whRBwOE2605tELs6plxU1dAk8Neelsv9ojN7snqxK9mDrZSTUW3r3ZEM8xDl6T4LdZTcD1kRL3BzDIS9D48q7kV6L070mdIBfaPsNM05Ao86uXnmPaGDYirRRcu6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EFOSpwvU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BBEC8C2BC9E;
	Thu, 15 Jan 2026 08:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768465694;
	bh=qcVt3Bv5jfMgQ/y4iZfPhQtIVMFB8I5f+l/a4BsqWCY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=EFOSpwvUNDxS5bPbBcpTE+lIzfst+2x5UCrl1ketCouK27oN36840LrbReaB11y5C
	 A0HAZA0r9PczneUCEBd+s8IxpGIaUSU7bPQUOeng6WRuOwI1p1D0Wa1uVlQ5bINk1y
	 wkY8/JD9gn9jmAQSiANdBboEhNL+5LG8ar83nzLxuEtEwqna9Tzf4GWZiRdjbUTZxy
	 CFN1xRBp342jbWd5Lc5s2HmYlAmV+8Ke7xlBLZ53168KGtqpUYJh08I0uGEfrGdqWE
	 H49oHb/L1KEcLu5oEEfBUPPbXTQ9ezj0fotKNNo49Z7D9MQeeYypKiMETi7XGTANDl
	 fEsPqFAPYrsww==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0EBED39010;
	Thu, 15 Jan 2026 08:28:14 +0000 (UTC)
From: Shrikant Raskar via B4 Relay <devnull+raskar.shree97.gmail.com@kernel.org>
Date: Thu, 15 Jan 2026 13:57:39 +0530
Subject: [PATCH v5 3/5] iio: proximity: rfd77402: Add interrupt handling
 support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-rfd77402_v5-v5-3-594eb57683e4@gmail.com>
References: <20260115-rfd77402_v5-v5-0-594eb57683e4@gmail.com>
In-Reply-To: <20260115-rfd77402_v5-v5-0-594eb57683e4@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: skhan@linuxfoundation.org, david.hunter.linux@gmail.com, 
 raskar.shree97@gmail.com, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768465693; l=5569;
 i=raskar.shree97@gmail.com; s=20260101; h=from:subject:message-id;
 bh=C3tD21DVcrSgT7m49qVjA0qq6ip8LRECwCOFJRa5kpU=;
 b=YzqmiZnqruOfQ4IhPBdUKSBTAUT1KokSQay9Ysl8YoAgUAwWHT/0sBRqpR1J+H4FKvHFLZSRj
 NYx4X11SAP6AKlGixVoxmANGcuQvQBRGmmreRZsDrhFrThX2Z1F7poB
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
 drivers/iio/proximity/rfd77402.c | 106 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 101 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/proximity/rfd77402.c b/drivers/iio/proximity/rfd77402.c
index 8c6379bebcc3..dd79c9ee838b 100644
--- a/drivers/iio/proximity/rfd77402.c
+++ b/drivers/iio/proximity/rfd77402.c
@@ -6,12 +6,13 @@
  *
  * 7-bit I2C slave address 0x4c
  *
- * TODO: interrupt
  * https://media.digikey.com/pdf/Data%20Sheets/RF%20Digital%20PDFs/RFD77402.pdf
  */
 
+#include <linux/completion.h>
 #include <linux/delay.h>
 #include <linux/i2c.h>
+#include <linux/interrupt.h>
 #include <linux/iopoll.h>
 #include <linux/module.h>
 
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
@@ -81,6 +90,8 @@ struct rfd77402_data {
 	struct i2c_client *client;
 	/* Serialize reads from the sensor */
 	struct mutex lock;
+	struct completion completion;
+	bool irq_en;
 };
 
 static const struct iio_chan_spec rfd77402_channels[] = {
@@ -91,6 +102,41 @@ static const struct iio_chan_spec rfd77402_channels[] = {
 	},
 };
 
+static irqreturn_t rfd77402_interrupt_handler(int irq, void *pdata)
+{
+	struct rfd77402_data *data = pdata;
+	int ret;
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
+
+	/*
+	 * According to RFD77402 Datasheet v1.8,
+	 * Section 3.1.1 "Single Measure" (Figure: Single Measure Flow Chart),
+	 * the suggested timeout for single measure is 100 ms.
+	 */
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
@@ -116,6 +162,11 @@ static int rfd77402_wait_for_result(struct rfd77402_data *data)
 	struct i2c_client *client = data->client;
 	int ret;
 
+	if (data->irq_en) {
+		reinit_completion(&data->completion);
+		return rfd77402_wait_for_irq(data);
+	}
+
 	return read_poll_timeout(i2c_smbus_read_byte_data, ret,
 				 ret & RFD77402_ICSR_RESULT,
 				 10 * USEC_PER_MSEC,
@@ -192,8 +243,21 @@ static const struct iio_info rfd77402_info = {
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
@@ -201,10 +265,26 @@ static int rfd77402_init(struct i2c_client *client)
 	if (ret < 0)
 		return ret;
 
-	/* configure INT pad as push-pull, active low */
-	ret = i2c_smbus_write_byte_data(client, RFD77402_ICSR,
-					RFD77402_ICSR_INT_MODE);
-	if (ret < 0)
+	if (data->irq_en) {
+		/*
+		 * Enable interrupt mode:
+		 * - Configure ICSR for auto-clear on read and
+		 *   push-pull output
+		 * - Enable "result ready" interrupt in IER
+		 */
+		ret = rfd77402_config_irq(client,
+					  RFD77402_ICSR_CLR_CFG |
+					  RFD77402_ICSR_INT_MODE,
+					  RFD77402_IER_RESULT);
+	} else {
+		/*
+		 * Disable all interrupts:
+		 * - Clear ICSR configuration
+		 * - Disable all interrupts in IER
+		 */
+		ret = rfd77402_config_irq(client, 0, 0);
+	}
+	if (ret)
 		return ret;
 
 	/* I2C configuration */
@@ -280,6 +360,22 @@ static int rfd77402_probe(struct i2c_client *client)
 	data = iio_priv(indio_dev);
 	data->client = client;
 	mutex_init(&data->lock);
+	init_completion(&data->completion);
+	i2c_set_clientdata(client, indio_dev);
+
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



