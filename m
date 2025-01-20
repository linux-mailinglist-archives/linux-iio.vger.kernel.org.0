Return-Path: <linux-iio+bounces-14501-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A58A16E38
	for <lists+linux-iio@lfdr.de>; Mon, 20 Jan 2025 15:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 444571889AB8
	for <lists+linux-iio@lfdr.de>; Mon, 20 Jan 2025 14:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69EAF1E282D;
	Mon, 20 Jan 2025 14:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FLqoRtuL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FF033E7
	for <linux-iio@vger.kernel.org>; Mon, 20 Jan 2025 14:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737382538; cv=none; b=OcOJhnnUiTp/iJW5Avoa70lMnX1c3zIBAP9XtNFp7NniOzh2kt1GW0LoetIwIYyiGe8QRz4QjZEieHp7VKtw+duXgsOC+sA2WEL3WCE/yhDX6IZcPOiswi45UjCEpjLllWbFoC97xR9/eZE1JwMdjSSBoNExw+BxwejFvCMoXGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737382538; c=relaxed/simple;
	bh=Zsp71q6Rc0/Nhkg1Zve+/HiaQ5Vh0kbI2OZpw7dmjdg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bzPbwULYMyqYmldIXdwxZC3rnwpfh030PgInViURp521mopGlnfk9Ss1yZChPnoqYaWrqfVbbo8CUdR8kZ4RJLV9VJeJLRiJowkPempXulwN7W+T8AUEvLW18EZL9NVxXzrtDzSz084UBb76mT1Nl1RKr4ZLWLqUpCU3TF3I9Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=FLqoRtuL; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43634b570c1so32382255e9.0
        for <linux-iio@vger.kernel.org>; Mon, 20 Jan 2025 06:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1737382534; x=1737987334; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D5slyFhFFg4eXgNrFHDN5dqCXylxctmjvDX+b8DDkEU=;
        b=FLqoRtuLMSMA33g6QhKTKdQlqALcN5kAjA4vM65Y1WnXWNBEUAmCWlfzoTxc7Ykstg
         Ew9E8zLAq+JrLixGp82Ms+EThaKpMiSedVVhrxES5HyPkXQB3FMlMrh/wzJy+RbMemtE
         TjMCIZLgmV0B/otWPuekGzJL9r+EGKGEwDjUE9RVjSyPvGR+x9NHA1JeHzQGNpeSVg6m
         Dy1Tuc/7WL294HZExQvpXfPJaf59TuYWWzqcsL5z6TLbgDbS7SbKmvlve06wbLm88vHM
         T79++8S0bQO3gTYxrYbTct4hbSNz3ig60suDs59FabjsGfevQoJ+JqLpZmgtw2QfXxx/
         0M6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737382534; x=1737987334;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D5slyFhFFg4eXgNrFHDN5dqCXylxctmjvDX+b8DDkEU=;
        b=qfaoT4BzJQvTqXASo88wYsKJGDPai0Doi3QjHI7E9pWQdniH9lb7TBDthsvg0LrzVN
         LFeOQOjTS+ngxhCirskIO+eVgAA6GdR+Qzcb6qEz/qK+Fy2WZBep27jwWk86FX+MaDSh
         lQalQh8BucAojbibIjJA3GXpmNBeHn2jlAHBdXWJzUR1hKFCo14FrZKYQ/LRKwAGxrlL
         IHUcmvn6Wq0V30LLycHMUJtQ41fYWYRBdrL7BL4k/1b81gF5yDqXKZeyZPcihHslnR21
         HR6GqNkGr7cGuri55HGIgVerBKcZgkfLg6GFZx/pvF0WdOkoJc5mmDSY6jpYzNhZSMOj
         CVFQ==
X-Gm-Message-State: AOJu0YzE9TOZkNVUJZyR7hj1OyDLL07y7tCtH2mzUmyWB07zCghU+kfz
	xx+Ioa3Wdypshbf3PbDrvW+UaMLCgwxz+p7DRDrCOwaK0rqcCYvIgNsufbyzQlPiILN7UAq0PbN
	c
X-Gm-Gg: ASbGnctZDsddMKfoySpLAAK2kqNg8YvxksIJyKg52uJHgRU+WPDvDB40gQT2PCOEKqX
	3aCjl18u55co5Yj0tiLaisXMMIiAIaTMLQlAZJtV/4kQVME+8n5+uRPMdP1AmWRe8F4vahNuGuI
	80c/F8HdcPRg9YXGrZlpFxtYE03MKuKGFAZR4/K8Cb9A7ZJBvxBMu93HCbBV1GGxxd6Uw4feGMe
	zIifFOvuBhrSQxi9ROZyIEfgEiKvfyuGzUGoSjvAUmk93NXBhNzKhuctoZd+HaVfnUjwCGi2gb8
	3cWRinbJzY6pAhqo773v4riuF4FI6+yArlpCEB3N
X-Google-Smtp-Source: AGHT+IHFUycdZuUdNNL2CNUC3XjcWOrzCZ8rDoxNz7si90lttH6MVmvHJw+OO2r/Obhpa15FEiwyrQ==
X-Received: by 2002:a05:600c:1f86:b0:436:aaf:7eb9 with SMTP id 5b1f17b1804b1-43891439d5fmr111420395e9.20.1737382533794;
        Mon, 20 Jan 2025 06:15:33 -0800 (PST)
Received: from [127.0.0.1] (alille-653-1-300-114.w90-1.abo.wanadoo.fr. [90.1.180.114])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438904621cdsm141233345e9.27.2025.01.20.06.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 06:15:32 -0800 (PST)
From: Guillaume Ranquet <granquet@baylibre.com>
Subject: [PATCH v4 0/2] iio: adc: ad7173: add ad4111 openwire detection
 support
Date: Mon, 20 Jan 2025 15:10:05 +0100
Message-Id: <20250120-ad4111_openwire-v4-0-e647835dbe62@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD5ZjmcC/3XP7WrDIBQG4FsJ/t4ZauoSwxi9jzGKH8dVWJJOb
 ZZScu8zlsK6br/kVXzec84kYvAYSVedScDJRz8OOWweKmL2anhH8DZnwinfMMYEKLueu/GAw5c
 PCCiERa1aLhtH8q9DQOfnIr6+XXLAz2OG0+WS9BijKnBXPd+6886oD6+DSnkMmBgwEK7l1DotT
 Eu3Wp3WZ3w0Y/+ytmkVEXLofeqqAecEV5Cs5Xsf0xhOZbuJlfZ/FyltVstGmVY7Lm7bCjfxKyE
 oo/Ke4ECB1g033FqkBv8g6h8Ee7on6kygkphHkNoy+4tYluUbvM4raLQBAAA=
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

 drivers/iio/adc/ad7173.c         | 166 +++++++++++++++++++++++++++++++++++++++
 drivers/iio/industrialio-event.c |   2 +
 include/uapi/linux/iio/types.h   |   2 +
 tools/iio/iio_event_monitor.c    |   4 +
 4 files changed, 174 insertions(+)
---
base-commit: c849f534b9ea4688304f80f4571af75931dda7c1
change-id: 20241115-ad4111_openwire-e55deba8297f
prerequisite-message-id: <20241115-ad411x_calibration-v1-1-5f820dfb5c80@baylibre.com>
prerequisite-patch-id: 26241903b8fee8c4243e73d11fb2872cd9f52a15

Best regards,
-- 
Guillaume Ranquet <granquet@baylibre.com>


