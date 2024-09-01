Return-Path: <linux-iio+bounces-8922-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA5B39675AE
	for <lists+linux-iio@lfdr.de>; Sun,  1 Sep 2024 11:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7182228286C
	for <lists+linux-iio@lfdr.de>; Sun,  1 Sep 2024 09:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE80149C68;
	Sun,  1 Sep 2024 09:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SOLDx4Gl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E2C1494C8;
	Sun,  1 Sep 2024 09:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725181942; cv=none; b=fxyt8VXOI1mk46wiwPY+QYG5JOBgDsw80O0g9vpC4Qko7FXR7nYXoQDWpBdH9QKYnvmnrR5H+EiGNNt4aEaQOqCLRb5d9AJiH7PtrCal5Y54PyaoXTvWBESAsWw1f5oHLYlHVcQQVzEy+V0YvFOZgA/3GnW86MUwTsqUorxBuC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725181942; c=relaxed/simple;
	bh=Vb61e5yxnIMUSRQME9TeUFTKhUGt8rdek04lYMhBN2I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=laf3z4jO3TXsa7P+7l9C0Q0LztJHkLSPWK9EpF3OGRqL4SG6HZlT7nDghcv7tdU2yLl7LBYQXnAaUl92Mt8xvwe8B2PTOgUJ3ARPy+C9zd6cMPiS1KcKhKxtiSgSMhdpgZXmfvJQWWaFmbe5/+7qqLOEmNmNaB0VyTDs1gyTqHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SOLDx4Gl; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2d89dbb60bdso593301a91.1;
        Sun, 01 Sep 2024 02:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725181940; x=1725786740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3RIvmqckB/XmS4jFCvRpV3k1k+SyUHd+kU2bgetmV8M=;
        b=SOLDx4GlUTnlypD7Iz8OnnVD+C+hxD4y7OqQ/kyEJ2LRkpLIlBU238vXz6OKBoJcgw
         jW4t0mQCq6TTZpXaIhJJdrg8Gi1q8ETZpeUegdDsQQbHR43Vw88vJxvgctzyClfCxHcl
         kK/4ekr6ZmuatJe5DyZciB6NIW4+C2zu/oUen9jhI48E1WzryCUbR5Bj8UYlRAMWuvsx
         7wCplEd8jlMJRN5nWLcMoPVfVmg//XRMmpaRebYwlGj9i7r6igbmPo4H3wNV+98c8tXC
         U9ff67OgGrki3RzsToy3JkjsuP3Um0kjBae0Th8iS2kK5Kzv6RA89ItMMBSSYY+8xYjZ
         6ISw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725181940; x=1725786740;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3RIvmqckB/XmS4jFCvRpV3k1k+SyUHd+kU2bgetmV8M=;
        b=hEPoWSPvy6dFF62pYv9paSn/hm3Xu3olRRFMVRpQVsWc94oKN1uMMHdYwMSE1MCzzb
         L0qXj03m4XpjyIK88Guhz4RmuZU+HXd2mEXAFpwmW3k/mxDjvBYizYlraOSTOtHRh68Y
         rbOpc5dyMrelvl50rwX6R8+B3X7QTGBsc7iE9qMml1wV4aOPDAY49i8fgxuCXerN7LKx
         yUK04DRLGVL/rWzood6KHmzivS9ScrqWu4RpMQWSzr+qslF09i+VcME27KX/8fXCNwtT
         Q+2pW6fc7P/L2QdhAy5Rus3TXcF+dfUGeYE2wdF1qk02f5KALJ1aC0Wk7D9OM1H+SeW6
         BtOw==
X-Forwarded-Encrypted: i=1; AJvYcCVUoVit7a5NSGqk275VZpXGwBNcPBIeRxgG99EnU52yj5XuuJac2f7z2iWRlwib7z6/ilvfqueVZuIAWGg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNxf6DwLmgSSVTiKtGug5a7oUzh0T0XnyEzG1Fk6FYf2GX62E6
	A1q+oq/3aYgSUjlkozxg9ebWjbZrVWyx+PnVuH2wVsEkfMjRtKeU6ya6qA==
X-Google-Smtp-Source: AGHT+IFyPw8FaR/QxQkc06MqfZ0lPGIAXmc1HESOZjrhWGxlcUaFOXRSBYhlJpXA6YFMwCvff3ACdw==
X-Received: by 2002:a17:90b:4c0b:b0:2c7:8a94:215d with SMTP id 98e67ed59e1d1-2d8561a13e6mr11460017a91.12.1725181940311;
        Sun, 01 Sep 2024 02:12:20 -0700 (PDT)
Received: from gye-ThinkPad-T590.. ([39.120.225.141])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d8d8b90e9asm59086a91.38.2024.09.01.02.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2024 02:12:20 -0700 (PDT)
From: Gyeyoung Baek <gye976@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Gyeyoung Baek <gye976@gmail.com>
Subject: [PATCH] iio: imu: inv_mpu6050: Remove duplicate code between labels
Date: Sun,  1 Sep 2024 18:12:14 +0900
Message-Id: <20240901091214.15199-1-gye976@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'flush_fifo' label performs same task as 'endsession' label
immediately after calling 'env_reset_fifo' function.
so i remove that duplication.

Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
index 45c37525c2f1..40107b4457d4 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
@@ -192,15 +192,12 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
 		iio_push_to_buffers_with_timestamp(indio_dev, st->data, timestamp);
 	}
 
-end_session:
-	mutex_unlock(&st->lock);
-	iio_trigger_notify_done(indio_dev->trig);
-
-	return IRQ_HANDLED;
 
 flush_fifo:
 	/* Flush HW and SW FIFOs. */
 	inv_reset_fifo(indio_dev);
+
+end_session:
 	mutex_unlock(&st->lock);
 	iio_trigger_notify_done(indio_dev->trig);
 
-- 
2.34.1


