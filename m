Return-Path: <linux-iio+bounces-14057-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66BB5A0785D
	for <lists+linux-iio@lfdr.de>; Thu,  9 Jan 2025 15:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61F61167336
	for <lists+linux-iio@lfdr.de>; Thu,  9 Jan 2025 14:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C780E218ADB;
	Thu,  9 Jan 2025 14:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yoQlJMdl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7294219A98
	for <linux-iio@vger.kernel.org>; Thu,  9 Jan 2025 14:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736431226; cv=none; b=NuYKnfIUyIFXPm3wlXmuz6FF9DaAThYz1F3kqJ4pL7EmlhF5P8l4CO80olmcxOFOW87pjhM/Th5B2Zj30pF17pCp6Y3FpZcAYXRQRMvOdESKYj5qgiM7NaykAjwhfiF8432CfL0LyYoDJPVWgBBUQwqs58VHMq3uYN0s1HUNNlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736431226; c=relaxed/simple;
	bh=msF7ZQ5TwLZKSY+AvY4kKDZ5+MNVWNn9oSiMCyJto6U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cjtmmmq8Dkc/Xk7OTK9oTRgglvdfOX2bFk7/X35byplP2+PqmlE2KMHrLav7zCugCRWIlwhAbtg5hgOtiaWdgQeoXkdWN+gH1R5BY2/GEKp1Q0kkxkVNUNDlQ5yPH832t8wPr5ugsIu3I/Uj+L1NT6mLLzwURYMznRVzIMHLHvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=yoQlJMdl; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4362f61757fso10046115e9.2
        for <linux-iio@vger.kernel.org>; Thu, 09 Jan 2025 06:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736431222; x=1737036022; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GaMP7Ycz0SnL/MIwzVdYFCtGiyRNYX+puS9A82aJygo=;
        b=yoQlJMdlFoJ2h39iQLh73AkXN3VvTyEqgHG9gbh0I96+nwzUWxVGPYMhK+z1uwior4
         NGFPz7NF4g7OtqAf0ZsDK8R+k/jg+l8KV+jnl0t4M7oKWjjOPEYl+iSTinlvnXg2WHX6
         oYk+0dyxCj1HWYdOpYAIbA4+TTKqHgKhclC3llqcWv37uX8trpfcAuX6JzWV+EIDuzeZ
         9brQ/ahoxW8zqw+1qAUHU6wfF/9W3hBYyCCODPjSkHJrUhMEdes6GzoS+tWUpYkPykFb
         5q8MufrPlzK7riCjOJKhDf6BRaf3s4uLhO0f8GIWRJyh/tjKwDD3EztXP6f7Az+/8DGz
         W7wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736431222; x=1737036022;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GaMP7Ycz0SnL/MIwzVdYFCtGiyRNYX+puS9A82aJygo=;
        b=WLFEIWCkNCDTqSQ3vumbTGPDqv0rv8wz0EAKsZOBd6+Ryr3/WE/ZeKUSz0Xdru7w0K
         cQmdYDfe6H8tQQjVzC6Fe3JLrpfYhxJkPcFjTm4SPWfPPxDIlX4Z0s4AOkGSfvHNiTo/
         KxHPAVnqPFjpou5HLL1AUC/TC2ilSsiDEZdJrVfvnCxphF/v1wVOUnyaFHZtnTR9wxnf
         GR+PF9LCP+cCciZQ+kXHlrn+kyfqgzWVjJemdrJ3xLIk8dHJyiDQHVCMag9ru2WHA/AH
         JwNkZkVHXT4HxKhzXSxy79VEZYAaHK9gv2dBEsADREHaoQzuGXLATXjVDbz7LB5b3K+m
         1LzQ==
X-Gm-Message-State: AOJu0YzRtmP4dRe8taNBVzrVBvvI5194aIGKC7rfOO3MM2BjDLhDbWpE
	JdoJkASLWkk3Y0Z3fxt5oZpNpIyyojyF4TqwVr3DMS0a5Okx+ZeSh2NvIX3Ld6xDm0ss0gYKs3a
	b
X-Gm-Gg: ASbGncuSJCKgRbhhf6DGoTMYb1rjEkDqCu0JRxwQ45NBzvmpT7nKvtIkS8/ez1HVbnI
	SAQuGQytrFtKdH5XOyluSxM6cXqNQfST4s0tVtwxfC+6KlSQPbkvMErSNvjEMyZxXGQKG7eHla9
	ZAiryIk8cXEznCqenJ8fzuNCSpYcayNhT4I0Bhdf9HHt3927JYch1RbJ5zrJN7Vjw7BaYcXaOzh
	B8V6WP6OmEBDWK/zPvMoz2Uzld+bWHYTRJ0A78Y4M27yvsk4aW/cn291g==
X-Google-Smtp-Source: AGHT+IHLM2NACOxdwEbd7aC+2P2BbQ4P0+lDYKdMt5AJfAXUydD1Bs1690gbYBVW7V0mZQGykMaw9Q==
X-Received: by 2002:a05:6000:188c:b0:386:4a0d:bb23 with SMTP id ffacd0b85a97d-38a872d1238mr5494723f8f.11.1736431222181;
        Thu, 09 Jan 2025 06:00:22 -0800 (PST)
Received: from [127.0.0.1] ([82.66.159.240])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e38325esm1901507f8f.27.2025.01.09.06.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 06:00:21 -0800 (PST)
From: Guillaume Ranquet <granquet@baylibre.com>
Date: Thu, 09 Jan 2025 14:55:17 +0100
Subject: [PATCH RFC v2 1/2] iio: introduce the OPENWIRE event type
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250109-ad4111_openwire-v2-1-0372c2dde0ce@baylibre.com>
References: <20250109-ad4111_openwire-v2-0-0372c2dde0ce@baylibre.com>
In-Reply-To: <20250109-ad4111_openwire-v2-0-0372c2dde0ce@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Guillaume Ranquet <granquet@baylibre.com>
X-Mailer: b4 0.15-dev

Add a new event type to describe an hardware failure related to a
disconnected line on a sensor.

Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
---
 drivers/iio/industrialio-event.c | 1 +
 include/uapi/linux/iio/types.h   | 1 +
 tools/iio/iio_event_monitor.c    | 2 ++
 3 files changed, 4 insertions(+)

diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
index db06501b0e61a91e3b06345b418504803f4aefb5..a3a3e448bd9fe7f768db6a37d7ddd78402bec0c2 100644
--- a/drivers/iio/industrialio-event.c
+++ b/drivers/iio/industrialio-event.c
@@ -232,6 +232,7 @@ static const char * const iio_ev_type_text[] = {
 	[IIO_EV_TYPE_CHANGE] = "change",
 	[IIO_EV_TYPE_MAG_REFERENCED] = "mag_referenced",
 	[IIO_EV_TYPE_GESTURE] = "gesture",
+	[IIO_EV_TYPE_OPENWIRE] = "openwire",
 };
 
 static const char * const iio_ev_dir_text[] = {
diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
index 12886d4465e4896aedce837c2df63c78f83a5496..46a63a16a16e40f2cecd14f1db65a1a1ad7b3814 100644
--- a/include/uapi/linux/iio/types.h
+++ b/include/uapi/linux/iio/types.h
@@ -119,6 +119,7 @@ enum iio_event_type {
 	IIO_EV_TYPE_CHANGE,
 	IIO_EV_TYPE_MAG_REFERENCED,
 	IIO_EV_TYPE_GESTURE,
+	IIO_EV_TYPE_OPENWIRE,
 };
 
 enum iio_event_direction {
diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
index cccf62ea2b8f9b55a83a4960c1a60087c7b053f3..ee1bf4fe405f6c9e3619a990baa8c6347b80ca77 100644
--- a/tools/iio/iio_event_monitor.c
+++ b/tools/iio/iio_event_monitor.c
@@ -75,6 +75,7 @@ static const char * const iio_ev_type_text[] = {
 	[IIO_EV_TYPE_CHANGE] = "change",
 	[IIO_EV_TYPE_MAG_REFERENCED] = "mag_referenced",
 	[IIO_EV_TYPE_GESTURE] = "gesture",
+	[IIO_EV_TYPE_OPENWIRE] = "openwire",
 };
 
 static const char * const iio_ev_dir_text[] = {
@@ -249,6 +250,7 @@ static bool event_is_known(struct iio_event_data *event)
 	case IIO_EV_TYPE_MAG_ADAPTIVE:
 	case IIO_EV_TYPE_CHANGE:
 	case IIO_EV_TYPE_GESTURE:
+	case IIO_EV_TYPE_OPENWIRE:
 		break;
 	default:
 		return false;

-- 
2.47.1


