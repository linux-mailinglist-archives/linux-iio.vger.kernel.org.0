Return-Path: <linux-iio+bounces-21848-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E2D2B0CD3D
	for <lists+linux-iio@lfdr.de>; Tue, 22 Jul 2025 00:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B3D71AA305B
	for <lists+linux-iio@lfdr.de>; Mon, 21 Jul 2025 22:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18FEA2417C8;
	Mon, 21 Jul 2025 22:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="I0CpUm59"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336EC22173A
	for <linux-iio@vger.kernel.org>; Mon, 21 Jul 2025 22:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753136484; cv=none; b=e4HcofWN1qVvNN1nSrqC7tCg1Jx7TqbWM8aWG3+1nRWGy2yuL5L3yOXULGZB0hjTz/BIng4vGyYkZWKrDwsa+AvLBZe82wKnN8Dg3gdv9RBfmfrz6o3xI4kfKPKkIiBPufNb9tr1bPEw1oIvQ2rbyIFpJnb4yY/xd65eXCc9XuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753136484; c=relaxed/simple;
	bh=nLCh7454KRl7sINjOvFM5ZPtrAAWEmL026g1Ao9hNGY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=KUSQS2algUdNlyoN7KFYVyiy5N0+5MkxDqzfMPCOt+WFx3d+MgI4JS6sjztD2vv1LBWdYuVdw9NYek5JNQ8lhKeX/1Okuui7mWPmtqcn6YcMdwKh3PZNYqUbzcOTXDEtLZIM7oNDOyasCpUgVWUa8Ix1KEITf6oq0lIpgPyC3eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=I0CpUm59; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-41c3addd37cso3521219b6e.3
        for <linux-iio@vger.kernel.org>; Mon, 21 Jul 2025 15:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1753136481; x=1753741281; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ir94cpWkFYvXSU0eidJncZJnbU2cvtbia6KJljasuts=;
        b=I0CpUm59NzuJhn1adw4JR+tJM1XtzMdmZOIhsXGCWy4v1IUFqB3nL6VTMp5m7T1jjd
         H/dh9bUn9NoPIwn0PkwxiU7Ln5QKBVVVxKbUUUyqBEnp6xJ9y13+8UhApBihu0kQuwfc
         Cpeu5JedA6vbbm7FVdLTeJ4y09jurwMoxd2Fl1lP89+4bmQ70oG6EM+l+4Xx0G3G5m/w
         +3FyGt/mmT1rUge8DNoJz028C6PKKh/IkQ6UhtT7D4p03X93/r1mtXj71HdtmeTiwrlV
         /qTnDRIGAIXYovku29TUpzy6fwvcFrRddlg62dFeVo/8ld10sCVJpO612vSqvE015x9e
         xDZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753136481; x=1753741281;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ir94cpWkFYvXSU0eidJncZJnbU2cvtbia6KJljasuts=;
        b=EhSz3/YPb1lwwx8phzyTGPRxN1BEmkzO1PfWqiO91U0BGfUKEvy2RE6jOL4aFuiRvD
         iR+oqySjXe+VRguAYbWbdwqguFTNNkg0UE0PPNF/uSX8djQ42KCSrR7lwPJ/LzDweCVj
         QOV7zyXQ7LBvZDfwznyFjFJMPkj9mo14OjXhwv48i+ntbpy2i4j2PB4r+FIyc2Vxi5Hf
         RxyrZ6km4yjKAfgkceny5vskhYTJfTnkQ4frcDdosknG7MiXUDSTtFFfRbw6hvQ5TCLV
         F7yDLunnKmHwrvHnRcCKKcuoTTytg2lHU0Cq6RGDnDcwgME8Zpp9uCRzrS9G0t34VPtx
         9QfQ==
X-Gm-Message-State: AOJu0YwUBP5SNyqFgocImZO25efKO7nm6R/pekKBMWJAP1cJCQvSzEVt
	Xjoh3nmJ3DxQHNF0eQULY7ALPMfFohWiwXJR+6HKFvifutnwcs9Vo1wj6fY/lBYaqDo=
X-Gm-Gg: ASbGncuYNLaBaoQK190daQiyWIpDvaxU1wGUOIUmVpQiDrjI8jxz6L4hnuaT/Ofm0tH
	vgSO+QFCcsiOU5duZGeHp78R604TRZpgxcurH/oz0fKXrmV/muEfLqOWuz8/CERxNbVBVE5Y4sx
	wFh7pB5EWaBiOybZglStbVbtbQCEo8gySo23stTJA4+2YDVN/5KcKLRF7Wh0n+EWK6fS9QmQOEb
	nibgpKOaD9iZgbTuCA4YCKSFzFSlo5riu5oYiEg6PqAvTE2+9Vct+in40/+62WWqJQiKGLZmgkI
	h4K9FDgBIHDGJ4iMnbvM4c3FtVzW3i/rQcPKn0U6hmtjtVYzxJIgrbjmhKUIQjlmQhXlPFZd7YD
	E65TFn2Vl4Qe89B+va8YaKZbQ5kCL
X-Google-Smtp-Source: AGHT+IEGuD7VmEgrTcRz/AB12UEyohE1S1RoBpW3vo852KHUXNkvFALamt2SbwQuW2cKGqo+pquHLQ==
X-Received: by 2002:a05:6808:15aa:b0:40a:557e:cf6 with SMTP id 5614622812f47-41d054697ffmr16645011b6e.26.1753136481265;
        Mon, 21 Jul 2025 15:21:21 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:2a79:4b55:6a01:85d7])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-41fd1db52e7sm2887113b6e.19.2025.07.21.15.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 15:21:19 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 21 Jul 2025 17:21:08 -0500
Subject: [PATCH v2] iio: proximity: srf08: use stack allocated scan buffer
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-iio-use-more-iio_declare_buffer_with_ts-6-v2-1-8b66e5b4e75a@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAFO9fmgC/53NQQ6DIBCF4asY1p0GSNDSVe/RGCMw1ElUGlBbY
 7x70SN0+b3F+zeWMBImdi82FnGhRGHMkJeC2a4dXwjkspnkUvFKCCAKMCeEIUQ80Di0fRuxMbP
 3GJsPTV0zJSih9N7eUGulpGP57x3R0/dsPevsjtIU4nqmF3Gs/1QWAQKkshU3WnNX2odp155Mx
 KsNA6v3ff8BwTWPJeUAAAA=
X-Change-ID: 20250711-iio-use-more-iio_declare_buffer_with_ts-6-6ffc8e99552d
To: Andreas Klinger <ak@it-klinger.de>, Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2186; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=nLCh7454KRl7sINjOvFM5ZPtrAAWEmL026g1Ao9hNGY=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBofr1YhHvq1ikn/fiQexdEXIuaEtoatlaw2aOuO
 mkMnE5cas2JATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaH69WAAKCRDCzCAB/wGP
 wFSWCACIgaB64GbBQQEjPJAOzozQK1/RHWXol/LxWWb0aeb6D4+KZ3Dat22fEWcsZQNzRxIkXlg
 Q2TdjP/GKO0eDVQ7CrA5mvvzSoANYvQlUoeXCqI2qVitLuQndx0VExSTcmttBdVQOFLs5/j0kq1
 wtp1ocUux7fHdh1cTrjZ44v0wdKh/VatBnl5qcuswy30B4uWW4QUhAB32HOaHKF4rpa8vgG6ga/
 kzpxuzCpxX8dtaYUAuPaqz0FctMoXuaC40Tpgzqm/d2mZN8EtH8Zt1RdXL1U6kF0GwEEV9M0+4D
 24wG9JzvOt7uo5GHTZ/CogmxOCbDHueuTUMVBYtE1rO4wcWZ
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use a stack allocated scan struct in srf08_trigger_handler(). Since the
scan buffer isn't used outside of this function and doesn't need to be
DMA-safe, it doesn't need to be in struct srf08_data. We can also
eliminate an extra local variable for the return value of
srf08_read_ranging() by using scan.chan directly.

Reviewed-by: Andreas Klinger <ak@it-klinger.de>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
Changes in v2:
- Zero-init the scan struct to avoid leaking uninitialized stack to userspace.
- Link to v1: https://lore.kernel.org/r/20250711-iio-use-more-iio_declare_buffer_with_ts-6-v1-1-25c70b990d6c@baylibre.com
---
 drivers/iio/proximity/srf08.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/proximity/srf08.c b/drivers/iio/proximity/srf08.c
index 6e32fdfd161b93a5624f757d5b7de579415b1055..d7e4cc48cfbf700c7828235de99a66324767316a 100644
--- a/drivers/iio/proximity/srf08.c
+++ b/drivers/iio/proximity/srf08.c
@@ -63,12 +63,6 @@ struct srf08_data {
 	int			range_mm;
 	struct mutex		lock;
 
-	/* Ensure timestamp is naturally aligned */
-	struct {
-		s16 chan;
-		aligned_s64 timestamp;
-	} scan;
-
 	/* Sensor-Type */
 	enum srf08_sensor_type	sensor_type;
 
@@ -182,16 +176,18 @@ static irqreturn_t srf08_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct srf08_data *data = iio_priv(indio_dev);
-	s16 sensor_data;
+	struct {
+		s16 chan;
+		aligned_s64 timestamp;
+	} scan = { };
 
-	sensor_data = srf08_read_ranging(data);
-	if (sensor_data < 0)
+	scan.chan = srf08_read_ranging(data);
+	if (scan.chan < 0)
 		goto err;
 
 	mutex_lock(&data->lock);
 
-	data->scan.chan = sensor_data;
-	iio_push_to_buffers_with_ts(indio_dev, &data->scan, sizeof(data->scan),
+	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan),
 				    pf->timestamp);
 
 	mutex_unlock(&data->lock);

---
base-commit: cd2731444ee4e35db76f4fb587f12d327eec5446
change-id: 20250711-iio-use-more-iio_declare_buffer_with_ts-6-6ffc8e99552d

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


