Return-Path: <linux-iio+bounces-19680-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05BB5ABC09A
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 16:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D2DC1889992
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 14:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34769284674;
	Mon, 19 May 2025 14:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="APJ6vmA/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986CA283FF5;
	Mon, 19 May 2025 14:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747664778; cv=none; b=eolr2cHQvBiyBGXRoEukir7t/hxrcBcgiAUKsU0LnnHgYKtPYf43hWeAbxDByydIgMzXRV3/SQXRz31tT9Fx1UnSkgoiY7HSkr/kKRG+PUH/J7yP0pl3mVXXvAV/yUuNM8y+JvRIwYRMi1LEdhCRltU4LDmapI7WyosTe1vbo8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747664778; c=relaxed/simple;
	bh=JuLC/Wx7Wg0nAvBCmYwGh7LiLm0cZfVz+AluP+xYrao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DHaTlmhktxXBevk6PS6c/gdFl5E3w853A5Y0I747IsONQ+FA2Y2ymNvKaidK7myPc7iuEzt5Ff1mIRqZ3Hh8KUySLG6wSG9c/ODFOoMyLxbutO6zeMK2CEQuZWrEVQRV8qVacZyOwaQFx8yipz575YnIQiKK4puW88lqzo7OWy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=APJ6vmA/; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-73c17c770a7so4801467b3a.2;
        Mon, 19 May 2025 07:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747664776; x=1748269576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2SDkPzy9RH9RATTYbdRqCXVmsGpXFpSAHI7QpsFMICQ=;
        b=APJ6vmA/faFZZQKW8ui42ZPkb5sFOSPTdqgtTHlHaS6UQ+V7BopVRAjrnIvZQGm/kx
         vsFzQjPJhBM6cFqRR2Mo8H/LFrBnIZMOb/7FYZRljyyGC/4klS5Kg4CR0IDjB9yAGZQl
         z78EtgNixTFNGFVXsFAWiIWdQ7s4lRiW48ohQqu69uh2Bfk6UVu5+V7yt0YmuKHYWspP
         P78+1+LjeO+62qcb3i8NH/zbgDRmi9WhFlIVlcXg/RZwF2eMmQjwbztysY9htaChzYoS
         0aupOvkhMxM6i77x4RhgxVDCXzyoBPp8CYvXXssETpH80jMEoWkiErcxLeV72Rkuj/St
         JUQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747664776; x=1748269576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2SDkPzy9RH9RATTYbdRqCXVmsGpXFpSAHI7QpsFMICQ=;
        b=mZUDBKp753v6nqhrnP6sVSkuOdT18VGAKf6v4bi1JA4McNovyc6+K7MmyiVwXeOKUj
         OQu7mKnG1kQXxmlWvZX0oFRiZMPhgeFeKlkY0zvSDjrQTRGYhh5T2COipCPcTz4U4vCE
         rNSsp4LRoOrcUvR2bDL4zajLGdhSQToLnszTQTDTQfaphCTNx0v2fhv0LC6AHcxJvrhl
         Xzkng2kfUg6KkdI/q2OI2NIhAEqmgqqiH6VVaAS9V/RE/l7hCqN3UhxAdDO/Pj3Bc3xM
         c3K+AWa27Jxrx0U9HUZIhaZEwVPGFPlbEL4zKL3YxpmsKvyC6/HnidYd3H/Zgq0NEfUm
         IdZg==
X-Forwarded-Encrypted: i=1; AJvYcCUgF0U25djwhfEKKrAioPmBZYxUUjsOzEfnAU2lN7mKbiFfxIvjCY/anW/VSFz5K7+s4KQImiI+pSX7TKJP@vger.kernel.org, AJvYcCWb9wezDOWvcj0k0N6TWz72KjmSyCrWLwassxKhCh05oTDUOpXaLhQnfYGBs8Ilfm+mExykfQnofmk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+ruYweRuGyxX+cRjoA7ejbbjpkAaD1/5zzWNV9IhYfTtJzPZm
	StAwcviTXsbq/rfLgM9YskDY1L7vjXC+MiPci1Prm3Ta5giowBQnow37
X-Gm-Gg: ASbGncu4it0YrZPT/+xNI9Ola8QXxLFXloO4uyJE72Dvs8dYw/9uyIxWaYMCS5dlL/l
	9+oJ5seq0Fxw+WCGXYhbr9kxXOQRZA84EhcPTbgUlgDubQOa2WP8q5A3Rx+qvwFF1oA4H3beJ7J
	0HYEUXKeM7AoEZmY6PJPcdLw2+gwRi+uP4LXvBnLfT+cXhUwoaVXONDy0ONzi9JWsfLXdsldTe3
	PGvKw4eOymWaIW28Bt0rNRhp1FWzpHi4B9Hk+pAVtJjtOoZMaoXBj33X2Yf+7REyfIRXAzoXJ51
	cRrUJAsOvcw2Y0tBwZt/3FHSjRmEfVO1MfuxGjrhVANp5j3dMXye64QqmVLnz+3fSCSs
X-Google-Smtp-Source: AGHT+IFVliOgI5KVl6qOEN0qtuBrpDs9j7s/ClZECT9Dvk6mL7nYUkBDU975EZEv9YLaUFDKtyQGWw==
X-Received: by 2002:a05:6a00:944e:b0:736:5b85:a911 with SMTP id d2e1a72fcca58-742a97dba4bmr21333271b3a.8.1747664775819;
        Mon, 19 May 2025 07:26:15 -0700 (PDT)
Received: from gye-ThinkPad-T590.. ([39.120.225.141])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a96e211csm6465303b3a.16.2025.05.19.07.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 07:26:15 -0700 (PDT)
From: Gyeyoung Baek <gye976@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Gyeyoung Baek <gye976@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC 2/9] iio: consumer: Define timestamp-related structures and constants
Date: Mon, 19 May 2025 23:25:54 +0900
Message-ID: <20250519-timestamp-v1-2-fcb4f6c2721c@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250519-timestamp-v1-0-fcb4f6c2721c@gmail.com>
References: <20250519-timestamp-v1-0-fcb4f6c2721c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Define the required constants and structures on the consumer side.

The `timestamp_enabled` indicates whether a timestamp is grabbed or not.
This is passed to `iio_triggered_buffer_setup_new()` as an argument.

The `timestamp_type` indicates which handler grabs the timestamp.
This value is set by `iio_poll_func_register()`.

Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
---
 include/linux/iio/trigger_consumer.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/iio/trigger_consumer.h b/include/linux/iio/trigger_consumer.h
index 2c05dfad88d7..5e6ff8738386 100644
--- a/include/linux/iio/trigger_consumer.h
+++ b/include/linux/iio/trigger_consumer.h
@@ -13,6 +13,13 @@
 struct iio_dev;
 struct iio_trigger;
 
+enum iio_timestamp_type {
+	IIO_TIMESTAMP_TYPE_NONE,
+	IIO_TIMESTAMP_TYPE_CONSUMER_TOP_HALF,
+	IIO_TIMESTAMP_TYPE_CONSUMER_BOTTOM_HALF,
+	IIO_TIMESTAMP_TYPE_TRIGGER,
+};
+
 /**
  * struct iio_poll_func - poll function pair
  *
@@ -26,7 +33,10 @@ struct iio_trigger;
  * @timestamp:			some devices need a timestamp grabbed as soon
  *				as possible after the trigger - hence handler
  *				passes it via here.
+ * @timestamp_type:		indicates which handler grabs the timestamp.
+ * @timestamp_enabled:		if true, automatically grabs the timestamp.
  **/
+
 struct iio_poll_func {
 	struct iio_dev *indio_dev;
 	irqreturn_t (*h)(int irq, void *p);
@@ -35,6 +45,9 @@ struct iio_poll_func {
 	char *name;
 	int irq;
 	s64 timestamp;
+
+	enum iio_timestamp_type timestamp_type;
+	bool timestamp_enabled;
 };
 
 

-- 
2.43.0

