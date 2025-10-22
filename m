Return-Path: <linux-iio+bounces-25348-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFDF8BFCD33
	for <lists+linux-iio@lfdr.de>; Wed, 22 Oct 2025 17:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71E333AB3F7
	for <lists+linux-iio@lfdr.de>; Wed, 22 Oct 2025 15:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2198834C9AE;
	Wed, 22 Oct 2025 15:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="aBM4Oe8E"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8BF35BDBD
	for <linux-iio@vger.kernel.org>; Wed, 22 Oct 2025 15:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761146121; cv=none; b=qFOm0tAwSpD7wNoxbAnoEFQgTlEat/krkcf3QP8zD8xNnBJh+6WtXITrpQCK+PQ00N9mP0N91rPiJy3avLQrSepfKVotn4rhNAiH7KvwT1sJh+mOL5hK0i7FDLC0AXKE8DLSeC6i+LhYhpa7+I9NNlo9keyOc7gdHZaRSB6VaVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761146121; c=relaxed/simple;
	bh=WTpvRLD5144+vjH1Zw9VcLOGppdzcnf6Z/9CbgJBVLM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=nBXcpYdKYfIm8jjsia8ugmDBcQE00AnzL8nom7M/sudsHgiXV7OBXglN1Xuos0+XXN76ylOj+xFBbVAA5OmCzOI504uLnKDD16alvvlytKw1MCeWPaiWAmWx+ayAaDV+wTvQi6nxcpbSOF4ZPMG5ikp7nLkcGbPT05SzBclNQXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=aBM4Oe8E; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-36e4d00ebfdso2462526fac.1
        for <linux-iio@vger.kernel.org>; Wed, 22 Oct 2025 08:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761146119; x=1761750919; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YiNjWVSV5OievZOCQgMlEoQIBQNTOw8GmSUPvxdLeec=;
        b=aBM4Oe8EUPq4f4cFKy8mvrCmyh1dt9FRaejtqfiwBZ/AQkAY4Kur1VxszUhsaxdJ0i
         qMkmV3HEg77c9hzExei07FUuEYqm+Fvet7NeOfVwcF1vKgcLK8B7uSCqtyHb22WgCkrg
         mvrQUT2JAJqtuea0A13N7O6aqFA4Hcd58WHJOY1/gN+7WmYMSY2uF1PW0M55VqyP2GIp
         vZbdj8xQiaNQlj7ci6q4L0LRi1zbri8ltpT6qyu8dj0KfM+gcYGlQBh7NhzyNtrFbKpv
         YTG1/nNFAClnSXE8D3KCpNXcwjjQyOC8Yq/YfZ3T1Mt3Bd6F0SUn7hyMs5cEZZTCQQ5Y
         JXUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761146119; x=1761750919;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YiNjWVSV5OievZOCQgMlEoQIBQNTOw8GmSUPvxdLeec=;
        b=BMu/1gYXIoHq+kOFGYDkhoPpgyKJ5CuMqTF0+3xddfQONZF6dwbyAElmBVqFDT5QyY
         MiEz9/MQOleq+7bC8PvKqXh6r3s9vHHudtfAIpOkfFp05H3r4GIL3r/e73nRHcCPK4cY
         Zl/j7amXO9xlih4vp7fhh2bJw8e/q/6IFAB0yjqMjwdAOd/D1HxM8XQ48GQhbRJ6Q1J3
         etVrYNbizq9Ve72Y5/VNYwUK7O/a1Y39pGS08vPq3c8lsxWs0kdoNAKYXtbexnkQMSSg
         F5HiN4QCtgrhpLCUtQZFGylL1PDmWUy9pT57wcj19i2MOxuLPjJgzfVGzdHDA1qaUE1U
         atYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUorFUx9daCOAn2OxJj2uHmHSXhqHUG8dOhONKwHxD9sKcRWDm8+5FwcNTfTpc2RmqR+SNUOJQ9gkA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTpWodTfcSzzcO15+ybGtZ54WgpEOIJaXxGJ8Y2/L64aIEdWLc
	HV7xf34XCFLiy8UAcPdxqBuPvInkD2whP3+i0M4Csk1ihGMJz0DYm0sp4mJeq345pYg=
X-Gm-Gg: ASbGnctf8OpOVO6+lXDLZ8tJkXqTfltni+rFz0c2l7c/vrbPaBvw2urW049H2Uo0fEZ
	u3Ffw2WBPdgRpWJohyeV+U8ye3SstkmjVaIwdATKxTzSoskKaOtrIeGoTgutzYtPghkecX2VgC4
	v91HP7Q2pueTq6CRzzXiQ0BCsfQs1jaqj+7/LPpReBSBiJUEwoasAfX9/6zMqik0t3aXm9bqiL1
	3erGfnGh/d5oiDrdAPYxN3lRs811JC8XsNvbraHl20QcuF+aL3LtVSv9sCSTV0FAF+cvhZiVaQg
	lr2ZGHOYOSVEh7ISRFz5/FUDfRHHyayPevSwJEAU1H/P7XlHQZlo04DuT3OPLoIvkiFrR2jBvLQ
	ansM48gqORaXUlXZh1nm53C75FUDvLStJhgf01L9RTlVqCbNMsYRJq7X4wXotnAdNHyf6Q1XtE6
	ld1/lpXFBHcrsySio=
X-Google-Smtp-Source: AGHT+IH3s+jypGDndBCQ0Ns65SdXD6IDaxf0wrngKERsomTFVmbor9XtC5pxEfAk48+eZXnF5Pg26A==
X-Received: by 2002:a05:6871:728b:b0:3c9:463b:47 with SMTP id 586e51a60fabf-3c98d155524mr9923426fac.44.1761146118834;
        Wed, 22 Oct 2025 08:15:18 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:4176:6994:bd72:1296])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3c9aef57064sm3987317fac.2.2025.10.22.08.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 08:15:18 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 22 Oct 2025 10:15:05 -0500
Subject: [PATCH] iio: adc: ad7124: fix possible OOB array access
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-iio-adc-ad7124-fix-possible-oob-array-access-v1-1-2552062cc8e6@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAPj0+GgC/x2NQQrCQAxFr1KyNtCJValXEReZNGpAmjKBopTe3
 eDiLd7i/b9BaDMNuHYbNF0tzOeUcuhAXjw/FW1KB+rpVHoiNHPkSZJLoQEf9sHFI6y+Fd0rcmv
 8RRbRCKTjWJUGlvNIkJNL0wz+d7f7vv8A31zc134AAAA=
X-Change-ID: 20251022-iio-adc-ad7124-fix-possible-oob-array-access-239be24ac692
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dan Carpenter <dan.carpenter@linaro.org>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1955; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=WTpvRLD5144+vjH1Zw9VcLOGppdzcnf6Z/9CbgJBVLM=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBo+PT+Muwt913++cn4xU48KwPDrnKbV9rUsv3z1
 q7Exx0l+lOJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaPj0/gAKCRDCzCAB/wGP
 wEc/B/4kFUI/qEWfw5MWbxXSJglmNpQqokd2QDNswLnpip277qJs+BzfuZC23zFOc88FEi2hdAF
 Ka2Hgxx5ia0sBrPtmDOofhZcapC7pQ8bjKl5ty7J9UU83Tu+RjsESih9GZynR4FyZ9i0dju4oBs
 V5yL61NhgAh6GbLrBoNUFt8Evq+1Q0InHKQ7VhWG8UCk8teNvE1YAG0p64jsufTFU+1quEkCq8z
 Y2b2uk66OGWrJeF6Ob3e4uGgHV34EQgkbx5T8DyGdINV58icEtjVUWaJCRh/pU7Y3uBbXZ4AvHm
 QXy5n+UK8QYXdyXN48Md279Grkbhg/UDfYUXG/q9KOKgT2Hw
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Reorder the channel bounds check before using it to index into the
channels array in ad7124_release_config_slot(). This prevents reading
past the end of the array.

The value read from invalid memory was not used, so this was mostly
harmless, but we still should not be reading out of bounds in the first
place.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/linux-iio/aPi6V-hcaKReSNWK@stanley.mountain/
Fixes: 9065197e0d41 ("iio: adc: ad7124: change setup reg allocation strategy")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7124.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 9d58ced7371d0af7004a81153888714e9795d4f4..ed828a82acb71342fb2eae27abfbbd86861cba53 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -586,13 +586,18 @@ static int ad7124_request_config_slot(struct ad7124_state *st, u8 channel)
 
 static void ad7124_release_config_slot(struct ad7124_state *st, u8 channel)
 {
-	unsigned int slot = st->channels[channel].cfg.cfg_slot;
+	unsigned int slot;
 
 	/*
-	 * All of these conditions can happen at probe when all channels are
-	 * disabled. Otherwise, they should not happen normally.
+	 * All of these early return conditions can happen at probe when all
+	 * channels are disabled. Otherwise, they should not happen normally.
 	 */
-	if (channel >= st->num_channels || slot == AD7124_CFG_SLOT_UNASSIGNED ||
+	if (channel >= st->num_channels)
+		return;
+
+	slot = st->channels[channel].cfg.cfg_slot;
+
+	if (slot == AD7124_CFG_SLOT_UNASSIGNED ||
 	    st->cfg_slot_use_count[slot] == 0)
 		return;
 

---
base-commit: 89cba586b8b4cde09c44b1896624720ea29f0205
change-id: 20251022-iio-adc-ad7124-fix-possible-oob-array-access-239be24ac692

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


