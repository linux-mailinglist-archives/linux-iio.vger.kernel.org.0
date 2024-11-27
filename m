Return-Path: <linux-iio+bounces-12729-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF209DA486
	for <lists+linux-iio@lfdr.de>; Wed, 27 Nov 2024 10:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30609B23595
	for <lists+linux-iio@lfdr.de>; Wed, 27 Nov 2024 09:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21AE71925AD;
	Wed, 27 Nov 2024 09:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rAeERaPi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B586191F75
	for <linux-iio@vger.kernel.org>; Wed, 27 Nov 2024 09:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732698657; cv=none; b=t4eHX68WiUwJB4pdWj9/N5tLTcM+eygw51W4Cv4jE3S9tXmvypqeAiA6EVDzO/FwbqfP9/t06uKcfyyRcmqhDNaZNtTUiJHC6OC+B6ZUEqOhAoRAwnZrhiWoxJnnJ1FXli9HN9l1JrhbR9Ur2SVy6DcndDyfC9ADGKMXjeqX1rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732698657; c=relaxed/simple;
	bh=hi7liUjxe5RX7PGtUMrmWW50QPKb3a7b4fHNFzjuy8k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yj0uG0kVBbyJA1JtJbpFM+GHCF1hmJ1tJs0DoVhrsJadqfNfmZYsr64KwUZf6W9fAJs6ShLIpeRaX+LSuPgBiZNh+E3XYnUuPApBhAy1WGi5SNw3SJulOliGbkQcpuofe2hIBuNBQ/3QLilTTejAb5fMQ2Ur9yd3Ji1fp+n/CTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=rAeERaPi; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-434a742481aso12477265e9.3
        for <linux-iio@vger.kernel.org>; Wed, 27 Nov 2024 01:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732698654; x=1733303454; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D++hmFkktyJpz8KdCoh+I0yzg35pIUrfCd8imheAkBM=;
        b=rAeERaPiTdAiFjKfP1n3AiaNPNT/gU9HVJeuKm4CZ7HsRJ1Os1ELUD8LR9fWH3S+Iy
         7J/N2JWIfzrhMzdhywuMgwKRnzpChJR1q2T3gDVA57gw3D9FeoPT27RtpvFipdeehKw+
         +FxcRPsBYBUKT12Y34EkMUvb4S8PQJ5I7OLVM/3ObV2SMdpCfA4LLWAoJ8A6J5DHUiUe
         MGxoLf40a2HUHjRAd9gUrDShsIW+kGlJQ5S/S/z7AGP2rJF4qUCKZNs2vuF0CZ3zCAqF
         dEPLuckfKQztzfETdJ9+6CBbw0vn28zT+v5yYz0NWwy6FpQugsaH3/y1tm7xR8ytgiX0
         qXZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732698654; x=1733303454;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D++hmFkktyJpz8KdCoh+I0yzg35pIUrfCd8imheAkBM=;
        b=egZb+Lpf5sY3rt6i6bfZcwjh0LCrREd+k1dEnXazxnnbLsl17iSA2z231RM2W794f/
         l23Z33/M1aWj3xzex85hJCHfpwIbvf3YF9RdZxJvy2ZForUIZFmTrLThHLwGkJp1pgTV
         zQ8wqMM/NuFtrDLGCWSH8XaCjbPBLvIs7al0UgHWEeM6CwgyLy2Jxiq3oEImVB06wOMQ
         lIg3FOHiii9+/MSpWoca5BrGrgAshj2TVlsZIGfy8TvxzDARBFO2bLrUEa6YIvKH72bp
         Qqig+7tcxuIBr79ACF7zMk9NxuZ10iitwy1EcdKieHb+JC7JRAKrQlVqPkxWN2CqWbh4
         ll3w==
X-Gm-Message-State: AOJu0YxzPVidUKiw+YPXlEloPB3kFrv7SnrtpZblGpJBhxkcf9obCY4B
	1sCoyHM1NqhWKNCYZ5TOEICqZLFjPz4JmwKPm+ivGBGvwV4ptoWakb7RqBQ/inA=
X-Gm-Gg: ASbGncvpbLPfIDiigEoMBHqOYfAVzzLJAYdnUSmZ3IZN6+YNOeUD8o39wf+gXrDv5yL
	SwUaQsDztMUTFT0FGdTazOac7Q6S2M3TJh5P9Qx23Os9Xv3a4xJgWuB97+dN+kXP0/HoSUY2FaM
	u94l4s6gYL880ldLNhCn4ACb4p816BrBh7wqqmzls7D2ZwtqCxT0VYj6LF5u0jwSZVzw0D27CIv
	NQhBTuU3bkfweS2xp5pi6Rh9AyhduZ7k6d1KVV8cAx07Pa9IlGRyn3alfD37pGIES5XrOG3PvSm
	C4k1CJka8xCZ+qTyaXsN
X-Google-Smtp-Source: AGHT+IEFPftre0OsDTeBGSoRFHKJc3M1AJdfpQJilY19IR+WHfaPS6t600F3xsPWWTZA6Rf3QY3rhQ==
X-Received: by 2002:a05:6000:1844:b0:37d:5352:c83f with SMTP id ffacd0b85a97d-385c6ebbab6mr1844313f8f.17.1732698653797;
        Wed, 27 Nov 2024 01:10:53 -0800 (PST)
Received: from [127.0.0.1] (alille-653-1-300-114.w90-1.abo.wanadoo.fr. [90.1.180.114])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa7e5285sm14529415e9.40.2024.11.27.01.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 01:10:53 -0800 (PST)
From: Guillaume Ranquet <granquet@baylibre.com>
Date: Wed, 27 Nov 2024 10:06:14 +0100
Subject: [PATCH v2 2/2] iio: adc: ad-sigma-delta: Document ABI for sigma
 delta adc
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241127-ad411x_calibration-v2-2-66412dac35aa@baylibre.com>
References: <20241127-ad411x_calibration-v2-0-66412dac35aa@baylibre.com>
In-Reply-To: <20241127-ad411x_calibration-v2-0-66412dac35aa@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Guillaume Ranquet <granquet@baylibre.com>
X-Mailer: b4 0.15-dev

Add common calibration nodes for sigma delta adc.

Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
---
 .../ABI/testing/sysfs-bus-iio-adc-ad-sigma-delta   | 23 +++++++++++++++++++++
 Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192 | 24 ----------------------
 2 files changed, 23 insertions(+), 24 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-ad-sigma-delta b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad-sigma-delta
new file mode 100644
index 0000000000000000000000000000000000000000..c2c55a966163736aea8d46fc5089c08dac747b84
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad-sigma-delta
@@ -0,0 +1,23 @@
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltagex_sys_calibration
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		This attribute, if available, initiates the system calibration procedure. This is done on a
+		single channel at a time. Write '1' to start the calibration.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltagex_sys_calibration_mode_available
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		This attribute, if available, returns a list with the possible calibration modes.
+		There are two available options:
+		"zero_scale" - calibrate to zero scale
+		"full_scale" - calibrate to full scale
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltagex_sys_calibration_mode
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		This attribute, if available, sets up the calibration mode used in the system calibration
+		procedure. Reading returns the current calibration mode.
+		Writing sets the system calibration mode.
diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192 b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192
index f8315202c8f0df2bd4b7216f5cf8d3c2780fcf3f..28be1cabf1124ac7593392e17e4759ddfac829e8 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192
+++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192
@@ -19,33 +19,9 @@ Description:
 		the bridge can be disconnected (when it is not being used
 		using the bridge_switch_en attribute.
 
-What:		/sys/bus/iio/devices/iio:deviceX/in_voltagex_sys_calibration
-KernelVersion:
-Contact:	linux-iio@vger.kernel.org
-Description:
-		Initiates the system calibration procedure. This is done on a
-		single channel at a time. Write '1' to start the calibration.
-
 What:		/sys/bus/iio/devices/iio:deviceX/in_voltage2-voltage2_shorted_raw
 KernelVersion:
 Contact:	linux-iio@vger.kernel.org
 Description:
 		Measure voltage from AIN2 pin connected to AIN(+)
 		and AIN(-) shorted.
-
-What:		/sys/bus/iio/devices/iio:deviceX/in_voltagex_sys_calibration_mode_available
-KernelVersion:
-Contact:	linux-iio@vger.kernel.org
-Description:
-		Reading returns a list with the possible calibration modes.
-		There are two available options:
-		"zero_scale" - calibrate to zero scale
-		"full_scale" - calibrate to full scale
-
-What:		/sys/bus/iio/devices/iio:deviceX/in_voltagex_sys_calibration_mode
-KernelVersion:
-Contact:	linux-iio@vger.kernel.org
-Description:
-		Sets up the calibration mode used in the system calibration
-		procedure. Reading returns the current calibration mode.
-		Writing sets the system calibration mode.

-- 
2.47.0


