Return-Path: <linux-iio+bounces-27945-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D013D3A471
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 11:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17E3F3135674
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 10:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091CD35971D;
	Mon, 19 Jan 2026 10:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2JE4x0ZF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49FD357724
	for <linux-iio@vger.kernel.org>; Mon, 19 Jan 2026 10:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768817096; cv=none; b=JZUYC/H5y99rN5nalvAh4nO45/3+exytSap7hpMhPL5qIgAA8UNDXn23BJ+LfAy7rXkPha74U+vi25z51mpgX4RpFQnFOPR8LlWJjJetKH5/e08FXxFzGg/USDdWt35B3c5NNhrYrMEqtTdrjOKLaRsAdjtpoFFPEIzxICzuErQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768817096; c=relaxed/simple;
	bh=MkM0A/HsyN7aXTv8muMJJ3kq/6hFQVpMJ9om7R8iWDM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fNqgKtK8pWVlRjlzeSIHWtlnhW/4PtRrnal+awHmyEt+KjqAGIp6edKQlwqKyYPWA1Cpp92v/OmebAmhX6EfJpWe9Y6DxDkfrkGjR0tjCfwGzVPPRSu0+k3Qg0sN+MosMgOGicHKuN3HpFDCsyLzhAMl5wzMWkQjZe8SprPmwwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=2JE4x0ZF; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b874c00a3fcso666514866b.1
        for <linux-iio@vger.kernel.org>; Mon, 19 Jan 2026 02:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768817093; x=1769421893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X2z+T2tcANuxuNpL/O66Pi5lTdKISXJnPtDtrt0skqs=;
        b=2JE4x0ZFFIF59kIBSF8mPvAv74Z2IzHmNVuV7afNvrhHDfuzYzvvW8QMCG5UlsEhHf
         bJL2g5IQ6nH1194PDd7Pfc8Vv7tpoasg5VgTxBbIyD/flWkmB+l5MtYc2dgmfHvSUvMp
         QLsjN/IAo9H9bQmeir3htoGttjVkR8A0bo6/mvAo8PiR0onEStVlr9SiVHq/ef+8x7+M
         m3EkzTn0I+3Eu6ENpWaNbJuUEyc0zzj9+LMaVfcybNesLx4h1vANmgwO7i1UhFEueiP5
         Ydohiis6qpKbCzLFLe9IQkCa8km7/N77WVeBKb55ByaBU/IaLfriXveVuJnAjxmYEYLE
         4n5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768817093; x=1769421893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=X2z+T2tcANuxuNpL/O66Pi5lTdKISXJnPtDtrt0skqs=;
        b=KjgHRydaJ2iNnYAkRsxi2xGBMRyoG6Cqtepi9S7NXbzX/FohnqEVPjoBC/GCVTsXuc
         E96SD62PaRpHHHNipGSJ2/XzpfjIn89ZEU2so+Gv/MUO/o1UA9xTCk/SPOyYJ7yyhZkp
         WshQE+BI5vm7ZeYpzUr5Jg4e619MA8cq3l/+bp+Ho9CYwpmbsXor6cNI9GrQI08QtPF7
         fsY50sxP0HWVHr1G0RummmJl/MVCd3HqDimU6aY+Tvin8BDaS9GRxvjP56Qu8GyoNY4J
         D8bOCMRDqEwgPJfSleL8gnG5oQ92vTJvwWaQ0idb2zbfheMqTjvTfgSv9yg5HzBzSJ2V
         9nXA==
X-Forwarded-Encrypted: i=1; AJvYcCXsFGpGa4KgEEpLDEKJ56IiIMSsMVcY2GEKESvKcW0tjFL0yztyVB3ul1/7IcApxSRQB0iJLFevAiE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7zSLVr5pOxu+dRUnRVsmJxbCGyUyR559r5A2PL5xCmiECMY4q
	CfNlsPVlqpN+8n7xepkuRQ83pQbC2Hd2TK0/jDd7JSdSEbe2aM1GJNeuHuFbWFF8gP8=
X-Gm-Gg: AY/fxX4wXxMUQVuOItbMfIfeH+ql6T4ISlF874wWJbbpyi5N3q6waCxYw4Tj11tiFub
	ktNmRh5HfGenvT4OlLStGfszkWc1hSszKyxxLnWDMhhY3tPtW/RB1JGhcNzYoWI5ZraAwo1mxlf
	3wMVE/tQgBfVa8Bb62JP+DaffLUFi/LT6cdwNHsWVekjDFA7qPPCxXCvUlG0u5gNdEHPJURLxUy
	VJqIRU4V56l9RXyNBofxwtv+asK4Qd8UI4f64hxuMbx9BxsoB0CkLKuEyfPyF2+hNVq478Jc1iS
	7oL2CelCR8x3JzvMKiVe554oSWBmxaT2C2KwRHKXzIpjwZKiUjfim1OA0ylu8mTdDj4hl6b7PqL
	dLsSEQAiGRENfTjYzNw2fberPx5B2yCHZtrN4cT1FhXQWmRfsuo1/UEU=
X-Received: by 2002:a17:906:7305:b0:b72:a899:169f with SMTP id a640c23a62f3a-b8792d6cf8amr1035219366b.4.1768817092791;
        Mon, 19 Jan 2026 02:04:52 -0800 (PST)
Received: from localhost ([151.37.196.5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8795169dd6sm1121075766b.27.2026.01.19.02.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 02:04:52 -0800 (PST)
From: Francesco Lavra <flavra@baylibre.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] iio: imu: st_lsm6dsx: set buffer sampling frequency for accelerometer only
Date: Mon, 19 Jan 2026 11:04:48 +0100
Message-Id: <20260119100449.1559624-3-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260119100449.1559624-1-flavra@baylibre.com>
References: <20260119100449.1559624-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2119; i=flavra@baylibre.com; h=from:subject; bh=MkM0A/HsyN7aXTv8muMJJ3kq/6hFQVpMJ9om7R8iWDM=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpbgGpzekMRgLVMzJRzGAWVnmajJ5v55zV0IGmF GehD4DC7SWJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaW4BqQAKCRDt8TtzzpQ2 X8vODACCXUbvZQprbWo5N0TTH+AgAFSCd8P2nUdAUySttBuiD4x+6cjnSXKha2V2xdldqUez0oj BxY2QKviGb+B+L9KbczmjbbJBcRS+8tVk7G0+5xJfTOBzxIFP+4DNFNzVrgo8nindu+K4FJfrvA /FklhRA21ROu4tO4DdQYKUUMBIqQTimyX3tIGRJJEtfR0lDHwuBQfQkUSz0LvcT6jTne7nB2s3R PVTvYSRQ5cvHcMMs8hdVVas9AYz1fb/AKKnfX5Ay+QjBtu5clv6NhiZ5IwHbT9ButvQ5yH9XKBm Mk+oHVveCVIotqEqWsL1ldvt2wczWIyA591JlpgdjnP+81z2i6lZHGQpTrEi0DNLE/zoU6pp9j0 jhwdGPotfG1AOzmmW7oI9hYfrT3uWhPq1cl17uFgiBHCWY3vIRJw5Iy39lly4sn1TImPSfSWtoy CPy+/eJ+hujserj5uNrZztD+M6wWwzPv9+f+dlivEx13cWIPTzu61r04GSDkh+eTMIUrY=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

The st_lsm6dsx_hwfifo_odr_store() function, which is called when userspace
writes the buffer sampling frequency sysfs attribute, calls
st_lsm6dsx_check_odr(), which accesses the odr_table array at index
`sensor->id`; since this array is only 2 entries long, an access for any
sensor type other than accelerometer or gyroscope is an out-of-bounds
access.

The motivation for being able to set a buffer frequency different from the
sensor sampling frequency is to support use cases that need accurate event
detection (which requires a high sampling frequency) while retrieving
sensor data at low frequency. Since all the supported event types are
generated from acceleration data only, do not create the buffer sampling
frequency attribute for sensor types other than the accelerometer.

Fixes: 6b648a36c200 ("iio: imu: st_lsm6dsx: Decouple sensor ODR from FIFO batch data rate")
Signed-off-by: Francesco Lavra <flavra@baylibre.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
index 1ee2fc5f5f1f..5b28a3ffcc3d 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
@@ -862,12 +862,21 @@ int st_lsm6dsx_fifo_setup(struct st_lsm6dsx_hw *hw)
 	int i, ret;
 
 	for (i = 0; i < ST_LSM6DSX_ID_MAX; i++) {
+		const struct iio_dev_attr **attrs;
+
 		if (!hw->iio_devs[i])
 			continue;
 
+		/*
+		 * For the accelerometer, allow setting FIFO sampling frequency
+		 * values different from the sensor sampling frequency, which
+		 * may be needed to keep FIFO data rate low while sampling
+		 * acceleration data at high rates for accurate event detection.
+		 */
+		attrs = i == ST_LSM6DSX_ID_ACC ? st_lsm6dsx_buffer_attrs : NULL;
 		ret = devm_iio_kfifo_buffer_setup_ext(hw->dev, hw->iio_devs[i],
 						      &st_lsm6dsx_buffer_ops,
-						      st_lsm6dsx_buffer_attrs);
+						      attrs);
 		if (ret)
 			return ret;
 	}
-- 
2.39.5


