Return-Path: <linux-iio+bounces-12452-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C26D29D49C2
	for <lists+linux-iio@lfdr.de>; Thu, 21 Nov 2024 10:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 627D51F224FD
	for <lists+linux-iio@lfdr.de>; Thu, 21 Nov 2024 09:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5201CB9ED;
	Thu, 21 Nov 2024 09:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aYDKy/pG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AEA1CB304
	for <linux-iio@vger.kernel.org>; Thu, 21 Nov 2024 09:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732180617; cv=none; b=YntCC1CbVGJ11xw0yVodRQKz6pdePtXNDUu8AbPtTr9vK3VTe/uHzJSm3LjnbgG5ceKbltvVUoVw2mW/0rjB5j7VG2StyHsALfY/56rAQlOt24ak8Q1NhaSU5Yyilelm69JZqzye1JYDSwU14g1n2BcNkTHmh2hLI9JgdYnfDn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732180617; c=relaxed/simple;
	bh=N6qcfExF6HKyVQROB3/M+JmpOuLdpLoagMzOOIIxoTI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=c7c/2CRQH37yWy/8ItyIDMW5RQHJAMt50c3Xcuhyxby6baVmMEa2Soe7jXHU59Hxm3d8D7I4s+bRYUB6II78YfSrN9ifYDDb4xwibBC8Dnto1J7hHMTm4Tu+6g+24VnRQI87fbT9Hd92agiGQrtjv/aGM/dvC6gvZhhXmfdSw14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aYDKy/pG; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6ee7b886b5fso5979057b3.3
        for <linux-iio@vger.kernel.org>; Thu, 21 Nov 2024 01:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732180614; x=1732785414; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gx7g1ycpbkaP8i3JjzDe0fy+LgJAm7hWm+PnlhjBjVk=;
        b=aYDKy/pG27J6HY4bYm7hxaykgqrMAFuEAID0AEFb4b+cNjXvsjNvHNmSGyQBYd4s2L
         uAfs/Wo0MYmOR+G+lVoRVfzy16EwG16YhhdMzVz6gk7VFDD5ZDrMX6pou2esfosj94m6
         SyHTY19OpZxGxRbwrojsPK6NFKrG0QbBBF+T0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732180614; x=1732785414;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gx7g1ycpbkaP8i3JjzDe0fy+LgJAm7hWm+PnlhjBjVk=;
        b=nRwbyNta1QepxVHKFrYWjGuXAnGQ4kFRid344byjJ783I0VaqO2PLmdFUFaSPUqvGE
         FD0njfYErEGcyV14vaiNT1lArvpPSgbY+oRUYmXQj6UclSTzt3njsWmaph7/Js+ZXoiV
         BfZypaGyGizZbnpHguU8VUAa4HAfeTblj+jLRX7o3owmsd9jqwv/nTBHWQ9O9Gd50C6z
         nCCQcIsoYJ/bUFr9/hPU8QF6v6C5GxYhkmFFsDsYar9vFr/7s08VWvS7aWRr69z4OF17
         /5qmLhem6LXkkTiWQfslRL5WzV5OEOfebA7ovwvhcTPSGbqNJfSMJyv/KF9P545GgvC1
         0feg==
X-Forwarded-Encrypted: i=1; AJvYcCUMNqlGkY6Fu9yFOCK+TYbPUGnbXWxDR1g3K6bs/asy1wBDn8b8sep1ZqxRYaS/50zmQqPWvCcSdhw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKHJ2aWPhlxL2mkv4USAOXCNzZTgnWqAlT8lzB35Mw4ppVVG3N
	p6PK8+tFrr3bn5H39DwPW9NV4s9FMH7Gbp1JGWU4MxnMRBMWj6X17AI0hc0vxA==
X-Google-Smtp-Source: AGHT+IEwtrszS3T6Xc4Yxiza7arbzx1prlMVVU5cAA6WJx38v3jLAfMA9YXxGlHZHefHwBVRD5GPYw==
X-Received: by 2002:a05:690c:4b11:b0:6ee:b43b:62fd with SMTP id 00721157ae682-6eebd2d1a9amr68205557b3.41.1732180614211;
        Thu, 21 Nov 2024 01:16:54 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d43812ab1csm20719276d6.93.2024.11.21.01.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 01:16:52 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 21 Nov 2024 09:16:47 +0000
Subject: [PATCH] iio: hid-sensor-prox: Fix invalid read_raw for attention
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241121-fix-processed-v1-1-4fae6770db30@chromium.org>
X-B4-Tracking: v=1; b=H4sIAH76PmcC/x2MwQqAIBAFfyX2nNCKCfUr0SHyVXtRcSEC6d+Tj
 gMzU0lRBEpzV6ngFpUUG3Df0X5t8YSR0JjsYB2zZXPIY3JJO1QRDAJv0+gdwztqTS5owv9b1vf
 9AG/s5slfAAAA
To: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 Lars-Peter Clausen <lars@metafoo.de>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

The attention channel is a IIO_CHAN_INFO_PROCESSED, not a
IIO_CHAN_INFO_RAW.

Modify prox_read_raw() to support it.

Fixes: 596ef5cf654b ("iio: hid-sensor-prox: Add support for more channels")
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/iio/light/hid-sensor-prox.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-sensor-prox.c
index e8e7b2999b4c..8e5d0ad13a5f 100644
--- a/drivers/iio/light/hid-sensor-prox.c
+++ b/drivers/iio/light/hid-sensor-prox.c
@@ -94,6 +94,7 @@ static int prox_read_raw(struct iio_dev *indio_dev,
 	*val2 = 0;
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
+	case IIO_CHAN_INFO_PROCESSED:
 		if (chan->scan_index >= prox_state->num_channels)
 			return -EINVAL;
 		address = prox_state->channel2usage[chan->scan_index];
@@ -107,8 +108,7 @@ static int prox_read_raw(struct iio_dev *indio_dev,
 							   report_id,
 							   SENSOR_HUB_SYNC,
 							   min < 0);
-		if (prox_state->channel2usage[chan->scan_index] ==
-		    HID_USAGE_SENSOR_HUMAN_ATTENTION)
+		if (mask == IIO_CHAN_INFO_PROCESSED)
 			*val *= 100;
 		hid_sensor_power_state(&prox_state->common_attributes, false);
 		ret_type = IIO_VAL_INT;

---
base-commit: decc701f41d07481893fdea942c0ac6b226e84cd
change-id: 20241121-fix-processed-ed1a95641e64

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


