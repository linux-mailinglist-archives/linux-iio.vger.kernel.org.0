Return-Path: <linux-iio+bounces-19678-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD4BABC095
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 16:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 630E116C078
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 14:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D9828314A;
	Mon, 19 May 2025 14:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jKmPIhIC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B3427A108;
	Mon, 19 May 2025 14:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747664771; cv=none; b=ceO8dFZKgHn73ZWWoZN/tWLHQ2SfI5zc9ouu1aEdYaC9C9mWTXO6ndwVzZXVVXdDRvOQ5hlLDQeMCggLSSPINUsdfnA/S3IpOkIrpFSKNvdNuO0p0O76IHLS+mwnKa8/tnKUM5r11qGJLyYWax0wDIcjliiJVMeO+VpdVr5mmWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747664771; c=relaxed/simple;
	bh=GwmD4nnJ/4YRZUg/clGh94EIdy399i+4EYIaYGZb7uE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YuJx8HqlPNfI9oHLjOHqzur/OXv1scLwryITjG0HU0H1YkpWxy6UiuYaA1AiaC9OteFW4KQlhIcgeqy/PIE/eF1LqPXOUJ3Yw5ixLJbaP1pt9AzwVfoh5kNq2yIWCmo4PSWK/INyuX7zyRq4B/QEEAHDehNif0XwN/WYcKn+yyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jKmPIhIC; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7426c44e014so4636835b3a.3;
        Mon, 19 May 2025 07:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747664769; x=1748269569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fepv5IGy9/iFE+uOGY8zxhCSixa/u5D0eTSI9lhQaO4=;
        b=jKmPIhICKN1q3Zf41JXfXpulcwrBZdZpW8Cvn1CiAfqROxfb9S0JgeVH5gJKG9ZkxM
         VVZxk0WaqKvMUF/uwk5al90LYWa4arNa3MTtowssPg1/vpDDe84oih/fscnxgsQHXbTf
         GbMsmZp47FZI7rbCJU18FGiwQ5kQQgW6bSS9OXBpw18vyIM63PxijPnEaeSOE7bDJTY4
         ifC39zEi3YMy80e2cW/fVSNWLBQSpsNzpa/Evpq9K4eBX9z9q7/X6kAWO5dT668C2t+5
         p9HHvyH/ShK8C6tShVAgXyUaNoQ1wM8won0ZEUnoFmhsCDyRpHHV/bKwXyNyz7xBieTA
         M/Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747664769; x=1748269569;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fepv5IGy9/iFE+uOGY8zxhCSixa/u5D0eTSI9lhQaO4=;
        b=EOwLaO7KT9eiBSxQR3V5XyJOD7aBYAaZUX2KHvnLwDPJzIvNc/7IM8U6qhL9tP0LTl
         HhJApshCZrk9/F7W1C5Aj4wUkIYqMr0vDdI3CkFu30hxFSEm1Wchujt9jnDDzXAT2gKQ
         y3cCTqN9gsqNiV5zxpFxRVLTBkbyNeibfxZApcz4N8t42LY9dcldGZ+7baoq7F7GOO4H
         NnsGADqeayhxf8/nVX3GIE5jkauRb0PsnHcw9tY/UTMdSofH+Z3fvZwEZiB8zvqj3Hy4
         c2YHoZ9nBvXOhjuJ6g2etajevJTBLtT3BS/WILbnhSr7qdsEJiTwI2PfT1Yy5ggApCJo
         MtZA==
X-Forwarded-Encrypted: i=1; AJvYcCUA1IZRDqumMm+ipZM4TSHia77uaYpY468M+gm3KeT3Bdo1STrmU7GOZg+MNryX3P3APKdKeITquDg=@vger.kernel.org, AJvYcCWSjz2y36xjuyj8RMxJAvCSU5oO466+22mFHDiwQBfjGg3lUUfYn7aczofPOM1sbZ7AYO2R6+yrOK8dECyY@vger.kernel.org
X-Gm-Message-State: AOJu0YxBIJxzCqOysE7/n2JD9m/4syHceIwnMP0xsGvp2o5QKTCOHOlF
	5HSvGYkMWHWdiYw/bzz35hW4LGyfW5SFPfqqkhTY4khWJisbvqbOP/kM2SEF4Q==
X-Gm-Gg: ASbGncuYRtWccpo8bkqDvGt5ULigHhg7/v/rKZUFdPByB1Nu4poqR0WEUaKNpAeHz+t
	zvgO+DAR8H5agqf+PWnPiRqm6n4qCKB5h+uU7c6FFwtiISwGmjSbngYiyQ+b6AaMuoytLPo9qEe
	DjG1/UrUMWV7tn4iGfR8gPTk4nV2v/Vgz6PHhU5J8LGNNYaPjY9upL7L8EQ1K1XHcHuEayDQfsM
	nHBaOdI/+DPx/TNZhSrgzkODflEGbxGrgTDPiqsIgIJYX06ArqwajAvG0OGe5JlmwIQ5NsmxhUJ
	MQBAEebI8NO+UZCWKQMCxMUm8Bc8Xr0flNDiQJr5rXyhyox7F4roYEPFDQ==
X-Google-Smtp-Source: AGHT+IGKbAb5p2EgNx/6VsB0S+WNE+aXplzMQ/uyYLudG6BwDonNegqkk2f+CXH/21P4T5wA7OXsrg==
X-Received: by 2002:a05:6a00:3985:b0:742:a334:466a with SMTP id d2e1a72fcca58-742a97eb677mr18209622b3a.12.1747664769409;
        Mon, 19 May 2025 07:26:09 -0700 (PDT)
Received: from gye-ThinkPad-T590.. ([39.120.225.141])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a96e211csm6465303b3a.16.2025.05.19.07.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 07:26:08 -0700 (PDT)
From: Gyeyoung Baek <gye976@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: Gyeyoung Baek <gye976@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC 0/9] iio: Introduce new timestamp grabbing APIs
Date: Mon, 19 May 2025 23:25:52 +0900
Message-ID: <20250519-timestamp-v1-0-fcb4f6c2721c@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20250518-timestamp-a899e78e07e3
Content-Transfer-Encoding: 8bit

Support automatic timestamp grabbing by passing `true` to the `timestamp_enabled` parameter of `iio_triggered_buffer_setup_new()`.
So consumer drivers don't need to set `iio_pollfunc_store_time()` as either the tophalf or bottomhalf manually.

For this, triggers must indicate whether they will call `poll()`, `poll_nested()`, or both before
calling `iio_trigger_register()`. This is necessary because the consumer's handler does not know
in advance which trigger will be attached.

Once `iio_trigger_attach_poll_func()` is called, a timestamp is grabbed in either the
tophalf or bottomhalf based on the trigger's type (POLL or POLL_NESTED). If the trigger
supports both (e.g., at91-sama5d2-adc.c), it is treated as POLL_NESTED since the consumer's
tophalf is not invoked in poll_nested(), but the bottomhalf always is.

If the attached trigger supports timestamp grabbing itself, the consumer does not need to handle it.
Instead, the consumer's `poll_func` pointer is passed to the trigger, which can then store the
timestamp directly into consumer. Trigger drivers can pass timestamp values to consumers in a consistent
interface using the new API `iio_trigger_store_time()`.

Tested on qemu, with dummy and trig-sysfs drivers tweaked for testing.

Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
---
Gyeyoung Baek (9):
      iio: buffer: Fix checkpatch.pl warning
      iio: consumer: Define timestamp-related structures and constants
      iio: consumer: Add new APIs of triggered_buffer_setup() family
      iio: consumer: Add new API iio_poll_func_register()
      iio: consumer: Add new API iio_pollfunc_get_timestamp()
      iio: trigger: Define timetamp-related structures and constants
      iio: trigger: Add new API iio_trigger_attach_timestamp()
      iio: trigger: Add new API iio_trigger_store_time()
      iio: rpr0521: Use new timestamp-related APIs

 drivers/iio/buffer/industrialio-triggered-buffer.c |  84 ++++++++++++-
 drivers/iio/industrialio-trigger.c                 | 135 ++++++++++++++++++++-
 drivers/iio/light/rpr0521.c                        |  22 +---
 include/linux/iio/trigger.h                        |  16 ++-
 include/linux/iio/trigger_consumer.h               |  23 ++++
 include/linux/iio/triggered_buffer.h               |  25 ++++
 6 files changed, 283 insertions(+), 22 deletions(-)
---
base-commit: 43a9eee06bf8a8535d8709b29379bec8cafcab56
change-id: 20250518-timestamp-a899e78e07e3

Best regards,
-- 
Gyeyoung Baek <gye976@gmail.com>

