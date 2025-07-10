Return-Path: <linux-iio+bounces-21539-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A35E2B009A0
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jul 2025 19:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7276A56723C
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jul 2025 17:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909892F0E54;
	Thu, 10 Jul 2025 17:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FxNRqaij"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F462F0E48
	for <linux-iio@vger.kernel.org>; Thu, 10 Jul 2025 17:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752167486; cv=none; b=BItr6RvVDxPsSyROg1UDdnw4SdI/W0W7gmCxrdw58HhV35gMYsIF51kdNUN0px7qWDZRUD1rQ8Ng0d8ZXTryg+EM67UMr57hsPcTjs65qiGGfFGn6eZgLSOIBhxKvKTsLq57Ed3zg24ddMtoPIn4Uq8jDYrcY8kYfkSAJZAshEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752167486; c=relaxed/simple;
	bh=LlckRpJ+9x+YYl7m9SbyoxNyVStkFOWXA+YtjQ7Ot5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jFyoG3kMwp3pzaEexq+64g+mrJB74SpVPVcaVnzE3uaADe2Eah628DwHglY5m+wmfN7SUyUy4SUpyqiJh1fo4xsIvnevpog0qvlMASBYOIQXKqI4Gvvy3sC7MQHkblHpJmD0Ev9jY54fW2hGdNVZCF6B9Z5jFnnn9MWmXK/MuGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FxNRqaij; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8544CC4CEF6;
	Thu, 10 Jul 2025 17:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752167486;
	bh=LlckRpJ+9x+YYl7m9SbyoxNyVStkFOWXA+YtjQ7Ot5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FxNRqaij4xM0m3sPDjHms4zcutq+rQTKFEwa/XkpyQMiFgr1eCuy28Q59hSb6RIRC
	 4PNJWTCqvn/EDBHICR8C+obUpBnL/AL+5KZv9xMi7eX5ihQW8Vnafy4oeSBAHfQFU9
	 135qgAQW3aBWICivJVrGkEbODzAsR1xKYQq71PaBXX4eO/T0Rj2Y50+WO3lT05AZNt
	 QHjnGWeZKx7y7e8QgJMXAYFqJZDMEt8vzKzMOt2+nrBPXOMlu0qqCwrctkfukTzpgZ
	 hoNkCBhX9fQQfrIH0GZZWPNzHcudADw52avW+vPNZS3UE7QC6WPcho19qT2Y7g9GIe
	 wvI6RaBmwu/1g==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>
Cc: Denis Ciocca <denis.ciocca@st.com>,
	Vasileios Amoiridis <vassilisamir@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 3/7] iio: pressure: mpl115: Apply iwyu principles to includes
Date: Thu, 10 Jul 2025 18:11:03 +0100
Message-ID: <20250710171107.443790-4-jic23@kernel.org>
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

Motivated by fixing the new W=1 warning for lack of include of
linux/export.h this reworks all the includes for this driver
along the lines of approximate include what you use principles.

One question here is what to do about gfp_types.h.
For now I've added a rule to allow GFP_KERNEL to come from linux/slab.h
or linux/device.h (for devm_ calls).  In this driver slab.h is
never used directly so linux/device.h provides the symbol.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/pressure/mpl115.c     | 13 ++++++++++---
 drivers/iio/pressure/mpl115.h     |  1 +
 drivers/iio/pressure/mpl115_i2c.c |  8 +++++++-
 drivers/iio/pressure/mpl115_spi.c |  5 +++++
 4 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/pressure/mpl115.c b/drivers/iio/pressure/mpl115.c
index 71beb28b7f2c..448d030d5621 100644
--- a/drivers/iio/pressure/mpl115.c
+++ b/drivers/iio/pressure/mpl115.c
@@ -6,11 +6,18 @@
  *
  * TODO: synchronization with system suspend
  */
-
-#include <linux/module.h>
-#include <linux/iio/iio.h>
+#include <linux/array_size.h>
+#include <linux/bits.h>
 #include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/export.h>
 #include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/pm_runtime.h>
+#include <linux/stddef.h>
+#include <linux/iio/iio.h>
 
 #include "mpl115.h"
 
diff --git a/drivers/iio/pressure/mpl115.h b/drivers/iio/pressure/mpl115.h
index 78a0068a17bb..480ee112f134 100644
--- a/drivers/iio/pressure/mpl115.h
+++ b/drivers/iio/pressure/mpl115.h
@@ -7,6 +7,7 @@
  */
 
 #include <linux/pm_runtime.h>
+#include <linux/types.h>
 
 #ifndef _MPL115_H_
 #define _MPL115_H_
diff --git a/drivers/iio/pressure/mpl115_i2c.c b/drivers/iio/pressure/mpl115_i2c.c
index 3db9ef4e2770..160cf1e5a317 100644
--- a/drivers/iio/pressure/mpl115_i2c.c
+++ b/drivers/iio/pressure/mpl115_i2c.c
@@ -9,11 +9,17 @@
  * Datasheet: http://www.nxp.com/files/sensors/doc/data_sheet/MPL115A2.pdf
  */
 
-#include <linux/module.h>
+#include <linux/errno.h>
 #include <linux/i2c.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/pm.h>
+#include <linux/types.h>
 
 #include "mpl115.h"
 
+struct device;
+
 static int mpl115_i2c_init(struct device *dev)
 {
 	return 0;
diff --git a/drivers/iio/pressure/mpl115_spi.c b/drivers/iio/pressure/mpl115_spi.c
index 4e1d24beff94..26df328769a4 100644
--- a/drivers/iio/pressure/mpl115_spi.c
+++ b/drivers/iio/pressure/mpl115_spi.c
@@ -7,8 +7,13 @@
  * Datasheet: http://www.nxp.com/files/sensors/doc/data_sheet/MPL115A1.pdf
  */
 
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
+#include <linux/pm.h>
 #include <linux/spi/spi.h>
+#include <linux/types.h>
 
 #include "mpl115.h"
 
-- 
2.50.0


