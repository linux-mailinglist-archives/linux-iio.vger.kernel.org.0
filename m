Return-Path: <linux-iio+bounces-24195-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBAABB7DE40
	for <lists+linux-iio@lfdr.de>; Wed, 17 Sep 2025 14:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4A4416D206
	for <lists+linux-iio@lfdr.de>; Tue, 16 Sep 2025 23:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD392EBBA1;
	Tue, 16 Sep 2025 23:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fTK4PiKK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC542D7DF1
	for <linux-iio@vger.kernel.org>; Tue, 16 Sep 2025 23:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758065825; cv=none; b=uPxNIMeig4GsXvLzN1Ub73OBgk8vLDhT9Vs3NRJHcvgDOEqLx/RYD9EM6Yqy1wn8jiq7Uh736xk0n7HkvTnl3T6RV5y8rbDWJLO8E8TMYKSPcJbvCPhhcgiF2whObDiSugDI05rCQkYTM4CBv+xCnjiXUsI10yGVgJHjZ23r/is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758065825; c=relaxed/simple;
	bh=jmIFrzhuCkeTq8aoCDJ2rAhb/3DfzKmeBEvuiDdglA8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FpZeYJA4k8hCArMvU14Hxrr0hva1b5qGy0NpM3sHDHRke2IIpChUSb3WTBMbiJHKrQosKMK85c/0zYne17+wxDCuSeU7f41icb3Kbv0ZsjGo6FTdMiO4sXUh6fxIzzX8i61z/CklYUn3uwJYWF4P171Um7sZXr09Ip81nNDZar4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fTK4PiKK; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-267f0fe72a1so6470155ad.2
        for <linux-iio@vger.kernel.org>; Tue, 16 Sep 2025 16:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758065823; x=1758670623; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lxdcHcBGjhOznZ861gxh1q71v55lbCXoAFjQMQ3zSXI=;
        b=fTK4PiKKBcMBx3xOI1xivxXwdJF4lt1JDhbQpQpWyyfDzqnkbkDETQMoxV3hxUSNDF
         fw4RqLMbWHjBgoAx2OZWnlI3f965OV+OVM1iE5znn+PgxLJgQeBTFmLsARI3/p8PWB2T
         xcj/4+jBgbZzFsNWV2kRuue86gCXl2NHy309ZptcnMM0+2ALnljmNY3h/LYvrpoZhNrL
         q7zHrttD09wAbUuz4A0eQZMi1sO+c9hwN4UlwAIAQpDWEr1XHhvRMPTpIEmry5fezaV5
         bxB0COo+sys19JUS4T90RnIq5jsFoVrHv7z5RiuE4IJepP3aduv5UGP60Al5176jkx0n
         y9Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758065823; x=1758670623;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lxdcHcBGjhOznZ861gxh1q71v55lbCXoAFjQMQ3zSXI=;
        b=ftDTWs25Q+S7koz93LllSxk0ucs4RebTmAIK6c+E6yLeqCjxF4iDgXPpj7IhZEw64c
         e4QOo7ye5QA6nt8QAFrKiEPvGwqUs90sbCCw89SLfpMwfI8iGnCtUvFkbqVf+g2TNeIf
         wLdkwR97a2t3p2LixYRI8xY+ZHJTt0JP/AsXkUeg7fKbLo+3IQT3F385YHVccKfZgxO8
         RgEtHGRL7pl48xe3PUDW7/VTLWM0lgU6V7l74TknDJbSmoQwdc21gz7hvX2gqB1IKIHA
         hp3LDNQoCmxnSjeuN6pksnf0T4G5qXmHAgYwmZgV749FleVVJDpLsJJAJd2SU4ljpqpI
         8i3w==
X-Gm-Message-State: AOJu0YwD3vFxmaU2bnnQrGGdQa1pjkn7eVjIgVE7XrXb42w5yjCvHJNk
	jdHKbP/9AhQmO2emWspQ3XHRf/qB81/Yo7GKJ/mdbceLwxRpLOCCvvCc
X-Gm-Gg: ASbGnctCS6f9130HnK5LcRbhtRow+21W5vSe5UMeMbBBBEOdBgDKl2o4uU62H1wmnhn
	LwQwKkIQsb46pVZ7n1WPOOMT+lgMQDZNVIrkPOfCdV7PvmGSE0Bf7w2yfGnut7ythbIVevV/JP4
	Ft3RXd+O0oqmmBxzt3uMWN/vxm9ZXfBPvGgKM4YCWtWgZnb05uiYnW3ARhAJRXiVwDFoeqQ1UOL
	0YBt7pkJu2IQWD0ATY5cYipTypWNk7YiPwiTJKIw2qsTGy9dyWCBmoydb6exzDVjaW1w0b02SoT
	5IrtDCm6L/yJn5xUILVDTaT1GhmgbKRbpPB+ZeRaIcwfCkXz/iVWK+WrgnpORshWKzSmTKZrMDA
	LB4I4XZuqnw2cQJMX2dL3j+neAg==
X-Google-Smtp-Source: AGHT+IHxLbxAZnUj1CScDSKSM3GL/HL/XAd0FoSZ3hZKt/QN7icZfLqKgH8sOlEwoiR3+HsctkbmDg==
X-Received: by 2002:a17:902:7448:b0:249:2318:7a2d with SMTP id d9443c01a7336-26811d9273fmr669685ad.19.1758065823035;
        Tue, 16 Sep 2025 16:37:03 -0700 (PDT)
Received: from [192.168.1.135] ([2804:14d:90a8:4498::371])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54b8eb4737sm10108298a12.9.2025.09.16.16.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 16:37:02 -0700 (PDT)
From: Gustavo Silva <gustavograzs@gmail.com>
Date: Tue, 16 Sep 2025 20:38:24 -0300
Subject: [PATCH v6 2/2] iio: ABI: document accelerometer event attributes
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-bmi270-v6-2-6acd8d26a862@gmail.com>
References: <20250916-bmi270-v6-0-6acd8d26a862@gmail.com>
In-Reply-To: <20250916-bmi270-v6-0-6acd8d26a862@gmail.com>
To: Alex Lanzano <lanzano.alex@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gustavo Silva <gustavograzs@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758065905; l=4613;
 i=gustavograzs@gmail.com; s=20250915; h=from:subject:message-id;
 bh=jmIFrzhuCkeTq8aoCDJ2rAhb/3DfzKmeBEvuiDdglA8=;
 b=Pz5QdTxcOVElNPSF9gagWNFeCT0go4cKUSZtUVWmRX7pfVomIz+MtkCJhuk3gUlW8dyVHoF0e
 uTCnfZmfcpeAoVWI7dqKKfFtc1B47Sh45wyLi4nxkiEuhOsbYo+YMR4
X-Developer-Key: i=gustavograzs@gmail.com; a=ed25519;
 pk=kYkFqZEIlab+1AaYMvpqhTQxwPXcJiTXdMaBQbfORrg=

Add ABI documentation for accelerometer event-related sysfs attributes
exposed by the bmi270 driver. These include threshold, period, and
enable controls for adaptive magnitude (any-motion) and rate of change
(no-motion) event detection.

Signed-off-by: Gustavo Silva <gustavograzs@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 34 +++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 2fb2cea4b19249743398b1ff0b538b03ced0340b..b45d1ba6972848a6024746d7d741146e35a55ebb 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -908,6 +908,7 @@ What:		/sys/.../iio:deviceX/events/in_accel_y_roc_rising_en
 What:		/sys/.../iio:deviceX/events/in_accel_y_roc_falling_en
 What:		/sys/.../iio:deviceX/events/in_accel_z_roc_rising_en
 What:		/sys/.../iio:deviceX/events/in_accel_z_roc_falling_en
+What:		/sys/.../iio:deviceX/events/in_accel_x&y&z_roc_rising_en
 What:		/sys/.../iio:deviceX/events/in_anglvel_x_roc_rising_en
 What:		/sys/.../iio:deviceX/events/in_anglvel_x_roc_falling_en
 What:		/sys/.../iio:deviceX/events/in_anglvel_y_roc_rising_en
@@ -991,6 +992,7 @@ What:		/sys/.../events/in_accel_y_raw_thresh_rising_value
 What:		/sys/.../events/in_accel_y_raw_thresh_falling_value
 What:		/sys/.../events/in_accel_z_raw_thresh_rising_value
 What:		/sys/.../events/in_accel_z_raw_thresh_falling_value
+What:		/sys/.../events/in_accel_mag_adaptive_rising_value
 What:		/sys/.../events/in_anglvel_x_raw_thresh_rising_value
 What:		/sys/.../events/in_anglvel_x_raw_thresh_falling_value
 What:		/sys/.../events/in_anglvel_y_raw_thresh_rising_value
@@ -1129,6 +1131,7 @@ Description:
 		will get activated once in_voltage0_raw goes above 1200 and will become
 		deactivated again once the value falls below 1150.
 
+What:		/sys/.../events/in_accel_roc_rising_value
 What:		/sys/.../events/in_accel_x_raw_roc_rising_value
 What:		/sys/.../events/in_accel_x_raw_roc_falling_value
 What:		/sys/.../events/in_accel_y_raw_roc_rising_value
@@ -1177,6 +1180,7 @@ Description:
 
 What:		/sys/.../events/in_accel_x_thresh_rising_period
 What:		/sys/.../events/in_accel_x_thresh_falling_period
+What:		/sys/.../events/in_accel_roc_rising_period
 What:		/sys/.../events/in_accel_x_roc_rising_period
 What:		/sys/.../events/in_accel_x_roc_falling_period
 What:		/sys/.../events/in_accel_y_thresh_rising_period
@@ -1187,6 +1191,7 @@ What:		/sys/.../events/in_accel_z_thresh_rising_period
 What:		/sys/.../events/in_accel_z_thresh_falling_period
 What:		/sys/.../events/in_accel_z_roc_rising_period
 What:		/sys/.../events/in_accel_z_roc_falling_period
+What:		/sys/.../events/in_accel_mag_adaptive_rising_period
 What:		/sys/.../events/in_anglvel_x_thresh_rising_period
 What:		/sys/.../events/in_anglvel_x_thresh_falling_period
 What:		/sys/.../events/in_anglvel_x_roc_rising_period
@@ -1344,6 +1349,15 @@ Description:
 		number or direction is not specified, applies to all channels of
 		this type.
 
+What:		/sys/.../iio:deviceX/events/in_accel_x_mag_adaptive_rising_en
+What:		/sys/.../iio:deviceX/events/in_accel_y_mag_adaptive_rising_en
+What:		/sys/.../iio:deviceX/events/in_accel_z_mag_adaptive_rising_en
+KernelVersion:	2.6.37
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Similar to in_accel_x_thresh[_rising|_falling]_en, but here the
+		magnitude of the channel is compared to the adaptive threshold.
+
 What:		/sys/.../iio:deviceX/events/in_accel_mag_referenced_en
 What:		/sys/.../iio:deviceX/events/in_accel_mag_referenced_rising_en
 What:		/sys/.../iio:deviceX/events/in_accel_mag_referenced_falling_en
@@ -2386,3 +2400,23 @@ Description:
 		Value representing the user's attention to the system expressed
 		in units as percentage. This usually means if the user is
 		looking at the screen or not.
+
+What:		/sys/.../events/in_accel_value_available
+KernelVersion:	6.18
+Contact:	linux-iio@vger.kernel.org
+Description:
+		List of available threshold values for acceleration event
+		generation. Applies to all event types on in_accel channels.
+		Units after application of scale and offset are m/s^2.
+		Expressed as:
+
+		- a range specified as "[min step max]"
+
+What:		/sys/.../events/in_accel_period_available
+KernelVersion:	6.18
+Contact:	linux-iio@vger.kernel.org
+Description:
+		List of available periods for accelerometer event detection in
+		seconds, expressed as:
+
+		- a range specified as "[min step max]"

-- 
2.51.0


