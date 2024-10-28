Return-Path: <linux-iio+bounces-11447-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2309B2C6B
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 11:12:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C9431C21CFD
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 10:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A321D222B;
	Mon, 28 Oct 2024 10:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Edzkb2N5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCF318B46E
	for <linux-iio@vger.kernel.org>; Mon, 28 Oct 2024 10:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730110347; cv=none; b=H/d7iBGu2ZpbPYj5N0XX2u8WypwIv8X6bBScyBKm9EcD+XwZEYk57vHJdhk4Bknu3Z1NuOpb3nv8fBWoQHv7D1+QJqq8Dtfe9oSvfmTQAqqTssjFMOMjaRhaVcKrf/AnuXX4gbbHJAykM+OXZGhklFKKe6MmQwvBk1qg5uVIhbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730110347; c=relaxed/simple;
	bh=G3w2AWS1sO2hIf0BXswma2XjfTe1ek5as8WEGaPafrM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=O6386lev4XU/uDXxT4R4Igo+ox+AyjDDKfcR+6XenEZ5/JaAIDFl7u7IT2lJ93RrLc1QzFmD9SW5wHGD725oOvGLmNIl08IF3e7wiMfM7O8Rggxtcr6Zgq/oxEODyZWl+U2IADQaO18a2Dn9DwjBpY1YiP0NrTfWUSHCT3Se34I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Edzkb2N5; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7b14554468fso316337885a.1
        for <linux-iio@vger.kernel.org>; Mon, 28 Oct 2024 03:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730110344; x=1730715144; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oiZZP8a/VVPUMg6rqixs38rRyTMltTho6huxqslh1r8=;
        b=Edzkb2N5UqemYRwYhSI2QxA7bKLVuNNY5IYOG3PG5JKeHARcNJPi8hnGhqSkAA9c/i
         u1ACfhDglbH/QmqP3Lnsq2FemVJ4oaQX/nSqLZlhBJxFRqmEQVzF/ogbSj8RsYa+Owsv
         Kas49vGIZLAteqo+qi57E/H53vQSNxrJgVy/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730110344; x=1730715144;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oiZZP8a/VVPUMg6rqixs38rRyTMltTho6huxqslh1r8=;
        b=Pj1hziKRDagP9ouUb2XkSzAuM0QIXkKmu/7g6PvlP2aFJ0soKqtwJyRVWKAWIbwHmM
         YGXRccGCcazrAGAz41N0xVsKSWLl6pRoD75m3B0Elw3S9SWlZ12jyfMl11US+RvDg1Ik
         ICJAaSSQaONxp3uqW7TrolMVOCQB+x5tuecNH8tiyDb7qqg773TNz6OnDpSgAjAUjvKu
         xHkISYidRKUsvW4LUQxzWsGh9aU1ELuXz9XSSpSCAwiAZK2UaEPuvvdO/hWjsXF7nmTm
         AM/GiGi+L4Ms1mK0Iq8/QtThWDX2ELD+SOD5wL7LLUQN1ta9B95rYCM/UR/k9R949gIj
         iv7w==
X-Forwarded-Encrypted: i=1; AJvYcCWjIhKC85EW8pDNJTAsqys7Q78Hj3o7Lnz7tmQzRgvtVinp1GLInvnPMprboO/n3LrHdldSLkxU44A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOxqINpXcbGFf/jmfG2kKE3HbhNpSTmA58dd8xSq9KLNqt3GB2
	CqFzv4GlEP3ZHZOLUAvWrd7LBJQRlwvTNvcOUAPkFg5Kv339+u0JbkYZOcZ07Q==
X-Google-Smtp-Source: AGHT+IHCZNylv6nLjfkO/ktra4n6JfoH26XKs2q4uwaI7CD5MA4OdYifu82wP1TO9Q9/suHNb6Q5ag==
X-Received: by 2002:a05:620a:468f:b0:7ac:9b5e:baf3 with SMTP id af79cd13be357-7b193ef2c9amr1311016885a.26.1730110344518;
        Mon, 28 Oct 2024 03:12:24 -0700 (PDT)
Received: from denia.c.googlers.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b18d279126sm305483385a.9.2024.10.28.03.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 03:12:23 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v2 0/5] iio: hid-sensors-prox: Add support for more
 channels
Date: Mon, 28 Oct 2024 10:12:20 +0000
Message-Id: <20241028-hpd-v2-0-18f6e79154d7@chromium.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIVjH2cC/zWMQQ7CIBBFr9LMWgxMMRJX3sN0UWEos2hpoDaah
 ruLJC7fz3/vgEyJKcOtOyDRzpnjUgFPHdgwLhMJdpUBJWolsRdhdYIcPfurV95bDfW5JvL8bpX
 HUDlw3mL6tOiufuvf183flZACR4UXY7BmzN2GFGd+zeeYJhhKKV9MDvwVmQAAAA==
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 Lars-Peter Clausen <lars@metafoo.de>
Cc: Harvey Yang <chenghaoyang@google.com>, linux-input@vger.kernel.org, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

EgisVision 620 provides two additional channels:
- proximity
- attention

Add support for them.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Changes in v2 (Thanks Jonathan):
- Create new attention channel type.
- Improve documentation for HID usages.
- Link to v1: https://lore.kernel.org/r/20241024-hpd-v1-0-2a125882f1f8@chromium.org

---
Ricardo Ribalda (5):
      iio: hid-sensors: Add proximity and attention IDs
      iio: hid-sensors-prox: Factor-in hid_sensor_push_data
      iio: Add channel type for attention
      iio: hid-sensors-prox: Make proximity channel indexed
      iio: hid-sensor-prox: Add support for more channels

 Documentation/ABI/testing/sysfs-bus-iio |   7 ++
 drivers/iio/industrialio-core.c         |   1 +
 drivers/iio/light/hid-sensor-prox.c     | 186 +++++++++++++++++---------------
 include/linux/hid-sensor-ids.h          |   2 +
 include/uapi/linux/iio/types.h          |   1 +
 tools/iio/iio_event_monitor.c           |   2 +
 6 files changed, 112 insertions(+), 87 deletions(-)
---
base-commit: c2ee9f594da826bea183ed14f2cc029c719bf4da
change-id: 20241023-hpd-edeb37f1ffc4

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


