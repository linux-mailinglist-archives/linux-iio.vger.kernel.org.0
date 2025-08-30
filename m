Return-Path: <linux-iio+bounces-23446-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79EACB3CAAD
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 13:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACF2D1BA36C7
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 11:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F117B27A10C;
	Sat, 30 Aug 2025 11:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="knDuW6yE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38079279DB5;
	Sat, 30 Aug 2025 11:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756555110; cv=none; b=LCtmOyu8TuKVx1Y4fbHOfR8cQb9Goi8suJFO0VLNmy5wxs4YCYO63gLGYjj0s9HUkXx1OZqqnPPWbdboDx2B9M/cmEe6RCd38aZh/M7ZEiaRjdjmTwZJKWHEK4FrnEEP9euztwBixqcoWLr9knJdqIwSuxPd2wa2uPerauIkrkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756555110; c=relaxed/simple;
	bh=mNoRtcB3OGrPNEtr1pdls19fEhZqwwrGnXwV7ZT3+7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W0WnvCAZZLD0AgzZPVd/GQvKjIKhALA8DBvXY8rsZLIJmBDL7PWViRNaWZvS/FcK3/DPWqfMnIZwqvAUUl3mgT2c7+35f8ObQ6yJDAToQKwjRMmlaNpfGRq9aWRZJHS3WVLWJh5S0oQPb87UWBxX2LbasUiFyrps+LLWhTaVUTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=knDuW6yE; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-244582738b5so26269205ad.3;
        Sat, 30 Aug 2025 04:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756555107; x=1757159907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9+oo756Tjry6BEfzGrRDKCtR92eHwxg4+Z/uBbl5WX4=;
        b=knDuW6yE7tusKhNFoJzErAG/sGZlZ2oJutoh/l5Acg0IzC5Behl4lBD4r6d5mFcBmg
         gNEkIYCNQxUOMADnIlxUcyqMQi9BnniVMPmZZ4LtCd28XZNj9DcVICvmys9vQ8GYVRKb
         kd0lKEwZlpy0KlSUoOvOrbmgSTqcwTqXP6d3YS60yc4QvzoaEPsMUlX/necGsuBbrCft
         M1AuYfS7nVmuFosj9dDXbfcnVmowS+13VYFd3Gu+F5hDx+++CFSj1AFJZNYrAiL6VOp4
         sndewATxQPppiZtqsl/1LIvAyuFRHQQ5rYFNSNHfYxK+TFsPjx0jzWfXhzHeL7l6JR5Y
         eX7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756555107; x=1757159907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9+oo756Tjry6BEfzGrRDKCtR92eHwxg4+Z/uBbl5WX4=;
        b=MmMysjgFuH/gUocnG+sPBtrn+EJauJGZwVvHuXnCkrX4LTUaO2hhTR8wVFilkpO9to
         hJcv29WZCZ1yfuEpa1RtQbqo7kCvDW12KML+LREaljzKM17b6XU2NK6e1dleL4lCvQ6r
         xvGvlFTc87djDhXvCWmKl+aqWIm1Deq0a4XR+jr8x0fvo9CZAqGNt/tzDgJ/z5FGMnkS
         WK28dq78XaQvHHY5s4XYJHCbp6TyiWZcxQGtp3lboFxGh+atVlh0X1yiMhYRQyhOuRId
         A9kSo+/WO1c9C+SLyqyw2tPbFxFrhMMC7z5vf3/+RcXwO9t5BrTmwG8leeXymHVpqwc2
         QTgg==
X-Forwarded-Encrypted: i=1; AJvYcCU0ITU5KXwYchspN4fdzdJP0Mz4daLzrSw9t8cjXZxRRbXT0xwDy31i3JdUMv5YmjBgyFHFRQQao20=@vger.kernel.org, AJvYcCXOJgcm5sn6KXYoFPvBkfCVbTSl5yeh/hsJoFeGY+Kn5rXetN5QHUnSvYL/Wme2jx7Ln0mXsup4KoEUz8xl@vger.kernel.org
X-Gm-Message-State: AOJu0YxoH+hysZJbJYKSvWBPkgnXucjtW9LxZgWz5sYHa6q7Cu/Ghioa
	08QApui+WPnLQdWb9S/xp68dnGhapF/vwzkX579P34qBSqg7Ek4qHxh1
X-Gm-Gg: ASbGncuZMZp/6ui3Z0IZtQNRw9xGRm3xLgJOrhFJzvXK80t19frtUpKucKKqZZ4DGwi
	OLNRsmHY9v6gdCXn9SAGYaO97ylAn3QbI1BTlyLLDOxxPPyA3Z/gaf23Wqrbqsljan/TG91i8Sp
	z+cvzRtJjIbv4qR7h8wePZ66sda2v898XOyJndiL4gvN2ICBxCH6TpFpYhpvyFXAgQz5UTIDe/Q
	+xDuKbf4VqKZBTCFIJkbAjJRiV1qxlyeY3pXHND6DvPAtEcrQwo90ox7zupvvvPc3h3QYIN26mI
	GLd0sIy+knPm1lWBJxatXeCkAhfmDCwIqSpmoK2smxu8lOR2lrffn92+4G9xu7Ld5dg2zAsGZGe
	m0lrfP/y5OC0TjLizz8SGVwhDsWZkiiRmdHmcAA==
X-Google-Smtp-Source: AGHT+IFGu/glniWHq9N0WKQhxbIcV+DGUmahTiEpkIcc6NEqQfvlBU+hO4voI5Y7r93zOQNLmg333Q==
X-Received: by 2002:a17:902:f789:b0:249:2789:4110 with SMTP id d9443c01a7336-24944890abfmr22539435ad.10.1756555107347;
        Sat, 30 Aug 2025 04:58:27 -0700 (PDT)
Received: from archlinux ([2804:14d:90a8:4498:a747:8dce:6184:1430])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24906390b55sm50966595ad.97.2025.08.30.04.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 04:58:26 -0700 (PDT)
From: Gustavo Silva <gustavograzs@gmail.com>
To: lanzano.alex@gmail.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: Gustavo Silva <gustavograzs@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 4/4] iio: ABI: document accel and roc event attributes
Date: Sat, 30 Aug 2025 08:58:57 -0300
Message-ID: <20250830115858.21477-3-gustavograzs@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250830115858.21477-1-gustavograzs@gmail.com>
References: <20250830115858.21477-1-gustavograzs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add accelerometer and rate of change event-related sysfs attributes
exposed by the bmi270 driver.

Signed-off-by: Gustavo Silva <gustavograzs@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 40 +++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 2fb2cea4b192..75a88f0dc533 100644
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
@@ -1129,6 +1130,7 @@ Description:
 		will get activated once in_voltage0_raw goes above 1200 and will become
 		deactivated again once the value falls below 1150.
 
+What:		/sys/.../events/in_accel_roc_rising_value
 What:		/sys/.../events/in_accel_x_raw_roc_rising_value
 What:		/sys/.../events/in_accel_x_raw_roc_falling_value
 What:		/sys/.../events/in_accel_y_raw_roc_rising_value
@@ -1177,6 +1179,7 @@ Description:
 
 What:		/sys/.../events/in_accel_x_thresh_rising_period
 What:		/sys/.../events/in_accel_x_thresh_falling_period
+What:		/sys/.../events/in_accel_roc_rising_period
 What:		/sys/.../events/in_accel_x_roc_rising_period
 What:		/sys/.../events/in_accel_x_roc_falling_period
 What:		/sys/.../events/in_accel_y_thresh_rising_period
@@ -1187,6 +1190,7 @@ What:		/sys/.../events/in_accel_z_thresh_rising_period
 What:		/sys/.../events/in_accel_z_thresh_falling_period
 What:		/sys/.../events/in_accel_z_roc_rising_period
 What:		/sys/.../events/in_accel_z_roc_falling_period
+What:		/sys/.../events/in_accel_mag_adaptive_rising_period
 What:		/sys/.../events/in_anglvel_x_thresh_rising_period
 What:		/sys/.../events/in_anglvel_x_thresh_falling_period
 What:		/sys/.../events/in_anglvel_x_roc_rising_period
@@ -1344,6 +1348,23 @@ Description:
 		number or direction is not specified, applies to all channels of
 		this type.
 
+What:		/sys/.../iio:deviceX/events/in_accel_x_mag_adaptive_rising_en
+What:		/sys/.../iio:deviceX/events/in_accel_y_mag_adaptive_rising_en
+What:		/sys/.../iio:deviceX/events/in_accel_z_mag_adaptive_rising_en
+KernelVersion:	2.6.37
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Similar to in_accel_x_thresh[_rising|_falling]_en, but here the
+		adaptive magnitude of the channel is compared to the threshold.
+
+What:		/sys/.../events/in_accel_mag_adaptive_rising_value
+KernelVersion:	2.6.37
+Contact:	linux-iio@vger.kernel.org
+Description:
+		The value to which the reference adaptive magnitude of the channel is
+		compared. If the axis is not specified, it applies to all channels
+		of this type.
+
 What:		/sys/.../iio:deviceX/events/in_accel_mag_referenced_en
 What:		/sys/.../iio:deviceX/events/in_accel_mag_referenced_rising_en
 What:		/sys/.../iio:deviceX/events/in_accel_mag_referenced_falling_en
@@ -2386,3 +2407,22 @@ Description:
 		Value representing the user's attention to the system expressed
 		in units as percentage. This usually means if the user is
 		looking at the screen or not.
+
+What:		/sys/.../events/in_accel_value_available
+KernelVersion:	6.18
+Contact:	linux-iio@vger.kernel.org
+Description:
+		List of available acceleration threshold values that can be
+		configured for event generation. Units after application of
+		scale and offset are m/s^2. Expressed as:
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


