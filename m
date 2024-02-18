Return-Path: <linux-iio+bounces-2733-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C92859828
	for <lists+linux-iio@lfdr.de>; Sun, 18 Feb 2024 18:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3DE81C209A8
	for <lists+linux-iio@lfdr.de>; Sun, 18 Feb 2024 17:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F126EB6F;
	Sun, 18 Feb 2024 17:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="StSEs/EP"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A4C1E86B
	for <linux-iio@vger.kernel.org>; Sun, 18 Feb 2024 17:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708277282; cv=none; b=rK9n5nYnlmUoP70MzpWecRQSMrKYa37R7e2bMcjqspToIbxrNJtSg+GadxIV6ZYOCaV/CHiNKhzt4ePHKRB1eKMUO/mE7hZkipccpvDd6aV8w39UMz3Iv420AcT0cw093h2jyrzZp7ch8iKf5uAc5lcbPq2vbPLKY5R3sOrx4zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708277282; c=relaxed/simple;
	bh=kTDZTYbB2tYdmtSqhX07F928v1XXc4IfBsH4twzt8vA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fnVEtYONLnL+veCVzL9EPYckh8NROzcBX0CSqZA0fUaxAicON2VNAMZKrlwIqsALIAYTlNEXOyC5Up/l1NQV/nmBRe82D3zmFgaqlLMJzp8CQ6GsLQMi1QXwwqkG81G2aTQL9CwFcxnJhpBJi+pegAQPeXx60kAy/eJ/NvNamzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=StSEs/EP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D84CC433F1;
	Sun, 18 Feb 2024 17:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708277282;
	bh=kTDZTYbB2tYdmtSqhX07F928v1XXc4IfBsH4twzt8vA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=StSEs/EPZYLNQZ+rr/mYRKxWFbFfbL+yfuxW66HDcVDaQRgl/yIaPp6lf/aX7RkGK
	 DDt7Pioow30IzuDBxBEWyGc0sTJSIskF5k1E1QbTzoXOzhyGioIzEZIlwA5+Z6sJco
	 a+x24ku95w6z25DAcTMzxSxHt4lxqP+uDs2ri0UfbxXdNTEu0zll1yv9N7ZqdutLM7
	 32eHzXQC1knXnlweO9eGfjVxLd82AeSQTuFVGNMVZsCzsDxl01um0lKt/mTHjyUc1v
	 31GYRmUDxIYP1f7qnRA6Y6wcGtkiah0pfGr79qEwrDtNjyPhUImW1iAS8Uxp68U7r1
	 V1QWJr+URnorg==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Alisa-Dariana Roman <alisa.roman@analog.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Sean Nyekjaer <sean@geanix.com>,
	Andreas Klinger <ak@it-klinger.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6/8] iio: accel: mma8452: Switch from of specific to fwnode property handling.
Date: Sun, 18 Feb 2024 17:27:29 +0000
Message-ID: <20240218172731.1023367-7-jic23@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240218172731.1023367-1-jic23@kernel.org>
References: <20240218172731.1023367-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

In this case only use was to get an irq so easily converted.
Also include linux/mod_devicetable.h for struct of_device_id definition.

Using the generic firmware handling, this driver may be used with other
firmware types. This also removes an example that might get copied into
other drivers leaving them unable to be used with alternative firmware
types.

Cc: Haibo Chen <haibo.chen@nxp.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/accel/mma8452.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index d3fd0318e47b..62e6369e2269 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -19,6 +19,8 @@
  */
 
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/property.h>
 #include <linux/i2c.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -28,8 +30,6 @@
 #include <linux/iio/triggered_buffer.h>
 #include <linux/iio/events.h>
 #include <linux/delay.h>
-#include <linux/of.h>
-#include <linux/of_irq.h>
 #include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
 
@@ -1642,7 +1642,7 @@ static int mma8452_probe(struct i2c_client *client)
 	if (client->irq) {
 		int irq2;
 
-		irq2 = of_irq_get_byname(client->dev.of_node, "INT2");
+		irq2 = fwnode_irq_get_byname(dev_fwnode(&client->dev), "INT2");
 
 		if (irq2 == client->irq) {
 			dev_dbg(&client->dev, "using interrupt line INT2\n");
-- 
2.43.2


