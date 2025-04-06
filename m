Return-Path: <linux-iio+bounces-17671-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7F1A7CE24
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 15:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BE5B3B14D8
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 13:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D4120E6FD;
	Sun,  6 Apr 2025 13:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZvDF3cnm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C9D28373;
	Sun,  6 Apr 2025 13:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743946438; cv=none; b=hLT7zra0DldeWZpZz3cBGp6AXAFVrOZ7+ohlWyaivG0S80O8gAudOlvfx2ap2BL2Wigz3miCvcSzKTsxm34iVOcRoeBU2/UG3Zfrz6fJ2IrcmWka0aQ8qFSeode1v5jedI77UIHLzy0rFvb5uSCjxoMs+WE4Fksq2k/a3qMNIi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743946438; c=relaxed/simple;
	bh=oVs63TJb+8rEmfOa+5VXdRzdrh2UJUbxLRr+CvG1dOI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iR9x+YGvUS/tVIGMhtWTYJadZLVZXg1dfgBCYZ9qTl5FEDU+WlVTij3EO0h9wlkz0lFsGAcswIGfaMwcT8Pip2cBkGEJwsi7yhFd4DzrPKyfJ++8wcRlwVSsBuB3/Ob7JGPaFm39j72S8WtrcVSUp4aHp/7dUoJTA4sMDrHkfPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZvDF3cnm; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-736ab1c43c4so3217459b3a.1;
        Sun, 06 Apr 2025 06:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743946436; x=1744551236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nTroQOij2iPJWIzxj/pE8sWckT4rZyQZIuXMZDZdXNc=;
        b=ZvDF3cnmcYzGniGZZw30bJu5B7Qv+I6CYHJG3XzU8eDfeaIPv9OHV48K7knntAI9us
         TFIqBU38Am4NWkm1tcslHR8ahUgN9QjhEnuYXJGVX1S03Wosm2+nqIaWezqvL29qQNGo
         pmzg/tPduVWeegXdRnSyjDN1HZMe5p40SiVL/87JtvDQmvuiq/9Fmu4a8Sn9xQk+vIUt
         WxMCrsFphDpjZlRbmljYvhjOnIlf1Jl6+hdH/UUr6Sa8VY+UXrlNvCElQFGB5quzJjJ9
         MNqe2UoA0kmeG0VyGYtrmLjeqyczFd8NadSp/Z9Syag/cdVs0tfEXQBr/SUIxWk6FIa7
         C5+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743946436; x=1744551236;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nTroQOij2iPJWIzxj/pE8sWckT4rZyQZIuXMZDZdXNc=;
        b=J86WHs1j2HQgZhSGMWE7+PEk9rSPItUmj2+q7zk3AF8XspOv0uNZDDGDAYE63Nfq/C
         kDtA/eKuchWjfvJtZ5NakgH+gcT84lN0eoFcGorYwXOkLVwRvsOMp5JJOmf0AFzFEXMa
         iAz8PkCX4181liol+kJU6tscbd5ZbLDGiRGAUfGRNMjnCt3Z5H/4F3U8sCpf6e7JQk9Q
         +aGVbXAvc++DHLh2XppUBycMOfKqC4Tvh+VO9i23gENnf+o4Vl+z2wGLQmYhkOKkfdp9
         k2oFD5PCTQH8j+lF05/GqT/fy8wQas25eEuiKXAdeQieq6haYP9GrbN1Av9RlZ2LFJT5
         NpjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYHq7OIjjzwnqXzUrQtfA/oT9R6iTKKiO6qhgYBAvK+IwNGe1eubhyW/h+bvQQyzpvUqoyPrfor4InsAU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvQB75mbU06hQU/jvJUgHTWYe15jzjEx1fy+8WelASGapveuaT
	6IHP2pdNmc2664ZGmpnsPO2oa6m+dgt+SzXHN9gcxhTGL3sMH2TI
X-Gm-Gg: ASbGnculPnpMnEljhqS3BrJTKYA/RmLnaJ8gjyRXfWbY69JcgHTh9bqeii/VzTZvUww
	OBpTDVy7LywFWSvILv22LRkSF+plUmaK6S6SoD2YHdCzLMuJbxrau0L1OdaLrshGYkdWRnVa8BX
	pcn4RRvWVlYrDlNGI65KWpSaJ0s4OpEoRIQwKdkPF/Mf9adZMuz7WWAE8Qf3gWfRdgC3JvgaT0t
	R3S9JsRKOLd3gej37w1iJiu1rmFWlp7J9HmOf9kVRtPBsCJhVYhtsNzIaRRQiUToh95LN0duot2
	hfxKWUAGiP94OJwjhHalvTlAcxmX8ls7votRvFC+5Jm1+IF2VKHrOIywZ3IU4OS8Q4ho9eS8z5+
	5Te0=
X-Google-Smtp-Source: AGHT+IEG6wqP9wloF4vsipirfwzY/0h0GR5lJVHBMqgOJ5xIaTHoeaVJtZM9RQhKuWrfo7hoIOlo3w==
X-Received: by 2002:a05:6a00:2381:b0:735:d89c:4b8e with SMTP id d2e1a72fcca58-739e48cf25bmr11714220b3a.5.1743946435783;
        Sun, 06 Apr 2025 06:33:55 -0700 (PDT)
Received: from brajesh-IdeaPad-3-15IAU7 ([103.205.130.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739d97ee1d1sm6683887b3a.38.2025.04.06.06.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Apr 2025 06:33:55 -0700 (PDT)
From: Brajesh Patil <brajeshpatil11@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	lars@metafoo.de,
	linux-kernel@vger.kernel.org,
	outreachy@lists.linux.dev,
	Brajesh Patil <brajeshpatil11@gmail.com>
Subject: [PATCH v1 1/1] iio: dummy: Add 3-axis compass (magnetometer) channels to the iio_simple_dummy
Date: Sun,  6 Apr 2025 19:03:49 +0530
Message-ID: <20250406133349.50633-1-brajeshpatil11@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds support for 3-axis magnetometer data (X, Y, Z) in the
iio_simple_dummy driver. It introduces three new IIO_MAGN channels and
populates them with dummy values for testing and prototyping purposes.

Signed-off-by: Brajesh Patil <brajeshpatil11@gmail.com>
---
 drivers/iio/dummy/iio_simple_dummy.c | 71 +++++++++++++++++++++++++++-
 drivers/iio/dummy/iio_simple_dummy.h |  6 +++
 2 files changed, 75 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/dummy/iio_simple_dummy.c b/drivers/iio/dummy/iio_simple_dummy.c
index 8575d4a08..713b764c9 100644
--- a/drivers/iio/dummy/iio_simple_dummy.c
+++ b/drivers/iio/dummy/iio_simple_dummy.c
@@ -222,7 +222,7 @@ static const struct iio_chan_spec iio_dummy_channels[] = {
         * Convenience macro for timestamps. 4 is the index in
         * the buffer.
         */
-       IIO_CHAN_SOFT_TIMESTAMP(4),
+	IIO_CHAN_SOFT_TIMESTAMP(DUMMY_INDEX_SOFT_TIMESTAMP),
        /* DAC channel out_voltage0_raw */
        {
                .type = IIO_VOLTAGE,
@@ -265,6 +265,48 @@ static const struct iio_chan_spec iio_dummy_channels[] = {
                .num_event_specs = 1,
 #endif /* CONFIG_IIO_SIMPLE_DUMMY_EVENTS */
        },
+	{
+		.type = IIO_MAGN,
+		.modified = 1,
+		.channel2 = IIO_MOD_X,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
+		.scan_index = DUMMY_MAGN_X,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 16,
+			.storagebits = 16,
+			.shift = 0,
+		},
+	},
+	{
+		.type = IIO_MAGN,
+		.modified = 1,
+		.channel2 = IIO_MOD_Y,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
+		.scan_index = DUMMY_MAGN_Y,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 16,
+			.storagebits = 16,
+			.shift = 0,
+		},
+	},
+	{
+		.type = IIO_MAGN,
+		.modified = 1,
+		.channel2 = IIO_MOD_Z,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
+		.scan_index = DUMMY_MAGN_Z,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 16,
+			.storagebits = 16,
+			.shift = 0,
+		},
+	},
 };
 
 static int __iio_dummy_read_raw(struct iio_dev *indio_dev,
@@ -294,6 +336,22 @@ static int __iio_dummy_read_raw(struct iio_dev *indio_dev,
        case IIO_ACCEL:
                *val = st->accel_val;
                return IIO_VAL_INT;
+	case IIO_MAGN:
+		switch (chan->scan_index) {
+		case DUMMY_MAGN_X:
+			*val = st->buffer_compass[0];
+			break;
+		case DUMMY_MAGN_Y:
+			*val = st->buffer_compass[1];
+			break;
+		case DUMMY_MAGN_Z:
+			*val = st->buffer_compass[2];
+			break;
+		default:
+			*val = 99;
+			break;
+		}
+		return IIO_VAL_INT;
        default:
                return -EINVAL;
        }
@@ -378,6 +436,11 @@ static int iio_dummy_read_raw(struct iio_dev *indio_dev,
                        default:
                                return -EINVAL;
                        }
+		case IIO_MAGN:
+			// Just add some dummy values
+			*val = 0;
+			*val2 = 2;
+			return IIO_VAL_INT_PLUS_MICRO;
                default:
                        return -EINVAL;
                }
@@ -562,6 +625,10 @@ static int iio_dummy_init_device(struct iio_dev *indio_dev)
        st->activity_running = 98;
        st->activity_walking = 4;
 
+	st->buffer_compass[0] = 78;
+	st->buffer_compass[1] = 10;
+	st->buffer_compass[2] = 3;
+
        return 0;
 }
 
@@ -732,5 +799,5 @@ static struct iio_sw_device_type iio_dummy_device = {
 module_iio_sw_device_driver(iio_dummy_device);
 
 MODULE_AUTHOR("Jonathan Cameron <jic23@kernel.org>");
-MODULE_DESCRIPTION("IIO dummy driver");
+MODULE_DESCRIPTION("IIO dummy driver -> IIO dummy modified by Me");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/dummy/iio_simple_dummy.h b/drivers/iio/dummy/iio_simple_dummy.h
index 8246f25db..e05d8b5cc 100644
--- a/drivers/iio/dummy/iio_simple_dummy.h
+++ b/drivers/iio/dummy/iio_simple_dummy.h
@@ -12,6 +12,7 @@
 struct iio_dummy_accel_calibscale;
 struct iio_dummy_regs;
 
+#define DUMMY_AXIS_XYZ 3
 /**
  * struct iio_dummy_state - device instance specific state.
  * @dac_val:                   cache for dac value
@@ -39,6 +40,7 @@ struct iio_dummy_state {
        int steps_enabled;
        int steps;
        int height;
+	u16 buffer_compass[DUMMY_AXIS_XYZ];
 #ifdef CONFIG_IIO_SIMPLE_DUMMY_EVENTS
        int event_irq;
        int event_val;
@@ -107,6 +109,10 @@ enum iio_simple_dummy_scan_elements {
        DUMMY_INDEX_DIFFVOLTAGE_1M2,
        DUMMY_INDEX_DIFFVOLTAGE_3M4,
        DUMMY_INDEX_ACCELX,
+	DUMMY_INDEX_SOFT_TIMESTAMP,
+	DUMMY_MAGN_X,
+	DUMMY_MAGN_Y,
+	DUMMY_MAGN_Z,
 };
 
 #ifdef CONFIG_IIO_SIMPLE_DUMMY_BUFFER
-- 
2.43.0

