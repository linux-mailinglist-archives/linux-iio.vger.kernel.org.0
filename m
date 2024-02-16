Return-Path: <linux-iio+bounces-2597-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA485857A42
	for <lists+linux-iio@lfdr.de>; Fri, 16 Feb 2024 11:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13CF51C20CD8
	for <lists+linux-iio@lfdr.de>; Fri, 16 Feb 2024 10:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67AF28E22;
	Fri, 16 Feb 2024 10:28:32 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0633428DDB
	for <linux-iio@vger.kernel.org>; Fri, 16 Feb 2024 10:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708079312; cv=none; b=AphNCuno2ev9c5Cu5Lg8LK38xVy28Syrf39Gb/r8xdXWrR9SKLZ/qxxF9yDPvdfIRanlXk3OSOSlQUULf0BjRPhV3Tjb4GJs7U+AXRwHpY2NfSHJ+QiRjXEYTqP45SDHsqtiyCbPmQHnKDI3EtLef6HAIXImIlUBB20druRMDV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708079312; c=relaxed/simple;
	bh=ZeXvEB7viOHK4bgTozoMlOU4OC6pZg8V0UUCaiKpFeI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c2nk5p7DRJbdqWwkntcufLwP2rGAmguyVhy3hf4VSQvNlxNRbr8SbdBf1tCHFf9XI1zWdmJ7e83TTPhTPS7LsUUko5/Gr/eao50RYojQbYrxBfkSpdSx35QqG8DGPIq7TrWllyh1katobpxPEIjIREx/E9Q1sX7+wgOsE25zHXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <m.felsch@pengutronix.de>)
	id 1ravS9-0006gI-Ih; Fri, 16 Feb 2024 11:28:21 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
To: puranjay12@gmail.com,
	jic23@kernel.org,
	lars@metafoo.de,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de,
	thomas.haemmerle@leica-geosystems.com
Subject: [RESEND PATCH 2/2] iio: temperature: tmp117: add support for vcc-supply
Date: Fri, 16 Feb 2024 11:28:20 +0100
Message-Id: <20240216102820.1395815-2-m.felsch@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240216102820.1395815-1-m.felsch@pengutronix.de>
References: <20240216102820.1395815-1-m.felsch@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::28
X-SA-Exim-Mail-From: m.felsch@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org

From: Thomas Haemmerle <thomas.haemmerle@leica-geosystems.com>

Add support to specify the VCC supply which is required to power the
device.

Signed-off-by: Thomas Haemmerle <thomas.haemmerle@leica-geosystems.com>
Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
Resend since I forgot to add the DT maintainers

 drivers/iio/temperature/tmp117.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iio/temperature/tmp117.c b/drivers/iio/temperature/tmp117.c
index 059953015ae7..69328066811a 100644
--- a/drivers/iio/temperature/tmp117.c
+++ b/drivers/iio/temperature/tmp117.c
@@ -17,6 +17,7 @@
 #include <linux/kernel.h>
 #include <linux/limits.h>
 #include <linux/property.h>
+#include <linux/regulator/consumer.h>
 
 #include <linux/iio/iio.h>
 
@@ -152,6 +153,10 @@ static int tmp117_probe(struct i2c_client *client)
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_WORD_DATA))
 		return -EOPNOTSUPP;
 
+	ret = devm_regulator_get_enable(&client->dev, "vcc");
+	if (ret)
+		return ret;
+
 	dev_id = i2c_smbus_read_word_swapped(client, TMP117_REG_DEVICE_ID);
 	if (dev_id < 0)
 		return dev_id;
-- 
2.39.2


