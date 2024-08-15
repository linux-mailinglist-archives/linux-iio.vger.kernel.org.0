Return-Path: <linux-iio+bounces-8508-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4909F9538F0
	for <lists+linux-iio@lfdr.de>; Thu, 15 Aug 2024 19:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E63EC1F262A1
	for <lists+linux-iio@lfdr.de>; Thu, 15 Aug 2024 17:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DCE71BC085;
	Thu, 15 Aug 2024 17:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="g+/XpKFB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0911BA89B
	for <linux-iio@vger.kernel.org>; Thu, 15 Aug 2024 17:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723742543; cv=none; b=V8yRMsemYh2dSkRaWZKDrAHOh21RBgitAIH8QJtX/VzCPv5Ypb59R5NKNzWZrWRhaNLdWm5FR1J+o9UBxrY0Jbi4276Y1LeFNn+PCnED9RmQj7f7TjLu/cCfsk8L1DNB0uFS/wVxkYQUrjPaVqinAtd+YhDEykDPw4PGYGNU7SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723742543; c=relaxed/simple;
	bh=NqKNlMBKIncrdZaC5SfMefPwGwnTpzNFFps7IhFDvR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hwSbZNXb1FmIM3gXTM98cNESl0r6yHdCPTeokOxHvLgZglt5g+xcIv59A+BcWRJthQDkbbBlnbLEsdpqw4AuIc/kugMm/4g6gJGb6yq+rT8f3iDAxt+JOsqqrlIh2XA9WPITMr/PFTSgkCIfE0Y0Ex+mF/VFAaOg7WmaUjt8IbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=g+/XpKFB; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5d5b986a806so1221829eaf.1
        for <linux-iio@vger.kernel.org>; Thu, 15 Aug 2024 10:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1723742541; x=1724347341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ee3sT3/uSk/z9bmUFqgsaKtC1S/E/xH0EqUpDks1E0E=;
        b=g+/XpKFBheqISNDyLc60IzSGdsQknKRbmh4gv1Eg6Xctfv12M3IDJtEAzK0Yr1ovHS
         nBBJkVKAjXuULjurUSkMehFOVs9BNUxt13+PeJTpR+ZSMA/DOBVOEixjSTMwM/wOcb8L
         I5wj/YPFeMo84W5jBMQccxl92GS7hxxyNrtv+SZfwCp3tqWavUgi97qnn+tOi37r/2pO
         hptrgYGY5RbY0AyZYUApgZge9K6oKRFCX0s1ns5C+vqBA/ZHMYtke93nkNoSFPuwXDSc
         yT7w+G9MVjMV/3d9So/U6QILZ9/oarsL6TPvyC+SWgKwUDZrY0KdGcYId9d+16Os6e6a
         0cxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723742541; x=1724347341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ee3sT3/uSk/z9bmUFqgsaKtC1S/E/xH0EqUpDks1E0E=;
        b=EDX7ep2ZCD/xAqcxjvbEoVB62ScqzhEqls+T7EBhJoxk9o6i60wjNCNBbg9MM9Y5dt
         5tZK64iOY56h/gbShs2qd2KoOIVHpdBDvm7xMdKFlqPbJc5Sm9PQLipCVyEhmux1JwRw
         6n1jgQklMR0IoqR+hHB4whSpsRrTpx02O6F7Bs8z4EoY0Wsr01pjKtSiqc8hISmKkaqi
         fBmmDl66UlIK/bm/sBxbQy0yjpKBP+daNlJY2TgWxPidvPtnhRshBt8DkjiS6e0vLLhA
         8ti3eHXFaWIMCGucMtPNJ3IZgLYmpcufOIhCnMkG1oMHNmOIvVpPpTn2H/WmnpQzSRrb
         AOGA==
X-Forwarded-Encrypted: i=1; AJvYcCWBpH25Yua/2yPZ00N+0cS+UNSkchH/om77viQBtoUX4dmoxYjIevBqiMVCqTKVCJAgxwbUc3Sd088AwRanPK4hRr9SNKRJp8ZU
X-Gm-Message-State: AOJu0Yzz4EKDZzz+n5Njz7YdiqQem6pou0IheUwwGh/hbolBA9H+fbHP
	bp5kPxrJqpvR1Mz7aRbz840wOlYRhZRKZ8jDJU8zb9QBnzEYElql1A/6l5WcpJI=
X-Google-Smtp-Source: AGHT+IF8WH4f1ycbtDoACQ5kxSxRbrCYYTVJnYwbt/UIAQoZGGCtScYr5OI1LKp7AivesPFCF2lJDg==
X-Received: by 2002:a05:6871:b2a:b0:260:26a2:68e8 with SMTP id 586e51a60fabf-2701c96f08bmr69838fac.4.1723742540830;
        Thu, 15 Aug 2024 10:22:20 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70ca66297d0sm345327a34.68.2024.08.15.10.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 10:22:20 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] iio: ABI: add missing calibbias attributes
Date: Thu, 15 Aug 2024 12:22:13 -0500
Message-ID: <20240815-iio-abi-calib-audit-v1-4-536b2fea8620@baylibre.com>
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

There are a number of calibbias and calibbias_available attributes that
are being used by various drivers that have not been documented yet.

This adds attributes found by searching the code for:

    BIT(IIO_CHAN_INFO_CALIBSCALE)

A couple of not quite alphabetical order attributes were moved while
touching this.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index da8096b04e14..345d58535dc9 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -523,13 +523,26 @@ Description:
 What:		/sys/bus/iio/devices/iio:deviceX/in_accel_x_calibbias
 What:		/sys/bus/iio/devices/iio:deviceX/in_accel_y_calibbias
 What:		/sys/bus/iio/devices/iio:deviceX/in_accel_z_calibbias
+What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltageY_i_calibbias
+What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltageY_q_calibbias
 What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_x_calibbias
 What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_y_calibbias
 What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_z_calibbias
+What:		/sys/bus/iio/devices/iio:deviceX/in_capacitance_calibbias
+What:		/sys/bus/iio/devices/iio:deviceX/in_illuminance_calibbias
 What:		/sys/bus/iio/devices/iio:deviceX/in_illuminance0_calibbias
-What:		/sys/bus/iio/devices/iio:deviceX/in_proximity0_calibbias
-What:		/sys/bus/iio/devices/iio:deviceX/in_pressureY_calibbias
+What:		/sys/bus/iio/devices/iio:deviceX/in_intensityY_calibbias
+What:		/sys/bus/iio/devices/iio:deviceX/in_magn_x_calibbias
+What:		/sys/bus/iio/devices/iio:deviceX/in_magn_y_calibbias
+What:		/sys/bus/iio/devices/iio:deviceX/in_magn_z_calibbias
 What:		/sys/bus/iio/devices/iio:deviceX/in_pressure_calibbias
+What:		/sys/bus/iio/devices/iio:deviceX/in_pressureY_calibbias
+What:		/sys/bus/iio/devices/iio:deviceX/in_proximity_calibbias
+What:		/sys/bus/iio/devices/iio:deviceX/in_proximity0_calibbias
+What:		/sys/bus/iio/devices/iio:deviceX/in_resistance_calibbias
+What:		/sys/bus/iio/devices/iio:deviceX/in_temp_calibbias
+What:		/sys/bus/iio/devices/iio:deviceX/out_currentY_calibbias
+What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_calibbias
 KernelVersion:	2.6.35
 Contact:	linux-iio@vger.kernel.org
 Description:
@@ -541,6 +554,9 @@ Description:
 
 What:		/sys/bus/iio/devices/iio:deviceX/in_accel_calibbias_available
 What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_calibbias_available
+What:		/sys/bus/iio/devices/iio:deviceX/in_temp_calibbias_available
+What:		/sys/bus/iio/devices/iio:deviceX/in_proximity_calibbias_available
+What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_calibbias_available
 KernelVersion:  5.8
 Contact:        linux-iio@vger.kernel.org
 Description:

-- 
2.43.0


