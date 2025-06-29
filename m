Return-Path: <linux-iio+bounces-21135-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2420AECF99
	for <lists+linux-iio@lfdr.de>; Sun, 29 Jun 2025 20:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D42A4188EB0C
	for <lists+linux-iio@lfdr.de>; Sun, 29 Jun 2025 18:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8259237A4F;
	Sun, 29 Jun 2025 18:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rVWw9E49"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EF320551C
	for <linux-iio@vger.kernel.org>; Sun, 29 Jun 2025 18:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751222218; cv=none; b=jRj+KYaIJqJUIZJhvwz69ygMxIDbswYlT2kYbEBVz7vlHFFToDasn1ISfgzqH35VCjP/Cc0HVsjExETQMZmhUtjk93a6c+me/91OKteWYKCkn+sjwsRPIzGqWAxfxbTdxsEMvX5rHu1JxgBvX+3PH92zT+3KUXt2m7vqs0kQMk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751222218; c=relaxed/simple;
	bh=hHKjTtAgwJtg7PPZyKGvLiHA3oNBFqifBEJcEHiRJvc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W+Jz5vSOYnfWQ5JXuV/M0QTQzTNQgRAqDzb3TgCT9fewGx86vXPjXyu8vPpX2V0m4vY8VVqjdTnsJQCWML162qD4fBOzvv0/EgDbgjx8K8So91sOOrPdcBBcDgnqC84d2vx0Th3sbtesZFpuGXLAaSk+hlengkoIws78YpGUtCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rVWw9E49; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA53FC4CEEB;
	Sun, 29 Jun 2025 18:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751222218;
	bh=hHKjTtAgwJtg7PPZyKGvLiHA3oNBFqifBEJcEHiRJvc=;
	h=From:To:Cc:Subject:Date:From;
	b=rVWw9E49L+utU+f33edBfRo4x1g6pySnIq2WA0BlSdgGxa+LwD9Ulum1yvzrvJz1m
	 dvLNolr46JOxGAXDmLFIns+0g9af79YfBAk6dRbqhgWvtU3B10EnVZVDYJQZvO6miH
	 /1QqlS7r45nIhDBzCrh2KIwyeizko59gnagccQ8LC7mP64G4pHE3FzhUEMrsJOHYyW
	 SoSkvObB0r5+ZXBwqPJIc4sV0M7V9dCp/rCgKQysRzOaY1vae+uh6FmtsQ7t3BVsp+
	 tDMrGBeoBJqkFLu+puyUlCZMTqIDWJOoshzlYx0RqhY4Nfvq71eziAenIya27rjXmH
	 bQ3QepBKRLrxw==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH] iio: accel: kionix-kx022a: Apply approximate iwyu principles to includes
Date: Sun, 29 Jun 2025 19:36:49 +0100
Message-ID: <20250629183649.184479-1-jic23@kernel.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Motivated by the W=1 warning about export.h that was introduced this cycle
this is an attempt to apply an approximation of the principles of including
whatever is used in the file directly.

Helped by the include-what-you-use tool.

Reasoning:
- Drop linux/moduleparam.h as completely unused.
- linux/array_size.h for ARRAY_SIZE()
- linux/bitmap.h for for_each_set_bit
- linux/errno.h for error codes.
- linux/export.h for EXPORT_SYMBOL*()
- linux/math64.h for do_div - alternative would be asm/div64.h
- linux/minmax.h for min()
- linux/sysfs.h for sysfs_emit()
- linux/time64.h for USEC_PER_MSEC
- linux/iio/buffer.h for iio_push_to_buffers_with_timestamp()
- asm/byteorder.h for le16_to_cpu()

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---

I picked this one fairly randomly as an example but longer term I'd like
to look through at least all new drivers with this in mind + all the ones
that are currently messing up my W=1 build logs.

Note I've been very descriptive in this patch to allow people to suggest
better alternatives for some of the ones that aren't entirely obvious.

---
 drivers/iio/accel/kionix-kx022a.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-kx022a.c
index 07dcf5f0599f..39485572a76b 100644
--- a/drivers/iio/accel/kionix-kx022a.c
+++ b/drivers/iio/accel/kionix-kx022a.c
@@ -5,27 +5,37 @@
  * ROHM/KIONIX accelerometer driver
  */
 
+#include <linux/array_size.h>
+#include <linux/bitmap.h>
 #include <linux/cleanup.h>
 #include <linux/delay.h>
 #include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/export.h>
 #include <linux/interrupt.h>
+#include <linux/math64.h>
+#include <linux/minmax.h>
 #include <linux/module.h>
-#include <linux/moduleparam.h>
 #include <linux/mutex.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 #include <linux/string_choices.h>
+#include <linux/sysfs.h>
+#include <linux/time64.h>
 #include <linux/types.h>
 #include <linux/units.h>
 
 #include <linux/iio/iio.h>
+#include <linux/iio/buffer.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/trigger.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
 
+#include <asm/byteorder.h>
+
 #include "kionix-kx022a.h"
 
 /*
-- 
2.50.0


