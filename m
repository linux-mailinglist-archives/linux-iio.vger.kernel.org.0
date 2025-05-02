Return-Path: <linux-iio+bounces-18988-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C26AA73A3
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 15:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1A99189A81F
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 13:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7164255250;
	Fri,  2 May 2025 13:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Cl9tbAis"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEFA246763
	for <linux-iio@vger.kernel.org>; Fri,  2 May 2025 13:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746192501; cv=none; b=JoJvmDtUltXW6CcPe/r9tbQQ49LX8T1JrAdJRz/CbCfNxnu5c9g12GBas1KKhW9XMI2h/xf7Ks+iCViI4AW7oozv5/Ox0AoF5xg9j+JoZedf9kdzIGSkREAGNETgD0mSbz0RYx5Y4rxU69AkXbZh7AwQXVtAPapI8cuXJ1PZCws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746192501; c=relaxed/simple;
	bh=9EK0Atp8rHdpu+X+rVm01GkzEyZtG4aZwO22eC6200s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=simlAt0UTttf/8gCUdeCkA9VRXUH0HZBH3xNhbutvkhavwfCzkrMVYoau9dEtKh+kIrWRtfmYD2WyBWG48DFXQU1lSmrosym1D5qmonF3KFqeXuXUGsdWfetsAimnMW7cCUfcxYX+eYsPn0Kk1ZvWRw7/7ir9A2iXbo4GBfmMzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Cl9tbAis; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43cfa7e7f54so11913825e9.1
        for <linux-iio@vger.kernel.org>; Fri, 02 May 2025 06:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746192497; x=1746797297; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RtntWz6cXKALzOhF2uJU1XcNxPBVH+VawQkBo5EZDg8=;
        b=Cl9tbAisCZ7CF6Omk9KfjX88GX8DuNq8qM6K4S2UAjQho5tXwOzShv6ZcYyd26kxKp
         k79lQaCy+wBogvwhPNRRyR4wUwEUTFP7uMk57hIyF7rUA3p6Okgrwj/AIFuZ6wZhiZtZ
         KZLrKMjYVUkoF+zY28k/7BYp25d4RdWR6tE38s+RpTDSvymnVysxn4KnxwLYmn1rw0to
         pCVRTupo37T4TaBdJkzMAVHzYhcVj12RfGubb6xtbWon6JNg5X4UdD4hOd1iLH75bBWo
         JPIZtNC2zUZTie4kx3/ZIij33F96QUZMmz17bP5j8D1U50O9VawJqXR5Q8Z/m2bOaQa2
         xoYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746192497; x=1746797297;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RtntWz6cXKALzOhF2uJU1XcNxPBVH+VawQkBo5EZDg8=;
        b=MWzJE0dBW+FPUwfJJe3/OX8yPqi65O3WuBPeJJ2ptMAaijjgpNUmqyLRo7xhQRvend
         BxEiLO3OwO9iOupqr69zyU2jLqvma2YtiGlb+0ALeCZoY766GcCBQRSwJeboCKZyein5
         G8Z2LNLyeam8IHln/ERdoZoxNV3OYMaq0vJup5h6nN2a7o3JTwvQ4c4FSKuMD0uOa1H8
         JzjFA1zTUptPrZCsLPSjhQdTOwcA5TXpm5OQukeNshRhweO02IZ5V54ZnULwKd3VHNES
         hWieyiXzQHpyVmeAP2C2CRAqXhWjnJi9Q8z59wsuofH7ATflkWaTmWiEHwiB9uV7Kia7
         9VbA==
X-Gm-Message-State: AOJu0YyxFR4A6mc4gz69sPaifD4yFAdegjzpxO6EoFf5FDoAD6F1nShR
	Yd3pCbn4Ha2Lp2zMbfueON+iZPeNIjh09gipIb+0Bd3jp/FJSizcUB9QIMNUhFc=
X-Gm-Gg: ASbGnctnW2alzO0/GUonx6F4dKNmO7E15edKouF7I/i8BSZM/xD0WrVJmjelkgYxLwU
	TXYB+aJWweBxpzPXTqyE8kzTq8JTdyjrZXhYp0nFzfvv3hu9ujPATk0fB75Bp0f3Xp1yIj/nrNg
	z6ZEJWl8x/CLvLafprLzjNV5x/eFyDCHDrbdJyJVTLvtnk/zls/h3mI9fkTU1sMVJ7rtPZwULkV
	ZLVRUyjZgY4anmAaROxATnGT1bLG833aOxhV60Eq2xsPYyaVZTjf/AxiqGB1Qg4wDb+sTOU7HJu
	OUgGMJvx/Ca7ePfP/9elPTj7c/vi53s+gzJIyRiScCCf
X-Google-Smtp-Source: AGHT+IHvcHbDPsyxb9la/dnjRvBkv8xkLYMqVH8JAhaqEDZzXIAl/dQSOfxdGlQyySBEP7xgydCKdA==
X-Received: by 2002:a05:600c:628b:b0:43b:c592:7e16 with SMTP id 5b1f17b1804b1-441b72b10f2mr62622585e9.3.1746192497181;
        Fri, 02 May 2025 06:28:17 -0700 (PDT)
Received: from [192.168.0.2] ([87.8.31.78])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b89cc50esm45761065e9.8.2025.05.02.06.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 06:28:16 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Fri, 02 May 2025 15:26:58 +0200
Subject: [PATCH v2 1/5] Documentation: ABI: IIO: add calibconv_delay
 documentation
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250502-wip-bl-ad7606-calibration-v2-1-174bd0af081b@baylibre.com>
References: <20250502-wip-bl-ad7606-calibration-v2-0-174bd0af081b@baylibre.com>
In-Reply-To: <20250502-wip-bl-ad7606-calibration-v2-0-174bd0af081b@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 devicetree@vger.kernel.org, Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1694;
 i=adureghello@baylibre.com; h=from:subject:message-id;
 bh=vb/6wvniAJeAs3RXPvCaUldK2+XHWqS8d1UiRHckMTI=;
 b=owGbwMvMwCXGf3bn1e/btlsznlZLYsgQOaEu92fjy4WvJ6i+WvtB+vefQvkn91iMJ04SkPAp/
 iwdvlBLpaOUhUGMi0FWTJGlLjHCJPR2qJTyAsbZMHNYmUCGMHBxCsBEHq9lZHg5/+5PK6Ndsq//
 T9rMHcI767huytKE/SG+YtkdiibFMa8ZGfbznYxesN3kjHXf6nWF73ZutXnMoX3G+aH+yWXmN9O
 2SXICAA==
X-Developer-Key: i=adureghello@baylibre.com; a=openpgp;
 fpr=703CDFAD8B573EB00850E38366D1CB9419AF3953

From: Angelo Dureghello <adureghello@baylibre.com>

Add new IIO calibconv_delay documentation.

The ad7606 implements a phase calibation feature, in nanoseconds.
Being this a time delay, using the conv_delay suffix.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 33c09c4ac60a4feec82308461643134f5ba84b66..56eb42f88999660b5f93f2311b7d57e0303b0647 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -559,6 +559,26 @@ Description:
 		- a small discrete set of values like "0 2 4 6 8"
 		- a range specified as "[min step max]"
 
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_calibconv_delay
+KernelVersion:  6.16
+Contact:        linux-iio@vger.kernel.org
+Description:
+		Hardware applied calbiration delay (assumed to fix errors that are
+		introduced from external circuitry).
+		For the ad7606 ADC series, this value is intended as a time delay,
+		as an integer plus nanoseconds.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_calibconv_delay_available
+KernelVersion:	6.16
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Available values of calibconv_delay. Maybe expressed as:
+
+		- a range specified as "[min step max]"
+
+		If shared across all channels, <type>_calibconv_delay_available
+		is used.
+
 What:		/sys/bus/iio/devices/iio:deviceX/in_accel_x_calibscale
 What:		/sys/bus/iio/devices/iio:deviceX/in_accel_y_calibscale
 What:		/sys/bus/iio/devices/iio:deviceX/in_accel_z_calibscale

-- 
2.49.0


