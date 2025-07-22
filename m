Return-Path: <linux-iio+bounces-21883-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4344EB0E520
	for <lists+linux-iio@lfdr.de>; Tue, 22 Jul 2025 22:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1CDB547CD1
	for <lists+linux-iio@lfdr.de>; Tue, 22 Jul 2025 20:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28C7285C8C;
	Tue, 22 Jul 2025 20:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="RB/3EyAj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C629285C8F
	for <linux-iio@vger.kernel.org>; Tue, 22 Jul 2025 20:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753217673; cv=none; b=rn6h2YC5zNLGd81Pnr3eCDIOjd7wernhfSa3AwqYjoJs0qZmTQGHKedjRv7DP6enJLjfLPud1pnIxEtW4yL7YzyUYXFQrtBbc1/ishfUETEXLjk7lL0OmEipiDvjZlu9TlEpdR2zrv6gNU7i2nXLHCl929jp9QlkLtfUba1SD+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753217673; c=relaxed/simple;
	bh=NnWRWqBvReMHmWJs47rzjgvayXdAyRE7j16CS2mN938=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=onMm+grs3fFpYa2DL2UKniqOsAqFWJwh6Ljhe0/b0sx4KSvPCPIQuEpNLxxBdJR4eAkopblMsaHHu2LTNploPRtlwLFesHjIblNZS7uco0jUvMGfK6DgPR6rqWWtgV+okbLmfEZDIqAQWqSRU7Xorq9zjGuD5TwyY3WKBEcMNHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=RB/3EyAj; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2e95f0b6cb7so2198693fac.3
        for <linux-iio@vger.kernel.org>; Tue, 22 Jul 2025 13:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1753217670; x=1753822470; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jtYLUVKT3EJ2aCiWti9B6lnDSXEv36NupqDq3ze/PBs=;
        b=RB/3EyAj6QDKMHA53diEIas6ipDkeTTwRcfKIE/gKW+u+via1zhIVSYNI/ZBPVmExC
         JqfKhVCItLTpYhhf5Vsc+rMyC8kIwKYAiyMzwPdVgQDCS3+wY4/WO9m7Gb1ArW7Hh2ZV
         7714Mbw/e3DqW5QXczX7Af4SLhuxLajlLp6IOzliGpKIvMskDoRIdk+l7nODYNBRc39n
         cB3MAhueFBJOjSLyhRiIwhI1RWpl1XFa4UAnEW4flPxvvQyuC3/IT9YhnzgxDlbEe1Cr
         bEvfbbGaYKrcHwHt4QRUJPd4r2+D+QvOrCdhWVDR8xDxiOWBsvSckVpsNXIDJnaRjpZT
         DgFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753217670; x=1753822470;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jtYLUVKT3EJ2aCiWti9B6lnDSXEv36NupqDq3ze/PBs=;
        b=a6Zb3Yjrpa2tUBBoiAh73PS596N1PUmRq7xi0lsCyE43ALlpbDS6b4wICkJvZkLcaF
         k/9qqKcFYTG9fxYu59/dCI/E45TeOTxxOE9f9ha/hNJ2W5U8HvqmcgPJ4sGqhctZxDfd
         5ldh8cB5LKTTuNmIYOBuPShGrl6vgDm2G45hXL1ttpC52PUSpCfxvWuaXXT9BLUIkEEJ
         AlJ+QJuWp/rhKWlOmdQmsEDMCpCYFVAz91KQ9zk+vkCshBzyjaNQabVWV7+dPLjrgxfW
         2wPXubt9eRIvYUsalwE7M+r8m1i1PH0jdzGAM9Ub1F6vF9XRriP9cTJtpOco+Kzp8/Us
         pTOA==
X-Gm-Message-State: AOJu0YyEqlEJ4kN/Ws7lSuJ4MIwTnBc0S1hKKJ3pP7MTDq6UxMA3TYwC
	WNTG11u4DwqfHgP4BAOz6ZxI9tzycipkTyQnt8ByHCdSlAKZQSnjEIGXPCPhK1nicBg=
X-Gm-Gg: ASbGncsctlo9D23+BUQo7Fi9sDZpIPBj9Uyz6pDx80zUZ1n33wlCQZJ7w/3YmFk/CIA
	0d6H3X51dX3XmSZlZfZN0PvZuLAP/Ui8nd+oQsFqCpiM2RSb/T7GuB0SpgsvKKFLFme8tKdmlCo
	7LhTMBhAm76X72vqXyHyrX2s+BzRU3QnT3KePb8tfcdfMK249vkNcv6RxpBS1Vvd3aNlT6NzAd3
	pLt0Y4o2ArbXXQvJzEZOtZy21xzA0J9eA41ceExluBB3Ork1hZKe3ww7l/pgPgTd48orEZQ3qVa
	yC2hi5oh0pga4+QlXcmVkXc3hZn5or2h/4YgUQ1Ljd+uF0fj8vf8iuEWbZ2Ktapc1cyDJKiB+NQ
	NgyoPmFTgbkjaAWZV1vluNnqBKX+PN2m5VeeXOHE=
X-Google-Smtp-Source: AGHT+IFNPX9fsChpVJmdX+dZS4oONm0mg+uzGXO2ed5W1O5w6MGHprAcem1dwesjGge9QOuX0kCmQQ==
X-Received: by 2002:a05:6871:79b:b0:306:bd25:6d34 with SMTP id 586e51a60fabf-306c727a354mr328144fac.29.1753217670159;
        Tue, 22 Jul 2025 13:54:30 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:2a79:4b55:6a01:85d7])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-30101ccfbdbsm4690173fac.10.2025.07.22.13.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 13:54:29 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 22 Jul 2025 15:54:21 -0500
Subject: [PATCH v2] iio: proximity: isl29501: fix buffered read on
 big-endian systems
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250722-iio-use-more-iio_declare_buffer_with_ts-7-v2-1-d3ebeb001ed3@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAHz6f2gC/53NQQ6CMBCF4auQrh3TFgnElfcwpCl0KpMANVNAC
 eHuFo7g8nuL928iIhNGcc82wbhQpDAm6Esm2s6OLwRyyUJLXchSKSAKMEeEITAeMA7b3jKaZvY
 e2Xxo6swUoYSqks555XJZSpH+3oyevmfrWSd3FKfA65le1LH+U1kUKLC510VuW403+2js2lPDe
 G3DIOp9338lQAdG5QAAAA==
X-Change-ID: 20250711-iio-use-more-iio_declare_buffer_with_ts-7-880ddf1d3070
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Mathieu Othacehe <othacehe@gnu.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2369; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=NnWRWqBvReMHmWJs47rzjgvayXdAyRE7j16CS2mN938=;
 b=owGbwMvMwMV46IwC43/G/gOMp9WSGDLqf9V5H+uIZ+VkYJHLyjyo9HJn4iTjgHNiJ9PLbqSdr
 5tcwB3YyWjMwsDIxSArpsjyRuLmvCS+5mtzbmTMgBnEygQyhYGLUwAmUhXN/odzrmVJTuQL5/z1
 mVtWntnJ7t78gvlh0TQTzXd/FttJ14THpfAWqi267Muw6N6ywG3Wr91YriSsSQjxsnxx0GqvTfp
 RfwbhhVMvblYRi3uscyH0UtG3pTfFTHYw+7JHTlqefNhVOeVoq7NjXI+rQEnY9uqo6ftzgjaf7e
 de9USk+PXTYzy5c+YeZi5+cac7LKc39r6Wqpu3iOY5y9We/pdY5e1CvYq7t3Uz/XPfNGW1ebCSl
 JSp5vb5XNuczzYmMMU5yt3W//12d+vL4x6/zc9Omx/iW5a496pntFtdy4rGzp7fT0pZm4oPqTz1
 Nvudy+Rjov7YnoVjNutHkS9yrFpT3qgn3t9gGf7QfrUGAA==
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Fix passing a u32 value as a u16 buffer scan item. This works on little-
endian systems, but not on big-endian systems.

A new local variable is introduced for getting the register value and
the array is changed to a struct to make the data layout more explicit
rather than just changing the type and having to recalculate the proper
length needed for the timestamp.

Fixes: 1c28799257bc ("iio: light: isl29501: Add support for the ISL29501 ToF sensor.")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
Changes in v2:
- Use u16 to match channel scan_type and introduce new local u32 variable
  for getting the register value.
- Reword subject and commit message since we now consider this a bug fix.
- Fix not zero-initializing the new struct.
- Link to v1: https://lore.kernel.org/r/20250711-iio-use-more-iio_declare_buffer_with_ts-7-v1-1-a3f253ac2e4a@baylibre.com
---
 drivers/iio/proximity/isl29501.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/proximity/isl29501.c b/drivers/iio/proximity/isl29501.c
index d1510fe2405088adc0998e28aa9f36e0186fafae..f69db6f2f380313b8444ee21399ee3a9faed6f04 100644
--- a/drivers/iio/proximity/isl29501.c
+++ b/drivers/iio/proximity/isl29501.c
@@ -938,12 +938,18 @@ static irqreturn_t isl29501_trigger_handler(int irq, void *p)
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct isl29501_private *isl29501 = iio_priv(indio_dev);
 	const unsigned long *active_mask = indio_dev->active_scan_mask;
-	u32 buffer[4] __aligned(8) = {}; /* 1x16-bit + naturally aligned ts */
-
-	if (test_bit(ISL29501_DISTANCE_SCAN_INDEX, active_mask))
-		isl29501_register_read(isl29501, REG_DISTANCE, buffer);
+	u32 value;
+	struct {
+		u16 data;
+		aligned_s64 ts;
+	} scan = { };
+
+	if (test_bit(ISL29501_DISTANCE_SCAN_INDEX, active_mask)) {
+		isl29501_register_read(isl29501, REG_DISTANCE, &value);
+		scan.data = value;
+	}
 
-	iio_push_to_buffers_with_timestamp(indio_dev, buffer, pf->timestamp);
+	iio_push_to_buffers_with_timestamp(indio_dev, &scan, pf->timestamp);
 	iio_trigger_notify_done(indio_dev->trig);
 
 	return IRQ_HANDLED;

---
base-commit: cd2731444ee4e35db76f4fb587f12d327eec5446
change-id: 20250711-iio-use-more-iio_declare_buffer_with_ts-7-880ddf1d3070

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


