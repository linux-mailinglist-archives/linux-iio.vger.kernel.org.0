Return-Path: <linux-iio+bounces-14609-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C866EA1D7AD
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jan 2025 15:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 235613A55DA
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jan 2025 14:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507981FF1BD;
	Mon, 27 Jan 2025 14:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="RYtywkpG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5637623CE
	for <linux-iio@vger.kernel.org>; Mon, 27 Jan 2025 14:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737986695; cv=none; b=L1XmN0tHwopG3eIFwmBggpHiVVYQutOpivWADK8ejxJZQ9DE+BtGjwMEUuUXawsa/y2izMLGpEPnRaOyBeSQmLnHim56iFbCehy2jNdWLhR1BkRPgtjwK/bJfxxov2vIZP15oL3GE0etxm1hb8i8LWafJ+eWzx3lNzdLLZO92kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737986695; c=relaxed/simple;
	bh=eOnQFt9KDLAtGS9JJRjBDvScO3hylO47UQ4KXcGrRGg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ep4ea7TkbQJkDLzFFQ6VgS2De+zrtBoxA0Dpkko73aMZVzmCMm7lCB2ZY7kaeJ6HAK+vL78/jbMC/U4Y+35chUsg2tiClMLpiFJ9OWt2IGmWoHix6MezxPP64OH17N3jEXggsfOnN5gF2NMusWvs8dPhYl9Sp5BFuXchZBrFY68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=RYtywkpG; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3862b40a6e0so3222856f8f.0
        for <linux-iio@vger.kernel.org>; Mon, 27 Jan 2025 06:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1737986690; x=1738591490; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rDZcqtex0NZJ8B9ZqGJYGG8HD687lfJ1eoGFYPdsiQQ=;
        b=RYtywkpGn0rXo85XBjs2DpyhXkYwcOxKb2kuod5miXzIOsDP9Y1DewBIL0MLpCOLPh
         9UeezCbCLyF2ys+L5+Hy3MwfvV7JCE/eHqVPaYzti3NaJ6jEbQ8JPH+SpOFj9zcJIM0+
         MiouQu1ZO4zDukwiWQ5roIGiHnc0ar2MJ01Vf2/CZBpvd+y3H5/1zSD08E8U+xdUy+LQ
         5A5Jge0j7Gp2SLgF7d4dvZlk/sx1jJDdEkug8qgy9vOns1dWl3fg0s3QFsStzCESBG3O
         QpAynQCkiMNDW2eM1olC4wXDgcR18/m6i+/r9IwGL5JIQsMdFd1Du5Dz13FmpCExhK6w
         f/0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737986690; x=1738591490;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rDZcqtex0NZJ8B9ZqGJYGG8HD687lfJ1eoGFYPdsiQQ=;
        b=oR/MwbQwcAeaSavKMcCm9VCJTWCC0zoCBkJAHv6ts5RO0LLgdu+SEvW0YNZIhPJAkX
         oP2WbgFvVFbtBaLKrO9wAhULKgHrQ7bGLQ9ji1dk4Q56RVpQkgsqFmzbVTg7TI9w+cWW
         hwE6SVhMx1k7uJaBHtyCbj4IYFB4xqvC/JOS0mjYZORl+Zyg1s+Vz2KKM2X5lLnHMFzn
         7JTZTAl4vwj82bLRXXtLgc8IoiKA6TzuMTpbs6M9qpudqkxirUmBKAkUT2GQ2/vckFWH
         L1hzsCSOKQ4sbblRwkuNG853bJqcNY4KWH0SczY3Bnm53KxcMwSG1zzc5nlRJTvwaXrH
         RrYw==
X-Gm-Message-State: AOJu0YyAU6paSn4hzC5PmmBuCu1OCjp31T2ie0ICPfUlrnOzFBS7d7Vw
	qDr+NO9kx7Z2FDYIp/JUwav4AsD+YgkUFQrpcCc0pOiwz7AIBa7rmceLlVAQmrI=
X-Gm-Gg: ASbGnctPYdn+flknqisvxCUJ+t9jIB+6ALHbj27hxfyCV5Un3ES2ykzdvsAhw3clFpS
	Hf5TDN2mkMX13W1itRr83Ep+8BeNb7FW8NvN7QhBCRxRkoPbRSr3uA1Kod0JwaaW5CqZgbRcP2n
	bXQS4bKw8QO++eDY2fhiEBUFuZtX+f8w1Yqa/UNV8M/gqau+tFTKQQbEwZtbqM28o7ajW0rXmXT
	oQ2O8qXpxRCycEbOEID4/UuN2R66tBd6y0e2Ky8v5hB0QqTjXH8LnT80R0BjiA59+Q/MzmYpuvf
	S2agZpYaNyIzsOc/jKGSGV6DfSBmFYl2NJxxwB1wbfc+Uty0vk/xpQUwzeVJcw==
X-Google-Smtp-Source: AGHT+IH+gpjsy7WJTZrz9zayvtQu7QoRPXAyDESpgAiLp0YmpMRV88awNr+y7pJz2JDTD232HzjIUQ==
X-Received: by 2002:a5d:47cf:0:b0:38c:1270:f964 with SMTP id ffacd0b85a97d-38c1270fbaamr26981054f8f.47.1737986690544;
        Mon, 27 Jan 2025 06:04:50 -0800 (PST)
Received: from [127.0.0.1] (alille-653-1-300-114.w90-1.abo.wanadoo.fr. [90.1.180.114])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a313383sm11480639f8f.36.2025.01.27.06.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 06:04:49 -0800 (PST)
From: Guillaume Ranquet <granquet@baylibre.com>
Subject: [PATCH v5 0/2] iio: adc: ad7173: add ad4111 openwire detection
 support
Date: Mon, 27 Jan 2025 14:59:31 +0100
Message-Id: <20250127-ad4111_openwire-v5-0-ef2db05c384f@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAESRl2cC/3XP7WrDIBQG4FsJ/p5DT2K+GGP3MUbx47gKTdJpl
 qWU3PuMpdAu3S95FZ/3nDMJ6B0G0mZn4nFywQ19DOIpI3ov+0+kzsRMgEHBORdUmvXcDUfsf5x
 HikIYVLKGprIk/jp6tG5O4vvHJXv8+o7weLkkHYYgE9xmL/fuvNPy4JSXYxyDTpxyKmwNzFgld
 M3elDytz/ish+51bVMyII2hc2Ob9TiP9AqStXzvwjj4U9pu4qn930VSm1FNJXWtLIj7tsRNcCU
 E46zZEkAZZXkFGoxBpvEBkd8QvNwSeSRQNhhHaJTh5gFR3BDAtkSxEmVR1bkwCkv4QyzL8gvVg
 z6x9wEAAA==
X-Change-ID: 20241115-ad4111_openwire-e55deba8297f
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Guillaume Ranquet <granquet@baylibre.com>, Nuno Sa <nuno.sa@analog.com>
X-Mailer: b4 0.15-dev

Hi.

This patch adds the openwire detection support for the ad4111 chip.

The openwire detection is done in software and relies on comparing the
results of two conversions on different channels.

The openwire detection on ad4111 is triggered automatically when a
single conversion is requested.
Due to the way openwire detection works on ad4111, implementing openwire
detection for continuous conversion mode is out of the scope of this
series.

Following discussion on V2, I have changed the event to be
IIO_EV_TYPE_FAULT and added a direction called IIO_EV_DIR_FAULT_OPENWIRE to
signal the specific fault.

The fault is level triggered (ie: the event will be sent as long as the
fault persists).
There's no event to signal that the fault has been "fixed", an absence
of FAULT event means that the open wire condition is not detected.

Thx,
Guillaume.

Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
---
Changes in v5:
- Rebased on top of iio/testing (ed2010907c)
- Added a millivolt to openwire raw threshold helper as suggested by
  Nuno.
- Link to v4: https://lore.kernel.org/r/20250120-ad4111_openwire-v4-0-e647835dbe62@baylibre.com

Changes in v4:
- Rename IIO_EV_DIR_OPENWIRE to IIO_EV_DIR_FAULT_OPENWIRE to make it
  clearer the OPENWIRE direction is in the FAULT "namespace"
- Removal of the RFC prefix
- Link to v3: https://lore.kernel.org/r/20250116-ad4111_openwire-v3-0-ea9ebf29bd1d@baylibre.com

Changes in v3:
- Rename IIO_EV_TYPE_OPENWIRE to IIO_EV_TYPE_FAULT and add
  IIO_EV_DIR_OPENWIRE.
- Remove per channel open wire threshold configuration interface.
- Link to v2: https://lore.kernel.org/r/20250109-ad4111_openwire-v2-0-0372c2dde0ce@baylibre.com

Changes in v2:
- Introduce IIO_EV_TYPE_OPENWIRE instead of misusing the IIO_EV_THRESH
  event.
- Link to v1: https://lore.kernel.org/r/20241115-ad4111_openwire-v1-1-db97ac8bf250@baylibre.com

---
Guillaume Ranquet (2):
      iio: introduce the FAULT event type
      iio: adc: ad7173: add openwire detection support for single conversions

 drivers/iio/adc/ad7173.c         | 179 +++++++++++++++++++++++++++++++++++++++
 drivers/iio/industrialio-event.c |   2 +
 include/uapi/linux/iio/types.h   |   2 +
 tools/iio/iio_event_monitor.c    |   4 +
 4 files changed, 187 insertions(+)
---
base-commit: c849f534b9ea4688304f80f4571af75931dda7c1
change-id: 20241115-ad4111_openwire-e55deba8297f
prerequisite-message-id: <20241115-ad411x_calibration-v1-1-5f820dfb5c80@baylibre.com>
prerequisite-patch-id: 26241903b8fee8c4243e73d11fb2872cd9f52a15

Best regards,
-- 
Guillaume Ranquet <granquet@baylibre.com>


