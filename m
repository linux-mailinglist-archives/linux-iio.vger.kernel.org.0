Return-Path: <linux-iio+bounces-19985-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E400AC638D
	for <lists+linux-iio@lfdr.de>; Wed, 28 May 2025 10:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6C9B1BC4547
	for <lists+linux-iio@lfdr.de>; Wed, 28 May 2025 08:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649E61B87EB;
	Wed, 28 May 2025 08:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="npqAgIvb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64392F2F;
	Wed, 28 May 2025 08:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748419287; cv=none; b=AExajn4XAB8rSMnixXXoyuJjbGAQXEKzqoqt6WNZSM6M2wyIMiatQhkWhfjapKy7jrVXmkoVD6AXKq7dJUSuExu+8G7rSqiJtPLwIiSLMIfSK2oBOVkyxpJT/6HmNRWwr+4QP570EoWseNwPYZaNtFy/dm8Um3oF8rTjBFmUl6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748419287; c=relaxed/simple;
	bh=IxHFccLgpCgNcXpBy6g6veU5pEuw/iNFgadb6in5fvU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A1KZS8RJ0ylY/4AMl5fgmiU9bDZ9kZgCSMTMyHBeY75Yw2cd60dpgyw/Q5L6ppHq23ZDx6YsPyKezi4Q0ScOcQg6r1Njxzo+iwxhORxIQuLX2H6caT98jSBLyGCoeu5pg6uJwZP0sCuuH1c0Knr4Gw+r1nLpGQMprgE7ZrzWK58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=npqAgIvb; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-742c73f82dfso3215852b3a.2;
        Wed, 28 May 2025 01:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748419285; x=1749024085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UWdQG3Tx6wClBi/pyNZ7WtC6psNihL3zvEzBuIdhfFs=;
        b=npqAgIvbxnMb+IAyg/a0uq1Rq7FOmPlkfGu5VDxF3dNd+KSMhSq8ZLqgtoVFDEctFK
         hfgxtTPThPSv1O37DAgcuUGP19mrW+H+/yVD8WfTTe3/LTN4FalyYy47st4UutvrJRF7
         faxE+LGOJP2cmH1cGocgrAch4K4DIbuBu0rpYATRkr57DEqqL1RM195Eo4cgRbYABv2j
         EX4l8xfYZN/uIk7rGH2YilykS7zkl67zMrX2/lK7kbWOVmvbF1YVc8nTYf3MosA/qGJM
         RuYPidB3fsjG+ltVk8B0OJYjEAfRjvdqCIiqrRBRKw1SJJr5EYfF6hVDLlAF2My8WAHN
         VJoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748419285; x=1749024085;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UWdQG3Tx6wClBi/pyNZ7WtC6psNihL3zvEzBuIdhfFs=;
        b=mciSicSGBag8VYjBlE6VgBcMVD9KRPDMKuBkUZpumO73IbscGuDFVKtO0q/D5OakeZ
         6ngF0xKAYNpSfgmoZFXu0L7an5XkA0ecjnPC6N73VCLC5Vf2Fdde25HI0Eb2SqxNZYWs
         EDIKNgJhHPcOrrk55Yp7856j3SPzYU2TjbBDOa9tNDHyf6UM726UvklBm/KvV1JY6jLp
         P3ZmhAuLNyDsP2/8NSAOqOY5V7V0xF8dNLJ1iEgfljxBCNLcpwmDz5OyVuGjeOw3/AKy
         ByyYLxU59r8bJEhsMkAnp0HnO7gge/76W5uTU6TRFH5owhXMLFlEYOcp0R2tG7KaqjGj
         qGeA==
X-Forwarded-Encrypted: i=1; AJvYcCXUW2zoNPhm7Zr9Fg1nrtVqKOfGnaYYafoGGgr8PyUApm9ad+687bFhIyBU3R1Bze7t3oxz2c068TCd97nl@vger.kernel.org, AJvYcCXZV9/wyLtinOqNLT3rCKxNV5HWo6eOP4fT6cQgqJ3f0y342HHvzXroPYYW12qSWf80GjhPYy5eyQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKb8wPQRh7UDN5BPQ5D4vx8eTb7eZHG+VhqV+N5XBd73HjtdkC
	/jwgZQ/Oym3gPE7O0mSJwrmvXGjv3EB4j80Z/GjXSfqB+oJEyFUVO/pi
X-Gm-Gg: ASbGnctB1Dz6wZZv3oSWOwns8kFIQhmeyb4ZKBF+cZdLYhLmOEjNRiY+JlX6om2auo2
	kjjMvk0amSgFSPLwoZsJi7MJDW/s5NHXh31R9Z/3Q/hTaQY4Y+sB3giKwjWmE86ZMcGuOO+aU7/
	PLITsxWdPXyhcZa6FDGuIBFptGLLQx15kN/52S1kiEelhscfREZVCEkqNkzx1l/LHIwlleQV/J8
	vKUMPbG/FaCh3SFJ8FbZ2RCD2hLewv3QWTpwYsvGBbB6dfIs0C/mMkasnw0HZJXJlYF3eiSH9wb
	zBy6f4Ecxs37GOohJ070o1ts8nwqGehmN86vJRwY4KpndhAOrhBkSNFK
X-Google-Smtp-Source: AGHT+IF5I55hrT2xFf6Cw60An/loPVGY74aTV1aVgoiR/mgaKSLKaf027Ydwk44wllbi/nYP5kXseg==
X-Received: by 2002:a05:6a00:4646:b0:742:ae7e:7da8 with SMTP id d2e1a72fcca58-745fdfcc5e9mr24012397b3a.8.1748419284699;
        Wed, 28 May 2025 01:01:24 -0700 (PDT)
Received: from gye-ThinkPad-T590.. ([59.16.200.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-746e341039dsm701253b3a.103.2025.05.28.01.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 01:01:24 -0700 (PDT)
From: Gyeyoung Baek <gye976@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Gyeyoung Baek <gye976@gmail.com>
Subject: [PATCH v2] iio: trigger: Avoid data race
Date: Wed, 28 May 2025 17:01:19 +0900
Message-ID: <20250528080119.9380-1-gye976@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A data race could occur between `atomic_read()` and `atomic_set()`.
Use `atomic_cmpxchg_relaxed()` to group them atomically.

Previously the main logic was executed when `use_count` was 0.
Now it returns early when `use_count` was not 0.

Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
---
Changelog:

v2:
 - Edit commit message. 
 - Separate variable declaration from logic. (Andy)
---
 drivers/iio/industrialio-trigger.c | 32 +++++++++++++++---------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index 54416a384232..fc799910c74d 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -196,15 +196,15 @@ void iio_trigger_poll(struct iio_trigger *trig)
 {
 	int i;
 
-	if (!atomic_read(&trig->use_count)) {
-		atomic_set(&trig->use_count, CONFIG_IIO_CONSUMERS_PER_TRIGGER);
+	if (atomic_cmpxchg_relaxed(&trig->use_count, 0,
+				   CONFIG_IIO_CONSUMERS_PER_TRIGGER))
+		return;
 
-		for (i = 0; i < CONFIG_IIO_CONSUMERS_PER_TRIGGER; i++) {
-			if (trig->subirqs[i].enabled)
-				generic_handle_irq(trig->subirq_base + i);
-			else
-				iio_trigger_notify_done_atomic(trig);
-		}
+	for (i = 0; i < CONFIG_IIO_CONSUMERS_PER_TRIGGER; i++) {
+		if (trig->subirqs[i].enabled)
+			generic_handle_irq(trig->subirq_base + i);
+		else
+			iio_trigger_notify_done_atomic(trig);
 	}
 }
 EXPORT_SYMBOL(iio_trigger_poll);
@@ -227,15 +227,15 @@ void iio_trigger_poll_nested(struct iio_trigger *trig)
 {
 	int i;
 
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
+	for (i = 0; i < CONFIG_IIO_CONSUMERS_PER_TRIGGER; i++) {
+		if (trig->subirqs[i].enabled)
+			handle_nested_irq(trig->subirq_base + i);
+		else
+			iio_trigger_notify_done(trig);
 	}
 }
 EXPORT_SYMBOL(iio_trigger_poll_nested);
-- 
2.43.0


