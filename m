Return-Path: <linux-iio+bounces-1549-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C836282A159
	for <lists+linux-iio@lfdr.de>; Wed, 10 Jan 2024 20:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 714012874D7
	for <lists+linux-iio@lfdr.de>; Wed, 10 Jan 2024 19:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F246D4F887;
	Wed, 10 Jan 2024 19:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Y3XOe08z"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63E24EB23
	for <linux-iio@vger.kernel.org>; Wed, 10 Jan 2024 19:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-598a0063134so424866eaf.0
        for <linux-iio@vger.kernel.org>; Wed, 10 Jan 2024 11:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1704916275; x=1705521075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UVV1rLtkyln7lfj7tpHcJX2VNB5e7ezkKOUrM/UkYLc=;
        b=Y3XOe08zJIN6pC3VWbJnk6shnya36LvTiwlT1mpPDBn7HF6W7lf55XtJoLyT01z4Ni
         kLDrI640BFKYOJV+twIgmxSRyCcIlvgFHw3W3UXoSvqpVwqCdKSP0SodzMi2Nvvr1zk+
         UZJWRTofD9NbokV1MbC5UAnqAKovP7bc5l8DlzzMdk/vyEoBCwylfHHCh4vUnt8c8CeY
         3NDrgUiZf6ry3YQaYkeQRQ8KDaW6gnD1blzmY8a6btcB2xN0pez+Ab+s/g29MFhVAVmx
         koGztaKC54dA6BdPzUJdMwSL1ONMegSuZ13H4StO3j800zWjP90Lc0AWtwnxZHUJ/zme
         CJcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704916275; x=1705521075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UVV1rLtkyln7lfj7tpHcJX2VNB5e7ezkKOUrM/UkYLc=;
        b=BaSOnBMa3R7NiuYv+RrapZNBrKR7fqqo0LDGgQztYrp5v71Xy/hXjIHFqVBiziB/J0
         OabnuUZGCiCxXChZ9eNfHP3ItaXeL6EqC/9DUOMiwUjsUv9CL89IFdh8y5BX2MU/cOuN
         quTY55oJBGwQtTa9uOOjwWiF9hTRBzfYZyZcY5fjx+/3sHyTLSujhrauvq+A4A+llQcW
         g7rNUTMNcEriqoYP3BnvnT7tE00wSytJo67g3BENlTpFovInbDQNuZXS0iZzW6H5n6UJ
         IHxexuJKyZYBL5lhy7CzLawbI1uDu4PAnf5C6wO+AfpzsDXStY3028HlbC1fTM5d6bbr
         oqTw==
X-Gm-Message-State: AOJu0YycLeNq/YkBA25sSH+4j2uxjbKCI+hUhiDLaW5l1/dtEZ5JekzU
	cdt6WPHnC4DiDrS65YSK7JQnMmw9Y4zCYg==
X-Google-Smtp-Source: AGHT+IGunDU9MSgs9fgHQVRozSUhKU17YNl+rYChXl6jqrO/GSOVN5G2k4xbC6HDR6Xk6s49R7pFjg==
X-Received: by 2002:a05:6820:1c89:b0:594:6b95:4218 with SMTP id ct9-20020a0568201c8900b005946b954218mr145662oob.1.1704916274825;
        Wed, 10 Jan 2024 11:51:14 -0800 (PST)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 187-20020a4a0dc4000000b00595b35927a3sm938513oob.39.2024.01.10.11.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 11:51:14 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
To: Mark Brown <broonie@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Frank Rowand <frowand.list@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	=?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-spi@vger.kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 06/13] iio: buffer: add hardware triggered buffer support
Date: Wed, 10 Jan 2024 13:49:47 -0600
Message-ID: <20240109-axi-spi-engine-series-3-v1-6-e42c6a986580@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240109-axi-spi-engine-series-3-v1-0-e42c6a986580@baylibre.com>
References: <20240109-axi-spi-engine-series-3-v1-0-e42c6a986580@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

This adds a new mode INDIO_HW_BUFFER_TRIGGERED to the IIO subsystem.

This mode is essentially the hardware version of INDIO_BUFFER_TRIGGERED
where the trigger has the semantics of INDIO_HARDWARE_TRIGGERED and the
buffer has the semantics of INDIO_BUFFER_HARDWARE.

So basically INDIO_HW_BUFFER_TRIGGERED is the same as
INDIO_BUFFER_HARDWARE except that it also enables the trigger when the
buffer is enabled.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/industrialio-buffer.c | 43 ++++++++++++++++++++++++++++++++++++---
 include/linux/iio/iio.h           | 16 ++++++++++++---
 2 files changed, 53 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 176d31d9f9d8..ffee3043c65a 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -27,6 +27,7 @@
 #include <linux/iio/sysfs.h>
 #include <linux/iio/buffer.h>
 #include <linux/iio/buffer_impl.h>
+#include <linux/iio/trigger.h>
 
 static const char * const iio_endian_prefix[] = {
 	[IIO_BE] = "be",
@@ -867,8 +868,17 @@ static int iio_verify_update(struct iio_dev *indio_dev,
 					insert_buffer->watermark);
 	}
 
-	/* Definitely possible for devices to support both of these. */
-	if ((modes & INDIO_BUFFER_TRIGGERED) && indio_dev->trig) {
+	/* Definitely possible for devices to support all of these. */
+	if (modes & INDIO_HW_BUFFER_TRIGGERED) {
+		/*
+		 * Keep things simple for now and only allow a single buffer to
+		 * be connected in hardware mode.
+		 */
+		if (insert_buffer && !list_empty(&iio_dev_opaque->buffer_list))
+			return -EINVAL;
+		config->mode = INDIO_HW_BUFFER_TRIGGERED;
+		strict_scanmask = true;
+	} else if ((modes & INDIO_BUFFER_TRIGGERED) && indio_dev->trig) {
 		config->mode = INDIO_BUFFER_TRIGGERED;
 	} else if (modes & INDIO_BUFFER_HARDWARE) {
 		/*
@@ -1107,11 +1117,21 @@ static int iio_enable_buffers(struct iio_dev *indio_dev,
 		}
 	}
 
+	if (iio_dev_opaque->currentmode == INDIO_HW_BUFFER_TRIGGERED) {
+		struct iio_trigger *trig = indio_dev->trig;
+
+		if (trig->ops && trig->ops->set_trigger_state) {
+			ret = trig->ops->set_trigger_state(trig, true);
+			if (ret)
+				goto err_disable_buffers;
+		}
+	}
+
 	if (iio_dev_opaque->currentmode == INDIO_BUFFER_TRIGGERED) {
 		ret = iio_trigger_attach_poll_func(indio_dev->trig,
 						   indio_dev->pollfunc);
 		if (ret)
-			goto err_disable_buffers;
+			goto err_disable_hw_trigger;
 	}
 
 	if (indio_dev->setup_ops->postenable) {
@@ -1130,6 +1150,16 @@ static int iio_enable_buffers(struct iio_dev *indio_dev,
 		iio_trigger_detach_poll_func(indio_dev->trig,
 					     indio_dev->pollfunc);
 	}
+err_disable_hw_trigger:
+	if (iio_dev_opaque->currentmode == INDIO_HW_BUFFER_TRIGGERED) {
+		struct iio_trigger *trig = indio_dev->trig;
+
+		if (trig->ops && trig->ops->set_trigger_state) {
+			ret = trig->ops->set_trigger_state(trig, false);
+			if (ret)
+				return ret;
+		}
+	}
 err_disable_buffers:
 	buffer = list_prepare_entry(tmp, &iio_dev_opaque->buffer_list, buffer_list);
 	list_for_each_entry_continue_reverse(buffer, &iio_dev_opaque->buffer_list,
@@ -1174,6 +1204,13 @@ static int iio_disable_buffers(struct iio_dev *indio_dev)
 					     indio_dev->pollfunc);
 	}
 
+	if (iio_dev_opaque->currentmode == INDIO_HW_BUFFER_TRIGGERED) {
+		struct iio_trigger *trig = indio_dev->trig;
+
+		if (trig->ops && trig->ops->set_trigger_state)
+			trig->ops->set_trigger_state(trig, false);
+	}
+
 	list_for_each_entry(buffer, &iio_dev_opaque->buffer_list, buffer_list) {
 		ret2 = iio_buffer_disable(buffer, indio_dev);
 		if (ret2 && !ret)
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index d0ce3b71106a..16f62bd38041 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -366,6 +366,11 @@ s64 iio_get_time_ns(const struct iio_dev *indio_dev);
  * they must be managed by the core, but without the entire interrupts/poll
  * functions burden. Interrupts are irrelevant as the data flow is hardware
  * mediated and distributed.
+ * @INDIO_HW_BUFFER_TRIGGERED: Very unusual mode.
+ * This is similar to INDIO_BUFFER_TRIGGERED but everything is done in hardware
+ * therefore there are no poll functions attached. It also implies the semantics
+ * of both INDIO_HARDWARE_TRIGGERED for the trigger and INDIO_BUFFER_HARDWARE
+ * for the buffer.
  */
 #define INDIO_DIRECT_MODE		0x01
 #define INDIO_BUFFER_TRIGGERED		0x02
@@ -373,14 +378,19 @@ s64 iio_get_time_ns(const struct iio_dev *indio_dev);
 #define INDIO_BUFFER_HARDWARE		0x08
 #define INDIO_EVENT_TRIGGERED		0x10
 #define INDIO_HARDWARE_TRIGGERED	0x20
+#define INDIO_HW_BUFFER_TRIGGERED	0x40
 
-#define INDIO_ALL_BUFFER_MODES					\
-	(INDIO_BUFFER_TRIGGERED | INDIO_BUFFER_HARDWARE | INDIO_BUFFER_SOFTWARE)
+#define INDIO_ALL_BUFFER_MODES		\
+	(INDIO_BUFFER_TRIGGERED		\
+	 | INDIO_BUFFER_HARDWARE	\
+	 | INDIO_BUFFER_SOFTWARE	\
+	 | INDIO_HW_BUFFER_TRIGGERED)
 
 #define INDIO_ALL_TRIGGERED_MODES	\
 	(INDIO_BUFFER_TRIGGERED		\
 	 | INDIO_EVENT_TRIGGERED	\
-	 | INDIO_HARDWARE_TRIGGERED)
+	 | INDIO_HARDWARE_TRIGGERED	\
+	 | INDIO_HW_BUFFER_TRIGGERED)
 
 #define INDIO_MAX_RAW_ELEMENTS		4
 

-- 
2.43.0


