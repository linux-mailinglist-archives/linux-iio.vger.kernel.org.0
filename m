Return-Path: <linux-iio+bounces-11470-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 274DE9B334E
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 15:22:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 586DD1C20D90
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 14:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F237B1DE3DD;
	Mon, 28 Oct 2024 14:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b="N2EsH13F"
X-Original-To: linux-iio@vger.kernel.org
Received: from a.peacevolution.org (a.peacevolution.org [206.189.193.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7F51DE3B2;
	Mon, 28 Oct 2024 14:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.193.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730125321; cv=none; b=KxXfN6WMR5Q7X8Jlac3F6mm8FnkZwCuA4TtPWfoJcPu9q+gfr+2OFYXNvsvSXTgLtJCL2ayFhKt0q7Jk9kZs2qT8sxxC3aYDMYNA5d4XOf2kmz6gjdV/mqHlxiJMuhItMrY635b5oczuNvvTv8K5BdommzfJPqdOSC9GZUnJiB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730125321; c=relaxed/simple;
	bh=507hLKffuNcyueEfogPk5RCl8UnnoDrtN4ihkP6hxtY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KetvArYx1B5CCXzuce0BvcA7kWzw+NXEbDb6TD8nUHqZ719HRhkguqn06x9RFOflv1KXmKoZIQabSzfjMJaaIQm4XonzFLt9mPPB8kvfx8wE7gnU5eDcr5l20qHJ5gwb5P2V0pm74EcQgKiXR6rvnhTOExghqOeiv56nDMgSglI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org; spf=pass smtp.mailfrom=peacevolution.org; dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b=N2EsH13F; arc=none smtp.client-ip=206.189.193.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peacevolution.org
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
	by a.peacevolution.org (Postfix) with ESMTPA id 8BFDB4C6A3;
	Mon, 28 Oct 2024 14:21:57 +0000 (UTC)
From: Aren Moynihan <aren@peacevolution.org>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Cc: Aren Moynihan <aren@peacevolution.org>,
	Kaustabh Chakraborty <kauschluss@disroot.org>,
	=?UTF-8?q?Barnab=C3=A1s=20Cz=C3=A9m=C3=A1n?= <trabarni@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Ondrej Jirman <megi@xff.cz>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	Dragan Simic <dsimic@manjaro.org>,
	phone-devel@vger.kernel.org
Subject: [PATCH v3 2/6] iio: light: stk3310: handle all remove logic with devm callbacks
Date: Mon, 28 Oct 2024 10:19:56 -0400
Message-ID: <20241028142000.1058149-3-aren@peacevolution.org>
In-Reply-To: <20241028142000.1058149-1-aren@peacevolution.org>
References: <20241028142000.1058149-1-aren@peacevolution.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: auth=pass smtp.auth=aren@peacevolution.org smtp.mailfrom=aren@peacevolution.org
X-Spam-Level: *****
X-Spamd-Bar: +++++
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=peacevolution.org;
	s=dkim; t=1730125318;
	h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding:in-reply-to:references;
	bh=XdEG+PzvG0Vo99BU/R4RjPsHvmaNQJ3LSrH+8TVql9M=;
	b=N2EsH13FDOQFjN8HkB+osgOBN8dUDuhjxjaYEcRsLPXlm636aADXeXR8Ybm0VHHf8pGmmv
	YScoijdrRYm4Jrw2F3qOCB+ANT9XC/0ViSVsKemakgDBPPVntrbuj8e0HHL06jWOL6jpX6
	94B/thP/0MgpRh548+mX3NM11ZItS+g=

Using devm callbacks helps to make the ordering of probe / remove
operations easier to reason about and removes some duplicate code
between the probe error path and driver remove.
---

Notes:
    Added in v3

 drivers/iio/light/stk3310.c | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
index ed20b6714546..2e1aa551bdbc 100644
--- a/drivers/iio/light/stk3310.c
+++ b/drivers/iio/light/stk3310.c
@@ -484,6 +484,17 @@ static int stk3310_set_state(struct stk3310_data *data, u8 state)
 	return ret;
 }
 
+static void stk3310_set_state_disable(void *private)
+{
+	int ret;
+	struct stk3310_data *data = private;
+	struct device *dev = &data->client->dev;
+
+	ret = stk3310_set_state(data, STK3310_STATE_STANDBY);
+	if (ret)
+		dev_err(dev, "failed to set state to standby: %d\n", ret);
+}
+
 static int stk3310_init(struct iio_dev *indio_dev)
 {
 	int ret;
@@ -507,6 +518,11 @@ static int stk3310_init(struct iio_dev *indio_dev)
 		return ret;
 	}
 
+	ret = devm_add_action_or_reset(&client->dev, stk3310_set_state_disable, data);
+	if (ret)
+		return dev_err_probe(&client->dev, ret,
+				     "failed to register cleanup function\n");
+
 	/* Enable PS interrupts */
 	ret = regmap_field_write(data->reg_int_ps, STK3310_PSINT_EN);
 	if (ret < 0)
@@ -650,29 +666,17 @@ static int stk3310_probe(struct i2c_client *client)
 		if (ret < 0) {
 			dev_err(&client->dev, "request irq %d failed\n",
 				client->irq);
-			goto err_standby;
+			return ret;
 		}
 	}
 
-	ret = iio_device_register(indio_dev);
+	ret = devm_iio_device_register(&client->dev, indio_dev);
 	if (ret < 0) {
 		dev_err(&client->dev, "device_register failed\n");
-		goto err_standby;
+		return ret;
 	}
 
 	return 0;
-
-err_standby:
-	stk3310_set_state(data, STK3310_STATE_STANDBY);
-	return ret;
-}
-
-static void stk3310_remove(struct i2c_client *client)
-{
-	struct iio_dev *indio_dev = i2c_get_clientdata(client);
-
-	iio_device_unregister(indio_dev);
-	stk3310_set_state(iio_priv(indio_dev), STK3310_STATE_STANDBY);
 }
 
 static int stk3310_suspend(struct device *dev)
@@ -736,7 +740,6 @@ static struct i2c_driver stk3310_driver = {
 		.acpi_match_table = stk3310_acpi_id,
 	},
 	.probe =        stk3310_probe,
-	.remove =           stk3310_remove,
 	.id_table =         stk3310_i2c_id,
 };
 
-- 
2.47.0


