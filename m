Return-Path: <linux-iio+bounces-8923-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82822967656
	for <lists+linux-iio@lfdr.de>; Sun,  1 Sep 2024 14:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4863B281F45
	for <lists+linux-iio@lfdr.de>; Sun,  1 Sep 2024 12:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE61A16EC1B;
	Sun,  1 Sep 2024 12:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QLtC6au6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3F71448D9;
	Sun,  1 Sep 2024 12:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725192526; cv=none; b=LnjtE53afZTwNQLroaHKpl0W8qdwW5v3G0k1nCHlkLV3q/L99QjV2xLidXJm26iu6v0QAbWLW8adVyA3tA9sECW/a+QNDt5SBYkaYKu3Gxr2nsPgVUsz1Un8hGz9tkjAcUn11uKfR47W/MgrKbUXjAtFBhPcXfORrlM5tRgsd4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725192526; c=relaxed/simple;
	bh=905dsb/JEMhkKQnTOYyihCyX7pPHaiJH+4Elw2hXlk8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eSw7rLSl8u+rHfPO1m2lDDj2DfOG5rSxShyp6+5Qcfdu+GLTGXV3+q2ScSaJr2IkZl3NPMnjOhv4cIREgNy8G3AdJNpp5hhOhz51FzZIYdFjh3OxrJudC1Mh3c557o7xpMye8jeJerIPiXM8p4/zc4Q1kANhyJe5fMtzOJPHsSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QLtC6au6; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-76cb5b6b3e4so2064019a12.1;
        Sun, 01 Sep 2024 05:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725192524; x=1725797324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8EMtUuyXl2YytpaXFrHHwYtzfmbBhMr/hxZuhnolDH0=;
        b=QLtC6au6WH2/O18nFCqssC+Uzzrx6AhyVfU2+P2f8sHQfDVEn1cwuy3l4SgFxai5kW
         CCYfz/oH7soO3KagaFAY4yqz25CY+3LlotglASlo0o6trFpA0mfvPNMZh+0KzjGiIVwT
         duSwYPfJ3nVKRs43TeyJ6Mpu1A3HvKj7k7jnqwxCR1fUOvZNJsdmRNozQnlqbqaTofQB
         BxUhqunTPy1BEvyvLAr60CK0y9cO4w2qwqnu7tOv5uKAh1zi7JV0Pz3IsBZe3zTf6j2Q
         rpNk60veTPch+gnkthnJ1ezmPqX8GjjuumbCZK30ZD03ozkWkvMNv76vK/SzLsh/2sV9
         owCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725192524; x=1725797324;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8EMtUuyXl2YytpaXFrHHwYtzfmbBhMr/hxZuhnolDH0=;
        b=JRTIotffVgBgclwBrvnqhVLvwXh9LEOYVoFe5zipC9ZATiB5qUtYNXX2IiniIvmPNN
         uGb//dtnu/ALCi/04l/Ew11/wOR++fVrxtQ9kB87P1qjrflB3JeN3sfTYEwwEBng9uOx
         BU6jxzQrLweLzaIH3FDyUJrx83T8ArQPijiIBHpefh265EK8k88pVMgZQrrRocxvhybj
         ZwJeG+dCSy/9wosm2X2Ac6EU8MfCwXX+ckh0cSQMQixICoQz3Q+v0oz5fz8Il8c6+Q0S
         rDvaYXoX0PTRaZE42oz4tACCwac5gPUqGVc984EACMGvnTwTOxYLGRf8ornb/VLU2Iny
         0udA==
X-Forwarded-Encrypted: i=1; AJvYcCUNVNt5a+r84v/xNrSvlu+XGPAHK42RQOuEnoh1fdkmMF6s04G0YH87Ee0S8TGtcPj2neblcU52ti4=@vger.kernel.org, AJvYcCWq0xtep7RL65UDycdfaGiBmC3vFUILIL9Pv2t6ArFYjsFJHM7fqHK/gN3wd8EQRWdqkJG5ewa+lRNHc3U0@vger.kernel.org
X-Gm-Message-State: AOJu0YzJx4q9ZDeNeJcqiFVh1RRBgl5O4Y8ayFwlwdpfyOoH16Gx6w7n
	AkipNk6ccPlGQqypTZ46nZl/xdyowYBAHdHRem0kHTxyxA1xNwgF
X-Google-Smtp-Source: AGHT+IEgYlGXwyKGlaJXivPc/8kz41LyvGax4wHff0PY88+KQdRoCq6M3hLoYki95eqCjyO5Cd8Tkw==
X-Received: by 2002:a05:6a21:670b:b0:1cc:9fa6:d3a6 with SMTP id adf61e73a8af0-1cece4d6dc7mr4184545637.3.1725192524476;
        Sun, 01 Sep 2024 05:08:44 -0700 (PDT)
Received: from gye-MS-7C82.skbroadband ([121.125.115.206])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20515534060sm51666415ad.143.2024.09.01.05.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2024 05:08:44 -0700 (PDT)
From: Gyeyoung Baek <gye976@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	jean-baptiste.maneyrol@tdk.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Gyeyoung Baek <gye976@gmail.com>
Subject: [PATCH v2] iio: imu: inv_mpu6050: Remove duplicate code between labels
Date: Sun,  1 Sep 2024 21:08:39 +0900
Message-Id: <20240901120839.9274-1-gye976@gmail.com>
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
So i remove that duplication.

Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
---
I worked on the wrong branch in v1, and reworked on the latest branch.

 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
index 3d3b27f28c9d..4753016d6ee0 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
@@ -121,15 +121,12 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
 		iio_push_to_buffers_with_timestamp(indio_dev, data, timestamp);
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


