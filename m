Return-Path: <linux-iio+bounces-8505-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0669E9538EB
	for <lists+linux-iio@lfdr.de>; Thu, 15 Aug 2024 19:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0E532852D8
	for <lists+linux-iio@lfdr.de>; Thu, 15 Aug 2024 17:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2351BB6B8;
	Thu, 15 Aug 2024 17:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NA4KPlho"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C081B4C48
	for <linux-iio@vger.kernel.org>; Thu, 15 Aug 2024 17:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723742542; cv=none; b=mPuq7URzTRx1ld3g9GLPIhqMzTQVZpEykqGxFlxvKtNLU2jXEaf4btTfpUYb83TcvV91BKNwtm39QoIh8YaENlKAE9al2qnVANhg3A99idpHMsHdZ7jwAzkDZfjx713RKabyTZlP7P+HgBQ7VXiWDnF/aACpxD9NAY/F45vu9Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723742542; c=relaxed/simple;
	bh=HTE9AF95FYEDE44Je5v0L+ZEBU/Bi9/yQL6SYE3InCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kYPB4+zALXjuXZ2Jd6ig67q4xCcudZkIzv09vPU3BqxSJf+XMGx/SKra+3q/boIGRnRkhFFI2iilOYdeSuDuyuovO7i7KjGLN7//CPVFWROMp5f0GlNezSGVUNEbuvi1Q7ElnHIM9sLiZNimuuhZtO1U1yxZeXOjaRErlWm5K2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=NA4KPlho; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-260f4c9dfe2so572193fac.0
        for <linux-iio@vger.kernel.org>; Thu, 15 Aug 2024 10:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1723742539; x=1724347339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wcesUZ+PyyZLACSq67B+2czdbFpwEBLROdXRTYzWgqs=;
        b=NA4KPlhoyQ0pL86j0qd0OgmEyLzMsi+VUWbx4uYhM6ba3h80OnPCRUNBemMVsFlZe9
         K4BqaMIVdCdL25C2hm+n6EWjj1TjBSnI4cUV6+dVN+VhK9SVHMBDMvlBb1LAUGN+THk1
         y4Zsa2hv/8JDszMYweQC0jEonM18oZFmMm+XigcVF6yYb3q9p4HhTVLt5VBqFRgTMY/+
         nFWGjgPAhQFfAW4EKry9w6SfWMahtSuzL7VdROJfzSV6rmu2ejbYCpvp8A+Oz4RItVBG
         2Os3JtRyi+sgrtu3CVFJegAjD8B0MbLmEzsFGrtyE0gZtiS8aM3oDJOUozQ25vLbQtGE
         j/cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723742539; x=1724347339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wcesUZ+PyyZLACSq67B+2czdbFpwEBLROdXRTYzWgqs=;
        b=b8eXr3Kc5xk7SnI0U7EdpeeFqFvZgkNN35MIfCHUn/T96bu1V8vOxCVPlwS68Nd2YQ
         Ho2WayQWL3tvPooUi7A94l42qq4Fn0uE/VS5j8YjfRFS9VTvClciP4fdNLssTaYIBO4A
         JxtWt/dB25ai6dT6kH8S0q053FvJy/27KTevTidP7iBaxhIUtvIxf1N4ushuY4hnElAu
         IuVJIWmjbL+qWRlUynB470bB51uM7oH/1N2xiS+OQWAlZewgLfd4608/KYYtSH5pssq0
         xd8HLv6DzKmM6Jba0asJdZBX3X414OxzBV9tueHgGVuawHGETk/HslhjI0bobzdoCvsq
         vzUA==
X-Forwarded-Encrypted: i=1; AJvYcCXBEhM/ckf14RCDizJu1ZEBUicWbBUQMBq5igZflkB343FI8ieV3elUiX1RPDyLIre4BC9krJa35H1hPAxz1S11zCTjdDRrHII+
X-Gm-Message-State: AOJu0Ywemt/ksIZTJCRGV4G2UbcAf88QAwZgAYyV2wtH6SGtNTzR3VZD
	DWmP9WKNmB0tS9/chH+X2x8O7FnZUQKaWwCueVVHj0xd/E/2GS7/1GYlNIfIrEg=
X-Google-Smtp-Source: AGHT+IE0IpVcxKXiE51xHAESEiTWRzrQ5ztPPnJYDYy6IwnEqG/maM6BAofsEHWuPvEpFKCslpu70w==
X-Received: by 2002:a05:6870:1b0d:b0:265:b32b:c465 with SMTP id 586e51a60fabf-26fff476ebdmr1895548fac.9.1723742539426;
        Thu, 15 Aug 2024 10:22:19 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70ca66297d0sm345327a34.68.2024.08.15.10.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 10:22:19 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] iio: ABI: sort calibscale attributes
Date: Thu, 15 Aug 2024 12:22:11 -0500
Message-ID: <20240815-iio-abi-calib-audit-v1-2-536b2fea8620@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240815-iio-abi-calib-audit-v1-0-536b2fea8620@baylibre.com>
References: <20240815-iio-abi-calib-audit-v1-0-536b2fea8620@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.0
Content-Transfer-Encoding: 8bit

Sort calibscale attributes so that when we add more, they can also be
added in alphabetical order.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 67d8d1df23d4..401e0a595aba 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -549,25 +549,25 @@ Description:
 		- a small discrete set of values like "0 2 4 6 8"
 		- a range specified as "[min step max]"
 
-What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_calibscale
-What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_supply_calibscale
-What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_i_calibscale
-What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_q_calibscale
-What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_i_calibscale
-What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_q_calibscale
-What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltage_calibscale
-What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_calibscale
 What:		/sys/bus/iio/devices/iio:deviceX/in_accel_x_calibscale
 What:		/sys/bus/iio/devices/iio:deviceX/in_accel_y_calibscale
 What:		/sys/bus/iio/devices/iio:deviceX/in_accel_z_calibscale
+What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltage_calibscale
 What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_x_calibscale
 What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_y_calibscale
 What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_z_calibscale
+What:		/sys/bus/iio/devices/iio:deviceX/in_illuminance_calibscale
 What:		/sys/bus/iio/devices/iio:deviceX/in_illuminance0_calibscale
-What:		/sys/bus/iio/devices/iio:deviceX/in_proximity0_calibscale
-What:		/sys/bus/iio/devices/iio:deviceX/in_pressureY_calibscale
 What:		/sys/bus/iio/devices/iio:deviceX/in_pressure_calibscale
-What:		/sys/bus/iio/devices/iio:deviceX/in_illuminance_calibscale
+What:		/sys/bus/iio/devices/iio:deviceX/in_pressureY_calibscale
+What:		/sys/bus/iio/devices/iio:deviceX/in_proximity0_calibscale
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_calibscale
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_i_calibscale
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_q_calibscale
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_calibscale
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_i_calibscale
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_q_calibscale
+What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_supply_calibscale
 KernelVersion:	2.6.35
 Contact:	linux-iio@vger.kernel.org
 Description:

-- 
2.43.0


