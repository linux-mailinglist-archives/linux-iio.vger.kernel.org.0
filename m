Return-Path: <linux-iio+bounces-21881-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B91B0E449
	for <lists+linux-iio@lfdr.de>; Tue, 22 Jul 2025 21:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A5C03A4750
	for <lists+linux-iio@lfdr.de>; Tue, 22 Jul 2025 19:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F79C283FDB;
	Tue, 22 Jul 2025 19:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="jpPxN/Hu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854D22459DD
	for <linux-iio@vger.kernel.org>; Tue, 22 Jul 2025 19:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753212915; cv=none; b=ZBGBsja3Hy4BJbjm+6t80OeLZTuNX0OUPo8YSV4eZhn7Q4DK9MwS4OoilHYJcfjVfDkap8sz9XHhR/GCYOvBiu6DfjKH3CiZICF9fbYiYg0OZE49+H79b/HNr4LPT+YH/LKT8BOOkKsapNjQiXuzWG0xpZVlJQYtCFefgoBV1n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753212915; c=relaxed/simple;
	bh=yRFRhMPm7jNLGGqB0LF4R3l3KyFeu06cYWiQMGcs2t8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=WHQSaDoK3/DS4VTsj5fTLpo+6x3bZ9OoHUPA3LWYMo31OQOjUZmtZuoeHMMADnFitRYhlBe/Ko7fNqmGNHjNmjOybAqFfO0+hyb3euDej0ENVrxKO+rvlstLUZyzB7w37S1pWGo2KLkS+3qHSDb9tGkBTQ0Y6+dgLZ05J3FtW18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=jpPxN/Hu; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-73e82d2ea1dso2907161a34.2
        for <linux-iio@vger.kernel.org>; Tue, 22 Jul 2025 12:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1753212912; x=1753817712; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oWqidPkEwwKODP+KFOjNIgdSCFO9hHiUxuXFTn1kZ7o=;
        b=jpPxN/HudjZoaAvK3AfTHQZQpiP/0BsGf1YPTuopO5mM0t4oYMaUV5CgGSYW7H8Ugk
         xTQOE3S6iB3nKo5/jr4ZrmF2Ox2ov/wdMWIm70Fr1O+w+CPYMfPlxTy/R0XP5D39yWY8
         tsgYl+PgWLH9dn0autTIjHk1v0Zk0USnIFY8FQWxefSfl0fgYOpiduWyRA4NmhEb/RVN
         8z+Y8yFpxPrYhan7UijdOvlfKsCPE8Wmn9nFymoolC+0E2A92VQqwqO5Y2nuYCHW8xIL
         74qPbKpia04kVL/CmJPWcF56CmnpDR/83pQHhrnufa1oPQYSjuUJZldrba+StXrlw1JH
         dkSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753212912; x=1753817712;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oWqidPkEwwKODP+KFOjNIgdSCFO9hHiUxuXFTn1kZ7o=;
        b=wFSvc8Lw1ZVOuzoV10sufZpSDYn4RWW361/WpvdipPBcedKevcN1RtY9hNzrfQSO+9
         O+FLJAr7RrDd92CQm9+Q/Uc5qj3L1FmSCD+uu1ob78gA8Qi7/QkvclnAR8bx2AXrVPNk
         NOKAkEHfMYGQzgrGLPcJkeVxN8KWJuT2PrFdgomPRuUyaJ0NovC6wWqEJPFMPkHvxC5S
         S+kOw+IPf+1jTY4f5FQBNajF/GnGHhXhp/3Lxut06BI7LEIOTKPe9G2B7n3sXr8ghF5U
         9E6i7ZblTVsmN5ZzYU1xbT8EwimDvdHDGyNdt9JVl3tPuI9vwmcG4CMN9mSVe71sgZq8
         nWhA==
X-Gm-Message-State: AOJu0YxVs058RsrUZQZsUqTHpQeaxe9WSQtDAHbf2RMLZb4rjDpM2sCR
	C1uOseocEXd3xUH58rQWBdbYrpAyUoTiyHuwQTgzD/aTtlbl1HufeYxm185GYJfxlxw=
X-Gm-Gg: ASbGnct6wFonAYEyp1MF8MCLcBkomZ8rmCQgftlTzRS0dFsWLE1vAxXMFbJXmR3gieK
	abnhNxbMSaArU26z+HWlbR1m7eLRkYet3GguE6oF1WpjgSWtNAzS6HRdyraJgqjnevhxo/asx6W
	+T3XHbk0sOc/5zZfwLKt29ov+Qzy3RaCgdoZpcbqNevWLEJdSkZKy0Zs9B0U9FHNK8YElzAQ93d
	zFH15DerIAXJSPg9M16Ttejio0Pw8aAfjOnJEAIq6cufu2w+AbaGEqFR6uAdk/GTwap5kSy1z4q
	nR1FehepxoYWZI+NzM0QdrE9SogN8WjBSvhffK+dxa8qsvudIcvaq8sNeBP262SFnm2XIqCPp5b
	ulO/nDiyxMrdTrkG6T+54jk2Ae08z
X-Google-Smtp-Source: AGHT+IHWjjjnvGCMQyiHrwuY7qYrjByD+x94DB6d6OoorDDQ+V8cuPmoT2p26TZIB9h6fNK3fjiziA==
X-Received: by 2002:a05:6830:8206:b0:73e:9d9d:8562 with SMTP id 46e09a7af769-74080537cecmr306315a34.8.1753212912449;
        Tue, 22 Jul 2025 12:35:12 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:2a79:4b55:6a01:85d7])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73e8354df6dsm3515525a34.5.2025.07.22.12.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 12:35:12 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 22 Jul 2025 14:35:02 -0500
Subject: [PATCH v2] iio: proximity: sx9500: use stack allocated struct for
 scan data
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250722-iio-use-more-iio_declare_buffer_with_ts-4-v2-1-9e566f3a4c6a@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAOXnf2gC/53NTQqDMBCG4avIrJtiUn+gq96jSIjJpA6oKRO1F
 fHujR6hzOqZxfduEJEJI9yzDRgXihTGBHXJwHZmfKEglwwqV2VeSymIgpgjiiEwHtAObW8YdTt
 7j6w/NHV6iqIQVeWcdVhWN4+Q9t6Mnr5n69kkdxSnwOuZXuTx/aeySJHOSCyVtL4u6kdr1p5ax
 qsNAzT7vv8ACNTGCOUAAAA=
X-Change-ID: 20250711-iio-use-more-iio_declare_buffer_with_ts-4-66ddcde563fe
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3486; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=yRFRhMPm7jNLGGqB0LF4R3l3KyFeu06cYWiQMGcs2t8=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBof+fpswTuivJAp1iQQuPyc7MzRJv3EIyU6cyBr
 o9RkiUpboqJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaH/n6QAKCRDCzCAB/wGP
 wPhWB/97aMoX5H0VD5kyF7x8QAP7S2CwPjDf/F+Cjy2J7CXuJCua0lwwFw4RYadCaDz1do1Kbab
 QkTrxu4/VL/h5CtIXQ051zwdLbb3s+dpsvDWBpT6JUloArshE9J5v/kAg06MQkkgKAEEBZk2CKf
 PXAKiiowl5AX/KOcEK2aRU6A2iFlO5fDNxFGBwOXf1309UtVhj5nyHs+T2bDlG+YrXbmSgaz8Lw
 dRf+I45vVfwjB1beNRzmtm/isp0zDkKaaomuMM0hZI+FXNHDoV0pfIq043ytjVtZjoOOt1HhBpq
 TGEpH3kk71/jUD8RvJmMu/FX9KYjAPypFXoLNGoisae4jreJ
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use a stack-allocated struct in sx9500_trigger_handler() to hold the
IIO buffer scan data. Since the scan buffer isn't used outside of this
function, it doesn't need to be in struct sx9500_data.

By always allocating enough space for the maximum number of channels,
we can avoid having to reallocate the buffer each time buffered reads
are enabled.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
Changes in v2:
- Replaced `IIO_DECLARE_BUFFER_WITH_TS()` with struct.
- I didn't pick up Andy's review tag since I don't consider this a trivial
  change and deserves a 2nd look.
- Link to v1: https://lore.kernel.org/r/20250711-iio-use-more-iio_declare_buffer_with_ts-4-v1-1-1a1e521cf747@baylibre.com
---
 drivers/iio/proximity/sx9500.c | 27 ++++++---------------------
 1 file changed, 6 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/proximity/sx9500.c b/drivers/iio/proximity/sx9500.c
index 05844f17a15f6980ab7d55536e5fecfc5e4fe8c0..6c67bae7488c4533ea513597f182af504a22c86d 100644
--- a/drivers/iio/proximity/sx9500.c
+++ b/drivers/iio/proximity/sx9500.c
@@ -88,7 +88,6 @@ struct sx9500_data {
 	bool prox_stat[SX9500_NUM_CHANNELS];
 	bool event_enabled[SX9500_NUM_CHANNELS];
 	bool trigger_enabled;
-	u16 *buffer;
 	/* Remember enabled channels and sample rate during suspend. */
 	unsigned int suspend_ctrl0;
 	struct completion completion;
@@ -578,22 +577,6 @@ static int sx9500_write_event_config(struct iio_dev *indio_dev,
 	return ret;
 }
 
-static int sx9500_update_scan_mode(struct iio_dev *indio_dev,
-				   const unsigned long *scan_mask)
-{
-	struct sx9500_data *data = iio_priv(indio_dev);
-
-	mutex_lock(&data->mutex);
-	kfree(data->buffer);
-	data->buffer = kzalloc(indio_dev->scan_bytes, GFP_KERNEL);
-	mutex_unlock(&data->mutex);
-
-	if (data->buffer == NULL)
-		return -ENOMEM;
-
-	return 0;
-}
-
 static IIO_CONST_ATTR_SAMP_FREQ_AVAIL(
 	"2.500000 3.333333 5 6.666666 8.333333 11.111111 16.666666 33.333333");
 
@@ -612,7 +595,6 @@ static const struct iio_info sx9500_info = {
 	.write_raw = &sx9500_write_raw,
 	.read_event_config = &sx9500_read_event_config,
 	.write_event_config = &sx9500_write_event_config,
-	.update_scan_mode = &sx9500_update_scan_mode,
 };
 
 static int sx9500_set_trigger_state(struct iio_trigger *trig,
@@ -649,6 +631,10 @@ static irqreturn_t sx9500_trigger_handler(int irq, void *private)
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct sx9500_data *data = iio_priv(indio_dev);
 	int val, bit, ret, i = 0;
+	struct {
+		u16 chan[SX9500_NUM_CHANNELS];
+		aligned_s64 timestamp;
+	} scan = { };
 
 	mutex_lock(&data->mutex);
 
@@ -658,10 +644,10 @@ static irqreturn_t sx9500_trigger_handler(int irq, void *private)
 		if (ret < 0)
 			goto out;
 
-		data->buffer[i++] = val;
+		scan.chan[i++] = val;
 	}
 
-	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
+	iio_push_to_buffers_with_timestamp(indio_dev, &scan,
 					   iio_get_time_ns(indio_dev));
 
 out:
@@ -984,7 +970,6 @@ static void sx9500_remove(struct i2c_client *client)
 	iio_triggered_buffer_cleanup(indio_dev);
 	if (client->irq > 0)
 		iio_trigger_unregister(data->trig);
-	kfree(data->buffer);
 }
 
 static int sx9500_suspend(struct device *dev)

---
base-commit: cd2731444ee4e35db76f4fb587f12d327eec5446
change-id: 20250711-iio-use-more-iio_declare_buffer_with_ts-4-66ddcde563fe

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


