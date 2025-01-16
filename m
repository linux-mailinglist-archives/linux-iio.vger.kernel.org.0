Return-Path: <linux-iio+bounces-14400-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A45A13D3C
	for <lists+linux-iio@lfdr.de>; Thu, 16 Jan 2025 16:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 517097A30C5
	for <lists+linux-iio@lfdr.de>; Thu, 16 Jan 2025 15:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E03D22BAB3;
	Thu, 16 Jan 2025 15:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="KF1uh0hq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A8E22B590
	for <linux-iio@vger.kernel.org>; Thu, 16 Jan 2025 15:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737040014; cv=none; b=UkdImcOThDsB79EasyQNZFy1vjmw+ngxojf/LTrzGueoNwPHPl1rfkLzvI5Ofkgc+abkZcys8WJ9OuR9wSUAGPf62Cjy0ZUvITlCGH0JF+eaJAuP246VhhdLEy4zHG+c6Vmr5bHceMzGH5Vd3Cjl+JhUN4NgZSWbKaPOblXL+14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737040014; c=relaxed/simple;
	bh=OvMvpa5hJvjp4mkxfj0XCsyUfbH0TO5uL7Xwk9BXyfI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PVGGFSa5vRoKo4zfg0VikJ4JqN9zouoW2UEGEQ1LFtRCh2lSeiVovITXZVhylqT1wrwGx0dY01SGdTsv7MHz2RPvQv+kvVTL1YdtXdC2Vc9F2ECungdFr4HpReFHC7KCFnFHdCyRr4beHu1BPZNqxhKyOkaL4G0FX456flo/kU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=KF1uh0hq; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-436a39e4891so6809935e9.1
        for <linux-iio@vger.kernel.org>; Thu, 16 Jan 2025 07:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1737040008; x=1737644808; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bYmh0880XE2lLymcGq8FMdf3HLknZRQFCBrcBxm7rsc=;
        b=KF1uh0hqtYe2KxnOqJuJU35WovaY8KY7x+SzmiUQp7SclFS+0l08eO5pi+iOE08D2W
         BIlMBeWDPqvNOijMum3o60S4xwuIjFwGfFqqTMHGpPx7IZ4FKLop70owvx65JakNXrpE
         P3u9M6znnOKb4gW2AQFSE1AuiDI7XR3ofbf/u5j52SnfszDAgrPgeUfUvlavZE24G6JW
         q1vFeL7viEl2xW+guu7VbDjYhn3BfrcNoWP0EBgJMyyQVcKDAL60ZqN+j9dvETV4NZ2W
         pLVfsTqBG08a7T5QP6EmQzel5g9X+3xbHFuw1wea4Oj1M7d3HEYlhl9l+19CcXDxGJDA
         H8ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737040008; x=1737644808;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bYmh0880XE2lLymcGq8FMdf3HLknZRQFCBrcBxm7rsc=;
        b=wXtJ72Oo3N9UhL2GwjizwygJOKxj82DOnpSWzufjtaK/WFBQ2IVophmP6kONv796+j
         AxSX7JgKlZPsQbY+LowYIaQk6BESNTktugvgSjSVNhirBF0XFHQW7zPzJOuzCrhNP4Ai
         XOFzgy9yFh8hBXyrq5iRlvFzBexcThdx/jf3SMmbY3sIBBLzF/EDaZbbOlpvOXIvLFax
         6yDrP5c/pwIbrXeH4Q1ckNY1Jnc2M+LbuhbxBH13leo9BzkVPzrKYaS51K4cYmibFBIp
         PIDCZP4Z6x9zQ1qhDWClfTbME+ojAbXMbCzzKdPTROj1esctDPruUTyMLlTTP20P7rCM
         sFTA==
X-Gm-Message-State: AOJu0YxuuencemvH+r8c4JVq2kvr+opZEy+Q/5nJ0cHzltl+F9g+OAka
	6zMWub1+muw5s9T8P0/ok/H8QJ2qONWKrPMvM4tE9UKyc5T4fbVTVSAlU7ziHH0=
X-Gm-Gg: ASbGncva4wjlf+WsAtUIhd5lQMEzpp7IpLfSZ0Mxclkbx/dhIN++rIEUT6YYDfnQZmc
	agjq/kmPcG5ALBsPxjpnebBXuCVatnGNFV27XdrBqldnXSofKT+UIAnSnC7Wn/XsjZwyBTguLME
	8oC8faN04BSC8QOiH5lHjGXkzHpXF/ERtvA8qc7wQy4W0B6dq/GCX/8LtnbiWeMuZFh2T/xj/sZ
	65d+6K3Ucda5YC7K6Qo8bugLP7rMJ2Bxv0CJ6I0X7VgAk2EKFgpSjHnMa2c2OqM7/0N9IOmh1o3
	W1egcyliprv6YIYCrV3tGg/OKjA=
X-Google-Smtp-Source: AGHT+IHU27OYlDGXMzXBaKrU+DkQAHWS8+mLw8V3qTbihM+GrLtuH3Q/whk1TW3oyYUFbrFi53pf9A==
X-Received: by 2002:a05:600c:1c28:b0:434:a734:d268 with SMTP id 5b1f17b1804b1-436e2699dfbmr347566565e9.14.1737040008384;
        Thu, 16 Jan 2025 07:06:48 -0800 (PST)
Received: from [127.0.0.1] (alille-653-1-300-114.w90-1.abo.wanadoo.fr. [90.1.180.114])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43890408a66sm2199445e9.5.2025.01.16.07.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 07:06:47 -0800 (PST)
From: Guillaume Ranquet <granquet@baylibre.com>
Date: Thu, 16 Jan 2025 16:01:46 +0100
Subject: [PATCH RFC v3 1/2] iio: introduce the FAULT event type
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250116-ad4111_openwire-v3-1-ea9ebf29bd1d@baylibre.com>
References: <20250116-ad4111_openwire-v3-0-ea9ebf29bd1d@baylibre.com>
In-Reply-To: <20250116-ad4111_openwire-v3-0-ea9ebf29bd1d@baylibre.com>
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
index db06501b0e61a91e3b06345b418504803f4aefb5..ea3dcdc0b70a7b8d53281d92d9d3bacbc74638ba 100644
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
+	[IIO_EV_DIR_OPENWIRE] = "openwire",
 };
 
 static const char * const iio_ev_info_text[] = {
diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
index 12886d4465e4896aedce837c2df63c78f83a5496..ac0f5ee0bac4aa44577d7d772d3628a084f5c645 100644
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
+	IIO_EV_DIR_OPENWIRE,
 };
 
 #endif /* _UAPI_IIO_TYPES_H_ */
diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
index cccf62ea2b8f9b55a83a4960c1a60087c7b053f3..efa1807ab505a507f10aa2d314e03e40b71f62ba 100644
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
+	[IIO_EV_DIR_OPENWIRE] = "openwire",
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
+	case IIO_EV_DIR_OPENWIRE:
 	case IIO_EV_DIR_NONE:
 		break;
 	default:

-- 
2.47.1


