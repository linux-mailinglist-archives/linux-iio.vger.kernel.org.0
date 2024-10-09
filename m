Return-Path: <linux-iio+bounces-10382-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C1B997776
	for <lists+linux-iio@lfdr.de>; Wed,  9 Oct 2024 23:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC4551F23025
	for <lists+linux-iio@lfdr.de>; Wed,  9 Oct 2024 21:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FB81DF734;
	Wed,  9 Oct 2024 21:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="pkjP7rqp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4EF40849
	for <linux-iio@vger.kernel.org>; Wed,  9 Oct 2024 21:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728509186; cv=none; b=WEZAkH1z5JUMoyu5V6qhuzz/DiGaDNUNKI73c3KiXS++v6pmXrhI9t6J9T5Om2llZupA8V0Xr2T9CAqogTR0YFpJ+lt6MUM20a12pwKAlyVYnMG+076qHRWGKEoUT10ZIKzn0/j54uh+YcoaG1UapFLJOR8qeLrDZYt36uUyB0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728509186; c=relaxed/simple;
	bh=VpUot3Wk/hqPADAj63BdpEHXJlxUTjKifypWaSWAA+E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Ujib951W97WIKvpIwR4ELCnNtsjfJ+hBJ8PJqLRpMVNSMevsuTD197fZVwX2CphVVPjZwNcB6yx2CECprbDtctkUmNqZFcDzyaWFy1RrMm53Oyteynq1uRWUw9zyFvTxPGBMIl+pKxRP08YmoMChVmPuuJcjjw/xggnUu7QzdIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=pkjP7rqp; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5e5568f1b6eso132983eaf.1
        for <linux-iio@vger.kernel.org>; Wed, 09 Oct 2024 14:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728509183; x=1729113983; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CKLu7KQ+mELVme63gzTjH18/L5l4LMgl1DhfRI52KK4=;
        b=pkjP7rqpfi6gY0nYV/D40XBzolXQhPGxHsjSFN3EkbsKLfiNYHcMUiCvvpTnlVn4KE
         Q8qkG+6KpIf0rBBFKv+46lM5O3s0nwtrQ4/lBBwedjHKwNMDVPNCrIMR85dwh0XJUEGv
         35HLFtHHfyJYU3ppARyWFk/ooLibwzqnqIRX1qi9E2xCQZY1ZsxXa5Z+Oe0LdyG5P7cp
         +hSC8TMJ88S2dbgXrUsMeBDczES2t8zZuttgStBuzLEBfXk8wdqroaWxhMr9NChDa/4+
         TzulQjZzZ8QiesDWIYikXn8OchUIyOI2XQEYEmlzjuI1Stdb7YbTO7GGohSUzEXDVoDi
         VV1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728509183; x=1729113983;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CKLu7KQ+mELVme63gzTjH18/L5l4LMgl1DhfRI52KK4=;
        b=fi6pFhc03XMJvqDwDAEYGadR0eLS3/VQhYFZa4SX+aVgsCmTcL/qwBCrzOWLlFz71D
         yzSng/sLIMEyOXmwftKYBTP2MtKs+VLJHVSFsVBtXyFzL7Y6yJoC137WU57GrzCuY9FN
         4T88QKcUAtHNz9TqMk7/UPLltCUUeB8mEKrTlf9qTQ7u+Crz9XVCKEjBTXxXbPG2AM0C
         HmcUpd4zWnLrAZFlbn9iWwGiz2ObP2jzfeuCRgxkhMc6b5qnBPNz0tPn5mJLjCqPAeH1
         sjGCB7tBJoIvAAWbq0h+Wm8zngpAJHBN16mGEXrKsgNcP3DVmLo601Lmqu539MUxuDzH
         JxKw==
X-Forwarded-Encrypted: i=1; AJvYcCWInVwqhtCJLItHNAOJiJg1GqRL1EfUaEE0vINyJlt+kr2EEYQy2MG0dw18+2pP8i2aL3ijJiFPIW8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfJ+iickZtyHg5a0n/2//NMVGjjI5SokkLmQs4SJ/Kyudfd7uP
	/bnxDJ8iZiQetxh5sZcjbf5K/G5briWmuNaSCIQ706OIBwGoFUJDXjkuhFzGlc4=
X-Google-Smtp-Source: AGHT+IHMGMW0vdYe4sQWwrO/xco4iIv+k6FsLUVoGcEY54rAXRy6QG9OZ6Zw9yBcr1oLrjyyCOLhIw==
X-Received: by 2002:a05:6871:586:b0:277:eb15:5c60 with SMTP id 586e51a60fabf-2883425ad33mr3145988fac.10.1728509183473;
        Wed, 09 Oct 2024 14:26:23 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-287d706756fsm3696399fac.9.2024.10.09.14.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 14:26:22 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 09 Oct 2024 16:26:21 -0500
Subject: [PATCH] iio: adc: ad7944: add namespace to T_QUIET_NS
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241009-iio-adc-ad7944-add-namespace-to-t_quiet_ns-v1-1-a216357a065c@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAPz0BmcC/x2NQQrCMBBFr1Jm7UASQut4FZEyJKPOwqQmqQild
 2/o4vF5m/82qFJUKtyGDYr8tGpOXexlgPDm9BLU2B2ccd4aQ6iakWPoTOR9n4iJP1IXDoItY5u
 /q0qbU0UmiSON5CZ7hX64FHnq/4zdH/t+AJiUQIx8AAAA
To: Jonathan Cameron <jic23@kernel.org>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

Add AD7944_ namespace to T_QUIET_NS. This is the preferred style. This
way the bad style won't be copied when we add more T_ macros.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7944.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7944.c b/drivers/iio/adc/ad7944.c
index 0f36138a7144..a5aea4e9f1a7 100644
--- a/drivers/iio/adc/ad7944.c
+++ b/drivers/iio/adc/ad7944.c
@@ -80,7 +80,7 @@ struct ad7944_adc {
 };
 
 /* quite time before CNV rising edge */
-#define T_QUIET_NS	20
+#define AD7944_T_QUIET_NS	20
 
 static const struct ad7944_timing_spec ad7944_timing_spec = {
 	.conv_ns = 420,
@@ -150,7 +150,7 @@ static int ad7944_3wire_cs_mode_init_msg(struct device *dev, struct ad7944_adc *
 	 * CS is tied to CNV and we need a low to high transition to start the
 	 * conversion, so place CNV low for t_QUIET to prepare for this.
 	 */
-	xfers[0].delay.value = T_QUIET_NS;
+	xfers[0].delay.value = AD7944_T_QUIET_NS;
 	xfers[0].delay.unit = SPI_DELAY_UNIT_NSECS;
 
 	/*

---
base-commit: 96be67caa0f0420d4128cb67f07bbd7a6f49e03a
change-id: 20241009-iio-adc-ad7944-add-namespace-to-t_quiet_ns-a9ed69692718

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


