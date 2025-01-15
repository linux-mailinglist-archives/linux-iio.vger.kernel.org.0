Return-Path: <linux-iio+bounces-14371-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A5DA11A3F
	for <lists+linux-iio@lfdr.de>; Wed, 15 Jan 2025 08:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D252C3A46C1
	for <lists+linux-iio@lfdr.de>; Wed, 15 Jan 2025 07:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC02E22FDF4;
	Wed, 15 Jan 2025 07:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IUD/RUOE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FF822F166;
	Wed, 15 Jan 2025 07:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736924426; cv=none; b=GFy54wcCqXxGqdaWLgqpjbi/YEkRA5vLBj+v7qMrzovf97SDjB+OhvcTzJ3snwxiZL0EO5kkLlxKCAw1C7GyXXrMdF++MQfsVrxV069Ap0t4sx5erx1IGjHo5v8JcZeAbHXl7ndPLilg0GMBAmmOcXjR4nseBkwLNg/On1u6zGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736924426; c=relaxed/simple;
	bh=nDyHfRo+K6FC5fnnEtaMc8Bc3uQ3Kb+bqRO8AZVdHjg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=PKskYMQ3ctZ13s78GVnXPYIcANCHQlLU0Xz5WDPkxRT+JDoJvsBcfqEwPbAE7w0xp+8qjiOCTzxe1qOOR17JEPOlg3Ilxg9dWn2SpJ9cAsZNCEB6dcWYY2ikagBakUgbQkh4ocC2oPtdlkZbQeaLLxSuySJ9hkX+aLGSyiT8v7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IUD/RUOE; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-219f8263ae0so104914295ad.0;
        Tue, 14 Jan 2025 23:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736924424; x=1737529224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Eb+O5WpkrYpDD7ZwYT7Bfm4Y6rLpuCSVUqwj2xJzlCk=;
        b=IUD/RUOENtKkL9HR8Qfz+jnLtgXnk9zp1EBsY/pkF1FV3X/2Q0uwhRG1DIvJIQJMpN
         0j4XSr3oY5h528p8iPNzd2L+QmS5MkM+vc5CWl+E5UODDs6jQKnl/ed1IxqHzMwHWMcN
         nZ3J5NYua9Nw5GomFm6qvcuXg/+4BmiMY6cYWzWjNT10l67AAlEKmwiIM8h5jHaouuxQ
         sEFUHGeB0YgGetucs4nUJ3ghsMVmAb3sTtJA193a9ySeUAPos+HqkYVy8hsZJWtNNdK2
         g9l6oFCrYXPSbwa36ba8g95alU31tydw4PZwaVHJsPivzsmdE8wdzSTdXZ+OMLlYSsg9
         +KCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736924424; x=1737529224;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Eb+O5WpkrYpDD7ZwYT7Bfm4Y6rLpuCSVUqwj2xJzlCk=;
        b=HuqESJDT+m86CeMOT2/OxV1ndRPSxWXoDgBKplnsIk8v5Hm3nZ5oxXDwbZ5kxI0J6d
         /yBBzWPQ7fHKNxO/L24B/OclqpA2TTcI0hq0Nc52zyX9vzm3tFKaGbaKGTR0fl/gnSd6
         93Jx9DuxS7ZK6xTZbU7+cfjUGY4IFDSZ+WxtH0+NcPeF4BorwG3tPrW7fQpZ+GdWwoQz
         oPsOuZ7jqsKsteSBfIT4h735MiueC1eVS0SvDb4eaZbpunT3zrLoAU5ulmzIGwH4T8TN
         4HKNCLMnfTZXPNFOd4RelOh3hkkSlWnbUokK1/IXOd+rWq6Nq50HnHm2Xm3TJWnrCrAa
         bjGg==
X-Forwarded-Encrypted: i=1; AJvYcCUBYTBF2GZ5nKvGtJxQgXF3BZsL2vi3bMRUk1YeaJe1RiI6/bRxNuUHPyBbMC2UUsDudRGda/QJI5tLs7i7@vger.kernel.org, AJvYcCW6pFTzQdP91DB4pZNcSgUMr6XRKcAl+5wJ4T1C2cut6cMqDbfLf9T71WHuBSsLfxqFa1CnLikfKh4=@vger.kernel.org, AJvYcCX6D1ygPeo6VWVYxA2+S4FGPYDv2IZ2DnHCgHqeNC/phM2v9on0/pLe17o52IXWIhC4WH4ILMKCRSe3fQM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1o+bmJ9XqVg7VbkT6fUr/SbSabhbBqjiL9/gLeA1Bzu848ejr
	R7qMJfI06SBi2AQY/BfnBcZSnUEeUsqcfk8x4zCI5aQsNGxxWLj0zDAZ7JW62R7h1A==
X-Gm-Gg: ASbGncuJIQZuVfoSclbYmSOtBY0NdjMEAkGZ6nElHkfwRB/rwZDov+4vsZKLE0qfFx2
	XUQdScF1hjS/v9p2eq7sDvLVa0XGwxxs05sylQUbivC+gah8FdrdcOTxjLlp8Numk5ewzjlN1Zy
	PMp7mtjUYLY9DnGeRQCMxk8a9JiIKXcu8TQwxG0U+VCHTvGTiQFzT8X7u5Cu1EhNxa28iMkn9vI
	YCLREdIK5K86bgA7ZXpmABfymc+jv4kGX6nFtK6YPnxsiyhAVKCDaw4rXqIfzJNWw0D+EgF1LHw
	1r3zSVSzCA==
X-Google-Smtp-Source: AGHT+IFJVCuVycLYvPU2G7q6Cahbwub5Ot+OKYVFQ3+IRaOZ632beXHt0WfE1aiUGqJOzvlPvJbXTw==
X-Received: by 2002:a05:6a21:3a8c:b0:1e1:ffec:b1bf with SMTP id adf61e73a8af0-1e88d12b62amr40659363637.26.1736924423589;
        Tue, 14 Jan 2025 23:00:23 -0800 (PST)
Received: from localhost (118-163-61-247.hinet-ip.hinet.net. [118.163.61.247])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-a318e8ec100sm9013075a12.36.2025.01.14.23.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 23:00:22 -0800 (PST)
Sender: AceLan Kao <acelan@gmail.com>
From: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiri Kosina <jikos@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org
Subject: [PATCH] HID: quirks: ignore non-functional sensor in HP 5MP Camera
Date: Wed, 15 Jan 2025 15:00:20 +0800
Message-ID: <20250115070020.2777721-1-acelan.kao@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The HP 5MP Camera (USB ID 0408:5473) reports a HID sensor interface that
is not actually implemented. Attempting to access this non-functional
sensor via iio_info causes system hangs as runtime PM tries to wake up
an unresponsive sensor.

  [453] hid-sensor-hub 0003:0408:5473.0003: Report latency attributes: ffffffff:ffffffff
  [453] hid-sensor-hub 0003:0408:5473.0003: common attributes: 5:1, 2:1, 3:1 ffffffff:ffffffff

Add this device to the HID ignore list since the sensor interface is
non-functional by design and should not be exposed to userspace.

Signed-off-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
---
 drivers/hid/hid-ids.h    | 1 +
 drivers/hid/hid-quirks.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 1f47fda809b9..c5b57e857e77 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -1094,6 +1094,7 @@
 #define USB_DEVICE_ID_QUANTA_OPTICAL_TOUCH_3001		0x3001
 #define USB_DEVICE_ID_QUANTA_OPTICAL_TOUCH_3003		0x3003
 #define USB_DEVICE_ID_QUANTA_OPTICAL_TOUCH_3008		0x3008
+#define USB_DEVICE_ID_QUANTA_HP_5MP_CAMERA_5473		0x5473
 
 #define I2C_VENDOR_ID_RAYDIUM		0x2386
 #define I2C_PRODUCT_ID_RAYDIUM_4B33	0x4b33
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index e0bbf0c6345d..5d7a418ccdbe 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -891,6 +891,7 @@ static const struct hid_device_id hid_ignore_list[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SYNAPTICS, USB_DEVICE_ID_SYNAPTICS_DPAD) },
 #endif
 	{ HID_USB_DEVICE(USB_VENDOR_ID_YEALINK, USB_DEVICE_ID_YEALINK_P1K_P4K_B2K) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_QUANTA, USB_DEVICE_ID_QUANTA_HP_5MP_CAMERA_5473) },
 	{ }
 };
 
-- 
2.43.0


