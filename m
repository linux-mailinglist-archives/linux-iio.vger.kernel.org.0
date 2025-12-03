Return-Path: <linux-iio+bounces-26708-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F29ACCA1585
	for <lists+linux-iio@lfdr.de>; Wed, 03 Dec 2025 20:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D363130249B1
	for <lists+linux-iio@lfdr.de>; Wed,  3 Dec 2025 19:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C44334C11;
	Wed,  3 Dec 2025 19:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bthYmq7F"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADE63321D3
	for <linux-iio@vger.kernel.org>; Wed,  3 Dec 2025 19:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764789587; cv=none; b=HzN1ZooJIsCK4+Q91sGZ+D4ZrQykDoPAbkfcy/2VDoEiIw/aZA0YGq2LDSzipMuPHmPCSTsvLSEduVs57QfTlbFUYf9BgRtOp+2HUFTR5m/pUxfcminXRU54A37N59M1oFkuSRElSgerekc/lqSjVwuX1a/KzceYpP1Vylcus7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764789587; c=relaxed/simple;
	bh=thwTqOzNRZkyszvhlMWjaq5EQB1WFkW17ri6c2K6Wec=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZdPq1ZnGzZpFgJTaj13uF0L8+UHlUuZML27ZLfC2BlKhSwc0xTEzrkQ+BQQrImBHypiPBwvTiblKrf7CdjpKyhhpstGHg7p/Mq9mY0GrsjFqbNcIqATDT8qjonSvS6CzjJDwj3kjVSZshvWk16WEQCdmKqh3JSSvZeUlLBvQ7LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bthYmq7F; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-55b26461e78so33346e0c.3
        for <linux-iio@vger.kernel.org>; Wed, 03 Dec 2025 11:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764789583; x=1765394383; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t+56Cx3PPU0pMNBTK6bCqPThZjyXJm4dzoboS+vzlFA=;
        b=bthYmq7FVhnHVG4ik6RImhcJ5C6furMYBw7Li1gaQiIAIlwveVXk2F7WTlAzyMzF+z
         KQ7noQsNJKNpCaCi7eBgbVTp+pLY/teQfmoQGnGqljHvN/Z1P1E7/8omiHlscee8bqZn
         PYvySBDo/AEbqsfz/gMB3znGWVFcSIWmUP1wYNJGPyFvInB2org1S1umw525qCjS4sqM
         kRpPFZBrFaqsE5yDcCiEdPoxbE9KVf+TYpAMnj4XVvY4K86h3UGvS0I0w2QXw/Q1SWMO
         Nouoqa0344Lrf/dsLxz5Q2e9vK4lSiCZCpYcjamAv0NYGqUpHWFor3nSDlkQVvGuu07c
         o86Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764789583; x=1765394383;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t+56Cx3PPU0pMNBTK6bCqPThZjyXJm4dzoboS+vzlFA=;
        b=IT0WvWMiO8auFHBAmEbjS+pI82Ob5JeR9NlOKh6KGHSp0S61OVWD0e0D0VjeXFSCQN
         2vQK7+7y15CNhCp2al5eeHMGOz2LkhPDNpaW7M34mJ9rgaY3X6q0S27wRN1Px9N/1ddl
         fS1AHnpZC5+2/nWlwCyjnsUR6eiosPRXfRwxWbyYeLlzsD0G+qSRLUmKfnbXI1RhnOC3
         xWjBoXlnydBsRu6rcbhsxwvHZgRNibo2vWASGSERDchMtFXcoMXp5sVs7RLSrhh1sc3V
         KFIXiaf2Nts7x4gvJl6CL19Nu4EW4VIjcMF+KXodGHsJPlX566mYqwGPZnLZQPYJTLsn
         oIMA==
X-Forwarded-Encrypted: i=1; AJvYcCVlrYvx6aA1fBGKBmBRNaYmKVlKT3zffUjI+beODjQ6VuWreOgg6BXmDRLjWKgTx1gtehTpcSn4E4w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI12A6K9iXkiit8WR6pOhujjG13LGgTUWypsjFh3+UHZa/iXyG
	AgRQL37YgVDie84sRTIBC7sep9/mhMuHmIpRsiW1Se7YZ2G23gg26YGq
X-Gm-Gg: ASbGncvgFL5+SvFBs4MwpLQ1oGMGZN/O0LS4svSIzh8wDsnTLoJN9OHoy+qXhWRxv1F
	NojBcbIkYxkshJU2jrSwT8p7OeQyDeDAc+qhWbV0rxcCBXdSJ1LbPIQHBhDHIhaZZsOM4YMmtIc
	2xi1A6BOzEFsHtGIr1s1ZNa4s56EYidbCphGfyRtty9ZT+Elf/2wfNHBNFJU5jwFkGbOq8jTkW1
	SjyEuG98apNZMHWnZ6S1gRKE6S7SvBbrTDIRqSO1DHCyrh5Q/w6IETmzuC+tqdwgQM+yHvUyI6q
	IDwAG87s6z9dBho/lUlSf0kVWgbvmeOoeDCohnXqeP4wRKaydtEKWL0u0T+0RGalRc4iA/8AYyf
	WHy9YpZNfj9eyM1YFX1aRmIgzROzs71P/Aecoyga2UPWTOzXSwRc2f15Zjs/Jvm36eX9vOgBPg7
	B3g5JI/UEyGX1N
X-Google-Smtp-Source: AGHT+IF9pu1NwTmjdGn8DFeer46ehoguwJV+JygngR29KNUZyGSjHLZ4RhNSUqDCM7LAEFNIdyXKyA==
X-Received: by 2002:a05:6122:2a53:b0:55b:9c1c:85f2 with SMTP id 71dfb90a1353d-55e5beb9cf8mr1482400e0c.1.1764789582987;
        Wed, 03 Dec 2025 11:19:42 -0800 (PST)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:875c:6c76:e06b:3095])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55cf4e1d56asm8121346e0c.4.2025.12.03.11.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 11:19:42 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
Date: Wed, 03 Dec 2025 14:18:17 -0500
Subject: [PATCH RFC 3/6] iio: core: Add cleanup.h support for
 iio_device_claim_*()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251203-lock-impr-v1-3-b4a1fd639423@gmail.com>
References: <20251203-lock-impr-v1-0-b4a1fd639423@gmail.com>
In-Reply-To: <20251203-lock-impr-v1-0-b4a1fd639423@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Benson Leung <bleung@chromium.org>, 
 Antoniu Miclaus <antoniu.miclaus@analog.com>, 
 Gwendal Grignou <gwendal@chromium.org>, 
 Shrikant Raskar <raskar.shree97@gmail.com>, 
 Per-Daniel Olsson <perdaniel.olsson@axis.com>
Cc: David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Guenter Roeck <groeck@chromium.org>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev, 
 Kurt Borja <kuurtb@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3155; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=thwTqOzNRZkyszvhlMWjaq5EQB1WFkW17ri6c2K6Wec=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDJkGva4eG14sOFYksZvzvrHpBSYR7dYvj1f3lu2YMu9Fi
 /eyLGbbjlIWBjEuBlkxRZb2hEXfHkXlvfU7EHofZg4rE8gQBi5OAZjIgg6Gv/L3I60Fp6u0OM5J
 cxFWOHy/M+zN4uao9uhu/2YbjWctvQx/pXSPXko79vm9287F99e1PBbnfhT/oldqc/aSI7J7JK7
 s5AIA
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Add guard() and ACQUIRE() support for iio_device_claim_*() lock.

This involves exporting iio_device_{claim, release}() wrappers to define
a general GUARD class, and then defining the _direct and _buffer
conditional ones.

Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/iio/industrialio-core.c | 12 ++++++++++++
 include/linux/iio/iio.h         | 20 ++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index adf0142d0300..da090c993fe8 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -2171,6 +2171,18 @@ int __devm_iio_device_register(struct device *dev, struct iio_dev *indio_dev,
 }
 EXPORT_SYMBOL_GPL(__devm_iio_device_register);
 
+void __iio_device_claim(struct iio_dev *indio_dev)
+{
+	mutex_lock(&to_iio_dev_opaque(indio_dev)->mlock);
+}
+EXPORT_SYMBOL_GPL(__iio_device_claim);
+
+void __iio_device_release(struct iio_dev *indio_dev)
+{
+	mutex_unlock(&to_iio_dev_opaque(indio_dev)->mlock);
+}
+EXPORT_SYMBOL_GPL(__iio_device_release);
+
 /**
  * __iio_device_claim_direct - Keep device in direct mode
  * @indio_dev:	the iio_dev associated with the device
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 27da9af67c47..472b13ec28d3 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -10,6 +10,7 @@
 #include <linux/align.h>
 #include <linux/device.h>
 #include <linux/cdev.h>
+#include <linux/cleanup.h>
 #include <linux/compiler_types.h>
 #include <linux/minmax.h>
 #include <linux/slab.h>
@@ -661,9 +662,23 @@ void iio_device_unregister(struct iio_dev *indio_dev);
 int __devm_iio_device_register(struct device *dev, struct iio_dev *indio_dev,
 			       struct module *this_mod);
 int iio_push_event(struct iio_dev *indio_dev, u64 ev_code, s64 timestamp);
+void __iio_device_claim(struct iio_dev *indio_dev);
+void __iio_device_release(struct iio_dev *indio_dev);
 bool __iio_device_claim_direct(struct iio_dev *indio_dev);
 void __iio_device_release_direct(struct iio_dev *indio_dev);
 
+static inline void iio_device_claim(struct iio_dev *indio_dev)
+	__acquires(indio_dev)
+{
+	__iio_device_claim(indio_dev);
+}
+
+static inline void iio_device_release(struct iio_dev *indio_dev)
+	__releases(indio_dev)
+{
+	__iio_device_release(indio_dev);
+}
+
 /*
  * Helper functions that allow claim and release of direct mode
  * in a fashion that doesn't generate many false positives from sparse.
@@ -690,6 +705,11 @@ static inline void iio_device_release_direct(struct iio_dev *indio_dev)
 bool iio_device_claim_buffer(struct iio_dev *indio_dev);
 void iio_device_release_buffer(struct iio_dev *indio_dev);
 
+DEFINE_GUARD(iio_device_claim, struct iio_dev *, iio_device_claim(_T),
+	     iio_device_release(_T));
+DEFINE_GUARD_COND(iio_device_claim, _buffer, iio_device_claim_buffer(_T));
+DEFINE_GUARD_COND(iio_device_claim, _direct, iio_device_claim_direct(_T));
+
 extern const struct bus_type iio_bus_type;
 
 /**

-- 
2.52.0


