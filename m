Return-Path: <linux-iio+bounces-11121-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9B59AE694
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 15:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1FBC28B7F2
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 13:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C4E1E32C4;
	Thu, 24 Oct 2024 13:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="C2L0ccF8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AC61E201D
	for <linux-iio@vger.kernel.org>; Thu, 24 Oct 2024 13:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729776550; cv=none; b=d3yZY2hbfFEBIIyX8s9OvrXbAr6fc3rgK1PBp5wPnHUzYsN7hFucG0aaPgD+4t/6xP5WRl2hhlS110MIV1UMzFySyJjE6k2lMaNxIMUIUuw9lym/V/l6WIz1LNAcN0bnl1uqY8sGbKA0xaynk//2jmeRlymO/V1xWMRppXTaV5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729776550; c=relaxed/simple;
	bh=bFwyN+jEa2XvW5Q/VvqMtLqk9XXyDIBC0cTMCtFmW8I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rh43kAg6A+wNTMZLpboiyvv1Wi8SxkD6/C/tzF/zs40SKEMmknfiYgbb925unfSTuAc59nMkpshx7ViuU51Amt1TpQ2Yz+lbij6/TzxtoWTH9tfvpHHMSuna3sfau9QreCt6k7E4Rarz6v+LQX1elV7vlc5dRtnDXxoEijOeilc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=C2L0ccF8; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7ac83a98e5eso86417285a.0
        for <linux-iio@vger.kernel.org>; Thu, 24 Oct 2024 06:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729776548; x=1730381348; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zzgB0Dmc7SbGSRkZ42QPW9VmAklZSsdEpabG3evbtX4=;
        b=C2L0ccF89lMnCzO/lOABh9M2irnWtNlV01UNnDvwggDQWRVMbTuXginOlkd9tXDFYz
         jLADbOLpGsn4fEvcPOw1zPUFuRE5fwGkevfhGowXHdiCUXopCz9YPhdBDprM9Oj1j9CL
         NHSySKqLQdu8900ssc+GlEZ8O8iOJjy5PdHwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729776548; x=1730381348;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zzgB0Dmc7SbGSRkZ42QPW9VmAklZSsdEpabG3evbtX4=;
        b=ozfn9Sx8+acwrKEmFfiYDx+6m/wrSaNbAu06CmTZ++Vy13zw4F9ExeqVFc/dXU9Ocb
         L5KToOqn7VeztH4tG5LfLS+Pqrnm0R7Tr7M1IqWcOR0dQ9Y+mcL9qvo5HgplgfMBfLiV
         vhoJofvjEsMMONCS67k3QDBLdL0YLLDGHGO+N9q1KKoAZSx9uMH+85nu1H+az2hpVppp
         S4d6bWDYcXM19BaXMuQtYe4M+zg3CEvdjZ092FxFI4eW/RiCkj2DGnvyDTYnYvuEoavm
         yHpdy6ploRUFeuiIcRBgZERG1Met9PTpOVfW8uwpCmffnj7ZWMcj0eYqGAF3XR/OTVu4
         CcMw==
X-Forwarded-Encrypted: i=1; AJvYcCUSi7cuFhdyGkjjMRjKSaTg1eqwvFyhgPA3fINgrP0naVbm0bQDCAR0DebGNRUyeoTUS5UQM1iTTBM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHt6phgKjPDdCIATyE83ARWk9pPnvEBQl36n2RzLQ9j/vSt89k
	bpQBjb0XPeM/AaIn+jZLLLhups5VHAcFWTr/GFqlkBO/5p/eRzZEttaKhL1zow==
X-Google-Smtp-Source: AGHT+IHOq1CHjjVbrTOuW87w2sexGCJD7U4FXEseprlQ/Sd8ltK1U55/s300FMFOWnd7m15YHmBXEA==
X-Received: by 2002:a05:620a:4621:b0:7a9:aa9e:3a9a with SMTP id af79cd13be357-7b1865e2a18mr350813885a.18.1729776547888;
        Thu, 24 Oct 2024 06:29:07 -0700 (PDT)
Received: from denia.c.googlers.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b165a5d663sm484204885a.94.2024.10.24.06.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 06:29:07 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 24 Oct 2024 13:29:05 +0000
Subject: [PATCH 1/3] iio: hid-sensors: Add proximity and attention IDs
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241024-hpd-v1-1-2a125882f1f8@chromium.org>
References: <20241024-hpd-v1-0-2a125882f1f8@chromium.org>
In-Reply-To: <20241024-hpd-v1-0-2a125882f1f8@chromium.org>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 Lars-Peter Clausen <lars@metafoo.de>
Cc: Harvey Yang <chenghaoyang@google.com>, linux-input@vger.kernel.org, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

The HID Usage Table at https://usb.org/sites/default/files/hut1_5.pdf
reserves:

- 0x4b2 for Human Proximity Range
- 0x4bd for Human Attention Detected

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 include/linux/hid-sensor-ids.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/hid-sensor-ids.h b/include/linux/hid-sensor-ids.h
index 6730ee900ee1..8a03d9696b1c 100644
--- a/include/linux/hid-sensor-ids.h
+++ b/include/linux/hid-sensor-ids.h
@@ -30,6 +30,8 @@
 #define HID_USAGE_SENSOR_PROX                                   0x200011
 #define HID_USAGE_SENSOR_DATA_PRESENCE                          0x2004b0
 #define HID_USAGE_SENSOR_HUMAN_PRESENCE                         0x2004b1
+#define HID_USAGE_SENSOR_HUMAN_PROXIMITY                        0x2004b2
+#define HID_USAGE_SENSOR_HUMAN_ATTENTION                        0x2004bd
 
 /* Pressure (200031) */
 #define HID_USAGE_SENSOR_PRESSURE                               0x200031

-- 
2.47.0.163.g1226f6d8fa-goog


