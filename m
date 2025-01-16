Return-Path: <linux-iio+bounces-14398-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58440A13D3B
	for <lists+linux-iio@lfdr.de>; Thu, 16 Jan 2025 16:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53DA27A31AD
	for <lists+linux-iio@lfdr.de>; Thu, 16 Jan 2025 15:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC1B22B8DA;
	Thu, 16 Jan 2025 15:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="u/UekPDb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFC51F37DF
	for <linux-iio@vger.kernel.org>; Thu, 16 Jan 2025 15:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737040013; cv=none; b=UzFohHVl98ksHJ9Xe4GpzxBARy0CuNaKCGK/7ZXARksv0LLqupYnqZndkZSnUEsi6fRD+zflCu7Ptkyzsce0dq+w1EXpN/ySGE6eOaG1xWoqSc6anliaotV9K+2lBUCWyJ6f2wKEQOi/IcXp4m+5RMClD823zAhw0Upe7/TA51I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737040013; c=relaxed/simple;
	bh=KBS/P9I2LLrNLn1NS1QGqm5TzUjueDRuJiqVE2TtIjw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=r6Y+v6aaZEAN7A7IyAPkr9xNdVcxmmWjrGq74GEGJPccl10VEnM3T/NWR6DUYrv1MjLUuteWuTbsPbpmm+AnPVs3pO1T5zIGVfsjLXb46IJSRZu4GItUrTKzkUCxtKEDPM1hXzt2DRepnGQMtKtICnXoDx9NsucPpNqMzBA7UPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=u/UekPDb; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43623f0c574so6830225e9.2
        for <linux-iio@vger.kernel.org>; Thu, 16 Jan 2025 07:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1737040009; x=1737644809; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GHqDURXTtTcKsvrcQ66g+RmlMvyDdroySV3/8MzmCow=;
        b=u/UekPDbXd0nb7dEYnKcVNvjfcTHOyFbw/swaRfLx6aYXz6+LbZskq6FlZ2W/Xo12I
         zN9rGYHHwxwkkVHOE4NqoEm8uSK3TmmLFpaL5kb0uXcPcOo+RiFh20QKQ1N5m4GzmTzd
         r2fn/G2njTndSjdLx3Fl68yoMeniEZmuldPKHejtsYrWtFs9c98JB/Uz6jXzzR1LDI9C
         a8x0kWpFrlGjr5EzkwIPuaMlmLRrp7D0FBpUke8dpywY4UqkIkf/UyfKB2n4B8Kh29tQ
         9yBPfS8n8NCOs9enBYEO0/71NJzGMsDhJqIN5C+cise3QmjAi1a7uNfaqBi6urXPeokg
         dv0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737040009; x=1737644809;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GHqDURXTtTcKsvrcQ66g+RmlMvyDdroySV3/8MzmCow=;
        b=oFHsc3hk1hac6JU/Az4UCcJLGxFSKPSVjSdXQ8vwZokW9q+DlmN5Dn3y+U8kXmaCtr
         ZepPJWjepGMslHyMTxQP2hlnbpUqDyGZiLqAxF0oFHaWYxe8puJ5cH/8w2Dj4f/Rvb+L
         clLvX/WZYu8Ku3j5tDmdy5obLVBb2FuZVJq522XLafA2I4lK5VnKvS13QnLSjaZUqLtO
         eAuw3q3Dl+69AUvHmA6HrgqLi726RljaU4YhfuBkiGN0LGIDf7vc+o1WV/19wOfd1SDw
         wmN2DeNfEJOmPNlzVw/vK9bNfBZsDwBXZLNficpXsQ7urYo1I/8qFJN9k9spyvDBk5aQ
         QSUw==
X-Gm-Message-State: AOJu0Yx+BtAlrDUe1aY57oXELGaZ4HqnwpheDmUDGobnjDXyPkMM9gY2
	F54ALmWDyyg+I6wgA8o9PWgX1GKJ67HP4wNsdRuL6aEI/6riOJyjiFc5bBJXjPM=
X-Gm-Gg: ASbGncsy+MVbv1JHDo7YmOVmupImbxhhuVeEwEoS3PzVyZm+jIsyijp2Q0wXv4l8LF4
	6tJz+3lSW3UGdZ4PrbAmgvv6LnzMRt50h6VxqoZh8CLaHkRA4SryXfk8UuTSbCZgtR67S00v8Tx
	v4d0Ayr+hjWt6GdAp91zayX16yTw/R6uEKg9FcSKiBA9XhlE+Ta3bEhJDWw8CTvEW5ucq7mjd8X
	R0iZEatPsOACxP3lW/muoegrxtcAkYl2B9adusf6n0xSnH+fCMMJnal60thgKl59h/Lj/BAAQRg
	Dq02qcEDyDg7ugAZPm7ikgsQ65Q=
X-Google-Smtp-Source: AGHT+IEew7ONB+f0ddWN9gZK72dm60y1I7zYki1lZgF261svGgnGh93CkieFRTxBmcwymR3M+Pibog==
X-Received: by 2002:a05:600c:3c85:b0:434:a802:e99a with SMTP id 5b1f17b1804b1-436e267821emr299459455e9.4.1737040007539;
        Thu, 16 Jan 2025 07:06:47 -0800 (PST)
Received: from [127.0.0.1] (alille-653-1-300-114.w90-1.abo.wanadoo.fr. [90.1.180.114])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43890408a66sm2199445e9.5.2025.01.16.07.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 07:06:46 -0800 (PST)
From: Guillaume Ranquet <granquet@baylibre.com>
Subject: [PATCH RFC v3 0/2] iio: adc: ad7173: add ad4111 openwire detection
 support
Date: Thu, 16 Jan 2025 16:01:45 +0100
Message-Id: <20250116-ad4111_openwire-v3-0-ea9ebf29bd1d@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFkfiWcC/3WP3UoDMRBGX2XJtSNJatgfRISCD+CtSJkkExtwd
 9skrlvKvrvZaC+qeDV8M8w5M2cWKXiKrKvOLNDkox+HHDY3FTN7HN4IvM2ZSS7vhBAK0K51Nx5
 o+PSBgJSypLGRbe1Y3joEcn4uxBf2/LRlr9/NQMePTE8/k55ixELvqvtr+Lwz+O51wJRvgUmAA
 OUaya3TyjT8UeNpHdOtGfuHVakxEuTQ+9RVA80JLsAi3/uYxnAqL06i2P/9ptisbms0jXZSXds
 KbpIXhOKCt38REjjwTS2NtJa4oV+IZVm+ALd6FHd2AQAA
X-Change-ID: 20241115-ad4111_openwire-e55deba8297f
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Guillaume Ranquet <granquet@baylibre.com>
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
IIO_EV_TYPE_FAULT and added a direction called IIO_EV_DIR_OPENWIRE to
signal the specific fault.

The fault is level triggered (ie: the event will be sent as long as the
fault persists).
There's no event to signal that the fault has been "fixed", an absence
of FAULT event means that the open wire condition is not detected.

Thx,
Guillaume.

Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
---
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

 drivers/iio/adc/ad7173.c         | 161 +++++++++++++++++++++++++++++++++++++++
 drivers/iio/industrialio-event.c |   2 +
 include/uapi/linux/iio/types.h   |   2 +
 tools/iio/iio_event_monitor.c    |   4 +
 4 files changed, 169 insertions(+)
---
base-commit: c849f534b9ea4688304f80f4571af75931dda7c1
change-id: 20241115-ad4111_openwire-e55deba8297f
prerequisite-message-id: <20241115-ad411x_calibration-v1-1-5f820dfb5c80@baylibre.com>
prerequisite-patch-id: 26241903b8fee8c4243e73d11fb2872cd9f52a15

Best regards,
-- 
Guillaume Ranquet <granquet@baylibre.com>


