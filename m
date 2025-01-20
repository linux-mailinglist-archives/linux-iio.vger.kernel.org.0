Return-Path: <linux-iio+bounces-14502-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64FE3A16E3B
	for <lists+linux-iio@lfdr.de>; Mon, 20 Jan 2025 15:15:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D96351889AF4
	for <lists+linux-iio@lfdr.de>; Mon, 20 Jan 2025 14:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067E11E32D4;
	Mon, 20 Jan 2025 14:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="CATZ732A"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0C7383A2
	for <linux-iio@vger.kernel.org>; Mon, 20 Jan 2025 14:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737382538; cv=none; b=ZYHgOZMVMxVL4xjd6t51tkknwj6XUc6iO63jYyf4x3rgSdsr/xVYbSSXkWZi/oadvXHkmb47JU05wWQfy0FZ/4x4+BTC0nwXsQq5RYzmopaTnTlJMKdRruJfbR9PIxBdFeYtdbsKDj6YeAplIac1qRib6TcyINy6q2iRbX2bwVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737382538; c=relaxed/simple;
	bh=Woe2IAahMXYWwHMcFlq9Zlh3hNuvAt2QB1RNA+l2Ar0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lf7IMdALOu8L+tx9Lf/YB9IGx6GUqOvK16S72pcWNOto5W1XQrFOZWlLepNTHlOp9ozNwbaeOUS/mc5Ojvuw3eeGmofMTglNxHB+Q6B1/4J9hBhbVxKPITN4W27D+PmMoqtY+otejAnO6+j4SUsAgxc0whwbUlCIm4R/Qc90js0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=CATZ732A; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-438a3216fc2so17874785e9.1
        for <linux-iio@vger.kernel.org>; Mon, 20 Jan 2025 06:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1737382535; x=1737987335; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xm4PTSA03b/yfa5uLtvcLZnr4Rze+iALf1YYnoU52r0=;
        b=CATZ732AoWdpupBPvZPEFKFOCI+P5ooon/jWh6rgsu1CmiA6qUmRZqDNU2xfaHSDqc
         M5pgQOZ6xJFjrLiXhMt2NTjRtjXt/vRqfoP5PY1COP1ljVzs4YKRLA8el0v9yUMK8rpH
         CQDkviaprsB/lri2AVu2rsxvcOFb0s1AmrujHEdkdJbW+kzIX3/mrNlB9ag1KKKS6Jy+
         AB6+NDuC98VtQZALkWrNuOjbpao6Y8y1OEGfznf3WwqLDULLsxuclQQn4+JzNkyZSeBg
         cSl/ak+RQRsjvjaEUWx9xoPX+6uLaUfyVdrbYO4EXuV+or8uhXR0aqxawl9P46VWuRFk
         77UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737382535; x=1737987335;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xm4PTSA03b/yfa5uLtvcLZnr4Rze+iALf1YYnoU52r0=;
        b=JmD92uXYxQgmXwknd7OY2xR0v07p0qKVQ3chqnYqTSxySJDncwBwzElvowVpLBS3eY
         DzfTb+ntrfwWpkw9cxAbw2MYI2ESL+v+vgwFpnN984S2cKvp0tX5shcf/wUD+is9Wm6t
         ZRwL/CtBey12X+Nd60CKcJq/FdPu0E0F+a2nKfJZfrYQhYJBRtKw1x9FLO2KGsM5tdey
         Gx2a/0S6hDnpm0i8kSLhSicaejpy6XXFKLyAsRjlqsfQ/XvfnC0g7Ch8nXCSqM97XjUy
         r/qjm5Ng18uoH6idWUtL+VCMG0jKqY6caIn6M3Q+TvhZolK2NGFAiKi3Jir0fpwEYAeY
         2xIw==
X-Gm-Message-State: AOJu0YzMFNMRZcIMDCb/h5lznl8dJlKgoD4hRbw2GYkxrQH2MvXcykfK
	th4qvd1EK1KUnvyxFsgoyZFH/Fn4fxK9wvdk21xiecJ6Dlere8j+OFymS6PC2U0=
X-Gm-Gg: ASbGnctVjpv7WLruviiPUu/xUM5XuvgNNug8Imghrs9QXLGS4R0VR1ZRDPKl92norks
	D7v1ZYaAQ+zCAsm+LRqZq+9KxXGaF3UkonXkyklR98eAsm5ZTcXOmGIHoiNNaJJBe6acTmHS5A7
	zlNUjTfXtWprsOLiBCM3bzRYiKyqa+tePWnFv6td4ag/eBDwJkiVvtrCDtto6c0/PhnnKoNnONd
	FsqgU1COOCipsGOn87ZI03bIkduJhTe8ZaGOSC2SYAjcEmyAw6ZjEbsWY2kf1f5ihgaQv2gFLG7
	JCVnBYDBR1eKULl0aivWrein2v2Osmr3ar/k7YWb
X-Google-Smtp-Source: AGHT+IGhRbvIXuL2ofFdmiNf7PtYX2OTJkrUe1eKdTjCaM0ZrjiEzhFjxCCCfNBCBJ+OpCnMkM87xQ==
X-Received: by 2002:a05:600c:3593:b0:431:5632:448b with SMTP id 5b1f17b1804b1-4389144eed4mr106238045e9.25.1737382535033;
        Mon, 20 Jan 2025 06:15:35 -0800 (PST)
Received: from [127.0.0.1] (alille-653-1-300-114.w90-1.abo.wanadoo.fr. [90.1.180.114])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438904621cdsm141233345e9.27.2025.01.20.06.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 06:15:34 -0800 (PST)
From: Guillaume Ranquet <granquet@baylibre.com>
Date: Mon, 20 Jan 2025 15:10:06 +0100
Subject: [PATCH v4 1/2] iio: introduce the FAULT event type
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250120-ad4111_openwire-v4-1-e647835dbe62@baylibre.com>
References: <20250120-ad4111_openwire-v4-0-e647835dbe62@baylibre.com>
In-Reply-To: <20250120-ad4111_openwire-v4-0-e647835dbe62@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Guillaume Ranquet <granquet@baylibre.com>
X-Mailer: b4 0.15-dev

Add a new event type to describe an hardware failure.

Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
---
 drivers/iio/industrialio-event.c | 2 ++
 include/uapi/linux/iio/types.h   | 2 ++
 tools/iio/iio_event_monitor.c    | 4 ++++
 3 files changed, 8 insertions(+)

diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
index db06501b0e61a91e3b06345b418504803f4aefb5..06295cfc2da8b1df17061cf58ade38d88020359e 100644
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
index 12886d4465e4896aedce837c2df63c78f83a5496..3eb0821af7a40e29544fbcc67c48e085507e13d0 100644
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
index cccf62ea2b8f9b55a83a4960c1a60087c7b053f3..eab7b082f19db8703aca55af7dbf4f1d624aa3af 100644
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


