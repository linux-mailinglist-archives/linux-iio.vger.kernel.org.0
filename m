Return-Path: <linux-iio+bounces-21066-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7AB1AEC946
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 19:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12A8B178AC5
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 17:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04AEC25F992;
	Sat, 28 Jun 2025 17:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="wcS2RWTw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE21155CB3
	for <linux-iio@vger.kernel.org>; Sat, 28 Jun 2025 17:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751130576; cv=none; b=dbBv5pJqkUVra2x5PnjLrK43chuhWpnS2yeWKd7YA+nIVTZMGiOkBJ/53dwSAp6Xmv/Oh6GZZ+1Ef0FGL4i+gTBqV91dBvn16b+hLqnsm9e/mtCxZgvrdVEQn6PpOB9DrWj/rp3u2kP7WF4QEROdWxoqxy5kV0ZDOWCxy4dtRRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751130576; c=relaxed/simple;
	bh=1KNuDVWaCyOz/P4MO1S4kStPPU3NA/f7Vmvt7em6yGs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=OPmC43uC14UgnGXoTcsuJkUnsTFR5vJbTUEDT6hEt5tqKr79pVpHAylbQroE7L33pPCqS8VVsb5iTsLUYPhenwY2nsut5Y6zYKNx5NZKUeURVJU04LgDS/x1wNK08eBeF+QpzwrG+IzK99FdVpqD6QPc3gAgOYQkCAiKpvi1x7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=wcS2RWTw; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6113f0cafb2so449139eaf.1
        for <linux-iio@vger.kernel.org>; Sat, 28 Jun 2025 10:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751130574; x=1751735374; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2YlrWgTRiRj8fPqf437+eL+u6Wuu8WHCApJJ9YXT3QI=;
        b=wcS2RWTwvT+WgJLRYeb3ZPJAmaWtC35616pXvOjY10x33qVGy4ZseHhKpfJCge6o6I
         8MM0otj7CuLV6MnYdszhN2PRk9JO9iOmbeLFuarT7+ynnQ9kDLFXAcW6/vGk22KHt/lg
         ZuJ8ju+4QUr0RoEWbLyIsbhceIcmpe4BQiqhhl/bxIO7X84PAyqPNWxy3fC9B7778rdK
         EUErSfdHEQQr9p73AelPBCCyviQtu2uGrvQX/DtMc6GgmT5oL9it4I8n6Ngt4hUC1D4K
         KeOLbsc7UxN2A+Yo8bSl1ng4CxoXTCR0sO/oWk2Yrev2S8xTyek5bEYHYBAou+tVPLYG
         NR0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751130574; x=1751735374;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2YlrWgTRiRj8fPqf437+eL+u6Wuu8WHCApJJ9YXT3QI=;
        b=RdBoQNHhMznoXRqqx1Zgsl1adRwk85w/3OHbpzNPoHqCSVC9eMDGlS7iglsxe1GC0k
         hDIyeDFAjpootCfH2gIpYopPoE7Y0rvtZb6YzDK9lstJBm+F/JZUszNdKpgDe+gwzgyi
         uZkpHYsUYoh99DZ8sseWDUKgM2ptT71yayEOxIHruhQHty3EEE0B93TY9Xw6Wmv60Ftq
         pQjBRjdKWgHJnACiTpbl4pKNOGwVwi04IpgkIiuWZt+Cy2qeHMa+BKwWHUDzPbhyJDs/
         bSe2Vvpyi9FJXkksNY33WeseshrOlDobQfWk3QYO+NIs6aJGb3s6bQZjOeI9+Igw9dKZ
         320g==
X-Gm-Message-State: AOJu0YydvmqnHDy7VfmIxRpxT/8F+S4/5d95xXULiUGdFV06qaYJQXe5
	fwMjaUgUbR7osvPTDdybQIug97AYVJHvLZoS9pm9L+jW0MZ9QTeWCDP3X/TMfdaEINg=
X-Gm-Gg: ASbGnctsjXnzifTeYYVzmxQ23Tf+UmF3VzfsmGGZwE387f6+gSfWJuw9/K3iAvUYbZQ
	+p1ix2Ll3xQsRs0PHnK4ONcISYZhlqjjPJb7vkajBsIOLkHjWWIi5IF9YsYKpxJBKVY8kVyE4bc
	uK0O3jFOPfCr6kUem5Wb0P75jVG2qhD/lvLWrJ7NtFpRRqT1FwdPMNTu/4fbH9/oSo6qX9XMGd/
	lsad0rHnr36xnc9KiEIBeBpbCzx2WScyznT5Xn3d1HTAw9afvhy9bo1A+X1RAuG2mCt0eFmxCDp
	RgK218ZruDPbw2SGPRqlIlFIL+Ok+2C/us2dLEE0NmDLaeFruTz43y8sdNEkZMR/iXqW
X-Google-Smtp-Source: AGHT+IGB0euxoQ6mW2ozZc4Vi6qheiUivTEG6Vn62CJ3QfLZcik/VChd0F2pkQo+LxvlQSBtZwKSJg==
X-Received: by 2002:a05:6820:1f10:b0:611:31a:6ff5 with SMTP id 006d021491bc7-611b9171be6mr5622294eaf.7.1751130574257;
        Sat, 28 Jun 2025 10:09:34 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:3092:a48c:b0c6:cbf4])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-611b85a2579sm604341eaf.33.2025.06.28.10.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jun 2025 10:09:33 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Sat, 28 Jun 2025 12:09:26 -0500
Subject: [PATCH] iio: common: hid-sensor-attributes: make unit_conversion
 const
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250628-iio-const-data-14-v1-1-4faa8015e122@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAMUhYGgC/x2MywqAIBAAfyX23MJqT/qV6GC51l40NCKQ/j3pO
 AwzGRJH4QRTlSHyLUmCL6DqCrbD+J1RbGHQpDvq9YgiAbfg04XWXAZVi2tTFBORcQOU7ozs5Pm
 f8/K+HxOJGH9jAAAA
X-Change-ID: 20250628-iio-const-data-14-b3250e000af7
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1048; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=1KNuDVWaCyOz/P4MO1S4kStPPU3NA/f7Vmvt7em6yGs=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoYCHG6klvWKejif42jAhakRTvI/VVHXgoSlPvJ
 DxPUINXIfWJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaGAhxgAKCRDCzCAB/wGP
 wLQ7B/9UWF9xz0RNOerT6WAbZyVYiZhutjZaE6DwdZlCZb/xP3KzOli54XwddNuVWAGazk7s9Zk
 Ff4FnVfL2yRi6pdERlVsadwxw2DwEMY+ANZvNgXbpHXzyd2cTyRa4P1ikwIdNvBqpLQVI7Sjp0w
 0zMVPl4SM3V7KKtxPpKpDP/kRzkjs7dD8xh+7I1vcvtjvYV75L1gc0IhIOLAu/L+DSQD2n+Bz38
 pPnd5k1RKbLkykWE5x2fgxYStvsexoZ1BaPUFrJ0OGsRPIBc0xlEqFngOEe1Bt06wGFU5AN7nIJ
 zD3Qo1mYC8cORpuPrNgfSbpxL2yvNsmvamgH8VQ8pRdGak+3
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add const qualifier to struct unit_conversion[]. This is read-only data
so it can be made const.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/common/hid-sensors/hid-sensor-attributes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
index 2055a03cbeb187743e687c2ce3f8a339a2bd4cfc..a61428bfdce372ea0511fb7c3e80f4c43f427eb4 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
@@ -11,7 +11,7 @@
 #include <linux/hid-sensor-hub.h>
 #include <linux/iio/iio.h>
 
-static struct {
+static const struct {
 	u32 usage_id;
 	int unit; /* 0 for default others from HID sensor spec */
 	int scale_val0; /* scale, whole number */

---
base-commit: 14071b9cf2d751ff9bc8b5e43fa94fbf08aceea1
change-id: 20250628-iio-const-data-14-b3250e000af7

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


