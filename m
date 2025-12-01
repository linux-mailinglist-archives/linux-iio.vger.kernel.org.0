Return-Path: <linux-iio+bounces-26586-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EE42FC96899
	for <lists+linux-iio@lfdr.de>; Mon, 01 Dec 2025 11:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A8BA74E137C
	for <lists+linux-iio@lfdr.de>; Mon,  1 Dec 2025 10:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E336F304BD0;
	Mon,  1 Dec 2025 10:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="IM2bHuVZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F286630496A
	for <linux-iio@vger.kernel.org>; Mon,  1 Dec 2025 10:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764583245; cv=none; b=Rv8yEENn7AgfjrZQJ+7guMLgLWKNPg4G2Bc8ZGAuPff3ojnr0Ztv/9dhlqSK/qdgv9xovrutxRwauSneInOWaUkYVP2yGeLePioSnEZ6plA0Ta9jfWT9ZFfvUJXXp4gjaCa2XZDsSG4BubVBgpqE8smRkEy8gXEd/UCXqbmrElA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764583245; c=relaxed/simple;
	bh=Hb1zr2alwVQYcp7QMo+P9C4EGA5XkhpF1f4WPadLW7c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DIxuMug7vYbq3oaMPsLXRIeN4EhYy8Yulcug1HYpzIJoOQTTHgsOBFqIEiQbbod7a+WEz6JDT2vXU+caFFw+9nDOCC4Eo6EJAaS0JeaCqv1oeVognKOmmOHLVk45D/oMQ5xhZBwL4w2ltnNo4mBdOYJ8z7D5Q4CVfGGMrzwpAgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=IM2bHuVZ; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b77030ffad9so438150566b.0
        for <linux-iio@vger.kernel.org>; Mon, 01 Dec 2025 02:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764583242; x=1765188042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UfRpMGSd7y9d0byFFdqTrDp2AlO8u4+9bS6XzrmHfjQ=;
        b=IM2bHuVZVj7TEGeea62sVbv129+HpSuMrH3EFduTqKtSy/qLw/UigE2AiYGGxUaHdB
         zbm0K6HwdE0er1fG2tDjR2jkR/XPoJ8u5EWkqanhABFF4IEX69KMXman1C06YeEE3/fs
         nHIoIXcdB1S73UPgsh4jQB7uJkMIuPDT5k1elOob0qLrsoHi83v6rZRZKjcSW3zRZIju
         q3Xc04OTs6b/j21t7o6x2D8rb2mtQPm0f8SfJvR0sKZVKYTAusYyjrHKAxtXxWOhroQn
         AK0dhlAzqPd2x+OaGpD98z0P8akb3SA/CcfqPN4X4Xyil5KWO7PYDdVOwGWRCTgGUbpQ
         d2yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764583242; x=1765188042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UfRpMGSd7y9d0byFFdqTrDp2AlO8u4+9bS6XzrmHfjQ=;
        b=T9uR0kn/Yi1SgPGm4dZ+DGYh++WaPgDtILaE9kTI8ppMeeeUvnid9euSJi1JSL2aVm
         ZLPUHKtf1+yHlN6tyg15nS5OosPlwtxsGQgnr1sAazsJdl1wVP+xXB9HyfOKFItBpx30
         mxjxNg9ZHloj1ZZdvZ3i1PKF8EVQ7N12JGU/AhLQSzoQocB3aWBjoMrC2xqsVvaY6NKs
         O2SkWxQy365XA1Czdco/fPhhF3bzpoI/4lhkUrb0Wnzc6X3aUEt4n2nZAIODzEonyUeI
         T7tAD+KKWH0rMKnyBOyWdap6m/ZRUdhGWViKT7yg9fBA2Gn88lodTdW+jtP4Cs9Y+5ZI
         mjGw==
X-Forwarded-Encrypted: i=1; AJvYcCWcqiH3SdFyqRzKws/HPgEV5FuUE33eenU5RCAMRXQV61PvzlIAGYYFjQ5vqpSGJoQDL46kSByRhKc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQVsw8xis4rYH9J05D+0zolKQcELha1I1c2QfblKsJPRyyxHsg
	7tTMIoG52/YjfxeIe1q3FkLlQeLIonGgH7UolFBRHXi7D77CkpbuzBy93RS9q3jPGL0=
X-Gm-Gg: ASbGnctvym70MARLMREzQRuTmYLCx9xS/2aAgursx/0HSnUJOCr6zUdLAiyXJQlCVT9
	aScNzZac3BNseuLt/Jc4TOwgWuDcL28jFcH5RNevt5MgiYxhUi2HE48NQLt7VuEpifAGXme0P9M
	NtpfWQgx26iwvK9pCxd9flf9F4Vw5/U4PyiambsS18xGVmnzGxGLosFD7AzX84rbRzLPgu40XNx
	jAG1Mn0BK2nAmpUfL/9r2f04mC+1QDuOHL8PbNkEMmxU8V6Fz+WKWwP+3KBx4QNZS9de+SA6McI
	enQT9ayjgLLMG5JNbAXgB7DCKTfn5pDurTdVvJ30vzPbpVhaWSpoJk/Zhryw0i45btoTHJGG2En
	dBF2cH47AdD+8xUczBFrpH6glvjar/dYWKGSmOmQkd6GxaWYtbTavIYshEPRmZs8bKIY=
X-Google-Smtp-Source: AGHT+IFG/lUWatn33AA2wWd09wsuBnOWD/+GXbAzbWeEhM/nMJxl9/I1ahJbDtANZJeZXogum1i+fA==
X-Received: by 2002:a17:907:3f9c:b0:b73:7f1c:b8d8 with SMTP id a640c23a62f3a-b767129709dmr3735719366b.0.1764583242142;
        Mon, 01 Dec 2025 02:00:42 -0800 (PST)
Received: from localhost ([151.35.151.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76f59eb401sm1146916566b.54.2025.12.01.02.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 02:00:41 -0800 (PST)
From: Francesco Lavra <flavra@baylibre.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v4 5/9] iio: imu: st_lsm6dsx: remove event_threshold field from hw struct
Date: Mon,  1 Dec 2025 11:00:14 +0100
Message-Id: <20251201100018.426749-6-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251201100018.426749-1-flavra@baylibre.com>
References: <20251201100018.426749-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2908; i=flavra@baylibre.com; h=from:subject; bh=Hb1zr2alwVQYcp7QMo+P9C4EGA5XkhpF1f4WPadLW7c=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpLWb5TjcYUfLEOFcXnMU2lpB8wmZGiiVcFvMuJ mTWraWzVvOJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaS1m+QAKCRDt8TtzzpQ2 XwKdC/4yPo7OYLrz2wCIsqz/WNMYNbCJYj/1+95VGKLsCkOXpR8oYV7vAlTH6sS5WCHSrXyI0qL ARftaaLJ7AFaMnmhHXcnDKe0tYSO2zpB58PaX/WCdC1o9yrpjTsTt25tkXzmVWptUCg6vZbzCFO wod86tUpQrouL6wF+6Lt8lyfWpAOyqLEvwYJLXB6FVnSo/wscOgTimLrP7IMhx6SQxD/IfpxsqF k0HqN6WHFWm7pWtsTK7FKLlzWamHPjs3vM/mi8dLYnMrLr2A3nuOX3aWR8LexqXL9sd5EUD9gnE Z4EN4K0dNt2sAOaRL7RUptxoeqGedlkitwI1c8t4vOr53/nP2BSuZRMhn1bqO3hyJEtnRfNC/sn K9WcgxYk87GiQeKxHGn1GH+HleAl+NrPYGo7xBgwUv3zi9NvmGAm23UmGOitWxDmAS6c9omBv/z Hfm4gpRUBPjEBP6r6UecmNFlvxIoMDc4w0HVcjpbvVWTebuJ5IX4rmvpPRUc5zaN0+MGM=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

This field is used to store the wakeup event detection threshold value.
When adding support for more event types, some of which may have different
threshold values for different axes, storing all threshold values for all
event sources would be cumbersome. Thus, remove this field altogether, and
read the currently configured value from the sensor when requested by
userspace.

Signed-off-by: Francesco Lavra <flavra@baylibre.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  3 +--
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 12 +++++++++---
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index 4200e5231950..b27a833d5107 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -79,6 +79,7 @@ enum st_lsm6dsx_hw_id {
 #define ST_LSM6DSX_MAX_TAGGED_WORD_LEN	((32 / ST_LSM6DSX_TAGGED_SAMPLE_SIZE) \
 					 * ST_LSM6DSX_TAGGED_SAMPLE_SIZE)
 #define ST_LSM6DSX_SHIFT_VAL(val, mask)	(((val) << __ffs(mask)) & (mask))
+#define st_lsm6dsx_field_get(mask, reg)	((reg & mask) >> __ffs(mask))
 
 #define ST_LSM6DSX_CHANNEL_ACC(chan_type, addr, mod, scan_idx)		\
 {									\
@@ -421,7 +422,6 @@ struct st_lsm6dsx_sensor {
  * @sip: Total number of samples (acc/gyro/ts) in a given pattern.
  * @buff: Device read buffer.
  * @irq_routing: pointer to interrupt routing configuration.
- * @event_threshold: wakeup event threshold.
  * @enable_event: enabled event bitmask.
  * @iio_devs: Pointers to acc/gyro iio_dev instances.
  * @settings: Pointer to the specific sensor settings in use.
@@ -445,7 +445,6 @@ struct st_lsm6dsx_hw {
 	u8 sip;
 
 	u8 irq_routing;
-	u8 event_threshold;
 	u8 enable_event;
 
 	u8 *buff;
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 828e495c870c..dbdf9bb9e258 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -1911,12 +1911,20 @@ static int st_lsm6dsx_read_event(struct iio_dev *iio_dev,
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
+	*val = st_lsm6dsx_field_get(reg->mask, data);
 
 	return IIO_VAL_INT;
 }
@@ -1948,8 +1956,6 @@ st_lsm6dsx_write_event(struct iio_dev *iio_dev,
 	if (err < 0)
 		return -EINVAL;
 
-	hw->event_threshold = val;
-
 	return 0;
 }
 
-- 
2.39.5


