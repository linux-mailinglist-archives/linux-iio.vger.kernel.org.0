Return-Path: <linux-iio+bounces-15248-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A25A2EA57
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 12:02:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC631188A446
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 11:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F231CEE8D;
	Mon, 10 Feb 2025 11:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WdQt3vr8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D42D187859;
	Mon, 10 Feb 2025 11:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739185297; cv=none; b=Zvap2rMnJpkjUe44SiB/UY+3BTOlstBmJhFzL3axQgpASuzUSe+bIAk7N7GmJmp0Bgzhx/4FgppLyAyxpQ/cDKHHy5jHZz2GEd/3n2C6gfccQxPnjpcNC0H5rHqizM641qBqTxApdl8LlIhbXZPqTzMU20kRCwfl/u6xKIqpIls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739185297; c=relaxed/simple;
	bh=N5wPUtEL8GafvraaTitozwAcmvfIG4+F6qsLJt/dB1o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TfMwCbKqPwaC+LGD+xLiZ7XXEoYoHNuIMYe6JhwkVeB9t4W4jFwMW8KKbRkzbloNeUWyZOQ2DvZHymivgRi9gK8H8JDE9kH5w8yz5OwjrBjvtTdakt5aTIE6XmCj7Lz+TJ/6pNdwR4W7/RQGQXqqhafbj3iWCJmw3UaMVYVF1E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WdQt3vr8; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ab7bbc14101so11813066b.1;
        Mon, 10 Feb 2025 03:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739185294; x=1739790094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mvbwv18cfnvcZ2p2D0qtMZqem9sYjjTgAWQthVEWC7o=;
        b=WdQt3vr8rbgTHxPk6U6VdW2ECdl3OQJLwlc4T+IVFITpwcdnE2Fl24N92oStoDK28z
         TbU9wUoraJN0BOyC3HkD41P+n1yZr1FEMIinU/DxD7iZty1qHisi3SJhcZUW1dwZ9IEX
         VRnSaufHqu60JvRJHIXf97nskfj7QTmUFOxxUpIntrGAXWqSfQLX1YEMpo/13VEKluPN
         olVEzgnuXRTDoCLIGeKYzb04m8IFJt0cYjmNxkeiUuKjQUbMsP/QZIOLb5UCDZ5r8t0T
         S05bz4fnPuAH6o0x54Fep1dSgG4NZa9Hm3DQ7qjrKA2GJRac8F/MrNZkeA92A0WDwll6
         6mBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739185294; x=1739790094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mvbwv18cfnvcZ2p2D0qtMZqem9sYjjTgAWQthVEWC7o=;
        b=JFNdnrmMv+R/OtmTXb0C0c0dGK8MQTCmNubaibjsZOJgLqlYaIZc6wZOT7w7xYjF8E
         kHRbNQrOs/VsPY+5VKTqF8oj1mZY978xGep8T6gnUQtFObzy8yPuWKttq/ieHxwx/irB
         Bg6H5sw4Ptb4VqsZUAq8FRzGQwZsRM0TPRC0tlUzDbELoFiXwjCP2qNfpmSPpPUTRaRz
         5TMElkNbab0Pmd4OGHEePS+9QDqOS7t3JH1nnbTI7nlxL5/TgicO4WTE0xznoOfn+3zJ
         XA3O9gGR10PjlDCVIFQfn909BIowgzVnQg2dwYc4O/VJjBYUj7zm8CncQDZ+aXyG+vN0
         Qwyg==
X-Forwarded-Encrypted: i=1; AJvYcCWirnvXlu3pxPk5X55dcLCRT+vkBoMoR3VBFGOKn3P4i6Ir4zoum6sr7osEHDUsLBmxYYhDIYu2cS7HsHo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzlv6X6qQYltBu7uXpPGEjAlrCKoTvwGBg7zkAkyIThE561Rmtk
	Zq7HsIz9Ap7c7jhlH830qHlx5sqaiE5Jhkm6yPpn2jl2ENdUKJ86eYAFRA==
X-Gm-Gg: ASbGncthr8kOx0nFU2fhsDYsuvzLygdkqjOwyDSFI3Pgk714LFu35RQpPnlSSKQNd/S
	fn3OSp8tI0zF50NT7GMYVs6R/qwWV63HVWeFc8+i0huPpfVtCk28ChvXlW0L2AYwSaObES7m8gp
	3FlG8O21qNlXkv96AxAqgrNeVlYMtXrufmahL+wm+JvkGW8KsVQmxhBwPv+r9jir6/Delv30bky
	oaLks72DUmslgYZhm7Aa1JIppT+7jSguuW4II6fBlg8vPgcVb382vMmXJs+C+0A85YJw6IwrA0p
	dYYCWUnhQU1JPTJVOXLlUSS1myD/q8PMPhWXFifLyCJdHlpRjs+cyLZgP4TK3CMffvR4iw==
X-Google-Smtp-Source: AGHT+IEZIhblyA8juUY5dwK6eMaP5FlaJwX0x5Wc+IM2QYYrQZYhbBhVJSIQL0w2PYJ+yjwkSiLz2w==
X-Received: by 2002:a17:907:9488:b0:aa6:ab00:7b9d with SMTP id a640c23a62f3a-ab789b4c8c2mr539555066b.4.1739185294146;
        Mon, 10 Feb 2025 03:01:34 -0800 (PST)
Received: from d9dabf0abd47.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7a5a78369sm486987266b.136.2025.02.10.03.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 03:01:33 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v2 01/14] iio: accel: adxl345: reorganize measurement enable
Date: Mon, 10 Feb 2025 11:01:06 +0000
Message-Id: <20250210110119.260858-2-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250210110119.260858-1-l.rubusch@gmail.com>
References: <20250210110119.260858-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the measurement enable function up in order to have it generically
available.

This is a preparation for upcomming patches. Particular features need
to have measuring off while changing settings, and turned on again
afterwards.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 40 ++++++++++++++++----------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index ed0291bea0f5..c24692c51893 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -76,6 +76,26 @@ static const unsigned long adxl345_scan_masks[] = {
 	0
 };
 
+/**
+ * adxl345_set_measure_en() - Enable and disable measuring.
+ *
+ * @st: The device data.
+ * @en: Enable measurements, else standby mode.
+ *
+ * For lowest power operation, standby mode can be used. In standby mode,
+ * current consumption is supposed to be reduced to 0.1uA (typical). In this
+ * mode no measurements are made. Placing the device into standby mode
+ * preserves the contents of FIFO.
+ *
+ * Return: Returns 0 if successful, or a negative error value.
+ */
+static int adxl345_set_measure_en(struct adxl345_state *st, bool en)
+{
+	unsigned int val = en ? ADXL345_POWER_CTL_MEASURE : ADXL345_POWER_CTL_STANDBY;
+
+	return regmap_write(st->regmap, ADXL345_REG_POWER_CTL, val);
+}
+
 static int adxl345_set_interrupts(struct adxl345_state *st)
 {
 	int ret;
@@ -214,26 +234,6 @@ static int adxl345_write_raw_get_fmt(struct iio_dev *indio_dev,
 	}
 }
 
-/**
- * adxl345_set_measure_en() - Enable and disable measuring.
- *
- * @st: The device data.
- * @en: Enable measurements, else standby mode.
- *
- * For lowest power operation, standby mode can be used. In standby mode,
- * current consumption is supposed to be reduced to 0.1uA (typical). In this
- * mode no measurements are made. Placing the device into standby mode
- * preserves the contents of FIFO.
- *
- * Return: Returns 0 if successful, or a negative error value.
- */
-static int adxl345_set_measure_en(struct adxl345_state *st, bool en)
-{
-	unsigned int val = en ? ADXL345_POWER_CTL_MEASURE : ADXL345_POWER_CTL_STANDBY;
-
-	return regmap_write(st->regmap, ADXL345_REG_POWER_CTL, val);
-}
-
 static void adxl345_powerdown(void *ptr)
 {
 	struct adxl345_state *st = ptr;
-- 
2.39.5


