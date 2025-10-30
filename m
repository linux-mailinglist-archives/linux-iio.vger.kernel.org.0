Return-Path: <linux-iio+bounces-25642-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA97C1EC00
	for <lists+linux-iio@lfdr.de>; Thu, 30 Oct 2025 08:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CC3D189DBE3
	for <lists+linux-iio@lfdr.de>; Thu, 30 Oct 2025 07:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF8D33893E;
	Thu, 30 Oct 2025 07:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="C3dX9SNh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FC4337BAF
	for <linux-iio@vger.kernel.org>; Thu, 30 Oct 2025 07:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761809284; cv=none; b=dBwP521U0c5XdWi0gWgH9mvdyPDMAXVf3g2vtlr621OdX1fIUAJISBe6k08x3sP9jeu2zSvdKAbOtACBMaXM36giQwWozI6FT/y7x9XPxxIwd5Tj/oOy7hq4GmsW+77lMauhKFaMUfuz9ZUVKyFLAF8lfDRqGFLj8B9AK6AZ0QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761809284; c=relaxed/simple;
	bh=b7Dh9immXL0raytQ5VJzXmvSgU6Eg8zKWr14CvTFrQI=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BCil9Lay/ZgOq4d+PEw+NZwbcvLkFatplqaE4+6WOsCJKVFZM5LdrC5k79W/CDRbB5b6P/q1c5UvKbdeMDRAHmt0I86A0DuvnuJKUO5IOq1WY75nuEOOkkRPT9G8u1ApZbUDtD2X/wm1spFFxZBDpPOTvGyDVhtYcVkYSIu+dUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=C3dX9SNh; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b403bb7843eso156472066b.3
        for <linux-iio@vger.kernel.org>; Thu, 30 Oct 2025 00:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761809280; x=1762414080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QT0z8mODIZIMMuRwFEf11FLhr8FVbk/1fZHt5oodyj0=;
        b=C3dX9SNhczqtyCYSvYL5QQBAa7+SPSYyEJH1vomMZhVcNlTwD19YC/wUwVbl4+M8vk
         lprtnjdrdA2Dt/0R2T0hp/YZ0Rwp+7WRP57Yqjf6QxuUzt7JQrUg9w+a94BSaDeTy/ZK
         W05OkJq/nBNL3d+KIvFZS54k8NaaMfw5L7RW6jEIRC5RhTqB2L6yvxeppoJRFMV1aBvu
         VusShjPgEn/eAWXtrq/NU0AWcDf7Rb2r1ymR0woPxqkTSevvz1cByaulYzHFdeLbjabX
         8I3pMBVrR1Lgl5X+jppC5NmF0vo1vf6GP2mdbgaBY+otMp56qi/sw95nArqEuj1aP4C+
         WvFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761809280; x=1762414080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QT0z8mODIZIMMuRwFEf11FLhr8FVbk/1fZHt5oodyj0=;
        b=oCqQQdkmQa7xMP5fq/Ph+kLVrxQI9mu9p1SohsRtC7ELzuSWsQePb4OmFT6Lt60Rzg
         Mg51LaiZDisyvjtwL1BJKl62T7dsgwJplmKOkER6wv6VhTgnyeLD6JOD3mVR2nQFM3wa
         +qKSiPDzYODaiZtCY0QMNKzx6T7jkROo4ahCKHB8th0slxBUsDL++3PACpvZ/mFLEYA6
         cSBr6GhebI7sjv1EA/l/VfsC1F39iIiJ+N07cIetjdj9hKqhQkusJRcBzAzs6jedg+du
         1U1COAu0vIiO7z3BFHBTjDOWjYAIpcTfb8ljNu7k+ELt53At63mW3icXGX964s2tiqat
         SZHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUn4fenOUv9bIpFrHuYXn4YQPt7cjunYKnorSUBKWyNCfuJygpExZFWaDBKSP3c2kzFOuLwgpRSLVE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ26gqcnS4ZYLzHqTci1NkjGjg5VTw2BlDTkhVDr5623yexcif
	4SsXTjiDY4/lhVSI9bwsJo8CMnugONasgsf6DWZ1mI3efqvrolTBs/vq9Dr2/+G66fI=
X-Gm-Gg: ASbGncspPyPys0j9kWifZOpOEv+SK/Xn+h1dU4faNFmMCHVKF2KdkrBmWexVEr4/pby
	uxKNRLHVy9QU3TGjkUz62Ehbq01TOH4MjqDuyz1SMmgag1sHI3RQG1uMiJVQzWU3qBHHAtVNJt0
	w/uSRBP56Hp0EQ8TsV4+oh5oFniI5fQehuKVFDTKsxWwpLJsLGMITyts8r/DYIZyK97crGCUEFl
	BK+9knyuwDcXYe1ZMpOTk2xCs0+DD9kxhDh++2WvhFv+ppBkSafdLfg8EvP+kfbN1z4QgOcndUr
	xPlbe9lsFEKe8iZFvC/SssGwKjQDRsB4t8kOws7VOHpP6FEeojhziml9FDmbQ/cMeUgIr59+8HT
	SoSy9X1MRIaAmRN2M5TdtCKYuGqo0ARV6YKXVrzdmxmLrFrhDPXKYX/UBYkYkmDuBw2THS3cf98
	fNO2KZ1kGGbnIHMddE+4z7cARV0g==
X-Google-Smtp-Source: AGHT+IE28vhagzBIqtsvFMlUCSlRCxRphCpZDF1Ly1iiRyJKZCT9Fu6Ll5Quw1HqsG9dFJn6ANMnnQ==
X-Received: by 2002:a17:907:2da0:b0:b47:de64:df1b with SMTP id a640c23a62f3a-b7053e097aamr189683066b.39.1761809280322;
        Thu, 30 Oct 2025 00:28:00 -0700 (PDT)
Received: from localhost (mob-176-247-57-96.net.vodafone.it. [176.247.57.96])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e7ef8288asm14128438a12.10.2025.10.30.00.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 00:28:00 -0700 (PDT)
From: Francesco Lavra <flavra@baylibre.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/9] iio: imu: st_lsm6dsx: remove event_threshold field from hw struct
Date: Thu, 30 Oct 2025 08:27:49 +0100
Message-Id: <20251030072752.349633-7-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251030072752.349633-1-flavra@baylibre.com>
References: <20251030072752.349633-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2449; i=flavra@baylibre.com; h=from:subject; bh=b7Dh9immXL0raytQ5VJzXmvSgU6Eg8zKWr14CvTFrQI=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpAxNK2vYG8vGV/Fkd4xN4etrjC5aDxbKlwjtbe g/iAEenn6iJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaQMTSgAKCRDt8TtzzpQ2 X7B9C/9Dr35JbHqe3T9yYUEs/dpWOJDYkCA024XIf6eIPF2OaKWYtW7tl/o0lpmzEzazRXH+zEl O8HEcPNs/JSm1mg602ZOV0TO5C9FTNehbpBBZN7SdQZG7e3inJDqyxG3DAU8yHiigNmlVi4PcKU ialKHxEqWkVwj3aDHkblUBYRKxBy85PMnVo7MzaTTj7xeqs63A2VSL1imLFjZCqe0p1VPjKx/M9 m4I+OTDyeag7b2W5ZIKZ2y1goXaLvFwzzPrfuGB1fC7GpLKnlDwzrOo4JxV+plynLgnDn+UfObS teeVRfVjITra8nmFE/sdumDhBo/zw5VBWqhUnzi4T/Oxd85gz9vHgVN/eQghjLsGLSFmzl+X8l7 KAuXajxfiaEoN8UEs8IPxatmY5StDjVD3sT4+4pptEWXpecrZU9T5538+W6eFOeQ7qGizGsgBXW Ax8nyGxhNB3Vlmu4MW/LLOGJrc46RXHjoqolVPQ2VwXEUmkl+wKfPxqrOM0Qqm2+hjIsA=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

This field is used to store the wakeup event detection threshold
value. When adding support for more event types, some of which may
have different threshold values for different axes, storing all
threshold values for all event sources would be cumbersome. Thus,
remove this field altogether, and read the currently configured
value from the sensor when requested by userspace.

Signed-off-by: Francesco Lavra <flavra@baylibre.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  2 --
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 12 +++++++++---
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index ec4efb29c4cc..98aa3cfb711b 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -398,7 +398,6 @@ struct st_lsm6dsx_sensor {
  * @sip: Total number of samples (acc/gyro/ts) in a given pattern.
  * @buff: Device read buffer.
  * @irq_routing: pointer to interrupt routing configuration.
- * @event_threshold: wakeup event threshold.
  * @enable_event: enabled event bitmask.
  * @iio_devs: Pointers to acc/gyro iio_dev instances.
  * @settings: Pointer to the specific sensor settings in use.
@@ -422,7 +421,6 @@ struct st_lsm6dsx_hw {
 	u8 sip;
 
 	u8 irq_routing;
-	u8 event_threshold;
 	u8 enable_event;
 
 	u8 *buff;
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 157bc2615dc6..ea145e15cd36 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -1825,12 +1825,20 @@ static int st_lsm6dsx_read_event(struct iio_dev *iio_dev,
 {
 	struct st_lsm6dsx_sensor *sensor = iio_priv(iio_dev);
 	struct st_lsm6dsx_hw *hw = sensor->hw;
+	const struct st_lsm6dsx_reg *reg;
+	u8 data;
+	int err;
 
 	if (type != IIO_EV_TYPE_THRESH)
 		return -EINVAL;
 
+	reg = &hw->settings->event_settings.sources[ST_LSM6DSX_EVENT_WAKEUP].value;
+	err = st_lsm6dsx_read_locked(hw, reg->addr, &data, sizeof(data));
+	if (err < 0)
+		return err;
+
 	*val2 = 0;
-	*val = hw->event_threshold;
+	*val = (data & reg->mask) >> __ffs(reg->mask);
 
 	return IIO_VAL_INT;
 }
@@ -1862,8 +1870,6 @@ st_lsm6dsx_write_event(struct iio_dev *iio_dev,
 	if (err < 0)
 		return -EINVAL;
 
-	hw->event_threshold = val;
-
 	return 0;
 }
 
-- 
2.39.5


