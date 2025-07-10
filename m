Return-Path: <linux-iio+bounces-21541-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7CDB009A2
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jul 2025 19:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54834563E20
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jul 2025 17:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F27B2F0E5C;
	Thu, 10 Jul 2025 17:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZEl9yGXp"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B0C2F0C5A
	for <linux-iio@vger.kernel.org>; Thu, 10 Jul 2025 17:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752167489; cv=none; b=tUtGcIwPKwMdHHIJmhfu+l38UfcTjGd1hUxFoF5GKseXIMaUHHo1XmHztI26h/3BCixoLXXt7zEMqtn5CP1yxiS37lGe4ZqFy1lhiLk3rzSZpEoIxrOCdoZs+HiGABl0wplBPHKrojYGpxIdtgaBiDJvmak2q/4heSnMwwD97Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752167489; c=relaxed/simple;
	bh=p0ZOsPnjPgZXczTXt7DUmMJtA+zCcsPbR05Dq4+utUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S+MRknWdZL5iEb4lziGBBXhsd+z5Nv+qbPjqtB82jd7T6P7f3q6MI8JBjuBQ0XPR3kU21h2TWET8nzVtycEXBVLDlNU4znGeWzwWR0U0AfB2erC2sbdGHqa+tLV3JaErb/X0DSFmR8R7dBAuQQQtURU75bzrsTv9nwHoRqZNrrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZEl9yGXp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4196BC4CEF5;
	Thu, 10 Jul 2025 17:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752167489;
	bh=p0ZOsPnjPgZXczTXt7DUmMJtA+zCcsPbR05Dq4+utUs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZEl9yGXpFO8VVXUGvZw83IkJgXh4HvRcbuuSSe6opsD7E5Pp6AKy+YKXIApeQeVvz
	 PxtrsxzZHOf2TvkJ9+Ym+kpzFYZ7G8leNvN1OKNXB8JpufGwhRwVLCgE5F9vFixHW+
	 Kthi0ZjY1UH/6imFiEdOqALw4xD3wfuGn4eoiKIG/uVT0weD5Vrn1gdg4UogImLsS+
	 jRJpnvGN8eI957bobOHc53fJd6F4VqH/eLDhimRsjYOaAhudIWf+RcFP5bD0oAQHTR
	 EgT/Ux0gaXX2JyERPuVtC6juDbQ2DM/AcmhznBUQHja7HHdxbuTm2Rcn7sMWFv+ws+
	 wfJGvpqyxQypg==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>
Cc: Denis Ciocca <denis.ciocca@st.com>,
	Vasileios Amoiridis <vassilisamir@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 5/7] iio: pressure: hsc030pa: Apply IWYU principles to includes.
Date: Thu, 10 Jul 2025 18:11:05 +0100
Message-ID: <20250710171107.443790-6-jic23@kernel.org>
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

Motivated by solving the W=1 warning recently added that notes that
linux/export.h wasn't included here. Do a thorough job by applying
approximate include what you use principles to includes.  In this
particular case there were quite a few unnecessary includes that are
removed.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/pressure/hsc030pa.c     | 12 ++++++------
 drivers/iio/pressure/hsc030pa.h     |  5 ++---
 drivers/iio/pressure/hsc030pa_i2c.c |  4 ----
 drivers/iio/pressure/hsc030pa_spi.c |  5 -----
 4 files changed, 8 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/pressure/hsc030pa.c b/drivers/iio/pressure/hsc030pa.c
index 2d00c0656259..44f97ba1629f 100644
--- a/drivers/iio/pressure/hsc030pa.c
+++ b/drivers/iio/pressure/hsc030pa.c
@@ -10,25 +10,25 @@
 #include <linux/array_size.h>
 #include <linux/bitfield.h>
 #include <linux/bits.h>
-#include <linux/cleanup.h>
-#include <linux/init.h>
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/export.h>
+#include <linux/interrupt.h>
 #include <linux/math64.h>
-#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/printk.h>
 #include <linux/property.h>
 #include <linux/regulator/consumer.h>
+#include <linux/stddef.h>
 #include <linux/string.h>
 #include <linux/types.h>
+#include <linux/unaligned.h>
 #include <linux/units.h>
 
 #include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
-#include <linux/iio/sysfs.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
 
-#include <linux/unaligned.h>
 
 #include "hsc030pa.h"
 
diff --git a/drivers/iio/pressure/hsc030pa.h b/drivers/iio/pressure/hsc030pa.h
index 5db46784f4c6..01f2b02a84e8 100644
--- a/drivers/iio/pressure/hsc030pa.h
+++ b/drivers/iio/pressure/hsc030pa.h
@@ -8,6 +8,8 @@
 #ifndef _HSC030PA_H
 #define _HSC030PA_H
 
+#include <linux/compiler.h>
+#include <linux/minmax.h>
 #include <linux/types.h>
 
 #include <linux/iio/iio.h>
@@ -17,9 +19,6 @@
 
 struct device;
 
-struct iio_chan_spec;
-struct iio_dev;
-
 struct hsc_data;
 struct hsc_chip_data;
 
diff --git a/drivers/iio/pressure/hsc030pa_i2c.c b/drivers/iio/pressure/hsc030pa_i2c.c
index a34ef4653f34..96aefd9f213a 100644
--- a/drivers/iio/pressure/hsc030pa_i2c.c
+++ b/drivers/iio/pressure/hsc030pa_i2c.c
@@ -9,14 +9,10 @@
  */
 
 #include <linux/delay.h>
-#include <linux/device.h>
 #include <linux/errno.h>
 #include <linux/i2c.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/types.h>
-
-#include <linux/iio/iio.h>
 
 #include "hsc030pa.h"
 
diff --git a/drivers/iio/pressure/hsc030pa_spi.c b/drivers/iio/pressure/hsc030pa_spi.c
index 5d331b3b6da8..ae9f4bb51f30 100644
--- a/drivers/iio/pressure/hsc030pa_spi.c
+++ b/drivers/iio/pressure/hsc030pa_spi.c
@@ -9,14 +9,9 @@
  */
 
 #include <linux/delay.h>
-#include <linux/device.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/spi/spi.h>
-#include <linux/stddef.h>
-#include <linux/types.h>
-
-#include <linux/iio/iio.h>
 
 #include "hsc030pa.h"
 
-- 
2.50.0


