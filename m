Return-Path: <linux-iio+bounces-16724-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 800FEA5BB23
	for <lists+linux-iio@lfdr.de>; Tue, 11 Mar 2025 09:51:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0336171561
	for <lists+linux-iio@lfdr.de>; Tue, 11 Mar 2025 08:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9C622A81A;
	Tue, 11 Mar 2025 08:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=4sigma.it header.i=@4sigma.it header.b="rhQFcKqG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A1C228C86
	for <linux-iio@vger.kernel.org>; Tue, 11 Mar 2025 08:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741683068; cv=none; b=Pa7EknJxf09h33XlSZykYG6kkIL9MeKJb1yxjQ999ew6Ur8X2or38gHyuL6qIudEM60iA2/gpnmgrDZn0sxPhMI5cPskedqNBLHiuw+uSHkSTnHzbVBHKNi/I4wMOgcZ3UCPEdIwgXiADIrKrU+RYWNM2+pLsOw7BVjSgIb8jQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741683068; c=relaxed/simple;
	bh=p57AsSdCyuAbESfbedFQezCRxx50/BKv2tVS78zloLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NQlUc/8eUEqf6NPhY5PX7oEJjoT5Xb7aKfZbga6sJNOjCnZEVWFhPJExGtP4XCQes5CUg1aFeaD97GO0waoE9qrcpmXSqxKyAEwnvzrC/xfeSrMwEsn1qTrnJVEFUXvWx59rXdU2gh6nS9BYOGz5G2gvp0RDC55wbNoSqMcEmIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=4sigma.it; spf=pass smtp.mailfrom=4sigma.it; dkim=pass (1024-bit key) header.d=4sigma.it header.i=@4sigma.it header.b=rhQFcKqG; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=4sigma.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=4sigma.it
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3913b539aabso1616313f8f.2
        for <linux-iio@vger.kernel.org>; Tue, 11 Mar 2025 01:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=4sigma.it; s=google; t=1741683062; x=1742287862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MwcL4HYRQdZ2nKV+qcZFfYe/5XI6eU/BnWbOOOqZ4hk=;
        b=rhQFcKqGf5SZtgYbPYQVKViEbD0mnIHANQKzzr8hOG3ADMCJrfSo7LoQkvN+4N5ZIt
         SnmBI8DT5UCSdQM3Oe7pjV6hB5Sdp7j/CHiC1R4RVrt7Sgh86KUhiP04C8Mw4OoasUy0
         oKrEK2Wlyd39X+vA/sZ+PwiiMThFvbWzoXFzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741683062; x=1742287862;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MwcL4HYRQdZ2nKV+qcZFfYe/5XI6eU/BnWbOOOqZ4hk=;
        b=I4IGYB2ZQsddCCzbkSg22FybvAKZL8oYjnOQCO2HJlRbc04hnYPpBmR4gPDpppVWwP
         xoa3Sd4zcu4r1NPda4d5Flxi178jWXmuX3A4XnEBL7X9A30ouASB6Y2O1eG3GzxbvoEN
         51AP59FCRVw9NAVHg9jOUiKdM9pD7nhyl+hUeYN8Qf9B6icV6q0FSdD0KU5RyVf3g9vZ
         GzHkweAnFvl20Jv2viyBxFetfRAVw1/WihXZDTA3OgajyZrrjfIQHoKcR0GYRQp/MoJU
         8TSTCawHbfp7rlhevJ+Ke+xLEGu5stFa3pXftl0Hz2W5OUnONDEL8B0pVnde4Z0xHXRP
         YcCg==
X-Forwarded-Encrypted: i=1; AJvYcCWGv7pw3oLTqa9LmHBSWtlGDci+wP/Hg7CPGV5YimooJdhfIMbZSdjEFWzxS7LOBn2SQhA5KJqNPWU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJS3e7lE352ueWdRLxetVhmdxXlmxEYhT0qyNr9AFN0/v8XXPx
	B0H95AJE/e9yifA7UQaAYvClz0goycmYuXRUwtneBXCMUC7km1jvp2tnKkB9QQ==
X-Gm-Gg: ASbGnctuXDuC+zyqGkTRw5wrmz/rwRR83xAA/cJ8sJ7Lz64lIzkm2AFrnCJV8rFDHvh
	lHj4u2O7NfPRPTk7bBI2aUuIE6WTqJ9UUmjF6rkVoa0fI+fYxdpREYMGHbibonEFzMvPtCgbCKw
	Y/Y6rVT6sGtrGyC9eVJAgBSJD6obh080bj0EmJF4b7GtYvTxIoI6xPR3bYhBng0vICdh1UzN59S
	Jsje7by1rvv9gdBn3qKk0rDAoCmqkg0O72ZJCZc0INFCQFZf4sq1ZB2Md6qgZCYNvA5B5+yFL5p
	ngg3zkbRRsTGbGBS84Z42SvSFKXstFLDEH19dcW8u2Q6xnQSre9m+s7EmxQy/twy9unnVzFeNgf
	HSrnIw2g=
X-Google-Smtp-Source: AGHT+IGk3N4ePEA8O4L8AME/TM7yCODZZG/WNCNcAMHPSuNIq2+J+9DDvIGH7pXqN6oDdgLo5zzbfQ==
X-Received: by 2002:a5d:5f4a:0:b0:391:22a9:4427 with SMTP id ffacd0b85a97d-39132d3b3ffmr11551870f8f.12.1741683062563;
        Tue, 11 Mar 2025 01:51:02 -0700 (PDT)
Received: from marvin.localdomain (83-103-103-194.ip.fastwebnet.it. [83.103.103.194])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c01cdd7sm17746333f8f.56.2025.03.11.01.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 01:51:02 -0700 (PDT)
From: Silvano Seva <s.seva@4sigma.it>
To: jic23@kernel.org
Cc: a.greco@4sigma.it,
	Silvano Seva <s.seva@4sigma.it>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] iio: imu: st_lsm6dsx: fix possible lockup in st_lsm6dsx_read_fifo
Date: Tue, 11 Mar 2025 09:49:47 +0100
Message-ID: <20250311085030.3593-2-s.seva@4sigma.it>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prevent st_lsm6dsx_read_fifo from falling in an infinite loop in case
pattern_len is equal to zero and the device FIFO is not empty.

Fixes: 290a6ce11d93 ("iio: imu: add support to lsm6dsx driver")
Signed-off-by: Silvano Seva <s.seva@4sigma.it>
---

Changes since v1:
* st_lsm6dsx_read_fifo: moved check for zero pattern_len before fifo_len assignment
* st_lsm6dsx_read_fifo: dropped check for zero fifo_len
* added Fixes tags in commit message

Changes since v2:
* split patch in two parts, one fixing st_lsm6dsx_read_fifo and one fixing
st_lsm6dsx_read_tagged_fifo

 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
index 0a7cd8c1aa33..480a9b31065c 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
@@ -392,6 +392,9 @@ int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw)
 	if (fifo_status & cpu_to_le16(ST_LSM6DSX_FIFO_EMPTY_MASK))
 		return 0;
 
+	if (!pattern_len)
+		pattern_len = ST_LSM6DSX_SAMPLE_SIZE;
+
 	fifo_len = (le16_to_cpu(fifo_status) & fifo_diff_mask) *
 		   ST_LSM6DSX_CHAN_SIZE;
 	fifo_len = (fifo_len / pattern_len) * pattern_len;
-- 
2.48.1


