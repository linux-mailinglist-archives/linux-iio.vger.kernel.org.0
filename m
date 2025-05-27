Return-Path: <linux-iio+bounces-19970-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 960D4AC5B36
	for <lists+linux-iio@lfdr.de>; Tue, 27 May 2025 22:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28FA83AF7AB
	for <lists+linux-iio@lfdr.de>; Tue, 27 May 2025 20:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B62204F9C;
	Tue, 27 May 2025 20:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aocnPWRL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91931922F4;
	Tue, 27 May 2025 20:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748376341; cv=none; b=BCVzqollFDZoMEuu2UJfWbQuHMaH22QiPVQ3pgZijujbsV09rTNftVmKjUmVLPl7yoGB5adGcJirxRxgYw+MdkJaT8smQeNfaC56bhuqJbNmTVlkCCzjf4AuTcvUuwbGc5F8spR0Sgqdjro6jYoGCFcCwx0oKJpbHQWeMjhLfLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748376341; c=relaxed/simple;
	bh=XIbl9FKWC0/ZseCR1fpIwG9PbNH06G2ZQDl7cmx9XMI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pn2x5oQgUk/oILxYdeKkQZpb9ThJEOwKBr647GEd4yRsGerjmlnwdvuXtIS5KCPmmIUZJAbw9CyvhWHOuhiRvYkfLBp85Yt2xPWRnyEgYNQk/m5U1aiLMyVyZBREUgIFN1jla4cfsRlM+VOM2rdvk2xJOV326V6poZkAYEVEA2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aocnPWRL; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-23035b3edf1so28536865ad.3;
        Tue, 27 May 2025 13:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748376339; x=1748981139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/ha5hgBscA0dQhpFCEO9OnTXh288jXUeLYKPFEnCUXY=;
        b=aocnPWRLWx+LFouU8ycTQXYIjznnrru7fNuw6sJhP0wK7S3yn3QKoNdjlFAdq97Gn8
         NbUxN9IuKzxGymr1m/JBEt5GmjT9b2klIu1jBWAwqt+A/LdvpDKWV2RPwU/w0Kl+9R2r
         AcOlovmPxZh+Y/nwsyN/jWUvftG0QsEiXqcuXsvd3nJVPQs+bZSP9kOTWhLF/YnCO1X+
         0yMibkqD7MpzQ45tf0Jd8HCF4x5Si1SfznBLA5hgiPNZjesVLgmQkvIBunKbM45+sSXq
         Z2T7DwR/Bdm+KIiTkalgahyFlu3a77ChQKQlYD3ncC+yzPivBRhXGoGJwnxQtEwls9a4
         CMQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748376339; x=1748981139;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/ha5hgBscA0dQhpFCEO9OnTXh288jXUeLYKPFEnCUXY=;
        b=w3ZxQhN+Z9VDbclAvy9r8O4Bjkun0Gpjghevpif9g3IK5sVNx8eJDLq6jpADWvBMbM
         E5Ait1mavTAhjJRiQz/C92wQEUhNvrZGU3UvrhV9P6K5RabKu1S/WFvZlP+Yv8obhWKv
         0RgKNDjrxEE67X7n1o7T0rfPzmJpfg8jFmAhUi47ygfWAghUkL6poacR0kQzWC3HhxDL
         10lWcm3MidENDoU6BOx4dWBobYIPB9PZ+j5UlCIx1XcAUJ7ww4iJySMrA+pYEA2mu6gE
         /V/ksHL9qBOIO6y3NWsFgE7nmSqBD/SxexCuiKDSAR4a6R6fHE94ekYsvVTWfl8lAES1
         B7pA==
X-Forwarded-Encrypted: i=1; AJvYcCU28gCqgKlDWx5Blo4wybCxeTCfkbXBCq82o51PI8nBvssC3/wnFfjt6dHMWdVmoqnjr7ZuucIAsBgJcU2Y@vger.kernel.org, AJvYcCUhFHb9uUet62X4o2UEX+9zq7cV3n4ZRgcq0RpPOI20WlQXvFyyoE2eDb34lEMuDXIvjst/CmXIxnM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4Stsj33yhQv8lsw8cu2boPApBF3X64sLggLbVHtZGwrEVfXy5
	XCorkmJ+XLFxZRUdtC3Nq3QqSQW4qeFwevwVne3BbFFirI8h766gYlY5b1chcw==
X-Gm-Gg: ASbGncug9IbVGrtTrj2wu/hcFcOQpxBkKaZVU77JxcRQCALGax1YZ/ipqAfYWLDsOri
	B0b+iobTr2da2oy3+ZJL4NlmnzdRv4fV4DEuWVXN92qrt7976eRPEVzrOYQbPdpul7ZUAp/ovEU
	+smf261nDB9QzdikfWFFloSW9R0+jjjmY39/oPSpY1X7xlM7O9YmdUbbTps9ciE9lHm+ezJyDYe
	tEs1oRHDKq94Nz6uFPZ4kCcLT2cUgTC3tQAsTvHQM7RTsATJapRtoCzA8anrf7oEnbnhqNBnMgz
	6j6U97Q8YDQK5wsMYypHhLJuHmonxNjTtI92ILliJu1x51JV03l0lRusTA==
X-Google-Smtp-Source: AGHT+IEW32gW/TskUCN3Xj4ALhCeY7pPAV+bb5ooRr6p04ehTa3DNo3F6S5VM7aV+CxCFdW0Cjc2aw==
X-Received: by 2002:a17:903:46ce:b0:22e:72fe:5f9c with SMTP id d9443c01a7336-23414fc85f8mr202873185ad.42.1748376338883;
        Tue, 27 May 2025 13:05:38 -0700 (PDT)
Received: from gye-ThinkPad-T590.. ([39.120.225.141])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23499615432sm18290195ad.246.2025.05.27.13.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 13:05:38 -0700 (PDT)
From: Gyeyoung Baek <gye976@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Gyeyoung Baek <gye976@gmail.com>
Subject: [PATCH] iio: trigger: Avoid data race
Date: Wed, 28 May 2025 05:05:34 +0900
Message-ID: <20250527200534.98689-1-gye976@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A data race could occur between `atomic_read()` and `atomic_set()`
Use `atomic_cmpxchg_relaxed()` to group them atomically.

Previously the main logic was executed when `use_count` is 0.
Now it returns early when `use_count` is not 0.

Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
---
 drivers/iio/industrialio-trigger.c | 38 +++++++++++++-----------------
 1 file changed, 17 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index 54416a384232..33a565037e0d 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -194,17 +194,15 @@ static void iio_trigger_notify_done_atomic(struct iio_trigger *trig)
  */
 void iio_trigger_poll(struct iio_trigger *trig)
 {
-	int i;
-
-	if (!atomic_read(&trig->use_count)) {
-		atomic_set(&trig->use_count, CONFIG_IIO_CONSUMERS_PER_TRIGGER);
-
-		for (i = 0; i < CONFIG_IIO_CONSUMERS_PER_TRIGGER; i++) {
-			if (trig->subirqs[i].enabled)
-				generic_handle_irq(trig->subirq_base + i);
-			else
-				iio_trigger_notify_done_atomic(trig);
-		}
+	if (atomic_cmpxchg_relaxed(&trig->use_count, 0,
+				   CONFIG_IIO_CONSUMERS_PER_TRIGGER))
+		return;
+
+	for (int i = 0; i < CONFIG_IIO_CONSUMERS_PER_TRIGGER; i++) {
+		if (trig->subirqs[i].enabled)
+			generic_handle_irq(trig->subirq_base + i);
+		else
+			iio_trigger_notify_done_atomic(trig);
 	}
 }
 EXPORT_SYMBOL(iio_trigger_poll);
@@ -225,17 +223,15 @@ EXPORT_SYMBOL(iio_trigger_generic_data_rdy_poll);
  */
 void iio_trigger_poll_nested(struct iio_trigger *trig)
 {
-	int i;
-
-	if (!atomic_read(&trig->use_count)) {
-		atomic_set(&trig->use_count, CONFIG_IIO_CONSUMERS_PER_TRIGGER);
+	if (atomic_cmpxchg_relaxed(&trig->use_count, 0,
+				   CONFIG_IIO_CONSUMERS_PER_TRIGGER))
+		return;
 
-		for (i = 0; i < CONFIG_IIO_CONSUMERS_PER_TRIGGER; i++) {
-			if (trig->subirqs[i].enabled)
-				handle_nested_irq(trig->subirq_base + i);
-			else
-				iio_trigger_notify_done(trig);
-		}
+	for (int i = 0; i < CONFIG_IIO_CONSUMERS_PER_TRIGGER; i++) {
+		if (trig->subirqs[i].enabled)
+			handle_nested_irq(trig->subirq_base + i);
+		else
+			iio_trigger_notify_done(trig);
 	}
 }
 EXPORT_SYMBOL(iio_trigger_poll_nested);
-- 
2.43.0


