Return-Path: <linux-iio+bounces-19023-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C4A8AA820B
	for <lists+linux-iio@lfdr.de>; Sat,  3 May 2025 21:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5E131B6012D
	for <lists+linux-iio@lfdr.de>; Sat,  3 May 2025 19:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D0B19D88F;
	Sat,  3 May 2025 19:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qtl2iF5O"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4902D13C8F3;
	Sat,  3 May 2025 19:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746298852; cv=none; b=n+/54rNvLMTZe5EqEDECsV+Af/LDUsrpLS8RxHafugFmpaNRs+1Cz0EyHBRFHf3hdVB4ezY3Vl4qEsqJIBf42AaK3/P5IilEIBA+ODubiM0OTD/2Zi6z4HeJP61OMrOY69u+hPzt/A4WlV7L49kmOIUsn7Ho+zR5MTf41cxqfrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746298852; c=relaxed/simple;
	bh=B8uLdGHpE3+9z5z5/9yyDUZbgxzBbVombqXtGfHrFw4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hQ5AzvYiy9fB3yhFMT52ng+q4J+4bq2d9pCISJubmnLWtth0OeZC9aKuMlXNlXamfz3aE0mvkDngmfoOnhD8OUJqQiyKAcrwQP6HnZZsIhP7yVco+DL2iw5/WPIdwPBxCr4tN5H0MGJgljH+tFWxc9sBURdBYpDywBHfkYaTCyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qtl2iF5O; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-73bf5aa95e7so3001119b3a.1;
        Sat, 03 May 2025 12:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746298850; x=1746903650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ihQIh2FOFA6wpr1oK/9ID92kTN0gqjt1G0k00n0HP4o=;
        b=Qtl2iF5O0G23ufUkB2fqEt1jDRRZwYa6sQTVIjgFSH1Z/pE8iYHrbGFhD0I2GCoq2x
         UGL7GoYi/iDg4F4PAE8q1IH/oq/f8oZlxrmkDSCxRR42eac5B6Rgvx6BycWrQIzNICyl
         2rI7qoDI/H/1NRMeJT5sHYcqo6OCJlw4sGi2sqACSKIZc/r/1ryYxNUdM6vb8QA1aty2
         Llzqi7EPcy+ZOks1neCs0JJv1s+9LpSa+achcX2haWnGA+wDO0eY0+9MmPQKhbqvq6bC
         w1lUT3lc5QwhkGrrEIYOlha2nsOJ3Dwz3VhFyUYkQODnUyP/ckVFJHj1e2WzyZIEPPFD
         p1lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746298850; x=1746903650;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ihQIh2FOFA6wpr1oK/9ID92kTN0gqjt1G0k00n0HP4o=;
        b=Y5eBiv28VbwDXs8V82R2MQ+++J+RX5j6Z06cEcifNMkIWE4GdWE2cuULZfnrTmuPUl
         /6YeZWGH8+iQHqMepqfXUeseCvZm83ZyhK0yr9vs912z2+edFoXJ+fhIbfDUw4DJ0Tp6
         dXkzqjmedFzBj4N2CcscrbP8iBRIsYlSnVpjXMy+/Em1cqA330yPpDvrkwdFmBtbGTFc
         AjRrfcdW8O1SqSPz2AZxdvbixNnsbLb5pKwhQYaN+OellCosJ09GnSFsOCm2pfihzMiG
         jd5Lv0JbXWvegc22ZXWSyVljBAXHiqv4UbnHw8ZiJ38FTzn5kHyInJXqEVcoPRERigOp
         2uLA==
X-Forwarded-Encrypted: i=1; AJvYcCU5bHUbRT8W5Syero1eBt9CpXPlyYAzFOHflB4PBcfNbIUre8ZRkz5O+7G1A938OrPw+CbJ88Y0e4bbr98W@vger.kernel.org, AJvYcCVEIW68Z1aqu+P9otxr2Sv08neSiMQ6lx7luI6FDn4z2K6ooK8vwulJGyeC2RKCbo7FC0QlhGb6goM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNDC8cWKK6A+jAvYN1EoaPKnplVBXtRL1z1smJhdeRguECzBc0
	VyI+MqScKn++f3dmouq5IRFpFtE+vHZpT6Nyx++Blzygg3Hpb+Ti
X-Gm-Gg: ASbGnct5wjAloP64XJ7OaWfMBH6ZoSzFE9055EM9H0vexdPof2hvCrPFv7hoAynmNly
	YbpWycXdcAfEXEug8j6iQIFRAN4EsLfpwEGRWTOhka4dTCmZJ3HY7DCPr0ycHyeUYpWGNaYKuc4
	GfrEU6OlZnjIyDtTvptTDsu+l6i9ryTSrqXwkPoGVkraHxSpgduqMg785Tzbx6dNp2EdnaYcu2U
	yWILijVrKOHQJHjaAsDZ+hXjli+Zb+KF+DNtMEIyq4CgTiq3RU8iKjbk3uKxUXHTDqYhokc5WBT
	0+gFHTKDBZQ5iI+rcEcw4+7M9R2sRSfWJDtFcHZSsKjY2R8=
X-Google-Smtp-Source: AGHT+IHLl5UGhBOTTa4k/EWd6EfVXCLfvwEd2zmqb8Z6UVBwSwe9MoBcn0LXDlOwuz2T0MNBqkGuHw==
X-Received: by 2002:a05:6a00:ab0d:b0:739:56c2:b661 with SMTP id d2e1a72fcca58-7406f0df3e7mr2959877b3a.12.1746298850347;
        Sat, 03 May 2025 12:00:50 -0700 (PDT)
Received: from gye-ThinkPad-T590.. ([39.120.225.141])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74059020955sm3786249b3a.101.2025.05.03.12.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 May 2025 12:00:50 -0700 (PDT)
From: Gyeyoung Baek <gye976@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Gyeyoung Baek <gye976@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: trigger: Add validation to reject devices requiring top half
Date: Sun,  4 May 2025 04:00:43 +0900
Message-ID: <20250503190044.32511-1-gye976@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some device drivers implement top-half handler,
which is not compatible with threaded handler trigger.
This patch adds a validation function to reject such devices,
allowing only iio_pollfunc_store_time().

Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
---
 drivers/iio/trigger/iio-trig-loop.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/trigger/iio-trig-loop.c b/drivers/iio/trigger/iio-trig-loop.c
index 7aaed0611899..a37615567a6c 100644
--- a/drivers/iio/trigger/iio-trig-loop.c
+++ b/drivers/iio/trigger/iio-trig-loop.c
@@ -7,18 +7,12 @@
  *
  * Note this is still rather experimental and may eat babies.
  *
- * Todo
- * * Protect against connection of devices that 'need' the top half
- *   handler.
- * * Work out how to run top half handlers in this context if it is
- *   safe to do so (timestamp grabbing for example)
- *
  * Tested against a max1363. Used about 33% cpu for the thread and 20%
  * for generic_buffer piping to /dev/null. Watermark set at 64 on a 128
  * element kfifo buffer.
  */
 
-#include <linux/kernel.h>
+#include <linux/errno.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
@@ -27,8 +21,10 @@
 #include <linux/freezer.h>
 
 #include <linux/iio/iio.h>
-#include <linux/iio/trigger.h>
 #include <linux/iio/sw_trigger.h>
+#include <linux/iio/trigger.h>
+
+#include "linux/iio/trigger_consumer.h"
 
 struct iio_loop_info {
 	struct iio_sw_trigger swt;
@@ -71,8 +67,25 @@ static int iio_loop_trigger_set_state(struct iio_trigger *trig, bool state)
 	return 0;
 }
 
+/*
+ * Protect against connection of devices that 'need' the top half
+ * handler.
+ */
+static int iio_loop_trigger_validate_device(struct iio_trigger *trig,
+						struct iio_dev *indio_dev)
+{
+	struct iio_poll_func *pf = indio_dev->pollfunc;
+
+	/* Only iio timestamp grabbing is allowed. */
+	if (pf->h && pf->h != iio_pollfunc_store_time)
+		return -EINVAL;
+
+	return 0;
+}
+
 static const struct iio_trigger_ops iio_loop_trigger_ops = {
 	.set_trigger_state = iio_loop_trigger_set_state,
+	.validate_device = iio_loop_trigger_validate_device,
 };
 
 static struct iio_sw_trigger *iio_trig_loop_probe(const char *name)
-- 
2.43.0


