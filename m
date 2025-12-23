Return-Path: <linux-iio+bounces-27327-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EEF8CD7EC4
	for <lists+linux-iio@lfdr.de>; Tue, 23 Dec 2025 03:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A0D4F302424C
	for <lists+linux-iio@lfdr.de>; Tue, 23 Dec 2025 02:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57E42BF3CC;
	Tue, 23 Dec 2025 02:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dionne-riel-com.20230601.gappssmtp.com header.i=@dionne-riel-com.20230601.gappssmtp.com header.b="b5UZXv97"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CF72BEC27
	for <linux-iio@vger.kernel.org>; Tue, 23 Dec 2025 02:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766458535; cv=none; b=IlUf9tCAwR/SNNQJKBsbpIkwWG3vaqvj89NVlayLFbh78a3QbQXMCvLU0sS3dgbtF91bHOhSaBnj0AUqHDjQbD+5vWUuEaJUiY08QNsMEevwLDo5eHZoDxK3eLu8gXXwv67x8b7a8t+anZZPg1/s2SUt/p3uPZeQccaeWD58c1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766458535; c=relaxed/simple;
	bh=R/pyaDy3Q7zpGfMK7jtEmQplZlnmXe5j1vpWw+kfDUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OE4NsQU27/3RqcXn9Xui3+jAq45g/Jgi7dBQjL5Qo/lbUSeQdGwWForI/PYhYrsAXFI12wJNjjzWnO+glgJvFZMph0JOvOHE7yRHBrQZXkkS0f00eNiytNJ/kGrnYsNq39jcHKJteM3C/+Q1Xk24ov+JUD1U9exWGHKYmznut14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dionne-riel.com; spf=pass smtp.mailfrom=dionne-riel.com; dkim=pass (2048-bit key) header.d=dionne-riel-com.20230601.gappssmtp.com header.i=@dionne-riel-com.20230601.gappssmtp.com header.b=b5UZXv97; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dionne-riel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dionne-riel.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8c0d16bb24dso243654985a.0
        for <linux-iio@vger.kernel.org>; Mon, 22 Dec 2025 18:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dionne-riel-com.20230601.gappssmtp.com; s=20230601; t=1766458532; x=1767063332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4byC3Mn7IdIEYarlTV3BJ0tOgTi1ifeHJj4YTWnTDNM=;
        b=b5UZXv974ITY1VPlleMISySbVlroR4+dBogTFdyYjLxhZ/OZkrCiwTuNxSxhnmOUpv
         +tgr+AeEWf0fBw/2ySX2egES22Wva55vNiE7SkaM4e820VmUsq7y6QSytmjUX6L2yf03
         MihrKFBf/frCDJMHJNT4W9HCjGyepCKmSNuBlc62MIUYglqeuQjvFyeYOo+Z1uvpXADC
         eTTecHZaVYmJrtVGusA9wXwJ6aDeVBr0QiMUQAteKUF0V1xqSg6kfexSInH9QqkEJ8Ex
         9INSDRgbFP/1nYaDxjAXKE3f7D6nvs+8Ljd29rXT2A8ICixxs+2BYObNli5Aaqoh8hMW
         Dfeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766458532; x=1767063332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4byC3Mn7IdIEYarlTV3BJ0tOgTi1ifeHJj4YTWnTDNM=;
        b=pSDJPjgBvFuKPLUOGc3mf3LktAZeny+DrC+UyAa3EKAxn1PmAUdQ88sA6NNknhaIeh
         PnHZNB2+LgYIKhrs51KUgrstm4eHXCIw0qRrBV+5EyO7llO+ZKmd7kFHXIbTBou3t8hV
         xosTdJRD8KfSX5xwcaGnvw8+Fn6W1pQDLdAUv+TBWeJfy+DnFjVJj+iwYHw2+xUa5M2Q
         /p0g/4jqFwEwi/X1c1WR4ZYVtI/5jIfHMandFvIv7p5PUv4tTUzM0VkD1iDO5GEbY4ZY
         /sIQSzfg05+l+j4o4s0S3LgdWr+7qO4IuurLGN1KuB6lK8lUiiz8lizHAVqVpRcThgBe
         fAvg==
X-Forwarded-Encrypted: i=1; AJvYcCWUU3lMF8Zb/2KTYaMp5lo2Sx1986Bpkr7EWGoxiUmL9RnZh5ElxI84TtP6JQhmTHN/cGXCpeqbs2o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyViZSqxNScyQ8Elhwktvt6XcekQdYZ7BXow4HRn5uIESQsz0ik
	dFwCYLwaDr2LotA/3xIQiP0oGbN72fBs7wEbn7mqP7bQlM1Goj3ki6JswoCilXyFcA==
X-Gm-Gg: AY/fxX56fx23EPeXXWucgKpg4w1h0McACbM6VDbeeOFbc2TECQK3+6XCm2HdVNVr3Hy
	goVEPlbkp94oj1QlAm1QeBTxZBUZ7NNRA5l2FdEmcnvCbP8VUTLX8epG2ngVKRvmqyAP4OVV9ZC
	qDfR11SBS93sF9V0UcrwtWcSDP6Mj/lFLHsmsVMoWtiL6jogV1Jx+Zkn+K993EUkOThyN3fN+io
	nyinonHch9PjUKco2Ktn24ndhiOXe6DV9aLb5sQD/+aUTYDs8c7U82+ZLPnwvJyETL3d5pS4U7K
	0JnXtnvyKJcQGKGY62Gnw3JBJ8gXzURikBwrAJIwtqJsU0Xk2QSXI+uk9e+b1ZjHbvdVg4DcLFy
	jC0WN10bPd/7Qnii2VlJIAlZKI7sguhbDhbrRnLXrhpHRRRUXAA9CbTuXYe3uJiXfcavOqeuKSu
	eZi2B2K5WVk7zVIcEyADi51k00HsAiAUfUBVxPNLLZbHdCwzIATcAivBWZhqY1J0jQGMUUm7jyu
	6j/
X-Google-Smtp-Source: AGHT+IE7uWWD/9WJtJidhv9TOoiEsH6kL22XXd7ZcKB4XxyaFlTJGguqeEdNjR/eFBcTx0vexKnYqw==
X-Received: by 2002:a05:620a:4484:b0:8b2:ec00:784f with SMTP id af79cd13be357-8c08fbb9c47mr2108884385a.82.1766458532150;
        Mon, 22 Dec 2025 18:55:32 -0800 (PST)
Received: from frankgrimes.elk-nominal.ts.net (135-23-195-66.cpe.pppoe.ca. [135.23.195.66])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c0970f8572sm952775585a.25.2025.12.22.18.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 18:55:31 -0800 (PST)
From: Samuel Dionne-Riel <samuel@dionne-riel.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Samuel Dionne-Riel <samuel@dionne-riel.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] iio: imu: lsm6dsx: Add alternative ACPI mount matrix retrieval
Date: Mon, 22 Dec 2025 21:53:51 -0500
Message-ID: <20251223025351.3099978-4-samuel@dionne-riel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251223025351.3099978-2-samuel@dionne-riel.com>
References: <20251223025351.3099978-2-samuel@dionne-riel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This uses the SLA0 matrix, which is how the SMOCF05 configuration
exposes the mounting information for the accelerometer.

On a limited sample size of one (1) unit, the SLG0 matrix is the
identity matrix. It is unknown how the SLG0 mounting matrix would
logically affect the data, if it differed from the identity matrix.
After all, the IMU is mounted as one single unit, its mounting can't
differ on the gyroscope compared to the accelerometer.

Signed-off-by: Samuel Dionne-Riel <samuel@dionne-riel.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 49ac17806e720..4bf1f7f7552d1 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -2707,6 +2707,12 @@ int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id,
 			return err;
 	}
 
+	if (!iio_read_acpi_mount_matrix(hw->dev, &hw->orientation, "SLA0")) {
+		err = iio_read_mount_matrix(hw->dev, &hw->orientation);
+		if (err)
+			return err;
+	}
+
 	for (i = 0; i < ST_LSM6DSX_ID_MAX; i++) {
 		if (!hw->iio_devs[i])
 			continue;
-- 
2.51.0


