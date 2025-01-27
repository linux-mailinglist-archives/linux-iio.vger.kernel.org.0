Return-Path: <linux-iio+bounces-14610-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FCE1A1D7B0
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jan 2025 15:05:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 500A018867EA
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jan 2025 14:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C051FF7D8;
	Mon, 27 Jan 2025 14:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="xBkPRinv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404FD3FC7
	for <linux-iio@vger.kernel.org>; Mon, 27 Jan 2025 14:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737986696; cv=none; b=lpM2E7RDEBAnLQVmQrT6AlnFn6AzruAJd8rS0PSo2slLRX+FycNj9S+QmLdIK36KaRwW+jZHvJyVVEdrtMez32YVX4LTwdrgt9NzwyB40j06FHd+i0K7MoeKNsBefBHe3a+tRZWgJ3iOJInveP06al1pZ9ePQjT/3QxYyKh0MtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737986696; c=relaxed/simple;
	bh=UpHNkBI+znuAR7QFzUQVnchxDjBRHfzjxtWP5dwdcCA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IqAHc7iY3W6fRsGc5Mk1Q0fyM9rsEjyYcQfd8MnZoRnZ8gEh4oMjzkQbU+e+yARPZzpbdyKsmasx1ggXc6DcuzqTn0/ssIFTluBDUUo9ZnT0rA4xkXhLB/baGjxFZ9iirxkntqJKq2e5eIrwUshAy9Nqr3+BZ+KQhwa4/8udXls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=xBkPRinv; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-38634c35129so4111460f8f.3
        for <linux-iio@vger.kernel.org>; Mon, 27 Jan 2025 06:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1737986691; x=1738591491; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iNC2vjMhon2bW9VLQSkA9jwR9CGK+U2zRjC3qRDo0Bc=;
        b=xBkPRinv3Bi4yu9UlbFpnqn5Ud2YsOs7RltIrKzwW0yRX/wKh4sYtSCFCoVlAg9kGi
         UpuMRyOqt5JVB/VG10OCGCWeLs0hFNrcipkEnRC1qxA3dp5bKY6tLBPPOUK7UmYQ+V1m
         EM2u6pl33GzVR6DVaAZ9Fkt/pqT2ZCyG2jUKW8Rz/XJhazUfdSXtHYe/eVtXuFJQ5UJa
         t4N+L716ioPjcXnAjJSHlCDUWJ+H0II8F9p9Ycjw2xQ7VGFjnkWFd+Li22pYamLN5ASl
         4XoBDa1cR6VoGcniUB0DAbuI9P/nPjztiQg/RP8MN7T4fNrWx8m3S+XQoPwNSYo8Q6++
         emLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737986691; x=1738591491;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iNC2vjMhon2bW9VLQSkA9jwR9CGK+U2zRjC3qRDo0Bc=;
        b=Fh9NAfHptvCr5W4HHa+Oh262ycEQqCer4DyJB4hJIhqtNAUqnUKttdDUxQlEfit+HW
         u90XUy7MQEvGHYvlfv8DbToYLYIAGMDXhbDWJhyrQvVT7Ww3rcJjuXog8EPK3PXSkchH
         G5NqzIskKuXtyURzNpxugdeKu22pHVLSMlhl2wa3GsN9VfGDBcC3j6S8ah6n1RsYdUpJ
         SP3P5itrINYZf/M2icfhJBn/KCDDXbN12KvtSPOHSCQhEWtru1U2I4ubSldbWRR+AaXC
         07nc39H9H7VI5kiPgtHsNiKmbm6U9jEUKZa3i8LOYW01XSbJqmOA15bjFeGekxye9E3K
         N2/Q==
X-Gm-Message-State: AOJu0YwCZacp4/i5gF4Gu0IL7F0uZIiwcUiVeW5sqpMpj3O8gjzKvsMT
	N0IWdhn93VUsnWepUzk6mYjCiTBokRULi+RprvuBnAxnvkv3liSYUoNc0di0rhQ=
X-Gm-Gg: ASbGncuxjNgZF6qLsQRU007JLEwoQiTGNR67zTqM3VIqZdWWNc4iXAo5SF6SiXGiF/X
	cVxKOtW9SoPM0AdH164zu/CqLpJ+u42c4zyCmHlY3AvVdf41CGrvGKgKxZKbUC6mw2AdDWwNt5S
	2V7NQeKq6o2Qs4jnoOP/xPkwRxHQgM+vRkcRQWSXfbM47eyJmnOFnrLhvo7644cIIxPyrmKUj+I
	9pgFUkPUT3Ra3SSJ+vq6zjEzOsDNjLeaj3pfCKMOctwJ7AdYYrQFkGQokpZ52LRWLMdKyir48BQ
	I2ghy4xFKt2y6BlJUeADi2GwIiY0d5mYisiKQPrUiKgguqsZFEE=
X-Google-Smtp-Source: AGHT+IGGBWanpFTeP02UHs/S3DLKjDqcOFx6yfwE/ZiViqDo1Y06YNnMhn9DsKK+yDK9DAhTq8qC9w==
X-Received: by 2002:adf:edcc:0:b0:385:f44a:a3b with SMTP id ffacd0b85a97d-38bf58e872dmr30759883f8f.41.1737986691499;
        Mon, 27 Jan 2025 06:04:51 -0800 (PST)
Received: from [127.0.0.1] (alille-653-1-300-114.w90-1.abo.wanadoo.fr. [90.1.180.114])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a313383sm11480639f8f.36.2025.01.27.06.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 06:04:50 -0800 (PST)
From: Guillaume Ranquet <granquet@baylibre.com>
Date: Mon, 27 Jan 2025 14:59:32 +0100
Subject: [PATCH v5 1/2] iio: introduce the FAULT event type
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250127-ad4111_openwire-v5-1-ef2db05c384f@baylibre.com>
References: <20250127-ad4111_openwire-v5-0-ef2db05c384f@baylibre.com>
In-Reply-To: <20250127-ad4111_openwire-v5-0-ef2db05c384f@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Guillaume Ranquet <granquet@baylibre.com>, Nuno Sa <nuno.sa@analog.com>
X-Mailer: b4 0.15-dev

Add a new event type to describe an hardware failure.

Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
---
 drivers/iio/industrialio-event.c | 2 ++
 include/uapi/linux/iio/types.h   | 2 ++
 tools/iio/iio_event_monitor.c    | 4 ++++
 3 files changed, 8 insertions(+)

diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
index db06501b0e61..06295cfc2da8 100644
--- a/drivers/iio/industrialio-event.c
+++ b/drivers/iio/industrialio-event.c
@@ -232,6 +232,7 @@ static const char * const iio_ev_type_text[] = {
 	[IIO_EV_TYPE_CHANGE] = "change",
 	[IIO_EV_TYPE_MAG_REFERENCED] = "mag_referenced",
 	[IIO_EV_TYPE_GESTURE] = "gesture",
+	[IIO_EV_TYPE_FAULT] = "fault",
 };
 
 static const char * const iio_ev_dir_text[] = {
@@ -240,6 +241,7 @@ static const char * const iio_ev_dir_text[] = {
 	[IIO_EV_DIR_FALLING] = "falling",
 	[IIO_EV_DIR_SINGLETAP] = "singletap",
 	[IIO_EV_DIR_DOUBLETAP] = "doubletap",
+	[IIO_EV_DIR_FAULT_OPENWIRE] = "openwire",
 };
 
 static const char * const iio_ev_info_text[] = {
diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
index 12886d4465e4..3eb0821af7a4 100644
--- a/include/uapi/linux/iio/types.h
+++ b/include/uapi/linux/iio/types.h
@@ -119,6 +119,7 @@ enum iio_event_type {
 	IIO_EV_TYPE_CHANGE,
 	IIO_EV_TYPE_MAG_REFERENCED,
 	IIO_EV_TYPE_GESTURE,
+	IIO_EV_TYPE_FAULT,
 };
 
 enum iio_event_direction {
@@ -128,6 +129,7 @@ enum iio_event_direction {
 	IIO_EV_DIR_NONE,
 	IIO_EV_DIR_SINGLETAP,
 	IIO_EV_DIR_DOUBLETAP,
+	IIO_EV_DIR_FAULT_OPENWIRE,
 };
 
 #endif /* _UAPI_IIO_TYPES_H_ */
diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
index cccf62ea2b8f..eab7b082f19d 100644
--- a/tools/iio/iio_event_monitor.c
+++ b/tools/iio/iio_event_monitor.c
@@ -75,6 +75,7 @@ static const char * const iio_ev_type_text[] = {
 	[IIO_EV_TYPE_CHANGE] = "change",
 	[IIO_EV_TYPE_MAG_REFERENCED] = "mag_referenced",
 	[IIO_EV_TYPE_GESTURE] = "gesture",
+	[IIO_EV_TYPE_FAULT] = "fault",
 };
 
 static const char * const iio_ev_dir_text[] = {
@@ -83,6 +84,7 @@ static const char * const iio_ev_dir_text[] = {
 	[IIO_EV_DIR_FALLING] = "falling",
 	[IIO_EV_DIR_SINGLETAP] = "singletap",
 	[IIO_EV_DIR_DOUBLETAP] = "doubletap",
+	[IIO_EV_DIR_FAULT_OPENWIRE] = "openwire",
 };
 
 static const char * const iio_modifier_names[] = {
@@ -249,6 +251,7 @@ static bool event_is_known(struct iio_event_data *event)
 	case IIO_EV_TYPE_MAG_ADAPTIVE:
 	case IIO_EV_TYPE_CHANGE:
 	case IIO_EV_TYPE_GESTURE:
+	case IIO_EV_TYPE_FAULT:
 		break;
 	default:
 		return false;
@@ -260,6 +263,7 @@ static bool event_is_known(struct iio_event_data *event)
 	case IIO_EV_DIR_FALLING:
 	case IIO_EV_DIR_SINGLETAP:
 	case IIO_EV_DIR_DOUBLETAP:
+	case IIO_EV_DIR_FAULT_OPENWIRE:
 	case IIO_EV_DIR_NONE:
 		break;
 	default:

-- 
2.47.1


