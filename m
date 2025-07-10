Return-Path: <linux-iio+bounces-21542-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9003AB009A3
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jul 2025 19:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 469A2565757
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jul 2025 17:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07BCE2F0C7E;
	Thu, 10 Jul 2025 17:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oAL8EgC6"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA1C2F0C76
	for <linux-iio@vger.kernel.org>; Thu, 10 Jul 2025 17:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752167492; cv=none; b=P7Nb5ByoyQYarM3IiVcMmbt0cNF7vFFlxIq3ItsSN5WYC5dM1vsJ6Vfdrxfj/6cZlIpSaO7Ya6b6k6ru7a7/ylVZ1nBALeZfuFDftU1J82TYlVh1FFnonlhGdl+pbFd42MUHcT2tSMOsmmgShaDS8dKf0S4zhJCAgPGJOHbQ7FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752167492; c=relaxed/simple;
	bh=WJrjzx0xTYePDHl03t7SXWfXqWmR7G5pAGD8kTw5gbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vEhf8Fc2DuzjbzzKK9ltjof8yyKFl6Opt1VnjT6vADWocD6bsFFuQKcanuTfBPJHlvGq6c+JaeGB229LGHt5SnqLpEnD1la1dXpmPeyfM9bCnxTmd9M/PENHZQtKSG8pKD1CV8+BjbVZRWn42nsAGymbRFJ+II606mBklcyS+CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oAL8EgC6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E389C4CEF4;
	Thu, 10 Jul 2025 17:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752167492;
	bh=WJrjzx0xTYePDHl03t7SXWfXqWmR7G5pAGD8kTw5gbk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oAL8EgC6+wS8kIAw3Q9grDRnPU61Ai29XKFjSfmi4aEa5eq6EH/RDwDh+Lc/0RTdg
	 5KdViyAinLZeD89sjdHfnF6IDxAE+8yd5xFvH233GkHhUlPUerYF+TrICtVpkd8/G+
	 sh9KTdO53YEpQ59iJpL4aBtIpoQWc3lMjCWV1lAEpTsjI9CBfyOZqh6Gu+Yp65skvL
	 O/I7zmWjtTTbO4A/f9bBTPk43B663C0OAilX0b4rw1qPcFzrZmHWEP6k/qEgElvLaZ
	 nGzSs0Zh6rK8zqFUVPlQ9+MfxlGbBBIoCFGqu6KPs2CIBvB6KthPq8wFq6qKZbKGX+
	 6pFYrjeeyyCrg==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>
Cc: Denis Ciocca <denis.ciocca@st.com>,
	Vasileios Amoiridis <vassilisamir@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 6/7] iio: pressure: mprls0025pa: Apply IWYU principles to includes.
Date: Thu, 10 Jul 2025 18:11:06 +0100
Message-ID: <20250710171107.443790-7-jic23@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250710171107.443790-1-jic23@kernel.org>
References: <20250710171107.443790-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

General rework of this driver's includes triggered by the new W=1
warning on lack of include of export.h.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/pressure/mprls0025pa.c     | 9 +++++++--
 drivers/iio/pressure/mprls0025pa.h     | 9 ++-------
 drivers/iio/pressure/mprls0025pa_i2c.c | 1 -
 3 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/pressure/mprls0025pa.c b/drivers/iio/pressure/mprls0025pa.c
index 2336f2760eae..60f693e8e79b 100644
--- a/drivers/iio/pressure/mprls0025pa.c
+++ b/drivers/iio/pressure/mprls0025pa.c
@@ -10,13 +10,18 @@
  */
 
 #include <linux/array_size.h>
-#include <linux/bitfield.h>
 #include <linux/bits.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/export.h>
+#include <linux/interrupt.h>
+#include <linux/jiffies.h>
 #include <linux/math64.h>
-#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/property.h>
 #include <linux/units.h>
+#include <linux/stddef.h>
 
 #include <linux/gpio/consumer.h>
 
diff --git a/drivers/iio/pressure/mprls0025pa.h b/drivers/iio/pressure/mprls0025pa.h
index d62a018eaff3..b2608eb69ec4 100644
--- a/drivers/iio/pressure/mprls0025pa.h
+++ b/drivers/iio/pressure/mprls0025pa.h
@@ -11,11 +11,10 @@
 #ifndef _MPRLS0025PA_H
 #define _MPRLS0025PA_H
 
+#include <linux/compiler.h>
 #include <linux/completion.h>
-#include <linux/delay.h>
-#include <linux/device.h>
+#include <linux/minmax.h>
 #include <linux/mutex.h>
-#include <linux/stddef.h>
 #include <linux/types.h>
 
 #include <linux/iio/iio.h>
@@ -28,10 +27,6 @@
 
 struct device;
 
-struct iio_chan_spec;
-struct iio_dev;
-
-struct mpr_data;
 struct mpr_ops;
 
 enum mpr_func_id {
diff --git a/drivers/iio/pressure/mprls0025pa_i2c.c b/drivers/iio/pressure/mprls0025pa_i2c.c
index 79811fd4a02b..32d3d437a5af 100644
--- a/drivers/iio/pressure/mprls0025pa_i2c.c
+++ b/drivers/iio/pressure/mprls0025pa_i2c.c
@@ -8,7 +8,6 @@
  *  https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/micropressure-mpr-series/documents/sps-siot-mpr-series-datasheet-32332628-ciid-172626.pdf
  */
 
-#include <linux/device.h>
 #include <linux/errno.h>
 #include <linux/i2c.h>
 #include <linux/mod_devicetable.h>
-- 
2.50.0


