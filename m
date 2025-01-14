Return-Path: <linux-iio+bounces-14340-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 905A3A10121
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jan 2025 08:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D16A1887E6A
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jan 2025 07:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B772397B2;
	Tue, 14 Jan 2025 07:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BvLo/L1Y"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0446233547;
	Tue, 14 Jan 2025 07:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736838157; cv=none; b=eKidskpWjQzLflVYu6vPl1ZZ9JY7oljU5GegGYyqRVsWanJawbaH1OCS4VGon//pNI09lUKUb+i7Zyc3Ncr6L18aVRqbqJIgxGk7PQ6D/46MV+xOkCbwyerAD5/lu1LXkV5WbDNdD16ExXPsZRRizPN64cHPXe5Ad7KbqKaFtCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736838157; c=relaxed/simple;
	bh=eP96/UxlSbqr8INGllcA27eJBJUAeYRtgL+BeHIdWh8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=MgU4bD9pVJy7M/GCE4CQ50z+8ULRilK70QbnYr0nkQYAuh9/wZ2pcCB1Y5Bw+MG0CMMjfuA6mI3Xcm+zINxZ5gTJfx/MFPAK/+fULlzUfw8yT76tV7K4OXqeFtsgzGZoQ1dmoE7ANq4zVTyYGjR6KzO/E0NKNTYISskIZ7nhaZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BvLo/L1Y; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21669fd5c7cso92225455ad.3;
        Mon, 13 Jan 2025 23:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736838155; x=1737442955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=WMEwm6g1OtkCE/I+rQscC86RvQEkgporJ3fM+wWISXc=;
        b=BvLo/L1YI4MX2qtDKJV/15g6vNWsF2xMDFRnbGAExd9+GwE6LYuzP8+VSbw2mIfiqx
         eH3Y36+4N9Nvqb1D3/YpeuwmYJ4TBBYgQZeF3ZUlGQoGk5VixKLLaXwHUsvDLU3bkMub
         kUM83bikDzVMs2DvtIkQNj8HVAYEEYKT1Mts/y+vOSxdy/cmFEzzpEKC+PXqaA1uavRe
         ggIxkVFOI7b+DPbTPlu5hzESmdxVwCHHH880VGFO0saBUO37U101sl62ONHJaZY2GHUV
         0U+gd6D3bJnoc4ywEI9TlEP3drH1FB8o+1Ae24LR4NtlYWvyT0T6v0ZPhjLuTcZEs6L7
         R+ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736838155; x=1737442955;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WMEwm6g1OtkCE/I+rQscC86RvQEkgporJ3fM+wWISXc=;
        b=Al9gaXxZX2hCw+RbM0kmQlwy4fBUi7adBFi85r/2qYu8f1cipsKhxp8ztrRXvx5ILc
         DBsUGkUMQ+2/ne8Wc0GzUc1FlTsmVfPgzPKRUCCqoruW5e9FhZv29GwXf8oza/nx7qPL
         XA3yDrvdutD0Vf6Uv2VlVamFzZbNJQHZ8uAwh4tEHt5li9H0qRyhTAbyNKKgaNPcL1GT
         JZnt8yWT/dpdvQRluDVSX5+L3bQD0OjMnVKoKI6D0/X3bNMYw2CI0YIJdVeDxBxPju5m
         oJ9UDAVb4Ew7JYkSWgnWaaGBoHTt9uIYIGOo2pONFCfh5jiCksvaYBN2CkEVAhbHxUTM
         ei0g==
X-Forwarded-Encrypted: i=1; AJvYcCVP1R7GngQST+MZcNnMt6LGeOuiBP3VjRBYz3WpwAIidC56ORJLiOUujyI+5gQGXHb0+98nF0KRmiw=@vger.kernel.org, AJvYcCXDyUxYqBKTy0vRqn4o8ZPmKD3KXyiofmBgWtgl12p9hb06WSkCIMpx38o4+yhaUbbKX1rEpqeUwwXqND/u@vger.kernel.org
X-Gm-Message-State: AOJu0YwDKmlNx2X4bBCUU7lCIdKfYN9Pr5RP3vDi2Jw854RFtZrjICMy
	5OQlnddm+YNFotQFIsEJNwqhRTSNqAhYEcyC7dQwMaqLWIoDfcjr
X-Gm-Gg: ASbGncsMH/D+tAfSuKyOzZreAn87ySOg/Q/n7nNYVucbJ17ed6Qh6e+498E3imdsBcR
	l2UN6v4/yFHuLZk5+izwqh9yRk3qCn3AyzSeO16u4ufrpxDDuSX5xGRt0zmiCgfZ6sWxnsC60gn
	9t8ix2EZKmHjQQ60pmd4MWHZDrPtkXXbNe8UCD6YjAC2RDOxg9xfcr/030UR8tHxhRf0ksadEo6
	Tk2BIt8n1kvbeHJz4ye5jeGBA9EUQ3CxxVdV4A=
X-Google-Smtp-Source: AGHT+IEjJRo9daiO/fiNDjEDHpCrMEuNKpRtffBAGnyYg8cSuse+oAft7zFuJnVBRJ40Cixli/EqqA==
X-Received: by 2002:a17:902:ce8a:b0:21a:5501:9d5 with SMTP id d9443c01a7336-21a83fde4femr386847245ad.44.1736838154828;
        Mon, 13 Jan 2025 23:02:34 -0800 (PST)
Received: from localhost ([2001:67c:1562:8007::aac:4468])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f25a477sm61455785ad.240.2025.01.13.23.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 23:02:34 -0800 (PST)
Sender: AceLan Kao <acelan@gmail.com>
From: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiri Kosina <jikos@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2] iio: hid-sensor-attributes: validate sensitivity attributes
Date: Tue, 14 Jan 2025 15:02:27 +0800
Message-ID: <20250114070227.1778298-1-acelan.kao@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An invalid sensor device was observed in HP 5MP Camera (USB ID 0408:5473)
which provided valid index and report_ids for poll, report_state and
power_state attributes, but had invalid report_latency, sensitivity, and
timestamp attributes. This would cause the system to hang when using
iio_info to access attributes, as runtime PM tried to wake up an
unresponsive sensor.

Fix this by validating both sensitivity.index and sensitivity_rel.index
during sensor probe. Since valid sensors must initialize these with
non-negative values, reject the sensor if either index is negative.

[    2.594565] [453] hid-sensor-hub 0003:0408:5473.0003: Report latency attributes: ffffffff:ffffffff
[    2.594573] [453] hid-sensor-hub 0003:0408:5473.0003: common attributes: 5:1, 2:1, 3:1 ffffffff:ffffffff ffffffff:ffffffff
[    2.595485] [453] hid-sensor-hub 0003:0408:5473.0003: Report latency attributes: ffffffff:ffffffff
[    2.595492] [453] hid-sensor-hub 0003:0408:5473.0003: common attributes: 5:11, 3:11, 1:11 ffffffff:ffffffff ffffffff:ffffffff

T:  Bus=03 Lev=01 Prnt=01 Port=03 Cnt=01 Dev#=  2 Spd=480  MxCh= 0
D:  Ver= 2.01 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0408 ProdID=5473 Rev=00.07
S:  Manufacturer=Quanta
S:  Product=HP 5MP Camera
S:  SerialNumber=01.00.00
C:  #Ifs= 6 Cfg#= 1 Atr=a0 MxPwr=500mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=0e(video) Sub=01 Prot=01 Driver=uvcvideo
E:  Ad=87(I) Atr=03(Int.) MxPS=  16 Ivl=16ms
I:  If#= 1 Alt= 0 #EPs= 0 Cls=0e(video) Sub=02 Prot=01 Driver=uvcvideo
I:  If#= 2 Alt= 0 #EPs= 1 Cls=0e(video) Sub=01 Prot=01 Driver=uvcvideo
E:  Ad=85(I) Atr=03(Int.) MxPS=  16 Ivl=16ms
I:  If#= 3 Alt= 0 #EPs= 0 Cls=0e(video) Sub=02 Prot=01 Driver=uvcvideo
I:  If#= 4 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=00 Prot=00 Driver=usbhid
E:  Ad=84(I) Atr=03(Int.) MxPS=  64 Ivl=16ms
I:  If#= 5 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=01 Driver=(none)

v2. add fixes tag and the device info

Fixes: bba6d9e47f3e ("iio: hid-sensor-attributes: Fix sensor property setting failure.")
Signed-off-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
---
 .../hid-sensors/hid-sensor-attributes.c       | 23 +++++++++++--------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
index ad1882f608c0..b7ffd97e6c56 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
@@ -564,8 +564,21 @@ int hid_sensor_parse_common_attributes(struct hid_sensor_hub_device *hsdev,
 	} else
 		st->timestamp_ns_scale = 1000000000;
 
+	ret = 0;
+	if (st->sensitivity.index < 0 || st->sensitivity_rel.index < 0) {
+		ret = -EINVAL;
+		goto out;
+	}
+
 	hid_sensor_get_report_latency_info(hsdev, usage_id, st);
 
+	ret = sensor_hub_get_feature(hsdev,
+				st->power_state.report_id,
+				st->power_state.index, sizeof(value), &value);
+	if (value < 0)
+		ret = -EINVAL;
+
+out:
 	hid_dbg(hsdev->hdev, "common attributes: %x:%x, %x:%x, %x:%x %x:%x %x:%x\n",
 		st->poll.index, st->poll.report_id,
 		st->report_state.index, st->report_state.report_id,
@@ -573,15 +586,7 @@ int hid_sensor_parse_common_attributes(struct hid_sensor_hub_device *hsdev,
 		st->sensitivity.index, st->sensitivity.report_id,
 		timestamp.index, timestamp.report_id);
 
-	ret = sensor_hub_get_feature(hsdev,
-				st->power_state.report_id,
-				st->power_state.index, sizeof(value), &value);
-	if (ret < 0)
-		return ret;
-	if (value < 0)
-		return -EINVAL;
-
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL_NS(hid_sensor_parse_common_attributes, "IIO_HID");
 
-- 
2.43.0


