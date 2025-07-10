Return-Path: <linux-iio+bounces-21540-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80978B009A5
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jul 2025 19:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC4C33BCF8D
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jul 2025 17:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A49A2F1988;
	Thu, 10 Jul 2025 17:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FUuCxh2I"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6CF2F1985
	for <linux-iio@vger.kernel.org>; Thu, 10 Jul 2025 17:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752167488; cv=none; b=qPKerY9lmps7hH6lTZ8CWav7YJ6S2OXufztn4TLT1a3YzH4+rR+REV2P4KIeo2pth0eLTnrRtrrLpQKJUYbpzzrCHpuIJzb6fTEU04H9ino1GuwRpzm3bS13Vf/2jeZL0772+imXlT4bdpiHhJHqmRGJck7XA0NeiYfEVPWpDXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752167488; c=relaxed/simple;
	bh=O9S6MkOsdRfGUFt+NmKFeqJtC8gW1lU4t0Jl+9l001k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sfYzOKqlj3jsRyUxAl2+gpm3ajpdPNY19aRKMFvkSbCzeAbJUtiGl7INIu9hVd+cekBYbfQ3PBVLBCAfBJYgIyhqBQ89qmC/cFi13CKClOwucCUX9wzGc2vQWCLSxQCmiwRocF90rkhNS2WIHbVyix4QCX03wBSkfPqPTuxbBTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FUuCxh2I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64BCDC4CEE3;
	Thu, 10 Jul 2025 17:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752167487;
	bh=O9S6MkOsdRfGUFt+NmKFeqJtC8gW1lU4t0Jl+9l001k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FUuCxh2IJKnap/F1Z5n8YzarSSi0K0xpaxL5XLfzHu9zADMhiNB8F8d8dQF3Y0IUE
	 7luN8Jl+suj6gZeC8rveNBTvnAWUjfS0kcsepHkhmGBC5Ar40HIB1D+sjSKi2sBbtK
	 B2qf61s1v/JItmQN14sfgd8kj1HFiK6IdYgl/hTxyxJqfJjlvpEHnJN0pTjRpf+T+I
	 neLPfAk/cLq6vSQwc3WY6cE0pNhFfzzdV90O8H7d93VLs+iey0XaHQgv8hePw2pqld
	 n85oKgskW5ByZ1tfMWFx+LS+AmX+DBW3RUkc6w+ydQDfn4QAMIL+LfvVAH6JOT1s7e
	 I28FTrw1k/qFQ==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>
Cc: Denis Ciocca <denis.ciocca@st.com>,
	Vasileios Amoiridis <vassilisamir@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 4/7] iio: pressure: ms5611: Apply iwyu principles to includes
Date: Thu, 10 Jul 2025 18:11:04 +0100
Message-ID: <20250710171107.443790-5-jic23@kernel.org>
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

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/pressure/ms5611_core.c | 15 ++++++++++++---
 drivers/iio/pressure/ms5611_i2c.c  |  5 ++++-
 drivers/iio/pressure/ms5611_spi.c  |  9 +++++++--
 3 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/pressure/ms5611_core.c b/drivers/iio/pressure/ms5611_core.c
index bdac27bd5a5d..e5e12b500af8 100644
--- a/drivers/iio/pressure/ms5611_core.c
+++ b/drivers/iio/pressure/ms5611_core.c
@@ -9,12 +9,21 @@
  *  http://www.meas-spec.com/downloads/MS5607-02BA03.pdf
  *
  */
-
-#include <linux/module.h>
-#include <linux/iio/iio.h>
+#include <linux/array_size.h>
+#include <linux/bits.h>
 #include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/export.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/regulator/consumer.h>
+#include <linux/sysfs.h>
+#include <linux/stddef.h>
+#include <linux/types.h>
 
+#include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/buffer.h>
 #include <linux/iio/triggered_buffer.h>
diff --git a/drivers/iio/pressure/ms5611_i2c.c b/drivers/iio/pressure/ms5611_i2c.c
index 1c041b9085fb..2dd4ff38f595 100644
--- a/drivers/iio/pressure/ms5611_i2c.c
+++ b/drivers/iio/pressure/ms5611_i2c.c
@@ -12,12 +12,15 @@
  */
 
 #include <linux/delay.h>
+#include <linux/errno.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
-
+#include <linux/types.h>
 #include <linux/unaligned.h>
 
+#include <linux/iio/iio.h>
+
 #include "ms5611.h"
 
 static int ms5611_i2c_reset(struct ms5611_state *st)
diff --git a/drivers/iio/pressure/ms5611_spi.c b/drivers/iio/pressure/ms5611_spi.c
index 25c7bd2d8fdf..46e4188cbce2 100644
--- a/drivers/iio/pressure/ms5611_spi.c
+++ b/drivers/iio/pressure/ms5611_spi.c
@@ -7,12 +7,17 @@
  */
 
 #include <linux/delay.h>
+#include <linux/errno.h>
+#include <linux/minmax.h>
 #include <linux/module.h>
-#include <linux/spi/spi.h>
 #include <linux/mod_devicetable.h>
-
+#include <linux/spi/spi.h>
+#include <linux/stddef.h>
+#include <linux/types.h>
 #include <linux/unaligned.h>
 
+#include <linux/iio/iio.h>
+
 #include "ms5611.h"
 
 static int ms5611_spi_reset(struct ms5611_state *st)
-- 
2.50.0


